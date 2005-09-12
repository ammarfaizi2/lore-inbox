Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVILRxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVILRxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVILRxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:53:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18326 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751103AbVILRxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:53:22 -0400
Subject: [RFC][PATCH 1/2] i386: consolidate discontig functions into normal ones
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 12 Sep 2005 10:53:19 -0700
Message-Id: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are quite a few functions in i386's discontig.c which are
actually NUMA-specific, not discontigmem.  They are also very
similar to the generic, flat functions found in setup.c.

This patch takes the versions in setup.c and makes them work
for both NUMA and non-NUMA cases.  In the process, quite a
few nasty #ifdef and externs can be removed.

One of the main mechanisms to do this is that highstart_pfn
and highend_pfn are now gone, replaced by node_start/end_pfn[].
However, this has no real impact on storage space, because
those arrays are declared with a length of MAX_NUMNODES, which
is 1 when NUMA is off.



---

 arch/i386/kernel/signal.c                |    0 
 memhotplug-dave/arch/i386/kernel/setup.c |  167 ++++++++++++++++++----
 memhotplug-dave/arch/i386/mm/discontig.c |  232 +++----------------------------
 memhotplug-dave/arch/i386/mm/init.c      |   43 +++--
 4 files changed, 186 insertions(+), 256 deletions(-)

diff -puN arch/i386/mm/init.c~i386-discontig-consolidate0 arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~i386-discontig-consolidate0	2005-09-12 10:52:26.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2005-09-12 10:52:26.000000000 -0700
@@ -44,7 +44,6 @@
 unsigned int __VMALLOC_RESERVE = 128 << 20;
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-unsigned long highstart_pfn, highend_pfn;
 
 static int noinline do_test_wp_bit(void);
 
@@ -310,18 +309,33 @@ void online_page(struct page *page)
 	add_one_highpage_hotplug(page, page_to_pfn(page));
 }
 
-
-#ifdef CONFIG_NUMA
-extern void set_highmem_pages_init(int);
-#else
-static void __init set_highmem_pages_init(int bad_ppro)
+void __init set_highmem_pages_init(int bad_ppro)
 {
-	int pfn;
-	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
-		add_one_highpage_init(pfn_to_page(pfn), pfn, bad_ppro);
+	struct zone *zone;
+	struct page *page;
+
+	for_each_zone(zone) {
+		unsigned long node_pfn, zone_start_pfn, zone_end_pfn;
+
+		if (!is_highmem(zone))
+			continue;
+
+		zone_start_pfn = zone->zone_start_pfn;
+		zone_end_pfn = zone_start_pfn + zone->spanned_pages;
+
+		printk("Initializing %s for node %d (%08lx:%08lx)\n",
+				zone->name, zone->zone_pgdat->node_id,
+				zone_start_pfn, zone_end_pfn);
+
+		for (node_pfn = zone_start_pfn; node_pfn < zone_end_pfn; node_pfn++) {
+			if (!pfn_valid(node_pfn))
+				continue;
+			page = pfn_to_page(node_pfn);
+			add_one_highpage_init(page, node_pfn, bad_ppro);
+		}
+	}
 	totalram_pages += totalhigh_pages;
 }
-#endif /* CONFIG_FLATMEM */
 
 #else
 #define kmap_init() do { } while (0)
@@ -556,11 +570,6 @@ static void __init test_wp_bit(void)
 
 static void __init set_max_mapnr_init(void)
 {
-#ifdef CONFIG_HIGHMEM
-	num_physpages = highend_pfn;
-#else
-	num_physpages = max_low_pfn;
-#endif
 #ifdef CONFIG_FLATMEM
 	max_mapnr = num_physpages;
 #endif
@@ -594,11 +603,7 @@ void __init mem_init(void)
  
 	set_max_mapnr_init();
 
-#ifdef CONFIG_HIGHMEM
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
-#else
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
-#endif
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
diff -puN arch/i386/mm/discontig.c~i386-discontig-consolidate0 arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~i386-discontig-consolidate0	2005-09-12 10:52:26.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-09-12 10:52:26.000000000 -0700
@@ -39,19 +39,6 @@
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
-bootmem_data_t node0_bdata;
-
-/*
- * numa interface - we expect the numa architecture specfic code to have
- *                  populated the following initialisation.
- *
- * 1) node_online_map  - the map of all nodes configured (online) in the system
- * 2) node_start_pfn   - the starting page frame number for a node
- * 3) node_end_pfn     - the ending page fram number for a node
- */
-unsigned long node_start_pfn[MAX_NUMNODES] __read_mostly;
-unsigned long node_end_pfn[MAX_NUMNODES] __read_mostly;
-
 
 #ifdef CONFIG_DISCONTIGMEM
 /*
@@ -103,7 +90,6 @@ extern void add_one_highpage_init(struct
 
 extern struct e820map e820;
 extern unsigned long init_pg_tables_end;
-extern unsigned long highend_pfn, highstart_pfn;
 extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
@@ -119,44 +105,6 @@ void set_pmd_pfn(unsigned long vaddr, un
 void *node_remap_end_vaddr[MAX_NUMNODES];
 void *node_remap_alloc_vaddr[MAX_NUMNODES];
 
-/*
- * FLAT - support for basic PC memory model with discontig enabled, essentially
- *        a single node with all available processors in it with a flat
- *        memory map.
- */
-int __init get_memcfg_numa_flat(void)
-{
-	printk("NUMA - single node, flat memory mode\n");
-
-	/* Run the memory configuration and find the top of memory. */
-	find_max_pfn();
-	node_start_pfn[0] = 0;
-	node_end_pfn[0] = max_pfn;
-	memory_present(0, 0, max_pfn);
-
-        /* Indicate there is one node available. */
-	nodes_clear(node_online_map);
-	node_set_online(0);
-	return 1;
-}
-
-/*
- * Find the highest page frame number we have available for the node
- */
-static void __init find_max_pfn_node(int nid)
-{
-	if (node_end_pfn[nid] > max_pfn)
-		node_end_pfn[nid] = max_pfn;
-	/*
-	 * if a user has given mem=XXXX, then we need to make sure 
-	 * that the node _starts_ before that, too, not just ends
-	 */
-	if (node_start_pfn[nid] > max_pfn)
-		node_start_pfn[nid] = max_pfn;
-	if (node_start_pfn[nid] > node_end_pfn[nid])
-		BUG();
-}
-
 /* Find the owning node for a pfn. */
 int early_pfn_to_nid(unsigned long pfn)
 {
@@ -179,6 +127,7 @@ int early_pfn_to_nid(unsigned long pfn)
  * node local data in physically node local memory.  See setup_memory()
  * for details.
  */
+static bootmem_data_t node0_bdata;
 static void __init allocate_pgdat(int nid)
 {
 	if (nid && node_has_online_mem(nid))
@@ -186,6 +135,30 @@ static void __init allocate_pgdat(int ni
 	else {
 		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
 		min_low_pfn += PFN_UP(sizeof(pg_data_t));
+		memset(NODE_DATA(0), 0, sizeof(struct pglist_data));
+		NODE_DATA(0)->bdata = &node0_bdata;
+	}
+}
+
+void setup_numa_kva_remap(void)
+{
+	int nid;
+	for_each_online_node(nid) {
+		if (NODE_DATA(nid))
+			continue;
+		node_remap_start_vaddr[nid] = pfn_to_kaddr(
+				max_low_pfn + node_remap_offset[nid]);
+		/* Init the node remap allocator */
+		node_remap_end_vaddr[nid] = node_remap_start_vaddr[nid] +
+			(node_remap_size[nid] * PAGE_SIZE);
+		node_remap_alloc_vaddr[nid] = node_remap_start_vaddr[nid] +
+			ALIGN(sizeof(pg_data_t), PAGE_SIZE);
+
+		allocate_pgdat(nid);
+		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
+			(ulong) node_remap_start_vaddr[nid],
+			(ulong) pfn_to_kaddr(max_low_pfn
+			   + node_remap_offset[nid] + node_remap_size[nid]));
 	}
 }
 
@@ -220,7 +193,7 @@ void __init remap_numa_kva(void)
 	}
 }
 
-static unsigned long calculate_numa_remap_pages(void)
+unsigned long calculate_numa_remap_pages(void)
 {
 	int nid;
 	unsigned long size, reserve_pages = 0;
@@ -281,156 +254,3 @@ static unsigned long calculate_numa_rema
 			reserve_pages);
 	return reserve_pages;
 }
-
-extern void setup_bootmem_allocator(void);
-unsigned long __init setup_memory(void)
-{
-	int nid;
-	unsigned long system_start_pfn, system_max_low_pfn;
-	unsigned long reserve_pages;
-
-	/*
-	 * When mapping a NUMA machine we allocate the node_mem_map arrays
-	 * from node local memory.  They are then mapped directly into KVA
-	 * between zone normal and vmalloc space.  Calculate the size of
-	 * this space and use it to adjust the boundry between ZONE_NORMAL
-	 * and ZONE_HIGHMEM.
-	 */
-	find_max_pfn();
-	get_memcfg_numa();
-
-	reserve_pages = calculate_numa_remap_pages();
-
-	/* partially used pages are not usable - thus round upwards */
-	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
-
-	system_max_low_pfn = max_low_pfn = find_max_low_pfn() - reserve_pages;
-	printk("reserve_pages = %ld find_max_low_pfn() ~ %ld\n",
-			reserve_pages, max_low_pfn + reserve_pages);
-	printk("max_pfn = %ld\n", max_pfn);
-#ifdef CONFIG_HIGHMEM
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > system_max_low_pfn)
-		highstart_pfn = system_max_low_pfn;
-	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-	       pages_to_mb(highend_pfn - highstart_pfn));
-#endif
-	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
-			pages_to_mb(system_max_low_pfn));
-	printk("min_low_pfn = %ld, max_low_pfn = %ld, highstart_pfn = %ld\n", 
-			min_low_pfn, max_low_pfn, highstart_pfn);
-
-	printk("Low memory ends at vaddr %08lx\n",
-			(ulong) pfn_to_kaddr(max_low_pfn));
-	for_each_online_node(nid) {
-		node_remap_start_vaddr[nid] = pfn_to_kaddr(
-				highstart_pfn + node_remap_offset[nid]);
-		/* Init the node remap allocator */
-		node_remap_end_vaddr[nid] = node_remap_start_vaddr[nid] +
-			(node_remap_size[nid] * PAGE_SIZE);
-		node_remap_alloc_vaddr[nid] = node_remap_start_vaddr[nid] +
-			ALIGN(sizeof(pg_data_t), PAGE_SIZE);
-
-		allocate_pgdat(nid);
-		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
-			(ulong) node_remap_start_vaddr[nid],
-			(ulong) pfn_to_kaddr(highstart_pfn
-			   + node_remap_offset[nid] + node_remap_size[nid]));
-	}
-	printk("High memory starts at vaddr %08lx\n",
-			(ulong) pfn_to_kaddr(highstart_pfn));
-	vmalloc_earlyreserve = reserve_pages * PAGE_SIZE;
-	for_each_online_node(nid)
-		find_max_pfn_node(nid);
-
-	memset(NODE_DATA(0), 0, sizeof(struct pglist_data));
-	NODE_DATA(0)->bdata = &node0_bdata;
-	setup_bootmem_allocator();
-	return max_low_pfn;
-}
-
-void __init zone_sizes_init(void)
-{
-	int nid;
-
-	/*
-	 * Insert nodes into pgdat_list backward so they appear in order.
-	 * Clobber node 0's links and NULL out pgdat_list before starting.
-	 */
-	pgdat_list = NULL;
-	for (nid = MAX_NUMNODES - 1; nid >= 0; nid--) {
-		if (!node_online(nid))
-			continue;
-		NODE_DATA(nid)->pgdat_next = pgdat_list;
-		pgdat_list = NODE_DATA(nid);
-	}
-
-	for_each_online_node(nid) {
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
-	}
-	return;
-}
-
-void __init set_highmem_pages_init(int bad_ppro) 
-{
-#ifdef CONFIG_HIGHMEM
-	struct zone *zone;
-	struct page *page;
-
-	for_each_zone(zone) {
-		unsigned long node_pfn, zone_start_pfn, zone_end_pfn;
-
-		if (!is_highmem(zone))
-			continue;
-
-		zone_start_pfn = zone->zone_start_pfn;
-		zone_end_pfn = zone_start_pfn + zone->spanned_pages;
-
-		printk("Initializing %s for node %d (%08lx:%08lx)\n",
-				zone->name, zone->zone_pgdat->node_id,
-				zone_start_pfn, zone_end_pfn);
-
-		for (node_pfn = zone_start_pfn; node_pfn < zone_end_pfn; node_pfn++) {
-			if (!pfn_valid(node_pfn))
-				continue;
-			page = pfn_to_page(node_pfn);
-			add_one_highpage_init(page, node_pfn, bad_ppro);
-		}
-	}
-	totalram_pages += totalhigh_pages;
-#endif
-}
diff -puN mm/page_alloc.c~i386-discontig-consolidate0 mm/page_alloc.c
diff -puN mm/bootmem.c~i386-discontig-consolidate0 mm/bootmem.c
diff -puN arch/i386/kernel/setup.c~i386-discontig-consolidate0 arch/i386/kernel/setup.c
--- memhotplug/arch/i386/kernel/setup.c~i386-discontig-consolidate0	2005-09-12 10:52:26.000000000 -0700
+++ memhotplug-dave/arch/i386/kernel/setup.c	2005-09-12 10:52:26.000000000 -0700
@@ -51,6 +51,7 @@
 #include <asm/apic.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
+#include <asm/mmzone.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include <asm/sections.h>
@@ -365,6 +366,37 @@ static void __init probe_roms(void)
 	}
 }
 
+/*
+ * numa interface - we expect the numa architecture specfic code to have
+ *                  populated the following initialisation.
+ *
+ * 1) node_online_map  - the map of all nodes configured (online) in the system
+ * 2) node_start_pfn   - the starting page frame number for a node
+ * 3) node_end_pfn     - the ending page fram number for a node
+ */
+unsigned long node_start_pfn[MAX_NUMNODES] __read_mostly;
+unsigned long node_end_pfn[MAX_NUMNODES] __read_mostly;
+bootmem_data_t node0_bdata;
+
+/*
+ * FLAT - support for basic PC memory model with discontig enabled, essentially
+ *        a single node with all available processors in it with a flat
+ *        memory map.
+ */
+int __init get_memcfg_numa_flat(void)
+{
+	printk("NUMA - single node, flat memory mode\n");
+
+	/* Run the memory configuration and find the top of memory. */
+	node_start_pfn[0] = 0;
+	node_end_pfn[0] = max_pfn;
+
+        /* Indicate there is one node available. */
+	nodes_clear(node_online_map);
+	node_set_online(0);
+	return 1;
+}
+
 static void __init limit_regions(unsigned long long size)
 {
 	unsigned long long current_addr = 0;
@@ -1111,59 +1143,132 @@ static void __init reserve_ebda_region(v
 		reserve_bootmem(addr, PAGE_SIZE);	
 }
 
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-void __init setup_bootmem_allocator(void);
-static unsigned long __init setup_memory(void)
+static void __init find_max_pfn_node(int nid)
 {
+	if (node_end_pfn[nid] > max_pfn)
+		node_end_pfn[nid] = max_pfn;
 	/*
-	 * partially used pages are not usable - thus
-	 * we are rounding upwards:
+	 * if a user has given mem=XXXX, then we need to make sure
+	 * that the node _starts_ before that, too, not just ends
 	 */
-	min_low_pfn = PFN_UP(init_pg_tables_end);
+	if (node_start_pfn[nid] > max_pfn)
+		node_start_pfn[nid] = max_pfn;
+	if (node_start_pfn[nid] > node_end_pfn[nid])
+		BUG();
+}
 
+unsigned long calculate_numa_remap_pages(void);
+void setup_numa_kva_remap(void);
+void __init setup_bootmem_allocator(void);
+unsigned long __init setup_memory(void)
+{
+	int nid;
+	unsigned long reserve_pages;
+
+	/*
+	 * When mapping a NUMA machine we allocate the node_mem_map arrays
+	 * from node local memory.  They are then mapped directly into KVA
+	 * between zone normal and vmalloc space.  Calculate the size of
+	 * this space and use it to adjust the boundry between ZONE_NORMAL
+	 * and ZONE_HIGHMEM.
+	 */
 	find_max_pfn();
+	get_memcfg_numa();
+	for_each_online_node(nid)
+		num_physpages = max(num_physpages, node_end_pfn[nid]);
 
-	max_low_pfn = find_max_low_pfn();
+	reserve_pages = calculate_numa_remap_pages();
 
+	/* partially used pages are not usable - thus round upwards */
+	min_low_pfn = PFN_UP(init_pg_tables_end);
+	max_low_pfn = find_max_low_pfn() - reserve_pages;
+
+	if (reserve_pages)
+		printk("reserve_pages = %ld find_max_low_pfn() ~ %ld\n",
+				reserve_pages, max_low_pfn + reserve_pages);
+	printk(KERN_DEBUG "max_pfn = %ld\n", max_pfn);
 #ifdef CONFIG_HIGHMEM
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > max_low_pfn) {
-		highstart_pfn = max_low_pfn;
-	}
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		pages_to_mb(highend_pfn - highstart_pfn));
+	       pages_to_mb(max_pfn - max_low_pfn));
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
-			pages_to_mb(max_low_pfn));
+			 pages_to_mb(max_low_pfn - min_low_pfn));
+	printk(KERN_DEBUG "min_low_pfn = %ld, max_low_pfn = %ld\n",
+			min_low_pfn, max_low_pfn);
+
+	printk(KERN_NOTICE "Low memory ends at vaddr %08lx\n",
+			(ulong) pfn_to_kaddr(max_low_pfn));
+	setup_numa_kva_remap();
+	printk("High memory starts at vaddr %08lx\n",
+			(ulong) pfn_to_kaddr(max_low_pfn));
+	vmalloc_earlyreserve = reserve_pages * PAGE_SIZE;
+	for_each_online_node(nid)
+		find_max_pfn_node(nid);
 
 	setup_bootmem_allocator();
-
 	return max_low_pfn;
 }
 
-void __init zone_sizes_init(void)
+static inline unsigned long max_hardware_dma_pfn(void)
+{
+	return virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+}
+static inline unsigned long  nid_size_pages(int nid)
+{
+	return node_end_pfn[nid] - node_start_pfn[nid];
+}
+static inline int nid_starts_in_highmem(int nid)
+{
+	return node_start_pfn[nid] >= max_low_pfn;
+}
+
+void __init nid_zone_sizes_init(int nid)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-	unsigned int max_dma, low;
+	unsigned long max_dma;
+	unsigned long start = node_start_pfn[nid];
+	unsigned long end = node_end_pfn[nid];
 
-	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	low = max_low_pfn;
+	if (node_has_online_mem(nid)){
+		if (nid_starts_in_highmem(nid)) {
+			zones_size[ZONE_HIGHMEM] = nid_size_pages(nid);
+		} else {
+			max_dma = min(max_hardware_dma_pfn(), max_low_pfn);
+			zones_size[ZONE_DMA] = max_dma;
+			zones_size[ZONE_NORMAL] = max_low_pfn - max_dma;
+			zones_size[ZONE_HIGHMEM] = end - max_low_pfn;
+		}
+	}
 
-	if (low < max_dma)
-		zones_size[ZONE_DMA] = low;
-	else {
-		zones_size[ZONE_DMA] = max_dma;
-		zones_size[ZONE_NORMAL] = low - max_dma;
-#ifdef CONFIG_HIGHMEM
-		zones_size[ZONE_HIGHMEM] = highend_pfn - low;
-#endif
+	free_area_init_node(nid, NODE_DATA(nid), zones_size, start,
+			    get_zholes_size(nid));
+}
+
+void __init init_pgdat_list(void)
+{
+	int nid;
+
+	/*
+	 * Insert nodes into pgdat_list backward so they appear in order.
+	 * Clobber node 0's links and NULL out pgdat_list before starting.
+	 */
+	pgdat_list = NULL;
+	for (nid = MAX_NUMNODES - 1; nid >= 0; nid--) {
+		if (!node_online(nid))
+			continue;
+		NODE_DATA(nid)->pgdat_next = pgdat_list;
+		pgdat_list = NODE_DATA(nid);
 	}
-	free_area_init(zones_size);
 }
-#else
-extern unsigned long __init setup_memory(void);
-extern void zone_sizes_init(void);
-#endif /* !CONFIG_NEED_MULTIPLE_NODES */
+
+void __init zone_sizes_init(void)
+{
+	int nid;
+
+	init_pgdat_list();
+	for_each_online_node(nid)
+		nid_zone_sizes_init(nid);
+}
 
 void __init setup_bootmem_allocator(void)
 {
diff -puN include/asm-i386/dma.h~i386-discontig-consolidate0 include/asm-i386/dma.h
diff -puN include/linux/mmzone.h~i386-discontig-consolidate0 include/linux/mmzone.h
diff -puN include/asm-i386/mmzone.h~i386-discontig-consolidate0 include/asm-i386/mmzone.h
diff -puN init/main.c~i386-discontig-consolidate0 init/main.c
diff -puN mm/memory.c~i386-discontig-consolidate0 mm/memory.c
diff -puN drivers/media/dvb/dvb-usb/dvb-usb-init.c~i386-discontig-consolidate0 drivers/media/dvb/dvb-usb/dvb-usb-init.c
diff -puN include/asm-i386/page.h~i386-discontig-consolidate0 include/asm-i386/page.h
diff -puN arch/i386/kernel/numaq.c~i386-discontig-consolidate0 arch/i386/kernel/numaq.c
diff -puN arch/i386/kernel/signal.c~i386-discontig-consolidate0 arch/i386/kernel/signal.c
diff -L ser -puN /dev/null /dev/null
_
