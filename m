Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270504AbRHNIAR>; Tue, 14 Aug 2001 04:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270506AbRHNIAI>; Tue, 14 Aug 2001 04:00:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22131 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270504AbRHNH7s>; Tue, 14 Aug 2001 03:59:48 -0400
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <20010813120505.97748.qmail@web11808.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2001 01:53:01 -0600
In-Reply-To: <20010813120505.97748.qmail@web11808.mail.yahoo.com>
Message-ID: <m1wv47oz6q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain <etienne_lorrain@yahoo.fr> writes:

> > This is indeed a good structure, but this wide interface is a pain to
> > keep stable, and having bootloaders call it directly is a genuinely
> > bad idea.  It will lock us into an interface, or cause major breakage,
> > when we have to do necessary revving of this interface.
> 
>  Note that this interface is so stable that the structure did not change
>  for a long time. If someone wants to change it completely, he will
>  have to rewrite tools which are accessing this structure (rdev) and
>  also the bootloaders which are setting up fields into it already.
>  This will involve re-coding real-mode i8086 assembly, and there is less
>  and less people knowing how to do it.

True.  However for the moment I am up for making this kind of change.
rdev needs to be recoded anyway as it is not portable.  We need a rdev
like tool to attach a command line and a ramdisk to arbitrary linux
kernels. 

> > Instead, the proper time to deal with this is at kernel link time.
> > The PC-BIOS stuff should go in, say arch/i386/pcbios, and you then can
> > have other platforms (say, for example, arch/i386/linuxbios) which has
> > its own setup code.  You then link a kernel image which has the
> > appropriate code for the platform you're running on, and you're set.
> 
>  I can see your point about keeping functions which set up the structure
>  and function which uses it in a single kernel release.
>  In fact, all the functions setting this structure are in the same
>  file in Gujin, vmlinuz.[ch]. This file could one day go into the Linux
>  kernel, but we are no more speaking of compatibility.
> 
>  My main problem is the order the things are done: First load compressed
>  files at defined addresses, then call a kernel function which callback the
>  BIOS, then uncompress files.

How is this a problem.  Is it the error handling or something else?
I like the fact that the kernel decompresses itself.  This is one less
thing that the bootloader doesn't have to do.  And allows the
compression scheme to be changed at least theoretically.

>  Once Gujin has started, I have a complete C environment so I can load
>  files, treat errors, display messages. I can do this either from cold
>  boot or from DOS (think of the first install of Linux on a system).

This definentily sounds nice.  Do you envision the setup code
returning to the bootloader if a fatal error occurs?
 
>  A good solution would be to have the kernel being two (or three) GZIP
>  files concatenated, the first would be the real-mode code to setup
>  the structure only, the second would be the protected-mode code of the
>  kernel (and the third the initrd). The first part would be a position
>  independant function getting some parameters (address/max size of the
>  structure to fill in) and returning information like microprocessor
>  minimum requirement, video mode supported (number of BPP, or text only),
>  address the kernel has been linked (to load a kernel at 16 Mb), ...
> 
>  Then I would call this setup function before doing invalid things like
>  writing in the "DOS=HIGH" area. Note also that Gujin do not keep the
>  compressed kernel/initrd files, it reads a block and uncompress it
>  immediately because of the 64Kb limit on the data section.

Why does Gujin need to do the decompression?  Is this simply for
better error checking, and error handling?
 
>  This interface would still not handle a distribution where there is
>  few kernel files:
>  /boot/Linux-2.4.8-SMP
>  /boot/Linux-2.4.8-UP
>  /boot/Linux-2.4.8-386
>  /boot/Linux-2.4.8-Pentium
>  And the bootloader should just select automagically the right kernel.

At this port I have linux booting from linux so what I would do is
load /boot/Linux-2.4.8-i386 and then from linux select the right
kernel modify the bootloader parameters, and boot the optimal kernel.

>  I have to say that I simply do not have time to do such a thing,
>  because I have a lot of other problems in Gujin: it is already
>  a Linux-3.0 bootloader, not Linux-2.5 .
>  Moreover, going from a simple solution (loading the binary image of
>  an ELF file) to a complex one (as described) to solve problem which
>  may appear in the future is not my way of thinking: it is already
>  complex enought to do simple software.

I believe it can be done much more simply.  And I think I can make the
time to get it done, over the long term.   I can do with an ELF
binary, not it's binary ala objdump -O binary I can do what you
propose to do with concatenated GZIP files.  And with that I don't
need decompression code in the bootloader. 

Eric

