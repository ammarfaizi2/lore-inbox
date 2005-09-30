Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVI3SzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVI3SzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVI3SzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:55:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29825 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965076AbVI3SzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:55:24 -0400
Subject: Re: [PATCH 07/07] i386: numa emulation on pc
From: Dave Hansen <haveblue@us.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>,
       Isaku Yamahata <yamahata@valinux.co.jp>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050930073308.10631.24247.sendpatchset@cherry.local>
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <20050930073308.10631.24247.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 11:55:11 -0700
Message-Id: <1128106512.8123.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
>  void __init nid_zone_sizes_init(int nid)
>  {
>  	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
> -	unsigned long max_dma;
> +	unsigned long max_dma = min(max_hardware_dma_pfn(), max_low_pfn);
>  	unsigned long start = node_start_pfn[nid];
>  	unsigned long end = node_end_pfn[nid];
>  
>  	if (node_has_online_mem(nid)){
> -		if (nid_starts_in_highmem(nid)) {
> -			zones_size[ZONE_HIGHMEM] = nid_size_pages(nid);
> -		} else {
> -			max_dma = min(max_hardware_dma_pfn(), max_low_pfn);
> -			zones_size[ZONE_DMA] = max_dma;
> -			zones_size[ZONE_NORMAL] = max_low_pfn - max_dma;
> -			zones_size[ZONE_HIGHMEM] = end - max_low_pfn;
> +		if (start < max_dma) {
> +			zones_size[ZONE_DMA] = min(end, max_dma) - start;
> +		}
> +		if (start < max_low_pfn && max_dma < end) {
> +			zones_size[ZONE_NORMAL] = min(end, max_low_pfn) - max(start, max_dma);
> +		}
> +		if (max_low_pfn <= end) {
> +			zones_size[ZONE_HIGHMEM] = end - max(start, max_low_pfn);
>  		}
>  	}

That is a decent cleanup all by itself.  You might want to break it out.
Take a look at the patches I just sent out.  They do some similar things
to the same code.

> @@ -1270,7 +1273,12 @@ void __init setup_bootmem_allocator(void
>  	/*
>  	 * Initialize the boot-time allocator (with low memory only):
>  	 */
> +#ifdef CONFIG_NUMA_EMU
> +	bootmap_size = init_bootmem(max(min_low_pfn, node_start_pfn[0]),
> +				    min(max_low_pfn, node_end_pfn[0]));
> +#else
>  	bootmap_size = init_bootmem(min_low_pfn, max_low_pfn);
> +#endif

This shouldn't be necessary.  Again, take a look at my discontig
separation patches and see if what I did works for you here.

>  	register_bootmem_low_pages(max_low_pfn);
>  
> --- from-0006/arch/i386/mm/numa.c
> +++ to-work/arch/i386/mm/numa.c	2005-09-28 17:49:53.000000000 +0900
> @@ -165,3 +165,103 @@ int early_pfn_to_nid(unsigned long pfn)
>  
>  	return 0;
>  }
> +
> +#ifdef CONFIG_NUMA_EMU
...
> +#endif

Ewwwwww :)  No real need to put new function in a big #ifdef like that.
Can you just create a new file for NUMA emulation?

> --- from-0001/include/asm-i386/numnodes.h
> +++ to-work/include/asm-i386/numnodes.h	2005-09-28 17:49:53.000000000 +0900
> @@ -8,7 +8,7 @@
>  /* Max 16 Nodes */
>  #define NODES_SHIFT	4
>  
> -#elif defined(CONFIG_ACPI_SRAT)
> +#elif defined(CONFIG_ACPI_SRAT) || defined(CONFIG_NUMA_EMU)
>  
>  /* Max 8 Nodes */
>  #define NODES_SHIFT	3

Geez.  We should probably just do those in the Kconfig files.  Would
look much simpler.  But, that's a patch for another day.  This is fine
by itself.

-- Dave

