Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUK0PCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUK0PCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 10:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUK0PCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 10:02:35 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:27599 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261213AbUK0PC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 10:02:28 -0500
Message-ID: <41A8A57A.DD2338BB@tv-sign.ru>
Date: Sat, 27 Nov 2004 19:04:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: PATCH? rcu: eliminate rcu_ctrlblk.lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am trying to understand the rcu implementetion.

I can't understand why rcu_ctrlblk.seqcount is needed.
It seems to me it can be replaced by a couple of barriers.

I mean:

void rcu_start_batch(rcu_ctrlblk *rcp, rcu_state *rsp, int next_pending)
{
	if (next_pending)
		rcp->next_pending = 1;

	if (rcp->next_pending && rcp->completed == rcp->cur) {
		rsp->cpumask = cpu_online_map;
		rcp->next_pending = 0;
		smp_wmb();			<------------------
		rcp->cur++;
	}
}

void __rcu_process_callbacks(rcu_ctrlblk *rcp, rcu_state *rsp, rcu_data *rdp)
{
	if (rdp->nxtlist && !rdp->curlist)
	{
		rdp->batch = rcp->cur + 1;
		smp_rmb();			<------------------

		if (!rcp->next_pending) {
			spin_lock(&rsp->lock);
			rcu_start_batch(rcp, rsp, 1);
			spin_unlock(&rsp->lock);
		}
	}
}

This way, if __rcu_process_callbacks() sees incremented rcu_ctrlblk.cur
value, it must also see that rcu_ctrlblk.next_pending == 0 (or rcu_start_batch()
is already in progress on another cpu).

Could you please explain to me where may i be wrong?

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc2/include/linux/rcupdate.h~	2004-11-15 17:12:20.000000000 +0300
+++ 2.6.10-rc2/include/linux/rcupdate.h	2004-11-27 21:32:49.812077616 +0300
@@ -65,7 +65,6 @@ struct rcu_ctrlblk {
 	long	cur;		/* Current batch number.                      */
 	long	completed;	/* Number of the last completed batch         */
 	int	next_pending;	/* Is the next batch already waiting?         */
-	seqcount_t lock;	/* For atomic reads of cur and next_pending.  */
 } ____cacheline_maxaligned_in_smp;
 
 /* Is batch a before batch b ? */
--- 2.6.10-rc2/kernel/rcupdate.c~	2004-11-08 19:43:29.000000000 +0300
+++ 2.6.10-rc2/kernel/rcupdate.c	2004-11-27 21:40:02.328325152 +0300
@@ -49,9 +49,9 @@
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
-	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
+	{ .cur = -300, .completed = -300 };
 struct rcu_ctrlblk rcu_bh_ctrlblk =
-	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
+	{ .cur = -300, .completed = -300 };
 
 /* Bookkeeping of the progress of the grace period */
 struct rcu_state {
@@ -185,10 +185,9 @@ static void rcu_start_batch(struct rcu_c
 			rcp->completed == rcp->cur) {
 		/* Can't change, since spin lock held. */
 		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
-		write_seqcount_begin(&rcp->lock);
 		rcp->next_pending = 0;
+		smp_wmb();
 		rcp->cur++;
-		write_seqcount_end(&rcp->lock);
 	}
 }
 
@@ -319,8 +318,6 @@ static void __rcu_process_callbacks(stru
 
 	local_irq_disable();
 	if (rdp->nxtlist && !rdp->curlist) {
-		int next_pending, seq;
-
 		rdp->curlist = rdp->nxtlist;
 		rdp->curtail = rdp->nxttail;
 		rdp->nxtlist = NULL;
@@ -330,14 +327,12 @@ static void __rcu_process_callbacks(stru
 		/*
 		 * start the next batch of callbacks
 		 */
-		do {
-			seq = read_seqcount_begin(&rcp->lock);
-			/* determine batch number */
-			rdp->batch = rcp->cur + 1;
-			next_pending = rcp->next_pending;
-		} while (read_seqcount_retry(&rcp->lock, seq));
 
-		if (!next_pending) {
+		/* determine batch number */
+		rdp->batch = rcp->cur + 1;
+		smp_rmb();
+
+		if (!rcp->next_pending) {
 			/* and start it/schedule start if it's a new batch */
 			spin_lock(&rsp->lock);
 			rcu_start_batch(rcp, rsp, 1);
