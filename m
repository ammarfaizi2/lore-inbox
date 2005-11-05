Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVKEBhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVKEBhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKEBhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:37:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44737 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751439AbVKEBhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:37:07 -0500
Date: Fri, 4 Nov 2005 17:36:51 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       suzannew@cs.pdx.edu, oleg@tv-sign.ru
Subject: [PATCH] Additional/catchup RCU signal fixes for -mm
Message-ID: <20051105013650.GA17461@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Additional RCU signal fixes to cover a race with exec() and to add
some rcu_dereference()s from earlier patches.

Signed-off-by: <paulmck@us.ibm.com>

---

 signal.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-mm0/kernel/signal.c linux-2.6.14-mm0-fix/kernel/signal.c
--- linux-2.6.14-mm0/kernel/signal.c	2005-11-04 14:37:18.000000000 -0800
+++ linux-2.6.14-mm0-fix/kernel/signal.c	2005-11-04 17:23:40.000000000 -0800
@@ -337,7 +337,7 @@ void exit_sighand(struct task_struct *ts
 	write_lock_irq(&tasklist_lock);
 	rcu_read_lock();
 	if (tsk->sighand != NULL) {
-		struct sighand_struct *sighand = tsk->sighand;
+		struct sighand_struct *sighand = rcu_dereference(tsk->sighand);
 		spin_lock(&sighand->siglock);
 		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
@@ -352,13 +352,14 @@ void exit_sighand(struct task_struct *ts
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
@@ -1100,7 +1101,7 @@ void zap_other_threads(struct task_struc
 }
 
 /*
- * Must be called with the tasklist_lock held for reading!
+ * Must be called under rcu_read_lock() or with tasklist_lock read-held.
  */
 int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
@@ -1386,7 +1387,7 @@ send_sigqueue(int sig, struct sigqueue *
 {
 	unsigned long flags;
 	int ret = 0;
-	struct sighand_struct *sh = p->sighand;
+	struct sighand_struct *sh;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
 
@@ -1405,7 +1406,15 @@ send_sigqueue(int sig, struct sigqueue *
 		goto out_err;
 	}
 
+retry:
+	sh = rcu_dereference(p->sighand);
+
 	spin_lock_irqsave(&sh->siglock, flags);
+	if (p->sighand != sh) {
+		/* We raced with exec() in a multithreaded process... */
+		spin_unlock_irqrestore(&sh->siglock, flags);
+		goto retry;
+	}
 
 	/*
 	 * We do the check here again to handle the following scenario:
@@ -1464,15 +1473,8 @@ send_group_sigqueue(int sig, struct sigq
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
 
-	while (!read_trylock(&tasklist_lock)) {
-		if (!p->sighand)
-			return -1;
-		cpu_relax();
-	}
-	if (unlikely(!p->sighand)) {
-		ret = -1;
-		goto out_err;
-	}
+	read_lock(&tasklist_lock);
+	/* Since it_lock is held, p->sighand cannot be NULL. */
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
