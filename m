Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVAOAcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVAOAcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVAOAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:32:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7651 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262056AbVAOAaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:30:35 -0500
Date: Fri, 14 Jan 2005 19:36:19 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator V2
Message-ID: <20050114213619.GA3336@logos.cnet>
References: <Pine.LNX.4.58.0501131552400.31154@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501131552400.31154@skynet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mel,

On Thu, Jan 13, 2005 at 03:56:46PM +0000, Mel Gorman wrote:
> The patch is against 2.6.11-rc1 and I'm willing to stand by it's
> stability. I'm also confident it does it's job pretty well so I'd like it
> to be considered for inclusion.

This is very interesting! 

Other than the advantage of decreased fragmentation which you aim, by providing 
clustering of different types of allocations you might have a performance gain (or loss :)) 
due to changes in cache colouring effects. 

It depends on the workload/application mix and type of cache of course, but I think there will be a 
significant measurable difference on most common workloads.

Physically indexed caches are going to be more influenced (since virtually indexed caches 
will only have an effect on kernel pages with your new scheme).

Have you done any investigation with that respect? IMHO such verification is really 
important before attempting to merge it.

BTW talking about cache colouring, I this is an area which has a HUGE space for improvement.
The allocator is completly unaware of colouring (except the SLAB) - we should try to 
come up with a light per-process allocation colouring optimizer. But thats another 
history.

> For me, the next stage is to write a linear scanner that goes through the
> address space to free up a high-order block of pages on demand. This will
> be a tricky job so it'll take me quite a while.

We're paving the road to implement a generic "weak" migration function on top 
of the current page migration infrastructure. With "weak" I mean that it bails
out easily if the page cannot be migrated, unlike the "strong" version which 
_has_ to migrate the page(s) (for memory hotplug purpose). 

With such function in place its easier to have different implementations of defragmentation
logic - we might want to coolaborate on that.

Your bitmap also allows a hint for the "defragmentator" to know the type of pages,
and possibly size of the block, so it can avoid earlier trying to migrate non reclaimable
memory. It possibly makes the scanning procedure much lightweight.


> Changelog since V1
> 
> o Update patch to 2.6.11-rc1
> o Cleaned up bug where memory was wasted on a large bitmap
> o Extended fallback_count bean counters to show the fallback count for each
>   allocation type
> o Better commenting
> 
> This patch divides allocations into three different types of allocations;
> 
> UserReclaimable - These are userspace pages that are easily reclaimable. Right
> 	now, I'm putting all allocations of GFP_USER and GFP_HIGHUSER as
> 	well as disk-buffer pages into this category. These pages are trivially
> 	reclaimed by writing the page out to swap or syncing with backing
> 	storage
> 
> KernelReclaimable - These are pages allocated by the kernel that are easily
> 	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
> 	These type of pages potentially could be reclaimed by dumping the
> 	caches and reaping the slabs (drastic, but you get the idea).
> 
> KernelNonReclaimable - These are pages that are allocated by the kernel that
> 	are not trivially reclaimed. For example, the memory allocated for a
> 	loaded module would be in this category. By default, allocations are
> 	considered to be of this type
> 
> Instead of having one global MAX_ORDER-sized array of free lists, there are
> three, one for each type of allocation. Finally, there is a list of pages of
> size 2^MAX_ORDER which is a global pool of the largest pages the kernel deals
> with.
> 
> Once a 2^MAX_ORDER block of pages it split for a type of allocation, it is
> added to the free-lists for that type, in effect reserving it. Hence, over
> time, pages of the different types can be clustered together. This means that
> if we wanted 2^MAX_ORDER number of pages, we could linearly scan a block of
> pages allocated for UserReclaimable and page each of them out.
> 
> Fallback is used when there are no 2^MAX_ORDER pages available and there
> are no free pages of the desired type. The fallback lists were chosen in a
> way that keeps the most easily reclaimable pages together.
>
> 
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> 
> @@ -658,7 +796,7 @@ int zone_watermark_ok(struct zone *z, in
>  {
>  	/* free_pages my go negative - that's OK */
>  	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
> -	int o;
> +	int o, type;
> 
>  	if (gfp_high)
>  		min -= min / 2;
> @@ -667,15 +805,17 @@ int zone_watermark_ok(struct zone *z, in
> 
>  	if (free_pages <= min + z->protection[alloc_type])
>  		return 0;
> -	for (o = 0; o < order; o++) {
> -		/* At the next order, this order's pages become unavailable */
> -		free_pages -= z->free_area[o].nr_free << o;
> +	for (type=0; type < ALLOC_TYPES; type++) {
> +		for (o = 0; o < order; o++) {
> +			/* At the next order, this order's pages become unavailable */
> +			free_pages -= z->free_area_lists[type][o].nr_free << o; 

You want to do 
		free_pages -= (z->free_area_lists[0][o].nr_free + z->free_area_lists[2][o].nr_free +
                		z->free_area_lists[2][o].nr_free) << o;

So not to interfere with the "min" decay (and remove the allocation type loop). 

> 
> -		/* Require fewer higher order pages to be free */
> -		min >>= 1;
> +			/* Require fewer higher order pages to be free */
> +			min >>= 1;
> 
> -		if (free_pages <= min)
> -			return 0;
> +			if (free_pages <= min)
> +				return 0;
> +		}

I'll play with your patch during the weekend, run some benchmarks (STP is our friend), 
try to measure the overhead, etc.

Congrats, this is very cool!
