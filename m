Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWEHOLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWEHOLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWEHOLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:11:55 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:36534 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932078AbWEHOLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:11:53 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Message-Id: <20060508141151.26912.15976.sendpatchset@skynet>
In-Reply-To: <20060508141030.26912.93090.sendpatchset@skynet>
References: <20060508141030.26912.93090.sendpatchset@skynet>
Subject: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
Date: Mon,  8 May 2006 15:11:51 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Size zones and holes in an architecture independent manner for x86_64.


 arch/x86_64/Kconfig         |    3 +
 arch/x86_64/kernel/e820.c   |  109 ++++++++++-----------------------------
 arch/x86_64/kernel/setup.c  |    7 ++
 arch/x86_64/mm/init.c       |   62 +---------------------
 arch/x86_64/mm/k8topology.c |    3 +
 arch/x86_64/mm/numa.c       |   18 +++---
 arch/x86_64/mm/srat.c       |   11 ++-
 include/asm-x86_64/e820.h   |    5 -
 include/asm-x86_64/proto.h  |    2 
 9 files changed, 63 insertions(+), 157 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/Kconfig linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/Kconfig
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/Kconfig	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/Kconfig	2006-05-08 09:20:01.000000000 +0100
@@ -73,6 +73,9 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
 config DMI
 	bool
 	default y
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/kernel/e820.c linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/kernel/e820.c
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/kernel/e820.c	2006-04-27 03:19:25.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/kernel/e820.c	2006-05-08 09:20:01.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/kexec.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 
 #include <asm/page.h>
 #include <asm/e820.h>
@@ -155,58 +156,14 @@ unsigned long __init find_e820_area(unsi
 	return -1UL;		
 } 
 
-/* 
- * Free bootmem based on the e820 table for a node.
- */
-void __init e820_bootmem_free(pg_data_t *pgdat, unsigned long start,unsigned long end)
-{
-	int i;
-	for (i = 0; i < e820.nr_map; i++) {
-		struct e820entry *ei = &e820.map[i]; 
-		unsigned long last, addr;
-
-		if (ei->type != E820_RAM || 
-		    ei->addr+ei->size <= start || 
-		    ei->addr >= end)
-			continue;
-
-		addr = round_up(ei->addr, PAGE_SIZE);
-		if (addr < start) 
-			addr = start;
-
-		last = round_down(ei->addr + ei->size, PAGE_SIZE); 
-		if (last >= end)
-			last = end; 
-
-		if (last > addr && last-addr >= PAGE_SIZE)
-			free_bootmem_node(pgdat, addr, last-addr);
-	}
-}
-
 /*
  * Find the highest page frame number we have available
  */
 unsigned long __init e820_end_of_ram(void)
 {
-	int i;
 	unsigned long end_pfn = 0;
 	
-	for (i = 0; i < e820.nr_map; i++) {
-		struct e820entry *ei = &e820.map[i]; 
-		unsigned long start, end;
-
-		start = round_up(ei->addr, PAGE_SIZE); 
-		end = round_down(ei->addr + ei->size, PAGE_SIZE); 
-		if (start >= end)
-			continue;
-		if (ei->type == E820_RAM) { 
-		if (end > end_pfn<<PAGE_SHIFT)
-			end_pfn = end>>PAGE_SHIFT;
-		} else { 
-			if (end > end_pfn_map<<PAGE_SHIFT) 
-				end_pfn_map = end>>PAGE_SHIFT;
-		} 
-	}
+	end_pfn = find_max_pfn_with_active_regions();
 
 	if (end_pfn > end_pfn_map) 
 		end_pfn_map = end_pfn;
@@ -220,40 +177,6 @@ unsigned long __init e820_end_of_ram(voi
 	return end_pfn;	
 }
 
-/* 
- * Compute how much memory is missing in a range.
- * Unlike the other functions in this file the arguments are in page numbers.
- */
-unsigned long __init
-e820_hole_size(unsigned long start_pfn, unsigned long end_pfn)
-{
-	unsigned long ram = 0;
-	unsigned long start = start_pfn << PAGE_SHIFT;
-	unsigned long end = end_pfn << PAGE_SHIFT;
-	int i;
-	for (i = 0; i < e820.nr_map; i++) {
-		struct e820entry *ei = &e820.map[i];
-		unsigned long last, addr;
-
-		if (ei->type != E820_RAM ||
-		    ei->addr+ei->size <= start ||
-		    ei->addr >= end)
-			continue;
-
-		addr = round_up(ei->addr, PAGE_SIZE);
-		if (addr < start)
-			addr = start;
-
-		last = round_down(ei->addr + ei->size, PAGE_SIZE);
-		if (last >= end)
-			last = end;
-
-		if (last > addr)
-			ram += last - addr;
-	}
-	return ((end - start) - ram) >> PAGE_SHIFT;
-}
-
 /*
  * Mark e820 reserved areas as busy for the resource manager.
  */
@@ -288,6 +211,34 @@ void __init e820_reserve_resources(void)
 	}
 }
 
+/* Walk the e820 map and register active regions within a node */
+void __init
+e820_register_active_regions(int nid, unsigned long start_pfn,
+							unsigned long end_pfn)
+{
+	int i;
+	unsigned long ei_startpfn, ei_endpfn;
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		ei_startpfn = round_up(ei->addr, PAGE_SIZE) >> PAGE_SHIFT;
+		ei_endpfn = round_down(ei->addr + ei->size, PAGE_SIZE)
+								>> PAGE_SHIFT;
+		/* Skip if map is outside the node */
+		if (ei->type != E820_RAM ||
+				ei_endpfn <= start_pfn ||
+				ei_startpfn >= end_pfn)
+			continue;
+
+		/* Check for overlaps */
+		if (ei_startpfn < start_pfn)
+			ei_startpfn = start_pfn;
+		if (ei_endpfn > end_pfn)
+			ei_endpfn = end_pfn;
+
+		add_active_range(nid, ei_startpfn, ei_endpfn);
+	}
+}
+
 /* 
  * Add a memory region to the kernel e820 map.
  */ 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/kernel/setup.c linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/kernel/setup.c	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/kernel/setup.c	2006-05-08 09:20:01.000000000 +0100
@@ -475,7 +475,8 @@ contig_initmem_init(unsigned long start_
 	if (bootmap == -1L)
 		panic("Cannot find bootmem map of size %ld\n",bootmap_size);
 	bootmap_size = init_bootmem(bootmap >> PAGE_SHIFT, end_pfn);
-	e820_bootmem_free(NODE_DATA(0), 0, end_pfn << PAGE_SHIFT);
+	e820_register_active_regions(0, start_pfn, end_pfn);
+	free_bootmem_with_active_regions(0, end_pfn);
 	reserve_bootmem(bootmap, bootmap_size);
 } 
 #endif
@@ -645,6 +646,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_identify_cpu(&boot_cpu_data);
 
+	e820_register_active_regions(0, 0, -1UL);
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
@@ -668,6 +670,9 @@ void __init setup_arch(char **cmdline_p)
 	acpi_boot_table_init();
 #endif
 
+	/* Remove active ranges so rediscovery with NUMA-awareness happens */
+	remove_all_active_ranges();
+
 #ifdef CONFIG_ACPI_NUMA
 	/*
 	 * Parse SRAT to discover nodes.
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/init.c linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/init.c
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/init.c	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/init.c	2006-05-08 09:20:01.000000000 +0100
@@ -406,69 +406,12 @@ void __cpuinit zap_low_mappings(int cpu)
 	__flush_tlb_all();
 }
 
-/* Compute zone sizes for the DMA and DMA32 zones in a node. */
-__init void
-size_zones(unsigned long *z, unsigned long *h,
-	   unsigned long start_pfn, unsigned long end_pfn)
-{
- 	int i;
- 	unsigned long w;
-
- 	for (i = 0; i < MAX_NR_ZONES; i++)
- 		z[i] = 0;
-
- 	if (start_pfn < MAX_DMA_PFN)
- 		z[ZONE_DMA] = MAX_DMA_PFN - start_pfn;
- 	if (start_pfn < MAX_DMA32_PFN) {
- 		unsigned long dma32_pfn = MAX_DMA32_PFN;
- 		if (dma32_pfn > end_pfn)
- 			dma32_pfn = end_pfn;
- 		z[ZONE_DMA32] = dma32_pfn - start_pfn;
- 	}
- 	z[ZONE_NORMAL] = end_pfn - start_pfn;
-
- 	/* Remove lower zones from higher ones. */
- 	w = 0;
- 	for (i = 0; i < MAX_NR_ZONES; i++) {
- 		if (z[i])
- 			z[i] -= w;
- 	        w += z[i];
-	}
-
-	/* Compute holes */
-	w = start_pfn;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		unsigned long s = w;
-		w += z[i];
-		h[i] = e820_hole_size(s, w);
-	}
-
-	/* Add the space pace needed for mem_map to the holes too. */
-	for (i = 0; i < MAX_NR_ZONES; i++)
-		h[i] += (z[i] * sizeof(struct page)) / PAGE_SIZE;
-
-	/* The 16MB DMA zone has the kernel and other misc mappings.
- 	   Account them too */
-	if (h[ZONE_DMA]) {
-		h[ZONE_DMA] += dma_reserve;
-		if (h[ZONE_DMA] >= z[ZONE_DMA]) {
-			printk(KERN_WARNING
-				"Kernel too large and filling up ZONE_DMA?\n");
-			h[ZONE_DMA] = z[ZONE_DMA];
-		}
-	}
-}
-
 #ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
-	unsigned long zones[MAX_NR_ZONES], holes[MAX_NR_ZONES];
-
 	memory_present(0, 0, end_pfn);
 	sparse_init();
-	size_zones(zones, holes, 0, end_pfn);
-	free_area_init_node(0, NODE_DATA(0), zones,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, holes);
+	free_area_init_nodes(MAX_DMA_PFN, MAX_DMA32_PFN, end_pfn, end_pfn);
 }
 #endif
 
@@ -620,7 +563,8 @@ void __init mem_init(void)
 #else
 	totalram_pages = free_all_bootmem();
 #endif
-	reservedpages = end_pfn - totalram_pages - e820_hole_size(0, end_pfn);
+	reservedpages = end_pfn - totalram_pages -
+					absent_pages_in_range(0, end_pfn);
 
 	after_bootmem = 1;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/k8topology.c linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/k8topology.c
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/k8topology.c	2006-04-27 03:19:25.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/k8topology.c	2006-05-08 09:20:01.000000000 +0100
@@ -146,6 +146,9 @@ int __init k8_scan_nodes(unsigned long s
 		
 		nodes[nodeid].start = base; 
 		nodes[nodeid].end = limit;
+		e820_register_active_regions(nodeid,
+				nodes[nodeid].start >> PAGE_SHIFT,
+				nodes[nodeid].end >> PAGE_SHIFT);
 
 		prevbase = base;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/numa.c linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/numa.c
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/numa.c	2006-04-27 03:19:25.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/numa.c	2006-05-08 09:20:01.000000000 +0100
@@ -161,7 +161,7 @@ void __init setup_node_bootmem(int nodei
 					 bootmap_start >> PAGE_SHIFT, 
 					 start_pfn, end_pfn); 
 
-	e820_bootmem_free(NODE_DATA(nodeid), start, end);
+	free_bootmem_with_active_regions(nodeid, end);
 
 	reserve_bootmem_node(NODE_DATA(nodeid), nodedata_phys, pgdat_size); 
 	reserve_bootmem_node(NODE_DATA(nodeid), bootmap_start, bootmap_pages<<PAGE_SHIFT);
@@ -175,13 +175,11 @@ void __init setup_node_bootmem(int nodei
 void __init setup_node_zones(int nodeid)
 { 
 	unsigned long start_pfn, end_pfn, memmapsize, limit;
-	unsigned long zones[MAX_NR_ZONES];
-	unsigned long holes[MAX_NR_ZONES];
 
  	start_pfn = node_start_pfn(nodeid);
  	end_pfn = node_end_pfn(nodeid);
 
-	Dprintk(KERN_INFO "Setting up node %d %lx-%lx\n",
+	Dprintk(KERN_INFO "Setting up memmap for node %d %lx-%lx\n",
 		nodeid, start_pfn, end_pfn);
 
 	/* Try to allocate mem_map at end to not fill up precious <4GB
@@ -195,10 +193,6 @@ void __init setup_node_zones(int nodeid)
 				round_down(limit - memmapsize, PAGE_SIZE), 
 				limit);
 #endif
-
-	size_zones(zones, holes, start_pfn, end_pfn);
-	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
-			    start_pfn, holes);
 } 
 
 void __init numa_init_array(void)
@@ -259,8 +253,11 @@ static int numa_emulation(unsigned long 
  		printk(KERN_ERR "No NUMA hash function found. Emulation disabled.\n");
  		return -1;
  	}
- 	for_each_online_node(i)
+ 	for_each_online_node(i) {
+		e820_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
+						nodes[i].end >> PAGE_SHIFT);
  		setup_node_bootmem(i, nodes[i].start, nodes[i].end);
+	}
  	numa_init_array();
  	return 0;
 }
@@ -299,6 +296,7 @@ void __init numa_initmem_init(unsigned l
 	for (i = 0; i < NR_CPUS; i++)
 		numa_set_node(i, 0);
 	node_to_cpumask[0] = cpumask_of_cpu(0);
+	e820_register_active_regions(0, start_pfn, end_pfn);
 	setup_node_bootmem(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
 }
 
@@ -346,6 +344,8 @@ void __init paging_init(void)
 	for_each_online_node(i) {
 		setup_node_zones(i); 
 	}
+
+	free_area_init_nodes(MAX_DMA_PFN, MAX_DMA32_PFN, end_pfn, end_pfn);
 } 
 
 /* [numa=off] */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/srat.c linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/arch/x86_64/mm/srat.c	2006-05-01 11:36:58.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/arch/x86_64/mm/srat.c	2006-05-08 09:20:01.000000000 +0100
@@ -87,6 +87,7 @@ static __init void bad_srat(void)
 		apicid_to_node[i] = NUMA_NO_NODE;
 	for (i = 0; i < MAX_NUMNODES; i++)
 		nodes_add[i].start = nodes[i].end = 0;
+	remove_all_active_ranges();
 }
 
 static __init inline int srat_disabled(void)
@@ -168,7 +169,7 @@ static int hotadd_enough_memory(struct b
 
 	if (mem < 0)
 		return 0;
-	allowed = (end_pfn - e820_hole_size(0, end_pfn)) * PAGE_SIZE;
+	allowed = (end_pfn - absent_pages_in_range(0, end_pfn)) * PAGE_SIZE;
 	allowed = (allowed / 100) * hotadd_percent;
 	if (allocated + mem > allowed) {
 		/* Give them at least part of their hotadd memory upto hotadd_percent
@@ -216,7 +217,7 @@ static int reserve_hotadd(int node, unsi
 	}
 
 	/* This check might be a bit too strict, but I'm keeping it for now. */
-	if (e820_hole_size(s_pfn, e_pfn) != e_pfn - s_pfn) {
+	if (absent_pages_in_range(s_pfn, e_pfn) != e_pfn - s_pfn) {
 		printk(KERN_ERR "SRAT: Hotplug area has existing memory\n");
 		return -1;
 	}
@@ -310,6 +311,8 @@ acpi_numa_memory_affinity_init(struct ac
 
 	printk(KERN_INFO "SRAT: Node %u PXM %u %Lx-%Lx\n", node, pxm,
 	       nd->start, nd->end);
+	e820_register_active_regions(node, nd->start >> PAGE_SHIFT,
+						nd->end >> PAGE_SHIFT);
 
 #ifdef RESERVE_HOTADD
  	if (ma->flags.hot_pluggable && reserve_hotadd(node, start, end) < 0) {
@@ -334,13 +337,13 @@ static int nodes_cover_memory(void)
 		unsigned long s = nodes[i].start >> PAGE_SHIFT;
 		unsigned long e = nodes[i].end >> PAGE_SHIFT;
 		pxmram += e - s;
-		pxmram -= e820_hole_size(s, e);
+		pxmram -= absent_pages_in_range(s, e);
 		pxmram -= nodes_add[i].end - nodes_add[i].start;
 		if ((long)pxmram < 0)
 			pxmram = 0;
 	}
 
-	e820ram = end_pfn - e820_hole_size(0, end_pfn);
+	e820ram = end_pfn - absent_pages_in_range(0, end_pfn);
 	/* We seem to lose 3 pages somewhere. Allow a bit of slack. */
 	if ((long)(e820ram - pxmram) >= 1*1024*1024) {
 		printk(KERN_ERR
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/include/asm-x86_64/e820.h linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/include/asm-x86_64/e820.h
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/include/asm-x86_64/e820.h	2006-04-27 03:19:25.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/include/asm-x86_64/e820.h	2006-05-08 09:20:01.000000000 +0100
@@ -50,10 +50,9 @@ extern void e820_print_map(char *who);
 extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
 extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
 
-extern void e820_bootmem_free(pg_data_t *pgdat, unsigned long start,unsigned long end);
 extern void e820_setup_gap(void);
-extern unsigned long e820_hole_size(unsigned long start_pfn,
-				    unsigned long end_pfn);
+extern void e820_register_active_regions(int nid,
+				unsigned long start_pfn, unsigned long end_pfn);
 
 extern void __init parse_memopt(char *p, char **end);
 extern void __init parse_memmapopt(char *p, char **end);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/include/asm-x86_64/proto.h linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/include/asm-x86_64/proto.h
--- linux-2.6.17-rc3-mm1-103-x86_use_init_nodes/include/asm-x86_64/proto.h	2006-05-01 11:37:01.000000000 +0100
+++ linux-2.6.17-rc3-mm1-104-x86_64_use_init_nodes/include/asm-x86_64/proto.h	2006-05-08 09:20:01.000000000 +0100
@@ -24,8 +24,6 @@ extern void mtrr_bp_init(void);
 #define mtrr_bp_init() do {} while (0)
 #endif
 extern void init_memory_mapping(unsigned long start, unsigned long end);
-extern void size_zones(unsigned long *z, unsigned long *h,
-			unsigned long start_pfn, unsigned long end_pfn);
 
 extern void system_call(void); 
 extern int kernel_syscall(void);
