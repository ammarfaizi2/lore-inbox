Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbULYR5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbULYR5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbULYR5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:57:04 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:56448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261548AbULYRzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:55:12 -0500
Date: Sat, 25 Dec 2004 18:54:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: Kill O(n^2) algorithm in swsusp
Message-ID: <20041225175453.GA10222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some machines are spending minutes of CPU time during suspend in
stupid O(n^2) algorithm. This patch replaces it with O(n) algorithm,
making swsusp usable to some people.

I'd like people to test this. It should probably spend few weeks 
in -mm tree to get some beating. OTOH SUSE has variant of this patch
in its kernel.

Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- clean-cvs/include/linux/page-flags.h	2004-08-24 20:26:54.000000000 +0200
+++ linux-cvs/include/linux/page-flags.h	2004-12-10 22:35:58.000000000 +0100
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
--- clean-cvs/include/linux/suspend.h	2004-09-29 22:04:50.000000000 +0200
+++ linux-cvs/include/linux/suspend.h	2004-12-10 22:35:58.000000000 +0100
@@ -31,6 +31,7 @@
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
+extern void mark_free_pages(struct zone *zone);
 
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
--- clean-cvs/kernel/power/swsusp.c	2004-12-14 20:43:42.000000000 +0100
+++ linux-cvs/kernel/power/swsusp.c	2004-12-14 20:48:31.000000000 +0100
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
@@ -448,11 +446,9 @@
 			printk("highmem reserved page?!\n");
 			continue;
 		}
-		if ((chunk_size = is_head_of_free_region(page))) {
-			pfn += chunk_size - 1;
-			zone_pfn += chunk_size - 1;
+		BUG_ON(PageNosave(page));
+		if (PageNosaveFree(page))
 			continue;
-		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
 		if (!save)
 			return -ENOMEM;
@@ -524,21 +520,16 @@
  *	We save a page if it's Reserved, and not in the range of pages
  *	statically defined as 'unsaveable', or if it isn't reserved, and
  *	isn't part of a free chunk of pages.
- *	If it is part of a free chunk, we update @pfn to point to the last 
- *	page of the chunk.
  */
 
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
@@ -547,10 +538,8 @@
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
@@ -563,10 +552,11 @@
 	nr_copy_pages = 0;
 
 	for_each_zone(zone) {
-		if (!is_highmem(zone)) {
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-				nr_copy_pages += saveable(zone, &zone_pfn);
-		}
+		if (is_highmem(zone))
+			continue;
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			nr_copy_pages += saveable(zone, &zone_pfn);
 	}
 }
 
@@ -576,52 +566,25 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
+	int to_copy = nr_copy_pages;
 	
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
-			}
-	}
-}
-
-
-static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
-{
-	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
-	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
-	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
-	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		if (!TestClearPageNosave(page))
-			continue;
-		else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
+		if (is_highmem(zone))
 			continue;
-		__free_page(page);
-	}
-}
-
-void swsusp_free(void)
-{
-	unsigned long p = (unsigned long)pagedir_save;
-	struct zone *zone;
-	for_each_zone(zone) {
-		if (!is_highmem(zone))
-			free_suspend_pagedir_zone(zone, p);
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			if (saveable(zone, &zone_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				pbe->orig_address = (long) page_address(page);
+				/* copy_page is not usable for copying task structs. */
+				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				pbe++;
+				to_copy--;
+			}
+		}
 	}
-	free_pages(p, pagedir_order);
+	BUG_ON(to_copy);
 }
 
 
@@ -687,6 +650,24 @@
 	return 0;
 }
 
+/**
+ *	free_image_pages - Free pages allocated for snapshot
+ */
+
+static void free_image_pages(void)
+{
+	struct pbe * p;
+	int i;
+
+	p = pagedir_save;
+	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+		if (p->address) {
+			ClearPageNosave(virt_to_page(p->address));
+			free_page(p->address);
+			p->address = 0;
+		}
+	}
+}
 
 /**
  *	alloc_image_pages - Allocate pages for the snapshot.
@@ -700,18 +681,19 @@
 
 	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address)
-			goto Error;
+		if (!p->address)
+			return -ENOMEM;
 		SetPageNosave(virt_to_page(p->address));
 	}
 	return 0;
- Error:
-	do { 
-		if (p->address)
-			free_page(p->address);
-		p->address = 0;
-	} while (p-- > pagedir_save);
-	return -ENOMEM;
+}
+
+void swsusp_free(void)
+{
+	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
+	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
+	free_image_pages();
+	free_pages((unsigned long) pagedir_save, pagedir_order);
 }
 
 
@@ -1113,6 +1087,7 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1179,9 +1154,7 @@
 	int i, n = swsusp_info.pagedir_pages;
 	int error = 0;
 
-	pagedir_order = get_bitmask_order(n);
-
-	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
+	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
 	if (!addr)
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
--- clean-cvs/mm/page_alloc.c	2004-11-19 12:54:54.000000000 +0100
+++ linux-cvs/mm/page_alloc.c	2004-12-10 22:35:59.000000000 +0100
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
