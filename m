Return-Path: <linux-kernel-owner+w=401wt.eu-S1754951AbXACHpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbXACHpn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbXACHpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:45:43 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25826 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951AbXACHpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:45:42 -0500
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       Oleg Nesterov <oleg@tv-sign.ru>, Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] 2/4 qrcu: add rcutorture test
Date: Wed,  3 Jan 2007 08:48:26 +0100
Message-Id: <11678105082868-git-send-email-jens.axboe@oracle.com>
X-Mailer: git-send-email 1.4.4.2.g02c9
In-Reply-To: <11678105083001-git-send-email-jens.axboe@oracle.com>
References: <11678105083001-git-send-email-jens.axboe@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@tv-sign.ru>

Add rcutorture test for qrcu.

Works for me!

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Josh Triplett <josh@freedesktop.org>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Jens Axboe <jens.axboe@oracle.com>
---
 include/linux/srcu.h |    4 +-
 kernel/rcutorture.c  |   71 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index fcdb749..03a9010 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -64,8 +64,8 @@ struct qrcu_struct {
 };
 
 int init_qrcu_struct(struct qrcu_struct *qp);
-int qrcu_read_lock(struct qrcu_struct *qp);
-void qrcu_read_unlock(struct qrcu_struct *qp, int idx);
+int qrcu_read_lock(struct qrcu_struct *qp) __acquires(qp);
+void qrcu_read_unlock(struct qrcu_struct *qp, int idx) __releases(qp);
 void synchronize_qrcu(struct qrcu_struct *qp);
 
 /**
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index 482b11f..bd7fd49 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -465,6 +465,73 @@ static struct rcu_torture_ops srcu_ops = {
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
 
@@ -503,8 +570,8 @@ static struct rcu_torture_ops sched_ops = {
 };
 
 static struct rcu_torture_ops *torture_ops[] =
-	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops, &srcu_ops,
-	  &sched_ops, NULL };
+	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops,
+	  &srcu_ops, &qrcu_ops, &sched_ops, NULL };
 
 /*
  * RCU torture writer kthread.  Repeatedly substitutes a new structure
-- 
1.4.4.2.g02c9

