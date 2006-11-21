Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031302AbWKUWxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031302AbWKUWxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031299AbWKUWxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:53:12 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:24231 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031284AbWKUWxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:53:04 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225303.11710.64499.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 8/11] [DEBUG] Add statistics
Date: Tue, 21 Nov 2006 22:53:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is strictly debug only.  It outputs some information to
/proc/buddyinfo that may help explain what went wrong if page clustering
totally breaks down and prints out a trace when fallbacks occur to help
determine if allocation flagging is incomplete.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 page_alloc.c |   32 ++++++++++++++++++++++++++++++++
 vmstat.c     |   16 ++++++++++++++++
 2 files changed, 48 insertions(+)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-008_reclaimable/mm/page_alloc.c linux-2.6.19-rc5-mm2-009_stats/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-008_reclaimable/mm/page_alloc.c	2006-11-21 10:57:46.000000000 +0000
+++ linux-2.6.19-rc5-mm2-009_stats/mm/page_alloc.c	2006-11-21 11:52:40.000000000 +0000
@@ -58,6 +58,10 @@ unsigned long totalram_pages __read_most
 unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 int percpu_pagelist_fraction;
+#ifdef CONFIG_PAGE_CLUSTERING
+int split_count[MIGRATE_TYPES];
+int fallback_counts[MIGRATE_TYPES];
+#endif /* CONFIG_PAGE_CLUSTERING */
 
 static void __free_pages_ok(struct page *page, unsigned int order);
 
@@ -84,6 +88,8 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 #endif
 };
 
+static int printfallback_count;
+
 EXPORT_SYMBOL(totalram_pages);
 
 static char *zone_names[MAX_NR_ZONES] = {
@@ -750,6 +756,27 @@ static struct page *__rmqueue_fallback(s
 					struct page, lru);
 			area->nr_free--;
 
+			/* Account for a MAX_ORDER block being split */
+			if (current_order == MAX_ORDER - 1 &&
+					order < MAX_ORDER - 1) {
+				split_count[start_migratetype]++;
+			}
+
+			/* Account for fallbacks of interest */
+			if (order < HUGETLB_PAGE_ORDER &&
+					current_order != MAX_ORDER - 1) {
+				fallback_counts[start_migratetype]++;
+				if (printfallback_count < 500 && start_migratetype != MIGRATE_MOVABLE) {
+					printfallback_count++;
+					printk("ALLOC FALLBACK %d TYPE %d TO %d ZONE %s\n", printfallback_count, start_migratetype, migratetype, zone->name);
+					printk("===========================\n");
+					dump_stack();
+					printk("===========================\n");
+			}
+
+
+			}
+
 			/* Remove the page from the freelists */
 			list_del(&page->lru);
 			rmv_page_order(page);
@@ -805,6 +832,11 @@ static struct page *__rmqueue(struct zon
 		if (list_empty(&area->free_list[migratetype]))
 			continue;
 
+#ifdef CONFIG_PAGE_CLUSTERING
+		if (current_order == MAX_ORDER - 1 && order < MAX_ORDER - 1)
+			split_count[migratetype]++;
+#endif /* CONFIG_PAGE_CLUSTERING */
+
 		page = list_entry(area->free_list[migratetype].next,
 					struct page, lru);
 		list_del(&page->lru);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-008_reclaimable/mm/vmstat.c linux-2.6.19-rc5-mm2-009_stats/mm/vmstat.c
--- linux-2.6.19-rc5-mm2-008_reclaimable/mm/vmstat.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-009_stats/mm/vmstat.c	2006-11-21 10:59:36.000000000 +0000
@@ -13,6 +13,11 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 
+#ifdef CONFIG_PAGE_CLUSTERING
+extern int split_count[MIGRATE_TYPES];
+extern int fallback_counts[MIGRATE_TYPES];
+#endif /* CONFIG_PAGE_CLUSTERING */
+
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
 {
@@ -403,6 +408,17 @@ static void *frag_next(struct seq_file *
 
 static void frag_stop(struct seq_file *m, void *arg)
 {
+#ifdef CONFIG_PAGE_CLUSTERING
+	seq_printf(m, "Fallback counts\n");
+	seq_printf(m, "Unmovable: %8d\n", fallback_counts[MIGRATE_UNMOVABLE]);
+	seq_printf(m, "Reclaim:   %8d\n", fallback_counts[MIGRATE_RECLAIMABLE]);
+	seq_printf(m, "Movable:   %8d\n", fallback_counts[MIGRATE_MOVABLE]);
+
+	seq_printf(m, "\nSplit counts\n");
+	seq_printf(m, "Unmovable: %8d\n", split_count[MIGRATE_UNMOVABLE]);
+	seq_printf(m, "Reclaim:   %8d\n", split_count[MIGRATE_RECLAIMABLE]);
+	seq_printf(m, "Movable:   %8d\n", split_count[MIGRATE_MOVABLE]);
+#endif /* CONFIG_PAGE_CLUSTERING */
 }
 
 /*
