Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162479AbWLBVK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162479AbWLBVK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162481AbWLBVK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:10:26 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:30601 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1162479AbWLBVKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:10:24 -0500
Date: Sun, 3 Dec 2006 00:09:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Josh Triplett <josh@freedesktop.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 2/2] qrcu: add rcutorture test
Message-ID: <20061202210938.GA99@oleg>
References: <20061129235409.GA1121@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129235409.GA1121@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(with sparse annotations from Josh)

[PATCH 2/2] qrcu: add rcutorture test

Add rcutorture test for qrcu.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Josh Triplett <josh@freedesktop.org>

--- 19-rc6/include/linux/srcu.h~2_test	2006-11-30 04:32:42.000000000 +0300
+++ 19-rc6/include/linux/srcu.h	2006-12-03 00:03:18.000000000 +0300
@@ -64,8 +64,8 @@ struct qrcu_struct {
 };
 
 int init_qrcu_struct(struct qrcu_struct *qp);
-int qrcu_read_lock(struct qrcu_struct *qp);
-void qrcu_read_unlock(struct qrcu_struct *qp, int idx);
+int qrcu_read_lock(struct qrcu_struct *qp) __acquires(qp);
+void qrcu_read_unlock(struct qrcu_struct *qp, int idx) __releases(qp);
 void synchronize_qrcu(struct qrcu_struct *qp);
 
 /**
--- 19-rc6/kernel/rcutorture.c~2_test	2006-10-22 18:24:03.000000000 +0400
+++ 19-rc6/kernel/rcutorture.c	2006-12-03 00:03:18.000000000 +0300
@@ -465,6 +465,73 @@ static struct rcu_torture_ops srcu_ops =
 };
 
 /*
+ * Definitions for qrcu torture testing.
+ */
+
+static struct qrcu_struct qrcu_ctl;
+
+static void qrcu_torture_init(void)
+{
+	init_qrcu_struct(&qrcu_ctl);
+	rcu_sync_torture_init();
+}
+
+static void qrcu_torture_cleanup(void)
+{
+	synchronize_qrcu(&qrcu_ctl);
+	cleanup_qrcu_struct(&qrcu_ctl);
+}
+
+static int qrcu_torture_read_lock(void) __acquires(&qrcu_ctl)
+{
+	return qrcu_read_lock(&qrcu_ctl);
+}
+
+static void qrcu_torture_read_unlock(int idx) __releases(&qrcu_ctl)
+{
+	qrcu_read_unlock(&qrcu_ctl, idx);
+}
+
+static int qrcu_torture_completed(void)
+{
+	return qrcu_ctl.completed;
+}
+
+static void qrcu_torture_synchronize(void)
+{
+	synchronize_qrcu(&qrcu_ctl);
+}
+
+static int qrcu_torture_stats(char *page)
+{
+	int cnt = 0;
+	int idx = qrcu_ctl.completed & 0x1;
+
+	cnt += sprintf(&page[cnt], "%s%s per-CPU(idx=%d):",
+			torture_type, TORTURE_FLAG, idx);
+
+	cnt += sprintf(&page[cnt], " (%d,%d)",
+			atomic_read(qrcu_ctl.ctr + 0),
+			atomic_read(qrcu_ctl.ctr + 1));
+
+	cnt += sprintf(&page[cnt], "\n");
+	return cnt;
+}
+
+static struct rcu_torture_ops qrcu_ops = {
+	.init = qrcu_torture_init,
+	.cleanup = qrcu_torture_cleanup,
+	.readlock = qrcu_torture_read_lock,
+	.readdelay = srcu_read_delay,
+	.readunlock = qrcu_torture_read_unlock,
+	.completed = qrcu_torture_completed,
+	.deferredfree = rcu_sync_torture_deferred_free,
+	.sync = qrcu_torture_synchronize,
+	.stats = qrcu_torture_stats,
+	.name = "qrcu"
+};
+
+/*
  * Definitions for sched torture testing.
  */
 
@@ -503,8 +570,8 @@ static struct rcu_torture_ops sched_ops 
 };
 
 static struct rcu_torture_ops *torture_ops[] =
-	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops, &srcu_ops,
-	  &sched_ops, NULL };
+	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops,
+	  &srcu_ops, &qrcu_ops, &sched_ops, NULL };
 
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure

