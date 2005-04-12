Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVDLKoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVDLKoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVDLKnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:43:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:58826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262287AbVDLKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:47 -0400
Message-Id: <200504121033.j3CAXOFQ005870@shell0.pdx.osdl.net>
Subject: [patch 177/198] IB/mthca: fill in opcode field for send completions
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       itamar@mellanox.co.il, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Fill in missing fields in send completions.

Signed-off-by: Itamar Rabenstein <itamar@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_cq.c  |   36 +++++++++++++++++++++++-
 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h |   13 ++++++++
 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c  |   13 --------
 3 files changed, 48 insertions(+), 14 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_cq.c~ib-mthca-fill-in-opcode-field-for-send-completions drivers/infiniband/hw/mthca/mthca_cq.c
--- 25/drivers/infiniband/hw/mthca/mthca_cq.c~ib-mthca-fill-in-opcode-field-for-send-completions	2005-04-12 03:21:45.588206440 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-12 03:21:45.595205376 -0700
@@ -473,7 +473,41 @@ static inline int mthca_poll_one(struct 
 	}
 
 	if (is_send) {
-		entry->opcode = IB_WC_SEND; /* XXX */
+		entry->wc_flags = 0;
+		switch (cqe->opcode) {
+		case MTHCA_OPCODE_RDMA_WRITE:
+			entry->opcode    = IB_WC_RDMA_WRITE;
+			break;
+		case MTHCA_OPCODE_RDMA_WRITE_IMM:
+			entry->opcode    = IB_WC_RDMA_WRITE;
+			entry->wc_flags |= IB_WC_WITH_IMM;
+			break;
+		case MTHCA_OPCODE_SEND:
+			entry->opcode    = IB_WC_SEND;
+			break;
+		case MTHCA_OPCODE_SEND_IMM:
+			entry->opcode    = IB_WC_SEND;
+			entry->wc_flags |= IB_WC_WITH_IMM;
+			break;
+		case MTHCA_OPCODE_RDMA_READ:
+			entry->opcode    = IB_WC_RDMA_READ;
+			entry->byte_len  = be32_to_cpu(cqe->byte_cnt);
+			break;
+		case MTHCA_OPCODE_ATOMIC_CS:
+			entry->opcode    = IB_WC_COMP_SWAP;
+			entry->byte_len  = be32_to_cpu(cqe->byte_cnt);
+			break;
+		case MTHCA_OPCODE_ATOMIC_FA:
+			entry->opcode    = IB_WC_FETCH_ADD;
+			entry->byte_len  = be32_to_cpu(cqe->byte_cnt);
+			break;
+		case MTHCA_OPCODE_BIND_MW:
+			entry->opcode    = IB_WC_BIND_MW;
+			break;
+		default:
+			entry->opcode    = MTHCA_OPCODE_INVALID;
+			break;
+		}
 	} else {
 		entry->byte_len = be32_to_cpu(cqe->byte_cnt);
 		switch (cqe->opcode & 0x1f) {
diff -puN drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-fill-in-opcode-field-for-send-completions drivers/infiniband/hw/mthca/mthca_dev.h
--- 25/drivers/infiniband/hw/mthca/mthca_dev.h~ib-mthca-fill-in-opcode-field-for-send-completions	2005-04-12 03:21:45.589206288 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-12 03:21:45.595205376 -0700
@@ -88,6 +88,19 @@ enum {
 	MTHCA_NUM_EQ
 };
 
+enum {
+	MTHCA_OPCODE_NOP            = 0x00,
+	MTHCA_OPCODE_RDMA_WRITE     = 0x08,
+	MTHCA_OPCODE_RDMA_WRITE_IMM = 0x09,
+	MTHCA_OPCODE_SEND           = 0x0a,
+	MTHCA_OPCODE_SEND_IMM       = 0x0b,
+	MTHCA_OPCODE_RDMA_READ      = 0x10,
+	MTHCA_OPCODE_ATOMIC_CS      = 0x11,
+	MTHCA_OPCODE_ATOMIC_FA      = 0x12,
+	MTHCA_OPCODE_BIND_MW        = 0x18,
+	MTHCA_OPCODE_INVALID        = 0xff
+};
+
 struct mthca_cmd {
 	int                       use_events;
 	struct semaphore          hcr_sem;
diff -puN drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-fill-in-opcode-field-for-send-completions drivers/infiniband/hw/mthca/mthca_qp.c
--- 25/drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-fill-in-opcode-field-for-send-completions	2005-04-12 03:21:45.591205984 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-12 03:21:45.597205072 -0700
@@ -171,19 +171,6 @@ enum {
 };
 
 enum {
-	MTHCA_OPCODE_NOP            = 0x00,
-	MTHCA_OPCODE_RDMA_WRITE     = 0x08,
-	MTHCA_OPCODE_RDMA_WRITE_IMM = 0x09,
-	MTHCA_OPCODE_SEND           = 0x0a,
-	MTHCA_OPCODE_SEND_IMM       = 0x0b,
-	MTHCA_OPCODE_RDMA_READ      = 0x10,
-	MTHCA_OPCODE_ATOMIC_CS      = 0x11,
-	MTHCA_OPCODE_ATOMIC_FA      = 0x12,
-	MTHCA_OPCODE_BIND_MW        = 0x18,
-	MTHCA_OPCODE_INVALID        = 0xff
-};
-
-enum {
 	MTHCA_NEXT_DBD       = 1 << 7,
 	MTHCA_NEXT_FENCE     = 1 << 6,
 	MTHCA_NEXT_CQ_UPDATE = 1 << 3,
_
