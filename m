Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVGLBM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVGLBM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGLBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 21:09:55 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:42685 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261895AbVGLBHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 21:07:31 -0400
Message-ID: <33703.127.0.0.1.1121130438.squirrel@localhost>
In-Reply-To: <20050711193454.GA2210@elf.ucw.cz>
References: <20050711193454.GA2210@elf.ucw.cz>
Date: Mon, 11 Jul 2005 20:07:18 -0500 (CDT)
Subject: Re: arm: how to operate leds on zaurus?
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, July 11, 2005 2:34 pm, Pavel Machek said:
> Hi!
>
> 2.6.12-rc5 (and newer) does not boot on sharp zaurus sl-5500. It
> blinks with green led, fast; what does it mean? I'd like to verify if
> it at least reaches .c code in setup.c. I inserted this code at
> begining of setup.c:674...
>
> #define locomo_writel(val,addr) ({ *(volatile u16 *)(addr) = (val); })
> #define LOCOMO_LPT_TOFH         0x80
> #define LOCOMO_LED              0xe8
> #define LOCOMO_LPT0             0x00
>
>       locomo_writel(LOCOMO_LPT_TOFH, LOCOMO_LPT0 + LOCOMO_LED);
>
> ...but that does not seem to do a trick -- it only breaks the boot :-(
> (do I need to add some kind of IO_BASE?).
> 								Pavel

No, that won't work.

As Russell said, there are problems accessing memory before the io maps
have been set up correctly.  You can see the patch
http://www.cs.wisc.edu/~lenz/zaurus/files/2.6.12-rc5/lenz-03-leds-2.6.12-rc5.patch
need scroll near the bottom in file locomo.c to see how the led gets set. 
You won't actually be able to know where in memory that space is mapped
because we call ioremap, and won't be able to access the locomo stuff
until device_initcall.

WARNING: Horrible hack!  Ugly, ugly, ugly!  First read and understand the
warning at
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2002-January/006730.html

Having said that, either before the MMU has been activated or before the
ioremap() has been called, it is sometimes possible to access the LEDs at
the physical addresses they are located at.  This may or may not work,
might not always work, etc... but it can help as a last resort.  On the
SL5500, the physical address of the start of the locomo chip is
0x40000000, and the leds are at an offset of 0xe8, so something like
volatile u16 *led = (volatile u16 *)0x400000e8;
*led = 0x80;
As the above email says, this is not guarenteed to work at all, will fail
at some point in the boot process, but is something you can try.

That said, I am aware that recent kernel versions have broken the boot on
collie, but haven't looked at the problem in detail (i.e. tried doing a
binary search between known working versions and broken ones to see the
patch that introduced the problem).  I have been working on the SL5600
recently.

John

