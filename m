Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVAGMbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVAGMbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVAGMbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:31:43 -0500
Received: from mail.renesas.com ([202.234.163.13]:15832 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261387AbVAGM37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:29:59 -0500
Date: Fri, 07 Jan 2005 21:29:50 +0900 (JST)
Message-Id: <20050107.212950.796978420.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-mm2] m32r: employ new kernel API/ABI
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to update the m32r kernel API/ABI.
Please apply.

We, Linux/M32R project members, decided to change the kernel API/ABI.
This modification is not small, but if we don't change it now,
perhaps we have no chance to change them hereafter.

* Why change the m32r kernel API/ABI?
- The m32r port has many old-style syscall interfaces,
  because we made m32r port refering to the other traditional archs.
  Some old syscalls are no longer used or can be safely removed
  by upgrading the GNU C library. 
- To make the m32r kernel more secure, it is preferable to prevent
  stack region from being executed. (e.g. stack overflow)

* API/ABI changes
- include/asm-m32r/unistd.h: Upgrade to the new kernel API.
- arch/m32r/entry.S: Minimum update to the new ABI.
- Don't use UID16 syscalls.
- To make stack noexecutable:
  1) Don't use trampoline for signal handlers for kernel space (cf. sparc64):
    sys_signal: remove.
    sys_sigaction, sys_rt_sigaction: use glibc's restorer.
  2) Don't generate trampoline code by GCC in userspace:
    Support non-executable stack by the m32r gcc.
    --> done (for gcc-3.4.3/gcc-4.0)

* New userland
- This modification does *not* keep backward compatibility.
  So we have been prepared new userland, based on the new API/ABI.
  Already, more than 200 new Debian deb binary packages are available
  on the Linux/M32R site:
  http://debian.linux-m32r.org/dists/04_ordovician/ (for this new ABI)

Regards,

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Kconfig         |    2 
 arch/m32r/kernel/entry.S  |   90 ++++++++---------
 arch/m32r/kernel/signal.c |  187 -----------------------------------
 include/asm-m32r/unistd.h |  241 ++++++++++++++++++++++------------------------
 4 files changed, 164 insertions(+), 356 deletions(-)


diff -ruNp a/arch/m32r/Kconfig b/arch/m32r/Kconfig
--- a/arch/m32r/Kconfig	2005-01-06 18:06:38.000000000 +0900
+++ b/arch/m32r/Kconfig	2005-01-07 14:28:45.000000000 +0900
@@ -14,7 +14,7 @@ config SBUS
 
 config UID16
 	bool
-	default y
+	default n
 
 config GENERIC_ISA_DMA
 	bool
diff -ruNp a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
--- a/arch/m32r/kernel/entry.S	2004-12-25 06:35:28.000000000 +0900
+++ b/arch/m32r/kernel/entry.S	2005-01-07 14:28:45.000000000 +0900
@@ -725,25 +725,25 @@ ENTRY(sys_call_table)
 	.long sys_time
 	.long sys_mknod
 	.long sys_chmod			/* 15 */
-	.long sys_lchown
+	.long sys_ni_syscall		/* lchown16 syscall holder */
 	.long sys_ni_syscall		/* old break syscall holder */
-	.long sys_stat
+	.long sys_ni_syscall		/* old stat syscall holder */
 	.long sys_lseek
 	.long sys_getpid		/* 20 */
 	.long sys_mount
 	.long sys_oldumount
-	.long sys_setuid
-	.long sys_getuid
+	.long sys_ni_syscall		/* setuid16 syscall holder */
+	.long sys_ni_syscall		/* getuid16 syscall holder */
 	.long sys_stime			/* 25 */
 	.long sys_ptrace
 	.long sys_alarm
-	.long sys_fstat
+	.long sys_ni_syscall		/* old fstat syscall holder */
 	.long sys_pause
 	.long sys_utime			/* 30 */
-	.long sys_cacheflush		/* for M32R */ /* old stty syscall holder */
+	.long sys_ni_syscall		/* old stty syscall holder */
 	.long sys_cachectl		/* for M32R */ /* old gtty syscall holder */
 	.long sys_access
-	.long sys_nice
+	.long sys_ni_syscall		/* nice	syscall holder */
 	.long sys_ni_syscall		/* 35  -  old ftime syscall holder */
 	.long sys_sync
 	.long sys_kill
@@ -755,17 +755,17 @@ ENTRY(sys_call_table)
 	.long sys_times
 	.long sys_ni_syscall		/* old prof syscall holder */
 	.long sys_brk			/* 45 */
-	.long sys_setgid
-	.long sys_getgid
-	.long sys_signal
-	.long sys_geteuid
-	.long sys_getegid		/* 50 */
+	.long sys_ni_syscall		/* setgid16 syscall holder */
+	.long sys_getgid		/* will be unused */
+	.long sys_ni_syscall		/* signal syscall holder */
+	.long sys_ni_syscall		/* geteuid16  syscall holder */
+	.long sys_ni_syscall		/* 50 - getegid16 syscall holder */
 	.long sys_acct
 	.long sys_umount		/* recycled never used phys() */
 	.long sys_ni_syscall		/* old lock syscall holder */
 	.long sys_ioctl
-	.long sys_fcntl			/* 55 */
-	.long sys_ni_syscall		/* old mpx syscall holder */
+	.long sys_fcntl			/* 55 - will be unused */
+	.long sys_ni_syscall		/* mpx syscall holder */
 	.long sys_setpgid
 	.long sys_ni_syscall		/* old ulimit syscall holder */
 	.long sys_ni_syscall		/* sys_olduname */
@@ -776,41 +776,41 @@ ENTRY(sys_call_table)
 	.long sys_getppid
 	.long sys_getpgrp		/* 65 */
 	.long sys_setsid
-	.long sys_sigaction
-	.long sys_sgetmask
-	.long sys_ssetmask
-	.long sys_setreuid		/* 70 */
-	.long sys_setregid
-	.long sys_sigsuspend
-	.long sys_sigpending
+	.long sys_ni_syscall		/* sigaction syscall holder */
+	.long sys_ni_syscall		/* sgetmask syscall holder */
+	.long sys_ni_syscall		/* ssetmask syscall holder */
+	.long sys_ni_syscall		/* 70 - setreuid16 syscall holder */
+	.long sys_ni_syscall		/* setregid16 syscall holder */
+	.long sys_ni_syscall		/* sigsuspend syscall holder */
+	.long sys_ni_syscall		/* sigpending syscall holder */
 	.long sys_sethostname
 	.long sys_setrlimit		/* 75 */
-	.long sys_getrlimit
+	.long sys_getrlimit/*will be unused*/
 	.long sys_getrusage
 	.long sys_gettimeofday
 	.long sys_settimeofday
-	.long sys_getgroups		/* 80 */
-	.long sys_setgroups
+	.long sys_ni_syscall		/* 80 - getgroups16 syscall holder */
+	.long sys_ni_syscall		/* setgroups16 syscall holder */
 	.long sys_ni_syscall		/* sys_oldselect */
 	.long sys_symlink
-	.long sys_lstat
+	.long sys_ni_syscall		/* old lstat syscall holder */
 	.long sys_readlink		/* 85 */
 	.long sys_uselib
 	.long sys_swapon
 	.long sys_reboot
-	.long old_readdir
+	.long sys_ni_syscall		/* readdir syscall holder */
 	.long sys_ni_syscall		/* 90 - old_mmap syscall holder */
 	.long sys_munmap
 	.long sys_truncate
 	.long sys_ftruncate
 	.long sys_fchmod
-	.long sys_fchown		/* 95 */
+	.long sys_ni_syscall		/* 95 - fchwon16  syscall holder */
 	.long sys_getpriority
 	.long sys_setpriority
 	.long sys_ni_syscall		/* old profil syscall holder */
 	.long sys_statfs
 	.long sys_fstatfs		/* 100 */
-	.long sys_ni_syscall		/* ioperm */
+	.long sys_ni_syscall		/* ioperm syscall holder */
 	.long sys_socketcall
 	.long sys_syslog
 	.long sys_setitimer
@@ -818,37 +818,37 @@ ENTRY(sys_call_table)
 	.long sys_newstat
 	.long sys_newlstat
 	.long sys_newfstat
-	.long sys_uname
-	.long sys_ni_syscall		/* 110  -  iopl */
+	.long sys_ni_syscall		/* old uname syscall holder */
+	.long sys_ni_syscall		/* 110  -  iopl syscall holder */
 	.long sys_vhangup
-	.long sys_ni_syscall		/* for idle */
-	.long sys_ni_syscall		/* for vm86old */
+	.long sys_ni_syscall		/* idle syscall holder */
+	.long sys_ni_syscall		/* vm86old syscall holder */
 	.long sys_wait4
 	.long sys_swapoff		/* 115 */
 	.long sys_sysinfo
 	.long sys_ipc
 	.long sys_fsync
-	.long sys_sigreturn
+	.long sys_ni_syscall		/* sigreturn syscall holder */
 	.long sys_clone			/* 120 */
 	.long sys_setdomainname
 	.long sys_newuname
-	.long sys_ni_syscall		/* sys_modify_ldt */
+	.long sys_ni_syscall		/* modify_ldt syscall holder */
 	.long sys_adjtimex
 	.long sys_mprotect		/* 125 */
-	.long sys_sigprocmask
-	.long sys_ni_syscall		/* sys_create_module */
+	.long sys_ni_syscall		/* sigprocmask syscall holder */
+	.long sys_ni_syscall		/* create_module syscall holder */
 	.long sys_init_module
 	.long sys_delete_module
-	.long sys_ni_syscall		/* 130 sys_get_kernel_syms */
+	.long sys_ni_syscall		/* 130 - get_kernel_syms */
 	.long sys_quotactl
 	.long sys_getpgid
 	.long sys_fchdir
 	.long sys_bdflush
 	.long sys_sysfs			/* 135 */
 	.long sys_personality
-	.long sys_ni_syscall		/* for afs_syscall */
-	.long sys_setfsuid
-	.long sys_setfsgid
+	.long sys_ni_syscall		/* afs_syscall syscall holder */
+	.long sys_ni_syscall		/* setfsuid16 syscall holder */
+	.long sys_ni_syscall		/* setfsgid16 syscall holder */
 	.long sys_llseek		/* 140 */
 	.long sys_getdents
 	.long sys_select
@@ -873,10 +873,10 @@ ENTRY(sys_call_table)
 	.long sys_sched_rr_get_interval
 	.long sys_nanosleep
 	.long sys_mremap
-	.long sys_setresuid
-	.long sys_getresuid		/* 165 */
-	.long sys_tas			/* vm86 */
-	.long sys_ni_syscall		/* sys_query_module */
+	.long sys_ni_syscall		/* setresuid16 syscall holder */
+	.long sys_ni_syscall		/* 165 - getresuid16 syscall holder */
+	.long sys_tas			/* vm86 syscall holder */
+	.long sys_ni_syscall		/* query_module syscall holder */
 	.long sys_poll
 	.long sys_nfsservctl
 	.long sys_setresgid		/* 170 */
@@ -891,7 +891,7 @@ ENTRY(sys_call_table)
 	.long sys_rt_sigsuspend
 	.long sys_pread64		/* 180 */
 	.long sys_pwrite64
-	.long sys_chown
+	.long sys_ni_syscall		/* chown16 syscall holder */
 	.long sys_getcwd
 	.long sys_capget
 	.long sys_capset		/* 185 */
diff -ruNp a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
--- a/arch/m32r/kernel/signal.c	2004-12-25 06:34:32.000000000 +0900
+++ b/arch/m32r/kernel/signal.c	2005-01-07 14:28:45.000000000 +0900
@@ -33,32 +33,6 @@
 
 int do_signal(struct pt_regs *, sigset_t *);
 
-/*
- * Atomically swap in the new signal mask, and wait for a signal.
- */
-asmlinkage int
-sys_sigsuspend(old_sigset_t mask, unsigned long r1,
-	       unsigned long r2, unsigned long r3, unsigned long r4,
-	       unsigned long r5, unsigned long r6, struct pt_regs regs)
-{
-	sigset_t saveset;
-
-	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	siginitset(&current->blocked, mask);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	regs.r0 = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&regs, &saveset))
-			return regs.r0;
-	}
-}
-
 asmlinkage int
 sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize,
 		  unsigned long r2, unsigned long r3, unsigned long r4,
@@ -90,38 +64,6 @@ sys_rt_sigsuspend(sigset_t *unewset, siz
 }
 
 asmlinkage int
-sys_sigaction(int sig, const struct old_sigaction __user *act,
-	      struct old_sigaction __user *oact)
-{
-	struct k_sigaction new_ka, old_ka;
-	int ret;
-
-	if (act) {
-		old_sigset_t mask;
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
-		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
-		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
-			return -EFAULT;
-		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
-		__get_user(mask, &act->sa_mask);
-		siginitset(&new_ka.sa.sa_mask, mask);
-	}
-
-	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
-
-	if (!ret && oact) {
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
-		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
-		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
-			return -EFAULT;
-		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
-		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
-	}
-
-	return ret;
-}
-
-asmlinkage int
 sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
 		unsigned long r2, unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, struct pt_regs regs)
@@ -134,26 +76,14 @@ sys_sigaltstack(const stack_t __user *us
  * Do a signal return; undo the signal stack.
  */
 
-struct sigframe
-{
-//	char *pretcode;
-	int sig;
-	struct sigcontext sc;
-//	struct _fpstate fpstate;
-	unsigned long extramask[_NSIG_WORDS-1];
-	char retcode[4];
-};
-
 struct rt_sigframe
 {
-//	char *pretcode;
 	int sig;
 	struct siginfo *pinfo;
 	void *puc;
 	struct siginfo info;
 	struct ucontext uc;
 //	struct _fpstate fpstate;
-	char retcode[8];
 };
 
 static int
@@ -208,38 +138,6 @@ restore_sigcontext(struct pt_regs *regs,
 }
 
 asmlinkage int
-sys_sigreturn(unsigned long r0, unsigned long r1,
-	      unsigned long r2, unsigned long r3, unsigned long r4,
-	      unsigned long r5, unsigned long r6, struct pt_regs regs)
-{
-	struct sigframe __user *frame = (struct sigframe __user *)regs.spu;
-	sigset_t set;
-	int result;
-
-	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || (_NSIG_WORDS > 1
-		&& __copy_from_user(&set.sig[1], &frame->extramask,
-				    sizeof(frame->extramask))))
-		goto badframe;
-
-	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
-	current->blocked = set;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	if (restore_sigcontext(&regs, &frame->sc, &result))
-		goto badframe;
-	return result;
-
-badframe:
-	force_sig(SIGSEGV, current);
-	return 0;
-}
-
-asmlinkage int
 sys_rt_sigreturn(unsigned long r0, unsigned long r1,
 		 unsigned long r2, unsigned long r3, unsigned long r4,
 		 unsigned long r5, unsigned long r6, struct pt_regs regs)
@@ -342,71 +240,6 @@ get_sigframe(struct k_sigaction *ka, uns
 	return (void __user *)((sp - frame_size) & -8ul);
 }
 
-static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs *regs)
-{
-	struct sigframe __user *frame;
-	int err = 0;
-	int signal;
-
-	frame = get_sigframe(ka, regs->spu, sizeof(*frame));
-
-	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
-		goto give_sigsegv;
-
-	signal = current_thread_info()->exec_domain
-		&& current_thread_info()->exec_domain->signal_invmap
-		&& sig < 32
-		? current_thread_info()->exec_domain->signal_invmap[sig]
-		: sig;
-
-	err |= __put_user(signal, &frame->sig);
-	if (err)
-		goto give_sigsegv;
-
-	err |= setup_sigcontext(&frame->sc, regs, set->sig[0]);
-	if (err)
-		goto give_sigsegv;
-
-	if (_NSIG_WORDS > 1) {
-		err |= __copy_to_user(frame->extramask, &set->sig[1],
-				      sizeof(frame->extramask));
-		if (err)
-			goto give_sigsegv;
-	}
-
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->lr = (unsigned long)ka->sa.sa_restorer;
-	else {
-		/* This is : ldi r7, #__NR_sigreturn ; trap #2 */
-		unsigned long code = 0x670010f2 | (__NR_sigreturn << 16);
-
-		regs->lr = (unsigned long)frame->retcode;
-		err |= __put_user(code, (long __user *)(frame->retcode+0));
-		if (err)
-			goto give_sigsegv;
-		flush_cache_sigtramp((unsigned long)frame->retcode);
-	}
-
-	/* Set up registers for signal handler */
-	regs->spu = (unsigned long)frame;
-	regs->r0 = signal;	/* Arg for signal handler */
-	regs->r1 = (unsigned long)&frame->sc;
-	regs->bpc = (unsigned long)ka->sa.sa_handler;
-
-	set_fs(USER_DS);
-
-#if DEBUG_SIG
-	printk("SIG deliver (%s:%d): sp=%p pc=%p\n",
-		current->comm, current->pid, frame, regs->pc);
-#endif
-
-	return;
-
-give_sigsegv:
-	force_sigsegv(sig, current);
-}
-
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 			   sigset_t *set, struct pt_regs *regs)
 {
@@ -448,20 +281,7 @@ static void setup_rt_frame(int sig, stru
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	if (ka->sa.sa_flags & SA_RESTORER)
-		regs->lr = (unsigned long)ka->sa.sa_restorer;
-	else {
-		/* This is : ldi r7, #__NR_rt_sigreturn ; trap #2 */
-		unsigned long code1 = 0x97f00000 | (__NR_rt_sigreturn);
-		unsigned long code2 = 0x10f2f000;
-
-		regs->lr = (unsigned long)frame->retcode;
-		err |= __put_user(code1, (long __user *)(frame->retcode+0));
-		err |= __put_user(code2, (long __user *)(frame->retcode+4));
-		if (err)
-			goto give_sigsegv;
-		flush_cache_sigtramp((unsigned long)frame->retcode);
-	}
+	regs->lr = (unsigned long)ka->sa.sa_restorer;
 
 	/* Set up registers for signal handler */
 	regs->spu = (unsigned long)frame;
@@ -519,10 +339,7 @@ handle_signal(unsigned long sig, struct 
 	}
 
 	/* Set up the stack frame */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(sig, ka, info, oldset, regs);
-	else
-		setup_frame(sig, ka, oldset, regs);
+	setup_rt_frame(sig, ka, info, oldset, regs);
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
diff -ruNp a/include/asm-m32r/unistd.h b/include/asm-m32r/unistd.h
--- a/include/asm-m32r/unistd.h	2004-12-25 06:35:00.000000000 +0900
+++ b/include/asm-m32r/unistd.h	2005-01-07 14:28:45.000000000 +0900
@@ -25,26 +25,26 @@
 #define __NR_time		 13
 #define __NR_mknod		 14
 #define __NR_chmod		 15
-#define __NR_lchown		 16
-#define __NR_break		 17
-#define __NR_oldstat		 18
+/* 16 is unused */
+/* 17 is unused */
+/* 18 is unused */
 #define __NR_lseek		 19
 #define __NR_getpid		 20
 #define __NR_mount		 21
 #define __NR_umount		 22
-#define __NR_setuid		 23
-#define __NR_getuid		 24
+/* 23 is unused */
+/* 24 is unused */
 #define __NR_stime		 25
 #define __NR_ptrace		 26
 #define __NR_alarm		 27
-#define __NR_oldfstat		 28
+/* 28 is unused */
 #define __NR_pause		 29
 #define __NR_utime		 30
-#define __NR_cacheflush		 31 /* old #define __NR_stty		 31*/
+/* 31 is unused */
 #define __NR_cachectl		 32 /* old #define __NR_gtty		 32*/
 #define __NR_access		 33
-#define __NR_nice		 34
-#define __NR_ftime		 35
+/* 34 is unused */
+/* 35 is unused */
 #define __NR_sync		 36
 #define __NR_kill		 37
 #define __NR_rename		 38
@@ -53,22 +53,22 @@
 #define __NR_dup		 41
 #define __NR_pipe		 42
 #define __NR_times		 43
-#define __NR_prof		 44
+/* 44 is unused */
 #define __NR_brk		 45
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_signal		 48
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
+/* 46 is unused */
+/* 47 is unused (getgid16) */
+/* 48 is unused */
+/* 49 is unused */
+/* 50 is unused */
 #define __NR_acct		 51
 #define __NR_umount2		 52
-#define __NR_lock		 53
+/* 53 is unused */
 #define __NR_ioctl		 54
-#define __NR_fcntl		 55
-#define __NR_mpx		 56
+/* 55 is unused (fcntl) */
+/* 56 is unused */
 #define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
+/* 58 is unused */
+/* 59 is unused */
 #define __NR_umask		 60
 #define __NR_chroot		 61
 #define __NR_ustat		 62
@@ -76,41 +76,41 @@
 #define __NR_getppid		 64
 #define __NR_getpgrp		 65
 #define __NR_setsid		 66
-#define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_sigsuspend		 72
-#define __NR_sigpending		 73
+/* 67 is unused */
+/* 68 is unused*/
+/* 69 is unused*/
+/* 70 is unused */
+/* 71 is unused */
+/* 72 is unused */
+/* 73 is unused */
 #define __NR_sethostname	 74
 #define __NR_setrlimit		 75
-#define __NR_getrlimit		 76	/* Back compatible 2Gig limited rlimit */
+/* 76 is unused (old getrlimit) */
 #define __NR_getrusage		 77
 #define __NR_gettimeofday	 78
 #define __NR_settimeofday	 79
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-#define __NR_select		 82
+/* 80 is unused */
+/* 81 is unused */
+/* 82 is unused */
 #define __NR_symlink		 83
-#define __NR_oldlstat		 84
+/* 84 is unused */
 #define __NR_readlink		 85
 #define __NR_uselib		 86
 #define __NR_swapon		 87
 #define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
+/* 89 is unused */
+/* 90 is unused */
 #define __NR_munmap		 91
 #define __NR_truncate		 92
 #define __NR_ftruncate		 93
 #define __NR_fchmod		 94
-#define __NR_fchown		 95
+/* 95 is unused */
 #define __NR_getpriority	 96
 #define __NR_setpriority	 97
-#define __NR_profil		 98
+/* 98 is unused */
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+/* 101 is unused */
 #define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -118,37 +118,37 @@
 #define __NR_stat		106
 #define __NR_lstat		107
 #define __NR_fstat		108
-#define __NR_olduname		109
-#define __NR_iopl		110
+/* 109 is unused */
+/* 110 is unused */
 #define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86old		113
+/* 112 is unused */
+/* 113 is unused */
 #define __NR_wait4		114
 #define __NR_swapoff		115
 #define __NR_sysinfo		116
 #define __NR_ipc		117
 #define __NR_fsync		118
-#define __NR_sigreturn		119
+/* 119 is unused */
 #define __NR_clone		120
 #define __NR_setdomainname	121
 #define __NR_uname		122
-#define __NR_modify_ldt		123
+/* 123 is unused */
 #define __NR_adjtimex		124
 #define __NR_mprotect		125
-#define __NR_sigprocmask	126
-#define __NR_create_module	127
+/* 126 is unused */
+/* 127 is unused */
 #define __NR_init_module	128
 #define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
+/* 130 is unused */
 #define __NR_quotactl		131
 #define __NR_getpgid		132
 #define __NR_fchdir		133
 #define __NR_bdflush		134
 #define __NR_sysfs		135
 #define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
+/* 137 is unused */
+/* 138 is unused */
+/* 139 is unused */
 #define __NR__llseek		140
 #define __NR_getdents		141
 #define __NR__newselect		142
@@ -173,14 +173,14 @@
 #define __NR_sched_rr_get_interval	161
 #define __NR_nanosleep		162
 #define __NR_mremap		163
-#define __NR_setresuid		164
-#define __NR_getresuid		165
+/* 164 is unused */
+/* 165 is unused */
 #define __NR_tas		166
-#define __NR_query_module	167
+/* 167 is unused */
 #define __NR_poll		168
 #define __NR_nfsservctl		169
-#define __NR_setresgid		170
-#define __NR_getresgid		171
+/* 170 is unused */
+/* 171 is unused */
 #define __NR_prctl              172
 #define __NR_rt_sigreturn	173
 #define __NR_rt_sigaction	174
@@ -191,14 +191,14 @@
 #define __NR_rt_sigsuspend	179
 #define __NR_pread64		180
 #define __NR_pwrite64		181
-#define __NR_chown		182
+/* 182 is unused */
 #define __NR_getcwd		183
 #define __NR_capget		184
 #define __NR_capset		185
 #define __NR_sigaltstack	186
 #define __NR_sendfile		187
-#define __NR_getpmsg		188	/* some people actually want streams */
-#define __NR_putpmsg		189	/* some people actually want streams */
+/* 188 is unused */
+/* 189 is unused */
 #define __NR_vfork		190
 #define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
 #define __NR_mmap2		192
@@ -229,71 +229,71 @@
 #define __NR_pivot_root		217
 #define __NR_mincore		218
 #define __NR_madvise		219
-#define __NR_madvise1		219	/* delete when C lib stub is removed */
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
-#define __NR_security           223     /* syscall for security modules */
-#define __NR_gettid             224
-#define __NR_readahead          225
-#define __NR_setxattr           226
-#define __NR_lsetxattr          227
-#define __NR_fsetxattr          228
-#define __NR_getxattr           229
-#define __NR_lgetxattr          230
-#define __NR_fgetxattr          231
-#define __NR_listxattr          232
-#define __NR_llistxattr         233
-#define __NR_flistxattr         234
-#define __NR_removexattr        235
-#define __NR_lremovexattr       236
-#define __NR_fremovexattr       237
+/* 222 is unused */
+/* 223 is unused */
+#define __NR_gettid		224
+#define __NR_readahead		225
+#define __NR_setxattr		226
+#define __NR_lsetxattr		227
+#define __NR_fsetxattr		228
+#define __NR_getxattr		229
+#define __NR_lgetxattr		230
+#define __NR_fgetxattr		231
+#define __NR_listxattr		232
+#define __NR_llistxattr		233
+#define __NR_flistxattr		234
+#define __NR_removexattr	235
+#define __NR_lremovexattr	236
+#define __NR_fremovexattr	237
 #define __NR_tkill		238
 #define __NR_sendfile64		239
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
-#define __NR_set_thread_area    243
-#define __NR_get_thread_area    244
-#define __NR_io_setup           245
-#define __NR_io_destroy         246
-#define __NR_io_getevents       247
-#define __NR_io_submit          248
-#define __NR_io_cancel          249
-#define __NR_fadvise64          250
-
-#define __NR_exit_group         252
-#define __NR_lookup_dcookie     253
-#define __NR_epoll_create       254
-#define __NR_epoll_ctl          255
-#define __NR_epoll_wait         256
-#define __NR_remap_file_pages   257
-#define __NR_set_tid_address    258
-#define __NR_timer_create       259
-#define __NR_timer_settime      (__NR_timer_create+1)
-#define __NR_timer_gettime      (__NR_timer_create+2)
-#define __NR_timer_getoverrun   (__NR_timer_create+3)
-#define __NR_timer_delete       (__NR_timer_create+4)
-#define __NR_clock_settime      (__NR_timer_create+5)
-#define __NR_clock_gettime      (__NR_timer_create+6)
-#define __NR_clock_getres       (__NR_timer_create+7)
-#define __NR_clock_nanosleep    (__NR_timer_create+8)
-#define __NR_statfs64           268
-#define __NR_fstatfs64          269
-#define __NR_tgkill             270
-#define __NR_utimes             271
-#define __NR_fadvise64_64       272
-#define __NR_vserver            273
-#define __NR_mbind              274
-#define __NR_get_mempolicy      275
-#define __NR_set_mempolicy      276
-#define __NR_mq_open            277
-#define __NR_mq_unlink          (__NR_mq_open+1)
-#define __NR_mq_timedsend       (__NR_mq_open+2)
-#define __NR_mq_timedreceive    (__NR_mq_open+3)
-#define __NR_mq_notify          (__NR_mq_open+4)
-#define __NR_mq_getsetattr      (__NR_mq_open+5)
-#define __NR_sys_kexec_load    283
-#define __NR_waitid            284
+#define __NR_set_thread_area	243
+#define __NR_get_thread_area	244
+#define __NR_io_setup		245
+#define __NR_io_destroy		246
+#define __NR_io_getevents	247
+#define __NR_io_submit		248
+#define __NR_io_cancel		249
+#define __NR_fadvise64		250
+/* 251 is unused */
+#define __NR_exit_group		252
+#define __NR_lookup_dcookie	253
+#define __NR_epoll_create	254
+#define __NR_epoll_ctl		255
+#define __NR_epoll_wait		256
+#define __NR_remap_file_pages	257
+#define __NR_set_tid_address	258
+#define __NR_timer_create	259
+#define __NR_timer_settime	(__NR_timer_create+1)
+#define __NR_timer_gettime	(__NR_timer_create+2)
+#define __NR_timer_getoverrun	(__NR_timer_create+3)
+#define __NR_timer_delete	(__NR_timer_create+4)
+#define __NR_clock_settime	(__NR_timer_create+5)
+#define __NR_clock_gettime	(__NR_timer_create+6)
+#define __NR_clock_getres	(__NR_timer_create+7)
+#define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_statfs64		268
+#define __NR_fstatfs64		269
+#define __NR_tgkill		270
+#define __NR_utimes		271
+#define __NR_fadvise64_64	272
+#define __NR_vserver		273
+#define __NR_mbind		274
+#define __NR_get_mempolicy	275
+#define __NR_set_mempolicy	276
+#define __NR_mq_open		277
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getsetattr	(__NR_mq_open+5)
+#define __NR_sys_kexec_load	283
+#define __NR_waitid		284
 
 #define NR_syscalls 285
 
@@ -407,14 +407,10 @@ __syscall_return(type,__res); \
 
 #ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION
-#define __ARCH_WANT_OLD_READDIR
-#define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
-#define __ARCH_WANT_SYS_SGETMASK
-#define __ARCH_WANT_SYS_SIGNAL
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
@@ -422,11 +418,8 @@ __syscall_return(type,__res); \
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_LLSEEK
-#define __ARCH_WANT_SYS_NICE
-#define __ARCH_WANT_SYS_OLD_GETRLIMIT
+#define __ARCH_WANT_SYS_OLD_GETRLIMIT /*will be unused*/
 #define __ARCH_WANT_SYS_OLDUMOUNT
-#define __ARCH_WANT_SYS_SIGPENDING
-#define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
 #endif
 
@@ -451,7 +444,6 @@ __syscall_return(type,__res); \
  */
 static __inline__ _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
 
-asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount);
 asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 			  unsigned long prot, unsigned long flags,
 			  unsigned long fd, unsigned long pgoff);
@@ -461,7 +453,6 @@ asmlinkage int sys_fork(struct pt_regs r
 asmlinkage int sys_vfork(struct pt_regs regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
-asmlinkage long sys_iopl(unsigned long unused);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				 const struct sigaction __user *act,

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
