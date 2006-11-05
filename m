Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965811AbWKEDem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965811AbWKEDem (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965812AbWKEDem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:34:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965811AbWKEDel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:34:41 -0500
Date: Sat, 4 Nov 2006 19:34:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
In-Reply-To: <1162689005.28571.118.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611041918560.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain> 
 <20061104140559.GC19760@flint.arm.linux.org.uk>  <1162678639.28571.63.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org> <1162689005.28571.118.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
> 
> The -only- problem I'm talking about is that in order to implement the
> above, this IOCOND does something around the line of:
> 
> 	if (pio)
> 		use_pio_accessor()
> 	else
> 		use_mmio_accessor()
> 
> It does that, by using the existing, arch provided, accessors for PIO
> and MMIO (inX, outX, readX, writeX), which are doing the right thing vs.
> barriers etc, so again, all is good and well.... until you hit cases
> where such accessors don't exist !

Right. Your first email seemed to make sense. However, you then said (in 
the second email, the one I responded to), and THAT didn't make any sense 
at all:

   Versions that would transparently use MMIO or PIO would make sense. A
   pure MMIO implementation doesn't, that has to be arch specific. It makes
   the generic iomap suddently non-portable in some ways.

This is the part I claim says that you don't seem to make any sense. You 
seemed to be missing the point about the whole "repeat" instructions, 
since the WHOLE POINT there was that it would _not_ transparently use MMIO 
or PIO, it would very much _nontransparently_ use one or the other, 
exactly because the choice has already very much been made.

> 	- "be" versions of MMIO accesses. Example:

Now, this one we should probably just drop, because nobody uses it. 
Big-endian IO devices basically don't exist any more, and if they do, they 
wouldn't use any generic structures.

> 	- repeat versions of MMIO accessors. Example:

So this one is the only one that makes sense. But it DOES NOT MAKE SENSE 
in light of your second email that talked about "transparently use MMIO or 
PIO". That's what made me think that you were just blathering.

But I also don't want to add _yet_another_ bogus IO accessor function to 
all architectures that nobody actually uses except for this one little 
thing. Quite frankly, I'd rather just add something like

	#ifndef iobarrier_w
	# define iobarrier_w() do { } while (0)
	#endif

and then use iobarrier_w()" in the "mmio" version of the __raw_writel loop 
(and same for iobarrier_r() for the __raw_readl).

			Linus
