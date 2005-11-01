Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVKAB2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVKAB2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKAB2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:28:16 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:58246 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964916AbVKAB2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:28:15 -0500
Date: Tue, 1 Nov 2005 01:28:07 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <4366AE98.7000100@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511010017170.29390@skynet>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
 <20051031055725.GA3820@w-mikek2.ibm.com> <4365BBC4.2090906@yahoo.com.au>
 <20051030235440.6938a0e9.akpm@osdl.org> <4365C39F.2080006@yahoo.com.au>
 <Pine.LNX.4.58.0510311250170.29390@skynet> <4366AE98.7000100@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Nick Piggin wrote:

> Mel Gorman wrote:
>
> > I recall Rohit's patch from an earlier -mm. Without knowing anything about
> > his test, I am guessing he is getting cheap page colouring by preloading
> > the per-cpu cache with contiguous pages and his workload is faulting in
> > the batch of pages immediately by doing something like linearly reading a
> > large array. Hence, the mappings of his workload are getting the right
> > colour pages. This makes his workload a "lucky"  workload. The general
> > benefit of preloading the percpu magazines is that there is a chance the
> > allocator only has to be called once, not pcp->batch times.
> >
>
> Or we could introduce a new allocation mechanism for anon pages that
> passes the vaddr to the allocator, and tries to get an odd/even page
> according to the vaddr.
>

We could, but it is a different problem than what this set of patches are
trying to address. I'll add page colouring to the end of the todo list in
case I get stuck for something to do.

> > An odd/even allocation scheme could be provided by having two free_lists
> > in a free_area. One list for the "left buddy" and the other list for the
> > "right buddy". However, at best, that would provide two colours. I'm not
> > sure how much benefit it would give for the cost of more linked lists.
> >
>
> 2 colours should be a good first order improvement because you will
> no longer have adjacent pages of the same colour.
>
> It would definitely be cheaper than fragmentation avoidance + higher
> order batch loading.
>

Ok, but the page colours would also need to be in the per-cpu lists this
new api that supplies vaddrs always takes the spinlock for the free lists.
I don't believe it would be cheaper and any benefit would only show up on
benchmarks that are cache sensitive. Judging by previous discussions on
page colouring in the mail archives, Linus will happily kick the approach
full of holes.

As for current performance, the Aim9 benchmarks show that the
fragmentation avoidance does not have a major performance penalty. A run
of the patches in the -mm tree should find out if there are performance
regressions on other machine types.

>
> > To replicate the functionality of these patches with zones would require
> > two additional zones for NormalEasy and HighmemEasy (I suck at naming
> > things).  The plus side is that once the zone fallback lists are updated,
> > the page allocator remains more or less the same as it is today. Then the
> > headaches start.
> >
> > Problem 1: Zone fallback lists are "one-way" and per-node. Lets assume a
> > fallback list of HighMemEasy, HighMem, NormalEasy, Normal, DMA. Assuming
> > we are allocating PTEs from high memory, we could fallback to the Normal
> > zone even if highmem pages are available because the HighMem zone was out
> > of pages. It will require very different fallback logic to say that
> > HighMem allocations can also use HighMemEasy rather than falling back to
> > Normal.
> >
>
> Just be a different set of GFP flags. Your patches obviously also have
> some ordering imposed.... pagecache would want HighMemEasy, HighMem,
> NormalEasy, Normal, DMA; ptes will want HighMem, Normal, DMA.
>

As well as a different set of GFP flags, we would also need new zone
fallback logic which will hit the __alloc_pages() path. It will be adding
more complexity to the allocator and we're replacing one type of
complexity with another.

> Note that if you do need to make some changes to the zone allocator, then
> IMO that is far preferable to add a new layer of things-that-are-blocks-of-
> -memory-but-not-zones, complete with their own balancing and other heuristics.
>

Thing is, with my approach, the very worst that happens is that it
fragments just as bad as the normal allocator. With a zone-based approach,
the worst that happens is that the kernel zone is too small, kernel caches
do not grow to a suitable size and overall system performance degrades.

> > Problem 2: Setting the zone size will be a very difficult tunable to get
> > right.  Right off, we are are introducing a tunable which will make
> > foreheads furrow. If the tunable is set wrong, system performance will
> > suffer and we could see situations where kernel allocations fail because
> > it's zone got depleted.
> >
>
> But even so, when you do automatic resizing, you seem to be adding a
> fundamental weak point in fragmentation avoidance.
>

The sizing I do is when a large block is split. Then the region is just
marked for a particular allocation type. This is very simple. The second
resizing that occurs is when a kernel allocation "steal" easyrclm pages. I
do not like the fact that we steal in this fashion but the alternative is
to teach kswapd how to reclaim easyrclm pages from other areas. I view
this as "future work" but if it was done, the "steal" mechanism would go
away.

> > Problem 3: To get rid of the tunable, we could try resizing the zones
> > dynamically but that will be hard. Obviously, the zones are going to be
> > physically adjacent to each other. To resize the zone, the pages at one
> > end of the zone will need to be free. Shrinking the NormalEasy zone would
> > be easy enough, but shrinking the Normal zone with kernel pages in it
> > would be considerably harder, if not outright impossible. One page in the
> > wrong place will mean the zone cannot be resized
> >
>
> OK, maybe it is hard ;) Do they really need to be resized, then?
>

I think we would need to, yes. If the size of the region is wrong, bad
things are likely to happen. If the kernel page zone is too small, it'll
be under pressure even though there is memory available elsewhere. If it's
too large, then it will get fragmented and high order allocations will
fail.

> Isn't the big memory hotunplug push aimed at virtual machines and
> hypervisors anyway? In which case one would presumably have some
> memory that "must" be reclaimable, in which case we can't expand
> non-Easy zones into that memory anyway.
>

I believe that is the case for hotplug all right, but not the case where
we just want to satisfy high order allocations in a reasonably reliable
fashion. In that case, it would be nice to reclaim an easyrclm region.

It has already been reported by Mike Kravetz that memory remove works a
whole lot better on PPC64 with this patch than without it. Memory hotplug
remove was not the problem I was trying to solve, but I consider the fact
that it is helped to be a big plus. So, even though it is possible that
this approach still gets fragmented under some workloads, we know that, in
general, it does a pretty good job.

> > Problem 4: Page reclaim would have two new zones to deal with bringing
> > with it a new set of zone balancing problems. That brings it's own special
> > brand of fun.
> >
> > There may be more problems but these 4 are fairly important. This patchset
> > does not suffer from the same problems.
> >
>
> If page reclaim can't deal with 5 zones then it is going to have problems
> somewhere at 3 and needs to be fixed. I don't see how your patches get
> around this fun by simply introducing their own balancing and fallback
> heuristics.
>

If my approach gets the sizes of areas all wrong, it will fragment. If the
zone-based approach gets the sizes of areas wrong, system performance
degrades. I prefer the failure scenario of my approach :).

> > Problem 1: This patchset has a fallback list for each allocation type. So
> > EasyRclm allocations can just as easily use an area reserved for kernel
> > allocations and vice versa. Obviously we don't like when this happens, but
> > when it does, things start fragmenting rather than breaking.
> >
> > Problem 2: The number of pages that get reserved for each type grows and
> > shrinks on demand. There is no tunable and no need for one.
> >
> > Problem 3: Problem doesn't exist for this patchset
> >
> > Problem 4: Problem doesn't exist for this patchset.
> >
> > Bottom line, using zones will be more complex than this set of patches and
> > bring a lot of tricky issues with it.
> >
>
> Maybe zones don't do exactly what you need, but I think they're better
> than you think ;)
>

You may be right, but I still think that my approach is simpler and less
likely to introduce horrible balancing problems.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
