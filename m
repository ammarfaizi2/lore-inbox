Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUAEVka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUAEVk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:40:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27850 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265948AbUAEVkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:40:09 -0500
Message-ID: <3FF9D8A3.4020608@us.ibm.com>
Date: Mon, 05 Jan 2004 13:35:31 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL PATCH] Ensure pfn_to_nid() is always defined for i386
References: <3FE74984.3000602@us.ibm.com> <1814780000.1072139199@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok... This looks good to me.  It's definitely longer than my 1 line fix, 
but it's also more correct long-term solution.

Cheers!

-Matt

Martin J. Bligh wrote:
>>pfn_to_nid() is defined for *almost* all configurations for i386.  
>>There is a small bug in that for CONFIG_X86_PC it is not.  This 
>>just sets up a generic definition so that this function is always 
>>defined in a reasonable manner.
> 
> 
> I'd prefer to fix the current ungodly mess in the current fashion ...
> I know it's longer, but I'd prefer to clean it up more if we're 
> going to touch it. This has been sitting in my tree for a while, 
> waiting for the code freeze to slush out a bit.
> 
> M.
> 
> 
> diff -purN -X /home/mbligh/.diff.exclude 276-per_node_rss/include/asm-i386/mmzone.h 278-pfn_to_nid/include/asm-i386/mmzone.h
> --- 276-per_node_rss/include/asm-i386/mmzone.h	2003-10-01 11:48:22.000000000 -0700
> +++ 278-pfn_to_nid/include/asm-i386/mmzone.h	2003-12-11 17:16:48.000000000 -0800
> @@ -10,7 +10,49 @@
>  
>  #ifdef CONFIG_DISCONTIGMEM
>  
> +#ifdef CONFIG_NUMA
> +	#ifdef CONFIG_X86_NUMAQ
> +		#include <asm/numaq.h>
> +	#else	/* summit or generic arch */
> +		#include <asm/srat.h>
> +	#endif
> +#else /* !CONFIG_NUMA */
> +	#define get_memcfg_numa get_memcfg_numa_flat
> +	#define get_zholes_size(n) (0)
> +#endif /* CONFIG_NUMA */
> +
>  extern struct pglist_data *node_data[];
> +#define NODE_DATA(nid)		(node_data[nid])
> +
> +/*
> + * generic node memory support, the following assumptions apply:
> + *
> + * 1) memory comes in 256Mb contigious chunks which are either present or not
> + * 2) we will not have more than 64Gb in total
> + *
> + * for now assume that 64Gb is max amount of RAM for whole system
> + *    64Gb / 4096bytes/page = 16777216 pages
> + */
> +#define MAX_NR_PAGES 16777216
> +#define MAX_ELEMENTS 256
> +#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
> +
> +extern u8 physnode_map[];
> +
> +static inline int pfn_to_nid(unsigned long pfn)
> +{
> +#ifdef CONFIG_NUMA
> +	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline struct pglist_data *pfn_to_pgdat(unsigned long pfn)
> +{
> +	return(NODE_DATA(pfn_to_nid(pfn)));
> +}
> +
>  
>  /*
>   * Following are macros that are specific to this numa platform.
> @@ -43,11 +85,6 @@ extern struct pglist_data *node_data[];
>   */
>  #define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
>  
> -/*
> - * Return a pointer to the node data for node n.
> - */
> -#define NODE_DATA(nid)		(node_data[nid])
> -
>  #define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid)						\
> @@ -93,40 +130,6 @@ extern struct pglist_data *node_data[];
>   */ 
>  #define pfn_valid(pfn)          ((pfn) < num_physpages)
>  
> -/*
> - * generic node memory support, the following assumptions apply:
> - *
> - * 1) memory comes in 256Mb contigious chunks which are either present or not
> - * 2) we will not have more than 64Gb in total
> - *
> - * for now assume that 64Gb is max amount of RAM for whole system
> - *    64Gb / 4096bytes/page = 16777216 pages
> - */
> -#define MAX_NR_PAGES 16777216
> -#define MAX_ELEMENTS 256
> -#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
> -
> -extern u8 physnode_map[];
> -
> -static inline int pfn_to_nid(unsigned long pfn)
> -{
> -	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
> -}
> -static inline struct pglist_data *pfn_to_pgdat(unsigned long pfn)
> -{
> -	return(NODE_DATA(pfn_to_nid(pfn)));
> -}
> -
> -#ifdef CONFIG_X86_NUMAQ
> -#include <asm/numaq.h>
> -#elif CONFIG_ACPI_SRAT
> -#include <asm/srat.h>
> -#elif CONFIG_X86_PC
> -#define get_zholes_size(n) (0)
> -#else
> -#define pfn_to_nid(pfn)		(0)
> -#endif /* CONFIG_X86_NUMAQ */
> -
>  extern int get_memcfg_numa_flat(void );
>  /*
>   * This allows any one NUMA architecture to be compiled
> diff -purN -X /home/mbligh/.diff.exclude 276-per_node_rss/include/linux/mmzone.h 278-pfn_to_nid/include/linux/mmzone.h
> --- 276-per_node_rss/include/linux/mmzone.h	2003-10-14 15:50:34.000000000 -0700
> +++ 278-pfn_to_nid/include/linux/mmzone.h	2003-12-11 17:16:48.000000000 -0800
> @@ -303,7 +303,7 @@ extern struct pglist_data contig_page_da
>  #define NODE_DATA(nid)		(&contig_page_data)
>  #define NODE_MEM_MAP(nid)	mem_map
>  #define MAX_NODES_SHIFT		0
> -
> +#define pfn_to_nid(pfn)		(0)
>  #else /* CONFIG_DISCONTIGMEM */
>  
>  #include <asm/mmzone.h>
> 
> 


