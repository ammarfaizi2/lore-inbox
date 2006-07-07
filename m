Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWGGAg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWGGAg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWGGAge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:36:34 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:59843 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751128AbWGGAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:19 -0400
Message-Id: <200607070033.k670XoUA008732@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 15/19] UML - Move _kern.c files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move most *_kern.c files in arch/um/kernel to *.c.  This makes UML somewhat
more closely resemble the other arches.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/exec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17/arch/um/kernel/exec.c	2006-07-06 13:29:14.000000000 -0400
@@ -0,0 +1,86 @@
+/*
+ * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/slab.h"
+#include "linux/smp_lock.h"
+#include "linux/ptrace.h"
+#include "asm/ptrace.h"
+#include "asm/pgtable.h"
+#include "asm/tlbflush.h"
+#include "asm/uaccess.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "mem_user.h"
+#include "kern.h"
+#include "irq_user.h"
+#include "tlb.h"
+#include "os.h"
+#include "choose-mode.h"
+#include "mode_kern.h"
+
+void flush_thread(void)
+{
+	arch_flush_thread(&current->thread.arch);
+	CHOOSE_MODE(flush_thread_tt(), flush_thread_skas());
+}
+
+void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
+{
+	CHOOSE_MODE_PROC(start_thread_tt, start_thread_skas, regs, eip, esp);
+}
+
+#ifdef CONFIG_TTY_LOG
+extern void log_exec(char **argv, void *tty);
+#endif
+
+static long execve1(char *file, char __user * __user *argv,
+		    char __user *__user *env)
+{
+        long error;
+
+#ifdef CONFIG_TTY_LOG
+	task_lock(current);
+	log_exec(argv, current->signal->tty);
+	task_unlock(current);
+#endif
+        error = do_execve(file, argv, env, &current->thread.regs);
+        if (error == 0){
+		task_lock(current);
+                current->ptrace &= ~PT_DTRACE;
+#ifdef SUBARCH_EXECVE1
+		SUBARCH_EXECVE1(&current->thread.regs.regs);
+#endif
+		task_unlock(current);
+                set_cmdline(current_cmd());
+        }
+        return(error);
+}
+
+long um_execve(char *file, char __user *__user *argv, char __user *__user *env)
+{
+	long err;
+
+	err = execve1(file, argv, env);
+	if(!err)
+		do_longjmp(current->thread.exec_buf, 1);
+	return(err);
+}
+
+long sys_execve(char __user *file, char __user *__user *argv,
+		char __user *__user *env)
+{
+	long error;
+	char *filename;
+
+	lock_kernel();
+	filename = getname(file);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename)) goto out;
+	error = execve1(filename, argv, env);
+	putname(filename);
+ out:
+	unlock_kernel();
+	return(error);
+}
Index: linux-2.6.17/arch/um/kernel/sigio.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17/arch/um/kernel/sigio.c	2006-07-06 13:29:14.000000000 -0400
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/kernel.h"
+#include "linux/list.h"
+#include "linux/slab.h"
+#include "linux/signal.h"
+#include "linux/interrupt.h"
+#include "init.h"
+#include "sigio.h"
+#include "irq_user.h"
+#include "irq_kern.h"
+#include "os.h"
+
+/* Protected by sigio_lock() called from write_sigio_workaround */
+static int sigio_irq_fd = -1;
+
+static irqreturn_t sigio_interrupt(int irq, void *data, struct pt_regs *unused)
+{
+	char c;
+
+	os_read_file(sigio_irq_fd, &c, sizeof(c));
+	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
+	return(IRQ_HANDLED);
+}
+
+int write_sigio_irq(int fd)
+{
+	int err;
+
+	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
+			     SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio",
+			     NULL);
+	if(err){
+		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
+		       err);
+		return(-1);
+	}
+	sigio_irq_fd = fd;
+	return(0);
+}
+
+static DEFINE_SPINLOCK(sigio_spinlock);
+
+void sigio_lock(void)
+{
+	spin_lock(&sigio_spinlock);
+}
+
+void sigio_unlock(void)
+{
+	spin_unlock(&sigio_spinlock);
+}
Index: linux-2.6.17/arch/um/kernel/signal.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17/arch/um/kernel/signal.c	2006-07-06 13:29:14.000000000 -0400
@@ -0,0 +1,191 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/config.h"
+#include "linux/stddef.h"
+#include "linux/sys.h"
+#include "linux/sched.h"
+#include "linux/wait.h"
+#include "linux/kernel.h"
+#include "linux/smp_lock.h"
+#include "linux/module.h"
+#include "linux/slab.h"
+#include "linux/tty.h"
+#include "linux/binfmts.h"
+#include "linux/ptrace.h"
+#include "asm/signal.h"
+#include "asm/uaccess.h"
+#include "asm/unistd.h"
+#include "user_util.h"
+#include "asm/ucontext.h"
+#include "kern_util.h"
+#include "signal_kern.h"
+#include "kern.h"
+#include "frame_kern.h"
+#include "sigcontext.h"
+#include "mode.h"
+
+EXPORT_SYMBOL(block_signals);
+EXPORT_SYMBOL(unblock_signals);
+
+#define _S(nr) (1<<((nr)-1))
+
+#define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
+
+/*
+ * OK, we're invoking a handler
+ */
+static int handle_signal(struct pt_regs *regs, unsigned long signr,
+			 struct k_sigaction *ka, siginfo_t *info,
+			 sigset_t *oldset)
+{
+	unsigned long sp;
+	int err;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
+	/* Did we come from a system call? */
+	if(PT_REGS_SYSCALL_NR(regs) >= 0){
+		/* If so, check system call restarting.. */
+		switch(PT_REGS_SYSCALL_RET(regs)){
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			PT_REGS_SYSCALL_RET(regs) = -EINTR;
+			break;
+
+		case -ERESTARTSYS:
+			if (!(ka->sa.sa_flags & SA_RESTART)) {
+				PT_REGS_SYSCALL_RET(regs) = -EINTR;
+				break;
+			}
+		/* fallthrough */
+		case -ERESTARTNOINTR:
+			PT_REGS_RESTART_SYSCALL(regs);
+			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
+			break;
+		}
+	}
+
+	sp = PT_REGS_SP(regs);
+	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
+		sp = current->sas_ss_sp + current->sas_ss_size;
+
+#ifdef CONFIG_ARCH_HAS_SC_SIGNALS
+	if(!(ka->sa.sa_flags & SA_SIGINFO))
+		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
+	else
+#endif
+		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
+
+	if(err){
+		spin_lock_irq(&current->sighand->siglock);
+		current->blocked = *oldset;
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+		force_sigsegv(signr, current);
+	} else {
+		spin_lock_irq(&current->sighand->siglock);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka->sa.sa_mask);
+		 if(!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked, signr);
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+
+	return err;
+}
+
+static int kern_do_signal(struct pt_regs *regs)
+{
+	struct k_sigaction ka_copy;
+	siginfo_t info;
+	sigset_t *oldset;
+	int sig, handled_sig = 0;
+
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
+		oldset = &current->blocked;
+
+	while((sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL)) > 0){
+		handled_sig = 1;
+		/* Whee!  Actually deliver the signal.  */
+		if(!handle_signal(regs, sig, &ka_copy, &info, oldset)){
+			/* a signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag */
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
+			break;
+		}
+	}
+
+	/* Did we come from a system call? */
+	if(!handled_sig && (PT_REGS_SYSCALL_NR(regs) >= 0)){
+		/* Restart the system call - no handlers present */
+		switch(PT_REGS_SYSCALL_RET(regs)){
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
+			PT_REGS_RESTART_SYSCALL(regs);
+			break;
+		case -ERESTART_RESTARTBLOCK:
+			PT_REGS_ORIG_SYSCALL(regs) = __NR_restart_syscall;
+			PT_REGS_RESTART_SYSCALL(regs);
+			break;
+ 		}
+	}
+
+	/* This closes a way to execute a system call on the host.  If
+	 * you set a breakpoint on a system call instruction and singlestep
+	 * from it, the tracing thread used to PTRACE_SINGLESTEP the process
+	 * rather than PTRACE_SYSCALL it, allowing the system call to execute
+	 * on the host.  The tracing thread will check this flag and
+	 * PTRACE_SYSCALL if necessary.
+	 */
+	if(current->ptrace & PT_DTRACE)
+		current->thread.singlestep_syscall =
+			is_syscall(PT_REGS_IP(&current->thread.regs));
+
+	/* if there's no signal to deliver, we just put the saved sigmask
+	 * back */
+	if (!handled_sig && test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
+	return(handled_sig);
+}
+
+int do_signal(void)
+{
+	return(kern_do_signal(&current->thread.regs));
+}
+
+/*
+ * Atomically swap in the new signal mask, and wait for a signal.
+ */
+long sys_sigsuspend(int history0, int history1, old_sigset_t mask)
+{
+	mask &= _BLOCKABLE;
+	spin_lock_irq(&current->sighand->siglock);
+	current->saved_sigmask = current->blocked;
+	siginitset(&current->blocked, mask);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
+}
+
+long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
+{
+	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
+}
Index: linux-2.6.17/arch/um/kernel/time.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17/arch/um/kernel/time.c	2006-07-06 13:29:14.000000000 -0400
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/kernel.h"
+#include "linux/module.h"
+#include "linux/unistd.h"
+#include "linux/stddef.h"
+#include "linux/spinlock.h"
+#include "linux/time.h"
+#include "linux/sched.h"
+#include "linux/interrupt.h"
+#include "linux/init.h"
+#include "linux/delay.h"
+#include "linux/hrtimer.h"
+#include "asm/irq.h"
+#include "asm/param.h"
+#include "asm/current.h"
+#include "kern_util.h"
+#include "user_util.h"
+#include "mode.h"
+#include "os.h"
+
+int hz(void)
+{
+	return(HZ);
+}
+
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
+}
+
+/* Changed at early boot */
+int timer_irq_inited = 0;
+
+static unsigned long long prev_nsecs;
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
+static long long delta;   		/* Deviation per interval */
+#endif
+
+void timer_irq(union uml_pt_regs *regs)
+{
+	unsigned long long ticks = 0;
+
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
+	if(prev_nsecs){
+		/* We've had 1 tick */
+		unsigned long long nsecs = os_nsecs();
+
+		delta += nsecs - prev_nsecs;
+		prev_nsecs = nsecs;
+
+		/* Protect against the host clock being set backwards */
+		if(delta < 0)
+			delta = 0;
+
+		ticks += (delta * HZ) / BILLION;
+		delta -= (ticks * BILLION) / HZ;
+	}
+	else prev_nsecs = os_nsecs();
+#else
+	ticks = 1;
+#endif
+	while(ticks > 0){
+		do_IRQ(TIMER_IRQ, regs);
+		ticks--;
+	}
+}
+
+static DEFINE_SPINLOCK(timer_spinlock);
+
+static unsigned long long local_offset = 0;
+
+static inline unsigned long long get_time(void)
+{
+	unsigned long long nsecs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_spinlock, flags);
+	nsecs = os_nsecs();
+	nsecs += local_offset;
+	spin_unlock_irqrestore(&timer_spinlock, flags);
+
+	return nsecs;
+}
+
+irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
+{
+	unsigned long long nsecs;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+
+	do_timer(regs);
+
+	nsecs = get_time() + local_offset;
+	xtime.tv_sec = nsecs / NSEC_PER_SEC;
+	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
+
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void register_timer(void)
+{
+	int err;
+
+	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);
+	if(err != 0)
+		printk(KERN_ERR "timer_init : request_irq failed - "
+		       "errno = %d\n", -err);
+
+	timer_irq_inited = 1;
+
+	user_time_init();
+}
+
+extern void (*late_time_init)(void);
+
+void time_init(void)
+{
+	long long nsecs;
+
+	nsecs = os_nsecs();
+	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
+				-nsecs % BILLION);
+	late_time_init = register_timer;
+}
+
+void do_gettimeofday(struct timeval *tv)
+{
+	unsigned long long nsecs = get_time();
+
+	tv->tv_sec = nsecs / NSEC_PER_SEC;
+	/* Careful about calculations here - this was originally done as
+	 * (nsecs - tv->tv_sec * NSEC_PER_SEC) / NSEC_PER_USEC
+	 * which gave bogus (> 1000000) values.  Dunno why, suspect gcc
+	 * (4.0.0) miscompiled it, or there's a subtle 64/32-bit conversion
+	 * problem that I missed.
+	 */
+	nsecs -= tv->tv_sec * NSEC_PER_SEC;
+	tv->tv_usec = (unsigned long) nsecs / NSEC_PER_USEC;
+}
+
+static inline void set_time(unsigned long long nsecs)
+{
+	unsigned long long now;
+	unsigned long flags;
+
+	spin_lock_irqsave(&timer_spinlock, flags);
+	now = os_nsecs();
+	local_offset = nsecs - now;
+	spin_unlock_irqrestore(&timer_spinlock, flags);
+
+	clock_was_set();
+}
+
+int do_settimeofday(struct timespec *tv)
+{
+	set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
+
+	return 0;
+}
+
+void timer_handler(int sig, union uml_pt_regs *regs)
+{
+	local_irq_disable();
+	irq_enter();
+	update_process_times(CHOOSE_MODE(
+	                     (UPT_SC(regs) && user_context(UPT_SP(regs))),
+			     (regs)->skas.is_user));
+	irq_exit();
+	local_irq_enable();
+	if(current_thread->cpu == 0)
+		timer_irq(regs);
+}
Index: linux-2.6.17/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/time_kern.c	2006-07-06 13:27:40.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,182 +0,0 @@
-/*
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/kernel.h"
-#include "linux/module.h"
-#include "linux/unistd.h"
-#include "linux/stddef.h"
-#include "linux/spinlock.h"
-#include "linux/time.h"
-#include "linux/sched.h"
-#include "linux/interrupt.h"
-#include "linux/init.h"
-#include "linux/delay.h"
-#include "linux/hrtimer.h"
-#include "asm/irq.h"
-#include "asm/param.h"
-#include "asm/current.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "mode.h"
-#include "os.h"
-
-int hz(void)
-{
-	return(HZ);
-}
-
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
-}
-
-/* Changed at early boot */
-int timer_irq_inited = 0;
-
-static unsigned long long prev_nsecs;
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
-static long long delta;   		/* Deviation per interval */
-#endif
-
-void timer_irq(union uml_pt_regs *regs)
-{
-	unsigned long long ticks = 0;
-
-#ifdef CONFIG_UML_REAL_TIME_CLOCK
-	if(prev_nsecs){
-		/* We've had 1 tick */
-		unsigned long long nsecs = os_nsecs();
-
-		delta += nsecs - prev_nsecs;
-		prev_nsecs = nsecs;
-
-		/* Protect against the host clock being set backwards */
-		if(delta < 0)
-			delta = 0;
-
-		ticks += (delta * HZ) / BILLION;
-		delta -= (ticks * BILLION) / HZ;
-	}
-	else prev_nsecs = os_nsecs();
-#else
-	ticks = 1;
-#endif
-	while(ticks > 0){
-		do_IRQ(TIMER_IRQ, regs);
-		ticks--;
-	}
-}
-
-static DEFINE_SPINLOCK(timer_spinlock);
-
-static unsigned long long local_offset = 0;
-
-static inline unsigned long long get_time(void)
-{
-	unsigned long long nsecs;
-	unsigned long flags;
-
-	spin_lock_irqsave(&timer_spinlock, flags);
-	nsecs = os_nsecs();
-	nsecs += local_offset;
-	spin_unlock_irqrestore(&timer_spinlock, flags);
-
-	return nsecs;
-}
-
-irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
-{
-	unsigned long long nsecs;
-	unsigned long flags;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-
-	do_timer(regs);
-
-	nsecs = get_time() + local_offset;
-	xtime.tv_sec = nsecs / NSEC_PER_SEC;
-	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
-
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	return IRQ_HANDLED;
-}
-
-static void register_timer(void)
-{
-	int err;
-
-	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);
-	if(err != 0)
-		printk(KERN_ERR "timer_init : request_irq failed - "
-		       "errno = %d\n", -err);
-
-	timer_irq_inited = 1;
-
-	user_time_init();
-}
-
-extern void (*late_time_init)(void);
-
-void time_init(void)
-{
-	long long nsecs;
-
-	nsecs = os_nsecs();
-	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
-				-nsecs % BILLION);
-	late_time_init = register_timer;
-}
-
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long long nsecs = get_time();
-
-	tv->tv_sec = nsecs / NSEC_PER_SEC;
-	/* Careful about calculations here - this was originally done as
-	 * (nsecs - tv->tv_sec * NSEC_PER_SEC) / NSEC_PER_USEC
-	 * which gave bogus (> 1000000) values.  Dunno why, suspect gcc
-	 * (4.0.0) miscompiled it, or there's a subtle 64/32-bit conversion
-	 * problem that I missed.
-	 */
-	nsecs -= tv->tv_sec * NSEC_PER_SEC;
-	tv->tv_usec = (unsigned long) nsecs / NSEC_PER_USEC;
-}
-
-static inline void set_time(unsigned long long nsecs)
-{
-	unsigned long long now;
-	unsigned long flags;
-
-	spin_lock_irqsave(&timer_spinlock, flags);
-	now = os_nsecs();
-	local_offset = nsecs - now;
-	spin_unlock_irqrestore(&timer_spinlock, flags);
-
-	clock_was_set();
-}
-
-int do_settimeofday(struct timespec *tv)
-{
-	set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
-
-	return 0;
-}
-
-void timer_handler(int sig, union uml_pt_regs *regs)
-{
-	local_irq_disable();
-	irq_enter();
-	update_process_times(CHOOSE_MODE(
-	                     (UPT_SC(regs) && user_context(UPT_SP(regs))),
-			     (regs)->skas.is_user));
-	irq_exit();
-	local_irq_enable();
-	if(current_thread->cpu == 0)
-		timer_irq(regs);
-}
Index: linux-2.6.17/arch/um/kernel/trap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17/arch/um/kernel/trap.c	2006-07-06 13:29:14.000000000 -0400
@@ -0,0 +1,251 @@
+/*
+ * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/kernel.h"
+#include "asm/errno.h"
+#include "linux/sched.h"
+#include "linux/mm.h"
+#include "linux/spinlock.h"
+#include "linux/config.h"
+#include "linux/init.h"
+#include "linux/ptrace.h"
+#include "asm/semaphore.h"
+#include "asm/pgtable.h"
+#include "asm/pgalloc.h"
+#include "asm/tlbflush.h"
+#include "asm/a.out.h"
+#include "asm/current.h"
+#include "asm/irq.h"
+#include "sysdep/sigcontext.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "kern.h"
+#include "chan_kern.h"
+#include "mconsole_kern.h"
+#include "mem.h"
+#include "mem_kern.h"
+#include "sysdep/sigcontext.h"
+#include "sysdep/ptrace.h"
+#include "os.h"
+#ifdef CONFIG_MODE_SKAS
+#include "skas.h"
+#endif
+#include "os.h"
+
+/* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
+int handle_page_fault(unsigned long address, unsigned long ip,
+		      int is_write, int is_user, int *code_out)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int err = -EFAULT;
+
+	*code_out = SEGV_MAPERR;
+
+	/* If the fault was during atomic operation, don't take the fault, just
+	 * fail. */
+	if (in_atomic())
+		goto out_nosemaphore;
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, address);
+	if(!vma)
+		goto out;
+	else if(vma->vm_start <= address)
+		goto good_area;
+	else if(!(vma->vm_flags & VM_GROWSDOWN))
+		goto out;
+	else if(is_user && !ARCH_IS_STACKGROW(address))
+		goto out;
+	else if(expand_stack(vma, address))
+		goto out;
+
+good_area:
+	*code_out = SEGV_ACCERR;
+	if(is_write && !(vma->vm_flags & VM_WRITE))
+		goto out;
+
+	/* Don't require VM_READ|VM_EXEC for write faults! */
+        if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
+                goto out;
+
+	do {
+survive:
+		switch (handle_mm_fault(mm, vma, address, is_write)){
+		case VM_FAULT_MINOR:
+			current->min_flt++;
+			break;
+		case VM_FAULT_MAJOR:
+			current->maj_flt++;
+			break;
+		case VM_FAULT_SIGBUS:
+			err = -EACCES;
+			goto out;
+		case VM_FAULT_OOM:
+			err = -ENOMEM;
+			goto out_of_memory;
+		default:
+			BUG();
+		}
+		pgd = pgd_offset(mm, address);
+		pud = pud_offset(pgd, address);
+		pmd = pmd_offset(pud, address);
+		pte = pte_offset_kernel(pmd, address);
+	} while(!pte_present(*pte));
+	err = 0;
+	/* The below warning was added in place of
+	 *	pte_mkyoung(); if (is_write) pte_mkdirty();
+	 * If it's triggered, we'd see normally a hang here (a clean pte is
+	 * marked read-only to emulate the dirty bit).
+	 * However, the generic code can mark a PTE writable but clean on a
+	 * concurrent read fault, triggering this harmlessly. So comment it out.
+	 */
+#if 0
+	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
+#endif
+	flush_tlb_page(vma, address);
+out:
+	up_read(&mm->mmap_sem);
+out_nosemaphore:
+	return(err);
+
+/*
+ * We ran out of memory, or some other thing happened to us that made
+ * us unable to handle the page fault gracefully.
+ */
+out_of_memory:
+	if (current->pid == 1) {
+		up_read(&mm->mmap_sem);
+		yield();
+		down_read(&mm->mmap_sem);
+		goto survive;
+	}
+	goto out;
+}
+
+void segv_handler(int sig, union uml_pt_regs *regs)
+{
+	struct faultinfo * fi = UPT_FAULTINFO(regs);
+
+	if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
+		bad_segv(*fi, UPT_IP(regs));
+		return;
+	}
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
+}
+
+struct kern_handlers handlinfo_kern = {
+	.relay_signal = relay_signal,
+	.winch = winch,
+	.bus_handler = relay_signal,
+	.page_fault = segv_handler,
+	.sigio_handler = sigio_handler,
+	.timer_handler = timer_handler
+};
+/*
+ * We give a *copy* of the faultinfo in the regs to segv.
+ * This must be done, since nesting SEGVs could overwrite
+ * the info in the regs. A pointer to the info then would
+ * give us bad data!
+ */
+unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user, void *sc)
+{
+	struct siginfo si;
+	void *catcher;
+	int err;
+        int is_write = FAULT_WRITE(fi);
+        unsigned long address = FAULT_ADDRESS(fi);
+
+        if(!is_user && (address >= start_vm) && (address < end_vm)){
+                flush_tlb_kernel_vm();
+                return(0);
+        }
+	else if(current->mm == NULL)
+		panic("Segfault with no mm");
+
+	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
+		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
+	else {
+		err = -EFAULT;
+		/* A thread accessed NULL, we get a fault, but CR2 is invalid.
+		 * This code is used in __do_copy_from_user() of TT mode. */
+		address = 0;
+	}
+
+	catcher = current->thread.fault_catcher;
+	if(!err)
+		return(0);
+	else if(catcher != NULL){
+		current->thread.fault_addr = (void *) address;
+		do_longjmp(catcher, 1);
+	}
+	else if(current->thread.fault_addr != NULL)
+		panic("fault_addr set but no fault catcher");
+        else if(!is_user && arch_fixup(ip, sc))
+		return(0);
+
+ 	if(!is_user)
+		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
+		      address, ip);
+
+	if (err == -EACCES) {
+		si.si_signo = SIGBUS;
+		si.si_errno = 0;
+		si.si_code = BUS_ADRERR;
+		si.si_addr = (void __user *)address;
+                current->thread.arch.faultinfo = fi;
+		force_sig_info(SIGBUS, &si, current);
+	} else if (err == -ENOMEM) {
+		printk("VM: killing process %s\n", current->comm);
+		do_exit(SIGKILL);
+	} else {
+		BUG_ON(err != -EFAULT);
+		si.si_signo = SIGSEGV;
+		si.si_addr = (void __user *) address;
+                current->thread.arch.faultinfo = fi;
+		force_sig_info(SIGSEGV, &si, current);
+	}
+	return(0);
+}
+
+void bad_segv(struct faultinfo fi, unsigned long ip)
+{
+	struct siginfo si;
+
+	si.si_signo = SIGSEGV;
+	si.si_code = SEGV_ACCERR;
+	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
+	current->thread.arch.faultinfo = fi;
+	force_sig_info(SIGSEGV, &si, current);
+}
+
+void relay_signal(int sig, union uml_pt_regs *regs)
+{
+	if(arch_handle_signal(sig, regs)) return;
+	if(!UPT_IS_USER(regs))
+		panic("Kernel mode signal %d", sig);
+        current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
+	force_sig(sig, current);
+}
+
+void bus_handler(int sig, union uml_pt_regs *regs)
+{
+	if(current->thread.fault_catcher != NULL)
+		do_longjmp(current->thread.fault_catcher, 1);
+	else relay_signal(sig, regs);
+}
+
+void winch(int sig, union uml_pt_regs *regs)
+{
+	do_IRQ(WINCH_IRQ, regs);
+}
+
+void trap_init(void)
+{
+}
Index: linux-2.6.17/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/trap_kern.c	2006-06-20 17:24:29.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,251 +0,0 @@
-/*
- * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/kernel.h"
-#include "asm/errno.h"
-#include "linux/sched.h"
-#include "linux/mm.h"
-#include "linux/spinlock.h"
-#include "linux/config.h"
-#include "linux/init.h"
-#include "linux/ptrace.h"
-#include "asm/semaphore.h"
-#include "asm/pgtable.h"
-#include "asm/pgalloc.h"
-#include "asm/tlbflush.h"
-#include "asm/a.out.h"
-#include "asm/current.h"
-#include "asm/irq.h"
-#include "sysdep/sigcontext.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "kern.h"
-#include "chan_kern.h"
-#include "mconsole_kern.h"
-#include "mem.h"
-#include "mem_kern.h"
-#include "sysdep/sigcontext.h"
-#include "sysdep/ptrace.h"
-#include "os.h"
-#ifdef CONFIG_MODE_SKAS
-#include "skas.h"
-#endif
-#include "os.h"
-
-/* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
-int handle_page_fault(unsigned long address, unsigned long ip, 
-		      int is_write, int is_user, int *code_out)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int err = -EFAULT;
-
-	*code_out = SEGV_MAPERR;
-
-	/* If the fault was during atomic operation, don't take the fault, just
-	 * fail. */
-	if (in_atomic())
-		goto out_nosemaphore;
-
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, address);
-	if(!vma) 
-		goto out;
-	else if(vma->vm_start <= address) 
-		goto good_area;
-	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
-		goto out;
-	else if(is_user && !ARCH_IS_STACKGROW(address))
-		goto out;
-	else if(expand_stack(vma, address)) 
-		goto out;
-
-good_area:
-	*code_out = SEGV_ACCERR;
-	if(is_write && !(vma->vm_flags & VM_WRITE)) 
-		goto out;
-
-	/* Don't require VM_READ|VM_EXEC for write faults! */
-        if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
-                goto out;
-
-	do {
-survive:
-		switch (handle_mm_fault(mm, vma, address, is_write)){
-		case VM_FAULT_MINOR:
-			current->min_flt++;
-			break;
-		case VM_FAULT_MAJOR:
-			current->maj_flt++;
-			break;
-		case VM_FAULT_SIGBUS:
-			err = -EACCES;
-			goto out;
-		case VM_FAULT_OOM:
-			err = -ENOMEM;
-			goto out_of_memory;
-		default:
-			BUG();
-		}
-		pgd = pgd_offset(mm, address);
-		pud = pud_offset(pgd, address);
-		pmd = pmd_offset(pud, address);
-		pte = pte_offset_kernel(pmd, address);
-	} while(!pte_present(*pte));
-	err = 0;
-	/* The below warning was added in place of
-	 *	pte_mkyoung(); if (is_write) pte_mkdirty();
-	 * If it's triggered, we'd see normally a hang here (a clean pte is
-	 * marked read-only to emulate the dirty bit).
-	 * However, the generic code can mark a PTE writable but clean on a
-	 * concurrent read fault, triggering this harmlessly. So comment it out.
-	 */
-#if 0
-	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
-#endif
-	flush_tlb_page(vma, address);
-out:
-	up_read(&mm->mmap_sem);
-out_nosemaphore:
-	return(err);
-
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
-out_of_memory:
-	if (current->pid == 1) {
-		up_read(&mm->mmap_sem);
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	goto out;
-}
-
-void segv_handler(int sig, union uml_pt_regs *regs)
-{
-	struct faultinfo * fi = UPT_FAULTINFO(regs);
-
-	if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
-		bad_segv(*fi, UPT_IP(regs));
-		return;
-	}
-	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
-}
-
-struct kern_handlers handlinfo_kern = {
-	.relay_signal = relay_signal,
-	.winch = winch,
-	.bus_handler = relay_signal,
-	.page_fault = segv_handler,
-	.sigio_handler = sigio_handler,
-	.timer_handler = timer_handler
-};
-/*
- * We give a *copy* of the faultinfo in the regs to segv.
- * This must be done, since nesting SEGVs could overwrite
- * the info in the regs. A pointer to the info then would
- * give us bad data!
- */
-unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user, void *sc)
-{
-	struct siginfo si;
-	void *catcher;
-	int err;
-        int is_write = FAULT_WRITE(fi);
-        unsigned long address = FAULT_ADDRESS(fi);
-
-        if(!is_user && (address >= start_vm) && (address < end_vm)){
-                flush_tlb_kernel_vm();
-                return(0);
-        }
-	else if(current->mm == NULL)
-		panic("Segfault with no mm");
-
-	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
-		err = handle_page_fault(address, ip, is_write, is_user, &si.si_code);
-	else {
-		err = -EFAULT;
-		/* A thread accessed NULL, we get a fault, but CR2 is invalid.
-		 * This code is used in __do_copy_from_user() of TT mode. */
-		address = 0;
-	}
-
-	catcher = current->thread.fault_catcher;
-	if(!err)
-		return(0);
-	else if(catcher != NULL){
-		current->thread.fault_addr = (void *) address;
-		do_longjmp(catcher, 1);
-	} 
-	else if(current->thread.fault_addr != NULL)
-		panic("fault_addr set but no fault catcher");
-        else if(!is_user && arch_fixup(ip, sc))
-		return(0);
-
- 	if(!is_user) 
-		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx", 
-		      address, ip);
-
-	if (err == -EACCES) {
-		si.si_signo = SIGBUS;
-		si.si_errno = 0;
-		si.si_code = BUS_ADRERR;
-		si.si_addr = (void __user *)address;
-                current->thread.arch.faultinfo = fi;
-		force_sig_info(SIGBUS, &si, current);
-	} else if (err == -ENOMEM) {
-		printk("VM: killing process %s\n", current->comm);
-		do_exit(SIGKILL);
-	} else {
-		BUG_ON(err != -EFAULT);
-		si.si_signo = SIGSEGV;
-		si.si_addr = (void __user *) address;
-                current->thread.arch.faultinfo = fi;
-		force_sig_info(SIGSEGV, &si, current);
-	}
-	return(0);
-}
-
-void bad_segv(struct faultinfo fi, unsigned long ip)
-{
-	struct siginfo si;
-
-	si.si_signo = SIGSEGV;
-	si.si_code = SEGV_ACCERR;
-	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
-	current->thread.arch.faultinfo = fi;
-	force_sig_info(SIGSEGV, &si, current);
-}
-
-void relay_signal(int sig, union uml_pt_regs *regs)
-{
-	if(arch_handle_signal(sig, regs)) return;
-	if(!UPT_IS_USER(regs))
-		panic("Kernel mode signal %d", sig);
-        current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
-	force_sig(sig, current);
-}
-
-void bus_handler(int sig, union uml_pt_regs *regs)
-{
-	if(current->thread.fault_catcher != NULL)
-		do_longjmp(current->thread.fault_catcher, 1);
-	else relay_signal(sig, regs);
-}
-
-void winch(int sig, union uml_pt_regs *regs)
-{
-	do_IRQ(WINCH_IRQ, regs);
-}
-
-void trap_init(void)
-{
-}
Index: linux-2.6.17/arch/um/kernel/syscall.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17/arch/um/kernel/syscall.c	2006-07-06 13:29:14.000000000 -0400
@@ -0,0 +1,166 @@
+/*
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/sched.h"
+#include "linux/file.h"
+#include "linux/smp_lock.h"
+#include "linux/mm.h"
+#include "linux/utsname.h"
+#include "linux/msg.h"
+#include "linux/shm.h"
+#include "linux/sys.h"
+#include "linux/syscalls.h"
+#include "linux/unistd.h"
+#include "linux/slab.h"
+#include "linux/utime.h"
+#include "asm/mman.h"
+#include "asm/uaccess.h"
+#include "kern_util.h"
+#include "user_util.h"
+#include "sysdep/syscalls.h"
+#include "mode_kern.h"
+#include "choose-mode.h"
+
+/*  Unlocked, I don't care if this is a bit off */
+int nsyscalls = 0;
+
+long sys_fork(void)
+{
+	long ret;
+
+	current->thread.forking = 1;
+	ret = do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
+		      &current->thread.regs, 0, NULL, NULL);
+	current->thread.forking = 0;
+	return(ret);
+}
+
+long sys_vfork(void)
+{
+	long ret;
+
+	current->thread.forking = 1;
+	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+		      UPT_SP(&current->thread.regs.regs),
+		      &current->thread.regs, 0, NULL, NULL);
+	current->thread.forking = 0;
+	return(ret);
+}
+
+/* common code for old and new mmaps */
+long sys_mmap2(unsigned long addr, unsigned long len,
+	       unsigned long prot, unsigned long flags,
+	       unsigned long fd, unsigned long pgoff)
+{
+	long error = -EBADF;
+	struct file * file = NULL;
+
+	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	if (!(flags & MAP_ANONYMOUS)) {
+		file = fget(fd);
+		if (!file)
+			goto out;
+	}
+
+	down_write(&current->mm->mmap_sem);
+	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+
+	if (file)
+		fput(file);
+ out:
+	return error;
+}
+
+long old_mmap(unsigned long addr, unsigned long len,
+	      unsigned long prot, unsigned long flags,
+	      unsigned long fd, unsigned long offset)
+{
+	long err = -EINVAL;
+	if (offset & ~PAGE_MASK)
+		goto out;
+
+	err = sys_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
+ out:
+	return err;
+}
+/*
+ * sys_pipe() is the normal C calling standard for creating
+ * a pipe. It's not the way unix traditionally does this, though.
+ */
+long sys_pipe(unsigned long __user * fildes)
+{
+        int fd[2];
+        long error;
+
+        error = do_pipe(fd);
+        if (!error) {
+		if (copy_to_user(fildes, fd, sizeof(fd)))
+                        error = -EFAULT;
+        }
+        return error;
+}
+
+
+long sys_uname(struct old_utsname __user * name)
+{
+	long err;
+	if (!name)
+		return -EFAULT;
+	down_read(&uts_sem);
+	err = copy_to_user(name, utsname(), sizeof (*name));
+	up_read(&uts_sem);
+	return err?-EFAULT:0;
+}
+
+long sys_olduname(struct oldold_utsname __user * name)
+{
+	long error;
+
+	if (!name)
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
+		return -EFAULT;
+
+  	down_read(&uts_sem);
+
+	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+			       __OLD_UTS_LEN);
+	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release, &utsname()->release,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->release + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version, &utsname()->version,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->version + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &utsname()->machine,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
+
+	up_read(&uts_sem);
+
+	error = error ? -EFAULT : 0;
+
+	return error;
+}
+
+DEFINE_SPINLOCK(syscall_lock);
+
+static int syscall_index = 0;
+
+int next_syscall_index(int limit)
+{
+	int ret;
+
+	spin_lock(&syscall_lock);
+	ret = syscall_index;
+	if(++syscall_index == limit)
+		syscall_index = 0;
+	spin_unlock(&syscall_lock);
+	return(ret);
+}
Index: linux-2.6.17/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/syscall_kern.c	2006-07-06 13:22:13.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,166 +0,0 @@
-/* 
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#include "linux/sched.h"
-#include "linux/file.h"
-#include "linux/smp_lock.h"
-#include "linux/mm.h"
-#include "linux/utsname.h"
-#include "linux/msg.h"
-#include "linux/shm.h"
-#include "linux/sys.h"
-#include "linux/syscalls.h"
-#include "linux/unistd.h"
-#include "linux/slab.h"
-#include "linux/utime.h"
-#include "asm/mman.h"
-#include "asm/uaccess.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "sysdep/syscalls.h"
-#include "mode_kern.h"
-#include "choose-mode.h"
-
-/*  Unlocked, I don't care if this is a bit off */
-int nsyscalls = 0;
-
-long sys_fork(void)
-{
-	long ret;
-
-	current->thread.forking = 1;
-	ret = do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
-		      &current->thread.regs, 0, NULL, NULL);
-	current->thread.forking = 0;
-	return(ret);
-}
-
-long sys_vfork(void)
-{
-	long ret;
-
-	current->thread.forking = 1;
-	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
-		      UPT_SP(&current->thread.regs.regs),
-		      &current->thread.regs, 0, NULL, NULL);
-	current->thread.forking = 0;
-	return(ret);
-}
-
-/* common code for old and new mmaps */
-long sys_mmap2(unsigned long addr, unsigned long len,
-	       unsigned long prot, unsigned long flags,
-	       unsigned long fd, unsigned long pgoff)
-{
-	long error = -EBADF;
-	struct file * file = NULL;
-
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	if (!(flags & MAP_ANONYMOUS)) {
-		file = fget(fd);
-		if (!file)
-			goto out;
-	}
-
-	down_write(&current->mm->mmap_sem);
-	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
-
-	if (file)
-		fput(file);
- out:
-	return error;
-}
-
-long old_mmap(unsigned long addr, unsigned long len,
-	      unsigned long prot, unsigned long flags,
-	      unsigned long fd, unsigned long offset)
-{
-	long err = -EINVAL;
-	if (offset & ~PAGE_MASK)
-		goto out;
-
-	err = sys_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
- out:
-	return err;
-}
-/*
- * sys_pipe() is the normal C calling standard for creating
- * a pipe. It's not the way unix traditionally does this, though.
- */
-long sys_pipe(unsigned long __user * fildes)
-{
-        int fd[2];
-        long error;
-
-        error = do_pipe(fd);
-        if (!error) {
-		if (copy_to_user(fildes, fd, sizeof(fd)))
-                        error = -EFAULT;
-        }
-        return error;
-}
-
-
-long sys_uname(struct old_utsname __user * name)
-{
-	long err;
-	if (!name)
-		return -EFAULT;
-	down_read(&uts_sem);
-	err = copy_to_user(name, utsname(), sizeof (*name));
-	up_read(&uts_sem);
-	return err?-EFAULT:0;
-}
-
-long sys_olduname(struct oldold_utsname __user * name)
-{
-	long error;
-
-	if (!name)
-		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
-		return -EFAULT;
-  
-  	down_read(&uts_sem);
-	
-	error = __copy_to_user(&name->sysname, &utsname()->sysname,
-			       __OLD_UTS_LEN);
-	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release, &utsname()->release,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->release + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version, &utsname()->version,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->version + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine, &utsname()->machine,
-				__OLD_UTS_LEN);
-	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
-	
-	up_read(&uts_sem);
-	
-	error = error ? -EFAULT : 0;
-
-	return error;
-}
-
-DEFINE_SPINLOCK(syscall_lock);
-
-static int syscall_index = 0;
-
-int next_syscall_index(int limit)
-{
-	int ret;
-
-	spin_lock(&syscall_lock);
-	ret = syscall_index;
-	if(++syscall_index == limit)
-		syscall_index = 0;
-	spin_unlock(&syscall_lock);
-	return(ret);
-}
Index: linux-2.6.17/arch/um/kernel/exec_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/exec_kern.c	2006-06-20 17:24:29.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,77 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/slab.h"
-#include "linux/smp_lock.h"
-#include "linux/ptrace.h"
-#include "asm/ptrace.h"
-#include "asm/pgtable.h"
-#include "asm/tlbflush.h"
-#include "asm/uaccess.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "mem_user.h"
-#include "kern.h"
-#include "irq_user.h"
-#include "tlb.h"
-#include "os.h"
-#include "choose-mode.h"
-#include "mode_kern.h"
-
-void flush_thread(void)
-{
-	arch_flush_thread(&current->thread.arch);
-	CHOOSE_MODE(flush_thread_tt(), flush_thread_skas());
-}
-
-void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
-{
-	CHOOSE_MODE_PROC(start_thread_tt, start_thread_skas, regs, eip, esp);
-}
-
-static long execve1(char *file, char __user * __user *argv,
-		    char __user *__user *env)
-{
-        long error;
-
-#ifdef CONFIG_TTY_LOG
-	log_exec(argv, current->tty);
-#endif
-        error = do_execve(file, argv, env, &current->thread.regs);
-        if (error == 0){
-		task_lock(current);
-                current->ptrace &= ~PT_DTRACE;
-		task_unlock(current);
-                set_cmdline(current_cmd());
-        }
-        return(error);
-}
-
-long um_execve(char *file, char __user *__user *argv, char __user *__user *env)
-{
-	long err;
-
-	err = execve1(file, argv, env);
-	if(!err)
-		do_longjmp(current->thread.exec_buf, 1);
-	return(err);
-}
-
-long sys_execve(char __user *file, char __user *__user *argv,
-		char __user *__user *env)
-{
-	long error;
-	char *filename;
-
-	lock_kernel();
-	filename = getname(file);
-	error = PTR_ERR(filename);
-	if (IS_ERR(filename)) goto out;
-	error = execve1(filename, argv, env);
-	putname(filename);
- out:
-	unlock_kernel();
-	return(error);
-}
Index: linux-2.6.17/arch/um/kernel/sigio_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/sigio_kern.c	2006-07-06 13:28:59.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,55 +0,0 @@
-/*
- * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#include "linux/kernel.h"
-#include "linux/list.h"
-#include "linux/slab.h"
-#include "linux/signal.h"
-#include "linux/interrupt.h"
-#include "init.h"
-#include "sigio.h"
-#include "irq_user.h"
-#include "irq_kern.h"
-#include "os.h"
-
-/* Protected by sigio_lock() called from write_sigio_workaround */
-static int sigio_irq_fd = -1;
-
-static irqreturn_t sigio_interrupt(int irq, void *data, struct pt_regs *unused)
-{
-	char c;
-
-	os_read_file(sigio_irq_fd, &c, sizeof(c));
-	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
-	return(IRQ_HANDLED);
-}
-
-int write_sigio_irq(int fd)
-{
-	int err;
-
-	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
-			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "write sigio",
-			     NULL);
-	if(err){
-		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
-		       err);
-		return(-1);
-	}
-	sigio_irq_fd = fd;
-	return(0);
-}
-
-static DEFINE_SPINLOCK(sigio_spinlock);
-
-void sigio_lock(void)
-{
-	spin_lock(&sigio_spinlock);
-}
-
-void sigio_unlock(void)
-{
-	spin_unlock(&sigio_spinlock);
-}
Index: linux-2.6.17/arch/um/kernel/signal_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/signal_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,191 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/config.h"
-#include "linux/stddef.h"
-#include "linux/sys.h"
-#include "linux/sched.h"
-#include "linux/wait.h"
-#include "linux/kernel.h"
-#include "linux/smp_lock.h"
-#include "linux/module.h"
-#include "linux/slab.h"
-#include "linux/tty.h"
-#include "linux/binfmts.h"
-#include "linux/ptrace.h"
-#include "asm/signal.h"
-#include "asm/uaccess.h"
-#include "asm/unistd.h"
-#include "user_util.h"
-#include "asm/ucontext.h"
-#include "kern_util.h"
-#include "signal_kern.h"
-#include "kern.h"
-#include "frame_kern.h"
-#include "sigcontext.h"
-#include "mode.h"
-
-EXPORT_SYMBOL(block_signals);
-EXPORT_SYMBOL(unblock_signals);
-
-#define _S(nr) (1<<((nr)-1))
-
-#define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
-
-/*
- * OK, we're invoking a handler
- */	
-static int handle_signal(struct pt_regs *regs, unsigned long signr,
-			 struct k_sigaction *ka, siginfo_t *info,
-			 sigset_t *oldset)
-{
-	unsigned long sp;
-	int err;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
-	/* Did we come from a system call? */
-	if(PT_REGS_SYSCALL_NR(regs) >= 0){
-		/* If so, check system call restarting.. */
-		switch(PT_REGS_SYSCALL_RET(regs)){
-		case -ERESTART_RESTARTBLOCK:
-		case -ERESTARTNOHAND:
-			PT_REGS_SYSCALL_RET(regs) = -EINTR;
-			break;
-
-		case -ERESTARTSYS:
-			if (!(ka->sa.sa_flags & SA_RESTART)) {
-				PT_REGS_SYSCALL_RET(regs) = -EINTR;
-				break;
-			}
-		/* fallthrough */
-		case -ERESTARTNOINTR:
-			PT_REGS_RESTART_SYSCALL(regs);
-			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
-			break;
-		}
-	}
-
-	sp = PT_REGS_SP(regs);
-	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-
-#ifdef CONFIG_ARCH_HAS_SC_SIGNALS
-	if(!(ka->sa.sa_flags & SA_SIGINFO))
-		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
-	else
-#endif
-		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
-
-	if(err){
-		spin_lock_irq(&current->sighand->siglock);
-		current->blocked = *oldset;
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-		force_sigsegv(signr, current);
-	} else {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked, 
-			  &ka->sa.sa_mask);
-		 if(!(ka->sa.sa_flags & SA_NODEFER))
-			sigaddset(&current->blocked, signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
-
-	return err;
-}
-
-static int kern_do_signal(struct pt_regs *regs)
-{
-	struct k_sigaction ka_copy;
-	siginfo_t info;
-	sigset_t *oldset;
-	int sig, handled_sig = 0;
-
-	if (test_thread_flag(TIF_RESTORE_SIGMASK))
-		oldset = &current->saved_sigmask;
-	else
-		oldset = &current->blocked;
-
-	while((sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL)) > 0){
-		handled_sig = 1;
-		/* Whee!  Actually deliver the signal.  */
-		if(!handle_signal(regs, sig, &ka_copy, &info, oldset)){
-			/* a signal was successfully delivered; the saved
-			 * sigmask will have been stored in the signal frame,
-			 * and will be restored by sigreturn, so we can simply
-			 * clear the TIF_RESTORE_SIGMASK flag */
-			if (test_thread_flag(TIF_RESTORE_SIGMASK))
-				clear_thread_flag(TIF_RESTORE_SIGMASK);
-			break;
-		}
-	}
-
-	/* Did we come from a system call? */
-	if(!handled_sig && (PT_REGS_SYSCALL_NR(regs) >= 0)){
-		/* Restart the system call - no handlers present */
-		switch(PT_REGS_SYSCALL_RET(regs)){
-		case -ERESTARTNOHAND:
-		case -ERESTARTSYS:
-		case -ERESTARTNOINTR:
-			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
-			PT_REGS_RESTART_SYSCALL(regs);
-			break;
-		case -ERESTART_RESTARTBLOCK:
-			PT_REGS_SYSCALL_RET(regs) = __NR_restart_syscall;
-			PT_REGS_RESTART_SYSCALL(regs);
-			break;
- 		}
-	}
-
-	/* This closes a way to execute a system call on the host.  If
-	 * you set a breakpoint on a system call instruction and singlestep
-	 * from it, the tracing thread used to PTRACE_SINGLESTEP the process
-	 * rather than PTRACE_SYSCALL it, allowing the system call to execute
-	 * on the host.  The tracing thread will check this flag and 
-	 * PTRACE_SYSCALL if necessary.
-	 */
-	if(current->ptrace & PT_DTRACE)
-		current->thread.singlestep_syscall =
-			is_syscall(PT_REGS_IP(&current->thread.regs));
-
-	/* if there's no signal to deliver, we just put the saved sigmask
-	 * back */
-	if (!handled_sig && test_thread_flag(TIF_RESTORE_SIGMASK)) {
-		clear_thread_flag(TIF_RESTORE_SIGMASK);
-		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
-	}
-	return(handled_sig);
-}
-
-int do_signal(void)
-{
-	return(kern_do_signal(&current->thread.regs));
-}
-
-/*
- * Atomically swap in the new signal mask, and wait for a signal.
- */
-long sys_sigsuspend(int history0, int history1, old_sigset_t mask)
-{
-	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sighand->siglock);
-	current->saved_sigmask = current->blocked;
-	siginitset(&current->blocked, mask);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	set_thread_flag(TIF_RESTORE_SIGMASK);
-	return -ERESTARTNOHAND;
-}
-
-long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
-{
-	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
-}
Index: linux-2.6.17/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/Makefile	2006-07-06 13:29:05.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/Makefile	2006-07-06 13:29:14.000000000 -0400
@@ -6,11 +6,10 @@
 extra-y := vmlinux.lds
 clean-files :=
 
-obj-y = config.o exec_kern.o exitcode.o \
-	init_task.o irq.o ksyms.o mem.o physmem.o \
-	process_kern.o ptrace.o reboot.o resource.o sigio_kern.o \
-	signal_kern.o smp.o syscall_kern.o sysrq.o \
-	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o
+obj-y = config.o exec.o exitcode.o init_task.o irq.o ksyms.o mem.o \
+	physmem.o process_kern.o ptrace.o reboot.o resource.o sigio.o \
+	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o uaccess.o \
+	um_arch.o umid.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o

