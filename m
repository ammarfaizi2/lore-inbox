Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSIRElq>; Wed, 18 Sep 2002 00:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265217AbSIRElq>; Wed, 18 Sep 2002 00:41:46 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4102
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265211AbSIRElp>; Wed, 18 Sep 2002 00:41:45 -0400
Subject: [PATCH] schedule() in_atomic() fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 00:46:43 -0400
Message-Id: <1032324404.4593.764.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch fixes the scheduler in_atomic() problem with kernel
preemption enabled (and is also working - when kernel preemption is on,
it finds a couple issues during boot).

I hope this approach is to your liking.

Patch is against current BK, please apply.

	Robert Love

diff -urN linux-2.5.36/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.36/kernel/sched.c	Tue Sep 17 20:58:48 2002
+++ linux/kernel/sched.c	Wed Sep 18 00:41:09 2002
@@ -940,9 +940,6 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
-
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
 #endif
@@ -950,8 +947,20 @@
 	preempt_disable();
 	prev = current;
 	rq = this_rq();
-
 	release_kernel_lock(prev);
+
+	/*
+	 * Test if we are atomic.  Since do_exit() needs to call into
+	 * schedule() atomically, we ignore that for now.  Otherwise,
+	 * whine if we are scheduling when we should not be.
+	 */
+	if (likely(current->state != TASK_ZOMBIE)) {
+		if (unlikely((preempt_count() & ~PREEMPT_ACTIVE) != 1)) {
+			printk(KERN_ERR "scheduling while non-atomic!\n");
+			dump_stack();
+		}
+	}
+
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 



