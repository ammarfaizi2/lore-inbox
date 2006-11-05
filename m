Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965822AbWKEDuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965822AbWKEDuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbWKEDuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:50:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:41150 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965820AbWKEDuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:50:06 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0611041918560.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041918560.25218@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 14:49:43 +1100
Message-Id: <1162698583.28571.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	- "be" versions of MMIO accesses. Example:
> 
> Now, this one we should probably just drop, because nobody uses it. 
> Big-endian IO devices basically don't exist any more, and if they do, they 
> wouldn't use any generic structures.

I'd be happy to do so :) I just added _be versions for PowerPC for that
(writew_be, etc...) and an ARCH_HAVE_* to tell iomap that they exit. I
also found out that the _be implementation in lib/iomap is broken for
PIO (it just uses the LE versions without swap).

I just sent you a patch that allows the arch to provide it's own
versions. But if you want, I can redo it dropping the "be" thingies.

There are BE devices though... just generally not on PCI (Heh, I've just
had to deal with some folks doing a BE version of EHCI !). For plaform
specific stuffs, PowerPC has it's own low level accessors
(in_le16/in_be16/etc....) so it doesn't really matter unless we start
wanting drivers for those weird animals to get a bit more generic.

> > 	- repeat versions of MMIO accessors. Example:
> 
> So this one is the only one that makes sense. But it DOES NOT MAKE SENSE 
> in light of your second email that talked about "transparently use MMIO or 
> PIO". That's what made me think that you were just blathering.

I think I just badly expressed myself. My appologies.

> But I also don't want to add _yet_another_ bogus IO accessor function to 
> all architectures that nobody actually uses except for this one little 
> thing. Quite frankly, I'd rather just add something like
> 
> 	#ifndef iobarrier_w
> 	# define iobarrier_w() do { } while (0)
> 	#endif
> 
> and then use iobarrier_w()" in the "mmio" version of the __raw_writel loop 
> (and same for iobarrier_r() for the __raw_readl).

Unfortunately, that is not enough for us... 

In the case of reads. I need a barrier before the read and I need to
create a data dependency on the read data to force the CPU to perform
the read followed by an instruction barrier...

Also, with our new ultra-hard-like-x86 semantics we have now (at least
until I try again sorting that other mess out), our stores also need
additional barriers before the stores and setting a magic per-CPU bit
after... That sort of crap isn't easy to expose in the form of a couple
of barrier macros so I'd rather keep it out of the way safely inside
asm-powerpc/io.h

I've actually come accross buggy drivers that could use some "repeat"
version of the MMIO accessors a couple of times in the past in fact
(they used a loop instead and got the endian wrong of course). So I'm
not convinced they are that useless.... That sort of shit is actually
fairly common in the embedded world.

Anyway, the patch I sent you earlier allows the arch to provide them and
just falls back to the "hand made" versions if not. You might still want
to add this iobarrier_w() thingy in addition to that for other archs
that might want to use the fallback and need barriers though...

Cheers
Ben.


