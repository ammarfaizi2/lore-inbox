Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312208AbSDEDJb>; Thu, 4 Apr 2002 22:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSDEDJX>; Thu, 4 Apr 2002 22:09:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:61963 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312181AbSDEDJN>;
	Thu, 4 Apr 2002 22:09:13 -0500
Subject: Re: [PATCH] preemptive kernel behavior change: don't be rude
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, George Anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204041740220.7731-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 22:09:04 -0500
Message-Id: <1017976155.22299.746.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus and company,

Attached find a final version of the new behavior patch.  It meets
everyone's concerns and it compiles, boots, and survived a basic stress
test here.

The next step would be to push the preempt_count check back into
preempt_schedule and duplicate preempt_schedule in entry.S and then have
it call schedule directly.  This would be both a space and time
optimization.  I will do this, but I'd like to give this as it is some
testing first.

Linus, if this is how you want it, please apply.  Patch is against
2.5.8-pre1.

	Robert Love

diff -urN linux-2.5.8-pre1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.8-pre1/arch/i386/kernel/entry.S	Wed Apr  3 20:57:24 2002
+++ linux/arch/i386/kernel/entry.S	Thu Apr  4 20:44:40 2002
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
+++ linux/arch/i386/kernel/ptrace.c	Thu Apr  4 20:44:40 2002
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
+++ linux/arch/i386/kernel/signal.c	Thu Apr  4 20:44:40 2002
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
+++ linux/include/linux/sched.h	Thu Apr  4 21:56:11 2002
@@ -91,6 +91,7 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
+#define PREEMPT_ACTIVE		0x4000000
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
diff -urN linux-2.5.8-pre1/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.8-pre1/include/linux/spinlock.h	Wed Apr  3 20:57:34 2002
+++ linux/include/linux/spinlock.h	Thu Apr  4 21:56:11 2002
@@ -177,8 +177,9 @@
 do { \
 	--current_thread_info()->preempt_count; \
 	barrier(); \
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
+	if (unlikely(!(current_thread_info()->preempt_count) && \
+		test_thread_flag(TIF_NEED_RESCHED))) \
+			preempt_schedule(); \
 } while (0)
 
 #define spin_lock(lock)	\
diff -urN linux-2.5.8-pre1/kernel/exit.c linux/kernel/exit.c
--- linux-2.5.8-pre1/kernel/exit.c	Wed Apr  3 20:57:37 2002
+++ linux/kernel/exit.c	Thu Apr  4 21:55:29 2002
@@ -499,6 +495,7 @@
 	acct_process(code);
 	__exit_mm(tsk);
 
+	preempt_disable();
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
diff -urN linux-2.5.8-pre1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.8-pre1/kernel/sched.c	Wed Apr  3 20:57:37 2002
+++ linux/kernel/sched.c	Thu Apr  4 20:54:17 2002
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
@@ -775,9 +782,7 @@
 	case TASK_RUNNING:
 		;
 	}
-#if CONFIG_SMP
 pick_next_task:
-#endif
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
 		load_balance(rq, 1);
@@ -841,10 +846,12 @@
  */
 asmlinkage void preempt_schedule(void)
 {
-	if (unlikely(preempt_get_count()))
-		return;
-	current->state = TASK_RUNNING;
-	schedule();
+	do {
+		current_thread_info()->preempt_count += PREEMPT_ACTIVE;
+		schedule();
+		current_thread_info()->preempt_count -= PREEMPT_ACTIVE;
+		barrier();
+	} while(test_thread_flag(TIF_NEED_RESCHED));
 }
 #endif /* CONFIG_PREEMPT */
 

