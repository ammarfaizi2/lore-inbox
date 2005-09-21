Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVIUUvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVIUUvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVIUUvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:51:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40367 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964820AbVIUUvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:51:54 -0400
Date: Wed, 21 Sep 2005 22:51:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [swsusp] Rework image freeing
Message-ID: <20050921205132.GA4249@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not store pagedirs in swap twice. This needed rewrite of image
freeing, but it enabled me nice cleanups in the end.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 67434821951d6f10d55e29465a24e7f5015038f1
tree ee0f4a209e8b680ffdfa6e7837a3a248b524f421
parent 7bdc8fc378f053bd4eb4210beb1d494485318512
author <pavel@amd.(none)> Tue, 20 Sep 2005 15:34:55 +0200
committer <pavel@amd.(none)> Tue, 20 Sep 2005 15:34:55 +0200

 kernel/power/swsusp.c |  103 ++++++++++++++++++++++---------------------------
 1 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -729,16 +729,6 @@ static void copy_data_pages(void)
 	BUG_ON(pbe);
 }
 
-
-/**
- *	calc_nr - Determine the number of pages needed for a pbe list.
- */
-
-static int calc_nr(int nr_copy)
-{
-	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
-}
-
 /**
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
@@ -749,6 +739,8 @@ static inline void free_pagedir(struct p
 
 	while (pblist) {
 		pbe = (pblist + PB_PAGE_SKIP)->next;
+		ClearPageNosave(virt_to_page(pblist));
+		ClearPageNosaveFree(virt_to_page(pblist));
 		free_page((unsigned long)pblist);
 		pblist = pbe;
 	}
@@ -794,6 +786,16 @@ static void create_pbe_list(struct pbe *
 	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
 }
 
+static long alloc_image_page(void)
+{
+	long res = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
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
@@ -807,7 +809,7 @@ static void create_pbe_list(struct pbe *
  *	On each page we set up a list of struct_pbe elements.
  */
 
-static struct pbe * alloc_pagedir(unsigned nr_pages)
+static struct pbe *alloc_pagedir(unsigned nr_pages)
 {
 	unsigned num;
 	struct pbe *pblist, *pbe;
@@ -816,11 +818,11 @@ static struct pbe * alloc_pagedir(unsign
 		return NULL;
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+	pblist = (struct pbe *) alloc_image_page();
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
-		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		pbe->next = (struct pbe *) alloc_image_page();
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
@@ -829,48 +831,27 @@ static struct pbe * alloc_pagedir(unsign
 	return pblist;
 }
 
-/**
- *	free_image_pages - Free pages allocated for snapshot
+/* Free pages we allocated for suspend. Suspend pages are alocated
+ * before atomic copy, so we need to free them after resume.
  */
-
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
+	for_each_zone(zone) {
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			struct page * page;
+			page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+			if (PageNosave(page) && PageNosaveFree(page)) {
+				ClearPageNosave(page);
+				ClearPageNosaveFree(page);
+				free_page((long) page_address(page));
+			}
 		}
 	}
 }
 
-/**
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
-void swsusp_free(void)
-{
-	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
-	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
-	free_image_pages();
-	free_pagedir(pagedir_save);
-}
-
 
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
@@ -914,19 +895,23 @@ static int enough_swap(void)
 
 static int swsusp_alloc(void)
 {
-	int error;
+	struct pbe *p;
 
 	pagedir_nosave = NULL;
-	nr_copy_pages = calc_nr(nr_copy_pages);
 
 	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
 		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
 
-	if (!enough_free_mem())
+	if (!enough_free_mem()) {
+		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
+	}
 
-	if (!enough_swap())
+	if (!enough_swap()) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
+	}
+		
 
 	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
@@ -934,10 +919,14 @@ static int swsusp_alloc(void)
 	}
 	create_pbe_list(pagedir_save, nr_copy_pages);
 	pagedir_nosave = pagedir_save;
-	if ((error = alloc_image_pages())) {
-		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
-		swsusp_free();
-		return error;
+
+	for_each_pbe (p, pagedir_save) {
+		p->address = alloc_image_page();
+		if (!p->address) {
+			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
+			swsusp_free();
+			return -ENOMEM;
+		}
 	}
 
 	nr_copy_pages_check = nr_copy_pages;
@@ -1037,7 +1026,7 @@ int swsusp_suspend(void)
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+	BUG_ON (!error && (nr_copy_pages_check != nr_copy_pages));
 	restore_highmem();
 	device_power_up();
 	local_irq_enable();

-- 
if you have sharp zaurus hardware you don't need... you know my address
