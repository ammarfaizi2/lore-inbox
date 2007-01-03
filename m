Return-Path: <linux-kernel-owner+w=401wt.eu-S1754999AbXACHqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbXACHqI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbXACHpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:45:47 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25834 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976AbXACHpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:45:42 -0500
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] 1/4 qrcu: "quick" srcu implementation
Date: Wed,  3 Jan 2007 08:48:25 +0100
Message-Id: <11678105082295-git-send-email-jens.axboe@oracle.com>
X-Mailer: git-send-email 1.4.4.2.g02c9
In-Reply-To: <11678105083001-git-send-email-jens.axboe@oracle.com>
References: <11678105083001-git-send-email-jens.axboe@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@tv-sign.ru>

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
Acked-by: Jens Axboe <jens.axboe@oracle.com>
---
 include/linux/srcu.h |   30 ++++++++++++++
 kernel/srcu.c        |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index aca0eee..fcdb749 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -27,6 +27,8 @@
 #ifndef _LINUX_SRCU_H
 #define _LINUX_SRCU_H
 
+#include <linux/wait.h>
+
 struct srcu_struct_array {
 	int c[2];
 };
@@ -50,4 +52,32 @@ void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
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
+/**
+ * cleanup_qrcu_struct - deconstruct a quick-RCU structure
+ * @qp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given qrcu_struct that
+ * was initialized via init_qrcu_struct().  We reserve the right to
+ * leak memory should you fail to do this!
+ */
+static inline void cleanup_qrcu_struct(struct qrcu_struct *qp)
+{
+}
+
 #endif
diff --git a/kernel/srcu.c b/kernel/srcu.c
index 3507cab..53c6989 100644
--- a/kernel/srcu.c
+++ b/kernel/srcu.c
@@ -256,3 +256,108 @@ EXPORT_SYMBOL_GPL(srcu_read_unlock);
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 EXPORT_SYMBOL_GPL(srcu_batches_completed);
 EXPORT_SYMBOL_GPL(srcu_readers_active);
+
+/**
+ * init_qrcu_struct - initialize a quick-RCU structure.
+ * @qp: structure to initialize.
+ *
+ * Must invoke this on a given qrcu_struct before passing that qrcu_struct
+ * to any other function.  Each qrcu_struct represents a separate domain
+ * of QRCU protection.
+ */
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
+/**
+ * qrcu_read_lock - register a new reader for an QRCU-protected structure.
+ * @qp: qrcu_struct in which to register the new reader.
+ *
+ * Counts the new reader in the appropriate element of the qrcu_struct.
+ * Returns an index that must be passed to the matching qrcu_read_unlock().
+ */
+int qrcu_read_lock(struct qrcu_struct *qp)
+{
+	for (;;) {
+		int idx = qp->completed & 0x1;
+		if (likely(atomic_inc_not_zero(qp->ctr + idx)))
+			return idx;
+	}
+}
+
+/**
+ * qrcu_read_unlock - unregister a old reader from an QRCU-protected structure.
+ * @qp: qrcu_struct in which to unregister the old reader.
+ * @idx: return value from corresponding qrcu_read_lock().
+ *
+ * Removes the count for the old reader from the appropriate element of
+ * the qrcu_struct.
+ */
+void qrcu_read_unlock(struct qrcu_struct *qp, int idx)
+{
+	if (atomic_dec_and_test(qp->ctr + idx))
+		wake_up(&qp->wq);
+}
+
+/**
+ * synchronize_qrcu - wait for prior QRCU read-side critical-section completion
+ * @qp: qrcu_struct with which to synchronize.
+ *
+ * Flip the completed counter, and wait for the old count to drain to zero.
+ * As with classic RCU, the updater must use some separate means of
+ * synchronizing concurrent updates.  Can block; must be called from
+ * process context.
+ *
+ * Note that it is illegal to call synchronize_qrcu() from the corresponding
+ * QRCU read-side critical section; doing so will result in deadlock.
+ * However, it is perfectly legal to call synchronize_qrcu() on one
+ * qrcu_struct from some other qrcu_struct's read-side critical section.
+ */
+void synchronize_qrcu(struct qrcu_struct *qp)
+{
+	int idx;
+
+	/*
+	 * The following memory barrier is needed to ensure that
+	 * any prior data-structure manipulation is seen by other
+	 * CPUs to happen before picking up the value of
+	 * qp->completed.
+	 */
+	smp_mb();
+	mutex_lock(&qp->mutex);
+
+	idx = qp->completed & 0x1;
+	if (atomic_read(qp->ctr + idx) == 1)
+		goto out;
+
+	atomic_inc(qp->ctr + (idx ^ 0x1));
+	/* Reduce the likelihood that qrcu_read_lock() will loop */
+	smp_mb__after_atomic_inc();
+	qp->completed++;
+
+	atomic_dec(qp->ctr + idx);
+	__wait_event(qp->wq, !atomic_read(qp->ctr + idx));
+out:
+	mutex_unlock(&qp->mutex);
+	smp_mb();
+	/*
+	 * The above smp_mb() is needed in the case that we
+	 * see the counter reaching zero, so that we do not
+	 * need to block.  In this case, we need to make
+	 * sure that the CPU does not re-order any subsequent
+	 * changes made by the caller to occur prior to the
+	 * test, as seen by other CPUs.
+	 */
+}
+
+EXPORT_SYMBOL_GPL(init_qrcu_struct);
+EXPORT_SYMBOL_GPL(qrcu_read_lock);
+EXPORT_SYMBOL_GPL(qrcu_read_unlock);
+EXPORT_SYMBOL_GPL(synchronize_qrcu);
-- 
1.4.4.2.g02c9

