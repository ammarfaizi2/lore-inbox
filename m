Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264560AbSIREjx>; Wed, 18 Sep 2002 00:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSIREjx>; Wed, 18 Sep 2002 00:39:53 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64261
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264560AbSIREjw>; Wed, 18 Sep 2002 00:39:52 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Steven Cole <elenstev@mesatop.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032296284.12257.66.camel@spc9.esa.lanl.gov>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain> 
	<1032290611.4592.206.camel@phantasy> 
	<1032292468.11907.44.camel@spc9.esa.lanl.gov> 
	<1032293199.4588.235.camel@phantasy> 
	<1032296284.12257.66.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 00:44:51 -0400
Message-Id: <1032324294.4588.758.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 16:58, Steven Cole wrote:

> Sorry, it hung so badly that it didn't respond to that.

I fixed the hang.  If you notice the problem, please do not laugh.

The attached patch, against 2.5.36, should work fine...

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
 

