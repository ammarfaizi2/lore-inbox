Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbSJCIVU>; Thu, 3 Oct 2002 04:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263190AbSJCIVU>; Thu, 3 Oct 2002 04:21:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37074 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263185AbSJCIVR>;
	Thu, 3 Oct 2002 04:21:17 -0400
Date: Thu, 3 Oct 2002 09:37:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sigfix-2.5.40-D6
Message-ID: <Pine.LNX.4.44.0210030930090.6426-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch combines all previous sigfix patches, against BK-curr,
and fixes all known signal semantics problems finally.

sigwait() is really evil - i had to re-introduce ->real_blocked. When a
signal has no handler defined then the actual action taken by the kernel
depends on whether the sigwait()-ing thread was blocking the signal
originally or not. If the signal was blocked => specific delivery to the
thread, if the signal was not blocked => kill-all.

fortunately this meant that PF_SIGWAIT could be killed - the real_blocked
field contains all the necessery information to do the right decision at
signal-sending time.

i've also cleaned up and made the shared-pending code more robust: now
there's a single central dequeue_signal() function that handles all the
details. Plus upon unqueueing a shared-pending signal we now re-queue the
signal to the current thread, which this time around is not going to end
up in the shared-pending queue. This change handles the following case
correctly: a signal was blocked in every signal, then one thread unblocks
it and gets the signal delivered - but there's no handler for the signal
=> the correct action is to do a kill-all.

i removed the unused shared_unblocked field as well, reported by Oleg
Nesterov.

now we pass both signal-tst1 and signal-tst2, so i'm confident that we got
most of the details right.

	Ingo

--- linux/include/linux/sched.h.orig	Thu Oct  3 08:23:26 2002
+++ linux/include/linux/sched.h	Thu Oct  3 09:22:41 2002
@@ -378,7 +378,7 @@
 /* signal handlers */
 	struct signal_struct *sig;
 
-	sigset_t blocked, real_blocked, shared_unblocked;
+	sigset_t blocked, real_blocked;
 	struct sigpending pending;
 
 	unsigned long sas_ss_sp;
@@ -529,7 +529,7 @@
 extern void flush_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *);
 extern void sig_exit(int, int, struct siginfo *);
-extern int dequeue_signal(struct sigpending *pending, sigset_t *mask, siginfo_t *info);
+extern int dequeue_signal(sigset_t *mask, siginfo_t *info);
 extern void block_all_signals(int (*notifier)(void *priv), void *priv,
 			      sigset_t *mask);
 extern void unblock_all_signals(void);
--- linux/kernel/signal.c.orig	Thu Oct  3 08:14:48 2002
+++ linux/kernel/signal.c	Thu Oct  3 09:26:00 2002
@@ -405,14 +405,8 @@
 	return 0;
 }
 
-/*
- * Dequeue a signal and return the element to the caller, which is 
- * expected to free it.
- *
- * All callers have to hold the siglock.
- */
-
-int dequeue_signal(struct sigpending *pending, sigset_t *mask, siginfo_t *info)
+static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
+			siginfo_t *info)
 {
 	int sig = 0;
 
@@ -438,6 +432,27 @@
 	return sig;
 }
 
+/*
+ * Dequeue a signal and return the element to the caller, which is 
+ * expected to free it.
+ *
+ * All callers have to hold the siglock.
+ */
+int dequeue_signal(sigset_t *mask, siginfo_t *info)
+{
+	/*
+	 * Here we handle shared pending signals. To implement the full
+	 * semantics we need to unqueue and resend them. It will likely
+	 * get into our own pending queue.
+	 */
+	if (current->sig->shared_pending.head) {
+		int signr = __dequeue_signal(&current->sig->shared_pending, mask, info);
+		if (signr)
+			__send_sig_info(signr, info, current);
+	}
+	return __dequeue_signal(&current->pending, mask, info);
+}
+
 static int rm_from_queue(int sig, struct sigpending *s)
 {
 	struct sigqueue *q, **pp;
@@ -843,8 +858,7 @@
 	struct pid *pid;
 
 	for_each_task_pid(p->tgid, PIDTYPE_TGID, tmp, l, pid)
-		if (!sigismember(&tmp->blocked, signr) &&
-					!sigismember(&tmp->real_blocked, signr))
+		if (!sigismember(&tmp->blocked, signr))
 			return tmp;
 	return NULL;
 }
@@ -887,6 +901,10 @@
 		ret = specific_send_sig_info(sig, info, p, 1);
 		goto out_unlock;
 	}
+	if (sigismember(&t->real_blocked,sig)) {
+		ret = specific_send_sig_info(sig, info, t, 0);
+		goto out_unlock;
+	}
 	if (sig_kernel_broadcast(sig) || sig_kernel_coredump(sig)) {
 		ret = __broadcast_thread_group(p, sig);
 		goto out_unlock;
@@ -1169,10 +1187,7 @@
 		struct k_sigaction *ka;
 
 		spin_lock_irq(&current->sig->siglock);
-		if (current->sig->shared_pending.head)
-			signr = dequeue_signal(&current->sig->shared_pending, mask, info);
-		if (!signr)
-			signr = dequeue_signal(&current->pending, mask, info);
+		signr = dequeue_signal(mask, info);
 		spin_unlock_irq(&current->sig->siglock);
 
 		if (!signr)
@@ -1268,7 +1283,7 @@
 #endif
 
 EXPORT_SYMBOL(recalc_sigpending);
-EXPORT_SYMBOL(dequeue_signal);
+EXPORT_SYMBOL_GPL(dequeue_signal);
 EXPORT_SYMBOL(flush_signals);
 EXPORT_SYMBOL(force_sig);
 EXPORT_SYMBOL(force_sig_info);
@@ -1469,9 +1484,7 @@
 	}
 
 	spin_lock_irq(&current->sig->siglock);
-	sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
-	if (!sig)
-		sig = dequeue_signal(&current->pending, &these, &info);
+	sig = dequeue_signal(&these, &info);
 	if (!sig) {
 		timeout = MAX_SCHEDULE_TIMEOUT;
 		if (uts)
@@ -1491,9 +1504,7 @@
 			timeout = schedule_timeout(timeout);
 
 			spin_lock_irq(&current->sig->siglock);
-			sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
-			if (!sig)
-				sig = dequeue_signal(&current->pending, &these, &info);
+			sig = dequeue_signal(&these, &info);
 			current->blocked = current->real_blocked;
 			siginitset(&current->real_blocked, 0);
 			recalc_sigpending();


