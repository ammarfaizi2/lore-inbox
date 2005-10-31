Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVJaQTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVJaQTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVJaQTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:19:35 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:61912 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932442AbVJaQTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:19:34 -0500
Date: Mon, 31 Oct 2005 16:19:18 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <4365C39F.2080006@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0510311250170.29390@skynet>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
 <20051031055725.GA3820@w-mikek2.ibm.com> <4365BBC4.2090906@yahoo.com.au>
 <20051030235440.6938a0e9.akpm@osdl.org> <4365C39F.2080006@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Nick Piggin wrote:

> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > > Despite what people were trying to tell me at Ottawa, this patch
> > > set really does add quite a lot of complexity to the page
> > > allocator, and it seems to be increasingly only of benefit to
> > > dynamically allocating hugepages and memory hot unplug.
> >
> >
> > Remember that Rohit is seeing ~10% variation between runs of scientific
> > software, and that his patch to use higher-order pages to preload the
> > percpu-pages magazines fixed that up.  I assume this means that it provided
> > up to 10% speedup, which is a lot.
> >
>
> OK, I wasn't aware of this. I wonder what other approaches we could
> try to add a bit of colour to our pages? I bet something simple like
> trying to hand out alternate odd/even pages per task might help.
>

Reading through the kernel archives, it appears that any page colouring
scheme was getting rejected because it slowed up workloads like kernel
compilers that were not very cache sensitive. Where an approach didn't
suffer from that problem, there was disagreement over whether there was a
general performance improvement or not.

I recall Rohit's patch from an earlier -mm. Without knowing anything about
his test, I am guessing he is getting cheap page colouring by preloading
the per-cpu cache with contiguous pages and his workload is faulting in
the batch of pages immediately by doing something like linearly reading a
large array. Hence, the mappings of his workload are getting the right
colour pages. This makes his workload a "lucky"  workload. The general
benefit of preloading the percpu magazines is that there is a chance the
allocator only has to be called once, not pcp->batch times.

An odd/even allocation scheme could be provided by having two free_lists
in a free_area. One list for the "left buddy" and the other list for the
"right buddy". However, at best, that would provide two colours. I'm not
sure how much benefit it would give for the cost of more linked lists.

> > gigE Tx buffer allocation failures, so I dropped it.
> >
> > We think that Mel's patches will allow us to reintroduce Rohit's
> > optimisation.
> >
> >
> > > If that is the case, do we really want to make such sacrifices
> > > for the huge machines that want these things? What about just
> > > making an extra zone for easy-to-reclaim things to live in?
> > >
> > > This could possibly even be resized at runtime according to
> > > demand with the memory hotplug stuff (though I haven't been
> > > following that).
> > >
> > > Don't take this as criticism of the actual implementation or its
> > > effectiveness.
> > >
> >
> >
> > But yes, adding additional complexity is a black mark, and these patches
> > add quite a bit.  (Ditto the fine-looking adaptive readahead patches, btw).
> >
>
> They do look quite fine. They seem to get their claws pretty deep
> into page reclaim, but I guess that is to be expected if we want
> to increase readahead smarts much more.
>
> However, I'm hoping bits of that can be merged at a time, and
> interfaces and page reclaim stuff can be discussed and the best
> option taken. No such luck with these patches AFAIKS - simply
> adding another level of page groups, and another level of
> heuristics to the page allocator is going to hurt. By definition.
> I do wonder why zones can't be used... though I'm sure there are
> good reasons.
>

Granted, the patch set does add complexity even though I tried to keep it
as simple as possible. Benchmarks were posted with each patchset to show
that it was not suffering in real performance even if the code is a bit
less approachable.

Doing something similar with zones is an old idea and brought up
specifically for memory hotplug. In implementations, the zone was called
ZONE_HOTREMOVABLE or something similar. In my opinion, replicating the
effect of this set of patches with zones introduces it's own set of
headaches and ends up being far more complicated. Hopefully, someone will
point out if I am missing historical context here, am rehashing old
arguments or am just plain wrong :)

To replicate the functionality of these patches with zones would require
two additional zones for NormalEasy and HighmemEasy (I suck at naming
things).  The plus side is that once the zone fallback lists are updated,
the page allocator remains more or less the same as it is today. Then the
headaches start.

Problem 1: Zone fallback lists are "one-way" and per-node. Lets assume a
fallback list of HighMemEasy, HighMem, NormalEasy, Normal, DMA. Assuming
we are allocating PTEs from high memory, we could fallback to the Normal
zone even if highmem pages are available because the HighMem zone was out
of pages. It will require very different fallback logic to say that
HighMem allocations can also use HighMemEasy rather than falling back to
Normal.

Problem 2: Setting the zone size will be a very difficult tunable to get
right.  Right off, we are are introducing a tunable which will make
foreheads furrow. If the tunable is set wrong, system performance will
suffer and we could see situations where kernel allocations fail because
it's zone got depleted.

Problem 3: To get rid of the tunable, we could try resizing the zones
dynamically but that will be hard. Obviously, the zones are going to be
physically adjacent to each other. To resize the zone, the pages at one
end of the zone will need to be free. Shrinking the NormalEasy zone would
be easy enough, but shrinking the Normal zone with kernel pages in it
would be considerably harder, if not outright impossible. One page in the
wrong place will mean the zone cannot be resized

Problem 4: Page reclaim would have two new zones to deal with bringing
with it a new set of zone balancing problems. That brings it's own special
brand of fun.

There may be more problems but these 4 are fairly important. This patchset
does not suffer from the same problems.

Problem 1: This patchset has a fallback list for each allocation type. So
EasyRclm allocations can just as easily use an area reserved for kernel
allocations and vice versa. Obviously we don't like when this happens, but
when it does, things start fragmenting rather than breaking.

Problem 2: The number of pages that get reserved for each type grows and
shrinks on demand. There is no tunable and no need for one.

Problem 3: Problem doesn't exist for this patchset

Problem 4: Problem doesn't exist for this patchset.

Bottom line, using zones will be more complex than this set of patches and
bring a lot of tricky issues with it.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
