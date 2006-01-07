Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965368AbWAGAZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965368AbWAGAZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965375AbWAGAZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:47 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:18065 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S965368AbWAGAZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:46 -0500
X-IronPort-AV: i="3.99,341,1131350400"; 
   d="scan'208"; a="388438778:sNHT31543520"
Subject: [git patch review 1/8] IB/mthca: max_inline_data handling tweaks
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593542999-4f2f4395a7bd3191@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:43.0523 (UTC) FILETIME=[E566AB30:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a case where copying max_inline_data from a successful create_qp
capabilities output to create_qp input could cause EINVAL error:

mthca_set_qp_size must check max_inline_data directly against
max_desc_sz; checking qp->sq.max_gs is wrong since max_inline_data
depends on the qp type and does not involve max_sg.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   62 +++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 26 deletions(-)

5b3bc7a68171138d52b1b62012c37ac888895460
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index ea45fa4..fd60cf3 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -890,18 +890,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	return err;
 }
 
-static void mthca_adjust_qp_caps(struct mthca_dev *dev,
-				 struct mthca_pd *pd,
-				 struct mthca_qp *qp)
+static int mthca_max_data_size(struct mthca_dev *dev, struct mthca_qp *qp, int desc_sz)
 {
-	int max_data_size;
-
 	/*
 	 * Calculate the maximum size of WQE s/g segments, excluding
 	 * the next segment and other non-data segments.
 	 */
-	max_data_size = min(dev->limits.max_desc_sz, 1 << qp->sq.wqe_shift) -
-		sizeof (struct mthca_next_seg);
+	int max_data_size = desc_sz - sizeof (struct mthca_next_seg);
 
 	switch (qp->transport) {
 	case MLX:
@@ -920,11 +915,24 @@ static void mthca_adjust_qp_caps(struct 
 		break;
 	}
 
+	return max_data_size;
+}
+
+static inline int mthca_max_inline_data(struct mthca_pd *pd, int max_data_size)
+{
 	/* We don't support inline data for kernel QPs (yet). */
-	if (!pd->ibpd.uobject)
-		qp->max_inline_data = 0;
-        else
-		qp->max_inline_data = max_data_size - MTHCA_INLINE_HEADER_SIZE;
+	return pd->ibpd.uobject ? max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
+}
+
+static void mthca_adjust_qp_caps(struct mthca_dev *dev,
+				 struct mthca_pd *pd,
+				 struct mthca_qp *qp)
+{
+	int max_data_size = mthca_max_data_size(dev, qp,
+						min(dev->limits.max_desc_sz,
+						    1 << qp->sq.wqe_shift));
+
+	qp->max_inline_data = mthca_max_inline_data(pd, max_data_size);
 
 	qp->sq.max_gs = min_t(int, dev->limits.max_sg,
 			      max_data_size / sizeof (struct mthca_data_seg));
@@ -1191,13 +1199,23 @@ static int mthca_alloc_qp_common(struct 
 }
 
 static int mthca_set_qp_size(struct mthca_dev *dev, struct ib_qp_cap *cap,
-			     struct mthca_qp *qp)
+			     struct mthca_pd *pd, struct mthca_qp *qp)
 {
+	int max_data_size = mthca_max_data_size(dev, qp, dev->limits.max_desc_sz);
+
 	/* Sanity check QP size before proceeding */
-	if (cap->max_send_wr  > dev->limits.max_wqes ||
-	    cap->max_recv_wr  > dev->limits.max_wqes ||
-	    cap->max_send_sge > dev->limits.max_sg   ||
-	    cap->max_recv_sge > dev->limits.max_sg)
+	if (cap->max_send_wr  	 > dev->limits.max_wqes ||
+	    cap->max_recv_wr  	 > dev->limits.max_wqes ||
+	    cap->max_send_sge 	 > dev->limits.max_sg   ||
+	    cap->max_recv_sge 	 > dev->limits.max_sg   ||
+	    cap->max_inline_data > mthca_max_inline_data(pd, max_data_size))
+		return -EINVAL;
+
+	/*
+	 * For MLX transport we need 2 extra S/G entries:
+	 * one for the header and one for the checksum at the end
+	 */
+	if (qp->transport == MLX && cap->max_recv_sge + 2 > dev->limits.max_sg)
 		return -EINVAL;
 
 	if (mthca_is_memfree(dev)) {
@@ -1216,14 +1234,6 @@ static int mthca_set_qp_size(struct mthc
 				    MTHCA_INLINE_CHUNK_SIZE) /
 			      sizeof (struct mthca_data_seg));
 
-	/*
-	 * For MLX transport we need 2 extra S/G entries:
-	 * one for the header and one for the checksum at the end
-	 */
-	if ((qp->transport == MLX && qp->sq.max_gs + 2 > dev->limits.max_sg) ||
-	    qp->sq.max_gs > dev->limits.max_sg || qp->rq.max_gs > dev->limits.max_sg)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -1238,7 +1248,7 @@ int mthca_alloc_qp(struct mthca_dev *dev
 {
 	int err;
 
-	err = mthca_set_qp_size(dev, cap, qp);
+	err = mthca_set_qp_size(dev, cap, pd, qp);
 	if (err)
 		return err;
 
@@ -1281,7 +1291,7 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	u32 mqpn = qpn * 2 + dev->qp_table.sqp_start + port - 1;
 	int err;
 
-	err = mthca_set_qp_size(dev, cap, &sqp->qp);
+	err = mthca_set_qp_size(dev, cap, pd, &sqp->qp);
 	if (err)
 		return err;
 
-- 
0.99.9n
