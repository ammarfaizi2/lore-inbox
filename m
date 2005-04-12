Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVDLKrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVDLKrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVDLKqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:46:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:53194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262282AbVDLKdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:44 -0400
Message-Id: <200504121033.j3CAXDWW005823@shell0.pdx.osdl.net>
Subject: [patch 164/198] IB/mthca: fill in more device query fields
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Implement more of the device_query method in mthca.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c      |    2 +
 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c |   22 +++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-fill-in-more-device-query-fields drivers/infiniband/hw/mthca/mthca_cmd.c
--- 25/drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-fill-in-more-device-query-fields	2005-04-12 03:21:42.632655752 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-12 03:21:42.638654840 -0700
@@ -987,6 +987,8 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	if (dev->hca_type == ARBEL_NATIVE) {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_RSZ_SRQ_OFFSET);
 		dev_lim->hca.arbel.resize_srq = field & 1;
+		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
+		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
 		dev_lim->mtt_seg_sz = size;
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
diff -puN drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-fill-in-more-device-query-fields drivers/infiniband/hw/mthca/mthca_provider.c
--- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-fill-in-more-device-query-fields	2005-04-12 03:21:42.634655448 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-12 03:21:42.639654688 -0700
@@ -52,6 +52,8 @@ static int mthca_query_device(struct ib_
 	if (!in_mad || !out_mad)
 		goto out;
 
+	memset(props, 0, sizeof props);
+
 	props->fw_ver              = mdev->fw_ver;
 
 	memset(in_mad, 0, sizeof *in_mad);
@@ -71,14 +73,26 @@ static int mthca_query_device(struct ib_
 		goto out;
 	}
 
-	props->device_cap_flags = mdev->device_cap_flags;
-	props->vendor_id        = be32_to_cpup((u32 *) (out_mad->data + 36)) &
+	props->device_cap_flags    = mdev->device_cap_flags;
+	props->vendor_id           = be32_to_cpup((u32 *) (out_mad->data + 36)) &
 		0xffffff;
-	props->vendor_part_id   = be16_to_cpup((u16 *) (out_mad->data + 30));
-	props->hw_ver           = be16_to_cpup((u16 *) (out_mad->data + 32));
+	props->vendor_part_id      = be16_to_cpup((u16 *) (out_mad->data + 30));
+	props->hw_ver              = be16_to_cpup((u16 *) (out_mad->data + 32));
 	memcpy(&props->sys_image_guid, out_mad->data +  4, 8);
 	memcpy(&props->node_guid,      out_mad->data + 12, 8);
 
+	props->max_mr_size         = ~0ull;
+	props->max_qp              = mdev->limits.num_qps - mdev->limits.reserved_qps;
+	props->max_qp_wr           = 0xffff;
+	props->max_sge             = mdev->limits.max_sg;
+	props->max_cq              = mdev->limits.num_cqs - mdev->limits.reserved_cqs;
+	props->max_cqe             = 0xffff;
+	props->max_mr              = mdev->limits.num_mpts - mdev->limits.reserved_mrws;
+	props->max_pd              = mdev->limits.num_pds - mdev->limits.reserved_pds;
+	props->max_qp_rd_atom      = 1 << mdev->qp_table.rdb_shift;
+	props->max_qp_init_rd_atom = 1 << mdev->qp_table.rdb_shift;
+	props->local_ca_ack_delay  = mdev->limits.local_ca_ack_delay;
+
 	err = 0;
  out:
 	kfree(in_mad);
_
