Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280792AbRKTAZj>; Mon, 19 Nov 2001 19:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280801AbRKTAZU>; Mon, 19 Nov 2001 19:25:20 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:10003 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280792AbRKTAZS>; Mon, 19 Nov 2001 19:25:18 -0500
Date: Mon, 19 Nov 2001 18:25:16 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119182516.B10597@asooo.flowerfire.com>
In-Reply-To: <20011119173935.A10597@asooo.flowerfire.com> <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 19, 2001 at 03:52:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 03:52:44PM -0800, Linus Torvalds wrote:
| 
| On Mon, 19 Nov 2001, Ken Brownfield wrote:
| >
| > I went straight to the aa patch, and it looks like it either fixes the
| > problem or (because of the side-effects Linus mentioned) otherwise
| > prevents the issue:
| 
| So is this pre6aa1, or pre6 + just the watermark patch?

I'm currently using -pre6 with his separately-posted zone-watermark-1
patch.  Sorry, I should have been clearer.

| > The machine went into swap immediately when the page cache stopped
| > growing and hovered at 100-400MB.  Also, in my experience the page cache
| > will grow until there's only 5ishMB of free RAM, but with the aa patch
| > it looks like it stops at 320MB or maybe 10% of RAM.  Was that the aa
| > patch, or part of -pre6?
| 
| That was the watermarking. The way Andrea did it, the page cache will
| basically refuse to touch as much of the "normal" page zone, because it
| would prefer to allocate more from highmem..
| 
| I think it's excessive to have 320MB free memory, though, that's just
| an insane waste. I suspect that the real number should be somewhere
| between the old behaviour and the new one. You can tweak the behaviour of
| andrea's kernel by changing the "reserved" page numbers, but I'd like to
| hear whether my simpler approach works too..

Yeah, maybe a tiered default would be best, IMHO.  5MB on a 3GB box
does, on the other hand, seem anemic.

| > The Oracle SGA is set to ~522MB, with nothing else running except a
| > couple of sshds, getty, etc.  Now that I'm looking, 2.8GB page cache
| > plus 328MB free adds up to about 3.1GB of RAM -- where does the 512MB
| > shared memory segment fit?  Is it being swapped out in deference to page
| > cache?
| 
| Shared memory actually uses the page cache too, so it will be accounted
| for in the 2.8GB number.

My bad, should have realized.

| Anyway, can you try plain vanilla pre6, with the appended patch? This is
| my suggested simplified version of what Andrea tried to do, and it should
| try to keep only a few extra megs of memory free in the low memory
| regions, not 300+ MB.
| 
| (and the profiling would be interesting regardless, but I think Andrea did
| find the real problem, his fix just seems a bit of an overkill ;)
| 
| 		Linus

I'll try this patch ASAP.

Thanks a LOT to all involved,
-- 
Ken.
brownfld@irridia.com

| diff -u --recursive --new-file pre6/linux/mm/page_alloc.c linux/mm/page_alloc.c
| --- pre6/linux/mm/page_alloc.c	Sat Nov 17 19:07:43 2001
| +++ linux/mm/page_alloc.c	Mon Nov 19 15:13:36 2001
| @@ -299,29 +299,26 @@
|  	return page;
|  }
|  
| -static inline unsigned long zone_free_pages(zone_t * zone, unsigned int order)
| -{
| -	long free = zone->free_pages - (1UL << order);
| -	return free >= 0 ? free : 0;
| -}
| -
|  /*
|   * This is the 'heart' of the zoned buddy allocator:
|   */
|  struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
|  {
| +	unsigned long min;
|  	zone_t **zone, * classzone;
|  	struct page * page;
|  	int freed;
|  
|  	zone = zonelist->zones;
|  	classzone = *zone;
| +	min = 1UL << order;
|  	for (;;) {
|  		zone_t *z = *(zone++);
|  		if (!z)
|  			break;
|  
| -		if (zone_free_pages(z, order) > z->pages_low) {
| +		min += z->pages_low;
| +		if (z->free_pages > min) {
|  			page = rmqueue(z, order);
|  			if (page)
|  				return page;
| @@ -334,16 +331,18 @@
|  		wake_up_interruptible(&kswapd_wait);
|  
|  	zone = zonelist->zones;
| +	min = 1UL << order;
|  	for (;;) {
| -		unsigned long min;
| +		unsigned long local_min;
|  		zone_t *z = *(zone++);
|  		if (!z)
|  			break;
|  
| -		min = z->pages_min;
| +		local_min = z->pages_min;
|  		if (!(gfp_mask & __GFP_WAIT))
| -			min >>= 2;
| -		if (zone_free_pages(z, order) > min) {
| +			local_min >>= 2;
| +		min += local_min;
| +		if (z->free_pages > min) {
|  			page = rmqueue(z, order);
|  			if (page)
|  				return page;
| @@ -376,12 +375,14 @@
|  		return page;
|  
|  	zone = zonelist->zones;
| +	min = 1UL << order;
|  	for (;;) {
|  		zone_t *z = *(zone++);
|  		if (!z)
|  			break;
|  
| -		if (zone_free_pages(z, order) > z->pages_min) {
| +		min += z->pages_min;
| +		if (z->free_pages > min) {
|  			page = rmqueue(z, order);
|  			if (page)
|  				return page;

