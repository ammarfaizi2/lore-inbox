Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUISUQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUISUQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUISUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:16:36 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:35382 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263429AbUISUQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:16:26 -0400
Date: Sun, 19 Sep 2004 22:16:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roland McGrath <roland@redhat.com>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: notify_parent (was: Re: Linux 2.6.9-rc2)
In-Reply-To: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.61.0409192213250.14392@anakin>
References: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, Roland McGrath wrote:
> > On Mon, 13 Sep 2004, Linus Torvalds wrote:
> > > Roland McGrath:
> > >   o cleanup ptrace stops and remove notify_parent
> > 
> > However, there are still a few users of notify_parent():
> 
> IIRC all these are old arch-specific signal code that is rampantly wrong in
> semantics compared to what the up-to-date arch's using the generic code do,
> for quite a long time now.  I believe I mentioned this when I posted the
> patch.  All this arch signal code needs to be rewritten to use
> get_signal_to_deliver, and define ptrace_signal_deliver appropriately to
> get its arch-specific work done.  The old style of code that does all the
> central signal dispatch logic itself is hopeless.  Mostly you have a lot of
> old cruft to remove, and the code that needs to be left is much smaller and
> simpler because the complex stuff is in the shared kernel/signal.c.

Can anyone with more intimate knowledge of (m68k) signal handling please take a
look at this? I gave it a first try, but I don't know enough about the code in
question to guarantee anything beyond `it does compile again'.

Thanks!

--- linux-2.6.9-rc2/arch/m68k/kernel/signal.c	2004-09-13 21:57:25.000000000 +0200
+++ linux-m68k-2.6.9-rc2/arch/m68k/kernel/signal.c	2004-09-19 22:01:26.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>
@@ -990,128 +991,34 @@
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	int signr;
+	struct k_sigaction ka;
 
 	current->thread.esp0 = (unsigned long) regs;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		goto no_signal;
+	}
+
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
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+	if (signr > 0) {
+		/* Reenable any watchpoints before delivering the
+		 * signal to user space. The processor register will
+		 * have been cleared if the watchpoint triggered
+		 * inside the kernel.
+		 */
+		regs->sr &= ~PS_T;
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, ka, &info, oldset, regs);
+		handle_signal(signr, &ka, &info, oldset, regs);
 		return 1;
 	}
 
+no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_d0 >= 0)
 		/* Restart the system call - no handlers present */
--- linux-2.6.9-rc2/include/asm-m68k/siginfo.h	2004-04-27 20:42:20.000000000 +0200
+++ linux-m68k-2.6.9-rc2/include/asm-m68k/siginfo.h	2004-09-19 12:52:57.000000000 +0200
@@ -46,6 +46,8 @@
 			clock_t _utime;
 			clock_t _stime;
 			__kernel_uid32_t _uid32; /* sender's uid */
+			// FIXME to be removed again in 2.6.9-rc3
+			struct rusage _rusage;
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
--- linux-2.6.9-rc2/include/asm-m68k/signal.h	2004-05-24 11:13:53.000000000 +0200
+++ linux-m68k-2.6.9-rc2/include/asm-m68k/signal.h	2004-09-19 22:00:15.000000000 +0200
@@ -213,7 +213,7 @@
 	return word ^ 31;
 }
 
-#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
+#define ptrace_signal_deliver(regs, cookie) do { } while (0)
 
 #endif /* __KERNEL__ */
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
