Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVKGUaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVKGUaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbVKGUaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:30:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:52125 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965162AbVKGU37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:29:59 -0500
Date: Mon, 7 Nov 2005 13:28:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] vm: kswapd incmin
Message-ID: <20051107152816.GA17246@logos.cnet>
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4366FAF5.8020908@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Looks nice, much easier to read than before.

One comment: you change the pagecache/slab scanning ratio by moving
shrink_slab() outside of the zone loop. 

This means that for each kswapd iteration will scan "lru_pages" 
SLAB entries, instead of "lru_pages*NR_ZONES" entries.

Can you comment on that?

On Tue, Nov 01, 2005 at 04:19:49PM +1100, Nick Piggin wrote:
> 1/3
> 
> -- 
> SUSE Labs, Novell Inc.
> 

> Explicitly teach kswapd about the incremental min logic instead of just scanning
> all zones under the first low zone. This should keep more even pressure applied
> on the zones.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> 
> Index: linux-2.6/mm/vmscan.c
> ===================================================================
> --- linux-2.6.orig/mm/vmscan.c	2005-11-01 13:42:33.000000000 +1100
> +++ linux-2.6/mm/vmscan.c	2005-11-01 14:27:16.000000000 +1100
> @@ -1051,97 +1051,63 @@ loop_again:
>  	}
>  
>  	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
> -		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
>  		unsigned long lru_pages = 0;
> +		int first_low_zone = 0;
>  
>  		all_zones_ok = 1;
> +		sc.nr_scanned = 0;
> +		sc.nr_reclaimed = 0;
> +		sc.priority = priority;
> +		sc.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
>  
> -		if (nr_pages == 0) {
> -			/*
> -			 * Scan in the highmem->dma direction for the highest
> -			 * zone which needs scanning
> -			 */
> -			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
> -				struct zone *zone = pgdat->node_zones + i;
> +		/* Scan in the highmem->dma direction */
> +		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
> +			struct zone *zone = pgdat->node_zones + i;
>  
> -				if (zone->present_pages == 0)
> -					continue;
> +			if (zone->present_pages == 0)
> +				continue;
>  
> -				if (zone->all_unreclaimable &&
> -						priority != DEF_PRIORITY)
> +			if (nr_pages == 0) {	/* Not software suspend */
> +				if (zone_watermark_ok(zone, order,
> +					zone->pages_high, first_low_zone, 0, 0))
>  					continue;
>  
> -				if (!zone_watermark_ok(zone, order,
> -						zone->pages_high, 0, 0, 0)) {
> -					end_zone = i;
> -					goto scan;
> -				}
> +				all_zones_ok = 0;
> +				if (first_low_zone < i)
> +					first_low_zone = i;
>  			}
> -			goto out;
> -		} else {
> -			end_zone = pgdat->nr_zones - 1;
> -		}
> -scan:
> -		for (i = 0; i <= end_zone; i++) {
> -			struct zone *zone = pgdat->node_zones + i;
> -
> -			lru_pages += zone->nr_active + zone->nr_inactive;
> -		}
> -
> -		/*
> -		 * Now scan the zone in the dma->highmem direction, stopping
> -		 * at the last zone which needs scanning.
> -		 *
> -		 * We do this because the page allocator works in the opposite
> -		 * direction.  This prevents the page allocator from allocating
> -		 * pages behind kswapd's direction of progress, which would
> -		 * cause too much scanning of the lower zones.
> -		 */
> -		for (i = 0; i <= end_zone; i++) {
> -			struct zone *zone = pgdat->node_zones + i;
> -			int nr_slab;
> -
> -			if (zone->present_pages == 0)
> -				continue;
>  
>  			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
>  				continue;
>  
> -			if (nr_pages == 0) {	/* Not software suspend */
> -				if (!zone_watermark_ok(zone, order,
> -						zone->pages_high, end_zone, 0, 0))
> -					all_zones_ok = 0;
> -			}
>  			zone->temp_priority = priority;
>  			if (zone->prev_priority > priority)
>  				zone->prev_priority = priority;
> -			sc.nr_scanned = 0;
> -			sc.nr_reclaimed = 0;
> -			sc.priority = priority;
> -			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
> +			lru_pages += zone->nr_active + zone->nr_inactive;
> +
>  			atomic_inc(&zone->reclaim_in_progress);
>  			shrink_zone(zone, &sc);
>  			atomic_dec(&zone->reclaim_in_progress);
> -			reclaim_state->reclaimed_slab = 0;
> -			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
> -						lru_pages);
> -			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
> -			total_reclaimed += sc.nr_reclaimed;
> -			total_scanned += sc.nr_scanned;
> -			if (zone->all_unreclaimable)
> -				continue;
> -			if (nr_slab == 0 && zone->pages_scanned >=
> +
> +			if (zone->pages_scanned >=
>  				    (zone->nr_active + zone->nr_inactive) * 4)
>  				zone->all_unreclaimable = 1;
> -			/*
> -			 * If we've done a decent amount of scanning and
> -			 * the reclaim ratio is low, start doing writepage
> -			 * even in laptop mode
> -			 */
> -			if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
> -			    total_scanned > total_reclaimed+total_reclaimed/2)
> -				sc.may_writepage = 1;
>  		}
> +		reclaim_state->reclaimed_slab = 0;
> +		shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
> +		sc.nr_reclaimed += reclaim_state->reclaimed_slab;
> +		total_reclaimed += sc.nr_reclaimed;
> +		total_scanned += sc.nr_scanned;
> +
> +		/*
> +		 * If we've done a decent amount of scanning and
> +		 * the reclaim ratio is low, start doing writepage
> +		 * even in laptop mode
> +		 */
> +		if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
> +		    total_scanned > total_reclaimed+total_reclaimed/2)
> +			sc.may_writepage = 1;
> +
>  		if (nr_pages && to_free > total_reclaimed)
>  			continue;	/* swsusp: need to do more work */
>  		if (all_zones_ok)
> @@ -1162,7 +1128,6 @@ scan:
>  		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
>  			break;
>  	}
> -out:
>  	for (i = 0; i < pgdat->nr_zones; i++) {
>  		struct zone *zone = pgdat->node_zones + i;
>  

