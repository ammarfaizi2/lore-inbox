Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVCCXfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVCCXfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVCCXd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:33:56 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262746AbVCCXWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:33 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][22/26] IB/mthca: mem-free work request posting
In-Reply-To: <2005331520.kqgduGt72iMbbNeg@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:28 -0800
Message-Id: <2005331520.ADYAIRdSQBiHhYiD@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0410 (UTC) FILETIME=[962B15A0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement posting send and receive work requests for mem-free mode.
Also tidy up a few things in send/receive posting for Tavor mode (fix
smp_wmb()s that should really be just wmb()s, annotate tests in the
fast path with likely()/unlikely()).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:01.213634129 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-03-03 14:13:02.565340719 -0800
@@ -380,10 +380,14 @@
 void mthca_qp_event(struct mthca_dev *dev, u32 qpn,
 		    enum ib_event_type event_type);
 int mthca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask);
-int mthca_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
-		    struct ib_send_wr **bad_wr);
-int mthca_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
-		       struct ib_recv_wr **bad_wr);
+int mthca_tavor_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+			  struct ib_send_wr **bad_wr);
+int mthca_tavor_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+			     struct ib_recv_wr **bad_wr);
+int mthca_arbel_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+			  struct ib_send_wr **bad_wr);
+int mthca_arbel_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+			     struct ib_recv_wr **bad_wr);
 int mthca_free_err_wqe(struct mthca_dev *dev, struct mthca_qp *qp, int is_send,
 		       int index, int *dbd, u32 *new_wqe);
 int mthca_alloc_qp(struct mthca_dev *dev,
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:13:01.213634129 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:13:02.566340502 -0800
@@ -613,8 +613,6 @@
 	dev->ib_dev.create_qp            = mthca_create_qp;
 	dev->ib_dev.modify_qp            = mthca_modify_qp;
 	dev->ib_dev.destroy_qp           = mthca_destroy_qp;
-	dev->ib_dev.post_send            = mthca_post_send;
-	dev->ib_dev.post_recv            = mthca_post_receive;
 	dev->ib_dev.create_cq            = mthca_create_cq;
 	dev->ib_dev.destroy_cq           = mthca_destroy_cq;
 	dev->ib_dev.poll_cq              = mthca_poll_cq;
@@ -625,10 +623,15 @@
 	dev->ib_dev.detach_mcast         = mthca_multicast_detach;
 	dev->ib_dev.process_mad          = mthca_process_mad;
 
-	if (dev->hca_type == ARBEL_NATIVE)
+	if (dev->hca_type == ARBEL_NATIVE) {
 		dev->ib_dev.req_notify_cq = mthca_arbel_arm_cq;
-	else
+		dev->ib_dev.post_send     = mthca_arbel_post_send;
+		dev->ib_dev.post_recv     = mthca_arbel_post_receive;
+	} else {
 		dev->ib_dev.req_notify_cq = mthca_tavor_arm_cq;
+		dev->ib_dev.post_send     = mthca_tavor_post_send;
+		dev->ib_dev.post_recv     = mthca_tavor_post_receive;
+	}
 
 	init_MUTEX(&dev->cap_mask_mutex);
 
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:01.713525620 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-03-03 14:13:02.567340285 -0800
@@ -253,6 +253,16 @@
 	u16 vcrc;
 };
 
+static const u8 mthca_opcode[] = {
+	[IB_WR_SEND]                 = MTHCA_OPCODE_SEND,
+	[IB_WR_SEND_WITH_IMM]        = MTHCA_OPCODE_SEND_IMM,
+	[IB_WR_RDMA_WRITE]           = MTHCA_OPCODE_RDMA_WRITE,
+	[IB_WR_RDMA_WRITE_WITH_IMM]  = MTHCA_OPCODE_RDMA_WRITE_IMM,
+	[IB_WR_RDMA_READ]            = MTHCA_OPCODE_RDMA_READ,
+	[IB_WR_ATOMIC_CMP_AND_SWP]   = MTHCA_OPCODE_ATOMIC_CS,
+	[IB_WR_ATOMIC_FETCH_AND_ADD] = MTHCA_OPCODE_ATOMIC_FA,
+};
+
 static int is_sqp(struct mthca_dev *dev, struct mthca_qp *qp)
 {
 	return qp->qpn >= dev->qp_table.sqp_start &&
@@ -637,9 +647,8 @@
 
 	if (qp->transport == MLX || qp->transport == UD)
 		qp_context->mtu_msgmax = (IB_MTU_2048 << 5) | 11;
-	else if (attr_mask & IB_QP_PATH_MTU) {
+	else if (attr_mask & IB_QP_PATH_MTU)
 		qp_context->mtu_msgmax = (attr->path_mtu << 5) | 31;
-	}
 
 	if (dev->hca_type == ARBEL_NATIVE) {
 		qp_context->rq_size_stride =
@@ -1385,8 +1394,8 @@
 	return 0;
 }
 
-int mthca_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
-		    struct ib_send_wr **bad_wr)
+int mthca_tavor_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+			  struct ib_send_wr **bad_wr)
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
@@ -1402,16 +1411,6 @@
 	int ind;
 	u8 op0 = 0;
 
-	static const u8 opcode[] = {
-		[IB_WR_SEND]                 = MTHCA_OPCODE_SEND,
-		[IB_WR_SEND_WITH_IMM]        = MTHCA_OPCODE_SEND_IMM,
-		[IB_WR_RDMA_WRITE]           = MTHCA_OPCODE_RDMA_WRITE,
-		[IB_WR_RDMA_WRITE_WITH_IMM]  = MTHCA_OPCODE_RDMA_WRITE_IMM,
-		[IB_WR_RDMA_READ]            = MTHCA_OPCODE_RDMA_READ,
-		[IB_WR_ATOMIC_CMP_AND_SWP]   = MTHCA_OPCODE_ATOMIC_CS,
-		[IB_WR_ATOMIC_FETCH_AND_ADD] = MTHCA_OPCODE_ATOMIC_FA,
-	};
-
 	spin_lock_irqsave(&qp->lock, flags);
 
 	/* XXX check that state is OK to post send */
@@ -1550,7 +1549,7 @@
 
 		qp->wrid[ind + qp->rq.max] = wr->wr_id;
 
-		if (wr->opcode >= ARRAY_SIZE(opcode)) {
+		if (wr->opcode >= ARRAY_SIZE(mthca_opcode)) {
 			mthca_err(dev, "opcode invalid\n");
 			err = -EINVAL;
 			*bad_wr = wr;
@@ -1561,15 +1560,15 @@
 			((struct mthca_next_seg *) prev_wqe)->nda_op =
 				cpu_to_be32(((ind << qp->sq.wqe_shift) +
 					     qp->send_wqe_offset) |
-					    opcode[wr->opcode]);
-			smp_wmb();
+					    mthca_opcode[wr->opcode]);
+			wmb();
 			((struct mthca_next_seg *) prev_wqe)->ee_nds =
 				cpu_to_be32((size0 ? 0 : MTHCA_NEXT_DBD) | size);
 		}
 
 		if (!size0) {
 			size0 = size;
-			op0   = opcode[wr->opcode];
+			op0   = mthca_opcode[wr->opcode];
 		}
 
 		++ind;
@@ -1578,7 +1577,7 @@
 	}
 
 out:
-	if (nreq) {
+	if (likely(nreq)) {
 		u32 doorbell[2];
 
 		doorbell[0] = cpu_to_be32(((qp->sq.next << qp->sq.wqe_shift) +
@@ -1599,8 +1598,8 @@
 	return err;
 }
 
-int mthca_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
-		       struct ib_recv_wr **bad_wr)
+int mthca_tavor_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+			     struct ib_recv_wr **bad_wr)
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
 	struct mthca_qp *qp = to_mqp(ibqp);
@@ -1621,7 +1620,7 @@
 	ind = qp->rq.next;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (qp->rq.cur + nreq >= qp->rq.max) {
+		if (unlikely(qp->rq.cur + nreq >= qp->rq.max)) {
 			mthca_err(dev, "RQ %06x full\n", qp->qpn);
 			err = -ENOMEM;
 			*bad_wr = wr;
@@ -1640,7 +1639,7 @@
 		wqe += sizeof (struct mthca_next_seg);
 		size = sizeof (struct mthca_next_seg) / 16;
 
-		if (wr->num_sge > qp->rq.max_gs) {
+		if (unlikely(wr->num_sge > qp->rq.max_gs)) {
 			err = -EINVAL;
 			*bad_wr = wr;
 			goto out;
@@ -1659,10 +1658,10 @@
 
 		qp->wrid[ind] = wr->wr_id;
 
-		if (prev_wqe) {
+		if (likely(prev_wqe)) {
 			((struct mthca_next_seg *) prev_wqe)->nda_op =
 				cpu_to_be32((ind << qp->rq.wqe_shift) | 1);
-			smp_wmb();
+			wmb();
 			((struct mthca_next_seg *) prev_wqe)->ee_nds =
 				cpu_to_be32(MTHCA_NEXT_DBD | size);
 		}
@@ -1676,7 +1675,7 @@
 	}
 
 out:
-	if (nreq) {
+	if (likely(nreq)) {
 		u32 doorbell[2];
 
 		doorbell[0] = cpu_to_be32((qp->rq.next << qp->rq.wqe_shift) | size0);
@@ -1696,6 +1695,247 @@
 	return err;
 }
 
+int mthca_arbel_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+			  struct ib_send_wr **bad_wr)
+{
+	struct mthca_dev *dev = to_mdev(ibqp->device);
+	struct mthca_qp *qp = to_mqp(ibqp);
+	void *wqe;
+	void *prev_wqe;
+	unsigned long flags;
+	int err = 0;
+	int nreq;
+	int i;
+	int size;
+	int size0 = 0;
+	u32 f0 = 0;
+	int ind;
+	u8 op0 = 0;
+
+	spin_lock_irqsave(&qp->lock, flags);
+
+	/* XXX check that state is OK to post send */
+
+	ind = qp->sq.next & (qp->sq.max - 1);
+
+	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (qp->sq.cur + nreq >= qp->sq.max) {
+			mthca_err(dev, "SQ full (%d posted, %d max, %d nreq)\n",
+				  qp->sq.cur, qp->sq.max, nreq);
+			err = -ENOMEM;
+			*bad_wr = wr;
+			goto out;
+		}
+
+		wqe = get_send_wqe(qp, ind);
+		prev_wqe = qp->sq.last;
+		qp->sq.last = wqe;
+
+		((struct mthca_next_seg *) wqe)->flags =
+			((wr->send_flags & IB_SEND_SIGNALED) ?
+			 cpu_to_be32(MTHCA_NEXT_CQ_UPDATE) : 0) |
+			((wr->send_flags & IB_SEND_SOLICITED) ?
+			 cpu_to_be32(MTHCA_NEXT_SOLICIT) : 0)   |
+			cpu_to_be32(1);
+		if (wr->opcode == IB_WR_SEND_WITH_IMM ||
+		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
+			((struct mthca_next_seg *) wqe)->flags = wr->imm_data;
+
+		wqe += sizeof (struct mthca_next_seg);
+		size = sizeof (struct mthca_next_seg) / 16;
+
+		switch (qp->transport) {
+		case UD:
+			memcpy(((struct mthca_arbel_ud_seg *) wqe)->av,
+			       to_mah(wr->wr.ud.ah)->av, MTHCA_AV_SIZE);
+			((struct mthca_arbel_ud_seg *) wqe)->dqpn =
+				cpu_to_be32(wr->wr.ud.remote_qpn);
+			((struct mthca_arbel_ud_seg *) wqe)->qkey =
+				cpu_to_be32(wr->wr.ud.remote_qkey);
+
+			wqe += sizeof (struct mthca_arbel_ud_seg);
+			size += sizeof (struct mthca_arbel_ud_seg) / 16;
+			break;
+
+		case MLX:
+			err = build_mlx_header(dev, to_msqp(qp), ind, wr,
+					       wqe - sizeof (struct mthca_next_seg),
+					       wqe);
+			if (err) {
+				*bad_wr = wr;
+				goto out;
+			}
+			wqe += sizeof (struct mthca_data_seg);
+			size += sizeof (struct mthca_data_seg) / 16;
+			break;
+		}
+
+		if (wr->num_sge > qp->sq.max_gs) {
+			mthca_err(dev, "too many gathers\n");
+			err = -EINVAL;
+			*bad_wr = wr;
+			goto out;
+		}
+
+		for (i = 0; i < wr->num_sge; ++i) {
+			((struct mthca_data_seg *) wqe)->byte_count =
+				cpu_to_be32(wr->sg_list[i].length);
+			((struct mthca_data_seg *) wqe)->lkey =
+				cpu_to_be32(wr->sg_list[i].lkey);
+			((struct mthca_data_seg *) wqe)->addr =
+				cpu_to_be64(wr->sg_list[i].addr);
+			wqe += sizeof (struct mthca_data_seg);
+			size += sizeof (struct mthca_data_seg) / 16;
+		}
+
+		/* Add one more inline data segment for ICRC */
+		if (qp->transport == MLX) {
+			((struct mthca_data_seg *) wqe)->byte_count =
+				cpu_to_be32((1 << 31) | 4);
+			((u32 *) wqe)[1] = 0;
+			wqe += sizeof (struct mthca_data_seg);
+			size += sizeof (struct mthca_data_seg) / 16;
+		}
+
+		qp->wrid[ind + qp->rq.max] = wr->wr_id;
+
+		if (wr->opcode >= ARRAY_SIZE(mthca_opcode)) {
+			mthca_err(dev, "opcode invalid\n");
+			err = -EINVAL;
+			*bad_wr = wr;
+			goto out;
+		}
+
+		if (likely(prev_wqe)) {
+			((struct mthca_next_seg *) prev_wqe)->nda_op =
+				cpu_to_be32(((ind << qp->sq.wqe_shift) +
+					     qp->send_wqe_offset) |
+					    mthca_opcode[wr->opcode]);
+			wmb();
+			((struct mthca_next_seg *) prev_wqe)->ee_nds =
+				cpu_to_be32(MTHCA_NEXT_DBD | size);
+		}
+
+		if (!size0) {
+			size0 = size;
+			op0   = mthca_opcode[wr->opcode];
+		}
+
+		++ind;
+		if (unlikely(ind >= qp->sq.max))
+			ind -= qp->sq.max;
+	}
+
+out:
+	if (likely(nreq)) {
+		u32 doorbell[2];
+
+		doorbell[0] = cpu_to_be32((nreq << 24)                  |
+					  ((qp->sq.next & 0xffff) << 8) |
+					  f0 | op0);
+		doorbell[1] = cpu_to_be32((qp->qpn << 8) | size0);
+
+		qp->sq.cur  += nreq;
+		qp->sq.next += nreq;
+
+		/*
+		 * Make sure that descriptors are written before
+		 * doorbell record.
+		 */
+		wmb();
+		*qp->sq.db = cpu_to_be32(qp->sq.next & 0xffff);
+
+		/*
+		 * Make sure doorbell record is written before we
+		 * write MMIO send doorbell.
+		 */
+		wmb();
+		mthca_write64(doorbell,
+			      dev->kar + MTHCA_SEND_DOORBELL,
+			      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
+	}
+
+	spin_unlock_irqrestore(&qp->lock, flags);
+	return err;
+}
+
+int mthca_arbel_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+			     struct ib_recv_wr **bad_wr)
+{
+	struct mthca_dev *dev = to_mdev(ibqp->device);
+	struct mthca_qp *qp = to_mqp(ibqp);
+	unsigned long flags;
+	int err = 0;
+	int nreq;
+	int ind;
+	int i;
+	void *wqe;
+
+	spin_lock_irqsave(&qp->lock, flags);
+
+	/* XXX check that state is OK to post receive */
+
+	ind = qp->rq.next & (qp->rq.max - 1);
+
+	for (nreq = 0; wr; ++nreq, wr = wr->next) {
+		if (unlikely(qp->rq.cur + nreq >= qp->rq.max)) {
+			mthca_err(dev, "RQ %06x full\n", qp->qpn);
+			err = -ENOMEM;
+			*bad_wr = wr;
+			goto out;
+		}
+
+		wqe = get_recv_wqe(qp, ind);
+
+		((struct mthca_next_seg *) wqe)->flags = 0;
+
+		wqe += sizeof (struct mthca_next_seg);
+
+		if (unlikely(wr->num_sge > qp->rq.max_gs)) {
+			err = -EINVAL;
+			*bad_wr = wr;
+			goto out;
+		}
+
+		for (i = 0; i < wr->num_sge; ++i) {
+			((struct mthca_data_seg *) wqe)->byte_count =
+				cpu_to_be32(wr->sg_list[i].length);
+			((struct mthca_data_seg *) wqe)->lkey =
+				cpu_to_be32(wr->sg_list[i].lkey);
+			((struct mthca_data_seg *) wqe)->addr =
+				cpu_to_be64(wr->sg_list[i].addr);
+			wqe += sizeof (struct mthca_data_seg);
+		}
+
+		if (i < qp->rq.max_gs) {
+			((struct mthca_data_seg *) wqe)->byte_count = 0;
+			((struct mthca_data_seg *) wqe)->lkey = cpu_to_be32(0x100);
+			((struct mthca_data_seg *) wqe)->addr = 0;
+		}
+
+		qp->wrid[ind] = wr->wr_id;
+
+		++ind;
+		if (unlikely(ind >= qp->rq.max))
+			ind -= qp->rq.max;
+	}
+out:
+	if (likely(nreq)) {
+		qp->rq.cur  += nreq;
+		qp->rq.next += nreq;
+
+		/*
+		 * Make sure that descriptors are written before
+		 * doorbell record.
+		 */
+		wmb();
+		*qp->rq.db = cpu_to_be32(qp->rq.next & 0xffff);
+	}
+
+	spin_unlock_irqrestore(&qp->lock, flags);
+	return err;
+}
+
 int mthca_free_err_wqe(struct mthca_dev *dev, struct mthca_qp *qp, int is_send,
 		       int index, int *dbd, u32 *new_wqe)
 {

