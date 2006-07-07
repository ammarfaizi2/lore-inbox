Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWGGXgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWGGXgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWGGXgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:36:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:13034 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932407AbWGGXgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:36:09 -0400
Date: Fri, 7 Jul 2006 16:26:04 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@us.ibm.com
Cc: joe@perches.com, akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, oleg@tv-sign.ru, jes@sgi.com
Subject: [PATCH] srcu-3: improved comment and code-style improvements from Joe Perches
Message-ID: <20060707232604.GA2784@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An improved comment for synchronize_srcu() and fixes for code-style
bugs pointed out by off-list by Joe Perches.

CC: Joe Perches <joe@perches.com>
Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 srcu.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-3/kernel/srcu.c linux-2.6.17-srcu-LKML-4/kernel/srcu.c
--- linux-2.6.17-srcu-LKML-3/kernel/srcu.c	2006-07-06 16:45:01.000000000 -0700
+++ linux-2.6.17-srcu-LKML-4/kernel/srcu.c	2006-07-06 16:50:23.000000000 -0700
@@ -62,7 +62,7 @@ static int srcu_readers_active_idx(struc
 	sum = 0;
 	for_each_possible_cpu(cpu)
 		sum += per_cpu_ptr(sp->per_cpu_ref, cpu)->c[idx];
-	return (sum);
+	return sum;
 }
 
 /**
@@ -144,11 +144,15 @@ void srcu_read_unlock(struct srcu_struct
  * As with classic RCU, the updater must use some separate means of
  * synchronizing concurrent updates.  Can block; must be called from
  * process context.
+ *
+ * Note that it is illegal to call synchornize_srcu() from the corresponding
+ * SRCU read-side critical section; doing so will result in deadlock.
+ * However, it is perfectly legal to call synchronize_srcu() on one
+ * srcu_struct from some other srcu_struct's read-side critical section.
  */
 void synchronize_srcu(struct srcu_struct *sp)
 {
 	int idx;
-	int sum;
 
 	idx = sp->completed;
 	mutex_lock(&sp->mutex);
@@ -195,12 +199,8 @@ void synchronize_srcu(struct srcu_struct
 	 * will have finished executing.
 	 */
 
-	for (;;) {
-		sum = srcu_readers_active_idx(sp, idx);
-		if (sum == 0)
-			break;
+	while (srcu_readers_active_idx(sp, idx))
 		schedule_timeout_interruptible(1);
-	}
 
 	synchronize_sched();  /* Force memory barrier on all CPUs. */
 
