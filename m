Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTJCRfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTJCRfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 13:35:45 -0400
Received: from ee.oulu.fi ([130.231.61.23]:16078 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263675AbTJCRfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 13:35:42 -0400
Date: Fri, 3 Oct 2003 20:35:37 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] b44 enable interrupts after tx timeout (2.4.23-pre6)
Message-ID: <20031003173537.GA25261@ee.oulu.fi>
References: <20031003163301.GA25032@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20031003163301.GA25032@ee.oulu.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the 2.4.23-pre6 version, which syncs the driver fully with 2.6.
Seems to work (tm).

--- linux-2.4.23-pre6/drivers/net/b44.c.orig	2003-08-25 14:44:42.000000000 +0300
+++ linux-2.4.23-pre6/drivers/net/b44.c	2003-10-03 19:39:49.000000000 +0300
@@ -25,8 +25,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.9"
-#define DRV_MODULE_RELDATE	"Jul 14, 2003"
+#define DRV_MODULE_VERSION	"0.91"
+#define DRV_MODULE_RELDATE	"Oct 3, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -80,16 +80,7 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
-#ifndef PCI_DEVICE_ID_BCM4401
-#define PCI_DEVICE_ID_BCM4401      0x4401
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#define IRQ_RETVAL(x) 
-#define irqreturn_t void
-#endif
-
-static struct pci_device_id b44_pci_tbl[] __devinitdata = {
+static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ }	/* terminate list with empty entry */
@@ -870,6 +861,8 @@
 
 	spin_unlock_irq(&bp->lock);
 
+	b44_enable_ints(bp);
+
 	netif_wake_queue(dev);
 }
 
@@ -1393,7 +1386,7 @@
 		strcpy (info.driver, DRV_MODULE_NAME);
 		strcpy (info.version, DRV_MODULE_VERSION);
 		memset(&info.fw_version, 0, sizeof(info.fw_version));
-		strcpy (info.bus_info, pci_dev->slot_name);
+		strcpy (info.bus_info, pci_name(pci_dev));
 		info.eedump_len = 0;
 		info.regdump_len = 0;
 		if (copy_to_user (useraddr, &info, sizeof (info)))
@@ -1834,7 +1827,7 @@
 	iounmap((void *) bp->regs);
 
 err_out_free_dev:
-	kfree(dev);
+	free_netdev(dev);
 
 err_out_free_res:
 	pci_release_regions(pdev);
@@ -1852,7 +1845,7 @@
 	if (dev) {
 		unregister_netdev(dev);
 		iounmap((void *) ((struct b44 *)(dev->priv))->regs);
-		kfree(dev);
+		free_netdev(dev);
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
 		pci_set_drvdata(pdev, NULL);
--- linux-2.4.23-pre6/include/linux/pci_ids.h.orig	2003-10-03 20:30:14.000000000 +0300
+++ linux-2.4.23-pre6/include/linux/pci_ids.h	2003-10-03 19:41:01.000000000 +0300
@@ -1669,6 +1669,7 @@
 #define PCI_DEVICE_ID_TIGON3_5703A3	0x16c7
 #define PCI_DEVICE_ID_TIGON3_5901	0x170d
 #define PCI_DEVICE_ID_TIGON3_5901_2	0x170e
+#define PCI_DEVICE_ID_BCM4401		0x4401
 
 #define PCI_VENDOR_ID_SYBA		0x1592
 #define PCI_DEVICE_ID_SYBA_2P_EPP	0x0782
