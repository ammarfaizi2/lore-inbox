Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVJaPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVJaPMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVJaPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:12:37 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:11192 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932112AbVJaPMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:12:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH] swsusp: rework swsusp_suspend
Date: Mon, 31 Oct 2005 16:12:59 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311612.59736.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes only the functions in swsusp.c call functions in
snapshot.c and not both ways.  It also moves the check for available swap
out of swsusp_suspend() which is necessary for separating the swap-handling
functions in swsusp from the core code.

Basically, it moves the code without changing its functionality.

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    2 
 kernel/power/snapshot.c |  102 ------------------------------
 kernel/power/swsusp.c   |  158 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 128 insertions(+), 134 deletions(-)

Index: linux-2.6.14-git3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-git3.orig/kernel/power/snapshot.c	2005-10-31 15:27:01.000000000 +0100
+++ linux-2.6.14-git3/kernel/power/snapshot.c	2005-10-31 15:36:10.000000000 +0100
@@ -33,98 +33,6 @@
 
 #include "power.h"
 
-#ifdef CONFIG_HIGHMEM
-struct highmem_page {
-	char *data;
-	struct page *page;
-	struct highmem_page *next;
-};
-
-static struct highmem_page *highmem_copy;
-
-static int save_highmem_zone(struct zone *zone)
-{
-	unsigned long zone_pfn;
-	mark_free_pages(zone);
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		struct highmem_page *save;
-		void *kaddr;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-
-		if (!(pfn%1000))
-			printk(".");
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		/*
-		 * This condition results from rvmalloc() sans vmalloc_32()
-		 * and architectural memory reservations. This should be
-		 * corrected eventually when the cases giving rise to this
-		 * are better understood.
-		 */
-		if (PageReserved(page)) {
-			printk("highmem reserved page?!\n");
-			continue;
-		}
-		BUG_ON(PageNosave(page));
-		if (PageNosaveFree(page))
-			continue;
-		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
-		if (!save)
-			return -ENOMEM;
-		save->next = highmem_copy;
-		save->page = page;
-		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
-		if (!save->data) {
-			kfree(save);
-			return -ENOMEM;
-		}
-		kaddr = kmap_atomic(page, KM_USER0);
-		memcpy(save->data, kaddr, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		highmem_copy = save;
-	}
-	return 0;
-}
-
-
-static int save_highmem(void)
-{
-	struct zone *zone;
-	int res = 0;
-
-	pr_debug("swsusp: Saving Highmem\n");
-	for_each_zone (zone) {
-		if (is_highmem(zone))
-			res = save_highmem_zone(zone);
-		if (res)
-			return res;
-	}
-	return 0;
-}
-
-int restore_highmem(void)
-{
-	printk("swsusp: Restoring Highmem\n");
-	while (highmem_copy) {
-		struct highmem_page *save = highmem_copy;
-		void *kaddr;
-		highmem_copy = save->next;
-
-		kaddr = kmap_atomic(save->page, KM_USER0);
-		memcpy(kaddr, save->data, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		free_page((long) save->data);
-		kfree(save);
-	}
-	return 0;
-}
-#else
-static int save_highmem(void) { return 0; }
-int restore_highmem(void) { return 0; }
-#endif /* CONFIG_HIGHMEM */
-
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -383,11 +291,6 @@
 	unsigned nr_pages;
 
 	pr_debug("swsusp: critical section: \n");
-	if (save_highmem()) {
-		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
-		restore_highmem();
-		return -ENOMEM;
-	}
 
 	drain_local_pages();
 	nr_pages = count_data_pages();
@@ -407,11 +310,6 @@
 		return -ENOMEM;
 	}
 
-	if (!enough_swap(nr_pages)) {
-		printk(KERN_ERR "swsusp: Not enough free swap\n");
-		return -ENOSPC;
-	}
-
 	pagedir_nosave = swsusp_alloc(nr_pages);
 	if (!pagedir_nosave)
 		return -ENOMEM;
Index: linux-2.6.14-git3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-git3.orig/kernel/power/swsusp.c	2005-10-31 15:27:01.000000000 +0100
+++ linux-2.6.14-git3/kernel/power/swsusp.c	2005-10-31 15:36:00.000000000 +0100
@@ -73,6 +73,97 @@
 
 #include "power.h"
 
+#ifdef CONFIG_HIGHMEM
+struct highmem_page {
+	char *data;
+	struct page *page;
+	struct highmem_page *next;
+};
+
+static struct highmem_page *highmem_copy;
+
+static int save_highmem_zone(struct zone *zone)
+{
+	unsigned long zone_pfn;
+	mark_free_pages(zone);
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+		struct page *page;
+		struct highmem_page *save;
+		void *kaddr;
+		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+
+		if (!(pfn%1000))
+			printk(".");
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		/*
+		 * This condition results from rvmalloc() sans vmalloc_32()
+		 * and architectural memory reservations. This should be
+		 * corrected eventually when the cases giving rise to this
+		 * are better understood.
+		 */
+		if (PageReserved(page)) {
+			printk("highmem reserved page?!\n");
+			continue;
+		}
+		BUG_ON(PageNosave(page));
+		if (PageNosaveFree(page))
+			continue;
+		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
+		if (!save)
+			return -ENOMEM;
+		save->next = highmem_copy;
+		save->page = page;
+		save->data = (void *) get_zeroed_page(GFP_ATOMIC);
+		if (!save->data) {
+			kfree(save);
+			return -ENOMEM;
+		}
+		kaddr = kmap_atomic(page, KM_USER0);
+		memcpy(save->data, kaddr, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		highmem_copy = save;
+	}
+	return 0;
+}
+
+static int save_highmem(void)
+{
+	struct zone *zone;
+	int res = 0;
+
+	pr_debug("swsusp: Saving Highmem\n");
+	for_each_zone (zone) {
+		if (is_highmem(zone))
+			res = save_highmem_zone(zone);
+		if (res)
+			return res;
+	}
+	return 0;
+}
+
+static int restore_highmem(void)
+{
+	printk("swsusp: Restoring Highmem\n");
+	while (highmem_copy) {
+		struct highmem_page *save = highmem_copy;
+		void *kaddr;
+		highmem_copy = save->next;
+
+		kaddr = kmap_atomic(save->page, KM_USER0);
+		memcpy(kaddr, save->data, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		free_page((long) save->data);
+		kfree(save);
+	}
+	return 0;
+}
+#else
+static int save_highmem(void) { return 0; }
+static int restore_highmem(void) { return 0; }
+#endif
+
 #define CIPHER "aes"
 #define MAXKEY 32
 #define MAXIV  32
@@ -507,6 +598,26 @@
 }
 
 /**
+ *	enough_swap - Make sure we have enough swap to save the image.
+ *
+ *	Returns TRUE or FALSE after checking the total amount of swap
+ *	space avaiable.
+ *
+ *	FIXME: si_swapinfo(&i) returns all swap devices information.
+ *	We should only consider resume_device.
+ */
+
+static int enough_swap(unsigned long nr_pages)
+{
+	struct sysinfo i;
+
+	si_swapinfo(&i);
+	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
+	return i.freeswap > (nr_pages + PAGES_FOR_IO +
+		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
+}
+
+/**
  *	write_suspend_image - Write entire image and metadata.
  *
  */
@@ -514,6 +625,11 @@
 {
 	int error;
 
+	if (!enough_swap(nr_copy_pages)) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
+
 	init_header();
 	if ((error = data_write()))
 		goto FreeData;
@@ -533,27 +649,6 @@
 	goto Done;
 }
 
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
-int enough_swap(unsigned nr_pages)
-{
-	struct sysinfo i;
-
-	si_swapinfo(&i);
-	pr_debug("swsusp: available swap: %lu pages\n", i.freeswap);
-	return i.freeswap > (nr_pages + PAGES_FOR_IO +
-		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
-}
-
-
 /* It is important _NOT_ to umount filesystems at this point. We want
  * them synced (in case something goes wrong) but we DO not want to mark
  * filesystem clean: it is not. (And it does not matter, if we resume
@@ -563,12 +658,15 @@
 {
 	int error;
 
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
+		return error;
+	}
 	lock_swapdevices();
 	error = write_suspend_image();
 	/* This will unlock ignored swap devices since writing is finished */
 	lock_swapdevices();
 	return error;
-
 }
 
 
@@ -576,6 +674,7 @@
 int swsusp_suspend(void)
 {
 	int error;
+
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
@@ -587,15 +686,12 @@
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
 		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
-		local_irq_enable();
-		return error;
+		goto Enable_irqs;
 	}
 
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
-		device_power_up();
-		local_irq_enable();
-		return error;
+	if ((error = save_highmem())) {
+		printk(KERN_ERR "swsusp: Not enough free pages for highmem\n");
+		goto Restore_highmem;
 	}
 
 	save_processor_state();
@@ -603,8 +699,10 @@
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
+Restore_highmem:
 	restore_highmem();
 	device_power_up();
+Enable_irqs:
 	local_irq_enable();
 	return error;
 }
@@ -895,7 +993,7 @@
 		 * Reset swap signature now.
 		 */
 		error = bio_write_page(0, &swsusp_header);
-	} else { 
+	} else {
 		return -EINVAL;
 	}
 	if (!error)
Index: linux-2.6.14-git3/kernel/power/power.h
===================================================================
--- linux-2.6.14-git3.orig/kernel/power/power.h	2005-10-31 15:27:01.000000000 +0100
+++ linux-2.6.14-git3/kernel/power/power.h	2005-10-31 15:31:52.000000000 +0100
@@ -65,8 +65,6 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-extern int restore_highmem(void);
 extern struct pbe * alloc_pagedir(unsigned nr_pages);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
-extern int enough_swap(unsigned nr_pages);
