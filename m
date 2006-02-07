Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWBGGBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWBGGBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWBGGBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:01:53 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:14560 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750941AbWBGGBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:01:51 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: implement swap prefetching
Date: Tue, 7 Feb 2006 17:02:19 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
References: <200602071028.30721.kernel@kolivas.org> <200602071502.41456.kernel@kolivas.org> <43E82979.7040501@yahoo.com.au>
In-Reply-To: <43E82979.7040501@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071702.20233.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 04:00 pm, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Tue, 7 Feb 2006 02:08 pm, Nick Piggin wrote:
> >>prefetch_get_page is doing funny things with zones and nodes / zonelists
> >>(eg. 'We don't prefetch into DMA' meaning something like 'this only works
> >>on i386 and x86-64').
> >
> > Hrm? It's just a generic thing to do; I'm not sure I follow why it's i386
> > and x86-64 only. Every architecture has ZONE_NORMAL so it will prefetch
> > there.
>
> I don't think every architecture has ZONE_NORMAL.

!ZONE_DMA they all have, no?

> >>buffered_rmqueue, zone_statistics, etc really should to stay static to
> >>page_alloc.
> >
> > I can have an even simpler version of buffered_rmqueue specifically for
> > swap prefetch, but I didn't want to reproduce code unnecessarily, nor did
> > I want a page allocator outside page_alloc.c or swap_prefetch only code
> > placed in page_alloc. The higher level page allocators do too much and
> > they test to see if we should reclaim (which we never want to do) or
> > allocate too many pages. It is the only code "cost" when swap prefetch is
> > configured off. I'm open to suggestions?
>
> If you omit __GFP_WAIT and already test the watermarks yourself it should
> be OK.

Ok.

> >>It is completely non NUMA or cpuset-aware so it will likely allocate
> >> memory in the wrong node, and will cause cpuset tasks that have their
> >> memory swapped out to get it swapped in again on other parts of the
> >> machine (ie. breaks cpuset's memory partitioning stuff).
> >>
> >>It introduces global cacheline bouncing in pagecache allocation and
> >> removal and page reclaim paths, also low watermark failure is quite
> >> common in normal operation, so that is another global cacheline write in
> >> page allocation path.
> >
> > None of these issues is going to remotely the target audience. If the
> > issue is how scalable such a change can be then I cannot advocate making
> > the code smart and complex enough to be numa and cpuset aware.. but then
> > that's never going to be the target audience. It affects a particular
> > class of user which happens to be quite a large population not affected
> > by complex memory hardware.
>
> Workstations can have 2 or more dual core CPUs with multiple threads or
> NUMA these days. Desktops and laptops will probably eventually gain more
> cores and threads too.

While I am aware of the hardware changes out there I still doubt the 
scalability issues you're concerned about affect a desktop. The code cost and 
complexity will increase substantially yet I'm not sure that will be for any 
gain to the targetted users.

> >>Why bother with the trylocks? On many architectures they'll RMW the
> >>cacheline anyway, so scalability isn't going to be much improved (or do
> >> you see big lock contention?)
> >
> > Rather than scalability concerns per se the trylock is used as yet
> > another (admittedly rarely hit) way of defining busy.
>
> They just seem to complicate the code for apparently little gain.

No biggie; I'll drop them.

> > The code is pretty aggressive at defining busy. It looks for pretty much
> > all of those and it prefetches till it stops then allowing idle to occur
> > again. Opting out of prefetching whenever there is doubt seems reasonable
> > to me.
>
> What if you want to prefetch when there is slight activity going on though?

I don't. I want this to not cost us anything during any activity.

> What if your pagecache has filled memory with useless stuff (which would
> appear to be the case with updatedb). 

There is no way the vm will ever be smart enough to say "this is crap, throw 
it out and prefetch some good stuff", so it doesn't matter.

> What if you don't want to prefetch in 
> laptop mode at all?

No problem; make it part of the laptop mode scripts to disable the sysctl.

> >>- for all its efforts, it will still interact with page reclaim by
> >>   putting pages on the LRU and causing them to be cycled.
> >>
> >>   - on bursty loads, this cycling could happen a bit. and more reads on
> >>     the swap devices.
> >
> > Theoretically yes I agree. The definition of busy is so broad that
> > prevents it prefetching that it is not significant.
>
> Not if the workload is very bursty.

It's an either/or for prefetching; I don't see a workaround, just some sane 
balance.

> >>- in a sense it papers over page reclaim problems that shouldn't be so
> >>   bad in the first place (midnight cron). On the other hand, I can see
> >>   how it solves this issue nicely.
> >
> > I doubt any audience that will care about scalability and complex memory
> > configurations would knowingly enable it so it costs them virtually
> > nothing for the relatively unintrusive code to be there. It's
> > configurable and helps a unique problem that affects most users who are
> > not in the complex hardware group. I was not advocating it being enabled
> > by default, but last time it was in -mm akpm suggested doing that to
> > increase its testing - while in -mm.
>
> If it is in core mm then I would very much like to see it adhere to how
> everything else works, and attempt to be scalable and generalised.

I'm trying.

> Any code in a core system is intrusive by definition because it simply
> adds to the amount of work that needs to be done when maintaining the
> thing or trying to understand how things work, debugging people's badly
> behaving workloads, etc.

I'm open to code suggestions and appreciate any outside help.

> If it is going to be off by default, why couldn't they
> echo 10 > /proc/sys/vm/swappiness rather than turning it on?

Because we still swap no matter what the sysctl setting is, which makes it 
even more useful in my opinion for those who aggressively set this tunable.

Thanks,
Con
