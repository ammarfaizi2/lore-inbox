Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWI1QCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWI1QCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWI1QCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:47 -0400
Received: from mx.pathscale.com ([64.160.42.68]:3766 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751922AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 20 of 28] IB/ipath - clean up module exit code
X-Mercurial-Node: e3158e62d6bf923cadc29c0f3bec5e84fc4d6b87
Message-Id: <e3158e62d6bf923cadc2.1159459216@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:16 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 858280e8cbab -r e3158e62d6bf drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:13 2006 -0700
@@ -517,33 +517,146 @@ bail:
 	return ret;
 }
 
+static void __devexit cleanup_device(struct ipath_devdata *dd)
+{
+	int port;
+
+	ipath_shutdown_device(dd);
+
+	if (*dd->ipath_statusp & IPATH_STATUS_CHIP_PRESENT) {
+		/* can't do anything more with chip; needs re-init */
+		*dd->ipath_statusp &= ~IPATH_STATUS_CHIP_PRESENT;
+		if (dd->ipath_kregbase) {
+			/*
+			 * if we haven't already cleaned up before these are
+			 * to ensure any register reads/writes "fail" until
+			 * re-init
+			 */
+			dd->ipath_kregbase = NULL;
+			dd->ipath_uregbase = 0;
+			dd->ipath_sregbase = 0;
+			dd->ipath_cregbase = 0;
+			dd->ipath_kregsize = 0;
+		}
+		ipath_disable_wc(dd);
+	}
+
+	if (dd->ipath_pioavailregs_dma) {
+		dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
+				  (void *) dd->ipath_pioavailregs_dma,
+				  dd->ipath_pioavailregs_phys);
+		dd->ipath_pioavailregs_dma = NULL;
+	}
+	if (dd->ipath_dummy_hdrq) {
+		dma_free_coherent(&dd->pcidev->dev,
+			dd->ipath_pd[0]->port_rcvhdrq_size,
+			dd->ipath_dummy_hdrq, dd->ipath_dummy_hdrq_phys);
+		dd->ipath_dummy_hdrq = NULL;
+	}
+
+	if (dd->ipath_pageshadow) {
+		struct page **tmpp = dd->ipath_pageshadow;
+		dma_addr_t *tmpd = dd->ipath_physshadow;
+		int i, cnt = 0;
+
+		ipath_cdbg(VERBOSE, "Unlocking any expTID pages still "
+			   "locked\n");
+		for (port = 0; port < dd->ipath_cfgports; port++) {
+			int port_tidbase = port * dd->ipath_rcvtidcnt;
+			int maxtid = port_tidbase + dd->ipath_rcvtidcnt;
+			for (i = port_tidbase; i < maxtid; i++) {
+				if (!tmpp[i])
+					continue;
+				pci_unmap_page(dd->pcidev, tmpd[i],
+					PAGE_SIZE, PCI_DMA_FROMDEVICE);
+				ipath_release_user_pages(&tmpp[i], 1);
+				tmpp[i] = NULL;
+				cnt++;
+			}
+		}
+		if (cnt) {
+			ipath_stats.sps_pageunlocks += cnt;
+			ipath_cdbg(VERBOSE, "There were still %u expTID "
+				   "entries locked\n", cnt);
+		}
+		if (ipath_stats.sps_pagelocks ||
+		    ipath_stats.sps_pageunlocks)
+			ipath_cdbg(VERBOSE, "%llu pages locked, %llu "
+				   "unlocked via ipath_m{un}lock\n",
+				   (unsigned long long)
+				   ipath_stats.sps_pagelocks,
+				   (unsigned long long)
+				   ipath_stats.sps_pageunlocks);
+
+		ipath_cdbg(VERBOSE, "Free shadow page tid array at %p\n",
+			   dd->ipath_pageshadow);
+		vfree(dd->ipath_pageshadow);
+		dd->ipath_pageshadow = NULL;
+	}
+
+	/*
+	 * free any resources still in use (usually just kernel ports)
+	 * at unload; we do for portcnt, not cfgports, because cfgports
+	 * could have changed while we were loaded.
+	 */
+	for (port = 0; port < dd->ipath_portcnt; port++) {
+		struct ipath_portdata *pd = dd->ipath_pd[port];
+		dd->ipath_pd[port] = NULL;
+		ipath_free_pddata(dd, pd);
+	}
+	kfree(dd->ipath_pd);
+	/*
+	 * debuggability, in case some cleanup path tries to use it
+	 * after this
+	 */
+	dd->ipath_pd = NULL;
+}
+
 static void __devexit ipath_remove_one(struct pci_dev *pdev)
 {
-	struct ipath_devdata *dd;
-
-	ipath_cdbg(VERBOSE, "removing, pdev=%p\n", pdev);
-	if (!pdev)
-		return;
-
-	dd = pci_get_drvdata(pdev);
-
-	if (dd->verbs_dev) {
+	struct ipath_devdata *dd = pci_get_drvdata(pdev);
+
+	ipath_cdbg(VERBOSE, "removing, pdev=%p, dd=%p\n", pdev, dd);
+
+	if (dd->verbs_dev)
 		ipath_unregister_ib_device(dd->verbs_dev);
-		dd->verbs_dev = NULL;
-	}
 
 	ipath_diag_remove(dd);
 	ipath_user_remove(dd);
 	ipathfs_remove_device(dd);
 	ipath_device_remove_group(&pdev->dev, dd);
+
 	ipath_cdbg(VERBOSE, "Releasing pci memory regions, dd %p, "
 		   "unit %u\n", dd, (u32) dd->ipath_unit);
-	if (dd->ipath_kregbase) {
-		ipath_cdbg(VERBOSE, "Unmapping kregbase %p\n",
-			   dd->ipath_kregbase);
-		iounmap((volatile void __iomem *) dd->ipath_kregbase);
-		dd->ipath_kregbase = NULL;
-	}
+
+	cleanup_device(dd);
+
+	/*
+	 * turn off rcv, send, and interrupts for all ports, all drivers
+	 * should also hard reset the chip here?
+	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
+	 * for all versions of the driver, if they were allocated
+	 */
+	if (pdev->irq) {
+		ipath_cdbg(VERBOSE,
+			   "unit %u free_irq of irq %x\n",
+			   dd->ipath_unit, pdev->irq);
+		free_irq(pdev->irq, dd);
+	} else
+		ipath_dbg("irq is 0, not doing free_irq "
+			  "for unit %u\n", dd->ipath_unit);
+	/*
+	 * we check for NULL here, because it's outside
+	 * the kregbase check, and we need to call it
+	 * after the free_irq.	Thus it's possible that
+	 * the function pointers were never initialized.
+	 */
+	if (dd->ipath_f_cleanup)
+		/* clean up chip-specific stuff */
+		dd->ipath_f_cleanup(dd);
+
+	ipath_cdbg(VERBOSE, "Unmapping kregbase %p\n", dd->ipath_kregbase);
+	iounmap((volatile void __iomem *) dd->ipath_kregbase);
 	pci_release_regions(pdev);
 	ipath_cdbg(VERBOSE, "calling pci_disable_device\n");
 	pci_disable_device(pdev);
@@ -1917,157 +2030,11 @@ bail:
 	return ret;
 }
 
-static void cleanup_device(struct ipath_devdata *dd)
-{
-	int port;
-
-	ipath_shutdown_device(dd);
-
-	if (*dd->ipath_statusp & IPATH_STATUS_CHIP_PRESENT) {
-		/* can't do anything more with chip; needs re-init */
-		*dd->ipath_statusp &= ~IPATH_STATUS_CHIP_PRESENT;
-		if (dd->ipath_kregbase) {
-			/*
-			 * if we haven't already cleaned up before these are
-			 * to ensure any register reads/writes "fail" until
-			 * re-init
-			 */
-			dd->ipath_kregbase = NULL;
-			dd->ipath_uregbase = 0;
-			dd->ipath_sregbase = 0;
-			dd->ipath_cregbase = 0;
-			dd->ipath_kregsize = 0;
-		}
-		ipath_disable_wc(dd);
-	}
-
-	if (dd->ipath_pioavailregs_dma) {
-		dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
-				  (void *) dd->ipath_pioavailregs_dma,
-				  dd->ipath_pioavailregs_phys);
-		dd->ipath_pioavailregs_dma = NULL;
-	}
-	if (dd->ipath_dummy_hdrq) {
-		dma_free_coherent(&dd->pcidev->dev,
-			dd->ipath_pd[0]->port_rcvhdrq_size,
-			dd->ipath_dummy_hdrq, dd->ipath_dummy_hdrq_phys);
-		dd->ipath_dummy_hdrq = NULL;
-	}
-
-	if (dd->ipath_pageshadow) {
-		struct page **tmpp = dd->ipath_pageshadow;
-		dma_addr_t *tmpd = dd->ipath_physshadow;
-		int i, cnt = 0;
-
-		ipath_cdbg(VERBOSE, "Unlocking any expTID pages still "
-			   "locked\n");
-		for (port = 0; port < dd->ipath_cfgports; port++) {
-			int port_tidbase = port * dd->ipath_rcvtidcnt;
-			int maxtid = port_tidbase + dd->ipath_rcvtidcnt;
-			for (i = port_tidbase; i < maxtid; i++) {
-				if (!tmpp[i])
-					continue;
-				pci_unmap_page(dd->pcidev, tmpd[i],
-					       PAGE_SIZE, PCI_DMA_FROMDEVICE);
-				ipath_release_user_pages(&tmpp[i], 1);
-				tmpp[i] = NULL;
-				cnt++;
-			}
-		}
-		if (cnt) {
-			ipath_stats.sps_pageunlocks += cnt;
-			ipath_cdbg(VERBOSE, "There were still %u expTID "
-				   "entries locked\n", cnt);
-		}
-		if (ipath_stats.sps_pagelocks ||
-		    ipath_stats.sps_pageunlocks)
-			ipath_cdbg(VERBOSE, "%llu pages locked, %llu "
-				   "unlocked via ipath_m{un}lock\n",
-				   (unsigned long long)
-				   ipath_stats.sps_pagelocks,
-				   (unsigned long long)
-				   ipath_stats.sps_pageunlocks);
-
-		ipath_cdbg(VERBOSE, "Free shadow page tid array at %p\n",
-			   dd->ipath_pageshadow);
-		vfree(dd->ipath_pageshadow);
-		dd->ipath_pageshadow = NULL;
-	}
-
-	/*
-	 * free any resources still in use (usually just kernel ports)
-	 * at unload; we do for portcnt, not cfgports, because cfgports
-	 * could have changed while we were loaded.
-	 */
-	for (port = 0; port < dd->ipath_portcnt; port++) {
-		struct ipath_portdata *pd = dd->ipath_pd[port];
-		dd->ipath_pd[port] = NULL;
-		ipath_free_pddata(dd, pd);
-	}
-	kfree(dd->ipath_pd);
-	/*
-	 * debuggability, in case some cleanup path tries to use it
-	 * after this
-	 */
-	dd->ipath_pd = NULL;
-}
-
 static void __exit infinipath_cleanup(void)
 {
-	struct ipath_devdata *dd, *tmp;
-	unsigned long flags;
-
-	ipath_diagpkt_remove();
-
 	ipath_exit_ipathfs();
 
 	ipath_driver_remove_group(&ipath_driver.driver);
-
-	spin_lock_irqsave(&ipath_devs_lock, flags);
-
-	/*
-	 * turn off rcv, send, and interrupts for all ports, all drivers
-	 * should also hard reset the chip here?
-	 * free up port 0 (kernel) rcvhdr, egr bufs, and eventually tid bufs
-	 * for all versions of the driver, if they were allocated
-	 */
-	list_for_each_entry_safe(dd, tmp, &ipath_dev_list, ipath_list) {
-		spin_unlock_irqrestore(&ipath_devs_lock, flags);
-
-		if (dd->verbs_dev) {
-			ipath_unregister_ib_device(dd->verbs_dev);
-			dd->verbs_dev = NULL;
-		}
-
-		if (dd->ipath_kregbase)
-			cleanup_device(dd);
-
-		if (dd->pcidev) {
-			if (dd->pcidev->irq) {
-				ipath_cdbg(VERBOSE,
-					   "unit %u free_irq of irq %x\n",
-					   dd->ipath_unit, dd->pcidev->irq);
-				free_irq(dd->pcidev->irq, dd);
-			} else
-				ipath_dbg("irq is 0, not doing free_irq "
-					  "for unit %u\n", dd->ipath_unit);
-
-			/*
-			 * we check for NULL here, because it's outside
-			 * the kregbase check, and we need to call it
-			 * after the free_irq.  Thus it's possible that
-			 * the function pointers were never initialized.
-			 */
-			if (dd->ipath_f_cleanup)
-				/* clean up chip-specific stuff */
-				dd->ipath_f_cleanup(dd);
-
-			dd->pcidev = NULL;
-		}
-		spin_lock_irqsave(&ipath_devs_lock, flags);
-	}
-
-	spin_unlock_irqrestore(&ipath_devs_lock, flags);
 
 	ipath_cdbg(VERBOSE, "Unregistering pci driver\n");
 	pci_unregister_driver(&ipath_driver);
