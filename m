Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUJDVfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUJDVfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUJDVeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:34:22 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:31435 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268641AbUJDVcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:32:09 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: PATCH/RFC: pci wakeup hooks (2/4)
Date: Mon, 4 Oct 2004 14:03:00 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410041403.00219.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UwbYB3J14qpqdeC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_UwbYB3J14qpqdeC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This adds minimal PCI hooks.  Maybe they should be more minimal.





--Boundary-00=_UwbYB3J14qpqdeC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="wake-pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wake-pci.patch"

This makes PCI use the new pmcore wakeup bits.

 - Initialized in pci_enable_device()
 - Disabled in pci_disable_device()
 - Lets userspace change the initial may_wakeup policy.

Previously, wakeup policies were driver-specific (other than ethtool).
This patch lets all drivers outsource such decisions.

NOTE:  the init could presumably be done in probe() and never changed,
except maybe when ACPI and PCI disagree.  But since I (mis?)remember
hearing about devices that choke on capability accesses during probe(),
it's done this way instead.

ALSO:  I think some boards can support system wakeup using signals other
then PME# ... handling wakeup without PCI PM.  Presumably board-specific
logic (ACPI bytecodes?) would kick in to mark the devices appropriately;
playing well with such logic might mean never clearing can_wakeup.

[ against 2.6.9-rc3 ]


--- 1.70/drivers/pci/pci.c	Wed Aug  4 18:20:19 2004
+++ edited/drivers/pci/pci.c	Mon Oct  4 12:42:04 2004
@@ -382,6 +382,16 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
+#ifdef	CONFIG_PM
+	/* with PCI PM capability, it can maybe issue PME# */
+	u16 pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	device_init_wakeup(&dev->dev, 0);
+	if (pm) {
+		pci_read_config_word(dev, pm + PCI_PM_PMC, &pm);
+		if (pm & PCI_PM_CAP_PME)
+			device_init_wakeup(&dev->dev, 1);
+	}
+#endif
 	dev->is_enabled = 1;
 	return pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
 }
@@ -400,6 +410,7 @@
 	
 	dev->is_enabled = 0;
 	dev->is_busmaster = 0;
+	device_init_wakeup(&dev->dev, 0);
 
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
@@ -434,6 +445,10 @@
 	 * wake events, it's a nop; otherwise fail */
 	if (!pm) 
 		return enable ? -EIO : 0; 
+
+	/* don't enable unless driver core lets us */
+	if (!device_may_wakeup(&dev->dev) && enable)
+		return -EROFS;
 
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);

--Boundary-00=_UwbYB3J14qpqdeC--
