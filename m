Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVKXTIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVKXTIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKXTIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:08:52 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:58506 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751391AbVKXTIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:08:50 -0500
Subject: RFC: Kill -ERESTART_RESTARTBLOCK.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
	baythorne.infradead.org See http://www.infradead.org/rpr.html
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
	baythorne.infradead.org See http://www.infradead.org/rpr.html
Content-Type: text/plain
Date: Thu, 24 Nov 2005 19:08:43 +0000
Message-Id: <1132859323.11921.110.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at implementing ppoll() and pselect(), and the existing
restartblock stuff isn't sufficient for that -- we don't get to store
enough args, and although it could possibly be expanded, I just don't
much like restarting syscalls that way.

I think it makes more sense just to allow the arch-independent code to
deliver signals. So this patch introduces arch_do_signal() and, perhaps
unfortunately, arch_set_sigframe_result().

This allows us to get rid of all the *_nanpsleep 'restart' mess, and
remove the restart block from the thread_info. We can probably also make
sigsuspend a generic function too, rather than having it re-implemented
by every architecture.

Functions which have (successfully) called arch_do_signal() are now
expected to return -ESIGNALLED, and the syscall exit path (or an
assembly wrapper round the syscall itself) _can_ treat that specially if
it needs to, doing whatever it used to do on the way out from
sigsuspend() directly into the signal handler.

This is a proof-of-concept for powerpc; I suspect I might need to do
something about the prototypes of sys_(clock_,}nanosleep().

Comments? Alternative options which would allow pselect() to work?

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index c9d0275..d14530f 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -64,6 +64,7 @@
 #define sys_sigaction	compat_sys_sigaction
 #define sys_swapcontext	compat_sys_swapcontext
 #define sys_sigreturn	compat_sys_sigreturn
+#define arch_set_sigframe_result arch_set_sigframe_result32
 
 #define old_sigaction	old_sigaction32
 #define sigcontext	sigcontext32
@@ -155,10 +156,9 @@ static inline int save_general_regs(stru
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
 
-	if (!FULL_REGS(regs)) {
+	current_thread_info()->nvgprs_frame = &frame->mc_gregs[0];
+	if (!FULL_REGS(regs))
 		set_thread_flag(TIF_SAVE_NVGPRS);
-		current_thread_info()->nvgprs_frame = frame->mc_gregs;
-	}
 
 	for (i = 0; i <= PT_RESULT; i ++) {
 		if (i == 14 && !FULL_REGS(regs))
@@ -219,6 +219,15 @@ static inline int get_old_sigaction(stru
 static inline int save_general_regs(struct pt_regs *regs,
 		struct mcontext __user *frame)
 {
+	current_thread_info()->nvgprs_frame = &frame->mc_gregs;
+	if (!FULL_REGS(regs)) {
+		/* Zero out the unsaved GPRs to avoid information
+		   leak, and set TIF_SAVE_NVGPRS to ensure that the
+		   registers do actually get saved later. */
+		memset(&regs->gpr[14], 0, 18 * sizeof(unsigned long));
+		set_thread_flag(TIF_SAVE_NVGPRS);
+	}
+
 	return __copy_to_user(&frame->mc_gregs, regs, GP_REGS_SIZE);
 }
 
@@ -921,9 +930,6 @@ long sys_rt_sigreturn(int r3, int r4, in
 {
 	struct rt_sigframe __user *rt_sf;
 
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
 	rt_sf = (struct rt_sigframe __user *)
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
 	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
@@ -1127,9 +1133,6 @@ long sys_sigreturn(int r3, int r4, int r
 	struct mcontext __user *sr;
 	sigset_t set;
 
-	/* Always make any pending restarted system calls return -EINTR */
-	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-
 	sc = (struct sigcontext __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
@@ -1251,3 +1254,40 @@ no_signal:
 
 	return ret;
 }
+
+int arch_set_sigframe_result(struct pt_regs *regs, int err)
+{
+	struct mcontext __user *mc = current_thread_info()->nvgprs_frame;
+	u32 ccr;
+
+	regs->result = err;
+
+	if (get_user(ccr, &mc->mc_gregs[PT_CCR]) ||
+	    put_user(ccr|0x10000000, &mc->mc_gregs[PT_CCR]) ||
+	    put_user(-err, &mc->mc_gregs[3])) {
+		/* The signal frame on the stack went away after it
+		   was first set up. We want to change the return code
+		   we stored there, but we can't. But then again, it
+		   doesn't matter much because userspace is going to
+		   SEGV if it looks at it anyway. So it doesn't matter
+		   much if we ignore this result. */
+		return -EFAULT;
+		
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PPC32
+int arch_do_signal(struct pt_regs *regs, sigset_t *saveset)
+{
+	int ret;
+
+	ret = do_signal(saveset, regs);
+	if (ret) {
+		set_thread_flag(TIF_RESTOREALL);
+		arch_set_sigframe_result(regs, -EINTR);
+	}
+
+	return ret;
+}
+#endif
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 5462bef..b80d775 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -591,3 +591,42 @@ int do_signal(sigset_t *oldset, struct p
 	return 0;
 }
 EXPORT_SYMBOL(do_signal);
+
+
+int arch_set_sigframe_result(struct pt_regs *regs, int err)
+{
+	struct mcontext __user *mc;
+	u32 ccr;
+
+	if (test_thread_flag(TIF_32BIT))
+		return arch_set_sigframe_result32(regs, err);
+
+	mc = = current_thread_info()->nvgprs_frame;
+	regs->result = err;
+
+	if (get_user(ccr, &mc->mc_gregs[PT_CCR]) ||
+	    put_user(ccr|0x10000000, &mc->mc_gregs[PT_CCR]) ||
+	    put_user(-err, &mc->mc_gregs[3])) {
+		/* The signal frame on the stack went away after it
+		   was first set up. We want to change the return code
+		   we stored there, but we can't. But then again, it
+		   doesn't matter much because userspace is going to
+		   SEGV if it looks at it anyway. So it doesn't matter
+		   much if we ignore this result. */
+		return -EFAULT;
+		
+	}
+	return 0;
+}
+
+int arch_do_signal(struct pt_regs *regs, sigset_t *saveset)
+{
+	int ret;
+
+	ret = do_signal(saveset, regs);
+	if (ret) {
+		set_thread_flag(TIF_RESTOREALL);
+		arch_set_sigframe_result(-EINTR);
+
+	return ret;
+}
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 989f628..385383e 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -41,7 +41,7 @@
 #endif
 
 _GLOBAL(sys_call_table)
-SYSCALL(restart_syscall)
+SYSCALL(ni_syscall)
 SYSCALL(exit)
 PPC_SYS(fork)
 SYSCALL(read)
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index ac1e80e..1e898ad 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -36,7 +36,6 @@ struct thread_info {
 	int		cpu;			/* cpu we're on */
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
-	struct restart_block restart_block;
 	void *nvgprs_frame;
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
@@ -53,9 +52,6 @@ struct thread_info {
 	.exec_domain =	&default_exec_domain,	\
 	.cpu =		0,			\
 	.preempt_count = 1,			\
-	.restart_block = {			\
-		.fn = do_no_restart_syscall,	\
-	},					\
 	.flags =	0,			\
 }
 
diff --git a/include/linux/errno.h b/include/linux/errno.h
index d90b80f..a85da23 100644
--- a/include/linux/errno.h
+++ b/include/linux/errno.h
@@ -11,6 +11,7 @@
 #define ERESTARTNOHAND	514	/* restart if no handler.. */
 #define ENOIOCTLCMD	515	/* No ioctl command */
 #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
+#define ESIGNALLED	517	/* A signal has already been delivered */
 
 /* Defined for the NFSv3 protocol */
 #define EBADHANDLE	521	/* Illegal NFS file handle */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index f942e2b..37e2552 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -77,7 +77,7 @@ struct k_clock {
 	int (*clock_set) (clockid_t which_clock, struct timespec * tp);
 	int (*clock_get) (clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *);
+	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *, struct pt_regs *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -91,7 +91,7 @@ void register_posix_clock(clockid_t cloc
 
 /* Error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
-int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *);
+int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *, struct pt_regs *);
 int do_posix_clock_nosettime(clockid_t, struct timespec *tp);
 
 /* function to call to trigger timer event */
@@ -121,7 +121,7 @@ int posix_cpu_clock_getres(clockid_t whi
 int posix_cpu_clock_get(clockid_t which_clock, struct timespec *);
 int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp);
 int posix_cpu_timer_create(struct k_itimer *);
-int posix_cpu_nsleep(clockid_t, int, struct timespec *);
+int posix_cpu_nsleep(clockid_t, int, struct timespec *, struct pt_regs *);
 int posix_cpu_timer_set(struct k_itimer *, int,
 			struct itimerspec *, struct itimerspec *);
 int posix_cpu_timer_del(struct k_itimer *);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 5dd5f02..b825170 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -233,6 +233,8 @@ extern int sigprocmask(int, sigset_t *, 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 
+extern int arch_do_signal(struct pt_regs *regs, sigset_t *saveset);
+extern int arch_set_sigframe_result(struct pt_regs *regs, int result);
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 44fdd48..0854f5e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -74,7 +74,9 @@ asmlinkage long sys_adjtimex(struct time
 asmlinkage long sys_times(struct tms __user *tbuf);
 
 asmlinkage long sys_gettid(void);
-asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp);
+asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp, 
+			      long x1, long x2, long x3, long x4, /* FIXME */
+			      struct pt_regs *regs);
 asmlinkage unsigned long sys_alarm(unsigned int seconds);
 asmlinkage long sys_getpid(void);
 asmlinkage long sys_getppid(void);
@@ -133,7 +135,9 @@ asmlinkage long sys_clock_getres(clockid
 				struct timespec __user *tp);
 asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
 				const struct timespec __user *rqtp,
-				struct timespec __user *rmtp);
+				struct timespec __user *rmtp,
+				    long x1, long x2, /* FIXME */
+				struct pt_regs *regs);
 
 asmlinkage long sys_nice(int increment);
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 1c4eb41..78b16e9 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -7,16 +7,6 @@
 #ifndef _LINUX_THREAD_INFO_H
 #define _LINUX_THREAD_INFO_H
 
-/*
- * System call restart block. 
- */
-struct restart_block {
-	long (*fn)(struct restart_block *);
-	unsigned long arg0, arg1, arg2, arg3;
-};
-
-extern long do_no_restart_syscall(struct restart_block *parm);
-
 #include <linux/bitops.h>
 #include <asm/thread_info.h>
 
diff --git a/kernel/compat.c b/kernel/compat.c
index 102296e..93ed67f 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -68,7 +68,8 @@ static long compat_nanosleep_restart(str
 }
 
 asmlinkage long compat_sys_nanosleep(struct compat_timespec __user *rqtp,
-		struct compat_timespec __user *rmtp)
+				     struct compat_timespec __user *rmtp,
+				     struct pt_regs *regs)
 {
 	struct timespec t;
 	struct restart_block *restart;
@@ -81,20 +82,18 @@ asmlinkage long compat_sys_nanosleep(str
 		return -EINVAL;
 
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	expire = schedule_timeout_interruptible(expire);
-	if (expire == 0)
-		return 0;
-
-	if (rmtp) {
-		jiffies_to_timespec(expire, &t);
-		if (put_compat_timespec(&t, rmtp))
-			return -EFAULT;
+
+	while ((expire = schedule_timeout_interruptible(expire))) {
+
+		if (arch_do_signal(regs, &current->blocked)) {
+			jiffies_to_timespec(expire, &t);
+			if (rmtp && put_compat_timespec(&t, rmtp))
+				arch_set_sigframe_result(regs, -EFAULT);
+
+			return -ESIGNALLED;
+		}
 	}
-	restart = &current_thread_info()->restart_block;
-	restart->fn = compat_nanosleep_restart;
-	restart->arg0 = jiffies + expire;
-	restart->arg1 = (unsigned long) rmtp;
-	return -ERESTART_RESTARTBLOCK;
+	return 0;
 }
 
 static inline long get_compat_itimerval(struct itimerval *o,
diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index 84af54c..e3b552f 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -1408,13 +1408,9 @@ void set_process_cpu_timer(struct task_s
 	}
 }
 
-static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
-
 int posix_cpu_nsleep(clockid_t which_clock, int flags,
-		     struct timespec *rqtp)
+		     struct timespec *rqtp, struct pt_regs *regs)
 {
-	struct restart_block *restart_block =
-	    &current_thread_info()->restart_block;
 	struct k_itimer timer;
 	int error;
 
@@ -1436,7 +1432,6 @@ int posix_cpu_nsleep(clockid_t which_clo
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
 	if (!error) {
-		struct timespec __user *rmtp;
 		static struct itimerspec zero_it;
 		struct itimerspec it = { .it_value = *rqtp,
 					 .it_interval = {} };
@@ -1448,69 +1443,42 @@ int posix_cpu_nsleep(clockid_t which_clo
 			return error;
 		}
 
-		while (!signal_pending(current)) {
-			if (timer.it.cpu.expires.sched == 0) {
-				/*
-				 * Our timer fired and was reset.
-				 */
-				spin_unlock_irq(&timer.it_lock);
-				return 0;
-			}
-
+		while (timer.it.cpu.expires.sched) {
 			/*
 			 * Block until cpu_timer_fire (or a signal) wakes us.
 			 */
 			__set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&timer.it_lock);
 			schedule();
-			spin_lock_irq(&timer.it_lock);
-		}
 
-		/*
-		 * We were interrupted by a signal.
-		 */
-		sample_to_timespec(which_clock, timer.it.cpu.expires, rqtp);
-		posix_cpu_timer_set(&timer, 0, &zero_it, &it);
-		spin_unlock_irq(&timer.it_lock);
+			if (test_thread_flag(TIF_SIGPENDING)) {
+				spin_lock_irq(&timer.it_lock);
+				sample_to_timespec(which_clock, timer.it.cpu.expires, rqtp);
+				posix_cpu_timer_set(&timer, 0, &zero_it, &it);
+				spin_unlock_irq(&timer.it_lock);
 
-		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
-			/*
-			 * It actually did fire already.
-			 */
-			return 0;
+				if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
+					/*
+					 * It actually did fire already.
+					 */
+					return 0;
+				}
+				if (arch_do_signal(regs, &current->blocked)) {
+					*rqtp = it.it_value;
+					return -ESIGNALLED;
+				}
+			}
+			spin_lock_irq(&timer.it_lock);
 		}
-
 		/*
-		 * Report back to the user the time still remaining.
+		 * Our timer fired and was reset.
 		 */
-		rmtp = (struct timespec __user *) restart_block->arg1;
-		if (rmtp != NULL && !(flags & TIMER_ABSTIME) &&
-		    copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
-			return -EFAULT;
-
-		restart_block->fn = posix_cpu_clock_nanosleep_restart;
-		/* Caller already set restart_block->arg1 */
-		restart_block->arg0 = which_clock;
-		restart_block->arg2 = rqtp->tv_sec;
-		restart_block->arg3 = rqtp->tv_nsec;
-
-		error = -ERESTART_RESTARTBLOCK;
+		spin_unlock_irq(&timer.it_lock);
 	}
 
 	return error;
 }
 
-static long
-posix_cpu_clock_nanosleep_restart(struct restart_block *restart_block)
-{
-	clockid_t which_clock = restart_block->arg0;
-	struct timespec t = { .tv_sec = restart_block->arg2,
-			      .tv_nsec = restart_block->arg3 };
-	restart_block->fn = do_no_restart_syscall;
-	return posix_cpu_nsleep(which_clock, TIMER_ABSTIME, &t);
-}
-
-
 #define PROCESS_CLOCK	MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED)
 #define THREAD_CLOCK	MAKE_THREAD_CPUCLOCK(0, CPUCLOCK_SCHED)
 
@@ -1528,9 +1496,9 @@ static int process_cpu_timer_create(stru
 	return posix_cpu_timer_create(timer);
 }
 static int process_cpu_nsleep(clockid_t which_clock, int flags,
-			      struct timespec *rqtp)
+			      struct timespec *rqtp, struct pt_regs *regs)
 {
-	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp);
+	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp, regs);
 }
 static int thread_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
 {
@@ -1546,7 +1514,7 @@ static int thread_cpu_timer_create(struc
 	return posix_cpu_timer_create(timer);
 }
 static int thread_cpu_nsleep(clockid_t which_clock, int flags,
-			      struct timespec *rqtp)
+			     struct timespec *rqtp, struct pt_regs *regs)
 {
 	return -EINVAL;
 }
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 5870efb..a17f450 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -215,7 +215,7 @@ static inline int common_timer_create(st
 /*
  * These ones are defined below.
  */
-static int common_nsleep(clockid_t, int flags, struct timespec *t);
+static int common_nsleep(clockid_t, int flags, struct timespec *t, struct pt_regs *);
 static void common_timer_get(struct k_itimer *, struct itimerspec *);
 static int common_timer_set(struct k_itimer *, int,
 			    struct itimerspec *, struct itimerspec *);
@@ -1232,7 +1232,7 @@ int do_posix_clock_notimer_create(struct
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_notimer_create);
 
-int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t)
+int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t, struct pt_regs *regs)
 {
 #ifndef ENOTSUP
 	return -EOPNOTSUPP;	/* aka ENOTSUP in userland for POSIX */
@@ -1392,16 +1392,14 @@ void clock_was_set(void)
 	up(&clock_was_set_lock);
 }
 
-long clock_nanosleep_restart(struct restart_block *restart_block);
-
 asmlinkage long
 sys_clock_nanosleep(clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
-		    struct timespec __user *rmtp)
+		    struct timespec __user *rmtp,
+		    long x1, long x2, /* FIXME */
+		    struct pt_regs *regs)
 {
 	struct timespec t;
-	struct restart_block *restart_block =
-	    &(current_thread_info()->restart_block);
 	int ret;
 
 	if (invalid_clockid(which_clock))
@@ -1413,50 +1411,28 @@ sys_clock_nanosleep(clockid_t which_cloc
 	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
 		return -EINVAL;
 
-	/*
-	 * Do this here as nsleep function does not have the real address.
-	 */
-	restart_block->arg1 = (unsigned long)rmtp;
+	ret = CLOCK_DISPATCH(which_clock, nsleep, (which_clock, flags, &t, regs));
 
-	ret = CLOCK_DISPATCH(which_clock, nsleep, (which_clock, flags, &t));
-
-	if ((ret == -ERESTART_RESTARTBLOCK) && rmtp &&
-					copy_to_user(rmtp, &t, sizeof (t)))
-		return -EFAULT;
+	if (ret == -ESIGNALLED && !(flags & TIMER_ABSTIME) && 
+	    rmtp && copy_to_user(rmtp, &t, sizeof(t)))
+		arch_set_sigframe_result(regs, -EFAULT);
+		
 	return ret;
 }
 
-
-static int common_nsleep(clockid_t which_clock,
-			 int flags, struct timespec *tsave)
+static int common_nsleep(clockid_t which_clock, int flags,
+			 struct timespec *tsave, struct pt_regs *regs)
 {
 	struct timespec t, dum;
 	DECLARE_WAITQUEUE(abs_wqueue, current);
 	u64 rq_time = (u64)0;
 	s64 left;
 	int abs;
-	struct restart_block *restart_block =
-	    &current_thread_info()->restart_block;
+	int ret = 0;
 
 	abs_wqueue.flags = 0;
 	abs = flags & TIMER_ABSTIME;
 
-	if (restart_block->fn == clock_nanosleep_restart) {
-		/*
-		 * Interrupted by a non-delivered signal, pick up remaining
-		 * time and continue.  Remaining time is in arg2 & 3.
-		 */
-		restart_block->fn = do_no_restart_syscall;
-
-		rq_time = restart_block->arg3;
-		rq_time = (rq_time << 32) + restart_block->arg2;
-		if (!rq_time)
-			return -EINTR;
-		left = rq_time - get_jiffies_64();
-		if (left <= (s64)0)
-			return 0;	/* Already passed */
-	}
-
 	if (abs && (posix_clocks[which_clock].clock_get !=
 			    posix_clocks[CLOCK_MONOTONIC].clock_get))
 		add_wait_queue(&nanosleep_abs_wqueue, &abs_wqueue);
@@ -1477,58 +1453,21 @@ static int common_nsleep(clockid_t which
 		schedule_timeout_interruptible(left);
 
 		left = rq_time - get_jiffies_64();
-	} while (left > (s64)0 && !test_thread_flag(TIF_SIGPENDING));
 
-	if (abs_wqueue.task_list.next)
-		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
-
-	if (left > (s64)0) {
-
-		/*
-		 * Always restart abs calls from scratch to pick up any
-		 * clock shifting that happened while we are away.
-		 */
-		if (abs)
-			return -ERESTARTNOHAND;
+		if (test_thread_flag(TIF_SIGPENDING)) {
+			t.tv_sec = div_long_long_rem(left*TICK_NSEC,
+						      NSEC_PER_SEC, 
+						      &t.tv_nsec);
+			if (arch_do_signal(regs, &current->blocked)) {
 
-		left *= TICK_NSEC;
-		tsave->tv_sec = div_long_long_rem(left, 
-						  NSEC_PER_SEC, 
-						  &tsave->tv_nsec);
-		/*
-		 * Restart works by saving the time remaing in 
-		 * arg2 & 3 (it is 64-bits of jiffies).  The other
-		 * info we need is the clock_id (saved in arg0). 
-		 * The sys_call interface needs the users 
-		 * timespec return address which _it_ saves in arg1.
-		 * Since we have cast the nanosleep call to a clock_nanosleep
-		 * both can be restarted with the same code.
-		 */
-		restart_block->fn = clock_nanosleep_restart;
-		restart_block->arg0 = which_clock;
-		/*
-		 * Caller sets arg1
-		 */
-		restart_block->arg2 = rq_time & 0xffffffffLL;
-		restart_block->arg3 = rq_time >> 32;
-
-		return -ERESTART_RESTARTBLOCK;
-	}
+				ret = -ESIGNALLED;
+				break;
+			}
+		}
+	} while (left > (s64)0);
 
-	return 0;
-}
-/*
- * This will restart clock_nanosleep.
- */
-long
-clock_nanosleep_restart(struct restart_block *restart_block)
-{
-	struct timespec t;
-	int ret = common_nsleep(restart_block->arg0, 0, &t);
+	if (abs_wqueue.task_list.next)
+		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
 
-	if ((ret == -ERESTART_RESTARTBLOCK) && restart_block->arg1 &&
-	    copy_to_user((struct timespec __user *)(restart_block->arg1), &t,
-			 sizeof (t)))
-		return -EFAULT;
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index d7611f1..2f1b4e2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1973,21 +1974,6 @@ EXPORT_SYMBOL(unblock_all_signals);
 

 /*
- * System call entry points.
- */
-
-asmlinkage long sys_restart_syscall(void)
-{
-	struct restart_block *restart = &current_thread_info()->restart_block;
-	return restart->fn(restart);
-}
-
-long do_no_restart_syscall(struct restart_block *param)
-{
-	return -EINTR;
-}
-
-/*
  * We don't need to get the kernel lock - this is all local to this
  * particular thread.. (and that's good, because this is _heavily_
  * used by various programs)
diff --git a/kernel/timer.c b/kernel/timer.c
index fd74268..9fa626d 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1118,36 +1118,13 @@ asmlinkage long sys_gettid(void)
 	return current->pid;
 }
 
-static long __sched nanosleep_restart(struct restart_block *restart)
-{
-	unsigned long expire = restart->arg0, now = jiffies;
-	struct timespec __user *rmtp = (struct timespec __user *) restart->arg1;
-	long ret;
-
-	/* Did it expire while we handled signals? */
-	if (!time_after(expire, now))
-		return 0;
-
-	expire = schedule_timeout_interruptible(expire - now);
-
-	ret = 0;
-	if (expire) {
-		struct timespec t;
-		jiffies_to_timespec(expire, &t);
-
-		ret = -ERESTART_RESTARTBLOCK;
-		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
-			ret = -EFAULT;
-		/* The 'restart' block is already filled in */
-	}
-	return ret;
-}
-
-asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
+asmlinkage long sys_nanosleep(struct timespec __user *rqtp, 
+			      struct timespec __user *rmtp,
+			      long x1, long x2, long x3, long x4, /* FIXME */
+			      struct pt_regs *regs)
 {
 	struct timespec t;
 	unsigned long expire;
-	long ret;
 
 	if (copy_from_user(&t, rqtp, sizeof(t)))
 		return -EFAULT;
@@ -1156,22 +1133,18 @@ asmlinkage long sys_nanosleep(struct tim
 		return -EINVAL;
 
 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	expire = schedule_timeout_interruptible(expire);
+ 
+	while ((expire = schedule_timeout_interruptible(expire))) {
 
-	ret = 0;
-	if (expire) {
-		struct restart_block *restart;
-		jiffies_to_timespec(expire, &t);
-		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
-			return -EFAULT;
-
-		restart = &current_thread_info()->restart_block;
-		restart->fn = nanosleep_restart;
-		restart->arg0 = jiffies + expire;
-		restart->arg1 = (unsigned long) rmtp;
-		ret = -ERESTART_RESTARTBLOCK;
+		if (arch_do_signal(regs, &current->blocked)) {
+			jiffies_to_timespec(expire, &t);
+			if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
+				arch_set_sigframe_result(regs, -EFAULT);
+
+			return -ESIGNALLED;
+		}
 	}
-	return ret;
+	return 0;
 }
 
 /*


-- 
dwmw2


