Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750760AbWFEIfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWFEIfA (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWFEIfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:35:00 -0400
Received: from peabody.ximian.com ([130.57.169.10]:21902 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750760AbWFEIe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:34:59 -0400
Subject: [PATCH 3/9] PCI PM: update functions to use generic detection
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:45:52 -0400
Message-Id: <1149497153.7831.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than accessing PCI configuration space and verifying power
management capabilities every time, each power management related
function can now utilize the generic infrastructure.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 pm.c |   54 +++++++++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	2006-06-01 22:35:10.000000000 -0400
+++ b/drivers/pci/pm.c	2006-06-01 22:37:16.000000000 -0400
@@ -110,8 +110,12 @@
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm, need_restore = 0;
-	u16 pmcsr, pmc;
+	int need_restore = 0;
+	u16 pmcsr;
+	struct pci_dev_pm *pm = dev->pm;
+
+	if (!pm)
+		return -EIO;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3hot)
@@ -128,28 +132,13 @@
 	} else if (dev->current_state == state)
 		return 0;        /* we're already there */
 
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
-
 	/* check if this device supports the desired state */
-	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
+	if (state == PCI_D1 && !pm->D1_supported)
 		return -EIO;
-	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+	else if (state == PCI_D2 && !pm->D2_supported)
 		return -EIO;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	pci_read_config_word(dev, pm->pm_offset + PCI_PM_CTRL, &pmcsr);
 
 	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
@@ -173,7 +162,7 @@
 	}
 
 	/* enter specified state */
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, pmcsr);
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
@@ -227,7 +216,7 @@
 {
 	int ret;
 
-	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+	if (!dev->pm)
 		return PCI_D0;
 
 	if (platform_pci_choose_state) {
@@ -272,28 +261,19 @@
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
-	int pm;
 	u16 value;
-
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	struct pci_dev_pm *pm = dev->pm;
 
 	/* If device doesn't support PM Capabilities, but request is to disable
 	 * wake events, it's a nop; otherwise fail */
-	if (!pm) 
-		return enable ? -EIO : 0; 
-
-	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
-
-	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
+	if (!pm)
+		return enable ? -EIO : 0;
 
 	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) 
+	if (!pm->pme_mask || !(pm->pme_mask & (1 << state)))
 		return enable ? -EINVAL : 0;
 
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
+	pci_read_config_word(dev, pm->pm_offset + PCI_PM_CTRL, &value);
 
 	/* Clear PME_Status by writing 1 to it and enable PME# */
 	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
@@ -301,7 +281,7 @@
 	if (!enable)
 		value &= ~PCI_PM_CTRL_PME_ENABLE;
 
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
+	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, value);
 	
 	return 0;
 }



