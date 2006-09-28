Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWI1QJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWI1QJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWI1QIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:08:01 -0400
Received: from mx.pathscale.com ([64.160.42.68]:65461 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751876AbWI1QBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:23 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 28] IB/ipath - ensure that PD of MR matches PD of QP
	checking the Rkey
X-Mercurial-Node: 4dbe5e686c780530dd0498cb7dde8ccd30af26d0
Message-Id: <4dbe5e686c780530dd04.1159459207@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:07 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Sep 28 08:57:12 2006 -0700
@@ -118,9 +118,10 @@ void ipath_free_lkey(struct ipath_lkey_t
  * Check the IB SGE for validity and initialize our internal version
  * of it.
  */
-int ipath_lkey_ok(struct ipath_lkey_table *rkt, struct ipath_sge *isge,
+int ipath_lkey_ok(struct ipath_qp *qp, struct ipath_sge *isge,
 		  struct ib_sge *sge, int acc)
 {
+	struct ipath_lkey_table *rkt = &to_idev(qp->ibqp.device)->lk_table;
 	struct ipath_mregion *mr;
 	unsigned n, m;
 	size_t off;
@@ -140,7 +141,8 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 		goto bail;
 	}
 	mr = rkt->table[(sge->lkey >> (32 - ib_ipath_lkey_table_size))];
-	if (unlikely(mr == NULL || mr->lkey != sge->lkey)) {
+	if (unlikely(mr == NULL || mr->lkey != sge->lkey ||
+		     qp->ibqp.pd != mr->pd)) {
 		ret = 0;
 		goto bail;
 	}
@@ -188,9 +190,10 @@ bail:
  *
  * Return 1 if successful, otherwise 0.
  */
-int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
+int ipath_rkey_ok(struct ipath_qp *qp, struct ipath_sge_state *ss,
 		  u32 len, u64 vaddr, u32 rkey, int acc)
 {
+	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	struct ipath_lkey_table *rkt = &dev->lk_table;
 	struct ipath_sge *sge = &ss->sge;
 	struct ipath_mregion *mr;
@@ -214,7 +217,8 @@ int ipath_rkey_ok(struct ipath_ibdev *de
 	}
 
 	mr = rkt->table[(rkey >> (32 - ib_ipath_lkey_table_size))];
-	if (unlikely(mr == NULL || mr->lkey != rkey)) {
+	if (unlikely(mr == NULL || mr->lkey != rkey ||
+		     qp->ibqp.pd != mr->pd)) {
 		ret = 0;
 		goto bail;
 	}
diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_mr.c
--- a/drivers/infiniband/hw/ipath/ipath_mr.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mr.c	Thu Sep 28 08:57:12 2006 -0700
@@ -138,6 +138,7 @@ struct ib_mr *ipath_reg_phys_mr(struct i
 		goto bail;
 	}
 
+	mr->mr.pd = pd;
 	mr->mr.user_base = *iova_start;
 	mr->mr.iova = *iova_start;
 	mr->mr.length = 0;
@@ -197,6 +198,7 @@ struct ib_mr *ipath_reg_user_mr(struct i
 		goto bail;
 	}
 
+	mr->mr.pd = pd;
 	mr->mr.user_base = region->user_base;
 	mr->mr.iova = region->virt_base;
 	mr->mr.length = region->length;
@@ -289,6 +291,7 @@ struct ib_fmr *ipath_alloc_fmr(struct ib
 	 * Resources are allocated but no valid mapping (RKEY can't be
 	 * used).
 	 */
+	fmr->mr.pd = pd;
 	fmr->mr.user_base = 0;
 	fmr->mr.iova = 0;
 	fmr->mr.length = 0;
diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -1234,7 +1234,7 @@ static inline int ipath_rc_rcv_error(str
 			 * Address range must be a subset of the original
 			 * request and start on pmtu boundaries.
 			 */
-			ok = ipath_rkey_ok(dev, &qp->s_rdma_sge,
+			ok = ipath_rkey_ok(qp, &qp->s_rdma_sge,
 					   qp->s_rdma_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_READ);
 			if (unlikely(!ok)) {
@@ -1532,7 +1532,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			int ok;
 
 			/* Check rkey & NAK */
-			ok = ipath_rkey_ok(dev, &qp->r_sge,
+			ok = ipath_rkey_ok(qp, &qp->r_sge,
 					   qp->r_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_WRITE);
 			if (unlikely(!ok))
@@ -1574,7 +1574,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			int ok;
 
 			/* Check rkey & NAK */
-			ok = ipath_rkey_ok(dev, &qp->s_rdma_sge,
+			ok = ipath_rkey_ok(qp, &qp->s_rdma_sge,
 					   qp->s_rdma_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_READ);
 			if (unlikely(!ok)) {
@@ -1633,7 +1633,7 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			goto nack_inv;
 		rkey = be32_to_cpu(ateth->rkey);
 		/* Check rkey & NAK */
-		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge,
+		if (unlikely(!ipath_rkey_ok(qp, &qp->r_sge,
 					    sizeof(u64), vaddr, rkey,
 					    IB_ACCESS_REMOTE_ATOMIC)))
 			goto nack_acc;
diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -108,7 +108,6 @@ void ipath_insert_rnr_queue(struct ipath
 
 static int init_sge(struct ipath_qp *qp, struct ipath_rwqe *wqe)
 {
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	int user = to_ipd(qp->ibqp.pd)->user;
 	int i, j, ret;
 	struct ib_wc wc;
@@ -119,8 +118,7 @@ static int init_sge(struct ipath_qp *qp,
 			continue;
 		/* Check LKEY */
 		if ((user && wqe->sg_list[i].lkey == 0) ||
-		    !ipath_lkey_ok(&dev->lk_table,
-				   &qp->r_sg_list[j], &wqe->sg_list[i],
+		    !ipath_lkey_ok(qp, &qp->r_sg_list[j], &wqe->sg_list[i],
 				   IB_ACCESS_LOCAL_WRITE))
 			goto bad_lkey;
 		qp->r_len += wqe->sg_list[i].length;
@@ -326,7 +324,7 @@ again:
 	case IB_WR_RDMA_WRITE:
 		if (wqe->length == 0)
 			break;
-		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, wqe->length,
+		if (unlikely(!ipath_rkey_ok(qp, &qp->r_sge, wqe->length,
 					    wqe->wr.wr.rdma.remote_addr,
 					    wqe->wr.wr.rdma.rkey,
 					    IB_ACCESS_REMOTE_WRITE))) {
@@ -350,7 +348,7 @@ again:
 		break;
 
 	case IB_WR_RDMA_READ:
-		if (unlikely(!ipath_rkey_ok(dev, &sqp->s_sge, wqe->length,
+		if (unlikely(!ipath_rkey_ok(qp, &sqp->s_sge, wqe->length,
 					    wqe->wr.wr.rdma.remote_addr,
 					    wqe->wr.wr.rdma.rkey,
 					    IB_ACCESS_REMOTE_READ)))
@@ -365,7 +363,7 @@ again:
 
 	case IB_WR_ATOMIC_CMP_AND_SWP:
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
-		if (unlikely(!ipath_rkey_ok(dev, &qp->r_sge, sizeof(u64),
+		if (unlikely(!ipath_rkey_ok(qp, &qp->r_sge, sizeof(u64),
 					    wqe->wr.wr.rdma.remote_addr,
 					    wqe->wr.wr.rdma.rkey,
 					    IB_ACCESS_REMOTE_ATOMIC)))
@@ -575,8 +573,7 @@ int ipath_post_ruc_send(struct ipath_qp 
 		}
 		if (wr->sg_list[i].length == 0)
 			continue;
-		if (!ipath_lkey_ok(&to_idev(qp->ibqp.device)->lk_table,
-				   &wqe->sg_list[j], &wr->sg_list[i],
+		if (!ipath_lkey_ok(qp, &wqe->sg_list[j], &wr->sg_list[i],
 				   acc)) {
 			spin_unlock_irqrestore(&qp->s_lock, flags);
 			ret = -EINVAL;
diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Sep 28 08:57:12 2006 -0700
@@ -444,7 +444,7 @@ void ipath_uc_rcv(struct ipath_ibdev *de
 			int ok;
 
 			/* Check rkey */
-			ok = ipath_rkey_ok(dev, &qp->r_sge, qp->r_len,
+			ok = ipath_rkey_ok(qp, &qp->r_sge, qp->r_len,
 					   vaddr, rkey,
 					   IB_ACCESS_REMOTE_WRITE);
 			if (unlikely(!ok)) {
diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Sep 28 08:57:12 2006 -0700
@@ -39,7 +39,6 @@ static int init_sge(struct ipath_qp *qp,
 static int init_sge(struct ipath_qp *qp, struct ipath_rwqe *wqe,
 		    u32 *lengthp, struct ipath_sge_state *ss)
 {
-	struct ipath_ibdev *dev = to_idev(qp->ibqp.device);
 	int user = to_ipd(qp->ibqp.pd)->user;
 	int i, j, ret;
 	struct ib_wc wc;
@@ -50,8 +49,7 @@ static int init_sge(struct ipath_qp *qp,
 			continue;
 		/* Check LKEY */
 		if ((user && wqe->sg_list[i].lkey == 0) ||
-		    !ipath_lkey_ok(&dev->lk_table,
-				   j ? &ss->sg_list[j - 1] : &ss->sge,
+		    !ipath_lkey_ok(qp, j ? &ss->sg_list[j - 1] : &ss->sge,
 				   &wqe->sg_list[i], IB_ACCESS_LOCAL_WRITE))
 			goto bad_lkey;
 		*lengthp += wqe->sg_list[i].length;
@@ -343,7 +341,7 @@ int ipath_post_ud_send(struct ipath_qp *
 
 		if (wr->sg_list[i].length == 0)
 			continue;
-		if (!ipath_lkey_ok(&dev->lk_table, ss.num_sge ?
+		if (!ipath_lkey_ok(qp, ss.num_sge ?
 				   sg_list + ss.num_sge - 1 : &ss.sge,
 				   &wr->sg_list[i], 0)) {
 			ret = -EINVAL;
diff -r f8c0eb9dc3b8 -r 4dbe5e686c78 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Sep 28 08:57:12 2006 -0700
@@ -220,6 +220,7 @@ struct ipath_segarray {
 };
 
 struct ipath_mregion {
+	struct ib_pd *pd;	/* shares refcnt of ibmr.pd */
 	u64 user_base;		/* User's address for this region */
 	u64 iova;		/* IB start address of this region */
 	size_t length;
@@ -657,12 +658,6 @@ int ipath_verbs_send(struct ipath_devdat
 
 void ipath_cq_enter(struct ipath_cq *cq, struct ib_wc *entry, int sig);
 
-int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
-		  u32 len, u64 vaddr, u32 rkey, int acc);
-
-int ipath_lkey_ok(struct ipath_lkey_table *rkt, struct ipath_sge *isge,
-		  struct ib_sge *sge, int acc);
-
 void ipath_copy_sge(struct ipath_sge_state *ss, void *data, u32 length);
 
 void ipath_skip_sge(struct ipath_sge_state *ss, u32 length);
@@ -687,10 +682,10 @@ int ipath_alloc_lkey(struct ipath_lkey_t
 
 void ipath_free_lkey(struct ipath_lkey_table *rkt, u32 lkey);
 
-int ipath_lkey_ok(struct ipath_lkey_table *rkt, struct ipath_sge *isge,
+int ipath_lkey_ok(struct ipath_qp *qp, struct ipath_sge *isge,
 		  struct ib_sge *sge, int acc);
 
-int ipath_rkey_ok(struct ipath_ibdev *dev, struct ipath_sge_state *ss,
+int ipath_rkey_ok(struct ipath_qp *qp, struct ipath_sge_state *ss,
 		  u32 len, u64 vaddr, u32 rkey, int acc);
 
 int ipath_post_srq_receive(struct ib_srq *ibsrq, struct ib_recv_wr *wr,
