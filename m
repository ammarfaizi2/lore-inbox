Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318050AbSGRNV0>; Thu, 18 Jul 2002 09:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSGRNV0>; Thu, 18 Jul 2002 09:21:26 -0400
Received: from dsl-213-023-043-252.arcor-ip.net ([213.23.43.252]:21192 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318050AbSGRNVZ>;
	Thu, 18 Jul 2002 09:21:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: root@chaos.analogic.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: HZ, preferably as small as possible
Date: Thu, 18 Jul 2002 15:25:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020718084908.15746A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020718084908.15746A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17VBHi-0004oH-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 14:57, Richard B. Johnson wrote:
> On Wed, 17 Jul 2002, Linus Torvalds wrote:
> > On Wed, 17 Jul 2002, Richard B. Johnson wrote:
> > >
> > > It is hardly novel and I can't imagine how Bresenham or whomever
> > > could make such a claim to the obvious. Even the DOS writer(s) used
> > > this technique to get one-second time intervals from the 18.206
> > > ticks/per second.
> > 
> > Ehh.. Look at _existing_ linux code to do exactly the same.
> > 
> > See update_wall_time_one_tick() and second_overflow() (which does a lot
> > more besides, but it does largely boil down to this "average fractions
> > using basic integer math" thing.
>
> Maybe you see something in the code I don't. In fact, the hardware
> apprears to have been programmed to interrupt at the HZ rate
> using the constant, CLOCK_TICK_RATE, defined in ../asm/timex.h.
> Maybe the hardware can't be programmed to interrupt at HZ so the
> real ticks are adjusted by 'average fractions' code, but it is
> very unclear if this is being done.
> 
> Here is a 20 year-old source snippit of some synthetic division
> code used to correct the DOS time by substituting part of INT 08.

Yes, that's the same algorithm all right, and 'synthetic division'
is a much better name for it than the one I used.  IMHO, we should be
doing this even when there happens to be an integral relationship 
between timer interrupt rate and HZ.  It eliminates a bunch of
posturing we'd otherwise be stuck with to explain/work around
restrictions in the choice of intervals.  With a little bit of head
scratching it's also possible to add the bookkeeping necessary to
handle varying physical interrupt rates, while still maintaining
the *exact* correct HZ tick count.

Stripping some cruft from your historical example:

 	SUB	WORD PTR [ACCUMULATOR],NUMERATOR
 	JNC	NO_TICK
 	MOV	AX,DIVISOR
 	ADD	WORD PTR [ACCUMULATOR],AX	; Synth div
 	CALL	TICK
NO_TICK:

Pretty hard to beat that for efficiency.

-- 
Daniel
