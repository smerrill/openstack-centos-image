#!/bin/sh

#set -e
if [ $# -lt 1 ]
then
  printf 'Usage: %s vm_name [arg1 [arg2 [...]]]\n' "$0"
  printf 'Example:\n'
  printf '%s' "$0"
  exit 1
fi

set -x

NAME="$1"; shift
#DISK=/home/smerrill/openshift/"$NAME"
CMDLINE='ks=file:/kickstart.ks'

for ARG
do
  CMDLINE="$CMDLINE $ARG"
done

#qemu-img create "$DISK" 30G -f raw && mkfs.ext4 -F "$DISK"

#virt-install --name="$NAME" --ram=16384 --vcpus=8 --hvm --disk pool=default,size=20 \
virt-install --name="$NAME" --ram=8192 --vcpus=4 --hvm --disk pool=default,size=20 \
  --location http://mirror.rit.edu/centos/6/os/x86_64/ \
  -x "$CMDLINE text console=ttyS0" --nographics --noreboot \
  --initrd-inject=/home/smerrill/Projects/centos-openstack-image/kickstart.ks \
  --connect qemu:///system --network bridge=virbr0 -d --wait=-1
