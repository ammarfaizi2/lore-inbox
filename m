Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSEQG6P>; Fri, 17 May 2002 02:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSEQG6O>; Fri, 17 May 2002 02:58:14 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9881 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315439AbSEQG6A>;
	Fri, 17 May 2002 02:58:00 -0400
Date: Fri, 17 May 2002 16:57:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] signal cleanups continued: cleanup do_signal
Message-Id: <20020517165712.56950189.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

11 out of our 17 architectures have basically the same code
in arch/../kernel/signal.c:do_signal.  This patch creates a
common function for that bit of code and uses it in the places
it can be.

This builds and runs on i386 and PPC and has been briefly looked
at by the CRIS, PARISC, PPC64 and x86_64 maintainers.

As a bonus, this fixes the "ignore SIGURG" bug for 9 more architectures
(i386 and PPC already were fixed).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.15/arch/cris/kernel/signal.c 2.5.15-si.5/arch/cris/kernel/signal.c
--- 2.5.15/arch/cris/kernel/signal.c	Wed Feb 20 16:36:36 2002
+++ 2.5.15-si.5/arch/cris/kernel/signal.c	Fri May 17 00:55:44 2002
@@ -518,9 +518,11 @@
  */	
 
 static inline void
-handle_signal(int canrestart, unsigned long sig, struct k_sigaction *ka,
+handle_signal(int canrestart, unsigned long sig,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	/* Are we from a system call? */
 	if (canrestart) {
 		/* If so, check system call restarting.. */
@@ -580,7 +582,7 @@
 int do_signal(int canrestart, sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
 
 	/*
 	 * We want the common case to go fast, which
@@ -594,98 +596,10 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				lock_kernel();
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(canrestart, signr, ka, &info, oldset, regs);
+		handle_signal(canrestart, signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/i386/kernel/signal.c 2.5.15-si.5/arch/i386/kernel/signal.c
--- 2.5.15/arch/i386/kernel/signal.c	Fri May 10 09:35:06 2002
+++ 2.5.15-si.5/arch/i386/kernel/signal.c	Fri May 17 00:03:09 2002
@@ -18,9 +18,7 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/tty.h>
 #include <linux/personality.h>
-#include <linux/binfmts.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -534,9 +532,11 @@
  */	
 
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
@@ -583,7 +583,7 @@
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
 
 	/*
 	 * We want the common case to go fast, which
@@ -597,98 +597,8 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->parent->pid;
-				info.si_uid = current->parent->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH: case SIGURG:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP: {
-				struct signal_struct *sig;
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				sig = current->parent->sig;
-				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-			}
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
 		 * have been cleared if the watchpoint triggered
@@ -697,7 +607,7 @@
 		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/mips/kernel/signal.c 2.5.15-si.5/arch/mips/kernel/signal.c
--- 2.5.15/arch/mips/kernel/signal.c	Mon Apr 15 10:44:54 2002
+++ 2.5.15-si.5/arch/mips/kernel/signal.c	Thu May 16 12:05:50 2002
@@ -522,9 +522,11 @@
 }
 
 static inline void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+		struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame(ka, regs, sig, oldset, info);
 	else
@@ -566,8 +568,8 @@
 
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka;
 	siginfo_t info;
+	int sig_nr;
 
 #ifdef CONFIG_BINFMT_IRIX
 	if (current->personality != PER_LINUX)
@@ -577,99 +579,12 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		if (regs->regs[0])
 			syscall_restart(regs, ka);
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/mips64/kernel/signal.c 2.5.15-si.5/arch/mips64/kernel/signal.c
--- 2.5.15/arch/mips64/kernel/signal.c	Wed Feb 20 16:36:37 2002
+++ 2.5.15-si.5/arch/mips64/kernel/signal.c	Thu May 16 12:11:28 2002
@@ -543,10 +543,11 @@
 	force_sig(SIGSEGV, current);
 }
 
-static inline void handle_signal(unsigned long sig, struct k_sigaction *ka,
-				 siginfo_t *info, sigset_t *oldset,
-				 struct pt_regs *regs)
+static inline void handle_signal(unsigned long sig, siginfo_t *info,
+		sigset_t *oldset, struct pt_regs *regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame(ka, regs, sig, oldset, info);
 	else
@@ -589,8 +590,8 @@
 
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka;
 	siginfo_t info;
+	int signr;
 
 #ifdef CONFIG_BINFMT_ELF32
 	if (current->thread.mflags & MF_32BIT) {
@@ -601,99 +602,12 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		if (regs->regs[0])
 			syscall_restart(regs, ka);
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/mips64/kernel/signal32.c 2.5.15-si.5/arch/mips64/kernel/signal32.c
--- 2.5.15/arch/mips64/kernel/signal32.c	Wed Feb 20 16:36:37 2002
+++ 2.5.15-si.5/arch/mips64/kernel/signal32.c	Thu May 16 14:14:18 2002
@@ -625,9 +625,11 @@
 }
 
 static inline void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig siginfo_t *info, sigset_t *oldset,
+		struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame(ka, regs, sig, oldset, info);
 	else
@@ -667,105 +669,18 @@
 
 asmlinkage int do_signal32(sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka;
 	siginfo_t info;
+	int signr;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		if (regs->regs[0])
 			syscall_restart(regs, ka);
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/parisc/kernel/signal.c 2.5.15-si.5/arch/parisc/kernel/signal.c
--- 2.5.15/arch/parisc/kernel/signal.c	Wed Feb 20 16:36:37 2002
+++ 2.5.15-si.5/arch/parisc/kernel/signal.c	Thu May 16 23:19:11 2002
@@ -432,10 +432,11 @@
  */	
 
 static long
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset,
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	      struct pt_regs *regs, int in_syscall)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 #if DEBUG_SIG
 	printk("handle_signal(sig=%ld, ka=%p, info=%p, oldset=%p, regs=%p)\n",
 	       sig, ka, info, oldset, regs);
@@ -473,6 +474,7 @@
 {
 	siginfo_t info;
 	struct k_sigaction *ka;
+	int signr;
 
 #if DEBUG_SIG
 	printk("do_signal(oldset=0x%p, regs=0x%p, sr7 %#lx, pending %d, in_syscall=%d\n",
@@ -490,102 +492,8 @@
 	printk("do_signal: oldset %08lx:%08lx\n", oldset->sig[0], oldset->sig[1]);
 #endif
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-#if DEBUG_SIG
-		printk("do_signal: signr=%ld, pid=%d\n", signr, current->pid);
-#endif
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			set_current_state(TASK_STOPPED);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-#if DEBUG_SIG
-		printk("sa_handler is %lx\n", ka->sa.sa_handler);
-#endif
-		if ((unsigned long) ka->sa.sa_handler == (unsigned long) SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if ((unsigned long) ka->sa.sa_handler == (unsigned long) SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				set_current_state(TASK_STOPPED);
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (signr == SIGQUIT) /* Userspace debugging */
-					show_regs(regs);
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Restart a system call if necessary. */
 		if (in_syscall) {
 			/* Check the return code */
@@ -598,6 +506,7 @@
 				break;
 
 			case -ERESTARTSYS:
+				ka = &current->sig->action[signr-1];
 				if (!(ka->sa.sa_flags & SA_RESTART)) {
 #if DEBUG_SIG
 					printk("ERESTARTSYS: putting -EINTR\n");
@@ -619,7 +528,7 @@
 		/* Whee!  Actually deliver the signal.  If the
 		   delivery failed, we need to continue to iterate in
 		   this loop so we can deliver the SIGSEGV... */
-		if (handle_signal(signr, ka, &info, oldset, regs, in_syscall)) {
+		if (handle_signal(signr, &info, oldset, regs, in_syscall)) {
 #if DEBUG_SIG
 			printk("Exiting do_signal (success), regs->gr[28] = %ld\n", regs->gr[28]);
 #endif
diff -ruN 2.5.15/arch/ppc/kernel/signal.c 2.5.15-si.5/arch/ppc/kernel/signal.c
--- 2.5.15/arch/ppc/kernel/signal.c	Fri May 10 09:35:08 2002
+++ 2.5.15-si.5/arch/ppc/kernel/signal.c	Thu May 16 14:41:22 2002
@@ -426,12 +426,12 @@
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
-	      unsigned long *newspp, unsigned long frame)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs, unsigned long *newspp, unsigned long frame)
 {
 	struct sigcontext_struct *sc;
 	struct rt_sigframe *rt_sf;
+	struct k_sigaction *ka = &current->sig->action[sig-1];
 
 	if (TRAP(regs) == 0x0C00 /* System Call! */
 	    && ((int)regs->result == -ERESTARTNOHAND ||
@@ -515,101 +515,16 @@
 	siginfo_t info;
 	struct k_sigaction *ka;
 	unsigned long frame, newsp;
+	int signr;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	newsp = frame = 0;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->parent->pid;
-				info.si_uid = current->parent->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH: case SIGURG:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->parent->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
 		if ( (ka->sa.sa_flags & SA_ONSTACK)
 		     && (! on_sig_stack(regs->gpr[1])))
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
@@ -618,8 +533,7 @@
 		newsp = frame = newsp - sizeof(struct sigregs);
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs, &newsp, frame);
-		break;
+		handle_signal(signr, &info, oldset, regs, &newsp, frame);
 	}
 
 	if (TRAP(regs) == 0x0C00 /* System Call! */ &&
diff -ruN 2.5.15/arch/ppc64/kernel/signal.c 2.5.15-si.5/arch/ppc64/kernel/signal.c
--- 2.5.15/arch/ppc64/kernel/signal.c	Fri May  3 12:08:04 2002
+++ 2.5.15-si.5/arch/ppc64/kernel/signal.c	Thu May 16 15:24:55 2002
@@ -544,12 +544,12 @@
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
-	      unsigned long *newspp, unsigned long frame)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs, unsigned long *newspp, unsigned long frame)
 {
 	struct sigcontext_struct *sc;
         struct rt_sigframe *rt_sf;
+	struct k_sigaction *ka = &current->sig->action[sig-1];
 
 	if (regs->trap == 0x0C00 /* System Call! */
 	    && ((int)regs->result == -ERESTARTNOHAND ||
@@ -633,6 +633,7 @@
 	siginfo_t info;
 	struct k_sigaction *ka;
 	unsigned long frame, newsp;
+	int signr;
 
 	/*
 	 * If the current thread is 32 bit - invoke the
@@ -646,103 +647,9 @@
 
 	newsp = frame = 0;
 
-	for (;;) {
-		unsigned long signr;
-
-                PPCDBG(PPCDBG_SIGNAL, "do_signal - (pre) dequeueing signal - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-                PPCDBG(PPCDBG_SIGNAL, "do_signal - (aft) dequeueing signal - signal=%lx - pid=%ld current=%lx comm=%s \n", signr, current->pid, current, current->comm);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->parent->pid;
-				info.si_uid = current->parent->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		ka = &current->sig->action[signr-1];
-
-  
-                PPCDBG(PPCDBG_SIGNAL, "do_signal - ka=%p, action handler=%lx \n", ka, ka->sa.sa_handler);
-
-		if (ka->sa.sa_handler == SIG_IGN) {
-                        PPCDBG(PPCDBG_SIGNAL, "do_signal - into SIG_IGN logic \n");
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-                        PPCDBG(PPCDBG_SIGNAL, "do_signal - into SIG_DFL logic \n");
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->parent->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
 		if ( (ka->sa.sa_flags & SA_ONSTACK)
 		     && (! on_sig_stack(regs->gpr[1])))
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
@@ -753,9 +660,8 @@
 		/* Whee!  Actually deliver the signal.  */
   
                 PPCDBG(PPCDBG_SIGNAL, "do_signal - GOING TO RUN SIGNAL HANDLER - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-		handle_signal(signr, ka, &info, oldset, regs, &newsp, frame);
+		handle_signal(signr, &info, oldset, regs, &newsp, frame);
                 PPCDBG(PPCDBG_SIGNAL, "do_signal - after running signal handler - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-                break;
 	}
 
 	if (regs->trap == 0x0C00 /* System Call! */ &&
diff -ruN 2.5.15/arch/ppc64/kernel/signal32.c 2.5.15-si.5/arch/ppc64/kernel/signal32.c
--- 2.5.15/arch/ppc64/kernel/signal32.c	Fri May  3 12:08:04 2002
+++ 2.5.15-si.5/arch/ppc64/kernel/signal32.c	Thu May 16 14:53:27 2002
@@ -1187,13 +1187,13 @@
  * OK, we're invoking a handler
  */
 static void
-handle_signal32(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
-	      unsigned int *newspp, unsigned int frame)
+handle_signal32(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs, unsigned int *newspp, unsigned int frame)
 {
 	struct sigcontext32_struct *sc;
 	struct rt_sigframe_32 *rt_stack_frame;
 	siginfo_t32 siginfo32bit;
+	struct k_sigaction *ka = &current->sig->action[sig-1];
 
 	if (regs->trap == 0x0C00 /* System Call! */
 	    && ((int)regs->result == -ERESTARTNOHAND ||
@@ -1337,114 +1337,23 @@
 	siginfo_t info;
 	struct k_sigaction *ka;
 	unsigned int frame, newsp;
+	int signr;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	newsp = frame = 0;
 
-	for (;;) {
-		unsigned long signr;
-		
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-		ifppcdebug(PPCDBG_SYS32) {
-			if (signr)
-				udbg_printf("do_signal32 - processing signal=%2lx - pid=%ld, comm=%s \n", signr, current->pid, current->comm);
-		}
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->parent->pid;
-				info.si_uid = current->parent->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		ka = &current->sig->action[signr-1];
 
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->parent->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
 		PPCDBG(PPCDBG_SIGNAL, " do signal :sigaction flags = %lx \n" ,ka->sa.sa_flags);
 		PPCDBG(PPCDBG_SIGNAL, " do signal :on sig stack  = %lx \n" ,on_sig_stack(regs->gpr[1]));
 		PPCDBG(PPCDBG_SIGNAL, " do signal :reg1  = %lx \n" ,regs->gpr[1]);
 		PPCDBG(PPCDBG_SIGNAL, " do signal :alt stack  = %lx \n" ,current->sas_ss_sp);
 		PPCDBG(PPCDBG_SIGNAL, " do signal :alt stack size  = %lx \n" ,current->sas_ss_size);
 
-
-
 		if ( (ka->sa.sa_flags & SA_ONSTACK)
 		     && (! on_sig_stack(regs->gpr[1])))
 		{
@@ -1454,8 +1363,7 @@
 		newsp = frame = newsp - sizeof(struct sigregs32);
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal32(signr, ka, &info, oldset, regs, &newsp, frame);
-		break;
+		handle_signal32(signr, &info, oldset, regs, &newsp, frame);
 	}
 
 	if (regs->trap == 0x0C00 /* System Call! */ &&
@@ -1468,9 +1376,8 @@
 	}
 
 	if (newsp == frame)
-	{
 		return 0;		/* no signals delivered */
-	}
+
 	// Invoke correct stack setup routine 
 	if (ka->sa.sa_flags & SA_SIGINFO) 
 		setup_rt_frame32(regs, (struct sigregs32*)(u64)frame, newsp);
diff -ruN 2.5.15/arch/s390/kernel/signal.c 2.5.15-si.5/arch/s390/kernel/signal.c
--- 2.5.15/arch/s390/kernel/signal.c	Wed Feb 20 16:36:40 2002
+++ 2.5.15-si.5/arch/s390/kernel/signal.c	Thu May 16 14:52:26 2002
@@ -409,9 +409,11 @@
  */	
 
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	/* Are we from a system call? */
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
@@ -462,7 +464,7 @@
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
 
 	/*
 	 * We want the common case to go fast, which
@@ -476,100 +478,10 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			set_current_state(TASK_STOPPED);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP: {
-				struct signal_struct *sig;
-				set_current_state(TASK_STOPPED);
-				current->exit_code = signr;
-				sig = current->p_pptr->sig;
-				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-			}
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-                                if (do_coredump(signr, regs))
-                                        exit_code |= 0x80;
-                                /* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/s390x/kernel/signal.c 2.5.15-si.5/arch/s390x/kernel/signal.c
--- 2.5.15/arch/s390x/kernel/signal.c	Wed Feb 20 16:36:40 2002
+++ 2.5.15-si.5/arch/s390x/kernel/signal.c	Thu May 16 14:51:59 2002
@@ -409,9 +409,11 @@
  */	
 
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	/* Are we from a system call? */
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
@@ -462,7 +464,6 @@
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -482,100 +483,10 @@
         }
 #endif 
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			set_current_state(TASK_STOPPED);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP: {
-				struct signal_struct *sig;
-				set_current_state(TASK_STOPPED);
-				current->exit_code = signr;
-				sig = current->p_pptr->sig;
-				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-			}
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-                                if (do_coredump(signr, regs))
-                                        exit_code |= 0x80;
-                                /* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/s390x/kernel/signal32.c 2.5.15-si.5/arch/s390x/kernel/signal32.c
--- 2.5.15/arch/s390x/kernel/signal32.c	Wed Feb 20 16:36:40 2002
+++ 2.5.15-si.5/arch/s390x/kernel/signal32.c	Thu May 16 15:12:51 2002
@@ -548,9 +548,11 @@
  */	
 
 static void
-handle_signal32(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal32(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	/* Are we from a system call? */
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
@@ -601,7 +603,7 @@
 int do_signal32(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
 
 	/*
 	 * We want the common case to go fast, which
@@ -615,97 +617,10 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			set_current_state(TASK_STOPPED);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				set_current_state(TASK_STOPPED);
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-                                if (do_coredump(signr, regs))
-                                        exit_code |= 0x80;
-                                /* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal32(signr, ka, &info, oldset, regs);
+		handle_signal32(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/sh/kernel/signal.c 2.5.15-si.5/arch/sh/kernel/signal.c
--- 2.5.15/arch/sh/kernel/signal.c	Wed Feb 20 16:36:40 2002
+++ 2.5.15-si.5/arch/sh/kernel/signal.c	Thu May 16 15:15:09 2002
@@ -522,9 +522,11 @@
  */	
 
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 	/* Are we from a system call? */
 	if (regs->syscall_nr >= 0) {
 		/* If so, check system call restarting.. */
@@ -575,7 +577,7 @@
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
 
 	/*
 	 * We want the common case to go fast, which
@@ -589,97 +591,10 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->p_pptr->pid;
-				info.si_uid = current->p_pptr->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP:
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/arch/x86_64/kernel/signal.c 2.5.15-si.5/arch/x86_64/kernel/signal.c
--- 2.5.15/arch/x86_64/kernel/signal.c	Tue Apr 23 10:42:14 2002
+++ 2.5.15-si.5/arch/x86_64/kernel/signal.c	Thu May 16 23:44:34 2002
@@ -380,9 +380,11 @@
  */	
 
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
+	struct pt_regs * regs)
 {
+	struct k_sigaction *ka = &current->sig->action[sig-1];
+
 #if DEBUG_SIG
 	printk("handle_signal pid:%d sig:%lu rip:%lx rsp:%lx regs=%p\n", current->pid, sig, 
 		regs->rip, regs->rsp, regs);
@@ -438,7 +440,7 @@
 int do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
 
 	/*
 	 * We want the common case to go fast, which
@@ -453,101 +455,8 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		unsigned long signr;
-
-		spin_lock_irq(&current->sigmask_lock);
-		signr = dequeue_signal(&current->blocked, &info);
-		spin_unlock_irq(&current->sigmask_lock);
-
-		if (!signr) { 
-			break;
-		}
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code))
-				continue;
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->parent->pid;
-				info.si_uid = current->parent->uid;
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
-			continue;
-		}
-
-		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
-
-			/* Init gets no signals it doesn't want.  */
-			if (current->pid == 1)			      
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD: case SIGWINCH:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP: {
-				struct signal_struct *sig;
-				preempt_disable(); 
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				sig = current->parent->sig;
-				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				preempt_enable();
-				continue;
-			}
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, regs);
+	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
 		 * have been cleared if the watchpoint triggered
@@ -556,7 +465,7 @@
 		__asm__("movq %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruN 2.5.15/include/asm-alpha/signal.h 2.5.15-si.5/include/asm-alpha/signal.h
--- 2.5.15/include/asm-alpha/signal.h	Thu Jun 25 07:30:11 1998
+++ 2.5.15-si.5/include/asm-alpha/signal.h	Fri May 17 10:14:44 2002
@@ -185,6 +185,9 @@
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
+
+#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 #endif
 
 #endif
diff -ruN 2.5.15/include/asm-arm/signal.h 2.5.15-si.5/include/asm-arm/signal.h
--- 2.5.15/include/asm-arm/signal.h	Wed Oct 24 16:12:32 2001
+++ 2.5.15-si.5/include/asm-arm/signal.h	Fri May 17 10:14:50 2002
@@ -187,6 +187,8 @@
 
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
+#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 #endif
 
 #endif
diff -ruN 2.5.15/include/asm-ia64/signal.h 2.5.15-si.5/include/asm-ia64/signal.h
--- 2.5.15/include/asm-ia64/signal.h	Tue Mar 19 15:12:06 2002
+++ 2.5.15-si.5/include/asm-ia64/signal.h	Fri May 17 10:04:30 2002
@@ -166,6 +166,8 @@
 
 #  include <asm/sigcontext.h>
 
+#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 #endif /* __KERNEL__ */
 
 # endif /* !__ASSEMBLY__ */
diff -ruN 2.5.15/include/asm-m68k/signal.h 2.5.15-si.5/include/asm-m68k/signal.h
--- 2.5.15/include/asm-m68k/signal.h	Fri Nov 19 14:37:03 1999
+++ 2.5.15-si.5/include/asm-m68k/signal.h	Fri May 17 10:04:48 2002
@@ -215,6 +215,8 @@
 	return word ^ 31;
 }
 
+#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_SIGNAL_H */
diff -ruN 2.5.15/include/asm-sparc/signal.h 2.5.15-si.5/include/asm-sparc/signal.h
--- 2.5.15/include/asm-sparc/signal.h	Thu Sep  9 04:14:32 1999
+++ 2.5.15-si.5/include/asm-sparc/signal.h	Fri May 17 10:05:03 2002
@@ -216,6 +216,8 @@
 	size_t		ss_size;
 } stack_t;
 
+#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_ASMSPARC_SIGNAL_H) */
diff -ruN 2.5.15/include/asm-sparc64/signal.h 2.5.15-si.5/include/asm-sparc64/signal.h
--- 2.5.15/include/asm-sparc64/signal.h	Thu Sep  9 04:14:32 1999
+++ 2.5.15-si.5/include/asm-sparc64/signal.h	Fri May 17 10:05:26 2002
@@ -252,6 +252,9 @@
 	int			ss_flags;
 	__kernel_size_t32	ss_size;
 } stack_t32;
+
+#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
 #endif
 
 #endif /* !(__ASSEMBLY__) */
diff -ruN 2.5.15/include/linux/signal.h 2.5.15-si.5/include/linux/signal.h
--- 2.5.15/include/linux/signal.h	Wed May 15 17:59:02 2002
+++ 2.5.15-si.5/include/linux/signal.h	Fri May 17 09:45:57 2002
@@ -220,6 +220,10 @@
 
 extern long do_sigpending(void *, unsigned long);
 
+#ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs);
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
diff -ruN 2.5.15/kernel/signal.c 2.5.15-si.5/kernel/signal.c
--- 2.5.15/kernel/signal.c	Fri May 10 09:35:17 2002
+++ 2.5.15-si.5/kernel/signal.c	Fri May 17 10:01:53 2002
@@ -14,6 +14,8 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include <asm/uaccess.h>
 
@@ -823,6 +825,110 @@
 	do_notify_parent(tsk, sig);
 	read_unlock(&tasklist_lock);
 }
+
+#ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+
+int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs)
+{
+	for (;;) {
+		unsigned long signr;
+		struct k_sigaction *ka;
+
+		spin_lock_irq(&current->sigmask_lock);
+		signr = dequeue_signal(&current->blocked, info);
+		spin_unlock_irq(&current->sigmask_lock);
+
+		if (!signr)
+			break;
+
+		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
+			/* Let the debugger run.  */
+			current->exit_code = signr;
+			set_current_state(TASK_STOPPED);
+			notify_parent(current, SIGCHLD);
+			schedule();
+
+			/* We're back.  Did the debugger cancel the sig?  */
+			signr = current->exit_code;
+			if (signr == 0)
+				continue;
+			current->exit_code = 0;
+
+			/* The debugger continued.  Ignore SIGSTOP.  */
+			if (signr == SIGSTOP)
+				continue;
+
+			/* Update the siginfo structure.  Is this good?  */
+			if (signr != info->si_signo) {
+				info->si_signo = signr;
+				info->si_errno = 0;
+				info->si_code = SI_USER;
+				info->si_pid = current->parent->pid;
+				info->si_uid = current->parent->uid;
+			}
+
+			/* If the (new) signal is now blocked, requeue it.  */
+			if (sigismember(&current->blocked, signr)) {
+				send_sig_info(signr, info, current);
+				continue;
+			}
+		}
+
+		ka = &current->sig->action[signr-1];
+		if (ka->sa.sa_handler == SIG_IGN) {
+			if (signr != SIGCHLD)
+				continue;
+			/* Check for SIGCHLD: it's special.  */
+			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
+				/* nothing */;
+			continue;
+		}
+
+		if (ka->sa.sa_handler == SIG_DFL) {
+			int exit_code = signr;
+
+			/* Init gets no signals it doesn't want.  */
+			if (current->pid == 1)
+				continue;
+
+			switch (signr) {
+			case SIGCONT: case SIGCHLD: case SIGWINCH: case SIGURG:
+				continue;
+
+			case SIGTSTP: case SIGTTIN: case SIGTTOU:
+				if (is_orphaned_pgrp(current->pgrp))
+					continue;
+				/* FALLTHRU */
+
+			case SIGSTOP: {
+				struct signal_struct *sig;
+				set_current_state(TASK_STOPPED);
+				current->exit_code = signr;
+				sig = current->parent->sig;
+				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
+					notify_parent(current, SIGCHLD);
+				schedule();
+				continue;
+			}
+
+			case SIGQUIT: case SIGILL: case SIGTRAP:
+			case SIGABRT: case SIGFPE: case SIGSEGV:
+			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
+				if (do_coredump(signr, regs))
+					exit_code |= 0x80;
+				/* FALLTHRU */
+
+			default:
+				sig_exit(signr, exit_code, info);
+				/* NOTREACHED */
+			}
+		}
+		return signr;
+	}
+	return 0;
+}
+
+#endif
 
 EXPORT_SYMBOL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
