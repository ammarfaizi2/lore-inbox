Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTBLUGH>; Wed, 12 Feb 2003 15:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBLUGH>; Wed, 12 Feb 2003 15:06:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1031 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267605AbTBLUGF>; Wed, 12 Feb 2003 15:06:05 -0500
Date: Wed, 12 Feb 2003 12:12:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302120206.h1C26sI19476@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302121138570.8062-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw, Roland, instead of your previous patch I would prefer something that 
just makes "sig_ignored()" test the state of the signal better. Ie 
something like the appended.

This should bring it much closer to the old code, which got this _right_. 
For example, a signal that is blocked is _never_ ignored, since even if 
the handler is SIG_IGN right now, it may not be by the time it is 
unblocked.

I bet the blocked case accounts for some of the new test failures, while
the (SIG_DFL && sig_kernel_ignore(sig)) case will account for a few more.  
In general I _think_ this should get us pretty much back to the old
behaviour.

At least this fixes the pipe write() / SIGWINCH testcase for me.

		Linus

---
===== kernel/signal.c 1.69 vs edited =====
--- 1.69/kernel/signal.c	Tue Feb 11 17:33:52 2003
+++ edited/kernel/signal.c	Wed Feb 12 12:03:28 2003
@@ -141,14 +141,34 @@
 	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
 	 ((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_IGN))
 
-#define sig_ignored(t, signr) \
-	(!((t)->ptrace & PT_PTRACED) && \
-	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_IGN)
-
 #define sig_fatal(t, signr) \
 	(!T(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
 	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
 
+static inline int sig_ignored(struct task_struct *t, int sig)
+{
+	void * handler;
+
+	/*
+	 * Tracers always want to know about signals..
+	 */
+	if (t->ptrace & PT_PTRACED)
+		return 0;
+
+	/*
+	 * Blocked signals are never ignored, since the
+	 * signal handler may change by the time it is
+	 * unblocked.
+	 */
+	if (sigismember(&t->blocked, sig))
+		return 0;
+
+	/* Is it explicitly or implicitly ignored? */
+	handler = t->sighand->action[sig-1].sa.sa_handler;
+	return   handler == SIG_IGN ||
+		(handler == SIG_DFL && sig_kernel_ignore(sig));
+}
+
 /*
  * Re-calculate pending state from the set of locally pending
  * signals, globally pending signals, and blocked signals.
@@ -642,7 +662,7 @@
 			 * TIF_SIGPENDING
 			 */
 			state = TASK_STOPPED;
-			if (!sigismember(&t->blocked, SIGCONT)) {
+			if (sig_user_defined(t, SIGCONT) && !sigismember(&t->blocked, SIGCONT)) {
 				set_tsk_thread_flag(t, TIF_SIGPENDING);
 				state |= TASK_INTERRUPTIBLE;
 			}

