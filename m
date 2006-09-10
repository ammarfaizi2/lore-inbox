Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWIJCmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWIJCmK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 22:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWIJCmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 22:42:10 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:7949 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965093AbWIJCmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 22:42:09 -0400
Message-ID: <45037B5F.1080509@shadowen.org>
Date: Sun, 10 Sep 2006 03:41:35 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: kmannth@us.ibm.com
CC: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch[1/1] i386 numa kva conversion to use bootmem reserve
References: <1150871711.8518.61.camel@keithlap>
In-Reply-To: <1150871711.8518.61.camel@keithlap>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey wrote:
> Hello,
>   I the current i386 numa the numa_kva (the area used to remap node
> local data in lowmem) space is acquired by adjusting the end of low
> memroy during boot. 
> 
> (from setup_memory)
> reserve_pages = calculate_numa_remap_pages();
> (then)
> system_max_low_pfn = max_low_pfn = find_max_low_pfn() - reserve_pages;
> 
> The problem this is that initrds can be trampled over (the kva can
> adjust system_max_low_pfn into the initrd area) This results in kernel
> throwing away the intird and a failed boot.  This is a long standing
> issue. (It has been like this at least for the last few years). 
> 
> This patch keeps the numa kva code from adjusting the end of memory and
> coverts it is just use the reserve_bootmem call to reserve the large
> amount of space needed for the numa_kva. It is mindful of initrds when
> present. 
> 
> This patch was built against 2.6.17-rc1 originally but applies and boots
> against 2.6.17 just fine.  I have only test this against the summit
> subarch (I don't have other i386 numa hw). 
> 
> all feedback welcome!
> 
> Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urN linux-2.6.17/arch/i386/kernel/setup.c linux-2.6.17-work/arch/i386/kernel/setup.c
> --- linux-2.6.17/arch/i386/kernel/setup.c	2006-06-17 18:49:35.000000000 -0700
> +++ linux-2.6.17-work/arch/i386/kernel/setup.c	2006-06-20 23:04:37.000000000 -0700
> @@ -1210,6 +1210,9 @@
>  extern void zone_sizes_init(void);
>  #endif /* !CONFIG_NEED_MULTIPLE_NODES */
>  
> +#ifdef CONFIG_NUMA
> +extern void numa_kva_reserve(void);
> +#endif
>  void __init setup_bootmem_allocator(void)
>  {
>  	unsigned long bootmap_size;
> @@ -1265,7 +1268,9 @@
>  	 */
>  	find_smp_config();
>  #endif
> -
> +#ifdef CONFIG_NUMA
> +	numa_kva_reserve();
> +#endif 
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (LOADER_TYPE && INITRD_START) {
>  		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
> diff -urN linux-2.6.17/arch/i386/mm/discontig.c linux-2.6.17-work/arch/i386/mm/discontig.c
> --- linux-2.6.17/arch/i386/mm/discontig.c	2006-06-17 18:49:35.000000000 -0700
> +++ linux-2.6.17-work/arch/i386/mm/discontig.c	2006-06-20 23:11:49.000000000 -0700
> @@ -118,7 +118,8 @@
>  
>  void *node_remap_end_vaddr[MAX_NUMNODES];
>  void *node_remap_alloc_vaddr[MAX_NUMNODES];
> -
> +static unsigned long kva_start_pfn;
> +static unsigned long kva_pages;
>  /*
>   * FLAT - support for basic PC memory model with discontig enabled, essentially
>   *        a single node with all available processors in it with a flat
> @@ -287,7 +288,6 @@
>  {
>  	int nid;
>  	unsigned long system_start_pfn, system_max_low_pfn;
> -	unsigned long reserve_pages;
>  
>  	/*
>  	 * When mapping a NUMA machine we allocate the node_mem_map arrays
> @@ -299,14 +299,23 @@
>  	find_max_pfn();
>  	get_memcfg_numa();
>  
> -	reserve_pages = calculate_numa_remap_pages();
> +	kva_pages = calculate_numa_remap_pages();
>  
>  	/* partially used pages are not usable - thus round upwards */
>  	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
>  
> -	system_max_low_pfn = max_low_pfn = find_max_low_pfn() - reserve_pages;
> -	printk("reserve_pages = %ld find_max_low_pfn() ~ %ld\n",
> -			reserve_pages, max_low_pfn + reserve_pages);
> +	kva_start_pfn = find_max_low_pfn() - kva_pages;
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Numa kva area is below the initrd */
> +	if (LOADER_TYPE && INITRD_START) 
> +		kva_start_pfn = PFN_DOWN(INITRD_START)  - kva_pages;
> +#endif 
> +	kva_start_pfn -= kva_start_pfn & (PTRS_PER_PTE-1);
> +
> +	system_max_low_pfn = max_low_pfn = find_max_low_pfn();
> +	printk("kva_start_pfn ~ %ld find_max_low_pfn() ~ %ld\n", 
> +		kva_start_pfn, max_low_pfn);
>  	printk("max_pfn = %ld\n", max_pfn);
>  #ifdef CONFIG_HIGHMEM
>  	highstart_pfn = highend_pfn = max_pfn;
> @@ -324,7 +333,7 @@
>  			(ulong) pfn_to_kaddr(max_low_pfn));
>  	for_each_online_node(nid) {
>  		node_remap_start_vaddr[nid] = pfn_to_kaddr(
> -				highstart_pfn + node_remap_offset[nid]);
> +				kva_start_pfn + node_remap_offset[nid]);
>  		/* Init the node remap allocator */
>  		node_remap_end_vaddr[nid] = node_remap_start_vaddr[nid] +
>  			(node_remap_size[nid] * PAGE_SIZE);
> @@ -339,7 +348,6 @@
>  	}
>  	printk("High memory starts at vaddr %08lx\n",
>  			(ulong) pfn_to_kaddr(highstart_pfn));
> -	vmalloc_earlyreserve = reserve_pages * PAGE_SIZE;
>  	for_each_online_node(nid)
>  		find_max_pfn_node(nid);
>  
> @@ -349,6 +357,12 @@
>  	return max_low_pfn;
>  }
>  
> +void __init numa_kva_reserve (void) 
> +{
> +	reserve_bootmem(PFN_PHYS(kva_start_pfn),PFN_PHYS(kva_pages));
> +
> +}
> +
>  void __init zone_sizes_init(void)
>  {
>  	int nid;

The primary reason that the mem_map is cut from the end of ZONE_NORMAL
is so that memory that would back that stolen KVA gets pushed out into
ZONE_HIGHMEM, the boundary between them is moved down.  By using
reserve_bootmem we will mark the pages which are currently backing the
KVA you are 'reusing' as reserved and prevent their release; we pay
double for the mem_map.

If the initrd's are falling into this space, can we not allocate some
bootmem for those and move them out of our way?  As filesystem images
they are essentially location neutral so this should be safe?

-apw
