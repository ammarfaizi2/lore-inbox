Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTC0Svj>; Thu, 27 Mar 2003 13:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbTC0Sve>; Thu, 27 Mar 2003 13:51:34 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:29197 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261290AbTC0Sv1>; Thu, 27 Mar 2003 13:51:27 -0500
Date: Thu, 27 Mar 2003 20:02:22 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Walt H <waltabbyh@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vesafb problem
Message-ID: <20030327190222.GA4060@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <3E8329D2.7040909@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8329D2.7040909@comcast.net>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walt H <waltabbyh@comcast.net>
Date: Thu, Mar 27, 2003 at 08:41:54AM -0800
> Hello all,
> 
> I've got a strange problem with my 760MPX system dual proc system. If I 
> try to use vesafb to setup the video on boot, the system will boot fine, 
> but will be unable to display anything on the console. The system 
> appears to be largely unaffacted by any underlying problem, as it is 
> stable after boot and seems to run fine. In looking through logs 
> afterward, I find these suspect messages:
> 
> mtrr: your CPUs had inconsistent fixed MTRR settings
> vesafb: abort, cannot ioremap video memory 0x8000000 @ 0xe8000000
> 
> I've tried using the rivafb frame buffer, which also does not work. From 
> what I could see in scanning the archives, this appears to possibly be a 
> BIOS issue, however, I'm game to throw nearly anything at it to try and 
> resolve it. Hardware is as follows:
> 
> Chaintech 7KDD 760MPX chipset motherboard
> 2 x AMD 2400MP
> 1 GB Ram
> Nvidia GeForce 4600
> 
I had a similar problem with 1 Gb Ram, and received this answer on the
linux-kernel mailinglist:

======================================================
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64: ioremap_nocache() failes with 1 gigabyte memory, works with 512 Mb?
From: Roland Dreier <roland@topspin.com>
Date: 14 Mar 2003 00:15:26 -0800

    thunder7> Now I added some information to the printk, and I now
    thunder7> know:

    thunder7> fb: Can't remap 3Dfx Voodoo5 register area. (start d0000000 length 8000000)

Length 0x8000000 means the driver is trying to ioremap a 128MB.

    thunder7> If I boot my kernel with 'mem=512M' I can use the
    thunder7> framebuffer just fine (well, it doesn't work and writes
    thunder7> funky patters to the screen, but at least
    thunder7> ioremap_nocache() works fine).

    thunder7> What is the reason ioremap_nocache() fails? Is this
    thunder7> something that can be prevented? I am not entirely clear
    thunder7> on what is happening anyway (real memory, virtual
    thunder7> memory, nocache-memory, io-memory - a little bit above
    thunder7> my head :-) ).

ioremap_nocache() uses "vmalloc space".  The kernel has some address
space it uses for kernel virtual memory mappings -- that is, for
mapping vmalloc()'ed memory and ioremap()'ed memory.

On i386, the kernel uses whatever part of the top 1 GB of address space
is not used for directly mapped RAM (aka lowmem).  (There are a few
other things that take some address space but that is approximately
true).

This means with "mem=512M", you will probably have about 500M of
vmalloc space, which is more than enough to ioremap the framebuffer.

With the full 1 GB of memory, you might think that there would be no
vmalloc space available at all.  However, <asm/page.h> defines a
constant VMALLOC_RESERVE (which by default is 128 MB), and the kernel
makes sure that there is at least this much vmalloc space available.
However, by the time you load the module, at least some of this space
has been consumed, so the ioremap fails.  (If nothing else uses
vmalloc space, just loading a module will call vmalloc() to get space
for the module to be loaded into!)

One not very good way for you to proceed would be to change the
definition of VMALLOC_RESERVE from (128 << 20) to something like (256
<< 20), which should leave the driver room to ioremap the framebuffer.
This is a little ugly.  However, I don't see why a framebuffer driver
would need to ioremap _all_ of a video card's memory -- so a better
solution would be to fix the driver to only ioremap what it needs to.

Best,
  Roland
======================================================

To see if this is it, booting with mem=512M would be a good test.

Kind regards,
Jurriaan
-- 
War does not determine who is right -- only who is left.
	Bertrand Russell
Debian (Unstable) GNU/Linux 2.5.65-mm3 4276 bogomips load av: 0.90 0.80 0.61
