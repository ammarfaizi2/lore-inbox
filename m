Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264488AbSIQTSf>; Tue, 17 Sep 2002 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbSIQTSf>; Tue, 17 Sep 2002 15:18:35 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64268
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264488AbSIQTSe>; Tue, 17 Sep 2002 15:18:34 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 15:23:31 -0400
Message-Id: <1032290611.4592.206.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 14:57, Ingo Molnar wrote:

> i'd do (a). current->state is to be used anyway, and the default-untaken
> first branch should be cheap. Plus by moving things down the splitup of
> the function would create more code duplication than necessery i think.

Note by moving it down, the only gain over keeping it at the top is not
having to check for the BKL...

Anyhow, I would appreciate it if you could give this a try (with kernel
preemption enabled)... any comments are appreciated.

(Note you need a 2.5.35-bk release to get the dump_stack().  Otherwise
use show_trace(0).)

	Robert Love

diff -urN linux-2.5.35/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.35/kernel/sched.c	Sun Sep 15 22:18:24 2002
+++ linux/kernel/sched.c	Tue Sep 17 15:24:08 2002
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
 
@@ -959,7 +968,7 @@
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_count() == PREEMPT_ACTIVE))
 		goto pick_next_task;
 
 	switch (prev->state) {

