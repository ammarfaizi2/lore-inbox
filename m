Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWBRQyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWBRQyO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWBRQyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:54:14 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:64433 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751453AbWBRQyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:54:13 -0500
Message-ID: <43F7636B.2181435A@tv-sign.ru>
Date: Sat, 18 Feb 2006 21:11:55 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] introduce lock_task_sighand() helper
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds lock_task_sighand() helper and converts
group_send_sig_info() to use it. Hopefully we will have
more users soon.

This patch also removes '!sighand->count' and '!p->usage'
checks, I think they both are bogus, racy and unneeded
(but probably it makes sense to restore them as BUG_ON()s).

->sighand is cleared and it's ->count is decremented in
release_task() with sighand->siglock held, so it is a bug
to have '!p->usage || !->count' after we already locked and
verified it is the same. On the other hand, an already dead
task without ->sighand can have a non-zero ->usage due to
ptrace, for example.

If we read the stale value of ->sighand we must see the change
after spin_lock(), because that change was done while holding
that same old ->sighand.siglock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/include/linux/sched.h~2_LTS	2006-02-18 00:05:20.000000000 +0300
+++ 2.6.16-rc3/include/linux/sched.h	2006-02-18 22:13:44.000000000 +0300
@@ -1217,6 +1217,15 @@ static inline void task_unlock(struct ta
 	spin_unlock(&p->alloc_lock);
 }
 
+extern struct sighand_struct *lock_task_sighand(struct task_struct *tsk,
+							unsigned long *flags);
+
+static inline void unlock_task_sighand(struct task_struct *tsk,
+						unsigned long *flags)
+{
+	spin_unlock_irqrestore(&tsk->sighand->siglock, *flags);
+}
+
 #ifndef __HAVE_THREAD_FUNCTIONS
 
 #define task_thread_info(task) (task)->thread_info
--- 2.6.16-rc3/kernel/signal.c~2_LTS	2006-02-18 00:07:37.000000000 +0300
+++ 2.6.16-rc3/kernel/signal.c	2006-02-18 22:34:22.000000000 +0300
@@ -1120,31 +1120,41 @@ void zap_other_threads(struct task_struc
 /*
  * Must be called under rcu_read_lock() or with tasklist_lock read-held.
  */
-int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
-{
-	unsigned long flags;
-	struct sighand_struct *sp;
-	int ret;
-
-retry:
-	ret = check_kill_permission(sig, info, p);
-	if (!ret && sig && (sp = rcu_dereference(p->sighand))) {
-		spin_lock_irqsave(&sp->siglock, flags);
-		if (p->sighand != sp) {
-			spin_unlock_irqrestore(&sp->siglock, flags);
-			goto retry;
-		}
-		if ((atomic_read(&sp->count) == 0) ||
-				(atomic_read(&p->usage) == 0)) {
-			spin_unlock_irqrestore(&sp->siglock, flags);
-			return -ESRCH;
-		}
-		ret = __group_send_sig_info(sig, info, p);
-		spin_unlock_irqrestore(&sp->siglock, flags);
-	}
-
-	return ret;
-}
+struct sighand_struct *lock_task_sighand(struct task_struct *tsk, unsigned long *flags)
+{
+	struct sighand_struct *sighand;
+
+	for (;;) {
+		sighand = rcu_dereference(tsk->sighand);
+		if (unlikely(sighand == NULL))
+			break;
+
+		spin_lock_irqsave(&sighand->siglock, *flags);
+		if (likely(sighand == tsk->sighand))
+			break;
+		spin_unlock_irqrestore(&sighand->siglock, *flags);
+	}
+
+	return sighand;
+}
+
+int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+{
+	unsigned long flags;
+	int ret;
+
+	ret = check_kill_permission(sig, info, p);
+
+	if (!ret && sig) {
+		ret = -ESRCH;
+		if (lock_task_sighand(p, &flags)) {
+			ret = __group_send_sig_info(sig, info, p);
+			unlock_task_sighand(p, &flags);
+		}
+	}
+
+	return ret;
+}
 
 /*
  * kill_pg_info() sends a signal to a process group: this is what the tty
