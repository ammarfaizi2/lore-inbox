Return-Path: <linux-kernel-owner+willy=40w.ods.org-S377939AbUKAWkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S377939AbUKAWkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277561AbUKAWkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:40:02 -0500
Received: from gprs214-251.eurotel.cz ([160.218.214.251]:28802 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S278838AbUKAU1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:27:04 -0500
Date: Mon, 1 Nov 2004 21:26:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Adapt drivers to type-safe pci
Message-ID: <20041101202640.GA24855@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adapts few drivers to type-safe pci powermanagment. I introduced
device_to_pci_state helper that will be usefull to few drivers... Does
it look okay? If so, Patrick, please apply.

[device_to_pci_power will have to change in near future. Still that's
better than changing 30 drivers.] 
								Pavel

--- linux.middle/drivers/media/video/bttv-driver.c	2004-10-19 14:38:02.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-11-01 21:25:09.000000000 +0100
@@ -3945,7 +3945,7 @@
 
 	/* save pci state */
 	pci_save_state(pci_dev, btv->state.pci_cfg);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, device_to_pci_power(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
 	}
@@ -3964,7 +3964,7 @@
 		pci_enable_device(pci_dev);
 		btv->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev, btv->state.pci_cfg);
 
 	/* restore bt878 state */
--- linux.middle/drivers/net/8139too.c	2004-10-19 14:38:06.000000000 +0200
+++ linux/drivers/net/8139too.c	2004-11-01 20:41:29.000000000 +0100
@@ -2608,7 +2608,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -2622,7 +2622,7 @@
 	pci_restore_state (pdev, tp->pci_state);
 	if (!netif_running (dev))
 		return 0;
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	netif_device_attach (dev);
--- linux.middle/drivers/net/via-rhine.c	2004-10-21 12:32:56.000000000 +0200
+++ linux/drivers/net/via-rhine.c	2004-11-01 20:35:30.000000000 +0100
@@ -1974,7 +1974,7 @@
         if (request_irq(dev->irq, rhine_interrupt, SA_SHIRQ, dev->name, dev))
 		printk(KERN_ERR "via-rhine %s: request_irq failed\n", dev->name);
 
-	ret = pci_set_power_state(pdev, 0);
+	ret = pci_set_power_state(pdev, PCI_D0);
 	if (debug > 1)
 		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",
 			dev->name, ret ? "failed" : "succeeded", ret);
--- linux.middle/include/linux/pci.h	2004-10-25 23:25:41.000000000 +0200
+++ linux/include/linux/pci.h	2004-11-01 21:24:17.000000000 +0100
@@ -488,6 +488,16 @@
 #define PCI_D3hot	((pci_power_t __force) 3)
 #define PCI_D3cold	((pci_power_t __force) 4)
 
+static inline pci_power_t device_to_pci_power(struct pci_dev *dev, u32 state)
+{
+	switch (state) {
+	case 0:	return PCI_D0;
+	case 2: return PCI_D2;
+	case 3: return PCI_D3hot;
+	default: BUG();
+	}
+}
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
