Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTAQGl5>; Fri, 17 Jan 2003 01:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbTAQGl5>; Fri, 17 Jan 2003 01:41:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:61155 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267409AbTAQGl4>; Fri, 17 Jan 2003 01:41:56 -0500
Date: Thu, 16 Jan 2003 22:50:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, gone@us.ibm.com
cc: akpm@zip.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: asm-i386/mmzone.h macro paren/eval fixes
Message-ID: <181070000.1042786246@titus>
In-Reply-To: <20030117063900.GA1036@holomorphy.com>
References: <20030117063900.GA1036@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh. That's why I broke struct page out into a seperate header file.
OK, Andrew ... now do you believe me? ;-) ;-)

M.

--On Thursday, January 16, 2003 22:39:00 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:

> Okay, this one looks ugly because we're missing some of the definitions
> available with which to convert to inline functions (esp. struct page).
> A lot of these introduce temporaries and sort of hope names won't clash,
> which might be important to whoever cares about -Wshadow.
> 
> (1) node_end_pfn() evaluates nid twice
> (2) local_mapnr() evaluates kvaddr twice
> (3) kern_addr_valid() evaluates kaddr twice
> (4) pfn_to_page() evaluates pfn multiple times
> (5) page_to_pfn() evaluates page thrice
> (6) pfn_valid() doesn't parenthesize its argument
> 
> 
> ===== include/asm-i386/mmzone.h 1.6 vs edited =====
> --- 1.6/include/asm-i386/mmzone.h	Wed Sep 25 17:40:59 2002
> +++ edited/include/asm-i386/mmzone.h	Thu Jan 16 22:37:03 2003
> @@ -57,25 +57,47 @@
>  
>  #define node_mem_map(nid)	(NODE_DATA(nid)->node_mem_map)
>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
> -#define node_end_pfn(nid)       (NODE_DATA(nid)->node_start_pfn + \
> -				 NODE_DATA(nid)->node_size)
> +#define node_end_pfn(nid)						\
> +({									\
> +	pg_data_t *__pgdat = NODE_DATA(nid);				\
> +	__pgdat->node_start_pfn + __pgdat->node_size;			\
> +})
>  
> -#define local_mapnr(kvaddr) \
> -	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) )
> +#define local_mapnr(kvaddr)						\
> +({									\
> +	unsigned long __pfn = __pa(kvaddr) >> PAGE_SHIFT;		\
> +	(__pfn - node_start_pfn(pfn_to_nid(__pfn)));			\
> +})
>  
> -#define kern_addr_valid(kaddr)	test_bit(local_mapnr(kaddr), \
> -		 NODE_DATA(kvaddr_to_nid(kaddr))->valid_addr_bitmap)
> +#define kern_addr_valid(kaddr)						\
> +({									\
> +	unsigned long __kaddr = (unsigned long)(kaddr);			\
> +	pg_data_t *__pgdat = NODE_DATA(kvaddr_to_nid(__kaddr));		\
> +	test_bit(local_mapnr(__kaddr), __pgdat->valid_addr_bitmap);	\
> +})
>  
> -#define pfn_to_page(pfn)	(node_mem_map(pfn_to_nid(pfn)) + node_localnr(pfn, pfn_to_nid(pfn)))
> -#define page_to_pfn(page)	((page - page_zone(page)->zone_mem_map) + page_zone(page)->zone_start_pfn)
> +#define pfn_to_page(pfn)						\
> +({									\
> +	unsigned long __pfn = pfn;					\
> +	int __node  = pfn_to_nid(__pfn);				\
> +	&node_mem_map(__node)[node_localnr(__pfn,__node)];		\
> +})
> +
> +#define page_to_pfn(pg)							\
> +({									\
> +	struct page *__page = pg;					\
> +	struct zone *__zone = page_zone(__page);			\
> +	(unsigned long)(__page - __zone->zone_mem_map)			\
> +		+ __zone->zone_start_pfn;				\
> +})
>  #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
>  /*
>   * pfn_valid should be made as fast as possible, and the current definition 
>   * is valid for machines that are NUMA, but still contiguous, which is what
>   * is currently supported. A more generalised, but slower definition would
>   * be something like this - mbligh:
> - * ( pfn_to_pgdat(pfn) && (pfn < node_end_pfn(pfn_to_nid(pfn))) ) 
> + * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
>   */ 
> -#define pfn_valid(pfn)          (pfn < num_physpages)
> +#define pfn_valid(pfn)          ((pfn) < num_physpages)
>  #endif /* CONFIG_DISCONTIGMEM */
>  #endif /* _ASM_MMZONE_H_ */
> 
> 


