Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVKOTxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVKOTxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVKOTxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:53:35 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51868 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965002AbVKOTxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:53:34 -0500
Date: Tue, 15 Nov 2005 11:54:14 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@us.ibm.com, vatsa@in.ibm.com, dipankar@in.ibm.com
Subject: [PATCH] add success/failure indication to RCU torture test
Message-ID: <20051115195414.GA2454@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

One issue with the RCU torture test is that the current error flagging
can be lost in dmesg.  This patch adds a "SUCCESS"/"FAILURE" string
to the line that flags the end of the test, where it can easily be
seen with "dmesg | tail" at the end of the test.  Also adds tests of
architecture-specific memory barriers -- or, more likely, of the RCU
torture test itself.

CC: <vatsa@in.ibm.com>
Signed-off-by: <paulmck@us.ibm.com>

---

 rcutorture.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-mm1/kernel/rcutorture.c linux-2.6.14-mm1-rcutortureerr/kernel/rcutorture.c
--- linux-2.6.14-mm1/kernel/rcutorture.c	2005-11-08 08:18:55.000000000 -0800
+++ linux-2.6.14-mm1-rcutortureerr/kernel/rcutorture.c	2005-11-15 11:46:57.000000000 -0800
@@ -80,6 +80,7 @@ struct rcu_torture {
 	struct rcu_head rtort_rcu;
 	int rtort_pipe_count;
 	struct list_head rtort_free;
+	int rtort_mbtest;
 };
 
 static int fullstop = 0;	/* stop generating callbacks at test end. */
@@ -96,6 +97,8 @@ static atomic_t rcu_torture_wcount[RCU_T
 atomic_t n_rcu_torture_alloc;
 atomic_t n_rcu_torture_alloc_fail;
 atomic_t n_rcu_torture_free;
+atomic_t n_rcu_torture_mberror;
+atomic_t n_rcu_torture_error;
 
 /*
  * Allocate an element from the rcu_tortures pool.
@@ -145,9 +148,10 @@ rcu_torture_cb(struct rcu_head *p)
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
-	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN)
+	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+		rp->rtort_mbtest = 0;
 		rcu_torture_free(rp);
-	else
+	} else
 		call_rcu(p, rcu_torture_cb);
 }
 
@@ -204,6 +208,7 @@ rcu_torture_writer(void *arg)
 		rp->rtort_pipe_count = 0;
 		udelay(rcu_random(&rand) & 0x3ff);
 		old_rp = rcu_torture_current;
+		rp->rtort_mbtest = 1;
 		rcu_assign_pointer(rcu_torture_current, rp);
 		smp_wmb();
 		if (old_rp != NULL) {
@@ -248,6 +253,8 @@ rcu_torture_reader(void *arg)
 			schedule_timeout_interruptible(HZ);
 			continue;
 		}
+		if (p->rtort_mbtest == 0)
+			atomic_inc(&n_rcu_torture_mberror);
 		udelay(rcu_random(&rand) & 0x7f);
 		preempt_disable();
 		pipe_count = p->rtort_pipe_count;
@@ -296,16 +303,22 @@ rcu_torture_printk(char *page)
 	}
 	cnt += sprintf(&page[cnt], "rcutorture: ");
 	cnt += sprintf(&page[cnt],
-		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d",
+		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d "
+		       "rtmbe: %d",
 		       rcu_torture_current,
 		       rcu_torture_current_version,
 		       list_empty(&rcu_torture_freelist),
 		       atomic_read(&n_rcu_torture_alloc),
 		       atomic_read(&n_rcu_torture_alloc_fail),
-		       atomic_read(&n_rcu_torture_free));
+		       atomic_read(&n_rcu_torture_free),
+		       atomic_read(&n_rcu_torture_mberror));
+	if (atomic_read(&n_rcu_torture_mberror) != 0)
+		cnt += sprintf(&page[cnt], " !!!");
 	cnt += sprintf(&page[cnt], "\nrcutorture: ");
-	if (i > 1)
+	if (i > 1) {
 		cnt += sprintf(&page[cnt], "!!! ");
+		atomic_inc(&n_rcu_torture_error);
+	}
 	cnt += sprintf(&page[cnt], "Reader Pipe: ");
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
@@ -396,7 +409,9 @@ rcu_torture_cleanup(void)
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++)
 		synchronize_rcu();
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
-	PRINTK_STRING("--- End of test");
+	printk(KERN_ALERT TORTURE_FLAG
+	       "--- End of test: %s\n",
+	       atomic_read(&n_rcu_torture_error) == 0 ? "SUCCESS" : "FAILURE");
 }
 
 static int
@@ -421,6 +436,7 @@ rcu_torture_init(void)
 
 	INIT_LIST_HEAD(&rcu_torture_freelist);
 	for (i = 0; i < sizeof(rcu_tortures) / sizeof(rcu_tortures[0]); i++) {
+		rcu_tortures[i].rtort_mbtest = 0;
 		list_add_tail(&rcu_tortures[i].rtort_free,
 			      &rcu_torture_freelist);
 	}
@@ -432,6 +448,8 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_alloc, 0);
 	atomic_set(&n_rcu_torture_alloc_fail, 0);
 	atomic_set(&n_rcu_torture_free, 0);
+	atomic_set(&n_rcu_torture_mberror, 0);
+	atomic_set(&n_rcu_torture_error, 0);
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
 		atomic_set(&rcu_torture_wcount[i], 0);
 	for_each_cpu(cpu) {
