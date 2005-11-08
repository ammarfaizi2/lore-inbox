Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVKHOYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVKHOYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVKHOYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:24:53 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59551 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965069AbVKHOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:24:52 -0500
Date: Tue, 08 Nov 2005 23:24:12 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [patch] Cleanup bootmem allocator and fix alloc_bootmem_low
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051108073224.GA3753@localhost.localdomain>
References: <20051108073224.GA3753@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051108224621.7062.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kiran-san.

Thank you for your patch. It looks good.
However, I couldn't try your patch today.

I guess your patch is for 2.6.14-git11, right?
I tried it on my ia64 Tiger4 with NUMA emulation.
This emulation had worked well so far.

But, 2.6.14-git11 doen't boot even if your patch is not used.
(Probably, it is caused by changing efi_map walker.)

And I can't use our big true NUMA machine now.
It is used by other person. So, I have to reserve it to use again.

If I can test it, I'll notify about it ASAP.

Bye.


> Hi Andrew,
> The following patch removes alloc_bootmem_*limit apis and fixes
> alloc_bootmem_low and friends to allocate below the 4G limit.
> 
> We'd agreed to do kill the *limit apis post 2.6.14.  
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112976967105993&w=2
> 
> Tested on x86_64 arches. 
> 
> Thanks,
> Kiran
> 
> --
> Patch cleans up the alloc_bootmem fix for swiotlb.  
> Patch removes alloc_bootmem_*_limit api and fixes 
> alloc_boot_*low api to do the right thing -- allocate from low32 memory.
> 
> We did not do this earlier to minimise impact at the 2.6.14 final 
> release moment.
> 
> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> 
> Index: linux-2.6.14/include/linux/bootmem.h
> ===================================================================
> --- linux-2.6.14.orig/include/linux/bootmem.h	2005-11-07 19:22:35.000000000 -0800
> +++ linux-2.6.14/include/linux/bootmem.h	2005-11-07 19:29:07.000000000 -0800
> @@ -43,50 +43,38 @@
>  extern unsigned long __init bootmem_bootmap_pages (unsigned long);
>  extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
>  extern void __init free_bootmem (unsigned long addr, unsigned long size);
> -extern void * __init __alloc_bootmem_limit (unsigned long size, unsigned long align, unsigned long goal, unsigned long limit);
> +extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
> +extern void * __init __alloc_bootmem_low(unsigned long size, 
> +					 unsigned long align,
> +					 unsigned long goal);
> +extern void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, 
> +					      unsigned long size,
> +					      unsigned long align,
> +					      unsigned long goal);
>  #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
>  extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
>  #define alloc_bootmem(x) \
>  	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
>  #define alloc_bootmem_low(x) \
> -	__alloc_bootmem((x), SMP_CACHE_BYTES, 0)
> +	__alloc_bootmem_low((x), SMP_CACHE_BYTES, 0)
>  #define alloc_bootmem_pages(x) \
>  	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
>  #define alloc_bootmem_low_pages(x) \
> -	__alloc_bootmem((x), PAGE_SIZE, 0)
> -
> -#define alloc_bootmem_limit(x, limit)						\
> -	__alloc_bootmem_limit((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS), (limit))
> -#define alloc_bootmem_low_limit(x, limit)			\
> -	__alloc_bootmem_limit((x), SMP_CACHE_BYTES, 0, (limit))
> -#define alloc_bootmem_pages_limit(x, limit)					\
> -	__alloc_bootmem_limit((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS), (limit))
> -#define alloc_bootmem_low_pages_limit(x, limit)		\
> -	__alloc_bootmem_limit((x), PAGE_SIZE, 0, (limit))
> -
> +	__alloc_bootmem_low((x), PAGE_SIZE, 0)
>  #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
>  extern unsigned long __init free_all_bootmem (void);
> -
> +extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
>  extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
>  extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
>  extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
>  extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
> -extern void * __init __alloc_bootmem_node_limit (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal, unsigned long limit);
>  #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
>  #define alloc_bootmem_node(pgdat, x) \
>  	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
>  #define alloc_bootmem_pages_node(pgdat, x) \
>  	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
>  #define alloc_bootmem_low_pages_node(pgdat, x) \
> -	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
> -
> -#define alloc_bootmem_node_limit(pgdat, x, limit)				\
> -	__alloc_bootmem_node_limit((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS), (limit))
> -#define alloc_bootmem_pages_node_limit(pgdat, x, limit)				\
> -	__alloc_bootmem_node_limit((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS), (limit))
> -#define alloc_bootmem_low_pages_node_limit(pgdat, x, limit)		\
> -	__alloc_bootmem_node_limit((pgdat), (x), PAGE_SIZE, 0, (limit))
> -
> +	__alloc_bootmem_low_node((pgdat), (x), PAGE_SIZE, 0)
>  #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
>  
>  #ifdef CONFIG_HAVE_ARCH_ALLOC_REMAP
> @@ -123,15 +111,5 @@
>  #endif
>  extern int __initdata hashdist;		/* Distribute hashes across NUMA nodes? */
>  
> -static inline void *__alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
> -{
> -	return __alloc_bootmem_limit(size, align, goal, 0);
> -}
> -
> -static inline void *__alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align,
> -				     unsigned long goal)
> -{
> -	return __alloc_bootmem_node_limit(pgdat, size, align, goal, 0);
> -}
>  
>  #endif /* _LINUX_BOOTMEM_H */
> Index: linux-2.6.14/lib/swiotlb.c
> ===================================================================
> --- linux-2.6.14.orig/lib/swiotlb.c	2005-11-07 19:22:35.000000000 -0800
> +++ linux-2.6.14/lib/swiotlb.c	2005-11-07 19:22:58.000000000 -0800
> @@ -142,8 +142,7 @@
>  	/*
>  	 * Get IO TLB memory from the low pages
>  	 */
> -	io_tlb_start = alloc_bootmem_low_pages_limit(io_tlb_nslabs *
> -					     (1 << IO_TLB_SHIFT), 0x100000000);
> +	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs * (1 << IO_TLB_SHIFT));
>  	if (!io_tlb_start)
>  		panic("Cannot allocate SWIOTLB buffer");
>  	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
> Index: linux-2.6.14/mm/bootmem.c
> ===================================================================
> --- linux-2.6.14.orig/mm/bootmem.c	2005-11-07 19:22:35.000000000 -0800
> +++ linux-2.6.14/mm/bootmem.c	2005-11-07 19:22:58.000000000 -0800
> @@ -391,15 +391,14 @@
>  	return(free_all_bootmem_core(NODE_DATA(0)));
>  }
>  
> -void * __init __alloc_bootmem_limit (unsigned long size, unsigned long align, unsigned long goal,
> -				unsigned long limit)
> +void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
>  {
>  	pg_data_t *pgdat = pgdat_list;
>  	void *ptr;
>  
>  	for_each_pgdat(pgdat)
>  		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
> -						 align, goal, limit)))
> +						 align, goal, 0)))
>  			return(ptr);
>  
>  	/*
> @@ -411,15 +410,38 @@
>  }
>  
>  
> -void * __init __alloc_bootmem_node_limit (pg_data_t *pgdat, unsigned long size, unsigned long align,
> -				     unsigned long goal, unsigned long limit)
> +void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size, unsigned long align,
> +				   unsigned long goal)
>  {
>  	void *ptr;
>  
> -	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, limit);
> +	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
>  	if (ptr)
>  		return (ptr);
>  
> -	return __alloc_bootmem_limit(size, align, goal, limit);
> +	return __alloc_bootmem(size, align, goal);
>  }
>  
> +void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
> +{
> +	pg_data_t *pgdat = pgdat_list;
> +	void *ptr;
> +
> +	for_each_pgdat(pgdat)
> +		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
> +						 align, goal, 0x100000000)))
> +			return(ptr);
> +
> +	/*
> +	 * Whoops, we cannot satisfy the allocation request.
> +	 */
> +	printk(KERN_ALERT "low bootmem alloc of %lu bytes failed!\n", size);
> +	panic("Out of low memory");
> +	return NULL;
> +}
> +
> +void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size, 
> +				       unsigned long align, unsigned long goal)
> +{
> +	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0x100000000);
> +}

-- 
Yasunori Goto 

