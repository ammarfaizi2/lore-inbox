Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVIOIvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVIOIvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVIOIvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:51:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7071 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932245AbVIOIvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:51:03 -0400
Date: Thu, 15 Sep 2005 14:20:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Dipankar <dipankar@in.ibm.com>,
       paulmck@us.ibm.com, schwidefsky@de.ibm.com
Subject: [PATCH 1/3] NO_IDLE_HZ support patches - Fix RCU race condition
Message-ID: <20050915085044.GB10191@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below, against 2.6.14-rc1, fixes a race condition wherein a CPU can 
set itself in the nohz_cpu_mask just after a new grace period is started. If 
the CPU continues to skip ticks after that, it can cause the grace
period that was started to be extended unnecessarily.



Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.14-rc1-root/kernel/rcupdate.c |   34 ++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff -puN kernel/rcupdate.c~rcu_race_fix kernel/rcupdate.c
--- linux-2.6.14-rc1/kernel/rcupdate.c~rcu_race_fix	2005-09-13 18:17:32.000000000 +0530
+++ linux-2.6.14-rc1-root/kernel/rcupdate.c	2005-09-13 18:17:42.000000000 +0530
@@ -86,6 +86,30 @@ spinlock_t __rcuref_hash[RCUREF_HASH_SIZ
 };
 #endif
 
+#ifdef CONFIG_NO_IDLE_HZ
+static inline int batch_complete(struct rcu_state *rsp)
+{
+	int rc = 0;
+	cpumask_t tmpmask;
+
+	cpus_andnot(tmpmask, rsp->cpumask, nohz_cpu_mask);
+	if (cpus_empty(tmpmask))
+		rc = 1;
+
+	return rc;
+}
+#else
+static inline int batch_complete(struct rcu_state *rsp)
+{
+	int rc = 0;
+
+	if (cpus_empty(rsp->cpumask))
+		rc = 1;
+
+	return rc;
+}
+#endif
+
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -197,7 +221,13 @@ static void rcu_start_batch(struct rcu_c
 
 	if (rcp->next_pending &&
 			rcp->completed == rcp->cur) {
-		/* Can't change, since spin lock held. */
+		/* cpu_online_map can't change, since a spinlock is held.
+		 * However nohz_cpu_mask can change as we read it. A bad
+		 * case of this race is when a CPU sets itself in the
+		 * nohz_cpu_mask just after we have read it. We take care of
+		 * this bad case when other CPUs call batch_complete() to check
+		 * for batch completion.
+		 */
 		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
 
 		rcp->next_pending = 0;
@@ -217,7 +247,7 @@ static void rcu_start_batch(struct rcu_c
 static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
 {
 	cpu_clear(cpu, rsp->cpumask);
-	if (cpus_empty(rsp->cpumask)) {
+	if (batch_complete(rsp)) {
 		/* batch completed ! */
 		rcp->completed = rcp->cur;
 		rcu_start_batch(rcp, rsp, 0);

_
-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
