Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281735AbRLQSkI>; Mon, 17 Dec 2001 13:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282080AbRLQSj7>; Mon, 17 Dec 2001 13:39:59 -0500
Received: from mail.myrio.com ([63.109.146.2]:26107 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S281932AbRLQSjn>;
	Mon, 17 Dec 2001 13:39:43 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB07@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Mike Galbraith'" <mikeg@wen-online.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: pivot_root and initrd kernel panic woes
Date: Mon, 17 Dec 2001 10:38:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been following this discussion with interest as I've also 
been having initrd problems recently with a setup that used to
work perfectly.  

I haven't completely tracked it down, but for me, it seems to 
be the initrd *build* that is the problem, rather than the kernel 
booting the initrd.  

My initrd is ext2, uses busybox as init (not using linuxrc or
pivot_root) - it is booted over the network using the pxelinux 
boot loader (part of Peter Anvin's syslinux package.)  

I take the same set of files and convert them into an initrd 
multiple times.  Some of the images will boot (every time) and 
some won't - ever.  

When they don't boot, the last messages on the console are:

RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1197k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 388k freed

and then the system just hangs.  When it works, the messages are
identical up to that point but continue...

init started:  BusyBox v0.51 (2001.04.25-13:32+0000) multi-call binary
(etc.)

I have a complete set of files and dev nodes for the initrd in 
./rootfs. They add up to about 3 MB.  Nothing too unusual - busybox, 
glibc 2.1.3, etc.

My build system kernel is 2.4.16, has the standard 4 MB ramdisk, 
and I use the following script to create the initrd:

#!/bin/bash

rm -rf initrd.gz
umount /dev/ram
mke2fs -m0 /dev/ram 4000
mount -t ext2 /dev/ram /mnt/ramdisk
cp -a rootfs/* /mnt/ramdisk
umount /dev/ram
dd if=/dev/ram bs=1k count=4000 of=initrd
gzip initrd

If I run this script several times, the resulting "initrd.gz"
files are different each time (of course - different timestamps 
and file ordering in the image).  They are all about 1.2 MB.

Some of them boot and some of them don't.  I can take a non-working
image, gunzip it, dd it back to the ramdisk, mount it, and 
recursively diff it against the original rootfs and find nothing
wrong. 

I thought this was a 2.4 kernel bug until I found that my older
2.2.19 kernel works or fails on the same initrd.gz files as the 
new 2.4.16 kernel.

But I never used to have this problem when I built initial 
ramdisks (using the *same* script and *same* files) under 2.2.19,
so maybe the problem is that creating initrd's on 2.4.x is buggy?

The other variable is I used to build them with Mandrake 7.2, 
I've since upgraded to Mandrake 8.1.  Perhaps the problem is the
version of gzip I use, or something else in the distribution.

Anyway, I hope to track this down today.

Very weird, and _very_ annoying.  Wasted 4 hours on this Friday.

Torrey Hoffman
