Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVJaWgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVJaWgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVJaWfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:35:01 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:59658 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S964810AbVJaWev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:34:51 -0500
Subject: [git patch review 5/5] [IPoIB] cleanups: fix comment,
	remove useless variables
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 22:34:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1130798082548-b095f02a09987549@cisco.com>
In-Reply-To: <1130798082548-8e2587fc62785f94@cisco.com>
X-OriginalArrivalTime: 31 Oct 2005 22:34:43.0745 (UTC) FILETIME=[4A2FF110:01C5DE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanups: fix a misleading comment, and get rid of attr_mask
variables that are only used to hold constants (just use the constants
directly).

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_ib.c    |   12 ++++++------
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c |    4 +---
 2 files changed, 7 insertions(+), 9 deletions(-)

applies-to: c29760bafd7107252389712965ad7e4ed0791a82
3bc12e75b23c0499cc2c0873a5f77494be173761
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 192fef8..0a6f578 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -486,15 +486,16 @@ int ipoib_ib_dev_stop(struct net_device 
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ib_qp_attr qp_attr;
-	int attr_mask;
 	unsigned long begin;
 	struct ipoib_tx_buf *tx_req;
 	int i;
 
-	/* Kill the existing QP and allocate a new one */
+	/*
+	 * Move our QP to the error state and then reinitialize in
+	 * when all work requests have completed or have been flushed.
+	 */
 	qp_attr.qp_state = IB_QPS_ERR;
-	attr_mask        = IB_QP_STATE;
-	if (ib_modify_qp(priv->qp, &qp_attr, attr_mask))
+	if (ib_modify_qp(priv->qp, &qp_attr, IB_QP_STATE))
 		ipoib_warn(priv, "Failed to modify QP to ERROR state\n");
 
 	/* Wait for all sends and receives to complete */
@@ -541,8 +542,7 @@ int ipoib_ib_dev_stop(struct net_device 
 
 timeout:
 	qp_attr.qp_state = IB_QPS_RESET;
-	attr_mask        = IB_QP_STATE;
-	if (ib_modify_qp(priv->qp, &qp_attr, attr_mask))
+	if (ib_modify_qp(priv->qp, &qp_attr, IB_QP_STATE))
 		ipoib_warn(priv, "Failed to modify QP to RESET state\n");
 
 	/* Wait for all AHs to be reaped */
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index b5902a7..e829e10 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -41,7 +41,6 @@ int ipoib_mcast_attach(struct net_device
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ib_qp_attr *qp_attr;
-	int attr_mask;
 	int ret;
 	u16 pkey_index;
 
@@ -59,8 +58,7 @@ int ipoib_mcast_attach(struct net_device
 
 	/* set correct QKey for QP */
 	qp_attr->qkey = priv->qkey;
-	attr_mask = IB_QP_QKEY;
-	ret = ib_modify_qp(priv->qp, qp_attr, attr_mask);
+	ret = ib_modify_qp(priv->qp, qp_attr, IB_QP_QKEY);
 	if (ret) {
 		ipoib_warn(priv, "failed to modify QP, ret = %d\n", ret);
 		goto out;
---
0.99.9
