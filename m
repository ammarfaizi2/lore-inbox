Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUFYWYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUFYWYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266715AbUFYWYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:24:41 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:61188 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S263448AbUFYWYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:24:38 -0400
Date: Fri, 25 Jun 2004 15:27:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [PATCH] convert uses of ZONE_HIGHMEM to is_highmem
Message-Id: <20040625152711.60fa7ee1.akpm@digeo.com>
In-Reply-To: <200406252203.i5PM3m6s031728@voidhawk.shadowen.org>
References: <200406252203.i5PM3m6s031728@voidhawk.shadowen.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 22:24:18.0176 (UTC) FILETIME=[27AAF000:01C45B03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> As the comments in mmzone.h indicate is_highmem() is designed to
> reduce the proliferation of the constant ZONE_HIGHMEM.  This patch
> updates three references to ZONE_HIGHMEM to use is_highmem().
> None appear to be on critical paths.
> 
> Revision: $Rev: 305 $ 
> 
>  void __init set_highmem_pages_init(int bad_ppro) 
>  {
>  #ifdef CONFIG_HIGHMEM
> -	int nid;
> +	struct zone *zone;
>  
> -	for (nid = 0; nid < numnodes; nid++) {
> +	for_each_zone(zone) {
>  		unsigned long node_pfn, node_high_size, zone_start_pfn;
>  		struct page * zone_mem_map;
>  		
> -		node_high_size = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].spanned_pages;
> -		zone_mem_map = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_mem_map;
> -		zone_start_pfn = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_pfn;
> +		if (!is_highmem(zone))
> +			continue;
> +
> +		printk("Initializing %s for node %d\n", zone->name,
> +			zone->zone_pgdat->node_id);
> +
> +		node_high_size = zone->spanned_pages;
> +		zone_mem_map = zone->zone_mem_map;
> +		zone_start_pfn = zone->zone_start_pfn;
>  
> -		printk("Initializing highpages for node %d\n", nid);
>  		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
>  			one_highpage_init((struct page *)(zone_mem_map + node_pfn),
>  					  zone_start_pfn + node_pfn, bad_ppro);

Fair enough.

> @@ -930,11 +930,12 @@ unsigned int nr_free_pagecache_pages(voi
>  #ifdef CONFIG_HIGHMEM
>  unsigned int nr_free_highpages (void)
>  {
> -	pg_data_t *pgdat;
> +	struct zone *zone;
>  	unsigned int pages = 0;
>  
> -	for_each_pgdat(pgdat)
> -		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
> +	for_each_zone(zone)
> +		if (is_highmem(zone))
> +			pages += zone->free_pages;

but that's slower.

