Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUGQWyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUGQWyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUGQWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:53:13 -0400
Received: from digitalimplant.org ([64.62.235.95]:26345 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262106AbUGQWfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:09 -0400
Date: Sat, 17 Jul 2004 15:35:04 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [7/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171528410.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1849, 2004/07/17 10:35:38-07:00, mochel@digitalimplant.org

[Power Mgmt] Consolidate page count/copy code of pmdisk and swsusp.

- Split count_and_copy_data_pages() into count_data_pages() and
  copy_data_pages().
- Move helper saveable() from pmdisk to swsusp, and update to work with
  page zones.
- Get rid of uneeded defines in pmdisk.


 kernel/power/pmdisk.c |  129 --------------------------------------------------
 kernel/power/swsusp.c |  119 +++++++++++++++++++++++++++++-----------------
 2 files changed, 77 insertions(+), 171 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:33 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:33 -07:00
@@ -37,15 +37,6 @@

 extern asmlinkage int pmdisk_arch_suspend(int resume);

-#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
-#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
-#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
-
-/* References to section boundaries */
-extern char __nosave_begin, __nosave_end;
-
-extern int is_head_of_free_region(struct page *);
-
 /* Variables to be preserved over suspend */
 extern int pagedir_order_check;
 extern int nr_copy_pages_check;
@@ -257,102 +248,8 @@
 }


-
-/**
- *	saveable - Determine whether a page should be cloned or not.
- *	@pfn:	The page
- *
- *	We save a page if it's Reserved, and not in the range of pages
- *	statically defined as 'unsaveable', or if it isn't reserved, and
- *	isn't part of a free chunk of pages.
- *	If it is part of a free chunk, we update @pfn to point to the last
- *	page of the chunk.
- */
-
-static int saveable(unsigned long * pfn)
-{
-	struct page * page = pfn_to_page(*pfn);
-
-	if (PageNosave(page))
-		return 0;
-
-	if (!PageReserved(page)) {
-		int chunk_size;
-
-		if ((chunk_size = is_head_of_free_region(page))) {
-			*pfn += chunk_size - 1;
-			return 0;
-		}
-	} else if (PageReserved(page)) {
-		/* Just copy whole code segment.
-		 * Hopefully it is not that big.
-		 */
-		if ((ADDRESS(*pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) &&
-		    (ADDRESS(*pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
-			pr_debug("[nosave %lx]\n", ADDRESS(*pfn));
-			return 0;
-		}
-		/* Hmm, perhaps copying all reserved pages is not
-		 * too healthy as they may contain
-		 * critical bios data?
-		 */
-	}
-	return 1;
-}
-
-
-
-/**
- *	count_pages - Determine size of page directory.
- *
- *	Iterate over all the pages in the system and tally the number
- *	we need to clone.
- */
-
-static void count_pages(void)
-{
-	unsigned long pfn;
-	int n = 0;
-
-	for (pfn = 0; pfn < max_pfn; pfn++) {
-		if (saveable(&pfn))
-			n++;
-	}
-	nr_copy_pages = n;
-}
-
-
-/**
- *	copy_pages - Atomically snapshot memory.
- *
- *	Iterate over all the pages in the system and copy each one
- *	into its corresponding location in the pagedir.
- *	We rely on the fact that the number of pages that we're snap-
- *	shotting hasn't changed since we counted them.
- */
-
-static void copy_pages(void)
-{
-	struct pbe * p = pagedir_save;
-	unsigned long pfn;
-	int n = 0;
-
-	for (pfn = 0; pfn < max_pfn; pfn++) {
-		if (saveable(&pfn)) {
-			n++;
-			p->orig_address = ADDRESS(pfn);
-			copy_page((void *) p->address,
-				  (void *) p->orig_address);
-			p++;
-		}
-	}
-	BUG_ON(n != nr_copy_pages);
-}
-
-
-
-extern int swsusp_alloc(void);
 extern void free_suspend_pagedir(unsigned long);
+extern int suspend_prepare_image(void);

 /**
  *	pmdisk_suspend - Atomically snapshot the system.
@@ -372,29 +269,7 @@

 	if ((error = swsusp_swap_check()))
 		return error;
-
-	drain_local_pages();
-	pr_debug("pmdisk: Counting pages to copy.\n" );
-	count_pages();
-
-	error = swsusp_alloc();
-
-	/* During allocating of suspend pagedir, new cold pages may appear.
-	 * Kill them
-	 */
-	drain_local_pages();
-
-	/* copy */
-	copy_pages();
-
-	/*
-	 * End of critical section. From now on, we can write to memory,
-	 * but we should not touch disk. This specially means we must _not_
-	 * touch swap space! Except we must write out our image of course.
-	 */
-
-	pr_debug("pmdisk: %d pages copied\n", nr_copy_pages );
-	return 0;
+	return suspend_prepare_image();
 }


diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:33 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:33 -07:00
@@ -523,57 +523,86 @@
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }

-/* if *pagedir_p != NULL it also copies the counted pages */
-static int count_and_copy_zone(struct zone *zone, struct pbe **pagedir_p)
+/**
+ *	saveable - Determine whether a page should be cloned or not.
+ *	@pfn:	The page
+ *
+ *	We save a page if it's Reserved, and not in the range of pages
+ *	statically defined as 'unsaveable', or if it isn't reserved, and
+ *	isn't part of a free chunk of pages.
+ *	If it is part of a free chunk, we update @pfn to point to the last
+ *	page of the chunk.
+ */
+
+static int saveable(struct zone * zone, unsigned long * zone_pfn)
 {
-	unsigned long zone_pfn, chunk_size, nr_copy_pages = 0;
-	struct pbe *pbe = *pagedir_p;
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
+	unsigned long chunk_size;
+	struct page * page;

-		if (!(pfn%1000))
-			printk(".");
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		BUG_ON(PageReserved(page) && PageNosave(page));
-		if (PageNosave(page))
-			continue;
-		if (PageReserved(page) && pfn_is_nosave(pfn)) {
-			PRINTK("[nosave pfn 0x%lx]", pfn);
-			continue;
-		}
-		if ((chunk_size = is_head_of_free_region(page))) {
-			pfn += chunk_size - 1;
-			zone_pfn += chunk_size - 1;
-			continue;
+	if (!pfn_valid(pfn))
+		return 0;
+
+	if (!(pfn%1000))
+		printk(".");
+	page = pfn_to_page(pfn);
+	BUG_ON(PageReserved(page) && PageNosave(page));
+	if (PageNosave(page))
+		return 0;
+	if (PageReserved(page) && pfn_is_nosave(pfn)) {
+		PRINTK("[nosave pfn 0x%lx]", pfn);
+		return 0;
+	}
+	if ((chunk_size = is_head_of_free_region(page))) {
+		zone_pfn += chunk_size - 1;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void count_data_pages(void)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+
+	nr_copy_pages = 0;
+
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
-		nr_copy_pages++;
-		if (!pbe)
-			continue;
-		pbe->orig_address = (long) page_address(page);
-		/* Copy page is dangerous: it likes to mess with
-		   preempt count on specific cpus. Wrong preempt count is then copied,
-		   oops. */
-		copy_page((void *)pbe->address, (void *)pbe->orig_address);
-		pbe++;
 	}
-	*pagedir_p = pbe;
-	return nr_copy_pages;
 }

-static int count_and_copy_data_pages(struct pbe *pagedir_p)
+
+static void copy_data_pages(struct pbe * pbe)
 {
-	int nr_copy_pages = 0;
 	struct zone *zone;
+	unsigned long zone_pfn;
+
+
 	for_each_zone(zone) {
 		if (!is_highmem(zone))
-			nr_copy_pages += count_and_copy_zone(zone, &pagedir_p);
+			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+				if (saveable(zone, &zone_pfn)) {
+					struct page * page;
+					page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+					pbe->orig_address = (long) page_address(page);
+					/* Copy page is dangerous: it likes to mess with
+					   preempt count on specific cpus. Wrong preempt
+					   count is then copied, oops.
+					*/
+					copy_page((void *)pbe->address,
+						  (void *)pbe->orig_address);
+					pbe++;
+				}
+			}
 	}
-	return nr_copy_pages;
 }

+
 static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
 {
 	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
@@ -734,7 +763,7 @@
 	return 1;
 }

-int swsusp_alloc(void)
+static int swsusp_alloc(void)
 {
 	int error;

@@ -763,7 +792,7 @@
 	return 0;
 }

-static int suspend_prepare_image(void)
+int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages = 0;

@@ -779,14 +808,16 @@

 	printk("counting pages to copy" );
 	drain_local_pages();
-	nr_copy_pages = count_and_copy_data_pages(NULL);
+	count_data_pages();
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;

 	swsusp_alloc();

-	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
-	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
-		BUG();
+	/* During allocating of suspend pagedir, new cold pages may appear.
+	 * Kill them.
+	 */
+	drain_local_pages();
+	copy_data_pages(pagedir_nosave);

 	/*
 	 * End of critical section. From now on, we can write to memory,
