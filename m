Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRIBC0R>; Sat, 1 Sep 2001 22:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271550AbRIBC0G>; Sat, 1 Sep 2001 22:26:06 -0400
Received: from maile.telia.com ([194.22.190.16]:61149 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S271537AbRIBC0C>;
	Sat, 1 Sep 2001 22:26:02 -0400
Message-Id: <200109020226.f822QCS18912@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sun, 2 Sep 2001 04:21:39 +0200
X-Mailer: KMail [version 1.3]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20010901202823.303eb0eb.skraw@ithnet.com> <20010902015023Z16303-32383+2910@humbolt.nl.linux.org>
In-Reply-To: <20010902015023Z16303-32383+2910@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday den 2 September 2001 03:57, Daniel Phillips wrote:
> On September 1, 2001 08:28 pm, Stephan von Krawczynski wrote:
>
> The next part of the theory says that the higher order allocations are
> failing because of fragmentation.  I put considerable thought into this
> today while wandering around in a dungeon in Berlin watching bats (really)
> and I will post an article to lkml tomorrow with my findings.  To summarize
> briefly here: a Linux system in steady state operation *is* going to show
> physical fragmentation so that the chance of a higher order allocation
> succeeding becomes very small.  The chance of failure increases
> exponentially (or worse) with a) the allocation order and b) the ratio of
> allocated to free memory.  The second of these you can control: the higher
> you set zone->pages_min the better chance your higher order allocations
> will have to succeed.  Do you want a patch for that, to see if this works
> in practice?
>

You beat me to it, with some minutes...
(I sent a email to Stephan...)

> Of course it would be much better if we had some positive mechanism for
> defragging physical memory instead of just relying on chance and hoping
> for the best the way we do now.  IMHO, such a mechanism can be built
> practically and I'm willing to give it a try.  Basically, kswapd would try
> to restore a depleted zone order list by scanning mem_map to find buddy
> partners for free blocks of the next lower order.  This strategy, together
> with the one used in the patch above, could largly eliminate atomic
> allocation failures.  (Although as I mentioned some time ago, getting rid
> of them entirely is an impossible problem.)
>
> The question remains why we suddenly started seeing more atomic allocation
> failures in the recent Linus trees.  I'll guess that the changes in
> scanning strategy have caused the system to spend more time close to the
> zone->pages_min amount of free memory.  This idea seems to be supported by
> your memstat listings.  In some sense, it's been good to have the issue
> forced so that we must come up with ways to make atomic and higher order
> allocations less fragile.

It might be that the elevator works now... :-)

You will only see it once there are no remaining free pages of an even higher
order left - then you will start to fail...

Two things are required:
1) You have lots of memory.
2) You have used it all at some point.

Another thing to do could be to add a order parameter to free.
The pages allocated has to be freed sometime... if we make sure that
they are freed together it could simplify things - no chance that the
first part gets allocated directly...

Or/and we could remove the sources of higher order allocs, as an example:
why is the SCSI layer allowed to allocate order 3 allocs (32 kB) several
times per second? Will we really get a performance hit by not allowing
higher order allocs in active driver code?

/RogerL
-- 
Roger Larsson
Skellefteå
Sweden
