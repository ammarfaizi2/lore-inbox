Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWDLXWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWDLXWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDLXWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:22:06 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:5808 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932406AbWDLXWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:22:03 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060412232157.18862.57051.sendpatchset@skynet>
In-Reply-To: <20060412232036.18862.84118.sendpatchset@skynet>
References: <20060412232036.18862.84118.sendpatchset@skynet>
Subject: [PATCH 4/7] Have x86_64 use add_active_range() and free_area_init_nodes
Date: Thu, 13 Apr 2006 00:21:57 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Size zones and holes in an architecture independent manner for x86_64.

This has only been boot tested on an x86_64 with NUMA and SRAT.


 arch/x86_64/Kconfig        |    3 ++
 arch/x86_64/kernel/e820.c  |   19 ++++++++++++
 arch/x86_64/mm/init.c      |   60 +---------------------------------------
 arch/x86_64/mm/numa.c      |   15 +++++-----
 include/asm-x86_64/e820.h  |    1 
 include/asm-x86_64/proto.h |    2 -
 6 files changed, 33 insertions(+), 67 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/Kconfig linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/Kconfig
--- linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/Kconfig	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/Kconfig	2006-04-12 20:04:36.000000000 +0100
@@ -73,6 +73,9 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
 config DMI
 	bool
 	default y
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/kernel/e820.c linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/kernel/e820.c
--- linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/kernel/e820.c	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/kernel/e820.c	2006-04-12 22:58:05.000000000 +0100
@@ -220,6 +220,25 @@ e820_hole_size(unsigned long start_pfn, 
 	return ((end - start) - ram) >> PAGE_SHIFT;
 }
 
+/* Walk the e820 map and register active regions */
+unsigned long __init
+e820_register_active_regions(void)
+{
+	int i;
+	unsigned long start_pa, end_pa;
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		if (ei->type != E820_RAM)
+			continue;
+
+		start_pa = round_up(ei->addr, PAGE_SIZE);
+		end_pa = round_down(ei->addr + ei->size, PAGE_SIZE);
+
+		add_active_range(0, start_pa >> PAGE_SHIFT,
+					end_pa >> PAGE_SHIFT);
+	}
+}
+
 /*
  * Mark e820 reserved areas as busy for the resource manager.
  */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/mm/init.c linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/mm/init.c
--- linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/mm/init.c	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/mm/init.c	2006-04-12 20:04:36.000000000 +0100
@@ -405,69 +405,13 @@ void __cpuinit zap_low_mappings(int cpu)
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
+	e820_register_active_regions();
+	free_area_init_nodes(MAX_DMA_PFN, MAX_DMA32_PFN, end_pfn, end_pfn);
 }
 #endif
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/mm/numa.c linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/mm/numa.c
--- linux-2.6.17-rc1-103-x86_use_init_nodes/arch/x86_64/mm/numa.c	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-104-x86_64_use_init_nodes/arch/x86_64/mm/numa.c	2006-04-12 20:04:36.000000000 +0100
@@ -149,13 +149,12 @@ void __init setup_node_bootmem(int nodei
 void __init setup_node_zones(int nodeid)
 { 
 	unsigned long start_pfn, end_pfn, memmapsize, limit;
-	unsigned long zones[MAX_NR_ZONES];
-	unsigned long holes[MAX_NR_ZONES];
 
  	start_pfn = node_start_pfn(nodeid);
  	end_pfn = node_end_pfn(nodeid);
+	add_active_range(nodeid, start_pfn, end_pfn);
 
-	Dprintk(KERN_INFO "Setting up node %d %lx-%lx\n",
+	Dprintk(KERN_INFO "Setting up memmap for node %d %lx-%lx\n",
 		nodeid, start_pfn, end_pfn);
 
 	/* Try to allocate mem_map at end to not fill up precious <4GB
@@ -167,10 +166,6 @@ void __init setup_node_zones(int nodeid)
 				memmapsize, SMP_CACHE_BYTES, 
 				round_down(limit - memmapsize, PAGE_SIZE), 
 				limit);
-
-	size_zones(zones, holes, start_pfn, end_pfn);
-	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
-			    start_pfn, holes);
 } 
 
 void __init numa_init_array(void)
@@ -312,12 +307,18 @@ static void __init arch_sparse_init(void
 void __init paging_init(void)
 { 
 	int i;
+	unsigned long max_normal_pfn = 0;
 
 	arch_sparse_init();
 
 	for_each_online_node(i) {
 		setup_node_zones(i); 
+		if (max_normal_pfn < node_end_pfn(i))
+			max_normal_pfn = node_end_pfn(i);
 	}
+
+	free_area_init_nodes(MAX_DMA_PFN, MAX_DMA32_PFN, max_normal_pfn,
+								max_normal_pfn);
 } 
 
 /* [numa=off] */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-103-x86_use_init_nodes/include/asm-x86_64/e820.h linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-x86_64/e820.h
--- linux-2.6.17-rc1-103-x86_use_init_nodes/include/asm-x86_64/e820.h	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-x86_64/e820.h	2006-04-12 20:04:36.000000000 +0100
@@ -53,6 +53,7 @@ extern void e820_bootmem_free(pg_data_t 
 extern void e820_setup_gap(void);
 extern unsigned long e820_hole_size(unsigned long start_pfn,
 				    unsigned long end_pfn);
+extern unsigned long e820_register_active_regions(void);
 
 extern void __init parse_memopt(char *p, char **end);
 extern void __init parse_memmapopt(char *p, char **end);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-103-x86_use_init_nodes/include/asm-x86_64/proto.h linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-x86_64/proto.h
--- linux-2.6.17-rc1-103-x86_use_init_nodes/include/asm-x86_64/proto.h	2006-04-03 04:22:10.000000000 +0100
+++ linux-2.6.17-rc1-104-x86_64_use_init_nodes/include/asm-x86_64/proto.h	2006-04-12 20:04:36.000000000 +0100
@@ -24,8 +24,6 @@ extern void mtrr_bp_init(void);
 #define mtrr_bp_init() do {} while (0)
 #endif
 extern void init_memory_mapping(unsigned long start, unsigned long end);
-extern void size_zones(unsigned long *z, unsigned long *h,
-			unsigned long start_pfn, unsigned long end_pfn);
 
 extern void system_call(void); 
 extern int kernel_syscall(void);
