Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUIVBh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUIVBh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 21:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUIVBh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 21:37:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:20686 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267333AbUIVBhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 21:37:55 -0400
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <roland@topspin.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
References: <1095758630.3332.133.camel@gaston>
	 <1095761113.30931.13.camel@localhost.localdomain>
	 <1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	 <52mzzjnuq7.fsf@topspin.com>
	 <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1095816897.21231.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 11:34:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 08:16, Linus Torvalds wrote:
> On Tue, 21 Sep 2004, Roland Dreier wrote:
> > 
> > That means using __raw_writel() is pretty much guaranteed to blow up
> > on IBM pSeries (and I do care about pSeries for my driver).
> 
> Oh, that's true. And that's pretty clearly a bug, since it just means that 
> __raw_writel() can't even work in general.

Only when eeh is enabled for a device, never happens on your g5 :)

> > Maybe something like the patch below would make sense?  (Reordering of
> > code is to make sure IO_TOKEN_TO_ADDR() is defined before the
> > __raw_*() functions; eeh.h has to be included after the in_*() and
> > out_*() functions are defined)
> 
> I wonder if we could just remove the TOKEN/ADDR games. I think they were 
> done entirely as a debugging aid (but I could be wrong). In particular, 
> the compile-time type safefy should hopefully be better at finding these 
> things in the long run, and in the short run the TOKEN games have 
> obviously played their part.
> 
> I wasn't using pp64 back when, maybe there's some other reason for playing
> games with the tokens? Who's the guity/knowledgeable party? Ben?

Well, g5 will never play token games on you. I need to investigate a bit
about what's up with pSeries, in the meantim, Roland patch looks fine.

There still is that issue with __raw_* doing both barrier-less and
endianswap-less accesses though. I think there is a fundamental problem
here with drivers like matroxfb using them to get endian-less access and
losing barriers at the same time.

I'd rather have matroxfb use writel with an explicit swap, or better, the
driver could maybe disable big endian register access and switch the card
to little endian, provided it can do that while keeping the frame buffer
itself set to BE (which is necessary most of the time).

Petr ?

Ben.


