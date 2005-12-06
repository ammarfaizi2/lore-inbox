Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVLFRY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVLFRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLFRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:24:58 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63384 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932526AbVLFRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:24:57 -0500
Date: Tue, 6 Dec 2005 09:24:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051206172444.18786.30131.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/2] Zone reclaim V2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zone reclaim allows the reclaiming of pages from a zone if the number of free
pages falls below the watermark even if other zones still have enough pages
available. Zone reclaim is of particular importance for NUMA machines. It can
be more beneficial to reclaim a page than taking the performance penalties
that come with allocating a page on a remote zone.

The patch replaces Martin Hick's zone reclaim function (which was never
working properly).

An arch can control zone_reclaim by setting zone_reclaim_mode during bootup
if it is discovered that the kernel is running on an NUMA configuration.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/page_alloc.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/mm/page_alloc.c	2005-12-06 09:12:01.000000000 -0800
@@ -842,7 +842,9 @@ get_page_from_freelist(gfp_t gfp_mask, u
 				mark = (*z)->pages_high;
 			if (!zone_watermark_ok(*z, order, mark,
 				    classzone_idx, alloc_flags))
-				continue;
+				if (zone_reclaim_mode &&
+			        	!zone_reclaim(*z, gfp_mask, order))
+						continue;
 		}
 
 		page = buffered_rmqueue(*z, order, gfp_mask);
Index: linux-2.6.15-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/vmscan.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/mm/vmscan.c	2005-12-06 09:10:00.000000000 -0800
@@ -1354,6 +1354,13 @@ static int __init kswapd_init(void)
 
 module_init(kswapd_init)
 
+/*
+ * Zone reclaim mode
+ *
+ * If non-zero call zone_reclaim when the number of free pages falls below
+ * the watermarks.
+ */
+int zone_reclaim_mode;
 
 /*
  * Try to free up some pages from this zone through reclaim.
@@ -1362,12 +1369,13 @@ int zone_reclaim(struct zone *zone, gfp_
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
@@ -1376,24 +1384,20 @@ int zone_reclaim(struct zone *zone, gfp_
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
+	return sc.nr_reclaimed > (1 << order);
 }
 
 asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
Index: linux-2.6.15-rc4/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/swap.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/swap.h	2005-12-06 09:10:39.000000000 -0800
@@ -172,6 +172,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, gfp_t);
+extern int zone_reclaim_mode;
 extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
Index: linux-2.6.15-rc4/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.15-rc4.orig/arch/ia64/mm/discontig.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/arch/ia64/mm/discontig.c	2005-12-06 09:17:29.000000000 -0800
@@ -446,6 +446,8 @@ static void __init arch_sparse_init(void
 {
 	efi_memmap_walk(register_sparse_mem, NULL);
 	sparse_init();
+	/* Switch on zone reclaim */
+	zone_reclaim_mode = 1;
 }
 #else
 #define arch_sparse_init() do {} while (0)
