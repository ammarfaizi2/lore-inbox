Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946798AbWKALUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946798AbWKALUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946799AbWKALUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:20:05 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:7564 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1946798AbWKALUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:20:02 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101112001.18798.61301.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 11/11] Use pageblock flags for anti-fragmentation
Date: Wed,  1 Nov 2006 11:20:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch alters anti-fragmentation to use the pageblock bits for tracking
the reclaimability of a block of pages.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 include/linux/pageblock-flags.h |    4 ++++
 mm/page_alloc.c                 |   22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/include/linux/pageblock-flags.h linux-2.6.19-rc4-mm1-103_antifrag_pageblock_bits/include/linux/pageblock-flags.h
--- linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/include/linux/pageblock-flags.h	2006-10-31 17:42:25.000000000 +0000
+++ linux-2.6.19-rc4-mm1-103_antifrag_pageblock_bits/include/linux/pageblock-flags.h	2006-10-31 18:25:54.000000000 +0000
@@ -27,6 +27,10 @@
 
 /* Bit indices that affect a whole block of pages */
 enum pageblock_bits {
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
+	PB_rclmtype,
+	PB_rclmtype_end = (PB_rclmtype + 2) - 1, /* 2 bits for rclm types */
+#endif
 	NR_PAGEBLOCK_BITS
 };
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/mm/page_alloc.c linux-2.6.19-rc4-mm1-103_antifrag_pageblock_bits/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/mm/page_alloc.c	2006-10-31 17:44:48.000000000 +0000
+++ linux-2.6.19-rc4-mm1-103_antifrag_pageblock_bits/mm/page_alloc.c	2006-10-31 18:24:48.000000000 +0000
@@ -140,8 +140,15 @@ static unsigned long __initdata dma_rese
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
 #ifdef CONFIG_PAGEALLOC_ANTIFRAG
-static inline int get_page_rclmtype(struct page *page)
+static inline int get_pageblock_rclmtype(struct page *page)
 {
+	return get_pageblock_flags_group(page, PB_rclmtype, PB_rclmtype_end);
+}
+
+static void set_pageblock_rclmtype(struct page *page, int rclmtype)
+{
+	set_pageblock_flags_group(page, (unsigned long)rclmtype,
+						PB_rclmtype, PB_rclmtype_end);
 }
 
 static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
@@ -153,11 +161,13 @@ static inline int gfpflags_to_rclmtype(g
 		((gfp_flags & __GFP_KERNRCLM) != 0);
 }
 #else
-static inline int get_page_rclmtype(struct page *page)
+static inline int get_pageblock_rclmtype(struct page *page)
 {
 	return RCLM_NORCLM;
 }
 
+static inline void set_pageblock_rclmtype(struct page *page, int rclmtype) {}
+
 static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
 {
 	return RCLM_NORCLM;
@@ -433,7 +443,7 @@ static inline void __free_one_page(struc
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
-	int rclmtype = get_page_rclmtype(page);
+	int rclmtype = get_pageblock_rclmtype(page);
 
 	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);
@@ -713,6 +723,7 @@ int move_freepages_block(struct zone *zo
 	if (page_zone(page) != page_zone(end_page))
 		return 0;
 
+	set_pageblock_rclmtype(start_page, rclmtype);
 	return move_freepages(zone, start_page, end_page, rclmtype);
 }
 
@@ -825,6 +836,10 @@ static struct page *__rmqueue(struct zon
 			split_count[rclmtype]++;
 
 		expand(zone, page, order, current_order, area, rclmtype);
+
+		if (current_order == MAX_ORDER - 1)
+			set_pageblock_rclmtype(page, rclmtype);
+
 		goto got_page;
 	}
 
@@ -1003,7 +1018,7 @@ void drain_all_local_pages(void) {}
 static void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
-	int pindex = get_page_rclmtype(page);
+	int pindex = get_pageblock_rclmtype(page);
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
