Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSKLCR0>; Mon, 11 Nov 2002 21:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbSKLCQW>; Mon, 11 Nov 2002 21:16:22 -0500
Received: from holomorphy.com ([66.224.33.161]:44728 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266118AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [9/9] privatize has_pending_signals()
Message-Id: <E18BQf6-00041O-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch privatizes has_pending_signals() to kernel/signal.c, which was
the file containing its only two callsites in the kernel.

 include/linux/sched.h |   30 ------------------------------
 kernel/signal.c       |   30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)


diff -urpN 07_has_stopped_jobs/include/linux/sched.h 08_has_pending_signals/include/linux/sched.h
--- 07_has_stopped_jobs/include/linux/sched.h	2002-11-10 19:28:04.000000000 -0800
+++ 08_has_pending_signals/include/linux/sched.h	2002-11-11 17:34:15.000000000 -0800
@@ -545,36 +545,6 @@ extern int kill_proc(pid_t, int, int);
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t *, stack_t *, unsigned long);
 
-/*
- * Re-calculate pending state from the set of locally pending
- * signals, globally pending signals, and blocked signals.
- */
-static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
-{
-	unsigned long ready;
-	long i;
-
-	switch (_NSIG_WORDS) {
-	default:
-		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
-			ready |= signal->sig[i] &~ blocked->sig[i];
-		break;
-
-	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
-		ready |= signal->sig[2] &~ blocked->sig[2];
-		ready |= signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
-		break;
-
-	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
-		break;
-
-	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
-	}
-	return ready !=	0;
-}
-
 /* True if we are on the alternate signal stack.  */
 
 static inline int on_sig_stack(unsigned long sp)
diff -urpN 07_has_stopped_jobs/kernel/signal.c 08_has_pending_signals/kernel/signal.c
--- 07_has_stopped_jobs/kernel/signal.c	2002-11-10 19:28:10.000000000 -0800
+++ 08_has_pending_signals/kernel/signal.c	2002-11-11 17:34:42.000000000 -0800
@@ -160,6 +160,36 @@ int max_queued_signals = 1024;
 static int
 __send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 
+/*
+ * Re-calculate pending state from the set of locally pending
+ * signals, globally pending signals, and blocked signals.
+ */
+static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
+{
+	unsigned long ready;
+	long i;
+
+	switch (_NSIG_WORDS) {
+	default:
+		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
+			ready |= signal->sig[i] &~ blocked->sig[i];
+		break;
+
+	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
+		ready |= signal->sig[2] &~ blocked->sig[2];
+		ready |= signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
+	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
+	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
+	}
+	return ready !=	0;
+}
+
 #define PENDING(p,b) has_pending_signals(&(p)->signal, (b))
 
 void recalc_sigpending_tsk(struct task_struct *t)
