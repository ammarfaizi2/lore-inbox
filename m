Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271060AbRHYTy2>; Sat, 25 Aug 2001 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271054AbRHYTyT>; Sat, 25 Aug 2001 15:54:19 -0400
Received: from www.wen-online.de ([212.223.88.39]:4871 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S271060AbRHYTyC>;
	Sat, 25 Aug 2001 15:54:02 -0400
Date: Sat, 25 Aug 2001 21:53:53 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Roger Larsson <roger.larsson@norran.net>, <linux-kernel@vger.kernel.org>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
In-Reply-To: <20010825180244Z16204-32383+1340@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108252029500.5077-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Daniel Phillips wrote:

> On August 25, 2001 10:48 am, Mike Galbraith wrote:
> > I think the easiest way to handle high order allocations is to do _low_
> > volume background reclamation if high order allocations might fail.  ie
> > put a little effort into keeping such allocations available, but don't
> > do massive effort.  Cache tends to lose it's value over time, so dumping
> > small quantities over time shouldn't hurt.
>
> Ah, time.  Please see below for an alternative way of looking at time.
>
> > This would also have the
> > benefit of scanning the inactive lists even when there's little activity
> > so that list information (page accessed _yesterday_?) won't get stale.
>
> It would probably improve the average performance somewhat.  I'm looking at a

It makes the system smoother, but doesn't change throughput much.  The
biggest effect is felt upon transition from idle launder/reclaim wise
to busy.  There, it can prevent unpleasant suprises.

> more direct approach: if we have a shortage at order(m) then, then for each
> (free) member of order(m-1) look in mem_map for its buddy, and if it doesn't
> look too active, try to free it, thus moving the allocation unit up one
> order.  Could you examine this idea please and check for obvious holes?

I don't know enough about the guts of the buddy.  Someone with stars and
moons on his pointy hat suggested checking at reclaim time to see if a
page would buddy up.. sounds the same to me.

> > I think it's ~fine to reclaim for up to say order 2, but beyond that, it
> > doesn't have any up side that I can see.. only down.
>
> Yep.
>
> > btw, I wonder why we don't do memory_pressure [+-]= 1 << order.
>
> We should, at least the "memory_pressure += 1 << order" flavor.  Patch?
>
> IMO the concept of memory pressure is bogus.  Instead we should calculate the
> number of pages to scan directly from the number of pages consumed by
> alloc_pages and the probability that deactivated pages will be rescued.  The
> latter statistic we can measure.  We can control it, too, by controlling the
> length of the inactive queue.  The shorter the inactive queue, the lower the
> probability a deactivated page will be rescued.
>
> The idea of clocking recalculate_vm_stats by real time is also bogus.  MM
> activity does not have a linear relationship to real time under most loads
> (exceptions: those loads clocked by a realtime constraint, such as network
> bandwidth on a saturated network).  We should be clocking the mm using a time
> quantum of "one page alloced".  A scan of the literature shows considerable
> support for this view, and it's also intuitive, don't you think?
>
> What this means in practice is, sure we can have kswapd wake once a second or
> once per 100 ms, but the amount of scanning it does needs to be based on the
> number of pages actually alloced in that interval.  (Intuitively, this
> corresponds to the number of free pages needed to replace those alloced.)
> >From the mm's perspective, kswapd's constant realtime interval is a variable
> delta-t in terms of mm time, meaning that we need to scale all proportional
> mm activity by the measured delta.  Hmm, clear as mud?  This is a standard
> idea from control theory.

Oh, it's much clearer than mud.. intuitive.  I did some experiments with
aging/laundering directly tied to quantity of 'unanswered' allocations
and it worked pretty well.

> BTW, what the heck is this supposed to do (page_alloc.c):
>
> 144         if (memory_pressure > NR_CPUS)
> 145                 memory_pressure--;

Keep it from going negative.

	-Mike

