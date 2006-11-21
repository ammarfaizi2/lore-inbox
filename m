Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031281AbWKUWvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031281AbWKUWvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031284AbWKUWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:51:46 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:5031 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1031274AbWKUWvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:51:44 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225143.11710.22954.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 4/11] Add a configure option for page clustering
Date: Tue, 21 Nov 2006 22:51:43 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Page clustering has some memory overhead and a more complex allocation
path. This patch allows the strategy to be disabled for small memory systems
or if it is known the workload is suffering because of the strategy. It also
acts to show where the page clustering strategy interacts with the standard
buddy allocator.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---

 include/linux/mmzone.h |    6 ++++++
 init/Kconfig           |   14 ++++++++++++++
 mm/page_alloc.c        |   27 ++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-004_percpu/include/linux/mmzone.h linux-2.6.19-rc5-mm2-005_configurable/include/linux/mmzone.h
--- linux-2.6.19-rc5-mm2-004_percpu/include/linux/mmzone.h	2006-11-21 10:48:55.000000000 +0000
+++ linux-2.6.19-rc5-mm2-005_configurable/include/linux/mmzone.h	2006-11-21 10:52:26.000000000 +0000
@@ -24,9 +24,15 @@
 #endif
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
+#ifdef CONFIG_PAGE_CLUSTERING
 #define MIGRATE_UNMOVABLE 0
 #define MIGRATE_MOVABLE   1
 #define MIGRATE_TYPES     2
+#else
+#define MIGRATE_UNMOVABLE 0
+#define MIGRATE_MOVABLE   0
+#define MIGRATE_TYPES     1
+#endif
 
 #define for_each_migratetype_order(order, type) \
 	for (order = 0; order < MAX_ORDER; order++) \
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-004_percpu/init/Kconfig linux-2.6.19-rc5-mm2-005_configurable/init/Kconfig
--- linux-2.6.19-rc5-mm2-004_percpu/init/Kconfig	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-005_configurable/init/Kconfig	2006-11-21 10:52:26.000000000 +0000
@@ -500,6 +500,20 @@ config SLOB
 	default !SLAB
 	bool
 
+config PAGE_CLUSTERING
+	bool "Cluster movable pages together in the page allocator"
+	def_bool n
+	help
+	  The standard allocator will fragment memory over time which means
+	  that high order allocations will fail even if kswapd is running. If
+	  this option is set, the allocator will try and group page types
+	  based on their ability to migrate or reclaim. This is a best effort
+	  attempt at lowering fragmentation which a few workloads care about.
+	  The loss is a more complex allocactor that may perform slower. If
+	  you are interested in working with large pages, say Y and set
+	  /proc/sys/vm/min_free_bytes to be 10% of physical memory. Otherwise
+	  say N
+
 menu "Loadable module support"
 
 config MODULES
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-004_percpu/mm/page_alloc.c linux-2.6.19-rc5-mm2-005_configurable/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-004_percpu/mm/page_alloc.c	2006-11-21 10:50:40.000000000 +0000
+++ linux-2.6.19-rc5-mm2-005_configurable/mm/page_alloc.c	2006-11-21 10:52:26.000000000 +0000
@@ -136,6 +136,7 @@ static unsigned long __initdata dma_rese
 #endif /* CONFIG_MEMORY_HOTPLUG_RESERVE */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
+#ifdef CONFIG_PAGE_CLUSTERING
 static inline int get_page_migratetype(struct page *page)
 {
 	return (PageMovable(page) != 0);
@@ -145,6 +146,17 @@ static inline int gfpflags_to_migratetyp
 {
 	return ((gfp_flags & __GFP_MOVABLE) != 0);
 }
+#else
+static inline int get_page_migratetype(struct page *page)
+{
+	return MIGRATE_UNMOVABLE;
+}
+
+static inline int gfpflags_to_migratetype(gfp_t gfp_flags)
+{
+	return MIGRATE_UNMOVABLE;
+}
+#endif /* CONFIG_PAGE_CLUSTERING */
 
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
@@ -648,6 +660,7 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+#ifdef CONFIG_PAGE_CLUSTERING
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 						int start_migratetype)
@@ -685,6 +698,13 @@ static struct page *__rmqueue_fallback(s
 
 	return NULL;
 }
+#else
+static struct page *__rmqueue_fallback(struct zone *zone, unsigned int order,
+							int migratetype)
+{
+	return NULL;
+}
+#endif /* CONFIG_PAGE_CLUSTERING */
 
 /* 
  * Do the hard work of removing an element from the buddy allocator.
@@ -877,7 +897,6 @@ static void fastcall free_hot_cold_page(
 	local_irq_save(flags);
 	__count_vm_event(PGFREE);
 	list_add(&page->lru, &pcp->list);
-	set_page_private(page, get_page_migratetype(page));
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
 		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
@@ -943,6 +962,7 @@ again:
 				goto failed;
 		}
 
+#ifdef CONFIG_PAGE_CLUSTERING
 		/* Find a page of the appropriate migrate type */
 		list_for_each_entry(page, &pcp->list, lru) {
 			if (page_private(page) == migratetype) {
@@ -964,6 +984,11 @@ again:
 			list_del(&page->lru);
 			pcp->count--;
 		}
+#else
+		page = list_entry(pcp->list.next, struct page, lru);
+		list_del(&page->lru);
+		pcp->count--;
+#endif /* CONFIG_PAGE_CLUSTERING */
 
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
