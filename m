Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVGNAtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVGNAtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGNAqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:46:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55467 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262319AbVGNAqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:46:06 -0400
Date: Thu, 14 Jul 2005 02:45:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 04/04] fix pm_message_t stuff in -mm tree
Message-ID: <20050714004553.GD7836@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should bits from -mm tree that are affected by pm_message_t
conversion. [I'm not 100% sure I got all of them, but I certainly got
all the errors on make allyesconfig build, and most of warnings,
too. I'll go through the buildlog tommorow and fix any remaining
bits].

--- clean-mm/drivers/net/wireless/hostap/hostap_pci.c	2005-07-14 01:17:53.000000000 +0200
+++ linux-mm/drivers/net/wireless/hostap/hostap_pci.c	2005-07-14 02:11:57.000000000 +0200
@@ -385,7 +385,7 @@
 
 
 #ifdef CONFIG_PM
-static int prism2_pci_suspend(struct pci_dev *pdev, u32 state)
+static int prism2_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -396,7 +396,7 @@
 	prism2_suspend(dev);
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, 3);
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
 }
--- clean-mm/drivers/net/wireless/ipw2200.c	2005-07-14 01:17:53.000000000 +0200
+++ linux-mm/drivers/net/wireless/ipw2200.c	2005-07-14 02:11:14.000000000 +0200
@@ -7229,7 +7229,7 @@
 
 
 #ifdef CONFIG_PM
-static int ipw_pci_suspend(struct pci_dev *pdev, u32 state)
+static int ipw_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct ipw_priv *priv = pci_get_drvdata(pdev);
 	struct net_device *dev = priv->net_dev;
@@ -7248,7 +7248,7 @@
 	pci_save_state(pdev);
 #endif
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	
 	return 0;
 }
--- clean-mm/drivers/perfctr/x86.c	2005-07-14 01:17:53.000000000 +0200
+++ linux-mm/drivers/perfctr/x86.c	2005-07-14 02:17:39.000000000 +0200
@@ -1640,7 +1640,7 @@
 
 #include <linux/sysdev.h>
 
-static int perfctr_device_suspend(struct sys_device *dev, u32 state)
+static int perfctr_device_suspend(struct sys_device *dev, pm_message_t state)
 {
 	perfctr_pm_suspend();
 	return 0;

-- 
teflon -- maybe it is a trademark, but it should not be.
