Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbSKMCgH>; Tue, 12 Nov 2002 21:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSKMCgH>; Tue, 12 Nov 2002 21:36:07 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:34324
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267102AbSKMCgF>; Tue, 12 Nov 2002 21:36:05 -0500
Date: Tue, 12 Nov 2002 21:37:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][2.5] xircom_cb small cleanups
Message-ID: <Pine.LNX.4.44.0211122134430.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.47/drivers/net/tulip/xircom_cb.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/drivers/net/tulip/xircom_cb.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 xircom_cb.c
--- linux-2.5.47/drivers/net/tulip/xircom_cb.c	11 Nov 2002 03:57:05 -0000	1.1.1.1
+++ linux-2.5.47/drivers/net/tulip/xircom_cb.c	13 Nov 2002 01:52:53 -0000
@@ -154,8 +154,6 @@
 	.id_table	= xircom_pci_table, 
 	.probe		= xircom_probe, 
 	.remove		= xircom_remove, 
-	.suspend =NULL,
-	.resume =NULL
 };
 
 
@@ -201,9 +199,9 @@
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 
-       switch(cmd) {
-       case SIOCETHTOOL:
-	       return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
+	switch(cmd) {
+	case SIOCETHTOOL:
+		return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -221,15 +219,17 @@
 	struct net_device *dev = NULL;
 	struct xircom_private *private;
 	unsigned char chip_rev;
-	unsigned long flags;
+	unsigned long flags, io_start;
 	unsigned short tmp16;
+	int rc = -ENODEV;
 	enter("xircom_probe");
 	
 	/* First do the PCI initialisation */
 
 	if (pci_enable_device(pdev))
-		return -ENODEV;
+		goto exit;
 
+	rc = -ENOMEM;
 	/* disable all powermanagement */
 	pci_write_config_dword(pdev, PCI_POWERMGMT, 0x0000);
 	
@@ -240,51 +240,48 @@
 	pci_write_config_word (pdev, PCI_STATUS,tmp16);
 	
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &chip_rev);
-	
-	if (!request_region(pci_resource_start(pdev, 0), 128, "xircom_cb")) {
-		printk(KERN_ERR "xircom_probe: failed to allocate io-region\n");
-		return -ENODEV;
+	io_start = pci_resource_start(pdev, 0);
+	if (!request_region(io_start, 128, "xircom_cb")) {
+		printk(KERN_ERR "xircom_probe: failed to allocate io-region \n");
+		goto exit;
 	}
 
-	
 	/* 
 	   Before changing the hardware, allocate the memory.
 	   This way, we can fail gracefully if not enough memory
 	   is available. 
 	 */
 	private = kmalloc(sizeof(*private),GFP_KERNEL);
-	memset(private, 0, sizeof(struct xircom_private));
+	if (private == NULL)
+		goto out_free_region;
+
+	memset(private, 0, sizeof *private);
 	
 	/* Allocate the send/receive buffers */
 	private->rx_buffer = pci_alloc_consistent(pdev,8192,&private->rx_dma_handle);
 	
 	if (private->rx_buffer == NULL) {
  		printk(KERN_ERR "xircom_probe: no memory for rx buffer \n");
- 		kfree(private);
-		return -ENODEV;
+		goto out_free_mem;
 	}	
 	private->tx_buffer = pci_alloc_consistent(pdev,8192,&private->tx_dma_handle);
 	if (private->tx_buffer == NULL) {
 		printk(KERN_ERR "xircom_probe: no memory for tx buffer \n");
-		kfree(private->rx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto out_free_mem;
 	}
 	dev = init_etherdev(dev, 0);
 	if (dev == NULL) {
 		printk(KERN_ERR "xircom_probe: failed to allocate etherdev\n");
-		kfree(private->rx_buffer);
-		kfree(private->tx_buffer);
-		kfree(private);
-		return -ENODEV;
+		goto out_free_mem;
 	}
 	SET_MODULE_OWNER(dev);
 	printk(KERN_INFO "%s: Xircom cardbus revision %i at irq %i \n", dev->name, chip_rev, pdev->irq);
 
+	rc = 0;
 	private->dev = dev;
 	private->pdev = pdev;
-	private->io_port = pci_resource_start(pdev, 0);
-	private->lock = SPIN_LOCK_UNLOCKED;
+	private->io_port = io_start;
+	spin_lock_init(&private->lock);
 	dev->irq = pdev->irq;
 	dev->base_addr = private->io_port;
 	
@@ -307,14 +304,23 @@
 	tranceiver_voodoo(private);
 	
 	spin_lock_irqsave(&private->lock,flags);
-	  activate_transmitter(private);
-	  activate_receiver(private);
+	activate_transmitter(private);
+	activate_receiver(private);
 	spin_unlock_irqrestore(&private->lock,flags);
 	
 	trigger_receive(private);
-	
+	goto exit;
+
+out_free_mem:
+	kfree(private->rx_buffer);
+	kfree(private->tx_buffer);
+	kfree(private);
+out_free_region:
+	release_region(io_start, 128);
+	pci_disable_device(pdev);
+exit:
 	leave("xircom_probe");
-	return 0;
+	return rc;
 }
 
 
-- 
function.linuxpower.ca

