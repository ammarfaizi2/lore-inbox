Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752666AbWAHSDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbWAHSDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbWAHSDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:03:36 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38884 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1752666AbWAHSDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:03:33 -0500
Message-ID: <43C165D7.6EAB8E47@tv-sign.ru>
Date: Sun, 08 Jan 2006 22:19:51 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/5][RFC] rcu: start new grace period from rcu_pending()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend, see the previous dicsussion:
	http://marc.theaimsgroup.com/?t=110442762800019
Manfred Spraul has another (better) idea to speedup qs detection, but
that would be a more radical change.

Let's suppose that cpu is running idle thread or user level process, and
the grace period was started. Currently we need 2 local timer interrupts
to happen before this cpu can signal the end of it's grace period. This is
because rcu_check_quiescent_state() will reset ->passed_quiesc before it
sets ->qs_pending = 1.

I think it is better to set ->qs_pending = 1 directly in __rcu_pending():

	int __rcu_pending()
	{
		if (qs_pending) return 1;

		if (rdp->quiescbatch != rcp->cur) {
			passed_quiesc = 0;
			barrier();
			qs_pending = 1;
			return 1;
		}
		... other checks ...
	}

	void rcu_check_quiescent_state()
	{
		if (!qs_pending) return;
		barrier();
		if (!passed_quiesc) return;

		cpu_quiet();

		qs_pending = 0;
	}

This way the grace period for that cpu will be completed after the 1st irq.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/rcupdate.c~5_SPEEDUP	2006-01-08 23:49:31.000000000 +0300
+++ 2.6.15/kernel/rcupdate.c	2006-01-09 00:26:44.000000000 +0300
@@ -292,28 +292,25 @@ static void cpu_quiet(int cpu, struct rc
 static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
 					struct rcu_data *rdp)
 {
-	if (rdp->quiescbatch != rcp->cur) {
-		/* start new grace period: */
-		rdp->qs_pending = 1;
-		rdp->passed_quiesc = 0;
-		rdp->quiescbatch = rcp->cur;
-		return;
-	}
-
 	/* Grace period already completed for this cpu?
 	 * qs_pending is checked instead of the actual bitmap to avoid
 	 * cacheline trashing.
 	 */
 	if (!rdp->qs_pending)
 		return;
+	/*
+	 * Protect against the race with __rcu_pending() from local interrupt.
+	 * We should read ->passed_quiesc after we checked ->qs_pending != 0.
+	 * These vars are cpu-local, no need to use memory barriers.
+	 */
+	barrier();
 
-	/* 
+	/*
 	 * Was there a quiescent state since the beginning of the grace
 	 * period? If no, then exit and wait for the next call.
 	 */
 	if (!rdp->passed_quiesc)
 		return;
-	rdp->qs_pending = 0;
 
 	spin_lock(&rcp->lock);
 	/*
@@ -324,6 +321,8 @@ static void rcu_check_quiescent_state(st
 		cpu_quiet(rdp->cpu, rcp);
 
 	spin_unlock(&rcp->lock);
+
+	rdp->qs_pending = 0;
 }
 
 
@@ -435,6 +434,20 @@ static void rcu_process_callbacks(unsign
 
 static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
 {
+	/* The rcu core waits for a quiescent state from the cpu */
+	if (rdp->qs_pending)
+		return 1;
+
+	if (rdp->quiescbatch != rcp->cur) {
+		/* start new grace period: */
+		rdp->quiescbatch = rcp->cur;
+		rdp->passed_quiesc = 0;
+		/* see the comment in rcu_check_quiescent_state() */
+		barrier();
+		rdp->qs_pending = 1;
+		return 1;
+	}
+
 	/* This cpu has pending rcu entries and the grace period
 	 * for them has completed.
 	 */
@@ -445,10 +458,6 @@ static int __rcu_pending(struct rcu_ctrl
 	if (!rdp->curlist && rdp->nxtlist)
 		return 1;
 
-	/* The rcu core waits for a quiescent state from the cpu */
-	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
-		return 1;
-
 	/* nothing to do */
 	return 0;
 }
