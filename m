Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWHYS23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWHYS23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHYSZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:31 -0400
Received: from mx.pathscale.com ([64.160.42.68]:44162 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422768AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 23] IB/ipath - be more strict about testing the modify
	QP verb
X-Mercurial-Node: 24ecb7ac41f857a67660f0f91b38725efbd8ac10
Message-Id: <24ecb7ac41f857a67660.1156530281@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:41 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -455,11 +455,16 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 				attr_mask))
 		goto inval;
 
-	if (attr_mask & IB_QP_AV)
+	if (attr_mask & IB_QP_AV) {
 		if (attr->ah_attr.dlid == 0 ||
 		    attr->ah_attr.dlid >= IPATH_MULTICAST_LID_BASE)
 			goto inval;
 
+		if ((attr->ah_attr.ah_flags & IB_AH_GRH) &&
+		    (attr->ah_attr.grh.sgid_index > 1))
+			goto inval;
+	}
+
 	if (attr_mask & IB_QP_PKEY_INDEX)
 		if (attr->pkey_index >= ipath_get_npkeys(dev->dd))
 			goto inval;
@@ -468,6 +473,27 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 		if (attr->min_rnr_timer > 31)
 			goto inval;
 
+	if (attr_mask & IB_QP_PORT)
+		if (attr->port_num == 0 ||
+		    attr->port_num > ibqp->device->phys_port_cnt)
+			goto inval;
+
+	if (attr_mask & IB_QP_PATH_MTU)
+		if (attr->path_mtu > IB_MTU_4096)
+			goto inval;
+
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
+		if (attr->max_dest_rd_atomic > 1)
+			goto inval;
+ 
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC)
+		if (attr->max_rd_atomic > 1)
+			goto inval;
+ 
+	if (attr_mask & IB_QP_PATH_MIG_STATE)
+		if (attr->path_mig_state != IB_MIG_MIGRATED)
+			goto inval;
+ 
 	switch (new_state) {
 	case IB_QPS_RESET:
 		ipath_reset_qp(qp);
@@ -517,6 +543,9 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 
 	if (attr_mask & IB_QP_MIN_RNR_TIMER)
 		qp->r_min_rnr_timer = attr->min_rnr_timer;
+
+	if (attr_mask & IB_QP_TIMEOUT)
+		qp->timeout = attr->timeout;
 
 	if (attr_mask & IB_QP_QKEY)
 		qp->qkey = attr->qkey;
@@ -564,7 +593,7 @@ int ipath_query_qp(struct ib_qp *ibqp, s
 	attr->max_dest_rd_atomic = 1;
 	attr->min_rnr_timer = qp->r_min_rnr_timer;
 	attr->port_num = 1;
-	attr->timeout = 0;
+	attr->timeout = qp->timeout;
 	attr->retry_cnt = qp->s_retry_cnt;
 	attr->rnr_retry = qp->s_rnr_retry;
 	attr->alt_port_num = 0;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Fri Aug 25 11:19:45 2006 -0700
@@ -371,6 +371,7 @@ struct ipath_qp {
 	u8 s_retry;		/* requester retry counter */
 	u8 s_rnr_retry;		/* requester RNR retry counter */
 	u8 s_pkey_index;	/* PKEY index to use */
+	u8 timeout;		/* Timeout for this QP */
 	enum ib_mtu path_mtu;
 	u32 remote_qpn;
 	u32 qkey;		/* QKEY for this QP (for UD or RD) */
