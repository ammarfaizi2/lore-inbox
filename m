Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932989AbWF2WEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbWF2WEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbWF2WD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:03:57 -0400
Received: from mx.pathscale.com ([64.160.42.68]:32143 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932841AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 39] IB/ipath - fix shared receive queues for RC
X-Mercurial-Node: e4f29a4e0c0fedcbe3c82c55da449ba63e213acb
Message-Id: <e4f29a4e0c0fedcbe3c8.1151617256@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:56 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r c93c2b42d279 -r e4f29a4e0c0f drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -257,7 +257,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 			break;
 
 		case IB_WR_RDMA_WRITE:
-			if (newreq)
+			if (newreq && qp->s_lsn != (u32) -1)
 				qp->s_lsn++;
 			/* FALLTHROUGH */
 		case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -283,8 +283,7 @@ int ipath_make_rc_req(struct ipath_qp *q
 			else {
 				qp->s_state =
 					OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE);
-				/* Immediate data comes
-				 * after RETH */
+				/* Immediate data comes after RETH */
 				ohdr->u.rc.imm_data = wqe->wr.imm_data;
 				hwords += 1;
 				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
@@ -304,7 +303,8 @@ int ipath_make_rc_req(struct ipath_qp *q
 			qp->s_state = OP(RDMA_READ_REQUEST);
 			hwords += sizeof(ohdr->u.rc.reth) / 4;
 			if (newreq) {
-				qp->s_lsn++;
+				if (qp->s_lsn != (u32) -1)
+					qp->s_lsn++;
 				/*
 				 * Adjust s_next_psn to count the
 				 * expected number of responses.
@@ -335,7 +335,8 @@ int ipath_make_rc_req(struct ipath_qp *q
 				wqe->wr.wr.atomic.compare_add);
 			hwords += sizeof(struct ib_atomic_eth) / 4;
 			if (newreq) {
-				qp->s_lsn++;
+				if (qp->s_lsn != (u32) -1)
+					qp->s_lsn++;
 				wqe->lpsn = wqe->psn;
 			}
 			if (++qp->s_cur == qp->s_size)
@@ -553,6 +554,88 @@ static void send_rc_ack(struct ipath_qp 
 }
 
 /**
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
+}
+
+/**
  * ipath_restart_rc - back up requester to resend the last un-ACKed request
  * @qp: the QP to restart
  * @psn: packet sequence number for the request
@@ -564,7 +647,6 @@ void ipath_restart_rc(struct ipath_qp *q
 {
 	struct ipath_swqe *wqe = get_swqe_ptr(qp, qp->s_last);
 	struct ipath_ibdev *dev;
-	u32 n;
 
 	/*
 	 * If there are no requests pending, we are done.
@@ -606,130 +688,13 @@ void ipath_restart_rc(struct ipath_qp *q
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
- * This is called from ipath_rc_rcv_resp() to process an incoming RC ACK
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
@@ -738,7 +703,7 @@ static void reset_psn(struct ipath_qp *q
  * @psn: the packet sequence number of the ACK
  * @opcode: the opcode of the request that resulted in the ACK
  *
- * This is called from ipath_rc_rcv() to process an incoming RC ACK
+ * This is called from ipath_rc_rcv_resp() to process an incoming RC ACK
  * for the given QP.
  * Called at interrupt level with the QP s_lock held.
  * Returns 1 if OK, 0 if current operation should be aborted (NAK).
@@ -877,22 +842,12 @@ static int do_rc_ack(struct ipath_qp *qp
 		if (qp->s_last == qp->s_tail)
 			goto bail;
 
-		/* The last valid PSN seen is the previous request's. */
-		qp->s_last_psn = wqe->psn - 1;
+		/* The last valid PSN is the previous PSN. */
+		qp->s_last_psn = psn - 1;
 
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
@@ -1070,9 +1025,10 @@ static inline void ipath_rc_rcv_resp(str
 				       &dev->pending[dev->pending_index]);
 		spin_unlock(&dev->pending_lock);
 		/*
-		 * Update the RDMA receive state but do the copy w/o holding the
-		 * locks and blocking interrupts.  XXX Yet another place that
-		 * affects relaxed RDMA order since we don't want s_sge modified.
+		 * Update the RDMA receive state but do the copy w/o
+		 * holding the locks and blocking interrupts.
+		 * XXX Yet another place that affects relaxed RDMA order
+		 * since we don't want s_sge modified.
 		 */
 		qp->s_len -= pmtu;
 		qp->s_last_psn = psn;
@@ -1119,9 +1075,12 @@ static inline void ipath_rc_rcv_resp(str
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
