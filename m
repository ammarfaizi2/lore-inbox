Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVDLKig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVDLKig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVDLKiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:38:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:44746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262279AbVDLKdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:31 -0400
Message-Id: <200504121033.j3CAXMiH005863@shell0.pdx.osdl.net>
Subject: [patch 175/198] IB/mthca: implement RDMA/atomic operations for mem-free mode
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Add code to support RDMA and atomic send work requests in mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c |   47 +++++++++++++++++++++++++
 1 files changed, 47 insertions(+)

diff -puN drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-implement-rdma-atomic-operations-for-mem-free-mode drivers/infiniband/hw/mthca/mthca_qp.c
--- 25/drivers/infiniband/hw/mthca/mthca_qp.c~ib-mthca-implement-rdma-atomic-operations-for-mem-free-mode	2005-04-12 03:21:45.105279856 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-12 03:21:45.109279248 -0700
@@ -1775,6 +1775,53 @@ int mthca_arbel_post_send(struct ib_qp *
 		size = sizeof (struct mthca_next_seg) / 16;
 
 		switch (qp->transport) {
+		case RC:
+			switch (wr->opcode) {
+			case IB_WR_ATOMIC_CMP_AND_SWP:
+			case IB_WR_ATOMIC_FETCH_AND_ADD:
+				((struct mthca_raddr_seg *) wqe)->raddr =
+					cpu_to_be64(wr->wr.atomic.remote_addr);
+				((struct mthca_raddr_seg *) wqe)->rkey =
+					cpu_to_be32(wr->wr.atomic.rkey);
+				((struct mthca_raddr_seg *) wqe)->reserved = 0;
+
+				wqe += sizeof (struct mthca_raddr_seg);
+
+				if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
+					((struct mthca_atomic_seg *) wqe)->swap_add =
+						cpu_to_be64(wr->wr.atomic.swap);
+					((struct mthca_atomic_seg *) wqe)->compare =
+						cpu_to_be64(wr->wr.atomic.compare_add);
+				} else {
+					((struct mthca_atomic_seg *) wqe)->swap_add =
+						cpu_to_be64(wr->wr.atomic.compare_add);
+					((struct mthca_atomic_seg *) wqe)->compare = 0;
+				}
+
+				wqe += sizeof (struct mthca_atomic_seg);
+				size += sizeof (struct mthca_raddr_seg) / 16 +
+					sizeof (struct mthca_atomic_seg);
+				break;
+
+			case IB_WR_RDMA_WRITE:
+			case IB_WR_RDMA_WRITE_WITH_IMM:
+			case IB_WR_RDMA_READ:
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
 			memcpy(((struct mthca_arbel_ud_seg *) wqe)->av,
 			       to_mah(wr->wr.ud.ah)->av, MTHCA_AV_SIZE);
_
