Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSKSOnc>; Tue, 19 Nov 2002 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSKSOnc>; Tue, 19 Nov 2002 09:43:32 -0500
Received: from holomorphy.com ([66.224.33.161]:1765 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265414AbSKSOn1>;
	Tue, 19 Nov 2002 09:43:27 -0500
Date: Tue, 19 Nov 2002 06:47:40 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [2/2] privatize has_pending_signals() from sched.h
Message-ID: <0211190647.Wbaafa~cOcEaAdPc2dvbzbKaNaRbYa1a28334@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0211190647.BccdTchaqcDbBa8bAcgcOcbclc9dAdhc28334@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This privizes has_pending_signals() to signal.c, where its
sole callers are.

 include/linux/sched.h |   30 ------------------------------
 kernel/signal.c       |   30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)


diff -urpN siblings-2.5.48/include/linux/sched.h pending-2.5.48/include/linux/sched.h
--- siblings-2.5.48/include/linux/sched.h	2002-11-19 05:49:43.000000000 -0800
+++ pending-2.5.48/include/linux/sched.h	2002-11-19 05:53:34.000000000 -0800
@@ -524,36 +524,6 @@ extern int kill_proc(pid_t, int, int);
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
diff -urpN siblings-2.5.48/kernel/signal.c pending-2.5.48/kernel/signal.c
--- siblings-2.5.48/kernel/signal.c	2002-11-17 20:29:32.000000000 -0800
+++ pending-2.5.48/kernel/signal.c	2002-11-19 05:53:34.000000000 -0800
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
