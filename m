Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbVLOAPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVLOAPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVLOAPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:15:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23945 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965089AbVLOAPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:15:00 -0500
Date: Wed, 14 Dec 2005 16:14:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215001446.31405.63375.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 06/14] Zone Reclaim
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zone reclaim allows the reclaiming of pages from a zone if the number of free
pages falls below the watermark even if other zones still have enough pages
available. Zone reclaim is of particular importance for NUMA machines. It can
be more beneficial to reclaim a page than taking the performance penalties
that come with allocating a page on a remote zone.

Zone reclaim is enabled if the maximum distance to another node is higher
than RECLAIM_DISTANCE, which may be defined by an arch. By default
RECLAIM_DISTANCE is 20 meaning the distance to another node in the
same component (enclosure or motherboard).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-14 14:57:33.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 15:24:22.000000000 -0800
@@ -1186,7 +1186,9 @@ get_page_from_freelist(gfp_t gfp_mask, u
 				mark = (*z)->pages_high;
 			if (!zone_watermark_ok(*z, order, mark,
 				    classzone_idx, alloc_flags))
-				continue;
+				if (!zone_reclaim_mode ||
+			        	!zone_reclaim(*z, gfp_mask, order))
+						continue;
 		}
 
 		page = buffered_rmqueue(*z, order, gfp_mask);
@@ -1957,13 +1959,22 @@ static void __init build_zonelists(pg_da
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
Index: linux-2.6.15-rc5-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/swap.h	2005-12-13 20:41:05.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/swap.h	2005-12-14 15:24:22.000000000 -0800
@@ -172,6 +172,17 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, gfp_t);
+#ifdef CONFIG_NUMA
+extern int zone_reclaim_mode;
+extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
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
 
Index: linux-2.6.15-rc5-mm2/include/linux/topology.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/topology.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/topology.h	2005-12-14 15:24:22.000000000 -0800
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
Index: linux-2.6.15-rc5-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/vmscan.c	2005-12-14 15:24:19.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/vmscan.c	2005-12-14 15:24:43.000000000 -0800
@@ -1823,3 +1823,60 @@ static int __init kswapd_init(void)
 }
 
 module_init(kswapd_init)
+
+#ifdef CONFIG_NUMA
+/*
+ * Zone reclaim mode
+ *
+ * If non-zero call zone_reclaim when the number of free pages falls below
+ * the watermarks.
+ */
+int zone_reclaim_mode __read_mostly;
+
+/*
+ * Try to free up some pages from this zone through reclaim.
+ */
+int zone_reclaim(struct zone *zone, gfp_t gfp_mask, unsigned int order)
+{
+	struct scan_control sc;
+	int nr_pages = 1 << order;
+	struct task_struct *p = current;
+	struct reclaim_state reclaim_state;
+
+	if (!(gfp_mask & __GFP_WAIT) ||
+	    zone->zone_pgdat->node_id != numa_node_id() ||
+	    zone->all_unreclaimable ||
+	    atomic_read(&zone->reclaim_in_progress) > 0)
+		return 0;
+
+	/*
+	 * Check if there is a reasonable amount of recoverable memory before
+	 * doing the scan.
+	 */
+	if (zone_page_state(zone, NR_PAGECACHE) <=
+			zone_page_state(zone, NR_MAPPED) + nr_pages)
+		return 0;
+
+	sc.gfp_mask = gfp_mask;
+	sc.may_writepage = 0;
+	sc.may_swap = 0;
+	sc.nr_mapped = global_page_state(NR_MAPPED);
+	sc.nr_scanned = 0;
+	sc.nr_reclaimed = 0;
+	sc.priority = 0;
+	disable_swap_token();
+
+	sc.swap_cluster_max = max(nr_pages, SWAP_CLUSTER_MAX);
+
+	cond_resched();
+	p->flags |= PF_MEMALLOC;
+	reclaim_state.reclaimed_slab = 0;
+	p->reclaim_state = &reclaim_state;
+	shrink_zone(zone, &sc);
+	p->reclaim_state = NULL;
+	current->flags &= ~PF_MEMALLOC;
+	cond_resched();
+	return sc.nr_reclaimed >= (1 << order);
+}
+#endif
+
