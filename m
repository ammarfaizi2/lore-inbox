Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946788AbWKALTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946788AbWKALTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946791AbWKALTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:19:05 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:37003 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946788AbWKALTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:19:01 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111900.18798.63649.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 8/11] [DEBUG] Add statistics
Date: Wed,  1 Nov 2006 11:19:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is strictly debug only. With static markers from SystemTap (what is
the current story with these?) or any other type of static marking of probe
points, this could be replaced by a relatively trivial script. Until such
static probes exist, this patch outputs some information to /proc/buddyinfo
that may help explain what went wrong if the anti-fragmentation strategy fails.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 page_alloc.c |   20 ++++++++++++++++++++
 vmstat.c     |   16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-007_kernrclm/mm/page_alloc.c linux-2.6.19-rc4-mm1-009_stats/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-007_kernrclm/mm/page_alloc.c	2006-10-31 13:52:17.000000000 +0000
+++ linux-2.6.19-rc4-mm1-009_stats/mm/page_alloc.c	2006-10-31 13:54:43.000000000 +0000
@@ -57,6 +57,10 @@ unsigned long totalram_pages __read_most
 unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
 int percpu_pagelist_fraction;
+int split_count[RCLM_TYPES];
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
+int fallback_counts[RCLM_TYPES];
+#endif
 
 static void __free_pages_ok(struct page *page, unsigned int order);
 
@@ -745,6 +749,12 @@ static struct page *__rmqueue_fallback(s
 					struct page, lru);
 			area->nr_free--;
 
+			/* Account for a MAX_ORDER block being split */
+			if (current_order == MAX_ORDER - 1 &&
+					order < MAX_ORDER - 1) {
+				split_count[start_rclmtype]++;
+			}
+
 			/* Remove the page from the freelists */
 			list_del(&page->lru);
 			rmv_page_order(page);
@@ -757,6 +767,12 @@ static struct page *__rmqueue_fallback(s
 				move_freepages_block(zone, page,
 							start_rclmtype);
 
+			/* Account for fallbacks */
+			if (order < MAX_ORDER - 1 &&
+					current_order != MAX_ORDER - 1) {
+				fallback_counts[start_rclmtype]++;
+			}
+
 			return page;
 		}
 	}
@@ -807,6 +823,10 @@ static struct page *__rmqueue(struct zon
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
+
+		if (current_order == MAX_ORDER - 1 && order < MAX_ORDER - 1)
+			split_count[rclmtype]++;
+
 		expand(zone, page, order, current_order, area, rclmtype);
 		goto got_page;
 	}
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-007_kernrclm/mm/vmstat.c linux-2.6.19-rc4-mm1-009_stats/mm/vmstat.c
--- linux-2.6.19-rc4-mm1-007_kernrclm/mm/vmstat.c	2006-10-31 13:35:47.000000000 +0000
+++ linux-2.6.19-rc4-mm1-009_stats/mm/vmstat.c	2006-10-31 13:54:43.000000000 +0000
@@ -13,6 +13,11 @@
 #include <linux/module.h>
 #include <linux/cpu.h>
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
+extern int split_count[RCLM_TYPES];
+extern int fallback_counts[RCLM_TYPES];
+#endif
+
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat)
 {
@@ -403,6 +408,17 @@ static void *frag_next(struct seq_file *
 
 static void frag_stop(struct seq_file *m, void *arg)
 {
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
+	seq_printf(m, "Fallback counts\n");
+	seq_printf(m, "KernNoRclm: %8d\n", fallback_counts[RCLM_NORCLM]);
+	seq_printf(m, "KernRclm:   %8d\n", fallback_counts[RCLM_KERN]);
+	seq_printf(m, "EasyRclm:   %8d\n", fallback_counts[RCLM_EASY]);
+
+	seq_printf(m, "\nSplit counts\n");
+	seq_printf(m, "KernNoRclm: %8d\n", split_count[RCLM_NORCLM]);
+	seq_printf(m, "KernRclm:   %8d\n", split_count[RCLM_KERN]);
+	seq_printf(m, "EasyRclm:   %8d\n", split_count[RCLM_EASY]);
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
 }
 
 /*
