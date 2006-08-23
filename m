Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965305AbWHWXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbWHWXZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbWHWXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:25:42 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:16954 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965305AbWHWXZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:25:41 -0400
To: greg@kroah.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 23 Aug 2006 16:25:38 -0700
Message-ID: <ada64gjxcel.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Aug 2006 23:25:38.0995 (UTC) FILETIME=[71881830:01C6C70B]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

to get a few fixes for the 2.6.18 tree:

Jack Morgenstein:
      IB/core: Fix SM LID/LID change with client reregister set

Michael S. Tsirkin:
      IB/mthca: Make fence flag work for send work requests
      IB/mthca: Update HCA firmware revisions

Roland Dreier:
      IB/mthca: Fix potential AB-BA deadlock with CQ locks
      IB/mthca: No userspace SRQs if HCA doesn't have SRQ support

 drivers/infiniband/core/cache.c              |    3 +
 drivers/infiniband/core/sa_query.c           |    3 +
 drivers/infiniband/hw/mthca/mthca_main.c     |    6 +--
 drivers/infiniband/hw/mthca/mthca_provider.c |   11 +++--
 drivers/infiniband/hw/mthca/mthca_provider.h |    4 +-
 drivers/infiniband/hw/mthca/mthca_qp.c       |   54 +++++++++++++++++++-------
 6 files changed, 55 insertions(+), 26 deletions(-)


diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index e05ca2c..75313ad 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -301,7 +301,8 @@ static void ib_cache_event(struct ib_eve
 	    event->event == IB_EVENT_PORT_ACTIVE ||
 	    event->event == IB_EVENT_LID_CHANGE  ||
 	    event->event == IB_EVENT_PKEY_CHANGE ||
-	    event->event == IB_EVENT_SM_CHANGE) {
+	    event->event == IB_EVENT_SM_CHANGE   ||
+	    event->event == IB_EVENT_CLIENT_REREGISTER) {
 		work = kmalloc(sizeof *work, GFP_ATOMIC);
 		if (work) {
 			INIT_WORK(&work->work, ib_cache_task, work);
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index aeda484..d6b8422 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -405,7 +405,8 @@ static void ib_sa_event(struct ib_event_
 	    event->event == IB_EVENT_PORT_ACTIVE ||
 	    event->event == IB_EVENT_LID_CHANGE  ||
 	    event->event == IB_EVENT_PKEY_CHANGE ||
-	    event->event == IB_EVENT_SM_CHANGE) {
+	    event->event == IB_EVENT_SM_CHANGE   ||
+	    event->event == IB_EVENT_CLIENT_REREGISTER) {
 		struct ib_sa_device *sa_dev;
 		sa_dev = container_of(handler, typeof(*sa_dev), event_handler);
 
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 557cde3..7b82c19 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -967,12 +967,12 @@ static struct {
 } mthca_hca_table[] = {
 	[TAVOR]        = { .latest_fw = MTHCA_FW_VER(3, 4, 0),
 			   .flags     = 0 },
-	[ARBEL_COMPAT] = { .latest_fw = MTHCA_FW_VER(4, 7, 400),
+	[ARBEL_COMPAT] = { .latest_fw = MTHCA_FW_VER(4, 7, 600),
 			   .flags     = MTHCA_FLAG_PCIE },
-	[ARBEL_NATIVE] = { .latest_fw = MTHCA_FW_VER(5, 1, 0),
+	[ARBEL_NATIVE] = { .latest_fw = MTHCA_FW_VER(5, 1, 400),
 			   .flags     = MTHCA_FLAG_MEMFREE |
 					MTHCA_FLAG_PCIE },
-	[SINAI]        = { .latest_fw = MTHCA_FW_VER(1, 0, 800),
+	[SINAI]        = { .latest_fw = MTHCA_FW_VER(1, 1, 0),
 			   .flags     = MTHCA_FLAG_MEMFREE |
 					MTHCA_FLAG_PCIE    |
 					MTHCA_FLAG_SINAI_OPT }
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 230ae21..265b1d1 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1287,11 +1287,7 @@ int mthca_register_device(struct mthca_d
 		(1ull << IB_USER_VERBS_CMD_MODIFY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_DESTROY_QP)		|
 		(1ull << IB_USER_VERBS_CMD_ATTACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST)	|
-		(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
-		(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
+		(1ull << IB_USER_VERBS_CMD_DETACH_MCAST);
 	dev->ib_dev.node_type            = IB_NODE_CA;
 	dev->ib_dev.phys_port_cnt        = dev->limits.num_ports;
 	dev->ib_dev.dma_device           = &dev->pdev->dev;
@@ -1316,6 +1312,11 @@ int mthca_register_device(struct mthca_d
 		dev->ib_dev.modify_srq           = mthca_modify_srq;
 		dev->ib_dev.query_srq            = mthca_query_srq;
 		dev->ib_dev.destroy_srq          = mthca_destroy_srq;
+		dev->ib_dev.uverbs_cmd_mask	|=
+			(1ull << IB_USER_VERBS_CMD_CREATE_SRQ)		|
+			(1ull << IB_USER_VERBS_CMD_MODIFY_SRQ)		|
+			(1ull << IB_USER_VERBS_CMD_QUERY_SRQ)		|
+			(1ull << IB_USER_VERBS_CMD_DESTROY_SRQ);
 
 		if (mthca_is_memfree(dev))
 			dev->ib_dev.post_srq_recv = mthca_arbel_post_srq_recv;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 8de2887..9a5bece 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -136,8 +136,8 @@ struct mthca_ah {
  * We have one global lock that protects dev->cq/qp_table.  Each
  * struct mthca_cq/qp also has its own lock.  An individual qp lock
  * may be taken inside of an individual cq lock.  Both cqs attached to
- * a qp may be locked, with the send cq locked first.  No other
- * nesting should be done.
+ * a qp may be locked, with the cq with the lower cqn locked first.
+ * No other nesting should be done.
  *
  * Each struct mthca_cq/qp also has an ref count, protected by the
  * corresponding table lock.  The pointer from the cq/qp_table to the
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index cd8b672..2e8f6f3 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -99,6 +99,10 @@ enum {
 	MTHCA_QP_BIT_RSC = 1 <<  3
 };
 
+enum {
+	MTHCA_SEND_DOORBELL_FENCE = 1 << 5
+};
+
 struct mthca_qp_path {
 	__be32 port_pkey;
 	u8     rnr_retry;
@@ -1259,6 +1263,32 @@ int mthca_alloc_qp(struct mthca_dev *dev
 	return 0;
 }
 
+static void mthca_lock_cqs(struct mthca_cq *send_cq, struct mthca_cq *recv_cq)
+{
+	if (send_cq == recv_cq)
+		spin_lock_irq(&send_cq->lock);
+	else if (send_cq->cqn < recv_cq->cqn) {
+		spin_lock_irq(&send_cq->lock);
+		spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock_irq(&recv_cq->lock);
+		spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static void mthca_unlock_cqs(struct mthca_cq *send_cq, struct mthca_cq *recv_cq)
+{
+	if (send_cq == recv_cq)
+		spin_unlock_irq(&send_cq->lock);
+	else if (send_cq->cqn < recv_cq->cqn) {
+		spin_unlock(&recv_cq->lock);
+		spin_unlock_irq(&send_cq->lock);
+	} else {
+		spin_unlock(&send_cq->lock);
+		spin_unlock_irq(&recv_cq->lock);
+	}
+}
+
 int mthca_alloc_sqp(struct mthca_dev *dev,
 		    struct mthca_pd *pd,
 		    struct mthca_cq *send_cq,
@@ -1311,17 +1341,13 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	 * Lock CQs here, so that CQ polling code can do QP lookup
 	 * without taking a lock.
 	 */
-	spin_lock_irq(&send_cq->lock);
-	if (send_cq != recv_cq)
-		spin_lock(&recv_cq->lock);
+	mthca_lock_cqs(send_cq, recv_cq);
 
 	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp, mqpn);
 	spin_unlock(&dev->qp_table.lock);
 
-	if (send_cq != recv_cq)
-		spin_unlock(&recv_cq->lock);
-	spin_unlock_irq(&send_cq->lock);
+	mthca_unlock_cqs(send_cq, recv_cq);
 
  err_out:
 	dma_free_coherent(&dev->pdev->dev, sqp->header_buf_size,
@@ -1355,9 +1381,7 @@ void mthca_free_qp(struct mthca_dev *dev
 	 * Lock CQs here, so that CQ polling code can do QP lookup
 	 * without taking a lock.
 	 */
-	spin_lock_irq(&send_cq->lock);
-	if (send_cq != recv_cq)
-		spin_lock(&recv_cq->lock);
+	mthca_lock_cqs(send_cq, recv_cq);
 
 	spin_lock(&dev->qp_table.lock);
 	mthca_array_clear(&dev->qp_table.qp,
@@ -1365,9 +1389,7 @@ void mthca_free_qp(struct mthca_dev *dev
 	--qp->refcount;
 	spin_unlock(&dev->qp_table.lock);
 
-	if (send_cq != recv_cq)
-		spin_unlock(&recv_cq->lock);
-	spin_unlock_irq(&send_cq->lock);
+	mthca_unlock_cqs(send_cq, recv_cq);
 
 	wait_event(qp->wait, !get_qp_refcount(dev, qp));
 
@@ -1502,7 +1524,7 @@ int mthca_tavor_post_send(struct ib_qp *
 	int i;
 	int size;
 	int size0 = 0;
-	u32 f0 = 0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
@@ -1686,6 +1708,8 @@ int mthca_tavor_post_send(struct ib_qp *
 		if (!size0) {
 			size0 = size;
 			op0   = mthca_opcode[wr->opcode];
+			f0    = wr->send_flags & IB_SEND_FENCE ?
+				MTHCA_SEND_DOORBELL_FENCE : 0;
 		}
 
 		++ind;
@@ -1843,7 +1867,7 @@ int mthca_arbel_post_send(struct ib_qp *
 	int i;
 	int size;
 	int size0 = 0;
-	u32 f0 = 0;
+	u32 f0;
 	int ind;
 	u8 op0 = 0;
 
@@ -2051,6 +2075,8 @@ int mthca_arbel_post_send(struct ib_qp *
 		if (!size0) {
 			size0 = size;
 			op0   = mthca_opcode[wr->opcode];
+			f0    = wr->send_flags & IB_SEND_FENCE ?
+				MTHCA_SEND_DOORBELL_FENCE : 0;
 		}
 
 		++ind;
