Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTBKQNv>; Tue, 11 Feb 2003 11:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbTBKQNv>; Tue, 11 Feb 2003 11:13:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32777 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265890AbTBKQNr>; Tue, 11 Feb 2003 11:13:47 -0500
Date: Tue, 11 Feb 2003 16:23:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
Message-ID: <20030211162332.B24592@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 10, 2003 at 11:08:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
> And Roland McGrath has been fixing POSIX thread signal handling, and that
> in turn ended up causing a lot of downstream fixes in affected areas.

And there's still more to come on the signal handling.  Currently, my
"hack" to get ARM working is as follows, and is not the best thing to
view on a full stomach.

Generalising the signal handling might have made sense, but this amount
of duplication _just_ to be able to handle non-hardware breakpoints is
getting rather rediculous.

I will be looking into the possibility of carving up the generic
signal handling into a saner structure so we don't have this mess.

Obviously, this patch is not for applying. 8)

--- orig/arch/arm/kernel/signal.c	Tue Feb 11 16:09:38 2003
+++ linux/arch/arm/kernel/signal.c	Tue Feb 11 16:13:55 2003
@x@ -492,6 +492,78 @x@
 	force_sig(SIGSEGV, tsk);
 }
 
+int
+specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t);
+void finish_stop(int stop_count);
+void do_signal_stop(int signr);
+
+/* Some systems do not have a SIGSTKFLT and the kernel never
+ * generates such signals anyways.
+ */
+#ifdef SIGSTKFLT
+#define M_SIGSTKFLT	M(SIGSTKFLT)
+#else
+#define M_SIGSTKFLT	0
+#endif
+
+#ifdef SIGEMT
+#define M_SIGEMT	M(SIGEMT)
+#else
+#define M_SIGEMT	0
+#endif
+
+#if SIGRTMIN > BITS_PER_LONG
+#define M(sig) (1ULL << ((sig)-1))
+#else
+#define M(sig) (1UL << ((sig)-1))
+#endif
+#define T(sig, mask) (M(sig) & (mask))
+
+#define SIG_KERNEL_BROADCAST_MASK (\
+	M(SIGHUP)    |  M(SIGINT)    |  M(SIGQUIT)   |  M(SIGILL)    | \
+	M(SIGTRAP)   |  M(SIGABRT)   |  M(SIGBUS)    |  M(SIGFPE)    | \
+	M(SIGKILL)   |  M(SIGUSR1)   |  M(SIGSEGV)   |  M(SIGUSR2)   | \
+	M(SIGPIPE)   |  M(SIGALRM)   |  M(SIGTERM)   |  M(SIGXCPU)   | \
+	M(SIGXFSZ)   |  M(SIGVTALRM) |  M(SIGPROF)   |  M(SIGPOLL)   | \
+	M(SIGSYS)    |  M_SIGSTKFLT  |  M(SIGPWR)    |  M(SIGCONT)   | \
+        M(SIGSTOP)   |  M(SIGTSTP)   |  M(SIGTTIN)   |  M(SIGTTOU)   | \
+        M_SIGEMT )
+
+#define SIG_KERNEL_ONLY_MASK (\
+	M(SIGKILL)   |  M(SIGSTOP)                                   )
+
+#define SIG_KERNEL_STOP_MASK (\
+	M(SIGSTOP)   |  M(SIGTSTP)   |  M(SIGTTIN)   |  M(SIGTTOU)   )
+
+#define SIG_KERNEL_COREDUMP_MASK (\
+        M(SIGQUIT)   |  M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   | \
+        M(SIGFPE)    |  M(SIGSEGV)   |  M(SIGBUS)    |  M(SIGSYS)    | \
+        M(SIGXCPU)   |  M(SIGXFSZ)   |  M_SIGEMT                     )
+
+#define SIG_KERNEL_IGNORE_MASK (\
+        M(SIGCONT)   |  M(SIGCHLD)   |  M(SIGWINCH)  |  M(SIGURG)    )
+
+#define sig_kernel_only(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_ONLY_MASK))
+#define sig_kernel_coredump(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_COREDUMP_MASK))
+#define sig_kernel_ignore(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_IGNORE_MASK))
+#define sig_kernel_stop(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
+
+#define sig_user_defined(t, signr) \
+	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
+	 ((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_IGN))
+
+#define sig_ignored(t, signr) \
+	(!((t)->ptrace & PT_PTRACED) && \
+	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_IGN)
+
+#define sig_fatal(t, signr) \
+	(!T(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
+	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
+
 /*
  * Note that 'init' is a special process: it doesn't get signals it doesn't
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
@@ -522,6 +594,29 @@
 		struct k_sigaction *ka;
 
 		spin_lock_irq(&current->sighand->siglock);
+		if (unlikely(current->signal->group_stop_count > 0)) {
+			int stop_count;
+			if (current->signal->group_exit_task == current) {
+				/*
+				 * Group stop is so we can do a core dump.
+				 */
+				current->signal->group_exit_task = NULL;
+				goto dequeue;
+			}
+			/*
+			 * There is a group stop in progress.  We stop
+			 * without any associated signal being in our queue.
+			 */
+			stop_count = --current->signal->group_stop_count;
+			signr = current->signal->group_exit_code;
+			current->exit_code = signr;
+			set_current_state(TASK_STOPPED);
+			spin_unlock_irq(&current->sighand->siglock);
+			finish_stop(stop_count);
+			single_stepping |= ptrace_cancel_bpt(current);
+			continue;
+		}
+	dequeue:
 		signr = dequeue_signal(&current->blocked, &info);
 		spin_unlock_irq(&current->sighand->siglock);
 
@@ -529,8 +624,19 @@
 			break;
 
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
+			/*
+			 * If there is a group stop in progress,
+			 * we must  participate in the bookkeeping.
+			 */
+			if (current->signal->group_stop_count > 0) {
+				spin_lock_irq(&current->sighand->siglock);
+				--current->signal->group_stop_count;
+				spin_unlock_irq(&current->sighand->siglock);
+			}
+
 			/* Let the debugger run.  */
 			current->exit_code = signr;
+			current->last_siginfo = &info;
 			set_current_state(TASK_STOPPED);
 			notify_parent(current, SIGCHLD);
 			schedule();
@@ -542,11 +648,10 @@
 				continue;
 			current->exit_code = 0;
 
-			/* The debugger continued.  Ignore SIGSTOP.  */
-			if (signr == SIGSTOP)
-				continue;
-
-			/* Update the siginfo structure.  Is this good? */
+			/* Update the siginfo structure if the signal has
+			   changed.  If the debugger wanted something
+			   specific in the siginfo structure then it should
+			   have updated *info via PTRACE_SETSIGINFO.  */
 			if (signr != info.si_signo) {
 				info.si_signo = signr;
 				info.si_errno = 0;
@@ -557,60 +662,68 @@
 
 			/* If the (new) signal is now blocked, requeue it.  */
 			if (sigismember(&current->blocked, signr)) {
-				send_sig_info(signr, &info, current);
+				spin_lock_irq(&current->sighand->siglock);
+				specific_send_sig_info(signr, &info, current);
+				spin_unlock_irq(&current->sighand->siglock);
 				continue;
 			}
 		}
 
-		ka = &current->sig->action[signr-1];
-		if (ka->sa.sa_handler == SIG_IGN) {
-			if (signr != SIGCHLD)
-				continue;
-			/* Check for SIGCHLD: it's special.  */
-			while (sys_wait4(-1, NULL, WNOHANG, NULL) > 0)
-				/* nothing */;
+		ka = &current->sighand->action[signr-1];
+		if (ka->sa.sa_handler == SIG_IGN) /* Do nothing.  */
 			continue;
-		}
 
 		if (ka->sa.sa_handler == SIG_DFL) {
-			int exit_code = signr;
+			/*
+			 * Now we are doing the default action for this signal.
+			 */
+			if (sig_kernel_ignore(signr)) /* Default is nothing. */
+				continue;
 
 			/* Init gets no signals it doesn't want.  */
 			if (current->pid == 1)
 				continue;
 
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
-				set_current_state(TASK_STOPPED);
-				current->exit_code = signr;
-				sig = current->parent->sig;
-				if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-					notify_parent(current, SIGCHLD);
-				schedule();
-				single_stepping |= ptrace_cancel_bpt(current);
+			if (sig_kernel_stop(signr)) {
+				/*
+				 * The default action is to stop all threads in
+				 * the thread group.  The job control signals
+				 * do nothing in an orphaned pgrp, but SIGSTOP
+				 * always works.
+				 */
+				if (signr == SIGSTOP ||
+				    !is_orphaned_pgrp(current->pgrp))
+					do_signal_stop(signr);
 				continue;
 			}
 
-			case SIGQUIT: case SIGILL: case SIGTRAP:
-			case SIGABRT: case SIGFPE: case SIGSEGV:
-			case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
-				if (do_coredump(signr, exit_code, regs))
-					exit_code |= 0x80;
-				/* FALLTHRU */
-
-			default:
-				sig_exit(signr, exit_code, &info);
-				/* NOTREACHED */
+			/*
+			 * Anything else is fatal, maybe with a core dump.
+			 */
+			current->flags |= PF_SIGNALED;
+			if (sig_kernel_coredump(signr) &&
+			    do_coredump(signr, signr, regs)) {
+				/*
+				 * That killed all other threads in the group and
+				 * synchronized with their demise, so there can't
+				 * be any more left to kill now.  The group_exit
+				 * flags are set by do_coredump.  Note that
+				 * thread_group_empty won't always be true yet,
+				 * because those threads were blocked in __exit_mm
+				 * and we just let them go to finish dying.
+				 */
+				const int code = signr | 0x80;
+				BUG_ON(!current->signal->group_exit);
+				BUG_ON(current->signal->group_exit_code != code);
+				do_exit(code);
+					/* NOTREACHED */
 			}
+
+			/*
+			 * Death signals, no core dump.
+			 */
+			do_group_exit(signr);
+			/* NOTREACHED */
 		}
 
 		/* Are we from a system call? */


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

