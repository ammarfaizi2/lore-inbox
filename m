Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968320AbWLEPs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968320AbWLEPs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968326AbWLEPs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:48:27 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1312 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968320AbWLEPs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:48:26 -0500
Message-ID: <457594B6.6020200@shadowen.org>
Date: Tue, 05 Dec 2006 15:48:06 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org> <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org> <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org> <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Mon, 4 Dec 2006, Andrew Morton wrote:

>> , but I would of course prefer to avoid
>> merging the anti-frag patches simply based on their stupendous size. 
>> It seems to me that lumpy-reclaim is suitable for the e1000 problem
>> , but perhaps not for the hugetlbpage problem.
> 
> I believe you'll hit similar problems even with lumpy-reclaim for the 
> e1000 (I've added Andy to the cc so he can comment more). Lumpy provides 
> a much smarter way of freeing higher-order contiguous blocks without 
> having to reclaim 95%+ of memory - this is good. However, if you are 
> currently seeing situations where the allocations fails even after you 
> page out everything possible, smarter reclaim that eventually pages out 
> everything anyway will not help you (chances are it's something like 
> page tables that are in your way).

The pre-lumpy algorithm is capable of producing reasonable numbers of 
very low order pages.  Lumpy should improve success rates producing 
sucessful reclaim at higher order than that.  Its success is limited 
however by the percentage of non-reclaimable pages and their distribution.

The e1000 problem is that it wants order=3 pages ie. 8 pages in size. 
For lumpy to have a high chance of success we would need the average 
unmovable page count to be significantly less than 1 in 8 pages 
(assuming a random distribution) (<12% pinned).  In stress testing we 
find we can reclaim of the order of 70% of memory, this tends to 
indicates that the pinned memory is more like 25% than 10%.  It would 
suggest that we are going to find reclaim rates above order=2 are poor 
without explicit placement control.

Obviously this all depends on the workload.  Our test workloads are 
known to be fairly hostile in terms of fragmentation.  So I would love 
to see lumpy tested in the problem scenario to get some data on that setup.

> This is where anti-frag comes in. It clusters pages together based on 
> their type - unmovable, reapable (inode caches, short-lived kernel 
> allocations, skbuffs etc) and movable. When kswapd kicks in, the slab 
> caches will be reaped. As reapable pages are clustered together, that 
> will free some contiguous areas - probably enough for the e1000 
> allocations to succeed!
> 
> If that doesn't work, kswapd and direct reclaim will start reclaiming 
> the "movable" pages. Without lumpy reclaim, 95%+ of memory could be 
> paged out which is bad. Lumpy finds the contiguous pages faster and with 
> less IO, that's why it's important.
> 
> Tests I am aware of show that lumpy-reclaim on it's own makes little or 
> no difference to the hugetlb page problem. However, with anti-frag, 
> hugetlb-sized allocations succeed much more often even when under memory 
> pressure.

At high order both traditional and lumpy reclaim are next to useless 
without placement controls.

> 
>> Whereas anti-fragmentation adds
>> vastly more code, but can address both problems?  Or something.
>>
> 
> Anti-frag goes a long way to addressing both problems. Lumpy-reclaim 
> increases it's success rates under memory pressure and reduces the 
> amount of reclaim that occurs.
> 
>> IOW: big-picture where-do-we-go-from-here stuff.
>>
> 
> Start with lumpy reclaim, then I'd like to merge page clustering piece 
> by piece, ideally with one of the people with e1000 problems testing to 
> see does it make a difference.
> 
> Assuming they are shown to help, where we'd go from there would be stuff 
> like;
> 
> 1. Keep non-movable and reapable allocations at the lower PFNs as much as
>    possible. This is so DIMMS for higher PFNs can be removed (doesn't
>    exist)
> 2. Use page migration to compact memory rather than depending solely on
>    reclaim (doesn't exist)
> 3. Introduce a mechanism for marking a group of pages as being offlined so
>    that they are not reallocated (code that does something like this
>    exists)
> 4. Resurrect the hotplug-remove code (exists, but probably very stale)
> 5. Allow allocations for hugepages outside of the pool as long as the
>    process remains with it's locked_vm limits (patches were posted to
>    libhugetlbfs last Friday. will post to linux-mm tomorrow).

-apw

