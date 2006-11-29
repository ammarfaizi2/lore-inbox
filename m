Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWK2XxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWK2XxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbWK2XxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:53:22 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:16316 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1752255AbWK2XxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:53:21 -0500
Date: Thu, 30 Nov 2006 02:53:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Josh Triplett <josh@freedesktop.org>, linux-kernel@vger.kernel.org
Subject: [RFC, PATCH 1/2] qrcu: "quick" srcu implementation
Message-ID: <20061129235303.GA1118@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very much based on ideas, corrections, and patient explanations from
Alan and Paul.

The current srcu implementation is very good for readers, lock/unlock
are extremely cheap. But for that reason it is not possible to avoid
synchronize_sched() and polling in synchronize_srcu().

Jens Axboe wrote:
>
> It works for me, but the overhead is still large. Before it would take
> 8-12 jiffies for a synchronize_srcu() to complete without there actually
> being any reader locks active, now it takes 2-3 jiffies. So it's
> definitely faster, and as suspected the loss of two of three
> synchronize_sched() cut down the overhead to a third.

'qrcu' behaves the same as srcu but optimized for writers. The fast path
for synchronize_qrcu() is mutex_lock() + atomic_read() + mutex_unlock().
The slow path is __wait_event(), no polling. However, the reader does
atomic inc/dec on lock/unlock, and the counters are not per-cpu.

Also, unlike srcu, qrcu read lock/unlock can be used in interrupt context,
and 'qrcu_struct' can be compile-time initialized.

See also (a long) discussion:
	http://marc.theaimsgroup.com/?t=116370857600003

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 19-rc6/include/linux/srcu.h~1_qrcu	2006-11-17 19:42:31.000000000 +0300
+++ 19-rc6/include/linux/srcu.h	2006-11-29 20:22:37.000000000 +0300
@@ -27,6 +27,8 @@
 #ifndef _LINUX_SRCU_H
 #define _LINUX_SRCU_H
 
+#include <linux/wait.h>
+
 struct srcu_struct_array {
 	int c[2];
 };
@@ -50,4 +52,24 @@ void srcu_read_unlock(struct srcu_struct
 void synchronize_srcu(struct srcu_struct *sp);
 long srcu_batches_completed(struct srcu_struct *sp);
 
+/*
+ * fully compatible with srcu, but optimized for writers.
+ */
+
+struct qrcu_struct {
+	int completed;
+	atomic_t ctr[2];
+	wait_queue_head_t wq;
+	struct mutex mutex;
+};
+
+int init_qrcu_struct(struct qrcu_struct *qp);
+int qrcu_read_lock(struct qrcu_struct *qp);
+void qrcu_read_unlock(struct qrcu_struct *qp, int idx);
+void synchronize_qrcu(struct qrcu_struct *qp);
+
+static inline void cleanup_qrcu_struct(struct qrcu_struct *qp)
+{
+}
+
 #endif
--- 19-rc6/kernel/srcu.c~1_qrcu	2006-11-17 19:42:31.000000000 +0300
+++ 19-rc6/kernel/srcu.c	2006-11-29 20:09:49.000000000 +0300
@@ -256,3 +256,55 @@ EXPORT_SYMBOL_GPL(srcu_read_unlock);
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 EXPORT_SYMBOL_GPL(srcu_batches_completed);
 EXPORT_SYMBOL_GPL(srcu_readers_active);
+
+int init_qrcu_struct(struct qrcu_struct *qp)
+{
+	qp->completed = 0;
+	atomic_set(qp->ctr + 0, 1);
+	atomic_set(qp->ctr + 1, 0);
+	init_waitqueue_head(&qp->wq);
+	mutex_init(&qp->mutex);
+
+	return 0;
+}
+
+int qrcu_read_lock(struct qrcu_struct *qp)
+{
+	for (;;) {
+		int idx = qp->completed & 0x1;
+		if (likely(atomic_inc_not_zero(qp->ctr + idx)))
+			return idx;
+	}
+}
+
+void qrcu_read_unlock(struct qrcu_struct *qp, int idx)
+{
+	if (atomic_dec_and_test(qp->ctr + idx))
+		wake_up(&qp->wq);
+}
+
+void synchronize_qrcu(struct qrcu_struct *qp)
+{
+	int idx;
+
+	smp_mb();
+	mutex_lock(&qp->mutex);
+
+	idx = qp->completed & 0x1;
+	if (atomic_read(qp->ctr + idx) == 1)
+		goto out;
+
+	atomic_inc(qp->ctr + (idx ^ 0x1));
+	qp->completed++;
+
+	atomic_dec(qp->ctr + idx);
+	__wait_event(qp->wq, !atomic_read(qp->ctr + idx));
+out:
+	mutex_unlock(&qp->mutex);
+	smp_mb();
+}
+
+EXPORT_SYMBOL_GPL(init_qrcu_struct);
+EXPORT_SYMBOL_GPL(qrcu_read_lock);
+EXPORT_SYMBOL_GPL(qrcu_read_unlock);
+EXPORT_SYMBOL_GPL(synchronize_qrcu);

