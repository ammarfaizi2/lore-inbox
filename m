Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbVKPDXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbVKPDXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVKPDW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:22:56 -0500
Received: from peabody.ximian.com ([130.57.169.10]:4568 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965208AbVKPDWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:22:36 -0500
Subject: [RFC][PATCH 3/6] PCI PM: update pci_set_power_state()
From: Adam Belay <abelay@novell.com>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Nov 2005 22:31:22 -0500
Message-Id: <1132111882.9809.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates pci_set_power_state() to use "struct pci_dev_pm".


--- a/drivers/pci/pm.c	2005-11-07 08:14:49.000000000 -0500
+++ b/drivers/pci/pm.c	2005-11-07 08:13:33.000000000 -0500
@@ -100,44 +100,32 @@
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm, need_restore = 0;
-	u16 pmcsr, pmc;
+	int need_restore = 0;
+	struct pci_dev_pm *data = dev->pm;
+	u16 pmcsr;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3hot)
 		state = PCI_D3hot;
 
+	if (dev->current_state == state) 
+		return 0;
+
+	if (!data)
+		return -EIO;
+
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
 	 */
 	if (state != PCI_D0 && dev->current_state > state)
 		return -EINVAL;
-	else if (dev->current_state == state) 
-		return 0;        /* we're already there */
-
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	
-	/* abort if the device doesn't support PM capabilities */
-	if (!pm)
-		return -EIO; 
-
-	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
-	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
-		printk(KERN_DEBUG
-		       "PCI: %s has unsupported PM cap regs version (%u)\n",
-		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
-		return -EIO;
-	}
 
 	/* check if this device supports the desired state */
-	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
-		return -EIO;
-	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+	if (!(dev->pm->state_mask & (1 << state)))
 		return -EIO;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	pci_read_config_word(dev, data->pm_offset + PCI_PM_CTRL, &pmcsr);
 
 	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
@@ -161,7 +149,7 @@
 	}
 
 	/* enter specified state */
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+	pci_write_config_word(dev, data->pm_offset + PCI_PM_CTRL, pmcsr);
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */


