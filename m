Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVJQWls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVJQWls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVJQWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:41:27 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:34243 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932359AbVJQWky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:40:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH 4/4] swsusp: reduce the use of global variables
Date: Tue, 18 Oct 2005 00:13:18 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200510172336.53194.rjw@sisk.pl>
In-Reply-To: <200510172336.53194.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510180013.18967.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch reduces the use of global variables in the
snapshot-handling part of swsusp, snapshot.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc4-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/snapshot.c	2005-10-17 23:28:40.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/snapshot.c	2005-10-18 00:13:02.000000000 +0200
@@ -164,37 +164,38 @@
 	return 1;
 }
 
-static void count_data_pages(void)
+static unsigned count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
+	unsigned n;
 
-	nr_copy_pages = 0;
-
+	n = 0;
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			nr_copy_pages += saveable(zone, &zone_pfn);
+			n += saveable(zone, &zone_pfn);
 	}
+	return n;
 }
 
-static void copy_data_pages(void)
+static void copy_data_pages(struct pbe *pblist)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe *pbe = pagedir_nosave, *p;
+	struct pbe *pbe, *p;
 
-	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
+	pbe = pblist;
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
 		/* This is necessary for swsusp_free() */
-		for_each_pb_page (p, pagedir_nosave)
+		for_each_pb_page (p, pblist)
 			SetPageNosaveFree(virt_to_page(p));
-		for_each_pbe (p, pagedir_nosave)
+		for_each_pbe (p, pblist)
 			SetPageNosaveFree(virt_to_page(p->address));
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
@@ -347,46 +348,39 @@
  *	free pages.
  */
 
-static int enough_free_mem(void)
+static int enough_free_mem(unsigned nr_pages)
 {
 	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
-	return nr_free_pages() > (nr_copy_pages + PAGES_FOR_IO +
-		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
+	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
+		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
 
-static int swsusp_alloc(void)
+static struct pbe *swsusp_alloc(unsigned nr_pages)
 {
-	struct pbe *p;
+	struct pbe *pblist, *p;
 
-	pagedir_nosave = NULL;
-
-	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
-	    !!(nr_copy_pages % PBES_PER_PAGE))
-		return -ENOSPC;
-
-	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
+	if (!(pblist = alloc_pagedir(nr_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
-		return -ENOMEM;
+		return NULL;
 	}
-	create_pbe_list(pagedir_save, nr_copy_pages);
-	pagedir_nosave = pagedir_save;
+	create_pbe_list(pblist, nr_pages);
 
-	for_each_pbe (p, pagedir_save) {
+	for_each_pbe (p, pblist) {
 		p->address = (unsigned long)alloc_image_page();
 		if (!p->address) {
 			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
 			swsusp_free();
-			return -ENOMEM;
+			return NULL;
 		}
 	}
 
-	return 0;
+	return pblist;
 }
 
 int swsusp_save(void)
 {
-	int error;
+	unsigned nr_pages;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -396,33 +390,37 @@
 	}
 
 	drain_local_pages();
-	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
+	nr_pages = count_data_pages();
+	printk("swsusp: Need to copy %u pages\n", nr_pages);
 
 	pr_debug("swsusp: pages needed: %u + %lu + %u, free: %u\n",
-		 nr_copy_pages,
-		 nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE),
+		 nr_pages,
+		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
 		 PAGES_FOR_IO, nr_free_pages());
 
-	if (!enough_free_mem()) {
+	/* This is needed because of the fixed size of swsusp_info */
+	if (MAX_PBES < (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE)
+		return -ENOSPC;
+
+	if (!enough_free_mem(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
 	}
 
-	if (!enough_swap()) {
+	if (!enough_swap(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
 	}
 
-	error = swsusp_alloc();
-	if (error)
-		return error;
+	pagedir_nosave = swsusp_alloc(nr_pages);
+	if (!pagedir_nosave)
+		return -ENOMEM;
 
 	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.
 	 */
 	drain_local_pages();
-	copy_data_pages();
+	copy_data_pages(pagedir_nosave);
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -430,6 +428,8 @@
 	 * touch swap space! Except we must write out our image of course.
 	 */
 
-	printk("swsusp: critical section/: done (%d pages copied)\n", nr_copy_pages );
+	nr_copy_pages = nr_pages;
+
+	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
 	return 0;
 }
Index: linux-2.6.14-rc4-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/swsusp.c	2005-10-17 23:28:52.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/swsusp.c	2005-10-18 00:13:02.000000000 +0200
@@ -543,14 +543,14 @@
  *	We should only consider resume_device.
  */
 
-int enough_swap(void)
+int enough_swap(unsigned nr_pages)
 {
 	struct sysinfo i;
 
 	si_swapinfo(&i);
 	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
-	return i.freeswap > (nr_copy_pages + PAGES_FOR_IO +
-		nr_copy_pages/PBES_PER_PAGE + !!(nr_copy_pages%PBES_PER_PAGE));
+	return i.freeswap > (nr_pages + PAGES_FOR_IO +
+		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
 
Index: linux-2.6.14-rc4-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/power.h	2005-10-17 23:28:29.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/power.h	2005-10-18 00:13:02.000000000 +0200
@@ -69,4 +69,4 @@
 extern struct pbe * alloc_pagedir(unsigned nr_pages);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
-extern int enough_swap(void);
+extern int enough_swap(unsigned nr_pages);
