Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262024AbTCQXqy>; Mon, 17 Mar 2003 18:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbTCQXqy>; Mon, 17 Mar 2003 18:46:54 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:11260 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262024AbTCQXqv>; Mon, 17 Mar 2003 18:46:51 -0500
Date: Tue, 18 Mar 2003 11:56:13 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: [PATCH] Don't refill pcp lists during SWSUSP.
To: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047945372.1714.19.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's another patch (the last for a little while, I promise!). It stops
the pcp lists from being refilled while SWSUSP is running. Despite the
comment in the page, drain_local_pages does only need to get called once
right now, but I have patches coming that will (DV) change that. This
patch is thus groundwork for them.

I see Linus has just done 2.5.65 - I'll rediff if need be.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

diff -ruN linux-2.5.64-02-free-page-map/include/linux/suspend.h linux-2.5.64-03-do-not-refill-hot-pages/include/linux/suspend.h
--- linux-2.5.64-02-free-page-map/include/linux/suspend.h	2003-03-10 12:36:16.000000000 +1300
+++ linux-2.5.64-03-do-not-refill-hot-pages/include/linux/suspend.h	2003-03-18 11:21:53.000000000 +1200
@@ -63,6 +63,8 @@
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
 
+extern unsigned int suspend_task;
+
 /* Communication between kernel/suspend.c and arch/i386/suspend.c */
 
 extern void do_magic_resume_1(void);
diff -ruN linux-2.5.64-02-free-page-map/kernel/suspend.c linux-2.5.64-03-do-not-refill-hot-pages/kernel/suspend.c
--- linux-2.5.64-02-free-page-map/kernel/suspend.c	2003-03-18 10:54:31.000000000 +1200
+++ linux-2.5.64-03-do-not-refill-hot-pages/kernel/suspend.c	2003-03-18 11:21:53.000000000 +1200
@@ -68,6 +68,7 @@
 extern int sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
+unsigned int suspend_task = 0;
 
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 /* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
@@ -232,6 +233,8 @@
 		}
 	} while(todo);
 	
+	suspend_task = current->pid;
+		
 	printk( "|\n" );
 	BUG_ON(in_atomic());
 	return 0;
@@ -253,6 +256,7 @@
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	suspend_task = 0;
 	printk( " done\n" );
 	MDELAY(500);
 }
diff -ruN linux-2.5.64-02-free-page-map/mm/page_alloc.c linux-2.5.64-03-do-not-refill-hot-pages/mm/page_alloc.c
--- linux-2.5.64-02-free-page-map/mm/page_alloc.c	2003-03-18 10:53:22.000000000 +1200
+++ linux-2.5.64-03-do-not-refill-hot-pages/mm/page_alloc.c	2003-03-18 11:21:53.000000000 +1200
@@ -486,6 +486,10 @@
  * Really, prep_compound_page() should be called from __rmqueue_bulk().  But
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
+ *
+ * While suspending, we don't use the pcp structure. It mucks up our
+ * accounting for all the pages and necessitates calling drain_local_pages
+ * multiple times.
  */
 
 static struct page *buffered_rmqueue(struct zone *zone, int order, int cold)
@@ -493,7 +497,7 @@
 	unsigned long flags;
 	struct page *page = NULL;
 
-	if (order == 0) {
+	if ((order == 0) && (!suspend_task)) {
 		struct per_cpu_pages *pcp;
 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];
@@ -700,7 +704,7 @@
 void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page)) {
-		if (order == 0)
+		if ((order == 0) && (!suspend_task))
 			free_hot_page(page);
 		else
 			__free_pages_ok(page, order);



