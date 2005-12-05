Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVLETBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVLETBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVLETBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:01:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13455 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751416AbVLETBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:01:07 -0500
Date: Mon, 5 Dec 2005 11:01:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-ia64@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051205190104.12037.69672.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/3] Arch specific zone reclaim framework
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic framework for arch specific zone reclaim.

Zone reclaim allows the reclaiming of pages from a zone if the number of free
pages falls below the watermark even if other zones still have enough pages
available.

Zone reclaim is of particular importance for NUMA machines. It can be more
beneficial to reclaim a page than taking the performance penalties that come
with allocating a page on a remote zone. Maybe this will also be useful
to implement reclaim for DMA zones in some architectures.

The penalty incurred by remote page accesses varies depending on the NUMA
factor of the archictecture. If the NUMA factor is very low (architectures
that have multiple nodes on the same motherboard like for example Opteron
multi-processor boards) then no page reclaim may be needed since access to
another nodes memory is almost as fast as a direct access.
On Itanium architectures and other bus based NUMA architectures a remote
access usually means that the access has to occur over some sort of NUMA
interlink. It is worth to sacrifice easily reclaimable pages in order to
allow a local allocation. Typically there are large number of easily reclaimable
page available if a scan over some files has just been done or if an application
has just terminated that mmapped many files.

Other architectures (especially software NUMA like VirtualIron) may have
higher NUMA factors and consequently it may be beneficial to do even more
cleaning of the local zone before going off-node for those.

This patch adds a hook to the page allocator and defines a generic zone
reclaim function. These allow an arch to implement its own zone reclaim
so that the off-node allocation behavior of of the page allocator may be
controlled in an arch specific way. The patch replaces Martin Hick's zone
reclaim function (which was never working properly).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/page_alloc.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/mm/page_alloc.c	2005-12-05 10:21:36.000000000 -0800
@@ -842,7 +842,8 @@ get_page_from_freelist(gfp_t gfp_mask, u
 				mark = (*z)->pages_high;
 			if (!zone_watermark_ok(*z, order, mark,
 				    classzone_idx, alloc_flags))
-				continue;
+				if (!arch_zone_reclaim(*z, gfp_mask, order))
+						continue;
 		}
 
 		page = buffered_rmqueue(*z, order, gfp_mask);
Index: linux-2.6.15-rc4/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/swap.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/swap.h	2005-12-05 10:21:36.000000000 -0800
@@ -172,7 +172,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, gfp_t);
-extern int zone_reclaim(struct zone *, gfp_t, unsigned int);
+extern int zone_reclaim(struct zone *, gfp_t, int, int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
Index: linux-2.6.15-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/vmscan.c	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/mm/vmscan.c	2005-12-05 10:21:36.000000000 -0800
@@ -1354,47 +1354,45 @@ static int __init kswapd_init(void)
 
 module_init(kswapd_init)
 
-
 /*
  * Try to free up some pages from this zone through reclaim.
  */
-int zone_reclaim(struct zone *zone, gfp_t gfp_mask, unsigned int order)
+#ifdef CONFIG_ARCH_ZONE_RECLAIM
+int zone_reclaim(struct zone *z, gfp_t gfp_mask, int writepage, int swap)
 {
+	struct task_struct *p = current;
 	struct scan_control sc;
-	int nr_pages = 1 << order;
-	int total_reclaimed = 0;
+	struct reclaim_state reclaim_state;
 
-	/* The reclaim may sleep, so don't do it if sleep isn't allowed */
-	if (!(gfp_mask & __GFP_WAIT))
-		return 0;
-	if (zone->all_unreclaimable)
-		return 0;
-
-	sc.gfp_mask = gfp_mask;
-	sc.may_writepage = 0;
-	sc.may_swap = 0;
-	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
-	/* scan at the highest priority */
+	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.priority = 0;
-	disable_swap_token();
-
-	if (nr_pages > SWAP_CLUSTER_MAX)
-		sc.swap_cluster_max = nr_pages;
-	else
-		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
+	sc.gfp_mask = gfp_mask;
+	sc.may_writepage = writepage;
+	sc.may_swap = swap;
+	sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 
+	/* The reclaim may sleep, so don't do it if sleep isn't allowed */
+	if (!(gfp_mask & __GFP_WAIT))
+		return 0;
+	if (z->all_unreclaimable)
+		return 0;
 	/* Don't reclaim the zone if there are other reclaimers active */
-	if (atomic_read(&zone->reclaim_in_progress) > 0)
-		goto out;
-
-	shrink_zone(zone, &sc);
-	total_reclaimed = sc.nr_reclaimed;
+	if (atomic_read(&z->reclaim_in_progress) > 0)
+		return 0;
 
- out:
-	return total_reclaimed;
+	cond_resched();
+	p->flags |= PF_MEMALLOC;
+	reclaim_state.reclaimed_slab = 0;
+	p->reclaim_state = &reclaim_state;
+	shrink_zone(z, &sc);
+	p->reclaim_state = NULL;
+	current->flags &= ~PF_MEMALLOC;
+	cond_resched();
+	return sc.nr_reclaimed;
 }
+#endif
 
 asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
 				     unsigned int state)
Index: linux-2.6.15-rc4/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc4.orig/include/linux/gfp.h	2005-11-30 22:25:15.000000000 -0800
+++ linux-2.6.15-rc4/include/linux/gfp.h	2005-12-05 10:21:54.000000000 -0800
@@ -100,6 +100,13 @@ static inline int gfp_zone(gfp_t gfp)
 static inline void arch_free_page(struct page *page, int order) { }
 #endif
 
+#ifndef CONFIG_ARCH_ZONE_RECLAIM
+static inline int arch_zone_reclaim(struct zone *z, gfp_t mask, unsigned int order)
+{
+	return 0;
+}
+#endif
+
 extern struct page *
 FASTCALL(__alloc_pages(gfp_t, unsigned int, struct zonelist *));
 
