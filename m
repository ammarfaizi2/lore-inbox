Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUL2P0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUL2P0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUL2P0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:26:05 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:52868 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261357AbUL2PZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:25:49 -0500
Date: Wed, 29 Dec 2004 16:25:44 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, <oleg@tv-sign.ru>
Subject: [PATCH 1/2 2.6.10] rcu: simplify quiescent state detection
Message-ID: <Pine.LNX.4.44.0412291623320.7011-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Based on an initial patch from Oleg Nesterov:

> Is the rcu_data.last_qsctr really needed?
>
> It is used in rcu_check_quiescent_state() exclusively.
> I think we can reset qsctr at the start of the grace period,
> and then just test qsctr against 0.
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

No, it's not needed. Actually: not even a counter is needed, just
a flag that indicates that there was a quiescent state.

Updated, rediffed against 2.6.10 and tested.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 10
//  EXTRAVERSION =
--- 2.6/include/linux/rcupdate.h	2004-12-29 15:35:54.000000000 +0100
+++ build-2.6/include/linux/rcupdate.h	2004-12-29 15:58:30.335784619 +0100
@@ -88,9 +88,7 @@
 struct rcu_data {
 	/* 1) quiescent state handling : */
 	long		quiescbatch;     /* Batch # for grace period */
-	long		qsctr;		 /* User-mode/idle loop etc. */
-	long            last_qsctr;	 /* value of qsctr at beginning */
-					 /* of rcu grace period */
+	int		passed_quiesc;	 /* User-mode/idle loop etc. */
 	int		qs_pending;	 /* core waits for quiesc state */

 	/* 2) batch handling */
@@ -110,17 +108,20 @@
 extern struct rcu_ctrlblk rcu_bh_ctrlblk;

 /*
- * Increment the quiscent state counter.
+ * Increment the quiescent state counter.
+ * The counter is a bit degenerated: We do not need to know
+ * how many quiescent states passed, just if there was at least
+ * one since the start of the grace period. Thus just a flag.
  */
 static inline void rcu_qsctr_inc(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	rdp->qsctr++;
+	rdp->passed_quiesc = 1;
 }
 static inline void rcu_bh_qsctr_inc(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
-	rdp->qsctr++;
+	rdp->passed_quiesc = 1;
 }

 static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
--- 2.6/kernel/rcupdate.c	2004-12-29 15:35:54.000000000 +0100
+++ build-2.6/kernel/rcupdate.c	2004-12-29 16:00:43.938620070 +0100
@@ -216,9 +216,9 @@
 			struct rcu_state *rsp, struct rcu_data *rdp)
 {
 	if (rdp->quiescbatch != rcp->cur) {
-		/* new grace period: record qsctr value. */
+		/* start new grace period: */
 		rdp->qs_pending = 1;
-		rdp->last_qsctr = rdp->qsctr;
+		rdp->passed_quiesc = 0;
 		rdp->quiescbatch = rcp->cur;
 		return;
 	}
@@ -231,11 +231,10 @@
 		return;

 	/*
-	 * Races with local timer interrupt - in the worst case
-	 * we may miss one quiescent state of that CPU. That is
-	 * tolerable. So no need to disable interrupts.
+	 * Was there a quiescent state since the beginning of the grace
+	 * period? If no, then exit and wait for the next call.
 	 */
-	if (rdp->qsctr == rdp->last_qsctr)
+	if (!rdp->passed_quiesc)
 		return;
 	rdp->qs_pending = 0;


