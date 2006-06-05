Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750791AbWFEIg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFEIg2 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWFEIgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:36:11 -0400
Received: from peabody.ximian.com ([130.57.169.10]:26510 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750783AbWFEIgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:36:03 -0400
Subject: [PATCH  6/9] PCI PM: call platform helpers properly
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:46:11 -0400
Message-Id: <1149497171.7831.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make much sense to call platform helpers (e.g. ACPI) after
the PCI power state has been set when returning to D0.  This patch
ensures that platform helpers and PCI PM registers are called in the
correct order.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 pm.c |   68 +++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	2006-06-04 02:17:48.000000000 -0400
+++ b/drivers/pci/pm.c	2006-06-04 02:09:53.000000000 -0400
@@ -111,6 +111,36 @@
 
 int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
 
+static void __pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	struct pci_dev_pm *pm = dev->pm;
+	u16 pmcsr;
+
+	pci_read_config_word(dev, pm->pm_offset + PCI_PM_CTRL, &pmcsr);
+
+	/* If we're (effectively) in D3, force entire word to 0.
+	 * This doesn't affect PME_Status, disables PME_En, and
+	 * sets PowerState to 0.
+	 */
+	if (dev->current_state == PCI_D3) {
+		pmcsr = 0;
+	} else {
+		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+		pmcsr |= state;
+	}
+
+	/* enter specified state */
+	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, pmcsr);
+
+	/* Mandatory power management transition delays */
+	/* see PCI PM 1.1 5.6.1 table 18 */
+	if (state == PCI_D3 || dev->current_state == PCI_D3)
+		msleep(10);
+	else if (state == PCI_D2 || dev->current_state == PCI_D2)
+		udelay(200);
+
+}
+
 /**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
@@ -127,7 +157,6 @@
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	u16 pmcsr;
 	struct pci_dev_pm *pm = dev->pm;
 
 	if (!pm)
@@ -150,39 +179,14 @@
 	else if (state == PCI_D2 && !pm->D2_supported)
 		return -EIO;
 
-	pci_read_config_word(dev, pm->pm_offset + PCI_PM_CTRL, &pmcsr);
-
-	/* If we're (effectively) in D3, force entire word to 0.
-	 * This doesn't affect PME_Status, disables PME_En, and
-	 * sets PowerState to 0.
-	 */
-	switch (dev->current_state) {
-	case PCI_D0:
-	case PCI_D1:
-	case PCI_D2:
-		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-		pmcsr |= state;
-		break;
-	default:
-		pmcsr = 0;
-		break;
-	}
-
-	/* enter specified state */
-	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, pmcsr);
+	/* call platform helpers (e.g. ACPI) before restoring power */
+	if (state == PCI_D0 && platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
 
-	/* Mandatory power management transition delays */
-	/* see PCI PM 1.1 5.6.1 table 18 */
-	if (state == PCI_D3 || dev->current_state == PCI_D3)
-		msleep(10);
-	else if (state == PCI_D2 || dev->current_state == PCI_D2)
-		udelay(200);
+	__pci_set_power_state(dev, state);
 
-	/*
-	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
-	 * Firmware method after natice method ?
-	 */
-	if (platform_pci_set_power_state)
+	/* otherwise, call platform helpers after removing power */
+	if (state != PCI_D0 && platform_pci_set_power_state)
 		platform_pci_set_power_state(dev, state);
 
 	dev->current_state = state;


