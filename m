Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbQKFWM3>; Mon, 6 Nov 2000 17:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbQKFWMJ>; Mon, 6 Nov 2000 17:12:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2564 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129599AbQKFWLi>; Mon, 6 Nov 2000 17:11:38 -0500
Date: Mon, 6 Nov 2000 17:11:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Richard Rak <richardr@corel.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.0-test9
In-Reply-To: <3A07255D.24AAAA70@corel.com>
Message-ID: <Pine.LNX.3.95.1001106170453.432A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Richard Rak wrote:

> 	I don't have any problems building initrd images here (using
> RAMDISKs).  Can I take a look at your scripts and see what is going on?
> 

Here is the script to boot off a hard disk.



#!/bin/bash
#
#	This installs the kernel on a system that requires an initial
#	RAM Disk and with an initial SCSI driver.
#

export VER=$1
RAMDISK_DEVICE=/dev/ram0
RAMDISK_MOUNT=/tmp/Ramdisk
DISKSIZE=1500
SYS=/usr/src/linux-${VER}/arch/i386/boot/bzImage
MAP=/usr/src/linux-${VER}/System.map
if [ "$1" = "" ] ;
   then
       echo "Usage:"
       echo "make_ramdisk <version>"
       exit 1
fi
if [ ! -f ${SYS} ] ;
   then
    echo "File not found, ${SYS}"
    exit 1
fi
if [ ! -f ${MAP} ] ;
   then
    echo "File not found, ${MAP}"
    exit 1
fi
if ! depmod -a ${VER} ;
   then
      echo "This won't work!  There are some unresolved symbols."
      exit 1
fi
umount ${RAMDISK_DEVICE} 2>/dev/null
umount ${RAMDISK_MOUNT}  2>/dev/null
mkdir  ${RAMDISK_MOUNT}  2>/dev/null
dd if=/dev/zero of=${RAMDISK_DEVICE} bs=1k count=${DISKSIZE}
mke2fs -q ${RAMDISK_DEVICE} ${DISKSIZE}
mount ${RAMDISK_DEVICE} ${RAMDISK_MOUNT}
rmdir ${RAMDISK_MOUNT}/lost+found 
mkdir ${RAMDISK_MOUNT}/dev
mkdir ${RAMDISK_MOUNT}/etc
mkdir ${RAMDISK_MOUNT}/lib
mkdir ${RAMDISK_MOUNT}/bin
mknod ${RAMDISK_MOUNT}/dev/null   c 1 3
mknod ${RAMDISK_MOUNT}/dev/ram0   b 1 0 
mknod ${RAMDISK_MOUNT}/dev/ram1   b 1 1
mknod ${RAMDISK_MOUNT}/dev/tty0   c 4 0
mknod ${RAMDISK_MOUNT}/dev/tty1   c 4 1
mknod ${RAMDISK_MOUNT}/dev/tty2   c 4 2
mknod ${RAMDISK_MOUNT}/dev/tty3   c 4 3
mknod ${RAMDISK_MOUNT}/dev/tty4   c 4 4
ln -s /dev/tty0 ${RAMDISK_MOUNT}/dev/systty
ln -s /dev/tty0 ${RAMDISK_MOUNT}/dev/console
ln -s /dev/ram1 ${RAMDISK_MOUNT}/dev/ram
ln -s /         ${RAMDISK_MOUNT}/dev/root
cp /bin/ash.static ${RAMDISK_MOUNT}/bin/sh
cp /sbin/insmod.static ${RAMDISK_MOUNT}/bin/insmod
#cp /sbin/modprobe-static ${RAMDISK_MOUNT}/bin/modprobe
cp /lib/modules/${VER}/kernel/drivers/scsi/BusLogic.o ${RAMDISK_MOUNT}/lib
cp /lib/modules/${VER}/kernel/drivers/scsi/scsi_mod.o ${RAMDISK_MOUNT}/lib
cp /lib/modules/${VER}/kernel/drivers/scsi/sd_mod.o   ${RAMDISK_MOUNT}/lib
echo "#!/bin/sh"   >${RAMDISK_MOUNT}/linuxrc
echo "/bin/insmod /lib/scsi_mod.o" >>${RAMDISK_MOUNT}/linuxrc
echo "/bin/insmod /lib/BusLogic.o" >>${RAMDISK_MOUNT}/linuxrc
echo "/bin/insmod /lib/sd_mod.o"   >>${RAMDISK_MOUNT}/linuxrc
chmod +x ${RAMDISK_MOUNT}/linuxrc
df ${RAMDISK_MOUNT}
sync
umount ${RAMDISK_MOUNT}
rmdir  ${RAMDISK_MOUNT} 
dd if=${RAMDISK_DEVICE} bs=1k count=${DISKSIZE} | gzip >/boot/initrd-${VER}
cp ${SYS} /boot/vmlinuz-${VER}
cp ${MAP} /boot/System.map-${VER}
rm -rf /boot/System.map
ln -s /boot/System.map-${VER} /boot/System.map
psupdate
#
echo >/boot/message
echo "    Booting Linux version ${VER}"                  >>/boot/message
echo "    Hit tab key to see alternatives"               >>/boot/message
echo "    This machine will self-destruct in 15 seconds" >>/boot/message
echo >>/boot/message
#
lilo -C - <<EOF
#
#  Lilo boot-configuration script.
#
boot = /dev/sda
message = /boot/message
compact
delay = 15	# optional, for systems that boot very quickly
vga = normal	# force sane state

image = /boot/vmlinuz-${VER}
  root  = current
  label = new 
  initrd = /boot/initrd-${VER}

image = /vmlinuz
 root = current
 label = linux

image = /vmlinuz
  root  = /dev/sdc3 
  label = maint 

image = /vmlinuz
  root  = /dev/sdb1 
  label = maint-su
  append="init=/bin/bash" 

image = /vmlinuz.old
  root = current
  label = linux_old

other = /dev/sda1
  table = /dev/sda
  label = dos
EOF


Here is a script to boot off a floppy.

#!/bin/bash
#
#	This installs the kernel on a system that requires an initial
#	RAM Disk and with an initial SCSI driver.
#

export VER=$1
RAMDISK_DEVICE=/dev/ram0
RAMDISK_MOUNT=/tmp/Ramdisk
RAMDISK_TMP=/mnt
DISKSIZE=1500
SYS=/usr/src/linux-${VER}/arch/i386/boot/bzImage
MAP=/usr/src/linux-${VER}/System.map
if [ "$1" = "" ] ;
   then
       echo "Usage:"
       echo "make_ramdisk <version>"
       exit 1
fi
if [ ! -f ${SYS} ] ;
   then
    echo "File not found, ${SYS}"
    exit 1
fi
if [ ! -f ${MAP} ] ;
   then
    echo "File not found, ${MAP}"
    exit 1
fi
if ! depmod -a ${VER} ;
   then
      echo "This won't work!  There are some unresolved symbols."
      exit 1
fi
mkdir  ${RAMDISK_TMP}    2>/dev/null
umount ${RAMDISK_DEVICE} 2>/dev/null
umount ${RAMDISK_MOUNT}  2>/dev/null
mkdir  ${RAMDISK_MOUNT}  2>/dev/null
dd if=/dev/zero of=${RAMDISK_DEVICE} bs=1k count=${DISKSIZE}
mke2fs -q ${RAMDISK_DEVICE} ${DISKSIZE}
mount -o loop ${RAMDISK_DEVICE} ${RAMDISK_MOUNT}
mke2fs -q /dev/fd0
mount /dev/fd0 ${RAMDISK_TMP}
rmdir ${RAMDISK_MOUNT}/lost+found 
rmdir ${RAMDISK_TMP}/lost+found 
mkdir ${RAMDISK_MOUNT}/dev
mkdir ${RAMDISK_MOUNT}/etc
mkdir ${RAMDISK_MOUNT}/lib
mkdir ${RAMDISK_MOUNT}/bin
mknod ${RAMDISK_MOUNT}/dev/null   c 1 3
mknod ${RAMDISK_MOUNT}/dev/ram0   b 1 0 
mknod ${RAMDISK_MOUNT}/dev/ram1   b 1 1
mknod ${RAMDISK_MOUNT}/dev/tty0   c 4 0
mknod ${RAMDISK_MOUNT}/dev/tty1   c 4 1
mknod ${RAMDISK_MOUNT}/dev/tty2   c 4 2
mknod ${RAMDISK_MOUNT}/dev/tty3   c 4 3
mknod ${RAMDISK_MOUNT}/dev/tty4   c 4 4
ln -s /dev/tty0 ${RAMDISK_MOUNT}/dev/systty
ln -s /dev/tty0 ${RAMDISK_MOUNT}/dev/console
ln -s /dev/ram1 ${RAMDISK_MOUNT}/dev/ram
ln -s /         ${RAMDISK_MOUNT}/dev/root
cp /bin/ash.static ${RAMDISK_MOUNT}/bin/sh
cp /sbin/insmod.static ${RAMDISK_MOUNT}/bin/insmod
#cp /sbin/modprobe-static ${RAMDISK_MOUNT}/bin/modprobe
cp /lib/modules/${VER}/kernel/drivers/scsi/BusLogic.o ${RAMDISK_MOUNT}/lib
cp /lib/modules/${VER}/kernel/drivers/scsi/scsi_mod.o ${RAMDISK_MOUNT}/lib
cp /lib/modules/${VER}/kernel/drivers/scsi/sd_mod.o   ${RAMDISK_MOUNT}/lib
cat >${RAMDISK_MOUNT}/linuxrc <<EOF
#!/bin/sh
/bin/insmod -f /lib/scsi_mod.o
/bin/insmod -f /lib/BusLogic.o
/bin/insmod -f /lib/sd_mod.o
EOF
chmod +x ${RAMDISK_MOUNT}/linuxrc
df ${RAMDISK_MOUNT}
sync
umount ${RAMDISK_MOUNT}
rmdir  ${RAMDISK_MOUNT} 
dd if=${RAMDISK_DEVICE} bs=1k count=${DISKSIZE} | gzip >${RAMDISK_TMP}/initrd-${VER}
cp ${SYS} ${RAMDISK_TMP}/vmlinuz-${VER}
cp ${MAP} ${RAMDISK_TMP}/System.map-${VER}
cp /boot/boot.b ${RAMDISK_TMP}
#
lilo -C - <<EOF
#
#  Lilo boot-configuration script.
#
boot    = /dev/fd0
map     = ${RAMDISK_TMP}/map
install = ${RAMDISK_TMP}/boot.b
backup  = /dev/null
compact
delay = 15	# optional, for systems that boot very quickly
vga = normal	# force sane state
  image = ${RAMDISK_TMP}/vmlinuz-${VER}
  root  = current
  label =  Linux 
  initrd = ${RAMDISK_TMP}/initrd-${VER}
EOF
umount ${RAMDISK_TMP}

They both work fine on 2.2.17, but fail to mount the initial ram-disk
if built while running 2.4.0-test9



Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
