Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTKLLZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTKLLZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:25:24 -0500
Received: from gaia.cela.pl ([213.134.162.11]:23561 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261793AbTKLLZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:25:22 -0500
Date: Wed, 12 Nov 2003 12:25:02 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linus Torvalds <torvalds@osdl.org>, Solar Designer <solar@openwall.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311111142520.1960-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311121204140.26451-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Solar, All,

I've managed to cut the problem down to the openwall patch
(linux-2.4.22-ow1). I know perhaps applying it to 2.4.23-rc1 (which as a 
stock kernel doesn't crash) is perhaps error-prone (ie it's not 
2.4.22 - although the patch applies with no problems and patching
2.4.23-pre6 also causes crashes) but after the number of kernel compiles
it took to locate this I really don't feel like compiling another two
kernels just to test something like this (I'm 99% sure that this'll crash 
on any recent 2.4.x kernel).  If you need stock 2.4.22 info just holler 
and I'll comply.

On Tue, 11 Nov 2003, Linus Torvalds wrote:
> A serial console may be easier than a binary search, but either sound like 
> they should find it.
Well a binary search did find it - it just took ages... and unfortunately 
I have no easy way to set up a serial console...

Applying the following patch to 23rc1 causes total (unresponsive
everything: keyboard, and when appropriate modules/drivers loaded: ps2
mouse, usb mouse, wireless pcmcia card, external ping, sometimes even bios
'fn' key depress LED light) crashes during 'strace ls -lR /' in an xterm
under X (with no other extra modules usb/pcmcia/fs loaded/mounted,
processes running). Seems to only happen during ide disk access, ptrace
and X video update happening at the same time (Toshiba Satellite 2590CDT
notebook).  [The stock 23rc1 kernel works with no problems]

Note that this is a very simplified fragment of the openwall patch found 
via binsearch/simplification (the openwall TASK_UNMAPPED_BASE(size) macro 
is a little more complicated - but this is its gist, and the more 
complicated version crashes as well (that's how the crash was first 
noticed), this system is ELF only anyway).
===========
diff -urN linux-2.4.23-rc1/include/asm-i386/processor.h linux-2.4.23-rc1-ow/include/asm-i386/processor.h
--- linux-2.4.23-rc1/include/asm-i386/processor.h       2003-11-12 00:51:35.000000000 +0100
+++ linux-2.4.23-rc1-ow/include/asm-i386/processor.h    2003-11-12 11:32:27.000000000 +0100
@@ -264,7 +264,8 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE     (TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE(size) ( (size) < 0x00ef0000UL ? 0x00110000UL \
+				:TASK_SIZE / 3)

 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -urN linux-2.4.23-rc1/mm/mmap.c linux-2.4.23-rc1-ow/mm/mmap.c
--- linux-2.4.23-rc1/mm/mmap.c  2003-10-25 23:02:19.000000000 +0200
+++ linux-2.4.23-rc1-ow/mm/mmap.c       2003-11-12 11:29:37.000000000 +0100
@@ -626,7 +626,7 @@
                    (!vma || addr + len <= vma->vm_start))
                        return addr;
        }
-       addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
+       addr = PAGE_ALIGN(TASK_UNMAPPED_BASE(len));

        for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
                /* At this point:  (!vma || addr < vma->vm_end). */
==============

Cheers,
MaZe.

