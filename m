Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbRGZAPA>; Wed, 25 Jul 2001 20:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbRGZAOu>; Wed, 25 Jul 2001 20:14:50 -0400
Received: from moline.gci.com ([205.140.80.106]:60685 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S267441AbRGZAOn>;
	Wed, 25 Jul 2001 20:14:43 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E1297@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Sparc-64 kernel build fails on version.h during 'make oldconf
	ig', small patch for comments
Date: Wed, 25 Jul 2001 16:14:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David Miller writes:
> Something is terribly wrong with either your system tools or
> this ".config" you are using.
> 
> If you cannot simply do:
> 
> cp arch/sparc64/defconfig .config
> make oldconfig; make dep; make clean; make vmlinux; make modules
> 
> Then something is truly screwed on your machine.  Watch
> for other errors in the make logs if it fails.  I have a
> strange feeling that one of the make sub-shells died on
> you or something.
> 

Well, since I can:

make include/linux/version.h
make vmlinux

and all works correctly, i don't think its my machine.  No other
errors show up, and the kernel builds fine.

On my i386 Thinkpad 760E:
i386# make mrproper
i386# ls include/linux/version.h
ls: include/linux/version.h: No such file or directory
i386 ../.config .
i386# make oldconfig
i386# ls include/linux/version.h
ls: include/linux/version.h: No such file or directory


However, examining makefile traces, for i386 the first step is to
create the version.h, whereas the sparc64 doesn't create the version.h
until after performing the check_asm routine and verifying the asm_offsets.h
file, which occurs in my 'make -n dep' approximately 117 lines into it.

However, 'make -n dep' does not fail under sparc64, as it does under 1386.
When you then attempt to 'make dep' under sparc64:

make -C arch/sparc64/kernel check_asm
make[1]: Entering directory `/usr/src/linux/arch/sparc64/kernel'
sparc64-linux-gcc -E -D__KERNEL__ -I/usr/src/linux/include tmp.c -o tmp.i
In file included from /usr/src/linux/include/linux/fs.h:660,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from tmp.c:3:
/usr/src/linux/include/linux/udf_fs_sb.h:22: linux/version.h: No such file
or directory
make[1]: *** [check_asm] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/sparc64/kernel'
make: *** [check_asm] Error 2

So it __appears__ that the dependancies are coming in the wrong order in the
makefile.  version.h needs to be build before entering the kernel directory.

{ i386 ports work because version.h is a dependancy in
arch/i386/boot/Makefile
but there is no equivilant dependancy in any other architecture.
( find /usr/src/linux -name Makefile -exec grep -il version.h {} \; )

i believe that the proper fix is this:

--- Makefile~	Wed Jul 25 15:44:18 2001
+++ Makefile	Wed Jul 25 16:05:23 2001
@@ -447 +447 @@
+dep-files: scripts/mkdep archdep include/linux/version.h
-dep-files: scripts/mkdep include/linux/version.h archdep

which simply changes the order to generate version.h before the 
archetecture-dependant code is called.

This fixes the build on my sparc64, and causes no problems on my i386.
Sorry i don't have any other architectures to test it on, but my gut
feeling is toward the positive.
