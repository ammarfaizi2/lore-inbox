Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbULWWzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbULWWzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbULWWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:55:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3238 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261332AbULWWsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:48:03 -0500
Subject: [RFC PATCH 10/10] Replace 'numnodes' with 'node_online_map' -
	arch-independent
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103842066.3945.39.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:47:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10/10 - Replace numnodes with node_online_map for arch-independent code

[mcd@arrakis node_online_map]$ diffstat arch-generic.patch
 Documentation/vm/numa    |    2 +-
 drivers/base/node.c      |    2 +-
 include/linux/mmzone.h   |    1 -
 include/linux/topology.h |   13 +++----------
 mm/hugetlb.c             |    4 ++--
 mm/mempolicy.c           |    2 +-
 mm/page_alloc.c          |   46 ++++++++++++++++++++++++++--------------------
 7 files changed, 34 insertions(+), 36 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/Documentation/vm/numa linux-2.6.10-rc3-mm1-nom.generic/Documentation/vm/numa
--- linux-2.6.10-rc3-mm1/Documentation/vm/numa	2004-12-13 16:24:49.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/Documentation/vm/numa	2004-12-20 16:56:02.000000000 -0800
@@ -29,7 +29,7 @@ Each node's page allocation data structu
 into a pg_data_t. The bootmem_data_t is just one part of this. To 
 make the code look uniform between NUMA and regular UMA platforms, 
 UMA platforms have a statically allocated pg_data_t too (contig_page_data).
-For the sake of uniformity, the variable "numnodes" is also defined
+For the sake of uniformity, the function num_online_nodes() is also defined
 for all platforms. As we run benchmarks, we might decide to NUMAize 
 more variables like low_on_memory, nr_free_pages etc into the pg_data_t.
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/drivers/base/node.c linux-2.6.10-rc3-mm1-nom.generic/drivers/base/node.c
--- linux-2.6.10-rc3-mm1/drivers/base/node.c	2004-12-13 16:20:36.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/drivers/base/node.c	2004-12-20 16:56:02.000000000 -0800
@@ -120,7 +120,7 @@ static ssize_t node_read_distance(struct
 	/* buf currently PAGE_SIZE, need ~4 chars per node */
 	BUILD_BUG_ON(MAX_NUMNODES*4 > PAGE_SIZE/2);
 
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
 
 	len += sprintf(buf + len, "\n");
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/linux/mmzone.h linux-2.6.10-rc3-mm1-nom.generic/include/linux/mmzone.h
--- linux-2.6.10-rc3-mm1/include/linux/mmzone.h	2004-12-13 16:23:30.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/include/linux/mmzone.h	2004-12-20 16:56:02.000000000 -0800
@@ -271,7 +271,6 @@ typedef struct pglist_data {
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
 
-extern int numnodes;
 extern struct pglist_data *pgdat_list;
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/linux/topology.h linux-2.6.10-rc3-mm1-nom.generic/include/linux/topology.h
--- linux-2.6.10-rc3-mm1/include/linux/topology.h	2004-12-13 16:23:31.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/include/linux/topology.h	2004-12-20 16:56:02.000000000 -0800
@@ -43,16 +43,9 @@
 	})
 #endif
 
-static inline int __next_node_with_cpus(int node)
-{
-	do
-		++node;
-	while (node < numnodes && !nr_cpus_node(node));
-	return node;
-}
-
-#define for_each_node_with_cpus(node) \
-	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
+#define for_each_node_with_cpus(node)						\
+	for_each_online_node(node)						\
+		if (nr_cpus_node(node))
 
 #ifndef node_distance
 /* Conform to ACPI 2.0 SLIT distance definitions */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/mm/hugetlb.c linux-2.6.10-rc3-mm1-nom.generic/mm/hugetlb.c
--- linux-2.6.10-rc3-mm1/mm/hugetlb.c	2004-12-13 16:25:02.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/mm/hugetlb.c	2004-12-20 16:56:02.000000000 -0800
@@ -54,10 +54,10 @@ static struct page *alloc_fresh_huge_pag
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER|__GFP_COMP|__GFP_NOWARN,
 					HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	if (page) {
 		nr_huge_pages++;
-		nr_huge_pages_node[page_zone(page)->zone_pgdat->node_id]++;
+		nr_huge_pages_node[page_to_nid(page)]++;
 	}
 	return page;
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/mm/mempolicy.c linux-2.6.10-rc3-mm1-nom.generic/mm/mempolicy.c
--- linux-2.6.10-rc3-mm1/mm/mempolicy.c	2004-12-13 16:25:02.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/mm/mempolicy.c	2004-12-20 16:57:51.000000000 -0800
@@ -714,7 +714,7 @@ asmlinkage long sys_get_mempolicy(int __
 
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
-	if (nmask != NULL && maxnode < numnodes)
+	if (nmask != NULL && maxnode < MAX_NUMNODES)
 		return -EINVAL;
 	if (flags & MPOL_F_ADDR) {
 		down_read(&mm->mmap_sem);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/mm/page_alloc.c linux-2.6.10-rc3-mm1-nom.generic/mm/page_alloc.c
--- linux-2.6.10-rc3-mm1/mm/page_alloc.c	2004-12-13 16:25:01.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.generic/mm/page_alloc.c	2004-12-22 17:32:38.000000000 -0800
@@ -37,13 +37,13 @@
 #include <asm/tlbflush.h>
 #include "internal.h"
 
-nodemask_t node_online_map = NODE_MASK_NONE;
+/* MCD - HACK: Find somewhere to initialize this EARLY, or make this initializer cleaner */
+nodemask_t node_online_map = { { [0] = 1UL } };
 nodemask_t node_possible_map = NODE_MASK_ALL;
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 long nr_swap_pages;
-int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
 
 EXPORT_SYMBOL(totalram_pages);
@@ -1358,13 +1358,13 @@ static int __init build_zonelists_node(p
 }
 
 #ifdef CONFIG_NUMA
-#define MAX_NODE_LOAD (numnodes)
+#define MAX_NODE_LOAD (num_online_nodes())
 static int __initdata node_load[MAX_NUMNODES];
 /**
  * find_next_best_node - find the next node that should appear in a given
  *    node's fallback list
  * @node: node whose fallback list we're appending
- * @used_node_mask: pointer to the bitmap of already used nodes
+ * @used_node_mask: nodemask_t of already used nodes
  *
  * We use a number of factors to determine which is the next node that should
  * appear on a given node's fallback list.  The node should not have appeared
@@ -1375,24 +1375,24 @@ static int __initdata node_load[MAX_NUMN
  * on them otherwise.
  * It returns -1 if no node is found.
  */
-static int __init find_next_best_node(int node, void *used_node_mask)
+static int __init find_next_best_node(int node, nodemask_t used_node_mask)
 {
 	int i, n, val;
 	int min_val = INT_MAX;
 	int best_node = -1;
 
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		cpumask_t tmp;
 
 		/* Start from local node */
-		n = (node+i)%numnodes;
+		n = (node+i) % num_online_nodes();
 
 		/* Don't want a node to appear more than once */
-		if (test_bit(n, used_node_mask))
+		if (node_isset(n, used_node_mask))
 			continue;
 
 		/* Use the local node if we haven't already */
-		if (!test_bit(node, used_node_mask)) {
+		if (!node_isset(node, used_node_mask)) {
 			best_node = node;
 			break;
 		}
@@ -1416,7 +1416,7 @@ static int __init find_next_best_node(in
 	}
 
 	if (best_node >= 0)
-		set_bit(best_node, used_node_mask);
+		node_set(best_node, used_node_mask);
 
 	return best_node;
 }
@@ -1426,7 +1426,7 @@ static void __init build_zonelists(pg_da
 	int i, j, k, node, local_node;
 	int prev_node, load;
 	struct zonelist *zonelist;
-	DECLARE_BITMAP(used_mask, MAX_NUMNODES);
+	nodemask_t used_mask;
 
 	/* initialize zonelists */
 	for (i = 0; i < GFP_ZONETYPES; i++) {
@@ -1437,9 +1437,9 @@ static void __init build_zonelists(pg_da
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
-	load = numnodes;
+	load = num_online_nodes();
 	prev_node = local_node;
-	bitmap_zero(used_mask, MAX_NUMNODES);
+	nodes_clear(used_mask);
 	while ((node = find_next_best_node(local_node, used_mask)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
@@ -1496,11 +1496,17 @@ static void __init build_zonelists(pg_da
  		 * zones coming right after the local ones are those from
  		 * node N+1 (modulo N)
  		 */
- 		for (node = local_node + 1; node < numnodes; node++)
- 			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
- 		for (node = 0; node < local_node; node++)
- 			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
- 
+		for (node = local_node + 1; node < MAX_NUMNODES; node++) {
+			if (!node_online(node))
+				continue;
+			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
+		}
+		for (node = 0; node < local_node; node++) {
+			if (!node_online(node))
+				continue;
+			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
+		}
+
 		zonelist->zones[j] = NULL;
 	}
 }
@@ -1511,9 +1517,9 @@ void __init build_all_zonelists(void)
 {
 	int i;
 
-	for(i = 0 ; i < numnodes ; i++)
+	for_each_online_node(i)
 		build_zonelists(NODE_DATA(i));
-	printk("Built %i zonelists\n", numnodes);
+	printk("Built %i zonelists\n", num_online_nodes());
 	cpuset_init_current_mems_allowed();
 }
 


