Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933390AbWKWTOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933390AbWKWTOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbWKWTOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:14:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933390AbWKWTOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:14:16 -0500
Date: Thu, 23 Nov 2006 11:09:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: mel@skynet.ie (Mel Gorman)
Cc: Andre Noll <maan@systemlinux.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-Id: <20061123110930.abc4fd9a.akpm@osdl.org>
In-Reply-To: <20061123120141.GA20920@skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
	<20061121212424.GQ5200@stusta.de>
	<200611221142.21212.ak@suse.de>
	<20061122155233.GA30607@skynet.ie>
	<20061122174223.GE27761@skl-net.de>
	<20061123120141.GA20920@skynet.ie>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 12:01:41 +0000
mel@skynet.ie (Mel Gorman) wrote:

> find_min_pfn_for_node() and find_min_pfn_with_active_regions() both depend
> on a sorted early_node_map[]. However, sort_node_map() is being called after
> fin_min_pfn_with_active_regions() in free_area_init_nodes(). In most cases,
> this is ok, but on at least one x86_64, the SRAT table caused the E820 ranges
> to be registered out of order. This gave the wrong values for the min PFN
> range resulting in some pages not being initialised.
> 
> This patch sorts the early_node_map in find_min_pfn_for_node(). It has
> been boot tested on x86, x86_64, ppc64 and ia64.
> 
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> 
> diff -rup linux-2.6.19-rc6-clean/mm/page_alloc.c linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c
> --- linux-2.6.19-rc6-clean/mm/page_alloc.c	2006-11-15 20:03:40.000000000 -0800
> +++ linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c	2006-11-23 02:23:57.000000000 -0800
> @@ -2612,6 +2612,9 @@ unsigned long __init find_min_pfn_for_no
>  {
>  	int i;
>  
> +	/* Regions in the early_node_map can be in any order */
> +	sort_node_map();
> +
>  	/* Assuming a sorted map, the first range found has the starting pfn */
>  	for_each_active_range_index_in_nid(i, nid)
>  		return early_node_map[i].start_pfn;
> @@ -2680,9 +2683,6 @@ void __init free_area_init_nodes(unsigne
>  			max(max_zone_pfn[i], arch_zone_lowest_possible_pfn[i]);
>  	}
>  
> -	/* Regions in the early_node_map can be in any order */
> -	sort_node_map();
> -
>  	/* Print out the zone ranges */
>  	printk("Zone PFN ranges:\n");
>  	for (i = 0; i < MAX_NR_ZONES; i++)

Doesn't this mean that we can sort that map multiple times?

Seems a bit ... ungainly?
