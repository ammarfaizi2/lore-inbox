Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVCDCkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVCDCkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVCCXrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:47:45 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262739AbVCCXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:24 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][17/26] IB/mthca: refactor CQ buffer allocate/free
In-Reply-To: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.tIEkOrHOmFDGvQZK@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:28.0066 (UTC) FILETIME=[95F69820:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Factor the allocation and freeing of completion queue buffers into
mthca_alloc_cq_buf() and mthca_free_cq_buf().  This makes the code
more readable and will eventually make handling userspace CQs simpler
(the kernel doesn't have to allocate a buffer at all).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:56.153732464 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cq.c	2005-03-03 14:12:59.925913650 -0800
@@ -557,32 +557,40 @@
 		      MTHCA_GET_DOORBELL_LOCK(&dev->doorbell_lock));
 }
 
-int mthca_init_cq(struct mthca_dev *dev, int nent,
-		  struct mthca_cq *cq)
+static void mthca_free_cq_buf(struct mthca_dev *dev, struct mthca_cq *cq)
 {
-	int size = nent * MTHCA_CQ_ENTRY_SIZE;
-	dma_addr_t t;
-	void *mailbox = NULL;
-	int npages, shift;
-	u64 *dma_list = NULL;
-	struct mthca_cq_context *cq_context;
-	int err = -ENOMEM;
-	u8 status;
 	int i;
+	int size;
 
-	might_sleep();
+	if (cq->is_direct)
+		pci_free_consistent(dev->pdev,
+				    (cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE,
+				    cq->queue.direct.buf,
+				    pci_unmap_addr(&cq->queue.direct,
+						   mapping));
+	else {
+		size = (cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE;
+		for (i = 0; i < (size + PAGE_SIZE - 1) / PAGE_SIZE; ++i)
+			if (cq->queue.page_list[i].buf)
+				pci_free_consistent(dev->pdev, PAGE_SIZE,
+						    cq->queue.page_list[i].buf,
+						    pci_unmap_addr(&cq->queue.page_list[i],
+								   mapping));
 
-	mailbox = kmalloc(sizeof (struct mthca_cq_context) + MTHCA_CMD_MAILBOX_EXTRA,
-			  GFP_KERNEL);
-	if (!mailbox)
-		goto err_out;
+		kfree(cq->queue.page_list);
+	}
+}
 
-	cq_context = MAILBOX_ALIGN(mailbox);
+static int mthca_alloc_cq_buf(struct mthca_dev *dev, int size,
+			      struct mthca_cq *cq)
+{
+	int err = -ENOMEM;
+	int npages, shift;
+	u64 *dma_list = NULL;
+	dma_addr_t t;
+	int i;
 
 	if (size <= MTHCA_MAX_DIRECT_CQ_SIZE) {
-		if (0)
-			mthca_dbg(dev, "Creating direct CQ of size %d\n", size);
-
 		cq->is_direct = 1;
 		npages        = 1;
 		shift         = get_order(size) + PAGE_SHIFT;
@@ -590,7 +598,7 @@
 		cq->queue.direct.buf = pci_alloc_consistent(dev->pdev,
 							    size, &t);
 		if (!cq->queue.direct.buf)
-			goto err_out;
+			return -ENOMEM;
 
 		pci_unmap_addr_set(&cq->queue.direct, mapping, t);
 
@@ -603,7 +611,7 @@
 
 		dma_list = kmalloc(npages * sizeof *dma_list, GFP_KERNEL);
 		if (!dma_list)
-			goto err_out_free;
+			goto err_free;
 
 		for (i = 0; i < npages; ++i)
 			dma_list[i] = t + i * (1 << shift);
@@ -612,12 +620,9 @@
 		npages        = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 		shift         = PAGE_SHIFT;
 
-		if (0)
-			mthca_dbg(dev, "Creating indirect CQ with %d pages\n", npages);
-
 		dma_list = kmalloc(npages * sizeof *dma_list, GFP_KERNEL);
 		if (!dma_list)
-			goto err_out;
+			return -ENOMEM;
 
 		cq->queue.page_list = kmalloc(npages * sizeof *cq->queue.page_list,
 					      GFP_KERNEL);
@@ -631,7 +636,7 @@
 			cq->queue.page_list[i].buf =
 				pci_alloc_consistent(dev->pdev, PAGE_SIZE, &t);
 			if (!cq->queue.page_list[i].buf)
-				goto err_out_free;
+				goto err_free;
 
 			dma_list[i] = t;
 			pci_unmap_addr_set(&cq->queue.page_list[i], mapping, t);
@@ -640,13 +645,6 @@
 		}
 	}
 
-	for (i = 0; i < nent; ++i)
-		set_cqe_hw(get_cqe(cq, i));
-
-	cq->cqn = mthca_alloc(&dev->cq_table.alloc);
-	if (cq->cqn == -1)
-		goto err_out_free;
-
 	err = mthca_mr_alloc_phys(dev, dev->driver_pd.pd_num,
 				  dma_list, shift, npages,
 				  0, size,
@@ -654,7 +652,52 @@
 				  MTHCA_MPT_FLAG_LOCAL_READ,
 				  &cq->mr);
 	if (err)
-		goto err_out_free_cq;
+		goto err_free;
+
+	kfree(dma_list);
+
+	return 0;
+
+err_free:
+	mthca_free_cq_buf(dev, cq);
+
+err_out:
+	kfree(dma_list);
+
+	return err;
+}
+
+int mthca_init_cq(struct mthca_dev *dev, int nent,
+		  struct mthca_cq *cq)
+{
+	int size = nent * MTHCA_CQ_ENTRY_SIZE;
+	void *mailbox = NULL;
+	struct mthca_cq_context *cq_context;
+	int err = -ENOMEM;
+	u8 status;
+	int i;
+
+	might_sleep();
+
+	cq->ibcq.cqe = nent - 1;
+
+	cq->cqn = mthca_alloc(&dev->cq_table.alloc);
+	if (cq->cqn == -1)
+		return -ENOMEM;
+
+	mailbox = kmalloc(sizeof (struct mthca_cq_context) + MTHCA_CMD_MAILBOX_EXTRA,
+			  GFP_KERNEL);
+	if (!mailbox)
+		goto err_out;
+
+	cq_context = MAILBOX_ALIGN(mailbox);
+
+	err = mthca_alloc_cq_buf(dev, size, cq);
+	if (err)
+		goto err_out_mailbox;
+
+	for (i = 0; i < nent; ++i)
+		set_cqe_hw(get_cqe(cq, i));
 
 	spin_lock_init(&cq->lock);
 	atomic_set(&cq->refcount, 1);
@@ -697,37 +740,20 @@
 
 	cq->cons_index = 0;
 
-	kfree(dma_list);
 	kfree(mailbox);
 
 	return 0;
 
- err_out_free_mr:
+err_out_free_mr:
 	mthca_free_mr(dev, &cq->mr);
+	mthca_free_cq_buf(dev, cq);
 
- err_out_free_cq:
-	mthca_free(&dev->cq_table.alloc, cq->cqn);
-
- err_out_free:
-	if (cq->is_direct)
-		pci_free_consistent(dev->pdev, size,
-				    cq->queue.direct.buf,
-				    pci_unmap_addr(&cq->queue.direct, mapping));
-	else {
-		for (i = 0; i < npages; ++i)
-			if (cq->queue.page_list[i].buf)
-				pci_free_consistent(dev->pdev, PAGE_SIZE,
-						    cq->queue.page_list[i].buf,
-						    pci_unmap_addr(&cq->queue.page_list[i],
-								   mapping));
-
-		kfree(cq->queue.page_list);
-	}
-
- err_out:
-	kfree(dma_list);
+err_out_mailbox:
 	kfree(mailbox);
 
+err_out:
+	mthca_free(&dev->cq_table.alloc, cq->cqn);
+
 	return err;
 }
 
@@ -778,27 +804,7 @@
 	wait_event(cq->wait, !atomic_read(&cq->refcount));
 
 	mthca_free_mr(dev, &cq->mr);
-
-	if (cq->is_direct)
-		pci_free_consistent(dev->pdev,
-				    (cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE,
-				    cq->queue.direct.buf,
-				    pci_unmap_addr(&cq->queue.direct,
-						   mapping));
-	else {
-		int i;
-
-		for (i = 0;
-		     i < ((cq->ibcq.cqe + 1) * MTHCA_CQ_ENTRY_SIZE + PAGE_SIZE - 1) /
-			     PAGE_SIZE;
-		     ++i)
-			pci_free_consistent(dev->pdev, PAGE_SIZE,
-					    cq->queue.page_list[i].buf,
-					    pci_unmap_addr(&cq->queue.page_list[i],
-							   mapping));
-
-		kfree(cq->queue.page_list);
-	}
+	mthca_free_cq_buf(dev, cq);
 
 	mthca_free(&dev->cq_table.alloc, cq->cqn);
 	kfree(mailbox);
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:12:54.673053870 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-03-03 14:12:59.925913650 -0800
@@ -408,8 +408,7 @@
 	if (err) {
 		kfree(cq);
 		cq = ERR_PTR(err);
-	} else
-		cq->ibcq.cqe = nent - 1;
+	}
 
 	return &cq->ibcq;
 }

