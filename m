Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVJZSTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVJZSTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVJZSTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:19:40 -0400
Received: from smtp.preteco.com ([200.68.93.225]:3535 "EHLO smtp.preteco.com")
	by vger.kernel.org with ESMTP id S964853AbVJZSTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:19:40 -0400
Message-ID: <435FC886.7070105@rhla.com>
Date: Wed, 26 Oct 2005 16:18:46 -0200
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Marcio Oliveira <moliveira@latinsourcetech.com>
Subject: Kernel Panic + Intel SATA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

  I have a IBM ThinkPad t43 running Fedora Core  Linux 4 and kernel 
2.6.12-1.146_FC4. I recompiled the kernel (2.6.13.4 - kernel.org) and I 
am geting the following message when the computer boots:

Creating root device
mkrootdev: label / not found
Mounting root filesystem
mount: error 2 mouting ext3
Switchimg to new root
ERROR opening /dev/console!!!!: 2
switchroot: mount failed: 22
Kernel Panic - not syncing to kill init!

    I added the fdisk command to the initrd file and the init script 
executes it every boot to check if the kernel was recognizing the SATA 
disk. All partitions are listed in the boot process and the disk is 
recognized without problems, but the kernel still not able to mount the 
root partition:

scsi0: ata_piix
...
...
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Disk /dev/sda: 60.0 GB, 60011642880 bytes
255 heads, 63 sectors/track, 7296 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
 
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1        1913    15361888+   7  HPFS/NTFS
Partition 1 does not end on cylinder boundary.
/dev/sda2            6778        7296     4165560   12  Compaq diagnostics
Partition 2 does not end on cylinder boundary.
/dev/sda3            1914        1929      128520   83  Linux
/dev/sda4            1930        6777    38941560    5  Extended
/dev/sda5            1930        2843     7341673+  8e  Linux LVM
/dev/sda6            2844        3235     3148708+  83  Linux
/dev/sda7            3236        6777    28451083+   b  W95 FAT32
 
Partition table entries are not in disk order

   I also checked the initrd file and all seems ok.
   Thinks I made:

- compiled the kernel with ext3 modular support;
- compiled the kernel with ext3 built-in support;
- checked the modules loaded in the initrd;
- rebuilded and customized the initrd;
- checked if the SATA controller is recognized at boot time;
- tested fstab with and without "LABEL" partition name.

Any idea?

   Related Files:

/etc/fstab:

# This file is edited by fstab-sync - see 'man fstab-sync' for details
/dev/sda6                 /                       ext3    
defaults        1 1
#LABEL=/                 /                       ext3    defaults        1 1
#LABEL=/boot             /boot                   ext3    defaults        1 2
/dev/sda3             /boot                   ext3    defaults        1 2
/dev/devpts             /dev/pts                devpts  gid=5,mode=620  0 0
/dev/shm                /dev/shm                tmpfs   defaults        0 0
/dev/proc               /proc                   proc    defaults        0 0
/dev/sys                /sys                    sysfs   defaults        0 0
/dev/VG00/usr           /usr                    ext3    defaults        1 2
/dev/VG00/var           /var                    ext3    defaults        1 2
/dev/VG00/swap          swap                    swap    defaults        0 0
/dev/sda7               /mnt/windows            vfat    user,defaults   0 0
/dev/hdc                /media/cdrecorder       auto    
pamconsole,exec,noauto,managed 0 0

/boot/grub/menu.lst

title Fedora Core (2.6.13-4)
        root (hd0,2)
        kernel /vmlinuz-2.6.13.4-ext3 ro root=LABEL=/ hda=noprobe 1
        initrd /initrd-2.6.13.4-ext3.img

*** I tested the root=LABEL=/ and root=/dev/sda6 kernel comand options.

Initrd file contents:

./sbin
./loopfs
./proc
./init
./sysroot
./bin
./bin/hotplug
./bin/nash
./bin/udev
./bin/fdisk
./bin/insmod
./bin/udevstart
./bin/modprobe
./dev
./dev/tty3
./dev/tty4
./dev/tty1
./dev/console
./dev/tty2
./dev/null
./dev/ram
./dev/systty
./sys
./lib
./lib/libc.so.6
./lib/ld-2.3.5.so
./lib/scsi_mod.ko
./lib/ld-linux.so.2
./lib/sd_mod.ko
./lib/libc-2.3.5.so
./lib/dm-mod.ko
./lib/ata_piix.ko
./lib/libata.ko
./etc
./etc/udev
./etc/udev/udev.conf

/init initrd file:

#!/bin/nash
mount -t proc /proc /proc
setquiet
echo Mounted /proc filesystem
echo Mounting sysfs
mount -t sysfs /sys /sys
echo Creating /dev
mount -o mode=0755 -t tmpfs /dev /dev
mknod /dev/console c 5 1
mknod /dev/null c 1 3
mknod /dev/zero c 1 5
mkdir /dev/pts
mkdir /dev/shm
echo Starting udev
/sbin/udevstart
echo -n "/sbin/hotplug" > /proc/sys/kernel/hotplug
echo "Loading scsi_mod.ko module"
insmod /lib/scsi_mod.ko
echo "Loading sd_mod.ko module"
insmod /lib/sd_mod.ko
echo "Loading libata.ko module"
insmod /lib/libata.ko
echo "Loading ata_piix.ko module"
insmod /lib/ata_piix.ko
echo "Loading dm-mod.ko module"
insmod /lib/dm-mod.ko
sleep 10
/sbin/fdisk -l
sleep 10
/sbin/udevstart
echo Creating root device
mkrootdev /dev/root
echo Mounting root filesystem
mount -o defaults --ro -t ext3 /dev/root /sysroot
echo Switching to new root
switchroot --movedev /sysroot


