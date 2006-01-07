Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965384AbWAGA1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbWAGA1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbWAGAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:52 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:17335 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965375AbWAGAZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:48 -0500
Subject: [git patch review 6/8] IB/mthca: Add support for automatic path
	migration (APM)
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593543000-c8b76b848fc384d6@cisco.com>
In-Reply-To: <1136593543000-0e0e6d306b8be206@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:45.0948 (UTC) FILETIME=[E6D8B1C0:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to modify QP operation to handle setting alternate paths for
connected QPs.

Signed-off-by: Dotan Barak <dotanb@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |   57 +++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 20 deletions(-)

4de144bf721e46e7ccc8fed45b20a640cc364904
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index ff2def3..564b6d5 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -549,6 +549,25 @@ static __be32 get_hw_access_flags(struct
 	return cpu_to_be32(hw_access_flags);
 }
 
+static void mthca_path_set(struct ib_ah_attr *ah, struct mthca_qp_path *path)
+{
+	path->g_mylmc     = ah->src_path_bits & 0x7f;
+	path->rlid        = cpu_to_be16(ah->dlid);
+	path->static_rate = !!ah->static_rate;
+
+	if (ah->ah_flags & IB_AH_GRH) {
+		path->g_mylmc   |= 1 << 7;
+		path->mgid_index = ah->grh.sgid_index;
+		path->hop_limit  = ah->grh.hop_limit;
+		path->sl_tclass_flowlabel = 
+			cpu_to_be32((ah->sl << 28)                |
+				    (ah->grh.traffic_class << 20) | 
+				    (ah->grh.flow_label));
+		memcpy(path->rgid, ah->grh.dgid.raw, 16);
+	} else
+		path->sl_tclass_flowlabel = cpu_to_be32(ah->sl << 28);
+}
+
 int mthca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask)
 {
 	struct mthca_dev *dev = to_mdev(ibqp->device);
@@ -712,28 +731,14 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 	}
 
 	if (attr_mask & IB_QP_RNR_RETRY) {
-		qp_context->pri_path.rnr_retry = attr->rnr_retry << 5;
-		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RNR_RETRY);
+		qp_context->alt_path.rnr_retry = qp_context->pri_path.rnr_retry =
+			attr->rnr_retry << 5;
+		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_RNR_RETRY | 
+							MTHCA_QP_OPTPAR_ALT_RNR_RETRY);
 	}
 
 	if (attr_mask & IB_QP_AV) {
-		qp_context->pri_path.g_mylmc     = attr->ah_attr.src_path_bits & 0x7f;
-		qp_context->pri_path.rlid        = cpu_to_be16(attr->ah_attr.dlid);
-		qp_context->pri_path.static_rate = !!attr->ah_attr.static_rate;
-		if (attr->ah_attr.ah_flags & IB_AH_GRH) {
-			qp_context->pri_path.g_mylmc |= 1 << 7;
-			qp_context->pri_path.mgid_index = attr->ah_attr.grh.sgid_index;
-			qp_context->pri_path.hop_limit = attr->ah_attr.grh.hop_limit;
-			qp_context->pri_path.sl_tclass_flowlabel =
-				cpu_to_be32((attr->ah_attr.sl << 28)                |
-					    (attr->ah_attr.grh.traffic_class << 20) |
-					    (attr->ah_attr.grh.flow_label));
-			memcpy(qp_context->pri_path.rgid,
-			       attr->ah_attr.grh.dgid.raw, 16);
-		} else {
-			qp_context->pri_path.sl_tclass_flowlabel =
-				cpu_to_be32(attr->ah_attr.sl << 28);
-		}
+		mthca_path_set(&attr->ah_attr, &qp_context->pri_path);
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_PRIMARY_ADDR_PATH);
 	}
 
@@ -742,7 +747,19 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
 		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_ACK_TIMEOUT);
 	}
 
-	/* XXX alt_path */
+	if (attr_mask & IB_QP_ALT_PATH) {
+		if (attr->alt_port_num == 0 || attr->alt_port_num > dev->limits.num_ports) {
+			mthca_dbg(dev, "Alternate port number (%u) is invalid\n", 
+				attr->alt_port_num);
+			return -EINVAL;
+		}
+
+		mthca_path_set(&attr->alt_ah_attr, &qp_context->alt_path);
+		qp_context->alt_path.port_pkey |= cpu_to_be32(attr->alt_pkey_index | 
+							      attr->alt_port_num << 24);
+		qp_context->alt_path.ackto = attr->alt_timeout << 3;
+		qp_param->opt_param_mask |= cpu_to_be32(MTHCA_QP_OPTPAR_ALT_ADDR_PATH);
+	}
 
 	/* leave rdd as 0 */
 	qp_context->pd         = cpu_to_be32(to_mpd(ibqp->pd)->pd_num);
-- 
0.99.9n
