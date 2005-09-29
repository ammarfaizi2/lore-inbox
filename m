Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVI2M5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVI2M5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVI2M5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:57:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14502 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751146AbVI2M5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:57:10 -0400
Date: Thu, 29 Sep 2005 14:56:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: rjw@sisk.pl
Subject: [swsusp] rework memory freeing
Message-ID: <20050929125614.GA5671@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not store pagedirs in swap twice. This needed rewrite of image
freeing, but it enabled me nice cleanups in the end. It did survive
quite a heavy stress testing.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -24,7 +24,7 @@ typedef struct pbe {
 #define for_each_pbe(pbe, pblist) \
 	for (pbe = pblist ; pbe ; pbe = pbe->next)
 
-#define PBES_PER_PAGE      (PAGE_SIZE/sizeof(struct pbe))
+#define PBES_PER_PAGE      ((unsigned int) (PAGE_SIZE/sizeof(struct pbe)))
 #define PB_PAGE_SKIP       (PBES_PER_PAGE-1)
 
 #define for_each_pb_page(pbe, pblist) \
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -701,24 +701,28 @@ static void count_data_pages(void)
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
@@ -730,15 +734,6 @@ static void copy_data_pages(void)
 
 
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
 
@@ -748,6 +743,8 @@ static inline void free_pagedir(struct p
 
 	while (pblist) {
 		pbe = (pblist + PB_PAGE_SKIP)->next;
+		ClearPageNosave(virt_to_page(pblist));
+		ClearPageNosaveFree(virt_to_page(pblist));
 		free_page((unsigned long)pblist);
 		pblist = pbe;
 	}
@@ -793,6 +790,16 @@ static void create_pbe_list(struct pbe *
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
@@ -815,11 +822,11 @@ static struct pbe * alloc_pagedir(unsign
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
@@ -829,51 +836,29 @@ static struct pbe * alloc_pagedir(unsign
 }
 
 /**
- *	free_image_pages - Free pages allocated for snapshot
- */
-
-static void free_image_pages(void)
-{
-	struct pbe * p;
-
-	for_each_pbe (p, pagedir_save) {
-		if (p->address) {
-			ClearPageNosave(virt_to_page(p->address));
-			free_page(p->address);
-			p->address = 0;
-		}
-	}
-}
-
-/**
- *	alloc_image_pages - Allocate pages for the snapshot.
+ * Free pages we allocated for suspend. Suspend pages are alocated
+ * before atomic copy, so we need to free them after resume.
  */
 
-static int alloc_image_pages(void)
+void swsusp_free(void)
 {
-	struct pbe * p;
+	struct zone *zone;
+	unsigned long zone_pfn;
 
-	for_each_pbe (p, pagedir_save) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if (!p->address)
-			return -ENOMEM;
-		SetPageNosave(virt_to_page(p->address));
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
 }
 
-
 /**
  *	enough_free_mem - Make sure we enough free memory to snapshot.
  *
@@ -883,12 +868,9 @@ void swsusp_free(void)
 
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
 
 
@@ -907,29 +889,16 @@ static int enough_swap(void)
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
 
 	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
 	    !!(nr_copy_pages % PBES_PER_PAGE))
@@ -941,10 +910,14 @@ static int swsusp_alloc(void)
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
@@ -956,7 +929,7 @@ static int suspend_prepare_image(void)
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
-		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
+		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
 		restore_highmem();
 		return -ENOMEM;
 	}
@@ -964,6 +937,22 @@ static int suspend_prepare_image(void)
 	drain_local_pages();
 	count_data_pages();
 	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
+	nr_copy_pages_check = nr_copy_pages;
+
+	pr_debug("swsusp: pages needed: %u + %u + %u, free: %u\n",
+		 nr_copy_pages,
+		 nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE),
+		 PAGES_FOR_IO, nr_free_pages());
+
+	if (!enough_free_mem()) {
+		printk(KERN_ERR "swsusp: Not enough free memory\n");
+		return -ENOMEM;
+	}
+
+	if (!enough_swap()) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
 
 	error = swsusp_alloc();
 	if (error)


-- 
if you have sharp zaurus hardware you don't need... you know my address
