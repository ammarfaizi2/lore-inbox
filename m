Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932880AbWF2V6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbWF2V6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932970AbWF2V6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:58:17 -0400
Received: from mx.pathscale.com ([64.160.42.68]:35471 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932880AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18 of 39] IB/ipath - use vmalloc to allocate struct
	ipath_devdata
X-Mercurial-Node: 9c072f8e7e68131f1c7eeae9ebb224b28bf72c34
Message-Id: <9c072f8e7e68131f1c7e.1151617269@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:09 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a DMA target, so no need to use dma_alloc_coherent on it.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 9d943b828776 -r 9c072f8e7e68 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
@@ -171,14 +171,13 @@ static void ipath_free_devdata(struct pc
 		list_del(&dd->ipath_list);
 		spin_unlock_irqrestore(&ipath_devs_lock, flags);
 	}
-	dma_free_coherent(&pdev->dev, sizeof(*dd), dd, dd->ipath_dma_addr);
+	vfree(dd);
 }
 
 static struct ipath_devdata *ipath_alloc_devdata(struct pci_dev *pdev)
 {
 	unsigned long flags;
 	struct ipath_devdata *dd;
-	dma_addr_t dma_addr;
 	int ret;
 
 	if (!idr_pre_get(&unit_table, GFP_KERNEL)) {
@@ -186,15 +185,12 @@ static struct ipath_devdata *ipath_alloc
 		goto bail;
 	}
 
-	dd = dma_alloc_coherent(&pdev->dev, sizeof(*dd), &dma_addr,
-				GFP_KERNEL);
-
+	dd = vmalloc(sizeof(*dd));
 	if (!dd) {
 		dd = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
-
-	dd->ipath_dma_addr = dma_addr;
+	memset(dd, 0, sizeof(*dd));
 	dd->ipath_unit = -1;
 
 	spin_lock_irqsave(&ipath_devs_lock, flags);
diff -r 9d943b828776 -r 9c072f8e7e68 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
@@ -163,7 +163,6 @@ struct ipath_devdata {
 	 * only written to by the chip, not the driver.
 	 */
 	volatile __le64 *ipath_hdrqtailptr;
-	dma_addr_t ipath_dma_addr;
 	/* ipath_cfgports pointers */
 	struct ipath_portdata **ipath_pd;
 	/* sk_buffs used by port 0 eager receive queue */
