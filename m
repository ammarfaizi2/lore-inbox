Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWFZS5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWFZS5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWFZS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:57:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:26813 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932659AbWFZS5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:57:37 -0400
Date: Mon, 26 Jun 2006 11:58:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       arjan@infradead.org, ioe-lkml@rameria.de, greg@kroah.com,
       pbadari@us.ibm.com, mrmacman_g4@mac.com, hugh@veritas.com,
       vatsa@in.ibm.com
Subject: [PATCH 0/3] rcutorture: add call_rcu_bh() operations
Message-ID: <20060626185812.GC2141@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060626184821.GA2091@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626184821.GA2091@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add operations for the call_rcu_bh() variant of RCU.  Also add an
rcu_batches_completed_bh() function, which is needed by rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 include/linux/rcupdate.h |    1 +
 kernel/rcupdate.c        |   10 ++++++++++
 kernel/rcutorture.c      |   40 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-tortureops/include/linux/rcupdate.h linux-2.6.17-torturercu_bh/include/linux/rcupdate.h
--- linux-2.6.17-tortureops/include/linux/rcupdate.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-torturercu_bh/include/linux/rcupdate.h	2006-06-23 22:45:12.000000000 -0700
@@ -258,6 +258,7 @@ extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
 extern long rcu_batches_completed(void);
+extern long rcu_batches_completed_bh(void);
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
diff -urpNa -X dontdiff linux-2.6.17-tortureops/kernel/rcupdate.c linux-2.6.17-torturercu_bh/kernel/rcupdate.c
--- linux-2.6.17-tortureops/kernel/rcupdate.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17-torturercu_bh/kernel/rcupdate.c	2006-06-23 22:40:09.000000000 -0700
@@ -182,6 +182,15 @@ long rcu_batches_completed(void)
 	return rcu_ctrlblk.completed;
 }
 
+/*
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed_bh(void)
+{
+	return rcu_bh_ctrlblk.completed;
+}
+
 static void rcu_barrier_callback(struct rcu_head *notused)
 {
 	if (atomic_dec_and_test(&rcu_barrier_cpu_count))
@@ -627,6 +636,7 @@ module_param(qlowmark, int, 0);
 module_param(rsinterval, int, 0);
 #endif
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
+EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
 EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL_GPL(synchronize_rcu);
diff -urpNa -X dontdiff linux-2.6.17-tortureops/kernel/rcutorture.c linux-2.6.17-torturercu_bh/kernel/rcutorture.c
--- linux-2.6.17-tortureops/kernel/rcutorture.c	2006-06-24 11:51:47.000000000 -0700
+++ linux-2.6.17-torturercu_bh/kernel/rcutorture.c	2006-06-24 11:52:08.000000000 -0700
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(test_no_idle_hz, "Test 
 module_param(shuffle_interval, int, 0);
 MODULE_PARM_DESC(shuffle_interval, "Number of seconds between shuffles");
 module_param(torture_type, charp, 0);
-MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu)");
+MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, rcu_bh)");
 
 #define TORTURE_FLAG "-torture:"
 #define PRINTK_STRING(s) \
@@ -246,8 +246,44 @@ static struct rcu_torture_ops rcu_ops = 
 	.name = "rcu"
 };
 
+/*
+ * Definitions for rcu_bh torture testing.
+ */
+
+static int rcu_bh_torture_read_lock(void)
+{
+	rcu_read_lock_bh();
+	return 0;
+}
+
+static void rcu_bh_torture_read_unlock(int idx)
+{
+	rcu_read_unlock_bh();
+}
+
+static int rcu_bh_torture_completed(void)
+{
+	return rcu_batches_completed_bh();
+}
+
+static void rcu_bh_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu_bh(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops rcu_bh_ops = {
+	.init = NULL,
+	.cleanup = NULL,
+	.readlock = rcu_bh_torture_read_lock,
+	.readunlock = rcu_bh_torture_read_unlock,
+	.completed = rcu_bh_torture_completed,
+	.deferredfree = rcu_bh_torture_deferred_free,
+	.stats = NULL,
+	.name = "rcu_bh"
+};
+
 static struct rcu_torture_ops *torture_ops[] =
-	{ &rcu_ops, NULL };
+	{ &rcu_ops, &rcu_bh_ops, NULL };
 
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure
