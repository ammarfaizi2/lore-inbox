Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAaOVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 09:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUAaOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 09:20:16 -0500
Received: from dp.samba.org ([66.70.73.150]:16060 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264608AbUAaOTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 09:19:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: [PATCH 2/4] 2.6.2-rc2-mm2 CPU Hotplug
Date: Sun, 01 Feb 2004 01:16:38 +1100
Message-Id: <20040131141938.06CDD2C0DA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like CONFIG_PM, CONFIG_HOTPLUG_CPU wants drain_local_pages(), except
we want to drain another (dead) CPU.  Trivial change, mainly fixing up
callers.

Name: Change drain_local_pages() To Take a CPU Number
Author: Rusty Russell
Status: Booted on 2.6.2-rc2-bk2

D: Hotplug CPU needs to drain pages on a downed CPU (usually it's the
D: current cpu).  Make it an argument, and expose it if CONFIG_HOTPLUG_CPU
D: as well as CONFIG_PM.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6243-linux-2.6.1-bk4/include/linux/suspend.h .6243-linux-2.6.1-bk4.updated/include/linux/suspend.h
--- .6243-linux-2.6.1-bk4/include/linux/suspend.h	2003-10-23 10:02:54.000000000 +1000
+++ .6243-linux-2.6.1-bk4.updated/include/linux/suspend.h	2004-01-19 15:14:01.000000000 +1100
@@ -43,7 +43,7 @@ struct suspend_header {
 extern int shrink_mem(void);
 
 /* mm/page_alloc.c */
-extern void drain_local_pages(void);
+extern void drain_local_pages(unsigned int cpu);
 
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6243-linux-2.6.1-bk4/mm/page_alloc.c .6243-linux-2.6.1-bk4.updated/mm/page_alloc.c
--- .6243-linux-2.6.1-bk4/mm/page_alloc.c	2004-01-19 15:13:56.000000000 +1100
+++ .6243-linux-2.6.1-bk4.updated/mm/page_alloc.c	2004-01-19 15:14:01.000000000 +1100
@@ -413,11 +413,13 @@ int is_head_of_free_region(struct page *
 	spin_unlock_irqrestore(&zone->lock, flags);
         return 0;
 }
+#endif /* CONFIG_PM */
 
+#if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
  */
-void drain_local_pages(void)
+void drain_local_pages(unsigned int cpu)
 {
 	unsigned long flags;
 	struct zone *zone;
@@ -427,7 +429,7 @@ void drain_local_pages(void)
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;
 
-		pset = &zone->pageset[smp_processor_id()];
+		pset = &zone->pageset[cpu];
 		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
 			struct per_cpu_pages *pcp;
 
@@ -438,7 +440,7 @@ void drain_local_pages(void)
 	}
 	local_irq_restore(flags);	
 }
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
 
 /*
  * Free a 0-order page
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6243-linux-2.6.1-bk4/kernel/power/pmdisk.c .6243-linux-2.6.1-bk4.updated/kernel/power/pmdisk.c
--- .6243-linux-2.6.1-bk4/kernel/power/pmdisk.c	2003-10-23 10:02:54.000000000 +1000
+++ .6243-linux-2.6.1-bk4.updated/kernel/power/pmdisk.c	2004-01-19 15:14:01.000000000 +1100
@@ -627,7 +627,7 @@ int pmdisk_suspend(void)
 	if ((error = read_swapfiles()))
 		return error;
 
-	drain_local_pages();
+	drain_local_pages(smp_processor_id());
 
 	pm_pagedir_nosave = NULL;
 	pr_debug("pmdisk: Counting pages to copy.\n" );
@@ -658,7 +658,7 @@ int pmdisk_suspend(void)
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them 
 	 */
-	drain_local_pages();
+	drain_local_pages(smp_processor_id());
 
 	/* copy */
 	copy_pages();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6243-linux-2.6.1-bk4/kernel/power/swsusp.c .6243-linux-2.6.1-bk4.updated/kernel/power/swsusp.c
--- .6243-linux-2.6.1-bk4/kernel/power/swsusp.c	2004-01-10 13:59:39.000000000 +1100
+++ .6243-linux-2.6.1-bk4.updated/kernel/power/swsusp.c	2004-01-19 15:14:01.000000000 +1100
@@ -520,7 +520,7 @@ static int suspend_prepare_image(void)
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
 
-	drain_local_pages();
+	drain_local_pages(smp_processor_id());
 
 	pagedir_nosave = NULL;
 	printk( "/critical section: Counting pages to copy" );
@@ -553,7 +553,7 @@ static int suspend_prepare_image(void)
 	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 
-	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
+	drain_local_pages(smp_processor_id());	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
 		BUG();
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
