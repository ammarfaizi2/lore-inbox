Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131178AbQL3UCa>; Sat, 30 Dec 2000 15:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbQL3UCU>; Sat, 30 Dec 2000 15:02:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18442 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131178AbQL3UCR>; Sat, 30 Dec 2000 15:02:17 -0500
Date: Sat, 30 Dec 2000 11:31:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre3 and poor reponse to RT-scheduled processes?
In-Reply-To: <Pine.GSO.4.21.0012301414070.4082-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012301126420.884-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Alexander Viro wrote:
> On 30 Dec 2000, Linus Torvalds wrote:
> 
> > There are other, equally likely, candidates for these kinds of stalls:
> > 
> >  - filesystem locks. Especially the ext2 superblock lock. You can easily
> >    hit this one, as some ext2 functions actually do a lot of IO while
> >    holding the lock.
> 
> Hmm... In 2.4 we can make the situation with superblock lock on ext2
> much better.

Actually, 2.4.x right now is worse than 2.2.x in this regard, for a really
simple reason: 2.2.x will only do the equivalent of "rebalance_dirty" when
it dirties a previously clean buffer. The current 2.4.x code does that
regardless of whether the buffer was dirty before or not.

I want to see your patches to fix this for good in a 2.5.x timeframe (or,
if they are really clean and obvious, at a later 2.4.x date), but for
2.4.x I think that we'll do either "remove rebalance dirty completely" or
at the very least we'll not re-balance for re-dirtying a dirty buffer.

The re-dirtying a dirty buffer is the common case for the superblock
stuff: bitmap blocks etc are often dirty already, _especially_ in the case
of an active writer. So 2.4.x is actually more likely to hit the
superblock/bdflush contention.

Of course, 2.4.x has had so many improvements in file writing memory
pressure that it might not end up being that noticeable, but even so..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
