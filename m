Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271045AbUJUW4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbUJUW4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbUJUWsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:48:03 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:1947 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S271055AbUJUWof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:44:35 -0400
Date: Fri, 22 Oct 2004 00:45:33 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041021224533.GB8756@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417837A7.8010908@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 08:26:47AM +1000, Nick Piggin wrote:
> Uses the zero length array which seems to be quite abundant throughout
> the tree (although maybe that also causes problems when it is by itself
> in an array?).

then we could use this on the spinlock too to drop the #ifdef. It
doesn't really matter either ways, in practice it's the same.

> @@ -108,10 +108,7 @@ struct per_cpu_pageset {
>   */
>  
>  struct zone {
> -	/*
> -	 * Commonly accessed fields:
> -	 */
> -	spinlock_t		lock;
> +	/* Fields commonly accessed by the page allocator */
>  	unsigned long		free_pages;
>  	unsigned long		pages_min, pages_low, pages_high;
>  	/*
> @@ -128,8 +125,18 @@ struct zone {
>  	 */
>  	unsigned long		protection[MAX_NR_ZONES];
>  
> +	struct per_cpu_pageset	pageset[NR_CPUS];
> +
> +	/*
> +	 * free areas of different sizes
> +	 */
> +	spinlock_t		lock;
> +	struct free_area	free_area[MAX_ORDER];
> +
> +
>  	ZONE_PADDING(_pad1_)
>  
> +	/* Fields commonly accessed by the page reclaim scanner */
>  	spinlock_t		lru_lock;	
>  	struct list_head	active_list;
>  	struct list_head	inactive_list;
> @@ -137,10 +144,8 @@ struct zone {
>  	unsigned long		nr_scan_inactive;
>  	unsigned long		nr_active;
>  	unsigned long		nr_inactive;
> -	int			all_unreclaimable; /* All pages pinned */
>  	unsigned long		pages_scanned;	   /* since last reclaim */
> -
> -	ZONE_PADDING(_pad2_)
> +	int			all_unreclaimable; /* All pages pinned */
>  
>  	/*
>  	 * prev_priority holds the scanning priority for this zone.  It is
> @@ -161,10 +166,9 @@ struct zone {
>  	int temp_priority;
>  	int prev_priority;
>  
> -	/*
> -	 * free areas of different sizes
> -	 */
> -	struct free_area	free_area[MAX_ORDER];
> +	
> +	ZONE_PADDING(_pad2_)
> +	/* Rarely used or read-mostly fields */
>  
>  	/*
>  	 * wait_table		-- the array holding the hash table
> @@ -194,10 +198,6 @@ struct zone {
>  	unsigned long		wait_table_size;
>  	unsigned long		wait_table_bits;
>  
> -	ZONE_PADDING(_pad3_)
> -
> -	struct per_cpu_pageset	pageset[NR_CPUS];
> -
>  	/*
>  	 * Discontig memory support fields.
>  	 */
> @@ -206,12 +206,13 @@ struct zone {
>  	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
>  	unsigned long		zone_start_pfn;
>  
> +	unsigned long		spanned_pages;	/* total size, including holes */
> +	unsigned long		present_pages;	/* amount of memory (excluding holes) */
> +
>  	/*
>  	 * rarely used fields:
>  	 */
>  	char			*name;
> -	unsigned long		spanned_pages;	/* total size, including holes */
> -	unsigned long		present_pages;	/* amount of memory (excluding holes) */
>  } ____cacheline_maxaligned_in_smp;

looks reasonable. only cons is that this rejects on my tree ;), pages_*
and protection is gone in my tree, replaced by watermarks[] using the
very same optimal and proven algo of 2.4 (enabled by default of course).
I'll reevaluate the false sharing later on.
