Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUIETOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUIETOl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUIETOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:14:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58301 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266910AbUIETNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:13:04 -0400
Date: Sun, 5 Sep 2004 21:13:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] abstract thread_info access
Message-ID: <Pine.LNX.4.61.0409052112190.9677@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the previous patch the thread_info pointer in task struct became 
redundant, so we can replace it with a macro and archs can provide a more 
efficient access to the thread_info structure.

Further changes now require the already mentioned header cleanup.

bye, Roman

diff -ur linux-2.6.8.1-allocstack/arch/i386/kernel/process.c linux-2.6.8.1-getthreadinfo/arch/i386/kernel/process.c
--- linux-2.6.8.1-allocstack/arch/i386/kernel/process.c	2004-08-14 12:52:25.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/arch/i386/kernel/process.c	2004-08-29 01:14:23.000000000 +0200
@@ -352,7 +352,7 @@
 	struct task_struct *tsk;
 	int err;
 
-	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->stack)) - 1;
 	*childregs = *regs;
 	childregs->eax = 0;
 	childregs->esp = esp;
@@ -456,7 +456,7 @@
 	struct pt_regs ptregs;
 	
 	ptregs = *(struct pt_regs *)
-		((unsigned long)tsk->thread_info+THREAD_SIZE - sizeof(ptregs));
+		((unsigned long)tsk->stack + THREAD_SIZE - sizeof(ptregs));
 	ptregs.xcs &= 0xffff;
 	ptregs.xds &= 0xffff;
 	ptregs.xes &= 0xffff;
@@ -647,7 +647,7 @@
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long)p->thread_info;
+	stack_page = (unsigned long)p->stack;
 	esp = p->thread.esp;
 	if (!stack_page || esp < stack_page || esp > top_esp+stack_page)
 		return 0;
diff -ur linux-2.6.8.1-allocstack/arch/i386/kernel/traps.c linux-2.6.8.1-getthreadinfo/arch/i386/kernel/traps.c
--- linux-2.6.8.1-allocstack/arch/i386/kernel/traps.c	2004-08-29 02:42:20.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/arch/i386/kernel/traps.c	2004-08-29 01:14:53.000000000 +0200
@@ -95,7 +95,7 @@
 
 static int valid_stack_ptr(struct task_struct *task, void *p)
 {
-	if (p <= (void *)task->thread_info)
+	if (p <= task->stack)
 		return 0;
 	if (kstack_end(p))
 		return 0;
diff -ur linux-2.6.8.1-allocstack/arch/i386/kernel/vm86.c linux-2.6.8.1-getthreadinfo/arch/i386/kernel/vm86.c
--- linux-2.6.8.1-allocstack/arch/i386/kernel/vm86.c	2004-08-14 12:52:25.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/arch/i386/kernel/vm86.c	2004-08-29 01:15:45.000000000 +0200
@@ -319,7 +319,7 @@
 		"movl %1,%%ebp\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (tsk->thread_info) : "ax");
+		:"r" (&info->regs), "r" (get_thread_info(tsk)) : "ax");
 	/* we never return here */
 }
 
diff -ur linux-2.6.8.1-allocstack/arch/m68k/kernel/process.c linux-2.6.8.1-getthreadinfo/arch/m68k/kernel/process.c
--- linux-2.6.8.1-allocstack/arch/m68k/kernel/process.c	2004-08-14 12:52:28.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/arch/m68k/kernel/process.c	2004-09-05 14:43:30.000000000 +0200
@@ -245,7 +245,7 @@
 	unsigned long stack_offset, *retp;
 
 	stack_offset = THREAD_SIZE - sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) ((unsigned long) (p->thread_info) + stack_offset);
+	childregs = (struct pt_regs *) ((unsigned long) (p->stack) + stack_offset);
 
 	*childregs = *regs;
 	childregs->d0 = 0;
@@ -390,7 +390,7 @@
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_page = (unsigned long)(p->thread_info);
+	stack_page = (unsigned long)(p->stack);
 	fp = ((struct switch_stack *)p->thread.ksp)->a6;
 	do {
 		if (fp < stack_page+sizeof(struct thread_info) ||
diff -ur linux-2.6.8.1-allocstack/include/asm/i387.h linux-2.6.8.1-getthreadinfo/include/asm/i387.h
--- linux-2.6.8.1-allocstack/include/asm/i387.h	2004-08-29 02:42:24.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/asm/i387.h	2004-08-29 01:13:10.000000000 +0200
@@ -40,19 +40,19 @@
 		asm volatile( "fnsave %0 ; fwait"
 			      : "=m" (tsk->thread.i387.fsave) );
 	}
-	tsk->thread_info->status &= ~TS_USEDFPU;
+	get_thread_info(tsk)->status &= ~TS_USEDFPU;
 }
 
 #define __unlazy_fpu( tsk ) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) \
+	if (get_thread_info(tsk)->status & TS_USEDFPU) \
 		save_init_fpu( tsk ); \
 } while (0)
 
 #define __clear_fpu( tsk )					\
 do {								\
-	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
-		asm volatile("fnclex ; fwait");				\
-		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
+	if (get_thread_info(tsk)->status & TS_USEDFPU) {	\
+		asm volatile("fnclex ; fwait");			\
+		get_thread_info(tsk)->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
diff -ur linux-2.6.8.1-allocstack/include/asm/processor.h linux-2.6.8.1-getthreadinfo/include/asm/processor.h
--- linux-2.6.8.1-allocstack/include/asm/processor.h	2004-08-14 12:53:31.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/asm/processor.h	2004-08-29 01:46:47.000000000 +0200
@@ -497,7 +497,7 @@
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);     \
+       __regs__ = (struct pt_regs *)KSTK_TOP((task)->stack);           \
        __regs__ - 1;                                                   \
 })
 
diff -ur linux-2.6.8.1-allocstack/include/asm/thread_info.h linux-2.6.8.1-getthreadinfo/include/asm/thread_info.h
--- linux-2.6.8.1-allocstack/include/asm/thread_info.h	2004-09-05 13:51:35.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/asm/thread_info.h	2004-09-05 14:03:26.000000000 +0200
@@ -117,13 +117,15 @@
 
 #define initialize_thread_info(tsk, orig)			\
 	({							\
-		struct thread_info *ti = tsk->stack;		\
+		struct thread_info *ti = get_thread_info(tsk);	\
 								\
-		*ti = *orig->thread_info;			\
+		*ti = *get_thread_info(orig);			\
 		ti->task = tsk;					\
-		tsk->thread_info = ti;				\
 	})
 
+#define get_thread_info(tsk)					\
+	({ struct thread_info *ti = (tsk)->stack; ti; })
+
 #else /* !__ASSEMBLY__ */
 
 /* how to get the thread information struct from ASM */
diff -ur linux-2.6.8.1-allocstack/include/asm-i386/i387.h linux-2.6.8.1-getthreadinfo/include/asm-i386/i387.h
--- linux-2.6.8.1-allocstack/include/asm-i386/i387.h	2004-08-29 02:42:24.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/asm-i386/i387.h	2004-08-29 01:13:10.000000000 +0200
@@ -40,19 +40,19 @@
 		asm volatile( "fnsave %0 ; fwait"
 			      : "=m" (tsk->thread.i387.fsave) );
 	}
-	tsk->thread_info->status &= ~TS_USEDFPU;
+	get_thread_info(tsk)->status &= ~TS_USEDFPU;
 }
 
 #define __unlazy_fpu( tsk ) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) \
+	if (get_thread_info(tsk)->status & TS_USEDFPU) \
 		save_init_fpu( tsk ); \
 } while (0)
 
 #define __clear_fpu( tsk )					\
 do {								\
-	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
-		asm volatile("fnclex ; fwait");				\
-		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
+	if (get_thread_info(tsk)->status & TS_USEDFPU) {	\
+		asm volatile("fnclex ; fwait");			\
+		get_thread_info(tsk)->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
diff -ur linux-2.6.8.1-allocstack/include/asm-i386/processor.h linux-2.6.8.1-getthreadinfo/include/asm-i386/processor.h
--- linux-2.6.8.1-allocstack/include/asm-i386/processor.h	2004-08-14 12:53:31.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/asm-i386/processor.h	2004-08-29 01:46:47.000000000 +0200
@@ -497,7 +497,7 @@
 #define task_pt_regs(task)                                             \
 ({                                                                     \
        struct pt_regs *__regs__;                                       \
-       __regs__ = (struct pt_regs *)KSTK_TOP((task)->thread_info);     \
+       __regs__ = (struct pt_regs *)KSTK_TOP((task)->stack);           \
        __regs__ - 1;                                                   \
 })
 
diff -ur linux-2.6.8.1-allocstack/include/asm-i386/thread_info.h linux-2.6.8.1-getthreadinfo/include/asm-i386/thread_info.h
--- linux-2.6.8.1-allocstack/include/asm-i386/thread_info.h	2004-09-05 13:51:35.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/asm-i386/thread_info.h	2004-09-05 14:03:26.000000000 +0200
@@ -117,13 +117,15 @@
 
 #define initialize_thread_info(tsk, orig)			\
 	({							\
-		struct thread_info *ti = tsk->stack;		\
+		struct thread_info *ti = get_thread_info(tsk);	\
 								\
-		*ti = *orig->thread_info;			\
+		*ti = *get_thread_info(orig);			\
 		ti->task = tsk;					\
-		tsk->thread_info = ti;				\
 	})
 
+#define get_thread_info(tsk)					\
+	({ struct thread_info *ti = (tsk)->stack; ti; })
+
 #else /* !__ASSEMBLY__ */
 
 /* how to get the thread information struct from ASM */
diff -ur linux-2.6.8.1-allocstack/include/linux/init_task.h linux-2.6.8.1-getthreadinfo/include/linux/init_task.h
--- linux-2.6.8.1-allocstack/include/linux/init_task.h	2004-09-05 13:50:53.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/linux/init_task.h	2004-09-05 14:03:55.000000000 +0200
@@ -67,7 +67,6 @@
 #define INIT_TASK(tsk)	\
 {									\
 	.state		= 0,						\
-	.thread_info	= &init_thread_info,				\
 	.stack		= &init_stack,					\
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
diff -ur linux-2.6.8.1-allocstack/include/linux/sched.h linux-2.6.8.1-getthreadinfo/include/linux/sched.h
--- linux-2.6.8.1-allocstack/include/linux/sched.h	2004-09-05 13:38:30.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/linux/sched.h	2004-09-05 14:05:40.000000000 +0200
@@ -389,7 +389,6 @@
 
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	struct thread_info *thread_info;
 	void *stack;
 	atomic_t usage;
 	unsigned long flags;	/* per process flags, defined below */
@@ -984,27 +983,27 @@
  */
 static inline void set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	set_ti_thread_flag(tsk->thread_info,flag);
+	set_ti_thread_flag(get_thread_info(tsk), flag);
 }
 
 static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	clear_ti_thread_flag(tsk->thread_info,flag);
+	clear_ti_thread_flag(get_thread_info(tsk), flag);
 }
 
 static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_and_set_ti_thread_flag(tsk->thread_info,flag);
+	return test_and_set_ti_thread_flag(get_thread_info(tsk), flag);
 }
 
 static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_and_clear_ti_thread_flag(tsk->thread_info,flag);
+	return test_and_clear_ti_thread_flag(get_thread_info(tsk), flag);
 }
 
 static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
-	return test_ti_thread_flag(tsk->thread_info,flag);
+	return test_ti_thread_flag(get_thread_info(tsk), flag);
 }
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
@@ -1068,12 +1067,12 @@
 
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
-	return p->thread_info->cpu;
+	return get_thread_info(p)->cpu;
 }
 
 static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 {
-	p->thread_info->cpu = cpu;
+	get_thread_info(p)->cpu = cpu;
 }
 
 #else
diff -ur linux-2.6.8.1-allocstack/include/linux/task_struct.h linux-2.6.8.1-getthreadinfo/include/linux/task_struct.h
--- linux-2.6.8.1-allocstack/include/linux/task_struct.h	2004-08-28 01:04:21.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/include/linux/task_struct.h	2004-08-29 01:04:42.000000000 +0200
@@ -14,7 +14,6 @@
 
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	struct thread_info *thread_info;
 	void *stack;
 	atomic_t usage;
 	unsigned long flags;	/* per process flags, defined below */
diff -ur linux-2.6.8.1-allocstack/kernel/exit.c linux-2.6.8.1-getthreadinfo/kernel/exit.c
--- linux-2.6.8.1-allocstack/kernel/exit.c	2004-08-29 02:42:32.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/kernel/exit.c	2004-08-29 01:35:15.000000000 +0200
@@ -832,7 +832,7 @@
 	if (tsk->signal->leader)
 		disassociate_ctty(1);
 
-	module_put(tsk->thread_info->exec_domain->module);
+	module_put(get_thread_info(tsk)->exec_domain->module);
 	if (tsk->binfmt)
 		module_put(tsk->binfmt->module);
 
diff -ur linux-2.6.8.1-allocstack/kernel/fork.c linux-2.6.8.1-getthreadinfo/kernel/fork.c
--- linux-2.6.8.1-allocstack/kernel/fork.c	2004-08-28 03:11:02.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/kernel/fork.c	2004-08-29 01:31:51.000000000 +0200
@@ -920,7 +920,7 @@
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 
-	if (!try_module_get(p->thread_info->exec_domain->module))
+	if (!try_module_get(get_thread_info(p)->exec_domain->module))
 		goto bad_fork_cleanup_count;
 
 	if (p->binfmt && !try_module_get(p->binfmt->module))
@@ -1130,7 +1130,7 @@
 	if (p->binfmt)
 		module_put(p->binfmt->module);
 bad_fork_cleanup_put_domain:
-	module_put(p->thread_info->exec_domain->module);
+	module_put(get_thread_info(p)->exec_domain->module);
 bad_fork_cleanup_count:
 	put_group_info(p->group_info);
 	atomic_dec(&p->user->processes);
diff -ur linux-2.6.8.1-allocstack/kernel/sched.c linux-2.6.8.1-getthreadinfo/kernel/sched.c
--- linux-2.6.8.1-allocstack/kernel/sched.c	2004-09-05 13:37:12.000000000 +0200
+++ linux-2.6.8.1-getthreadinfo/kernel/sched.c	2004-08-29 01:28:44.000000000 +0200
@@ -888,7 +888,7 @@
 	 * but it also can be p->switch_lock.) So we compensate with a count
 	 * of 1. Also, we want to start with kernel preemption disabled.
 	 */
-	p->thread_info->preempt_count = 1;
+	get_thread_info(p)->preempt_count = 1;
 #endif
 	/*
 	 * Share the timeslice between parent and child, thus the
@@ -3287,9 +3287,9 @@
 
 	/* Set the preempt count _outside_ the spinlocks! */
 #ifdef CONFIG_PREEMPT
-	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
+	get_thread_info(idle)->preempt_count = (idle->lock_depth >= 0);
 #else
-	idle->thread_info->preempt_count = 0;
+	get_thread_info(idle)->preempt_count = 0;
 #endif
 }
 
