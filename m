Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283537AbRLRBqN>; Mon, 17 Dec 2001 20:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283586AbRLRBqE>; Mon, 17 Dec 2001 20:46:04 -0500
Received: from mail.myrio.com ([63.109.146.2]:15602 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S283585AbRLRBpp>;
	Mon, 17 Dec 2001 20:45:45 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB08@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'andersen@codepoet.org'" <andersen@codepoet.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "'viro@math.psu.edu'" <viro@math.psu.edu>
Subject: ramdisk corruption problems - was: RE: pivot_root and initrd kern
	el panic woes
Date: Mon, 17 Dec 2001 17:44:54 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Erik Anderson and Al Viro, your responses to my first
report helped me to produce this much more accurate report.

I've narrowed it down quite a bit.  It's a problem with ramdisk 
corruption on some 2.4 kernels, not specifically initrd, and 
definitely not a problem with booting initrd.  

executive summary:
  dd'ing from /dev/ram0 usually produces a corrupted ramdisk
  image.

This is reproducible on:
 2.4.12 
 2.4.16 
 2.4.17-pre2 + low-latency patch + custom tweaks 

However, I cannot reproduce the problem on:
 2.4.8-26mdk  (default Mandrake 8.1 kernel)
 2.4.9 

On 2.4.10, I can't do the test, seems like ramdisk was *really*
broken on that kernel.  (no room on ramdisk after mke2fs???)

I now have a simple script that checks for the problem and was 
tried on each of the kernels listed above:

---------------------------------------------------
#!/bin/bash

umount /dev/ram0
./rootfs/bin/busybox freeramdisk /dev/ram0

mke2fs -m0 /dev/ram0 4000
mount -t ext2 /dev/ram0 /mnt/ramdisk
cp -a rootfs/* /mnt/ramdisk
umount /dev/ram0
dd if=/dev/ram0 of=initrd bs=1k count=4000 

dd if=initrd of=/dev/ram0 bs=1k count=4000 
mount -t ext2 /dev/ram0 /mnt/ramdisk

diff -q -r /mnt/ramdisk/bin ./rootfs/bin
diff -q -r /mnt/ramdisk/lib ./rootfs/lib

---------------------------------------------------

On kernels with the problem, the scripted diff reports that most 
(or all?) the binaries and libraries are corrupt.  This contradicts 
my earlier problem report, sorry about that. 

I'm eager to help track this down, I can test patches, supply 
more information, give you a tar.gz of the contents of my rootfs,
or do whatever it takes.   In the meantime I've gone back to 
the default Mandrake 2.4.8 kernel.  It's noticably slower. :-(


A few loose ends...

Erik Andersen wrote:
> Any particular reason you are using a version of busybox that is 
> quite old?  You really should get a newer release -- I've fixed a 
> lot of bugs since then.

Yes, that is one of the reasons I'm working on this again - I'm 
updating my old initrd with the new kernel and the latest versions 
of all the tools I'm using, including busybox.  BTW, thanks 
for your work on busybox, it's great.

[...]

> Can you sucessfully chroot into your rootfs dir?

Good suggestion, that helped set me on the right track to finding
the problem.  I can chroot into my rootfs "source" directory, but 
(unsurprisingly) attempting to chroot to a corrupted image segfaults,
that's how I discovered the corruption, not sure how I missed it 
before.  I'll blame it on Friday afternoon confusion.

Torrey
