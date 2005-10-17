Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVJQRIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVJQRIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVJQRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:08:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14283 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750814AbVJQRIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:08:53 -0400
Date: Mon, 17 Oct 2005 12:15:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: cleanups
Message-ID: <20051017101542.GA5414@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce number of ifdefs somehow, and fix whitespace a bit. No real
code changes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -33,7 +33,6 @@
 
 #include "power.h"
 
-
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -88,12 +87,10 @@ static int save_highmem_zone(struct zone
 	}
 	return 0;
 }
-#endif /* CONFIG_HIGHMEM */
 
 
 static int save_highmem(void)
 {
-#ifdef CONFIG_HIGHMEM
 	struct zone *zone;
 	int res = 0;
 
@@ -104,13 +101,11 @@ static int save_highmem(void)
 		if (res)
 			return res;
 	}
-#endif
 	return 0;
 }
 
 int restore_highmem(void)
 {
-#ifdef CONFIG_HIGHMEM
 	printk("swsusp: Restoring Highmem\n");
 	while (highmem_copy) {
 		struct highmem_page *save = highmem_copy;
@@ -123,9 +118,12 @@ int restore_highmem(void)
 		free_page((long) save->data);
 		kfree(save);
 	}
-#endif
 	return 0;
 }
+#else
+static int save_highmem(void) { return 0; }
+int restore_highmem(void) { return 0; }
+#endif /* CONFIG_HIGHMEM */
 
 
 static int pfn_is_nosave(unsigned long pfn)
@@ -144,10 +142,10 @@ static int pfn_is_nosave(unsigned long p
  *	isn't part of a free chunk of pages.
  */
 
-static int saveable(struct zone * zone, unsigned long * zone_pfn)
+static int saveable(struct zone *zone, unsigned long *zone_pfn)
 {
 	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
-	struct page * page;
+	struct page *page;
 
 	if (!pfn_valid(pfn))
 		return 0;
@@ -196,11 +194,11 @@ static void copy_data_pages(void)
 		/* This is necessary for swsusp_free() */
 		for_each_pb_page (p, pagedir_nosave)
 			SetPageNosaveFree(virt_to_page(p));
-		for_each_pbe(p, pagedir_nosave)
+		for_each_pbe (p, pagedir_nosave)
 			SetPageNosaveFree(virt_to_page(p->address));
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
-				struct page * page;
+				struct page *page;
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address = (unsigned long)page_address(page);
@@ -294,7 +292,7 @@ static void *alloc_image_page(void)
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe * alloc_pagedir(unsigned nr_pages)
+struct pbe *alloc_pagedir(unsigned nr_pages)
 {
 	unsigned num;
 	struct pbe *pblist, *pbe;
@@ -303,12 +301,12 @@ struct pbe * alloc_pagedir(unsigned nr_p
 		return NULL;
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = (struct pbe *)alloc_image_page();
+	pblist = alloc_image_page();
 	/* FIXME: rewrite this ugly loop */
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
-		pbe->next = (struct pbe *)alloc_image_page();
+		pbe->next = alloc_image_page();
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
@@ -359,7 +357,7 @@ static int enough_free_mem(void)
 
 static int swsusp_alloc(void)
 {
-	struct pbe * p;
+	struct pbe *p;
 
 	pagedir_nosave = NULL;
 

-- 
Thanks, Sharp!
