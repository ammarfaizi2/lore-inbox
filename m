Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbULWWrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbULWWrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbULWWqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:46:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37082 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261328AbULWWmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:42:54 -0500
Subject: [RFC PATCH 6/10] Replace 'numnodes' with 'node_online_map' - mips
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841753.3945.29.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:42:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

6/10 - Replace numnodes with node_online_map for mips

[mcd@arrakis node_online_map]$ diffstat arch-mips.patch
 arch/mips/sgi-ip27/ip27-init.c   |    1 -
 arch/mips/sgi-ip27/ip27-klnuma.c |   28 +++++++++++-----------------
 arch/mips/sgi-ip27/ip27-memory.c |   32 ++++++++++++++++----------------
 arch/mips/sgi-ip27/ip27-nmi.c    |    8 ++++----
 arch/mips/sgi-ip27/ip27-reset.c  |    4 ++--
 arch/mips/sgi-ip27/ip27-smp.c    |   14 +++++++++-----
 include/asm-mips/sn/sn_private.h |    4 ++--
 7 files changed, 44 insertions(+), 47 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-init.c linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-init.c
--- linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-init.c	2004-12-13 16:22:15.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-init.c	2004-12-15 14:52:12.000000000 -0800
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/mmzone.h>	/* for numnodes */
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-klnuma.c linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-klnuma.c
--- linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-klnuma.c	2004-12-13 16:22:15.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-klnuma.c	2004-12-15 15:03:18.000000000 -0800
@@ -27,33 +27,25 @@ static cpumask_t ktext_repmask;
  * kernel.  For example, we should never put a copy on a headless node,
  * and we should respect the topology of the machine.
  */
-void __init setup_replication_mask(int maxnodes)
+void __init setup_replication_mask()
 {
-	static int 	numa_kernel_replication_ratio;
 	cnodeid_t	cnode;
 
 	/* Set only the master cnode's bit.  The master cnode is always 0. */
 	cpus_clear(ktext_repmask);
 	cpu_set(0, ktext_repmask);
 
-	numa_kernel_replication_ratio = 0;
 #ifdef CONFIG_REPLICATE_KTEXT
 #ifndef CONFIG_MAPPED_KERNEL
 #error Kernel replication works with mapped kernel support. No calias support.
 #endif
-	numa_kernel_replication_ratio = 1;
-#endif
-
-	for (cnode = 1; cnode < numnodes; cnode++) {
-		/* See if this node should get a copy of the kernel */
-		if (numa_kernel_replication_ratio &&
-		    !(cnode % numa_kernel_replication_ratio)) {
-
-			/* Advertise that we have a copy of the kernel */
-			cpu_set(cnode, ktext_repmask);
-		}
+	for_each_online_node(cnode) {
+		if (cnode == 0)
+			continue;
+		/* Advertise that we have a copy of the kernel */
+		cpu_set(cnode, ktext_repmask);
 	}
-
+#endif
 	/* Set up a GDA pointer to the replication mask. */
 	GDA->g_ktext_repmask = &ktext_repmask;
 }
@@ -92,7 +84,7 @@ static __init void copy_kernel(nasid_t d
 	memcpy((void *)dest_kern_start, (void *)source_start, kern_size);
 }
 
-void __init replicate_kernel_text(int maxnodes)
+void __init replicate_kernel_text()
 {
 	cnodeid_t cnode;
 	nasid_t client_nasid;
@@ -103,7 +95,9 @@ void __init replicate_kernel_text(int ma
 	/* Record where the master node should get its kernel text */
 	set_ktext_source(master_nasid, master_nasid);
 
-	for (cnode = 1; cnode < maxnodes; cnode++) {
+	for_each_online_node(cnode) {
+		if (cnode == 0)
+			continue;
 		client_nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		/* Check if this node should get a copy of the kernel */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-memory.c linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-memory.c
--- linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-memory.c	2004-12-13 16:22:15.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-memory.c	2004-12-15 15:12:58.000000000 -0800
@@ -59,12 +59,12 @@ static hubreg_t get_region(cnodeid_t cno
 
 static hubreg_t region_mask;
 
-static void gen_region_mask(hubreg_t *region_mask, int maxnodes)
+static void gen_region_mask(hubreg_t *region_mask)
 {
 	cnodeid_t cnode;
 
 	(*region_mask) = 0;
-	for (cnode = 0; cnode < maxnodes; cnode++) {
+	for_each_online_node(cnode) {
 		(*region_mask) |= 1ULL << get_region(cnode);
 	}
 }
@@ -120,7 +120,7 @@ static int __init compute_node_distance(
 	int port;
 
 	/* Figure out which routers nodes in question are connected to */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		if (nasid == -1) continue;
@@ -187,9 +187,9 @@ static void __init init_topology_matrix(
 		for (col = 0; col < MAX_COMPACT_NODES; col++)
 			__node_distances[row][col] = -1;
 
-	for (row = 0; row < numnodes; row++) {
+	for_each_online_node(row) {
 		nasid = COMPACT_TO_NASID_NODEID(row);
-		for (col = 0; col < numnodes; col++) {
+		for_each_online_node(col) {
 			nasid2 = COMPACT_TO_NASID_NODEID(col);
 			__node_distances[row][col] =
 				compute_node_distance(nasid, nasid2);
@@ -210,17 +210,17 @@ static void __init dump_topology(void)
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
 			printk("%2d ", node_distance(row, col));
 		printk("\n");
 	}
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		if (nasid == -1) continue;
@@ -363,14 +363,14 @@ static void __init mlreset(void)
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
@@ -407,7 +407,7 @@ static void __init szmem(void)
 
 	num_physpages = 0;
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		ignore = nodebytes = 0;
 		for (slot = 0; slot < MAX_MEM_SLOTS; slot++) {
 			slot_psize = slot_psize_compute(node, slot);
@@ -489,7 +489,7 @@ void __init prom_meminit(void)
 	szmem();
 
 	for (node = 0; node < MAX_COMPACT_NODES; node++) {
-		if (node < numnodes) {
+		if (node_online(node)) {
 			node_mem_init(node);
 			continue;
 		}
@@ -513,7 +513,7 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pfn_t start_pfn = slot_getbasepfn(node, 0);
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
@@ -533,7 +533,7 @@ void __init mem_init(void)
 
 	high_memory = (void *) __va(num_physpages << PAGE_SHIFT);
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		unsigned slot, numslots;
 		struct page *end, *p;
 	
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-nmi.c linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-nmi.c
--- linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-nmi.c	2004-12-13 16:22:15.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-nmi.c	2004-12-14 11:57:17.000000000 -0800
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
+		if (node == MAX_NUMNODES)
 			break;
 		if (i == 1000) {
-			for (node=0; node < numnodes; node++)
+			for_each_online_node(node)
 				if (NODEPDA(node)->dump_count == 0) {
 					cpu = node_to_first_cpu(node);
 					for (n=0; n < CNODE_NUM_CPUS(node); cpu++, n++) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-reset.c linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-reset.c
--- linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-reset.c	2004-12-13 16:22:15.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-reset.c	2004-12-14 11:57:17.000000000 -0800
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-smp.c linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-smp.c
--- linux-2.6.10-rc3-mm1/arch/mips/sgi-ip27/ip27-smp.c	2004-12-13 16:22:15.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/arch/mips/sgi-ip27/ip27-smp.c	2004-12-15 15:48:00.000000000 -0800
@@ -108,18 +108,22 @@ void cpu_node_probe(void)
 	for (i = 0; i < MAXCPUS; i++)
 		cpuid_to_compact_node[i] = INVALID_CNODEID;
 
-	numnodes = 0;
+	/*
+	 * MCD - this whole "compact node" stuff can probably be dropped, 
+	 * as we can handle sparse numbering now
+	 */
+	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_COMPACT_NODES; i++) {
 		nasid_t nasid = gdap->g_nasidtable[i];
 		if (nasid == INVALID_NASID)
 			break;
 		compact_to_nasid_node[i] = nasid;
 		nasid_to_compact_node[nasid] = i;
-		numnodes++;
+		node_set_online(num_online_nodes());
 		highest = do_cpumask(i, nasid, highest);
 	}
 
-	printk("Discovered %d cpus on %d nodes\n", highest + 1, numnodes);
+	printk("Discovered %d cpus on %d nodes\n", highest + 1, num_online_nodes());
 }
 
 static void intr_clear_bits(nasid_t nasid, volatile hubreg_t *pend,
@@ -151,10 +155,10 @@ void __init prom_prepare_cpus(unsigned i
 {
 	cnodeid_t	cnode;
 
-	for (cnode = 0; cnode < numnodes; cnode++)
+	for_each_online_node(cnode)
 		intr_clear_all(COMPACT_TO_NASID_NODEID(cnode));
 
-	replicate_kernel_text(numnodes);
+	replicate_kernel_text();
 
 	/*
 	 * Assumption to be fixed: we're always booted on logical / physical
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-mips/sn/sn_private.h linux-2.6.10-rc3-mm1-nom.mips/include/asm-mips/sn/sn_private.h
--- linux-2.6.10-rc3-mm1/include/asm-mips/sn/sn_private.h	2004-12-13 16:23:38.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.mips/include/asm-mips/sn/sn_private.h	2004-12-14 11:57:17.000000000 -0800
@@ -12,8 +12,8 @@ extern void cpu_time_init(void);
 extern void per_cpu_init(void);
 extern void install_cpu_nmi_handler(int slice);
 extern void install_ipi(void);
-extern void setup_replication_mask(int);
-extern void replicate_kernel_text(int);
+extern void setup_replication_mask();
+extern void replicate_kernel_text();
 extern pfn_t node_getfirstfree(cnodeid_t);
 
 #endif /* __ASM_SN_SN_PRIVATE_H */


