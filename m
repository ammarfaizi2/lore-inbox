Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280834AbRKTDKQ>; Mon, 19 Nov 2001 22:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280839AbRKTDJ6>; Mon, 19 Nov 2001 22:09:58 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:40714 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280834AbRKTDJp>; Mon, 19 Nov 2001 22:09:45 -0500
Date: Mon, 19 Nov 2001 21:09:41 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119210941.C10597@asooo.flowerfire.com>
In-Reply-To: <20011119173935.A10597@asooo.flowerfire.com> <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 19, 2001 at 03:52:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I think you'll be pleased to hear that your untested patch
compiled, booted, _and_ fixed the problem. :)

The minimum free RAM was about 9.8-11MB (matching your guestimate) and
kswapd seemed to behave the same as the watermark patch.  The results of
top were basically the same, so I'm omitting it.

However, I do have some profiling numbers, thanks to Marcelo.  Attached
are numbers from "readprofile | sort -nr +2 | head -20".  I think the
pre4 numbers point to shrink_cache, prune_icache, and statm_pgd_range.
The other two might have significance for wizards, but statistically
don't stand out to me, except maybe statm_pgd_range.

I reset the counters just before starting Oracle and the stress test.  I
think a -pre7 with a blessed patch would be good, since my testing was
very narrow.

I'll test new kernels as I hear new info.

Thanks much!
-- 
Ken.
brownfld@irridia.com


2.4.15-pre4 with your original patch:
(shorter time period since the machine went to hell fast)
(matches vanilla behaviour)

164536 default_idle                             3164.1538
101562 shrink_cache                             113.8587
  3683 prune_icache                              13.5404
  3034 file_read_actor                           12.2339
   914 DAC960_BA_InterruptHandler                 5.5732
  1128 statm_pgd_range                            2.9072
    40 page_cache_release                         0.8333
    31 add_page_to_hash_queue                     0.5167
    89 page_cache_read                            0.4363
    25 remove_inode_page                          0.4167
    26 unlock_page                                0.3095
   509 __make_request                             0.3008
    66 smp_call_function                          0.2946
    21 set_bh_page                                0.2917
     9 __brelse                                   0.2812
    90 try_to_free_buffers                        0.2778
    13 mark_page_accessed                         0.2708
     8 __free_pages                               0.2500
    43 get_hash_table                             0.2443
    42 activate_page                              0.2234

2.4.15-pre6 with watermark patch:

1617446 default_idle                             31104.7308
 27599 DAC960_BA_InterruptHandler               168.2866
 38918 file_read_actor                          156.9274
   528 page_cache_release                        11.0000
   554 add_page_to_hash_queue                     9.2333
 15487 __make_request                             9.1531
  3453 statm_pgd_range                            8.8995
   514 remove_inode_page                          8.5667
  1453 blk_init_free_list                         7.2650
   377 set_bh_page                                5.2361
   898 page_cache_read                            4.4020
   590 add_to_page_cache_unique                   4.3382
   136 __brelse                                   4.2500
  1120 kmem_cache_alloc                           3.8356
   628 kunmap_high                                3.7381
  1189 try_to_free_buffers                        3.6698
   625 get_hash_table                             3.5511
   439 lru_cache_add                              3.4297
  1715 rmqueue                                    3.0194
   105 remove_wait_queue                          2.9167

2.4.15-pre6 with Linus patch:

1249875 default_idle                             24036.0577
 65324 file_read_actor                          263.4032
 36979 DAC960_BA_InterruptHandler               225.4817
  9809 statm_pgd_range                           25.2809
  1039 page_cache_release                        21.6458
   994 add_page_to_hash_queue                    16.5667
   922 remove_inode_page                         15.3667
  2409 blk_init_free_list                        12.0450
 20159 __make_request                            11.9143
  1198 lru_cache_add                              9.3594
  1628 page_cache_read                            7.9804
   987 add_to_page_cache_unique                   7.2574
  2202 try_to_free_buffers                        6.7963
  1038 get_unused_buffer_head                     6.6538
   484 unlock_page                                5.7619
  3182 rmqueue                                    5.6021
   874 kunmap_high                                5.2024
   164 __brelse                                   5.1250
   900 get_hash_table                             5.1136
   357 set_bh_page                                4.9583


On Mon, Nov 19, 2001 at 03:52:44PM -0800, Linus Torvalds wrote:
| 
| On Mon, 19 Nov 2001, Ken Brownfield wrote:
| >
| > I went straight to the aa patch, and it looks like it either fixes the
| > problem or (because of the side-effects Linus mentioned) otherwise
| > prevents the issue:
| 
| So is this pre6aa1, or pre6 + just the watermark patch?
| 
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
| 
| > The Oracle SGA is set to ~522MB, with nothing else running except a
| > couple of sshds, getty, etc.  Now that I'm looking, 2.8GB page cache
| > plus 328MB free adds up to about 3.1GB of RAM -- where does the 512MB
| > shared memory segment fit?  Is it being swapped out in deference to page
| > cache?
| 
| Shared memory actually uses the page cache too, so it will be accounted
| for in the 2.8GB number.
| 
| Anyway, can you try plain vanilla pre6, with the appended patch? This is
| my suggested simplified version of what Andrea tried to do, and it should
| try to keep only a few extra megs of memory free in the low memory
| regions, not 300+ MB.
| 
| (and the profiling would be interesting regardless, but I think Andrea did
| find the real problem, his fix just seems a bit of an overkill ;)
| 
| 		Linus

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

