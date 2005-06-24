Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVFXEIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVFXEIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbVFXEGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:06:55 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263096AbVFXEEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:23 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 07/14] IB/mthca: Enable unreliable connected transport
In-Reply-To: <2005623214.rtUVEh14lfm8dUC3@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.1YZfsHaBvXkxQMAb@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0870 (UTC) FILETIME=[CC923A60:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for unreliable connected (UC) transport to mthca driver:
 - Add attributes for UC to modify QP table.
 - Add support for posting UC work requests.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_qp.c |   79 ++++++++++++++++++++++++++++++++-
 1 files changed, 78 insertions(+), 1 deletion(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:05.636897055 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:06.027812451 -0700
@@ -357,6 +357,9 @@ static const struct {
 				[UD]  = (IB_QP_PKEY_INDEX |
 					 IB_QP_PORT       |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_PKEY_INDEX |
+					 IB_QP_PORT       |
+					 IB_QP_ACCESS_FLAGS),
 				[RC]  = (IB_QP_PKEY_INDEX |
 					 IB_QP_PORT       |
 					 IB_QP_ACCESS_FLAGS),
@@ -378,6 +381,9 @@ static const struct {
 				[UD]  = (IB_QP_PKEY_INDEX |
 					 IB_QP_PORT       |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_PKEY_INDEX |
+					 IB_QP_PORT       |
+					 IB_QP_ACCESS_FLAGS),
 				[RC]  = (IB_QP_PKEY_INDEX |
 					 IB_QP_PORT       |
 					 IB_QP_ACCESS_FLAGS),
@@ -388,6 +394,11 @@ static const struct {
 		[IB_QPS_RTR]   = {
 			.trans = MTHCA_TRANS_INIT2RTR,
 			.req_param = {
+				[UC]  = (IB_QP_AV                  |
+					 IB_QP_PATH_MTU            |
+					 IB_QP_DEST_QPN            |
+					 IB_QP_RQ_PSN              |
+					 IB_QP_MAX_DEST_RD_ATOMIC),
 				[RC]  = (IB_QP_AV                  |
 					 IB_QP_PATH_MTU            |
 					 IB_QP_DEST_QPN            |
@@ -398,6 +409,9 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_PKEY_INDEX |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_ALT_PATH     |
+					 IB_QP_ACCESS_FLAGS |
+					 IB_QP_PKEY_INDEX),
 				[RC]  = (IB_QP_ALT_PATH     |
 					 IB_QP_ACCESS_FLAGS |
 					 IB_QP_PKEY_INDEX),
@@ -413,6 +427,8 @@ static const struct {
 			.trans = MTHCA_TRANS_RTR2RTS,
 			.req_param = {
 				[UD]  = IB_QP_SQ_PSN,
+				[UC]  = (IB_QP_SQ_PSN            |
+					 IB_QP_MAX_QP_RD_ATOMIC),
 				[RC]  = (IB_QP_TIMEOUT           |
 					 IB_QP_RETRY_CNT         |
 					 IB_QP_RNR_RETRY         |
@@ -423,6 +439,11 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_CUR_STATE             |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_CUR_STATE             |
+					 IB_QP_ALT_PATH              |
+					 IB_QP_ACCESS_FLAGS          |
+					 IB_QP_PKEY_INDEX            |
+					 IB_QP_PATH_MIG_STATE),
 				[RC]  = (IB_QP_CUR_STATE             |
 					 IB_QP_ALT_PATH              |
 					 IB_QP_ACCESS_FLAGS          |
@@ -442,6 +463,9 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_CUR_STATE             |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_ACCESS_FLAGS          |
+					 IB_QP_ALT_PATH              |
+					 IB_QP_PATH_MIG_STATE),
 				[RC]  = (IB_QP_ACCESS_FLAGS          |
 					 IB_QP_ALT_PATH              |
 					 IB_QP_PATH_MIG_STATE        |
@@ -462,6 +486,10 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_CUR_STATE             |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_CUR_STATE             |
+					 IB_QP_ALT_PATH              |
+					 IB_QP_ACCESS_FLAGS          |
+					 IB_QP_PATH_MIG_STATE),
 				[RC]  = (IB_QP_CUR_STATE             |
 					 IB_QP_ALT_PATH              |
 					 IB_QP_ACCESS_FLAGS          |
@@ -476,6 +504,14 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_PKEY_INDEX            |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_AV                    |
+					 IB_QP_MAX_QP_RD_ATOMIC      |
+					 IB_QP_MAX_DEST_RD_ATOMIC    |
+					 IB_QP_CUR_STATE             |
+					 IB_QP_ALT_PATH              |
+					 IB_QP_ACCESS_FLAGS          |
+					 IB_QP_PKEY_INDEX            |
+					 IB_QP_PATH_MIG_STATE),
 				[RC]  = (IB_QP_AV                    |
 					 IB_QP_TIMEOUT               |
 					 IB_QP_RETRY_CNT             |
@@ -501,6 +537,7 @@ static const struct {
 			.opt_param = {
 				[UD]  = (IB_QP_CUR_STATE             |
 					 IB_QP_QKEY),
+				[UC]  = (IB_QP_CUR_STATE),
 				[RC]  = (IB_QP_CUR_STATE             |
 					 IB_QP_MIN_RNR_TIMER),
 				[MLX] = (IB_QP_CUR_STATE             |
@@ -1530,6 +1567,26 @@ int mthca_tavor_post_send(struct ib_qp *
 
 			break;
 
+		case UC:
+			switch (wr->opcode) {
+			case IB_WR_RDMA_WRITE:
+			case IB_WR_RDMA_WRITE_WITH_IMM:
+				((struct mthca_raddr_seg *) wqe)->raddr =
+					cpu_to_be64(wr->wr.rdma.remote_addr);
+				((struct mthca_raddr_seg *) wqe)->rkey =
+					cpu_to_be32(wr->wr.rdma.rkey);
+				((struct mthca_raddr_seg *) wqe)->reserved = 0;
+				wqe += sizeof (struct mthca_raddr_seg);
+				size += sizeof (struct mthca_raddr_seg) / 16;
+				break;
+
+			default:
+				/* No extra segments required for sends */
+				break;
+			}
+
+			break;
+
 		case UD:
 			((struct mthca_tavor_ud_seg *) wqe)->lkey =
 				cpu_to_be32(to_mah(wr->wr.ud.ah)->key);
@@ -1815,9 +1872,29 @@ int mthca_arbel_post_send(struct ib_qp *
 					sizeof (struct mthca_atomic_seg);
 				break;
 
+			case IB_WR_RDMA_READ:
+			case IB_WR_RDMA_WRITE:
+			case IB_WR_RDMA_WRITE_WITH_IMM:
+				((struct mthca_raddr_seg *) wqe)->raddr =
+					cpu_to_be64(wr->wr.rdma.remote_addr);
+				((struct mthca_raddr_seg *) wqe)->rkey =
+					cpu_to_be32(wr->wr.rdma.rkey);
+				((struct mthca_raddr_seg *) wqe)->reserved = 0;
+				wqe += sizeof (struct mthca_raddr_seg);
+				size += sizeof (struct mthca_raddr_seg) / 16;
+				break;
+
+			default:
+				/* No extra segments required for sends */
+				break;
+			}
+
+			break;
+
+		case UC:
+			switch (wr->opcode) {
 			case IB_WR_RDMA_WRITE:
 			case IB_WR_RDMA_WRITE_WITH_IMM:
-			case IB_WR_RDMA_READ:
 				((struct mthca_raddr_seg *) wqe)->raddr =
 					cpu_to_be64(wr->wr.rdma.remote_addr);
 				((struct mthca_raddr_seg *) wqe)->rkey =

