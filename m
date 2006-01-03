Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWACXAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWACXAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWACXAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:00:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10659 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751457AbWACXAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:00:30 -0500
Date: Tue, 3 Jan 2006 14:58:34 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: [PATCH] Fix the zone reclaim code in 2.6.15
Message-ID: <Pine.LNX.4.62.0601031457300.22676@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some bits for zone reclaim exists in 2.6.15 but they are not usable.
This patch fixes them up, removes unused code and makes zone reclaim usable.

Zone reclaim allows the reclaiming of pages from a zone if the number of free
pages falls below the watermarks even if other zones still have enough pages
available. Zone reclaim is of particular importance for NUMA machines. It can
be more beneficial to reclaim a page than taking the performance penalties
that come with allocating a page on a remote zone.

Zone reclaim is enabled if the maximum distance to another node is higher
than RECLAIM_DISTANCE, which may be defined by an arch. By default
RECLAIM_DISTANCE is 20. 20 is the distance to another node in the
same component (enclosure or motherboard) on IA64. The meaning of the
NUMA distance information seems to vary by arch.

If zone reclaim is not successful then no further reclaim attempts
will occur for a certain time period (ZONE_RECLAIM_INTERVAL).

This patch was discussed before. See

http://marc.theaimsgroup.com/?l=linux-kernel&m=113519961504207&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=113408418232531&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=113389027420032&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=113380938612205&w=2

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/page_alloc.c
===================================================================
--- linux-2.6.15.orig/mm/page_alloc.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/mm/page_alloc.c	2006-01-03 14:04:59.000000000 -0800
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
Index: linux-2.6.15/include/linux/swap.h
===================================================================
--- linux-2.6.15.orig/include/linux/swap.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/include/linux/swap.h	2006-01-03 14:07:39.000000000 -0800
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
 
Index: linux-2.6.15/include/linux/topology.h
===================================================================
--- linux-2.6.15.orig/include/linux/topology.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/include/linux/topology.h	2006-01-03 14:04:59.000000000 -0800
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
Index: linux-2.6.15/mm/vmscan.c
===================================================================
--- linux-2.6.15.orig/mm/vmscan.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/mm/vmscan.c	2006-01-03 14:36:21.000000000 -0800
@@ -1354,6 +1354,19 @@ static int __init kswapd_init(void)
 
 module_init(kswapd_init)
 
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
+ * Mininum time between zone reclaim scans
+ */
+#define ZONE_RECLAIM_INTERVAL HZ/2
 
 /*
  * Try to free up some pages from this zone through reclaim.
@@ -1362,13 +1375,18 @@ int zone_reclaim(struct zone *zone, gfp_
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
-		return 0;
+	if (!(gfp_mask & __GFP_WAIT) ||
+		zone->zone_pgdat->node_id != numa_node_id() ||
+		zone->all_unreclaimable ||
+		atomic_read(&zone->reclaim_in_progress) > 0)
+			return 0;
+
+	if (time_before(jiffies,
+		zone->last_unsuccessful_zone_reclaim + ZONE_RECLAIM_INTERVAL))
+			return 0;
 
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
@@ -1385,44 +1403,17 @@ int zone_reclaim(struct zone *zone, gfp_
 	else
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 
-	/* Don't reclaim the zone if there are other reclaimers active */
-	if (atomic_read(&zone->reclaim_in_progress) > 0)
-		goto out;
-
+	cond_resched();
+	p->flags |= PF_MEMALLOC;
+	reclaim_state.reclaimed_slab = 0;
+	p->reclaim_state = &reclaim_state;
 	shrink_zone(zone, &sc);
-	total_reclaimed = sc.nr_reclaimed;
-
- out:
-	return total_reclaimed;
-}
-
-asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
-				     unsigned int state)
-{
-	struct zone *z;
-	int i;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (node >= MAX_NUMNODES || !node_online(node))
-		return -EINVAL;
-
-	/* This will break if we ever add more zones */
-	if (!(zone & (1<<ZONE_DMA|1<<ZONE_NORMAL|1<<ZONE_HIGHMEM)))
-		return -EINVAL;
-
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		if (!(zone & 1<<i))
-			continue;
-
-		z = &NODE_DATA(node)->node_zones[i];
+	p->reclaim_state = NULL;
+	current->flags &= ~PF_MEMALLOC;
 
-		if (state)
-			z->reclaim_pages = 1;
-		else
-			z->reclaim_pages = 0;
-	}
+	if (sc.nr_reclaimed == 0)
+		zone->last_unsuccessful_zone_reclaim = jiffies;
 
-	return 0;
+	return sc.nr_reclaimed > nr_pages;
 }
+#endif
Index: linux-2.6.15/include/linux/mmzone.h
===================================================================
--- linux-2.6.15.orig/include/linux/mmzone.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/include/linux/mmzone.h	2006-01-03 14:19:48.000000000 -0800
@@ -150,14 +150,11 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
-	/*
-	 * Does the allocator try to reclaim pages from the zone as soon
-	 * as it fails a watermark_ok() in __alloc_pages?
-	 */
-	int			reclaim_pages;
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
+	unsigned long		last_unsuccessful_zone_reclaim;
+
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
 	 * defined as the scanning priority at which we achieved our reclaim
Index: linux-2.6.15/include/asm-i386/unistd.h
===================================================================
--- linux-2.6.15.orig/include/asm-i386/unistd.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/include/asm-i386/unistd.h	2006-01-03 14:19:13.000000000 -0800
@@ -256,7 +256,7 @@
 #define __NR_io_submit		248
 #define __NR_io_cancel		249
 #define __NR_fadvise64		250
-#define __NR_set_zone_reclaim	251
+/* 251 is available for reuse (was briefly sys_set_zone_reclaim) */
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
 #define __NR_epoll_create	254
Index: linux-2.6.15/include/asm-ia64/unistd.h
===================================================================
--- linux-2.6.15.orig/include/asm-ia64/unistd.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/include/asm-ia64/unistd.h	2006-01-03 14:19:13.000000000 -0800
@@ -265,7 +265,7 @@
 #define __NR_keyctl			1273
 #define __NR_ioprio_set			1274
 #define __NR_ioprio_get			1275
-#define __NR_set_zone_reclaim		1276
+/* 1276 is available for reuse (was briefly sys_set_zone_reclaim) */
 #define __NR_inotify_init		1277
 #define __NR_inotify_add_watch		1278
 #define __NR_inotify_rm_watch		1279
