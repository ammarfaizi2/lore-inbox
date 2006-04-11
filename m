Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWDKKll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWDKKll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDKKlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:41:40 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:63183 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750723AbWDKKl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:41:28 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060411104127.18153.20318.sendpatchset@skynet>
In-Reply-To: <20060411103946.18153.83059.sendpatchset@skynet>
References: <20060411103946.18153.83059.sendpatchset@skynet>
Subject: [PATCH 5/6] Have ia64 use add_active_range() and free_area_init_nodes
Date: Tue, 11 Apr 2006 11:41:27 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Size zones and holes in an architecture independent manner for ia64.

This has only been compile-tested due to lack of a suitable test machine.


 arch/ia64/Kconfig          |    3 +
 arch/ia64/mm/contig.c      |   62 +++++-----------------------------------
 arch/ia64/mm/discontig.c   |   43 +++++----------------------
 arch/ia64/mm/init.c        |   10 ++++++
 include/asm-ia64/meminit.h |    1 
 5 files changed, 30 insertions(+), 89 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/ia64/Kconfig	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/Kconfig	2006-04-10 10:55:25.000000000 +0100
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
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/contig.c	2006-04-10 10:55:25.000000000 +0100
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
@@ -232,71 +216,41 @@ void __init
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
-		vmem_map = (struct page *) 0;
-		free_area_init_node(0, NODE_DATA(0), zones_size, 0,
-				    zholes_size);
+		free_area_init_nodes(max_dma, max_dma,
+				max_low_pfn, max_low_pfn);
 	} else {
 		unsigned long map_size;
 
 		/* allocate virtual_mem_map */
-
 		map_size = PAGE_ALIGN(max_low_pfn * sizeof(struct page));
 		vmalloc_end -= map_size;
 		vmem_map = (struct page *) vmalloc_end;
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
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/discontig.c	2006-04-10 10:55:25.000000000 +0100
@@ -88,6 +88,9 @@ static int __init build_node_maps(unsign
 	min_low_pfn = min(min_low_pfn, bdp->node_boot_start>>PAGE_SHIFT);
 	max_low_pfn = max(max_low_pfn, bdp->node_low_pfn);
 
+	/* Add a known active range */
+	add_active_range(node, start, end);
+
 	return 0;
 }
 
@@ -660,8 +663,7 @@ static __init int count_node_pages(unsig
 void __init paging_init(void)
 {
 	unsigned long max_dma;
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long zholes_size[MAX_NR_ZONES];
+	unsigned long max_pfn = 0;
 	unsigned long pfn_offset = 0;
 	int node;
 
@@ -679,46 +681,17 @@ void __init paging_init(void)
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
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/arch/ia64/mm/init.c	2006-04-10 10:55:25.000000000 +0100
@@ -526,6 +526,16 @@ ia64_pfn_valid (unsigned long pfn)
 EXPORT_SYMBOL(ia64_pfn_valid);
 
 int __init
+register_active_ranges(u64 start, u64 end, void *nid)
+{
+	BUG_ON(nid == NULL);
+	BUG_ON(*(unsigned long *)nid >= MAX_NUMNODES);
+
+	add_active_range(*(unsigned long *)nid, start, end);
+	return 0;
+}
+
+int __init
 find_largest_hole (u64 start, u64 end, void *arg)
 {
 	u64 *max_gap = arg;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-ia64/meminit.h linux-2.6.17-rc1-105-ia64_use_init_nodes/include/asm-ia64/meminit.h
--- linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-ia64/meminit.h	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-105-ia64_use_init_nodes/include/asm-ia64/meminit.h	2006-04-10 10:55:25.000000000 +0100
@@ -56,6 +56,7 @@ extern void efi_memmap_init(unsigned lon
   extern unsigned long vmalloc_end;
   extern struct page *vmem_map;
   extern int find_largest_hole (u64 start, u64 end, void *arg);
+  extern int register_active_ranges (u64 start, u64 end, void *arg);
   extern int create_mem_map_page_table (u64 start, u64 end, void *arg);
 #endif
 
