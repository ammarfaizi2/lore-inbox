Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWFZSzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWFZSzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWFZSzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:55:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:32151 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932653AbWFZSzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:55:07 -0400
Date: Mon, 26 Jun 2006 11:55:37 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       arjan@infradead.org, ioe-lkml@rameria.de, greg@kroah.com,
       pbadari@us.ibm.com, mrmacman_g4@mac.com, hugh@veritas.com,
       vatsa@in.ibm.com
Subject: [PATCH 2/3] rcutorture: add ops vector and Classic RCU ops
Message-ID: <20060626185537.GB2141@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060626184821.GA2091@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626184821.GA2091@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ops vector to rcutorture, and add the ops for Classic RCU.
Update the rcutorture documentation to reflect slight change to the
dmesg formats.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 Documentation/RCU/torture.txt |   22 +++--
 kernel/rcutorture.c           |  163 ++++++++++++++++++++++++++++++------------
 2 files changed, 133 insertions(+), 52 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-torturedoc/Documentation/RCU/torture.txt linux-2.6.17-tortureops/Documentation/RCU/torture.txt
--- linux-2.6.17-torturedoc/Documentation/RCU/torture.txt	2006-06-24 11:34:36.000000000 -0700
+++ linux-2.6.17-tortureops/Documentation/RCU/torture.txt	2006-06-23 18:20:15.000000000 -0700
@@ -7,7 +7,7 @@ The CONFIG_RCU_TORTURE_TEST config optio
 implementations.  It creates an rcutorture kernel module that can
 be loaded to run a torture test.  The test periodically outputs
 status messages via printk(), which can be examined via the dmesg
-command (perhaps grepping for "rcutorture").  The test is started
+command (perhaps grepping for "torture").  The test is started
 when the module is loaded, and stops when the module is unloaded.
 
 However, actually setting this config option to "y" results in the system
@@ -44,6 +44,10 @@ test_no_idle_hz	Whether or not to test t
 		a kernel that disables the scheduling-clock interrupt to
 		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
 
+torture_type	The type of RCU to test: "rcu" for the rcu_read_lock()
+		API, "rcu_bh" for the rcu_read_lock_bh() API, and "srcu"
+		for the "srcu_read_lock()" API.
+
 verbose		Enable debug printk()s.  Default is disabled.
 
 
@@ -51,14 +55,14 @@ OUTPUT
 
 The statistics output is as follows:
 
-	rcutorture: --- Start of test: nreaders=16 stat_interval=0 verbose=0
-	rcutorture: rtc: 0000000000000000 ver: 1916 tfle: 0 rta: 1916 rtaf: 0 rtf: 1915
-	rcutorture: Reader Pipe:  1466408 9747 0 0 0 0 0 0 0 0 0
-	rcutorture: Reader Batch:  1464477 11678 0 0 0 0 0 0 0 0
-	rcutorture: Free-Block Circulation:  1915 1915 1915 1915 1915 1915 1915 1915 1915 1915 0
-	rcutorture: --- End of test
+	rcu-torture: --- Start of test: nreaders=16 stat_interval=0 verbose=0
+	rcu-torture: rtc: 0000000000000000 ver: 1916 tfle: 0 rta: 1916 rtaf: 0 rtf: 1915
+	rcu-torture: Reader Pipe:  1466408 9747 0 0 0 0 0 0 0 0 0
+	rcu-torture: Reader Batch:  1464477 11678 0 0 0 0 0 0 0 0
+	rcu-torture: Free-Block Circulation:  1915 1915 1915 1915 1915 1915 1915 1915 1915 1915 0
+	rcu-torture: --- End of test
 
-The command "dmesg | grep rcutorture:" will extract this information on
+The command "dmesg | grep torture:" will extract this information on
 most systems.  On more esoteric configurations, it may be necessary to
 use other commands to access the output of the printk()s used by
 the RCU torture test.  The printk()s use KERN_ALERT, so they should
@@ -124,7 +128,7 @@ The following script may be used to tort
 	modprobe rcutorture
 	sleep 100
 	rmmod rcutorture
-	dmesg | grep rcutorture:
+	dmesg | grep torture:
 
 The output can be manually inspected for the error flag of "!!!".
 One could of course create a more elaborate script that automatically
diff -urpNa -X dontdiff linux-2.6.17-torturedoc/kernel/rcutorture.c linux-2.6.17-tortureops/kernel/rcutorture.c
--- linux-2.6.17-torturedoc/kernel/rcutorture.c	2006-06-23 16:28:08.000000000 -0700
+++ linux-2.6.17-tortureops/kernel/rcutorture.c	2006-06-24 11:51:47.000000000 -0700
@@ -53,6 +53,7 @@ static int stat_interval;	/* Interval be
 static int verbose;		/* Print more debug info. */
 static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
 static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
+static char *torture_type = "rcu"; /* What to torture. */
 
 module_param(nreaders, int, 0);
 MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
@@ -64,13 +65,16 @@ module_param(test_no_idle_hz, bool, 0);
 MODULE_PARM_DESC(test_no_idle_hz, "Test support for tickless idle CPUs");
 module_param(shuffle_interval, int, 0);
 MODULE_PARM_DESC(shuffle_interval, "Number of seconds between shuffles");
-#define TORTURE_FLAG "rcutorture: "
+module_param(torture_type, charp, 0);
+MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu)");
+
+#define TORTURE_FLAG "-torture:"
 #define PRINTK_STRING(s) \
-	do { printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
+	do { printk(KERN_ALERT "%s" TORTURE_FLAG s "\n", torture_type); } while (0)
 #define VERBOSE_PRINTK_STRING(s) \
-	do { if (verbose) printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
+	do { if (verbose) printk(KERN_ALERT "%s" TORTURE_FLAG s "\n", torture_type); } while (0)
 #define VERBOSE_PRINTK_ERRSTRING(s) \
-	do { if (verbose) printk(KERN_ALERT TORTURE_FLAG "!!! " s "\n"); } while (0)
+	do { if (verbose) printk(KERN_ALERT "%s" TORTURE_FLAG "!!! " s "\n", torture_type); } while (0)
 
 static char printk_buf[4096];
 
@@ -139,28 +143,6 @@ rcu_torture_free(struct rcu_torture *p)
 	spin_unlock_bh(&rcu_torture_lock);
 }
 
-static void
-rcu_torture_cb(struct rcu_head *p)
-{
-	int i;
-	struct rcu_torture *rp = container_of(p, struct rcu_torture, rtort_rcu);
-
-	if (fullstop) {
-		/* Test is ending, just drop callbacks on the floor. */
-		/* The next initialization will pick up the pieces. */
-		return;
-	}
-	i = rp->rtort_pipe_count;
-	if (i > RCU_TORTURE_PIPE_LEN)
-		i = RCU_TORTURE_PIPE_LEN;
-	atomic_inc(&rcu_torture_wcount[i]);
-	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
-		rp->rtort_mbtest = 0;
-		rcu_torture_free(rp);
-	} else
-		call_rcu(p, rcu_torture_cb);
-}
-
 struct rcu_random_state {
 	unsigned long rrs_state;
 	unsigned long rrs_count;
@@ -191,6 +173,83 @@ rcu_random(struct rcu_random_state *rrsp
 }
 
 /*
+ * Operations vector for selecting different types of tests.
+ */
+
+struct rcu_torture_ops {
+	void (*init)(void);
+	void (*cleanup)(void);
+	int (*readlock)(void);
+	void (*readunlock)(int idx);
+	int (*completed)(void);
+	void (*deferredfree)(struct rcu_torture *p);
+	int (*stats)(char *page);
+	char *name;
+};
+static struct rcu_torture_ops *cur_ops = NULL;
+
+/*
+ * Definitions for rcu torture testing.
+ */
+
+static int rcu_torture_read_lock(void)
+{
+	rcu_read_lock();
+	return 0;
+}
+
+static void rcu_torture_read_unlock(int idx)
+{
+	rcu_read_unlock();
+}
+
+static int rcu_torture_completed(void)
+{
+	return rcu_batches_completed();
+}
+
+static void
+rcu_torture_cb(struct rcu_head *p)
+{
+	int i;
+	struct rcu_torture *rp = container_of(p, struct rcu_torture, rtort_rcu);
+
+	if (fullstop) {
+		/* Test is ending, just drop callbacks on the floor. */
+		/* The next initialization will pick up the pieces. */
+		return;
+	}
+	i = rp->rtort_pipe_count;
+	if (i > RCU_TORTURE_PIPE_LEN)
+		i = RCU_TORTURE_PIPE_LEN;
+	atomic_inc(&rcu_torture_wcount[i]);
+	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+		rp->rtort_mbtest = 0;
+		rcu_torture_free(rp);
+	} else
+		cur_ops->deferredfree(rp);
+}
+
+static void rcu_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops rcu_ops = {
+	.init = NULL,
+	.cleanup = NULL,
+	.readlock = rcu_torture_read_lock,
+	.readunlock = rcu_torture_read_unlock,
+	.completed = rcu_torture_completed,
+	.deferredfree = rcu_torture_deferred_free,
+	.stats = NULL,
+	.name = "rcu"
+};
+
+static struct rcu_torture_ops *torture_ops[] =
+	{ &rcu_ops, NULL };
+
+/*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure
  * for that pointed to by rcu_torture_current, freeing the old structure
  * after a series of grace periods (the "pipeline").
@@ -209,8 +268,6 @@ rcu_torture_writer(void *arg)
 
 	do {
 		schedule_timeout_uninterruptible(1);
-		if (rcu_batches_completed() == oldbatch)
-			continue;
 		if ((rp = rcu_torture_alloc()) == NULL)
 			continue;
 		rp->rtort_pipe_count = 0;
@@ -225,10 +282,10 @@ rcu_torture_writer(void *arg)
 				i = RCU_TORTURE_PIPE_LEN;
 			atomic_inc(&rcu_torture_wcount[i]);
 			old_rp->rtort_pipe_count++;
-			call_rcu(&old_rp->rtort_rcu, rcu_torture_cb);
+			cur_ops->deferredfree(old_rp);
 		}
 		rcu_torture_current_version++;
-		oldbatch = rcu_batches_completed();
+		oldbatch = cur_ops->completed();
 	} while (!kthread_should_stop() && !fullstop);
 	VERBOSE_PRINTK_STRING("rcu_torture_writer task stopping");
 	while (!kthread_should_stop())
@@ -246,6 +303,7 @@ static int
 rcu_torture_reader(void *arg)
 {
 	int completed;
+	int idx;
 	DEFINE_RCU_RANDOM(rand);
 	struct rcu_torture *p;
 	int pipe_count;
@@ -254,12 +312,12 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, 19);
 
 	do {
-		rcu_read_lock();
-		completed = rcu_batches_completed();
+		idx = cur_ops->readlock();
+		completed = cur_ops->completed();
 		p = rcu_dereference(rcu_torture_current);
 		if (p == NULL) {
 			/* Wait for rcu_torture_writer to get underway */
-			rcu_read_unlock();
+			cur_ops->readunlock(idx);
 			schedule_timeout_interruptible(HZ);
 			continue;
 		}
@@ -273,14 +331,14 @@ rcu_torture_reader(void *arg)
 			pipe_count = RCU_TORTURE_PIPE_LEN;
 		}
 		++__get_cpu_var(rcu_torture_count)[pipe_count];
-		completed = rcu_batches_completed() - completed;
+		completed = cur_ops->completed() - completed;
 		if (completed > RCU_TORTURE_PIPE_LEN) {
 			/* Should not happen, but... */
 			completed = RCU_TORTURE_PIPE_LEN;
 		}
 		++__get_cpu_var(rcu_torture_batch)[completed];
 		preempt_enable();
-		rcu_read_unlock();
+		cur_ops->readunlock(idx);
 		schedule();
 	} while (!kthread_should_stop() && !fullstop);
 	VERBOSE_PRINTK_STRING("rcu_torture_reader task stopping");
@@ -311,7 +369,7 @@ rcu_torture_printk(char *page)
 		if (pipesummary[i] != 0)
 			break;
 	}
-	cnt += sprintf(&page[cnt], "rcutorture: ");
+	cnt += sprintf(&page[cnt], "%s%s ", torture_type, TORTURE_FLAG);
 	cnt += sprintf(&page[cnt],
 		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d "
 		       "rtmbe: %d",
@@ -324,7 +382,7 @@ rcu_torture_printk(char *page)
 		       atomic_read(&n_rcu_torture_mberror));
 	if (atomic_read(&n_rcu_torture_mberror) != 0)
 		cnt += sprintf(&page[cnt], " !!!");
-	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "\n%s%s ", torture_type, TORTURE_FLAG);
 	if (i > 1) {
 		cnt += sprintf(&page[cnt], "!!! ");
 		atomic_inc(&n_rcu_torture_error);
@@ -332,17 +390,19 @@ rcu_torture_printk(char *page)
 	cnt += sprintf(&page[cnt], "Reader Pipe: ");
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
-	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "\n%s%s ", torture_type, TORTURE_FLAG);
 	cnt += sprintf(&page[cnt], "Reader Batch: ");
-	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++)
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		cnt += sprintf(&page[cnt], " %ld", batchsummary[i]);
-	cnt += sprintf(&page[cnt], "\nrcutorture: ");
+	cnt += sprintf(&page[cnt], "\n%s%s ", torture_type, TORTURE_FLAG);
 	cnt += sprintf(&page[cnt], "Free-Block Circulation: ");
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
 		cnt += sprintf(&page[cnt], " %d",
 			       atomic_read(&rcu_torture_wcount[i]));
 	}
 	cnt += sprintf(&page[cnt], "\n");
+	if (cur_ops->stats != NULL)
+		cnt += cur_ops->stats(&page[cnt]);
 	return cnt;
 }
 
@@ -444,11 +504,11 @@ rcu_torture_shuffle(void *arg)
 static inline void
 rcu_torture_print_module_parms(char *tag)
 {
-	printk(KERN_ALERT TORTURE_FLAG "--- %s: nreaders=%d "
+	printk(KERN_ALERT "%s" TORTURE_FLAG "--- %s: nreaders=%d "
 		"stat_interval=%d verbose=%d test_no_idle_hz=%d "
 		"shuffle_interval = %d\n",
-		tag, nrealreaders, stat_interval, verbose, test_no_idle_hz,
-		shuffle_interval);
+		torture_type, tag, nrealreaders, stat_interval, verbose,
+		test_no_idle_hz, shuffle_interval);
 }
 
 static void
@@ -493,6 +553,9 @@ rcu_torture_cleanup(void)
 	rcu_barrier();
 
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
+
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
 	if (atomic_read(&n_rcu_torture_error))
 		rcu_torture_print_module_parms("End of test: FAILURE");
 	else
@@ -508,6 +571,20 @@ rcu_torture_init(void)
 
 	/* Process args and tell the world that the torturer is on the job. */
 
+	for (i = 0; cur_ops = torture_ops[i], cur_ops != NULL; i++) {
+		cur_ops = torture_ops[i];
+		if (strcmp(torture_type, cur_ops->name) == 0) {
+			break;
+		}
+	}
+	if (cur_ops == NULL) {
+		printk(KERN_ALERT "rcutorture: invalid torture type: \"%s\"\n",
+		       torture_type);
+		return (-EINVAL);
+	}
+	if (cur_ops->init != NULL)
+		cur_ops->init(); /* no "goto unwind" prior to this point!!! */
+
 	if (nreaders >= 0)
 		nrealreaders = nreaders;
 	else
