Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUIVS7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUIVS7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUIVS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:59:21 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:9600 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266663AbUIVS7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:59:19 -0400
Date: Wed, 22 Sep 2004 20:58:51 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <roland@topspin.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
Message-ID: <20040922185851.GA11017@vana.vc.cvut.cz>
References: <1095758630.3332.133.camel@gaston> <1095761113.30931.13.camel@localhost.localdomain> <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com> <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org> <52mzzjnuq7.fsf@topspin.com> <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org> <1095816897.21231.32.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095816897.21231.32.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 11:34:57AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2004-09-22 at 08:16, Linus Torvalds wrote:
> 
> Well, g5 will never play token games on you. I need to investigate a bit
> about what's up with pSeries, in the meantim, Roland patch looks fine.
> 
> There still is that issue with __raw_* doing both barrier-less and
> endianswap-less accesses though. I think there is a fundamental problem
> here with drivers like matroxfb using them to get endian-less access and
> losing barriers at the same time.

Before I put __raw_* there, code was using direct *(u_int32_t*)(mmio +
reg) = value, and nobody complained... (and it worked on my PReP box).
It seems that PPC does not reorder concurrent writes targetting one
device.

> I'd rather have matroxfb use writel with an explicit swap, or better, the
> driver could maybe disable big endian register access and switch the card
> to little endian, provided it can do that while keeping the frame buffer
> itself set to BE (which is necessary most of the time).

It is due to compatibility with XFree (or at least I was told) - they want 
both framebuffer and accelerator in big-endian mode, so there is really no
choice (other than not supporting ppc...).

But of course, I can use writel(swab(...)) to get big-endian PCI
accesses if __raw_* does not work on your hardware...
							Petr Vandrovec

