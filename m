Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUL3POT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUL3POT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUL3POT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:14:19 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:665 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261651AbUL3PNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:13:23 -0500
Message-ID: <41D429C5.F32D7161@tv-sign.ru>
Date: Thu, 30 Dec 2004 19:16:05 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rcu: speed up quiescent state detection
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of Manfred's 'rcu: simplify quiescent state detection', see
http://marc.theaimsgroup.com/?l=linux-kernel&m=110433412126392

Let's suppose that cpu is running idle thread or user level process,
and the grace period was started.

Afaics, currently we need 2 local timer interrupts to happen before
this cpu can end its grace period.

1st timer_interrupt:
	__rcu_pending():
		if (rdp->quiescbatch != rcp->cur)
			return 1;
	rcu_check_callbacks():
		if (user || idle)
			->passed_quiesc = 1;
		tasklet_schedule(rcu_tasklet)
		do_softirq():
			__rcu_process_callbacks():
				rcu_check_quiescent_state()
					if (rdp->quiescbatch != rcp->cur) {
						->qs_pending = 1;
						->passed_quiesc = 0;
						return;
					}

Only the next interrupt will notice ->qs_pending in __rcu_pending() and
increment ->completed in rcu_check_quiescent_state().

I think it is better to set ->qs_pending = 1 directly in __rcu_pending():

	int __rcu_pending()
	{
		if (qs_pending) return 1;

		if (quiescbatch != rcp->cur) {
			quiescbatch = rcp->cur;
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

This way grace period for that cpu will be completed after 1st interupt.

Note that when fork()->scheduler_tick()->rcu_pending() runs in process
context, it does this with interrupts disabled, so there is no race with
timer interrupt (Although i think that it is better to call rcu_pending()
directly from update_process_times() instead).

What do you think?

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10/include/linux/rcupdate.h~	2004-12-30 18:31:43.486279168 +0300
+++ 2.6.10/include/linux/rcupdate.h	2004-12-30 20:21:49.589998752 +0300
@@ -124,30 +124,7 @@ static inline void rcu_bh_qsctr_inc(int 
 	rdp->passed_quiesc = 1;
 }
 
-static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
-						struct rcu_data *rdp)
-{
-	/* This cpu has pending rcu entries and the grace period
-	 * for them has completed.
-	 */
-	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
-		return 1;
-
-	/* This cpu has no pending entries, but there are new entries */
-	if (!rdp->curlist && rdp->nxtlist)
-		return 1;
-
-	/* This cpu has finished callbacks to invoke */
-	if (rdp->donelist)
-		return 1;
-
-	/* The rcu core waits for a quiescent state from the cpu */
-	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
-		return 1;
-
-	/* nothing to do */
-	return 0;
-}
+extern int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp);
 
 static inline int rcu_pending(int cpu)
 {
--- 2.6.10/kernel/rcupdate.c~	2004-12-30 19:45:36.290390512 +0300
+++ 2.6.10/kernel/rcupdate.c	2004-12-30 20:20:59.955544336 +0300
@@ -207,6 +207,39 @@ static void cpu_quiet(int cpu, struct rc
 	}
 }
 
+int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
+{
+	/* The rcu core waits for a quiescent state from the cpu */
+	if (rdp->qs_pending)
+		return 1;
+
+	if (rdp->quiescbatch != rcp->cur) {
+		/* start new grace period: */
+		rdp->quiescbatch = rcp->cur;
+		rdp->passed_quiesc = 0;
+		barrier();
+		rdp->qs_pending = 1;
+		return 1;
+	}
+
+	/* This cpu has pending rcu entries and the grace period
+	 * for them has completed.
+	 */
+	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
+		return 1;
+
+	/* This cpu has no pending entries, but there are new entries */
+	if (!rdp->curlist && rdp->nxtlist)
+		return 1;
+
+	/* This cpu has finished callbacks to invoke */
+	if (rdp->donelist)
+		return 1;
+
+	/* nothing to do */
+	return 0;
+}
+
 /*
  * Check if the cpu has gone through a quiescent state (say context
  * switch). If so and if it already hasn't done so in this RCU
@@ -215,14 +248,6 @@ static void cpu_quiet(int cpu, struct rc
 static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
 			struct rcu_state *rsp, struct rcu_data *rdp)
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
@@ -234,9 +259,9 @@ static void rcu_check_quiescent_state(st
 	 * Was there a quiescent state since the beginning of the grace
 	 * period? If no, then exit and wait for the next call.
 	 */
+	barrier();
 	if (!rdp->passed_quiesc)
 		return;
-	rdp->qs_pending = 0;
 
 	spin_lock(&rsp->lock);
 	/*
@@ -247,6 +272,8 @@ static void rcu_check_quiescent_state(st
 		cpu_quiet(rdp->cpu, rcp, rsp);
 
 	spin_unlock(&rsp->lock);
+
+	rdp->qs_pending = 0;
 }
