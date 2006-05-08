Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWEHOLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWEHOLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWEHOLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:11:15 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:23734 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932078AbWEHOLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:11:12 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Message-Id: <20060508141111.26912.6076.sendpatchset@skynet>
In-Reply-To: <20060508141030.26912.93090.sendpatchset@skynet>
References: <20060508141030.26912.93090.sendpatchset@skynet>
Subject: [PATCH 2/6] Have Power use add_active_range() and free_area_init_nodes()
Date: Mon,  8 May 2006 15:11:11 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Size zones and holes in an architecture independent manner for Power.


 powerpc/Kconfig   |   13 ++--
 powerpc/mm/mem.c  |   53 ++++++----------
 powerpc/mm/numa.c |  157 ++++---------------------------------------------
 ppc/Kconfig       |    3 
 ppc/mm/init.c     |   26 ++++----
 5 files changed, 62 insertions(+), 190 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/powerpc/Kconfig linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/powerpc/Kconfig
--- linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/powerpc/Kconfig	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/powerpc/Kconfig	2006-05-08 09:17:57.000000000 +0100
@@ -676,11 +676,16 @@ config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 	depends on SMP && PPC_PSERIES
 
-source "mm/Kconfig"
-
-config HAVE_ARCH_EARLY_PFN_TO_NID
+config ARCH_POPULATES_NODE_MAP
 	def_bool y
-	depends on NEED_MULTIPLE_NODES
+
+# Value of 256 is MAX_LMB_REGIONS * 2
+config MAX_ACTIVE_REGIONS
+	int
+	default 256
+	depends on ARCH_POPULATES_NODE_MAP
+
+source "mm/Kconfig"
 
 config ARCH_MEMORY_PROBE
 	def_bool y
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/powerpc/mm/mem.c linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/powerpc/mm/mem.c
--- linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/powerpc/mm/mem.c	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/powerpc/mm/mem.c	2006-05-08 09:17:57.000000000 +0100
@@ -257,20 +257,22 @@ void __init do_init_bootmem(void)
 
 	boot_mapsize = init_bootmem(start >> PAGE_SHIFT, total_pages);
 
+	/* Add active regions with valid PFNs */
+	for (i = 0; i < lmb.memory.cnt; i++) {
+		unsigned long start_pfn, end_pfn;
+		start_pfn = lmb.memory.region[i].base >> PAGE_SHIFT;
+		end_pfn = start_pfn + lmb_size_pages(&lmb.memory, i);
+		add_active_range(0, start_pfn, end_pfn);
+	}
+
 	/* Add all physical memory to the bootmem map, mark each area
 	 * present.
 	 */
-	for (i = 0; i < lmb.memory.cnt; i++) {
-		unsigned long base = lmb.memory.region[i].base;
-		unsigned long size = lmb_size_bytes(&lmb.memory, i);
 #ifdef CONFIG_HIGHMEM
-		if (base >= total_lowmem)
-			continue;
-		if (base + size > total_lowmem)
-			size = total_lowmem - base;
+	free_bootmem_with_active_regions(0, total_lowmem >> PAGE_SHIFT);
+#else
+	free_bootmem_with_active_regions(0, max_pfn);
 #endif
-		free_bootmem(base, size);
-	}
 
 	/* reserve the sections we're already using */
 	for (i = 0; i < lmb.reserved.cnt; i++)
@@ -278,9 +280,8 @@ void __init do_init_bootmem(void)
 				lmb_size_bytes(&lmb.reserved, i));
 
 	/* XXX need to clip this if using highmem? */
-	for (i = 0; i < lmb.memory.cnt; i++)
-		memory_present(0, lmb_start_pfn(&lmb.memory, i),
-			       lmb_end_pfn(&lmb.memory, i));
+	sparse_memory_present_with_active_regions(0);
+
 	init_bootmem_done = 1;
 }
 
@@ -289,8 +290,6 @@ void __init do_init_bootmem(void)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long zholes_size[MAX_NR_ZONES];
 	unsigned long total_ram = lmb_phys_mem_size();
 	unsigned long top_of_ram = lmb_end_of_DRAM();
 
@@ -308,26 +307,18 @@ void __init paging_init(void)
 	       top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
-	/*
-	 * All pages are DMA-able so we put them all in the DMA zone.
-	 */
-	memset(zones_size, 0, sizeof(zones_size));
-	memset(zholes_size, 0, sizeof(zholes_size));
-
-	zones_size[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
-	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
-
 #ifdef CONFIG_HIGHMEM
-	zones_size[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
-	zones_size[ZONE_HIGHMEM] = (total_memory - total_lowmem) >> PAGE_SHIFT;
-	zholes_size[ZONE_HIGHMEM] = (top_of_ram - total_ram) >> PAGE_SHIFT;
+	free_area_init_nodes(total_lowmem >> PAGE_SHIFT,
+				total_lowmem >> PAGE_SHIFT,
+				total_lowmem >> PAGE_SHIFT,
+				top_of_ram >> PAGE_SHIFT);
 #else
-	zones_size[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
-	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
-#endif /* CONFIG_HIGHMEM */
+	free_area_init_nodes(top_of_ram >> PAGE_SHIFT,
+				top_of_ram >> PAGE_SHIFT,
+				top_of_ram >> PAGE_SHIFT,
+				top_of_ram >> PAGE_SHIFT);
+#endif
 
-	free_area_init_node(0, NODE_DATA(0), zones_size,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/powerpc/mm/numa.c linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/powerpc/mm/numa.c
--- linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/powerpc/mm/numa.c	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/powerpc/mm/numa.c	2006-05-08 09:17:57.000000000 +0100
@@ -39,96 +39,6 @@ static bootmem_data_t __initdata plat_no
 static int min_common_depth;
 static int n_mem_addr_cells, n_mem_size_cells;
 
-/*
- * We need somewhere to store start/end/node for each region until we have
- * allocated the real node_data structures.
- */
-#define MAX_REGIONS	(MAX_LMB_REGIONS*2)
-static struct {
-	unsigned long start_pfn;
-	unsigned long end_pfn;
-	int nid;
-} init_node_data[MAX_REGIONS] __initdata;
-
-int __init early_pfn_to_nid(unsigned long pfn)
-{
-	unsigned int i;
-
-	for (i = 0; init_node_data[i].end_pfn; i++) {
-		unsigned long start_pfn = init_node_data[i].start_pfn;
-		unsigned long end_pfn = init_node_data[i].end_pfn;
-
-		if ((start_pfn <= pfn) && (pfn < end_pfn))
-			return init_node_data[i].nid;
-	}
-
-	return -1;
-}
-
-void __init add_region(unsigned int nid, unsigned long start_pfn,
-		       unsigned long pages)
-{
-	unsigned int i;
-
-	dbg("add_region nid %d start_pfn 0x%lx pages 0x%lx\n",
-		nid, start_pfn, pages);
-
-	for (i = 0; init_node_data[i].end_pfn; i++) {
-		if (init_node_data[i].nid != nid)
-			continue;
-		if (init_node_data[i].end_pfn == start_pfn) {
-			init_node_data[i].end_pfn += pages;
-			return;
-		}
-		if (init_node_data[i].start_pfn == (start_pfn + pages)) {
-			init_node_data[i].start_pfn -= pages;
-			return;
-		}
-	}
-
-	/*
-	 * Leave last entry NULL so we dont iterate off the end (we use
-	 * entry.end_pfn to terminate the walk).
-	 */
-	if (i >= (MAX_REGIONS - 1)) {
-		printk(KERN_ERR "WARNING: too many memory regions in "
-				"numa code, truncating\n");
-		return;
-	}
-
-	init_node_data[i].start_pfn = start_pfn;
-	init_node_data[i].end_pfn = start_pfn + pages;
-	init_node_data[i].nid = nid;
-}
-
-/* We assume init_node_data has no overlapping regions */
-void __init get_region(unsigned int nid, unsigned long *start_pfn,
-		       unsigned long *end_pfn, unsigned long *pages_present)
-{
-	unsigned int i;
-
-	*start_pfn = -1UL;
-	*end_pfn = *pages_present = 0;
-
-	for (i = 0; init_node_data[i].end_pfn; i++) {
-		if (init_node_data[i].nid != nid)
-			continue;
-
-		*pages_present += init_node_data[i].end_pfn -
-			init_node_data[i].start_pfn;
-
-		if (init_node_data[i].start_pfn < *start_pfn)
-			*start_pfn = init_node_data[i].start_pfn;
-
-		if (init_node_data[i].end_pfn > *end_pfn)
-			*end_pfn = init_node_data[i].end_pfn;
-	}
-
-	/* We didnt find a matching region, return start/end as 0 */
-	if (*start_pfn == -1UL)
-		*start_pfn = 0;
-}
-
 static void __cpuinit map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
@@ -471,8 +381,8 @@ new_range:
 				continue;
 		}
 
-		add_region(nid, start >> PAGE_SHIFT,
-			   size >> PAGE_SHIFT);
+		add_active_range(nid, start >> PAGE_SHIFT,
+				(start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
 
 		if (--ranges)
 			goto new_range;
@@ -485,6 +395,7 @@ static void __init setup_nonnuma(void)
 {
 	unsigned long top_of_ram = lmb_end_of_DRAM();
 	unsigned long total_ram = lmb_phys_mem_size();
+	unsigned long start_pfn, end_pfn;
 	unsigned int i;
 
 	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
@@ -492,9 +403,11 @@ static void __init setup_nonnuma(void)
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
 
-	for (i = 0; i < lmb.memory.cnt; ++i)
-		add_region(0, lmb.memory.region[i].base >> PAGE_SHIFT,
-			   lmb_size_pages(&lmb.memory, i));
+	for (i = 0; i < lmb.memory.cnt; ++i) {
+		start_pfn = lmb.memory.region[i].base >> PAGE_SHIFT;
+		end_pfn = start_pfn + lmb_size_pages(&lmb.memory, i);
+		add_active_range(0, start_pfn, end_pfn);
+	}
 	node_set_online(0);
 }
 
@@ -632,11 +545,11 @@ void __init do_init_bootmem(void)
 			  (void *)(unsigned long)boot_cpuid);
 
 	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn, pages_present;
+		unsigned long start_pfn, end_pfn;
 		unsigned long bootmem_paddr;
 		unsigned long bootmap_pages;
 
-		get_region(nid, &start_pfn, &end_pfn, &pages_present);
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
 		/* Allocate the node structure node local if possible */
 		NODE_DATA(nid) = careful_allocation(nid,
@@ -669,19 +582,7 @@ void __init do_init_bootmem(void)
 		init_bootmem_node(NODE_DATA(nid), bootmem_paddr >> PAGE_SHIFT,
 				  start_pfn, end_pfn);
 
-		/* Add free regions on this node */
-		for (i = 0; init_node_data[i].end_pfn; i++) {
-			unsigned long start, end;
-
-			if (init_node_data[i].nid != nid)
-				continue;
-
-			start = init_node_data[i].start_pfn << PAGE_SHIFT;
-			end = init_node_data[i].end_pfn << PAGE_SHIFT;
-
-			dbg("free_bootmem %lx %lx\n", start, end - start);
-  			free_bootmem_node(NODE_DATA(nid), start, end - start);
-		}
+		free_bootmem_with_active_regions(nid, end_pfn);
 
 		/* Mark reserved regions on this node */
 		for (i = 0; i < lmb.reserved.cnt; i++) {
@@ -712,44 +613,14 @@ void __init do_init_bootmem(void)
 			}
 		}
 
-		/* Add regions into sparsemem */
-		for (i = 0; init_node_data[i].end_pfn; i++) {
-			unsigned long start, end;
-
-			if (init_node_data[i].nid != nid)
-				continue;
-
-			start = init_node_data[i].start_pfn;
-			end = init_node_data[i].end_pfn;
-
-			memory_present(nid, start, end);
-		}
+		sparse_memory_present_with_active_regions(nid);
 	}
 }
 
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long zholes_size[MAX_NR_ZONES];
-	int nid;
-
-	memset(zones_size, 0, sizeof(zones_size));
-	memset(zholes_size, 0, sizeof(zholes_size));
-
-	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn, pages_present;
-
-		get_region(nid, &start_pfn, &end_pfn, &pages_present);
-
-		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] - pages_present;
-
-		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
-		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
-
-		free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn,
-				    zholes_size);
-	}
+	unsigned long end_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
+	free_area_init_nodes(end_pfn, end_pfn, end_pfn, end_pfn);
 }
 
 static int __init early_numa(char *p)
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/ppc/Kconfig linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/ppc/Kconfig
--- linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/ppc/Kconfig	2006-04-27 03:19:25.000000000 +0100
+++ linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/ppc/Kconfig	2006-05-08 09:17:57.000000000 +0100
@@ -949,6 +949,9 @@ config NR_CPUS
 config HIGHMEM
 	bool "High memory support"
 
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "mm/Kconfig"
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/ppc/mm/init.c linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/ppc/mm/init.c
--- linux-2.6.17-rc3-mm1-101-add_free_area_init_nodes/arch/ppc/mm/init.c	2006-04-27 03:19:25.000000000 +0100
+++ linux-2.6.17-rc3-mm1-102-powerpc_use_init_nodes/arch/ppc/mm/init.c	2006-05-08 09:17:57.000000000 +0100
@@ -359,8 +359,7 @@ void __init do_init_bootmem(void)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES], i;
-
+	unsigned long start_pfn, end_pfn;
 #ifdef CONFIG_HIGHMEM
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = pte_offset_kernel(pmd_offset(pgd_offset_k
@@ -370,19 +369,22 @@ void __init paging_init(void)
 			(KMAP_FIX_BEGIN), KMAP_FIX_BEGIN), KMAP_FIX_BEGIN);
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */
-
-	/*
-	 * All pages are DMA-able so we put them all in the DMA zone.
-	 */
-	zones_size[ZONE_DMA] = total_lowmem >> PAGE_SHIFT;
-	for (i = 1; i < MAX_NR_ZONES; i++)
-		zones_size[i] = 0;
+	/* All pages are DMA-able so we put them all in the DMA zone. */
+	start_pfn = __pa(PAGE_OFFSET) >> PAGE_SHIFT;
+	end_pfn = start_pfn + (total_memory >> PAGE_SHIFT);
+	add_active_range(0, start_pfn, end_pfn);
 
 #ifdef CONFIG_HIGHMEM
-	zones_size[ZONE_HIGHMEM] = (total_memory - total_lowmem) >> PAGE_SHIFT;
+	free_area_init_nodes(total_lowmem >> PAGE_SHIFT,
+				total_lowmem >> PAGE_SHIFT,
+				total_lowmem >> PAGE_SHIFT,
+				total_memory >> PAGE_SHIFT);
+#else
+	free_area_init_nodes(total_memory >> PAGE_SHIFT,
+				total_memory >> PAGE_SHIFT,
+				total_memory >> PAGE_SHIFT,
+				total_memory >> PAGE_SHIFT);
 #endif /* CONFIG_HIGHMEM */
-
-	free_area_init(zones_size);
 }
 
 void __init mem_init(void)
