Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422956AbWHZAEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422956AbWHZAEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422946AbWHZADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:03:12 -0400
Received: from mga05.intel.com ([192.55.52.89]:30870 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422933AbWHZADK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:10 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="121404938:sNHT130511682"
Message-Id: <20060826000304.251263000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:35 -0700
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
 drivers/net/tulip/winbond-840.c |   10 +++++++---
 3 files changed, 21 insertions(+), 10 deletions(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
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
--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/winbond-840.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/winbond-840.c
@@ -1626,14 +1626,18 @@ static int w840_resume (struct pci_dev *
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
+	int retval;
 
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
+			return retval;
+		}
 		spin_lock_irq(&np->lock);
 		iowrite32(1, np->base_addr+PCIBusCfg);
 		ioread32(np->base_addr+PCIBusCfg);
--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/de2104x.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/de2104x.c
@@ -2138,17 +2138,21 @@ static int de_resume (struct pci_dev *pd
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct de_private *de = dev->priv;
+	int retval;
 
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
+		return retval;
 	}
+	de_init_hw(de);
+out_attach:
+	netif_device_attach(dev);
 out:
 	rtnl_unlock();
 	return 0;

--
