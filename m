Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbULANkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbULANkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULANkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:40:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:24764 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261251AbULANkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:40:02 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 1 Dec 2004 14:13:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC/PATCH] fix sigwait + ptrace with NPTL
Message-ID: <20041201131341.GA20530@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

When using NPTL glibc implements sigwait() using the rt_sigtimedwait
syscall.  The kernel doesn't notify the ptracing process for any signals
delivered via rt_sigtimedwait(), so gdb+strace will not see them.

Below is a patch which fixes that for most archs, it doesn't work
through for those where ptrace_signal_deliver() isn't a noop (i.e.
sparc + sparc64).  I suspect to get these fixed as well we'll need
a arch-specific rt_sigtimedwait() ...

  Gerd

Index: linux-2.6.10-rc2/kernel/signal.c
===================================================================
--- linux-2.6.10-rc2.orig/kernel/signal.c	2004-11-17 18:40:00.000000000 +0100
+++ linux-2.6.10-rc2/kernel/signal.c	2004-12-01 13:53:35.000000000 +0100
@@ -2163,6 +2163,7 @@ sys_rt_sigtimedwait(const sigset_t __use
 	}
 
 	spin_lock_irq(&current->sighand->siglock);
+try_again:
 	sig = dequeue_signal(current, &these, &info);
 	if (!sig) {
 		timeout = MAX_SCHEDULE_TIMEOUT;
@@ -2189,6 +2190,40 @@ sys_rt_sigtimedwait(const sigset_t __use
 			recalc_sigpending();
 		}
 	}
+	if (sig && (current->ptrace & PT_PTRACED) && sig != SIGKILL) {
+#if 0 /* FIXME: some archs (sparc) need this ... */
+		ptrace_signal_deliver(regs, cookie);
+#endif
+
+		/* Let the debugger run.  */
+		ptrace_stop(sig, &info);
+
+		/* We're back.  Did the debugger cancel the sig?  */
+		sig = current->exit_code;
+		if (sig == 0)
+			goto try_again;
+
+		current->exit_code = 0;
+		
+		/* Update the siginfo structure if the signal has
+		   changed.  If the debugger wanted something
+		   specific in the siginfo structure then it should
+		   have updated *info via PTRACE_SETSIGINFO.  */
+		if (sig != info.si_signo) {
+			info.si_signo = sig;
+			info.si_errno = 0;
+			info.si_code = SI_USER;
+			info.si_pid = current->parent->pid;
+			info.si_uid = current->parent->uid;
+		}
+
+		/* If the (new) signal is not in the set we are looking for,
+		   requeue it. */
+		if (sigismember(&these, sig)) {
+			specific_send_sig_info(sig, &info, current);
+			goto try_again;
+		}
+	}
 	spin_unlock_irq(&current->sighand->siglock);
 
 	if (sig) {
