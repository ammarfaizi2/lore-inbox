Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbRAIUKN>; Tue, 9 Jan 2001 15:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbRAIUKD>; Tue, 9 Jan 2001 15:10:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26884 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130085AbRAIUJw>; Tue, 9 Jan 2001 15:09:52 -0500
Date: Tue, 9 Jan 2001 12:08:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Simon Kirby <sim@stormix.com>
cc: Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <20010109145352.A23691@stormix.com>
Message-ID: <Pine.LNX.4.10.10101091200050.2331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Simon Kirby wrote:
>
> On Tue, Jan 09, 2001 at 10:47:57AM -0800, Linus Torvalds wrote:
> 
> > And this _is_ a downside, there's no question about it. There's the worry
> > about the potential loss of locality, but there's also the fact that you
> > effectively need a bigger swap partition with 2.4.x - never mind that
> > large portions of the allocations may never be used. You still need the
> > disk space for good VM behaviour.
> > 
> > There are always trade-offs, I think the 2.4.x tradeoff is a good one.
> 
> Hmm, perhaps you could clarify...
> 
> For boxes that rarely ever use swap with 2.2, will they now need more
> swap space on 2.4 to perform well, or just boxes which don't have enough
> RAM to handle everything nicely?

If you don't have any swap, or if you run out of swap, the major
difference between 2.2.x and 2.4.x is probably going to be the oom
handling: I suspect that 2.4.x might be more likely to kill things off
sooner (but it tries to be graceful about which processes to kill).

Not having any swap is going to be a performance issue for both 2.2.x and
2.4.x - Linux likes to push inactive dirty pages out to swap where they
can lie around without bothering anybody, even if there is no _major_
memory crunch going on.

If you do have swap, but it's smaller than your available physical RAM, I
suspect that the Linux-2.4 swap pre-allocate may cause that kind of
performance degradation earlier than 2.2.x would have. Another way of
putting this: in 2.2.x you could use a fairly small swap partition to pick
up some of the slack, and in 2.4.x a really small swap-partition doesn't
really buy you much anything.

> I've always been tending to make swap partitions smaller lately, as it
> helps in the case where we have to wait for a runaway process to eat up
> all of the swap space before it gets killed.  Making the swap size
> smaller speeds up the time it takes for this to happen, albeit something
> which isn't supposed to happen anyway.

Yes, that kind of swap size tuning will still work in 2.4.x, but the sizes
you tune for would be different, I'm afraid. If you have, say, 128MB or
RAM, and you used to make a smallish partition of 64MB for "slop" in
2.2.x, I really suspect that you might like to increase it to 128MB or
196MB.

Of course, if you really only used your swap for "slop", I don't think
you'll necessarily notice the difference.

NOTE! The above guide-lines are pure guesses. The machines I use have had
big swap-partitions or none at all, so I think we'll just have to wait and
see.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
