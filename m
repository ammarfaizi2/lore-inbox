Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbTCQXdk>; Mon, 17 Mar 2003 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbTCQXdk>; Mon, 17 Mar 2003 18:33:40 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:23203 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262046AbTCQXdi>; Mon, 17 Mar 2003 18:33:38 -0500
Date: Tue, 18 Mar 2003 11:43:03 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: [PATCH] Faster SWSUSP free page counting
To: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047944582.1713.5.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch improves the speed of SWSUSP's count_and_copy_data_pages
function by generating a map of the free pages before iterating through
the list of pages. The net result is to go from O(n^2) to O(n), if I
remember my computer science correctly.

Regards,

Nigel

diff -ruN linux-2.5.64-01-ide-disk-suspend/include/linux/page-flags.h linux-2.5.64-02-free-page-map/include/linux/page-flags.h
--- linux-2.5.64-01-ide-disk-suspend/include/linux/page-flags.h	2003-02-20 07:59:33.000000000 +1300
+++ linux-2.5.64-02-free-page-map/include/linux/page-flags.h	2003-03-18 10:56:13.000000000 +1200
@@ -74,6 +74,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_free			20	/* swsusp - page is unused - dont rely on outside swsusp! */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -237,6 +238,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageFree(page)		test_bit(PG_free, &(page)->flags)
+#define SetPageFree(page)	set_bit(PG_free, &(page)->flags)
+#define ClearPageFree(page)	clear_bit(PG_free, &(page)->flags)
+
 #define PageDirect(page)	test_bit(PG_direct, &(page)->flags)
 #define SetPageDirect(page)	set_bit(PG_direct, &(page)->flags)
 #define TestSetPageDirect(page)	test_and_set_bit(PG_direct, &(page)->flags)
diff -ruN linux-2.5.64-01-ide-disk-suspend/kernel/suspend.c linux-2.5.64-02-free-page-map/kernel/suspend.c
--- linux-2.5.64-01-ide-disk-suspend/kernel/suspend.c	2003-03-13 10:12:51.000000000 +1300
+++ linux-2.5.64-02-free-page-map/kernel/suspend.c	2003-03-18 10:54:31.000000000 +1200
@@ -479,6 +479,8 @@
 #else
 	BUG_ON (max_pfn != num_physpages);
 #endif
+	generate_free_page_map();
+
 	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
diff -ruN linux-2.5.64-01-ide-disk-suspend/mm/page_alloc.c linux-2.5.64-02-free-page-map/mm/page_alloc.c
--- linux-2.5.64-01-ide-disk-suspend/mm/page_alloc.c	2003-02-20 07:59:34.000000000 +1300
+++ linux-2.5.64-02-free-page-map/mm/page_alloc.c	2003-03-18 10:53:22.000000000 +1200
@@ -387,26 +387,41 @@
 }
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
-int is_head_of_free_region(struct page *page)
+void generate_free_page_map(void) 
 {
-        struct zone *zone = page_zone(page);
-        unsigned long flags;
-	int order;
+	int i, loop;
+	struct page * page;
+	unsigned long flags = 0;
+	unsigned int order;
 	struct list_head *curr;
+	struct zone *zone;
 
-	/*
-	 * Should not matter as we need quiescent system for
-	 * suspend anyway, but...
-	 */
-	spin_lock_irqsave(&zone->lock, flags);
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list)
-			if (page == list_entry(curr, struct page, list)) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return 1 << order;
+	for(i=0; i < max_mapnr; i++)
+		ClearPageFree(mem_map+i);
+	
+	for_each_zone(zone) {
+		if (!zone->present_pages)
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		printk("Zone %8s ", zone->name);
+		for (order = 0; order < MAX_ORDER; ++order)
+			list_for_each(curr, &(zone->free_area[order].free_list)) {
+				if ((page = list_entry(curr, struct page, list)))
+					for(loop=0; loop < (1 << order); loop++)
+						SetPageFree(page+loop);
 			}
-	spin_unlock_irqrestore(&zone->lock, flags);
-        return 0;
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+}
+
+int is_head_of_free_region(struct page *page)
+{
+	struct page * posn = page;
+
+	while (((posn-mem_map) < max_mapnr) && (PageFree(posn))) 
+		posn++;
+	return (posn - page);
 }
 
 /*



