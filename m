Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSDBFEy>; Tue, 2 Apr 2002 00:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312786AbSDBFEp>; Tue, 2 Apr 2002 00:04:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20272 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312783AbSDBFEd>; Tue, 2 Apr 2002 00:04:33 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] Linux/i386 boot protocol version 2.04
In-Reply-To: <Pine.LNX.4.33L2.0204011236060.13412-100000@dragon.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Apr 2002 21:58:10 -0700
Message-ID: <m1vgbau271.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On 30 Mar 2002, Eric W. Biederman wrote:
> 
> | I have been doing some very weird things with booting the Linux kernel
> | for a long time.
> 
> so you are saying that we want these 'weird' things in the
> baseline kernel?  ;)

We want the ability yes.  The overhead is quite small, the code is clean,
and it makes the kernel more maintainable.  The mainline handles
weird cases so Linux will just work.  Without these we aren't handling
the hard cases.

> Will you please provide a one-sentence explanation for each of
> these items?  (not "what," but "why" it's good to have it)
> 
> |   - Entering the kernel in 32bit mode to avoid 16bit BIOS calls.

If you don't have an pc compatible BIOS making 16bit BIOS calls is
fatal.  Additionally there are boot environments where switching
to 16bit to enter the kernel is just silly.

> |   - Converting bzImage into static ELF executables.

Bean counting for bootloaders, my patch simply increases the
visibility of what the Linux kernel does while loading.  Being able
to actually understand what the kernel is doing while loading makes it
much easier to trouble shot problems.

I'm a big fan of making a giant static binary with the command line,
ramdisk and everything included and just asking the bootloader to read
it from wherever and put it in memory exactly where I said.  And
failing that to give me an Error message.  The ELF file format doesn't
have much overhead and provides a general way for me to do that.

The biggest thing this allows is with some fixing on how we allocate
the bootmem bitmap bootloaders will be able to put the initial ramdisk
right after where the kernel is in memory, without a decrease in
bootability for the low memory case.  Which if we had done it that way
in the first place would have prevented our problems on high memory
machines.

> |   - Hard coding a kernel command-line

There is one byte of overhead with this a terminating null.  For
cases with stupid bootloaders, or users who can't figure out their
bootloaders this is handy.   Additionally doing this reduces the
memory fragmentation potentially allowing video.S to have a larger
heap.

> |   - Going back to 16bit mode to make BIOS calls if necessary.

> |
> | This version of the boot protocol should be fully backwards compatible
> | but has new capabilities so I can do all of the above cleanly.
> |
> | The current plan is to send this to Linus in the next couple of days
> | as soon as he gets back.
> |
> ...
> |
> | Anyway please tell me what you think.
> |
> | Eric
> |
> |
> | This is a log of a series of patches that cleans up and enhances the
> | x86 boot process.
> 
> [snippage]
> 
> | 2.5.7.boot.proto 7
> | ============================================================
> | Update the boot protocol to include:
> |    - A compiled in command line
> 
> when and how is the command line specified?  at build time?
> 
> maybe in a kernel.command.line file so that I don't have to type
> it in every time?

At compile time.  You can put in .config .  I copied the
config interface from the other Linux ports that already have
this functionality.  There is enough information present in the
bzImage header that you can edit have a utility to edit it
later if you want.

> |
> | 2.5.7.boot.boot_params 1
> | ============================================================
> | - Introduce asm-i386/boot_param.h and struct boot_params
> | - Implement struct boot_params in misc.c & setup.c
> 
> Yep, I like that one.
> 
> | This removes a lot of magic macros and by keeping all of the
> | boot parameters in a structure it becomes much easier to track
> | which boot_paramters we have and where they live.  Additionally
> | this keeps the names more uniform making grepping easier.
> 
> I'll try to look over the patch files too.

Thanks.

Eric
