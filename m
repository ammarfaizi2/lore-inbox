Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757271AbWKWBf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbWKWBf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757269AbWKWBf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:35:26 -0500
Received: from smtp-out.google.com ([216.239.45.12]:2996 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757268AbWKWBfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:35:19 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=a7cBQjlGI960SJSfSwyyYYqY84nDgB8S1PiqrKvS5KUEGITOjmrjbLxAwve3HHknM
	QAa1VRsqrtZxw1EzICwlQ==
Subject: [Patch3/4]: fake numa for x86_64 patches
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 22 Nov 2006 17:34:47 -0800
Message-Id: <1164245687.29844.153.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the existing numa=fake so that ioholes are appropriately configured.
Currently machines that have sizeable IO holes don't work with
numa=fake>4.  This patch tries to equally partition the total available
memory in equal size chunk.  The minimum size of the fake node is set to
32MB.

Signed-off-by: David Rientjes <reintjes@google.com>
Signed-off-by: Paul Menage <menage@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>

--- linux-2.6.19-rc5-mm2.org/include/asm-x86_64/mmzone.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.19-rc5-mm2/include/asm-x86_64/mmzone.h	2006-11-20 11:39:19.000000000 -0800
@@ -11,25 +11,26 @@
 
 #include <asm/smp.h>
 
-/* Should really switch to dynamic allocation at some point */
-#define NODEMAPSIZE 0x4fff
-
-/* Simple perfect hash to map physical addresses to node numbers */
-struct memnode {
-	int shift;
-	u8 map[NODEMAPSIZE];
-} ____cacheline_aligned;
-extern struct memnode memnode;
-#define memnode_shift memnode.shift
-#define memnodemap memnode.map
+/*
+ * Generic node memory support with the following assumptions:
+ * 1) Memory is allocated in NODE_MIN_SIZE contiguous chunks
+ * 2) There is not more than 64GB of system memory total
+ *
+ * 64GB / (4KB / page) == 16777216 pages
+ */
+#define MAX_NR_PAGES 16777216
+#define NODE_MIN_SIZE (32<<20)
+#define PAGES_PER_ELEMENT (NODE_MIN_SIZE / PAGE_SIZE)
+#define MAX_ELEMENTS (MAX_NR_PAGES / PAGES_PER_ELEMENT)
+#define NODE_HASH_MASK (~(NODE_MIN_SIZE -1ul))
 
+extern unsigned char physnode_map[];
 extern struct pglist_data *node_data[];
 
 static inline __attribute__((pure)) int phys_to_nid(unsigned long addr) 
 { 
-	unsigned nid; 
-	VIRTUAL_BUG_ON((addr >> memnode_shift) >= NODEMAPSIZE);
-	nid = memnodemap[addr >> memnode_shift]; 
+	int nid; 
+	nid = ((int)physnode_map[(addr >> PAGE_SHIFT) / PAGES_PER_ELEMENT]);
 	VIRTUAL_BUG_ON(nid >= MAX_NUMNODES || !node_data[nid]); 
 	return nid; 
 } 
--- linux-2.6.19-rc5-mm2.org/include/asm-x86_64/numa.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.19-rc5-mm2/include/asm-x86_64/numa.h	2006-11-20 11:40:20.000000000 -0800
@@ -7,7 +7,7 @@ struct bootnode {
 	u64 start,end; 
 };
 
-extern int compute_hash_shift(struct bootnode *nodes, int numnodes);
+extern void populate_physnode_map(struct bootnode *nodes, int numnodes);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 
--- linux-2.6.19-rc5-mm2.org/arch/x86_64/mm/k8topology.c	2006-11-22 12:20:34.000000000 -0800
+++ linux-2.6.19-rc5-mm2/arch/x86_64/mm/k8topology.c	2006-11-20 11:24:10.000000000 -0800
@@ -141,7 +141,10 @@ int __init k8_scan_nodes(unsigned long s
 			       prevbase,base);
 			return -1;
 		}
-			
+		
+		/* Round down to NODE_HASH_MASK */
+		limit = ((limit - base) & NODE_HASH_MASK) + base;
+
 		printk(KERN_INFO "Node %d MemBase %016lx Limit %016lx\n", 
 		       nodeid, base, limit); 
 		
@@ -161,12 +164,7 @@ int __init k8_scan_nodes(unsigned long s
 	if (!found)
 		return -1; 
 
-	memnode_shift = compute_hash_shift(nodes, 8);
-	if (memnode_shift < 0) { 
-		printk(KERN_ERR "No NUMA node hash function found. Contact maintainer\n"); 
-		return -1; 
-	} 
-	printk(KERN_INFO "Using node hash shift of %d\n", memnode_shift); 
+	populate_physnode_map(nodes, 8);
 
 	for (i = 0; i < 8; i++) {
 		if (nodes[i].start != nodes[i].end) { 
--- linux-2.6.19-rc5-mm2.org/arch/x86_64/mm/srat.c	2006-11-22 12:20:34.000000000 -0800
+++ linux-2.6.19-rc5-mm2/arch/x86_64/mm/srat.c	2006-11-20 11:29:50.000000000 -0800
@@ -31,10 +31,6 @@ static struct bootnode nodes_add[MAX_NUM
 static int found_add_area __initdata;
 int hotadd_percent __initdata = 0;
 
-/* Too small nodes confuse the VM badly. Usually they result
-   from BIOS bugs. */
-#define NODE_MIN_SIZE (4*1024*1024)
-
 static __init int setup_node(int pxm)
 {
 	return acpi_map_pxm_to_node(pxm);
@@ -394,11 +390,14 @@ int __init acpi_scan_nodes(unsigned long
 
 	/* First clean up the node list */
 	for (i = 0; i < MAX_NUMNODES; i++) {
+		signed long sz = nodes[i].end - nodes[i].start;
  		cutoff_node(i, start, end);
-		if ((nodes[i].end - nodes[i].start) < NODE_MIN_SIZE) {
+		if (sz < NODE_MIN_SIZE) {
 			unparse_node(i);
 			node_set_offline(i);
 		}
+		/* Round down. */
+		nodes[i].end = nodes[i].start + (sz & NODE_HASH_MASK);
 	}
 
 	if (acpi_numa <= 0)
@@ -409,13 +408,7 @@ int __init acpi_scan_nodes(unsigned long
 		return -1;
 	}
 
-	memnode_shift = compute_hash_shift(nodes, MAX_NUMNODES);
-	if (memnode_shift < 0) {
-		printk(KERN_ERR
-		     "SRAT: No NUMA node hash function found. Contact maintainer\n");
-		bad_srat();
-		return -1;
-	}
+	populate_physnode_map(nodes, MAX_NUMNODES);
 
 	/* Finally register nodes */
 	for_each_node_mask(i, nodes_parsed)
--- linux-2.6.19-rc5-mm2.org/arch/x86_64/mm/numa.c	2006-11-22 12:20:34.000000000 -0800
+++ linux-2.6.19-rc5-mm2/arch/x86_64/mm/numa.c	2006-11-22 16:47:57.000000000 -0800
@@ -25,72 +25,34 @@
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
 
-struct memnode memnode;
-
 unsigned char cpu_to_node[NR_CPUS] __read_mostly = {
 	[0 ... NR_CPUS-1] = NUMA_NO_NODE
 };
 unsigned char apicid_to_node[MAX_LOCAL_APIC] __cpuinitdata = {
  	[0 ... MAX_LOCAL_APIC-1] = NUMA_NO_NODE
 };
+unsigned char physnode_map[MAX_ELEMENTS] __read_mostly = {
+	[0 ... MAX_ELEMENTS-1] = NUMA_NO_NODE
+};
 cpumask_t node_to_cpumask[MAX_NUMNODES] __read_mostly;
 
 int numa_off __initdata;
+struct bootnode nodes[MAX_NUMNODES] __initdata;
 
-
-/*
- * Given a shift value, try to populate memnodemap[]
- * Returns :
- * 1 if OK
- * 0 if memnodmap[] too small (of shift too small)
- * -1 if node overlap or lost ram (shift too big)
- */
-static int __init
-populate_memnodemap(const struct bootnode *nodes, int numnodes, int shift)
+void __init populate_physnode_map(struct bootnode *nodes, int numnodes)
 {
 	int i; 
-	int res = -1;
-	unsigned long addr, end;
+	unsigned long addr, end, pfn;
 
-	if (shift >= 64)
-		return -1;
-	memset(memnodemap, 0xff, sizeof(memnodemap));
 	for (i = 0; i < numnodes; i++) {
 		addr = nodes[i].start;
 		end = nodes[i].end;
 		if (addr >= end)
 			continue;
-		if ((end >> shift) >= NODEMAPSIZE)
-			return 0;
-		do {
-			if (memnodemap[addr >> shift] != 0xff)
-				return -1;
-			memnodemap[addr >> shift] = i;
-                       addr += (1UL << shift);
-		} while (addr < end);
-		res = 1;
+		for (pfn = addr >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT);
+		     pfn += PAGES_PER_ELEMENT)
+			physnode_map[pfn / PAGES_PER_ELEMENT] = i;
 	} 
-	return res;
-}
-
-int __init compute_hash_shift(struct bootnode *nodes, int numnodes)
-{
-	int shift = 20;
-
-	while (populate_memnodemap(nodes, numnodes, shift + 1) >= 0)
-		shift++;
-
-	printk(KERN_DEBUG "NUMA: Using %d for the hash shift.\n",
-		shift);
-
-	if (populate_memnodemap(nodes, numnodes, shift) != 1) {
-		printk(KERN_INFO
-	"Your memory is not aligned you need to rebuild your kernel "
-	"with a bigger NODEMAPSIZE shift=%d\n",
-			shift);
-		return -1;
-	}
-	return shift;
 }
 
 #ifdef CONFIG_SPARSEMEM
@@ -218,49 +180,141 @@ void __init numa_init_array(void)
 #ifdef CONFIG_NUMA_EMU
 int numa_fake __initdata = 0;
 
-/* Numa emulation */
-static int __init numa_emulation(unsigned long start_pfn, unsigned long end_pfn)
+/*
+ * Sets up nodeid to range from addr to addr + sz.  If the end boundary is
+ * greater than max_addr, then max_addr is used instead.  The return value is 0
+ * if there is additional memory left for allocation past addr and -1 otherwise.
+ * addr is adjusted to be at the end of the node.
+ */
+static int setup_node_range(int nodeid, struct bootnode *nodes, u64 *addr,
+			    u64 sz, u64 max_addr)
 {
- 	int i;
- 	struct bootnode nodes[MAX_NUMNODES];
- 	unsigned long sz = ((end_pfn - start_pfn)<<PAGE_SHIFT) / numa_fake;
-
- 	/* Kludge needed for the hash function */
- 	if (hweight64(sz) > 1) {
- 		unsigned long x = 1;
- 		while ((x << 1) < sz)
- 			x <<= 1;
- 		if (x < sz/2)
- 			printk(KERN_ERR "Numa emulation unbalanced. Complain to maintainer\n");
- 		sz = x;
- 	}
-
- 	memset(&nodes,0,sizeof(nodes));
- 	for (i = 0; i < numa_fake; i++) {
- 		nodes[i].start = (start_pfn<<PAGE_SHIFT) + i*sz;
- 		if (i == numa_fake-1)
- 			sz = (end_pfn<<PAGE_SHIFT) - nodes[i].start;
- 		nodes[i].end = nodes[i].start + sz;
- 		printk(KERN_INFO "Faking node %d at %016Lx-%016Lx (%LuMB)\n",
- 		       i,
- 		       nodes[i].start, nodes[i].end,
- 		       (nodes[i].end - nodes[i].start) >> 20);
-		node_set_online(i);
- 	}
- 	memnode_shift = compute_hash_shift(nodes, numa_fake);
- 	if (memnode_shift < 0) {
- 		memnode_shift = 0;
- 		printk(KERN_ERR "No NUMA hash function found. Emulation disabled.\n");
- 		return -1;
- 	}
+	int ret = 0;
+	nodes[nodeid].start = *addr;
+	*addr += sz;
+	if (*addr >= max_addr) {
+		*addr = max_addr;
+		ret = -1;
+	}
+	nodes[nodeid].end = *addr;
+	node_set_online(nodeid);
+	printk(KERN_INFO "Faking node %d at %016Lx-%016Lx (%LuMB)\n", nodeid,
+	       nodes[nodeid].start, nodes[nodeid].end,
+	       (nodes[nodeid].end - nodes[nodeid].start) >> 20);
+	return ret;
+}
+
+int zone_cross_over(unsigned long start, unsigned long end)
+{
+	if ((start < (MAX_DMA32_PFN << PAGE_SHIFT)) &&
+		(end >= (MAX_DMA32_PFN << PAGE_SHIFT)))
+		return 1;
+	return 0;
+}
+
+/*
+ * Splits num_nodes nodes up equally starting at node_start.  The return value
+ * is the number of nodes split up and addr is adjusted to be at the end of the
+ * last node allocated.
+ */
+static int split_nodes_equal(struct bootnode *nodes, u64 *addr, u64 max_addr,
+			     int node_start, int num_nodes)
+{
+	unsigned long big;
+	unsigned long  sz;
+	int i;
+
+	if (num_nodes <= 0)
+		return -1;
+	if (num_nodes > MAX_NUMNODES)
+		num_nodes = MAX_NUMNODES;
+	big = e820_hole_size(*addr, max_addr);
+	sz = (max_addr - *addr - big) / num_nodes;
+	/*
+	 * Calculate the number of big nodes that can be allocated as a result
+	 * of consolidating our leftovers.
+	 */
+	big = ((sz & ~NODE_HASH_MASK) * num_nodes) / NODE_MIN_SIZE;
+
+	/* Round down to the nearest 4MB for hash function */
+	sz &= NODE_HASH_MASK;
+	printk(KERN_INFO"Number of big nodes = %lu\n", big);
+	if (!sz) {
+		printk(KERN_ERR "Not enough memory allotted for each node. "
+		       "NUMA emulation disabled.\n");
+		return -1;
+	}
+
+	for (i = node_start; i < num_nodes + node_start; i++) {
+		u64 end = *addr + sz;
+		if ((i - node_start) < big)
+			end += NODE_MIN_SIZE;
+		/*
+		 * The final node can have the remaining system RAM.  Other
+		 * nodes receive roughly the same amount of available pages.
+		 */
+		if (i == num_nodes + node_start - 1)
+			end = max_addr;
+		else {
+			while (end - *addr - e820_hole_size(*addr, end) < sz) {
+				end += NODE_MIN_SIZE;
+				if (end > max_addr)
+					break;
+			}
+			/*
+			 * Look at next node to see if
+			 * there is any hole there.  We want to make
+			 * sure that there is no node that is starting
+			 * with hole...or still worse only has hole in
+			 * it. Generally the holes are well aligned.
+			 */
+			while (e820_hole_size(end, end+sz) > 0) {
+				if (zone_cross_over(*addr, end+sz)) {
+					end = (MAX_DMA32_PFN << PAGE_SHIFT);
+					break;
+				}
+				if (end >= max_addr)
+					break;
+				end += sz;
+			}
+		}
+		/* setup_node_range will also do *addr += sz
+		 */
+		if (setup_node_range(i, nodes, addr, end - *addr, max_addr) < 0)
+			break;
+	}
+	return i - node_start + 1;
+}
+
+/*
+ * Sets up the system RAM area from start_pfn to end_pfn according to the
+ * numa=fake command line.
+ */
+static int numa_emulation(unsigned long start_pfn, unsigned long end_pfn)
+{
+	u64 addr = start_pfn << PAGE_SHIFT;
+	u64 max_addr = end_pfn << PAGE_SHIFT;
+	int num_nodes;
+	int i;
+
+	memset(&nodes, 0, sizeof(nodes));
+	/*
+	 * If the numa=fake command line is just a single number N, split the
+	 * system RAM into N fake nodes.
+	 */
+	num_nodes = split_nodes_equal(nodes, &addr, max_addr, 0, numa_fake);
+	if (num_nodes < 0)
+		return num_nodes;
+	populate_physnode_map(nodes, num_nodes);
  	for_each_online_node(i) {
 		e820_register_active_regions(i, nodes[i].start >> PAGE_SHIFT,
 						nodes[i].end >> PAGE_SHIFT);
  		setup_node_bootmem(i, nodes[i].start, nodes[i].end);
 	}
- 	numa_init_array();
- 	return 0;
+	numa_init_array();
+	return 0;
 }
+
 #endif
 
 void __init numa_initmem_init(unsigned long start_pfn, unsigned long end_pfn)
@@ -288,14 +342,15 @@ void __init numa_initmem_init(unsigned l
 	printk(KERN_INFO "Faking a node at %016lx-%016lx\n", 
 	       start_pfn << PAGE_SHIFT,
 	       end_pfn << PAGE_SHIFT); 
-		/* setup dummy node covering all memory */ 
-	memnode_shift = 63; 
-	memnodemap[0] = 0;
+	/* setup dummy node covering all memory */ 
 	nodes_clear(node_online_map);
 	node_set_online(0);
 	for (i = 0; i < NR_CPUS; i++)
 		numa_set_node(i, 0);
 	node_to_cpumask[0] = cpumask_of_cpu(0);
+	nodes[0].start = start_pfn << PAGE_SHIFT;
+	nodes[0].end = end_pfn << PAGE_SHIFT;
+	populate_physnode_map(nodes, 1);
 	e820_register_active_regions(0, start_pfn, end_pfn);
 	setup_node_bootmem(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
 }
@@ -361,7 +416,7 @@ static __init int numa_setup(char *opt)
 		numa_off = 1;
 #ifdef CONFIG_NUMA_EMU
 	if(!strncmp(opt, "fake=", 5)) {
-		numa_fake = simple_strtoul(opt+5,NULL,0); ;
+		numa_fake = simple_strtoul(opt+5,NULL,0);
 		if (numa_fake >= MAX_NUMNODES)
 			numa_fake = MAX_NUMNODES;
 	}
@@ -404,8 +459,8 @@ void __init init_cpu_to_node(void)
 
 EXPORT_SYMBOL(cpu_to_node);
 EXPORT_SYMBOL(node_to_cpumask);
-EXPORT_SYMBOL(memnode);
 EXPORT_SYMBOL(node_data);
+EXPORT_SYMBOL(physnode_map);
 
 #ifdef CONFIG_DISCONTIGMEM
 /*


