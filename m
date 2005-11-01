Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVKAX4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVKAX4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVKAXz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:55:57 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:56768 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751458AbVKAXzv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:55:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] swsusp: rework swsusp_suspend
Date: Wed, 2 Nov 2005 00:11:00 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200511020000.11183.rjw@sisk.pl>
In-Reply-To: <200511020000.11183.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511020011.01041.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes only the functions in swsusp.c call functions in
snapshot.c and not both ways.  It also moves the check for available swap
out of swsusp_suspend() which is necessary for separating the swap-handling
functions in swsusp from the core code. 

This is to replace any previous iteration of the patch called
"rework swsusp_suspend".

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    2 -
 kernel/power/snapshot.c |   19 +-----------
 kernel/power/swsusp.c   |   75 ++++++++++++++++++++++++++++--------------------
 3 files changed, 47 insertions(+), 49 deletions(-)

Index: linux-2.6.14-git4/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/snapshot.c	2005-11-01 18:22:12.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/snapshot.c	2005-11-01 18:24:12.000000000 +0100
@@ -88,8 +88,7 @@
 	return 0;
 }
 
-
-static int save_highmem(void)
+int save_highmem(void)
 {
 	struct zone *zone;
 	int res = 0;
@@ -120,11 +119,7 @@
 	}
 	return 0;
 }
-#else
-static int save_highmem(void) { return 0; }
-int restore_highmem(void) { return 0; }
-#endif /* CONFIG_HIGHMEM */
-
+#endif
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -417,11 +412,6 @@
 	unsigned nr_pages;
 
 	pr_debug("swsusp: critical section: \n");
-	if (save_highmem()) {
-		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
-		restore_highmem();
-		return -ENOMEM;
-	}
 
 	drain_local_pages();
 	nr_pages = count_data_pages();
@@ -441,11 +431,6 @@
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
Index: linux-2.6.14-git4/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/swsusp.c	2005-11-01 18:22:12.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/swsusp.c	2005-11-01 18:24:12.000000000 +0100
@@ -73,6 +73,14 @@
 
 #include "power.h"
 
+#ifdef CONFIG_HIGHMEM
+int save_highmem(void);
+int restore_highmem(void);
+#else
+static int save_highmem(void) { return 0; }
+static int restore_highmem(void) { return 0; }
+#endif
+
 #define CIPHER "aes"
 #define MAXKEY 32
 #define MAXIV  32
@@ -507,6 +515,26 @@
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
@@ -514,6 +542,11 @@
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
@@ -533,27 +566,6 @@
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
@@ -563,12 +575,15 @@
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
 
 
@@ -576,6 +591,7 @@
 int swsusp_suspend(void)
 {
 	int error;
+
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
@@ -587,15 +603,12 @@
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
@@ -603,8 +616,10 @@
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
@@ -811,7 +826,7 @@
 		 * Reset swap signature now.
 		 */
 		error = bio_write_page(0, &swsusp_header);
-	} else { 
+	} else {
 		return -EINVAL;
 	}
 	if (!error)
Index: linux-2.6.14-git4/kernel/power/power.h
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/power.h	2005-11-01 18:22:12.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/power.h	2005-11-01 18:24:12.000000000 +0100
@@ -65,10 +65,8 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-extern int restore_highmem(void);
 extern void free_pagedir(struct pbe *pblist);
 extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
 extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
-extern int enough_swap(unsigned nr_pages);

