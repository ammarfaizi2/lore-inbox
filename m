Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTDFUd6 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTDFUd5 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:33:57 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:57670
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263077AbTDFUdy (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 16:33:54 -0400
Date: Sun, 6 Apr 2003 16:40:50 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][2.5] xircom_cb release memory on failure
Message-ID: <Pine.LNX.4.50.0304061635500.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches free'ing to pci_free_consistent and fixes a memory 
leak plus a few small cleanups.

Index: linux-2.5.66/drivers/net/tulip/xircom_cb.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/drivers/net/tulip/xircom_cb.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 xircom_cb.c
--- linux-2.5.66/drivers/net/tulip/xircom_cb.c	24 Mar 2003 23:39:20 -0000	1.1.1.1
+++ linux-2.5.66/drivers/net/tulip/xircom_cb.c	6 Apr 2003 20:25:44 -0000
@@ -73,6 +73,8 @@ MODULE_LICENSE("GPL");
 /* Offsets of the buffers within the descriptor pages, in bytes */
 
 #define NUMDESCRIPTORS 4
+#define RX_BUF_SIZE	8192
+#define TX_BUF_SIZE	8192
 
 static int bufferoffsets[NUMDESCRIPTORS] = {128,2048,4096,6144};
 
@@ -96,7 +98,7 @@ struct xircom_private {
 	int transmit_used;
 
 	/* Spinlock to serialize register operations.
-	   It must be helt while manipulating the following registers:
+	   It must be held whilst manipulating the following registers:
 	   CSR0, CSR6, CSR7, CSR9, CSR10, CSR15
 	 */
 	spinlock_t lock;
@@ -220,12 +222,13 @@ static int __devinit xircom_probe(struct
 	unsigned char chip_rev;
 	unsigned long flags;
 	unsigned short tmp16;
+	int ret = -EIO;
 	enter("xircom_probe");
 	
 	/* First do the PCI initialisation */
 
 	if (pci_enable_device(pdev))
-		return -ENODEV;
+		goto out;
 
 	/* disable all powermanagement */
 	pci_write_config_dword(pdev, PCI_POWERMGMT, 0x0000);
@@ -238,9 +241,10 @@ static int __devinit xircom_probe(struct
 	
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
 	
+	ret = -ENOMEM;
 	if (!request_region(pci_resource_start(pdev, 0), 128, "xircom_cb")) {
 		printk(KERN_ERR "xircom_probe: failed to allocate io-region\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	
@@ -250,30 +254,27 @@ static int __devinit xircom_probe(struct
 	   is available. 
 	 */
 	private = kmalloc(sizeof(*private),GFP_KERNEL);
-	memset(private, 0, sizeof(struct xircom_private));
+	if (private == NULL)
+		goto out_region;
+
+	memset(private, 0, sizeof(*private));
 	
 	/* Allocate the send/receive buffers */
-	private->rx_buffer = pci_alloc_consistent(pdev,8192,&private->rx_dma_handle);
+	private->rx_buffer = pci_alloc_consistent(pdev,RX_BUF_SIZE,&private->rx_dma_handle);
 	
 	if (private->rx_buffer == NULL) {
  		printk(KERN_ERR "xircom_probe: no memory for rx buffer \n");
- 		kfree(private);
-		return -ENODEV;
+		goto out_free1;
 	}	
-	private->tx_buffer = pci_alloc_consistent(pdev,8192,&private->tx_dma_handle);
+	private->tx_buffer = pci_alloc_consistent(pdev,TX_BUF_SIZE,&private->tx_dma_handle);
 	if (private->tx_buffer == NULL) {
 		printk(KERN_ERR "xircom_probe: no memory for tx buffer \n");
-		kfree(private->rx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto out_free2;
 	}
 	dev = init_etherdev(dev, 0);
 	if (dev == NULL) {
 		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
-		kfree(private->rx_buffer);
-		kfree(private->tx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto out_free3;
 	}
 	SET_MODULE_OWNER(dev);
 	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
@@ -304,14 +305,25 @@ static int __devinit xircom_probe(struct
 	transceiver_voodoo(private);
 	
 	spin_lock_irqsave(&private->lock,flags);
-	  activate_transmitter(private);
-	  activate_receiver(private);
+	activate_transmitter(private);
+	activate_receiver(private);
 	spin_unlock_irqrestore(&private->lock,flags);
 	
 	trigger_receive(private);
-	
+	ret = 0;
+	goto out;
+
+out_free3:
+	pci_free_consistent(pdev, TX_BUF_SIZE, private->tx_buffer, private->tx_dma_handle);
+out_free2:
+	pci_free_consistent(pdev, RX_BUF_SIZE, private->rx_buffer, private->rx_dma_handle);
+out_free1:
+	kfree(private);	
+out_region:
+	release_region(pci_resource_start(pdev, 0), 128);
+out:
 	leave("xircom_probe");
-	return 0;
+	return ret;
 }
 
 
@@ -330,10 +342,10 @@ static void __devexit xircom_remove(stru
 		card=dev->priv;
 		if (card!=NULL) {	
 			if (card->rx_buffer!=NULL)
-				pci_free_consistent(pdev,8192,card->rx_buffer,card->rx_dma_handle);
+				pci_free_consistent(pdev,RX_BUF_SIZE,card->rx_buffer,card->rx_dma_handle);
 			card->rx_buffer = NULL;
 			if (card->tx_buffer!=NULL)
-				pci_free_consistent(pdev,8192,card->tx_buffer,card->tx_dma_handle);
+				pci_free_consistent(pdev,TX_BUF_SIZE,card->tx_buffer,card->tx_dma_handle);
 			card->tx_buffer = NULL;			
 		}
 		kfree(card);

-- 
function.linuxpower.ca
