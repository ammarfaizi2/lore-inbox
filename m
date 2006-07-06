Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWGFQIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWGFQIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWGFQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:08:38 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:24518 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1030270AbWGFQIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:08:37 -0400
Date: Thu, 6 Jul 2006 17:08:36 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
In-Reply-To: <44AD1F90.10103@innova-card.com>
Message-ID: <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie>
References: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie>
 <44AD1F90.10103@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, Franck Bui-Huu wrote:

> Hi Mel !
>

Hi.

> Mel Gorman wrote:
>> The FLATMEM memory model assumes that memory is one contiguous region based
>> at PFN 0 and uses the NODE_DATA(0)->node_mem_map as the global mem_map. As
>
> [snip]
>
>>
>> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/include/asm-generic/memory_model.h linux-2.6.17-mm6-archpfnoffset_optimise/include/asm-generic/memory_model.h
>> --- linux-2.6.17-mm6-clean/include/asm-generic/memory_model.h	2006-07-05 14:31:17.000000000 +0100
>> +++ linux-2.6.17-mm6-archpfnoffset_optimise/include/asm-generic/memory_model.h	2006-07-05 14:36:04.000000000 +0100
>> @@ -28,9 +28,8 @@
>>   */
>>  #if defined(CONFIG_FLATMEM)
>>
>> -#define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
>> -#define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
>> -				 ARCH_PFN_OFFSET)
>> +#define __pfn_to_page(pfn)	(mem_map + (pfn))
>> +#define __page_to_pfn(page)	((unsigned long)((page) - mem_map))
>>  #elif defined(CONFIG_DISCONTIGMEM)
>>
>
> ok for that part.
>

Grand.

>>  #define __pfn_to_page(pfn)			\
>> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-clean/mm/page_alloc.c linux-2.6.17-mm6-archpfnoffset_optimise/mm/page_alloc.c
>> --- linux-2.6.17-mm6-clean/mm/page_alloc.c	2006-07-05 14:31:18.000000000 +0100
>> +++ linux-2.6.17-mm6-archpfnoffset_optimise/mm/page_alloc.c	2006-07-05 17:01:01.000000000 +0100
>> @@ -2157,10 +2157,14 @@ static void __init alloc_node_mem_map(st
>>  	}
>>  #ifdef CONFIG_FLATMEM
>>  	/*
>> -	 * With no DISCONTIG, the global mem_map is just set as node 0's
>> +	 * With FLATMEM, the global mem_map is just set as node 0's. The
>> +	 * FLATMEM memory model assumes that memory is in one contiguous area
>> +	 * starting at PFN 0. Architectures that do not start NODE 0 at PFN 0
>> +	 * must define ARCH_PFN_OFFSET as the offset between
>> +	 * NODE_DATA(0)->node_mem_map and PFN 0.
>>  	 */
>>  	if (pgdat == NODE_DATA(0))
>> -		mem_map = NODE_DATA(0)->node_mem_map;
>> +		mem_map = NODE_DATA(0)->node_mem_map - ARCH_PFN_OFFSET;
>
> is mem_map always aligned on MAX_ORDER ?
>

The start of mem_map is at PFN 0 so it's always aligned. node_mem_map is 
MAX_ORDER_NR_PAGES aligned in alloc_node_mem_map().

Bear in mind that the only difference between the patched and unpatched 
kernel is that the unpatched kernel offsets NODE_DATA(0)->node_mem_map by 
NODE_DATA(0)->node_mem_map at every call to __pfn_to_page() and 
__page_to_pfn() and the patched kernel offsets just once. I'm not looking 
to alter anything fundamental here.

>>  #endif
>>  #endif /* CONFIG_FLAT_NODE_MEM_MAP */
>>  }
>>
>
> I'm not sure of that part. We basically make incoherent the use of
> free_area_init_node()'s fourth parameter by doing this change (for
> FLATMEM model of course).
>
> When using free_area_init() which is defined as follow:
>
> void __init free_area_init(unsigned long *zones_size)
> {
> 	free_area_init_node(0, NODE_DATA(0), zones_size,
> 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
> }
>
> we will end up to have 2 definitions for the mem start:
>
> 	- __pa(PAGE_OFFSET) >> PAGE_SHIFT
> 	- ARCH_PFN_OFFSET
>
> The former will be used to calculate the size of mem_map

The size of the node_mem_map is determined by zones_size. mem_map does not 
have a size as such because it's not necessarily a fully populated array. 
The location of mem_map is determined by the location of 
NODE_DATA(0)->node_mem_map and ARCH_PFN_OFFSET. Neither the former nor the 
latter affect the size of mem_map in other words.

> and the
> latter will be used to calculate the offset between
> NODE_DATA(0)->node_mem_map and PFN 0. I don't think that will result
> in any problem since:
>
> 	ARCH_PFN_OFFSET == __pa(PAGE_OFFSET) >> PAGE_SHIFT
>
> That just makes the code is harder to follow.
>
> But if some platforms were doing something like (which is unlikely)
>
> 	[...]
> 	free_area_init_node(0, NODE_DATA(0), zone_size, FOO_PFN_OFFSET, NULL);
> 	[...]
>
> and ARCH_PFN_OFFSET != FOO_PFN_OFFSET then they may have some troubles.
>

I'm not aware of an architecture that would run into such a problem but 
that is not saying a lot.

> What about this patch for page_alloc.c ? I think it makes more obvious
> what is ARCH_PFN_OFFSET. And if someone doesn't want to use
> ARCH_PFN_OFFSET, he still can use:
>
> 	free_area_init_node(0, NODE_DATA(0), zone_size, FOO_PFN_OFFSET, NULL);
>


I think my patch does the job of moving ARCH_PFN_OFFSET out of the hot 
path in a less risky fashion. However, if you are sure that callers to 
free_area_init() and ARCH_PFN_OFFSET are ok after your patch, I'd be happy 
to go with it. If you're not sure, I reckon my patch would be the way to 
go.

> 		Franck
>
> -- >8 --
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 253a450..9daee06 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2147,7 +2147,7 @@ #ifdef CONFIG_FLATMEM
> 	 * With no DISCONTIG, the global mem_map is just set as node 0's
> 	 */
> 	if (pgdat == NODE_DATA(0))
> -		mem_map = NODE_DATA(0)->node_mem_map;
> +		mem_map = NODE_DATA(0)->node_mem_map - pgdat->node_start_pfn;
> #endif
> #endif /* CONFIG_FLAT_NODE_MEM_MAP */
> }
> @@ -2172,10 +2172,13 @@ struct pglist_data contig_page_data = {
> EXPORT_SYMBOL(contig_page_data);
> #endif
>
> +/*
> + * This function is used only by FLATMEM. In that case the
> + * start of physical mem is always given by ARCH_PFN_OFFSET.
> + */
> void __init free_area_init(unsigned long *zones_size)
> {
> -	free_area_init_node(0, NODE_DATA(0), zones_size,
> -			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
> +	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, NULL);
> }
>
> #ifdef CONFIG_PROC_FS
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
