Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUH2R3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUH2R3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUH2R3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:29:04 -0400
Received: from gprs214-40.eurotel.cz ([160.218.214.40]:53901 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268230AbUH2R0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:26:24 -0400
Date: Sun, 29 Aug 2004 19:25:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: seife@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       erik@rigtorp.com
Subject: Speed up swsusp + progress indication
Message-ID: <20040829172548.GA25528@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This speeds up swsusp and adds progress indication from Erik. I'd like
to get some testing...

								Pavel

--- clean-mm.middle/include/linux/page-flags.h	2004-08-20 14:08:39.000000000 +0200
+++ linux-mm/include/linux/page-flags.h	2004-08-29 18:30:51.000000000 +0200
@@ -74,7 +74,7 @@
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
-
+#define PG_nosave_free		19	/* Page is free and should not be written */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -277,6 +277,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageNosaveFree(page)	test_bit(PG_nosave_free, &(page)->flags)
+#define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
+#define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- clean-mm.middle/include/linux/suspend.h	2004-08-20 14:08:39.000000000 +0200
+++ linux-mm/include/linux/suspend.h	2004-08-29 18:30:51.000000000 +0200
@@ -31,6 +31,7 @@
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
+extern void mark_free_pages(struct zone *zone);
 
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
--- clean-mm.middle/kernel/power/disk.c	2004-08-20 14:09:14.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-08-29 18:24:45.000000000 +0200
@@ -91,10 +91,20 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
+	unsigned int i = 0;
+	unsigned int tmp;
+	unsigned long pages = 0;
+	char *p = "-\\|/";
+	
+	printk("Freeing memory...  ");
+	while (tmp = shrink_all_memory(10000)) {
+		pages += tmp;
+		printk("\b%c", p[i]);
+		i++;
+		if (i > 3)
+			i = 0;
+	}
+	printk("\bdone (%li pages freed)\n", pages);
 }
 
 
--- clean-mm.middle/kernel/power/swsusp.c	2004-08-20 14:11:31.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-08-29 19:21:40.000000000 +0200
@@ -74,8 +74,6 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-extern int is_head_of_free_region(struct page *);
-
 /* Variables to be preserved over suspend */
 int pagedir_order_check;
 int nr_copy_pages_check;
@@ -296,15 +294,19 @@
 {
 	int error = 0;
 	int i;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	unsigned int mod = nr_copy_pages / 100;
+	
+	if (!mod)
+		mod = 1;
+	
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
 	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
-	printk(" %d Pages done.\n",i);
+	printk("\b\b\b\bdone\n");
 	return error;
 }
 
@@ -423,12 +425,12 @@
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
@@ -445,11 +447,8 @@
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
@@ -528,14 +527,11 @@
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
@@ -544,10 +540,8 @@
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
@@ -561,6 +555,7 @@
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
+			mark_free_pages(zone);
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
@@ -575,17 +570,18 @@
 	struct pbe * pbe = pagedir_nosave;
 	
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-				if (saveable(zone, &zone_pfn)) {
-					struct page * page;
-					page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
-					pbe->orig_address = (long) page_address(page);
-					/* copy_page is no usable for copying task structs. */
-					memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-					pbe++;
-				}
+		if (is_highmem(zone))
+			continue;
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			if (saveable(zone, &zone_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				pbe->orig_address = (long) page_address(page);
+				/* copy_page is no usable for copying task structs. */
+				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				pbe++;
 			}
+		}
 	}
 }
 
@@ -677,9 +673,9 @@
 	calc_order();
 	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
 							     pagedir_order);
-	if(!pagedir_save)
+	if (!pagedir_save)
 		return -ENOMEM;
-	memset(pagedir_save,0,(1 << pagedir_order) * PAGE_SIZE);
+	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
 	pagedir_nosave = pagedir_save;
 	return 0;
 }
@@ -784,6 +780,7 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages = 0;
+	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -796,7 +793,9 @@
 	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 
-	swsusp_alloc();
+	error = swsusp_alloc();
+	if (error)
+		return error;
 	
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them.
@@ -1150,14 +1149,18 @@
 	struct pbe * p;
 	int error;
 	int i;
-
+	int mod = nr_copy_pages / 100;
+	
+	if (!mod)
+		mod = 1;
+	
 	if ((error = swsusp_pagedir_relocate()))
 		return error;
 
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	printk( "Reading image data (%d pages):     ", nr_copy_pages );
 	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
 	}
--- clean-mm.middle/mm/page_alloc.c	2004-08-20 14:08:39.000000000 +0200
+++ linux-mm/mm/page_alloc.c	2004-08-29 18:30:52.000000000 +0200
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
