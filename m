Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVKARBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVKARBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVKARBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:01:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:30889 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750960AbVKARBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:01:36 -0500
Date: Tue, 1 Nov 2005 09:01:53 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [PATCH] additional -rt RCU usage fixes
Message-ID: <20051101170153.GA6564@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I guess I need to be more careful when creating experimental RCU patches,
as people have been copying my mistakes.  Here is a patch to fix some of
them in -rt.

Signed-off-by: <paulmck@us.ibm.com>

---

 signal.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-rc5-rt2-ckhandRCUfix/kernel/signal.c linux-2.6.14-rc5-rt2-signalRCUfix/kernel/signal.c
--- linux-2.6.14-rc5-rt2-ckhandRCUfix/kernel/signal.c	2005-10-31 22:28:45.000000000 -0800
+++ linux-2.6.14-rc5-rt2-signalRCUfix/kernel/signal.c	2005-10-31 22:40:07.000000000 -0800
@@ -338,7 +338,7 @@ void exit_sighand(struct task_struct *ts
 	write_lock_irq(&tasklist_lock);
 	rcu_read_lock();
 	if (tsk->sighand != NULL) {
-		struct sighand_struct *sighand = tsk->sighand;
+		struct sighand_struct *sighand = rcu_dereference(tsk->sighand);
 		spin_lock(&sighand->siglock);
 		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
@@ -353,13 +353,14 @@ void exit_sighand(struct task_struct *ts
 void __exit_signal(struct task_struct *tsk)
 {
 	struct signal_struct * sig = tsk->signal;
-	struct sighand_struct * sighand = tsk->sighand;
+	struct sighand_struct * sighand;
 
 	if (!sig)
 		BUG();
 	if (!atomic_read(&sig->count))
 		BUG();
 	rcu_read_lock();
+	sighand = rcu_dereference(tsk->sighand);
 	spin_lock(&sighand->siglock);
 	posix_cpu_timers_exit(tsk);
 	if (atomic_dec_and_test(&sig->count)) {
@@ -1140,7 +1141,7 @@ void zap_other_threads(struct task_struc
 }
 
 /*
- * Must be called with the tasklist_lock held for reading!
+ * Must be called under rcu_read_lock() or with tasklist_lock read-held.
  */
 int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
@@ -1422,7 +1423,7 @@ send_sigqueue(int sig, struct sigqueue *
 {
 	unsigned long flags;
 	int ret = 0;
-	struct sighand_struct *sh = p->sighand;
+	struct sighand_struct *sh;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
 
@@ -1442,6 +1443,8 @@ send_sigqueue(int sig, struct sigqueue *
 		goto out_err;
 	}
 
+	sh = rcu_dereference(p->sighand);
+
 	spin_lock_irqsave(&sh->siglock, flags);
 
 	/*
