Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVKARNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVKARNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVKARNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:13:25 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:45246 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750969AbVKARNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:13:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: rework swsusp_suspend
Date: Tue, 1 Nov 2005 18:13:44 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200510311612.59736.rjw@sisk.pl> <20051031220435.GD14877@elf.ucw.cz>
In-Reply-To: <20051031220435.GD14877@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011813.45251.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of October 2005 23:04, Pavel Machek wrote:
> Hi!
> 
> > The following patch makes only the functions in swsusp.c call functions in
> > snapshot.c and not both ways.  It also moves the check for available swap
> > out of swsusp_suspend() which is necessary for separating the swap-handling
> > functions in swsusp from the core code.
> 
> Moving highmem handling code is not neccessary for this goal, right?

No, it is a side-effect.

> Please keep it in place.

OK (although I don't see why you are insisting on this).

> (You being x86-64 person, I can understand you don't want it in
> snapshot.c ;-)

This isn't related to my hardware preferences. ;-)

The highmem-handling functions have nothing to do with the snapshot
functionality, because the highmem is _really_ saved _before_ creating
the snapshot and restored _after_ it has beed created.

Clearly restore_highmem() is only called from swsusp_suspend()
and swsusp_resume() which are in swsusp.c.  If CONFIG_HIGHMEM
is unset, it is defined as a non-static empty function which bloats the kernel
as Ingo Oeser has already noticed.  Therefore if CONFIG_HIGHMEM
is unset, restore_highmem() should be declared as a static empty function in
swsusp.c (this declaration should not be placed in power.h as it causes some
compiler warnings to appear for files that do not use restore_highmem()).
By analogy it should be defined as a static function is CONFIG_HIGHMEM
is set either.

OTOH save_highmem() is actually symmetrical to restore_highmem(),
so it should be called from the same function from which restore_highmem()
is called, and this function is swsusp_suspend() (the call to restore_highmem()
from swsusp_resume() is unnecessary, but you refused to let it go).

Anyway the appended patch contains only changes that you have
already agreed with, except for the "#ifdef CONFIG_HIGHMEM" thing in swsusp.c
which originally was in snapshot.c (and bloated the kernel).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/power.h    |    2 
 kernel/power/snapshot.c |  102 ------------------------------
 kernel/power/swsusp.c   |  158 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 128 insertions(+), 134 deletions(-)

Index: linux-2.6.14-git4/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-git4.orig/kernel/power/snapshot.c	2005-11-01 14:04:41.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/snapshot.c	2005-11-01 14:14:01.000000000 +0100
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
@@ -383,11 +378,6 @@
 	unsigned nr_pages;
 
 	pr_debug("swsusp: critical section: \n");
-	if (save_highmem()) {
-		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
-		restore_highmem();
-		return -ENOMEM;
-	}
 
 	drain_local_pages();
 	nr_pages = count_data_pages();
@@ -407,11 +397,6 @@
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
--- linux-2.6.14-git4.orig/kernel/power/swsusp.c	2005-11-01 14:04:41.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/swsusp.c	2005-11-01 14:12:42.000000000 +0100
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
@@ -895,7 +910,7 @@
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
--- linux-2.6.14-git4.orig/kernel/power/power.h	2005-11-01 14:04:41.000000000 +0100
+++ linux-2.6.14-git4/kernel/power/power.h	2005-11-01 14:08:24.000000000 +0100
@@ -65,8 +65,6 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
-extern int restore_highmem(void);
 extern struct pbe * alloc_pagedir(unsigned nr_pages);
 extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
-extern int enough_swap(unsigned nr_pages);
