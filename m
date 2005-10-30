Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVJ3PwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVJ3PwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVJ3PwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:52:19 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:29105 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932101AbVJ3PwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:52:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] swsusp: rework swsusp_suspend
Date: Sun, 30 Oct 2005 16:40:33 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200510301637.48842.rjw@sisk.pl>
In-Reply-To: <200510301637.48842.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510301640.34306.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes only the functions in swsusp.c call functions in snapshot.c
and not both ways.  Basically, it moves the code without changing its
functionality.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    2 -
 kernel/power/snapshot.c |   14 +---------
 kernel/power/swsusp.c   |   62 +++++++++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/snapshot.c	2005-10-28 23:46:36.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/snapshot.c	2005-10-28 23:49:15.000000000 +0200
@@ -89,7 +89,7 @@
 }
 
 
-static int save_highmem(void)
+int save_highmem(void)
 {
 	struct zone *zone;
 	int res = 0;
@@ -121,7 +121,7 @@
 	return 0;
 }
 #else
-static int save_highmem(void) { return 0; }
+int save_highmem(void) { return 0; }
 int restore_highmem(void) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
@@ -383,11 +383,6 @@
 	unsigned nr_pages;
 
 	pr_debug("swsusp: critical section: \n");
-	if (save_highmem()) {
-		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
-		restore_highmem();
-		return -ENOMEM;
-	}
 
 	drain_local_pages();
 	nr_pages = count_data_pages();
@@ -407,11 +402,6 @@
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
Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-28 23:46:36.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-28 23:49:15.000000000 +0200
@@ -507,6 +507,26 @@
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
@@ -514,6 +534,11 @@
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
@@ -533,27 +558,6 @@
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
@@ -576,6 +580,7 @@
 int swsusp_suspend(void)
 {
 	int error;
+
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
@@ -587,15 +592,17 @@
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
 		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
-		local_irq_enable();
-		return error;
+		goto Enable_irqs;
 	}
 
 	if ((error = swsusp_swap_check())) {
 		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
-		device_power_up();
-		local_irq_enable();
-		return error;
+		goto Power_up;
+	}
+
+	if ((error = save_highmem())) {
+		printk(KERN_ERR "swsusp: Not enough free pages for highmem\n");
+		goto Restore_highmem;
 	}
 
 	save_processor_state();
@@ -603,8 +610,11 @@
 		printk(KERN_ERR "Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
+Restore_highmem:
 	restore_highmem();
+Power_up:
 	device_power_up();
+Enable_irqs:
 	local_irq_enable();
 	return error;
 }
Index: linux-2.6.14-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/power.h	2005-10-28 23:46:36.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/power.h	2005-10-28 23:49:15.000000000 +0200
@@ -65,8 +65,8 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
+extern int save_highmem(void);
 extern int restore_highmem(void);
 extern struct pbe * alloc_pagedir(unsigned nr_pages);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
-extern int enough_swap(unsigned nr_pages);

