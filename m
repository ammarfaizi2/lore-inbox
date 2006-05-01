Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWEAXPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWEAXPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWEAXPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:15:50 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:22926 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932314AbWEAXPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:15:49 -0400
Date: Tue, 2 May 2006 01:12:06 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: [PATCH 3/3] ipg: plug leaks in the error path of ipg_nic_open
Message-ID: <20060501231206.GD7419@electric-eye.fr.zoreil.com>
References: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146506939.23931.2.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added ipg_{rx/tx}_clear() to factor out some code.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

---

 drivers/net/ipg.c |  161 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 93 insertions(+), 68 deletions(-)

96f29e9d57f503f1275757f4bbec76c0f7f421fc
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index da0fa22..393b617 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -16,6 +16,9 @@
  */
 #include <linux/crc32.h>
 
+#define IPG_RX_RING_BYTES	(sizeof(struct RFD) * IPG_RFDLIST_LENGTH)
+#define IPG_TX_RING_BYTES	(sizeof(struct TFD) * IPG_TFDLIST_LENGTH)
+
 #define JUMBO_FRAME_4k_ONLY
 enum {
 	netdev_io_size = 128
@@ -1485,15 +1488,46 @@ static void ipg_nic_txfree(struct net_de
 	} while (maxtfdcount != 0);
 }
 
-static int ipg_nic_open(struct net_device *dev)
+static void ipg_rx_clear(struct ipg_nic_private *sp)
 {
-	/* The IPG NIC Ethernet interface is opened when activated
-	 * by ifconfig.
-	 */
+	struct pci_dev *pdev = sp->pdev;
+	unsigned int i;
 
-	int error = 0;
-	void __iomem *ioaddr = ipg_ioaddr(dev);
+	for (i = 0; i < IPG_RFDLIST_LENGTH; i++) {
+		if (sp->RxBuff[i]) {
+			struct ipg_dmabuff *desc = sp->RxBuffDMAhandle + i;
+
+			IPG_DEV_KFREE_SKB(sp->RxBuff[i]);
+			sp->RxBuff[i] = NULL;
+			pci_unmap_single(pdev, desc->dmahandle, desc->len,
+					 PCI_DMA_FROMDEVICE);
+		}
+	}
+}
+
+static void ipg_tx_clear(struct ipg_nic_private *sp)
+{
+	struct pci_dev *pdev = sp->pdev;
+	unsigned int i;
+
+	for (i = 0; i < IPG_TFDLIST_LENGTH; i++) {
+		if (sp->TxBuff[i]) {
+			struct ipg_dmabuff *desc = sp->TxBuffDMAhandle + i;
+
+			IPG_DEV_KFREE_SKB(sp->TxBuff[i]);
+			sp->TxBuff[i] = NULL;
+			pci_unmap_single(pdev, desc->dmahandle, desc->len,
+					 PCI_DMA_TODEVICE);
+		}
+	}
+}
+
+static int ipg_nic_open(struct net_device *dev)
+{
 	struct ipg_nic_private *sp = netdev_priv(dev);
+	void __iomem *ioaddr = ipg_ioaddr(dev);
+	struct pci_dev *pdev = sp->pdev;
+	int rc;
 
 	IPG_DEBUG_MSG("_nic_open\n");
 
@@ -1508,59 +1542,53 @@ static int ipg_nic_open(struct net_devic
 	/* Register the interrupt line to be used by the IPG within
 	 * the Linux system.
 	 */
-	if ((error = request_irq(sp->pdev->irq,
-				 &ipg_interrupt_handler,
-				 SA_SHIRQ, dev->name, dev)) < 0) {
+	rc = request_irq(pdev->irq, &ipg_interrupt_handler, SA_SHIRQ,
+			 dev->name, dev);
+	if (rc < 0) {
 		printk(KERN_INFO "%s: Error when requesting interrupt.\n",
 		       dev->name);
-		return error;
+		goto out;
 	}
 
-	dev->irq = sp->pdev->irq;
+	dev->irq = pdev->irq;
 
-	sp->RFDList = pci_alloc_consistent(sp->pdev,
-					   (sizeof(struct RFD) *
-					    IPG_RFDLIST_LENGTH),
+	rc = -ENOMEM;
+
+	sp->RFDList = pci_alloc_consistent(pdev, IPG_RX_RING_BYTES,
 					   &sp->RFDListDMAhandle);
+	if (!sp->RFDList)
+		goto err_free_irq_0;
 
-	sp->TFDList = pci_alloc_consistent(sp->pdev,
-					   (sizeof(struct TFD) *
-					    IPG_TFDLIST_LENGTH),
+	sp->TFDList = pci_alloc_consistent(pdev, IPG_TX_RING_BYTES,
 					   &sp->TFDListDMAhandle);
+	if (!sp->TFDList)
+		goto err_free_rx_1;
 
-	if ((sp->RFDList == NULL) || (sp->TFDList == NULL)) {
-		printk(KERN_INFO
-		       "%s: No memory available for IP1000 RFD and/or TFD lists.\n",
-		       dev->name);
-		return -ENOMEM;
-	}
-
-	error = init_rfdlist(dev);
-	if (error < 0) {
+	rc = init_rfdlist(dev);
+	if (rc < 0) {
 		printk(KERN_INFO "%s: Error during configuration.\n",
 		       dev->name);
-		return error;
+		goto err_free_tx_2;
 	}
 
-	error = init_tfdlist(dev);
-	if (error < 0) {
+	rc = init_tfdlist(dev);
+	if (rc < 0) {
 		printk(KERN_INFO "%s: Error during configuration.\n",
 		       dev->name);
-		return error;
+		goto err_release_rfdlist_3;
 	}
 
-	/* Configure IPG I/O registers. */
-	error = ipg_io_config(dev);
-	if (error < 0) {
+	rc = ipg_io_config(dev);
+	if (rc < 0) {
 		printk(KERN_INFO "%s: Error during configuration.\n",
 		       dev->name);
-		return error;
+		goto err_release_tfdlist_4;
 	}
 
 	/* Resolve autonegotiation. */
-	if (ipg_config_autoneg(dev) < 0) {
+	if (ipg_config_autoneg(dev) < 0)
 		printk(KERN_INFO "%s: Auto-negotiation error.\n", dev->name);
-	}
+
 #ifdef JUMBO_FRAME
 	/* initialize JUMBO Frame control variable */
 	sp->Jumbo.FoundStart = 0;
@@ -1575,8 +1603,22 @@ #endif
 		   IPG_MC_TX_ENABLE), ioaddr + IPG_MACCTRL);
 
 	netif_start_queue(dev);
+out:
+	return rc;
 
-	return 0;
+err_release_tfdlist_4:
+	ipg_tx_clear(sp);
+err_release_rfdlist_3:
+	ipg_rx_clear(sp);
+err_free_tx_2:
+	pci_free_consistent(pdev, IPG_TX_RING_BYTES, sp->TFDList,
+			    sp->TFDListDMAhandle);
+err_free_rx_1:
+	pci_free_consistent(pdev, IPG_RX_RING_BYTES, sp->RFDList,
+			    sp->RFDListDMAhandle);
+err_free_irq_0:
+	free_irq(pdev->irq, dev);
+	goto out;
 }
 
 static int init_rfdlist(struct net_device *dev)
@@ -1593,13 +1635,16 @@ static int init_rfdlist(struct net_devic
 	sp->RxBuffNotReady = 0;
 
 	for (i = 0; i < IPG_RFDLIST_LENGTH; i++) {
+		if (!sp->RxBuff[i])
+			continue;
+
 		/* Free any allocated receive buffers. */
 		pci_unmap_single(sp->pdev,
 				 sp->RxBuffDMAhandle[i].dmahandle,
 				 sp->RxBuffDMAhandle[i].len,
 				 PCI_DMA_FROMDEVICE);
-		if (sp->RxBuff[i] != NULL)
-			IPG_DEV_KFREE_SKB(sp->RxBuff[i]);
+
+		IPG_DEV_KFREE_SKB(sp->RxBuff[i]);
 		sp->RxBuff[i] = NULL;
 
 		/* Clear out the RFS field. */
@@ -1727,11 +1772,11 @@ static int ipg_get_rxbuff(struct net_dev
 
 static int ipg_nic_stop(struct net_device *dev)
 {
-	/* Release resources requested by driver open function. */
+	struct ipg_nic_private *sp = netdev_priv(dev);
+	struct pci_dev *pdev = sp->pdev;
 
 	int i;
 	int error;
-	struct ipg_nic_private *sp = netdev_priv(dev);
 
 	IPG_DEBUG_MSG("_nic_stop\n");
 
@@ -1752,40 +1797,20 @@ static int ipg_nic_stop(struct net_devic
 
 	error = ipg_reset(dev, i);
 	if (error < 0) {
+		// FIXME FIXME FIXME: giant leak alert
 		return error;
 	}
 
-	/* Free all receive buffers. */
-	for (i = 0; i < IPG_RFDLIST_LENGTH; i++) {
-		pci_unmap_single(sp->pdev,
-				 sp->RxBuffDMAhandle[i].dmahandle,
-				 sp->RxBuffDMAhandle[i].len,
-				 PCI_DMA_FROMDEVICE);
-		if (sp->RxBuff[i] != NULL)
-			IPG_DEV_KFREE_SKB(sp->RxBuff[i]);
-		sp->RxBuff[i] = NULL;
-	}
+	ipg_rx_clear(sp);
 
-	/* Free all transmit buffers. */
-	for (i = 0; i < IPG_TFDLIST_LENGTH; i++) {
-		if (sp->TxBuff[i] != NULL)
-			IPG_DEV_KFREE_SKB(sp->TxBuff[i]);
-		sp->TxBuff[i] = NULL;
-	}
+	ipg_tx_clear(sp);
 
 	netif_stop_queue(dev);
 
-	/* Free memory associated with the RFDList. */
-	pci_free_consistent(sp->pdev,
-			    (sizeof(struct RFD) *
-			     IPG_RFDLIST_LENGTH),
-			    sp->RFDList, sp->RFDListDMAhandle);
-
-	/* Free memory associated with the TFDList. */
-	pci_free_consistent(sp->pdev,
-			    (sizeof(struct TFD) *
-			     IPG_TFDLIST_LENGTH),
-			    sp->TFDList, sp->TFDListDMAhandle);
+	pci_free_consistent(pdev, IPG_RX_RING_BYTES, sp->RFDList,
+			    sp->RFDListDMAhandle);
+	pci_free_consistent(pdev, IPG_TX_RING_BYTES, sp->TFDList,
+			    sp->TFDListDMAhandle);
 
 	/* Release interrupt line. */
 	free_irq(dev->irq, dev);
-- 
1.3.1

