#!/bin/bash


echo -e "\033[0;32m==>\033[1;37m Installing Stackery CLI\033[0;0m"
echo -e "\033[0;32m==>\033[1;37m Detecting local OS\033[0;0m"

# Check if we're on OSX or linux
UNAME="$(uname -s)"
case "${UNAME}" in
  Linux*)
    os=linux
    displayOS=Linux
    ;;
  Darwin*)
    os=osx
    displayOS="Mac OS X"
    ;;
  *)
    echo -e "\033[0;31m==>\033[1;37m Can't automatically install on OS=${UNAME}.\033[0;0m"
    echo -e "\033[0;31m==>\033[1;37m Please manually install the stackery CLI.\033[0;0m"
    exit 1
esac

echo -e "\033[0;32m    $displayOS detected\033[0;0m"

DESTINATION=/usr/local/bin/stackery
if [[ -f $DESTINATION && -t 0 ]]; then
  echo -e "\033[0;33m==>\033[1;37m Found existing stackery cli at $DESTINATION\033[0;0m"
  read -p "    Overwrite $DESTINATION? (y/n) " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\033[1;33m    Aborting\033[0;0m"
    exit 1
  fi
fi

url="https://ga.cli.stackery.io/$os.zip"
echo -e "\033[0;32m==>\033[1;37m Downloading $url\033[0;0m"
curl -Ls https://ga.cli.stackery.io/$os.zip > /tmp/stackery.zip
echo -e "\033[0;32m==>\033[1;37m Installing cli at /usr/local/bin/stackery\033[0;0m"
unzip -oqq /tmp/stackery.zip -d /usr/local/bin >/dev/null
echo -e "\033[0;32m==>\033[1;37m Success!\033[0;0m"
