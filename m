Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUCRXKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbUCRXJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:09:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:62380 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263269AbUCRXFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:32 -0500
Subject: [PATCH] nodemask_t x86_64 changes [5/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-lOZSGoJIUcG6NRrDiSlw"
Organization: IBM LTC
Message-Id: <1079651082.8149.175.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lOZSGoJIUcG6NRrDiSlw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nodemask_t-05-x86_64.patch - Changes to x86_64 specific code. 
Untested.  Code review & testing requested.

--=-lOZSGoJIUcG6NRrDiSlw
Content-Disposition: attachment; filename=nodemask_t-05-x86_64.patch
Content-Type: text/x-patch; name=nodemask_t-05-x86_64.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/x86_64/kernel/setup64.c linux-2.6.4-nodemask_t-x86_64/arch/x86_64/kernel/setup64.c
--- linux-2.6.4-vanilla/arch/x86_64/kernel/setup64.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-x86_64/arch/x86_64/kernel/setup64.c	Thu Mar 11 12:00:36 2004
@@ -135,11 +135,11 @@ void __init setup_per_cpu_areas(void)
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/x86_64/mm/k8topology.c linux-2.6.4-nodemask_t-x86_64/arch/x86_64/mm/k8topology.c
--- linux-2.6.4-vanilla/arch/x86_64/mm/k8topology.c	Wed Mar 10 18:55:51 2004
+++ linux-2.6.4-nodemask_t-x86_64/arch/x86_64/mm/k8topology.c	Thu Mar 11 14:37:42 2004
@@ -44,7 +44,7 @@ static __init int find_northbridge(void)
 int __init k8_scan_nodes(unsigned long start, unsigned long end)
 { 
 	unsigned long prevbase;
-	struct node nodes[MAXNODE];
+	struct node nodes[MAX_NUMNODES];
 	int nodeid, i, nb; 
 	int found = 0;
 	u32 reg;
@@ -57,9 +57,10 @@ int __init k8_scan_nodes(unsigned long s
 	printk(KERN_INFO "Scanning NUMA topology in Northbridge %d\n", nb); 
 
 	reg = read_pci_config(0, nb, 0, 0x60); 
-	numnodes =  ((reg >> 4) & 7) + 1; 
+	for(i = 0; i <= ((reg >> 4) & 7); i++)
+		node_set_online(i); 
 
-	printk(KERN_INFO "Number of nodes %d (%x)\n", numnodes, reg);
+	printk(KERN_INFO "Number of nodes %d (%x)\n", num_online_nodes(), reg);
 
 	memset(&nodes,0,sizeof(nodes)); 
 	prevbase = 0;
@@ -71,11 +72,11 @@ int __init k8_scan_nodes(unsigned long s
 
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
@@ -91,7 +92,7 @@ int __init k8_scan_nodes(unsigned long s
 			       nodeid, (base>>8)&3, (limit>>8) & 3); 
 			return -1; 
 		}	
-		if ((1UL << nodeid) & nodes_present) { 
+		if (node_online(nodeid)) {
 			printk(KERN_INFO "Node %d already present. Skipping\n", 
 			       nodeid);
 			continue;
@@ -151,7 +152,7 @@ int __init k8_scan_nodes(unsigned long s
 	} 
 	printk(KERN_INFO "Using node hash shift of %d\n", memnode_shift); 
 
-	for (i = 0; i < MAXNODE; i++) { 
+	for_each_node(i) {
 		if (nodes[i].start != nodes[i].end)
 		setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
 	} 
@@ -161,15 +162,14 @@ int __init k8_scan_nodes(unsigned long s
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
+	nodemask_t node_offline_map = nodes_complement(node_online_map);
+	for_each_node_mask(i, node_offline_map) {
 		node_data[i] = node_data[rr];
-		rr++; 
+
+		rr = next_node(rr, node_online_map);
+		if (rr >= MAX_NUMNODES)
+			rr = first_node(node_online_map);
 	}
 
 	if (found == 1) 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/x86_64/mm/numa.c linux-2.6.4-nodemask_t-x86_64/arch/x86_64/mm/numa.c
--- linux-2.6.4-vanilla/arch/x86_64/mm/numa.c	Wed Mar 10 18:55:43 2004
+++ linux-2.6.4-nodemask_t-x86_64/arch/x86_64/mm/numa.c	Thu Mar 11 12:00:36 2004
@@ -16,7 +16,7 @@
 
 #define Dprintk(x...)
 
-struct pglist_data *node_data[MAXNODE];
+struct pglist_data *node_data[MAX_NUMNODES];
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
 
 int memnode_shift;
@@ -24,8 +24,6 @@ u8  memnodemap[NODEMAPSIZE];
 
 static int numa_off __initdata; 
 
-unsigned long nodes_present; 
-
 int __init compute_hash_shift(struct node *nodes)
 {
 	int i; 
@@ -35,7 +33,7 @@ int __init compute_hash_shift(struct nod
 	/* When in doubt use brute force. */
 	while (shift < 48) { 
 		memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE); 
-		for (i = 0; i < numnodes; i++) { 
+		for_each_online_node(i) {
 			if (nodes[i].start == nodes[i].end) 
 				continue;
 			for (addr = nodes[i].start; 
@@ -101,9 +99,6 @@ void __init setup_node_bootmem(int nodei
 
 	reserve_bootmem_node(NODE_DATA(nodeid), nodedata_phys, pgdat_size); 
 	reserve_bootmem_node(NODE_DATA(nodeid), bootmap_start, bootmap_pages<<PAGE_SHIFT);
-	if (nodeid + 1 > numnodes)
-		numnodes = nodeid + 1;
-	nodes_present |= (1UL << nodeid); 
 	node_set_online(nodeid);
 } 
 
@@ -152,7 +147,8 @@ int __init numa_initmem_init(unsigned lo
 	fake_node = 1; 	
 	memnode_shift = 63; 
 	memnodemap[0] = 0;
-	numnodes = 1;
+	nodes_clear(node_online_map);
+	node_set_online(0);
 	setup_node_bootmem(0, start_pfn<<PAGE_SHIFT, end_pfn<<PAGE_SHIFT);
 	return -1; 
 } 
@@ -161,7 +157,7 @@ unsigned long __init numa_free_all_bootm
 { 
 	int i;
 	unsigned long pages = 0;
-	for_all_nodes(i) {
+	for_each_online_node(i) {
 		pages += free_all_bootmem_node(NODE_DATA(i));
 	}
 	return pages;
@@ -170,7 +166,7 @@ unsigned long __init numa_free_all_bootm
 void __init paging_init(void)
 { 
 	int i;
-	for_all_nodes(i) { 
+	for_each_online_node(i) { 
 		setup_node_zones(i); 
 	}
 } 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-x86_64/mmzone.h linux-2.6.4-nodemask_t-x86_64/include/asm-x86_64/mmzone.h
--- linux-2.6.4-vanilla/include/asm-x86_64/mmzone.h	Wed Mar 10 18:55:43 2004
+++ linux-2.6.4-nodemask_t-x86_64/include/asm-x86_64/mmzone.h	Thu Mar 11 12:00:36 2004
@@ -12,7 +12,6 @@
 
 #include <asm/smp.h>
 
-#define MAXNODE 8 
 #define NODEMAPSIZE 0xff
 
 /* Simple perfect hash to map physical addresses to node numbers */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-x86_64/numa.h linux-2.6.4-nodemask_t-x86_64/include/asm-x86_64/numa.h
--- linux-2.6.4-vanilla/include/asm-x86_64/numa.h	Wed Mar 10 18:55:21 2004
+++ linux-2.6.4-nodemask_t-x86_64/include/asm-x86_64/numa.h	Thu Mar 11 12:00:36 2004
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
 

--=-lOZSGoJIUcG6NRrDiSlw--

