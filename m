Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWBQPui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWBQPui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBQPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:50:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54926 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751506AbWBQPug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:50:36 -0500
Subject: Re: [PATCH: 003/012] Memory hotplug for new nodes v.2. (Wait table
	and zonelists initalization)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <20060217211336.406E.Y-GOTO@jp.fujitsu.com>
References: <20060217211336.406E.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 07:49:58 -0800
Message-Id: <1140191398.21383.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 22:28 +0900, Yasunori Goto wrote:
> include/linux/mmzone.h
> mm/memory_hotplug.c
> include/linux/memory_hotplug.h'
> 
> 
> This patch is to initialize wait table and zonelists for new pgdat.
> When new node is added, free_area_init_node() is called to initialize
> pgdat. But, wait table must be allocated by kmalloc (not bootmem) for it.
> And, zonelists is accessed from any other process every time,
> So, stop_machine_run() is used for safety update.
> 
> 
>  Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

I have _not_ signed off on these patches.  I understand you based the
initial code from one of my patches, but please remove my signed-off-by,
as I think they code has diverged sufficiently from mine.

>  Signed-off-by: Hiroyuki Kamezawa <kamezawa.hiroyu@jp.fujitsu.com>
>  Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
> 
> 
> Index: pgdat3/mm/page_alloc.c
> ===================================================================
> --- pgdat3.orig/mm/page_alloc.c	2006-02-17 16:52:50.000000000 +0900
> +++ pgdat3/mm/page_alloc.c	2006-02-17 18:41:52.000000000 +0900
> @@ -37,6 +37,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mempolicy.h>
> +#include <linux/stop_machine.h>
>  
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> @@ -2077,18 +2078,35 @@ void __init setup_per_cpu_pageset(void)
>  static __meminit
>  void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
>  {
> -	int i;
> +	int i, hotadd = (system_state == SYSTEM_RUNNING);
>  	struct pglist_data *pgdat = zone->zone_pgdat;
>  
>  	/*
>  	 * The per-page waitqueue mechanism uses hashed waitqueues
>  	 * per zone.
>  	 */
> -	zone->wait_table_size = wait_table_size(zone_size_pages);
> -	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
> -	zone->wait_table = (wait_queue_head_t *)
> -		alloc_bootmem_node(pgdat, zone->wait_table_size
> -					* sizeof(wait_queue_head_t));
> +	if (hotadd){
> +		unsigned long size = 4096UL; /* Max size */

Where does this come from?

> +		wait_queue_head_t *p;
> +
> +		while (size){
> +			p = kmalloc(size * sizeof(wait_queue_head_t),
> +				    GFP_ATOMIC);
> +			if (p)
> +				break;
> +			size >>= 1;
> +		}

Huh?  Trying to allocate the largest wait queue that kmalloc will let
you?

Don't we want to base the wait queue size on something devised at
runtime?  If we make a bad guess here, how is it fixed later?

I think this is an issue for existing hot-add, but I haven't thought
about it quite enough.
>  
>  	for(i = 0; i < zone->wait_table_size; ++i)
>  		init_waitqueue_head(zone->wait_table + i);
> @@ -2126,6 +2144,7 @@ static __meminit void init_currently_emp
>  	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
>  
>  	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
> +	zone->spanned_pages = size;
>  }

What is this hunk?  Trying to sneak something in? ;)

We already set this variable in free_area_init_core() and
grow_zone_span().  Why are those not being used?

> --- pgdat3.orig/include/linux/mmzone.h	2006-02-17 16:52:43.000000000 +0900
> +++ pgdat3/include/linux/mmzone.h	2006-02-17 18:41:52.000000000 +0900
> @@ -403,7 +403,9 @@ static inline struct zone *next_zone(str
>  
>  static inline int populated_zone(struct zone *zone)
>  {
> -	return (!!zone->present_pages);
> +	/* When hot-add, present page is 0 at this point.
> +	   So check spanned_pages instead of present_pages */
> +	return (!!zone->spanned_pages);
>  }

Please don't change this.  To me, populated means "has actual pages in
it".  Spanned means "spans an area where there could be pages".  I fear
that this is abusing present and spanned pages.  At the very least,
changing behavior like this needs to be in its own patch and justified
separately. 

Also, your comment needs to be CodingStyle-ified.

-- Dave

