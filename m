Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVAJAe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVAJAe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVAJAe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:34:59 -0500
Received: from pD953A118.dip.t-dialin.net ([217.83.161.24]:20390 "EHLO
	tglx.tec.linutronix.de") by vger.kernel.org with ESMTP
	id S262019AbVAJAes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:34:48 -0500
Date: Mon, 10 Jan 2005 01:34:19 +0100
From: tglx@linutronix.de
Message-ID: <20050110013417.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: akpm@osdl.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-mm2] Fix preemption race [1/3] (Core)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idle-thread-preemption-fix.patch introduced a race, which is not 
critical, but might give us an extra turn through the scheduler. When
interrupts are reenabled in entry.c and an interrupt occures before we
reach the add_preempt_schedule() in preempt_schedule we get rescheduled
again in the return from interrupt path.

The patch prevents this by leaving preemption disabled (set to 1) and 
providing a seperate function entry_preempt_schedule().
This was done by moving the inner loop of preempt_schedule() into a
seperate function do_preempt_schedule(), which has an increment argument.
The function is called from preempt_schedule() with PREEMPT_ACTIVE and
from entry_preempt_schedule() with PREEMPT_ACTIVE-1 to fixup the already
available 1 in preempt_count.

This split adds different plausibility checks for entry code and kernel
calls and provides simpler adjusting of other platforms esp. ARM to the
new code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 sched.c |   44 ++++++++++++++++++++++++++++++++++----------
 entry.S |    3 ++-
 2 files changed, 36 insertions(+), 11 deletions(-)
---
Index: 2.6.10-mm1/kernel/sched.c
===================================================================
--- 2.6.10-mm1/kernel/sched.c	(revision 141)
+++ 2.6.10-mm1/kernel/sched.c	(working copy)
@@ -2836,22 +2836,15 @@
  * off of preempt_enable.  Kernel preemptions off return from interrupt
  * occur there and call schedule directly.
  */
-asmlinkage void __sched preempt_schedule(void)
+static void __sched do_preempt_schedule(int incr)
 {
-	struct thread_info *ti = current_thread_info();
 #ifdef CONFIG_PREEMPT_BKL
 	struct task_struct *task = current;
 	int saved_lock_depth;
 #endif
-	/*
-	 * If there is a non-zero preempt_count or interrupts are disabled,
-	 * we do not want to preempt the current task.  Just return..
-	 */
-	if (unlikely(ti->preempt_count || irqs_disabled()))
-		return;
 
 need_resched:
-	add_preempt_count(PREEMPT_ACTIVE);
+	add_preempt_count(incr);
 	/*
 	 * We keep the big kernel semaphore locked, but we
 	 * clear ->lock_depth so that schedule() doesnt
@@ -2865,15 +2858,46 @@
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;
 #endif
-	sub_preempt_count(PREEMPT_ACTIVE);
+	sub_preempt_count(incr);
 
 	/* we could miss a preemption opportunity between schedule and now */
 	barrier();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
 }
+/*
+ * this is is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.  Kernel preemptions off return from interrupt
+ * occur there and call schedule directly.
+ */
+asmlinkage void __sched preempt_schedule(void)
+{
+	struct thread_info *ti = current_thread_info();
+	/*
+	 * If there is a non-zero preempt_count or interrupts are disabled,
+	 * we do not want to preempt the current task.  Just return..
+	 */
+	if (unlikely(ti->preempt_count || irqs_disabled()))
+		return;
+	do_preempt_schedule(PREEMPT_ACTIVE);
+}
 
 EXPORT_SYMBOL(preempt_schedule);
+
+asmlinkage void __sched entry_preempt_schedule(void)
+{
+	struct thread_info *ti = current_thread_info();
+	/* 
+	 * If preempt_count != 1 or interrupts are disabled
+	 * the calling code is broken.
+	 */
+	BUG_ON((ti->preempt_count != 1 || irqs_disabled()));
+		
+	do_preempt_schedule(PREEMPT_ACTIVE - 1);
+}
+
+EXPORT_SYMBOL(entry_preempt_schedule);
+
 #endif /* CONFIG_PREEMPT */
 
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync, void *key)
Index: 2.6.10-mm1/arch/i386/kernel/entry.S
===================================================================
--- 2.6.10-mm1/arch/i386/kernel/entry.S	(revision 141)
+++ 2.6.10-mm1/arch/i386/kernel/entry.S	(working copy)
@@ -197,8 +197,9 @@
 	jz restore_all
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
+	movl $1,TI_preempt_count(%ebp)
 	sti
-	call preempt_schedule
+	call entry_preempt_schedule
 	cli
 	movl $0,TI_preempt_count(%ebp)
 	jmp need_resched
