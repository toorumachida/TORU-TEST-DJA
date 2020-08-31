#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
#!/bin/bash
trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
#Quick Hack: used to convert e.g. "C:\Program Files\Docker Toolbox" to "/c/Program Files/Docker Toolbox"
win_to_unix_path(){  	wd="$(pwd)"; 	cd "$1"; 		the_path="$(pwd)"; 	cd "$wd"; 	echo $the_path; }
# This is needed  to ensure that binaries provided
# by Docker Toolbox over-ride binaries provided by
# Docker for Windows when launching using the Quickstart.
export PATH="$(win_to_unix_path "${DOCKER_TOOLBOX_INSTALL_PATH}"):$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE="${DOCKER_TOOLBOX_INSTALL_PATH}\docker-machine.exe"
STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then   VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"; else   VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"; fi
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'
#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then   unset ALL_PROXY; fi
if  [[ $all_proxy != socks* ]]; then   unset all_proxy; fi
if [ ! -f "${DOCKER_MACHINE}" ]; then   echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
if [ ! -f "${VBOXMANAGE}" ]; then   echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?
set -e
STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then   "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :;   rm -rf ~/.docker/machine/machines/"${VM}"   if [ "${HTTP_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY";   fi;   if [ "${HTTPS_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY";   fi;   if [ "${NO_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY";   fi;   "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"; fi
STEP="Checking status on $VM"
VM_STATUS="$( set +e ; "${DOCKER_MACHINE}" status "${VM}" )"
if [ "${VM_STATUS}" != "Running" ]; then   "${DOCKER_MACHINE}" start "${VM}";   yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"; fi
STEP="Setting env"
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}" | sed -e "s/export/SETX/g" | sed -e "s/=/ /g")" &> /dev/null #for persistent Environment Variables, available in next sessions
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}")" #for transient Environment Variables, available in current session
STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF

echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$("${DOCKER_MACHINE}" ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
echo 
#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
#!/bin/bash
trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
#Quick Hack: used to convert e.g. "C:\Program Files\Docker Toolbox" to "/c/Program Files/Docker Toolbox"
win_to_unix_path(){  	wd="$(pwd)"; 	cd "$1"; 		the_path="$(pwd)"; 	cd "$wd"; 	echo $the_path; }
# This is needed  to ensure that binaries provided
# by Docker Toolbox over-ride binaries provided by
# Docker for Windows when launching using the Quickstart.
export PATH="$(win_to_unix_path "${DOCKER_TOOLBOX_INSTALL_PATH}"):$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE="${DOCKER_TOOLBOX_INSTALL_PATH}\docker-machine.exe"
STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then   VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"; else   VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"; fi
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'
#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then   unset ALL_PROXY; fi
if  [[ $all_proxy != socks* ]]; then   unset all_proxy; fi
if [ ! -f "${DOCKER_MACHINE}" ]; then   echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
if [ ! -f "${VBOXMANAGE}" ]; then   echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?
set -e
STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then   "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :;   rm -rf ~/.docker/machine/machines/"${VM}"   if [ "${HTTP_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY";   fi;   if [ "${HTTPS_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY";   fi;   if [ "${NO_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY";   fi;   "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"; fi
STEP="Checking status on $VM"
VM_STATUS="$( set +e ; "${DOCKER_MACHINE}" status "${VM}" )"
if [ "${VM_STATUS}" != "Running" ]; then   "${DOCKER_MACHINE}" start "${VM}";   yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"; fi
STEP="Setting env"
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}" | sed -e "s/export/SETX/g" | sed -e "s/=/ /g")" &> /dev/null #for persistent Environment Variables, available in next sessions
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}")" #for transient Environment Variables, available in current session
STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF

echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$("${DOCKER_MACHINE}" ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
echo 
#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
#!/bin/bash
trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
#Quick Hack: used to convert e.g. "C:\Program Files\Docker Toolbox" to "/c/Program Files/Docker Toolbox"
win_to_unix_path(){  	wd="$(pwd)"; 	cd "$1"; 		the_path="$(pwd)"; 	cd "$wd"; 	echo $the_path; }
# This is needed  to ensure that binaries provided
# by Docker Toolbox over-ride binaries provided by
# Docker for Windows when launching using the Quickstart.
export PATH="$(win_to_unix_path "${DOCKER_TOOLBOX_INSTALL_PATH}"):$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE="${DOCKER_TOOLBOX_INSTALL_PATH}\docker-machine.exe"
STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then   VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"; else   VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"; fi
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'
#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then   unset ALL_PROXY; fi
if  [[ $all_proxy != socks* ]]; then   unset all_proxy; fi
if [ ! -f "${DOCKER_MACHINE}" ]; then   echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
if [ ! -f "${VBOXMANAGE}" ]; then   echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?
set -e
STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then   "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :;   rm -rf ~/.docker/machine/machines/"${VM}"   if [ "${HTTP_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY";   fi;   if [ "${HTTPS_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY";   fi;   if [ "${NO_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY";   fi;   "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"; fi
STEP="Checking status on $VM"
VM_STATUS="$( set +e ; "${DOCKER_MACHINE}" status "${VM}" )"
if [ "${VM_STATUS}" != "Running" ]; then   "${DOCKER_MACHINE}" start "${VM}";   yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"; fi
STEP="Setting env"
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}" | sed -e "s/export/SETX/g" | sed -e "s/=/ /g")" &> /dev/null #for persistent Environment Variables, available in next sessions
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}")" #for transient Environment Variables, available in current session
STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF

echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$("${DOCKER_MACHINE}" ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
echo 
#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
#!/bin/bash
trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
#Quick Hack: used to convert e.g. "C:\Program Files\Docker Toolbox" to "/c/Program Files/Docker Toolbox"
win_to_unix_path(){  	wd="$(pwd)"; 	cd "$1"; 		the_path="$(pwd)"; 	cd "$wd"; 	echo $the_path; }
# This is needed  to ensure that binaries provided
# by Docker Toolbox over-ride binaries provided by
# Docker for Windows when launching using the Quickstart.
export PATH="$(win_to_unix_path "${DOCKER_TOOLBOX_INSTALL_PATH}"):$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE="${DOCKER_TOOLBOX_INSTALL_PATH}\docker-machine.exe"
STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then   VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"; else   VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"; fi
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'
#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then   unset ALL_PROXY; fi
if  [[ $all_proxy != socks* ]]; then   unset all_proxy; fi
if [ ! -f "${DOCKER_MACHINE}" ]; then   echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
if [ ! -f "${VBOXMANAGE}" ]; then   echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?
set -e
STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then   "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :;   rm -rf ~/.docker/machine/machines/"${VM}"   if [ "${HTTP_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY";   fi;   if [ "${HTTPS_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY";   fi;   if [ "${NO_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY";   fi;   "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"; fi
STEP="Checking status on $VM"
VM_STATUS="$( set +e ; "${DOCKER_MACHINE}" status "${VM}" )"
if [ "${VM_STATUS}" != "Running" ]; then   "${DOCKER_MACHINE}" start "${VM}";   yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"; fi
STEP="Setting env"
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}" | sed -e "s/export/SETX/g" | sed -e "s/=/ /g")" &> /dev/null #for persistent Environment Variables, available in next sessions
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}")" #for transient Environment Variables, available in current session
STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF

echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$("${DOCKER_MACHINE}" ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
echo 
#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
#!/bin/bash
trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
#Quick Hack: used to convert e.g. "C:\Program Files\Docker Toolbox" to "/c/Program Files/Docker Toolbox"
win_to_unix_path(){  	wd="$(pwd)"; 	cd "$1"; 		the_path="$(pwd)"; 	cd "$wd"; 	echo $the_path; }
# This is needed  to ensure that binaries provided
# by Docker Toolbox over-ride binaries provided by
# Docker for Windows when launching using the Quickstart.
export PATH="$(win_to_unix_path "${DOCKER_TOOLBOX_INSTALL_PATH}"):$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE="${DOCKER_TOOLBOX_INSTALL_PATH}\docker-machine.exe"
STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then   VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"; else   VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"; fi
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'
#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then   unset ALL_PROXY; fi
if  [[ $all_proxy != socks* ]]; then   unset all_proxy; fi
if [ ! -f "${DOCKER_MACHINE}" ]; then   echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
if [ ! -f "${VBOXMANAGE}" ]; then   echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?
set -e
STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then   "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :;   rm -rf ~/.docker/machine/machines/"${VM}"   if [ "${HTTP_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY";   fi;   if [ "${HTTPS_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY";   fi;   if [ "${NO_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY";   fi;   "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"; fi
STEP="Checking status on $VM"
VM_STATUS="$( set +e ; "${DOCKER_MACHINE}" status "${VM}" )"
if [ "${VM_STATUS}" != "Running" ]; then   "${DOCKER_MACHINE}" start "${VM}";   yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"; fi
STEP="Setting env"
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}" | sed -e "s/export/SETX/g" | sed -e "s/=/ /g")" &> /dev/null #for persistent Environment Variables, available in next sessions
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}")" #for transient Environment Variables, available in current session
STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF

echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$("${DOCKER_MACHINE}" ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
echo 
#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
#!/bin/bash
trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
#Quick Hack: used to convert e.g. "C:\Program Files\Docker Toolbox" to "/c/Program Files/Docker Toolbox"
win_to_unix_path(){  	wd="$(pwd)"; 	cd "$1"; 		the_path="$(pwd)"; 	cd "$wd"; 	echo $the_path; }
# This is needed  to ensure that binaries provided
# by Docker Toolbox over-ride binaries provided by
# Docker for Windows when launching using the Quickstart.
export PATH="$(win_to_unix_path "${DOCKER_TOOLBOX_INSTALL_PATH}"):$PATH"
VM=${DOCKER_MACHINE_NAME-default}
DOCKER_MACHINE="${DOCKER_TOOLBOX_INSTALL_PATH}\docker-machine.exe"
STEP="Looking for vboxmanage.exe"
if [ ! -z "$VBOX_MSI_INSTALL_PATH" ]; then   VBOXMANAGE="${VBOX_MSI_INSTALL_PATH}VBoxManage.exe"; else   VBOXMANAGE="${VBOX_INSTALL_PATH}VBoxManage.exe"; fi
BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'
#clear all_proxy if not socks address
if  [[ $ALL_PROXY != socks* ]]; then   unset ALL_PROXY; fi
if  [[ $all_proxy != socks* ]]; then   unset all_proxy; fi
if [ ! -f "${DOCKER_MACHINE}" ]; then   echo "Docker Machine is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
if [ ! -f "${VBOXMANAGE}" ]; then   echo "VirtualBox is not installed. Please re-run the Toolbox Installer and try again.";   exit 1; fi
"${VBOXMANAGE}" list vms | grep \""${VM}"\" &> /dev/null
VM_EXISTS_CODE=$?
set -e
STEP="Checking if machine $VM exists"
if [ $VM_EXISTS_CODE -eq 1 ]; then   "${DOCKER_MACHINE}" rm -f "${VM}" &> /dev/null || :;   rm -rf ~/.docker/machine/machines/"${VM}"   if [ "${HTTP_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTP_PROXY=$HTTP_PROXY";   fi;   if [ "${HTTPS_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env HTTPS_PROXY=$HTTPS_PROXY";   fi;   if [ "${NO_PROXY}" ]; then     PROXY_ENV="$PROXY_ENV --engine-env NO_PROXY=$NO_PROXY";   fi;   "${DOCKER_MACHINE}" create -d virtualbox $PROXY_ENV "${VM}"; fi
STEP="Checking status on $VM"
VM_STATUS="$( set +e ; "${DOCKER_MACHINE}" status "${VM}" )"
if [ "${VM_STATUS}" != "Running" ]; then   "${DOCKER_MACHINE}" start "${VM}";   yes | "${DOCKER_MACHINE}" regenerate-certs "${VM}"; fi
STEP="Setting env"
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}" | sed -e "s/export/SETX/g" | sed -e "s/=/ /g")" &> /dev/null #for persistent Environment Variables, available in next sessions
eval "$("${DOCKER_MACHINE}" env --shell=bash --no-proxy "${VM}")" #for transient Environment Variables, available in current session
STEP="Finalize"
clear
cat << EOF


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/

EOF

echo -e "${BLUE}docker${NC} is configured to use the ${GREEN}${VM}${NC} machine with IP ${GREEN}$("${DOCKER_MACHINE}" ip ${VM})${NC}"
echo "For help getting started, check out the docs at https://docs.docker.com"
echo
echo 
#cd #Bad: working dir should be whatever directory was invoked from rather than fixed to the Home folder
docker () {   MSYS_NO_PATHCONV=1 docker.exe "$@"; }
export -f docker
if [ $# -eq 0 ]; then   echo "Start interactive shell";   exec "$BASH" --login -i; else   echo "Start shell with command";   exec "$BASH" -c "$*"; fi
docker image
docker images
vi Dockerfile
docker login
exit
mkdir tutorial
cd tutorial
git init
git add myfile.txt
touch myfile.txt
git add myfile.txt
git commit -m "first commit"
git branch issue1
git branch
git checkout issue1
git add myfile.txt
git commit -m "addの説明を追加"
git checkout master
git merge issue1
git branch -d issue1
git branch
git branch issue2
git branch issue3
git checkout issue2
git add myfile.txt
git commit -m "commitの説明を追加"
git checkout issue3
vi myfile.txt
cat myfile.txt
git add myfile.txt
git commit -m "pull　の説明を追加"
git checkout master
git merge issue2
git merge issue3
git reset --hard HEAD~
git checkout issue3
git rebase master
git reset --hard HEAD~
git checkout issue3
git rebase master
mkdir tutorial
cd tutorial
git init 
vi myfile.txt
cat myfile.txt
git add myfile.txt
git commit -m "first commit"
git tag apple
git tag
git log --decorate
git tag -am " サル先生の git" banana
git tag -n
git log
mkdir turorial
cd tutorial
git init
git add myfile.txt
git commit -m "first commit"
git branch issue
git branch
git branch
git checkout
git checkout issue1
git checkout issue3
git branch
git checkout master
git branch
git checkout issue1
git branch issue1
git checkout issue1
git branch
vi myfile.txt
cat myfile.txt
git add mygile.txt
git add myfile.txt
git commit -m "add の説明を追加"
git checkout master
cat myfile.txt
vi myfile.txt
cat myfil.txt
cat myfile.txt
git merge issue1
cat myfile.txt
git merge issue1
git checkout issue1
git checkout issue1
git add myfile.txt
git commit -m "add の説明を追加"
git checkout issue1
git checkout master
git merge issue1
cat myfile.txt
vi myfile.txt
git branch -d issue1
git branch
git branch -d issue1
git branch -D issue1
git branch
git checkout issue2
cat myfile.txt
git merge issue1
git checkout master
git checkout master
git add myfile.txt
git commit myfile.txt
cd
mkdir tuto
cd tuto
git init
vi myfile.txt
cat myfil.tst
cat myfile.txt
git add myfile.txt
git commit -m "first commit"
git branch issue1
git branch
git checkout issue1
vi myfile.txt
cat myfile.txt
git add myfile.txt
git commit -m "add の説明を追加"
git checkout master
cat myfile.txt
git merge issue1
cat myfile.txt
git branch -d issue1
git branch
cat myfile.txt
git branch issue2
git branch issue3
git checkout issue2
git branch
vi myfile.txt
git add myfile.txt
git commit -m "commit の説明を追加"
git checkout issue3
vi myfile.txt
git add myfile.txt
git commit -m "pull の説明を追加"
git checkout master
git merge issue2
git merge issue3
cat myfile.txt
vi myfile.txt
cat myfile.txt
git add myfile.txt
git commit -m "issue3 ブランチをマージ"
git reset --hard HEAD~
git checkout issue3
git rebase master
git reset --hard HEAD~
git checkout issue3
git rebase master
vi myfile.txt
cd tuto
mkdir tutorial
cd tutorial
git init
vi myfile.txt
git add myfile.txt
git commit -m "first commit"
git tag apple
git tag
git log --decorate
git tag -am " サル先生の git " banana
git tag -n
