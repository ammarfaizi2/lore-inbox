Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUJ0C5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUJ0C5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUJ0C5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:57:00 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:63839 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261599AbUJ0C4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:56:48 -0400
Message-ID: <417F0E6C.60104@yahoo.com.au>
Date: Wed, 27 Oct 2004 12:56:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com> <20041027005425.GO14325@dualathlon.random> <20041027005637.GP14325@dualathlon.random> <20041027013522.GR14325@dualathlon.random>
In-Reply-To: <20041027013522.GR14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> this _incremental_ 2/? patch should fix the longtanding kswapd issue
> vs protection algorithm, now lowmem_reserve (partly hidden by the lack
> of lowmem_reserve/protection or equivalent band-aid enabled in 2.6.9).
> 
> --- 2-kswapd-balance/include/linux/mmzone.h.~1~	2004-10-27 03:17:07.207812600 +0200
> +++ 2-kswapd-balance/include/linux/mmzone.h	2004-10-27 03:26:22.673369000 +0200
> @@ -273,7 +273,7 @@ void __get_zone_counts(unsigned long *ac
>  void get_zone_counts(unsigned long *active, unsigned long *inactive,
>  			unsigned long *free);
>  void build_all_zonelists(void);
> -void wakeup_kswapd(struct zone *zone);
> +void wakeup_kswapd(struct zone *zone, int classzone_idx);
>  
>  /*
>   * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
> --- 2-kswapd-balance/mm/page_alloc.c.~1~	2004-10-27 03:17:07.215811384 +0200
> +++ 2-kswapd-balance/mm/page_alloc.c	2004-10-27 03:24:31.351292528 +0200
> @@ -641,7 +641,7 @@ __alloc_pages(unsigned int gfp_mask, uns
>  	}
>  
>  	for (i = 0; (z = zones[i]) != NULL; i++)
> -		wakeup_kswapd(z);
> +		wakeup_kswapd(z, classzone_idx);
>  
>  	/*
>  	 * Go through the zonelist again. Let __GFP_HIGH and allocations
> --- 2-kswapd-balance/mm/vmscan.c.~1~	2004-10-27 03:14:22.563842288 +0200
> +++ 2-kswapd-balance/mm/vmscan.c	2004-10-27 03:26:57.462080312 +0200
> @@ -1169,11 +1169,11 @@ static int kswapd(void *p)
>  /*
>   * A zone is low on free memory, so wake its kswapd task to service it.
>   */
> -void wakeup_kswapd(struct zone *zone)
> +void wakeup_kswapd(struct zone *zone, int classzone_idx)
>  {
>  	if (zone->present_pages == 0)
>  		return;
> -	if (zone->free_pages > zone->pages_low)
> +	if (zone->free_pages > zone->pages_low + zone->lowmem_reserve[classzone_idx])
>  		return;
>  	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
>  		return;

I don't think this is required, because by the time __alloc_pages
reaches wakeup_kswapd, it would have checked one zone with a
->lowmem_reserve of 0, and found it to be low on pages. Thus
wakeup_kswapd will wake it up.
