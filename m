Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVKJScF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVKJScF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKJScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:32:04 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22336 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932137AbVKJScB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:32:01 -0500
Subject: [git patch review 3/7] [IB] uverbs: have kernel return QP capabilities
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 18:31:55 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131647515831-b1175b20ec8fd319@cisco.com>
In-Reply-To: <1131647515831-cd68db8e19d165ad@cisco.com>
X-OriginalArrivalTime: 10 Nov 2005 18:31:56.0871 (UTC) FILETIME=[07C8DD70:01C5E625]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the computation of QP capabilities (max scatter/gather entries,
max inline data, etc) into the kernel, and have the uverbs module
return the values as part of the create QP response.  This keeps
precise knowledge of device limits in the low-level kernel driver.

This requires an ABI bump, so while we're making changes, get rid of
the max_sge parameter for the modify SRQ command -- it's not used and
shouldn't be there.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs_cmd.c         |   12 ++--
 drivers/infiniband/hw/mthca/mthca_cmd.c      |    2 +
 drivers/infiniband/hw/mthca/mthca_dev.h      |    1 
 drivers/infiniband/hw/mthca/mthca_main.c     |    1 
 drivers/infiniband/hw/mthca/mthca_provider.c |    2 -
 drivers/infiniband/hw/mthca/mthca_provider.h |    1 
 drivers/infiniband/hw/mthca/mthca_qp.c       |   86 ++++++++++++++++++++++++--
 include/rdma/ib_user_verbs.h                 |    9 ++-
 8 files changed, 98 insertions(+), 16 deletions(-)

applies-to: 2741f22c820fb664f6958becc4f3d415eea0e61b
77369ed31daac51f4827c50d30f233c45480235a
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 63a7415..ed45da8 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -708,7 +708,7 @@ ssize_t ib_uverbs_poll_cq(struct ib_uver
 		resp->wc[i].opcode 	   = wc[i].opcode;
 		resp->wc[i].vendor_err 	   = wc[i].vendor_err;
 		resp->wc[i].byte_len 	   = wc[i].byte_len;
-		resp->wc[i].imm_data 	   = wc[i].imm_data;
+		resp->wc[i].imm_data 	   = (__u32 __force) wc[i].imm_data;
 		resp->wc[i].qp_num 	   = wc[i].qp_num;
 		resp->wc[i].src_qp 	   = wc[i].src_qp;
 		resp->wc[i].wc_flags 	   = wc[i].wc_flags;
@@ -908,7 +908,12 @@ retry:
 	if (ret)
 		goto err_destroy;
 
-	resp.qp_handle = uobj->uobject.id;
+	resp.qp_handle       = uobj->uobject.id;
+	resp.max_recv_sge    = attr.cap.max_recv_sge;
+	resp.max_send_sge    = attr.cap.max_send_sge;
+	resp.max_recv_wr     = attr.cap.max_recv_wr;
+	resp.max_send_wr     = attr.cap.max_send_wr;
+	resp.max_inline_data = attr.cap.max_inline_data;
 
 	if (copy_to_user((void __user *) (unsigned long) cmd.response,
 			 &resp, sizeof resp)) {
@@ -1135,7 +1140,7 @@ ssize_t ib_uverbs_post_send(struct ib_uv
 		next->num_sge    = user_wr->num_sge;
 		next->opcode     = user_wr->opcode;
 		next->send_flags = user_wr->send_flags;
-		next->imm_data   = user_wr->imm_data;
+		next->imm_data   = (__be32 __force) user_wr->imm_data;
 
 		if (qp->qp_type == IB_QPT_UD) {
 			next->wr.ud.ah = idr_find(&ib_uverbs_ah_idr,
@@ -1701,7 +1706,6 @@ ssize_t ib_uverbs_modify_srq(struct ib_u
 	}
 
 	attr.max_wr    = cmd.max_wr;
-	attr.max_sge   = cmd.max_sge;
 	attr.srq_limit = cmd.srq_limit;
 
 	ret = ib_modify_srq(srq, &attr, cmd.attr_mask);
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 49f211d..9ed3458 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -1060,6 +1060,8 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 		dev_lim->hca.arbel.resize_srq = field & 1;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
 		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
+		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MAX_DESC_SZ_RQ_OFFSET);
+		dev_lim->max_desc_sz = min_t(int, size, dev_lim->max_desc_sz);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
 		dev_lim->mpt_entry_sz = size;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_PBL_SZ_OFFSET);
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 808037f..497ff79 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -131,6 +131,7 @@ struct mthca_limits {
 	int      max_sg;
 	int      num_qps;
 	int      max_wqes;
+	int	 max_desc_sz;
 	int	 max_qp_init_rdma;
 	int      reserved_qps;
 	int      num_srqs;
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 16594d1..147f248 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -168,6 +168,7 @@ static int __devinit mthca_dev_lim(struc
 	mdev->limits.max_srq_wqes       = dev_lim->max_srq_sz;
 	mdev->limits.reserved_srqs      = dev_lim->reserved_srqs;
 	mdev->limits.reserved_eecs      = dev_lim->reserved_eecs;
+	mdev->limits.max_desc_sz        = dev_lim->max_desc_sz;
 	/*
 	 * Subtract 1 from the limit because we need to allocate a
 	 * spare CQE so the HCA HW can tell the difference between an
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index e78259b..4cc7e28 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -616,11 +616,11 @@ static struct ib_qp *mthca_create_qp(str
 		return ERR_PTR(err);
 	}
 
-	init_attr->cap.max_inline_data = 0;
 	init_attr->cap.max_send_wr     = qp->sq.max;
 	init_attr->cap.max_recv_wr     = qp->rq.max;
 	init_attr->cap.max_send_sge    = qp->sq.max_gs;
 	init_attr->cap.max_recv_sge    = qp->rq.max_gs;
+	init_attr->cap.max_inline_data = qp->max_inline_data;
 
 	return &qp->ibqp;
 }
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index bcd4b01..1e73947 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -251,6 +251,7 @@ struct mthca_qp {
 	struct mthca_wq        sq;
 	enum ib_sig_type       sq_policy;
 	int                    send_wqe_offset;
+	int                    max_inline_data;
 
 	u64                   *wrid;
 	union mthca_buf	       queue;
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 8852ea4..7f39af4 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -885,6 +885,48 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	return err;
 }
 
+static void mthca_adjust_qp_caps(struct mthca_dev *dev,
+				 struct mthca_pd *pd,
+				 struct mthca_qp *qp)
+{
+	int max_data_size;
+
+	/*
+	 * Calculate the maximum size of WQE s/g segments, excluding
+	 * the next segment and other non-data segments.
+	 */
+	max_data_size = min(dev->limits.max_desc_sz, 1 << qp->sq.wqe_shift) -
+		sizeof (struct mthca_next_seg);
+
+	switch (qp->transport) {
+	case MLX:
+		max_data_size -= 2 * sizeof (struct mthca_data_seg);
+		break;
+
+	case UD:
+		if (mthca_is_memfree(dev))
+			max_data_size -= sizeof (struct mthca_arbel_ud_seg);
+		else
+			max_data_size -= sizeof (struct mthca_tavor_ud_seg);
+		break;
+
+	default:
+		max_data_size -= sizeof (struct mthca_raddr_seg);
+		break;
+	}
+
+	/* We don't support inline data for kernel QPs (yet). */
+	if (!pd->ibpd.uobject)
+		qp->max_inline_data = 0;
+        else
+		qp->max_inline_data = max_data_size - MTHCA_INLINE_HEADER_SIZE;
+
+	qp->sq.max_gs = max_data_size / sizeof (struct mthca_data_seg);
+	qp->rq.max_gs = (min(dev->limits.max_desc_sz, 1 << qp->rq.wqe_shift) -
+			sizeof (struct mthca_next_seg)) /
+			sizeof (struct mthca_data_seg);
+}
+
 /*
  * Allocate and register buffer for WQEs.  qp->rq.max, sq.max,
  * rq.max_gs and sq.max_gs must all be assigned.
@@ -902,27 +944,53 @@ static int mthca_alloc_wqe_buf(struct mt
 	size = sizeof (struct mthca_next_seg) +
 		qp->rq.max_gs * sizeof (struct mthca_data_seg);
 
+	if (size > dev->limits.max_desc_sz)
+		return -EINVAL;
+
 	for (qp->rq.wqe_shift = 6; 1 << qp->rq.wqe_shift < size;
 	     qp->rq.wqe_shift++)
 		; /* nothing */
 
-	size = sizeof (struct mthca_next_seg) +
-		qp->sq.max_gs * sizeof (struct mthca_data_seg);
+	size = qp->sq.max_gs * sizeof (struct mthca_data_seg);
 	switch (qp->transport) {
 	case MLX:
 		size += 2 * sizeof (struct mthca_data_seg);
 		break;
+
 	case UD:
-		if (mthca_is_memfree(dev))
-			size += sizeof (struct mthca_arbel_ud_seg);
-		else
-			size += sizeof (struct mthca_tavor_ud_seg);
+		size += mthca_is_memfree(dev) ?
+			sizeof (struct mthca_arbel_ud_seg) :
+			sizeof (struct mthca_tavor_ud_seg);
+		break;
+
+	case UC:
+		size += sizeof (struct mthca_raddr_seg);
+		break;
+
+	case RC:
+		size += sizeof (struct mthca_raddr_seg);
+		/*
+		 * An atomic op will require an atomic segment, a
+		 * remote address segment and one scatter entry.
+		 */
+		size = max_t(int, size,
+			     sizeof (struct mthca_atomic_seg) +
+			     sizeof (struct mthca_raddr_seg) +
+			     sizeof (struct mthca_data_seg));
 		break;
+
 	default:
-		/* bind seg is as big as atomic + raddr segs */
-		size += sizeof (struct mthca_bind_seg);
+		break;
 	}
 
+	/* Make sure that we have enough space for a bind request */
+	size = max_t(int, size, sizeof (struct mthca_bind_seg));
+
+	size += sizeof (struct mthca_next_seg);
+
+	if (size > dev->limits.max_desc_sz)
+		return -EINVAL;
+
 	for (qp->sq.wqe_shift = 6; 1 << qp->sq.wqe_shift < size;
 	     qp->sq.wqe_shift++)
 		; /* nothing */
@@ -1066,6 +1134,8 @@ static int mthca_alloc_qp_common(struct 
 		return ret;
 	}
 
+	mthca_adjust_qp_caps(dev, pd, qp);
+
 	/*
 	 * If this is a userspace QP, we're done now.  The doorbells
 	 * will be allocated and buffers will be initialized in
diff --git a/include/rdma/ib_user_verbs.h b/include/rdma/ib_user_verbs.h
index 072f3a2..5ff1490 100644
--- a/include/rdma/ib_user_verbs.h
+++ b/include/rdma/ib_user_verbs.h
@@ -43,7 +43,7 @@
  * Increment this value if any changes that break userspace ABI
  * compatibility are made.
  */
-#define IB_USER_VERBS_ABI_VERSION	3
+#define IB_USER_VERBS_ABI_VERSION	4
 
 enum {
 	IB_USER_VERBS_CMD_GET_CONTEXT,
@@ -333,6 +333,11 @@ struct ib_uverbs_create_qp {
 struct ib_uverbs_create_qp_resp {
 	__u32 qp_handle;
 	__u32 qpn;
+	__u32 max_send_wr;
+	__u32 max_recv_wr;
+	__u32 max_send_sge;
+	__u32 max_recv_sge;
+	__u32 max_inline_data;
 };
 
 /*
@@ -552,9 +557,7 @@ struct ib_uverbs_modify_srq {
 	__u32 srq_handle;
 	__u32 attr_mask;
 	__u32 max_wr;
-	__u32 max_sge;
 	__u32 srq_limit;
-	__u32 reserved;
 	__u64 driver_data[0];
 };
 
---
0.99.9e
