Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUDHTz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDHTy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:54:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:38632 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262545AbUDHTvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:49 -0400
Date: Thu, 8 Apr 2004 12:50:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 23/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125047.2072811d.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P23.nodemask_other_archs - Matthew Dobson's [PATCH]_nodemask_t_other_arch_changes_[7_7]
        Changes to other arch-specific code (alpha, arm, mips,
        sparc64 & sh).  Untested.  Code review & testing requested.

Index: 2.6.5.bitmap/arch/alpha/mm/numa.c
===================================================================
--- 2.6.5.bitmap.orig/arch/alpha/mm/numa.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/alpha/mm/numa.c	2004-04-08 08:17:17.000000000 -0700
@@ -246,7 +246,7 @@
 	reserve_bootmem_node(NODE_DATA(nid), PFN_PHYS(bootmap_start), bootmap_size);
 	printk(" reserving pages %ld:%ld\n", bootmap_start, bootmap_start+PFN_UP(bootmap_size));
 
-	numnodes++;
+	node_set_online(nid);
 }
 
 void __init
@@ -256,11 +256,11 @@
 
 	show_mem_layout();
 
-	numnodes = 0;
+	nodes_clear(node_online_map);
 
 	min_low_pfn = ~0UL;
 	max_low_pfn = 0UL;
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
+	for_each_node(nid)
 		setup_memory_node(nid, kernel_end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -303,7 +303,7 @@
 	 */
 	dma_local_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn = node_bdata[nid].node_boot_start >> PAGE_SHIFT;
 		unsigned long end_pfn = node_bdata[nid].node_low_pfn;
 
@@ -332,7 +332,7 @@
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	reservedpages = 0;
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		/*
 		 * This will free up the bootmem, ie, slot 0 memory
 		 */
@@ -372,7 +372,7 @@
 	printk("\nMem-info:\n");
 	show_free_areas();
 	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		struct page * lmem_map = node_mem_map(nid);
 		i = node_spanned_pages(nid);
 		while (i-- > 0) {
Index: 2.6.5.bitmap/arch/arm/mm/init.c
===================================================================
--- 2.6.5.bitmap.orig/arch/arm/mm/init.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/arm/mm/init.c	2004-04-08 08:17:17.000000000 -0700
@@ -69,7 +69,7 @@
 	show_free_areas();
 	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		struct page *page, *end;
 
 		page = NODE_MEM_MAP(node);
@@ -172,7 +172,7 @@
 {
 	unsigned int i, bootmem_pages = 0, memend_pfn = 0;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		np[i].start = -1U;
 		np[i].end = 0;
 		np[i].bootmap_pages = 0;
@@ -192,18 +192,13 @@
 
 		node = mi->bank[i].node;
 
-		if (node >= numnodes) {
-			numnodes = node + 1;
-
-			/*
-			 * Make sure we haven't exceeded the maximum number
-			 * of nodes that we have in this configuration.  If
-			 * we have, we're in trouble.  (maybe we ought to
-			 * limit, instead of bugging?)
-			 */
-			if (numnodes > MAX_NUMNODES)
-				BUG();
-		}
+		/*
+		 * Make sure we haven't exceeded the maximum number of nodes 
+		 * that we have in this configuration.  If we have, we're in 
+		 * trouble.
+		 */
+		if (!node_online(node) && node_possible(node))
+			node_set_online(node);
 
 		/*
 		 * Get the start and end pfns for this bank
@@ -225,7 +220,7 @@
 	 * Calculate the number of pages we require to
 	 * store the bootmem bitmaps.
 	 */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		if (np[i].end == 0)
 			continue;
 
@@ -388,8 +383,8 @@
 	 * (we could also do with rolling bootmem_init and paging_init
 	 * into one generic "memory_init" type function).
 	 */
-	np += numnodes - 1;
-	for (node = numnodes - 1; node >= 0; node--, np--) {
+	np += num_online_nodes() - 1;
+	for (node = num_online_nodes() - 1; node >= 0; node--, np--) {
 		/*
 		 * If there are no pages in this node, ignore it.
 		 * Note that node 0 must always have some pages.
@@ -457,7 +452,7 @@
 	/*
 	 * initialise the zones within each node
 	 */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		unsigned long zone_size[MAX_NR_ZONES];
 		unsigned long zhole_size[MAX_NR_ZONES];
 		struct bootmem_data *bdata;
@@ -567,7 +562,7 @@
 		create_memmap_holes(&meminfo);
 
 	/* this will put all unused low memory onto the freelists */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pg_data_t *pgdat = NODE_DATA(node);
 
 		if (pgdat->node_spanned_pages != 0)
Index: 2.6.5.bitmap/arch/arm/mm/mm-armv.c
===================================================================
--- 2.6.5.bitmap.orig/arch/arm/mm/mm-armv.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/arm/mm/mm-armv.c	2004-04-08 08:17:17.000000000 -0700
@@ -653,6 +653,6 @@
 {
 	int node;
 
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		free_unused_memmap_node(node, mi);
 }
Index: 2.6.5.bitmap/arch/arm26/mm/init.c
===================================================================
--- 2.6.5.bitmap.orig/arch/arm26/mm/init.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/arm26/mm/init.c	2004-04-08 08:17:17.000000000 -0700
@@ -156,7 +156,8 @@
 {
 	unsigned int memend_pfn = 0;
 
-	numnodes = 1;
+	nodes_clear(node_online_map);
+	node_set_online(0);
 
 	np->bootmap_pages = 0;
 
Index: 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-init.c
===================================================================
--- 2.6.5.bitmap.orig/arch/mips/sgi-ip27/ip27-init.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-init.c	2004-04-08 08:17:17.000000000 -0700
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/mmzone.h>	/* for numnodes */
+#include <linux/nodemask.h>	/* for node_online_map */
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <asm/cpu.h>
@@ -56,14 +56,13 @@
 		return COMPACT_TO_NASID_NODEID(cnode) >> NASID_TO_COARSEREG_SHFT;
 }
 
-static void gen_region_mask(hubreg_t *region_mask, int maxnodes)
+static void gen_region_mask(hubreg_t *region_mask)
 {
 	cnodeid_t cnode;
 
 	(*region_mask) = 0;
-	for (cnode = 0; cnode < maxnodes; cnode++) {
+	for_each_online_node(cnode)
 		(*region_mask) |= 1ULL << get_region(cnode);
-	}
 }
 
 static int is_fine_dirmode(void)
@@ -168,7 +167,7 @@
 	int port;
 
 	/* Figure out which routers nodes in question are connected to */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		if (nasid == -1) continue;
@@ -235,9 +234,9 @@
 		for (col = 0; col < MAX_COMPACT_NODES; col++)
 			node_distances[row][col] = -1;
 
-	for (row = 0; row < numnodes; row++) {
+	for_each_online_node(row) {
 		nasid = COMPACT_TO_NASID_NODEID(row);
-		for (col = 0; col < numnodes; col++) {
+		for_each_online_node(col) {
 			nasid2 = COMPACT_TO_NASID_NODEID(col);
 			node_distances[row][col] = node_distance(nasid, nasid2);
 		}
@@ -257,17 +256,17 @@
 	printk("************** Topology ********************\n");
 
 	printk("    ");
-	for (col = 0; col < numnodes; col++)
+	for_each_online_node(col)
 		printk("%02d ", col);
 	printk("\n");
-	for (row = 0; row < numnodes; row++) {
+	for_each_online_node(row) {
 		printk("%02d  ", row);
-		for (col = 0; col < numnodes; col++)
+		for_each_online_node(col)
 			printk("%2d ", node_distances[row][col]);
 		printk("\n");
 	}
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		if (nasid == -1) continue;
@@ -323,14 +322,14 @@
 	init_topology_matrix();
 	dump_topology();
 
-	gen_region_mask(&region_mask, numnodes);
+	gen_region_mask(&region_mask);
 
-	setup_replication_mask(numnodes);
+	setup_replication_mask();
 
 	/*
 	 * Set all nodes' calias sizes to 8k
 	 */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		nasid_t nasid;
 
 		nasid = COMPACT_TO_NASID_NODEID(i);
Index: 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-klnuma.c
===================================================================
--- 2.6.5.bitmap.orig/arch/mips/sgi-ip27/ip27-klnuma.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-klnuma.c	2004-04-08 08:17:17.000000000 -0700
@@ -27,7 +27,7 @@
  * kernel.  For example, we should never put a copy on a headless node,
  * and we should respect the topology of the machine.
  */
-void __init setup_replication_mask(int maxnodes)
+void __init setup_replication_mask(void)
 {
 	static int 	numa_kernel_replication_ratio;
 	cnodeid_t	cnode;
@@ -44,7 +44,7 @@
 	numa_kernel_replication_ratio = 1;
 #endif
 
-	for (cnode = 1; cnode < numnodes; cnode++) {
+	for (cnode = 1; cnode < num_online_nodes(); cnode++) {
 		/* See if this node should get a copy of the kernel */
 		if (numa_kernel_replication_ratio &&
 		    !(cnode % numa_kernel_replication_ratio)) {
@@ -92,7 +92,7 @@
 	memcpy((void *)dest_kern_start, (void *)source_start, kern_size);
 }
 
-void __init replicate_kernel_text(int maxnodes)
+void __init replicate_kernel_text(void)
 {
 	cnodeid_t cnode;
 	nasid_t client_nasid;
@@ -103,7 +103,7 @@
 	/* Record where the master node should get its kernel text */
 	set_ktext_source(master_nasid, master_nasid);
 
-	for (cnode = 1; cnode < maxnodes; cnode++) {
+	for (cnode = 1; cnode < num_online_nodes(); cnode++) {
 		client_nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		/* Check if this node should get a copy of the kernel */
Index: 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-memory.c
===================================================================
--- 2.6.5.bitmap.orig/arch/mips/sgi-ip27/ip27-memory.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-memory.c	2004-04-08 08:17:17.000000000 -0700
@@ -137,7 +137,7 @@
 	pfn_t slot0sz = 0, nodebytes;	/* Hack to detect problem configs */
 	int ignore;
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		numslots = node_getnumslots(node);
 		ignore = nodebytes = 0;
 		for (slot = 0; slot < numslots; slot++) {
@@ -183,7 +183,7 @@
 
 	num_physpages = szmem();
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pfn_t slot_firstpfn = slot_getbasepfn(node, 0);
 		pfn_t slot_lastpfn = slot_firstpfn + slot_getsize(node, 0);
 		pfn_t slot_freepfn = node_getfirstfree(node);
@@ -225,7 +225,7 @@
 
 	pagetable_init();
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pfn_t start_pfn = slot_getbasepfn(node, 0);
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
@@ -245,7 +245,7 @@
 
 	high_memory = (void *) __va(num_physpages << PAGE_SHIFT);
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		unsigned slot, numslots;
 		struct page *end, *p;
 	
Index: 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-nmi.c
===================================================================
--- 2.6.5.bitmap.orig/arch/mips/sgi-ip27/ip27-nmi.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-nmi.c	2004-04-08 08:17:17.000000000 -0700
@@ -183,7 +183,7 @@
 {
 	cnodeid_t	cnode;
 
-	for(cnode = 0 ; cnode < numnodes; cnode++)
+	for_each_online_node(cnode)
 		nmi_node_eframe_save(cnode);
 }
 
@@ -214,13 +214,13 @@
 	 * send NMIs to all cpus on a 256p system.
 	 */
 	for (i=0; i < 1500; i++) {
-		for (node=0; node < numnodes; node++)
+		for_each_online_node(node)
 			if (NODEPDA(node)->dump_count == 0)
 				break;
-		if (node == numnodes)
+		if (node == num_online_nodes())
 			break;
 		if (i == 1000) {
-			for (node=0; node < numnodes; node++)
+			for_each_online_node(node)
 				if (NODEPDA(node)->dump_count == 0) {
 					cpu = CNODE_TO_CPU_BASE(node);
 					for (n=0; n < CNODE_NUM_CPUS(node); cpu++, n++) {
Index: 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-reset.c
===================================================================
--- 2.6.5.bitmap.orig/arch/mips/sgi-ip27/ip27-reset.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-reset.c	2004-04-08 08:17:17.000000000 -0700
@@ -43,7 +43,7 @@
 	smp_send_stop();
 #endif
 #if 0
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		REMOTE_HUB_S(COMPACT_TO_NASID_NODEID(i), PROMOP_REG,
 							PROMOP_REBOOT);
 #else
@@ -59,7 +59,7 @@
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		REMOTE_HUB_S(COMPACT_TO_NASID_NODEID(i), PROMOP_REG,
 							PROMOP_RESTART);
 	LOCAL_HUB_S(NI_PORT_RESET, NPR_PORTRESET | NPR_LOCALRESET);
Index: 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-smp.c
===================================================================
--- 2.6.5.bitmap.orig/arch/mips/sgi-ip27/ip27-smp.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/mips/sgi-ip27/ip27-smp.c	2004-04-08 08:17:17.000000000 -0700
@@ -108,18 +108,18 @@
 	for (i = 0; i < MAXCPUS; i++)
 		cpuid_to_compact_node[i] = INVALID_CNODEID;
 
-	numnodes = 0;
+	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_COMPACT_NODES; i++) {
 		nasid_t nasid = gdap->g_nasidtable[i];
 		if (nasid == INVALID_NASID)
 			break;
 		compact_to_nasid_node[i] = nasid;
 		nasid_to_compact_node[nasid] = i;
-		numnodes++;
+		node_set_online(i);
 		highest = do_cpumask(i, nasid, highest);
 	}
 
-	printk("Discovered %d cpus on %d nodes\n", highest + 1, numnodes);
+	printk("Discovered %d cpus on %d nodes\n", highest + 1, num_online_nodes());
 }
 
 void __init prom_build_cpu_map(void)
@@ -155,13 +155,13 @@
 {
 	cnodeid_t	cnode;
 
-	for (cnode = 0; cnode < numnodes; cnode++)
+	for_each_online_node(cnode)
 		intr_clear_all(COMPACT_TO_NASID_NODEID(cnode));
 
 	/* Master has already done per_cpu_init() */
 	install_ipi();
 
-	replicate_kernel_text(numnodes);
+	replicate_kernel_text();
 
 	/*
 	 * Assumption to be fixed: we're always booted on logical / physical
Index: 2.6.5.bitmap/arch/sh/mm/hugetlbpage.c
===================================================================
--- 2.6.5.bitmap.orig/arch/sh/mm/hugetlbpage.c	2004-04-08 08:04:03.000000000 -0700
+++ 2.6.5.bitmap/arch/sh/mm/hugetlbpage.c	2004-04-08 08:17:58.000000000 -0700
@@ -61,7 +61,7 @@
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
Index: 2.6.5.bitmap/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- 2.6.5.bitmap.orig/arch/sparc64/mm/hugetlbpage.c	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/arch/sparc64/mm/hugetlbpage.c	2004-04-08 08:17:17.000000000 -0700
@@ -39,12 +39,11 @@
 	struct page *page = NULL;
 
 	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
+		for_each_node(nid)
 			if (!list_empty(&hugepage_freelists[nid]))
 				break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES &&
-	    !list_empty(&hugepage_freelists[nid])) {
+	if (node_possible(nid) && !list_empty(&hugepage_freelists[nid])) {
 		page = list_entry(hugepage_freelists[nid].next,
 				  struct page, list);
 		list_del(&page->list);
@@ -57,7 +56,7 @@
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -464,7 +463,7 @@
 	int i;
 	struct page *page;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for_each_node(i)
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 	for (i = 0; i < htlbpage_max; ++i) {
Index: 2.6.5.bitmap/include/asm-mips/sn/sn_private.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-mips/sn/sn_private.h	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/include/asm-mips/sn/sn_private.h	2004-04-08 08:17:17.000000000 -0700
@@ -13,8 +13,8 @@
 extern void per_hub_init(cnodeid_t cnode);
 extern void install_cpu_nmi_handler(int slice);
 extern void install_ipi(void);
-extern void setup_replication_mask(int);
-extern void replicate_kernel_text(int);
+extern void setup_replication_mask(void);
+extern void replicate_kernel_text(void);
 extern pfn_t node_getfirstfree(cnodeid_t);
 
 #endif /* __ASM_SN_SN_PRIVATE_H */
Index: 2.6.5.bitmap/include/asm-sh/mmzone.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-sh/mmzone.h	2004-04-08 08:17:10.000000000 -0700
+++ 2.6.5.bitmap/include/asm-sh/mmzone.h	2004-04-08 08:17:17.000000000 -0700
@@ -46,7 +46,7 @@
 {
 	unsigned int i;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		if (page >= NODE_MEM_MAP(i) &&
 		    page < NODE_MEM_MAP(i) + NODE_DATA(i)->node_size)
 			return 1;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
