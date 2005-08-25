Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVHYFWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVHYFWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVHYFWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:22:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11468 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964831AbVHYFWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:22:21 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (21/22) task_thread_info - part 4/4
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AEw-0005f0-Rf@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:25:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

partially pulled from m68k CVS; switches m68k handling of thread flags to
usual bitmap, which allows to unify most of the thread flag helpers.  After
that only task_thread_info(), stack_end() and setup_thread_info() are
conditional on __HAVE_THREAD_FUNCTIONS.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-m68k/arch/m68k/fpsp040/skeleton.S RC13-rc7-m68k-flags/arch/m68k/fpsp040/skeleton.S
--- RC13-rc7-m68k/arch/m68k/fpsp040/skeleton.S	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-flags/arch/m68k/fpsp040/skeleton.S	2005-08-25 00:54:20.000000000 -0400
@@ -381,10 +381,8 @@
 .Lnotkern:
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
-	tstb	%curptr@(TASK_NEEDRESCHED)
-	jne	ret_from_exception	| deliver signals,
-					| reschedule etc..
-	RESTORE_ALL
+	| deliver signals, reschedule etc..
+	jra	ret_from_exception
 
 |
 |	mem_write --- write to user or supervisor address space
diff -urN RC13-rc7-m68k/arch/m68k/ifpsp060/iskeleton.S RC13-rc7-m68k-flags/arch/m68k/ifpsp060/iskeleton.S
--- RC13-rc7-m68k/arch/m68k/ifpsp060/iskeleton.S	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-flags/arch/m68k/ifpsp060/iskeleton.S	2005-08-25 00:54:20.000000000 -0400
@@ -75,10 +75,8 @@
 .Lnotkern:
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
-	tstb	%curptr@(TASK_NEEDRESCHED)
-	jne	ret_from_exception	| deliver signals,
-					| reschedule etc..
-	RESTORE_ALL
+	| deliver signals, reschedule etc..
+	jra	ret_from_exception
 
 |
 | _060_real_chk():
diff -urN RC13-rc7-m68k/arch/m68k/kernel/asm-offsets.c RC13-rc7-m68k-flags/arch/m68k/kernel/asm-offsets.c
--- RC13-rc7-m68k/arch/m68k/kernel/asm-offsets.c	2005-08-25 00:54:19.000000000 -0400
+++ RC13-rc7-m68k-flags/arch/m68k/kernel/asm-offsets.c	2005-08-25 00:54:20.000000000 -0400
@@ -25,11 +25,6 @@
 	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
-	DEFINE(TASK_WORK, offsetof(struct task_struct, thread.work));
-	DEFINE(TASK_NEEDRESCHED, offsetof(struct task_struct, thread.work.need_resched));
-	DEFINE(TASK_SYSCALL_TRACE, offsetof(struct task_struct, thread.work.syscall_trace));
-	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, thread.work.sigpending));
-	DEFINE(TASK_NOTIFY_RESUME, offsetof(struct task_struct, thread.work.notify_resume));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
 	DEFINE(TASK_INFO, offsetof(struct task_struct, thread.info));
 	DEFINE(TASK_MM, offsetof(struct task_struct, mm));
@@ -48,7 +43,7 @@
 
 	/* offsets into the thread_info struct */
 	DEFINE(TINFO_PREEMPT, offsetof(struct thread_info, preempt_count));
-	DEFINE(HARDIRQ_SHIFT, HARDIRQ_SHIFT);
+	DEFINE(TINFO_FLAGS, offsetof(struct thread_info, flags));
 
 	/* offsets into the pt_regs */
 	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
diff -urN RC13-rc7-m68k/arch/m68k/kernel/entry.S RC13-rc7-m68k-flags/arch/m68k/kernel/entry.S
--- RC13-rc7-m68k/arch/m68k/kernel/entry.S	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-flags/arch/m68k/kernel/entry.S	2005-08-25 00:54:20.000000000 -0400
@@ -44,9 +44,7 @@
 
 #include <asm/offsets.h>
 
-.globl system_call, buserr, trap
-.globl resume, ret_from_exception
-.globl ret_from_signal
+.globl system_call, buserr, trap, resume
 .globl inthandler, sys_call_table
 .globl sys_fork, sys_clone, sys_vfork
 .globl ret_from_interrupt, bad_interrupt
@@ -58,7 +56,7 @@
 	movel	%sp,%sp@-		| stack frame pointer argument
 	bsrl	buserr_c
 	addql	#4,%sp
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
 ENTRY(trap)
 	SAVE_ALL_INT
@@ -66,7 +64,7 @@
 	movel	%sp,%sp@-		| stack frame pointer argument
 	bsrl	trap_c
 	addql	#4,%sp
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
 	| After a fork we jump here directly from resume,
 	| so that %d1 contains the previous task
@@ -75,30 +73,31 @@
 	movel	%d1,%sp@-
 	jsr	schedule_tail
 	addql	#4,%sp
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
-badsys:
-	movel	#-ENOSYS,%sp@(PT_D0)
-	jra	ret_from_exception
-
-do_trace:
+do_trace_entry:
 	movel	#-ENOSYS,%sp@(PT_D0)	| needed for strace
 	subql	#4,%sp
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
-	movel	%sp@(PT_ORIG_D0),%d1
-	movel	#-ENOSYS,%d0
-	cmpl	#NR_syscalls,%d1
-	jcc	1f
-	jbsr	@(sys_call_table,%d1:l:4)@(0)
-1:	movel	%d0,%sp@(PT_D0)		| save the return value
-	subql	#4,%sp			| dummy return address
+	movel	%sp@(PT_ORIG_D0),%d0
+	cmpl	#NR_syscalls,%d0
+	jcs	syscall
+badsys:
+	movel	#-ENOSYS,%sp@(PT_D0)
+	jra	ret_from_syscall
+
+do_trace_exit:
+	subql	#4,%sp
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace
+	RESTORE_SWITCH_STACK
+	addql	#4,%sp
+	jra	.Lret_from_exception
 
-ret_from_signal:
+ENTRY(ret_from_signal)
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
 /* on 68040 complete pending writebacks if any */
@@ -111,7 +110,7 @@
 	addql	#4,%sp
 1:
 #endif
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
 ENTRY(system_call)
 	SAVE_ALL_SYS
@@ -120,30 +119,34 @@
 	| save top of frame
 	movel	%sp,%curptr@(TASK_THREAD+THREAD_ESP0)
 
-	tstb	%curptr@(TASK_SYSCALL_TRACE)
-	jne	do_trace
+	| syscall trace?
+	tstb	%curptr@(TASK_INFO+TINFO_FLAGS+2)
+	jmi	do_trace_entry
 	cmpl	#NR_syscalls,%d0
 	jcc	badsys
+syscall:
 	jbsr	@(sys_call_table,%d0:l:4)@(0)
 	movel	%d0,%sp@(PT_D0)		| save the return value
-
+ret_from_syscall:
 	|oriw	#0x0700,%sr
-	movel	%curptr@(TASK_WORK),%d0
+	movew	%curptr@(TASK_INFO+TINFO_FLAGS+2),%d0
 	jne	syscall_exit_work
 1:	RESTORE_ALL
 
 syscall_exit_work:
 	btst	#5,%sp@(PT_SR)		| check if returning to kernel
 	bnes	1b			| if so, skip resched, signals
-	tstw	%d0
-	jeq	do_signal_return
-	tstb	%d0
-	jne	do_delayed_trace
-
+	lslw	#1,%d0
+	jcs	do_trace_exit
+	jmi	do_delayed_trace
+	lslw	#8,%d0
+	jmi	do_signal_return
 	pea	resume_userspace
-	jmp	schedule
+	jra	schedule
+
 
-ret_from_exception:
+ENTRY(ret_from_exception)
+.Lret_from_exception:
 	btst	#5,%sp@(PT_SR)		| check if returning to kernel
 	bnes	1f			| if so, skip resched, signals
 	| only allow interrupts when we are really the last one on the
@@ -152,19 +155,18 @@
 	andw	#ALLOWINT,%sr
 
 resume_userspace:
-	movel	%curptr@(TASK_WORK),%d0
-	lsrl	#8,%d0
+	moveb	%curptr@(TASK_INFO+TINFO_FLAGS+3),%d0
 	jne	exit_work
 1:	RESTORE_ALL
 
 exit_work:
 	| save top of frame
 	movel	%sp,%curptr@(TASK_THREAD+THREAD_ESP0)
-	tstb	%d0
-	jeq	do_signal_return
-
+	lslb	#1,%d0
+	jmi	do_signal_return
 	pea	resume_userspace
-	jmp	schedule
+	jra	schedule
+
 
 do_signal_return:
 	|andw	#ALLOWINT,%sr
@@ -254,7 +256,7 @@
 
 	/* check if we need to do software interrupts */
 	tstl	irq_stat+CPUSTAT_SOFTIRQ_PENDING
-	jeq	ret_from_exception
+	jeq	.Lret_from_exception
 	pea	ret_from_exception
 	jra	do_softirq
 
diff -urN RC13-rc7-m68k/arch/m68k/kernel/ptrace.c RC13-rc7-m68k-flags/arch/m68k/kernel/ptrace.c
--- RC13-rc7-m68k/arch/m68k/kernel/ptrace.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-flags/arch/m68k/kernel/ptrace.c	2005-08-25 00:54:20.000000000 -0400
@@ -103,18 +103,22 @@
 }
 
 /*
- * Called by kernel/ptrace.c when detaching..
- *
  * Make sure the single step bit is not set.
  */
-void ptrace_disable(struct task_struct *child)
+static inline void singlestep_disable(struct task_struct *child)
 {
-	unsigned long tmp;
-	/* make sure the single step bit is not set. */
-	tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
+	unsigned long tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
 	put_reg(child, PT_SR, tmp);
-	child->thread.work.delayed_trace = 0;
-	child->thread.work.syscall_trace = 0;
+	clear_tsk_thread_flag(child, TIF_DELAYED_TRACE);
+}
+
+/*
+ * Called by kernel/ptrace.c when detaching..
+ */
+void ptrace_disable(struct task_struct *child)
+{
+	singlestep_disable(child);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
@@ -248,46 +252,33 @@
 			break;
 
 		case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-		case PTRACE_CONT: { /* restart after signal. */
-			long tmp;
-
+		case PTRACE_CONT: /* restart after signal. */
 			ret = -EIO;
 			if (!valid_signal(data))
 				break;
-			if (request == PTRACE_SYSCALL) {
-					child->thread.work.syscall_trace = ~0;
-			} else {
-					child->thread.work.syscall_trace = 0;
-			}
+			if (request == PTRACE_SYSCALL)
+				set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			else
+				clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			child->exit_code = data;
-			/* make sure the single step bit is not set. */
-			tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
-			put_reg(child, PT_SR, tmp);
-			child->thread.work.delayed_trace = 0;
+			singlestep_disable(child);
 			wake_up_process(child);
 			ret = 0;
 			break;
-		}
 
 /*
  * make the child exit.  Best I can do is send it a sigkill.
  * perhaps it should be put in the status that it wants to
  * exit.
  */
-		case PTRACE_KILL: {
-			long tmp;
-
+		case PTRACE_KILL:
 			ret = 0;
 			if (child->exit_state == EXIT_ZOMBIE) /* already dead */
 				break;
 			child->exit_code = SIGKILL;
-	/* make sure the single step bit is not set. */
-			tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
-			put_reg(child, PT_SR, tmp);
-			child->thread.work.delayed_trace = 0;
+			singlestep_disable(child);
 			wake_up_process(child);
 			break;
-		}
 
 		case PTRACE_SINGLESTEP: {  /* set the trap flag. */
 			long tmp;
@@ -295,10 +286,10 @@
 			ret = -EIO;
 			if (!valid_signal(data))
 				break;
-			child->thread.work.syscall_trace = 0;
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
 			put_reg(child, PT_SR, tmp);
-			child->thread.work.delayed_trace = 1;
+			set_tsk_thread_flag(child, TIF_DELAYED_TRACE);
 
 			child->exit_code = data;
 	/* give it a chance to run. */
@@ -377,9 +368,6 @@
 
 asmlinkage void syscall_trace(void)
 {
-	if (!current->thread.work.delayed_trace &&
-	    !current->thread.work.syscall_trace)
-		return;
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
 				 ? 0x80 : 0));
 	/*
diff -urN RC13-rc7-m68k/include/asm-m68k/processor.h RC13-rc7-m68k-flags/include/asm-m68k/processor.h
--- RC13-rc7-m68k/include/asm-m68k/processor.h	2005-08-25 00:54:19.000000000 -0400
+++ RC13-rc7-m68k-flags/include/asm-m68k/processor.h	2005-08-25 00:54:20.000000000 -0400
@@ -56,17 +56,6 @@
 #endif
 #define TASK_UNMAPPED_ALIGN(addr, off)	PAGE_ALIGN(addr)
 
-struct task_work {
-	unsigned char sigpending;
-	unsigned char notify_resume;	/* request for notification on
-					   userspace execution resumption */
-	char          need_resched;
-	unsigned char delayed_trace;	/* single step a syscall */
-	unsigned char syscall_trace;	/* count of syscall interceptors */
-	unsigned char memdie;		/* task was selected to be killed */
-	unsigned char pad[2];
-};
-
 struct thread_struct {
 	unsigned long  ksp;		/* kernel stack pointer */
 	unsigned long  usp;		/* user stack pointer */
@@ -79,7 +68,6 @@
 	unsigned long  fp[8*3];
 	unsigned long  fpcntl[3];	/* fp control regs */
 	unsigned char  fpstate[FPSTATESIZE];  /* floating point state */
-	struct task_work work;
 	struct thread_info info;
 };
 
diff -urN RC13-rc7-m68k/include/asm-m68k/thread_info.h RC13-rc7-m68k-flags/include/asm-m68k/thread_info.h
--- RC13-rc7-m68k/include/asm-m68k/thread_info.h	2005-08-25 00:54:19.000000000 -0400
+++ RC13-rc7-m68k-flags/include/asm-m68k/thread_info.h	2005-08-25 00:54:20.000000000 -0400
@@ -6,6 +6,7 @@
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
+	unsigned long		flags;
 	struct exec_domain	*exec_domain;	/* execution domain */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u32 cpu; /* should always be 0 on m68k */
@@ -42,80 +43,18 @@
 
 #define __HAVE_THREAD_FUNCTIONS
 
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
-#define TIF_DELAYED_TRACE	1	/* single step a syscall */
-#define TIF_NOTIFY_RESUME	2	/* resumption notification requested */
-#define TIF_SIGPENDING		3	/* signal pending */
-#define TIF_NEED_RESCHED	4	/* rescheduling necessary */
-#define TIF_MEMDIE		5
-
-extern int thread_flag_fixme(void);
-
 #define setup_thread_info(p, ti) do (ti)->task = p; while(0)
 
 #define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
 
-/*
- * flag set/clear/test wrappers
- * - pass TIF_xxxx constants to these functions
+/* entry.S relies on these definitions!
+ * bits 0-7 are tested at every exception exit
+ * bits 8-15 are also tested at syscall exit
  */
-
-#define __set_tsk_thread_flag(tsk, flag, val) ({	\
-	switch (flag) {					\
-	case TIF_SIGPENDING:				\
-		tsk->thread.work.sigpending = val;	\
-		break;					\
-	case TIF_NEED_RESCHED:				\
-		tsk->thread.work.need_resched = val;	\
-		break;					\
-	case TIF_SYSCALL_TRACE:				\
-		tsk->thread.work.syscall_trace = val;	\
-		break;					\
-	case TIF_MEMDIE:				\
-		tsk->thread.work.memdie = val;		\
-		break;					\
-	default:					\
-		thread_flag_fixme();			\
-	}						\
-})
-
-#define __get_tsk_thread_flag(tsk, flag) ({		\
-	int ___res;					\
-	switch (flag) {					\
-	case TIF_SIGPENDING:				\
-		___res = tsk->thread.work.sigpending;	\
-		break;					\
-	case TIF_NEED_RESCHED:				\
-		___res = tsk->thread.work.need_resched;	\
-		break;					\
-	case TIF_SYSCALL_TRACE:				\
-		___res = tsk->thread.work.syscall_trace;\
-		break;					\
-	case TIF_MEMDIE:				\
-		___res = tsk->thread.work.memdie;\
-		break;					\
-	default:					\
-		___res = thread_flag_fixme();		\
-	}						\
-	___res;						\
-})
-
-#define __get_set_tsk_thread_flag(tsk, flag, val) ({	\
-	int __res = __get_tsk_thread_flag(tsk, flag);	\
-	__set_tsk_thread_flag(tsk, flag, val);		\
-	__res;						\
-})
-
-#define set_tsk_thread_flag(tsk, flag) __set_tsk_thread_flag(tsk, flag, ~0)
-#define clear_tsk_thread_flag(tsk, flag) __set_tsk_thread_flag(tsk, flag, 0)
-#define test_and_set_tsk_thread_flag(tsk, flag) __get_set_tsk_thread_flag(tsk, flag, ~0)
-#define test_tsk_thread_flag(tsk, flag) __get_tsk_thread_flag(tsk, flag)
-
-#define set_thread_flag(flag) set_tsk_thread_flag(current, flag)
-#define clear_thread_flag(flag) clear_tsk_thread_flag(current, flag)
-#define test_thread_flag(flag) test_tsk_thread_flag(current, flag)
-
-#define set_need_resched() set_thread_flag(TIF_NEED_RESCHED)
-#define clear_need_resched() clear_thread_flag(TIF_NEED_RESCHED)
+#define TIF_SIGPENDING		6	/* signal pending */
+#define TIF_NEED_RESCHED	7	/* rescheduling necessary */
+#define TIF_DELAYED_TRACE	14	/* single step a syscall */
+#define TIF_SYSCALL_TRACE	15	/* syscall trace active */
+#define TIF_MEMDIE		16
 
 #endif	/* _ASM_M68K_THREAD_INFO_H */
diff -urN RC13-rc7-m68k/include/linux/sched.h RC13-rc7-m68k-flags/include/linux/sched.h
--- RC13-rc7-m68k/include/linux/sched.h	2005-08-25 00:54:18.000000000 -0400
+++ RC13-rc7-m68k-flags/include/linux/sched.h	2005-08-25 00:54:20.000000000 -0400
@@ -1150,6 +1150,8 @@
 	return (unsigned long *)(p->thread_info + 1);
 }
 
+#endif
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
@@ -1178,8 +1180,6 @@
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-#endif
-
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
diff -urN RC13-rc7-m68k/include/linux/thread_info.h RC13-rc7-m68k-flags/include/linux/thread_info.h
--- RC13-rc7-m68k/include/linux/thread_info.h	2005-08-25 00:54:18.000000000 -0400
+++ RC13-rc7-m68k-flags/include/linux/thread_info.h	2005-08-25 00:54:20.000000000 -0400
@@ -22,37 +22,11 @@
 
 #ifdef __KERNEL__
 
-#ifndef __HAVE_THREAD_FUNCTIONS
 /*
  * flag set/clear/test wrappers
  * - pass TIF_xxxx constants to these functions
  */
 
-static inline void set_thread_flag(int flag)
-{
-	set_bit(flag,&current_thread_info()->flags);
-}
-
-static inline void clear_thread_flag(int flag)
-{
-	clear_bit(flag,&current_thread_info()->flags);
-}
-
-static inline int test_and_set_thread_flag(int flag)
-{
-	return test_and_set_bit(flag,&current_thread_info()->flags);
-}
-
-static inline int test_and_clear_thread_flag(int flag)
-{
-	return test_and_clear_bit(flag,&current_thread_info()->flags);
-}
-
-static inline int test_thread_flag(int flag)
-{
-	return test_bit(flag,&current_thread_info()->flags);
-}
-
 static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
 {
 	set_bit(flag,&ti->flags);
@@ -78,17 +52,20 @@
 	return test_bit(flag,&ti->flags);
 }
 
-static inline void set_need_resched(void)
-{
-	set_thread_flag(TIF_NEED_RESCHED);
-}
+#define set_thread_flag(flag) \
+	set_ti_thread_flag(current_thread_info(), flag)
+#define clear_thread_flag(flag) \
+	clear_ti_thread_flag(current_thread_info(), flag)
+#define test_and_set_thread_flag(flag) \
+	test_and_set_ti_thread_flag(current_thread_info(), flag)
+#define test_and_clear_thread_flag(flag) \
+	test_and_clear_ti_thread_flag(current_thread_info(), flag)
+#define test_thread_flag(flag) \
+	test_ti_thread_flag(current_thread_info(), flag)
 
-static inline void clear_need_resched(void)
-{
-	clear_thread_flag(TIF_NEED_RESCHED);
-}
+#define set_need_resched()	set_thread_flag(TIF_NEED_RESCHED)
+#define clear_need_resched()	clear_thread_flag(TIF_NEED_RESCHED)
 
 #endif
-#endif
 
 #endif /* _LINUX_THREAD_INFO_H */
