Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVLIVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVLIVwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVLIVwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:52:30 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:56955 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964883AbVLIVwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:52:13 -0500
X-IronPort-AV: i="3.99,235,1131350400"; 
   d="scan'208"; a="376315012:sNHT40754008724"
Subject: [git patch review 1/5] IB/mthca: fix QP size limits for mem-free HCAs
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 09 Dec 2005 21:51:50 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134165110300-0a7b2146d584150e@cisco.com>
X-OriginalArrivalTime: 09 Dec 2005 21:51:50.0316 (UTC) FILETIME=[C26A16C0:01C5FD0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike tavor, the max work queue size is an exact power of 2 for arbel
mode, despite what the documentation (of the QUERY_DEV_LIM firmware
command) says.  Without this patch, on Arbel, we can start with a QP
of a valid size and get above the reported limit after rounding to the
next power of two.

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cmd.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

a3c8ab4fe8f006d742c24be677518bfa9862e732
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 9ed3458..22ac72b 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -937,10 +937,6 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	if (err)
 		goto out;
 
-	MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SRQ_SZ_OFFSET);
-	dev_lim->max_srq_sz = (1 << field) - 1;
-	MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_QP_SZ_OFFSET);
-	dev_lim->max_qp_sz = (1 << field) - 1;
 	MTHCA_GET(field, outbox, QUERY_DEV_LIM_RSVD_QP_OFFSET);
 	dev_lim->reserved_qps = 1 << (field & 0xf);
 	MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_QP_OFFSET);
@@ -1056,6 +1052,10 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	mthca_dbg(dev, "Flags: %08x\n", dev_lim->flags);
 
 	if (mthca_is_memfree(dev)) {
+		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SRQ_SZ_OFFSET);
+		dev_lim->max_srq_sz = 1 << field;
+		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_QP_SZ_OFFSET);
+		dev_lim->max_qp_sz = 1 << field;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_RSZ_SRQ_OFFSET);
 		dev_lim->hca.arbel.resize_srq = field & 1;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
@@ -1087,6 +1087,10 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 		mthca_dbg(dev, "Max ICM size %lld MB\n",
 			  (unsigned long long) dev_lim->hca.arbel.max_icm_sz >> 20);
 	} else {
+		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SRQ_SZ_OFFSET);
+		dev_lim->max_srq_sz = (1 << field) - 1;
+		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_QP_SZ_OFFSET);
+		dev_lim->max_qp_sz = (1 << field) - 1;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_AV_OFFSET);
 		dev_lim->hca.tavor.max_avs = 1 << (field & 0x3f);
 		dev_lim->mpt_entry_sz = MTHCA_MPT_ENTRY_SIZE;
-- 
0.99.9l
