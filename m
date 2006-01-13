Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161592AbWAMAN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161592AbWAMAN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161588AbWAMAN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:27 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14129 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161592AbWAMAN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:26 -0500
Subject: [git patch review 6/6] IB/mthca: Initialize grh_present before using
	it
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 13 Jan 2006 00:13:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137111197380-ba6aed04e3bd8864@cisco.com>
In-Reply-To: <1137111197380-d647455e061ba3b8@cisco.com>
X-OriginalArrivalTime: 13 Jan 2006 00:13:22.0795 (UTC) FILETIME=[2A5F0BB0:01C617D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

build_mlx_header() was using sqp->ud_header.grh_present before it was
initialized by mthca_read_ah().  Furthermore, header->grh_present is
set by ib_ud_header_init, so there's no need to set it again in
mthca_read_ah().

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_av.c  |   10 ++++++----
 drivers/infiniband/hw/mthca/mthca_dev.h |    1 +
 drivers/infiniband/hw/mthca/mthca_qp.c  |    2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

9eacee2ac624bfa9740d49355dbe6ee88d0cba0a
diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
index 22fdc44..a14eed0 100644
--- a/drivers/infiniband/hw/mthca/mthca_av.c
+++ b/drivers/infiniband/hw/mthca/mthca_av.c
@@ -163,6 +163,11 @@ int mthca_destroy_ah(struct mthca_dev *d
 	return 0;
 }
 
+int mthca_ah_grh_present(struct mthca_ah *ah)
+{
+	return !!(ah->av->g_slid & 0x80);
+}
+
 int mthca_read_ah(struct mthca_dev *dev, struct mthca_ah *ah,
 		  struct ib_ud_header *header)
 {
@@ -172,8 +177,7 @@ int mthca_read_ah(struct mthca_dev *dev,
 	header->lrh.service_level   = be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 28;
 	header->lrh.destination_lid = ah->av->dlid;
 	header->lrh.source_lid      = cpu_to_be16(ah->av->g_slid & 0x7f);
-	if (ah->av->g_slid & 0x80) {
-		header->grh_present = 1;
+	if (mthca_ah_grh_present(ah)) {
 		header->grh.traffic_class =
 			(be32_to_cpu(ah->av->sl_tclass_flowlabel) >> 20) & 0xff;
 		header->grh.flow_label    =
@@ -184,8 +188,6 @@ int mthca_read_ah(struct mthca_dev *dev,
 				  &header->grh.source_gid);
 		memcpy(header->grh.destination_gid.raw,
 		       ah->av->dgid, 16);
-	} else {
-		header->grh_present = 0;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 795b379..a104ab0 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -520,6 +520,7 @@ int mthca_create_ah(struct mthca_dev *de
 int mthca_destroy_ah(struct mthca_dev *dev, struct mthca_ah *ah);
 int mthca_read_ah(struct mthca_dev *dev, struct mthca_ah *ah,
 		  struct ib_ud_header *header);
+int mthca_ah_grh_present(struct mthca_ah *ah);
 
 int mthca_multicast_attach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
 int mthca_multicast_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 564b6d5..fba608e 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1434,7 +1434,7 @@ static int build_mlx_header(struct mthca
 	u16 pkey;
 
 	ib_ud_header_init(256, /* assume a MAD */
-			  sqp->ud_header.grh_present,
+			  mthca_ah_grh_present(to_mah(wr->wr.ud.ah)),
 			  &sqp->ud_header);
 
 	err = mthca_read_ah(dev, to_mah(wr->wr.ud.ah), &sqp->ud_header);
-- 
1.0.7
