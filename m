Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314959AbSD2JNa>; Mon, 29 Apr 2002 05:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314960AbSD2JN3>; Mon, 29 Apr 2002 05:13:29 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:22522 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S314959AbSD2JN2>;
	Mon, 29 Apr 2002 05:13:28 -0400
Date: Mon, 29 Apr 2002 11:13:02 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: initrd and devfs
In-Reply-To: <22788.1020070005@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.30.0204291107420.11078-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not absolutely sure that this is what you want, but I think I have a
similar case.
I boot from a CD a kernel which has cdrom support compiled as modules, and
devfs compiled in:

syslinux starts kernel with this:
 /boot/bzImage devfs=mount root=/dev/cdroms/cdrom0 initrd=/boot/initrd

Then the initrd loads the needed modules, and _exits_.
The kernel then mounts the given root, and the system boots successfully.

So all I needed to do is give the root partition as a parameter, and no
mkrootdev or pivot_root was needed.

-- 
Balazs Pozsar

On Mon, 29 Apr 2002, Keith Owens wrote:

> I am having problems with the combination of initrd and devfs.
>
> mkinitrd 3.3.9, hacked to build an ia64 initrd on ia32.
> Kernel 2.4.18-ia64-020410, config extract.
>
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=8192
> CONFIG_BLK_DEV_INITRD=y
>
> linuxrc commands:
>
> insmod /lib/qla1280.o
> echo Mounting /proc filesystem
> mount -t proc /proc /proc
> echo Creating root device
> mkrootdev /dev/root
>   fails "mkrootdev: mknod failed: 17".  devfs has already created
>   /dev/root as a symlink.
> echo 0x0100 > /proc/sys/kernel/real-root-dev
> echo Mounting root filesystem
> mount --ro -t ext2 /dev/root /sysroot
>   fails "mount: error 16 mounting ext2" because /dev/root is wrong.
> pivot_root /sysroot /sysroot/initrd
>   fails "pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2"
>
> By removing /dev/root immediately before mkrootdev /dev/root I can get
> past those errors, even pivot_root works.  But then it gets nasty :-
>
> INIT: version 2.78 booting
>                         Welcome to Red Hat Linux
>                 Press 'I' to enter interactive startup.
> Mounting proc filesystem:  [  OK  ]
> Unmounting initrd:  umount: /initrd: device is busy
>   Because of this mount - none /initrd/dev devfs rw 0 0
>
> If I boot with initrd and devfs=nomount it goes through initrd
> processing and successfully umounts initrd, but then fails "Remounting
> root filesystem in read-write mode: mount: no such partition found".
> /proc/mounts contains
>
>   /dev/root / ext2 ro 0 0
>
> What is the correct way of using initrd and devfs together?
>
> devfsd.conf is not the answer, initrd does not run the devfsd daemon.

