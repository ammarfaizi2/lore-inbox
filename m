Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSDEAEM>; Thu, 4 Apr 2002 19:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDEAEF>; Thu, 4 Apr 2002 19:04:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:29706 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289484AbSDEADt>;
	Thu, 4 Apr 2002 19:03:49 -0500
Subject: [PATCH] preemptive kernel behavior change: don't be rude
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, george@mvista.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041554350.26177-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 19:03:49 -0500
Message-Id: <1017965029.23629.685.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 18:55, Linus Torvalds wrote:
> Fair enough. Send me a patch to look at.

Linus et all,

Here we go:

- do not manually set task->state
- instead, in preempt_schedule, set a flag in preempt_count that
  denotes that this task is entering schedule off a kernel preemption.
- use this flag in schedule to jump to pick_next_task
- in preempt_schedule, upon return from schedule, unset the flag
- have entry.S just call preempt_schedule and not duplicate this work,
  as Linus suggested.  I agree.  Note this makes debugging easier as
  we keep a single point of entry for kernel preemptions.

The result: we can safely preempt non-TASK_RUNNING tasks.  If one is
preempted, we can safely survive schedule because we won't handle the
special casing of non-TASK_RUNNING at the top of schedule.  Thus other
tasks can run as desired and our non-TASK_RUNNING task will eventually
be rescheduled, in its original state, and complete happily.

This is the behavior we have in the 2.4 patches and 2.5 until
~2.5.6-pre.  This works.  It requires no other changes elsewhere (it
actually removes some special-casing Ingo did in the signal code).

This patch works in theory and compiles, but received minimal testing.

	Robert Love

diff -urN linux-2.5.8-pre1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.8-pre1/arch/i386/kernel/entry.S	Wed Apr  3 20:57:24 2002
+++ linux/arch/i386/kernel/entry.S	Thu Apr  4 18:32:03 2002
@@ -240,9 +240,7 @@
 	jnz restore_all
 	incl TI_PRE_COUNT(%ebx)
 	sti
-	movl TI_TASK(%ebx), %ecx		# ti->task
-	movl $0,(%ecx)			# current->state = TASK_RUNNING
-	call SYMBOL_NAME(schedule)
+	call SYMBOL_NAME(preempt_schedule)
 	jmp ret_from_intr
 #endif
 
diff -urN linux-2.5.8-pre1/arch/i386/kernel/ptrace.c linux/arch/i386/kernel/ptrace.c
--- linux-2.5.8-pre1/arch/i386/kernel/ptrace.c	Wed Apr  3 20:57:24 2002
+++ linux/arch/i386/kernel/ptrace.c	Thu Apr  4 18:31:17 2002
@@ -455,11 +455,9 @@
 	   between a syscall stop and SIGTRAP delivery */
 	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
 					? 0x80 : 0);
-	preempt_disable();
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
-	preempt_enable();
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -urN linux-2.5.8-pre1/arch/i386/kernel/signal.c linux/arch/i386/kernel/signal.c
--- linux-2.5.8-pre1/arch/i386/kernel/signal.c	Wed Apr  3 20:57:24 2002
+++ linux/arch/i386/kernel/signal.c	Thu Apr  4 18:31:00 2002
@@ -610,11 +610,9 @@
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			/* Let the debugger run.  */
 			current->exit_code = signr;
-			preempt_disable();
 			current->state = TASK_STOPPED;
 			notify_parent(current, SIGCHLD);
 			schedule();
-			preempt_enable();
 
 			/* We're back.  Did the debugger cancel the sig?  */
 			if (!(signr = current->exit_code))
@@ -669,14 +667,12 @@
 
 			case SIGSTOP: {
 				struct signal_struct *sig;
+				current->state = TASK_STOPPED;
 				current->exit_code = signr;
 				sig = current->parent->sig;
-				preempt_disable();
-				current->state = TASK_STOPPED;
 				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
 					notify_parent(current, SIGCHLD);
 				schedule();
-				preempt_enable();
 				continue;
 			}
 
diff -urN linux-2.5.8-pre1/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.8-pre1/include/linux/sched.h	Wed Apr  3 20:57:27 2002
+++ linux/include/linux/sched.h	Thu Apr  4 18:29:53 2002
@@ -91,6 +91,7 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
+#define PREEMPT_ACTIVE		0x4000000
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
diff -urN linux-2.5.8-pre1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.8-pre1/kernel/sched.c	Wed Apr  3 20:57:37 2002
+++ linux/kernel/sched.c	Thu Apr  4 18:29:24 2002
@@ -764,6 +764,13 @@
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
+	/*
+	 * if entering from preempt_schedule, off a kernel preemption,
+	 * go straight to picking the next task.
+	 */
+	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
+		goto pick_next_task;
+	
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
 		if (unlikely(signal_pending(prev))) {
@@ -775,7 +782,7 @@
 	case TASK_RUNNING:
 		;
 	}
-#if CONFIG_SMP
+#if CONFIG_SMP || CONFIG_PREEMPT
 pick_next_task:
 #endif
 	if (unlikely(!rq->nr_running)) {
@@ -843,8 +850,11 @@
 {
 	if (unlikely(preempt_get_count()))
 		return;
-	current->state = TASK_RUNNING;
+
+	current_thread_info()->preempt_count += PREEMPT_ACTIVE;
 	schedule();
+	current_thread_info()->preempt_count -= PREEMPT_ACTIVE;
+	barrier();
 }
 #endif /* CONFIG_PREEMPT */
 

