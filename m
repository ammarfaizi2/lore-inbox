Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263883AbSIQIJs>; Tue, 17 Sep 2002 04:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263887AbSIQIJs>; Tue, 17 Sep 2002 04:09:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32266
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263883AbSIQIJr>; Tue, 17 Sep 2002 04:09:47 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 04:12:55 -0400
Message-Id: <1032250378.969.112.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 01:56, Linus Torvalds wrote:

> We have a simple rule:
>  - task->lock_depth = -1 means "no lock held"
>  - task->lock_depth >= 0 means "BKL really held"
> 
> ... but what does "task->lock_depth < -1" mean?
> 
> Yup: "validly nonpreemptable".
> 
> So then you have:
> 
> 	#define kernel_locked()	(current->lock_depth >= 0)
> 
> 	#define in_atomic() (preempt_count() & ~PREEMPT_ACTIVE) != (current->lock_depth != -1))
> 
> and you're all set - just set lock_depth to -2 when you exit to show that
> you don't hold the BKL, but that you are validly not preemtable.
> 
> I get the award for having the most disgusting ideas.

Yah, you do.  Good job though.

I implemented exactly what you detailed, with one change: we need to
check kernel_locked() before setting lock_depth because it is valid to
exit() while holding the BKL.  Aside from kernel code that does it
intentionally, crashed code (e.g. modules) would have the same problem.

Anyhow, this works.  Finally.

Except the printk() still causes my system to lockup, but that is
another (tomorrow's) issue.

Patch is against current BK.  Thanks for the help.

	Robert Love

diff -urN linux-2.5.35/include/asm-i386/hardirq.h linux/include/asm-i386/hardirq.h
--- linux-2.5.35/include/asm-i386/hardirq.h	Sun Sep 15 22:18:46 2002
+++ linux/include/asm-i386/hardirq.h	Tue Sep 17 03:20:00 2002
@@ -77,7 +77,8 @@
 #define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
 #if CONFIG_PREEMPT
-# define in_atomic()	(preempt_count() != kernel_locked())
+# define in_atomic() \
+	((preempt_count() & ~PREEMPT_ACTIVE) != (current->lock_depth != -1))
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
 # define in_atomic()	(preempt_count() != 0)
diff -urN linux-2.5.35/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.35/kernel/exit.c	Tue Sep 17 03:18:53 2002
+++ linux/kernel/exit.c	Tue Sep 17 03:55:12 2002
@@ -637,6 +637,21 @@
 	preempt_disable();
 	if (current->exit_signal == -1)
 		release_task(current);
+
+	/*
+	 * This little bit of genius comes from the twisted mind of Linus.
+	 * We need exit() to be atomic but we also want a debugging check
+	 * in schedule() to whine if we are atomic.  The wickedness is in
+	 * these rules:
+	 *	- task->lock_depth = -2 means "validly nonpreemptable"
+	 * 	- task->lock_depth = -1 means "BKL not held"
+         * 	- task->lock_depth >= 0 means "BKL held"
+	 * release_kernel_lock and kernel_locked() check >=0, and
+	 * in_atomic() checks != -1... the "fake BKL" will "cancel out"
+	 * the preempt_disable() above and everyone is happy.
+	 */
+	if (unlikely(!kernel_locked()))
+		tsk->lock_depth = -2;
 	schedule();
 	BUG();
 /*
diff -urN linux-2.5.35/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.35/kernel/sched.c	Sun Sep 15 22:18:24 2002
+++ linux/kernel/sched.c	Tue Sep 17 03:50:04 2002
@@ -940,8 +940,10 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	if (unlikely(in_atomic())) {
+		printk(KERN_ERR "error: scheduling while non-atomic!\n");
+		dump_stack();
+	}
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
@@ -959,7 +961,7 @@
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_count() == PREEMPT_ACTIVE))
 		goto pick_next_task;
 
 	switch (prev->state) {

