Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWFWQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWFWQiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWFWQiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:38:54 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:50881 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751760AbWFWQix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:38:53 -0400
Date: Fri, 23 Jun 2006 17:38:51 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm1
In-Reply-To: <449C0DF3.601@innova-card.com>
Message-ID: <Pine.LNX.4.64.0606231728040.13746@skynet.skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com>
 <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com>
 <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
 <cda58cb80606221025y63906e81wbec9597b94069b6a@mail.gmail.com>
 <20060623102037.GA1973@skynet.ie> <449BDCF5.6040808@innova-card.com>
 <20060623134634.GA6071@skynet.ie> <449C036D.6060004@innova-card.com>
 <20060623151322.GA13130@skynet.ie> <449C0DF3.601@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Franck Bui-Huu wrote:

> Mel Gorman wrote:
>> On (23/06/06 17:06), Franck Bui-Huu didst pronounce:
>>> what do you think about this use of ARCH_PFN_OFFSET ?
>>>
>>
>> I believe that arches calling free_area_init_node() directly, but using
>> CONFIG_FLAT_NODE_MEM_MAP will have problems with this. There is no
>> guarantee that pgdat->node_start_pfn will have any relation to
>> ARCH_PFN_OFFSET.
>
> I agree we shouldn't make this assumption.
>
> what about this ?
>
> -- >8 --
> [PATCH] flatmem: tiny optimisation when memory do not start at 0
>
> The FLATMEM memory model assumes that memory is in one
> contigious area based at pfn 0. Some archictectures, like
> ARM, use ARCH_PFN_OFFSET to relax this requirement but it
> involves one more operation during page/pfn conversion.
>
> Instead this patch modifies the address of mem_map to make
> mem_map[ARCH_PFN_OFFSET] pointing at NODE_DATA(0)->node_mem_map.
> The result is a slight gain on kernel code size.
>
> It also relaxes this requirement in two more places:
> 	free_area_init(...)
> 	init_bootmem(...)
>
> ---
> include/asm-generic/memory_model.h |    6 +++---
> mm/bootmem.c                       |    4 ++--
> mm/page_alloc.c                    |   18 ++++++++++++------
> 3 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
> index 0cfb086..2faa12f 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -34,9 +34,9 @@ #else
>  */
> #if defined(CONFIG_FLATMEM)
>
> -#define pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
> -#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
> -				 ARCH_PFN_OFFSET)
> +#define pfn_to_page(pfn)	(mem_map + (pfn))
> +#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
> +
> #elif defined(CONFIG_DISCONTIGMEM)
>
> #define pfn_to_page(pfn)			\
> diff --git a/mm/bootmem.c b/mm/bootmem.c
> index d213fed..fd28eed 100644
> --- a/mm/bootmem.c
> +++ b/mm/bootmem.c
> @@ -377,11 +377,11 @@ unsigned long __init free_all_bootmem_no
> 	return(free_all_bootmem_core(pgdat));
> }
>
> -unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
> +unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
> {
> 	max_low_pfn = pages;
> 	min_low_pfn = start;
> -	return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
> +	return init_bootmem_core(NODE_DATA(0), start, ARCH_PFN_OFFSET, pages);
> }
>

Not all arches will use init_bootmem(). Arm for example uses 
init_bootmem_node(). ARCH_PFN_OFFSET is only meant to affect mem_map, not 
any node attribute. I suspect (but don't know for a fact) that if we try 
and change node attributes with ARCH_PFN_OFFSET, we'll shoot ourselves in 
the foot.

> #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 253a450..3e97bc3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2118,15 +2118,16 @@ static void __init free_area_init_core(s
>
> static void __init alloc_node_mem_map(struct pglist_data *pgdat)
> {
> +#ifdef CONFIG_FLAT_NODE_MEM_MAP
> +	struct page *map = pgdat->node_mem_map;
> +
> 	/* Skip empty nodes */
> 	if (!pgdat->node_spanned_pages)
> 		return;
>
> -#ifdef CONFIG_FLAT_NODE_MEM_MAP
> 	/* ia64 gets its own node_mem_map, before this, without bootmem */
> -	if (!pgdat->node_mem_map) {
> +	if (!map) {
> 		unsigned long size, start, end;
> -		struct page *map;
>
> 		/*
> 		 * The zone's endpoints aren't required to be MAX_ORDER
> @@ -2147,7 +2148,13 @@ #ifdef CONFIG_FLATMEM
> 	 * With no DISCONTIG, the global mem_map is just set as node 0's
> 	 */
> 	if (pgdat == NODE_DATA(0))
> -		mem_map = NODE_DATA(0)->node_mem_map;
> +		/*
> +		 * mem_map is assumed to be based at pfn 0 such that
> +		 * 'pfn = page* - mem_map' is true. Adjust map
> +		 * relative to node_mem_map to maintain this
> +		 * relationship.
> +		 */
> +		mem_map = map - ARCH_PFN_OFFSET;

This part is fine.

> #endif
> #endif /* CONFIG_FLAT_NODE_MEM_MAP */
> }
> @@ -2174,8 +2181,7 @@ #endif
>
> void __init free_area_init(unsigned long *zones_size)
> {
> -	free_area_init_node(0, NODE_DATA(0), zones_size,
> -			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
> +	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, NULL);
> }
>

Same comment applies as for init_bootmem(). I can't be sure it's a good 
idea.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
