Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIOLXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIOLXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIOLXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:23:17 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:20353 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265127AbUIOLW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:22:58 -0400
Date: Wed, 15 Sep 2004 13:22:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: speedup patch
Message-ID: <20040915112235.GA20730@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills O(n^2) algorithm from swsusp. Lightly tested (in SUSE
kernel). I'd prefer it to go in after 2.6.9.

								Pavel

--- clean-mm/include/linux/page-flags.h	2004-09-15 12:58:11.000000000 +0200
+++ linux-mm/include/linux/page-flags.h	2004-09-15 13:00:51.000000000 +0200
@@ -75,7 +75,7 @@
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
-
+#define PG_nosave_free		19	/* Page is free and should not be written */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -278,6 +278,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageNosaveFree(page)	test_bit(PG_nosave_free, &(page)->flags)
+#define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
+#define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- clean-mm/include/linux/suspend.h	2004-09-15 12:58:11.000000000 +0200
+++ linux-mm/include/linux/suspend.h	2004-09-15 13:00:51.000000000 +0200
@@ -31,6 +31,7 @@
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
+extern void mark_free_pages(struct zone *zone);
 
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
--- clean-mm/kernel/power/disk.c	2004-09-15 12:58:11.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-09-15 13:02:24.000000000 +0200
@@ -177,6 +177,7 @@
 {
 	int error;
 
+	system_state = SYSTEM_SNAPSHOT;
 	if ((error = prepare()))
 		return error;
 
--- clean-mm/kernel/power/swsusp.c	2004-09-15 12:58:11.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-15 13:00:51.000000000 +0200
@@ -74,11 +74,9 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-extern int is_head_of_free_region(struct page *);
-
 /* Variables to be preserved over suspend */
-int pagedir_order_check;
-int nr_copy_pages_check;
+static int pagedir_order_check;
+static int nr_copy_pages_check;
 
 extern char resume_file[];
 static dev_t resume_device;
@@ -426,12 +424,12 @@
 static int save_highmem_zone(struct zone *zone)
 {
 	unsigned long zone_pfn;
+	mark_free_pages(zone);
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 		struct page *page;
 		struct highmem_page *save;
 		void *kaddr;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-		int chunk_size;
 
 		if (!(pfn%1000))
 			printk(".");
@@ -448,11 +446,8 @@
 			printk("highmem reserved page?!\n");
 			continue;
 		}
-		if ((chunk_size = is_head_of_free_region(page))) {
-			pfn += chunk_size - 1;
-			zone_pfn += chunk_size - 1;
+		if (PageNosaveFree(page))
 			continue;
-		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
 		if (!save)
 			return -ENOMEM;
@@ -531,14 +526,11 @@
 static int saveable(struct zone * zone, unsigned long * zone_pfn)
 {
 	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
-	unsigned long chunk_size;
 	struct page * page;
 
 	if (!pfn_valid(pfn))
 		return 0;
 
-	if (!(pfn%1000))
-		printk(".");
 	page = pfn_to_page(pfn);
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
@@ -547,10 +539,8 @@
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
-	if ((chunk_size = is_head_of_free_region(page))) {
-		*zone_pfn += chunk_size - 1;
+	if (PageNosaveFree(page))
 		return 0;
-	}
 
 	return 1;
 }
@@ -564,6 +554,7 @@
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
+			mark_free_pages(zone);
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
--- clean-mm/mm/page_alloc.c	2004-09-15 12:58:11.000000000 +0200
+++ linux-mm/mm/page_alloc.c	2004-09-15 13:00:51.000000000 +0200
@@ -437,26 +437,30 @@
 #endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM
-int is_head_of_free_region(struct page *page)
+
+void mark_free_pages(struct zone *zone)
 {
-        struct zone *zone = page_zone(page);
-        unsigned long flags;
+	unsigned long zone_pfn, flags;
 	int order;
 	struct list_head *curr;
 
-	/*
-	 * Should not matter as we need quiescent system for
-	 * suspend anyway, but...
-	 */
+	if (!zone->spanned_pages)
+		return;
+
 	spin_lock_irqsave(&zone->lock, flags);
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
+
 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list)
-			if (page == list_entry(curr, struct page, lru)) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return 1 << order;
-			}
+		list_for_each(curr, &zone->free_area[order].free_list) {
+			unsigned long start_pfn, i;
+
+			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
+
+			for (i=0; i < (1<<order); i++)
+				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
-        return 0;
 }
 
 /*

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
