Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUIWAwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUIWAwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUIWAwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:52:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:63190 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266257AbUIWAwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:52:32 -0400
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <roland@topspin.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040922185851.GA11017@vana.vc.cvut.cz>
References: <1095758630.3332.133.camel@gaston>
	 <1095761113.30931.13.camel@localhost.localdomain>
	 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	 <52mzzjnuq7.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
	 <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1095900539.6359.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 10:49:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 04:58, Petr Vandrovec wrote:

> > There still is that issue with __raw_* doing both barrier-less and
> > endianswap-less accesses though. I think there is a fundamental problem
> > here with drivers like matroxfb using them to get endian-less access and
> > losing barriers at the same time.
> 
> Before I put __raw_* there, code was using direct *(u_int32_t*)(mmio +
> reg) = value, and nobody complained... (and it worked on my PReP box).
> It seems that PPC does not reorder concurrent writes targetting one
> device.

It may re-order write vs. reads, nobody complained because on most old
machines, the CPU would be too dumb to do really heavy re-ordering but
that is no longer the case. This is definitely a bug.

> > I'd rather have matroxfb use writel with an explicit swap, or better, the
> > driver could maybe disable big endian register access and switch the card
> > to little endian, provided it can do that while keeping the frame buffer
> > itself set to BE (which is necessary most of the time).
>
> It is due to compatibility with XFree (or at least I was told) - they want 
> both framebuffer and accelerator in big-endian mode, so there is really no
> choice (other than not supporting ppc...).

Hrm... having a quick look at mga driver in current Xorg tree, it uses
the MMIO_IN/OUT macros directly, those are not byteswapping ?

It also does this at one point (ugh !) :

#if X_BYTE_ORDER == X_BIG_ENDIAN
	/* Disable byte-swapping for big-endian architectures - the XFree
	   driver seems to like a little-endian framebuffer -ReneR */
	/* pReg->Option |= 0x80000000; */
	pReg->Option &= ~0x80000000;
#endif

Weird... I think the X driver just lacks any "knowledge" of what's going
on with endianness...

> But of course, I can use writel(swab(...)) to get big-endian PCI
> accesses if __raw_* does not work on your hardware...

It's not that "__raw_*" does not work for my hardware ... it's that __raw_*
is always wrong to use on MMIO register accesses (unless you know _exactly_ 
what you are doing, for example it may be acceptable for filling a fifo in
some cases provided the first & last writes are not __raw)

Ben.

