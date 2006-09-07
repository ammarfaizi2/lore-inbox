Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWIGTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWIGTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWIGTF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:05:27 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:55008 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751549AbWIGTFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:05:23 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060907190523.6166.3957.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 5/8] Drain per-cpu lists when high-order allocations fail
Date: Thu,  7 Sep 2006 20:05:23 +0100 (IST)
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
 page_alloc.c |   32 +++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-004_configurable/mm/Kconfig linux-2.6.18-rc5-mm1-005_drainpercpu/mm/Kconfig
--- linux-2.6.18-rc5-mm1-004_configurable/mm/Kconfig	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-005_drainpercpu/mm/Kconfig	2006-09-07 19:16:11.000000000 +0100
@@ -242,3 +242,7 @@ config READAHEAD_SMOOTH_AGING
 		- have the danger of readahead thrashing(i.e. memory tight)
 
 	  This feature is only available on non-NUMA systems.
+
+config NEED_DRAIN_PERCPU_PAGES
+	def_bool y
+	depends on PM || HOTPLUG_CPU || PAGEALLOC_ANTIFRAG
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-004_configurable/mm/page_alloc.c linux-2.6.18-rc5-mm1-005_drainpercpu/mm/page_alloc.c
--- linux-2.6.18-rc5-mm1-004_configurable/mm/page_alloc.c	2006-09-07 19:14:30.000000000 +0100
+++ linux-2.6.18-rc5-mm1-005_drainpercpu/mm/page_alloc.c	2006-09-07 19:16:38.000000000 +0100
@@ -796,7 +796,7 @@ void drain_node_pages(int nodeid)
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
 
+#if defined(CONFIG_PM) || defined(CONFIG_PAGEALLOC_ANTIFRAG)
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
+#endif /* CONFIG_PM || CONFIG_PAGEALLOC_ANTIFRAG */
 
 /*
  * Free a 0-order page
@@ -1232,6 +1255,9 @@ rebalance:
 
 	cond_resched();
 
+	if (order != 0)
+		drain_all_local_pages();
+
 	if (likely(did_some_progress)) {
 		page = get_page_from_freelist(gfp_mask, order,
 						zonelist, alloc_flags);
