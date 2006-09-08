Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWIHSWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWIHSWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWIHSUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:20:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:34893 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751136AbWIHSUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:20:34 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="123415642:sNHT27595484"
Message-Id: <20060908182024.372546000@linux.intel.com>
References: <20060908181533.771856000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 08 Sep 2006 11:15:41 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valerie Henson <val_henson@linux.intel.com>, Jeff Garzik <jeff@garzik.org>
Subject: [patch 08/10] [TULIP] Handle pci_enable_device() errors in resume
Content-Disposition: inline; filename=tulip-handle-pci_enable_device-errors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/de2104x.c     |   16 ++++++++++------
 drivers/net/tulip/tulip_core.c  |    5 ++++-
 drivers/net/tulip/winbond-840.c |   12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

--- linux-2.6.18-rc4-mm1-tulip.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1-tulip/drivers/net/tulip/tulip_core.c
@@ -1780,7 +1780,10 @@ static int tulip_resume(struct pci_dev *
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
-	pci_enable_device(pdev);
+	if ((retval = pci_enable_device(pdev))) {
+		printk (KERN_ERR "tulip: pci_enable_device failed in resume\n");
+		return retval;
+	}
 
 	if ((retval = request_irq(dev->irq, &tulip_interrupt, IRQF_SHARED, dev->name, dev))) {
 		printk (KERN_ERR "tulip: request_irq failed in resume\n");
--- linux-2.6.18-rc4-mm1-tulip.orig/drivers/net/tulip/winbond-840.c
+++ linux-2.6.18-rc4-mm1-tulip/drivers/net/tulip/winbond-840.c
@@ -1626,14 +1626,18 @@ static int w840_resume (struct pci_dev *
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
+	int retval = 0;
 
 	rtnl_lock();
 	if (netif_device_present(dev))
 		goto out; /* device not suspended */
 	if (netif_running(dev)) {
-		pci_enable_device(pdev);
-	/*	pci_power_on(pdev); */
-
+		if ((retval = pci_enable_device(pdev))) {
+			printk (KERN_ERR
+				"%s: pci_enable_device failed in resume\n",
+				dev->name);
+			goto out;
+		}
 		spin_lock_irq(&np->lock);
 		iowrite32(1, np->base_addr+PCIBusCfg);
 		ioread32(np->base_addr+PCIBusCfg);
@@ -1651,7 +1655,7 @@ static int w840_resume (struct pci_dev *
 	}
 out:
 	rtnl_unlock();
-	return 0;
+	return retval;
 }
 #endif
 
--- linux-2.6.18-rc4-mm1-tulip.orig/drivers/net/tulip/de2104x.c
+++ linux-2.6.18-rc4-mm1-tulip/drivers/net/tulip/de2104x.c
@@ -2138,17 +2138,21 @@ static int de_resume (struct pci_dev *pd
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct de_private *de = dev->priv;
+	int retval = 0;
 
 	rtnl_lock();
 	if (netif_device_present(dev))
 		goto out;
-	if (netif_running(dev)) {
-		pci_enable_device(pdev);
-		de_init_hw(de);
-		netif_device_attach(dev);
-	} else {
-		netif_device_attach(dev);
+	if (!netif_running(dev))
+		goto out_attach;
+	if ((retval = pci_enable_device(pdev))) {
+		printk (KERN_ERR "%s: pci_enable_device failed in resume\n",
+			dev->name);
+		goto out;
 	}
+	de_init_hw(de);
+out_attach:
+	netif_device_attach(dev);
 out:
 	rtnl_unlock();
 	return 0;

--
