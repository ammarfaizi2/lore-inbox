Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVDAU5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVDAU5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVDAUzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:55:53 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262903AbVDAUvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:14 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][13/27] IB/mthca: implement RDMA/atomic operations for mem-free mode
In-Reply-To: <2005411249.mBxBGEwdeob5Gy84@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.0FJpqa4lTtcUTWSU@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0169 (UTC) FILETIME=[5AB97810:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to support RDMA and atomic send work requests in mem-free mode.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:21.580276194 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_qp.c	2005-04-01 12:38:25.023528759 -0800
@@ -1775,6 +1775,53 @@
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

