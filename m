Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUDHTz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUDHTzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:55:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37352 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262532AbUDHTvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:47 -0400
Date: Thu, 8 Apr 2004 12:50:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 21/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125037.7c65ac76.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P21.nodemask_x86_64 - Matthew Dobson's [PATCH]_nodemask_t_x86_64_changes_[5_7]
        Changes to x86_64 specific code.
        Untested.  Code review & testing requested.

Index: 2.6.5.bitmap/arch/x86_64/kernel/setup64.c
===================================================================
--- 2.6.5.bitmap.orig/arch/x86_64/kernel/setup64.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/x86_64/kernel/setup64.c	2004-04-08 04:46:12.000000000 -0700
@@ -135,11 +135,11 @@
 		unsigned char *ptr;
 		/* If possible allocate on the node of the CPU.
 		   In case it doesn't exist round-robin nodes. */
-		if (!NODE_DATA(i % numnodes)) { 
-			printk("cpu with no node %d, numnodes %d\n", i, numnodes);
+		if (!NODE_DATA(i % num_online_nodes())) { 
+			printk("cpu with no node %d, num_online_nodes() %d\n", i, num_online_nodes());
 			ptr = alloc_bootmem(size);
 		} else { 
-			ptr = alloc_bootmem_node(NODE_DATA(i % numnodes), size);
+			ptr = alloc_bootmem_node(NODE_DATA(i % num_online_nodes()), size);
 		}
 		if (!ptr)
 			panic("Cannot allocate cpu data for CPU %d\n", i);
Index: 2.6.5.bitmap/arch/x86_64/mm/k8topology.c
===================================================================
--- 2.6.5.bitmap.orig/arch/x86_64/mm/k8topology.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/x86_64/mm/k8topology.c	2004-04-08 04:46:12.000000000 -0700
@@ -44,7 +44,7 @@
 int __init k8_scan_nodes(unsigned long start, unsigned long end)
 { 
 	unsigned long prevbase;
-	struct node nodes[MAXNODE];
+	struct node nodes[MAX_NUMNODES];
 	int nodeid, i, nb; 
 	int found = 0;
 	u32 reg;
@@ -57,9 +57,10 @@
 	printk(KERN_INFO "Scanning NUMA topology in Northbridge %d\n", nb); 
 
 	reg = read_pci_config(0, nb, 0, 0x60); 
-	numnodes =  ((reg >> 4) & 7) + 1; 
+	for(i = 0; i <= ((reg >> 4) & 7); i++)
+		node_set_online(i); 
 
-	printk(KERN_INFO "Number of nodes %d (%x)\n", numnodes, reg);
+	printk(KERN_INFO "Number of nodes %d (%x)\n", num_online_nodes(), reg);
 
 	memset(&nodes,0,sizeof(nodes)); 
 	prevbase = 0;
@@ -71,11 +72,11 @@
 
 		nodeid = limit & 7; 
 		if ((base & 3) == 0) { 
-			if (i < numnodes) 
+			if (i < num_online_nodes()) 
 				printk("Skipping disabled node %d\n", i); 
 			continue;
 		} 
-		if (nodeid >= numnodes) { 
+		if (nodeid >= num_online_nodes()) { 
 			printk("Ignoring excess node %d (%lx:%lx)\n", nodeid,
 			       base, limit); 
 			continue;
@@ -91,7 +92,7 @@
 			       nodeid, (base>>8)&3, (limit>>8) & 3); 
 			return -1; 
 		}	
-		if ((1UL << nodeid) & nodes_present) { 
+		if (node_online(nodeid)) {
 			printk(KERN_INFO "Node %d already present. Skipping\n", 
 			       nodeid);
 			continue;
@@ -151,7 +152,7 @@
 	} 
 	printk(KERN_INFO "Using node hash shift of %d\n", memnode_shift); 
 
-	for (i = 0; i < MAXNODE; i++) { 
+	for_each_node(i) {
 		if (nodes[i].start != nodes[i].end)
 		setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
 	} 
@@ -161,15 +162,16 @@
 	   mapping. To avoid this fill in the mapping for all possible
 	   CPUs, as the number of CPUs is not known yet. 
 	   We round robin the existing nodes. */
-	rr = 0;
-	for (i = 0; i < MAXNODE; i++) {
-		if (nodes_present & (1UL<<i))
-			continue;
-		if ((nodes_present >> rr) == 0) 
-			rr = 0; 
-		rr = ffz(~nodes_present >> rr); 
+	rr = first_node(node_online_map);
+	for_each_node(i) {
+		if (node_online(i))
+			continue;
+
 		node_data[i] = node_data[rr];
-		rr++; 
+
+		rr = next_node(rr, node_online_map);
+		if (rr >= MAX_NUMNODES)
+			rr = first_node(node_online_map);
 	}
 
 	if (found == 1) 
Index: 2.6.5.bitmap/arch/x86_64/mm/numa.c
===================================================================
--- 2.6.5.bitmap.orig/arch/x86_64/mm/numa.c	2004-04-05 02:41:32.000000000 -0700
+++ 2.6.5.bitmap/arch/x86_64/mm/numa.c	2004-04-08 04:46:12.000000000 -0700
@@ -18,7 +18,7 @@
 #define Dprintk(x...)
 #endif
 
-struct pglist_data *node_data[MAXNODE];
+struct pglist_data *node_data[MAX_NUMNODES];
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
 
 int memnode_shift;
@@ -26,8 +26,6 @@
 
 static int numa_off __initdata; 
 
-unsigned long nodes_present; 
-
 int __init compute_hash_shift(struct node *nodes)
 {
 	int i; 
@@ -37,7 +35,7 @@
 	/* When in doubt use brute force. */
 	while (shift < 48) { 
 		memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE); 
-		for (i = 0; i < numnodes; i++) { 
+		for_each_online_node(i) {
 			if (nodes[i].start == nodes[i].end) 
 				continue;
 			for (addr = nodes[i].start; 
@@ -103,9 +101,6 @@
 
 	reserve_bootmem_node(NODE_DATA(nodeid), nodedata_phys, pgdat_size); 
 	reserve_bootmem_node(NODE_DATA(nodeid), bootmap_start, bootmap_pages<<PAGE_SHIFT);
-	if (nodeid + 1 > numnodes)
-		numnodes = nodeid + 1;
-	nodes_present |= (1UL << nodeid); 
 	node_set_online(nodeid);
 } 
 
@@ -154,7 +149,8 @@
 	fake_node = 1; 	
 	memnode_shift = 63; 
 	memnodemap[0] = 0;
-	numnodes = 1;
+	nodes_clear(node_online_map);
+	node_set_online(0);
 	setup_node_bootmem(0, start_pfn<<PAGE_SHIFT, end_pfn<<PAGE_SHIFT);
 	return -1; 
 } 
@@ -163,7 +159,7 @@
 { 
 	int i;
 	unsigned long pages = 0;
-	for_all_nodes(i) {
+	for_each_online_node(i) {
 		pages += free_all_bootmem_node(NODE_DATA(i));
 	}
 	return pages;
@@ -172,7 +168,7 @@
 void __init paging_init(void)
 { 
 	int i;
-	for_all_nodes(i) { 
+	for_each_online_node(i) { 
 		setup_node_zones(i); 
 	}
 } 
Index: 2.6.5.bitmap/include/asm-x86_64/mmzone.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-x86_64/mmzone.h	2004-04-05 02:41:33.000000000 -0700
+++ 2.6.5.bitmap/include/asm-x86_64/mmzone.h	2004-04-08 04:46:12.000000000 -0700
@@ -12,7 +12,6 @@
 
 #include <asm/smp.h>
 
-#define MAXNODE 8 
 #define NODEMAPSIZE 0xff
 
 /* Simple perfect hash to map physical addresses to node numbers */
Index: 2.6.5.bitmap/include/asm-x86_64/numa.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-x86_64/numa.h	2004-04-05 02:41:33.000000000 -0700
+++ 2.6.5.bitmap/include/asm-x86_64/numa.h	2004-04-08 04:46:12.000000000 -0700
@@ -1,19 +1,13 @@
 #ifndef _ASM_X8664_NUMA_H 
 #define _ASM_X8664_NUMA_H 1
 
-#define MAXNODE 8 
 #define NODEMASK 0xff
 
 struct node { 
 	u64 start,end; 
 };
 
-#define for_all_nodes(x) for ((x) = 0; (x) < numnodes; (x)++) \
-				if ((1UL << (x)) & nodes_present)
-
-
 extern int compute_hash_shift(struct node *nodes);
-extern unsigned long nodes_present;
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
