Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUGQWzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUGQWzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUGQWzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:55:10 -0400
Received: from digitalimplant.org ([64.62.235.95]:26601 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262382AbUGQWfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:09 -0400
Date: Sat, 17 Jul 2004 15:34:59 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [6/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1848, 2004/07/17 10:07:17-07:00, mochel@digitalimplant.org

[Power Mgmt] Consolidate code for allocating image pages in pmdisk and swsusp

- Move helpers calc_order(), alloc_pagedir(), alloc_image_pages(),
  enough_free_mem(), and enough_swap() into swsusp.
- Wrap them all with a new function - swsusp_alloc().
- Fix up pmdisk to just call that.
- Fix up suspend_prepare_image() to call that, instead of doing it inline.


 kernel/power/pmdisk.c |  161 +----------------------------------------
 kernel/power/swsusp.c |  196 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 143 insertions(+), 214 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:37 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:37 -07:00
@@ -350,138 +350,9 @@
 }


-/**
- *	free_image_pages - Free each page allocated for snapshot.
- */
-
-static void free_image_pages(void)
-{
-	struct pbe * p;
-	int i;
-
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		ClearPageNosave(virt_to_page(p->address));
-		free_page(p->address);
-	}
-}
-
-
-/**
- *	free_pagedir - Free the page directory.
- */
-
-static void free_pagedir(void)
-{
-	free_image_pages();
-	free_pages((unsigned long)pagedir_save, pagedir_order);
-}
-
-
-static void calc_order(void)
-{
-	int diff;
-	int order;
-
-	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
-	nr_copy_pages += 1 << order;
-	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
-		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
-		}
-	} while(diff);
-	pagedir_order = order;
-}
-
-
-/**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many contiguous pages we need,
- *	allocate them, then mark each 'unsavable'.
- */
-
-static int alloc_pagedir(void)
-{
-	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
-							     pagedir_order);
-	if(!pagedir_save)
-		return -ENOMEM;
-	memset(pagedir_save,0,(1 << pagedir_order) * PAGE_SIZE);
-	pagedir_nosave = pagedir_save;
-	return 0;
-}
-
-
-/**
- *	alloc_image_pages - Allocate pages for the snapshot.
- *
- */
-
-static int alloc_image_pages(void)
-{
-	struct pbe * p;
-	int i;
-
-	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address)
-			goto Error;
-		SetPageNosave(virt_to_page(p->address));
-	}
-	return 0;
- Error:
-	do {
-		if (p->address)
-			free_page(p->address);
-		p->address = 0;
-	} while (p-- > pagedir_save);
-	return -ENOMEM;
-}
-
-
-/**
- *	enough_free_mem - Make sure we enough free memory to snapshot.
- *
- *	Returns TRUE or FALSE after checking the number of available
- *	free pages.
- */
-
-static int enough_free_mem(void)
-{
-	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
-		pr_debug("pmdisk: Not enough free pages: Have %d\n",
-			 nr_free_pages());
-		return 0;
-	}
-	return 1;
-}
-
-
-/**
- *	enough_swap - Make sure we have enough swap to save the image.
- *
- *	Returns TRUE or FALSE after checking the total amount of swap
- *	space avaiable.
- *
- *	FIXME: si_swapinfo(&i) returns all swap devices information.
- *	We should only consider resume_device.
- */
-
-static int enough_swap(void)
-{
-	struct sysinfo i;
-
-	si_swapinfo(&i);
-	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
-		pr_debug("pmdisk: Not enough swap. Need %ld\n",i.freeswap);
-		return 0;
-	}
-	return 1;
-}

+extern int swsusp_alloc(void);
+extern void free_suspend_pagedir(unsigned long);

 /**
  *	pmdisk_suspend - Atomically snapshot the system.
@@ -503,33 +374,11 @@
 		return error;

 	drain_local_pages();
-
-	pagedir_nosave = NULL;
 	pr_debug("pmdisk: Counting pages to copy.\n" );
 	count_pages();
-
-	pr_debug("pmdisk: (pages needed: %d + %d free: %d)\n",
-		 nr_copy_pages,PAGES_FOR_IO,nr_free_pages());
-
-	if (!enough_free_mem())
-		return -ENOMEM;
-
-	if (!enough_swap())
-		return -ENOSPC;
-
-	if ((error = alloc_pagedir())) {
-		pr_debug("pmdisk: Allocating pagedir failed.\n");
-		return error;
-	}
-	if ((error = alloc_image_pages())) {
-		pr_debug("pmdisk: Allocating image pages failed.\n");
-		free_pagedir();
-		return error;
-	}
-
-	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;

+	error = swsusp_alloc();
+
 	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them
 	 */
@@ -931,7 +780,7 @@
 int pmdisk_free(void)
 {
 	pr_debug( "Freeing prev allocated pagedir\n" );
-	free_pagedir();
+	free_suspend_pagedir((unsigned long)pagedir_save);
 	return 0;
 }

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:37 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:37 -07:00
@@ -594,7 +594,7 @@
 	}
 }

-static void free_suspend_pagedir(unsigned long this_pagedir)
+void free_suspend_pagedir(unsigned long this_pagedir)
 {
 	struct zone *zone;
 	for_each_zone(zone) {
@@ -604,36 +604,6 @@
 	free_pages(this_pagedir, pagedir_order);
 }

-static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
-{
-	int i;
-	suspend_pagedir_t *pagedir;
-	struct pbe *p;
-	struct page *page;
-
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
-
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
-	if (!pagedir)
-		return NULL;
-
-	page = virt_to_page(pagedir);
-	for(i=0; i < 1<<pagedir_order; i++)
-		SetPageNosave(page++);
-
-	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if (!p->address) {
-			free_suspend_pagedir((unsigned long) pagedir);
-			return NULL;
-		}
-		SetPageNosave(virt_to_page(p->address));
-		p->orig_address = 0;
-		p++;
-	}
-	return pagedir;
-}
-
 static int prepare_suspend_processes(void)
 {
 	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
@@ -658,12 +628,145 @@
 	printk("|\n");
 }

-static int suspend_prepare_image(void)
+
+static void calc_order(void)
+{
+	int diff;
+	int order;
+
+	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+	nr_copy_pages += 1 << order;
+	do {
+		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
+		if (diff) {
+			order += diff;
+			nr_copy_pages += 1 << diff;
+		}
+	} while(diff);
+	pagedir_order = order;
+}
+
+
+/**
+ *	alloc_pagedir - Allocate the page directory.
+ *
+ *	First, determine exactly how many contiguous pages we need,
+ *	allocate them, then mark each 'unsavable'.
+ */
+
+static int alloc_pagedir(void)
+{
+	calc_order();
+	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
+							     pagedir_order);
+	if(!pagedir_save)
+		return -ENOMEM;
+	memset(pagedir_save,0,(1 << pagedir_order) * PAGE_SIZE);
+	pagedir_nosave = pagedir_save;
+	return 0;
+}
+
+
+/**
+ *	alloc_image_pages - Allocate pages for the snapshot.
+ *
+ */
+
+static int alloc_image_pages(void)
+{
+	struct pbe * p;
+	int i;
+
+	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		if(!p->address)
+			goto Error;
+		SetPageNosave(virt_to_page(p->address));
+	}
+	return 0;
+ Error:
+	do {
+		if (p->address)
+			free_page(p->address);
+		p->address = 0;
+	} while (p-- > pagedir_save);
+	return -ENOMEM;
+}
+
+
+/**
+ *	enough_free_mem - Make sure we enough free memory to snapshot.
+ *
+ *	Returns TRUE or FALSE after checking the number of available
+ *	free pages.
+ */
+
+static int enough_free_mem(void)
+{
+	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
+		pr_debug("pmdisk: Not enough free pages: Have %d\n",
+			 nr_free_pages());
+		return 0;
+	}
+	return 1;
+}
+
+
+/**
+ *	enough_swap - Make sure we have enough swap to save the image.
+ *
+ *	Returns TRUE or FALSE after checking the total amount of swap
+ *	space avaiable.
+ *
+ *	FIXME: si_swapinfo(&i) returns all swap devices information.
+ *	We should only consider resume_device.
+ */
+
+static int enough_swap(void)
 {
 	struct sysinfo i;
-	unsigned int nr_needed_pages = 0;
+
+	si_swapinfo(&i);
+	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
+		pr_debug("pmdisk: Not enough swap. Need %ld\n",i.freeswap);
+		return 0;
+	}
+	return 1;
+}
+
+int swsusp_alloc(void)
+{
+	int error;
+
+	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
+		 nr_copy_pages,PAGES_FOR_IO,nr_free_pages());

 	pagedir_nosave = NULL;
+	if (!enough_free_mem())
+		return -ENOMEM;
+
+	if (!enough_swap())
+		return -ENOSPC;
+
+	if ((error = alloc_pagedir())) {
+		pr_debug("suspend: Allocating pagedir failed.\n");
+		return error;
+	}
+	if ((error = alloc_image_pages())) {
+		pr_debug("suspend: Allocating image pages failed.\n");
+		free_suspend_pagedir((unsigned long)pagedir_save);
+		return error;
+	}
+
+	nr_copy_pages_check = nr_copy_pages;
+	pagedir_order_check = pagedir_order;
+	return 0;
+}
+
+static int suspend_prepare_image(void)
+{
+	unsigned int nr_needed_pages = 0;
+
 	printk( "/critical section: ");
 #ifdef CONFIG_HIGHMEM
 	printk( "handling highmem" );
@@ -678,32 +781,9 @@
 	drain_local_pages();
 	nr_copy_pages = count_and_copy_data_pages(NULL);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
-
-	printk(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
-	if(nr_free_pages() < nr_needed_pages) {
-		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
-		       name_suspend, nr_needed_pages-nr_free_pages());
-		root_swap = 0xFFFF;
-		return -ENOMEM;
-	}
-	si_swapinfo(&i);	/* FIXME: si_swapinfo(&i) returns all swap devices information.
-				   We should only consider resume_device. */
-	if (i.freeswap < nr_needed_pages)  {
-		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
-		       name_suspend, nr_needed_pages-i.freeswap);
-		return -ENOSPC;
-	}
-
-	PRINTK( "Alloc pagedir\n" );
-	pagedir_save = pagedir_nosave = create_suspend_pagedir(nr_copy_pages);
-	if (!pagedir_nosave) {
-		/* Pagedir is big, one-chunk allocation. It is easily possible for this allocation to fail */
-		printk(KERN_CRIT "%sCouldn't allocate continuous pagedir\n", name_suspend);
-		return -ENOMEM;
-	}
-	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;

+	swsusp_alloc();
+
 	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
 		BUG();
