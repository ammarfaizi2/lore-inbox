Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWJEJKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWJEJKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWJEJKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:10:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:15332 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751526AbWJEJKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:10:11 -0400
Subject: Re: 2.6.18-rc6-mm2: fix for error compiling ppc/mm/init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Judith Lebzelter <judith@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0610041510400.24183@skynet.skynet.ie>
References: <20060914173705.GC19807@shell0.pdx.osdl.net>
	 <Pine.LNX.4.64.0609141910440.1812@skynet.skynet.ie>
	 <1159849491.5482.24.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610030909490.2904@skynet.skynet.ie>
	 <1159867180.5482.61.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610031023100.13141@skynet.skynet.ie>
	 <1159877552.5482.69.camel@localhost.localdomain>
	 <20061003130457.GA17358@skynet.ie>
	 <1159932158.8469.12.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610041510400.24183@skynet.skynet.ie>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 19:09:48 +1000
Message-Id: <1160039388.22232.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 15:12 +0100, Mel Gorman wrote:
> On Wed, 4 Oct 2006, Benjamin Herrenschmidt wrote:
> 
> >
> > Patch looks good on a quick look. I will try to test later today at
> > which point, it should go in asap, current upstream doesn't boot on
> > CONFIG_HIGHMEM powerpc, which is a lot of them...
> >
> 
> The patch has passed tests here on x86, x86_64, ia64 and ppc64. Testing on 
> powerpc with HIGHMEM is a configuration I cannot test. If you say it 
> passes, I'll see can I get it pushed before 2.6.19-rc1

Too late for rc1 :( I'll ask Johannes to test as I don't have access to
the box atm.

Thanks.
Ben.

> Thanks
> 
> >>
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/i386/kernel/setup.c linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/kernel/setup.c
> >> --- linux-2.6.18-git19-clean/arch/i386/kernel/setup.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/kernel/setup.c	2006-10-03 11:15:59.000000000 +0100
> >> @@ -1083,16 +1083,15 @@ static unsigned long __init setup_memory
> >>
> >>  void __init zone_sizes_init(void)
> >>  {
> >> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >> +	max_zone_pfns[ZONE_DMA] =
> >> +		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> >>  #ifdef CONFIG_HIGHMEM
> >> -	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
> >> -			virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
> >> -			max_low_pfn,
> >> -			highend_pfn};
> >> +	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
> >>  	add_active_range(0, 0, highend_pfn);
> >>  #else
> >> -	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
> >> -			virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
> >> -			max_low_pfn};
> >>  	add_active_range(0, 0, max_low_pfn);
> >>  #endif
> >>
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/i386/mm/discontig.c linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/mm/discontig.c
> >> --- linux-2.6.18-git19-clean/arch/i386/mm/discontig.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/i386/mm/discontig.c	2006-10-03 11:17:27.000000000 +0100
> >> @@ -357,11 +357,12 @@ void __init numa_kva_reserve(void)
> >>  void __init zone_sizes_init(void)
> >>  {
> >>  	int nid;
> >> -	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
> >> -		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT,
> >> -		max_low_pfn,
> >> -		highend_pfn
> >> -	};
> >> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >> +	max_zone_pfns[ZONE_DMA] =
> >> +		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> >> +	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
> >>
> >>  	/* If SRAT has not registered memory, register it now */
> >>  	if (find_max_pfn_with_active_regions() == 0) {
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/ia64/mm/contig.c linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/contig.c
> >> --- linux-2.6.18-git19-clean/arch/ia64/mm/contig.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/contig.c	2006-10-03 11:21:09.000000000 +0100
> >> @@ -233,6 +233,7 @@ paging_init (void)
> >>  	efi_memmap_walk(count_pages, &num_physpages);
> >>
> >>  	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >>  	max_zone_pfns[ZONE_DMA] = max_dma;
> >>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> >>
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/ia64/mm/discontig.c linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/discontig.c
> >> --- linux-2.6.18-git19-clean/arch/ia64/mm/discontig.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/ia64/mm/discontig.c	2006-10-03 11:21:54.000000000 +0100
> >> @@ -709,6 +709,7 @@ void __init paging_init(void)
> >>  			max_pfn = mem_data[node].max_pfn;
> >>  	}
> >>
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >>  	max_zone_pfns[ZONE_DMA] = max_dma;
> >>  	max_zone_pfns[ZONE_NORMAL] = max_pfn;
> >>  	free_area_init_nodes(max_zone_pfns);
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/powerpc/mm/mem.c linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/mem.c
> >> --- linux-2.6.18-git19-clean/arch/powerpc/mm/mem.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/mem.c	2006-10-03 11:10:57.000000000 +0100
> >> @@ -307,11 +307,12 @@ void __init paging_init(void)
> >>  	       top_of_ram, total_ram);
> >>  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
> >>  	       (top_of_ram - total_ram) >> 20);
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >>  #ifdef CONFIG_HIGHMEM
> >> -	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
> >> -	max_zone_pfns[1] = top_of_ram >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
> >>  #else
> >> -	max_zone_pfns[0] = top_of_ram >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
> >>  #endif
> >>  	free_area_init_nodes(max_zone_pfns);
> >>  }
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/powerpc/mm/numa.c linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/numa.c
> >> --- linux-2.6.18-git19-clean/arch/powerpc/mm/numa.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/powerpc/mm/numa.c	2006-10-03 11:12:01.000000000 +0100
> >> @@ -617,9 +617,9 @@ void __init do_init_bootmem(void)
> >>
> >>  void __init paging_init(void)
> >>  {
> >> -	unsigned long max_zone_pfns[MAX_NR_ZONES] = {
> >> -				lmb_end_of_DRAM() >> PAGE_SHIFT
> >> -	};
> >> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >> +	max_zone_pfns[ZONE_DMA] = lmb_end_of_DRAM() >> PAGE_SHIFT;
> >>  	free_area_init_nodes(max_zone_pfns);
> >>  }
> >>
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/ppc/mm/init.c linux-2.6.18-git19-use_zone_symbolic_names/arch/ppc/mm/init.c
> >> --- linux-2.6.18-git19-clean/arch/ppc/mm/init.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/ppc/mm/init.c	2006-10-03 11:13:46.000000000 +0100
> >> @@ -374,11 +374,12 @@ void __init paging_init(void)
> >>  	end_pfn = start_pfn + (total_memory >> PAGE_SHIFT);
> >>  	add_active_range(0, start_pfn, end_pfn);
> >>
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >>  #ifdef CONFIG_HIGHMEM
> >> -	max_zone_pfns[0] = total_lowmem >> PAGE_SHIFT;
> >> -	max_zone_pfns[1] = total_memory >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_HIGHMEM] = total_memory >> PAGE_SHIFT;
> >>  #else
> >> -	max_zone_pfns[0] = total_memory >> PAGE_SHIFT;
> >> +	max_zone_pfns[ZONE_DMA] = total_memory >> PAGE_SHIFT;
> >>  #endif /* CONFIG_HIGHMEM */
> >>  	free_area_init_nodes(max_zone_pfns);
> >>  }
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/x86_64/mm/init.c linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/init.c
> >> --- linux-2.6.18-git19-clean/arch/x86_64/mm/init.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/init.c	2006-10-03 11:18:54.000000000 +0100
> >> @@ -406,9 +406,12 @@ void __cpuinit zap_low_mappings(int cpu)
> >>  #ifndef CONFIG_NUMA
> >>  void __init paging_init(void)
> >>  {
> >> -	unsigned long max_zone_pfns[MAX_NR_ZONES] = {MAX_DMA_PFN,
> >> -							MAX_DMA32_PFN,
> >> -							end_pfn};
> >> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >> +	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> >> +	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
> >> +	max_zone_pfns[ZONE_NORMAL] = end_pfn;
> >> +
> >>  	memory_present(0, 0, end_pfn);
> >>  	sparse_init();
> >>  	free_area_init_nodes(max_zone_pfns);
> >> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-git19-clean/arch/x86_64/mm/numa.c linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/numa.c
> >> --- linux-2.6.18-git19-clean/arch/x86_64/mm/numa.c	2006-10-03 09:12:56.000000000 +0100
> >> +++ linux-2.6.18-git19-use_zone_symbolic_names/arch/x86_64/mm/numa.c	2006-10-03 11:19:47.000000000 +0100
> >> @@ -338,9 +338,11 @@ static void __init arch_sparse_init(void
> >>  void __init paging_init(void)
> >>  {
> >>  	int i;
> >> -	unsigned long max_zone_pfns[MAX_NR_ZONES] = { MAX_DMA_PFN,
> >> -		MAX_DMA32_PFN,
> >> -		end_pfn};
> >> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
> >> +	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >> +	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
> >> +	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
> >> +	max_zone_pfns[ZONE_NORMAL] = end_pfn;
> >>
> >>  	arch_sparse_init();
> >>
> 

