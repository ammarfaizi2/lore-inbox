Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932926AbWF2VrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbWF2VrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWF2VoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:15 -0400
Received: from mx.pathscale.com ([64.160.42.68]:29839 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932833AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 39] IB/ipath - Share more common code between RC and UC
	protocols
X-Mercurial-Node: ebf646d10db07350e297e9987ef5c99f8fe1e410
Message-Id: <ebf646d10db07350e297.1151617254@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:54 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r f7c82500b9c7 -r ebf646d10db0 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
@@ -709,9 +709,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 		spin_lock_init(&qp->r_rq.lock);
 		atomic_set(&qp->refcount, 0);
 		init_waitqueue_head(&qp->wait);
-		tasklet_init(&qp->s_task,
-			     init_attr->qp_type == IB_QPT_RC ?
-			     ipath_do_rc_send : ipath_do_uc_send,
+		tasklet_init(&qp->s_task, ipath_do_ruc_send,
 			     (unsigned long)qp);
 		INIT_LIST_HEAD(&qp->piowait);
 		INIT_LIST_HEAD(&qp->timerwait);
@@ -896,9 +894,9 @@ void ipath_get_credit(struct ipath_qp *q
 	 * as many packets as we like.  Otherwise, we have to
 	 * honor the credit field.
 	 */
-	if (credit == IPS_AETH_CREDIT_INVAL) {
+	if (credit == IPS_AETH_CREDIT_INVAL)
 		qp->s_lsn = (u32) -1;
-	} else if (qp->s_lsn != (u32) -1) {
+	else if (qp->s_lsn != (u32) -1) {
 		/* Compute new LSN (i.e., MSN + credit) */
 		credit = (aeth + credit_table[credit]) & IPS_MSN_MASK;
 		if (ipath_cmp24(credit, qp->s_lsn) > 0)
diff -r f7c82500b9c7 -r ebf646d10db0 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -73,9 +73,9 @@ static void ipath_init_restart(struct ip
  * Return bth0 if constructed; otherwise, return 0.
  * Note the QP s_lock must be held.
  */
-static inline u32 ipath_make_rc_ack(struct ipath_qp *qp,
-				    struct ipath_other_headers *ohdr,
-				    u32 pmtu)
+u32 ipath_make_rc_ack(struct ipath_qp *qp,
+		      struct ipath_other_headers *ohdr,
+		      u32 pmtu)
 {
 	struct ipath_sge_state *ss;
 	u32 hwords;
@@ -96,8 +96,7 @@ static inline u32 ipath_make_rc_ack(stru
 		if (len > pmtu) {
 			len = pmtu;
 			qp->s_ack_state = OP(RDMA_READ_RESPONSE_FIRST);
-		}
-		else
+		} else
 			qp->s_ack_state = OP(RDMA_READ_RESPONSE_ONLY);
 		qp->s_rdma_len -= len;
 		bth0 = qp->s_ack_state << 24;
@@ -177,9 +176,9 @@ static inline u32 ipath_make_rc_ack(stru
  * Return 1 if constructed; otherwise, return 0.
  * Note the QP s_lock must be held.
  */
-static inline int ipath_make_rc_req(struct ipath_qp *qp,
-				    struct ipath_other_headers *ohdr,
-				    u32 pmtu, u32 *bth0p, u32 *bth2p)
+int ipath_make_rc_req(struct ipath_qp *qp,
+		      struct ipath_other_headers *ohdr,
+		      u32 pmtu, u32 *bth0p, u32 *bth2p)
 {
 	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ipath_sge_state *ss;
@@ -497,160 +496,33 @@ done:
 	return 0;
 }
 
-static inline void ipath_make_rc_grh(struct ipath_qp *qp,
-				     struct ib_global_route *grh,
-				     u32 nwords)
-{
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
-
-	/* GRH header size in 32-bit words. */
-	qp->s_hdrwords += 10;
-	qp->s_hdr.u.l.grh.version_tclass_flow =
-		cpu_to_be32((6 << 28) |
-			    (grh->traffic_class << 20) |
-			    grh->flow_label);
-	qp->s_hdr.u.l.grh.paylen =
-		cpu_to_be16(((qp->s_hdrwords - 12) + nwords +
-			     SIZE_OF_CRC) << 2);
-	/* next_hdr is defined by C8-7 in ch. 8.4.1 */
-	qp->s_hdr.u.l.grh.next_hdr = 0x1B;
-	qp->s_hdr.u.l.grh.hop_limit = grh->hop_limit;
-	/* The SGID is 32-bit aligned. */
-	qp->s_hdr.u.l.grh.sgid.global.subnet_prefix = dev->gid_prefix;
-	qp->s_hdr.u.l.grh.sgid.global.interface_id =
-		ipath_layer_get_guid(dev->dd);
-	qp->s_hdr.u.l.grh.dgid = grh->dgid;
-}
-
 /**
- * ipath_do_rc_send - perform a send on an RC QP
- * @data: contains a pointer to the QP
+ * send_rc_ack - Construct an ACK packet and send it
+ * @qp: a pointer to the QP
  *
- * Process entries in the send work queue until credit or queue is
- * exhausted.  Only allow one CPU to send a packet per QP (tasklet).
- * Otherwise, after we drop the QP s_lock, two threads could send
- * packets out of order.
+ * This is called from ipath_rc_rcv() and only uses the receive
+ * side QP state.
+ * Note that RDMA reads are handled in the send side QP state and tasklet.
  */
-void ipath_do_rc_send(unsigned long data)
-{
-	struct ipath_qp *qp = (struct ipath_qp *)data;
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
-	unsigned long flags;
-	u16 lrh0;
-	u32 nwords;
-	u32 extra_bytes;
-	u32 bth0;
-	u32 bth2;
-	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
-	struct ipath_other_headers *ohdr;
-
-	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
-		goto bail;
-
-	if (unlikely(qp->remote_ah_attr.dlid ==
-		     ipath_layer_get_lid(dev->dd))) {
-		struct ib_wc wc;
-
-		/*
-		 * Pass in an uninitialized ib_wc to be consistent with
-		 * other places where ipath_ruc_loopback() is called.
-		 */
-		ipath_ruc_loopback(qp, &wc);
-		goto clear;
-	}
-
-	ohdr = &qp->s_hdr.u.oth;
-	if (qp->remote_ah_attr.ah_flags & IB_AH_GRH)
-		ohdr = &qp->s_hdr.u.l.oth;
-
-again:
-	/* Check for a constructed packet to be sent. */
-	if (qp->s_hdrwords != 0) {
-		/*
-		 * If no PIO bufs are available, return.  An interrupt will
-		 * call ipath_ib_piobufavail() when one is available.
-		 */
-		_VERBS_INFO("h %u %p\n", qp->s_hdrwords, &qp->s_hdr);
-		_VERBS_INFO("d %u %p %u %p %u %u %u %u\n", qp->s_cur_size,
-			    qp->s_cur_sge->sg_list,
-			    qp->s_cur_sge->num_sge,
-			    qp->s_cur_sge->sge.vaddr,
-			    qp->s_cur_sge->sge.sge_length,
-			    qp->s_cur_sge->sge.length,
-			    qp->s_cur_sge->sge.m,
-			    qp->s_cur_sge->sge.n);
-		if (ipath_verbs_send(dev->dd, qp->s_hdrwords,
-				     (u32 *) &qp->s_hdr, qp->s_cur_size,
-				     qp->s_cur_sge)) {
-			ipath_no_bufs_available(qp, dev);
-			goto bail;
-		}
-		dev->n_unicast_xmit++;
-		/* Record that we sent the packet and s_hdr is empty. */
-		qp->s_hdrwords = 0;
-	}
-
-	/*
-	 * The lock is needed to synchronize between setting
-	 * qp->s_ack_state, resend timer, and post_send().
-	 */
-	spin_lock_irqsave(&qp->s_lock, flags);
-
-	/* Sending responses has higher priority over sending requests. */
-	if (qp->s_ack_state != OP(ACKNOWLEDGE) &&
-	    (bth0 = ipath_make_rc_ack(qp, ohdr, pmtu)) != 0)
-		bth2 = qp->s_ack_psn++ & IPS_PSN_MASK;
-	else if (!ipath_make_rc_req(qp, ohdr, pmtu, &bth0, &bth2))
-		goto done;
-
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-
-	/* Construct the header. */
-	extra_bytes = (4 - qp->s_cur_size) & 3;
-	nwords = (qp->s_cur_size + extra_bytes) >> 2;
-	lrh0 = IPS_LRH_BTH;
-	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
-		ipath_make_rc_grh(qp, &qp->remote_ah_attr.grh, nwords);
-		lrh0 = IPS_LRH_GRH;
-	}
-	lrh0 |= qp->remote_ah_attr.sl << 4;
-	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
-	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
-	qp->s_hdr.lrh[2] = cpu_to_be16(qp->s_hdrwords + nwords +
-				       SIZE_OF_CRC);
-	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
-	bth0 |= ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
-	bth0 |= extra_bytes << 20;
-	ohdr->bth[0] = cpu_to_be32(bth0);
-	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
-	ohdr->bth[2] = cpu_to_be32(bth2);
-
-	/* Check for more work to do. */
-	goto again;
-
-done:
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-clear:
-	clear_bit(IPATH_S_BUSY, &qp->s_flags);
-bail:
-	return;
-}
-
 static void send_rc_ack(struct ipath_qp *qp)
 {
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
-		ohdr = &qp->s_hdr.u.l.oth;
+		hwords += ipath_make_grh(dev, &hdr.u.l.grh,
+					 &qp->remote_ah_attr.grh,
+					 hwords, 0);
+		ohdr = &hdr.u.l.oth;
 		lrh0 = IPS_LRH_GRH;
 	}
 	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
@@ -658,15 +530,14 @@ static void send_rc_ack(struct ipath_qp 
 	if (qp->s_ack_state >= OP(COMPARE_SWAP)) {
 		bth0 |= IB_OPCODE_ATOMIC_ACKNOWLEDGE << 24;
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
@@ -674,8 +545,7 @@ static void send_rc_ack(struct ipath_qp 
 	/*
 	 * If we can send the ACK, clear the ACK state.
 	 */
-	if (ipath_verbs_send(dev->dd, qp->s_hdrwords, (u32 *) &qp->s_hdr,
-			     0, NULL) == 0) {
+	if (ipath_verbs_send(dev->dd, hwords, (u32 *) &hdr, 0, NULL) == 0) {
 		qp->s_ack_state = OP(ACKNOWLEDGE);
 		dev->n_rc_qacks++;
 		dev->n_unicast_xmit++;
@@ -805,7 +675,7 @@ bail:
  * @qp: the QP
  * @psn: the packet sequence number to restart at
  *
- * This is called from ipath_rc_rcv() to process an incoming RC ACK
+ * This is called from ipath_rc_rcv_resp() to process an incoming RC ACK
  * for the given QP.
  * Called at interrupt level with the QP s_lock held.
  */
@@ -1231,18 +1101,12 @@ static inline void ipath_rc_rcv_resp(str
 		 * ICRC (4).
 		 */
 		if (unlikely(tlen <= (hdrsize + pad + 8))) {
-			/*
-			 * XXX Need to generate an error CQ
-			 * entry.
-			 */
+			/* XXX Need to generate an error CQ entry. */
 			goto ack_done;
 		}
 		tlen -= hdrsize + pad + 8;
 		if (unlikely(tlen != qp->s_len)) {
-			/*
-			 * XXX Need to generate an error CQ
-			 * entry.
-			 */
+			/* XXX Need to generate an error CQ entry. */
 			goto ack_done;
 		}
 		if (!header_in_data)
@@ -1384,7 +1248,7 @@ static inline int ipath_rc_rcv_error(str
 	case OP(COMPARE_SWAP):
 	case OP(FETCH_ADD):
 		/*
-		 * Check for the PSN of the last atomic operations
+		 * Check for the PSN of the last atomic operation
 		 * performed and resend the result if found.
 		 */
 		if ((psn & IPS_PSN_MASK) != qp->r_atomic_psn) {
@@ -1454,11 +1318,6 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 		} else
 			psn = be32_to_cpu(ohdr->bth[2]);
 	}
-	/*
-	 * The opcode is in the low byte when its in network order
-	 * (top byte when in host order).
-	 */
-	opcode = be32_to_cpu(ohdr->bth[0]) >> 24;
 
 	/*
 	 * Process responses (ACKs) before anything else.  Note that the
@@ -1466,6 +1325,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 	 * queue rather than the expected receive packet sequence number.
 	 * In other words, this QP is the requester.
 	 */
+	opcode = be32_to_cpu(ohdr->bth[0]) >> 24;
 	if (opcode >= OP(RDMA_READ_RESPONSE_FIRST) &&
 	    opcode <= OP(ATOMIC_ACKNOWLEDGE)) {
 		ipath_rc_rcv_resp(dev, ohdr, data, tlen, qp, opcode, psn,
diff -r f7c82500b9c7 -r ebf646d10db0 drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -32,6 +32,7 @@
  */
 
 #include "ipath_verbs.h"
+#include "ips_common.h"
 
 /*
  * Convert the AETH RNR timeout code into the number of milliseconds.
@@ -188,7 +189,6 @@ bail:
 /**
  * ipath_ruc_loopback - handle UC and RC lookback requests
  * @sqp: the loopback QP
- * @wc: the work completion entry
  *
  * This is called from ipath_do_uc_send() or ipath_do_rc_send() to
  * forward a WQE addressed to the same HCA.
@@ -197,13 +197,14 @@ bail:
  * receive interrupts since this is a connected protocol and all packets
  * will pass through here.
  */
-void ipath_ruc_loopback(struct ipath_qp *sqp, struct ib_wc *wc)
+static void ipath_ruc_loopback(struct ipath_qp *sqp)
 {
 	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
 	struct ipath_qp *qp;
 	struct ipath_swqe *wqe;
 	struct ipath_sge *sge;
 	unsigned long flags;
+	struct ib_wc wc;
 	u64 sdata;
 
 	qp = ipath_lookup_qpn(&dev->qp_table, sqp->remote_qpn);
@@ -234,8 +235,8 @@ again:
 	wqe = get_swqe_ptr(sqp, sqp->s_last);
 	spin_unlock_irqrestore(&sqp->s_lock, flags);
 
-	wc->wc_flags = 0;
-	wc->imm_data = 0;
+	wc.wc_flags = 0;
+	wc.imm_data = 0;
 
 	sqp->s_sge.sge = wqe->sg_list[0];
 	sqp->s_sge.sg_list = wqe->sg_list + 1;
@@ -243,8 +244,8 @@ again:
 	sqp->s_len = wqe->length;
 	switch (wqe->wr.opcode) {
 	case IB_WR_SEND_WITH_IMM:
-		wc->wc_flags = IB_WC_WITH_IMM;
-		wc->imm_data = wqe->wr.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		wc.imm_data = wqe->wr.imm_data;
 		/* FALLTHROUGH */
 	case IB_WR_SEND:
 		spin_lock_irqsave(&qp->r_rq.lock, flags);
@@ -255,7 +256,7 @@ again:
 			if (qp->ibqp.qp_type == IB_QPT_UC)
 				goto send_comp;
 			if (sqp->s_rnr_retry == 0) {
-				wc->status = IB_WC_RNR_RETRY_EXC_ERR;
+				wc.status = IB_WC_RNR_RETRY_EXC_ERR;
 				goto err;
 			}
 			if (sqp->s_rnr_retry_cnt < 7)
@@ -270,8 +271,8 @@ again:
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
-		wc->wc_flags = IB_WC_WITH_IMM;
-		wc->imm_data = wqe->wr.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		wc.imm_data = wqe->wr.imm_data;
 		spin_lock_irqsave(&qp->r_rq.lock, flags);
 		if (!ipath_get_rwqe(qp, 1))
 			goto rnr_nak;
@@ -285,20 +286,20 @@ again:
 					    wqe->wr.wr.rdma.rkey,
 					    IB_ACCESS_REMOTE_WRITE))) {
 		acc_err:
-			wc->status = IB_WC_REM_ACCESS_ERR;
+			wc.status = IB_WC_REM_ACCESS_ERR;
 		err:
-			wc->wr_id = wqe->wr.wr_id;
-			wc->opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
-			wc->vendor_err = 0;
-			wc->byte_len = 0;
-			wc->qp_num = sqp->ibqp.qp_num;
-			wc->src_qp = sqp->remote_qpn;
-			wc->pkey_index = 0;
-			wc->slid = sqp->remote_ah_attr.dlid;
-			wc->sl = sqp->remote_ah_attr.sl;
-			wc->dlid_path_bits = 0;
-			wc->port_num = 0;
-			ipath_sqerror_qp(sqp, wc);
+			wc.wr_id = wqe->wr.wr_id;
+			wc.opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+			wc.vendor_err = 0;
+			wc.byte_len = 0;
+			wc.qp_num = sqp->ibqp.qp_num;
+			wc.src_qp = sqp->remote_qpn;
+			wc.pkey_index = 0;
+			wc.slid = sqp->remote_ah_attr.dlid;
+			wc.sl = sqp->remote_ah_attr.sl;
+			wc.dlid_path_bits = 0;
+			wc.port_num = 0;
+			ipath_sqerror_qp(sqp, &wc);
 			goto done;
 		}
 		break;
@@ -374,22 +375,22 @@ again:
 		goto send_comp;
 
 	if (wqe->wr.opcode == IB_WR_RDMA_WRITE_WITH_IMM)
-		wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		wc.opcode = IB_WC_RECV_RDMA_WITH_IMM;
 	else
-		wc->opcode = IB_WC_RECV;
-	wc->wr_id = qp->r_wr_id;
-	wc->status = IB_WC_SUCCESS;
-	wc->vendor_err = 0;
-	wc->byte_len = wqe->length;
-	wc->qp_num = qp->ibqp.qp_num;
-	wc->src_qp = qp->remote_qpn;
+		wc.opcode = IB_WC_RECV;
+	wc.wr_id = qp->r_wr_id;
+	wc.status = IB_WC_SUCCESS;
+	wc.vendor_err = 0;
+	wc.byte_len = wqe->length;
+	wc.qp_num = qp->ibqp.qp_num;
+	wc.src_qp = qp->remote_qpn;
 	/* XXX do we know which pkey matched? Only needed for GSI. */
-	wc->pkey_index = 0;
-	wc->slid = qp->remote_ah_attr.dlid;
-	wc->sl = qp->remote_ah_attr.sl;
-	wc->dlid_path_bits = 0;
+	wc.pkey_index = 0;
+	wc.slid = qp->remote_ah_attr.dlid;
+	wc.sl = qp->remote_ah_attr.sl;
+	wc.dlid_path_bits = 0;
 	/* Signal completion event if the solicited bit is set. */
-	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), wc,
+	ipath_cq_enter(to_icq(qp->ibqp.recv_cq), &wc,
 		       wqe->wr.send_flags & IB_SEND_SOLICITED);
 
 send_comp:
@@ -397,19 +398,19 @@ send_comp:
 
 	if (!test_bit(IPATH_S_SIGNAL_REQ_WR, &sqp->s_flags) ||
 	    (wqe->wr.send_flags & IB_SEND_SIGNALED)) {
-		wc->wr_id = wqe->wr.wr_id;
-		wc->status = IB_WC_SUCCESS;
-		wc->opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
-		wc->vendor_err = 0;
-		wc->byte_len = wqe->length;
-		wc->qp_num = sqp->ibqp.qp_num;
-		wc->src_qp = 0;
-		wc->pkey_index = 0;
-		wc->slid = 0;
-		wc->sl = 0;
-		wc->dlid_path_bits = 0;
-		wc->port_num = 0;
-		ipath_cq_enter(to_icq(sqp->ibqp.send_cq), wc, 0);
+		wc.wr_id = wqe->wr.wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.opcode = ib_ipath_wc_opcode[wqe->wr.opcode];
+		wc.vendor_err = 0;
+		wc.byte_len = wqe->length;
+		wc.qp_num = sqp->ibqp.qp_num;
+		wc.src_qp = 0;
+		wc.pkey_index = 0;
+		wc.slid = 0;
+		wc.sl = 0;
+		wc.dlid_path_bits = 0;
+		wc.port_num = 0;
+		ipath_cq_enter(to_icq(sqp->ibqp.send_cq), &wc, 0);
 	}
 
 	/* Update s_last now that we are finished with the SWQE */
@@ -455,11 +456,11 @@ void ipath_no_bufs_available(struct ipat
 }
 
 /**
- * ipath_post_rc_send - post RC and UC sends
+ * ipath_post_ruc_send - post RC and UC sends
  * @qp: the QP to post on
  * @wr: the work request to send
  */
-int ipath_post_rc_send(struct ipath_qp *qp, struct ib_send_wr *wr)
+int ipath_post_ruc_send(struct ipath_qp *qp, struct ib_send_wr *wr)
 {
 	struct ipath_swqe *wqe;
 	unsigned long flags;
@@ -534,13 +535,149 @@ int ipath_post_rc_send(struct ipath_qp *
 	qp->s_head = next;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 
-	if (qp->ibqp.qp_type == IB_QPT_UC)
-		ipath_do_uc_send((unsigned long) qp);
-	else
-		ipath_do_rc_send((unsigned long) qp);
+	ipath_do_ruc_send((unsigned long) qp);
 
 	ret = 0;
 
 bail:
 	return ret;
 }
+
+/**
+ * ipath_make_grh - construct a GRH header
+ * @dev: a pointer to the ipath device
+ * @hdr: a pointer to the GRH header being constructed
+ * @grh: the global route address to send to
+ * @hwords: the number of 32 bit words of header being sent
+ * @nwords: the number of 32 bit words of data being sent
+ *
+ * Return the size of the header in 32 bit words.
+ */
+u32 ipath_make_grh(struct ipath_ibdev *dev, struct ib_grh *hdr,
+		   struct ib_global_route *grh, u32 hwords, u32 nwords)
+{
+	hdr->version_tclass_flow =
+		cpu_to_be32((6 << 28) |
+			    (grh->traffic_class << 20) |
+			    grh->flow_label);
+	hdr->paylen = cpu_to_be16((hwords - 2 + nwords + SIZE_OF_CRC) << 2);
+	/* next_hdr is defined by C8-7 in ch. 8.4.1 */
+	hdr->next_hdr = 0x1B;
+	hdr->hop_limit = grh->hop_limit;
+	/* The SGID is 32-bit aligned. */
+	hdr->sgid.global.subnet_prefix = dev->gid_prefix;
+	hdr->sgid.global.interface_id = ipath_layer_get_guid(dev->dd);
+	hdr->dgid = grh->dgid;
+
+	/* GRH header size in 32-bit words. */
+	return sizeof(struct ib_grh) / sizeof(u32);
+}
+
+/**
+ * ipath_do_ruc_send - perform a send on an RC or UC QP
+ * @data: contains a pointer to the QP
+ *
+ * Process entries in the send work queue until credit or queue is
+ * exhausted.  Only allow one CPU to send a packet per QP (tasklet).
+ * Otherwise, after we drop the QP s_lock, two threads could send
+ * packets out of order.
+ */
+void ipath_do_ruc_send(unsigned long data)
+{
+	struct ipath_qp *qp = (struct ipath_qp *)data;
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
+	unsigned long flags;
+	u16 lrh0;
+	u32 nwords;
+	u32 extra_bytes;
+	u32 bth0;
+	u32 bth2;
+	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
+	struct ipath_other_headers *ohdr;
+
+	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
+		goto bail;
+
+	if (unlikely(qp->remote_ah_attr.dlid ==
+		     ipath_layer_get_lid(dev->dd))) {
+		ipath_ruc_loopback(qp);
+		goto clear;
+	}
+
+	ohdr = &qp->s_hdr.u.oth;
+	if (qp->remote_ah_attr.ah_flags & IB_AH_GRH)
+		ohdr = &qp->s_hdr.u.l.oth;
+
+again:
+	/* Check for a constructed packet to be sent. */
+	if (qp->s_hdrwords != 0) {
+		/*
+		 * If no PIO bufs are available, return.  An interrupt will
+		 * call ipath_ib_piobufavail() when one is available.
+		 */
+		if (ipath_verbs_send(dev->dd, qp->s_hdrwords,
+				     (u32 *) &qp->s_hdr, qp->s_cur_size,
+				     qp->s_cur_sge)) {
+			ipath_no_bufs_available(qp, dev);
+			goto bail;
+		}
+		dev->n_unicast_xmit++;
+		/* Record that we sent the packet and s_hdr is empty. */
+		qp->s_hdrwords = 0;
+	}
+
+	/*
+	 * The lock is needed to synchronize between setting
+	 * qp->s_ack_state, resend timer, and post_send().
+	 */
+	spin_lock_irqsave(&qp->s_lock, flags);
+
+	/* Sending responses has higher priority over sending requests. */
+	if (qp->s_ack_state != IB_OPCODE_RC_ACKNOWLEDGE &&
+	    (bth0 = ipath_make_rc_ack(qp, ohdr, pmtu)) != 0)
+		bth2 = qp->s_ack_psn++ & IPS_PSN_MASK;
+	else if (!((qp->ibqp.qp_type == IB_QPT_RC) ?
+		   ipath_make_rc_req(qp, ohdr, pmtu, &bth0, &bth2) :
+		   ipath_make_uc_req(qp, ohdr, pmtu, &bth0, &bth2))) {
+		/*
+		 * Clear the busy bit before unlocking to avoid races with
+		 * adding new work queue items and then failing to process
+		 * them.
+		 */
+		clear_bit(IPATH_S_BUSY, &qp->s_flags);
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		goto bail;
+	}
+
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
+	/* Construct the header. */
+	extra_bytes = (4 - qp->s_cur_size) & 3;
+	nwords = (qp->s_cur_size + extra_bytes) >> 2;
+	lrh0 = IPS_LRH_BTH;
+	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
+		qp->s_hdrwords += ipath_make_grh(dev, &qp->s_hdr.u.l.grh,
+						 &qp->remote_ah_attr.grh,
+						 qp->s_hdrwords, nwords);
+		lrh0 = IPS_LRH_GRH;
+	}
+	lrh0 |= qp->remote_ah_attr.sl << 4;
+	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
+	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
+	qp->s_hdr.lrh[2] = cpu_to_be16(qp->s_hdrwords + nwords +
+				       SIZE_OF_CRC);
+	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
+	bth0 |= ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
+	bth0 |= extra_bytes << 20;
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
+	ohdr->bth[2] = cpu_to_be32(bth2);
+
+	/* Check for more work to do. */
+	goto again;
+
+clear:
+	clear_bit(IPATH_S_BUSY, &qp->s_flags);
+bail:
+	return;
+}
diff -r f7c82500b9c7 -r ebf646d10db0 drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -62,90 +62,40 @@ static void complete_last_send(struct ip
 }
 
 /**
- * ipath_do_uc_send - do a send on a UC queue
- * @data: contains a pointer to the QP to send on
- *
- * Process entries in the send work queue until the queue is exhausted.
- * Only allow one CPU to send a packet per QP (tasklet).
- * Otherwise, after we drop the QP lock, two threads could send
- * packets out of order.
- * This is similar to ipath_do_rc_send() below except we don't have
- * timeouts or resends.
+ * ipath_make_uc_req - construct a request packet (SEND, RDMA write)
+ * @qp: a pointer to the QP
+ * @ohdr: a pointer to the IB header being constructed
+ * @pmtu: the path MTU
+ * @bth0p: pointer to the BTH opcode word
+ * @bth2p: pointer to the BTH PSN word
+ *
+ * Return 1 if constructed; otherwise, return 0.
+ * Note the QP s_lock must be held and interrupts disabled.
  */
-void ipath_do_uc_send(unsigned long data)
+int ipath_make_uc_req(struct ipath_qp *qp,
+		      struct ipath_other_headers *ohdr,
+		      u32 pmtu, u32 *bth0p, u32 *bth2p)
 {
-	struct ipath_qp *qp = (struct ipath_qp *)data;
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ipath_swqe *wqe;
-	unsigned long flags;
-	u16 lrh0;
 	u32 hwords;
-	u32 nwords;
-	u32 extra_bytes;
 	u32 bth0;
-	u32 bth2;
-	u32 pmtu = ib_mtu_enum_to_int(qp->path_mtu);
 	u32 len;
-	struct ipath_other_headers *ohdr;
 	struct ib_wc wc;
 
-	if (test_and_set_bit(IPATH_S_BUSY, &qp->s_flags))
-		goto bail;
-
-	if (unlikely(qp->remote_ah_attr.dlid ==
-		     ipath_layer_get_lid(dev->dd))) {
-		/* Pass in an uninitialized ib_wc to save stack space. */
-		ipath_ruc_loopback(qp, &wc);
-		clear_bit(IPATH_S_BUSY, &qp->s_flags);
-		goto bail;
-	}
-
-	ohdr = &qp->s_hdr.u.oth;
-	if (qp->remote_ah_attr.ah_flags & IB_AH_GRH)
-		ohdr = &qp->s_hdr.u.l.oth;
-
-again:
-	/* Check for a constructed packet to be sent. */
-	if (qp->s_hdrwords != 0) {
-			/*
-			 * If no PIO bufs are available, return.
-			 * An interrupt will call ipath_ib_piobufavail()
-			 * when one is available.
-			 */
-			if (ipath_verbs_send(dev->dd, qp->s_hdrwords,
-					     (u32 *) &qp->s_hdr,
-					     qp->s_cur_size,
-					     qp->s_cur_sge)) {
-				ipath_no_bufs_available(qp, dev);
-				goto bail;
-			}
-			dev->n_unicast_xmit++;
-		/* Record that we sent the packet and s_hdr is empty. */
-		qp->s_hdrwords = 0;
-	}
-
-	lrh0 = IPS_LRH_BTH;
+	if (!(ib_ipath_state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
+		goto done;
+
 	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
 	hwords = 5;
-
-	/*
-	 * The lock is needed to synchronize between
-	 * setting qp->s_ack_state and post_send().
-	 */
-	spin_lock_irqsave(&qp->s_lock, flags);
-
-	if (!(ib_ipath_state_ops[qp->state] & IPATH_PROCESS_SEND_OK))
-		goto done;
-
-	bth0 = ipath_layer_get_pkey(dev->dd, qp->s_pkey_index);
-
-	/* Send a request. */
+	bth0 = 0;
+
+	/* Get the next send request. */
 	wqe = get_swqe_ptr(qp, qp->s_last);
 	switch (qp->s_state) {
 	default:
 		/*
-		 * Signal the completion of the last send (if there is
-		 * one).
+		 * Signal the completion of the last send
+		 * (if there is one).
 		 */
 		if (qp->s_last != qp->s_tail)
 			complete_last_send(qp, wqe, &wc);
@@ -258,61 +208,16 @@ again:
 		}
 		break;
 	}
-	bth2 = qp->s_next_psn++ & IPS_PSN_MASK;
 	qp->s_len -= len;
-	bth0 |= qp->s_state << 24;
-
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-
-	/* Construct the header. */
-	extra_bytes = (4 - len) & 3;
-	nwords = (len + extra_bytes) >> 2;
-	if (unlikely(qp->remote_ah_attr.ah_flags & IB_AH_GRH)) {
-		/* Header size in 32-bit words. */
-		hwords += 10;
-		lrh0 = IPS_LRH_GRH;
-		qp->s_hdr.u.l.grh.version_tclass_flow =
-			cpu_to_be32((6 << 28) |
-				    (qp->remote_ah_attr.grh.traffic_class
-				     << 20) |
-				    qp->remote_ah_attr.grh.flow_label);
-		qp->s_hdr.u.l.grh.paylen =
-			cpu_to_be16(((hwords - 12) + nwords +
-				     SIZE_OF_CRC) << 2);
-		/* next_hdr is defined by C8-7 in ch. 8.4.1 */
-		qp->s_hdr.u.l.grh.next_hdr = 0x1B;
-		qp->s_hdr.u.l.grh.hop_limit =
-			qp->remote_ah_attr.grh.hop_limit;
-		/* The SGID is 32-bit aligned. */
-		qp->s_hdr.u.l.grh.sgid.global.subnet_prefix =
-			dev->gid_prefix;
-		qp->s_hdr.u.l.grh.sgid.global.interface_id =
-			ipath_layer_get_guid(dev->dd);
-		qp->s_hdr.u.l.grh.dgid = qp->remote_ah_attr.grh.dgid;
-	}
 	qp->s_hdrwords = hwords;
 	qp->s_cur_sge = &qp->s_sge;
 	qp->s_cur_size = len;
-	lrh0 |= qp->remote_ah_attr.sl << 4;
-	qp->s_hdr.lrh[0] = cpu_to_be16(lrh0);
-	/* DEST LID */
-	qp->s_hdr.lrh[1] = cpu_to_be16(qp->remote_ah_attr.dlid);
-	qp->s_hdr.lrh[2] = cpu_to_be16(hwords + nwords + SIZE_OF_CRC);
-	qp->s_hdr.lrh[3] = cpu_to_be16(ipath_layer_get_lid(dev->dd));
-	bth0 |= extra_bytes << 20;
-	ohdr->bth[0] = cpu_to_be32(bth0);
-	ohdr->bth[1] = cpu_to_be32(qp->remote_qpn);
-	ohdr->bth[2] = cpu_to_be32(bth2);
-
-	/* Check for more work to do. */
-	goto again;
+	*bth0p = bth0 | (qp->s_state << 24);
+	*bth2p = qp->s_next_psn++ & IPS_PSN_MASK;
+	return 1;
 
 done:
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-	clear_bit(IPATH_S_BUSY, &qp->s_flags);
-
-bail:
-	return;
+	return 0;
 }
 
 /**
@@ -536,12 +441,13 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 		if (qp->r_len != 0) {
 			u32 rkey = be32_to_cpu(reth->rkey);
 			u64 vaddr = be64_to_cpu(reth->vaddr);
+			int ok;
 
 			/* Check rkey */
-			if (unlikely(!ipath_rkey_ok(
-					     dev, &qp->r_sge, qp->r_len,
-					     vaddr, rkey,
-					     IB_ACCESS_REMOTE_WRITE))) {
+			ok = ipath_rkey_ok(dev, &qp->r_sge, qp->r_len,
+					   vaddr, rkey,
+					   IB_ACCESS_REMOTE_WRITE);
+			if (unlikely(!ok)) {
 				dev->n_pkt_drops++;
 				goto done;
 			}
@@ -559,8 +465,7 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 		}
 		if (opcode == OP(RDMA_WRITE_ONLY))
 			goto rdma_last;
-		else if (opcode ==
-			 OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE))
+		else if (opcode == OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE))
 			goto rdma_last_imm;
 		/* FALLTHROUGH */
 	case OP(RDMA_WRITE_MIDDLE):
@@ -593,9 +498,9 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 			dev->n_pkt_drops++;
 			goto done;
 		}
-		if (qp->r_reuse_sge) {
+		if (qp->r_reuse_sge)
 			qp->r_reuse_sge = 0;
-		} else if (!ipath_get_rwqe(qp, 1)) {
+		else if (!ipath_get_rwqe(qp, 1)) {
 			dev->n_pkt_drops++;
 			goto done;
 		}
diff -r f7c82500b9c7 -r ebf646d10db0 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
@@ -194,7 +194,7 @@ static int ipath_post_send(struct ib_qp 
 		switch (qp->ibqp.qp_type) {
 		case IB_QPT_UC:
 		case IB_QPT_RC:
-			err = ipath_post_rc_send(qp, wr);
+			err = ipath_post_ruc_send(qp, wr);
 			break;
 
 		case IB_QPT_SMI:
diff -r f7c82500b9c7 -r ebf646d10db0 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
@@ -581,10 +581,6 @@ void ipath_sqerror_qp(struct ipath_qp *q
 
 void ipath_get_credit(struct ipath_qp *qp, u32 aeth);
 
-void ipath_do_rc_send(unsigned long data);
-
-void ipath_do_uc_send(unsigned long data);
-
 void ipath_cq_enter(struct ipath_cq *cq, struct ib_wc *entry, int sig);
 
 int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
@@ -597,7 +593,7 @@ void ipath_copy_sge(struct ipath_sge_sta
 
 void ipath_skip_sge(struct ipath_sge_state *ss, u32 length);
 
-int ipath_post_rc_send(struct ipath_qp *qp, struct ib_send_wr *wr);
+int ipath_post_ruc_send(struct ipath_qp *qp, struct ib_send_wr *wr);
 
 void ipath_uc_rcv(struct ipath_ibdev *dev, struct ipath_ib_header *hdr,
 		  int has_grh, void *data, u32 tlen, struct ipath_qp *qp);
@@ -679,7 +675,19 @@ void ipath_insert_rnr_queue(struct ipath
 
 int ipath_get_rwqe(struct ipath_qp *qp, int wr_id_only);
 
-void ipath_ruc_loopback(struct ipath_qp *sqp, struct ib_wc *wc);
+u32 ipath_make_grh(struct ipath_ibdev *dev, struct ib_grh *hdr,
+		   struct ib_global_route *grh, u32 hwords, u32 nwords);
+
+void ipath_do_ruc_send(unsigned long data);
+
+u32 ipath_make_rc_ack(struct ipath_qp *qp, struct ipath_other_headers *ohdr,
+		      u32 pmtu);
+
+int ipath_make_rc_req(struct ipath_qp *qp, struct ipath_other_headers *ohdr,
+		      u32 pmtu, u32 *bth0p, u32 *bth2p);
+
+int ipath_make_uc_req(struct ipath_qp *qp, struct ipath_other_headers *ohdr,
+		      u32 pmtu, u32 *bth0p, u32 *bth2p);
 
 extern const enum ib_wc_opcode ib_ipath_wc_opcode[];
 
