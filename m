Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbVIAWA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbVIAWA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVIAWA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:00:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64135 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030435AbVIAWA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:00:27 -0400
Date: Fri, 2 Sep 2005 00:00:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 5/10] m68k: convert thread flags to use bit fields
Message-ID: <Pine.LNX.4.61.0509012359450.9799@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove task_work structure, use the standard thread flags functions and
use shifts in entry.S to test the thread flags. Add a few local labels
to entry.S to allow gas to generate short jumps.
Finally it changes a number of inline functions in thread_info.h to macros
to delay the current_thread_info() usage, which requires on m68k a structure
(task_struct) not yet defined at this point.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/fpsp040/skeleton.S   |    6 +--
 arch/m68k/ifpsp060/iskeleton.S |    6 +--
 arch/m68k/kernel/asm-offsets.c |    5 --
 arch/m68k/kernel/entry.S       |   78 ++++++++++++++++++++-------------------
 arch/m68k/kernel/ptrace.c      |   15 +++----
 include/asm-m68k/processor.h   |   12 ------
 include/asm-m68k/thread_info.h |   81 ++++-------------------------------------
 include/linux/thread_info.h    |   45 ++++++----------------
 8 files changed, 71 insertions(+), 177 deletions(-)

Index: linux-2.6-mm/arch/m68k/fpsp040/skeleton.S
===================================================================
--- linux-2.6-mm.orig/arch/m68k/fpsp040/skeleton.S	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68k/fpsp040/skeleton.S	2005-09-01 21:04:39.636108908 +0200
@@ -381,10 +381,8 @@ fpsp_done:
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
Index: linux-2.6-mm/arch/m68k/ifpsp060/iskeleton.S
===================================================================
--- linux-2.6-mm.orig/arch/m68k/ifpsp060/iskeleton.S	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68k/ifpsp060/iskeleton.S	2005-09-01 21:04:39.676102037 +0200
@@ -75,10 +75,8 @@ _060_isp_done:
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
Index: linux-2.6-mm/arch/m68k/kernel/asm-offsets.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/asm-offsets.c	2005-09-01 21:04:36.173703799 +0200
+++ linux-2.6-mm/arch/m68k/kernel/asm-offsets.c	2005-09-01 21:04:39.676102037 +0200
@@ -25,11 +25,6 @@ int main(void)
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
Index: linux-2.6-mm/arch/m68k/kernel/entry.S
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/entry.S	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/arch/m68k/kernel/entry.S	2005-09-01 21:04:39.695098773 +0200
@@ -44,9 +44,7 @@
 
 #include <asm/offsets.h>
 
-.globl system_call, buserr, trap
-.globl resume, ret_from_exception
-.globl ret_from_signal
+.globl system_call, buserr, trap, resume
 .globl inthandler, sys_call_table
 .globl sys_fork, sys_clone, sys_vfork
 .globl ret_from_interrupt, bad_interrupt
@@ -58,7 +56,7 @@ ENTRY(buserr)
 	movel	%sp,%sp@-		| stack frame pointer argument
 	bsrl	buserr_c
 	addql	#4,%sp
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
 ENTRY(trap)
 	SAVE_ALL_INT
@@ -66,7 +64,7 @@ ENTRY(trap)
 	movel	%sp,%sp@-		| stack frame pointer argument
 	bsrl	trap_c
 	addql	#4,%sp
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
 	| After a fork we jump here directly from resume,
 	| so that %d1 contains the previous task
@@ -75,30 +73,31 @@ ENTRY(ret_from_fork)
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
@@ -111,7 +110,7 @@ ret_from_signal:
 	addql	#4,%sp
 1:
 #endif
-	jra	ret_from_exception
+	jra	.Lret_from_exception
 
 ENTRY(system_call)
 	SAVE_ALL_SYS
@@ -120,30 +119,34 @@ ENTRY(system_call)
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
@@ -152,19 +155,18 @@ ret_from_exception:
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
@@ -254,7 +256,7 @@ ret_from_interrupt:
 
 	/* check if we need to do software interrupts */
 	tstl	irq_stat+CPUSTAT_SOFTIRQ_PENDING
-	jeq	ret_from_exception
+	jeq	.Lret_from_exception
 	pea	ret_from_exception
 	jra	do_softirq
 
Index: linux-2.6-mm/arch/m68k/kernel/ptrace.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/kernel/ptrace.c	2005-09-01 21:04:00.912762727 +0200
+++ linux-2.6-mm/arch/m68k/kernel/ptrace.c	2005-09-01 21:04:39.696098601 +0200
@@ -109,7 +109,7 @@ static inline void singlestep_disable(st
 {
 	unsigned long tmp = get_reg(child, PT_SR) & ~(TRACE_BITS << 16);
 	put_reg(child, PT_SR, tmp);
-	child->thread.work.delayed_trace = 0;
+	clear_tsk_thread_flag(child, TIF_DELAYED_TRACE);
 }
 
 /*
@@ -118,7 +118,7 @@ static inline void singlestep_disable(st
 void ptrace_disable(struct task_struct *child)
 {
 	singlestep_disable(child);
-	child->thread.work.syscall_trace = 0;
+	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
@@ -235,9 +235,9 @@ asmlinkage int sys_ptrace(long request, 
 			goto out_eio;
 
 		if (request == PTRACE_SYSCALL)
-			child->thread.work.syscall_trace = ~0;
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		else
-			child->thread.work.syscall_trace = 0;
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		child->exit_code = data;
 		singlestep_disable(child);
 		wake_up_process(child);
@@ -260,10 +260,10 @@ asmlinkage int sys_ptrace(long request, 
 		if (!valid_signal(data))
 			goto out_eio;
 
-		child->thread.work.syscall_trace = 0;
+		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		tmp = get_reg(child, PT_SR) | (TRACE_BITS << 16);
 		put_reg(child, PT_SR, tmp);
-		child->thread.work.delayed_trace = 1;
+		set_tsk_thread_flag(child, TIF_DELAYED_TRACE);
 
 		child->exit_code = data;
 		/* give it a chance to run. */
@@ -329,9 +329,6 @@ out_eio:
 
 asmlinkage void syscall_trace(void)
 {
-	if (!current->thread.work.delayed_trace &&
-	    !current->thread.work.syscall_trace)
-		return;
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
 				 ? 0x80 : 0));
 	/*
Index: linux-2.6-mm/include/asm-m68k/processor.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/processor.h	2005-09-01 21:04:36.184701909 +0200
+++ linux-2.6-mm/include/asm-m68k/processor.h	2005-09-01 21:04:39.696098601 +0200
@@ -56,17 +56,6 @@ static inline void wrusp(unsigned long u
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
@@ -79,7 +68,6 @@ struct thread_struct {
 	unsigned long  fp[8*3];
 	unsigned long  fpcntl[3];	/* fp control regs */
 	unsigned char  fpstate[FPSTATESIZE];  /* floating point state */
-	struct task_work work;
 	struct thread_info info;
 };
 
Index: linux-2.6-mm/include/asm-m68k/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/asm-m68k/thread_info.h	2005-09-01 21:04:36.216696412 +0200
+++ linux-2.6-mm/include/asm-m68k/thread_info.h	2005-09-01 21:04:39.711096024 +0200
@@ -6,12 +6,11 @@
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
+	unsigned long		flags;
 	struct exec_domain	*exec_domain;	/* execution domain */
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u32 cpu; /* should always be 0 on m68k */
 	struct restart_block    restart_block;
-
-	__u8			supervisor_stack[0];
 };
 
 #define PREEMPT_ACTIVE		0x4000000
@@ -49,76 +48,14 @@ struct thread_info {
 
 #define end_of_stack(p) ((unsigned long *)(p)->thread_info + 1)
 
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
-#define TIF_DELAYED_TRACE	1	/* single step a syscall */
-#define TIF_NOTIFY_RESUME	2	/* resumption notification requested */
-#define TIF_SIGPENDING		3	/* signal pending */
-#define TIF_NEED_RESCHED	4	/* rescheduling necessary */
-#define TIF_MEMDIE		5
-
-extern int thread_flag_fixme(void);
-
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
Index: linux-2.6-mm/include/linux/thread_info.h
===================================================================
--- linux-2.6-mm.orig/include/linux/thread_info.h	2005-09-01 13:21:50.000000000 +0200
+++ linux-2.6-mm/include/linux/thread_info.h	2005-09-01 21:04:39.711096024 +0200
@@ -27,31 +27,6 @@ extern long do_no_restart_syscall(struct
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
@@ -77,15 +52,19 @@ static inline int test_ti_thread_flag(st
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
 
