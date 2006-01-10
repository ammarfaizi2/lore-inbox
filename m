Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWAJMaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWAJMaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWAJMaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:30:23 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:15269 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750790AbWAJMaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:30:21 -0500
Message-ID: <43C3BAC2.C1F20B95@tv-sign.ru>
Date: Tue, 10 Jan 2006 16:46:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] rcu: don't set ->next_pending in rcu_start_batch()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is better to set ->next_pending in the caller, when
it is needed. This saves one parameter, and this coincides with
cpu_quiet() beahaviour, which sets ->completed = ->cur itself.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/rcupdate.c~2_NPEND	2006-01-10 18:35:45.000000000 +0300
+++ 2.6.15/kernel/rcupdate.c	2006-01-10 18:39:08.000000000 +0300
@@ -249,12 +249,8 @@ static void rcu_do_batch(struct rcu_data
  * active batch and the batch to be registered has not already occurred.
  * Caller must hold rcu_state.lock.
  */
-static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
-				int next_pending)
+static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
 {
-	if (next_pending)
-		rcp->next_pending = 1;
-
 	if (rcp->next_pending &&
 			rcp->completed == rcp->cur) {
 		rcp->next_pending = 0;
@@ -288,7 +284,7 @@ static void cpu_quiet(int cpu, struct rc
 	if (cpus_empty(rsp->cpumask)) {
 		/* batch completed ! */
 		rcp->completed = rcp->cur;
-		rcu_start_batch(rcp, rsp, 0);
+		rcu_start_batch(rcp, rsp);
 	}
 }
 
@@ -423,7 +419,8 @@ static void __rcu_process_callbacks(stru
 		if (!rcp->next_pending) {
 			/* and start it/schedule start if it's a new batch */
 			spin_lock(&rsp->lock);
-			rcu_start_batch(rcp, rsp, 1);
+			rcp->next_pending = 1;
+			rcu_start_batch(rcp, rsp);
 			spin_unlock(&rsp->lock);
 		}
 	} else {
