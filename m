Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVDAUvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVDAUvg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVDAUvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:51:35 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262891AbVDAUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:00 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][2/27] IB/mthca: fill in more device query fields
In-Reply-To: <2005411249.NCfupdZrkMmfcKnV@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.WCbW5NdE7NBIkIcr@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0263 (UTC) FILETIME=[5A2F3970:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement more of the device_query method in mthca.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-03-31 19:07:00.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:20.843436141 -0800
@@ -987,6 +987,8 @@
 	if (dev->hca_type == ARBEL_NATIVE) {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_RSZ_SRQ_OFFSET);
 		dev_lim->hca.arbel.resize_srq = field & 1;
+		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
+		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
 		dev_lim->mtt_seg_sz = size;
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-31 19:07:00.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:20.839437009 -0800
@@ -52,6 +52,8 @@
 	if (!in_mad || !out_mad)
 		goto out;
 
+	memset(props, 0, sizeof props);
+
 	props->fw_ver              = mdev->fw_ver;
 
 	memset(in_mad, 0, sizeof *in_mad);
@@ -71,14 +73,26 @@
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

