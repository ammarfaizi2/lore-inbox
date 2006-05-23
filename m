Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWEWSeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWEWSeD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWEWSdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:42 -0400
Received: from mx.pathscale.com ([64.160.42.68]:8631 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751218AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 9 of 10] ipath - fix null deref during rdma ops
X-Mercurial-Node: 3d844dee2f612417bdb85b12c1a5a68e74f17393
Message-Id: <3d844dee2f612417bdb8.1148409157@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:37 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem was that node A's sending thread, which handles sending RDMA
read response data, would write the trigger word, the last packet would
be sent, node B would send a new RDMA read request, node A's interrupt
handler would initialize s_rdma_sge, then node A's sending thread would
update s_rdma_sge.  This didn't happen very often naturally but was more
frequent with 1 byte RDMA reads.  Rather than adding more locking or
increasing the QP structure size and copying sge data, I modified the
copy routine to update the pointers before writing the trigger word to
avoid the update race.

Signed-off-by: Ralph Campbell <ralphc@pathscale.com>
Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 551717ecc3db -r 3d844dee2f61 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Tue May 23 11:29:16 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Tue May 23 11:29:16 2006 -0700
@@ -872,12 +872,13 @@ static void copy_io(u32 __iomem *piobuf,
 		update_sge(ss, len);
 		length -= len;
 	}
+	/* Update address before sending packet. */
+	update_sge(ss, length);
 	/* must flush early everything before trigger word */
 	ipath_flush_wc();
 	__raw_writel(last, piobuf);
 	/* be sure trigger word is written */
 	ipath_flush_wc();
-	update_sge(ss, length);
 }
 
 /**
@@ -943,17 +944,18 @@ int ipath_verbs_send(struct ipath_devdat
 	if (likely(ss->num_sge == 1 && len <= ss->sge.length &&
 		   !((unsigned long)ss->sge.vaddr & (sizeof(u32) - 1)))) {
 		u32 w;
-
+		u32 *addr = (u32 *) ss->sge.vaddr;
+
+		/* Update address before sending packet. */
+		update_sge(ss, len);
 		/* Need to round up for the last dword in the packet. */
 		w = (len + 3) >> 2;
-		__iowrite32_copy(piobuf, ss->sge.vaddr, w - 1);
+		__iowrite32_copy(piobuf, addr, w - 1);
 		/* must flush early everything before trigger word */
 		ipath_flush_wc();
-		__raw_writel(((u32 *) ss->sge.vaddr)[w - 1],
-			     piobuf + w - 1);
+		__raw_writel(addr[w - 1], piobuf + w - 1);
 		/* be sure trigger word is written */
 		ipath_flush_wc();
-		update_sge(ss, len);
 		ret = 0;
 		goto bail;
 	}
