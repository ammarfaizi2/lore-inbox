Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268531AbTANCrc>; Mon, 13 Jan 2003 21:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268532AbTANCqf>; Mon, 13 Jan 2003 21:46:35 -0500
Received: from dp.samba.org ([66.70.73.150]:46732 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268535AbTANCqB>;
	Mon, 13 Jan 2003 21:46:01 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Drain local pages to make swsusp work
Date: Tue, 14 Jan 2003 13:42:54 +1100
Message-Id: <20030114025453.790822C445@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Pavel Machek <pavel@ucw.cz>

  Hi!
  
  With local pages present, swsusp's accounting goes wrong and you get
  nice BUG(). This fixes it, please apply.
  								Pavel
  

--- trivial-2.5.57/kernel/suspend.c.orig	2003-01-14 12:54:30.000000000 +1100
+++ trivial-2.5.57/kernel/suspend.c	2003-01-14 12:54:30.000000000 +1100
@@ -680,6 +680,8 @@
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
 
+	drain_local_pages();
+
 	pagedir_nosave = NULL;
 	printk( "/critical section: Counting pages to copy" );
 	nr_copy_pages = count_and_copy_data_pages(NULL);
@@ -714,6 +716,7 @@
 	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 
+	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
 		BUG();
 
-- 
  Don't blame me: the Monkey is driving
  File: Pavel Machek <pavel@ucw.cz>: Drain local pages to make swsusp work
