Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWEWSeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWEWSeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWEWSdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:39 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2743 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751194AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 10] ipath - don't modify QP if changes fail
X-Mercurial-Node: bb640dcf4d9dc18cf02eacb6b4c8a6599b40b1d0
Message-Id: <bb640dcf4d9dc18cf02e.1148409150@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:30 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure modify_qp won't modify the QP if any of the changes failed.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r bc968dacc860 -r bb640dcf4d9d drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Tue May 23 11:29:15 2006 -0700
@@ -427,6 +427,7 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 int ipath_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		    int attr_mask)
 {
+	struct ipath_ibdev *dev = to_idev(ibqp->device);
 	struct ipath_qp *qp = to_iqp(ibqp);
 	enum ib_qp_state cur_state, new_state;
 	unsigned long flags;
@@ -443,6 +444,19 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 				attr_mask))
 		goto inval;
 
+	if (attr_mask & IB_QP_AV)
+		if (attr->ah_attr.dlid == 0 ||
+		    attr->ah_attr.dlid >= IPS_MULTICAST_LID_BASE)
+			goto inval;
+
+	if (attr_mask & IB_QP_PKEY_INDEX)
+		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->dd))
+			goto inval;
+
+	if (attr_mask & IB_QP_MIN_RNR_TIMER)
+		if (attr->min_rnr_timer > 31)
+			goto inval;
+
 	switch (new_state) {
 	case IB_QPS_RESET:
 		ipath_reset_qp(qp);
@@ -457,13 +471,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 
 	}
 
-	if (attr_mask & IB_QP_PKEY_INDEX) {
-		struct ipath_ibdev *dev = to_idev(ibqp->device);
-
-		if (attr->pkey_index >= ipath_layer_get_npkeys(dev->dd))
-			goto inval;
+	if (attr_mask & IB_QP_PKEY_INDEX)
 		qp->s_pkey_index = attr->pkey_index;
-	}
 
 	if (attr_mask & IB_QP_DEST_QPN)
 		qp->remote_qpn = attr->dest_qp_num;
@@ -479,12 +488,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 	if (attr_mask & IB_QP_ACCESS_FLAGS)
 		qp->qp_access_flags = attr->qp_access_flags;
 
-	if (attr_mask & IB_QP_AV) {
-		if (attr->ah_attr.dlid == 0 ||
-		    attr->ah_attr.dlid >= IPS_MULTICAST_LID_BASE)
-			goto inval;
+	if (attr_mask & IB_QP_AV)
 		qp->remote_ah_attr = attr->ah_attr;
-	}
 
 	if (attr_mask & IB_QP_PATH_MTU)
 		qp->path_mtu = attr->path_mtu;
@@ -499,11 +504,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 		qp->s_rnr_retry_cnt = qp->s_rnr_retry;
 	}
 
-	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
-		if (attr->min_rnr_timer > 31)
-			goto inval;
+	if (attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp->s_min_rnr_timer = attr->min_rnr_timer;
-	}
 
 	if (attr_mask & IB_QP_QKEY)
 		qp->qkey = attr->qkey;
