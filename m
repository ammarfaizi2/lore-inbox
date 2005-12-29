Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVL2AkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVL2AkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVL2Ajv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:51 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52712 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964937AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 20] path - infiniband verbs support, part 2 of 3
X-Mercurial-Node: fc067af322a1816facf1d8bf41b45d78596794a6
Message-Id: <fc067af322a1816facf1.1135816295@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:35 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 471b7a7a005c -r fc067af322a1 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Dec 28 14:19:43 2005 -0800
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Wed Dec 28 14:19:43 2005 -0800
@@ -2305,3 +2305,2513 @@
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 	clear_bit(IPATH_S_BUSY, &qp->s_flags);
 }
+
+static void send_rc_ack(struct ipath_qp *qp)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	u16 lrh0;
+	u32 bth0;
+	u32 hwords;
+	struct ipath_other_headers *ohdr;
+
+	/* Construct the header. */
+	ohdr = &qp->s_hdr.u.oth;
+	lrh0 = IPS_LRH_BTH;
+	/* header size in 32-bit words LRH+BTH+AETH = (8+12+4)/4. */
+	hwords = 6;
+	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
+		ohdr = &qp->s_hdr.u.l.oth;
+		/* Header size in 32-bit words. */
+		hwords += 10;
+		lrh0 = IPS_LRH_GRH;
+		qp->s_hdr.u.l.grh.version_tclass_flow =
+		    cpu_to_be32((6 << 28) |
+				(qp->remote_ah_attr.grh.traffic_class << 20) |
+				qp->remote_ah_attr.grh.flow_label);
+		qp->s_hdr.u.l.grh.paylen =
+		    cpu_to_be16(((hwords - 12) + SIZE_OF_CRC) << 2);
+		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
+		qp->s_hdr.u.l.grh.hop_limit = qp->remote_ah_attr.grh.hop_limit;
+		/* The SGID is 32-bit aligned. */
+		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
+		qp->s_hdr.u.l.grh.sgid.global.interface_id =
+		    ipath_layer_get_guid(dev->ib_unit);
+		qp->s_hdr.u.l.grh.dgid = qp->remote_ah_attr.grh.dgid;
+	}
+	bth0 = ipath_layer_get_pkey(dev->ib_unit, qp->s_pkey_index);
+	ohdr->u.aeth = ipath_compute_aeth(qp);
+	if (qp->s_ack_state >= IB_OPCODE_RC_COMPARE_SWAP) {
+		bth0 |= IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
+		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->s_ack_atomic);
+		hwords += sizeof(ohdr->u.at.atomic_ack_eth) / 4;
+	} else {
+		bth0 |= IB_OPCODE_RC_ACKNOWLEDGE << 24;
+	}
+	lrh0 |= qp->remote_ah_attr.sl << 4;
+	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
+	/* DEST LID */
+	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
+	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + SIZE_OF_CRC);
+	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->ib_unit));
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
+	ohdr->bth[2] = cpu_to_be32(qp->s_ack_psn & 0xFFFFFF);
+
+	/*
+	 * If we can send the ACK, clear the ACK state.
+	 */
+	if (ipath_verbs_send(dev->ib_unit, hwords, (uint32_t *) &qp->s_hdr,
+			     0, NULL) == 0) {
+		qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
+		dev->n_rc_qacks++;
+		dev->n_unicast_xmit++;
+	}
+}
+
+/*
+ * Back up the requester to resend the last un-ACKed request.
+ * The QP s_lock should be held.
+ */
+static void ipath_restart_rc(struct ipath_qp *qp, u32 psn, struct ib_wc *wc)
+{
+	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
+	struct ipath_ibdev *dev;
+	u32 n;
+
+	/*
+	 * If there are no requests pending, we are done.
+	 */
+	if (cmp24(psn, qp->s_next_psn) >= 0 || qp->s_last == qp->s_tail)
+		goto done;
+
+	if (qp->s_retry == 0) {
+		wc->wr_id = wqe->wr.wr_id;
+		wc->status = IB_WC_RETRY_EXC_ERR;
+		wc->opcode = wc_opcode[wqe->wr.opcode];
+		wc->vendor_err = 0;
+		wc->byte_len = 0;
+		wc->qp_num = qp->ibqp.qp_num;
+		wc->src_qp = qp->remote_qpn;
+		wc->pkey_index = 0;
+		wc->slid = qp->remote_ah_attr.dlid;
+		wc->sl = qp->remote_ah_attr.sl;
+		wc->dlid_path_bits = 0;
+		wc->port_num = 0;
+		ipath_sqerror_qp(qp, wc);
+		return;
+	}
+	qp->s_retry--;
+
+	/*
+	 * Remove the QP from the timeout queue.
+	 * Note: it may already have been removed by ipath_ib_timer().
+	 */
+	dev = to_idev(qp->ibqp.device);
+	spin_lock(&dev->pending_lock);
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	spin_unlock(&dev->pending_lock);
+
+	if (wqe->wr.opcode == IB_WR_RDMA_READ)
+		dev->n_rc_resends++;
+	else
+		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
+
+	/*
+	 * If we are starting the request from the beginning, let the
+	 * normal send code handle initialization.
+	 */
+	qp->s_cur = qp->s_last;
+	if (cmp24(psn, wqe->psn) <= 0) {
+		qp->s_state = IB_OPCODE_RC_SEND_LAST;
+		qp->s_psn = wqe->psn;
+	} else {
+		n = qp->s_cur;
+		for (;;) {
+			if (++n == qp->s_size)
+				n = 0;
+			if (n == qp->s_tail) {
+				if (cmp24(psn, qp->s_next_psn) >= 0) {
+					qp->s_cur = n;
+					wqe = get_swqe_ptr(qp, n);
+				}
+				break;
+			}
+			wqe = get_swqe_ptr(qp, n);
+			if (cmp24(psn, wqe->psn) < 0)
+				break;
+			qp->s_cur = n;
+		}
+		qp->s_psn = psn;
+
+		/*
+		 * Reset the state to restart in the middle of a request.
+		 * Don't change the s_sge, s_cur_sge, or s_cur_size.
+		 * See do_rc_send().
+		 */
+		switch (wqe->wr.opcode) {
+		case IB_WR_SEND:
+		case IB_WR_SEND_WITH_IMM:
+			qp->s_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
+			break;
+
+		case IB_WR_RDMA_WRITE:
+		case IB_WR_RDMA_WRITE_WITH_IMM:
+			qp->s_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
+			break;
+
+		case IB_WR_RDMA_READ:
+			qp->s_state = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
+			break;
+
+		default:
+			/*
+			 * This case shouldn't happen since its only
+			 * one PSN per req.
+			 */
+			qp->s_state = IB_OPCODE_RC_SEND_LAST;
+		}
+	}
+
+done:
+	tasklet_schedule(&qp->s_task);
+}
+
+/*
+ * Handle RC and UC post sends.
+ */
+static int ipath_post_rc_send(struct ipath_qp *qp, struct ib_send_wr *wr)
+{
+	struct ipath_swqe *wqe;
+	unsigned long flags;
+	u32 next;
+	int i, j;
+	int acc;
+
+	/*
+	 * Don't allow RDMA reads or atomic operations on UC or
+	 * undefined operations.
+	 * Make sure buffer is large enough to hold the result for atomics.
+	 */
+	if (qp->ibqp.qp_type == IB_QPT_UC) {
+		if ((unsigned) wr->opcode >= IB_WR_RDMA_READ)
+			return -EINVAL;
+	} else if ((unsigned) wr->opcode > IB_WR_ATOMIC_FETCH_AND_ADD)
+		return -EINVAL;
+	else if (wr->opcode >= IB_WR_ATOMIC_CMP_AND_SWP &&
+		 (wr->num_sge == 0 || wr->sg_list[0].length < sizeof(u64) ||
+		  wr->sg_list[0].addr & 0x7))
+		return -EINVAL;
+
+	/* IB spec says that num_sge == 0 is OK. */
+	if (wr->num_sge > qp->s_max_sge)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	next = qp->s_head + 1;
+	if (next >= qp->s_size)
+		next = 0;
+	if (next == qp->s_last) {
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		return -EINVAL;
+	}
+
+	wqe = get_swqe_ptr(qp, qp->s_head);
+	wqe->wr = *wr;
+	wqe->ssn = qp->s_ssn++;
+	wqe->sg_list[0].mr = NULL;
+	wqe->sg_list[0].vaddr = NULL;
+	wqe->sg_list[0].length = 0;
+	wqe->sg_list[0].sge_length = 0;
+	wqe->length = 0;
+	acc = wr->opcode >= IB_WR_RDMA_READ ? IB_ACCESS_LOCAL_WRITE : 0;
+	for (i = 0, j = 0; i < wr->num_sge; i++) {
+		if (to_ipd(qp->ibqp.pd)->user && wr->sg_list[i].lkey == 0) {
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+			return -EINVAL;
+		}
+		if (wr->sg_list[i].length == 0)
+			continue;
+		if (!ipath_lkey_ok(&to_idev(qp->ibqp.device)->lk_table,
+				   &wqe->sg_list[j], &wr->sg_list[i], acc)) {
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+			return -EINVAL;
+		}
+		wqe->length += wr->sg_list[i].length;
+		j++;
+	}
+	wqe->wr.num_sge = j;
+	qp->s_head = next;
+	/*
+	 * Wake up the send tasklet if the QP is not waiting
+	 * for an RNR timeout.
+	 */
+	next = qp->s_rnr_timeout;
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
+	if (next == 0) {
+		if (qp->ibqp.qp_type == IB_QPT_UC)
+			do_uc_send((unsigned long) qp);
+		else
+			do_rc_send((unsigned long) qp);
+	}
+	return 0;
+}
+
+/*
+ * Note that we actually send the data as it is posted instead of putting
+ * the request into a ring buffer.  If we wanted to use a ring buffer,
+ * we would need to save a reference to the destination address in the SWQE.
+ */
+static int ipath_post_ud_send(struct ipath_qp *qp, struct ib_send_wr *wr)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ipath_other_headers *ohdr;
+	struct ib_ah_attr *ah_attr;
+	struct ipath_sge_state ss;
+	struct ipath_sge *sg_list;
+	struct ib_wc wc;
+	u32 hwords;
+	u32 nwords;
+	u32 len;
+	u32 extra_bytes;
+	u32 bth0;
+	u16 lrh0;
+	u16 lid;
+	int i;
+
+	if (!(state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
+		return 0;
+
+	/* IB spec says that num_sge == 0 is OK. */
+	if (wr->num_sge > qp->s_max_sge)
+		return -EINVAL;
+
+	if (wr->num_sge > 1) {
+		sg_list = kmalloc((qp->s_max_sge - 1) * sizeof(*sg_list),
+				  GFP_ATOMIC);
+		if (!sg_list)
+			return -ENOMEM;
+	} else
+		sg_list = NULL;
+
+	/* Check the buffer to send. */
+	ss.sg_list = sg_list;
+	ss.sge.mr = NULL;
+	ss.sge.vaddr = NULL;
+	ss.sge.length = 0;
+	ss.sge.sge_length = 0;
+	ss.num_sge = 0;
+	len = 0;
+	for (i = 0; i < wr->num_sge; i++) {
+		/* Check LKEY */
+		if (to_ipd(qp->ibqp.pd)->user && wr->sg_list[i].lkey == 0)
+			return -EINVAL;
+
+		if (wr->sg_list[i].length == 0)
+			continue;
+		if (!ipath_lkey_ok(&dev->lk_table, ss.num_sge ?
+				   sg_list + ss.num_sge : &ss.sge,
+				   &wr->sg_list[i], 0)) {
+			return -EINVAL;
+		}
+		len += wr->sg_list[i].length;
+		ss.num_sge++;
+	}
+	extra_bytes = (4 - len) & 3;
+	nwords = (len + extra_bytes) >> 2;
+
+	/* Construct the header. */
+	ah_attr = &to_iah(wr->wr.ud.ah)->attr;
+	if (ah_attr->dlid >= 0xC000 && ah_attr->dlid < 0xFFFF)
+		dev->n_multicast_xmit++;
+	else
+		dev->n_unicast_xmit++;
+	if (unlikely(ah_attr->dlid == ipath_layer_get_lid(dev->ib_unit))) {
+		/* Pass in an uninitialized ib_wc to save stack space. */
+		ipath_ud_loopback(qp, &ss, len, wr, &wc);
+		goto done;
+	}
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		/* Header size in 32-bit words. */
+		hwords = 17;
+		lrh0 = IPS_LRH_GRH;
+		ohdr = &qp->s_hdr.u.l.oth;
+		qp->s_hdr.u.l.grh.version_tclass_flow =
+		    cpu_to_be32((6 << 28) |
+				(ah_attr->grh.traffic_class << 20) |
+				ah_attr->grh.flow_label);
+		qp->s_hdr.u.l.grh.paylen =
+		    cpu_to_be16(((wr->opcode ==
+				  IB_WR_SEND_WITH_IMM ? 6 : 5) + nwords +
+				 SIZE_OF_CRC) << 2);
+		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
+		qp->s_hdr.u.l.grh.hop_limit = ah_attr->grh.hop_limit;
+		/* The SGID is 32-bit aligned. */
+		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
+		qp->s_hdr.u.l.grh.sgid.global.interface_id =
+		    ipath_layer_get_guid(dev->ib_unit);
+		qp->s_hdr.u.l.grh.dgid = ah_attr->grh.dgid;
+		/*
+		 * Don't worry about sending to locally attached
+		 * multicast QPs.  It is unspecified by the spec. what happens.
+		 */
+	} else {
+		/* Header size in 32-bit words. */
+		hwords = 7;
+		lrh0 = IPS_LRH_BTH;
+		ohdr = &qp->s_hdr.u.oth;
+	}
+	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
+		ohdr->u.ud.imm_data = wr->imm_data;
+		wc.imm_data = wr->imm_data;
+		hwords += 1;
+		bth0 = IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE << 24;
+	} else if (wr->opcode == IB_WR_SEND) {
+		wc.imm_data = 0;
+		bth0 = IB_OPCODE_UD_SEND_ONLY << 24;
+	} else
+		return -EINVAL;
+	lrh0 |= ah_attr->sl << 4;
+	if (qp->ibqp.qp_type == IB_QPT_SMI)
+		lrh0 |= 0xF000;	/* Set VL */
+	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
+	qp->s_hdr.lrh[1] = cpu_to_be16(ah_attr->dlid);	/* DEST LID */
+	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
+	lid = ipath_layer_get_lid(dev->ib_unit);
+	qp->s_hdr.lrh[3] = lid ? cpu_to_be16(lid) : IB_LID_PERMISSIVE;
+	if (wr->send_flags & IB_SEND_SOLICITED)
+		bth0 |= 1 << 23;
+	bth0 |= extra_bytes << 20;
+	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? IPS_DEFAULT_P_KEY :
+	    ipath_layer_get_pkey(dev->ib_unit, qp->s_pkey_index);
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(wr->wr.ud.remote_qpn);
+	/* XXX Could lose a PSN count but not worth locking */
+	ohdr->bth[2] = cpu_to_be32(qp->s_psn++ & 0xFFFFFF);
+	/*
+	 * Qkeys with the high order bit set mean use the
+	 * qkey from the QP context instead of the WR (see 10.2.5).
+	 */
+	ohdr->u.ud.deth[0] = cpu_to_be32((int)wr->wr.ud.remote_qkey < 0 ?
+					 qp->qkey : wr->wr.ud.remote_qkey);
+	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
+	if (ipath_verbs_send(dev->ib_unit, hwords, (uint32_t *) &qp->s_hdr,
+			     len, &ss))
+		dev->n_no_piobuf++;
+
+done:
+	/* Queue the completion status entry. */
+	if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
+	    (wr->send_flags & IB_SEND_SIGNALED)) {
+		wc.wr_id = wr->wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.vendor_err = 0;
+		wc.opcode = IB_WC_SEND;
+		wc.byte_len = len;
+		wc.qp_num = qp->ibqp.qp_num;
+		wc.src_qp = 0;
+		wc.wc_flags = 0;
+		/* XXX initialize other fields? */
+		ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 0);
+	}
+	kfree(sg_list);
+
+	return 0;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static int ipath_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
+			   struct ib_send_wr **bad_wr)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	int err = 0;
+
+	/* Check that state is OK to post send. */
+	if (!(state_ops[qp->state] & IPATH_POST_SEND_OK)) {
+		*bad_wr = wr;
+		return -EINVAL;
+	}
+
+	for (; wr; wr = wr->next) {
+		switch (qp->ibqp.qp_type) {
+		case IB_QPT_UC:
+		case IB_QPT_RC:
+			err = ipath_post_rc_send(qp, wr);
+			break;
+
+		case IB_QPT_SMI:
+		case IB_QPT_GSI:
+		case IB_QPT_UD:
+			err = ipath_post_ud_send(qp, wr);
+			break;
+
+		default:
+			err = -EINVAL;
+		}
+		if (err) {
+			*bad_wr = wr;
+			break;
+		}
+	}
+	return err;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static int ipath_post_receive(struct ib_qp *ibqp, struct ib_recv_wr *wr,
+			      struct ib_recv_wr **bad_wr)
+{
+	struct ipath_qp *qp = to_iqp(ibqp);
+	unsigned long flags;
+
+	/* Check that state is OK to post receive. */
+	if (!(state_ops[qp->state] & IPATH_POST_RECV_OK)) {
+		*bad_wr = wr;
+		return -EINVAL;
+	}
+
+	for (; wr; wr = wr->next) {
+		struct ipath_rwqe *wqe;
+		u32 next;
+		int i, j;
+
+		if (wr->num_sge > qp->r_rq.max_sge) {
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		next = qp->r_rq.head + 1;
+		if (next >= qp->r_rq.size)
+			next = 0;
+		if (next == qp->r_rq.tail) {
+			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		wqe = get_rwqe_ptr(&qp->r_rq, qp->r_rq.head);
+		wqe->wr_id = wr->wr_id;
+		wqe->sg_list[0].mr = NULL;
+		wqe->sg_list[0].vaddr = NULL;
+		wqe->sg_list[0].length = 0;
+		wqe->sg_list[0].sge_length = 0;
+		wqe->length = 0;
+		for (i = 0, j = 0; i < wr->num_sge; i++) {
+			/* Check LKEY */
+			if (to_ipd(qp->ibqp.pd)->user &&
+			    wr->sg_list[i].lkey == 0) {
+				spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			if (wr->sg_list[i].length == 0)
+				continue;
+			if (!ipath_lkey_ok(&to_idev(qp->ibqp.device)->lk_table,
+					   &wqe->sg_list[j], &wr->sg_list[i],
+					   IB_ACCESS_LOCAL_WRITE)) {
+				spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			wqe->length += wr->sg_list[i].length;
+			j++;
+		}
+		wqe->num_sge = j;
+		qp->r_rq.head = next;
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+	}
+	return 0;
+}
+
+/*
+ * This may be called from interrupt context.
+ */
+static int ipath_post_srq_receive(struct ib_srq *ibsrq, struct ib_recv_wr *wr,
+				  struct ib_recv_wr **bad_wr)
+{
+	struct ipath_srq *srq = to_isrq(ibsrq);
+	struct ipath_ibdev *dev = to_idev(ibsrq->device);
+	unsigned long flags;
+
+	for (; wr; wr = wr->next) {
+		struct ipath_rwqe *wqe;
+		u32 next;
+		int i, j;
+
+		if (wr->num_sge > srq->rq.max_sge) {
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		next = srq->rq.head + 1;
+		if (next >= srq->rq.size)
+			next = 0;
+		if (next == srq->rq.tail) {
+			spin_unlock_irqrestore(&srq->rq.lock, flags);
+			*bad_wr = wr;
+			return -ENOMEM;
+		}
+
+		wqe = get_rwqe_ptr(&srq->rq, srq->rq.head);
+		wqe->wr_id = wr->wr_id;
+		wqe->sg_list[0].mr = NULL;
+		wqe->sg_list[0].vaddr = NULL;
+		wqe->sg_list[0].length = 0;
+		wqe->sg_list[0].sge_length = 0;
+		wqe->length = 0;
+		for (i = 0, j = 0; i < wr->num_sge; i++) {
+			/* Check LKEY */
+			if (to_ipd(srq->ibsrq.pd)->user &&
+			    wr->sg_list[i].lkey == 0) {
+				spin_unlock_irqrestore(&srq->rq.lock, flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			if (wr->sg_list[i].length == 0)
+				continue;
+			if (!ipath_lkey_ok(&dev->lk_table,
+					   &wqe->sg_list[j], &wr->sg_list[i],
+					   IB_ACCESS_LOCAL_WRITE)) {
+				spin_unlock_irqrestore(&srq->rq.lock, flags);
+				*bad_wr = wr;
+				return -EINVAL;
+			}
+			wqe->length += wr->sg_list[i].length;
+			j++;
+		}
+		wqe->num_sge = j;
+		srq->rq.head = next;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
+	return 0;
+}
+
+/*
+ * This is called from ipath_qp_rcv() to process an incomming UD packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+static void ipath_ud_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
+			 int has_grh, void *data, u32 tlen, struct ipath_qp *qp)
+{
+	struct ipath_other_headers *ohdr;
+	int opcode;
+	u32 hdrsize;
+	u32 pad;
+	unsigned long flags;
+	struct ib_wc wc;
+	u32 qkey;
+	u32 src_qp;
+	struct ipath_rq *rq;
+	struct ipath_srq *srq;
+	struct ipath_rwqe *wqe;
+
+	/* Check for GRH */
+	if (!has_grh) {
+		ohdr = &hdr->u.oth;
+		hdrsize = 8 + 12 + 8;	/* LRH + BTH + DETH */
+		qkey = be32_to_cpu(ohdr->u.ud.deth[0]);
+		src_qp = be32_to_cpu(ohdr->u.ud.deth[1]);
+	} else {
+		ohdr = &hdr->u.l.oth;
+		hdrsize = 8 + 40 + 12 + 8;	/* LRH + GRH + BTH + DETH */
+		/*
+		 * The header with GRH is 68 bytes and the
+		 * core driver sets the eager header buffer
+		 * size to 56 bytes so the last 12 bytes of
+		 * the IB header is in the data buffer.
+		 */
+		qkey = be32_to_cpu(((u32 *) data)[1]);
+		src_qp = be32_to_cpu(((u32 *) data)[2]);
+		data += 12;
+	}
+	src_qp &= 0xFFFFFF;
+
+	/* Check that the qkey matches (except for QP0, see 9.6.1.4.1). */
+	if (unlikely(qp->ibqp.qp_num && qkey != qp->qkey)) {
+		/* XXX OK to lose a count once in a while. */
+		dev->qkey_violations++;
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	/* Get the number of bytes the message was padded by. */
+	pad = (ohdr->bth[0] >> 12) & 3;
+	if (unlikely(tlen < (hdrsize + pad + 4))) {
+		/* Drop incomplete packets. */
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	/*
+	 * A GRH is expected to preceed the data even if not
+	 * present on the wire.
+	 */
+	wc.byte_len = tlen - (hdrsize + pad + 4) + sizeof(struct ib_grh);
+
+	/*
+	 * The opcode is in the low byte when its in network order
+	 * (top byte when in host order).
+	 */
+	opcode = *(u8 *) (&ohdr->bth[0]);
+	if (opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else
+			wc.imm_data = ohdr->u.ud.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		hdrsize += sizeof(u32);
+	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
+		wc.imm_data = 0;
+		wc.wc_flags = 0;
+	} else {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+	/*
+	 * Get the next work request entry to find where to put the data.
+	 * Note that it is safe to drop the lock after changing rq->tail
+	 * since ipath_post_receive() won't fill the empty slot.
+	 */
+	if (qp->ibqp.srq) {
+		srq = to_isrq(qp->ibqp.srq);
+		rq = &srq->rq;
+	} else {
+		srq = NULL;
+		rq = &qp->r_rq;
+	}
+	spin_lock_irqsave(&rq->lock, flags);
+	if (rq->tail == rq->head) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		return;
+	}
+	/* Silently drop packets which are too big. */
+	wqe = get_rwqe_ptr(rq, rq->tail);
+	if (wc.byte_len > wqe->length) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		return;
+	}
+	wc.wr_id = wqe->wr_id;
+	qp->r_sge.sge = wqe->sg_list[0];
+	qp->r_sge.sg_list = wqe->sg_list + 1;
+	qp->r_sge.num_sge = wqe->num_sge;
+	if (++rq->tail >= rq->size)
+		rq->tail = 0;
+	if (srq && srq->ibsrq.event_handler) {
+		u32 n;
+
+		if (rq->head < rq->tail)
+			n = rq->size + rq->head - rq->tail;
+		else
+			n = rq->head - rq->tail;
+		if (n < srq->limit) {
+			struct ib_event ev;
+
+			srq->limit = 0;
+			spin_unlock_irqrestore(&rq->lock, flags);
+			ev.device = qp->ibqp.device;
+			ev.element.srq = qp->ibqp.srq;
+			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+			srq->ibsrq.event_handler(&ev, srq->ibsrq.srq_context);
+		} else
+			spin_unlock_irqrestore(&rq->lock, flags);
+	} else
+		spin_unlock_irqrestore(&rq->lock, flags);
+	if (has_grh) {
+		copy_sge(&qp->r_sge, &hdr->u.l.grh, sizeof(struct ib_grh));
+		wc.wc_flags |= IB_WC_GRH;
+	} else
+		skip_sge(&qp->r_sge, sizeof(struct ib_grh));
+	copy_sge(&qp->r_sge, data, wc.byte_len - sizeof(struct ib_grh));
+	wc.status = IB_WC_SUCCESS;
+	wc.opcode = IB_WC_RECV;
+	wc.vendor_err = 0;
+	wc.qp_num = qp->ibqp.qp_num;
+	wc.src_qp = src_qp;
+	/* XXX do we know which pkey matched? Only needed for GSI. */
+	wc.pkey_index = 0;
+	wc.slid = be16_to_cpu(hdr->lrh[3]);
+	wc.sl = (be16_to_cpu(hdr->lrh[0]) >> 4) & 0xF;
+	wc.dlid_path_bits = 0;
+	/* Signal completion event if the solicited bit is set. */
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
+		       ohdr->bth[0] & __constant_cpu_to_be32(1 << 23));
+}
+
+/*
+ * This is called from ipath_post_ud_send() to forward a WQE addressed
+ * to the same HCA.
+ */
+static void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
+			      u32 length, struct ib_send_wr *wr,
+			      struct ib_wc *wc)
+{
+	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
+	struct ipath_qp *qp;
+	struct ib_ah_attr *ah_attr;
+	unsigned long flags;
+	struct ipath_rq *rq;
+	struct ipath_srq *srq;
+	struct ipath_sge_state rsge;
+	struct ipath_sge *sge;
+	struct ipath_rwqe *wqe;
+
+	qp = ipath_lookup_qpn(&dev->qp_table, wr->wr.ud.remote_qpn);
+	if (!qp)
+		return;
+
+	/*
+	 * Check that the qkey matches (except for QP0, see 9.6.1.4.1).
+	 * Qkeys with the high order bit set mean use the
+	 * qkey from the QP context instead of the WR (see 10.2.5).
+	 */
+	if (unlikely(qp->ibqp.qp_num && ((int)wr->wr.ud.remote_qkey < 0 ?
+		     qp->qkey : wr->wr.ud.remote_qkey) != qp->qkey)) {
+		/* XXX OK to lose a count once in a while. */
+		dev->qkey_violations++;
+		dev->n_pkt_drops++;
+		goto done;
+	}
+
+	/*
+	 * A GRH is expected to preceed the data even if not
+	 * present on the wire.
+	 */
+	wc->byte_len = length + sizeof(struct ib_grh);
+
+	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->imm_data = wr->imm_data;
+	} else {
+		wc->wc_flags = 0;
+		wc->imm_data = 0;
+	}
+
+	/*
+	 * Get the next work request entry to find where to put the data.
+	 * Note that it is safe to drop the lock after changing rq->tail
+	 * since ipath_post_receive() won't fill the empty slot.
+	 */
+	if (qp->ibqp.srq) {
+		srq = to_isrq(qp->ibqp.srq);
+		rq = &srq->rq;
+	} else {
+		srq = NULL;
+		rq = &qp->r_rq;
+	}
+	spin_lock_irqsave(&rq->lock, flags);
+	if (rq->tail == rq->head) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		goto done;
+	}
+	/* Silently drop packets which are too big. */
+	wqe = get_rwqe_ptr(rq, rq->tail);
+	if (wc->byte_len > wqe->length) {
+		spin_unlock_irqrestore(&rq->lock, flags);
+		dev->n_pkt_drops++;
+		goto done;
+	}
+	wc->wr_id = wqe->wr_id;
+	rsge.sge = wqe->sg_list[0];
+	rsge.sg_list = wqe->sg_list + 1;
+	rsge.num_sge = wqe->num_sge;
+	if (++rq->tail >= rq->size)
+		rq->tail = 0;
+	if (srq && srq->ibsrq.event_handler) {
+		u32 n;
+
+		if (rq->head < rq->tail)
+			n = rq->size + rq->head - rq->tail;
+		else
+			n = rq->head - rq->tail;
+		if (n < srq->limit) {
+			struct ib_event ev;
+
+			srq->limit = 0;
+			spin_unlock_irqrestore(&rq->lock, flags);
+			ev.device = qp->ibqp.device;
+			ev.element.srq = qp->ibqp.srq;
+			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+			srq->ibsrq.event_handler(&ev, srq->ibsrq.srq_context);
+		} else
+			spin_unlock_irqrestore(&rq->lock, flags);
+	} else
+		spin_unlock_irqrestore(&rq->lock, flags);
+	ah_attr = &to_iah(wr->wr.ud.ah)->attr;
+	if (ah_attr->ah_flags & IB_AH_GRH) {
+		copy_sge(&rsge, &ah_attr->grh, sizeof(struct ib_grh));
+		wc->wc_flags |= IB_WC_GRH;
+	} else
+		skip_sge(&rsge, sizeof(struct ib_grh));
+	sge = &ss->sge;
+	while (length) {
+		u32 len = sge->length;
+
+		if (len > length)
+			len = length;
+		BUG_ON(len == 0);
+		copy_sge(&rsge, sge->vaddr, len);
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (sge->sge_length == 0) {
+			if (--ss->num_sge)
+				*sge = *ss->sg_list++;
+		} else if (sge->length == 0 && sge->mr != NULL) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		length -= len;
+	}
+	wc->status = IB_WC_SUCCESS;
+	wc->opcode = IB_WC_RECV;
+	wc->vendor_err = 0;
+	wc->qp_num = qp->ibqp.qp_num;
+	wc->src_qp = sqp->ibqp.qp_num;
+	/* XXX do we know which pkey matched? Only needed for GSI. */
+	wc->pkey_index = 0;
+	wc->slid = ipath_layer_get_lid(dev->ib_unit);
+	wc->sl = ah_attr->sl;
+	wc->dlid_path_bits = 0;
+	/* Signal completion event if the solicited bit is set. */
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), wc,
+		       wr->send_flags & IB_SEND_SOLICITED);
+
+done:
+	if (atomic_dec_and_test(&qp->refcount))
+		wake_up(&qp->wait);
+}
+
+/*
+ * Copy the next RWQE into the QP's RWQE.
+ * Return zero if no RWQE is available.
+ * Called at interrupt level with the QP r_rq.lock held.
+ */
+static int get_rwqe(struct ipath_qp *qp, int wr_id_only)
+{
+	struct ipath_rq *rq;
+	struct ipath_srq *srq;
+	struct ipath_rwqe *wqe;
+
+	if (!qp->ibqp.srq) {
+		rq = &qp->r_rq;
+		if (unlikely(rq->tail == rq->head))
+			return 0;
+		wqe = get_rwqe_ptr(rq, rq->tail);
+		qp->r_wr_id = wqe->wr_id;
+		if (!wr_id_only) {
+			qp->r_sge.sge = wqe->sg_list[0];
+			qp->r_sge.sg_list = wqe->sg_list + 1;
+			qp->r_sge.num_sge = wqe->num_sge;
+			qp->r_len = wqe->length;
+		}
+		if (++rq->tail >= rq->size)
+			rq->tail = 0;
+		return 1;
+	}
+
+	srq = to_isrq(qp->ibqp.srq);
+	rq = &srq->rq;
+	spin_lock(&rq->lock);
+	if (unlikely(rq->tail == rq->head)) {
+		spin_unlock(&rq->lock);
+		return 0;
+	}
+	wqe = get_rwqe_ptr(rq, rq->tail);
+	qp->r_wr_id = wqe->wr_id;
+	if (!wr_id_only) {
+		qp->r_sge.sge = wqe->sg_list[0];
+		qp->r_sge.sg_list = wqe->sg_list + 1;
+		qp->r_sge.num_sge = wqe->num_sge;
+		qp->r_len = wqe->length;
+	}
+	if (++rq->tail >= rq->size)
+		rq->tail = 0;
+	if (srq->ibsrq.event_handler) {
+		struct ib_event ev;
+		u32 n;
+
+		if (rq->head < rq->tail)
+			n = rq->size + rq->head - rq->tail;
+		else
+			n = rq->head - rq->tail;
+		if (n < srq->limit) {
+			srq->limit = 0;
+			spin_unlock(&rq->lock);
+			ev.device = qp->ibqp.device;
+			ev.element.srq = qp->ibqp.srq;
+			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+			srq->ibsrq.event_handler(&ev, srq->ibsrq.srq_context);
+		} else
+			spin_unlock(&rq->lock);
+	} else
+		spin_unlock(&rq->lock);
+	return 1;
+}
+
+/*
+ * This is called from ipath_qp_rcv() to process an incomming UC packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+static void ipath_uc_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
+			 int has_grh, void *data, u32 tlen, struct ipath_qp *qp)
+{
+	struct ipath_other_headers *ohdr;
+	int opcode;
+	u32 hdrsize;
+	u32 psn;
+	u32 pad;
+	unsigned long flags;
+	struct ib_wc wc;
+	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
+	struct ib_reth *reth;
+
+	/* Check for GRH */
+	if (!has_grh) {
+		ohdr = &hdr->u.oth;
+		hdrsize = 8 + 12;	/* LRH + BTH */
+		psn = be32_to_cpu(ohdr->bth[2]);
+	} else {
+		ohdr = &hdr->u.l.oth;
+		hdrsize = 8 + 40 + 12;	/* LRH + GRH + BTH */
+		/*
+		 * The header with GRH is 60 bytes and the
+		 * core driver sets the eager header buffer
+		 * size to 56 bytes so the last 4 bytes of
+		 * the BTH header (PSN) is in the data buffer.
+		 */
+		psn = be32_to_cpu(((u32 *) data)[0]);
+		data += sizeof(u32);
+	}
+	/*
+	 * The opcode is in the low byte when its in network order
+	 * (top byte when in host order).
+	 */
+	opcode = *(u8 *) (&ohdr->bth[0]);
+
+	wc.imm_data = 0;
+	wc.wc_flags = 0;
+
+	spin_lock_irqsave(&qp->r_rq.lock, flags);
+
+	/* Compare the PSN verses the expected PSN. */
+	if (unlikely(cmp24(psn, qp->r_psn) != 0)) {
+		/*
+		 * Handle a sequence error.
+		 * Silently drop any current message.
+		 */
+		qp->r_psn = psn;
+	      inv:
+		qp->r_state = IB_OPCODE_UC_SEND_LAST;
+		switch (opcode) {
+		case IB_OPCODE_UC_SEND_FIRST:
+		case IB_OPCODE_UC_SEND_ONLY:
+		case IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE:
+			goto send_first;
+
+		case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+		case IB_OPCODE_UC_RDMA_WRITE_ONLY:
+		case IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE:
+			goto rdma_first;
+
+		default:
+			dev->n_pkt_drops++;
+			goto done;
+		}
+	}
+
+	/* Check for opcode sequence errors. */
+	switch (qp->r_state) {
+	case IB_OPCODE_UC_SEND_FIRST:
+	case IB_OPCODE_UC_SEND_MIDDLE:
+		if (opcode == IB_OPCODE_UC_SEND_MIDDLE ||
+		    opcode == IB_OPCODE_UC_SEND_LAST ||
+		    opcode == IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE)
+			break;
+		goto inv;
+
+	case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+	case IB_OPCODE_UC_RDMA_WRITE_MIDDLE:
+		if (opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_LAST ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE)
+			break;
+		goto inv;
+
+	default:
+		if (opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    opcode == IB_OPCODE_UC_SEND_ONLY ||
+		    opcode == IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY ||
+		    opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE)
+			break;
+		goto inv;
+	}
+
+	/* OK, process the packet. */
+	switch (opcode) {
+	case IB_OPCODE_UC_SEND_FIRST:
+	case IB_OPCODE_UC_SEND_ONLY:
+	case IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE:
+	      send_first:
+		if (qp->r_reuse_sge) {
+			qp->r_reuse_sge = 0;
+			qp->r_sge = qp->s_rdma_sge;
+		} else if (!get_rwqe(qp, 0)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Save the WQE so we can reuse it in case of an error. */
+		qp->s_rdma_sge = qp->r_sge;
+		qp->r_rcv_len = 0;
+		if (opcode == IB_OPCODE_UC_SEND_ONLY)
+			goto send_last;
+		else if (opcode == IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE)
+			goto send_last_imm;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_SEND_MIDDLE:
+		/* Check for invalid length PMTU or posted rwqe len. */
+		if (unlikely(tlen != (hdrsize + pmtu + 4))) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len)) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		copy_sge(&qp->r_sge, data, pmtu);
+		break;
+
+	case IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE:
+	      send_last_imm:
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else {
+			/* Immediate data comes after BTH */
+			wc.imm_data = ohdr->u.imm_data;
+		}
+		hdrsize += 4;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_SEND_LAST:
+	      send_last:
+		/* Get the number of bytes the message was padded by. */
+		pad = (ohdr->bth[0] >> 12) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		wc.byte_len = tlen + qp->r_rcv_len;
+		if (unlikely(wc.byte_len > qp->r_len)) {
+			qp->r_reuse_sge = 1;
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* XXX Need to free SGEs */
+	      last_imm:
+		copy_sge(&qp->r_sge, data, tlen);
+		wc.wr_id = qp->r_wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.opcode = IB_WC_RECV;
+		wc.vendor_err = 0;
+		wc.qp_num = qp->ibqp.qp_num;
+		wc.src_qp = qp->remote_qpn;
+		wc.pkey_index = 0;
+		wc.slid = qp->remote_ah_attr.dlid;
+		wc.sl = qp->remote_ah_attr.sl;
+		wc.dlid_path_bits = 0;
+		wc.port_num = 0;
+		/* Signal completion event if the solicited bit is set. */
+		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
+			       ohdr->bth[0] & __constant_cpu_to_be32(1 << 23));
+		break;
+
+	case IB_OPCODE_UC_RDMA_WRITE_FIRST:
+	case IB_OPCODE_UC_RDMA_WRITE_ONLY:
+	case IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE: /* consume RWQE */
+	      rdma_first:
+		/* RETH comes after BTH */
+		if (!has_grh)
+			reth = &ohdr->u.rc.reth;
+		else {
+			reth = (struct ib_reth *)data;
+			data += sizeof(*reth);
+		}
+		hdrsize += sizeof(*reth);
+		qp->r_len = be32_to_cpu(reth->length);
+		qp->r_rcv_len = 0;
+		if (qp->r_len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = be64_to_cpu(reth->vaddr);
+
+			/* Check rkey */
+			if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, qp->r_len,
+						    vaddr, rkey,
+						    IB_ACCESS_REMOTE_WRITE))) {
+				dev->n_pkt_drops++;
+				goto done;
+			}
+		} else {
+			qp->r_sge.sg_list = NULL;
+			qp->r_sge.sge.mr = NULL;
+			qp->r_sge.sge.vaddr = NULL;
+			qp->r_sge.sge.length = 0;
+			qp->r_sge.sge.sge_length = 0;
+		}
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_WRITE))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		if (opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY)
+			goto rdma_last;
+		else if (opcode == IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE)
+			goto rdma_last_imm;
+		/* FALLTHROUGH */
+	case IB_OPCODE_UC_RDMA_WRITE_MIDDLE:
+		/* Check for invalid length PMTU or posted rwqe len. */
+		if (unlikely(tlen != (hdrsize + pmtu + 4))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		copy_sge(&qp->r_sge, data, pmtu);
+		break;
+
+	case IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE:
+	      rdma_last_imm:
+		/* Get the number of bytes the message was padded by. */
+		pad = (ohdr->bth[0] >> 12) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		if (unlikely(tlen + qp->r_rcv_len != qp->r_len)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		if (qp->r_reuse_sge) {
+			qp->r_reuse_sge = 0;
+		} else if (!get_rwqe(qp, 1)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else {
+			/* Immediate data comes after BTH */
+			wc.imm_data = ohdr->u.imm_data;
+		}
+		hdrsize += 4;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		wc.byte_len = 0;
+		goto last_imm;
+
+	case IB_OPCODE_UC_RDMA_WRITE_LAST:
+	      rdma_last:
+		/* Get the number of bytes the message was padded by. */
+		pad = (ohdr->bth[0] >> 12) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		if (unlikely(tlen + qp->r_rcv_len != qp->r_len)) {
+			dev->n_pkt_drops++;
+			goto done;
+		}
+		copy_sge(&qp->r_sge, data, tlen);
+		break;
+
+	default:
+		/* Drop packet for unknown opcodes. */
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		dev->n_pkt_drops++;
+		return;
+	}
+	qp->r_psn++;
+	qp->r_state = opcode;
+done:
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+}
+
+/*
+ * Put this QP on the RNR timeout list for the device.
+ * XXX Use a simple list for now.  We might need a priority
+ * queue if we have lots of QPs waiting for RNR timeouts
+ * but that should be rare.
+ */
+static void insert_rnr_queue(struct ipath_qp *qp)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->pending_lock, flags);
+	if (list_empty(&dev->rnrwait))
+		list_add(&qp->timerwait, &dev->rnrwait);
+	else {
+		struct list_head *l = &dev->rnrwait;
+		struct ipath_qp *nqp = list_entry(l->next, struct ipath_qp,
+						  timerwait);
+
+		while (qp->s_rnr_timeout >= nqp->s_rnr_timeout) {
+			qp->s_rnr_timeout -= nqp->s_rnr_timeout;
+			l = l->next;
+			if (l->next == &dev->rnrwait)
+				break;
+			nqp = list_entry(l->next, struct ipath_qp, timerwait);
+		}
+		list_add(&qp->timerwait, l);
+	}
+	spin_unlock_irqrestore(&dev->pending_lock, flags);
+}
+
+/*
+ * This is called from do_uc_send() or do_rc_send() to forward a WQE addressed
+ * to the same HCA.
+ * Note that although we are single threaded due to the tasklet, we still
+ * have to protect against post_send().  We don't have to worry about
+ * receive interrupts since this is a connected protocol and all packets
+ * will pass through here.
+ */
+static void ipath_ruc_loopback(struct ipath_qp *sqp, struct ib_wc *wc)
+{
+	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
+	struct ipath_qp *qp;
+	struct ipath_swqe *wqe;
+	struct ipath_sge *sge;
+	unsigned long flags;
+	u64 sdata;
+
+	qp = ipath_lookup_qpn(&dev->qp_table, sqp->remote_qpn);
+	if (!qp) {
+		dev->n_pkt_drops++;
+		return;
+	}
+
+again:
+	spin_lock_irqsave(&sqp->s_lock, flags);
+
+	if (!(state_ops[sqp->state] & IPATH_PROCESS_SEND_OK)) {
+		spin_unlock_irqrestore(&sqp->s_lock, flags);
+		goto done;
+	}
+
+	/* Get the next send request. */
+	if (sqp->s_last == sqp->s_head) {
+		/* Send work queue is empty. */
+		spin_unlock_irqrestore(&sqp->s_lock, flags);
+		goto done;
+	}
+
+	/*
+	 * We can rely on the entry not changing without the s_lock
+	 * being held until we update s_last.
+	 */
+	wqe = get_swqe_ptr(sqp, sqp->s_last);
+	spin_unlock_irqrestore(&sqp->s_lock, flags);
+
+	wc->wc_flags = 0;
+	wc->imm_data = 0;
+
+	sqp->s_sge.sge = wqe->sg_list[0];
+	sqp->s_sge.sg_list = wqe->sg_list + 1;
+	sqp->s_sge.num_sge = wqe->wr.num_sge;
+	sqp->s_len = wqe->length;
+	switch (wqe->wr.opcode) {
+	case IB_WR_SEND_WITH_IMM:
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->imm_data = wqe->wr.imm_data;
+		/* FALLTHROUGH */
+	case IB_WR_SEND:
+		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		if (!get_rwqe(qp, 0)) {
+		      rnr_nak:
+			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+			/* Handle RNR NAK */
+			if (qp->ibqp.qp_type == IB_QPT_UC)
+				goto send_comp;
+			if (sqp->s_rnr_retry == 0) {
+				wc->status = IB_WC_RNR_RETRY_EXC_ERR;
+				goto err;
+			}
+			if (sqp->s_rnr_retry_cnt < 7)
+				sqp->s_rnr_retry--;
+			dev->n_rnr_naks++;
+			sqp->s_rnr_timeout = rnr_table[sqp->s_min_rnr_timer];
+			insert_rnr_queue(sqp);
+			goto done;
+		}
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		break;
+
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->imm_data = wqe->wr.imm_data;
+		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		if (!get_rwqe(qp, 1))
+			goto rnr_nak;
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		/* FALLTHROUGH */
+	case IB_WR_RDMA_WRITE:
+		if (wqe->length == 0)
+			break;
+		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, wqe->length,
+					    wqe->wr.wr.rdma.remote_addr,
+					    wqe->wr.wr.rdma.rkey,
+					    IB_ACCESS_REMOTE_WRITE))) {
+		      acc_err:
+			wc->status = IB_WC_REM_ACCESS_ERR;
+		      err:
+			wc->wr_id = wqe->wr.wr_id;
+			wc->opcode = wc_opcode[wqe->wr.opcode];
+			wc->vendor_err = 0;
+			wc->byte_len = 0;
+			wc->qp_num = sqp->ibqp.qp_num;
+			wc->src_qp = sqp->remote_qpn;
+			wc->pkey_index = 0;
+			wc->slid = sqp->remote_ah_attr.dlid;
+			wc->sl = sqp->remote_ah_attr.sl;
+			wc->dlid_path_bits = 0;
+			wc->port_num = 0;
+			ipath_sqerror_qp(sqp, wc);
+			goto done;
+		}
+		break;
+
+	case IB_WR_RDMA_READ:
+		if (unlikely(!ipath_rkey_ok(dev, &sqp->s_sge, wqe->length,
+					    wqe->wr.wr.rdma.remote_addr,
+					    wqe->wr.wr.rdma.rkey,
+					    IB_ACCESS_REMOTE_READ))) {
+			goto acc_err;
+		}
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_READ)))
+			goto acc_err;
+		qp->r_sge.sge = wqe->sg_list[0];
+		qp->r_sge.sg_list = wqe->sg_list + 1;
+		qp->r_sge.num_sge = wqe->wr.num_sge;
+		break;
+
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, sizeof(u64),
+					    wqe->wr.wr.rdma.remote_addr,
+					    wqe->wr.wr.rdma.rkey,
+					    IB_ACCESS_REMOTE_ATOMIC))) {
+			goto acc_err;
+		}
+		/* Perform atomic OP and save result. */
+		sdata = wqe->wr.wr.atomic.swap;
+		spin_lock_irqsave(&dev->pending_lock, flags);
+		qp->r_atomic_data = *(u64 *) qp->r_sge.sge.vaddr;
+		if (wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
+			*(u64 *) qp->r_sge.sge.vaddr =
+			    qp->r_atomic_data + sdata;
+		} else if (qp->r_atomic_data == wqe->wr.wr.atomic.compare_add) {
+			*(u64 *) qp->r_sge.sge.vaddr = sdata;
+		}
+		spin_unlock_irqrestore(&dev->pending_lock, flags);
+		*(u64 *) sqp->s_sge.sge.vaddr = qp->r_atomic_data;
+		goto send_comp;
+
+	default:
+		goto done;
+	}
+
+	sge = &sqp->s_sge.sge;
+	while (sqp->s_len) {
+		u32 len = sqp->s_len;
+
+		if (len > sge->length)
+			len = sge->length;
+		BUG_ON(len == 0);
+		copy_sge(&qp->r_sge, sge->vaddr, len);
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (sge->sge_length == 0) {
+			if (--sqp->s_sge.num_sge)
+				*sge = *sqp->s_sge.sg_list++;
+		} else if (sge->length == 0 && sge->mr != NULL) {
+			if (++sge->n >= IPATH_SEGSZ) {
+				if (++sge->m >= sge->mr->mapsz)
+					break;
+				sge->n = 0;
+			}
+			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		sqp->s_len -= len;
+	}
+
+	if (wqe->wr.opcode == IB_WR_RDMA_WRITE ||
+	    wqe->wr.opcode == IB_WR_RDMA_READ)
+		goto send_comp;
+
+	if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM)
+		wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+	else
+		wc->opcode = IB_WC_RECV;
+	wc->wr_id = qp->r_wr_id;
+	wc->status = IB_WC_SUCCESS;
+	wc->vendor_err = 0;
+	wc->byte_len = wqe->length;
+	wc->qp_num = qp->ibqp.qp_num;
+	wc->src_qp = qp->remote_qpn;
+	/* XXX do we know which pkey matched? Only needed for GSI. */
+	wc->pkey_index = 0;
+	wc->slid = qp->remote_ah_attr.dlid;
+	wc->sl = qp->remote_ah_attr.sl;
+	wc->dlid_path_bits = 0;
+	/* Signal completion event if the solicited bit is set. */
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), wc,
+		       wqe->wr.send_flags & IB_SEND_SOLICITED);
+
+send_comp:
+	sqp->s_rnr_retry = sqp->s_rnr_retry_cnt;
+
+	if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &sqp->s_flags) ||
+	    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
+		wc->wr_id = wqe->wr.wr_id;
+		wc->status = IB_WC_SUCCESS;
+		wc->opcode = wc_opcode[wqe->wr.opcode];
+		wc->vendor_err = 0;
+		wc->byte_len = wqe->length;
+		wc->qp_num = sqp->ibqp.qp_num;
+		wc->src_qp = 0;
+		wc->pkey_index = 0;
+		wc->slid = 0;
+		wc->sl = 0;
+		wc->dlid_path_bits = 0;
+		wc->port_num = 0;
+		ipath_cq_enter(to_icq(sqp->ibqp.send_cq), wc, 0);
+	}
+
+	/* Update s_last now that we are finished with the SWQE */
+	spin_lock_irqsave(&sqp->s_lock, flags);
+	if (++sqp->s_last >= sqp->s_size)
+		sqp->s_last = 0;
+	spin_unlock_irqrestore(&sqp->s_lock, flags);
+	goto again;
+
+done:
+	if (atomic_dec_and_test(&qp->refcount))
+		wake_up(&qp->wait);
+}
+
+/*
+ * Flush send work queue.
+ * The QP s_lock should be held.
+ */
+static void ipath_get_credit(struct ipath_qp *qp, u32 aeth)
+{
+	u32 credit = (aeth >> 24) & 0x1F;
+
+	/*
+	 * If credit == 0x1F, credit is invalid and we can send
+	 * as many packets as we like.  Otherwise, we have to
+	 * honor the credit field.
+	 */
+	if (credit == 0x1F) {
+		qp->s_lsn = (u32) -1;
+	} else if (qp->s_lsn != (u32) -1) {
+		/* Compute new LSN (i.e., MSN + credit) */
+		credit = (aeth + credit_table[credit]) & 0xFFFFFF;
+		if (cmp24(credit, qp->s_lsn) > 0)
+			qp->s_lsn = credit;
+	}
+
+	/* Restart sending if it was blocked due to lack of credits. */
+	if (qp->s_cur != qp->s_head &&
+	    (qp->s_lsn == (u32) -1 ||
+	     cmp24(get_swqe_ptr(qp, qp->s_cur)->ssn, qp->s_lsn + 1) <= 0)) {
+		tasklet_schedule(&qp->s_task);
+	}
+}
+
+/*
+ * This is called from ipath_rc_rcv() to process an incomming RC ACK
+ * for the given QP.
+ * Called at interrupt level with the QP s_lock held.
+ * Returns 1 if OK, 0 if current operation should be aborted (NAK).
+ */
+static int do_rc_ack(struct ipath_qp *qp, u32 aeth, u32 psn, int opcode)
+{
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ib_wc wc;
+	struct ipath_swqe *wqe;
+
+	/*
+	 * Remove the QP from the timeout queue (or RNR timeout queue).
+	 * If ipath_ib_timer() has already removed it,
+	 * it's OK since we hold the QP s_lock and ipath_restart_rc()
+	 * just won't find anything to restart if we ACK everything.
+	 */
+	spin_lock(&dev->pending_lock);
+	if (qp->timerwait.next != LIST_POISON1)
+		list_del(&qp->timerwait);
+	spin_unlock(&dev->pending_lock);
+
+	/*
+	 * Note that NAKs implicitly ACK outstanding SEND and
+	 * RDMA write requests and implicitly NAK RDMA read and
+	 * atomic requests issued before the NAK'ed request.
+	 * The MSN won't include the NAK'ed request but will include
+	 * an ACK'ed request(s).
+	 */
+	wqe = get_swqe_ptr(qp, qp->s_last);
+
+	/* Nothing is pending to ACK/NAK. */
+	if (qp->s_last == qp->s_tail)
+		return 0;
+
+	/*
+	 * The MSN might be for a later WQE than the PSN indicates so
+	 * only complete WQEs that the PSN finishes.
+	 */
+	while (cmp24(psn, wqe->lpsn) >= 0) {
+		/* If we are ACKing a WQE, the MSN should be >= the SSN. */
+		if (cmp24(aeth, wqe->ssn) < 0)
+			break;
+		/*
+		 * If this request is a RDMA read or atomic, and the ACK is
+		 * for a later operation, this ACK NAKs the RDMA read or atomic.
+		 * In other words, only a RDMA_READ_LAST or ONLY can ACK
+		 * a RDMA read and likewise for atomic ops.
+		 * Note that the NAK case can only happen if relaxed ordering
+		 * is used and requests are sent after an RDMA read
+		 * or atomic is sent but before the response is received.
+		 */
+		if ((wqe->wr.opcode == IB_WR_RDMA_READ &&
+		     opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) ||
+		    ((wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		      wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) &&
+		     (opcode != IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE ||
+		      cmp24(wqe->psn, psn) != 0))) {
+			/* The last valid PSN seen is the previous request's. */
+			qp->s_last_psn = wqe->psn - 1;
+			/* Retry this request. */
+			ipath_restart_rc(qp, wqe->psn, &wc);
+			/*
+			 * No need to process the ACK/NAK since we are
+			 * restarting an earlier request.
+			 */
+			return 0;
+		}
+		/* Post a send completion queue entry if requested. */
+		if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &qp->s_flags) ||
+		    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
+			wc.wr_id = wqe->wr.wr_id;
+			wc.status = IB_WC_SUCCESS;
+			wc.opcode = wc_opcode[wqe->wr.opcode];
+			wc.vendor_err = 0;
+			wc.byte_len = wqe->length;
+			wc.qp_num = qp->ibqp.qp_num;
+			wc.src_qp = qp->remote_qpn;
+			wc.pkey_index = 0;
+			wc.slid = qp->remote_ah_attr.dlid;
+			wc.sl = qp->remote_ah_attr.sl;
+			wc.dlid_path_bits = 0;
+			wc.port_num = 0;
+			ipath_cq_enter(to_icq(qp->ibqp.send_cq), &wc, 0);
+		}
+		qp->s_retry = qp->s_retry_cnt;
+		/*
+		 * If we are completing a request which is in the process
+		 * of being resent, we can stop resending it since we know
+		 * the responder has already seen it.
+		 */
+		if (qp->s_last == qp->s_cur) {
+			if (++qp->s_cur >= qp->s_size)
+				qp->s_cur = 0;
+			wqe = get_swqe_ptr(qp, qp->s_cur);
+			qp->s_state = IB_OPCODE_RC_SEND_LAST;
+			qp->s_psn = wqe->psn;
+		}
+		if (++qp->s_last >= qp->s_size)
+			qp->s_last = 0;
+		wqe = get_swqe_ptr(qp, qp->s_last);
+		if (qp->s_last == qp->s_tail)
+			break;
+	}
+
+	switch (aeth >> 29) {
+	case 0:		/* ACK */
+		dev->n_rc_acks++;
+		/* If this is a partial ACK, reset the retransmit timer. */
+		if (qp->s_last != qp->s_tail) {
+			spin_lock(&dev->pending_lock);
+			list_add_tail(&qp->timerwait,
+				      &dev->pending[dev->pending_index]);
+			spin_unlock(&dev->pending_lock);
+		}
+		ipath_get_credit(qp, aeth);
+		qp->s_rnr_retry = qp->s_rnr_retry_cnt;
+		qp->s_retry = qp->s_retry_cnt;
+		qp->s_last_psn = psn;
+		return 1;
+
+	case 1:		/* RNR NAK */
+		dev->n_rnr_naks++;
+		if (qp->s_rnr_retry == 0) {
+			if (qp->s_last == qp->s_tail)
+				return 0;
+
+			wc.status = IB_WC_RNR_RETRY_EXC_ERR;
+			goto class_b;
+		}
+		if (qp->s_rnr_retry_cnt < 7)
+			qp->s_rnr_retry--;
+		if (qp->s_last == qp->s_tail)
+			return 0;
+
+		/* The last valid PSN seen is the previous request's. */
+		qp->s_last_psn = wqe->psn - 1;
+
+		/* Restart this request after the RNR timeout. */
+		wqe = get_swqe_ptr(qp, qp->s_last);
+
+		dev->n_rc_resends += (int)qp->s_psn - (int)psn;
+
+		/*
+		 * If we are starting the request from the beginning, let the
+		 * normal send code handle initialization.
+		 */
+		qp->s_cur = qp->s_last;
+		if (cmp24(psn, wqe->psn) <= 0) {
+			qp->s_state = IB_OPCODE_RC_SEND_LAST;
+			qp->s_psn = wqe->psn;
+		} else {
+			u32 n;
+
+			n = qp->s_cur;
+			for (;;) {
+				if (++n == qp->s_size)
+					n = 0;
+				if (n == qp->s_tail) {
+					if (cmp24(psn, qp->s_next_psn) >= 0) {
+						qp->s_cur = n;
+						wqe = get_swqe_ptr(qp, n);
+					}
+					break;
+				}
+				wqe = get_swqe_ptr(qp, n);
+				if (cmp24(psn, wqe->psn) < 0)
+					break;
+				qp->s_cur = n;
+			}
+			qp->s_psn = psn;
+
+			/*
+			 * Set the state to restart in the middle of a request.
+			 * Don't change the s_sge, s_cur_sge, or s_cur_size.
+			 * See do_rc_send().
+			 */
+			switch (wqe->wr.opcode) {
+			case IB_WR_SEND:
+			case IB_WR_SEND_WITH_IMM:
+				qp->s_state =
+					IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
+				break;
+
+			case IB_WR_RDMA_WRITE:
+			case IB_WR_RDMA_WRITE_WITH_IMM:
+				qp->s_state =
+					IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
+				break;
+
+			case IB_WR_RDMA_READ:
+				qp->s_state =
+					IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
+				break;
+
+			default:
+				/*
+				 * This case shouldn't happen since its only
+				 * one PSN per req.
+				 */
+				qp->s_state = IB_OPCODE_RC_SEND_LAST;
+			}
+		}
+
+		qp->s_rnr_timeout = rnr_table[(aeth >> 24) & 0x1F];
+		insert_rnr_queue(qp);
+		return 0;
+
+	case 3:		/* NAK */
+		/* The last valid PSN seen is the previous request's. */
+		if (qp->s_last != qp->s_tail)
+			qp->s_last_psn = wqe->psn - 1;
+		switch ((aeth >> 24) & 0x1F) {
+		case 0:	/* PSN sequence error */
+			dev->n_seq_naks++;
+			/*
+			 * Back up to the responder's expected PSN.
+			 * XXX Note that we might get a NAK in the
+			 * middle of an RDMA READ response which
+			 * terminates the RDMA READ.
+			 */
+			if (qp->s_last == qp->s_tail)
+				break;
+
+			if (cmp24(psn, wqe->psn) < 0) {
+				break;
+			}
+			/* Retry the request. */
+			ipath_restart_rc(qp, psn, &wc);
+			break;
+
+		case 1:	/* Invalid Request */
+			wc.status = IB_WC_REM_INV_REQ_ERR;
+			dev->n_other_naks++;
+			goto class_b;
+
+		case 2:	/* Remote Access Error */
+			wc.status = IB_WC_REM_ACCESS_ERR;
+			dev->n_other_naks++;
+			goto class_b;
+
+		case 3:	/* Remote Operation Error */
+			wc.status = IB_WC_REM_OP_ERR;
+			dev->n_other_naks++;
+		      class_b:
+			wc.wr_id = wqe->wr.wr_id;
+			wc.opcode = wc_opcode[wqe->wr.opcode];
+			wc.vendor_err = 0;
+			wc.byte_len = 0;
+			wc.qp_num = qp->ibqp.qp_num;
+			wc.src_qp = qp->remote_qpn;
+			wc.pkey_index = 0;
+			wc.slid = qp->remote_ah_attr.dlid;
+			wc.sl = qp->remote_ah_attr.sl;
+			wc.dlid_path_bits = 0;
+			wc.port_num = 0;
+			ipath_sqerror_qp(qp, &wc);
+			break;
+
+		default:
+			/* Ignore other reserved NAK error codes */
+			goto reserved;
+		}
+		qp->s_rnr_retry = qp->s_rnr_retry_cnt;
+		return 0;
+
+	default:		/* 2: reserved */
+	      reserved:
+		/* Ignore reserved NAK codes. */
+		return 0;
+	}
+}
+
+/*
+ * This is called from ipath_qp_rcv() to process an incomming RC packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+static void ipath_rc_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
+			 int has_grh, void *data, u32 tlen, struct ipath_qp *qp)
+{
+	struct ipath_other_headers *ohdr;
+	int opcode;
+	u32 hdrsize;
+	u32 psn;
+	u32 pad;
+	unsigned long flags;
+	struct ib_wc wc;
+	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
+	int diff;
+	struct ib_reth *reth;
+
+	/* Check for GRH */
+	if (!has_grh) {
+		ohdr = &hdr->u.oth;
+		hdrsize = 8 + 12;	/* LRH + BTH */
+		psn = be32_to_cpu(ohdr->bth[2]);
+	} else {
+		ohdr = &hdr->u.l.oth;
+		hdrsize = 8 + 40 + 12;	/* LRH + GRH + BTH */
+		/*
+		 * The header with GRH is 60 bytes and the
+		 * core driver sets the eager header buffer
+		 * size to 56 bytes so the last 4 bytes of
+		 * the BTH header (PSN) is in the data buffer.
+		 */
+		psn = be32_to_cpu(((u32 *) data)[0]);
+		data += sizeof(u32);
+	}
+	/*
+	 * The opcode is in the low byte when its in network order
+	 * (top byte when in host order).
+	 */
+	opcode = *(u8 *) (&ohdr->bth[0]);
+
+	/*
+	 * Process responses (ACKs) before anything else.
+	 * Note that the packet sequence number will be for something
+	 * in the send work queue rather than the expected receive
+	 * packet sequence number.  In other words, this QP is the
+	 * requester.
+	 */
+	if (opcode >= IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST &&
+	    opcode <= IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE) {
+
+		spin_lock_irqsave(&qp->s_lock, flags);
+
+		/* Ignore invalid responses. */
+		if (cmp24(psn, qp->s_next_psn) >= 0) {
+			goto ack_done;
+		}
+
+		/* Ignore duplicate responses. */
+		diff = cmp24(psn, qp->s_last_psn);
+		if (unlikely(diff <= 0)) {
+			/* Update credits for "ghost" ACKs */
+			if (diff == 0 && opcode == IB_OPCODE_RC_ACKNOWLEDGE) {
+				if (!has_grh) {
+					pad = be32_to_cpu(ohdr->u.aeth);
+				} else {
+					pad = be32_to_cpu(((u32 *) data)[0]);
+					data += sizeof(u32);
+				}
+				if ((pad >> 29) == 0) {
+					ipath_get_credit(qp, pad);
+				}
+			}
+			goto ack_done;
+		}
+
+		switch (opcode) {
+		case IB_OPCODE_RC_ACKNOWLEDGE:
+		case IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE:
+		case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
+			if (!has_grh) {
+				pad = be32_to_cpu(ohdr->u.aeth);
+			} else {
+				pad = be32_to_cpu(((u32 *) data)[0]);
+				data += sizeof(u32);
+			}
+			if (opcode == IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE) {
+				*(u64 *) qp->s_sge.sge.vaddr = *(u64 *) data;
+			}
+			if (!do_rc_ack(qp, pad, psn, opcode) ||
+			    opcode != IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST) {
+				goto ack_done;
+			}
+			hdrsize += 4;
+			/*
+			 * do_rc_ack() has already checked the PSN so skip
+			 * the sequence check.
+			 */
+			goto rdma_read;
+
+		case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+			/* no AETH, no ACK */
+			if (unlikely(cmp24(psn, qp->s_last_psn + 1) != 0)) {
+				dev->n_rdma_seq++;
+				ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+				goto ack_done;
+			}
+		      rdma_read:
+			if (unlikely(qp->s_state !=
+				     IB_OPCODE_RC_RDMA_READ_REQUEST))
+				goto ack_done;
+			if (unlikely(tlen != (hdrsize + pmtu + 4)))
+				goto ack_done;
+			if (unlikely(pmtu >= qp->s_len))
+				goto ack_done;
+			/* We got a response so update the timeout. */
+			if (unlikely(qp->s_last == qp->s_tail ||
+				     get_swqe_ptr(qp, qp->s_last)->wr.opcode !=
+				     IB_WR_RDMA_READ))
+				goto ack_done;
+			spin_lock(&dev->pending_lock);
+			if (qp->s_rnr_timeout == 0 &&
+			    qp->timerwait.next != LIST_POISON1) {
+				list_move_tail(&qp->timerwait,
+					       &dev->pending[dev->
+							     pending_index]);
+			}
+			spin_unlock(&dev->pending_lock);
+			/*
+			 * Update the RDMA receive state but do the copy w/o
+			 * holding the locks and blocking interrupts.
+			 * XXX Yet another place that affects relaxed
+			 * RDMA order since we don't want s_sge modified.
+			 */
+			qp->s_len -= pmtu;
+			qp->s_last_psn = psn;
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+			copy_sge(&qp->s_sge, data, pmtu);
+			return;
+
+		case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
+			/* ACKs READ req. */
+			if (unlikely(cmp24(psn, qp->s_last_psn + 1) != 0)) {
+				dev->n_rdma_seq++;
+				ipath_restart_rc(qp, qp->s_last_psn + 1, &wc);
+				goto ack_done;
+			}
+			/* FALLTHROUGH */
+		case IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY:
+			if (unlikely(qp->s_state !=
+				     IB_OPCODE_RC_RDMA_READ_REQUEST)) {
+				goto ack_done;
+			}
+			/* Get the number of bytes the message was padded by. */
+			pad = (ohdr->bth[0] >> 12) & 3;
+			/*
+			 * Check that the data size is >= 1 && <= pmtu.
+			 * Remember to account for the AETH header (4)
+			 * and ICRC (4).
+			 */
+			if (unlikely(tlen <= (hdrsize + pad + 8))) {
+				/* XXX Need to generate an error CQ entry. */
+				goto ack_done;
+			}
+			tlen -= hdrsize + pad + 8;
+			if (unlikely(tlen != qp->s_len)) {
+				/* XXX Need to generate an error CQ entry. */
+				goto ack_done;
+			}
+			if (!has_grh) {
+				pad = be32_to_cpu(ohdr->u.aeth);
+			} else {
+				pad = be32_to_cpu(((u32 *) data)[0]);
+				data += sizeof(u32);
+			}
+			copy_sge(&qp->s_sge, data, tlen);
+			if (do_rc_ack(qp, pad, psn,
+				      IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST)) {
+				/*
+				 * Change the state so we contimue
+				 * processing new requests.
+				 */
+				qp->s_state = IB_OPCODE_RC_SEND_LAST;
+			}
+			goto ack_done;
+		}
+	      ack_done:
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		return;
+	}
+
+	spin_lock_irqsave(&qp->r_rq.lock, flags);
+
+	/* Compute 24 bits worth of difference. */
+	diff = cmp24(psn, qp->r_psn);
+	if (unlikely(diff)) {
+		if (diff > 0) {
+			/*
+			 * Packet sequence error.
+			 * A NAK will ACK earlier sends and RDMA writes.
+			 * Don't queue the NAK if a RDMA read, atomic, or
+			 * NAK is pending though.
+			 */
+			spin_lock(&qp->s_lock);
+			if ((qp->s_ack_state >=
+			     IB_OPCODE_RC_RDMA_READ_REQUEST &&
+			     qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) ||
+			    qp->s_nak_state != 0) {
+				spin_unlock(&qp->s_lock);
+				goto done;
+			}
+			qp->s_ack_state = IB_OPCODE_RC_SEND_ONLY;
+			qp->s_nak_state = IB_NAK_PSN_ERROR;
+			/* Use the expected PSN. */
+			qp->s_ack_psn = qp->r_psn;
+			goto resched;
+		}
+
+		/*
+		 * Handle a duplicate request.
+		 * Don't re-execute SEND, RDMA write or atomic op.
+		 * Don't NAK errors, just silently drop the duplicate request.
+		 * Note that r_sge, r_len, and r_rcv_len may be
+		 * in use so don't modify them.
+		 *
+		 * We are supposed to ACK the earliest duplicate PSN
+		 * but we can coalesce an outstanding duplicate ACK.
+		 * We have to send the earliest so that RDMA reads
+		 * can be restarted at the requester's expected PSN.
+		 */
+		spin_lock(&qp->s_lock);
+		if (qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE &&
+		    cmp24(psn, qp->s_ack_psn) >= 0) {
+			if (qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST)
+				qp->s_ack_psn = psn;
+			spin_unlock(&qp->s_lock);
+			goto done;
+		}
+		switch (opcode) {
+		case IB_OPCODE_RC_RDMA_READ_REQUEST:
+			/*
+			 * We have to be careful to not change s_rdma_sge
+			 * while do_rc_send() is using it and not holding
+			 * the s_lock.
+			 */
+			if (qp->s_ack_state != IB_OPCODE_RC_ACKNOWLEDGE &&
+			    qp->s_ack_state >= IB_OPCODE_RDMA_READ_REQUEST) {
+				spin_unlock(&qp->s_lock);
+				dev->n_rdma_dup_busy++;
+				goto done;
+			}
+			/* RETH comes after BTH */
+			if (!has_grh)
+				reth = &ohdr->u.rc.reth;
+			else {
+				reth = (struct ib_reth *)data;
+				data += sizeof(*reth);
+			}
+			qp->s_rdma_len = be32_to_cpu(reth->length);
+			if (qp->s_rdma_len != 0) {
+				u32 rkey = be32_to_cpu(reth->rkey);
+				u64 vaddr = be64_to_cpu(reth->vaddr);
+
+				/*
+				 * Address range must be a subset of the
+				 * original request and start on pmtu
+				 * boundaries.
+				 */
+				if (unlikely(!ipath_rkey_ok(dev,
+							    &qp->s_rdma_sge,
+							    qp->s_rdma_len,
+							    vaddr, rkey,
+							    IB_ACCESS_REMOTE_READ)))
+				{
+					goto done;
+				}
+			} else {
+				qp->s_rdma_sge.sg_list = NULL;
+				qp->s_rdma_sge.num_sge = 0;
+				qp->s_rdma_sge.sge.mr = NULL;
+				qp->s_rdma_sge.sge.vaddr = NULL;
+				qp->s_rdma_sge.sge.length = 0;
+				qp->s_rdma_sge.sge.sge_length = 0;
+			}
+			break;
+
+		case IB_OPCODE_RC_COMPARE_SWAP:
+		case IB_OPCODE_RC_FETCH_ADD:
+			/*
+			 * Check for the PSN of the last atomic operations
+			 * performed and resend the result if found.
+			 */
+			if ((psn & 0xFFFFFF) != qp->r_atomic_psn) {
+				spin_unlock(&qp->s_lock);
+				goto done;
+			}
+			qp->s_ack_atomic = qp->r_atomic_data;
+			break;
+		}
+		qp->s_ack_state = opcode;
+		qp->s_nak_state = 0;
+		qp->s_ack_psn = psn;
+		goto resched;
+	}
+
+	/* Check for opcode sequence errors. */
+	switch (qp->r_state) {
+	case IB_OPCODE_RC_SEND_FIRST:
+	case IB_OPCODE_RC_SEND_MIDDLE:
+		if (opcode == IB_OPCODE_RC_SEND_MIDDLE ||
+		    opcode == IB_OPCODE_RC_SEND_LAST ||
+		    opcode == IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE)
+			break;
+	      nack_inv:
+		/*
+		 * A NAK will ACK earlier sends and RDMA writes.
+		 * Don't queue the NAK if a RDMA read, atomic, or
+		 * NAK is pending though.
+		 */
+		spin_lock(&qp->s_lock);
+		if (qp->s_ack_state >= IB_OPCODE_RC_RDMA_READ_REQUEST &&
+		    qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) {
+			spin_unlock(&qp->s_lock);
+			goto done;
+		}
+		/* XXX Flush WQEs */
+		qp->state = IB_QPS_ERR;
+		qp->s_ack_state = IB_OPCODE_RC_SEND_ONLY;
+		qp->s_nak_state = IB_NAK_INVALID_REQUEST;
+		qp->s_ack_psn = qp->r_psn;
+		goto resched;
+
+	case IB_OPCODE_RC_RDMA_WRITE_FIRST:
+	case IB_OPCODE_RC_RDMA_WRITE_MIDDLE:
+		if (opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE ||
+		    opcode == IB_OPCODE_RC_RDMA_WRITE_LAST ||
+		    opcode == IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE)
+			break;
+		goto nack_inv;
+
+	case IB_OPCODE_RC_RDMA_READ_REQUEST:
+	case IB_OPCODE_RC_COMPARE_SWAP:
+	case IB_OPCODE_RC_FETCH_ADD:
+		/*
+		 * Drop all new requests until a response has been sent.
+		 * A new request then ACKs the RDMA response we sent.
+		 * Relaxed ordering would allow new requests to be
+		 * processed but we would need to keep a queue
+		 * of rwqe's for all that are in progress.
+		 * Note that we can't RNR NAK this request since the RDMA
+		 * READ or atomic response is already queued to be sent
+		 * (unless we implement a response send queue).
+		 */
+		goto done;
+
+	default:
+		if (opcode == IB_OPCODE_RC_SEND_MIDDLE ||
+		    opcode == IB_OPCODE_RC_SEND_LAST ||
+		    opcode == IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE ||
+		    opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE ||
+		    opcode == IB_OPCODE_RC_RDMA_WRITE_LAST ||
+		    opcode == IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE)
+			goto nack_inv;
+		break;
+	}
+
+	wc.imm_data = 0;
+	wc.wc_flags = 0;
+
+	/* OK, process the packet. */
+	switch (opcode) {
+	case IB_OPCODE_RC_SEND_FIRST:
+		if (!get_rwqe(qp, 0)) {
+		      rnr_nak:
+			/*
+			 * A RNR NAK will ACK earlier sends and RDMA writes.
+			 * Don't queue the NAK if a RDMA read or atomic
+			 * is pending though.
+			 */
+			spin_lock(&qp->s_lock);
+			if (qp->s_ack_state >= IB_OPCODE_RC_RDMA_READ_REQUEST &&
+			    qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) {
+				spin_unlock(&qp->s_lock);
+				goto done;
+			}
+			qp->s_ack_state = IB_OPCODE_RC_SEND_ONLY;
+			qp->s_nak_state = IB_RNR_NAK | qp->s_min_rnr_timer;
+			qp->s_ack_psn = qp->r_psn;
+			goto resched;
+		}
+		qp->r_rcv_len = 0;
+		/* FALLTHROUGH */
+	case IB_OPCODE_RC_SEND_MIDDLE:
+	case IB_OPCODE_RC_RDMA_WRITE_MIDDLE:
+	      send_middle:
+		/* Check for invalid length PMTU or posted rwqe len. */
+		if (unlikely(tlen != (hdrsize + pmtu + 4))) {
+			goto nack_inv;
+		}
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len)) {
+			goto nack_inv;
+		}
+		copy_sge(&qp->r_sge, data, pmtu);
+		break;
+
+	case IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE:
+		/* consume RWQE */
+		if (!get_rwqe(qp, 1))
+			goto rnr_nak;
+		goto send_last_imm;
+
+	case IB_OPCODE_RC_SEND_ONLY:
+	case IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE:
+		if (!get_rwqe(qp, 0))
+			goto rnr_nak;
+		qp->r_rcv_len = 0;
+		if (opcode == IB_OPCODE_RC_SEND_ONLY)
+			goto send_last;
+		/* FALLTHROUGH */
+	case IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE:
+	      send_last_imm:
+		if (has_grh) {
+			wc.imm_data = *(u32 *) data;
+			data += sizeof(u32);
+		} else {
+			/* Immediate data comes after BTH */
+			wc.imm_data = ohdr->u.imm_data;
+		}
+		hdrsize += 4;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		/* FALLTHROUGH */
+	case IB_OPCODE_RC_SEND_LAST:
+	case IB_OPCODE_RC_RDMA_WRITE_LAST:
+	      send_last:
+		/* Get the number of bytes the message was padded by. */
+		pad = (ohdr->bth[0] >> 12) & 3;
+		/* Check for invalid length. */
+		/* XXX LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4))) {
+			goto nack_inv;
+		}
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + pad + 4);
+		wc.byte_len = tlen + qp->r_rcv_len;
+		if (unlikely(wc.byte_len > qp->r_len)) {
+			goto nack_inv;
+		}
+		/* XXX Need to free SGEs */
+		copy_sge(&qp->r_sge, data, tlen);
+		atomic_inc(&qp->msn);
+		if (opcode == IB_OPCODE_RC_RDMA_WRITE_LAST ||
+		    opcode == IB_OPCODE_RC_RDMA_WRITE_ONLY)
+			break;
+		wc.wr_id = qp->r_wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.opcode = IB_WC_RECV;
+		wc.vendor_err = 0;
+		wc.qp_num = qp->ibqp.qp_num;
+		wc.src_qp = qp->remote_qpn;
+		wc.pkey_index = 0;
+		wc.slid = qp->remote_ah_attr.dlid;
+		wc.sl = qp->remote_ah_attr.sl;
+		wc.dlid_path_bits = 0;
+		wc.port_num = 0;
+		/* Signal completion event if the solicited bit is set. */
+		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
+			       ohdr->bth[0] & __constant_cpu_to_be32(1 << 23));
+		break;
+
+	case IB_OPCODE_RC_RDMA_WRITE_FIRST:
+	case IB_OPCODE_RC_RDMA_WRITE_ONLY:
+	case IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE:
+		/* consume RWQE */
+		/* RETH comes after BTH */
+		if (!has_grh)
+			reth = &ohdr->u.rc.reth;
+		else {
+			reth = (struct ib_reth *)data;
+			data += sizeof(*reth);
+		}
+		hdrsize += sizeof(*reth);
+		qp->r_len = be32_to_cpu(reth->length);
+		qp->r_rcv_len = 0;
+		if (qp->r_len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = be64_to_cpu(reth->vaddr);
+
+			/* Check rkey & NAK */
+			if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, qp->r_len,
+						    vaddr, rkey,
+						    IB_ACCESS_REMOTE_WRITE))) {
+			      nack_acc:
+				/*
+				 * A NAK will ACK earlier sends and RDMA
+				 * writes.
+				 * Don't queue the NAK if a RDMA read,
+				 * atomic, or NAK is pending though.
+				 */
+				spin_lock(&qp->s_lock);
+				if (qp->s_ack_state >=
+				    IB_OPCODE_RC_RDMA_READ_REQUEST &&
+				    qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) {
+					spin_unlock(&qp->s_lock);
+					goto done;
+				}
+				/* XXX Flush WQEs */
+				qp->state = IB_QPS_ERR;
+				qp->s_ack_state = IB_OPCODE_RC_RDMA_WRITE_ONLY;
+				qp->s_nak_state = IB_NAK_REMOTE_ACCESS_ERROR;
+				qp->s_ack_psn = qp->r_psn;
+				goto resched;
+			}
+		} else {
+			qp->r_sge.sg_list = NULL;
+			qp->r_sge.sge.mr = NULL;
+			qp->r_sge.sge.vaddr = NULL;
+			qp->r_sge.sge.length = 0;
+			qp->r_sge.sge.sge_length = 0;
+		}
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_WRITE)))
+			goto nack_acc;
+		if (opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST)
+			goto send_middle;
+		else if (opcode == IB_OPCODE_RC_RDMA_WRITE_ONLY)
+			goto send_last;
+		if (!get_rwqe(qp, 1))
+			goto rnr_nak;
+		goto send_last_imm;
+
+	case IB_OPCODE_RC_RDMA_READ_REQUEST:
+		/* RETH comes after BTH */
+		if (!has_grh)
+			reth = &ohdr->u.rc.reth;
+		else {
+			reth = (struct ib_reth *)data;
+			data += sizeof(*reth);
+		}
+		spin_lock(&qp->s_lock);
+		if (qp->s_ack_state != IB_OPCODE_RC_ACKNOWLEDGE &&
+		    qp->s_ack_state >= IB_OPCODE_RDMA_READ_REQUEST) {
+			spin_unlock(&qp->s_lock);
+			goto done;
+		}
+		qp->s_rdma_len = be32_to_cpu(reth->length);
+		if (qp->s_rdma_len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = be64_to_cpu(reth->vaddr);
+
+			/* Check rkey & NAK */
+			if (unlikely(!ipath_rkey_ok(dev, &qp->s_rdma_sge,
+						    qp->s_rdma_len,
+						    vaddr, rkey,
+						    IB_ACCESS_REMOTE_READ))) {
+				spin_unlock(&qp->s_lock);
+				goto nack_acc;
+			}
+			/*
+			 * Update the next expected PSN.
+			 * We add 1 later below, so only add the remainder here.
+			 */
+			if (qp->s_rdma_len > pmtu)
+				qp->r_psn += (qp->s_rdma_len - 1) / pmtu;
+		} else {
+			qp->s_rdma_sge.sg_list = NULL;
+			qp->s_rdma_sge.num_sge = 0;
+			qp->s_rdma_sge.sge.mr = NULL;
+			qp->s_rdma_sge.sge.vaddr = NULL;
+			qp->s_rdma_sge.sge.length = 0;
+			qp->s_rdma_sge.sge.sge_length = 0;
+		}
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_READ)))
+			goto nack_acc;
+		/*
+		 * We need to increment the MSN here instead of when we
+		 * finish sending the result since a duplicate request would
+		 * increment it more than once.
+		 */
+		atomic_inc(&qp->msn);
+		qp->s_ack_state = opcode;
+		qp->s_nak_state = 0;
+		qp->s_ack_psn = psn;
+		qp->r_psn++;
+		qp->r_state = opcode;
+		goto rdmadone;
+
+	case IB_OPCODE_RC_COMPARE_SWAP:
+	case IB_OPCODE_RC_FETCH_ADD:{
+			struct ib_atomic_eth *ateth;
+			u64 vaddr;
+			u64 sdata;
+			u32 rkey;
+
+			if (!has_grh)
+				ateth = &ohdr->u.atomic_eth;
+			else {
+				ateth = (struct ib_atomic_eth *)data;
+				data += sizeof(*ateth);
+			}
+			vaddr = be64_to_cpu(ateth->vaddr);
+			if (unlikely(vaddr & 0x7))
+				goto nack_inv;
+			rkey = be32_to_cpu(ateth->rkey);
+			/* Check rkey & NAK */
+			if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge,
+						    sizeof(u64), vaddr, rkey,
+						    IB_ACCESS_REMOTE_ATOMIC))) {
+				goto nack_acc;
+			}
+			if (unlikely(!(qp->qp_access_flags &
+					IB_ACCESS_REMOTE_ATOMIC)))
+				goto nack_acc;
+			/* Perform atomic OP and save result. */
+			sdata = be64_to_cpu(ateth->swap_data);
+			spin_lock(&dev->pending_lock);
+			qp->r_atomic_data = *(u64 *) qp->r_sge.sge.vaddr;
+			if (opcode == IB_OPCODE_RC_FETCH_ADD) {
+				*(u64 *) qp->r_sge.sge.vaddr =
+				    qp->r_atomic_data + sdata;
+			} else if (qp->r_atomic_data ==
+				   be64_to_cpu(ateth->compare_data)) {
+				*(u64 *) qp->r_sge.sge.vaddr = sdata;
+			}
+			spin_unlock(&dev->pending_lock);
+			atomic_inc(&qp->msn);
+			qp->r_atomic_psn = psn & 0xFFFFFF;
+			psn |= 1 << 31;
+			break;
+		}
+
+	default:
+		/* Drop packet for unknown opcodes. */
+		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		return;
+	}
+	qp->r_psn++;
+	qp->r_state = opcode;
+	/* Send an ACK if requested or required. */
+	if (psn & (1 << 31)) {
+		/*
+		 * Coalesce ACKs unless there is a RDMA READ or
+		 * ATOMIC pending.
+		 */
+		spin_lock(&qp->s_lock);
+		if (qp->s_ack_state == IB_OPCODE_RC_ACKNOWLEDGE ||
+		    qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST) {
+			qp->s_ack_state = opcode;
+			qp->s_nak_state = 0;
+			qp->s_ack_psn = psn;
+			qp->s_ack_atomic = qp->r_atomic_data;
+			goto resched;
+		}
+		spin_unlock(&qp->s_lock);
+	}
+done:
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+	return;
+
+resched:
+	/* Try to send ACK right away but not if do_rc_send() is active. */
+	if (qp->s_hdrwords == 0 &&
+	    (qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST ||
+	     qp->s_ack_state >= IB_OPCODE_COMPARE_SWAP))
+		send_rc_ack(qp);
+
+rdmadone:
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+
+	/* Call do_rc_send() in another thread. */
+	tasklet_schedule(&qp->s_task);
+}
