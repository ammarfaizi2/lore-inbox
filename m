Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSEYRyf>; Sat, 25 May 2002 13:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSEYRyf>; Sat, 25 May 2002 13:54:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26637 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315170AbSEYRyd>; Sat, 25 May 2002 13:54:33 -0400
Date: Sat, 25 May 2002 10:54:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Brownell <david-b@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
In-Reply-To: <3CEFC6A3.6080002@pacbell.net>
Message-ID: <Pine.LNX.4.44.0205251049380.6515-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, David Brownell wrote:
>
> Seems to me it'd be worth mentioning this issue somewhere in the
> documentation or source.  One could get the impression that the
> main issue for a CardBus-enabled PCI driver is to make sure that
> the "new style" driver APIs -- with a DEVICE_TABLE etc -- are used.
> (Maybe just a brief comment in <asm/io.h> ...)

Documentation might be a good thing, indeed. I doubt <asm/io.h> is the
right place for it, people tend to look at other drivers etc to pattern
after (as clearly showed by how often a bug in one place is replicated in
lots of other places ;)

We've actually fixed a number of these things - there are drivers that
notice removal on their own silently, and just turn it into a no-op.

> I'm hardly averse to changing that loop (which normally does have an end :)
> and I expected to need to at some point.  It's interesting to me just how
> long that has been there without causing problems.  In this case the root
> cause is that Cardbus "improper shutdown sequence" problem, so "no end"
> is just a particularly nasty secondary failure mode.

Most people don't unplug their devices while they are in use, and on
cardbus the most common case ends up (I think) being the fact that the
cardbus PCI static interrupt itself is shared with the device interrupt.
So what happens is that when you remove the CardBus card, that causes the
cardbus controller to send an interrupt (for removal), but since that
interrupt is shared with the card driver, the card driver also sees the
interrupt even if the card itself is otherwise idle.

This meant that some tulip cards at least were _guaranteed_ to lock up
some time ago, simply because their interrupt handler would loop forever
on seeing the "more work" bit continually (all bits in the status register
were set due to the removal and floating data lines).

		Linus

