Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVLHUj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVLHUj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVLHUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:39:27 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:17549 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932369AbVLHUj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:39:26 -0500
Date: Thu, 8 Dec 2005 12:37:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       steiner@sgi.com, linux-kernel@vger.kernel.org, ak@suse.de,
       Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/3] Zone reclaim V3: main patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zone reclaim allows the reclaiming of pages from a zone if the number of free
pages falls below the watermark even if other zones still have enough pages
available. Zone reclaim is of particular importance for NUMA machines. It can
be more beneficial to reclaim a page than taking the performance penalties
that come with allocating a page on a remote zone.

The patch replaces Martin Hick's zone reclaim function (which was never
working properly).

Zone reclaim is enabled if the maximum distance to another node is higher
than RECLAIM_DISTANCE, which may be defined by an arch. By default
RECLAIM_DISTANCE is 20 meaning the distance to another node in the
same component (enclosure or motherboard).

V2->V3:
- At Andi Kleen's suggestion: Use distance information to determine zone
  reclaim behavior instead of using an arch specific function.
- Do not compile zone_reclaim logic if this is not a NUMA system
- Limit number of unsuccessful reclaim attempts

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/page_alloc.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/mm/page_alloc.c	2005-12-08 12:30:29.000000000 -0800
@@ -842,7 +842,9 @@ get_page_from_freelist(gfp_t gfp_mask, u
 				mark = (*z)->pages_high;
 			if (!zone_watermark_ok(*z, order, mark,
 				    classzone_idx, alloc_flags))
-				continue;
+				if (!zone_reclaim_mode ||
+			        	!zone_reclaim(*z, gfp_mask, order))
+						continue;
 		}
 
 		page = buffered_rmqueue(*z, order, gfp_mask);
@@ -1559,13 +1561,22 @@ static void __init build_zonelists(pg_da
 	prev_node = local_node;
 	nodes_clear(used_mask);
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
+		int distance = node_distance(local_node, node);
+		
+		/*
+		 * If another node is sufficiently far away then it is better
+		 * to reclaim pages in a zone before going off node.
+		 */
+		if (distance > RECLAIM_DISTANCE)
+			zone_reclaim_mode = 1;
+
 		/*
 		 * We don't want to pressure a particular node.
 		 * So adding penalty to the first node in same
 		 * distance group to make it round-robin.
 		 */
-		if (node_distance(local_node, node) !=
-				node_distance(local_node, prev_node))
+
+		if (distance != node_distance(local_node, prev_node))
 			node_load[node] += load;
 		prev_node = node;
 		load--;
Index: linux-2.6.15-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/vmscan.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/mm/vmscan.c	2005-12-08 12:30:29.000000000 -0800
@@ -1354,6 +1354,14 @@ static int __init kswapd_init(void)
 
 module_init(kswapd_init)
 
+#ifdef CONFIG_NUMA
+/*
+ * Zone reclaim mode
+ *
+ * If non-zero call zone_reclaim when the number of free pages falls below
+ * the watermarks.
+ */
+int zone_reclaim_mode __read_mostly;
 
 /*
  * Try to free up some pages from this zone through reclaim.
@@ -1362,12 +1370,13 @@ int zone_reclaim(struct zone *zone, gfp_
 {
 	struct scan_control sc;
 	int nr_pages = 1 << order;
-	int total_reclaimed = 0;
+	struct task_struct *p = current;
+	struct reclaim_state reclaim_state;
 
-	/* The reclaim may sleep, so don't do it if sleep isn't allowed */
-	if (!(gfp_mask & __GFP_WAIT))
-		return 0;
-	if (zone->all_unreclaimable)
+	if (!(gfp_mask & __GFP_WAIT) ||
+	    zone->zone_pgdat->node_id != numa_node_id() ||
+	    zone->all_unreclaimable ||
+	    atomic_read(&zone->reclaim_in_progress) > 0)
 		return 0;
 
 	sc.gfp_mask = gfp_mask;
@@ -1376,25 +1385,22 @@ int zone_reclaim(struct zone *zone, gfp_
 	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
-	/* scan at the highest priority */
 	sc.priority = 0;
 	disable_swap_token();
 
-	if (nr_pages > SWAP_CLUSTER_MAX)
-		sc.swap_cluster_max = nr_pages;
-	else
-		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
-
-	/* Don't reclaim the zone if there are other reclaimers active */
-	if (atomic_read(&zone->reclaim_in_progress) > 0)
-		goto out;
+	sc.swap_cluster_max = max(nr_pages, SWAP_CLUSTER_MAX);
 
+	cond_resched();
+	p->flags |= PF_MEMALLOC;
+	reclaim_state.reclaimed_slab = 0;
+	p->reclaim_state = &reclaim_state;
 	shrink_zone(zone, &sc);
-	total_reclaimed = sc.nr_reclaimed;
-
- out:
-	return total_reclaimed;
+	p->reclaim_state = NULL;
+	current->flags &= ~PF_MEMALLOC;
+	cond_resched();
+	return sc.nr_reclaimed >= (1 << order);
 }
+#endif
 
 asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
 				     unsigned int state)
Index: linux-2.6.15-rc4/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/swap.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/swap.h	2005-12-08 12:30:57.000000000 -0800
@@ -172,7 +172,17 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, gfp_t);
+#ifdef CONFIG_NUMA
+extern int zone_reclaim_mode;
 extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
+#else
+#define zone_reclaim_mode 0
+static inline int zone_reclaim(struct zone *z, gfp_t mask,
+				unsigned int order)
+{
+	return 0;
+}
+#endif
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
Index: linux-2.6.15-rc4/include/linux/topology.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/topology.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/topology.h	2005-12-08 12:30:29.000000000 -0800
@@ -56,6 +56,9 @@
 #define REMOTE_DISTANCE		20
 #define node_distance(from,to)	((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
 #endif
+#ifndef RECLAIM_DISTANCE
+#define RECLAIM_DISTANCE 20
+#endif
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
