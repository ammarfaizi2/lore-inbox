Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266671AbUFWVMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266671AbUFWVMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUFWVLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:11:33 -0400
Received: from holomorphy.com ([207.189.100.168]:18309 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266681AbUFWVHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:07:50 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [oom]: [3/4] track wired pages on a per-zone basis
Message-ID: <0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com>
In-Reply-To: <0406231407.Wa3a0aIbWaLbXaJbIb1a1aLbKb2aKb2a3aYaJbYa3a1a4aJbKbWa4a0a4a4aWaHb342@holomorphy.com>
CC: akpm@osdl.org
Date: Wed, 23 Jun 2004 14:07:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.7/include/linux/mmzone.h
===================================================================
--- linux-2.6.7.orig/include/linux/mmzone.h	2004-06-16 05:19:36.000000000 +0000
+++ linux-2.6.7/include/linux/mmzone.h	2004-06-23 18:58:13.000000000 +0000
@@ -170,6 +170,7 @@
 	ZONE_PADDING(_pad3_)
 
 	struct per_cpu_pageset	pageset[NR_CPUS];
+	unsigned long		nr_wired[NR_CPUS];
 
 	/*
 	 * Discontig memory support fields.
Index: linux-2.6.7/include/linux/page-flags.h
===================================================================
--- linux-2.6.7.orig/include/linux/page-flags.h	2004-06-23 18:57:13.000000000 +0000
+++ linux-2.6.7/include/linux/page-flags.h	2004-06-23 18:58:21.000000000 +0000
@@ -322,6 +322,8 @@
 int __clear_page_dirty(struct page *page);
 int test_clear_page_writeback(struct page *page);
 int test_set_page_writeback(struct page *page);
+void set_page_wired(struct page *);
+void clear_page_wired(struct page *);
 
 static inline void clear_page_dirty(struct page *page)
 {
@@ -333,16 +335,4 @@
 	test_set_page_writeback(page);
 }
 
-static inline void set_page_wired(struct page *page)
-{
-	SetPageWired(page);
-	inc_page_state(nr_wired);
-}
-
-static inline void clear_page_wired(struct page *page)
-{
-	ClearPageWired(page);
-	dec_page_state(nr_wired);
-}
-
 #endif	/* PAGE_FLAGS_H */
Index: linux-2.6.7/include/linux/mm_inline.h
===================================================================
--- linux-2.6.7.orig/include/linux/mm_inline.h	2004-06-16 05:20:26.000000000 +0000
+++ linux-2.6.7/include/linux/mm_inline.h	2004-06-23 18:58:13.000000000 +0000
@@ -30,11 +30,13 @@
 static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
-	list_del(&page->lru);
-	if (PageActive(page)) {
-		ClearPageActive(page);
-		zone->nr_active--;
-	} else {
-		zone->nr_inactive--;
+	if (!PageWired(page)) {
+		list_del(&page->lru);
+		if (!PageActive(page))
+			zone->nr_inactive--;
+		else {
+			ClearPageActive(page);
+			zone->nr_active--;
+		}
 	}
 }
Index: linux-2.6.7/mm/swap.c
===================================================================
--- linux-2.6.7.orig/mm/swap.c	2004-06-16 05:19:13.000000000 +0000
+++ linux-2.6.7/mm/swap.c	2004-06-23 18:58:50.000000000 +0000
@@ -54,6 +54,34 @@
 EXPORT_SYMBOL(put_page);
 #endif
 
+void set_page_wired(struct page *page)
+{
+	unsigned long flags;
+	int cpu;
+	struct zone *zone = page_zone(page);
+
+	SetPageWired(page);
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	per_cpu(page_states, cpu).nr_wired++;
+	zone->nr_wired[cpu]++;
+	local_irq_restore(flags);
+}
+
+void clear_page_wired(struct page *page)
+{
+	unsigned long flags;
+	int cpu;
+	struct zone *zone = page_zone(page);
+
+	ClearPageWired(page);
+	local_irq_save(flags);
+	cpu = smp_processor_id();
+	per_cpu(page_states, cpu).nr_wired--;
+	zone->nr_wired[cpu]--;
+	local_irq_restore(flags);
+}
+
 /*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
@@ -101,8 +129,11 @@
  */
 void fastcall activate_page(struct page *page)
 {
-	struct zone *zone = page_zone(page);
+	struct zone *zone;
 
+	if (PageWired(page))
+		return;
+	zone = page_zone(page);
 	spin_lock_irq(&zone->lru_lock);
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(zone, page);
@@ -122,12 +153,13 @@
  */
 void fastcall mark_page_accessed(struct page *page)
 {
+	if (PageWired(page))
+		return;
 	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
 		activate_page(page);
 		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
+	} else if (!PageReferenced(page))
 		SetPageReferenced(page);
-	}
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
@@ -144,7 +176,7 @@
 	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
 
 	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
+	if (!PageWired(page) && !pagevec_add(pvec, page))
 		__pagevec_lru_add(pvec);
 	put_cpu_var(lru_add_pvecs);
 }
@@ -154,7 +186,7 @@
 	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
 
 	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
+	if (!PageWired(page) && !pagevec_add(pvec, page))
 		__pagevec_lru_add_active(pvec);
 	put_cpu_var(lru_add_active_pvecs);
 }
Index: linux-2.6.7/mm/page_alloc.c
===================================================================
--- linux-2.6.7.orig/mm/page_alloc.c	2004-06-23 18:57:50.000000000 +0000
+++ linux-2.6.7/mm/page_alloc.c	2004-06-23 18:58:13.000000000 +0000
@@ -1066,9 +1066,7 @@
 {
 	struct page_state ps;
 	int cpu, temperature;
-	unsigned long active;
-	unsigned long inactive;
-	unsigned long free;
+	unsigned long active, inactive, free, wired;
 	struct zone *zone;
 
 	for_each_zone(zone) {
@@ -1122,6 +1120,8 @@
 		int i;
 
 		show_node(zone);
+		for (wired = cpu = 0; cpu < NR_CPUS; ++cpu)
+			wired += zone->nr_wired[cpu];
 		printk("%s"
 			" free:%lukB"
 			" min:%lukB"
@@ -1130,6 +1130,7 @@
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" wired:%lukB"
 			"\n",
 			zone->name,
 			K(zone->free_pages),
@@ -1138,7 +1139,8 @@
 			K(zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
-			K(zone->present_pages)
+			K(zone->present_pages),
+			K(wired)
 			);
 		printk("protections[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -1662,8 +1664,8 @@
 	pg_data_t *pgdat = (pg_data_t *)arg;
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
-	unsigned long flags;
-	int order;
+	unsigned long wired, flags;
+	int order, cpu;
 
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
@@ -1681,6 +1683,11 @@
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
+		for (wired = cpu = 0; cpu < NR_CPUS; ++cpu)
+			wired += zone->nr_wired[cpu];
+		wired >>= PAGE_SHIFT - 10;
+		seq_printf(m, "Node %d, zone %8s wired: %lu kB\n",
+					pgdat->node_id, zone->name, wired);
 	}
 	return 0;
 }
