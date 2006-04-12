Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWDLKuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWDLKuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWDLKuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:50:51 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:49629 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932148AbWDLKuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:50:51 -0400
Date: Wed, 12 Apr 2006 11:50:31 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
 independent manner
In-Reply-To: <20060412000500.GA8532@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
 <20060411222029.GA7743@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
 <20060412000500.GA8532@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006, Luck, Tony wrote:

> On Wed, Apr 12, 2006 at 12:23:45AM +0100, Mel Gorman wrote:
>> Darn.
>>
>> o Did it boot on other IA64 machines or was the Tiger the first boot failure?
>
> I only tried to boot on the Tiger.
>

ok, based on your console log, I'm pretty sure it would have broken on 
almost any IA64.

>> o Possibly a stupid question but does the Tiger configuration use the
>>    flatmem memory model, sparsemem or discontig?
>
> I built using arch/ia64/configs/tiger_defconfig - a FLATMEM config with
> VIRT_MEM_MAP=y.  The machine has 4G of memory, 2G at 0-2G, and 2G at 6G-8G
> (so it is somewhat sparse ... but this is pretty normal for an ia64 with
>> 2G).
>

That's useful to know. It means I know what pfn ranges I expect to see 
being passed to add_active_range().

>> If it's flatmem, I noticed I made a stupid mistake where vmem_map is not
>> getting set to (void *)0 for machines with small memory holes. Nothing
>> else really obvious jumped out at me.
>>
>> I've attached a patch called "105-ia64_use_init_nodes.patch". Can you
>> reverse Patch 5/6 and apply this one instead please? I've also attached
>> 107-debug.diff that applies on top of patch 6/6. It just prints out
>> debugging information during startup that may tell me where I went wrong
>> in arch/ia64. I'd really appreciate it if you could use both patches, let
>> me know if it still fails to boot and send me the console log of the
>> machine starting up if it fails so I can make guesses as to what is going
>> wrong.
>>
>> Thanks a lot for trying the patches out on ia64. It was the one arch of
>> the set I had no chance to test with at all :/
>
> Ok, I cloned a branch from patch4, applied the new patch 5, git-cherry-picked
> patch 6, and then applied the debug patch7.
>
> Here's the console log:
>
> <snip snip>
> add_active_range(0, 16140901064512634880, 16140901066637049856): New
> add_active_range(0, 16140901066641899520, 16140901066642489344): New
> add_active_range(0, 16140901070938308608, 16140901073083760640): New
> add_active_range(0, 16140901073084219392, 16140901073085480960): New
> <snip snip>

Good man Mel! The callback register_active_ranges() callback is getting 
*virtual addresses*, not PFNs (which is brutally obvious now!). For 
discontig, there is a similar story. count_node_pages() is getting a 
*physical address*, not a pfn (also called start which is a bit confusing 
but a different problem).

So some thinking out loud to see if you spot problems;

o PAGE_OFFSET seems to be 16140901064495857664 from the header file
o Instead of using add_active_range(node, start, end), assume I had used
   add_active_range(node,
 		(start - PAGE_OFFSET) >> PAGE_SHIFT,
 		(end - PAGE_OFFSET) >> PAGE_SHIFT);

That would have made the console log look something like;

add_active_range(0, 4096, 522752): New
add_active_range(0, 523936, 524080): New
add_active_range(0, 1572864, 2096656): New
add_active_range(0, 2096768, 2097076): New

That seems to register memory about the 0-2G mark and 6-8G with some small 
holes here and there. Sounds like what you expected to happen. In case the 
1:1 virt->phys mapping is not always true on IA64, I decided to use __pa() 
instead of PAGE_OFFSET like;

add_active_range(node, __pa(start) >> PAGE_SHIFT, __pa(end) >> PAGE_SHIFT);

Is this the correct thing to do or is "start - PAGE_OFFSET" safer? 
Optimistically assuming __pa() is ok, the following patch (which replaces 
Patch 5/6 again) should boot (passed compile testing here). If it doesn't, 
can you send the console log again please?

Thanks again.

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig	2006-04-11 23:31:38.000000000 +0100
@@ -352,6 +352,9 @@ config NUMA
  	  Access).  This option is for configuring high-end multiprocessor
  	  server systems.  If in doubt, say N.

+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
  # VIRTUAL_MEM_MAP and FLAT_NODE_MEM_MAP are functionally equivalent.
  # VIRTUAL_MEM_MAP has been retained for historical reasons.
  config VIRTUAL_MEM_MAP
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/mm/contig.c linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/contig.c
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/mm/contig.c	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/contig.c	2006-04-11 23:56:45.000000000 +0100
@@ -26,10 +26,6 @@
  #include <asm/sections.h>
  #include <asm/mca.h>

-#ifdef CONFIG_VIRTUAL_MEM_MAP
-static unsigned long num_dma_physpages;
-#endif
-
  /**
   * show_mem - display a memory statistics summary
   *
@@ -212,18 +208,6 @@ count_pages (u64 start, u64 end, void *a
  	return 0;
  }

-#ifdef CONFIG_VIRTUAL_MEM_MAP
-static int
-count_dma_pages (u64 start, u64 end, void *arg)
-{
-	unsigned long *count = arg;
-
-	if (start < MAX_DMA_ADDRESS)
-		*count += (min(end, MAX_DMA_ADDRESS) - start) >> PAGE_SHIFT;
-	return 0;
-}
-#endif
-
  /*
   * Set up the page tables.
   */
@@ -232,47 +216,24 @@ void __init
  paging_init (void)
  {
  	unsigned long max_dma;
-	unsigned long zones_size[MAX_NR_ZONES];
  #ifdef CONFIG_VIRTUAL_MEM_MAP
-	unsigned long zholes_size[MAX_NR_ZONES];
+	unsigned long nid = 0;
  	unsigned long max_gap;
  #endif

-	/* initialize mem_map[] */
-
-	memset(zones_size, 0, sizeof(zones_size));
-
  	num_physpages = 0;
  	efi_memmap_walk(count_pages, &num_physpages);

  	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;

  #ifdef CONFIG_VIRTUAL_MEM_MAP
-	memset(zholes_size, 0, sizeof(zholes_size));
-
-	num_dma_physpages = 0;
-	efi_memmap_walk(count_dma_pages, &num_dma_physpages);
-
-	if (max_low_pfn < max_dma) {
-		zones_size[ZONE_DMA] = max_low_pfn;
-		zholes_size[ZONE_DMA] = max_low_pfn - num_dma_physpages;
-	} else {
-		zones_size[ZONE_DMA] = max_dma;
-		zholes_size[ZONE_DMA] = max_dma - num_dma_physpages;
-		if (num_physpages > num_dma_physpages) {
-			zones_size[ZONE_NORMAL] = max_low_pfn - max_dma;
-			zholes_size[ZONE_NORMAL] =
-				((max_low_pfn - max_dma) -
-				 (num_physpages - num_dma_physpages));
-		}
-	}
-
  	max_gap = 0;
+	efi_memmap_walk(register_active_ranges, &nid);
  	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
  	if (max_gap < LARGE_GAP) {
  		vmem_map = (struct page *) 0;
-		free_area_init_node(0, NODE_DATA(0), zones_size, 0,
-				    zholes_size);
+		free_area_init_nodes(max_dma, max_dma,
+				max_low_pfn, max_low_pfn);
  	} else {
  		unsigned long map_size;

@@ -284,19 +245,14 @@ paging_init (void)
  		efi_memmap_walk(create_mem_map_page_table, NULL);

  		NODE_DATA(0)->node_mem_map = vmem_map;
-		free_area_init_node(0, NODE_DATA(0), zones_size,
-				    0, zholes_size);
+		free_area_init_nodes(max_dma, max_dma,
+				max_low_pfn, max_low_pfn);

  		printk("Virtual mem_map starts at 0x%p\n", mem_map);
  	}
  #else /* !CONFIG_VIRTUAL_MEM_MAP */
-	if (max_low_pfn < max_dma)
-		zones_size[ZONE_DMA] = max_low_pfn;
-	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = max_low_pfn - max_dma;
-	}
-	free_area_init(zones_size);
+	add_active_range(0, 0, max_low_pfn);
+	free_area_init_nodes(max_dma, max_dma, max_low_pfn, max_low_pfn);
  #endif /* !CONFIG_VIRTUAL_MEM_MAP */
  	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
  }
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/mm/discontig.c linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/discontig.c
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/mm/discontig.c	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/discontig.c	2006-04-12 11:27:55.000000000 +0100
@@ -647,6 +647,7 @@ static __init int count_node_pages(unsig
  				     end >> PAGE_SHIFT);
  	mem_data[node].min_pfn = min(mem_data[node].min_pfn,
  				     start >> PAGE_SHIFT);
+	add_active_range(node, start >> PAGE_SHIFT, end >> PAGE_SHIFT);

  	return 0;
  }
@@ -660,9 +661,8 @@ static __init int count_node_pages(unsig
  void __init paging_init(void)
  {
  	unsigned long max_dma;
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long zholes_size[MAX_NR_ZONES];
  	unsigned long pfn_offset = 0;
+	unsigned long max_pfn = 0;
  	int node;

  	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
@@ -679,46 +679,17 @@ void __init paging_init(void)
  #endif

  	for_each_online_node(node) {
-		memset(zones_size, 0, sizeof(zones_size));
-		memset(zholes_size, 0, sizeof(zholes_size));
-
  		num_physpages += mem_data[node].num_physpages;
-
-		if (mem_data[node].min_pfn >= max_dma) {
-			/* All of this node's memory is above ZONE_DMA */
-			zones_size[ZONE_NORMAL] = mem_data[node].max_pfn -
-				mem_data[node].min_pfn;
-			zholes_size[ZONE_NORMAL] = mem_data[node].max_pfn -
-				mem_data[node].min_pfn -
-				mem_data[node].num_physpages;
-		} else if (mem_data[node].max_pfn < max_dma) {
-			/* All of this node's memory is in ZONE_DMA */
-			zones_size[ZONE_DMA] = mem_data[node].max_pfn -
-				mem_data[node].min_pfn;
-			zholes_size[ZONE_DMA] = mem_data[node].max_pfn -
-				mem_data[node].min_pfn -
-				mem_data[node].num_dma_physpages;
-		} else {
-			/* This node has memory in both zones */
-			zones_size[ZONE_DMA] = max_dma -
-				mem_data[node].min_pfn;
-			zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] -
-				mem_data[node].num_dma_physpages;
-			zones_size[ZONE_NORMAL] = mem_data[node].max_pfn -
-				max_dma;
-			zholes_size[ZONE_NORMAL] = zones_size[ZONE_NORMAL] -
-				(mem_data[node].num_physpages -
-				 mem_data[node].num_dma_physpages);
-		}
-
  		pfn_offset = mem_data[node].min_pfn;

  #ifdef CONFIG_VIRTUAL_MEM_MAP
  		NODE_DATA(node)->node_mem_map = vmem_map + pfn_offset;
  #endif
-		free_area_init_node(node, NODE_DATA(node), zones_size,
-				    pfn_offset, zholes_size);
+		if (mem_data[node].max_pfn > max_pfn)
+			max_pfn = mem_data[node].max_pfn;
  	}

+	free_area_init_nodes(max_dma, max_dma, max_pfn, max_pfn);
+
  	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
  }
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/mm/init.c linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/init.c
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/mm/init.c	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/init.c	2006-04-12 11:07:10.000000000 +0100
@@ -539,6 +539,18 @@ find_largest_hole (u64 start, u64 end, v
  	last_end = end;
  	return 0;
  }
+
+int __init
+register_active_ranges(u64 start, u64 end, void *nid)
+{
+	BUG_ON(nid == NULL);
+	BUG_ON(*(unsigned long *)nid >= MAX_NUMNODES);
+
+	add_active_range(*(unsigned long *)nid,
+				__pa(start) >> PAGE_SHIFT,
+				__pa(end) >> PAGE_SHIFT);
+	return 0;
+}
  #endif /* CONFIG_VIRTUAL_MEM_MAP */

  static int __init
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-ia64/meminit.h linux-2.6.17-rc1-105-ia64_use_init_nodes/include/asm-ia64/meminit.h
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-ia64/meminit.h	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/include/asm-ia64/meminit.h	2006-04-11 23:34:58.000000000 +0100
@@ -56,6 +56,7 @@ extern void efi_memmap_init(unsigned lon
    extern unsigned long vmalloc_end;
    extern struct page *vmem_map;
    extern int find_largest_hole (u64 start, u64 end, void *arg);
+  extern int register_active_ranges (u64 start, u64 end, void *arg);
    extern int create_mem_map_page_table (u64 start, u64 end, void *arg);
  #endif

