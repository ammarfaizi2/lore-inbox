Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWIJBD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWIJBD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 21:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWIJBD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 21:03:57 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:1293 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965064AbWIJBD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 21:03:56 -0400
Message-ID: <4503644D.9070307@shadowen.org>
Date: Sun, 10 Sep 2006 02:03:09 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>
CC: akpm@osdl.org, mel@csn.ul.ie, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64 specific for Sizing zones and holes in an architecture
 independent
References: <20060829101247.GF10680@localhost>
In-Reply-To: <20060829101247.GF10680@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco wrote:
> Andrew,
> 
> Mel's latest V9 regressed slightly for ia64 FLATMEM+VIRTUAL_MEM_MAP. When 
> the largest hole is greater than LARGE_GAP, vmem_map is allocated before 
> free_area_init_nodes; resultant crash follows. Rather than complicate
> alloc_node_mem_map just for this ia64 case, add an adjustment to node_mem_map
> which is later negated by alloc_node_mem_map.
> 
> Previous to V9, the mem_map adjustment was done in the scope where allocation
> is achieved in alloc_node_mem_map. The current code is more appropriate but
> unfortunately caused an issue for ia64.
> 
> Please add this to the next -mm.
> 
> thanks,
> 
> bob
> 
> Acked-by: Mel Gorman <mel@csn.ul.ie>
> Signed-off-by: Bob Picco <bob.picco@hp.com>
> 
>  arch/ia64/mm/contig.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc4-mm3/arch/ia64/mm/contig.c
> ===================================================================
> --- linux-2.6.18-rc4-mm3.orig/arch/ia64/mm/contig.c	2006-08-28 13:10:00.000000000 -0400
> +++ linux-2.6.18-rc4-mm3/arch/ia64/mm/contig.c	2006-08-28 18:18:54.000000000 -0400
> @@ -252,7 +252,12 @@ paging_init (void)
>  		vmem_map = (struct page *) vmalloc_end;
>  		efi_memmap_walk(create_mem_map_page_table, NULL);
>  
> -		NODE_DATA(0)->node_mem_map = vmem_map;
> +		/*
> +		 * alloc_node_mem_map makes an adjustment for mem_map
> +		 * which isn't compatible with vmem_map.
> +		 */

Bob, which adjustment is this that is incompatible?  Is it the one in
the final stanza, the FLATMEM mem_map instantiation?  This one?

#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
                if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
                        mem_map -= pgdat->node_start_pfn;
#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */

-apw

> +		NODE_DATA(0)->node_mem_map = vmem_map +
> +			find_min_pfn_with_active_regions();
>  		free_area_init_nodes(max_zone_pfns);
>  
>  		printk("Virtual mem_map starts at 0x%p\n", mem_map);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

