Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031275AbWKUWwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031275AbWKUWwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031286AbWKUWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:52:16 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:7847 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1031284AbWKUWwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:52:04 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225203.11710.36332.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 5/11] Drain per-cpu lists when high-order allocations fail
Date: Tue, 21 Nov 2006 22:52:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Per-cpu pages can accidentally cause fragmentation because they are free, but
pinned pages in an otherwise contiguous block.  When this patch is applied,
the per-cpu caches are drained after the direct-reclaim is entered if the
requested order is greater than 0. It simply reuses the code used by suspend
and hotplug.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 Kconfig      |    4 ++++
 page_alloc.c |   33 ++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-005_configurable/mm/Kconfig linux-2.6.19-rc5-mm2-006_drainpercpu/mm/Kconfig
--- linux-2.6.19-rc5-mm2-005_configurable/mm/Kconfig	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-006_drainpercpu/mm/Kconfig	2006-11-21 10:54:11.000000000 +0000
@@ -247,3 +247,7 @@ config READAHEAD_SMOOTH_AGING
 		- have the danger of readahead thrashing(i.e. memory tight)
 
 	  This feature is only available on non-NUMA systems.
+
+config NEED_DRAIN_PERCPU_PAGES
+	def_bool y
+	depends on PM || HOTPLUG_CPU || PAGE_CLUSTERING
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-005_configurable/mm/page_alloc.c linux-2.6.19-rc5-mm2-006_drainpercpu/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-005_configurable/mm/page_alloc.c	2006-11-21 10:52:26.000000000 +0000
+++ linux-2.6.19-rc5-mm2-006_drainpercpu/mm/page_alloc.c	2006-11-21 10:54:11.000000000 +0000
@@ -801,7 +801,7 @@ void drain_node_pages(int nodeid)
 }
 #endif
 
-#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
+#ifdef CONFIG_NEED_DRAIN_PERCPU_PAGES
 static void __drain_pages(unsigned int cpu)
 {
 	unsigned long flags;
@@ -823,7 +823,7 @@ static void __drain_pages(unsigned int c
 		}
 	}
 }
-#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_DRAIN_PERCPU_PAGES */
 
 #ifdef CONFIG_PM
 
@@ -860,7 +860,9 @@ void mark_free_pages(struct zone *zone)
 
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
+#endif /* CONFIG_PM */
 
+#if defined(CONFIG_PM) || defined(CONFIG_PAGE_CLUSTERING)
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
  */
@@ -872,7 +874,28 @@ void drain_local_pages(void)
 	__drain_pages(smp_processor_id());
 	local_irq_restore(flags);	
 }
-#endif /* CONFIG_PM */
+
+void smp_drain_local_pages(void *arg)
+{
+	drain_local_pages();
+}
+
+/*
+ * Spill all the per-cpu pages from all CPUs back into the buddy allocator
+ */
+void drain_all_local_pages(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__drain_pages(smp_processor_id());
+	local_irq_restore(flags);
+
+	smp_call_function(smp_drain_local_pages, NULL, 0, 1);
+}
+#else
+void drain_all_local_pages(void) {}
+#endif /* CONFIG_PM || CONFIG_PAGE_CLUSTERING */
 
 /*
  * Free a 0-order page
@@ -897,6 +920,7 @@ static void fastcall free_hot_cold_page(
 	local_irq_save(flags);
 	__count_vm_event(PGFREE);
 	list_add(&page->lru, &pcp->list);
+	set_page_private(page, get_page_migratetype(page));
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
 		free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
@@ -1489,6 +1513,9 @@ nofail_alloc:
 
 	cond_resched();
 
+	if (order != 0)
+		drain_all_local_pages();
+
 	if (likely(did_some_progress)) {
 		page = get_page_from_freelist(gfp_mask, order,
 						zonelist, alloc_flags);
