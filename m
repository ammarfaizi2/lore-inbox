Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUDHUDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDHUBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:01:53 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:55270 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262422AbUDHTvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:00 -0400
Date: Thu, 8 Apr 2004 12:50:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 18/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125019.05e0a362.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P18.nodemask_core - Matthew Dobson's [PATCH] nodemask_t core changes [2/7]
        nodemask_t-02-core.patch - Changes to arch-independent code.
        Surprisingly few references to numnodes, open-coded node loops,
        etc. in generic code.  Most important result of this patch is
        that no generic code assumes anything about node numbering.
        This allows individual arches to use sparse numbering if they
        care to.

Index: 2.6.5.bitmap/Documentation/vm/numa
===================================================================
--- 2.6.5.bitmap.orig/Documentation/vm/numa	2004-04-08 08:12:31.000000000 -0700
+++ 2.6.5.bitmap/Documentation/vm/numa	2004-04-08 08:12:34.000000000 -0700
@@ -29,7 +29,7 @@
 into a pg_data_t. The bootmem_data_t is just one part of this. To 
 make the code look uniform between NUMA and regular UMA platforms, 
 UMA platforms have a statically allocated pg_data_t too (contig_page_data).
-For the sake of uniformity, the variable "numnodes" is also defined
+For the sake of uniformity, the variable "node_online_map" is also defined
 for all platforms. As we run benchmarks, we might decide to NUMAize 
 more variables like low_on_memory, nr_free_pages etc into the pg_data_t.
 
Index: 2.6.5.bitmap/include/linux/gfp.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/gfp.h	2004-04-08 08:12:31.000000000 -0700
+++ 2.6.5.bitmap/include/linux/gfp.h	2004-04-08 08:12:34.000000000 -0700
@@ -58,7 +58,7 @@
 
 /*
  * We get the zone list from the current node and the gfp_mask.
- * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
+ * This zone list contains a maximum of MAX_NUMNODES*MAX_NR_ZONES zones.
  *
  * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
  * optimized to &contig_page_data at compile-time.
Index: 2.6.5.bitmap/include/linux/topology.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/topology.h	2004-04-08 08:12:31.000000000 -0700
+++ 2.6.5.bitmap/include/linux/topology.h	2004-04-08 08:12:34.000000000 -0700
@@ -43,16 +43,21 @@
 	})
 #endif
 
-static inline int __next_node_with_cpus(int node)
+static inline int __next_node_with_cpus(int last_node)
 {
-	do
-		++node;
-	while (node < numnodes && !nr_cpus_node(node));
-	return node;
+	int nid;
+	for_each_online_node(nid)
+		if (nr_cpus_node(nid) && nid > last_node)
+			return nid;
+
+	return MAX_NUMNODES;
 }
 
-#define for_each_node_with_cpus(node) \
-	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
+/* Assumes first_node(node_online_map) will have CPUs */
+#define for_each_node_with_cpus(node)			\
+	for(node = first_node(node_online_map);		\
+		node < MAX_NUMNODES;			\
+		node = __next_node_with_cpus(node))
 
 #ifndef node_distance
 #define node_distance(from,to)	(from != to)
Index: 2.6.5.bitmap/kernel/sched.c
===================================================================
--- 2.6.5.bitmap.orig/kernel/sched.c	2004-04-08 08:12:31.000000000 -0700
+++ 2.6.5.bitmap/kernel/sched.c	2004-04-08 08:12:34.000000000 -0700
@@ -1084,7 +1084,7 @@
 {
 	int new_cpu;
 
-	if (numnodes > 1) {
+	if (num_online_nodes() > 1) {
 		new_cpu = sched_best_cpu(current);
 		if (new_cpu != smp_processor_id())
 			sched_migrate_task(current, new_cpu);
Index: 2.6.5.bitmap/mm/page_alloc.c
===================================================================
--- 2.6.5.bitmap.orig/mm/page_alloc.c	2004-04-08 08:12:31.000000000 -0700
+++ 2.6.5.bitmap/mm/page_alloc.c	2004-04-08 08:14:14.000000000 -0700
@@ -34,12 +34,12 @@
 
 #include <asm/tlbflush.h>
 
-DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
+nodemask_t node_online_map = NODE_MASK_NONE;
+nodemask_t node_possible_map = NODE_MASK_ALL;
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 int nr_swap_pages;
-int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
 
 EXPORT_SYMBOL(totalram_pages);
@@ -701,14 +701,14 @@
 	struct page *page;
 
 	for (;;) {
-		if (i > nodenr + numnodes)
+		if (i > nodenr + num_online_nodes())
 			return 0;
-		if (node_present_pages(i%numnodes)) {
+		if (node_present_pages(i%num_online_nodes())) {
 			struct zone **z;
 			/* The node contains memory. Check that there is
 			 * memory in the intended zonelist.
 			 */
-			z = NODE_DATA(i%numnodes)->node_zonelists[gfp_mask & GFP_ZONEMASK].zones;
+			z = NODE_DATA(i%num_online_nodes())->node_zonelists[gfp_mask & GFP_ZONEMASK].zones;
 			while (*z) {
 				if ( (*z)->free_pages > (1UL<<order))
 					goto found_node;
@@ -719,7 +719,7 @@
 	}
 found_node:
 	nodenr = i+1;
-	page = alloc_pages_node(i%numnodes, gfp_mask, order);
+	page = alloc_pages_node(i%num_online_nodes(), gfp_mask, order);
 	if (!page)
 		return 0;
 	return (unsigned long) page_address(page);
@@ -1134,7 +1134,7 @@
 }
 
 #ifdef CONFIG_NUMA
-#define MAX_NODE_LOAD (numnodes)
+#define MAX_NODE_LOAD (num_online_nodes())
 static int __initdata node_load[MAX_NUMNODES];
 /**
  * find_next_best_node - find the next node that should appear in a given
@@ -1157,11 +1157,11 @@
 	int min_val = INT_MAX;
 	int best_node = -1;
 
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		cpumask_t tmp;
 
 		/* Start from local node */
-		n = (node+i)%numnodes;
+		n = (node+i)%num_online_nodes();
 
 		/* Don't want a node to appear more than once */
 		if (test_bit(n, used_node_mask))
@@ -1207,7 +1207,7 @@
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
-	load = numnodes;
+	load = num_online_nodes();
 	prev_node = local_node;
 	CLEAR_BITMAP(used_mask, MAX_NUMNODES);
 	while ((node = find_next_best_node(local_node, used_mask)) >= 0) {
@@ -1266,9 +1266,13 @@
  		 * zones coming right after the local ones are those from
  		 * node N+1 (modulo N)
  		 */
- 		for (node = local_node + 1; node < numnodes; node++)
+ 		for (node = next_node(local_node, node_online_map);
+		     node < MAX_NUMNODES;
+		     node = next_node(node, node_online_map))
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
- 		for (node = 0; node < local_node; node++)
+ 		for (node = first_node(node_online_map);
+		     node < local_node;
+		     node = next_node(node, node_online_map))
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  
 		zonelist->zones[j++] = NULL;
@@ -1281,9 +1285,9 @@
 {
 	int i;
 
-	for(i = 0 ; i < numnodes ; i++)
+	for_each_online_node(i)
 		build_zonelists(NODE_DATA(i));
-	printk("Built %i zonelists\n", numnodes);
+	printk("Built %i zonelists\n", num_online_nodes());
 }
 
 /*


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
