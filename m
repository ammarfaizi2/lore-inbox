Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWEJWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWEJWSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWEJWSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:18:48 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:1915 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965037AbWEJWSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:18:47 -0400
X-IronPort-AV: i="4.05,111,1146466800"; 
   d="scan'208"; a="1803998181:sNHT41664140"
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] please pull for-linus branch of infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 May 2006 15:18:35 -0700
Message-ID: <ada4pzx7cck.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2006 22:18:45.0939 (UTC) FILETIME=[B4309830:01C6747F]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The changes and patch are:

Michael S. Tsirkin:
      IB/mthca: ioremap fix

Ralph Campbell:
      IB: Fix display of 4-bit port counters in sysfs

Roland Dreier:
      IB/srp: Fix tracking of pending requests during error handling
      IB/mthca: Fix race in reference counting
      IPoIB: Free child interfaces properly

 drivers/infiniband/core/sysfs.c              |    2 
 drivers/infiniband/hw/mthca/mthca_cq.c       |   41 +++--
 drivers/infiniband/hw/mthca/mthca_dev.h      |    2 
 drivers/infiniband/hw/mthca/mthca_mr.c       |   15 +-
 drivers/infiniband/hw/mthca/mthca_provider.h |   22 ++-
 drivers/infiniband/hw/mthca/mthca_qp.c       |   31 +++-
 drivers/infiniband/hw/mthca/mthca_srq.c      |   23 ++-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |    4 -
 drivers/infiniband/ulp/srp/ib_srp.c          |  195 +++++++++++++++-----------
 drivers/infiniband/ulp/srp/ib_srp.h          |    4 -
 10 files changed, 202 insertions(+), 137 deletions(-)


diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 15121cb..21f9282 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -336,7 +336,7 @@ static ssize_t show_pma_counter(struct i
 	switch (width) {
 	case 4:
 		ret = sprintf(buf, "%u\n", (out_mad->data[40 + offset / 8] >>
-					    (offset % 4)) & 0xf);
+					    (4 - (offset % 8))) & 0xf);
 		break;
 	case 8:
 		ret = sprintf(buf, "%u\n", out_mad->data[40 + offset / 8]);
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 312cf90..205854e 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -238,9 +238,9 @@ void mthca_cq_event(struct mthca_dev *de
 	spin_lock(&dev->cq_table.lock);
 
 	cq = mthca_array_get(&dev->cq_table.cq, cqn & (dev->limits.num_cqs - 1));
-
 	if (cq)
-		atomic_inc(&cq->refcount);
+		++cq->refcount;
+
 	spin_unlock(&dev->cq_table.lock);
 
 	if (!cq) {
@@ -254,8 +254,10 @@ void mthca_cq_event(struct mthca_dev *de
 	if (cq->ibcq.event_handler)
 		cq->ibcq.event_handler(&event, cq->ibcq.cq_context);
 
-	if (atomic_dec_and_test(&cq->refcount))
+	spin_lock(&dev->cq_table.lock);
+	if (!--cq->refcount)
 		wake_up(&cq->wait);
+	spin_unlock(&dev->cq_table.lock);
 }
 
 static inline int is_recv_cqe(struct mthca_cqe *cqe)
@@ -267,23 +269,13 @@ static inline int is_recv_cqe(struct mth
 		return !(cqe->is_send & 0x80);
 }
 
-void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn,
+void mthca_cq_clean(struct mthca_dev *dev, struct mthca_cq *cq, u32 qpn,
 		    struct mthca_srq *srq)
 {
-	struct mthca_cq *cq;
 	struct mthca_cqe *cqe;
 	u32 prod_index;
 	int nfreed = 0;
 
-	spin_lock_irq(&dev->cq_table.lock);
-	cq = mthca_array_get(&dev->cq_table.cq, cqn & (dev->limits.num_cqs - 1));
-	if (cq)
-		atomic_inc(&cq->refcount);
-	spin_unlock_irq(&dev->cq_table.lock);
-
-	if (!cq)
-		return;
-
 	spin_lock_irq(&cq->lock);
 
 	/*
@@ -301,7 +293,7 @@ void mthca_cq_clean(struct mthca_dev *de
 
 	if (0)
 		mthca_dbg(dev, "Cleaning QPN %06x from CQN %06x; ci %d, pi %d\n",
-			  qpn, cqn, cq->cons_index, prod_index);
+			  qpn, cq->cqn, cq->cons_index, prod_index);
 
 	/*
 	 * Now sweep backwards through the CQ, removing CQ entries
@@ -325,8 +317,6 @@ void mthca_cq_clean(struct mthca_dev *de
 	}
 
 	spin_unlock_irq(&cq->lock);
-	if (atomic_dec_and_test(&cq->refcount))
-		wake_up(&cq->wait);
 }
 
 void mthca_cq_resize_copy_cqes(struct mthca_cq *cq)
@@ -821,7 +811,7 @@ int mthca_init_cq(struct mthca_dev *dev,
 	}
 
 	spin_lock_init(&cq->lock);
-	atomic_set(&cq->refcount, 1);
+	cq->refcount = 1;
 	init_waitqueue_head(&cq->wait);
 
 	memset(cq_context, 0, sizeof *cq_context);
@@ -896,6 +886,17 @@ err_out:
 	return err;
 }
 
+static inline int get_cq_refcount(struct mthca_dev *dev, struct mthca_cq *cq)
+{
+	int c;
+
+	spin_lock_irq(&dev->cq_table.lock);
+	c = cq->refcount;
+	spin_unlock_irq(&dev->cq_table.lock);
+
+	return c;
+}
+
 void mthca_free_cq(struct mthca_dev *dev,
 		   struct mthca_cq *cq)
 {
@@ -929,6 +930,7 @@ void mthca_free_cq(struct mthca_dev *dev
 	spin_lock_irq(&dev->cq_table.lock);
 	mthca_array_clear(&dev->cq_table.cq,
 			  cq->cqn & (dev->limits.num_cqs - 1));
+	--cq->refcount;
 	spin_unlock_irq(&dev->cq_table.lock);
 
 	if (dev->mthca_flags & MTHCA_FLAG_MSI_X)
@@ -936,8 +938,7 @@ void mthca_free_cq(struct mthca_dev *dev
 	else
 		synchronize_irq(dev->pdev->irq);
 
-	atomic_dec(&cq->refcount);
-	wait_event(cq->wait, !atomic_read(&cq->refcount));
+	wait_event(cq->wait, !get_cq_refcount(dev, cq));
 
 	if (cq->is_kernel) {
 		mthca_free_cq_buf(dev, &cq->buf, cq->ibcq.cqe);
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 4c1dcb4..f8160b8 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -496,7 +496,7 @@ void mthca_free_cq(struct mthca_dev *dev
 void mthca_cq_completion(struct mthca_dev *dev, u32 cqn);
 void mthca_cq_event(struct mthca_dev *dev, u32 cqn,
 		    enum ib_event_type event_type);
-void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn,
+void mthca_cq_clean(struct mthca_dev *dev, struct mthca_cq *cq, u32 qpn,
 		    struct mthca_srq *srq);
 void mthca_cq_resize_copy_cqes(struct mthca_cq *cq);
 int mthca_alloc_cq_buf(struct mthca_dev *dev, struct mthca_cq_buf *buf, int nent);
diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index 25e1c1d..a486dec 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -761,6 +761,7 @@ void mthca_arbel_fmr_unmap(struct mthca_
 
 int __devinit mthca_init_mr_table(struct mthca_dev *dev)
 {
+	unsigned long addr;
 	int err, i;
 
 	err = mthca_alloc_init(&dev->mr_table.mpt_alloc,
@@ -796,9 +797,12 @@ int __devinit mthca_init_mr_table(struct
 			goto err_fmr_mpt;
 		}
 
+		addr = pci_resource_start(dev->pdev, 4) +
+			((pci_resource_len(dev->pdev, 4) - 1) &
+			 dev->mr_table.mpt_base);
+
 		dev->mr_table.tavor_fmr.mpt_base =
-			ioremap(dev->mr_table.mpt_base,
-				(1 << i) * sizeof (struct mthca_mpt_entry));
+			ioremap(addr, (1 << i) * sizeof(struct mthca_mpt_entry));
 
 		if (!dev->mr_table.tavor_fmr.mpt_base) {
 			mthca_warn(dev, "MPT ioremap for FMR failed.\n");
@@ -806,9 +810,12 @@ int __devinit mthca_init_mr_table(struct
 			goto err_fmr_mpt;
 		}
 
+		addr = pci_resource_start(dev->pdev, 4) +
+			((pci_resource_len(dev->pdev, 4) - 1) &
+			 dev->mr_table.mtt_base);
+
 		dev->mr_table.tavor_fmr.mtt_base =
-			ioremap(dev->mr_table.mtt_base,
-				(1 << i) * MTHCA_MTT_SEG_SIZE);
+			ioremap(addr, (1 << i) * MTHCA_MTT_SEG_SIZE);
 		if (!dev->mr_table.tavor_fmr.mtt_base) {
 			mthca_warn(dev, "MTT ioremap for FMR failed.\n");
 			err = -ENOMEM;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 6676a78..179a8f6 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -139,11 +139,12 @@ struct mthca_ah {
  * a qp may be locked, with the send cq locked first.  No other
  * nesting should be done.
  *
- * Each struct mthca_cq/qp also has an atomic_t ref count.  The
- * pointer from the cq/qp_table to the struct counts as one reference.
- * This reference also is good for access through the consumer API, so
- * modifying the CQ/QP etc doesn't need to take another reference.
- * Access because of a completion being polled does need a reference.
+ * Each struct mthca_cq/qp also has an ref count, protected by the
+ * corresponding table lock.  The pointer from the cq/qp_table to the
+ * struct counts as one reference.  This reference also is good for
+ * access through the consumer API, so modifying the CQ/QP etc doesn't
+ * need to take another reference.  Access to a QP because of a
+ * completion being polled does not need a reference either.
  *
  * Finally, each struct mthca_cq/qp has a wait_queue_head_t for the
  * destroy function to sleep on.
@@ -159,8 +160,9 @@ struct mthca_ah {
  * - decrement ref count; if zero, wake up waiters
  *
  * To destroy a CQ/QP, we can do the following:
- * - lock cq/qp_table, remove pointer, unlock cq/qp_table lock
- * - decrement ref count
+ * - lock cq/qp_table
+ * - remove pointer and decrement ref count
+ * - unlock cq/qp_table lock
  * - wait_event until ref count is zero
  *
  * It is the consumer's responsibilty to make sure that no QP
@@ -197,7 +199,7 @@ struct mthca_cq_resize {
 struct mthca_cq {
 	struct ib_cq		ibcq;
 	spinlock_t		lock;
-	atomic_t		refcount;
+	int			refcount;
 	int			cqn;
 	u32			cons_index;
 	struct mthca_cq_buf	buf;
@@ -217,7 +219,7 @@ struct mthca_cq {
 struct mthca_srq {
 	struct ib_srq		ibsrq;
 	spinlock_t		lock;
-	atomic_t		refcount;
+	int			refcount;
 	int			srqn;
 	int			max;
 	int			max_gs;
@@ -254,7 +256,7 @@ struct mthca_wq {
 
 struct mthca_qp {
 	struct ib_qp           ibqp;
-	atomic_t               refcount;
+	int                    refcount;
 	u32                    qpn;
 	int                    is_direct;
 	u8                     port; /* for SQP and memfree use only */
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index f37b0e3..19765f6 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -240,7 +240,7 @@ void mthca_qp_event(struct mthca_dev *de
 	spin_lock(&dev->qp_table.lock);
 	qp = mthca_array_get(&dev->qp_table.qp, qpn & (dev->limits.num_qps - 1));
 	if (qp)
-		atomic_inc(&qp->refcount);
+		++qp->refcount;
 	spin_unlock(&dev->qp_table.lock);
 
 	if (!qp) {
@@ -257,8 +257,10 @@ void mthca_qp_event(struct mthca_dev *de
 	if (qp->ibqp.event_handler)
 		qp->ibqp.event_handler(&event, qp->ibqp.qp_context);
 
-	if (atomic_dec_and_test(&qp->refcount))
+	spin_lock(&dev->qp_table.lock);
+	if (!--qp->refcount)
 		wake_up(&qp->wait);
+	spin_unlock(&dev->qp_table.lock);
 }
 
 static int to_mthca_state(enum ib_qp_state ib_state)
@@ -833,10 +835,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	 * entries and reinitialize the QP.
 	 */
 	if (new_state == IB_QPS_RESET && !qp->ibqp.uobject) {
-		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn,
+		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq), qp->qpn,
 			       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 		if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
-			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq)->cqn, qp->qpn,
+			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq), qp->qpn,
 				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 
 		mthca_wq_init(&qp->sq);
@@ -1096,7 +1098,7 @@ static int mthca_alloc_qp_common(struct 
 	int ret;
 	int i;
 
-	atomic_set(&qp->refcount, 1);
+	qp->refcount = 1;
 	init_waitqueue_head(&qp->wait);
 	qp->state    	 = IB_QPS_RESET;
 	qp->atomic_rd_en = 0;
@@ -1318,6 +1320,17 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	return err;
 }
 
+static inline int get_qp_refcount(struct mthca_dev *dev, struct mthca_qp *qp)
+{
+	int c;
+
+	spin_lock_irq(&dev->qp_table.lock);
+	c = qp->refcount;
+	spin_unlock_irq(&dev->qp_table.lock);
+
+	return c;
+}
+
 void mthca_free_qp(struct mthca_dev *dev,
 		   struct mthca_qp *qp)
 {
@@ -1339,14 +1352,14 @@ void mthca_free_qp(struct mthca_dev *dev
 	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp,
 			  qp->qpn & (dev->limits.num_qps - 1));
+	--qp->refcount;
 	spin_unlock(&dev->qp_table.lock);
 
 	if (send_cq != recv_cq)
 		spin_unlock(&recv_cq->lock);
 	spin_unlock_irq(&send_cq->lock);
 
-	atomic_dec(&qp->refcount);
-	wait_event(qp->wait, !atomic_read(&qp->refcount));
+	wait_event(qp->wait, !get_qp_refcount(dev, qp));
 
 	if (qp->state != IB_QPS_RESET)
 		mthca_MODIFY_QP(dev, qp->state, IB_QPS_RESET, qp->qpn, 0,
@@ -1358,10 +1371,10 @@ void mthca_free_qp(struct mthca_dev *dev
 	 * unref the mem-free tables and free the QPN in our table.
 	 */
 	if (!qp->ibqp.uobject) {
-		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn,
+		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq), qp->qpn,
 			       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 		if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
-			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq)->cqn, qp->qpn,
+			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq), qp->qpn,
 				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 
 		mthca_free_memfree(dev, qp);
diff --git a/drivers/infiniband/hw/mthca/mthca_srq.c b/drivers/infiniband/hw/mthca/mthca_srq.c
index adcaf85..1ea4332 100644
--- a/drivers/infiniband/hw/mthca/mthca_srq.c
+++ b/drivers/infiniband/hw/mthca/mthca_srq.c
@@ -241,7 +241,7 @@ int mthca_alloc_srq(struct mthca_dev *de
 		goto err_out_mailbox;
 
 	spin_lock_init(&srq->lock);
-	atomic_set(&srq->refcount, 1);
+	srq->refcount = 1;
 	init_waitqueue_head(&srq->wait);
 
 	if (mthca_is_memfree(dev))
@@ -308,6 +308,17 @@ err_out:
 	return err;
 }
 
+static inline int get_srq_refcount(struct mthca_dev *dev, struct mthca_srq *srq)
+{
+	int c;
+
+	spin_lock_irq(&dev->srq_table.lock);
+	c = srq->refcount;
+	spin_unlock_irq(&dev->srq_table.lock);
+
+	return c;
+}
+
 void mthca_free_srq(struct mthca_dev *dev, struct mthca_srq *srq)
 {
 	struct mthca_mailbox *mailbox;
@@ -329,10 +340,10 @@ void mthca_free_srq(struct mthca_dev *de
 	spin_lock_irq(&dev->srq_table.lock);
 	mthca_array_clear(&dev->srq_table.srq,
 			  srq->srqn & (dev->limits.num_srqs - 1));
+	--srq->refcount;
 	spin_unlock_irq(&dev->srq_table.lock);
 
-	atomic_dec(&srq->refcount);
-	wait_event(srq->wait, !atomic_read(&srq->refcount));
+	wait_event(srq->wait, !get_srq_refcount(dev, srq));
 
 	if (!srq->ibsrq.uobject) {
 		mthca_free_srq_buf(dev, srq);
@@ -414,7 +425,7 @@ void mthca_srq_event(struct mthca_dev *d
 	spin_lock(&dev->srq_table.lock);
 	srq = mthca_array_get(&dev->srq_table.srq, srqn & (dev->limits.num_srqs - 1));
 	if (srq)
-		atomic_inc(&srq->refcount);
+		++srq->refcount;
 	spin_unlock(&dev->srq_table.lock);
 
 	if (!srq) {
@@ -431,8 +442,10 @@ void mthca_srq_event(struct mthca_dev *d
 	srq->ibsrq.event_handler(&event, srq->ibsrq.srq_context);
 
 out:
-	if (atomic_dec_and_test(&srq->refcount))
+	spin_lock(&dev->srq_table.lock);
+	if (!--srq->refcount)
 		wake_up(&srq->wait);
+	spin_unlock(&dev->srq_table.lock);
 }
 
 /*
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 4ca1755..f887780 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -158,10 +158,8 @@ int ipoib_vlan_delete(struct net_device 
 		if (priv->pkey == pkey) {
 			unregister_netdev(priv->dev);
 			ipoib_dev_cleanup(priv->dev);
-
 			list_del(&priv->list);
-
-			kfree(priv);
+			free_netdev(priv->dev);
 
 			ret = 0;
 			break;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 5bb5574..c32ce43 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -409,6 +409,34 @@ static int srp_connect_target(struct srp
 	}
 }
 
+static void srp_unmap_data(struct scsi_cmnd *scmnd,
+			   struct srp_target_port *target,
+			   struct srp_request *req)
+{
+	struct scatterlist *scat;
+	int nents;
+
+	if (!scmnd->request_buffer ||
+	    (scmnd->sc_data_direction != DMA_TO_DEVICE &&
+	     scmnd->sc_data_direction != DMA_FROM_DEVICE))
+		return;
+
+	/*
+	 * This handling of non-SG commands can be killed when the
+	 * SCSI midlayer no longer generates non-SG commands.
+	 */
+	if (likely(scmnd->use_sg)) {
+		nents = scmnd->use_sg;
+		scat  = scmnd->request_buffer;
+	} else {
+		nents = 1;
+		scat  = &req->fake_sg;
+	}
+
+	dma_unmap_sg(target->srp_host->dev->dma_device, scat, nents,
+		     scmnd->sc_data_direction);
+}
+
 static int srp_reconnect_target(struct srp_target_port *target)
 {
 	struct ib_cm_id *new_cm_id;
@@ -455,16 +483,16 @@ static int srp_reconnect_target(struct s
 	list_for_each_entry(req, &target->req_queue, list) {
 		req->scmnd->result = DID_RESET << 16;
 		req->scmnd->scsi_done(req->scmnd);
+		srp_unmap_data(req->scmnd, target, req);
 	}
 
 	target->rx_head	 = 0;
 	target->tx_head	 = 0;
 	target->tx_tail  = 0;
-	target->req_head = 0;
-	for (i = 0; i < SRP_SQ_SIZE - 1; ++i)
-		target->req_ring[i].next = i + 1;
-	target->req_ring[SRP_SQ_SIZE - 1].next = -1;
+	INIT_LIST_HEAD(&target->free_reqs);
 	INIT_LIST_HEAD(&target->req_queue);
+	for (i = 0; i < SRP_SQ_SIZE; ++i)
+		list_add_tail(&target->req_ring[i].list, &target->free_reqs);
 
 	ret = srp_connect_target(target);
 	if (ret)
@@ -589,40 +617,10 @@ static int srp_map_data(struct scsi_cmnd
 	return len;
 }
 
-static void srp_unmap_data(struct scsi_cmnd *scmnd,
-			   struct srp_target_port *target,
-			   struct srp_request *req)
-{
-	struct scatterlist *scat;
-	int nents;
-
-	if (!scmnd->request_buffer ||
-	    (scmnd->sc_data_direction != DMA_TO_DEVICE &&
-	     scmnd->sc_data_direction != DMA_FROM_DEVICE))
-		return;
-
-	/*
-	 * This handling of non-SG commands can be killed when the
-	 * SCSI midlayer no longer generates non-SG commands.
-	 */
-	if (likely(scmnd->use_sg)) {
-		nents = scmnd->use_sg;
-		scat  = scmnd->request_buffer;
-	} else {
-		nents = 1;
-		scat  = &req->fake_sg;
-	}
-
-	dma_unmap_sg(target->srp_host->dev->dma_device, scat, nents,
-		     scmnd->sc_data_direction);
-}
-
-static void srp_remove_req(struct srp_target_port *target, struct srp_request *req,
-			   int index)
+static void srp_remove_req(struct srp_target_port *target, struct srp_request *req)
 {
-	list_del(&req->list);
-	req->next = target->req_head;
-	target->req_head = index;
+	srp_unmap_data(req->scmnd, target, req);
+	list_move_tail(&req->list, &target->free_reqs);
 }
 
 static void srp_process_rsp(struct srp_target_port *target, struct srp_rsp *rsp)
@@ -647,7 +645,7 @@ static void srp_process_rsp(struct srp_t
 			req->tsk_status = rsp->data[3];
 		complete(&req->done);
 	} else {
-		scmnd 	      = req->scmnd;
+		scmnd = req->scmnd;
 		if (!scmnd)
 			printk(KERN_ERR "Null scmnd for RSP w/tag %016llx\n",
 			       (unsigned long long) rsp->tag);
@@ -665,14 +663,11 @@ static void srp_process_rsp(struct srp_t
 		else if (rsp->flags & (SRP_RSP_FLAG_DIOVER | SRP_RSP_FLAG_DIUNDER))
 			scmnd->resid = be32_to_cpu(rsp->data_in_res_cnt);
 
-		srp_unmap_data(scmnd, target, req);
-
 		if (!req->tsk_mgmt) {
-			req->scmnd = NULL;
 			scmnd->host_scribble = (void *) -1L;
 			scmnd->scsi_done(scmnd);
 
-			srp_remove_req(target, req, rsp->tag & ~SRP_TAG_TSK_MGMT);
+			srp_remove_req(target, req);
 		} else
 			req->cmd_done = 1;
 	}
@@ -859,7 +854,6 @@ static int srp_queuecommand(struct scsi_
 	struct srp_request *req;
 	struct srp_iu *iu;
 	struct srp_cmd *cmd;
-	long req_index;
 	int len;
 
 	if (target->state == SRP_TARGET_CONNECTING)
@@ -879,22 +873,20 @@ static int srp_queuecommand(struct scsi_
 	dma_sync_single_for_cpu(target->srp_host->dev->dma_device, iu->dma,
 				SRP_MAX_IU_LEN, DMA_TO_DEVICE);
 
-	req_index = target->req_head;
+	req = list_entry(target->free_reqs.next, struct srp_request, list);
 
 	scmnd->scsi_done     = done;
 	scmnd->result        = 0;
-	scmnd->host_scribble = (void *) req_index;
+	scmnd->host_scribble = (void *) (long) req->index;
 
 	cmd = iu->buf;
 	memset(cmd, 0, sizeof *cmd);
 
 	cmd->opcode = SRP_CMD;
 	cmd->lun    = cpu_to_be64((u64) scmnd->device->lun << 48);
-	cmd->tag    = req_index;
+	cmd->tag    = req->index;
 	memcpy(cmd->cdb, scmnd->cmnd, scmnd->cmd_len);
 
-	req = &target->req_ring[req_index];
-
 	req->scmnd    = scmnd;
 	req->cmd      = iu;
 	req->cmd_done = 0;
@@ -919,8 +911,7 @@ static int srp_queuecommand(struct scsi_
 		goto err_unmap;
 	}
 
-	target->req_head = req->next;
-	list_add_tail(&req->list, &target->req_queue);
+	list_move_tail(&req->list, &target->req_queue);
 
 	return 0;
 
@@ -1143,30 +1134,20 @@ static int srp_cm_handler(struct ib_cm_i
 	return 0;
 }
 
-static int srp_send_tsk_mgmt(struct scsi_cmnd *scmnd, u8 func)
+static int srp_send_tsk_mgmt(struct srp_target_port *target,
+			     struct srp_request *req, u8 func)
 {
-	struct srp_target_port *target = host_to_target(scmnd->device->host);
-	struct srp_request *req;
 	struct srp_iu *iu;
 	struct srp_tsk_mgmt *tsk_mgmt;
-	int req_index;
-	int ret = FAILED;
 
 	spin_lock_irq(target->scsi_host->host_lock);
 
 	if (target->state == SRP_TARGET_DEAD ||
 	    target->state == SRP_TARGET_REMOVED) {
-		scmnd->result = DID_BAD_TARGET << 16;
+		req->scmnd->result = DID_BAD_TARGET << 16;
 		goto out;
 	}
 
-	if (scmnd->host_scribble == (void *) -1L)
-		goto out;
-
-	req_index = (long) scmnd->host_scribble;
-	printk(KERN_ERR "Abort for req_index %d\n", req_index);
-
-	req = &target->req_ring[req_index];
 	init_completion(&req->done);
 
 	iu = __srp_get_tx_iu(target);
@@ -1177,10 +1158,10 @@ static int srp_send_tsk_mgmt(struct scsi
 	memset(tsk_mgmt, 0, sizeof *tsk_mgmt);
 
 	tsk_mgmt->opcode 	= SRP_TSK_MGMT;
-	tsk_mgmt->lun 		= cpu_to_be64((u64) scmnd->device->lun << 48);
-	tsk_mgmt->tag 		= req_index | SRP_TAG_TSK_MGMT;
+	tsk_mgmt->lun 		= cpu_to_be64((u64) req->scmnd->device->lun << 48);
+	tsk_mgmt->tag 		= req->index | SRP_TAG_TSK_MGMT;
 	tsk_mgmt->tsk_mgmt_func = func;
-	tsk_mgmt->task_tag 	= req_index;
+	tsk_mgmt->task_tag 	= req->index;
 
 	if (__srp_post_send(target, iu, sizeof *tsk_mgmt))
 		goto out;
@@ -1188,37 +1169,85 @@ static int srp_send_tsk_mgmt(struct scsi
 	req->tsk_mgmt = iu;
 
 	spin_unlock_irq(target->scsi_host->host_lock);
+
 	if (!wait_for_completion_timeout(&req->done,
 					 msecs_to_jiffies(SRP_ABORT_TIMEOUT_MS)))
-		return FAILED;
-	spin_lock_irq(target->scsi_host->host_lock);
+		return -1;
 
-	if (req->cmd_done) {
-		srp_remove_req(target, req, req_index);
-		scmnd->scsi_done(scmnd);
-	} else if (!req->tsk_status) {
-		srp_remove_req(target, req, req_index);
-		scmnd->result = DID_ABORT << 16;
-		ret = SUCCESS;
-	}
+	return 0;
 
 out:
 	spin_unlock_irq(target->scsi_host->host_lock);
-	return ret;
+	return -1;
+}
+
+static int srp_find_req(struct srp_target_port *target,
+			struct scsi_cmnd *scmnd,
+			struct srp_request **req)
+{
+	if (scmnd->host_scribble == (void *) -1L)
+		return -1;
+
+	*req = &target->req_ring[(long) scmnd->host_scribble];
+
+	return 0;
 }
 
 static int srp_abort(struct scsi_cmnd *scmnd)
 {
+	struct srp_target_port *target = host_to_target(scmnd->device->host);
+	struct srp_request *req;
+	int ret = SUCCESS;
+
 	printk(KERN_ERR "SRP abort called\n");
 
-	return srp_send_tsk_mgmt(scmnd, SRP_TSK_ABORT_TASK);
+	if (srp_find_req(target, scmnd, &req))
+		return FAILED;
+	if (srp_send_tsk_mgmt(target, req, SRP_TSK_ABORT_TASK))
+		return FAILED;
+
+	spin_lock_irq(target->scsi_host->host_lock);
+
+	if (req->cmd_done) {
+		srp_remove_req(target, req);
+		scmnd->scsi_done(scmnd);
+	} else if (!req->tsk_status) {
+		srp_remove_req(target, req);
+		scmnd->result = DID_ABORT << 16;
+	} else
+		ret = FAILED;
+
+	spin_unlock_irq(target->scsi_host->host_lock);
+
+	return ret;
 }
 
 static int srp_reset_device(struct scsi_cmnd *scmnd)
 {
+	struct srp_target_port *target = host_to_target(scmnd->device->host);
+	struct srp_request *req, *tmp;
+
 	printk(KERN_ERR "SRP reset_device called\n");
 
-	return srp_send_tsk_mgmt(scmnd, SRP_TSK_LUN_RESET);
+	if (srp_find_req(target, scmnd, &req))
+		return FAILED;
+	if (srp_send_tsk_mgmt(target, req, SRP_TSK_LUN_RESET))
+		return FAILED;
+	if (req->tsk_status)
+		return FAILED;
+
+	spin_lock_irq(target->scsi_host->host_lock);
+
+	list_for_each_entry_safe(req, tmp, &target->req_queue, list)
+		if (req->scmnd->device == scmnd->device) {
+			req->scmnd->result = DID_RESET << 16;
+			scmnd->scsi_done(scmnd);
+			srp_remove_req(target, req);
+		}
+
+	spin_unlock_irq(target->scsi_host->host_lock);
+
+	return SUCCESS;
 }
 
 static int srp_reset_host(struct scsi_cmnd *scmnd)
@@ -1518,10 +1547,12 @@ static ssize_t srp_create_target(struct 
 
 	INIT_WORK(&target->work, srp_reconnect_work, target);
 
-	for (i = 0; i < SRP_SQ_SIZE - 1; ++i)
-		target->req_ring[i].next = i + 1;
-	target->req_ring[SRP_SQ_SIZE - 1].next = -1;
+	INIT_LIST_HEAD(&target->free_reqs);
 	INIT_LIST_HEAD(&target->req_queue);
+	for (i = 0; i < SRP_SQ_SIZE; ++i) {
+		target->req_ring[i].index = i;
+		list_add_tail(&target->req_ring[i].list, &target->free_reqs);
+	}
 
 	ret = srp_parse_options(buf, target);
 	if (ret)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index bd7f7c3..c5cd43a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -101,7 +101,7 @@ struct srp_request {
 	 */
 	struct scatterlist	fake_sg;
 	struct completion	done;
-	short			next;
+	short			index;
 	u8			cmd_done;
 	u8			tsk_status;
 };
@@ -133,7 +133,7 @@ struct srp_target_port {
 	unsigned		tx_tail;
 	struct srp_iu	       *tx_ring[SRP_SQ_SIZE + 1];
 
-	int			req_head;
+	struct list_head	free_reqs;
 	struct list_head	req_queue;
 	struct srp_request	req_ring[SRP_SQ_SIZE];
 
