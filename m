Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVDAVA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVDAVA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVDAU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:57:31 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262904AbVDAUvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:16 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][15/27] IB/mthca: fill in opcode field for send completions
In-Reply-To: <2005411249.E7CWkenJFFkWDs2q@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.qipkNNwvZYuE2KBu@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0310 (UTC) FILETIME=[5ACEFBE0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Fill in missing fields in send completions.

Signed-off-by: Itamar Rabenstein <itamar@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-01 12:38:24.207705852 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-04-01 12:38:26.177278312 -0800
@@ -473,7 +473,41 @@
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
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:25.561412000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_dev.h	2005-04-01 12:38:26.173279180 -0800
@@ -88,6 +88,19 @@
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
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:25.023528759 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:26.181277444 -0800
@@ -171,19 +171,6 @@
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

