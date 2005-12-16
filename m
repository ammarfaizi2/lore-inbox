Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLPEAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLPEAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLPEAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:43 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14458 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932118AbVLPEA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:27 -0500
X-IronPort-AV: i="3.99,259,1131350400"; 
   d="scan'208"; a="685293793:sNHT33268508"
Subject: [git patch review 1/7] IB/mthca: check RDMA limits
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617067-b51dec64cec55f52@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:17.0141 (UTC) FILETIME=[39966250:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add limit checking on rd_atomic and dest_rd_atomic attributes:
especially for max_dest_rd_atomic, a value that is larger than HCA
capability can cause RDB overflow and corruption of another QP.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

94361cf74a6fca1973d2fed5338d5fb4bcd902fa
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 7450550..c5c3d0e 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -591,6 +591,20 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		return -EINVAL;
 	}
 
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
+	    attr->max_rd_atomic > dev->limits.max_qp_init_rdma) {
+		mthca_dbg(dev, "Max rdma_atomic as initiator %u too large (max is %d)\n",
+			  attr->max_rd_atomic, dev->limits.max_qp_init_rdma);
+		return -EINVAL;
+	}
+
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
+	    attr->max_dest_rd_atomic > 1 << dev->qp_table.rdb_shift) {
+		mthca_dbg(dev, "Max rdma_atomic as responder %u too large (max %d)\n",
+			  attr->max_dest_rd_atomic, 1 << dev->qp_table.rdb_shift);
+		return -EINVAL;
+	}
+
 	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
-- 
0.99.9n
