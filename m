Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbSJBQYK>; Wed, 2 Oct 2002 12:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263150AbSJBQYK>; Wed, 2 Oct 2002 12:24:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10454 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263147AbSJBQYI>;
	Wed, 2 Oct 2002 12:24:08 -0400
Date: Wed, 2 Oct 2002 18:39:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sigfix-2.5.40-B1
Message-ID: <Pine.LNX.4.44.0210021836050.1805-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch (ontop of the previous signal patch) fixes one more
thread-signals testcase. POSIX treats threads in sigwait() as a special
thing - eg. the 'action' of a signal must not be considered for a thread
that is in sigwait(). Ie. if no handler is defined and the only thread
accepting a given signal is one in sigwait(), then the signal must be
queued to that signal.

this should fix Axel Zeuner's sigwait() testcase.

	Ingo

--- linux/include/linux/sched.h.orig	Wed Oct  2 18:10:24 2002
+++ linux/include/linux/sched.h	Wed Oct  2 18:12:14 2002
@@ -430,6 +430,7 @@
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
 #define PF_SYNC		0x00080000	/* performing fsync(), etc */
 #define PF_FSTRANS	0x00100000	/* inside a filesystem transaction */
+#define PF_SIGWAIT	0x00200000	/* inside sigwait */
 
 /*
  * Ptrace flags
--- linux/kernel/signal.c.orig	Wed Oct  2 18:08:39 2002
+++ linux/kernel/signal.c	Wed Oct  2 18:14:05 2002
@@ -886,6 +886,10 @@
 		ret = specific_send_sig_info(sig, info, p, 1);
 		goto out_unlock;
 	}
+	if (t->flags & PF_SIGWAIT) {
+		ret = specific_send_sig_info(sig, info, t, 0);
+		goto out_unlock;
+	}
 	if (sig_kernel_broadcast(sig) || sig_kernel_coredump(sig)) {
 		ret = __broadcast_thread_group(p, sig);
 		goto out_unlock;
@@ -1485,12 +1489,14 @@
 
 			sigandsets(&current->blocked, &current->blocked, &these);
 			recalc_sigpending();
+			current->flags |= PF_SIGWAIT;
 			spin_unlock_irq(&current->sig->siglock);
 
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
 			spin_lock_irq(&current->sig->siglock);
+			current->flags &= ~PF_SIGWAIT;
 			sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
 			if (!sig)
 				sig = dequeue_signal(&current->pending, &these, &info);


