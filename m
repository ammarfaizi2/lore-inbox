Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUGUDIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUGUDIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 23:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUGUDIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 23:08:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46028 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266458AbUGUDHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 23:07:42 -0400
Date: Tue, 20 Jul 2004 20:03:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roland Dreier <roland@topspin.com>
Cc: ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sparc64 build with CONFIG_COMPAT=n
Message-Id: <20040720200352.5c17b3f7.davem@redhat.com>
In-Reply-To: <52fz808qwy.fsf@topspin.com>
References: <52fz808qwy.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jul 2004 20:47:09 -0700
Roland Dreier <roland@topspin.com> wrote:

> I'm including the simple fix inline and attaching the big fix.

I like the big fix, and it allowed some cleanups too.
I've munged your patch a bit and this is what I'm currently
testing.

Thanks a lot.

===== arch/sparc64/Kconfig 1.52 vs edited =====
--- 1.52/arch/sparc64/Kconfig	2004-05-24 10:09:14 -07:00
+++ edited/arch/sparc64/Kconfig	2004-07-20 19:49:30 -07:00
@@ -382,6 +382,7 @@
 
 config SUNOS_EMUL
 	bool "SunOS binary emulation"
+	depends on BINFMT_AOUT32
 	help
 	  This allows you to run most SunOS binaries.  If you want to do this,
 	  say Y here and place appropriate files in /usr/gnemul/sunos. See
@@ -391,7 +392,7 @@
 
 config SOLARIS_EMUL
 	tristate "Solaris binary emulation (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on SPARC32_COMPAT && EXPERIMENTAL
 	help
 	  This is experimental code which will enable you to run (many)
 	  Solaris binaries on your SPARC Linux machine.
===== arch/sparc64/kernel/entry.S 1.34 vs edited =====
--- 1.34/arch/sparc64/kernel/entry.S	2004-06-20 12:32:28 -07:00
+++ edited/arch/sparc64/kernel/entry.S	2004-07-20 19:55:29 -07:00
@@ -1496,28 +1496,30 @@
 	/* SunOS's execv() call only specifies the argv argument, the
 	 * environment settings are the same as the calling processes.
 	 */
-	.globl	sunos_execv, sys_execve, sys32_execve
+	.globl	sunos_execv
 sys_execve:
 	sethi		%hi(sparc_execve), %g1
 	ba,pt		%xcc, execve_merge
 	 or		%g1, %lo(sparc_execve), %g1
+#ifdef CONFIG_COMPAT
+	.globl	sys_execve
 sunos_execv:
 	stx		%g0, [%sp + PTREGS_OFF + PT_V9_I2]
+	.globl	sys32_execve
 sys32_execve:
 	sethi		%hi(sparc32_execve), %g1
 	or		%g1, %lo(sparc32_execve), %g1
+#endif
 execve_merge:
 	flushw
 	jmpl		%g1, %g0
 	 add		%sp, PTREGS_OFF, %o0
 
 	.globl	sys_pipe, sys_sigpause, sys_nis_syscall
-	.globl	sys_sigsuspend, sys_rt_sigsuspend, sys32_rt_sigsuspend
+	.globl	sys_sigsuspend, sys_rt_sigsuspend
 	.globl	sys_rt_sigreturn
-	.globl	sys32_sigreturn, sys32_rt_sigreturn
-	.globl	sys32_execve, sys_ptrace
-	.globl	sys_sigaltstack, sys32_sigaltstack
-	.globl	sys32_sigstack
+	.globl	sys_ptrace
+	.globl	sys_sigaltstack
 	.align	32
 sys_pipe:	ba,pt		%xcc, sparc_pipe
 		 add		%sp, PTREGS_OFF, %o0
@@ -1528,12 +1530,15 @@
 		 add		%sp, PTREGS_OFF, %o1
 sys_sigaltstack:ba,pt		%xcc, do_sigaltstack
 		 add		%i6, STACK_BIAS, %o2
+#ifdef CONFIG_COMPAT
+	.globl	sys32_sigstack
 sys32_sigstack:	ba,pt		%xcc, do_sys32_sigstack
 		 mov		%i6, %o2
+	.globl	sys32_sigaltstack
 sys32_sigaltstack:
 		ba,pt		%xcc, do_sys32_sigaltstack
 		 mov		%i6, %o2
-
+#endif
 		.align		32
 sys_sigsuspend:	add		%sp, PTREGS_OFF, %o0
 		call		do_sigsuspend
@@ -1544,31 +1549,40 @@
 		call		do_rt_sigsuspend
 		 add		%o7, 1f-.-4, %o7
 		nop
+#ifdef CONFIG_COMPAT
+	.globl	sys32_rt_sigsuspend
 sys32_rt_sigsuspend: /* NOTE: %o0,%o1 have a correct value already */
 		srl		%o0, 0, %o0
 		add		%sp, PTREGS_OFF, %o2
 		call		do_rt_sigsuspend32
 		 add		%o7, 1f-.-4, %o7
+#endif
 		/* NOTE: %o0 has a correct value already */
 sys_sigpause:	add		%sp, PTREGS_OFF, %o1
 		call		do_sigpause
 		 add		%o7, 1f-.-4, %o7
 		nop
+#ifdef CONFIG_COMPAT
+	.globl	sys32_sigreturn
 sys32_sigreturn:
 		add		%sp, PTREGS_OFF, %o0
 		call		do_sigreturn32
 		 add		%o7, 1f-.-4, %o7
 		nop
+#endif
 sys_rt_sigreturn:
 		add		%sp, PTREGS_OFF, %o0
 		call		do_rt_sigreturn
 		 add		%o7, 1f-.-4, %o7
 		nop
+#ifdef CONFIG_COMPAT
+	.globl	sys32_rt_sigreturn
 sys32_rt_sigreturn:
 		add		%sp, PTREGS_OFF, %o0
 		call		do_rt_sigreturn32
 		 add		%o7, 1f-.-4, %o7
 		nop
+#endif
 sys_ptrace:	add		%sp, PTREGS_OFF, %o0
 		call		do_ptrace
 		 add		%o7, 1f-.-4, %o7
===== arch/sparc64/kernel/process.c 1.55 vs edited =====
--- 1.55/arch/sparc64/kernel/process.c	2004-06-01 21:42:33 -07:00
+++ edited/arch/sparc64/kernel/process.c	2004-07-20 19:13:30 -07:00
@@ -12,6 +12,7 @@
 
 #include <stdarg.h>
 
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -588,10 +589,13 @@
 
 	clone_flags &= ~CLONE_IDLETASK;
 
+#ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
 		parent_tid_ptr = compat_ptr(regs->u_regs[UREG_I2]);
 		child_tid_ptr = compat_ptr(regs->u_regs[UREG_I4]);
-	} else {
+	} else
+#endif
+	{
 		parent_tid_ptr = (int __user *) regs->u_regs[UREG_I2];
 		child_tid_ptr = (int __user *) regs->u_regs[UREG_I4];
 	}
===== arch/sparc64/kernel/signal32.c 1.38 vs edited =====
--- 1.38/arch/sparc64/kernel/signal32.c	2004-07-13 05:56:55 -07:00
+++ edited/arch/sparc64/kernel/signal32.c	2004-07-20 19:12:25 -07:00
@@ -59,6 +59,63 @@
 	unsigned int extramask[_COMPAT_NSIG_WORDS - 1];
 };
 
+typedef union sigval32 {
+	int sival_int;
+	u32 sival_ptr;
+} sigval_t32;
+
+typedef struct siginfo32 {
+	int si_signo;
+	int si_errno;
+	int si_code;
+
+	union {
+		int _pad[SI_PAD_SIZE32];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;		/* sender's pid */
+			unsigned int _uid;		/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			timer_t _tid;			/* timer id */
+			int _overrun;			/* overrun count */
+			sigval_t32 _sigval;		/* same as below */
+			int _sys_private;		/* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;		/* sender's pid */
+			unsigned int _uid;		/* sender's uid */
+			sigval_t32 _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;		/* which child */
+			unsigned int _uid;		/* sender's uid */
+			int _status;			/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
+		struct {
+			u32 _addr; /* faulting insn/memory ref. */
+			int _trapno;
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+	} _sifields;
+} siginfo_t32;
+
 /* 
  * And the new one, intended to be used for Linux applications only
  * (we have enough in there to work with clone).
@@ -76,6 +133,12 @@
 	__siginfo_fpu_t		fpu_state;
 };
 
+typedef struct sigaltstack32 {
+	u32			ss_sp;
+	int			ss_flags;
+	compat_size_t		ss_size;
+} stack_t32;
+
 struct rt_signal_frame32 {
 	struct sparc_stackf32	ss;
 	siginfo_t32		info;
@@ -95,7 +158,7 @@
 #define NF_ALIGNEDSZ  (((sizeof(struct new_signal_frame32) + 7) & (~7)))
 #define RT_ALIGNEDSZ  (((sizeof(struct rt_signal_frame32) + 7) & (~7)))
 
-int copy_siginfo_to_user32(siginfo_t32 __user *to, siginfo_t *from)
+static int copy_siginfo_to_user32(siginfo_t32 __user *to, siginfo_t *from)
 {
 	int err;
 
@@ -1370,5 +1433,106 @@
 		    __put_user(uoss.ss_flags, &((stack_t32 __user *)(long)uossa)->ss_flags) ||
 		    __put_user(uoss.ss_size, &((stack_t32 __user *)(long)uossa)->ss_size)))
 		return -EFAULT;
+	return ret;
+}
+
+asmlinkage long sys32_rt_sigtimedwait(compat_sigset_t __user *uthese,
+				      siginfo_t32 __user *uinfo,
+				      struct compat_timespec __user *uts,
+				      compat_size_t sigsetsize)
+{
+	int ret, sig;
+	sigset_t these;
+	compat_sigset_t these32;
+	struct timespec ts;
+	siginfo_t info;
+	long timeout = 0;
+
+	/* XXX: Don't preclude handling different sized sigset_t's.  */
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (copy_from_user (&these32, uthese, sizeof(compat_sigset_t)))
+		return -EFAULT;
+
+	switch (_NSIG_WORDS) {
+	case 4: these.sig[3] = these32.sig[6] | (((long)these32.sig[7]) << 32);
+	case 3: these.sig[2] = these32.sig[4] | (((long)these32.sig[5]) << 32);
+	case 2: these.sig[1] = these32.sig[2] | (((long)these32.sig[3]) << 32);
+	case 1: these.sig[0] = these32.sig[0] | (((long)these32.sig[1]) << 32);
+	}
+		
+	/*
+	 * Invert the set of allowed signals to get those we
+	 * want to block.
+	 */
+	sigdelsetmask(&these, sigmask(SIGKILL)|sigmask(SIGSTOP));
+	signotset(&these);
+
+	if (uts) {
+		if (get_compat_timespec(&ts, uts))
+			return -EINVAL;
+		if (ts.tv_nsec >= 1000000000L || ts.tv_nsec < 0
+		    || ts.tv_sec < 0)
+			return -EINVAL;
+	}
+
+	spin_lock_irq(&current->sighand->siglock);
+	sig = dequeue_signal(current, &these, &info);
+	if (!sig) {
+		timeout = MAX_SCHEDULE_TIMEOUT;
+		if (uts)
+			timeout = (timespec_to_jiffies(&ts)
+				   + (ts.tv_sec || ts.tv_nsec));
+
+		if (timeout) {
+			/* None ready -- temporarily unblock those we're
+			 * interested while we are sleeping in so that we'll
+			 * be awakened when they arrive.  */
+			current->real_blocked = current->blocked;
+			sigandsets(&current->blocked, &current->blocked, &these);
+			recalc_sigpending();
+			spin_unlock_irq(&current->sighand->siglock);
+
+			current->state = TASK_INTERRUPTIBLE;
+			timeout = schedule_timeout(timeout);
+
+			spin_lock_irq(&current->sighand->siglock);
+			sig = dequeue_signal(current, &these, &info);
+			current->blocked = current->real_blocked;
+			siginitset(&current->real_blocked, 0);
+			recalc_sigpending();
+		}
+	}
+	spin_unlock_irq(&current->sighand->siglock);
+
+	if (sig) {
+		ret = sig;
+		if (uinfo) {
+			if (copy_siginfo_to_user32(uinfo, &info))
+				ret = -EFAULT;
+		}
+	} else {
+		ret = -EAGAIN;
+		if (timeout)
+			ret = -EINTR;
+	}
+
+	return ret;
+}
+
+asmlinkage long compat_sys_rt_sigqueueinfo(int pid, int sig,
+					   siginfo_t32 __user *uinfo)
+{
+	siginfo_t info;
+	int ret;
+	mm_segment_t old_fs = get_fs();
+	
+	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
+	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE))
+		return -EFAULT;
+	set_fs (KERNEL_DS);
+	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
+	set_fs (old_fs);
 	return ret;
 }
===== arch/sparc64/kernel/sys_sparc32.c 1.103 vs edited =====
--- 1.103/arch/sparc64/kernel/sys_sparc32.c	2004-07-13 05:57:10 -07:00
+++ edited/arch/sparc64/kernel/sys_sparc32.c	2004-07-20 19:12:04 -07:00
@@ -1176,106 +1176,19 @@
 	return ret;
 }
 
-asmlinkage long sys32_rt_sigtimedwait(compat_sigset_t __user *uthese,
-				      siginfo_t32 __user *uinfo,
-				      struct compat_timespec __user *uts,
-				      compat_size_t sigsetsize)
-{
-	int ret, sig;
-	sigset_t these;
-	compat_sigset_t these32;
-	struct timespec ts;
-	siginfo_t info;
-	long timeout = 0;
-
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user (&these32, uthese, sizeof(compat_sigset_t)))
-		return -EFAULT;
-
-	switch (_NSIG_WORDS) {
-	case 4: these.sig[3] = these32.sig[6] | (((long)these32.sig[7]) << 32);
-	case 3: these.sig[2] = these32.sig[4] | (((long)these32.sig[5]) << 32);
-	case 2: these.sig[1] = these32.sig[2] | (((long)these32.sig[3]) << 32);
-	case 1: these.sig[0] = these32.sig[0] | (((long)these32.sig[1]) << 32);
-	}
-		
-	/*
-	 * Invert the set of allowed signals to get those we
-	 * want to block.
-	 */
-	sigdelsetmask(&these, sigmask(SIGKILL)|sigmask(SIGSTOP));
-	signotset(&these);
-
-	if (uts) {
-		if (get_compat_timespec(&ts, uts))
-			return -EINVAL;
-		if (ts.tv_nsec >= 1000000000L || ts.tv_nsec < 0
-		    || ts.tv_sec < 0)
-			return -EINVAL;
-	}
-
-	spin_lock_irq(&current->sighand->siglock);
-	sig = dequeue_signal(current, &these, &info);
-	if (!sig) {
-		timeout = MAX_SCHEDULE_TIMEOUT;
-		if (uts)
-			timeout = (timespec_to_jiffies(&ts)
-				   + (ts.tv_sec || ts.tv_nsec));
-
-		if (timeout) {
-			/* None ready -- temporarily unblock those we're
-			 * interested while we are sleeping in so that we'll
-			 * be awakened when they arrive.  */
-			current->real_blocked = current->blocked;
-			sigandsets(&current->blocked, &current->blocked, &these);
-			recalc_sigpending();
-			spin_unlock_irq(&current->sighand->siglock);
-
-			current->state = TASK_INTERRUPTIBLE;
-			timeout = schedule_timeout(timeout);
-
-			spin_lock_irq(&current->sighand->siglock);
-			sig = dequeue_signal(current, &these, &info);
-			current->blocked = current->real_blocked;
-			siginitset(&current->real_blocked, 0);
-			recalc_sigpending();
-		}
-	}
-	spin_unlock_irq(&current->sighand->siglock);
-
-	if (sig) {
-		ret = sig;
-		if (uinfo) {
-			if (copy_siginfo_to_user32(uinfo, &info))
-				ret = -EFAULT;
-		}
-	} else {
-		ret = -EAGAIN;
-		if (timeout)
-			ret = -EINTR;
-	}
-
-	return ret;
-}
+struct __old_sigaction32 {
+	unsigned		sa_handler;
+	compat_old_sigset_t  	sa_mask;
+	unsigned int    	sa_flags;
+	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+};
 
-asmlinkage long compat_sys_rt_sigqueueinfo(int pid, int sig,
-					   siginfo_t32 __user *uinfo)
-{
-	siginfo_t info;
-	int ret;
-	mm_segment_t old_fs = get_fs();
-	
-	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE))
-		return -EFAULT;
-	set_fs (KERNEL_DS);
-	ret = sys_rt_sigqueueinfo(pid, sig, (siginfo_t __user *) &info);
-	set_fs (old_fs);
-	return ret;
-}
+struct __new_sigaction32 {
+	unsigned		sa_handler;
+	unsigned int    	sa_flags;
+	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+	compat_sigset_t 	sa_mask;
+};
 
 asmlinkage long compat_sys_sigaction(int sig, struct old_sigaction32 __user *act,
 				     struct old_sigaction32 __user *oact)
@@ -1831,6 +1744,20 @@
 sys_timer_create(clockid_t which_clock,
 		 struct sigevent __user *timer_event_spec,
 		 timer_t __user *created_timer_id);
+
+typedef struct sigevent32 {
+	sigval_t32 sigev_value;
+	int sigev_signo;
+	int sigev_notify;
+	union {
+		int _pad[SIGEV_PAD_SIZE32];
+
+		struct {
+			u32 _function;
+			u32 _attribute;	/* really pthread_attr_t */
+		} _sigev_thread;
+	} _sigev_un;
+} sigevent_t32;
 
 long
 sys32_timer_create(u32 clock, struct sigevent32 __user *se32,
===== arch/sparc64/kernel/systbls.S 1.60 vs edited =====
--- 1.60/arch/sparc64/kernel/systbls.S	2004-06-01 21:42:33 -07:00
+++ edited/arch/sparc64/kernel/systbls.S	2004-07-20 19:56:06 -07:00
@@ -15,6 +15,7 @@
 	.text
 	.align	4
 
+#ifdef CONFIG_COMPAT
 	/* First, the 32-bit Linux native syscall table. */
 
 	.globl sys_call_table32
@@ -77,6 +78,8 @@
 	.word sys_mq_timedsend, sys_mq_timedreceive, compat_sys_mq_notify, compat_sys_mq_getsetattr, sys_ni_syscall
 /*280*/	.word sys_ni_syscall, sys_ni_syscall, sys_ni_syscall
 
+#endif /* CONFIG_COMPAT */
+
 	/* Now the 64-bit native Linux syscall table. */
 
 	.align	4
@@ -85,7 +88,7 @@
 sys_call_table:
 /*0*/	.word sys_restart_syscall, sparc_exit, sys_fork, sys_read, sys_write
 /*5*/	.word sys_open, sys_close, sys_wait4, sys_creat, sys_link
-/*10*/  .word sys_unlink, sunos_execv, sys_chdir, sys_chown, sys_mknod
+/*10*/  .word sys_unlink, sys_nis_syscall, sys_chdir, sys_chown, sys_mknod
 /*15*/	.word sys_chmod, sys_lchown, sparc_brk, sys_perfctr, sys_lseek
 /*20*/	.word sys_getpid, sys_capget, sys_capset, sys_setuid, sys_getuid
 /*25*/	.word sys_nis_syscall, sys_ptrace, sys_alarm, sys_sigaltstack, sys_nis_syscall
===== include/asm-sparc64/siginfo.h 1.15 vs edited =====
--- 1.15/include/asm-sparc64/siginfo.h	2004-05-31 16:25:29 -07:00
+++ edited/include/asm-sparc64/siginfo.h	2004-07-20 19:12:32 -07:00
@@ -12,69 +12,6 @@
 
 #include <asm-generic/siginfo.h>
 
-#ifdef __KERNEL__
-
-#include <linux/compat.h>
-
-typedef union sigval32 {
-	int sival_int;
-	u32 sival_ptr;
-} sigval_t32;
-
-typedef struct siginfo32 {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			timer_t _tid;			/* timer id */
-			int _overrun;			/* overrun count */
-			sigval_t32 _sigval;		/* same as below */
-			int _sys_private;		/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-			sigval_t32 _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			unsigned int _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			u32 _addr; /* faulting insn/memory ref. */
-			int _trapno;
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} siginfo_t32;
-
-#endif /* __KERNEL__ */
-
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
 /*
@@ -82,25 +19,5 @@
  */
 #define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
 #define NSIGEMT		1
-
-#ifdef __KERNEL__
-
-typedef struct sigevent32 {
-	sigval_t32 sigev_value;
-	int sigev_signo;
-	int sigev_notify;
-	union {
-		int _pad[SIGEV_PAD_SIZE32];
-
-		struct {
-			u32 _function;
-			u32 _attribute;	/* really pthread_attr_t */
-		} _sigev_thread;
-	} _sigev_un;
-} sigevent_t32;
-
-extern int copy_siginfo_to_user32(siginfo_t32 __user *to, siginfo_t *from);
-
-#endif /* __KERNEL__ */
 
 #endif
===== include/asm-sparc64/signal.h 1.14 vs edited =====
--- 1.14/include/asm-sparc64/signal.h	2004-07-13 05:51:54 -07:00
+++ edited/include/asm-sparc64/signal.h	2004-07-20 19:09:41 -07:00
@@ -8,7 +8,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/personality.h>
 #include <linux/types.h>
-#include <linux/compat.h>
 #endif
 #endif
 
@@ -208,13 +207,6 @@
 };
 
 #ifdef __KERNEL__
-struct __new_sigaction32 {
-	unsigned		sa_handler;
-	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-	compat_sigset_t 	sa_mask;
-};
-
 struct k_sigaction {
 	struct __new_sigaction 	sa;
 	void __user		*ka_restorer;
@@ -228,15 +220,6 @@
 	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
 };
 
-#ifdef __KERNEL__
-struct __old_sigaction32 {
-	unsigned		sa_handler;
-	compat_old_sigset_t  	sa_mask;
-	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-};
-#endif
-
 typedef struct sigaltstack {
 	void			__user *ss_sp;
 	int			ss_flags;
@@ -244,12 +227,6 @@
 } stack_t;
 
 #ifdef __KERNEL__
-typedef struct sigaltstack32 {
-	u32			ss_sp;
-	int			ss_flags;
-	compat_size_t		ss_size;
-} stack_t32;
-
 struct signal_deliver_cookie {
 	int restart_syscall;
 	unsigned long orig_i0;
===== include/asm-sparc64/ttable.h 1.8 vs edited =====
--- 1.8/include/asm-sparc64/ttable.h	2003-08-18 01:08:52 -07:00
+++ edited/include/asm-sparc64/ttable.h	2004-07-20 19:51:24 -07:00
@@ -123,7 +123,11 @@
 #else
 #define SUNOS_SYSCALL_TRAP TRAP(sunos_syscall)
 #endif
+#ifdef CONFIG_COMPAT
 #define	LINUX_32BIT_SYSCALL_TRAP SYSCALL_TRAP(linux_sparc_syscall32, sys_call_table32)
+#else
+#define	LINUX_32BIT_SYSCALL_TRAP BTRAP(0x110)
+#endif
 #define LINUX_64BIT_SYSCALL_TRAP SYSCALL_TRAP(linux_sparc_syscall, sys_call_table64)
 #define GETCC_TRAP TRAP(getcc)
 #define SETCC_TRAP TRAP(setcc)
