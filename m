Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUCRXNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUCRXMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:12:19 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:7665 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263273AbUCRXFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:37 -0500
Subject: [PATCH] nodemask_t other arch changes [7/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-/OhEfozH5g0X6K2h1kgh"
Organization: IBM LTC
Message-Id: <1079651088.8149.179.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/OhEfozH5g0X6K2h1kgh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nodemask_t-07-other.patch - Changes to other arch-specific code (alpha,
arm, mips, sparc64 & sh).  Untested.  Code review & testing requested.


--=-/OhEfozH5g0X6K2h1kgh
Content-Disposition: attachment; filename=nodemask_t-07-other.patch
Content-Type: text/x-patch; name=nodemask_t-07-other.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/alpha/mm/numa.c linux-2.6.4-nodemask_t-other/arch/alpha/mm/numa.c
--- linux-2.6.4-vanilla/arch/alpha/mm/numa.c	Wed Mar 10 18:55:21 2004
+++ linux-2.6.4-nodemask_t-other/arch/alpha/mm/numa.c	Thu Mar 11 12:01:46 2004
@@ -244,7 +244,7 @@ setup_memory_node(int nid, void *kernel_
 	reserve_bootmem_node(NODE_DATA(nid), PFN_PHYS(bootmap_start), bootmap_size);
 	printk(" reserving pages %ld:%ld\n", bootmap_start, bootmap_start+PFN_UP(bootmap_size));
 
-	numnodes++;
+	node_set_online(nid);
 }
 
 void __init
@@ -254,11 +254,11 @@ setup_memory(void *kernel_end)
 
 	show_mem_layout();
 
-	numnodes = 0;
+	nodes_clear(node_online_map);
 
 	min_low_pfn = ~0UL;
 	max_low_pfn = 0UL;
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
+	for_each_node(nid)
 		setup_memory_node(nid, kernel_end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -301,7 +301,7 @@ void __init paging_init(void)
 	 */
 	dma_local_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn = node_bdata[nid].node_boot_start >> PAGE_SHIFT;
 		unsigned long end_pfn = node_bdata[nid].node_low_pfn;
 
@@ -330,7 +330,7 @@ void __init mem_init(void)
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	reservedpages = 0;
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		/*
 		 * This will free up the bootmem, ie, slot 0 memory
 		 */
@@ -370,7 +370,7 @@ show_mem(void)
 	printk("\nMem-info:\n");
 	show_free_areas();
 	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		struct page * lmem_map = node_mem_map(nid);
 		i = node_spanned_pages(nid);
 		while (i-- > 0) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/arm/mm/init.c linux-2.6.4-nodemask_t-other/arch/arm/mm/init.c
--- linux-2.6.4-vanilla/arch/arm/mm/init.c	Wed Mar 10 18:55:22 2004
+++ linux-2.6.4-nodemask_t-other/arch/arm/mm/init.c	Tue Mar 16 14:26:18 2004
@@ -69,7 +69,7 @@ void show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6dkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		struct page *page, *end;
 
 		page = NODE_MEM_MAP(node);
@@ -172,7 +172,7 @@ find_memend_and_nodes(struct meminfo *mi
 {
 	unsigned int i, bootmem_pages = 0, memend_pfn = 0;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		np[i].start = -1U;
 		np[i].end = 0;
 		np[i].bootmap_pages = 0;
@@ -192,18 +192,13 @@ find_memend_and_nodes(struct meminfo *mi
 
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
@@ -225,7 +220,7 @@ find_memend_and_nodes(struct meminfo *mi
 	 * Calculate the number of pages we require to
 	 * store the bootmem bitmaps.
 	 */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		if (np[i].end == 0)
 			continue;
 
@@ -388,8 +383,8 @@ void __init bootmem_init(struct meminfo 
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
@@ -457,7 +452,7 @@ void __init paging_init(struct meminfo *
 	/*
 	 * initialise the zones within each node
 	 */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		unsigned long zone_size[MAX_NR_ZONES];
 		unsigned long zhole_size[MAX_NR_ZONES];
 		struct bootmem_data *bdata;
@@ -567,7 +562,7 @@ void __init mem_init(void)
 		create_memmap_holes(&meminfo);
 
 	/* this will put all unused low memory onto the freelists */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pg_data_t *pgdat = NODE_DATA(node);
 
 		if (pgdat->node_spanned_pages != 0)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/arm/mm/mm-armv.c linux-2.6.4-nodemask_t-other/arch/arm/mm/mm-armv.c
--- linux-2.6.4-vanilla/arch/arm/mm/mm-armv.c	Wed Mar 10 18:55:35 2004
+++ linux-2.6.4-nodemask_t-other/arch/arm/mm/mm-armv.c	Thu Mar 11 12:01:46 2004
@@ -653,6 +653,6 @@ void __init create_memmap_holes(struct m
 {
 	int node;
 
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		free_unused_memmap_node(node, mi);
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/arm26/mm/init.c linux-2.6.4-nodemask_t-other/arch/arm26/mm/init.c
--- linux-2.6.4-vanilla/arch/arm26/mm/init.c	Wed Mar 10 18:55:44 2004
+++ linux-2.6.4-nodemask_t-other/arch/arm26/mm/init.c	Thu Mar 11 12:01:46 2004
@@ -156,7 +156,8 @@ find_memend_and_nodes(struct meminfo *mi
 {
 	unsigned int memend_pfn = 0;
 
-	numnodes = 1;
+	nodes_clear(node_online_map);
+	node_set_online(0);
 
 	np->bootmap_pages = 0;
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-init.c linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-init.c
--- linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-init.c	Wed Mar 10 18:55:45 2004
+++ linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-init.c	Thu Mar 11 14:53:28 2004
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/mmzone.h>	/* for numnodes */
+#include <linux/nodemask.h>	/* for node_online_map */
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <asm/cpu.h>
@@ -56,14 +56,13 @@ static hubreg_t get_region(cnodeid_t cno
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
@@ -168,7 +167,7 @@ static int node_distance(nasid_t nasid_a
 	int port;
 
 	/* Figure out which routers nodes in question are connected to */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		if (nasid == -1) continue;
@@ -235,9 +234,9 @@ static void init_topology_matrix(void)
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
@@ -257,17 +256,17 @@ static void dump_topology(void)
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
@@ -323,14 +322,14 @@ void mlreset(void)
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-klnuma.c linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-klnuma.c
--- linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-klnuma.c	Wed Mar 10 18:55:26 2004
+++ linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-klnuma.c	Thu Mar 11 12:01:46 2004
@@ -27,7 +27,7 @@ static cpumask_t ktext_repmask;
  * kernel.  For example, we should never put a copy on a headless node,
  * and we should respect the topology of the machine.
  */
-void __init setup_replication_mask(int maxnodes)
+void __init setup_replication_mask(void)
 {
 	static int 	numa_kernel_replication_ratio;
 	cnodeid_t	cnode;
@@ -44,7 +44,7 @@ void __init setup_replication_mask(int m
 	numa_kernel_replication_ratio = 1;
 #endif
 
-	for (cnode = 1; cnode < numnodes; cnode++) {
+	for (cnode = 1; cnode < num_online_nodes(); cnode++) {
 		/* See if this node should get a copy of the kernel */
 		if (numa_kernel_replication_ratio &&
 		    !(cnode % numa_kernel_replication_ratio)) {
@@ -92,7 +92,7 @@ static __init void copy_kernel(nasid_t d
 	memcpy((void *)dest_kern_start, (void *)source_start, kern_size);
 }
 
-void __init replicate_kernel_text(int maxnodes)
+void __init replicate_kernel_text(void)
 {
 	cnodeid_t cnode;
 	nasid_t client_nasid;
@@ -103,7 +103,7 @@ void __init replicate_kernel_text(int ma
 	/* Record where the master node should get its kernel text */
 	set_ktext_source(master_nasid, master_nasid);
 
-	for (cnode = 1; cnode < maxnodes; cnode++) {
+	for (cnode = 1; cnode < num_online_nodes(); cnode++) {
 		client_nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		/* Check if this node should get a copy of the kernel */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-memory.c linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-memory.c
--- linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-memory.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-memory.c	Thu Mar 11 14:51:35 2004
@@ -137,7 +137,7 @@ static pfn_t szmem(void)
 	pfn_t slot0sz = 0, nodebytes;	/* Hack to detect problem configs */
 	int ignore;
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		numslots = node_getnumslots(node);
 		ignore = nodebytes = 0;
 		for (slot = 0; slot < numslots; slot++) {
@@ -183,7 +183,7 @@ void __init prom_meminit(void)
 
 	num_physpages = szmem();
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pfn_t slot_firstpfn = slot_getbasepfn(node, 0);
 		pfn_t slot_lastpfn = slot_firstpfn + slot_getsize(node, 0);
 		pfn_t slot_freepfn = node_getfirstfree(node);
@@ -225,7 +225,7 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pfn_t start_pfn = slot_getbasepfn(node, 0);
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
@@ -245,7 +245,7 @@ void __init mem_init(void)
 
 	high_memory = (void *) __va(num_physpages << PAGE_SHIFT);
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		unsigned slot, numslots;
 		struct page *end, *p;
 	
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-nmi.c linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-nmi.c
--- linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-nmi.c	Wed Mar 10 18:55:21 2004
+++ linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-nmi.c	Thu Mar 11 12:01:46 2004
@@ -183,7 +183,7 @@ nmi_eframes_save(void)
 {
 	cnodeid_t	cnode;
 
-	for(cnode = 0 ; cnode < numnodes; cnode++)
+	for_each_online_node(cnode)
 		nmi_node_eframe_save(cnode);
 }
 
@@ -214,13 +214,13 @@ cont_nmi_dump(void)
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-reset.c linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-reset.c
--- linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-reset.c	Wed Mar 10 18:55:28 2004
+++ linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-reset.c	Thu Mar 11 12:01:46 2004
@@ -43,7 +43,7 @@ static void ip27_machine_restart(char *c
 	smp_send_stop();
 #endif
 #if 0
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		REMOTE_HUB_S(COMPACT_TO_NASID_NODEID(i), PROMOP_REG,
 							PROMOP_REBOOT);
 #else
@@ -59,7 +59,7 @@ static void ip27_machine_halt(void)
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		REMOTE_HUB_S(COMPACT_TO_NASID_NODEID(i), PROMOP_REG,
 							PROMOP_RESTART);
 	LOCAL_HUB_S(NI_PORT_RESET, NPR_PORTRESET | NPR_LOCALRESET);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-smp.c linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-smp.c
--- linux-2.6.4-vanilla/arch/mips/sgi-ip27/ip27-smp.c	Wed Mar 10 18:55:35 2004
+++ linux-2.6.4-nodemask_t-other/arch/mips/sgi-ip27/ip27-smp.c	Tue Mar 16 14:48:10 2004
@@ -108,18 +108,18 @@ void cpu_node_probe(void)
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
@@ -155,13 +155,13 @@ void __init prom_prepare_cpus(unsigned i
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/sparc64/mm/hugetlbpage.c linux-2.6.4-nodemask_t-other/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.4-vanilla/arch/sparc64/mm/hugetlbpage.c	Wed Mar 10 18:55:35 2004
+++ linux-2.6.4-nodemask_t-other/arch/sparc64/mm/hugetlbpage.c	Thu Mar 11 16:48:49 2004
@@ -39,12 +39,11 @@ static struct page *dequeue_huge_page(vo
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
@@ -57,7 +56,7 @@ static struct page *alloc_fresh_huge_pag
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -464,7 +463,7 @@ static int __init hugetlb_init(void)
 	int i;
 	struct page *page;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for_each_node(i)
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 	for (i = 0; i < htlbpage_max; ++i) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-mips/sn/sn_private.h linux-2.6.4-nodemask_t-other/include/asm-mips/sn/sn_private.h
--- linux-2.6.4-vanilla/include/asm-mips/sn/sn_private.h	Wed Mar 10 18:55:37 2004
+++ linux-2.6.4-nodemask_t-other/include/asm-mips/sn/sn_private.h	Thu Mar 11 14:59:23 2004
@@ -13,8 +13,8 @@ extern void per_cpu_init(void);
 extern void per_hub_init(cnodeid_t cnode);
 extern void install_cpu_nmi_handler(int slice);
 extern void install_ipi(void);
-extern void setup_replication_mask(int);
-extern void replicate_kernel_text(int);
+extern void setup_replication_mask(void);
+extern void replicate_kernel_text(void);
 extern pfn_t node_getfirstfree(cnodeid_t);
 
 #endif /* __ASM_SN_SN_PRIVATE_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-sh/mmzone.h linux-2.6.4-nodemask_t-other/include/asm-sh/mmzone.h
--- linux-2.6.4-vanilla/include/asm-sh/mmzone.h	Wed Mar 10 18:55:44 2004
+++ linux-2.6.4-nodemask_t-other/include/asm-sh/mmzone.h	Thu Mar 11 16:12:54 2004
@@ -46,7 +46,7 @@ static inline int is_valid_page(struct p
 {
 	unsigned int i;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		if (page >= NODE_MEM_MAP(i) &&
 		    page < NODE_MEM_MAP(i) + NODE_DATA(i)->node_size)
 			return 1;

--=-/OhEfozH5g0X6K2h1kgh--

