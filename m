Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVJKSAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVJKSAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVJKSAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:00:12 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:34216 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932242AbVJKSAI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:00:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] swsusp: rework image freeing
Date: Tue, 11 Oct 2005 19:52:34 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200510111948.11242.rjw@sisk.pl>
In-Reply-To: <200510111948.11242.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510111952.35365.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes swsusp use PG_nosave and PG_nosave_free flags
to mark pages that should be freed after the state of the system has been
restored from the image (or in case of an error during suspend).

This allows us to avoid storing metadata in swap twice and to
reduce the amount of memory needed by swsusp.  Additionally, it allows us
to simplify the code by removing a couple of functions that are no longer
necessary.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: linux-2.6.14-rc4/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc4.orig/kernel/power/swsusp.c	2005-10-11 18:09:39.000000000 +0200
+++ linux-2.6.14-rc4/kernel/power/swsusp.c	2005-10-11 19:38:18.000000000 +0200
@@ -701,24 +701,28 @@
 	}
 }
 
-
 static void copy_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe * pbe = pagedir_nosave;
+	struct pbe *pbe = pagedir_nosave, *p;
 
 	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
+		/* This is necessary for swsusp_free() */
+		for_each_pb_page (p, pagedir_nosave)
+			SetPageNosaveFree(virt_to_page(p));
+		for_each_pbe(p, pagedir_nosave)
+			SetPageNosaveFree(virt_to_page(p->address));
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
 				struct page * page;
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
-				pbe->orig_address = (long) page_address(page);
+				pbe->orig_address = (unsigned long)page_address(page);
 				/* copy_page is not usable for copying task structs. */
 				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
 				pbe = pbe->next;
@@ -730,15 +734,6 @@
 
 
 /**
- *	calc_nr - Determine the number of pages needed for a pbe list.
- */
-
-static int calc_nr(int nr_copy)
-{
-	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
-}
-
-/**
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
 
@@ -748,6 +743,8 @@
 
 	while (pblist) {
 		pbe = (pblist + PB_PAGE_SKIP)->next;
+		ClearPageNosave(virt_to_page(pblist));
+		ClearPageNosaveFree(virt_to_page(pblist));
 		free_page((unsigned long)pblist);
 		pblist = pbe;
 	}
@@ -793,6 +790,16 @@
 	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
 }
 
+static void *alloc_image_page(void)
+{
+	void *res = (void *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	if (res) {
+		SetPageNosave(virt_to_page(res));
+		SetPageNosaveFree(virt_to_page(res));
+	}
+	return res;
+}
+
 /**
  *	alloc_pagedir - Allocate the page directory.
  *
@@ -815,11 +822,11 @@
 		return NULL;
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	pblist = (struct pbe *)alloc_image_page();
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
-		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		pbe->next = (struct pbe *)alloc_image_page();
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
@@ -829,52 +836,30 @@
 }
 
 /**
- *	free_image_pages - Free pages allocated for snapshot
+ * Free pages we allocated for suspend. Suspend pages are alocated
+ * before atomic copy, so we need to free them after resume.
  */
 
-static void free_image_pages(void)
+void swsusp_free(void)
 {
-	struct pbe * p;
+	struct zone *zone;
+	unsigned long zone_pfn;
 
-	for_each_pbe (p, pagedir_save) {
-		if (p->address) {
-			ClearPageNosave(virt_to_page(p->address));
-			free_page(p->address);
-			p->address = 0;
-		}
+	for_each_zone(zone) {
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			if (pfn_valid(zone_pfn + zone->zone_start_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				if (PageNosave(page) && PageNosaveFree(page)) {
+					ClearPageNosave(page);
+					ClearPageNosaveFree(page);
+					free_page((long) page_address(page));
+				}
+			}
 	}
 }
 
 /**
- *	alloc_image_pages - Allocate pages for the snapshot.
- */
-
-static int alloc_image_pages(void)
-{
-	struct pbe * p;
-
-	for_each_pbe (p, pagedir_save) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if (!p->address)
-			return -ENOMEM;
-		SetPageNosave(virt_to_page(p->address));
-	}
-	return 0;
-}
-
-/* Free pages we allocated for suspend. Suspend pages are alocated
- * before atomic copy, so we need to free them after resume.
- */
-void swsusp_free(void)
-{
-	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
-	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
-	free_image_pages();
-	free_pagedir(pagedir_save);
-}
-
-
-/**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
  *
  *	Returns TRUE or FALSE after checking the number of available
@@ -883,12 +868,9 @@
 
 static int enough_free_mem(void)
 {
-	if (nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
-		pr_debug("swsusp: Not enough free pages: Have %d\n",
-			 nr_free_pages());
-		return 0;
-	}
-	return 1;
+	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
+	return nr_free_pages() > (nr_copy_pages + PAGES_FOR_IO +
+		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
 }
 
 
@@ -907,33 +889,16 @@
 	struct sysinfo i;
 
 	si_swapinfo(&i);
-	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
-		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
-		return 0;
-	}
-	return 1;
+	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
+	return i.freeswap > (nr_copy_pages + PAGES_FOR_IO +
+		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
 }
 
 static int swsusp_alloc(void)
 {
-	int error;
+	struct pbe * p;
 
 	pagedir_nosave = NULL;
-	nr_copy_pages = calc_nr(nr_copy_pages);
-	nr_copy_pages_check = nr_copy_pages;
-
-	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
-		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
-
-	if (!enough_free_mem())
-		return -ENOMEM;
-
-	if (!enough_swap())
-		return -ENOSPC;
-
-	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
-	    !!(nr_copy_pages % PBES_PER_PAGE))
-		return -ENOSPC;
 
 	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
@@ -941,10 +906,14 @@
 	}
 	create_pbe_list(pagedir_save, nr_copy_pages);
 	pagedir_nosave = pagedir_save;
-	if ((error = alloc_image_pages())) {
-		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
-		swsusp_free();
-		return error;
+
+	for_each_pbe (p, pagedir_save) {
+		p->address = (unsigned long)alloc_image_page();
+		if (!p->address) {
+			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
+			swsusp_free();
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
@@ -956,7 +925,7 @@
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
-		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
+		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
 		restore_highmem();
 		return -ENOMEM;
 	}
@@ -964,6 +933,28 @@
 	drain_local_pages();
 	count_data_pages();
 	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
+	nr_copy_pages_check = nr_copy_pages;
+
+	pr_debug("swsusp: pages needed: %u + %lu + %u, free: %u\n",
+		 nr_copy_pages,
+		 nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE),
+		 PAGES_FOR_IO, nr_free_pages());
+
+	if (!enough_free_mem()) {
+		printk(KERN_ERR "swsusp: Not enough free memory\n");
+		return -ENOMEM;
+	}
+
+	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
+	    !!(nr_copy_pages % PBES_PER_PAGE)) {
+		printk(KERN_ERR "swsusp: Too many image pages\n");
+		return -ENOSPC;
+	}
+
+	if (!enough_swap()) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
 
 	error = swsusp_alloc();
 	if (error)

