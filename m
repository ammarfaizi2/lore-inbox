Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVCUU0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVCUU0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVCUU0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:26:39 -0500
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:30526
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261858AbVCUUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:25:56 -0500
Date: Mon, 21 Mar 2005 21:25:49 +0100
Message-Id: <200503212025.j2LKPntC011301@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 529] M68k: Update signal delivery handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update signal delivery handling, which was broken by the removal of
notify_parent() in 2.6.9-rc2

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/arch/m68k/kernel/signal.c	19 Oct 2004 23:06:39 -0000
+++ linux-m68k-2.6.12-rc1/arch/m68k/kernel/signal.c	8 Dec 2004 00:43:09 -0000
@@ -951,6 +951,21 @@
 	}
 }
 
+void ptrace_signal_deliver(struct pt_regs *regs, void *cookie)
+{
+	if (regs->orig_d0 < 0)
+		return;
+	switch (regs->d0) {
+	case -ERESTARTNOHAND:
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+		regs->d0 = regs->orig_d0;
+		regs->orig_d0 = -1;
+		regs->pc -= 2;
+		break;
+	}
+}
+
 /*
  * OK, we're invoking a handler
  */
@@ -982,133 +997,22 @@
  * Note that 'init' is a special process: it doesn't get signals it doesn't
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
- *
- * Note that we go through the signals twice: once to check the signals
- * that the kernel can handle, and then we build all the user-level signal
- * handling stack-frames in one go after that.
  */
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	struct k_sigaction ka;
+	int signr;
 
 	current->thread.esp0 = (unsigned long) regs;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
-	for (;;) {
-		int signr;
-
-		signr = dequeue_signal(current, &current->blocked, &info);
-
-		if (!signr)
-			break;
-
-		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
-			current->exit_code = signr;
-			current->state = TASK_STOPPED;
-			regs->sr &= ~PS_T;
-
-			/* Did we come from a system call? */
-			if (regs->orig_d0 >= 0) {
-				/* Restart the system call the same way as
-				   if the process were not traced.  */
-				struct k_sigaction *ka =
-					&current->sighand->action[signr-1];
-				int has_handler =
-					(ka->sa.sa_handler != SIG_IGN &&
-					 ka->sa.sa_handler != SIG_DFL);
-				handle_restart(regs, ka, has_handler);
-			}
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			/* We're back.  Did the debugger cancel the sig?  */
-			if (!(signr = current->exit_code)) {
-			discard_frame:
-			    /* Make sure that a faulted bus cycle isn't
-			       restarted (only needed on the 680[23]0).  */
-			    if (regs->format == 10 || regs->format == 11)
-				regs->stkadj = frame_extra_sizes[regs->format];
-			    continue;
-			}
-			current->exit_code = 0;
-
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				goto discard_frame;
-
-			/* Update the siginfo structure.  Is this good?  */
-			if (signr != info.si_signo) {
-				info.si_signo = signr;
-				info.si_errno = 0;
-				info.si_code = SI_USER;
-				info.si_pid = current->parent->pid;
-				info.si_uid = current->parent->uid;
-				info.si_uid16 = high2lowuid(current->parent->uid);
-			}
-
-			/* If the (new) signal is now blocked, requeue it.  */
-			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
-				continue;
-			}
-		}
-
-		ka = &current->sighand->action[signr-1];
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
-			if (current->pid == 1)
-				continue;
-
-			switch (signr) {
-			case SIGCONT: case SIGCHLD:
-			case SIGWINCH: case SIGURG:
-				continue;
-
-			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(process_group(current)))
-					continue;
-				/* FALLTHRU */
-
-			case SIGSTOP: {
-				struct sighand_struct *sighand;
-				current->state = TASK_STOPPED;
-				current->exit_code = signr;
-				sighand = current->parent->sighand;
-				if (sighand && !(sighand->action[SIGCHLD-1].sa.sa_flags
-					     & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				continue;
-			}
-
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGIOT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, exit_code, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				do_group_exit(signr);
-				/* NOTREACHED */
-			}
-		}
-
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &ka, &info, oldset, regs);
 		return 1;
 	}
 
@@ -1117,18 +1021,5 @@
 		/* Restart the system call - no handlers present */
 		handle_restart(regs, NULL, 0);
 
-	/* If we are about to discard some frame stuff we must copy
-	   over the remaining frame. */
-	if (regs->stkadj) {
-		struct pt_regs *tregs =
-		  (struct pt_regs *) ((ulong) regs + regs->stkadj);
-
-		/* This must be copied with decreasing addresses to
-		   handle overlaps.  */
-		tregs->vector = 0;
-		tregs->format = 0;
-		tregs->pc = regs->pc;
-		tregs->sr = regs->sr;
-	}
 	return 0;
 }
--- linux-2.6.12-rc1/include/asm-m68k/signal.h	5 Apr 2004 13:09:08 -0000	1.3
+++ linux-m68k-2.6.12-rc1/include/asm-m68k/signal.h	8 Dec 2004 00:43:09 -0000	1.4
@@ -213,7 +213,7 @@
 	return word ^ 31;
 }
 
-#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+extern void ptrace_signal_deliver(struct pt_regs *regs, void *cookie);
 
 #endif /* __KERNEL__ */
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
