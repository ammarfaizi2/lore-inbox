Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbULWWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbULWWvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbULWWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:48:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:10645 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261325AbULWWqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:46:40 -0500
Subject: [RFC PATCH 9/10] Replace 'numnodes' with 'node_online_map' - x86_64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841972.3945.36.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:46:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9/10 - Replace numnodes with node_online_map for x86_64

[mcd@arrakis node_online_map]$ diffstat arch-x86_64.patch
 arch/x86_64/kernel/setup64.c |    3 ++-
 arch/x86_64/mm/k8topology.c  |    9 +++++----
 arch/x86_64/mm/numa.c        |   15 +++++++--------
 arch/x86_64/mm/srat.c        |   13 +++++--------
 include/asm-x86_64/numa.h    |    3 ---
 5 files changed, 19 insertions(+), 24 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/x86_64/kernel/setup64.c linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/kernel/setup64.c
--- linux-2.6.10-rc3-mm1/arch/x86_64/kernel/setup64.c	2004-12-13 16:23:05.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/kernel/setup64.c	2004-12-14 11:57:17.000000000 -0800
@@ -82,7 +82,8 @@ void __init setup_per_cpu_areas(void)
 		unsigned char *ptr;
 
 		if (!NODE_DATA(cpu_to_node(i))) {
-			printk("cpu with no node %d, numnodes %d\n", i, numnodes);
+			printk("cpu with no node %d, num_online_nodes %d\n", 
+			       i, num_online_nodes());
 			ptr = alloc_bootmem(size);
 		} else { 
 			ptr = alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/x86_64/mm/k8topology.c linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/mm/k8topology.c
--- linux-2.6.10-rc3-mm1/arch/x86_64/mm/k8topology.c	2004-12-13 16:23:05.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/mm/k8topology.c	2004-12-14 16:08:46.000000000 -0800
@@ -55,9 +55,10 @@ int __init k8_scan_nodes(unsigned long s
 	printk(KERN_INFO "Scanning NUMA topology in Northbridge %d\n", nb); 
 
 	reg = read_pci_config(0, nb, 0, 0x60); 
-	numnodes =  ((reg >> 4) & 7) + 1; 
+	for (i = 0; i <= ((reg >> 4) & 7); i++)
+		node_set_online(i);
 
-	printk(KERN_INFO "Number of nodes %d (%x)\n", numnodes, reg);
+	printk(KERN_INFO "Number of nodes %d (%x)\n", num_online_nodes(), reg);
 
 	memset(&nodes,0,sizeof(nodes)); 
 	prevbase = 0;
@@ -69,11 +70,11 @@ int __init k8_scan_nodes(unsigned long s
 
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/x86_64/mm/numa.c linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/mm/numa.c
--- linux-2.6.10-rc3-mm1/arch/x86_64/mm/numa.c	2004-12-13 16:23:05.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/mm/numa.c	2004-12-14 16:12:18.000000000 -0800
@@ -45,7 +45,7 @@ int __init compute_hash_shift(struct nod
 	/* When in doubt use brute force. */
 	while (shift < 48) { 
 		memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE); 
-		for (i = 0; i < numnodes; i++) { 
+		for_each_online_node(i) { 
 			if (nodes[i].start == nodes[i].end) 
 				continue;
 			for (addr = nodes[i].start; 
@@ -111,8 +111,6 @@ void __init setup_node_bootmem(int nodei
 
 	reserve_bootmem_node(NODE_DATA(nodeid), nodedata_phys, pgdat_size); 
 	reserve_bootmem_node(NODE_DATA(nodeid), bootmap_start, bootmap_pages<<PAGE_SHIFT);
-	if (nodeid + 1 > numnodes)
-		numnodes = nodeid + 1;
 	node_set_online(nodeid);
 } 
 
@@ -197,15 +195,15 @@ static int numa_emulation(unsigned long 
  		       i,
  		       nodes[i].start, nodes[i].end,
  		       (nodes[i].end - nodes[i].start) >> 20);
+		node_set_online(i);
  	}
- 	numnodes = numa_fake;
  	memnode_shift = compute_hash_shift(nodes);
  	if (memnode_shift < 0) {
  		memnode_shift = 0;
  		printk(KERN_ERR "No NUMA hash function found. Emulation disabled.\n");
  		return -1;
  	}
- 	for (i = 0; i < numa_fake; i++)
+ 	for_each_online_node(i)
  		setup_node_bootmem(i, nodes[i].start, nodes[i].end);
  	numa_init_array();
  	return 0;
@@ -240,7 +238,8 @@ void __init numa_initmem_init(unsigned l
 		/* setup dummy node covering all memory */ 
 	memnode_shift = 63; 
 	memnodemap[0] = 0;
-	numnodes = 1;
+	nodes_clear(node_online_map);
+	node_set_online(0);
 	for (i = 0; i < NR_CPUS; i++)
 		cpu_to_node[i] = 0;
 	node_to_cpumask[0] = cpumask_of_cpu(0);
@@ -258,7 +257,7 @@ unsigned long __init numa_free_all_bootm
 { 
 	int i;
 	unsigned long pages = 0;
-	for_all_nodes(i) {
+	for_each_online_node(i) {
 		pages += free_all_bootmem_node(NODE_DATA(i));
 	}
 	return pages;
@@ -267,7 +266,7 @@ unsigned long __init numa_free_all_bootm
 void __init paging_init(void)
 { 
 	int i;
-	for_all_nodes(i) { 
+	for_each_online_node(i) { 
 		setup_node_zones(i); 
 	}
 } 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/x86_64/mm/srat.c linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/mm/srat.c
--- linux-2.6.10-rc3-mm1/arch/x86_64/mm/srat.c	2004-12-13 16:23:05.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.x86_64/arch/x86_64/mm/srat.c	2004-12-14 16:17:39.000000000 -0800
@@ -27,10 +27,10 @@ static __u8  pxm2node[256] __initdata = 
 static __init int setup_node(int pxm)
 {
 	if (pxm2node[pxm] == 0xff) {
-		if (numnodes > MAX_NUMNODES)
+		if (num_online_nodes() >= MAX_NUMNODES)
 			return -1;
-		pxm2node[pxm] = numnodes - 1;
-		numnodes++;
+		pxm2node[pxm] = num_online_nodes();
+		node_set_online(num_online_nodes());
 	}
 	return pxm2node[pxm];
 }
@@ -38,7 +38,7 @@ static __init int setup_node(int pxm)
 static __init int conflicting_nodes(unsigned long start, unsigned long end)
 {
 	int i;
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		struct node *nd = &nodes[i];
 		if (nd->start == nd->end)
 			continue;
@@ -155,10 +155,7 @@ acpi_numa_memory_affinity_init(struct ac
 	       nd->start, nd->end);
 }
 
-void __init acpi_numa_arch_fixup(void)
-{
-	numnodes--;
-}
+void __init acpi_numa_arch_fixup(void) {}
 
 /* Use the information discovered above to actually set up the nodes. */
 int __init acpi_scan_nodes(unsigned long start, unsigned long end)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-x86_64/numa.h linux-2.6.10-rc3-mm1-nom.x86_64/include/asm-x86_64/numa.h
--- linux-2.6.10-rc3-mm1/include/asm-x86_64/numa.h	2004-12-13 16:23:20.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.x86_64/include/asm-x86_64/numa.h	2004-12-14 11:57:17.000000000 -0800
@@ -8,9 +8,6 @@ struct node { 
 	u64 start,end; 
 };
 
-#define for_all_nodes(x) for ((x) = 0; (x) < numnodes; (x)++) \
-				if (node_online(x))
-
 extern int compute_hash_shift(struct node *nodes);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))


