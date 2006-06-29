Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWF2Vo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWF2Vo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932911AbWF2Voi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:38 -0400
Received: from mx.pathscale.com ([64.160.42.68]:38287 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932917AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 29 of 39] IB/ipath - RC receive interrupt performance changes
X-Mercurial-Node: 1bef8244297aef83d9a66c0eaf3e48cb99c3cdf1
Message-Id: <1bef8244297aef83d9a6.1151617280@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:20 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch separates QP state used for sending and receiving
RC packets so the processing in the receive interrupt handler
can be done mostly without locks being held.  ACK packets are
now sent without requiring synchronization with the send tasklet.

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 5f3c0b2d446d -r 1bef8244297a drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Jun 29 14:33:26 2006 -0700
@@ -121,6 +121,7 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 		  struct ib_sge *sge, int acc)
 {
 	struct ipath_mregion *mr;
+	unsigned n, m;
 	size_t off;
 	int ret;
 
@@ -152,20 +153,22 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 	}
 
 	off += mr->offset;
+	m = 0;
+	n = 0;
+	while (off >= mr->map[m]->segs[n].length) {
+		off -= mr->map[m]->segs[n].length;
+		n++;
+		if (n >= IPATH_SEGSZ) {
+			m++;
+			n = 0;
+		}
+	}
 	isge->mr = mr;
-	isge->m = 0;
-	isge->n = 0;
-	while (off >= mr->map[isge->m]->segs[isge->n].length) {
-		off -= mr->map[isge->m]->segs[isge->n].length;
-		isge->n++;
-		if (isge->n >= IPATH_SEGSZ) {
-			isge->m++;
-			isge->n = 0;
-		}
-	}
-	isge->vaddr = mr->map[isge->m]->segs[isge->n].vaddr + off;
-	isge->length = mr->map[isge->m]->segs[isge->n].length - off;
+	isge->vaddr = mr->map[m]->segs[n].vaddr + off;
+	isge->length = mr->map[m]->segs[n].length - off;
 	isge->sge_length = sge->length;
+	isge->m = m;
+	isge->n = n;
 
 	ret = 1;
 
@@ -190,6 +193,7 @@ int ipath_rkey_ok(struct ipath_ibdev *de
 	struct ipath_lkey_table *rkt = &dev->lk_table;
 	struct ipath_sge *sge = &ss->sge;
 	struct ipath_mregion *mr;
+	unsigned n, m;
 	size_t off;
 	int ret;
 
@@ -207,20 +211,22 @@ int ipath_rkey_ok(struct ipath_ibdev *de
 	}
 
 	off += mr->offset;
+	m = 0;
+	n = 0;
+	while (off >= mr->map[m]->segs[n].length) {
+		off -= mr->map[m]->segs[n].length;
+		n++;
+		if (n >= IPATH_SEGSZ) {
+			m++;
+			n = 0;
+		}
+	}
 	sge->mr = mr;
-	sge->m = 0;
-	sge->n = 0;
-	while (off >= mr->map[sge->m]->segs[sge->n].length) {
-		off -= mr->map[sge->m]->segs[sge->n].length;
-		sge->n++;
-		if (sge->n >= IPATH_SEGSZ) {
-			sge->m++;
-			sge->n = 0;
-		}
-	}
-	sge->vaddr = mr->map[sge->m]->segs[sge->n].vaddr + off;
-	sge->length = mr->map[sge->m]->segs[sge->n].length - off;
+	sge->vaddr = mr->map[m]->segs[n].vaddr + off;
+	sge->length = mr->map[m]->segs[n].length - off;
 	sge->sge_length = len;
+	sge->m = m;
+	sge->n = n;
 	ss->sg_list = NULL;
 	ss->num_sge = 1;
 
diff -r 5f3c0b2d446d -r 1bef8244297a drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:26 2006 -0700
@@ -333,10 +333,11 @@ static void ipath_reset_qp(struct ipath_
 	qp->remote_qpn = 0;
 	qp->qkey = 0;
 	qp->qp_access_flags = 0;
+	clear_bit(IPATH_S_BUSY, &qp->s_flags);
 	qp->s_hdrwords = 0;
 	qp->s_psn = 0;
 	qp->r_psn = 0;
-	atomic_set(&qp->msn, 0);
+	qp->r_msn = 0;
 	if (qp->ibqp.qp_type == IB_QPT_RC) {
 		qp->s_state = IB_OPCODE_RC_SEND_LAST;
 		qp->r_state = IB_OPCODE_RC_SEND_LAST;
@@ -345,7 +346,8 @@ static void ipath_reset_qp(struct ipath_
 		qp->r_state = IB_OPCODE_UC_SEND_LAST;
 	}
 	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
-	qp->s_nak_state = 0;
+	qp->r_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
+	qp->r_nak_state = 0;
 	qp->s_rnr_timeout = 0;
 	qp->s_head = 0;
 	qp->s_tail = 0;
@@ -363,10 +365,10 @@ static void ipath_reset_qp(struct ipath_
  * @qp: the QP to put into an error state
  *
  * Flushes both send and receive work queues.
- * QP r_rq.lock and s_lock should be held.
- */
-
-static void ipath_error_qp(struct ipath_qp *qp)
+ * QP s_lock should be held and interrupts disabled.
+ */
+
+void ipath_error_qp(struct ipath_qp *qp)
 {
 	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ib_wc wc;
@@ -409,12 +411,14 @@ static void ipath_error_qp(struct ipath_
 	qp->s_ack_state = IB_OPCODE_RC_ACKNOWLEDGE;
 
 	wc.opcode = IB_WC_RECV;
+	spin_lock(&qp->r_rq.lock);
 	while (qp->r_rq.tail != qp->r_rq.head) {
 		wc.wr_id = get_rwqe_ptr(&qp->r_rq, qp->r_rq.tail)->wr_id;
 		if (++qp->r_rq.tail >= qp->r_rq.size)
 			qp->r_rq.tail = 0;
 		ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc, 1);
 	}
+	spin_unlock(&qp->r_rq.lock);
 }
 
 /**
@@ -434,8 +438,7 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&qp->r_rq.lock, flags);
-	spin_lock(&qp->s_lock);
+	spin_lock_irqsave(&qp->s_lock, flags);
 
 	cur_state = attr_mask & IB_QP_CUR_STATE ?
 		attr->cur_qp_state : qp->state;
@@ -506,31 +509,19 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_MIN_RNR_TIMER)
-		qp->s_min_rnr_timer = attr->min_rnr_timer;
+		qp->r_min_rnr_timer = attr->min_rnr_timer;
 
 	if (attr_mask & IB_QP_QKEY)
 		qp->qkey = attr->qkey;
 
 	qp->state = new_state;
-	spin_unlock(&qp->s_lock);
-	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
-
-	/*
-	 * If QP1 changed to the RTS state, try to move to the link to INIT
-	 * even if it was ACTIVE so the SM will reinitialize the SMA's
-	 * state.
-	 */
-	if (qp->ibqp.qp_num == 1 && new_state == IB_QPS_RTS) {
-		struct ipath_ibdev *dev = to_idev(ibqp->device);
-
-		ipath_layer_set_linkstate(dev->dd, IPATH_IB_LINKDOWN);
-	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
 	ret = 0;
 	goto bail;
 
 inval:
-	spin_unlock(&qp->s_lock);
-	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+	spin_unlock_irqrestore(&qp->s_lock, flags);
 	ret = -EINVAL;
 
 bail:
@@ -564,7 +555,7 @@ int ipath_query_qp(struct ib_qp *ibqp, s
 	attr->sq_draining = 0;
 	attr->max_rd_atomic = 1;
 	attr->max_dest_rd_atomic = 1;
-	attr->min_rnr_timer = qp->s_min_rnr_timer;
+	attr->min_rnr_timer = qp->r_min_rnr_timer;
 	attr->port_num = 1;
 	attr->timeout = 0;
 	attr->retry_cnt = qp->s_retry_cnt;
@@ -591,16 +582,12 @@ int ipath_query_qp(struct ib_qp *ibqp, s
  * @qp: the queue pair to compute the AETH for
  *
  * Returns the AETH.
- *
- * The QP s_lock should be held.
  */
 __be32 ipath_compute_aeth(struct ipath_qp *qp)
 {
-	u32 aeth = atomic_read(&qp->msn) & IPS_MSN_MASK;
-
-	if (qp->s_nak_state) {
-		aeth |= qp->s_nak_state << IPS_AETH_CREDIT_SHIFT;
-	} else if (qp->ibqp.srq) {
+	u32 aeth = qp->r_msn & IPS_MSN_MASK;
+
+	if (qp->ibqp.srq) {
 		/*
 		 * Shared receive queues don't generate credits.
 		 * Set the credit field to the invalid value.
diff -r 5f3c0b2d446d -r 1bef8244297a drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:26 2006 -0700
@@ -42,7 +42,7 @@
  * @qp: the QP who's SGE we're restarting
  * @wqe: the work queue to initialize the QP's SGE from
  *
- * The QP s_lock should be held.
+ * The QP s_lock should be held and interrupts disabled.
  */
 static void ipath_init_restart(struct ipath_qp *qp, struct ipath_swqe *wqe)
 {
@@ -77,7 +77,6 @@ u32 ipath_make_rc_ack(struct ipath_qp *q
 		      struct ipath_other_headers *ohdr,
 		      u32 pmtu)
 {
-	struct ipath_sge_state *ss;
 	u32 hwords;
 	u32 len;
 	u32 bth0;
@@ -91,7 +90,7 @@ u32 ipath_make_rc_ack(struct ipath_qp *q
 	 */
 	switch (qp->s_ack_state) {
 	case OP(RDMA_READ_REQUEST):
-		ss = &qp->s_rdma_sge;
+		qp->s_cur_sge = &qp->s_rdma_sge;
 		len = qp->s_rdma_len;
 		if (len > pmtu) {
 			len = pmtu;
@@ -108,7 +107,7 @@ u32 ipath_make_rc_ack(struct ipath_qp *q
 		qp->s_ack_state = OP(RDMA_READ_RESPONSE_MIDDLE);
 		/* FALLTHROUGH */
 	case OP(RDMA_READ_RESPONSE_MIDDLE):
-		ss = &qp->s_rdma_sge;
+		qp->s_cur_sge = &qp->s_rdma_sge;
 		len = qp->s_rdma_len;
 		if (len > pmtu)
 			len = pmtu;
@@ -127,41 +126,50 @@ u32 ipath_make_rc_ack(struct ipath_qp *q
 		 * We have to prevent new requests from changing
 		 * the r_sge state while a ipath_verbs_send()
 		 * is in progress.
-		 * Changing r_state allows the receiver
-		 * to continue processing new packets.
-		 * We do it here now instead of above so
-		 * that we are sure the packet was sent before
-		 * changing the state.
-		 */
-		qp->r_state = OP(RDMA_READ_RESPONSE_LAST);
+		 */
 		qp->s_ack_state = OP(ACKNOWLEDGE);
-		return 0;
+		bth0 = 0;
+		goto bail;
 
 	case OP(COMPARE_SWAP):
 	case OP(FETCH_ADD):
-		ss = NULL;
+		qp->s_cur_sge = NULL;
 		len = 0;
-		qp->r_state = OP(SEND_LAST);
-		qp->s_ack_state = OP(ACKNOWLEDGE);
-		bth0 = IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
+		/*
+		 * Set the s_ack_state so the receive interrupt handler
+		 * won't try to send an ACK (out of order) until this one
+		 * is actually sent.
+		 */
+		qp->s_ack_state = OP(RDMA_READ_RESPONSE_LAST);
+		bth0 = OP(ATOMIC_ACKNOWLEDGE) << 24;
 		ohdr->u.at.aeth = ipath_compute_aeth(qp);
-		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->s_ack_atomic);
+		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->r_atomic_data);
 		hwords += sizeof(ohdr->u.at) / 4;
 		break;
 
 	default:
 		/* Send a regular ACK. */
-		ss = NULL;
+		qp->s_cur_sge = NULL;
 		len = 0;
-		qp->s_ack_state = OP(ACKNOWLEDGE);
-		bth0 = qp->s_ack_state << 24;
-		ohdr->u.aeth = ipath_compute_aeth(qp);
+		/*
+		 * Set the s_ack_state so the receive interrupt handler
+		 * won't try to send an ACK (out of order) until this one
+		 * is actually sent.
+		 */
+		qp->s_ack_state = OP(RDMA_READ_RESPONSE_LAST);
+		bth0 = OP(ACKNOWLEDGE) << 24;
+		if (qp->s_nak_state)
+			ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPS_MSN_MASK) |
+						    (qp->s_nak_state <<
+						     IPS_AETH_CREDIT_SHIFT));
+		else
+			ohdr->u.aeth = ipath_compute_aeth(qp);
 		hwords++;
 	}
 	qp->s_hdrwords = hwords;
-	qp->s_cur_sge = ss;
 	qp->s_cur_size = len;
 
+bail:
 	return bth0;
 }
 
@@ -174,7 +182,7 @@ u32 ipath_make_rc_ack(struct ipath_qp *q
  * @bth2p: pointer to the BTH PSN word
  *
  * Return 1 if constructed; otherwise, return 0.
- * Note the QP s_lock must be held.
+ * Note the QP s_lock must be held and interrupts disabled.
  */
 int ipath_make_rc_req(struct ipath_qp *qp,
 		      struct ipath_other_headers *ohdr,
@@ -356,6 +364,11 @@ int ipath_make_rc_req(struct ipath_qp *q
 		bth2 |= qp->s_psn++ & IPS_PSN_MASK;
 		if ((int)(qp->s_psn - qp->s_next_psn) > 0)
 			qp->s_next_psn = qp->s_psn;
+		/*
+		 * Put the QP on the pending list so lost ACKs will cause
+		 * a retry.  More than one request can be pending so the
+		 * QP may already be on the dev->pending list.
+		 */
 		spin_lock(&dev->pending_lock);
 		if (list_empty(&qp->timerwait))
 			list_add_tail(&qp->timerwait,
@@ -365,8 +378,8 @@ int ipath_make_rc_req(struct ipath_qp *q
 
 	case OP(RDMA_READ_RESPONSE_FIRST):
 		/*
-		 * This case can only happen if a send is restarted.  See
-		 * ipath_restart_rc().
+		 * This case can only happen if a send is restarted.
+		 * See ipath_restart_rc().
 		 */
 		ipath_init_restart(qp, wqe);
 		/* FALLTHROUGH */
@@ -526,11 +539,17 @@ static void send_rc_ack(struct ipath_qp 
 		ohdr = &hdr.u.l.oth;
 		lrh0 = IPS_LRH_GRH;
 	}
+	/* read pkey_index w/o lock (its atomic) */
 	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
-	ohdr->u.aeth = ipath_compute_aeth(qp);
-	if (qp->s_ack_state >= OP(COMPARE_SWAP)) {
-		bth0 |= IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
-		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->s_ack_atomic);
+	if (qp->r_nak_state)
+		ohdr->u.aeth = cpu_to_be32((qp->r_msn & IPS_MSN_MASK) |
+					    (qp->r_nak_state <<
+					     IPS_AETH_CREDIT_SHIFT));
+	else
+		ohdr->u.aeth = ipath_compute_aeth(qp);
+	if (qp->r_ack_state >= OP(COMPARE_SWAP)) {
+		bth0 |= OP(ATOMIC_ACKNOWLEDGE) << 24;
+		ohdr->u.at.atomic_ack_eth = cpu_to_be64(qp->r_atomic_data);
 		hwords += sizeof(ohdr->u.at.atomic_ack_eth) / 4;
 	} else
 		bth0 |= OP(ACKNOWLEDGE) << 24;
@@ -541,15 +560,36 @@ static void send_rc_ack(struct ipath_qp 
 	hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
-	ohdr->bth[2] = cpu_to_be32(qp->s_ack_psn & IPS_PSN_MASK);
+	ohdr->bth[2] = cpu_to_be32(qp->r_ack_psn & IPS_PSN_MASK);
 
 	/*
 	 * If we can send the ACK, clear the ACK state.
 	 */
 	if (ipath_verbs_send(dev->dd, hwords, (u32 *) &hdr, 0, NULL) == 0) {
-		qp->s_ack_state = OP(ACKNOWLEDGE);
+		qp->r_ack_state = OP(ACKNOWLEDGE);
+		dev->n_unicast_xmit++;
+	} else {
+		/*
+		 * We are out of PIO buffers at the moment.
+		 * Pass responsibility for sending the ACK to the
+		 * send tasklet so that when a PIO buffer becomes
+		 * available, the ACK is sent ahead of other outgoing
+		 * packets.
+		 */
 		dev->n_rc_qacks++;
-		dev->n_unicast_xmit++;
+		spin_lock_irq(&qp->s_lock);
+		/* Don't coalesce if a RDMA read or atomic is pending. */
+		if (qp->s_ack_state == OP(ACKNOWLEDGE) ||
+		    qp->s_ack_state < OP(RDMA_READ_REQUEST)) {
+			qp->s_ack_state = qp->r_ack_state;
+			qp->s_nak_state = qp->r_nak_state;
+			qp->s_ack_psn = qp->r_ack_psn;
+			qp->r_ack_state = OP(ACKNOWLEDGE);
+		}
+		spin_unlock_irq(&qp->s_lock);
+
+		/* Call ipath_do_rc_send() in another thread. */
+		tasklet_hi_schedule(&qp->s_task);
 	}
 }
 
@@ -641,7 +681,7 @@ done:
  * @psn: packet sequence number for the request
  * @wc: the work completion request
  *
- * The QP s_lock should be held.
+ * The QP s_lock should be held and interrupts disabled.
  */
 void ipath_restart_rc(struct ipath_qp *qp, u32 psn, struct ib_wc *wc)
 {
@@ -705,7 +745,7 @@ bail:
  *
  * This is called from ipath_rc_rcv_resp() to process an incoming RC ACK
  * for the given QP.
- * Called at interrupt level with the QP s_lock held.
+ * Called at interrupt level with the QP s_lock held and interrupts disabled.
  * Returns 1 if OK, 0 if current operation should be aborted (NAK).
  */
 static int do_rc_ack(struct ipath_qp *qp, u32 aeth, u32 psn, int opcode)
@@ -1126,18 +1166,16 @@ static inline int ipath_rc_rcv_error(str
 		 * Don't queue the NAK if a RDMA read, atomic, or
 		 * NAK is pending though.
 		 */
-		spin_lock(&qp->s_lock);
-		if ((qp->s_ack_state >= OP(RDMA_READ_REQUEST) &&
-		     qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) ||
-		    qp->s_nak_state != 0) {
-			spin_unlock(&qp->s_lock);
+		if (qp->s_ack_state != OP(ACKNOWLEDGE) ||
+		    qp->r_nak_state != 0)
 			goto done;
-		}
-		qp->s_ack_state = OP(SEND_ONLY);
-		qp->s_nak_state = IB_NAK_PSN_ERROR;
-		/* Use the expected PSN. */
-		qp->s_ack_psn = qp->r_psn;
-		goto resched;
+		if (qp->r_ack_state < OP(COMPARE_SWAP)) {
+			qp->r_ack_state = OP(SEND_ONLY);
+			qp->r_nak_state = IB_NAK_PSN_ERROR;
+			/* Use the expected PSN. */
+			qp->r_ack_psn = qp->r_psn;
+		}
+		goto send_ack;
 	}
 
 	/*
@@ -1151,33 +1189,29 @@ static inline int ipath_rc_rcv_error(str
 	 * send the earliest so that RDMA reads can be restarted at
 	 * the requester's expected PSN.
 	 */
-	spin_lock(&qp->s_lock);
-	if (qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE &&
-	    ipath_cmp24(psn, qp->s_ack_psn) >= 0) {
-		if (qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST)
-			qp->s_ack_psn = psn;
-		spin_unlock(&qp->s_lock);
-		goto done;
-	}
-	switch (opcode) {
-	case OP(RDMA_READ_REQUEST):
-		/*
-		 * We have to be careful to not change s_rdma_sge
-		 * while ipath_do_rc_send() is using it and not
-		 * holding the s_lock.
-		 */
-		if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
-		    qp->s_ack_state >= IB_OPCODE_RDMA_READ_REQUEST) {
-			spin_unlock(&qp->s_lock);
-			dev->n_rdma_dup_busy++;
-			goto done;
-		}
+	if (opcode == OP(RDMA_READ_REQUEST)) {
 		/* RETH comes after BTH */
 		if (!header_in_data)
 			reth = &ohdr->u.rc.reth;
 		else {
 			reth = (struct ib_reth *)data;
 			data += sizeof(*reth);
+		}
+		/*
+		 * If we receive a duplicate RDMA request, it means the
+		 * requester saw a sequence error and needs to restart
+		 * from an earlier point.  We can abort the current
+		 * RDMA read send in that case.
+		 */
+		spin_lock_irq(&qp->s_lock);
+		if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
+		    (qp->s_hdrwords || ipath_cmp24(psn, qp->s_ack_psn) >= 0)) {
+			/*
+			 * We are already sending earlier requested data.
+			 * Don't abort it to send later out of sequence data.
+			 */
+			spin_unlock_irq(&qp->s_lock);
+			goto done;
 		}
 		qp->s_rdma_len = be32_to_cpu(reth->length);
 		if (qp->s_rdma_len != 0) {
@@ -1192,8 +1226,10 @@ static inline int ipath_rc_rcv_error(str
 			ok = ipath_rkey_ok(dev, &qp->s_rdma_sge,
 					   qp->s_rdma_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_READ);
-			if (unlikely(!ok))
+			if (unlikely(!ok)) {
+				spin_unlock_irq(&qp->s_lock);
 				goto done;
+			}
 		} else {
 			qp->s_rdma_sge.sg_list = NULL;
 			qp->s_rdma_sge.num_sge = 0;
@@ -1202,25 +1238,44 @@ static inline int ipath_rc_rcv_error(str
 			qp->s_rdma_sge.sge.length = 0;
 			qp->s_rdma_sge.sge.sge_length = 0;
 		}
-		break;
-
+		qp->s_ack_state = opcode;
+		qp->s_ack_psn = psn;
+		spin_unlock_irq(&qp->s_lock);
+		tasklet_hi_schedule(&qp->s_task);
+		goto send_ack;
+	}
+
+	/*
+	 * A pending RDMA read will ACK anything before it so
+	 * ignore earlier duplicate requests.
+	 */
+	if (qp->s_ack_state != OP(ACKNOWLEDGE))
+		goto done;
+
+	/*
+	 * If an ACK is pending, don't replace the pending ACK
+	 * with an earlier one since the later one will ACK the earlier.
+	 * Also, if we already have a pending atomic, send it.
+	 */
+	if (qp->r_ack_state != OP(ACKNOWLEDGE) &&
+	    (ipath_cmp24(psn, qp->r_ack_psn) <= 0 ||
+	     qp->r_ack_state >= OP(COMPARE_SWAP)))
+		goto send_ack;
+	switch (opcode) {
 	case OP(COMPARE_SWAP):
 	case OP(FETCH_ADD):
 		/*
 		 * Check for the PSN of the last atomic operation
 		 * performed and resend the result if found.
 		 */
-		if ((psn & IPS_PSN_MASK) != qp->r_atomic_psn) {
-			spin_unlock(&qp->s_lock);
+		if ((psn & IPS_PSN_MASK) != qp->r_atomic_psn)
 			goto done;
-		}
-		qp->s_ack_atomic = qp->r_atomic_data;
 		break;
 	}
-	qp->s_ack_state = opcode;
-	qp->s_nak_state = 0;
-	qp->s_ack_psn = psn;
-resched:
+	qp->r_ack_state = opcode;
+	qp->r_nak_state = 0;
+	qp->r_ack_psn = psn;
+send_ack:
 	return 0;
 
 done:
@@ -1248,7 +1303,6 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 	u32 hdrsize;
 	u32 psn;
 	u32 pad;
-	unsigned long flags;
 	struct ib_wc wc;
 	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
 	int diff;
@@ -1289,10 +1343,8 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 	    opcode <= OP(ATOMIC_ACKNOWLEDGE)) {
 		ipath_rc_rcv_resp(dev, ohdr, data, tlen, qp, opcode, psn,
 				  hdrsize, pmtu, header_in_data);
-		goto bail;
-	}
-
-	spin_lock_irqsave(&qp->r_rq.lock, flags);
+		goto done;
+	}
 
 	/* Compute 24 bits worth of difference. */
 	diff = ipath_cmp24(psn, qp->r_psn);
@@ -1300,7 +1352,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		if (ipath_rc_rcv_error(dev, ohdr, data, qp, opcode,
 				       psn, diff, header_in_data))
 			goto done;
-		goto resched;
+		goto send_ack;
 	}
 
 	/* Check for opcode sequence errors. */
@@ -1312,22 +1364,19 @@ void ipath_rc_rcv(struct ipath_ibdev *de
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
+		if (qp->r_ack_state >= OP(COMPARE_SWAP))
+			goto send_ack;
+		/* XXX Flush WQEs */
+		qp->state = IB_QPS_ERR;
+		qp->r_ack_state = OP(SEND_ONLY);
+		qp->r_nak_state = IB_NAK_INVALID_REQUEST;
+		qp->r_ack_psn = qp->r_psn;
+		goto send_ack;
 
 	case OP(RDMA_WRITE_FIRST):
 	case OP(RDMA_WRITE_MIDDLE):
@@ -1336,20 +1385,6 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		    opcode == OP(RDMA_WRITE_LAST_WITH_IMMEDIATE))
 			break;
 		goto nack_inv;
-
-	case OP(RDMA_READ_REQUEST):
-	case OP(COMPARE_SWAP):
-	case OP(FETCH_ADD):
-		/*
-		 * Drop all new requests until a response has been sent.  A
-		 * new request then ACKs the RDMA response we sent.  Relaxed
-		 * ordering would allow new requests to be processed but we
-		 * would need to keep a queue of rwqe's for all that are in
-		 * progress.  Note that we can't RNR NAK this request since
-		 * the RDMA READ or atomic response is already queued to be
-		 * sent (unless we implement a response send queue).
-		 */
-		goto done;
 
 	default:
 		if (opcode == OP(SEND_MIDDLE) ||
@@ -1359,6 +1394,11 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		    opcode == OP(RDMA_WRITE_LAST) ||
 		    opcode == OP(RDMA_WRITE_LAST_WITH_IMMEDIATE))
 			goto nack_inv;
+		/*
+		 * Note that it is up to the requester to not send a new
+		 * RDMA read or atomic operation before receiving an ACK
+		 * for the previous operation.
+		 */
 		break;
 	}
 
@@ -1375,17 +1415,12 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			 * Don't queue the NAK if a RDMA read or atomic
 			 * is pending though.
 			 */
-			spin_lock(&qp->s_lock);
-			if (qp->s_ack_state >=
-			    OP(RDMA_READ_REQUEST) &&
-			    qp->s_ack_state != IB_OPCODE_ACKNOWLEDGE) {
-				spin_unlock(&qp->s_lock);
-				goto done;
-			}
-			qp->s_ack_state = OP(SEND_ONLY);
-			qp->s_nak_state = IB_RNR_NAK | qp->s_min_rnr_timer;
-			qp->s_ack_psn = qp->r_psn;
-			goto resched;
+			if (qp->r_ack_state >= OP(COMPARE_SWAP))
+				goto send_ack;
+			qp->r_ack_state = OP(SEND_ONLY);
+			qp->r_nak_state = IB_RNR_NAK | qp->r_min_rnr_timer;
+			qp->r_ack_psn = qp->r_psn;
+			goto send_ack;
 		}
 		qp->r_rcv_len = 0;
 		/* FALLTHROUGH */
@@ -1442,7 +1477,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		if (unlikely(wc.byte_len > qp->r_len))
 			goto nack_inv;
 		ipath_copy_sge(&qp->r_sge, data, tlen);
-		atomic_inc(&qp->msn);
+		qp->r_msn++;
 		if (opcode == OP(RDMA_WRITE_LAST) ||
 		    opcode == OP(RDMA_WRITE_ONLY))
 			break;
@@ -1486,29 +1521,8 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			ok = ipath_rkey_ok(dev, &qp->r_sge,
 					   qp->r_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_WRITE);
-			if (unlikely(!ok)) {
-			nack_acc:
-				/*
-				 * A NAK will ACK earlier sends and RDMA
-				 * writes.  Don't queue the NAK if a RDMA
-				 * read, atomic, or NAK is pending though.
-				 */
-				spin_lock(&qp->s_lock);
-				if (qp->s_ack_state >=
-				    OP(RDMA_READ_REQUEST) &&
-				    qp->s_ack_state !=
-				    IB_OPCODE_ACKNOWLEDGE) {
-					spin_unlock(&qp->s_lock);
-					goto done;
-				}
-				/* XXX Flush WQEs */
-				qp->state = IB_QPS_ERR;
-				qp->s_ack_state = OP(RDMA_WRITE_ONLY);
-				qp->s_nak_state =
-					IB_NAK_REMOTE_ACCESS_ERROR;
-				qp->s_ack_psn = qp->r_psn;
-				goto resched;
-			}
+			if (unlikely(!ok))
+				goto nack_acc;
 		} else {
 			qp->r_sge.sg_list = NULL;
 			qp->r_sge.sge.mr = NULL;
@@ -1535,12 +1549,10 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			reth = (struct ib_reth *)data;
 			data += sizeof(*reth);
 		}
-		spin_lock(&qp->s_lock);
-		if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
-		    qp->s_ack_state >= IB_OPCODE_RDMA_READ_REQUEST) {
-			spin_unlock(&qp->s_lock);
-			goto done;
-		}
+		if (unlikely(!(qp->qp_access_flags &
+			       IB_ACCESS_REMOTE_READ)))
+			goto nack_acc;
+		spin_lock_irq(&qp->s_lock);
 		qp->s_rdma_len = be32_to_cpu(reth->length);
 		if (qp->s_rdma_len != 0) {
 			u32 rkey = be32_to_cpu(reth->rkey);
@@ -1552,7 +1564,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 					   qp->s_rdma_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_READ);
 			if (unlikely(!ok)) {
-				spin_unlock(&qp->s_lock);
+				spin_unlock_irq(&qp->s_lock);
 				goto nack_acc;
 			}
 			/*
@@ -1569,21 +1581,25 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			qp->s_rdma_sge.sge.length = 0;
 			qp->s_rdma_sge.sge.sge_length = 0;
 		}
-		if (unlikely(!(qp->qp_access_flags &
-			       IB_ACCESS_REMOTE_READ)))
-			goto nack_acc;
 		/*
 		 * We need to increment the MSN here instead of when we
 		 * finish sending the result since a duplicate request would
 		 * increment it more than once.
 		 */
-		atomic_inc(&qp->msn);
+		qp->r_msn++;
+
 		qp->s_ack_state = opcode;
-		qp->s_nak_state = 0;
 		qp->s_ack_psn = psn;
+		spin_unlock_irq(&qp->s_lock);
+
 		qp->r_psn++;
 		qp->r_state = opcode;
-		goto rdmadone;
+		qp->r_nak_state = 0;
+
+		/* Call ipath_do_rc_send() in another thread. */
+		tasklet_hi_schedule(&qp->s_task);
+
+		goto done;
 
 	case OP(COMPARE_SWAP):
 	case OP(FETCH_ADD): {
@@ -1612,7 +1628,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			goto nack_acc;
 		/* Perform atomic OP and save result. */
 		sdata = be64_to_cpu(ateth->swap_data);
-		spin_lock(&dev->pending_lock);
+		spin_lock_irq(&dev->pending_lock);
 		qp->r_atomic_data = *(u64 *) qp->r_sge.sge.vaddr;
 		if (opcode == OP(FETCH_ADD))
 			*(u64 *) qp->r_sge.sge.vaddr =
@@ -1620,8 +1636,8 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		else if (qp->r_atomic_data ==
 			 be64_to_cpu(ateth->compare_data))
 			*(u64 *) qp->r_sge.sge.vaddr = sdata;
-		spin_unlock(&dev->pending_lock);
-		atomic_inc(&qp->msn);
+		spin_unlock_irq(&dev->pending_lock);
+		qp->r_msn++;
 		qp->r_atomic_psn = psn & IPS_PSN_MASK;
 		psn |= 1 << 31;
 		break;
@@ -1633,44 +1649,39 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 	}
 	qp->r_psn++;
 	qp->r_state = opcode;
+	qp->r_nak_state = 0;
 	/* Send an ACK if requested or required. */
 	if (psn & (1 << 31)) {
 		/*
 		 * Coalesce ACKs unless there is a RDMA READ or
 		 * ATOMIC pending.
 		 */
-		spin_lock(&qp->s_lock);
-		if (qp->s_ack_state == OP(ACKNOWLEDGE) ||
-		    qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST) {
-			qp->s_ack_state = opcode;
-			qp->s_nak_state = 0;
-			qp->s_ack_psn = psn;
-			qp->s_ack_atomic = qp->r_atomic_data;
-			goto resched;
-		}
-		spin_unlock(&qp->s_lock);
-	}
+		if (qp->r_ack_state < OP(COMPARE_SWAP)) {
+			qp->r_ack_state = opcode;
+			qp->r_ack_psn = psn;
+		}
+		goto send_ack;
+	}
+	goto done;
+
+nack_acc:
+	/*
+	 * A NAK will ACK earlier sends and RDMA writes.
+	 * Don't queue the NAK if a RDMA read, atomic, or NAK
+	 * is pending though.
+	 */
+	if (qp->r_ack_state < OP(COMPARE_SWAP)) {
+		/* XXX Flush WQEs */
+		qp->state = IB_QPS_ERR;
+		qp->r_ack_state = OP(RDMA_WRITE_ONLY);
+		qp->r_nak_state = IB_NAK_REMOTE_ACCESS_ERROR;
+		qp->r_ack_psn = qp->r_psn;
+	}
+send_ack:
+	/* Send ACK right away unless the send tasklet has a pending ACK. */
+	if (qp->s_ack_state == OP(ACKNOWLEDGE))
+		send_rc_ack(qp);
+
 done:
-	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
-	goto bail;
-
-resched:
-	/*
-	 * Try to send ACK right away but not if ipath_do_rc_send() is
-	 * active.
-	 */
-	if (qp->s_hdrwords == 0 &&
-	    (qp->s_ack_state < IB_OPCODE_RDMA_READ_REQUEST ||
-	     qp->s_ack_state >= IB_OPCODE_COMPARE_SWAP))
-		send_rc_ack(qp);
-
-rdmadone:
-	spin_unlock(&qp->s_lock);
-	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
-
-	/* Call ipath_do_rc_send() in another thread. */
-	tasklet_hi_schedule(&qp->s_task);
-
-bail:
 	return;
 }
diff -r 5f3c0b2d446d -r 1bef8244297a drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:26 2006 -0700
@@ -113,20 +113,23 @@ void ipath_insert_rnr_queue(struct ipath
  *
  * Return 0 if no RWQE is available, otherwise return 1.
  *
- * Called at interrupt level with the QP r_rq.lock held.
+ * Can be called from interrupt level.
  */
 int ipath_get_rwqe(struct ipath_qp *qp, int wr_id_only)
 {
+	unsigned long flags;
 	struct ipath_rq *rq;
 	struct ipath_srq *srq;
 	struct ipath_rwqe *wqe;
-	int ret;
+	int ret = 1;
 
 	if (!qp->ibqp.srq) {
 		rq = &qp->r_rq;
+		spin_lock_irqsave(&rq->lock, flags);
+
 		if (unlikely(rq->tail == rq->head)) {
 			ret = 0;
-			goto bail;
+			goto done;
 		}
 		wqe = get_rwqe_ptr(rq, rq->tail);
 		qp->r_wr_id = wqe->wr_id;
@@ -138,17 +141,16 @@ int ipath_get_rwqe(struct ipath_qp *qp, 
 		}
 		if (++rq->tail >= rq->size)
 			rq->tail = 0;
-		ret = 1;
-		goto bail;
+		goto done;
 	}
 
 	srq = to_isrq(qp->ibqp.srq);
 	rq = &srq->rq;
-	spin_lock(&rq->lock);
+	spin_lock_irqsave(&rq->lock, flags);
+
 	if (unlikely(rq->tail == rq->head)) {
-		spin_unlock(&rq->lock);
 		ret = 0;
-		goto bail;
+		goto done;
 	}
 	wqe = get_rwqe_ptr(rq, rq->tail);
 	qp->r_wr_id = wqe->wr_id;
@@ -170,18 +172,18 @@ int ipath_get_rwqe(struct ipath_qp *qp, 
 			n = rq->head - rq->tail;
 		if (n < srq->limit) {
 			srq->limit = 0;
-			spin_unlock(&rq->lock);
+			spin_unlock_irqrestore(&rq->lock, flags);
 			ev.device = qp->ibqp.device;
 			ev.element.srq = qp->ibqp.srq;
 			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
 			srq->ibsrq.event_handler(&ev,
 						 srq->ibsrq.srq_context);
-		} else
-			spin_unlock(&rq->lock);
-	} else
-		spin_unlock(&rq->lock);
-	ret = 1;
-
+			goto bail;
+		}
+	}
+
+done:
+	spin_unlock_irqrestore(&rq->lock, flags);
 bail:
 	return ret;
 }
@@ -248,10 +250,8 @@ again:
 		wc.imm_data = wqe->wr.imm_data;
 		/* FALLTHROUGH */
 	case IB_WR_SEND:
-		spin_lock_irqsave(&qp->r_rq.lock, flags);
 		if (!ipath_get_rwqe(qp, 0)) {
 		rnr_nak:
-			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
 			/* Handle RNR NAK */
 			if (qp->ibqp.qp_type == IB_QPT_UC)
 				goto send_comp;
@@ -263,20 +263,17 @@ again:
 				sqp->s_rnr_retry--;
 			dev->n_rnr_naks++;
 			sqp->s_rnr_timeout =
-				ib_ipath_rnr_table[sqp->s_min_rnr_timer];
+				ib_ipath_rnr_table[sqp->r_min_rnr_timer];
 			ipath_insert_rnr_queue(sqp);
 			goto done;
 		}
-		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
 		wc.wc_flags = IB_WC_WITH_IMM;
 		wc.imm_data = wqe->wr.imm_data;
-		spin_lock_irqsave(&qp->r_rq.lock, flags);
 		if (!ipath_get_rwqe(qp, 1))
 			goto rnr_nak;
-		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
 		/* FALLTHROUGH */
 	case IB_WR_RDMA_WRITE:
 		if (wqe->length == 0)
diff -r 5f3c0b2d446d -r 1bef8244297a drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:26 2006 -0700
@@ -241,7 +241,6 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 	u32 hdrsize;
 	u32 psn;
 	u32 pad;
-	unsigned long flags;
 	struct ib_wc wc;
 	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
 	struct ib_reth *reth;
@@ -279,8 +278,6 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 	wc.imm_data = 0;
 	wc.wc_flags = 0;
 
-	spin_lock_irqsave(&qp->r_rq.lock, flags);
-
 	/* Compare the PSN verses the expected PSN. */
 	if (unlikely(ipath_cmp24(psn, qp->r_psn) != 0)) {
 		/*
@@ -537,15 +534,11 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 
 	default:
 		/* Drop packet for unknown opcodes. */
-		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
 		dev->n_pkt_drops++;
-		goto bail;
+		goto done;
 	}
 	qp->r_psn++;
 	qp->r_state = opcode;
 done:
-	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
-
-bail:
 	return;
 }
diff -r 5f3c0b2d446d -r 1bef8244297a drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:26 2006 -0700
@@ -307,32 +307,34 @@ struct ipath_qp {
 	u32 s_next_psn;		/* PSN for next request */
 	u32 s_last_psn;		/* last response PSN processed */
 	u32 s_psn;		/* current packet sequence number */
+	u32 s_ack_psn;		/* PSN for RDMA_READ */
 	u32 s_rnr_timeout;	/* number of milliseconds for RNR timeout */
-	u32 s_ack_psn;		/* PSN for next ACK or RDMA_READ */
-	u64 s_ack_atomic;	/* data for atomic ACK */
+	u32 r_ack_psn;		/* PSN for next ACK or atomic ACK */
 	u64 r_wr_id;		/* ID for current receive WQE */
 	u64 r_atomic_data;	/* data for last atomic op */
 	u32 r_atomic_psn;	/* PSN of last atomic op */
 	u32 r_len;		/* total length of r_sge */
 	u32 r_rcv_len;		/* receive data len processed */
 	u32 r_psn;		/* expected rcv packet sequence number */
+	u32 r_msn;		/* message sequence number */
 	u8 state;		/* QP state */
 	u8 s_state;		/* opcode of last packet sent */
 	u8 s_ack_state;		/* opcode of packet to ACK */
 	u8 s_nak_state;		/* non-zero if NAK is pending */
 	u8 r_state;		/* opcode of last packet received */
+	u8 r_ack_state;		/* opcode of packet to ACK */
+	u8 r_nak_state;		/* non-zero if NAK is pending */
+	u8 r_min_rnr_timer;	/* retry timeout value for RNR NAKs */
 	u8 r_reuse_sge;		/* for UC receive errors */
 	u8 r_sge_inx;		/* current index into sg_list */
+	u8 qp_access_flags;
 	u8 s_max_sge;		/* size of s_wq->sg_list */
-	u8 qp_access_flags;
 	u8 s_retry_cnt;		/* number of times to retry */
 	u8 s_rnr_retry_cnt;
-	u8 s_min_rnr_timer;
 	u8 s_retry;		/* requester retry counter */
 	u8 s_rnr_retry;		/* requester RNR retry counter */
 	u8 s_pkey_index;	/* PKEY index to use */
 	enum ib_mtu path_mtu;
-	atomic_t msn;		/* message sequence number */
 	u32 remote_qpn;
 	u32 qkey;		/* QKEY for this QP (for UD or RD) */
 	u32 s_size;		/* send work queue size */
