Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSJ2Wqj>; Tue, 29 Oct 2002 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSJ2Wqj>; Tue, 29 Oct 2002 17:46:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18948 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262448AbSJ2Wqh>;
	Tue, 29 Oct 2002 17:46:37 -0500
Date: Wed, 30 Oct 2002 00:18:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp -- small fixes
Message-ID: <20021029231810.GA158@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Do not oops when no swapfile is available and make it compile on
DISCONTIGMEM machines. Please apply,
								Pavel

--- clean/kernel/suspend.c	2002-10-14 18:18:54.000000000 +0200
+++ linux-swsusp/kernel/suspend.c	2002-10-18 20:26:11.000000000 +0200
@@ -57,12 +57,13 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>
+#include <linux/swapops.h>
+#include <linux/bootmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <linux/swapops.h>
 
 extern void signal_wake_up(struct task_struct *t);
 extern int sys_sync(void);
@@ -225,7 +226,7 @@
 			todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
-		yield();
+		yield();			/* Yield is okay here */
 		if (time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
@@ -309,6 +311,9 @@
 	union diskpage *cur;
 	struct page *page;
 
+	if (root_swap == 0xFFFF)  /* ignored */
+		return;
+
 	page = alloc_page(GFP_ATOMIC);
 	if (!page)
 		panic("Out of memory in mark_swapfiles");
@@ -474,9 +480,9 @@
 #ifdef CONFIG_DISCONTIGMEM
 	panic("Discontingmem not supported");
 #else
-	BUG_ON (max_mapnr != num_physpages);
+	BUG_ON (max_pfn != num_physpages);
 #endif
-	for (pfn = 0; pfn < max_mapnr; pfn++) {
+	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
 			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
@@ -686,6 +702,7 @@
 	if(nr_free_pages() < nr_needed_pages) {
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
+		root_swap = 0xFFFF;
 		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
