Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTK3PMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 10:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTK3PMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 10:12:41 -0500
Received: from ip008.siteplanet.com.br ([200.245.54.8]:6929 "EHLO
	plutao.siteplanet.com.br") by vger.kernel.org with ESMTP
	id S264917AbTK3PMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 10:12:34 -0500
Subject: [PATCH 2.6] RTL8169 Suspend and Resume Stuff
From: Fernando Alencar =?ISO-8859-1?Q?Mar=F3stica?= <famarost@unimep.br>
To: Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       RealTek Mailing List <realtek@scyld.com>
Cc: Djalma Fadel Junior <fadel@ferasoft.com.br>,
       Walter Gima <wgima@ferasoft.com.br>
Content-Type: multipart/mixed; boundary="=-Gtpb2CrgWMdupcU5YdZd"
Organization: University Methodist of Piracicaba
Message-Id: <1070203973.1216.6.camel@oxygenium>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 30 Nov 2003 12:52:53 -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gtpb2CrgWMdupcU5YdZd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi Jeff,

Here's a short patch for the new Realtek RTL8169 PCI Gigabit Driver
(drivers/net/r8169.c) in kernel. This patch add new PCI suspend
and resume code.

The patch applies against 2.4.23 and 2.6.0-test11. I've tested the 
compilation with 2.4.23.

Happy Hack!

-- 
Fernando Alencar Maróstica
Graduate Student, Computer Science
Linux Register User Id #281457
                                                                     
University Methodist of Piracicaba
Departament of Computer Science
email: famarost@unimep.br
homepage: http://www.unimep.br/~famarost


--=-Gtpb2CrgWMdupcU5YdZd
Content-Disposition: attachment; filename=r8169-linux-2.6.0-test11.patch
Content-Type: text/x-patch; name=r8169-linux-2.6.0-test11.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- r8169.c.orig	2003-11-30 12:01:19.000000000 -0200
+++ r8169.c	2003-11-30 12:39:55.000000000 -0200
@@ -33,6 +33,10 @@
 	- Copy mc_filter setup code from 8139cp
 	  (includes an optimization, and avoids set_bit use)
 
+		<2003/11/30>
+
+	- Add new rtl8169_resume() support
+	- Add new rtl8169_suspend() support
 */
 
 #include <linux/module.h>
@@ -359,6 +363,7 @@
 	int rc, i;
 	unsigned long mmio_start, mmio_end, mmio_flags, mmio_len;
 	u32 tmp;
+	int acpi_idle_state = 0, pm_cap;
 
 	assert(pdev != NULL);
 	assert(ioaddr_out != NULL);
@@ -366,10 +371,10 @@
 	*ioaddr_out = NULL;
 	*dev_out = NULL;
 
-	// dev zeroed in alloc_etherdev 
+	/* dev zeroed in alloc_etherdev  */
 	dev = alloc_etherdev(sizeof (*tp));
-	if (dev == NULL) {
-		printk(KERN_ERR PFX "unable to alloc new ethernet\n");
+	if (!dev) {
+		printk(KERN_ERR PFX "%s: Could not allocate new ethernet device.\n", pdev->slot_name);
 		return -ENOMEM;
 	}
 
@@ -377,10 +382,24 @@
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	tp = dev->priv;
 
-	// enable device (incl. PCI PM wakeup and hotplug setup)
+	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pci_enable_device(pdev);
-	if (rc)
+	if (rc) {
+		printk(KERN_ERR PFX "%s: unable to enable device\n", pdev->slot_name);
 		goto err_out;
+	}
+
+	/* save power state before pci_enable_device overwrites it */
+	pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	if (pm_cap) {
+		u16 pwr_command;
+		pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pwr_command);
+		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
+	}
+	else {
+		printk(KERN_ERR PFX "Cannot find PowerManagement capability, aborting.\n");
+		goto err_out_free_res;
+	}
 
 	mmio_start = pci_resource_start(pdev, 1);
 	mmio_end = pci_resource_end(pdev, 1);
@@ -402,10 +421,12 @@
 	}
 
 	rc = pci_request_regions(pdev, dev->name);
-	if (rc)
+	if (rc) {
+		printk(KERN_ERR PFX "%s: Could not request regions.\n", pdev->slot_name);
 		goto err_out_disable;
+	}
 
-	// enable PCI bus-mastering
+	/* enable PCI bus-mastering */
 	pci_set_master(pdev);
 
 	// ioremap MMIO region 
@@ -466,7 +487,6 @@
 	struct rtl8169_private *tp = NULL;
 	void *ioaddr = NULL;
 	static int board_idx = -1;
-	static int printed_version = 0;
 	int i, rc;
 	int option = -1, Cap10_100 = 0, Cap1000 = 0;
 
@@ -475,11 +495,16 @@
 
 	board_idx++;
 
-	if (!printed_version) {
-		printk(KERN_INFO RTL8169_DRIVER_NAME " loaded\n");
-		printed_version = 1;
-	}
++#ifndef MODULE
+	{
+		/* when built-in, we only print version if device is found */
+		static int did_version;
 
+		if (!did_version++)
+			printk(KERN_INFO RTL8169_DRIVER_NAME " loaded\n");
+	}
++#endif
+	
 	rc = rtl8169_init_board(pdev, &dev, &ioaddr);
 	if (rc)
 		return rc;
@@ -651,6 +676,50 @@
 	pci_set_drvdata(pdev, NULL);
 }
 
+#ifdef CONFIG_PM
+
+static int rtl8169_suspend (struct pci_dev *pci_device, u32 state)
+{
+	struct net_device *ethernet_device = pci_get_drvdata (pci_device);
+	struct rtl8169_private *tp = (struct rtl8169_private *) (ethernet_device->priv);
+	void *ioaddr = tp->mmio_addr;
+	unsigned long flags;
+
+	if (!netif_running (ethernet_device))
+		return 0;
+	
+	netif_device_detach (ethernet_device);
+	netif_stop_queue (ethernet_device);
+	spin_lock_irqsave (&tp->lock, flags);
+
+	/* Disable interrupts, stop Rx and Tx */
+	writew ((0), ioaddr + (IntrMask));
+	writeb ((0), ioaddr + (ChipCmd));
+		
+	/* Update the error counts. */
+	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
+	writel ((0), ioaddr + (RxMissed));
+	spin_unlock_irqrestore (&tp->lock, flags);
+	
+	return 0;
+}
+
+static int rtl8169_resume (struct pci_dev *pci_device)
+{
+	struct net_device *ethernet_device = pci_get_drvdata (pci_device);
+
+	if (!netif_running (ethernet_device))
+	    return 0;
+
+	netif_device_attach (ethernet_device);
+	rtl8169_hw_start (ethernet_device);
+	netif_start_queue (ethernet_device);
+
+	return 0;
+}
+                                                                                
+#endif /* CONFIG_PM */
+
 static int
 rtl8169_open(struct net_device *dev)
 {
@@ -698,6 +767,7 @@
 
 	rtl8169_init_ring(dev);
 	rtl8169_hw_start(dev);
+	netif_start_queue(dev);
 
 	return 0;
 
@@ -754,9 +824,6 @@
 
 	/* Enable all known interrupts by setting the interrupt mask. */
 	RTL_W16(IntrMask, rtl8169_intr_mask);
-
-	netif_start_queue(dev);
-
 }
 
 static void
@@ -1126,8 +1193,10 @@
 	.id_table	= rtl8169_pci_tbl,
 	.probe		= rtl8169_init_one,
 	.remove		= __devexit_p(rtl8169_remove_one),
-	.suspend	= NULL,
-	.resume		= NULL,
+#ifdef CONFIG_PM
+	.suspend	= rtl8169_suspend,
+	.resume		= rtl8169_resume,
+#endif
 };
 
 static int __init

--=-Gtpb2CrgWMdupcU5YdZd--

