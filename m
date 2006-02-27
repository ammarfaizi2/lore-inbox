Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWB0Wjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWB0Wjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWB0Wjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:39:31 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50817 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932384AbWB0Wbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:52 -0500
Message-Id: <20060227223408.822215000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:39 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Roland Dreier <rdreier@cisco.com>,
       Jack Morgenstein <jackm@mellanox.co.il>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>
Subject: [patch 39/39] [PATCH] IB/mthca: max_inline_data handling tweaks
Content-Disposition: inline; filename=ib-mthca-max_inline_data-handling-tweaks.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix a case where copying max_inline_data from a successful create_qp
capabilities output to create_qp input could cause EINVAL error:

mthca_set_qp_size must check max_inline_data directly against
max_desc_sz; checking qp->sq.max_gs is wrong since max_inline_data
depends on the qp type and does not involve max_sg.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: "Michael S. Tsirkin" <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
fixes http://article.gmane.org/gmane.linux.drivers.openib/21118

 drivers/infiniband/hw/mthca/mthca_qp.c |   62 +++++++++++++++++++--------------
 1 files changed, 36 insertions(+), 26 deletions(-)

--- linux-2.6.15.4.orig/drivers/infiniband/hw/mthca/mthca_qp.c
+++ linux-2.6.15.4/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -885,18 +885,13 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
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
@@ -915,11 +910,24 @@ static void mthca_adjust_qp_caps(struct 
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
@@ -1186,13 +1194,23 @@ static int mthca_alloc_qp_common(struct 
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
@@ -1211,14 +1229,6 @@ static int mthca_set_qp_size(struct mthc
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
 
@@ -1233,7 +1243,7 @@ int mthca_alloc_qp(struct mthca_dev *dev
 {
 	int err;
 
-	err = mthca_set_qp_size(dev, cap, qp);
+	err = mthca_set_qp_size(dev, cap, pd, qp);
 	if (err)
 		return err;
 
@@ -1276,7 +1286,7 @@ int mthca_alloc_sqp(struct mthca_dev *de
 	u32 mqpn = qpn * 2 + dev->qp_table.sqp_start + port - 1;
 	int err;
 
-	err = mthca_set_qp_size(dev, cap, &sqp->qp);
+	err = mthca_set_qp_size(dev, cap, pd, &sqp->qp);
 	if (err)
 		return err;
 

--
