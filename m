Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVKPDYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVKPDYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbVKPDWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:22:55 -0500
Received: from peabody.ximian.com ([130.57.169.10]:5848 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965209AbVKPDWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:22:39 -0500
Subject: [RFC][PATCH 4/6] PCI PM: update pci_enable_wake()
From: Adam Belay <abelay@novell.com>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Nov 2005 22:31:25 -0500
Message-Id: <1132111885.9809.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates pci_enable_wake() to use "struct pci_dev_pm".


--- a/drivers/pci/pm.c	2005-11-07 08:18:18.000000000 -0500
+++ b/drivers/pci/pm.c	2005-11-07 08:17:21.000000000 -0500
@@ -247,28 +247,19 @@
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
-	int pm;
 	u16 value;
-
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	struct pci_dev_pm *data = dev->pm;
 
 	/* If device doesn't support PM Capabilities, but request is to disable
 	 * wake events, it's a nop; otherwise fail */
-	if (!pm) 
+	if (!data) 
 		return enable ? -EIO : 0; 
 
-	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
-
-	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
-
 	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) 
+	if (!data->pme_mask || !(data->pme_mask & (1 << state)))
 		return enable ? -EINVAL : 0;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
+	pci_read_config_word(dev, data->pm_offset + PCI_PM_CTRL, &value);
 
 	/* Clear PME_Status by writing 1 to it and enable PME# */
 	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
@@ -276,7 +267,7 @@
 	if (!enable)
 		value &= ~PCI_PM_CTRL_PME_ENABLE;
 
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
+	pci_write_config_word(dev, data->pm_offset + PCI_PM_CTRL, value);
 	
 	return 0;
 }


