Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760371AbWLFJb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760371AbWLFJb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760376AbWLFJb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:31:28 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:37000 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760371AbWLFJb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:31:27 -0500
Date: Wed, 6 Dec 2006 09:31:25 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <Pine.LNX.4.64.0612051521060.20570@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612060903161.7238@skynet.skynet.ie>
References: <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
 <20061204120611.4306024e.akpm@osdl.org> <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
 <20061204131959.bdeeee41.akpm@osdl.org> <Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com>
 <20061204142259.3cdda664.akpm@osdl.org> <Pine.LNX.4.64.0612050754560.11213@schroedinger.engr.sgi.com>
 <20061205112541.2a4b7414.akpm@osdl.org> <Pine.LNX.4.64.0612051159510.18687@schroedinger.engr.sgi.com>
 <20061205214721.GE20614@skynet.ie> <Pine.LNX.4.64.0612051521060.20570@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Christoph Lameter wrote:

> On Tue, 5 Dec 2006, Mel Gorman wrote:
>
>> There are times you want to reclaim just part of a zone - specifically
>> satisfying a high-order allocations. See sitations 1 and 2 from elsewhere
>> in this thread. On a similar vein, there will be times when you want to
>> migrate a PFN range for similar reasons.
>
> This is confusing reclaim with defragmentation.

No, I'm not. What is important is the objective.

Objective: Get contiguous block of free pages
Required: Pages that can move
Move means: Migrating them or reclaiming
How we do it for high-order allocations: Take a page from the LRU, move
 	the pages within that high-order block
How we do it for unplug: Take the pages within the range of interest, move
 	all the pages out of that range

In both cases, you are taking a subsection of a zone and doing something 
to it. In the beginning, we'll be reclaiming because it's easier and it's 
relatively well understood. Once stable, then work can start on defrag 
properly.

> I think we are in
> conceptually unclean territory because we mix the two. If you must use
> reclaim to get a portion of contiguous memory free then yes we have this
> problem.

The way I see it working is that defragmentation is a kernel thread starts 
compacting memory (possibly kswapd) when external fragmentation gets above 
a watermark. This is to avoid multiple defragment processes migrating into 
each others area of interest which would be locking hilarity. When a 
process fails to allocate a high-order block, it's because defragmentation 
was ineffective, probably due to low memory, and it enters direct reclaim 
as normal - just like a process enters direct reclaim because kswapd was 
not able to keep enough free memory.

> If you can migrate pages then no there is no need for reclaiming
> a part of a zone. You can occasionally shuffle pages around to
> get a large continous chunk. If there is not enough memory then an
> independent reclaim subsystem can take care of freeing a sufficient amount
> of memory. Marrying the two seems to be getting a bit complex and maybe
> very difficult to get right.
>

I don't intend to marry the two. However, I intend to handle reclaim first 
because it's needed whether defrag exists or not.

> The classification of the memory allocations is useful
> to find a potential starting point to reduce the minimum number of pages
> to move to open up that hole.
>

Agreed.

>>> Why would one want to allocate from the 1/4th of a zone? (Are we still
>>> discussing Mel's antifrag scheme or what is this about?)
>> Because you wanted contiguous blocks of pages.  This is related to anti-frag
>> because with anti-frag, reclaiming memory or migration memory will free up
>> contiguous blocks. Without it, you're probably wasting your time.
>
> I am still not sure how this should work. Reclaim in a portion of the
> reclaimable/movable portion of the zone? Or pick a huge page and simply
> reclaim all the pages in that range?
>

Reclaim in a portion of the reclaimable/movable portion of the zone by;

1. Take a leader page from the LRU lists
2. Move the pages within that order-aligned block

> This is required for anti-frag regardless of additonal zones right?
>

Right.

> BTW If one would successfully do this partial reclaim thing then we also
> have no need anymore DMA zones because we can free up memory in the DMA
> area of a zone at will if we run short on memory there.
>

Possibly, but probably not. As well as providing an easy way to reclaim 
within a PFN range and have range-specific LRU lists, zones help keep 
pages from a PFN range that could have used a different PFN range. If the 
DMA range got filled with kmalloc() slab pages that could have been 
allocated from ZONE_NORMAL, directed reclaim won't help you.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
