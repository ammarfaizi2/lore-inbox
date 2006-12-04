Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967853AbWLDXpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967853AbWLDXpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967856AbWLDXpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:45:35 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:35900 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967853AbWLDXpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:45:34 -0500
Date: Mon, 4 Dec 2006 23:45:32 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, Andy Whitcroft <apw@shadowen.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061204143435.6ab587db.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie> <20061204143435.6ab587db.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/12/06 14:34), Andrew Morton didst pronounce:
> On Mon, 4 Dec 2006 20:34:29 +0000 (GMT)
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
> > > IOW: big-picture where-do-we-go-from-here stuff.
> > >
> > 
> > Start with lumpy reclaim,
> 
> I had lumpy-reclaim in my todo-queue but it seems to have gone away.  I
> think I need a lumpy-reclaim resend, please.
>

I believe the patches conflicted with the latest -mm and it was going through
another rebase and retest cycle.

> > then I'd like to merge page clustering piece by 
> > piece, ideally with one of the people with e1000 problems testing to see 
> > does it make a difference.
> > 
> > Assuming they are shown to help, where we'd go from there would be stuff 
> > like;
> > 
> > 1. Keep non-movable and reapable allocations at the lower PFNs as much as
> >     possible. This is so DIMMS for higher PFNs can be removed (doesn't
> >     exist)
> 
> "as much as possible" won't suffice, I suspect.  If there's any chance at
> all that a non-moveable page can land in a hot-unpluggable region then
> there will be failure scenarios.  Easy-to-hit ones, I suspect.
>

There are five situations of interest I can think of

1. Satisfying high-order allocations such as those required for e1000
2. Being able to grow the hugepage pool when the system has been running
    for any length of time
3. Offlining a SPARSEMEM section of memory
4. Offlining a DIMM
5. Offlining a Node

anti-frag + lumpy-reclaim definitly help situation 2 in the test situations
I've used. I cannot trigger situation 1 on demand but if situation 2 works
at all, I imagine situation 1 does as well.

Situation 3 used to be helped by anti-frag, particularly if a
MAX_ORDER_NR_PAGES == NUMBER_OF_PAGES_IN_A_SECTION. I was at one point
able to offline memory on an x86 although the stability left a lot to be
desired. Zones are overkill here.

For Situation 4, a zone may be needed because MAX_ORDER_NR_PAGES would have
to be set to too high for anti-frag to be effective. However, zones would
have to be tuned at boot-time and that would be an annoying restriction. If
DIMMs are being offlined for power reasons, it would be sufficient to be
best-effort.

Situation 5 requires that a hotpluggable node only allows __GFP_MOVABLE
allocations in the zonelists. This would probably involving having one
zone that only allowed __GFP_MOVABLE.

What is particularly important here is that using a zone would solve situation
3, 4 or 5 a reliable fashion but it does not help situations 1 and 2 at
all. anti-frag+lumpy-reclaim greatly improve the situation for situations
1-3. By keeping non-movable allocations at lower PFNs, situation 4 will
sometimes work but not always.

In other words, to properly address all situations, we may need anti-frag
and zones, not one or the other.

> > 2. Use page migration to compact memory rather than depending solely on
> >     reclaim (doesn't exist)
> 
> Yup.
> 
> > 3. Introduce a mechanism for marking a group of pages as being offlined so
> >     that they are not reallocated (code that does something like this
> >     exists)
> 
> yup.
> 
> > 4. Resurrect the hotplug-remove code (exists, but probably very stale)
> 
> I don't even remember what that looks like.
>

I don't fully recall either. When I last got it working though 10 months
or so ago, it wasn't in the best of shape.

What I recall is that it worked by marking a memory section as going
offline. All pages within that section were marked as under "page-capture"
and once freed, never allocated again. It would then reap caches
and reclaiming pages until the section could be marked fully offline.

> > 5. Allow allocations for hugepages outside of the pool as long as the
> >     process remains with it's locked_vm limits (patches were posted to
> >     libhugetlbfs last Friday. will post to linux-mm tomorrow).
> 
> hm.
> 
> 
> I'm not saying that we need to do memory hot-unplug immediately.  But the
> overlaps between this and anti-frag and lumpiness are sufficient that I do
> think that we need to work out how we'll implement hot-unplug, so we don't
> screw ourselves up later on.

Ok, how about this is a rough roadmap. It is mainly concerned with how to 
place pages.

1. Use lumpy-reclaim to intelligently reclaim contigous pages. The same
    logic can be used to reclaim within a PFN range
2. Merge anti-frag to help high-order allocations, hugetlbpage
    allocations and freeing up SPARSEMEM sections of memory
3. Anti-frag includes support for page flags that affected a MAX_ORDER block
    of pages. These flags can be used to mark a section of memory that should
    not be allocated from. This is of interest to both hugetlb page allocatoin
    and memory hot-remove. Use the flags to mark a MAX_ORDER_NR_PAGES that
    is currently being freed up and shouldn't be allocated. 
4. Use anti-frag fallback logic to bias unmovable allocations to the lower
    PFNs.
5. Add arch support where possible for offlining sections of memory that
    can be powered down.
6. Add arch support where possible to power down a DIMM when the memory
    sections that make it up have been offlined. This is an extenstion of
    step 5 only.
7. Add a zone that only allows __GFP_MOVABLE allocations so that
    sections can 100% be reclaimed and powered-down
8. Allow nodes to only have a zone for __GFP_MOVABLE allocations so that
    whole nodes can be offlined.

Does that make any sense?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
