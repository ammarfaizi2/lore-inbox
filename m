Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVALLtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVALLtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVALLtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:49:40 -0500
Received: from pD95F6CA7.dip.t-dialin.net ([217.95.108.167]:17384 "EHLO
	tglx.tec.linutronix.de") by vger.kernel.org with ESMTP
	id S261154AbVALLtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:49:35 -0500
Date: Wed, 12 Jan 2005 12:49:19 +0100
From: tglx@linutronix.de
Message-ID: <20050112124910.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: akpm@osdl.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-mm2 Resend] Fix preemption race [1/3] (Core/i386)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idle-thread-preemption-fix.patch introduced a race, which is not 
critical, but might give us an extra turn through the scheduler. When
interrupts are reenabled in entry.c and an interrupt occures before we
reach the add_preempt_schedule() in preempt_schedule we get rescheduled
again in the return from interrupt path.

The patch prevents this by leaving interrupts disabled and calling a
a seperate function preempt_schedule_irq().

This split adds different plausibility checks for irq context calls 
and kernel calls.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
arch/i386/kernel/entry.S |    6 ++----
kernel/sched.c           |   42 ++++++++++++++++++++++++++++++++++++++++++
2 files changed, 44 insertions(+), 4 deletions(-)
---
Index: 2.6.10-mm2/kernel/sched.c
===================================================================
--- 2.6.10-mm2/kernel/sched.c	(revision 148)
+++ 2.6.10-mm2/kernel/sched.c	(working copy)
@@ -2870,6 +2870,48 @@
 }
 
 EXPORT_SYMBOL(preempt_schedule);
+
+/*
+ * this is is the entry point to schedule() from kernel preemption
+ * off of irq context. 
+ * Note, that this is called and return with irqs disabled. This will
+ * protect us against recursive calling from irq.
+ */
+asmlinkage void __sched preempt_schedule_irq(void)
+{
+	struct thread_info *ti = current_thread_info();
+#ifdef CONFIG_PREEMPT_BKL
+	struct task_struct *task = current;
+	int saved_lock_depth;
+#endif
+	/* Catch callers which need to be fixed*/
+	BUG_ON(ti->preempt_count || !irqs_disabled());
+
+need_resched:
+	add_preempt_count(PREEMPT_ACTIVE);
+	/*
+	 * We keep the big kernel semaphore locked, but we
+	 * clear ->lock_depth so that schedule() doesnt
+	 * auto-release the semaphore:
+	 */
+#ifdef CONFIG_PREEMPT_BKL
+	saved_lock_depth = task->lock_depth;
+	task->lock_depth = -1;
+#endif
+	local_irq_enable();
+	schedule();
+	local_irq_disable();
+#ifdef CONFIG_PREEMPT_BKL
+	task->lock_depth = saved_lock_depth;
+#endif
+	sub_preempt_count(PREEMPT_ACTIVE);
+
+	/* we could miss a preemption opportunity between schedule and now */
+	barrier();
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		goto need_resched;
+}
+
 #endif /* CONFIG_PREEMPT */
 
 int default_wake_function(wait_queue_t *curr, unsigned mode, int sync, void *key)
Index: 2.6.10-mm2/arch/i386/kernel/entry.S
===================================================================
--- 2.6.10-mm2/arch/i386/kernel/entry.S	(revision 148)
+++ 2.6.10-mm2/arch/i386/kernel/entry.S	(working copy)
@@ -189,6 +189,7 @@
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
+	cli
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_all
 need_resched:
@@ -197,10 +198,7 @@
 	jz restore_all
 	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
-	sti
-	call preempt_schedule
-	cli
-	movl $0,TI_preempt_count(%ebp)
+	call preempt_schedule_irq(); 
 	jmp need_resched
 #endif
 
