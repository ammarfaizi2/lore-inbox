Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263993AbRFNEJZ>; Thu, 14 Jun 2001 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264007AbRFNEJQ>; Thu, 14 Jun 2001 00:09:16 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:50352 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S263993AbRFNEJE>; Thu, 14 Jun 2001 00:09:04 -0400
Message-ID: <3B28391B.60536489@idcomm.com>
Date: Wed, 13 Jun 2001 22:10:03 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: initial ramdisk failure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying for a while now, without luck, to get a kernel with
the SGI XFS system to boot as modules. I do fine if I make all scsi and
XFS as non-modules, but modules fail for both scsi and XFS (I can make
one or the other modular at a time, or both, it fails). According to
what I see, this should not be happening, but it is. All messages
indicate it was successful. I can also take the initial ramdisk image
and gzip, and create a file that I mount via loopback to actually view
the items it contains...no surprises, it has what it should have. But
lilo is not using it (the messages from lilo claim to, but proof is in
the failure). I'm going to list my output below, but the question will
be, for an SMP scsi aic7xxx system, noapic, with ext2 compiled in, and
/boot on its own ext2 partition (root is XFS), how is it possible that
this output lies and does not install scsi or XFS modules? Big note:
label with -2 is successful and has no modules; label with -3 fails, if
any part of filesystem XFS or scsi is modular, and otherwise, there are
no kernel configuration differences. Also, the "ramdisk_size" argument
of the relevant kernel is due to the size of XFS, just to be sure. The
output:

lilo.conf:
boot=/dev/sda
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
linear
vga=0x030c
default=2.4.6-p1-xfs-2
backup=boot.backup.when-2.4.6-pre1-xfs-3

# FAILS, modular.
image=/boot/vmlinuz-2.4.6-pre1-xfs-3
        label=2.4.6-p1-xfs-3
        initrd=/boot/ir-2.4.6-p1-xfs-3.img
        read-only
        root=/dev/sda6
        append="noapic ramdisk_size=16000"

# WORKS, no relevant modules, despite a ramdisk.
image=/boot/vmlinuz-2.4.6-pre1-xfs-2
        label=2.4.6-p1-xfs-2
        initrd=/boot/initrd-2.4.6-pre1-xfs-2.img
        read-only
        root=/dev/sda6
        append="noapic"


Creating the ramdisk (tried both with SGI's mkinitrd.xfs, as well as
regular mkinitrd):
mkinitrd \
 -v \
 -f \
 --preload pagebuf \
 --preload xfs_support \
 --preload xfs \
 --with=scsi_mod \
 --with=sd_mod \
 --with=aic7xxx \
 /boot/ir-2.4.6-p1-xfs-3.img \
 2.4.6-pre1-xfs-3

The output of mkinitrd:
Using modules:  ./kernel/fs/pagebuf/pagebuf.o
./kernel/fs/xfs_support/xfs_support.o ./kernel/fs/xfs/xfs.o
./kernel/drivers/scsi/scsi_mod.o ./kernel/drivers/scsi/sd_mod.o
./kernel/drivers/scsi/aic7xxx/aic7xxx.o
Using loopback device /dev/loop0
/sbin/nash -> /tmp/initrd.sXOMy4/bin/nash
/sbin/insmod.static -> /tmp/initrd.sXOMy4/bin/insmod
`/lib/modules/2.4.6-pre1-xfs-3/./kernel/fs/pagebuf/pagebuf.o' ->
`/tmp/initrd.sXOMy4/lib/pagebuf.o'
`/lib/modules/2.4.6-pre1-xfs-3/./kernel/fs/xfs_support/xfs_support.o' ->
`/tmp/initrd.sXOMy4/lib/xfs_support.o'
`/lib/modules/2.4.6-pre1-xfs-3/./kernel/fs/xfs/xfs.o' ->
`/tmp/initrd.sXOMy4/lib/xfs.o'
`/lib/modules/2.4.6-pre1-xfs-3/./kernel/drivers/scsi/scsi_mod.o' ->
`/tmp/initrd.sXOMy4/lib/scsi_mod.o'
`/lib/modules/2.4.6-pre1-xfs-3/./kernel/drivers/scsi/sd_mod.o' ->
`/tmp/initrd.sXOMy4/lib/sd_mod.o'
`/lib/modules/2.4.6-pre1-xfs-3/./kernel/drivers/scsi/aic7xxx/aic7xxx.o'
-> `/tmp/initrd.sXOMy4/lib/aic7xxx.o'
Loading module pagebuf with options 
Loading module xfs_support with options 
Loading module xfs with options 
Loading module scsi_mod with options 
Loading module sd_mod with options 
Loading module aic7xxx with options 


The output of lilo -v -v:
# lilo -v -v
LILO version 21.4-4, Copyright (C) 1992-1998 Werner Almesberger
'lba32' extensions Copyright (C) 1999,2000 John Coffman

Reading boot sector from /dev/sda
Merging with /boot/boot.b
Secondary loader: 11 sectors.
Mapping message file /boot/message
Message: 46 sectors.
Boot image: /boot/vmlinuz-2.4.6-pre1-xfs-3
Setup length is 9 sectors.
Mapped 1607 sectors.
Mapping RAM disk /boot/ir-2.4.6-p1-xfs-3.img
RAM disk: 1304 sectors.
Added 2.4.6-p1-xfs-3
Boot image: /boot/vmlinuz-2.4.6-pre1-xfs-2
Setup length is 9 sectors.
Mapped 2274 sectors.
Mapping RAM disk /boot/initrd-2.4.6-pre1-xfs-2.img
RAM disk: 500 sectors.
Added 2.4.6-p1-xfs-2 *
boot.backup.when-2.4.6-pre1-xfs-3 exists - no backup copy made.
Map file size: 34304 bytes.
Writing boot sector.


NOTE: It explicitly states "Mapping RAM disk
/boot/ir-2.4.6-p1-xfs-3.img", the relevant ramdisk. It lied. How can it
be? I've been going at this for a couple of weeks now with no success.


After using gzip -dc on the .img, and mounting it via loopback, here is
the content of linuxrc:
#!/bin/nash

echo "Loading pagebuf module"
insmod /lib/pagebuf.o 
echo "Loading xfs_support module"
insmod /lib/xfs_support.o 
echo "Loading xfs module"
insmod /lib/xfs.o 
echo "Loading scsi_mod module"
insmod /lib/scsi_mod.o 
echo "Loading sd_mod module"
insmod /lib/sd_mod.o 
echo "Loading aic7xxx module"
insmod /lib/aic7xxx.o 


Here is the tree of the whole initial ramdisk from loopback mount:
.
|-- bin
|   |-- insmod
|   `-- nash
|-- dev
|   |-- console
|   |-- null
|   |-- ram
|   |-- systty
|   |-- tty1
|   |-- tty2
|   |-- tty3
|   `-- tty4
|-- etc
|-- lib
|   |-- aic7xxx.o
|   |-- pagebuf.o
|   |-- scsi_mod.o
|   |-- sd_mod.o
|   |-- xfs.o
|   `-- xfs_support.o
|-- linuxrc
|-- loopfs
`-- sbin
    |-- bin -> bin
    `-- modprobe -> /bin/nash



Something is wrong, it lacks scsi support if I make scsi a module, it
lacks XFS support if I make that a module. For all intents and purposes,
lilo totally ignored the ramdisk. Any possible clues at all how this
could be?

D. Stimits, stimits@idcomm.com
