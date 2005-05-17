Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVEQSS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVEQSS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEQSS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:18:27 -0400
Received: from serv01.siteground.net ([70.85.91.68]:19350 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261271AbVEQSSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:18:13 -0400
Date: Tue, 17 May 2005 10:19:58 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
cc: akpm@osdl.org, Andy Whitcroft <apw@shadowen.org>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, shai@scalex86.org
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node
 memory alignment
In-Reply-To: <E1DY18K-0002dJ-KM@pinky.shadowen.org>
Message-ID: <Pine.LNX.4.62.0505171018560.2872@ScMPusgw>
References: <E1DY18K-0002dJ-KM@pinky.shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Andy Whitcroft wrote:

> Andrew, please consider this patch for -mm.

I agree. Forget about my patch and include this one.

> Originally __free_pages_bulk used the relative page number within
> a zone to define its buddies.  This meant that to maintain the
> "maximally aligned" requirements (that an allocation of size N will
> be aligned at least to N physically) zones had to also be aligned to
> 1<<MAX_ORDER pages.  When __free_pages_bulk was updated to use the
> relative page frame numbers of the free'd pages to pair buddies this
> released the alignment constraint on the 'left' edge of the zone.
> This allows _either_ edge of the zone to contain partial MAX_ORDER
> sized buddies.  These simply never will have matching buddies and
> thus will never make it to the 'top' of the pyramid.
> 
> The patch below removes a now redundant check ensuring that the
> mem_map was aligned to MAX_ORDER.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> 
> diffstat free_area_init_core-remove-bogus-warning
> ---
>  page_alloc.c |    4 ----
>  1 files changed, 4 deletions(-)
> 
> diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
> --- reference/mm/page_alloc.c
> +++ current/mm/page_alloc.c
> @@ -1942,7 +1942,6 @@ static void __init free_area_init_core(s
>  		unsigned long *zones_size, unsigned long *zholes_size)
>  {
>  	unsigned long i, j;
> -	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
>  	int cpu, nid = pgdat->node_id;
>  	unsigned long zone_start_pfn = pgdat->node_start_pfn;
>  
> @@ -2033,9 +2032,6 @@ static void __init free_area_init_core(s
>  		zone->zone_mem_map = pfn_to_page(zone_start_pfn);
>  		zone->zone_start_pfn = zone_start_pfn;
>  
> -		if ((zone_start_pfn) & (zone_required_alignment-1))
> -			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
> -
>  		memmap_init(size, nid, j, zone_start_pfn);
>  
>  		zonetable_add(zone, nid, j, zone_start_pfn, size);
> 
> 
> 
