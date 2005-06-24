Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVFXEIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVFXEIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbVFXEFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:05:47 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263091AbVFXEEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:22 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 04/14] IB/mthca: Use dma_alloc_coherent instead of pci_alloc_consistent
In-Reply-To: <2005623214.Zy3c64TeILEv3G5E@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.8EmcOxrdtkDFLmDq@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0698 (UTC) FILETIME=[CC77FBA0:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch all allocations of coherent memory from pci_alloc_consistent()
to dma_alloc_coherent(), so that we can pass GFP_KERNEL.  This should
help when the system is low on memory.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_cq.c |   25 +++++++++++++------------
 linux.git/drivers/infiniband/hw/mthca/mthca_eq.c |   12 ++++++------
 linux.git/drivers/infiniband/hw/mthca/mthca_qp.c |   19 ++++++++++---------
 3 files changed, 29 insertions(+), 27 deletions(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:04.326180727 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:04.752088550 -0700
@@ -636,19 +636,19 @@ static void mthca_free_cq_buf(struct mth
 	int size;
 
 	if (cq->is_direct)
-		pci_free_consistent(dev->pdev,
-				    (cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE,
-				    cq->queue.direct.buf,
-				    pci_unmap_addr(&cq->queue.direct,
-						   mapping));
+		dma_free_coherent(&dev->pdev->dev,
+				  (cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE,
+				  cq->queue.direct.buf,
+				  pci_unmap_addr(&cq->queue.direct,
+						 mapping));
 	else {
 		size = (cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE;
 		for (i = 0; i < (size + PAGE_SIZE - 1) / PAGE_SIZE; ++i)
 			if (cq->queue.page_list[i].buf)
-				pci_free_consistent(dev->pdev, PAGE_SIZE,
-						    cq->queue.page_list[i].buf,
-						    pci_unmap_addr(&cq->queue.page_list[i],
-								   mapping));
+				dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
+						  cq->queue.page_list[i].buf,
+						  pci_unmap_addr(&cq->queue.page_list[i],
+								 mapping));
 
 		kfree(cq->queue.page_list);
 	}
@@ -668,8 +668,8 @@ static int mthca_alloc_cq_buf(struct mth
 		npages        = 1;
 		shift         = get_order(size) + PAGE_SHIFT;
 
-		cq->queue.direct.buf = pci_alloc_consistent(dev->pdev,
-							    size, &t);
+		cq->queue.direct.buf = dma_alloc_coherent(&dev->pdev->dev,
+							  size, &t, GFP_KERNEL);
 		if (!cq->queue.direct.buf)
 			return -ENOMEM;
 
@@ -707,7 +707,8 @@ static int mthca_alloc_cq_buf(struct mth
 
 		for (i = 0; i < npages; ++i) {
 			cq->queue.page_list[i].buf =
-				pci_alloc_consistent(dev->pdev, PAGE_SIZE, &t);
+				dma_alloc_coherent(&dev->pdev->dev, PAGE_SIZE,
+						   &t, GFP_KERNEL);
 			if (!cq->queue.page_list[i].buf)
 				goto err_free;
 
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_eq.c	2005-06-23 13:03:03.703315530 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_eq.c	2005-06-23 13:03:04.752088550 -0700
@@ -501,8 +501,8 @@ static int __devinit mthca_create_eq(str
 	eq_context = MAILBOX_ALIGN(mailbox);
 
 	for (i = 0; i < npages; ++i) {
-		eq->page_list[i].buf = pci_alloc_consistent(dev->pdev,
-							    PAGE_SIZE, &t);
+		eq->page_list[i].buf = dma_alloc_coherent(&dev->pdev->dev,
+							  PAGE_SIZE, &t, GFP_KERNEL);
 		if (!eq->page_list[i].buf)
 			goto err_out_free;
 
@@ -582,10 +582,10 @@ static int __devinit mthca_create_eq(str
  err_out_free:
 	for (i = 0; i < npages; ++i)
 		if (eq->page_list[i].buf)
-			pci_free_consistent(dev->pdev, PAGE_SIZE,
-					    eq->page_list[i].buf,
-					    pci_unmap_addr(&eq->page_list[i],
-							   mapping));
+			dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
+					  eq->page_list[i].buf,
+					  pci_unmap_addr(&eq->page_list[i],
+							 mapping));
 
 	kfree(eq->page_list);
 	kfree(dma_list);
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:02.079666927 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_qp.c	2005-06-23 13:03:04.751088766 -0700
@@ -934,7 +934,8 @@ static int mthca_alloc_wqe_buf(struct mt
 			mthca_dbg(dev, "Creating direct QP of size %d (shift %d)\n",
 				  size, shift);
 
-		qp->queue.direct.buf = pci_alloc_consistent(dev->pdev, size, &t);
+		qp->queue.direct.buf = dma_alloc_coherent(&dev->pdev->dev, size,
+							  &t, GFP_KERNEL);
 		if (!qp->queue.direct.buf)
 			goto err_out;
 
@@ -973,7 +974,8 @@ static int mthca_alloc_wqe_buf(struct mt
 
 		for (i = 0; i < npages; ++i) {
 			qp->queue.page_list[i].buf =
-				pci_alloc_consistent(dev->pdev, PAGE_SIZE, &t);
+				dma_alloc_coherent(&dev->pdev->dev, PAGE_SIZE,
+						   &t, GFP_KERNEL);
 			if (!qp->queue.page_list[i].buf)
 				goto err_out_free;
 
@@ -996,16 +998,15 @@ static int mthca_alloc_wqe_buf(struct mt
 
  err_out_free:
 	if (qp->is_direct) {
-		pci_free_consistent(dev->pdev, size,
-				    qp->queue.direct.buf,
-				    pci_unmap_addr(&qp->queue.direct, mapping));
+		dma_free_coherent(&dev->pdev->dev, size, qp->queue.direct.buf,
+				  pci_unmap_addr(&qp->queue.direct, mapping));
 	} else
 		for (i = 0; i < npages; ++i) {
 			if (qp->queue.page_list[i].buf)
-				pci_free_consistent(dev->pdev, PAGE_SIZE,
-						    qp->queue.page_list[i].buf,
-						    pci_unmap_addr(&qp->queue.page_list[i],
-								   mapping));
+				dma_free_coherent(&dev->pdev->dev, PAGE_SIZE,
+						  qp->queue.page_list[i].buf,
+						  pci_unmap_addr(&qp->queue.page_list[i],
+								 mapping));
 
 		}
 

