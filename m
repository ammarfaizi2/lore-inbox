Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbTCRGcZ>; Tue, 18 Mar 2003 01:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCRGcZ>; Tue, 18 Mar 2003 01:32:25 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:46016 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262180AbTCRGcV>; Tue, 18 Mar 2003 01:32:21 -0500
Date: Tue, 18 Mar 2003 18:40:57 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
In-reply-to: <20030317160556.4efc880f.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047969656.2430.30.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1047945372.1714.19.camel@laptop-linux.cunninghams>
 <20030317160556.4efc880f.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the updated version.

Regards,

Nigel

diff -ruN linux-2.5.65-02/include/linux/suspend.h linux-2.5.65-03/include/linux/suspend.h
--- linux-2.5.65-02/include/linux/suspend.h	2003-03-10 12:36:16.000000000 +1300
+++ linux-2.5.65-03/include/linux/suspend.h	2003-03-18 17:56:37.000000000 +1200
@@ -63,6 +63,8 @@
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
 
+extern unsigned int suspend_task;
+
 /* Communication between kernel/suspend.c and arch/i386/suspend.c */
 
 extern void do_magic_resume_1(void);
@@ -79,6 +81,7 @@
 static inline void software_suspend(void)
 {
 }
+#define suspend_task			0
 #define software_resume()		do { } while(0)
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
diff -ruN linux-2.5.65-02/kernel/suspend.c linux-2.5.65-03/kernel/suspend.c
--- linux-2.5.65-02/kernel/suspend.c	2003-03-18 17:53:44.000000000 +1200
+++ linux-2.5.65-03/kernel/suspend.c	2003-03-18 17:55:55.000000000 +1200
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
diff -ruN linux-2.5.65-02/mm/page_alloc.c linux-2.5.65-03/mm/page_alloc.c
--- linux-2.5.65-02/mm/page_alloc.c	2003-03-18 17:53:44.000000000 +1200
+++ linux-2.5.65-03/mm/page_alloc.c	2003-03-18 17:55:55.000000000 +1200
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



-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

