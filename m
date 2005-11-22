Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbVKVTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbVKVTRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVKVTRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:17:51 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:44776 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965132AbVKVTRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:17:44 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Message-Id: <20051122191735.21757.48973.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
References: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 5/5] Light fragmentation avoidance without usemap: 005_drainpercpu
Date: Tue, 22 Nov 2005 19:17:38 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per-cpu pages can accidentally cause fragmentation because they are free, but
pinned pages in an otherwise contiguous block.  When this patch is applied,
the per-cpu caches are drained after the direct-reclaim is entered if the
requested order is greater than 3. It simply reuses the code used by suspend
and hotplug and only is triggered when anti-defragmentation is enabled.
Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-004_configurable/mm/page_alloc.c linux-2.6.15-rc1-mm2-005_drainpercpu/mm/page_alloc.c
--- linux-2.6.15-rc1-mm2-004_configurable/mm/page_alloc.c	2005-11-22 16:53:03.000000000 +0000
+++ linux-2.6.15-rc1-mm2-005_drainpercpu/mm/page_alloc.c	2005-11-22 16:53:45.000000000 +0000
@@ -689,7 +689,9 @@ void drain_remote_pages(void)
 }
 #endif
 
-#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
+#if defined(CONFIG_PM) || \
+	defined(CONFIG_HOTPLUG_CPU) || \
+	defined(CONFIG_PAGEALLOC_ANTIDEFRAG)
 static void __drain_pages(unsigned int cpu)
 {
 	struct zone *zone;
@@ -716,10 +718,9 @@ static void __drain_pages(unsigned int c
 		}
 	}
 }
-#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU || CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 #ifdef CONFIG_PM
-
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
@@ -746,7 +747,9 @@ void mark_free_pages(struct zone *zone)
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
+#endif /* CONFIG_PM */
 
+#if defined(CONFIG_PM) || defined(CONFIG_PAGEALLOC_ANTIDEFRAG)
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
  */
@@ -758,7 +761,28 @@ void drain_local_pages(void)
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
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 void zone_statistics(struct zonelist *zonelist, struct zone *z)
 {
@@ -1109,6 +1133,9 @@ rebalance:
 
 	did_some_progress = try_to_free_pages(zonelist->zones, gfp_mask);
 
+	if (order > 3)
+		drain_all_local_pages();
+
 	p->reclaim_state = NULL;
 	p->flags &= ~PF_MEMALLOC;
 
