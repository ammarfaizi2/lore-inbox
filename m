Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUE2Xta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUE2Xta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUE2Xta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 19:49:30 -0400
Received: from opersys.com ([64.40.108.71]:27411 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261231AbUE2XtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 19:49:25 -0400
Message-ID: <40B922D5.5090609@opersys.com>
Date: Sat, 29 May 2004 19:55:01 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
References: <40B8A161.5040306@kegel.com>
In-Reply-To: <40B8A161.5040306@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Kegel wrote:
> As an aside, it seems like gcc-3.3.3 is pretty good.
> There are some known problems with it, but the number is small.
> I haven't tried gcc-3.4.0 much yet, but I have seen a few kernel patches
> to fix issues 3.4.0 found in the kernel source.

I thought I'd drop in here while there's mention of the kernel and 3.4.0
to describe some recent experiences I've been having on that topic.

Here's some detilas of what I've been trying to get to work:
- hardware: Motorola MCP750 - Mesquite / PowerPC 750
- kernel: 2.4.18 patched with motorola patches for MCP750
- binutils: 2.15
- gcc: 3.4.0
- glibc: 2.3.2

First off, I was able to get the toolchain to build. Needed a few hacks,
but nothing really major.
RANT: It's really about time that someone within the GNU project took it
upon herself to actually get the GNU toolchain to build for cross-dev
without having to require walking-on-water talents. Anyhow ...

I built the kernel with the toolchain, and here's what I got when trying
to launch it from ppc-bug:
---------------------------------------------------------------
PPC1-Bug>nbo 0 0,,, zImage.prep
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: zImage.prep

Client IP Address      = 192.168.12.3
Server IP Address      = 192.168.12.8
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage.prep
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1018969, Bytes Loaded =&1018969
Bytes/Second   =&1018969, Elapsed Time =1 Second(s)

Residual-Data Located at: $07E88000
loaded at:     00005400 00019234
relocated to:  01000000 01013E34
board data at: 07E88000 07E8EA0C
relocated to:  0100A14C 01010B58
zimage at:     0000F400 000FBC17
relocated to:  01014000 01100817
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600
cmd_line located > 16M
hold_residual located > 16M
Uncompressing Linux...done.
Now booting the kernel
vector: 300 at pc = 900108b4, lr = 901b847c
msr = 1032, sp = 9019dc80 [9019dbd0]
dar = 0, dsisr = 40000000
current = 9019bcd0, pid = 0, comm = swapper
mon>
---------------------------------------------------------------

[To even get the 2.4.18 kernel to build, I had to modify a few
syscall clobber statements which the recent toolchain didn't like
much. Peaked into 2.4.26's include/asm-ppc/unistd.h for some
inspiration ;)]

To make a very long story short, I was able to actually get this
kernel to start only if I commented out parse_options() and
do_initcalls() in init/main.c. No need to say how ugly this is.
Somehow, if I set cmd_line[0] = '\0' it actually went through
parse options without any problem, but still died in do_initcalls.
Yet, if I looped around and printed out the content of the command
line, it was all OK:
	{
	  int i;
	for (i = 0; i < 256; i++)
	  if (command_line[i] != '\0')
	    printk("Command line entry %d is %c \n", i, command_line[i]);
	  else
	    printk("Command line entry %d is NULL \n");
	}

Feeling that this might be a problem with the 2.4.18 kernel I
was using, I tried a variety of different kernels without the
mot patch: 2.4.25-debian, 2.4.26-vanilla, 2.4.25-benh1, 2.6.6,
etc. Nothing worked. At best, I got to the same spot as earlier.

[ BTW, the 2.6.6 kernel wouldn't build without the following
modifications to the main makefile:
AS              = $(CROSS_COMPILE)as -maltivec
CFLAGS_KERNEL   = -maltivec
AFLAGS_KERNEL   = -maltivec
For some reason 3.4.0 forgets to tell AS that this CPU may have
Altivec instructions -- there are some postings about this if
you google around.]

Finally, despite my reservations about what such a thing would
really change, I decided to try gcc 3.3.2 and gcc 3.2.3.
Surprisingly, this actually worked. The patched 2.4.18 above
booted without any problem whatsoever. I tried a couple of other
kernels as well, to see if they too would work. I noticed that
some that actually failed as above (causing a fault very early
at boot time), now didn't fail with 3.3.2, but printed nothing
to the terminal and the system would eventually reboot -- as if
console=ttyS0,9600 had no effect and the kernel panicked as
expected because of the missing rootfs.

But I wanted to at least have another kernel than the mot 2.4.18
with gcc 3.3.2 working, so I went back to the kernel dated
2004/05/22 downloaded from http://www.ppckernel.org/kernel.php?id=26
-- it's actually a modified 2.4.26 -- and hacked the Makefile and
misc.c files in arch/ppc/boot/prep directory to get it to build.
Once I did this, I was actually able to get this one to build and
boot successfully on the board with both gcc 3.3.2 and gcc 3.4.0.
So there's at least one kernel I was able to get working with
3.4.0.

What's most frustrating is that I came away with not much more
understanding as to why the same parse_options() and
do_initcalls() would build without a warning on gcc 3.4.0 but
would cause a fault at runtime, while building and running
flawlessly with gcc 3.3.2 and gcc 3.2.3 ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

