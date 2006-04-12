Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWDLK7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWDLK7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDLK7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:59:14 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:33246 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932142AbWDLK7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:59:14 -0400
Date: Wed, 12 Apr 2006 11:59:01 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: Bob Picco <bob.picco@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linuxppc-dev@ozlabs.org,
       davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
 independent manner
In-Reply-To: <20060412013824.GF23742@localhost>
Message-ID: <Pine.LNX.4.64.0604121150370.24819@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
 <20060411222029.GA7743@agluck-lia64.sc.intel.com> <20060411232944.GE23742@localhost>
 <Pine.LNX.4.64.0604120053080.10268@skynet.skynet.ie> <20060412013824.GF23742@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006, Bob Picco wrote:

> Mel Gorman wrote:	[Tue Apr 11 2006, 08:02:10PM EDT]
>> On Tue, 11 Apr 2006, Bob Picco wrote:
>>
>>> luck wrote:	[Tue Apr 11 2006, 06:20:29PM EDT]
>>>> On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:
>>>>
>>>>> The patches have only been *compile tested* for ia64 with a flatmem
>>>>> configuration. At attempt was made to boot test on an ancient RS/6000
>>>>> but the vanilla kernel does not boot so I have to investigate there.
>>>>
>>>> The good news: Compilation is clean on the ia64 config variants that
>>>> I usually build (all 10 of them).
>>>>
>>>> The bad (or at least consistent) news: It doesn't boot on an Intel
>>>> Tiger either (oops at kmem_cache_alloc+0x41).
>>>>
>>>> -Tony
>>> I had a reply queued to report the same failure with
>>> DISCONTIG+NUMA+VIRTUAL_MEM_MAP.  This was 2 CPU HP rx2600. I'll take a
>>> closer
>>> look at the code tomorrow.
>>>
>>
>> hmm, ok, so discontig.c is in use which narrows things down. When
>> build_node_maps() is called, I assumed that the start and end pfn passed
>> in was for a valid page range. Was this a valid assumption? When I re-read
> The addresses are a valid physical range. The caution should be that
> filter_rsvd_memory converts the addresses from identity mapped to
> physical. efi_memmap_walk calls back to function with identity mapped
> addresses. What you've done seems okay.

It would have been ok if I spotted it was physical addresses being passed 
into count_node_pages(). add_active_range() expects pfns so a >> PAGE_SHIFT
was missing there.

> BTW - I like want you are attempting to achieve.

Thanks

>> the comment, it implies that memory holes could be within this range which
>> would cause boot failures. If that is the case, the correct thing to do
>> was to call add_active_range() in count_node_pages() instead of
>> build_node_maps().
> Yes that helps because of granules and it boots.  The patch below is applied
> on top of your original post. But..
>
> <Patch Snipped>
>
> Page free/avail accounting is off and I'm done for tonight. I believe it's how
> you treat holes but haven't looked closely yet.
>

Thanks for trying it out so late in the evening. The accounting is off 
because I was passing in physical addresses instead of pfns. The fact it 
booted at all means we probably registered the memory near address 0 by 
accident and it would eventually oops.

>
> Let me wrap my head around this code again. It's been some time.

This is the same patch I posted to Tony that hopefully fix the problems on 
flatmem. The important changes for your discontig machine is;

o Registering in count_node_pages() as your patch fixed
o Converting the physical address passed to count_node_pages() to a PFN

Can you try it out when you're next looking at this? Thanks

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

