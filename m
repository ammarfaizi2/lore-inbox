Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268822AbTGaUgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbTGaUgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 16:36:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47032 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268822AbTGaUgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 16:36:17 -0400
Date: Fri, 1 Aug 2003 02:08:31 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Dave Miller <davem@redhat.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] Monitor RCU grace period
Message-ID: <20030731203831.GG1990@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a culmination of a long investigation of a problem
Robert encountered while doing DoS testing on a linux router. The
symptoms were that the route cache would overflow and it looked
like RCU isn't happening. This particular test had a process
installing many ipv4 routes while a packet flood was going
on.

It turned out that the test had softirqs running on a CPU for
more than 20 seconds at a time, a very bad situation. This required
a mechanism to detect if a CPU is stalled in such manner preventing
user processes from executing. Since RCU already does accounting for
forward progress (context switch/idle/user process detection counter),
such infrastructure can be taken advantage of and I implemented a
simple API rcu_grace_period(int cpu) that returns the length of
the grace period of the current CPU in terms of jiffies. This can be 
used by livelock sensitive code to detect forward progress. This
was used in Robert's test setup to put an upper bound on softirqs
and switch over to using ksoftirqds to avoid long running softirqs
which solved his problem.

The rcu-monitor-grace-period patch monitors only the CPUs that
are currently participating in the grace period. If it has
context switched or there is no RCU pending in the system,
it returns 0. Should there be a need to do this unconditionally,
I can add the support for that too.

Thanks
Dipankar




This patch implements monitoring of rcu grace period so that
it can be used in other places in the kernel for livelock
detection. We monitor the per-cpu quiescent state counter.
We start counting ticks when a cpu starts participating in
a RCU grace period. Every scheduler tick, when we check
if the counter changed, we update this tick if there is no
change. When the counter changes, we reset it. Later on we
can check a stuck cpu by looking at this value. If there is no
rcu going on, we don't monitor the quiescent state counter,
so cpu stalls aren't detected.


 include/linux/rcupdate.h |   10 ++++++++++
 kernel/rcupdate.c        |    7 ++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff -puN include/linux/rcupdate.h~rcu-monitor-grace-period include/linux/rcupdate.h
--- linux-2.6.0-test2-rcu/include/linux/rcupdate.h~rcu-monitor-grace-period	2003-08-01 01:26:26.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/include/linux/rcupdate.h	2003-08-01 01:32:59.000000000 +0530
@@ -40,6 +40,7 @@
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
+#include <linux/jiffies.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -95,6 +96,8 @@ struct rcu_data {
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+	unsigned long 	grace_start;
+	unsigned long 	grace_ticks;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -105,6 +108,8 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
+#define RCU_grace_start(cpu) 	(per_cpu(rcu_data, (cpu)).grace_start)
+#define RCU_grace_ticks(cpu) 	(per_cpu(rcu_data, (cpu)).grace_ticks)
 
 #define RCU_QSCTR_INVALID	0
 
@@ -123,6 +128,11 @@ static inline int rcu_pending(int cpu) 
 #define rcu_read_lock()		preempt_disable()
 #define rcu_read_unlock()	preempt_enable()
 
+static inline unsigned long rcu_grace_period(int cpu)
+{
+	return RCU_grace_ticks(cpu);
+}
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 
diff -puN kernel/rcupdate.c~rcu-monitor-grace-period kernel/rcupdate.c
--- linux-2.6.0-test2-rcu/kernel/rcupdate.c~rcu-monitor-grace-period	2003-08-01 01:26:26.000000000 +0530
+++ linux-2.6.0-test2-rcu-dipankar/kernel/rcupdate.c	2003-08-01 01:37:15.000000000 +0530
@@ -132,16 +132,21 @@ static void rcu_check_quiescent_state(vo
 	 */
 	if (RCU_last_qsctr(cpu) == RCU_QSCTR_INVALID) {
 		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
+		RCU_grace_start(cpu) = jiffies;
+		RCU_grace_ticks(cpu) = 0UL;
 		return;
 	}
-	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu))
+	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu)) {
+		RCU_grace_ticks(cpu) = jiffies - RCU_grace_start(cpu);
 		return;
+	}
 
 	spin_lock(&rcu_ctrlblk.mutex);
 	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
 		goto out_unlock;
 
 	clear_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask);
+	RCU_grace_ticks(cpu) = 0UL;
 	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
 	if (rcu_ctrlblk.rcu_cpu_mask != 0)
 		goto out_unlock;

_
