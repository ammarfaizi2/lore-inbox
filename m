Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWHSAqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWHSAqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWHSAqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:46:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:38546 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751614AbWHSAqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:46:51 -0400
Subject: [PATCH] RCU: add fake writers to rcutorture
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Paul McKenney <paulmck@us.ibm.com>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 17:46:51 -0700
Message-Id: <1155948411.5337.14.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcutorture currently has one writer and an arbitrary number of readers.
To better exercise some of the code paths in RCU implementations, add
fake writer threads which call the synchronize function for the RCU
variant in a loop, with a delay between calls to arrange for different
numbers of writers running in parallel.
---
 Documentation/RCU/torture.txt |    9 +++
 kernel/rcutorture.c           |  109 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
index 2174bad..2180ef9 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.txt
@@ -28,6 +28,15 @@ nreaders	This is the number of RCU readi
 		To properly exercise RCU implementations with preemptible
 		read-side critical sections.
 
+nfakewriters	This is the number of RCU fake writer threads to run.  Fake
+		writer threads repeatedly use the synchronous "wait for
+		current readers" function of the interface selected by
+		torture_type, with a delay between calls to allow for various
+		different numbers of writers running in parallel.
+		nfakewriters defaults to 4, which provides enough parallelism
+		to trigger special cases caused by multiple writers, such as
+		the synchronize_srcu() early return optimization.
+
 stat_interval	The number of seconds between output of torture
 		statistics (via printk()).  Regardless of the interval,
 		statistics are printed when the module is unloaded.
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 43d6d4f..fdd678b 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -15,9 +15,10 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Copyright (C) IBM Corporation, 2005
+ * Copyright (C) IBM Corporation, 2005, 2006
  *
  * Authors: Paul E. McKenney <paulmck@us.ibm.com>
+ *          Josh Triplett <josh@freedesktop.org>
  *
  * See also:  Documentation/RCU/torture.txt
  */
@@ -47,9 +48,11 @@ #include <linux/stat.h>
 #include <linux/srcu.h>
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com>");
+MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com> and "
+              "Josh Triplett <josh@freedesktop.org>");
 
 static int nreaders = -1;	/* # reader threads, defaults to 2*ncpus */
+static int nfakewriters = 4;	/* # fake writer threads */
 static int stat_interval;	/* Interval between stats, in seconds. */
 				/*  Defaults to "only at end of test". */
 static int verbose;		/* Print more debug info. */
@@ -59,6 +62,8 @@ static char *torture_type = "rcu"; /* Wh
 
 module_param(nreaders, int, 0);
 MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
+module_param(nfakewriters, int, 0);
+MODULE_PARM_DESC(nfakewriters, "Number of RCU fake writer threads");
 module_param(stat_interval, int, 0);
 MODULE_PARM_DESC(stat_interval, "Number of seconds between stats printk()s");
 module_param(verbose, bool, 0);
@@ -82,6 +87,7 @@ static char printk_buf[4096];
 
 static int nrealreaders;
 static struct task_struct *writer_task;
+static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *shuffler_task;
@@ -186,6 +192,7 @@ struct rcu_torture_ops {
 	void (*readunlock)(int idx);
 	int (*completed)(void);
 	void (*deferredfree)(struct rcu_torture *p);
+	void (*sync)(void);
 	int (*stats)(char *page);
 	char *name;
 };
@@ -258,6 +265,7 @@ static struct rcu_torture_ops rcu_ops = 
 	.readunlock = rcu_torture_read_unlock,
 	.completed = rcu_torture_completed,
 	.deferredfree = rcu_torture_deferred_free,
+	.sync = synchronize_rcu,
 	.stats = NULL,
 	.name = "rcu"
 };
@@ -287,6 +295,28 @@ static void rcu_bh_torture_deferred_free
 	call_rcu_bh(&p->rtort_rcu, rcu_torture_cb);
 }
 
+struct rcu_bh_torture_synchronize {
+	struct rcu_head head;
+	struct completion completion;
+};
+
+static void rcu_bh_torture_wakeme_after_cb(struct rcu_head *head)
+{
+	struct rcu_bh_torture_synchronize *rcu;
+
+	rcu = container_of(head, struct rcu_bh_torture_synchronize, head);
+	complete(&rcu->completion);
+}
+
+void rcu_bh_torture_synchronize(void)
+{
+	struct rcu_bh_torture_synchronize rcu;
+
+	init_completion(&rcu.completion);
+	call_rcu_bh(&rcu.head, rcu_bh_torture_wakeme_after_cb);
+	wait_for_completion(&rcu.completion);
+}
+
 static struct rcu_torture_ops rcu_bh_ops = {
 	.init = NULL,
 	.cleanup = NULL,
@@ -295,6 +325,7 @@ static struct rcu_torture_ops rcu_bh_ops
 	.readunlock = rcu_bh_torture_read_unlock,
 	.completed = rcu_bh_torture_completed,
 	.deferredfree = rcu_bh_torture_deferred_free,
+	.sync = rcu_bh_torture_synchronize,
 	.stats = NULL,
 	.name = "rcu_bh"
 };
@@ -367,6 +398,11 @@ static void srcu_torture_deferred_free(s
 	}
 }
 
+static void srcu_torture_synchronize(void)
+{
+	synchronize_srcu(&srcu_ctl);
+}
+
 static int srcu_torture_stats(char *page)
 {
 	int cnt = 0;
@@ -392,6 +428,7 @@ static struct rcu_torture_ops srcu_ops =
 	.readunlock = srcu_torture_read_unlock,
 	.completed = srcu_torture_completed,
 	.deferredfree = srcu_torture_deferred_free,
+	.sync = srcu_torture_synchronize,
 	.stats = srcu_torture_stats,
 	.name = "srcu"
 };
@@ -444,6 +481,30 @@ rcu_torture_writer(void *arg)
 }
 
 /*
+ * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
+ * delay between calls.
+ */
+static int
+rcu_torture_fakewriter(void *arg)
+{
+	DEFINE_RCU_RANDOM(rand);
+
+	VERBOSE_PRINTK_STRING("rcu_torture_fakewriter task started");
+	set_user_nice(current, 19);
+
+	do {
+		schedule_timeout_uninterruptible(1 + rcu_random(&rand)%10);
+		udelay(rcu_random(&rand) & 0x3ff);
+		cur_ops->sync();
+	} while (!kthread_should_stop() && !fullstop);
+
+	VERBOSE_PRINTK_STRING("rcu_torture_fakewriter task stopping");
+	while (!kthread_should_stop())
+		schedule_timeout_uninterruptible(1);
+	return 0;
+}
+
+/*
  * RCU torture reader kthread.  Repeatedly dereferences rcu_torture_current,
  * incrementing the corresponding element of the pipeline array.  The
  * counter in the element should never be greater than 1, otherwise, the
@@ -621,6 +682,12 @@ static void rcu_torture_shuffle_tasks(vo
 				set_cpus_allowed(reader_tasks[i], tmp_mask);
 	}
 
+	if (fakewriter_tasks != NULL) {
+		for (i = 0; i < nfakewriters; i++)
+			if (fakewriter_tasks[i])
+				set_cpus_allowed(fakewriter_tasks[i], tmp_mask);
+	}
+
 	if (writer_task)
 		set_cpus_allowed(writer_task, tmp_mask);
 
@@ -654,11 +721,12 @@ rcu_torture_shuffle(void *arg)
 static inline void
 rcu_torture_print_module_parms(char *tag)
 {
-	printk(KERN_ALERT "%s" TORTURE_FLAG "--- %s: nreaders=%d "
+	printk(KERN_ALERT "%s" TORTURE_FLAG
+		"--- %s: nreaders=%d nfakewriters=%d "
 		"stat_interval=%d verbose=%d test_no_idle_hz=%d "
 		"shuffle_interval = %d\n",
-		torture_type, tag, nrealreaders, stat_interval, verbose,
-		test_no_idle_hz, shuffle_interval);
+		torture_type, tag, nrealreaders, nfakewriters,
+		stat_interval, verbose, test_no_idle_hz, shuffle_interval);
 }
 
 static void
@@ -693,6 +761,19 @@ rcu_torture_cleanup(void)
 	}
 	rcu_torture_current = NULL;
 
+	if (fakewriter_tasks != NULL) {
+		for (i = 0; i < nfakewriters; i++) {
+			if (fakewriter_tasks[i] != NULL) {
+				VERBOSE_PRINTK_STRING(
+					"Stopping rcu_torture_fakewriter task");
+				kthread_stop(fakewriter_tasks[i]);
+			}
+			fakewriter_tasks[i] = NULL;
+		}
+		kfree(fakewriter_tasks);
+		fakewriter_tasks = NULL;
+	}
+
 	if (stats_task != NULL) {
 		VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
 		kthread_stop(stats_task);
@@ -780,6 +861,24 @@ rcu_torture_init(void)
 		writer_task = NULL;
 		goto unwind;
 	}
+	fakewriter_tasks = kzalloc(nfakewriters * sizeof(fakewriter_tasks[0]),
+	                           GFP_KERNEL);
+	if (fakewriter_tasks == NULL) {
+		VERBOSE_PRINTK_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+	for (i = 0; i < nfakewriters; i++) {
+		VERBOSE_PRINTK_STRING("Creating rcu_torture_fakewriter task");
+		fakewriter_tasks[i] = kthread_run(rcu_torture_fakewriter, NULL,
+		                                  "rcu_torture_fakewriter");
+		if (IS_ERR(fakewriter_tasks[i])) {
+			firsterr = PTR_ERR(fakewriter_tasks[i]);
+			VERBOSE_PRINTK_ERRSTRING("Failed to create fakewriter");
+			fakewriter_tasks[i] = NULL;
+			goto unwind;
+		}
+	}
 	reader_tasks = kzalloc(nrealreaders * sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {


