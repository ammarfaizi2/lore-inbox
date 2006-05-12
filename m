Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWELXuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWELXuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWELXpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:10 -0400
Received: from mx.pathscale.com ([64.160.42.68]:61865 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932281AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 38 of 53] ipath - SRQ compliance checks
X-Mercurial-Node: e9306861dc6a82d0dc192402b1694221884acacc
Message-Id: <e9306861dc6a82d0dc19.1147477403@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:23 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were not rigorous enough in checking SRQs.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r f8debae94d44 -r e9306861dc6a drivers/infiniband/hw/ipath/ipath_srq.c
--- a/drivers/infiniband/hw/ipath/ipath_srq.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_srq.c	Fri May 12 15:55:28 2006 -0700
@@ -125,11 +125,23 @@ struct ib_srq *ipath_create_srq(struct i
 				struct ib_srq_init_attr *srq_init_attr,
 				struct ib_udata *udata)
 {
+	struct ipath_ibdev *dev = to_idev(ibpd->device);
 	struct ipath_srq *srq;
 	u32 sz;
 	struct ib_srq *ret;
 
-	if (srq_init_attr->attr.max_sge < 1) {
+	if (dev->n_srqs_allocated == ib_ipath_max_srqs) {
+		ret = ERR_PTR(-ENOMEM);
+		goto bail;
+	}
+
+	if (srq_init_attr->attr.max_wr == 0) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
+	if ((srq_init_attr->attr.max_sge > ib_ipath_max_srq_sges) ||
+	    (srq_init_attr->attr.max_wr > ib_ipath_max_srq_wrs)) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
 	}
@@ -164,6 +176,8 @@ struct ib_srq *ipath_create_srq(struct i
 
 	ret = &srq->ibsrq;
 
+	dev->n_srqs_allocated++;
+
 bail:
 	return ret;
 }
@@ -181,24 +195,26 @@ int ipath_modify_srq(struct ib_srq *ibsr
 	unsigned long flags;
 	int ret;
 
-	if (attr_mask & IB_SRQ_LIMIT) {
-		spin_lock_irqsave(&srq->rq.lock, flags);
-		srq->limit = attr->srq_limit;
-		spin_unlock_irqrestore(&srq->rq.lock, flags);
-	}
+	if (attr_mask & IB_SRQ_MAX_WR)
+		if ((attr->max_wr > ib_ipath_max_srq_wrs) ||
+		    (attr->max_sge > srq->rq.max_sge)) {
+			ret = -EINVAL;
+			goto bail;
+		}
+
+	if (attr_mask & IB_SRQ_LIMIT)
+		if (attr->srq_limit >= srq->rq.size) {
+			ret = -EINVAL;
+			goto bail;
+		}
+
 	if (attr_mask & IB_SRQ_MAX_WR) {
-		u32 size = attr->max_wr + 1;
 		struct ipath_rwqe *wq, *p;
-		u32 n;
-		u32 sz;
-
-		if (attr->max_sge < srq->rq.max_sge) {
-			ret = -EINVAL;
-			goto bail;
-		}
+		u32 sz, size, n;
 
 		sz = sizeof(struct ipath_rwqe) +
 			attr->max_sge * sizeof(struct ipath_sge);
+		size = attr->max_wr + 1;
 		wq = vmalloc(size * sz);
 		if (!wq) {
 			ret = -ENOMEM;
@@ -242,6 +258,11 @@ int ipath_modify_srq(struct ib_srq *ibsr
 		spin_unlock_irqrestore(&srq->rq.lock, flags);
 	}
 
+	if (attr_mask & IB_SRQ_LIMIT) {
+		spin_lock_irqsave(&srq->rq.lock, flags);
+		srq->limit = attr->srq_limit;
+		spin_unlock_irqrestore(&srq->rq.lock, flags);
+	}
 	ret = 0;
 
 bail:
@@ -265,7 +286,9 @@ int ipath_destroy_srq(struct ib_srq *ibs
 int ipath_destroy_srq(struct ib_srq *ibsrq)
 {
 	struct ipath_srq *srq = to_isrq(ibsrq);
-
+	struct ipath_ibdev *dev = to_idev(ibsrq->device);
+
+	dev->n_srqs_allocated--;
 	vfree(srq->rq.wq);
 	kfree(srq);
 
diff -r f8debae94d44 -r e9306861dc6a drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri May 12 15:55:28 2006 -0700
@@ -436,6 +436,7 @@ struct ipath_ibdev {
 	u32 n_pds_allocated;	/* number of PDs allocated for device */
 	u32 n_ahs_allocated;	/* number of AHs allocated for device */
 	u32 n_cqs_allocated;	/* number of CQs allocated for device */
+	u32 n_srqs_allocated;	/* number of SRQs allocated for device */
 	u32 n_mcast_grps_allocated; /* number of mcast groups allocated */
 	u64 ipath_sword;	/* total dwords sent (sample result) */
 	u64 ipath_rword;	/* total dwords received (sample result) */
