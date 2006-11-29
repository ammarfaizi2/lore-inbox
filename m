Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967684AbWK2XyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967684AbWK2XyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967679AbWK2XyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:54:15 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:20412 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S967684AbWK2XyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:54:14 -0500
Date: Thu, 30 Nov 2006 02:54:09 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Josh Triplett <josh@freedesktop.org>, linux-kernel@vger.kernel.org
Subject: [RFC, PATCH 2/2] qrcu: add rcutorture test
Message-ID: <20061129235409.GA1121@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add rcutorture test for qrcu.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 19-rc6/kernel/__rcutorture.c	2006-11-17 19:42:31.000000000 +0300
+++ 19-rc6/kernel/rcutorture.c	2006-11-29 20:05:23.000000000 +0300
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
+static int qrcu_torture_read_lock(void)
+{
+	return qrcu_read_lock(&qrcu_ctl);
+}
+
+static void qrcu_torture_read_unlock(int idx)
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

