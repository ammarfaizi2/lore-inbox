Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966646AbWLDUed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966646AbWLDUed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966739AbWLDUed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:34:33 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:32964 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966646AbWLDUec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:34:32 -0500
Date: Mon, 4 Dec 2006 20:34:29 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, Andy Whitcroft <apw@shadowen.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061204113051.4e90b249.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Andrew Morton wrote:

> On Mon, 4 Dec 2006 14:07:47 +0000
> mel@skynet.ie (Mel Gorman) wrote:
>
>> o copy_strings() and variants are no longer setting the flag as the pages
>>   are not obviously movable when I took a much closer look.
>>
>> o The arch function alloc_zeroed_user_highpage() is now called
>>   __alloc_zeroed_user_highpage and takes flags related to
>>   movability that will be applied.  alloc_zeroed_user_highpage()
>>   calls __alloc_zeroed_user_highpage() with no additional flags to
>>   preserve existing behavior of the API for out-of-tree users and
>>   alloc_zeroed_user_highpage_movable() sets the __GFP_MOVABLE flag.
>>
>> o new_inode() documents that it uses GFP_HIGH_MOVABLE and callers are expected
>>   to call mapping_set_gfp_mask() if that is not suitable.
>
> umm, OK.  Could we please have some sort of statement pinning down the
> exact semantics of __GFP_MOVABLE, and what its envisaged applications are?
>

"An allocation marked __GFP_MOVABLE may be moved using either page 
migration or by paging out."

Right now, it's paging out. It isn't smart enough to use page migration. 
Bottom line, if a __GFP_MOVABLE allocation is in an awkward place, it can 
be got rid of somewhow.

> My concern is that __GFP_MOVABLE is useful for fragmentation-avoidance, but
> useless for memory hot-unplug.

Anti-fragmentation did allow SPARSEMEM sections to be off-lined when it 
was tested a long time ago so it's not useless. Where it could help 
general hotplug remove is by keeping non-movable allocations at the lower 
PFNs as much as possible.

> So that if/when hot-unplug comes along
> we'll add more gunk which is a somewhat-superset of the GFP_MOVABLE
> infrastructure, hence we didn't need the GFP_MOVABLE code.  Or something.
>

If/when hot-unplug comes along, it's going to need some way of identifying 
pages that are safe to place in a hot-unpluggable areas so you'll end up 
with something like __GFP_MOVABLE.

> That depends on how we do hot-unplug, if we do it.  I continue to suspect
> that it'll be done via memory zones: effectively by resurrecting
> GFP_HIGHMEM.  In which case there's little overlap with anti-frag.

And will introduce a zone that must be tuned at boot-time which is 
undesirable but doable. With arch-independent zone-sizing in place, it's 
considerably easier to create such a zone and then use __GFP_MOVABLE as a 
zone modifier within the allocator. I have really old patches that do 
something like this that I can bring up to date. However, that zone will 
only be usable by __GFP_MOVABLE pages and will not help the e1000 case for 
example.

On the other hand anti-frag (exists) + keeping non-movable pages at 
lowest-possible-pfn (doesn't exist yet) would allow some DIMMs to be 
unplugged without needing additional zones or tuning.

> (btw, I
> have a suspicion that the most important application of memory hot-unplug
> will be power management: destructively turning off DIMMs).
>

You're probably right.

> I'd also like to pin down the situation with lumpy-reclaim versus
> anti-fragmentation.  No offence

None taken.

>, but I would of course prefer to avoid
> merging the anti-frag patches simply based on their stupendous size. 
> It seems to me that lumpy-reclaim is suitable for the e1000 problem
>, but perhaps not for the hugetlbpage problem.

I believe you'll hit similar problems even with lumpy-reclaim for the 
e1000 (I've added Andy to the cc so he can comment more). Lumpy provides a 
much smarter way of freeing higher-order contiguous blocks without having 
to reclaim 95%+ of memory - this is good. However, if you are currently 
seeing situations where the allocations fails even after you page out 
everything possible, smarter reclaim that eventually pages out everything 
anyway will not help you (chances are it's something like page tables that 
are in your way).

This is where anti-frag comes in. It clusters pages together based on 
their type - unmovable, reapable (inode caches, short-lived kernel 
allocations, skbuffs etc) and movable. When kswapd kicks in, the slab 
caches will be reaped. As reapable pages are clustered together, that will 
free some contiguous areas - probably enough for the e1000 allocations to 
succeed!

If that doesn't work, kswapd and direct reclaim will start reclaiming the 
"movable" pages. Without lumpy reclaim, 95%+ of memory could be paged out 
which is bad. Lumpy finds the contiguous pages faster and with less IO, 
that's why it's important.

Tests I am aware of show that lumpy-reclaim on it's own makes little or no 
difference to the hugetlb page problem. However, with anti-frag, 
hugetlb-sized allocations succeed much more often even when under memory 
pressure.

> Whereas anti-fragmentation adds
> vastly more code, but can address both problems?  Or something.
>

Anti-frag goes a long way to addressing both problems. Lumpy-reclaim 
increases it's success rates under memory pressure and reduces the amount 
of reclaim that occurs.

> IOW: big-picture where-do-we-go-from-here stuff.
>

Start with lumpy reclaim, then I'd like to merge page clustering piece by 
piece, ideally with one of the people with e1000 problems testing to see 
does it make a difference.

Assuming they are shown to help, where we'd go from there would be stuff 
like;

1. Keep non-movable and reapable allocations at the lower PFNs as much as
    possible. This is so DIMMS for higher PFNs can be removed (doesn't
    exist)
2. Use page migration to compact memory rather than depending solely on
    reclaim (doesn't exist)
3. Introduce a mechanism for marking a group of pages as being offlined so
    that they are not reallocated (code that does something like this
    exists)
4. Resurrect the hotplug-remove code (exists, but probably very stale)
5. Allow allocations for hugepages outside of the pool as long as the
    process remains with it's locked_vm limits (patches were posted to
    libhugetlbfs last Friday. will post to linux-mm tomorrow).

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
