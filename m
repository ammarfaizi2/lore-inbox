Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbSITUAS>; Fri, 20 Sep 2002 16:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263444AbSITUAR>; Fri, 20 Sep 2002 16:00:17 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:524
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263435AbSITUAQ>; Fri, 20 Sep 2002 16:00:16 -0400
Subject: [PATCH] schedule() in_atomic() check
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 16:05:15 -0400
Message-Id: <1032552318.962.830.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Resend of patch to make the in_atomic() check in schedule() actually
work.  You merged the PREEMPT_ACTIVE bits, we just need to handle the
exit() case correctly.

Tested with and without CONFIG_PREEMPT -- works like a charm.

Patch is against current BK.

	Robert Love

diff -urN linux-2.5.37/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.37/kernel/sched.c	Fri Sep 20 11:20:32 2002
+++ linux/kernel/sched.c	Fri Sep 20 15:49:05 2002
@@ -940,8 +940,17 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	/*
+	 * Test if we are atomic.  Since do_exit() needs to call into
+	 * schedule() atomically, we ignore that path for now.
+	 * Otherwise, whine if we are scheduling when we should not be.
+	 */
+	if (likely(current->state != TASK_ZOMBIE)) {
+		if (unlikely(in_atomic())) {
+			printk(KERN_ERR "bad: scheduling while atomic!\n");
+			dump_stack();
+		}
+	}
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();





