Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933018AbWFZUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018AbWFZUSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933019AbWFZUSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:18:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47060 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933018AbWFZUSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:18:13 -0400
Date: Mon, 26 Jun 2006 13:18:49 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Fw: [PATCH 2/2] srcu: add SRCU operations to rcutorture
Message-ID: <20060626201849.GC2396@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds SRCU operations to rcutorture and updates rcutorture documentation.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/torture.txt |   15 +++++++
 kernel/rcutorture.c           |   89 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 3 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-srcu/Documentation/RCU/torture.txt linux-2.6.17-torturesrcu/Documentation/RCU/torture.txt
--- linux-2.6.17-srcu/Documentation/RCU/torture.txt	2006-06-24 12:13:12.000000000 -0700
+++ linux-2.6.17-torturesrcu/Documentation/RCU/torture.txt	2006-06-24 12:13:45.000000000 -0700
@@ -118,6 +118,21 @@ o	"Free-Block Circulation": Shows the nu
 	as it is only incremented if a torture structure's counter
 	somehow gets incremented farther than it should.
 
+Different implementations of RCU can provide implementation-specific
+additional information.  For example, SRCU provides the following:
+
+	srcu-torture: rtc: f8cf46a8 ver: 355 tfle: 0 rta: 356 rtaf: 0 rtf: 346 rtmbe: 0
+	srcu-torture: Reader Pipe:  559738 939 0 0 0 0 0 0 0 0 0
+	srcu-torture: Reader Batch:  560434 243 0 0 0 0 0 0 0 0
+	srcu-torture: Free-Block Circulation:  355 354 353 352 351 350 349 348 347 346 0
+	srcu-torture: per-CPU(idx=1): 0(0,1) 1(0,1) 2(0,0) 3(0,1)
+
+The first four lines are similar to those for RCU.  The last line shows
+the per-CPU counter state.  The numbers in parentheses are the values
+of the "old" and "current" counters for the corresponding CPU.  The
+"idx" value maps the "old" and "current" values to the underlying array,
+and is useful for debugging.
+
 
 USAGE
 
diff -urpNa -X dontdiff linux-2.6.17-srcu/kernel/rcutorture.c linux-2.6.17-torturesrcu/kernel/rcutorture.c
--- linux-2.6.17-srcu/kernel/rcutorture.c	2006-06-24 11:52:08.000000000 -0700
+++ linux-2.6.17-torturesrcu/kernel/rcutorture.c	2006-06-24 11:51:16.000000000 -0700
@@ -44,6 +44,7 @@
 #include <linux/delay.h>
 #include <linux/byteorder/swabb.h>
 #include <linux/stat.h>
+#include <linux/srcu.h>
 
 MODULE_LICENSE("GPL");
 
@@ -53,7 +54,7 @@ static int stat_interval;	/* Interval be
 static int verbose;		/* Print more debug info. */
 static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
 static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
-static char *torture_type = "rcu"; /* What to torture. */
+static char *torture_type = "rcu"; /* What to torture: rcu, srcu. */
 
 module_param(nreaders, int, 0);
 MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
@@ -66,7 +67,7 @@ MODULE_PARM_DESC(test_no_idle_hz, "Test 
 module_param(shuffle_interval, int, 0);
 MODULE_PARM_DESC(shuffle_interval, "Number of seconds between shuffles");
 module_param(torture_type, charp, 0);
-MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, rcu_bh)");
+MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, rcu_bh, srcu)");
 
 #define TORTURE_FLAG "-torture:"
 #define PRINTK_STRING(s) \
@@ -282,8 +283,90 @@ static struct rcu_torture_ops rcu_bh_ops
 	.name = "rcu_bh"
 };
 
+/*
+ * Definitions for srcu torture testing.
+ */
+
+static struct srcu_struct srcu_ctl;
+static struct list_head srcu_removed;
+
+static void srcu_torture_init(void)
+{
+	init_srcu_struct(&srcu_ctl);
+	INIT_LIST_HEAD(&srcu_removed);
+}
+
+static void srcu_torture_cleanup(void)
+{
+	synchronize_srcu(&srcu_ctl);
+	cleanup_srcu_struct(&srcu_ctl);
+}
+
+static int srcu_torture_read_lock(void)
+{
+	return (srcu_read_lock(&srcu_ctl));
+}
+
+static void srcu_torture_read_unlock(int idx)
+{
+	srcu_read_unlock(&srcu_ctl, idx);
+}
+
+static int srcu_torture_completed(void)
+{
+	return srcu_batches_completed(&srcu_ctl);
+}
+
+static void srcu_torture_deferred_free(struct rcu_torture *p)
+{
+	int i;
+	struct rcu_torture *rp;
+	struct rcu_torture *rp1;
+
+	synchronize_srcu(&srcu_ctl);
+	list_add(&p->rtort_free, &srcu_removed);
+	list_for_each_entry_safe(rp, rp1, &srcu_removed, rtort_free) {
+		i = rp->rtort_pipe_count;
+		if (i > RCU_TORTURE_PIPE_LEN)
+			i = RCU_TORTURE_PIPE_LEN;
+		atomic_inc(&rcu_torture_wcount[i]);
+		if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+			rp->rtort_mbtest = 0;
+			list_del(&rp->rtort_free);
+			rcu_torture_free(rp);
+		}
+	}
+}
+
+int srcu_torture_stats(char *page)
+{
+	int cnt = 0;
+	int cpu;
+	int idx = srcu_ctl.completed & 0x1;
+
+	cnt += sprintf(&page[cnt], "%s%s per-CPU(idx=%d):", torture_type, TORTURE_FLAG, idx);
+	for_each_cpu(cpu) {
+		cnt += sprintf(&page[cnt], " %d(%d,%d)", cpu,
+			       srcu_ctl.per_cpu_ref[cpu].c[!idx],
+			       srcu_ctl.per_cpu_ref[cpu].c[idx]);
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	return (cnt);
+}
+
+static struct rcu_torture_ops srcu_ops = {
+	.init = srcu_torture_init,
+	.cleanup = srcu_torture_cleanup,
+	.readlock = srcu_torture_read_lock,
+	.readunlock = srcu_torture_read_unlock,
+	.completed = srcu_torture_completed,
+	.deferredfree = srcu_torture_deferred_free,
+	.stats = srcu_torture_stats,
+	.name = "srcu"
+};
+
 static struct rcu_torture_ops *torture_ops[] =
-	{ &rcu_ops, &rcu_bh_ops, NULL };
+	{ &rcu_ops, &rcu_bh_ops, &srcu_ops, NULL };
 
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure

