Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314375AbSEECsa>; Sat, 4 May 2002 22:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315172AbSEECs3>; Sat, 4 May 2002 22:48:29 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:28932 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314375AbSEECs2>;
	Sat, 4 May 2002 22:48:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: initrd and devfs 
In-Reply-To: Your message of "Mon, 29 Apr 2002 18:46:45 +1000."
             <22788.1020070005@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 12:48:18 +1000
Message-ID: <2588.1020566898@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend, no response from initrd/devfs maintainers the first time.

I am having problems with the combination of initrd and devfs.

mkinitrd 3.3.9, hacked to build an ia64 initrd on ia32.
Kernel 2.4.18-ia64-020410, config extract.

CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y

linuxrc commands:

insmod /lib/qla1280.o
echo Mounting /proc filesystem
mount -t proc /proc /proc
echo Creating root device
mkrootdev /dev/root
  fails "mkrootdev: mknod failed: 17".  devfs has already created
  /dev/root as a symlink.
echo 0x0100 > /proc/sys/kernel/real-root-dev
echo Mounting root filesystem
mount --ro -t ext2 /dev/root /sysroot
  fails "mount: error 16 mounting ext2" because /dev/root is wrong.
pivot_root /sysroot /sysroot/initrd
  fails "pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2"

By removing /dev/root immediately before mkrootdev /dev/root I can get
past those errors, even pivot_root works.  But then it gets nasty :-

INIT: version 2.78 booting
                        Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Unmounting initrd:  umount: /initrd: device is busy
  Because of this mount - none /initrd/dev devfs rw 0 0

If I boot with initrd and devfs=nomount it goes through initrd
processing and successfully umounts initrd, but then fails "Remounting
root filesystem in read-write mode: mount: no such partition found".
/proc/mounts contains

  /dev/root / ext2 ro 0 0

What is the correct way of using initrd and devfs together?

devfsd.conf is not the answer, initrd does not run the devfsd daemon.

