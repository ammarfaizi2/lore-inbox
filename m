Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVCDAEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVCDAEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCDAEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:04:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262726AbVCCXWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:02 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][3/26] IB/mthca: improve CQ locking part 1
In-Reply-To: <2005331520.GI2ijwUAkM9zyNyy@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:26 -0800
Message-Id: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0113 (UTC) FILETIME=[95652D90:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Avoid taking the CQ table lock in the fast path path by using
synchronize_irq() after removing a CQ from the table to make sure that
no completion events are still in progress.  This gets a nice speedup
(about 4%) in IP over IB on my hardware.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:51.832670421 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:52.368554099 -0800
@@ -33,6 +33,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/hardirq.h>
 
 #include <ib_pack.h>
 
@@ -181,11 +182,7 @@
 {
 	struct mthca_cq *cq;
 
-	spin_lock(&dev->cq_table.lock);
 	cq = mthca_array_get(&dev->cq_table.cq, cqn & (dev->limits.num_cqs - 1));
-	if (cq)
-		atomic_inc(&cq->refcount);
-	spin_unlock(&dev->cq_table.lock);
 
 	if (!cq) {
 		mthca_warn(dev, "Completion event for bogus CQ %08x\n", cqn);
@@ -193,9 +190,6 @@
 	}
 
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-
-	if (atomic_dec_and_test(&cq->refcount))
-		wake_up(&cq->wait);
 }
 
 void mthca_cq_clean(struct mthca_dev *dev, u32 cqn, u32 qpn)
@@ -783,6 +777,11 @@
 			  cq->cqn & (dev->limits.num_cqs - 1));
 	spin_unlock_irq(&dev->cq_table.lock);
 
+	if (dev->mthca_flags & MTHCA_FLAG_MSI_X)
+		synchronize_irq(dev->eq_table.eq[MTHCA_EQ_COMP].msi_x_vector);
+	else
+		synchronize_irq(dev->pdev->irq);
+
 	atomic_dec(&cq->refcount);
 	wait_event(cq->wait, !atomic_read(&cq->refcount));
 

