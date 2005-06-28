Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVF2CgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVF2CgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVF1XaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:30:07 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:21276 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S262233AbVF1XD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:56 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037114:sNHT34742400"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 15/16] IB uverbs: add mthca user QP support
In-Reply-To: <2005628163.jWivrrVepuPgy40z@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:44 -0700
Message-Id: <2005628163.VUsohVlfE72duiiM@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for userspace queue pairs (QPs) to mthca.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_dev.h      |    2 
 drivers/infiniband/hw/mthca/mthca_provider.c |   80 ++++++++--
 drivers/infiniband/hw/mthca/mthca_qp.c       |  215 +++++++++++++++++----------
 3 files changed, 212 insertions(+), 85 deletions(-)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-28 15:20:25.681346835 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-28 15:20:28.954636956 -0700
@@ -440,12 +440,14 @@ int mthca_alloc_qp(struct mthca_dev *dev
 		   struct mthca_cq *recv_cq,
 		   enum ib_qp_type type,
 		   enum ib_sig_type send_policy,
+		   struct ib_qp_cap *cap,
 		   struct mthca_qp *qp);
 int mthca_alloc_sqp(struct mthca_dev *dev,
 		    struct mthca_pd *pd,
 		    struct mthca_cq *send_cq,
 		    struct mthca_cq *recv_cq,
 		    enum ib_sig_type send_policy,
+		    struct ib_qp_cap *cap,
 		    int qpn,
 		    int port,
 		    struct mthca_sqp *sqp);
--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:25.681346835 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:28.953637173 -0700
@@ -424,6 +424,7 @@ static struct ib_qp *mthca_create_qp(str
 				     struct ib_qp_init_attr *init_attr,
 				     struct ib_udata *udata)
 {
+	struct mthca_create_qp ucmd;
 	struct mthca_qp *qp;
 	int err;
 
@@ -432,41 +433,82 @@ static struct ib_qp *mthca_create_qp(str
 	case IB_QPT_UC:
 	case IB_QPT_UD:
 	{
+		struct mthca_ucontext *context;
+
 		qp = kmalloc(sizeof *qp, GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
 
-		qp->sq.max    = init_attr->cap.max_send_wr;
-		qp->rq.max    = init_attr->cap.max_recv_wr;
-		qp->sq.max_gs = init_attr->cap.max_send_sge;
-		qp->rq.max_gs = init_attr->cap.max_recv_sge;
+		if (pd->uobject) {
+			context = to_mucontext(pd->uobject->context);
+
+			if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
+				return ERR_PTR(-EFAULT);
+
+			err = mthca_map_user_db(to_mdev(pd->device), &context->uar,
+						context->db_tab,
+						ucmd.sq_db_index, ucmd.sq_db_page);
+			if (err) {
+				kfree(qp);
+				return ERR_PTR(err);
+			}
+
+			err = mthca_map_user_db(to_mdev(pd->device), &context->uar,
+						context->db_tab,
+						ucmd.rq_db_index, ucmd.rq_db_page);
+			if (err) {
+				mthca_unmap_user_db(to_mdev(pd->device),
+						    &context->uar,
+						    context->db_tab,
+						    ucmd.sq_db_index);
+				kfree(qp);
+				return ERR_PTR(err);
+			}
+
+			qp->mr.ibmr.lkey = ucmd.lkey;
+			qp->sq.db_index  = ucmd.sq_db_index;
+			qp->rq.db_index  = ucmd.rq_db_index;
+		}
 
 		err = mthca_alloc_qp(to_mdev(pd->device), to_mpd(pd),
 				     to_mcq(init_attr->send_cq),
 				     to_mcq(init_attr->recv_cq),
 				     init_attr->qp_type, init_attr->sq_sig_type,
-				     qp);
+				     &init_attr->cap, qp);
+
+		if (err && pd->uobject) {
+			context = to_mucontext(pd->uobject->context);
+
+			mthca_unmap_user_db(to_mdev(pd->device),
+					    &context->uar,
+					    context->db_tab,
+					    ucmd.sq_db_index);
+			mthca_unmap_user_db(to_mdev(pd->device),
+					    &context->uar,
+					    context->db_tab,
+					    ucmd.rq_db_index);
+		}
+
 		qp->ibqp.qp_num = qp->qpn;
 		break;
 	}
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	{
+		/* Don't allow userspace to create special QPs */
+		if (pd->uobject)
+			return ERR_PTR(-EINVAL);
+
 		qp = kmalloc(sizeof (struct mthca_sqp), GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
 
-		qp->sq.max    = init_attr->cap.max_send_wr;
-		qp->rq.max    = init_attr->cap.max_recv_wr;
-		qp->sq.max_gs = init_attr->cap.max_send_sge;
-		qp->rq.max_gs = init_attr->cap.max_recv_sge;
-
 		qp->ibqp.qp_num = init_attr->qp_type == IB_QPT_SMI ? 0 : 1;
 
 		err = mthca_alloc_sqp(to_mdev(pd->device), to_mpd(pd),
 				      to_mcq(init_attr->send_cq),
 				      to_mcq(init_attr->recv_cq),
-				      init_attr->sq_sig_type,
+				      init_attr->sq_sig_type, &init_attr->cap,
 				      qp->ibqp.qp_num, init_attr->port_num,
 				      to_msqp(qp));
 		break;
@@ -481,13 +523,27 @@ static struct ib_qp *mthca_create_qp(str
 		return ERR_PTR(err);
 	}
 
-        init_attr->cap.max_inline_data = 0;
+	init_attr->cap.max_inline_data = 0;
+	init_attr->cap.max_send_wr     = qp->sq.max;
+	init_attr->cap.max_recv_wr     = qp->rq.max;
+	init_attr->cap.max_send_sge    = qp->sq.max_gs;
+	init_attr->cap.max_recv_sge    = qp->rq.max_gs;
 
 	return &qp->ibqp;
 }
 
 static int mthca_destroy_qp(struct ib_qp *qp)
 {
+	if (qp->uobject) {
+		mthca_unmap_user_db(to_mdev(qp->device),
+				    &to_mucontext(qp->uobject->context)->uar,
+				    to_mucontext(qp->uobject->context)->db_tab,
+				    to_mqp(qp)->sq.db_index);
+		mthca_unmap_user_db(to_mdev(qp->device),
+				    &to_mucontext(qp->uobject->context)->uar,
+				    to_mucontext(qp->uobject->context)->db_tab,
+				    to_mqp(qp)->rq.db_index);
+	}
 	mthca_free_qp(to_mdev(qp->device), to_mqp(qp));
 	kfree(qp);
 	return 0;
--- linux.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-28 15:19:18.256921644 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-28 15:20:28.952637389 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Cisco Systems. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -46,7 +47,9 @@ enum {
 	MTHCA_MAX_DIRECT_QP_SIZE = 4 * PAGE_SIZE,
 	MTHCA_ACK_REQ_FREQ       = 10,
 	MTHCA_FLIGHT_LIMIT       = 9,
-	MTHCA_UD_HEADER_SIZE     = 72 /* largest UD header possible */
+	MTHCA_UD_HEADER_SIZE     = 72, /* largest UD header possible */
+	MTHCA_INLINE_HEADER_SIZE = 4,  /* data segment overhead for inline */
+	MTHCA_INLINE_CHUNK_SIZE  = 16  /* inline data segment chunk */
 };
 
 enum {
@@ -689,7 +692,11 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 
 	/* leave arbel_sched_queue as 0 */
 
-	qp_context->usr_page   = cpu_to_be32(dev->driver_uar.index);
+	if (qp->ibqp.uobject)
+		qp_context->usr_page =
+			cpu_to_be32(to_mucontext(qp->ibqp.uobject->context)->uar.index);
+	else
+		qp_context->usr_page = cpu_to_be32(dev->driver_uar.index);
 	qp_context->local_qpn  = cpu_to_be32(qp->qpn);
 	if (attr_mask & IB_QP_DEST_QPN) {
 		qp_context->remote_qpn = cpu_to_be32(attr->dest_qp_num);
@@ -954,6 +961,15 @@ static int mthca_alloc_wqe_buf(struct mt
 
 	qp->send_wqe_offset = ALIGN(qp->rq.max << qp->rq.wqe_shift,
 				    1 << qp->sq.wqe_shift);
+
+	/*
+	 * If this is a userspace QP, we don't actually have to
+	 * allocate anything.  All we need is to calculate the WQE
+	 * sizes and the send_wqe_offset, so we're done now.
+	 */
+	if (pd->ibpd.uobject)
+		return 0;
+
 	size = PAGE_ALIGN(qp->send_wqe_offset +
 			  (qp->sq.max << qp->sq.wqe_shift));
 
@@ -1053,10 +1069,32 @@ static int mthca_alloc_wqe_buf(struct mt
 	return err;
 }
 
-static int mthca_alloc_memfree(struct mthca_dev *dev,
+static void mthca_free_wqe_buf(struct mthca_dev *dev,
 			       struct mthca_qp *qp)
 {
-	int ret = 0;
+	int i;
+	int size = PAGE_ALIGN(qp->send_wqe_offset +
+			      (qp->sq.max << qp->sq.wqe_shift));
+
+	if (qp->is_direct) {
+		dma_free_coherent(&dev->pdev->dev, size, qp->queue.direct.buf,
+				  pci_unmap_addr(&qp->queue.direct, mapping));
+	} else {
+		for (i = 0; i < size / PAGE_SIZE; ++i) {
+			dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
+					  qp->queue.page_list[i].buf,
+					  pci_unmap_addr(&qp->queue.page_list[i],
+							 mapping));
+		}
+	}
+
+	kfree(qp->wrid);
+}
+
+static int mthca_map_memfree(struct mthca_dev *dev,
+			     struct mthca_qp *qp)
+{
+	int ret;
 
 	if (mthca_is_memfree(dev)) {
 		ret = mthca_table_get(dev, dev->qp_table.qp_table, qp->qpn);
@@ -1067,35 +1105,15 @@ static int mthca_alloc_memfree(struct mt
 		if (ret)
 			goto err_qpc;
 
-		ret = mthca_table_get(dev, dev->qp_table.rdb_table,
-				      qp->qpn << dev->qp_table.rdb_shift);
-		if (ret)
-			goto err_eqpc;
-
-		qp->rq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_RQ,
-						 qp->qpn, &qp->rq.db);
-		if (qp->rq.db_index < 0) {
-			ret = -ENOMEM;
-			goto err_rdb;
-		}
+ 		ret = mthca_table_get(dev, dev->qp_table.rdb_table,
+ 				      qp->qpn << dev->qp_table.rdb_shift);
+ 		if (ret)
+ 			goto err_eqpc;
 
-		qp->sq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_SQ,
-						 qp->qpn, &qp->sq.db);
-		if (qp->sq.db_index < 0) {
-			ret = -ENOMEM;
-			goto err_rq_db;
-		}
 	}
 
 	return 0;
 
-err_rq_db:
-	mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
-
-err_rdb:
-	mthca_table_put(dev, dev->qp_table.rdb_table,
-			qp->qpn << dev->qp_table.rdb_shift);
-
 err_eqpc:
 	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
 
@@ -1105,6 +1123,35 @@ err_qpc:
 	return ret;
 }
 
+static void mthca_unmap_memfree(struct mthca_dev *dev,
+				struct mthca_qp *qp)
+{
+	mthca_table_put(dev, dev->qp_table.rdb_table,
+			qp->qpn << dev->qp_table.rdb_shift);
+	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
+	mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
+}
+
+static int mthca_alloc_memfree(struct mthca_dev *dev,
+			       struct mthca_qp *qp)
+{
+	int ret = 0;
+
+	if (mthca_is_memfree(dev)) {
+		qp->rq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_RQ,
+						 qp->qpn, &qp->rq.db);
+		if (qp->rq.db_index < 0)
+			return ret;
+
+		qp->sq.db_index = mthca_alloc_db(dev, MTHCA_DB_TYPE_SQ,
+						 qp->qpn, &qp->sq.db);
+		if (qp->sq.db_index < 0)
+			mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
+	}
+
+	return ret;
+}
+
 static void mthca_free_memfree(struct mthca_dev *dev,
 			       struct mthca_qp *qp)
 {
@@ -1112,11 +1159,6 @@ static void mthca_free_memfree(struct mt
 		mthca_free_db(dev, MTHCA_DB_TYPE_SQ, qp->sq.db_index);
 		mthca_free_db(dev, MTHCA_DB_TYPE_RQ, qp->rq.db_index);
 	}
-
-	mthca_table_put(dev, dev->qp_table.rdb_table,
-			qp->qpn << dev->qp_table.rdb_shift);
-	mthca_table_put(dev, dev->qp_table.eqp_table, qp->qpn);
-	mthca_table_put(dev, dev->qp_table.qp_table, qp->qpn);
 }
 
 static void mthca_wq_init(struct mthca_wq* wq)
@@ -1147,13 +1189,28 @@ static int mthca_alloc_qp_common(struct 
 	mthca_wq_init(&qp->sq);
 	mthca_wq_init(&qp->rq);
 
-	ret = mthca_alloc_memfree(dev, qp);
+	ret = mthca_map_memfree(dev, qp);
 	if (ret)
 		return ret;
 
 	ret = mthca_alloc_wqe_buf(dev, pd, qp);
 	if (ret) {
-		mthca_free_memfree(dev, qp);
+		mthca_unmap_memfree(dev, qp);
+		return ret;
+	}
+
+	/*
+	 * If this is a userspace QP, we're done now.  The doorbells
+	 * will be allocated and buffers will be initialized in
+	 * userspace.
+	 */
+	if (pd->ibpd.uobject)
+		return 0;
+
+	ret = mthca_alloc_memfree(dev, qp);
+	if (ret) {
+		mthca_free_wqe_buf(dev, qp);
+		mthca_unmap_memfree(dev, qp);
 		return ret;
 	}
 
@@ -1186,22 +1243,39 @@ static int mthca_alloc_qp_common(struct 
 	return 0;
 }
 
-static void mthca_align_qp_size(struct mthca_dev *dev, struct mthca_qp *qp)
+static int mthca_set_qp_size(struct mthca_dev *dev, struct ib_qp_cap *cap,
+			     struct mthca_qp *qp)
 {
-	int i;
-
-	if (!mthca_is_memfree(dev))
-		return;
+	/* Sanity check QP size before proceeding */
+	if (cap->max_send_wr  > 65536 || cap->max_recv_wr  > 65536 ||
+	    cap->max_send_sge > 64    || cap->max_recv_sge > 64)
+		return -EINVAL;
 
-	for (i = 0; 1 << i < qp->rq.max; ++i)
-		; /* nothing */
+	if (mthca_is_memfree(dev)) {
+		qp->rq.max = cap->max_recv_wr ?
+			roundup_pow_of_two(cap->max_recv_wr) : 0;
+		qp->sq.max = cap->max_send_wr ?
+			roundup_pow_of_two(cap->max_send_wr) : 0;
+	} else {
+		qp->rq.max = cap->max_recv_wr;
+		qp->sq.max = cap->max_send_wr;
+	}
 
-	qp->rq.max = 1 << i;
+	qp->rq.max_gs = cap->max_recv_sge;
+	qp->sq.max_gs = max_t(int, cap->max_send_sge,
+			      ALIGN(cap->max_inline_data + MTHCA_INLINE_HEADER_SIZE,
+				    MTHCA_INLINE_CHUNK_SIZE) /
+			      sizeof (struct mthca_data_seg));
 
-	for (i = 0; 1 << i < qp->sq.max; ++i)
-		; /* nothing */
+	/*
+	 * For MLX transport we need 2 extra S/G entries:
+	 * one for the header and one for the checksum at the end
+	 */
+	if ((qp->transport == MLX && qp->sq.max_gs + 2 > dev->limits.max_sg) ||
+	    qp->sq.max_gs > dev->limits.max_sg || qp->rq.max_gs > dev->limits.max_sg)
+		return -EINVAL;
 
-	qp->sq.max = 1 << i;
+	return 0;
 }
 
 int mthca_alloc_qp(struct mthca_dev *dev,
@@ -1210,11 +1284,14 @@ int mthca_alloc_qp(struct mthca_dev *dev
 		   struct mthca_cq *recv_cq,
 		   enum ib_qp_type type,
 		   enum ib_sig_type send_policy,
+		   struct ib_qp_cap *cap,
 		   struct mthca_qp *qp)
 {
 	int err;
 
-	mthca_align_qp_size(dev, qp);
+	err = mthca_set_qp_size(dev, cap, qp);
+	if (err)
+		return err;
 
 	switch (type) {
 	case IB_QPT_RC: qp->transport = RC; break;
@@ -1247,14 +1324,17 @@ int mthca_alloc_sqp(struct mthca_dev *de
 		    struct mthca_cq *send_cq,
 		    struct mthca_cq *recv_cq,
 		    enum ib_sig_type send_policy,
+		    struct ib_qp_cap *cap,
 		    int qpn,
 		    int port,
 		    struct mthca_sqp *sqp)
 {
-	int err = 0;
 	u32 mqpn = qpn * 2 + dev->qp_table.sqp_start + port - 1;
+	int err;
 
-	mthca_align_qp_size(dev, &sqp->qp);
+	err = mthca_set_qp_size(dev, cap, &sqp->qp);
+	if (err)
+		return err;
 
 	sqp->header_buf_size = sqp->qp.sq.max * MTHCA_UD_HEADER_SIZE;
 	sqp->header_buf = dma_alloc_coherent(&dev->pdev->dev, sqp->header_buf_size,
@@ -1313,8 +1393,6 @@ void mthca_free_qp(struct mthca_dev *dev
 		   struct mthca_qp *qp)
 {
 	u8 status;
-	int size;
-	int i;
 	struct mthca_cq *send_cq;
 	struct mthca_cq *recv_cq;
 
@@ -1344,31 +1422,22 @@ void mthca_free_qp(struct mthca_dev *dev
 	if (qp->state != IB_QPS_RESET)
 		mthca_MODIFY_QP(dev, MTHCA_TRANS_ANY2RST, qp->qpn, 0, NULL, 0, &status);
 
-	mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn);
-	if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
-		mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq)->cqn, qp->qpn);
-
-	mthca_free_mr(dev, &qp->mr);
-
-	size = PAGE_ALIGN(qp->send_wqe_offset +
-			  (qp->sq.max << qp->sq.wqe_shift));
+	/*
+	 * If this is a userspace QP, the buffers, MR, CQs and so on
+	 * will be cleaned up in userspace, so all we have to do is
+	 * unref the mem-free tables and free the QPN in our table.
+	 */
+	if (!qp->ibqp.uobject) {
+		mthca_cq_clean(dev, to_mcq(qp->ibqp.send_cq)->cqn, qp->qpn);
+		if (qp->ibqp.send_cq != qp->ibqp.recv_cq)
+			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq)->cqn, qp->qpn);
 
-	if (qp->is_direct) {
-		pci_free_consistent(dev->pdev, size,
-				    qp->queue.direct.buf,
-				    pci_unmap_addr(&qp->queue.direct, mapping));
-	} else {
-		for (i = 0; i < size / PAGE_SIZE; ++i) {
-			pci_free_consistent(dev->pdev, PAGE_SIZE,
-					    qp->queue.page_list[i].buf,
-					    pci_unmap_addr(&qp->queue.page_list[i],
-							   mapping));
-		}
+		mthca_free_mr(dev, &qp->mr);
+		mthca_free_memfree(dev, qp);
+		mthca_free_wqe_buf(dev, qp);
 	}
 
-	kfree(qp->wrid);
-
-	mthca_free_memfree(dev, qp);
+	mthca_unmap_memfree(dev, qp);
 
 	if (is_sqp(dev, qp)) {
 		atomic_dec(&(to_mpd(qp->ibqp.pd)->sqp_count));
