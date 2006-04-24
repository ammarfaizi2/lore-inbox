Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWDXV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWDXV0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWDXVXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:53 -0400
Received: from mx.pathscale.com ([64.160.42.68]:35523 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751289AbWDXVXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:42 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 13] ipath - fix a number of RC protocol bugs
X-Mercurial-Node: fafcc38877ad194f3a7ab4c1caabd6849641df8b
Message-Id: <fafcc38877ad194f3a7a.1145913784@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:04 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a number of RC protocol bugs:

1. ipath_init_restart() could be called when the QP is already on the
   timeout list, thus triggering a bad BUG_ON.
2. If a RDMA read was received on a QP without remote read access,
   the s_lock spin lock was reentered.
3. If a sequence NAK was received for a PSN for the middle of a
   pending operation, the code to compute which operation to restart
   had a bug so that the wrong opcode/PSN was resent.  This caused
   the RC connection to go into the error state.
4. If a RC connection was configured for shared receive queues (SRQ),
   the limit sequence number was not being handled correctly when
   RDMA reads, writes, or atomic operations were performed, thus causing
   the RC connection to hang.

Signed-off-by: Ralph Campbell <ralphc@pathscale.com>
Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ee2f95e99c27 -r fafcc38877ad drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Mon Apr 24 14:21:04 2006 -0700
@@ -57,9 +57,8 @@ static void ipath_init_restart(struct ip
 	qp->s_len = wqe->length - len;
 	dev = to_idev(qp->ibqp.device);
 	spin_lock(&dev->pending_lock);
-	if (qp->timerwait.next == LIST_POISON1)
-		list_add_tail(&qp->timerwait,
-			      &dev->pending[dev->pending_index]);
+	BUG_ON(qp->timerwait.next != LIST_POISON1);
+	list_add_tail(&qp->timerwait, &dev->pending[dev->pending_index]);
 	spin_unlock(&dev->pending_lock);
 }
 
@@ -135,7 +134,8 @@ static inline u32 ipath_make_rc_ack(stru
 		 */
 		qp->r_state = OP(RDMA_READ_RESPONSE_LAST);
 		qp->s_ack_state = OP(ACKNOWLEDGE);
-		return 0;
+		bth0 = 0;
+		goto bail;
 
 	case OP(COMPARE_SWAP):
 	case OP(FETCH_ADD):
@@ -143,7 +143,7 @@ static inline u32 ipath_make_rc_ack(stru
 		len = 0;
 		qp->r_state = OP(SEND_LAST);
 		qp->s_ack_state = OP(ACKNOWLEDGE);
-		bth0 = IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
+		bth0 = OP(ATOMIC_ACKNOWLEDGE) << 24;
 		ohdr->u.at.aeth = ipath_compute_aeth(qp);
 		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->s_ack_atomic);
 		hwords += sizeof(ohdr->u.at) / 4;
@@ -162,6 +162,7 @@ static inline u32 ipath_make_rc_ack(stru
 	qp->s_cur_sge = ss;
 	qp->s_cur_size = len;
 
+bail:
 	return bth0;
 }
 
@@ -257,7 +258,7 @@ static inline int ipath_make_rc_req(stru
 			break;
 
 		case IB_WR_RDMA_WRITE:
-			if (newreq)
+			if (newreq && qp->s_lsn != (u32) -1)
 				qp->s_lsn++;
 			/* FALLTHROUGH */
 		case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -283,8 +284,7 @@ static inline int ipath_make_rc_req(stru
 			else {
 				qp->s_state =
 					OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE);
-				/* Immediate data comes
-				 * after RETH */
+				/* Immediate data comes after RETH */
 				ohdr->u.rc.imm_data = wqe->wr.imm_data;
 				hwords += 1;
 				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
@@ -304,7 +304,8 @@ static inline int ipath_make_rc_req(stru
 			qp->s_state = OP(RDMA_READ_REQUEST);
 			hwords += sizeof(ohdr->u.rc.reth) / 4;
 			if (newreq) {
-				qp->s_lsn++;
+				if (qp->s_lsn != (u32) -1)
+					qp->s_lsn++;
 				/*
 				 * Adjust s_next_psn to count the
 				 * expected number of responses.
@@ -335,7 +336,8 @@ static inline int ipath_make_rc_req(stru
 				wqe->wr.wr.atomic.compare_add);
 			hwords += sizeof(struct ib_atomic_eth) / 4;
 			if (newreq) {
-				qp->s_lsn++;
+				if (qp->s_lsn != (u32) -1)
+					qp->s_lsn++;
 				wqe->lpsn = wqe->psn;
 			}
 			if (++qp->s_cur == qp->s_size)
@@ -355,6 +357,11 @@ static inline int ipath_make_rc_req(stru
 		bth2 |= qp->s_psn++ & IPS_PSN_MASK;
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
+		/*
+		 * Put the QP on the pending list so lost ACKs will cause
+		 * a retry.  More than one request can be pending so the
+		 * QP may already be on the dev->pending list.
+		 */
 		spin_lock(&dev->pending_lock);
 		if (qp->timerwait.next == LIST_POISON1)
 			list_add_tail(&qp->timerwait,
@@ -364,8 +371,8 @@ static inline int ipath_make_rc_req(stru
 
 	case OP(RDMA_READ_RESPONSE_FIRST):
 		/*
-		 * This case can only happen if a send is restarted.  See
-		 * ipath_restart_rc().
+		 * This case can only happen if a send is restarted.
+		 * See ipath_restart_rc().
 		 */
 		ipath_init_restart(qp, wqe);
 		/* FALLTHROUGH */
@@ -496,29 +503,37 @@ done:
 	return 0;
 }
 
-static inline void ipath_make_rc_grh(struct ipath_qp *qp,
-				     struct ib_global_route *grh,
-				     u32 nwords)
+/**
+ * ipath_make_rc_grh - construct a GRH header
+ * @dev: a pointer to the ipath device
+ * @hdr: a pointer to the GRH header being constructed
+ * @grh: the global route address to send to
+ * @hwords: the number of 32 bit words of header being sent
+ * @nwords: the number of 32 bit words of data being sent
+ *
+ * Return the size of the header in 32 bit words.
+ */
+static u32 ipath_make_rc_grh(struct ipath_ibdev *dev,
+			     struct ib_grh *hdr,
+			     struct ib_global_route *grh,
+			     u32 hwords,
+			     u32 nwords)
 {
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
-
-	/* GRH header size in 32-bit words. */
-	qp->s_hdrwords += 10;
-	qp->s_hdr.u.l.grh.version_tclass_flow =
+	hdr->version_tclass_flow =
 		cpu_to_be32((6 << 28) |
 			    (grh->traffic_class << 20) |
 			    grh->flow_label);
-	qp->s_hdr.u.l.grh.paylen =
-		cpu_to_be16(((qp->s_hdrwords - 12) + nwords +
-			     SIZE_OF_CRC) << 2);
+	hdr->paylen = cpu_to_be16((hwords - 2 + nwords + SIZE_OF_CRC) << 2);
 	/* next_hdr is defined by C8-7 in ch. 8.4.1 */
-	qp->s_hdr.u.l.grh.next_hdr = 0x1B;
-	qp->s_hdr.u.l.grh.hop_limit = grh->hop_limit;
+	hdr->next_hdr = 0x1B;
+	hdr->hop_limit = grh->hop_limit;
 	/* The SGID is 32-bit aligned. */
-	qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
-	qp->s_hdr.u.l.grh.sgid.global.interface_id =
-		ipath_layer_get_guid(dev->dd);
-	qp->s_hdr.u.l.grh.dgid = grh->dgid;
+	hdr->sgid.global.subnet_prefix = dev->gid_prefix;
+	hdr->sgid.global.interface_id = ipath_layer_get_guid(dev->dd);
+	hdr->dgid = grh->dgid;
+
+	/* GRH header size in 32-bit words. */
+	return sizeof(struct ib_grh) / sizeof(u32);
 }
 
 /**
@@ -569,15 +584,6 @@ again:
 		 * If no PIO bufs are available, return.  An interrupt will
 		 * call ipath_ib_piobufavail() when one is available.
 		 */
-		_VERBS_INFO("h %u %p\n", qp->s_hdrwords, &qp->s_hdr);
-		_VERBS_INFO("d %u %p %u %p %u %u %u %u\n", qp->s_cur_size,
-			    qp->s_cur_sge->sg_list,
-			    qp->s_cur_sge->num_sge,
-			    qp->s_cur_sge->sge.vaddr,
-			    qp->s_cur_sge->sge.sge_length,
-			    qp->s_cur_sge->sge.length,
-			    qp->s_cur_sge->sge.m,
-			    qp->s_cur_sge->sge.n);
 		if (ipath_verbs_send(dev->dd, qp->s_hdrwords,
 				     (u32 *) &qp->s_hdr, qp->s_cur_size,
 				     qp->s_cur_sge)) {
@@ -599,8 +605,16 @@ again:
 	if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
 	    (bth0 = ipath_make_rc_ack(qp, ohdr, pmtu)) != 0)
 		bth2 = qp->s_ack_psn++ & IPS_PSN_MASK;
-	else if (!ipath_make_rc_req(qp, ohdr, pmtu, &bth0, &bth2))
-		goto done;
+	else if (!ipath_make_rc_req(qp, ohdr, pmtu, &bth0, &bth2)) {
+		/*
+		 * Clear the busy bit before unlocking to avoid races with
+		 * adding new work queue items and then failing to process
+		 * them.
+		 */
+		clear_bit(IPATH_S_BUSY, &qp->s_flags);
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		goto bail;
+	}
 
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 
@@ -609,7 +623,9 @@ again:
 	nwords = (qp->s_cur_size + extra_bytes) >> 2;
 	lrh0 = IPS_LRH_BTH;
 	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
-		ipath_make_rc_grh(qp, &qp->remote_ah_attr.grh, nwords);
+		qp->s_hdrwords += ipath_make_rc_grh(dev, &qp->s_hdr.u.l.grh,
+						    &qp->remote_ah_attr.grh,
+						    qp->s_hdrwords, nwords);
 		lrh0 = IPS_LRH_GRH;
 	}
 	lrh0 |= qp->remote_ah_attr.sl << 4;
@@ -627,8 +643,6 @@ again:
 	/* Check for more work to do. */
 	goto again;
 
-done:
-	spin_unlock_irqrestore(&qp->s_lock, flags);
 clear:
 	clear_bit(IPATH_S_BUSY, &qp->s_flags);
 bail:
@@ -640,32 +654,35 @@ static void send_rc_ack(struct ipath_qp 
 	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	u16 lrh0;
 	u32 bth0;
+	u32 hwords;
+	struct ipath_ib_header hdr;
 	struct ipath_other_headers *ohdr;
 
 	/* Construct the header. */
-	ohdr = &qp->s_hdr.u.oth;
+	ohdr = &hdr.u.oth;
 	lrh0 = IPS_LRH_BTH;
 	/* header size in 32-bit words LRH+BTH+AETH = (8+12+4)/4. */
-	qp->s_hdrwords = 6;
+	hwords = 6;
 	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
-		ipath_make_rc_grh(qp, &qp->remote_ah_attr.grh, 0);
+		hwords += ipath_make_rc_grh(dev, &hdr.u.l.grh,
+					    &qp->remote_ah_attr.grh,
+					    hwords, 0);
 		ohdr = &qp->s_hdr.u.l.oth;
 		lrh0 = IPS_LRH_GRH;
 	}
 	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
 	ohdr->u.aeth = ipath_compute_aeth(qp);
 	if (qp->s_ack_state >= OP(COMPARE_SWAP)) {
-		bth0 |= IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
+		bth0 |= OP(ATOMIC_ACKNOWLEDGE) << 24;
 		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->s_ack_atomic);
-		qp->s_hdrwords += sizeof(ohdr->u.at.atomic_ack_eth) / 4;
-	}
-	else
+		hwords += sizeof(ohdr->u.at.atomic_ack_eth) / 4;
+	} else
 		bth0 |= OP(ACKNOWLEDGE) << 24;
 	lrh0 |= qp->remote_ah_attr.sl << 4;
-	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
-	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
-	qp->s_hdr.lrh[2] = cpu_to_be16(qp->s_hdrwords + SIZE_OF_CRC);
-	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
+	hdr.lrh[0] = cpu_to_be16(lrh0);
+	hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
+	hdr.lrh[2] = cpu_to_be16(hwords + SIZE_OF_CRC);
+	hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
 	ohdr->bth[2] = cpu_to_be32(qp->s_ack_psn & IPS_PSN_MASK);
@@ -673,12 +690,93 @@ static void send_rc_ack(struct ipath_qp 
 	/*
 	 * If we can send the ACK, clear the ACK state.
 	 */
-	if (ipath_verbs_send(dev->dd, qp->s_hdrwords, (u32 *) &qp->s_hdr,
-			     0, NULL) == 0) {
+	if (ipath_verbs_send(dev->dd, hwords, (u32 *) &hdr, 0, NULL) == 0) {
 		qp->s_ack_state = OP(ACKNOWLEDGE);
+		dev->n_unicast_xmit++;
+	} else
 		dev->n_rc_qacks++;
-		dev->n_unicast_xmit++;
-	}
+}
+
+/**
+ * reset_psn - reset the QP state to send starting from PSN
+ * @qp: the QP
+ * @psn: the packet sequence number to restart at
+ *
+ * This is called from ipath_rc_rcv() to process an incoming RC ACK
+ * for the given QP.
+ * Called at interrupt level with the QP s_lock held.
+ */
+static void reset_psn(struct ipath_qp *qp, u32 psn)
+{
+	u32 n = qp->s_last;
+	struct ipath_swqe *wqe = get_swqe_ptr(qp, n);
+	u32 opcode;
+
+	qp->s_cur = n;
+
+	/*
+	 * If we are starting the request from the beginning,
+	 * let the normal send code handle initialization.
+	 */
+	if (ipath_cmp24(psn, wqe->psn) <= 0) {
+		qp->s_state = OP(SEND_LAST);
+		goto done;
+	}
+
+	/* Find the work request opcode corresponding to the given PSN. */
+	opcode = wqe->wr.opcode;
+	for (;;) {
+		int diff;
+
+		if (++n == qp->s_size)
+			n = 0;
+		if (n == qp->s_tail)
+			break;
+		wqe = get_swqe_ptr(qp, n);
+		diff = ipath_cmp24(psn, wqe->psn);
+		if (diff < 0)
+			break;
+		qp->s_cur = n;
+		/*
+		 * If we are starting the request from the beginning,
+		 * let the normal send code handle initialization.
+		 */
+		if (diff == 0) {
+			qp->s_state = OP(SEND_LAST);
+			goto done;
+		}
+		opcode = wqe->wr.opcode;
+	}
+
+	/*
+	 * Set the state to restart in the middle of a request.
+	 * Don't change the s_sge, s_cur_sge, or s_cur_size.
+	 * See ipath_do_rc_send().
+	 */
+	switch (opcode) {
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+		qp->s_state = OP(RDMA_READ_RESPONSE_FIRST);
+		break;
+
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		qp->s_state = OP(RDMA_READ_RESPONSE_LAST);
+		break;
+
+	case IB_WR_RDMA_READ:
+		qp->s_state = OP(RDMA_READ_RESPONSE_MIDDLE);
+		break;
+
+	default:
+		/*
+		 * This case shouldn't happen since its only
+		 * one PSN per req.
+		 */
+		qp->s_state = OP(SEND_LAST);
+	}
+done:
+	qp->s_psn = psn;
 }
 
 /**
@@ -693,7 +791,6 @@ void ipath_restart_rc(struct ipath_qp *q
 {
 	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
 	struct ipath_ibdev *dev;
-	u32 n;
 
 	/*
 	 * If there are no requests pending, we are done.
@@ -735,130 +832,13 @@ void ipath_restart_rc(struct ipath_qp *q
 	else
 		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
 
-	/*
-	 * If we are starting the request from the beginning, let the normal
-	 * send code handle initialization.
-	 */
-	qp->s_cur = qp->s_last;
-	if (ipath_cmp24(psn, wqe->psn) <= 0) {
-		qp->s_state = OP(SEND_LAST);
-		qp->s_psn = wqe->psn;
-	} else {
-		n = qp->s_cur;
-		for (;;) {
-			if (++n == qp->s_size)
-				n = 0;
-			if (n == qp->s_tail) {
-				if (ipath_cmp24(psn, qp->s_next_psn) >= 0) {
-					qp->s_cur = n;
-					wqe = get_swqe_ptr(qp, n);
-				}
-				break;
-			}
-			wqe = get_swqe_ptr(qp, n);
-			if (ipath_cmp24(psn, wqe->psn) < 0)
-				break;
-			qp->s_cur = n;
-		}
-		qp->s_psn = psn;
-
-		/*
-		 * Reset the state to restart in the middle of a request.
-		 * Don't change the s_sge, s_cur_sge, or s_cur_size.
-		 * See ipath_do_rc_send().
-		 */
-		switch (wqe->wr.opcode) {
-		case IB_WR_SEND:
-		case IB_WR_SEND_WITH_IMM:
-			qp->s_state = OP(RDMA_READ_RESPONSE_FIRST);
-			break;
-
-		case IB_WR_RDMA_WRITE:
-		case IB_WR_RDMA_WRITE_WITH_IMM:
-			qp->s_state = OP(RDMA_READ_RESPONSE_LAST);
-			break;
-
-		case IB_WR_RDMA_READ:
-			qp->s_state =
-				OP(RDMA_READ_RESPONSE_MIDDLE);
-			break;
-
-		default:
-			/*
-			 * This case shouldn't happen since its only
-			 * one PSN per req.
-			 */
-			qp->s_state = OP(SEND_LAST);
-		}
-	}
+	reset_psn(qp, psn);
 
 done:
 	tasklet_hi_schedule(&qp->s_task);
 
 bail:
 	return;
-}
-
-/**
- * reset_psn - reset the QP state to send starting from PSN
- * @qp: the QP
- * @psn: the packet sequence number to restart at
- *
- * This is called from ipath_rc_rcv() to process an incoming RC ACK
- * for the given QP.
- * Called at interrupt level with the QP s_lock held.
- */
-static void reset_psn(struct ipath_qp *qp, u32 psn)
-{
-	struct ipath_swqe *wqe;
-	u32 n;
-
-	n = qp->s_cur;
-	wqe = get_swqe_ptr(qp, n);
-	for (;;) {
-		if (++n == qp->s_size)
-			n = 0;
-		if (n == qp->s_tail) {
-			if (ipath_cmp24(psn, qp->s_next_psn) >= 0) {
-				qp->s_cur = n;
-				wqe = get_swqe_ptr(qp, n);
-			}
-			break;
-		}
-		wqe = get_swqe_ptr(qp, n);
-		if (ipath_cmp24(psn, wqe->psn) < 0)
-			break;
-		qp->s_cur = n;
-	}
-	qp->s_psn = psn;
-
-	/*
-	 * Set the state to restart in the middle of a
-	 * request.  Don't change the s_sge, s_cur_sge, or
-	 * s_cur_size.  See ipath_do_rc_send().
-	 */
-	switch (wqe->wr.opcode) {
-	case IB_WR_SEND:
-	case IB_WR_SEND_WITH_IMM:
-		qp->s_state = OP(RDMA_READ_RESPONSE_FIRST);
-		break;
-
-	case IB_WR_RDMA_WRITE:
-	case IB_WR_RDMA_WRITE_WITH_IMM:
-		qp->s_state = OP(RDMA_READ_RESPONSE_LAST);
-		break;
-
-	case IB_WR_RDMA_READ:
-		qp->s_state = OP(RDMA_READ_RESPONSE_MIDDLE);
-		break;
-
-	default:
-		/*
-		 * This case shouldn't happen since its only
-		 * one PSN per req.
-		 */
-		qp->s_state = OP(SEND_LAST);
-	}
 }
 
 /**
@@ -1011,17 +991,7 @@ static int do_rc_ack(struct ipath_qp *qp
 
 		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
 
-		/*
-		 * If we are starting the request from the beginning, let
-		 * the normal send code handle initialization.
-		 */
-		qp->s_cur = qp->s_last;
-		wqe = get_swqe_ptr(qp, qp->s_cur);
-		if (ipath_cmp24(psn, wqe->psn) <= 0) {
-			qp->s_state = OP(SEND_LAST);
-			qp->s_psn = wqe->psn;
-		} else
-			reset_psn(qp, psn);
+		reset_psn(qp, psn);
 
 		qp->s_rnr_timeout =
 			ib_ipath_rnr_table[(aeth >> IPS_AETH_CREDIT_SHIFT) &
@@ -1182,33 +1152,34 @@ static inline void ipath_rc_rcv_resp(str
 			goto ack_done;
 		}
 	rdma_read:
-	if (unlikely(qp->s_state != OP(RDMA_READ_REQUEST)))
-		goto ack_done;
-	if (unlikely(tlen != (hdrsize + pmtu + 4)))
-		goto ack_done;
-	if (unlikely(pmtu >= qp->s_len))
-		goto ack_done;
-	/* We got a response so update the timeout. */
-	if (unlikely(qp->s_last == qp->s_tail ||
-		     get_swqe_ptr(qp, qp->s_last)->wr.opcode !=
-		     IB_WR_RDMA_READ))
-		goto ack_done;
-	spin_lock(&dev->pending_lock);
-	if (qp->s_rnr_timeout == 0 &&
-	    qp->timerwait.next != LIST_POISON1)
-		list_move_tail(&qp->timerwait,
-			       &dev->pending[dev->pending_index]);
-	spin_unlock(&dev->pending_lock);
-	/*
-	 * Update the RDMA receive state but do the copy w/o holding the
-	 * locks and blocking interrupts.  XXX Yet another place that
-	 * affects relaxed RDMA order since we don't want s_sge modified.
-	 */
-	qp->s_len -= pmtu;
-	qp->s_last_psn = psn;
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-	ipath_copy_sge(&qp->s_sge, data, pmtu);
-	goto bail;
+		if (unlikely(qp->s_state != OP(RDMA_READ_REQUEST)))
+			goto ack_done;
+		if (unlikely(tlen != (hdrsize + pmtu + 4)))
+			goto ack_done;
+		if (unlikely(pmtu >= qp->s_len))
+			goto ack_done;
+		/* We got a response so update the timeout. */
+		if (unlikely(qp->s_last == qp->s_tail ||
+			     get_swqe_ptr(qp, qp->s_last)->wr.opcode !=
+			     IB_WR_RDMA_READ))
+			goto ack_done;
+		spin_lock(&dev->pending_lock);
+		if (qp->s_rnr_timeout == 0 &&
+		    qp->timerwait.next != LIST_POISON1)
+			list_move_tail(&qp->timerwait,
+				       &dev->pending[dev->pending_index]);
+		spin_unlock(&dev->pending_lock);
+		/*
+		 * Update the RDMA receive state but do the copy w/o
+		 * holding the locks and blocking interrupts.
+		 * XXX Yet another place that affects relaxed RDMA order
+		 * since we don't want s_sge modified.
+		 */
+		qp->s_len -= pmtu;
+		qp->s_last_psn = psn;
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		ipath_copy_sge(&qp->s_sge, data, pmtu);
+		goto bail;
 
 	case OP(RDMA_READ_RESPONSE_LAST):
 		/* ACKs READ req. */
@@ -1255,9 +1226,12 @@ static inline void ipath_rc_rcv_resp(str
 		if (do_rc_ack(qp, aeth, psn, OP(RDMA_READ_RESPONSE_LAST))) {
 			/*
 			 * Change the state so we contimue
-			 * processing new requests.
+			 * processing new requests and wake up the
+			 * tasklet if there are posted sends.
 			 */
 			qp->s_state = OP(SEND_LAST);
+			if (qp->s_tail != qp->s_head)
+				tasklet_hi_schedule(&qp->s_task);
 		}
 		goto ack_done;
 	}
@@ -1296,6 +1270,8 @@ static inline int ipath_rc_rcv_error(str
 {
 	struct ib_reth *reth;
 
+	spin_lock(&qp->s_lock);
+
 	if (diff > 0) {
 		/*
 		 * Packet sequence error.
@@ -1303,13 +1279,10 @@ static inline int ipath_rc_rcv_error(str
 		 * Don't queue the NAK if a RDMA read, atomic, or
 		 * NAK is pending though.
 		 */
-		spin_lock(&qp->s_lock);
 		if ((qp->s_ack_state >= OP(RDMA_READ_REQUEST) &&
-		     qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) ||
-		    qp->s_nak_state != 0) {
-			spin_unlock(&qp->s_lock);
+		     qp->s_ack_state != OP(ACKNOWLEDGE)) ||
+		    qp->s_nak_state != 0)
 			goto done;
-		}
 		qp->s_ack_state = OP(SEND_ONLY);
 		qp->s_nak_state = IB_NAK_PSN_ERROR;
 		/* Use the expected PSN. */
@@ -1328,12 +1301,10 @@ static inline int ipath_rc_rcv_error(str
 	 * send the earliest so that RDMA reads can be restarted at
 	 * the requester's expected PSN.
 	 */
-	spin_lock(&qp->s_lock);
-	if (qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE &&
+	if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
 	    ipath_cmp24(psn, qp->s_ack_psn) >= 0) {
-		if (qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST)
+		if (qp->s_ack_state < OP(RDMA_READ_REQUEST))
 			qp->s_ack_psn = psn;
-		spin_unlock(&qp->s_lock);
 		goto done;
 	}
 	switch (opcode) {
@@ -1344,8 +1315,7 @@ static inline int ipath_rc_rcv_error(str
 		 * holding the s_lock.
 		 */
 		if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
-		    qp->s_ack_state >= IB_OPCODE_RDMA_READ_REQUEST) {
-			spin_unlock(&qp->s_lock);
+		    qp->s_ack_state >= OP(RDMA_READ_REQUEST)) {
 			dev->n_rdma_dup_busy++;
 			goto done;
 		}
@@ -1387,10 +1357,8 @@ static inline int ipath_rc_rcv_error(str
 		 * Check for the PSN of the last atomic operations
 		 * performed and resend the result if found.
 		 */
-		if ((psn & IPS_PSN_MASK) != qp->r_atomic_psn) {
-			spin_unlock(&qp->s_lock);
+		if ((psn & IPS_PSN_MASK) != qp->r_atomic_psn)
 			goto done;
-		}
 		qp->s_ack_atomic = qp->r_atomic_data;
 		break;
 	}
@@ -1401,6 +1369,7 @@ resched:
 	return 0;
 
 done:
+	spin_unlock(&qp->s_lock);
 	return 1;
 }
 
@@ -1493,22 +1462,23 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		    opcode == OP(SEND_LAST_WITH_IMMEDIATE))
 			break;
 	nack_inv:
-	/*
-	 * A NAK will ACK earlier sends and RDMA writes.  Don't queue the
-	 * NAK if a RDMA read, atomic, or NAK is pending though.
-	 */
-	spin_lock(&qp->s_lock);
-	if (qp->s_ack_state >= OP(RDMA_READ_REQUEST) &&
-	    qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) {
-		spin_unlock(&qp->s_lock);
-		goto done;
-	}
-	/* XXX Flush WQEs */
-	qp->state = IB_QPS_ERR;
-	qp->s_ack_state = OP(SEND_ONLY);
-	qp->s_nak_state = IB_NAK_INVALID_REQUEST;
-	qp->s_ack_psn = qp->r_psn;
-	goto resched;
+		/*
+		 * A NAK will ACK earlier sends and RDMA writes.
+		 * Don't queue the NAK if a RDMA read, atomic, or NAK
+		 * is pending though.
+		 */
+		spin_lock(&qp->s_lock);
+		if (qp->s_ack_state >= OP(RDMA_READ_REQUEST) &&
+		    qp->s_ack_state != OP(ACKNOWLEDGE)) {
+			spin_unlock(&qp->s_lock);
+			goto done;
+		}
+		/* XXX Flush WQEs */
+		qp->state = IB_QPS_ERR;
+		qp->s_ack_state = OP(SEND_ONLY);
+		qp->s_nak_state = IB_NAK_INVALID_REQUEST;
+		qp->s_ack_psn = qp->r_psn;
+		goto resched;
 
 	case OP(RDMA_WRITE_FIRST):
 	case OP(RDMA_WRITE_MIDDLE):
@@ -1557,9 +1527,8 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			 * is pending though.
 			 */
 			spin_lock(&qp->s_lock);
-			if (qp->s_ack_state >=
-			    OP(RDMA_READ_REQUEST) &&
-			    qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) {
+			if (qp->s_ack_state >= OP(RDMA_READ_REQUEST) &&
+			    qp->s_ack_state != OP(ACKNOWLEDGE)) {
 				spin_unlock(&qp->s_lock);
 				goto done;
 			}
@@ -1675,10 +1644,10 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 				 * read, atomic, or NAK is pending though.
 				 */
 				spin_lock(&qp->s_lock);
+			nack_acc1:
 				if (qp->s_ack_state >=
 				    OP(RDMA_READ_REQUEST) &&
-				    qp->s_ack_state !=
-				    IB_OPCODE_ACKNOWLEDGE) {
+				    qp->s_ack_state != OP(ACKNOWLEDGE)) {
 					spin_unlock(&qp->s_lock);
 					goto done;
 				}
@@ -1716,9 +1685,16 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			reth = (struct ib_reth *)data;
 			data += sizeof(*reth);
 		}
+		if (unlikely(!(qp->qp_access_flags &
+			       IB_ACCESS_REMOTE_READ)))
+			goto nack_acc;
+		/*
+		 * Ignore request if we already have an
+		 * RDMA read or ATOMIC pending.
+		 */
 		spin_lock(&qp->s_lock);
 		if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
-		    qp->s_ack_state >= IB_OPCODE_RDMA_READ_REQUEST) {
+		    qp->s_ack_state >= OP(RDMA_READ_REQUEST)) {
 			spin_unlock(&qp->s_lock);
 			goto done;
 		}
@@ -1732,10 +1708,8 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			ok = ipath_rkey_ok(dev, &qp->s_rdma_sge,
 					   qp->s_rdma_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_READ);
-			if (unlikely(!ok)) {
-				spin_unlock(&qp->s_lock);
-				goto nack_acc;
-			}
+			if (unlikely(!ok))
+				goto nack_acc1;
 			/*
 			 * Update the next expected PSN.  We add 1 later
 			 * below, so only add the remainder here.
@@ -1750,9 +1724,6 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			qp->s_rdma_sge.sge.length = 0;
 			qp->s_rdma_sge.sge.sge_length = 0;
 		}
-		if (unlikely(!(qp->qp_access_flags &
-			       IB_ACCESS_REMOTE_READ)))
-			goto nack_acc;
 		/*
 		 * We need to increment the MSN here instead of when we
 		 * finish sending the result since a duplicate request would
@@ -1822,7 +1793,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		 */
 		spin_lock(&qp->s_lock);
 		if (qp->s_ack_state == OP(ACKNOWLEDGE) ||
-		    qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST) {
+		    qp->s_ack_state < OP(RDMA_READ_REQUEST)) {
 			qp->s_ack_state = opcode;
 			qp->s_nak_state = 0;
 			qp->s_ack_psn = psn;
@@ -1844,6 +1815,8 @@ resched:
 	    (qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST ||
 	     qp->s_ack_state >= IB_OPCODE_COMPARE_SWAP))
 		send_rc_ack(qp);
+	else
+		dev->n_rc_qacks++;
 
 rdmadone:
 	spin_unlock(&qp->s_lock);
