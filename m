Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWDXUVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWDXUVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDXUVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:21:34 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:38040 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751222AbWDXUVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:21:10 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060424202109.20409.92624.sendpatchset@skynet>
In-Reply-To: <20060424202009.20409.89016.sendpatchset@skynet>
References: <20060424202009.20409.89016.sendpatchset@skynet>
Subject: [PATCH 3/7] Have x86 use add_active_range() and free_area_init_nodes
Date: Mon, 24 Apr 2006 21:21:09 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Size zones and holes in an architecture independent manner for x86.

This has been boot tested on;

x86 with 4 CPUs, flatmem
x86 on NUMAQ

It needs to be boot tested on an x86 machine that uses SRAT.


 Kconfig        |    8 +---
 kernel/setup.c |   19 +++-------
 kernel/srat.c  |   98 ----------------------------------------------------
 mm/discontig.c |   59 ++++---------------------------
 4 files changed, 17 insertions(+), 167 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/Kconfig linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/Kconfig
--- linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/Kconfig	2006-04-19 04:00:49.000000000 +0100
+++ linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/Kconfig	2006-04-24 15:50:57.000000000 +0100
@@ -569,12 +569,10 @@ config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SPARSEMEM_ENABLE
 
-source "mm/Kconfig"
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
 
-config HAVE_ARCH_EARLY_PFN_TO_NID
-	bool
-	default y
-	depends on NUMA
+source "mm/Kconfig"
 
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/kernel/setup.c linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/kernel/setup.c
--- linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/kernel/setup.c	2006-04-19 04:00:49.000000000 +0100
+++ linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/kernel/setup.c	2006-04-24 15:50:57.000000000 +0100
@@ -1186,22 +1186,15 @@ static unsigned long __init setup_memory
 
 void __init zone_sizes_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-	unsigned int max_dma, low;
+	unsigned int max_dma;
+#ifndef CONFIG_HIGHMEM
+	unsigned long highend_pfn = max_low_pfn;
+#endif
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	low = max_low_pfn;
 
-	if (low < max_dma)
-		zones_size[ZONE_DMA] = low;
-	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-		zones_size[ZONE_HIGHMEM] = highend_pfn - low;
-#endif
-	}
-	free_area_init(zones_size);
+	add_active_range(0, 0, highend_pfn);
+	free_area_init_nodes(max_dma, max_dma, max_low_pfn, highend_pfn);
 }
 #else
 extern unsigned long __init setup_memory(void);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/kernel/srat.c linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/kernel/srat.c
--- linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/kernel/srat.c	2006-04-19 04:00:49.000000000 +0100
+++ linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/kernel/srat.c	2006-04-24 15:50:57.000000000 +0100
@@ -56,8 +56,6 @@ struct node_memory_chunk_s {
 static struct node_memory_chunk_s node_memory_chunk[MAXCHUNKS];
 
 static int num_memory_chunks;		/* total number of memory chunks */
-static int zholes_size_init;
-static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -137,50 +135,6 @@ static void __init parse_memory_affinity
 		 "enabled and removable" : "enabled" ) );
 }
 
-#if MAX_NR_ZONES != 4
-#error "MAX_NR_ZONES != 4, chunk_to_zone requires review"
-#endif
-/* Take a chunk of pages from page frame cstart to cend and count the number
- * of pages in each zone, returned via zones[].
- */
-static __init void chunk_to_zones(unsigned long cstart, unsigned long cend, 
-		unsigned long *zones)
-{
-	unsigned long max_dma;
-	extern unsigned long max_low_pfn;
-
-	int z;
-	unsigned long rend;
-
-	/* FIXME: MAX_DMA_ADDRESS and max_low_pfn are trying to provide
-	 * similarly scoped information and should be handled in a consistant
-	 * manner.
-	 */
-	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-
-	/* Split the hole into the zones in which it falls.  Repeatedly
-	 * take the segment in which the remaining hole starts, round it
-	 * to the end of that zone.
-	 */
-	memset(zones, 0, MAX_NR_ZONES * sizeof(long));
-	while (cstart < cend) {
-		if (cstart < max_dma) {
-			z = ZONE_DMA;
-			rend = (cend < max_dma)? cend : max_dma;
-
-		} else if (cstart < max_low_pfn) {
-			z = ZONE_NORMAL;
-			rend = (cend < max_low_pfn)? cend : max_low_pfn;
-
-		} else {
-			z = ZONE_HIGHMEM;
-			rend = cend;
-		}
-		zones[z] += rend - cstart;
-		cstart = rend;
-	}
-}
-
 /*
  * The SRAT table always lists ascending addresses, so can always
  * assume that the first "start" address that you see is the real
@@ -233,7 +187,6 @@ static int __init acpi20_parse_srat(stru
 
 	memset(pxm_bitmap, 0, sizeof(pxm_bitmap));	/* init proximity domain bitmap */
 	memset(node_memory_chunk, 0, sizeof(node_memory_chunk));
-	memset(zholes_size, 0, sizeof(zholes_size));
 
 	/* -1 in these maps means not available */
 	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
@@ -414,54 +367,3 @@ out_err:
 	printk("failed to get NUMA memory information from SRAT table\n");
 	return 0;
 }
-
-/* For each node run the memory list to determine whether there are
- * any memory holes.  For each hole determine which ZONE they fall
- * into.
- *
- * NOTE#1: this requires knowledge of the zone boundries and so
- * _cannot_ be performed before those are calculated in setup_memory.
- * 
- * NOTE#2: we rely on the fact that the memory chunks are ordered by
- * start pfn number during setup.
- */
-static void __init get_zholes_init(void)
-{
-	int nid;
-	int c;
-	int first;
-	unsigned long end = 0;
-
-	for_each_online_node(nid) {
-		first = 1;
-		for (c = 0; c < num_memory_chunks; c++){
-			if (node_memory_chunk[c].nid == nid) {
-				if (first) {
-					end = node_memory_chunk[c].end_pfn;
-					first = 0;
-
-				} else {
-					/* Record any gap between this chunk
-					 * and the previous chunk on this node
-					 * against the zones it spans.
-					 */
-					chunk_to_zones(end,
-						node_memory_chunk[c].start_pfn,
-						&zholes_size[nid * MAX_NR_ZONES]);
-				}
-			}
-		}
-	}
-}
-
-unsigned long * __init get_zholes_size(int nid)
-{
-	if (!zholes_size_init) {
-		zholes_size_init++;
-		get_zholes_init();
-	}
-	if (nid >= MAX_NUMNODES || !node_online(nid))
-		printk("%s: nid = %d is invalid/offline. num_online_nodes = %d",
-		       __FUNCTION__, nid, num_online_nodes());
-	return &zholes_size[nid * MAX_NR_ZONES];
-}
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/mm/discontig.c linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/mm/discontig.c
--- linux-2.6.17-rc2-102-powerpc_use_init_nodes/arch/i386/mm/discontig.c	2006-04-19 04:00:49.000000000 +0100
+++ linux-2.6.17-rc2-103-x86_use_init_nodes/arch/i386/mm/discontig.c	2006-04-24 15:50:57.000000000 +0100
@@ -157,21 +157,6 @@ static void __init find_max_pfn_node(int
 		BUG();
 }
 
-/* Find the owning node for a pfn. */
-int early_pfn_to_nid(unsigned long pfn)
-{
-	int nid;
-
-	for_each_node(nid) {
-		if (node_end_pfn[nid] == 0)
-			break;
-		if (node_start_pfn[nid] <= pfn && node_end_pfn[nid] >= pfn)
-			return nid;
-	}
-
-	return 0;
-}
-
 /* 
  * Allocate memory for the pg_data_t for this node via a crude pre-bootmem
  * method.  For node zero take this from the bottom of memory, for
@@ -352,45 +337,17 @@ unsigned long __init setup_memory(void)
 void __init zone_sizes_init(void)
 {
 	int nid;
-
+	unsigned long max_dma_pfn;
 
 	for_each_online_node(nid) {
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-		unsigned long *zholes_size;
-		unsigned int max_dma;
-
-		unsigned long low = max_low_pfn;
-		unsigned long start = node_start_pfn[nid];
-		unsigned long high = node_end_pfn[nid];
-
-		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-
-		if (node_has_online_mem(nid)){
-			if (start > low) {
-#ifdef CONFIG_HIGHMEM
-				BUG_ON(start > high);
-				zones_size[ZONE_HIGHMEM] = high - start;
-#endif
-			} else {
-				if (low < max_dma)
-					zones_size[ZONE_DMA] = low;
-				else {
-					BUG_ON(max_dma > low);
-					BUG_ON(low > high);
-					zones_size[ZONE_DMA] = max_dma;
-					zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-					zones_size[ZONE_HIGHMEM] = high - low;
-#endif
-				}
-			}
-		}
-
-		zholes_size = get_zholes_size(nid);
-
-		free_area_init_node(nid, NODE_DATA(nid), zones_size, start,
-				zholes_size);
+		if (node_has_online_mem(nid))
+			add_active_range(nid, node_start_pfn[nid],
+							node_end_pfn[nid]);
 	}
+
+	max_dma_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+	free_area_init_nodes(max_dma_pfn, max_dma_pfn,
+						max_low_pfn, highend_pfn);
 	return;
 }
 
