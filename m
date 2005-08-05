Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVHEBGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVHEBGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVHEBGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:06:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:43751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262802AbVHEBGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:06:37 -0400
Date: Thu, 4 Aug 2005 18:06:10 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com
Subject: [patch 1/5] PCI: restore BAR values after D3hot->D0 for devices that need it
Message-ID: <20050805010610.GB19625@kroah.com>
References: <20050805010206.711658000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-restore-bar-values.patch"
In-Reply-To: <20050805010533.GA19625@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>

Some PCI devices (e.g. 3c905B, 3c556B) lose all configuration
(including BARs) when transitioning from D3hot->D0.  This leaves such
a device in an inaccessible state.  The patch below causes the BARs
to be restored when enabling such a device, so that its driver will
be able to access it.

The patch also adds pci_restore_bars as a new global symbol, and adds a
correpsonding EXPORT_SYMBOL_GPL for that.

Some firmware (e.g. Thinkpad T21) leaves devices in D3hot after a
(re)boot.  Most drivers call pci_enable_device very early, so devices
left in D3hot that lose configuration during the D3hot->D0 transition
will be inaccessible to their drivers.

Drivers could be modified to account for this, but it would
be difficult to know which drivers need modification.  This is
especially true since often many devices are covered by the same
driver.  It likely would be necessary to replicate code across dozens
of drivers.

The patch below should trigger only when transitioning from D3hot->D0
(or at boot), and only for devices that have the "no soft reset" bit
cleared in the PM control register.  I believe it is safe to include
this patch as part of the PCI infrastructure.

The cleanest implementation of pci_restore_bars was to call
pci_update_resource.  Unfortunately, that does not currently exist
for the sparc64 architecture.  The patch below includes a null
implemenation of pci_update_resource for sparc64.

Some have expressed interest in making general use of the the
pci_restore_bars function, so that has been exported to GPL licensed
modules.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/sparc64/kernel/pci.c |    6 ++++
 drivers/pci/pci.c         |   59 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/pci/setup-res.c   |    2 -
 include/linux/pci.h       |    3 ++
 4 files changed, 65 insertions(+), 5 deletions(-)

--- gregkh-2.6.orig/arch/sparc64/kernel/pci.c	2005-08-04 17:37:26.000000000 -0700
+++ gregkh-2.6/arch/sparc64/kernel/pci.c	2005-08-04 17:46:13.000000000 -0700
@@ -413,6 +413,12 @@
 	return -EBUSY;
 }
 
+void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
+{
+	/* Not implemented for sparc64... */
+	BUG();
+}
+
 int pci_assign_resource(struct pci_dev *pdev, int resource)
 {
 	struct pcidev_cookie *pcp = pdev->sysdata;
--- gregkh-2.6.orig/drivers/pci/pci.c	2005-08-04 17:37:26.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci.c	2005-08-04 17:46:13.000000000 -0700
@@ -222,6 +222,37 @@
 }
 
 /**
+ * pci_restore_bars - restore a devices BAR values (e.g. after wake-up)
+ * @dev: PCI device to have its BARs restored
+ *
+ * Restore the BAR values for a given device, so as to make it
+ * accessible by its driver.
+ */
+void
+pci_restore_bars(struct pci_dev *dev)
+{
+	int i, numres;
+
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+		numres = 6;
+		break;
+	case PCI_HEADER_TYPE_BRIDGE:
+		numres = 2;
+		break;
+	case PCI_HEADER_TYPE_CARDBUS:
+		numres = 1;
+		break;
+	default:
+		/* Should never get here, but just in case... */
+		return;
+	}
+
+	for (i = 0; i < numres; i ++)
+		pci_update_resource(dev, &dev->resource[i], i);
+}
+
+/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
@@ -239,7 +270,7 @@
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm;
+	int pm, need_restore = 0;
 	u16 pmcsr, pmc;
 
 	/* bound the state we're entering */
@@ -278,14 +309,17 @@
 			return -EIO;
 	}
 
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+
 	/* If we're in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
-	if (dev->current_state >= PCI_D3hot)
+	if (dev->current_state >= PCI_D3hot) {
+		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
+			need_restore = 1;
 		pmcsr = 0;
-	else {
-		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	} else {
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
 	}
@@ -308,6 +342,22 @@
 		platform_pci_set_power_state(dev, state);
 
 	dev->current_state = state;
+
+	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
+	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
+	 * from D3hot to D0 _may_ perform an internal reset, thereby
+	 * going to "D0 Uninitialized" rather than "D0 Initialized".
+	 * For example, at least some versions of the 3c905B and the
+	 * 3c556B exhibit this behaviour.
+	 *
+	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
+	 * devices in a D3hot state at boot.  Consequently, we need to
+	 * restore at least the BARs so that the device will be
+	 * accessible to its driver.
+	 */
+	if (need_restore)
+		pci_restore_bars(dev);
+
 	return 0;
 }
 
@@ -805,6 +855,7 @@
 EXPORT_SYMBOL(isa_bridge);
 #endif
 
+EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
--- gregkh-2.6.orig/drivers/pci/setup-res.c	2005-08-04 17:37:26.000000000 -0700
+++ gregkh-2.6/drivers/pci/setup-res.c	2005-08-04 17:46:13.000000000 -0700
@@ -26,7 +26,7 @@
 #include "pci.h"
 
 
-static void
+void
 pci_update_resource(struct pci_dev *dev, struct resource *res, int resno)
 {
 	struct pci_bus_region region;
--- gregkh-2.6.orig/include/linux/pci.h	2005-08-04 17:37:27.000000000 -0700
+++ gregkh-2.6/include/linux/pci.h	2005-08-04 17:46:13.000000000 -0700
@@ -225,6 +225,7 @@
 #define  PCI_PM_CAP_PME_D3cold  0x8000  /* PME# from D3 (cold) */
 #define PCI_PM_CTRL		4	/* PM control and status register */
 #define  PCI_PM_CTRL_STATE_MASK	0x0003	/* Current power state (D0 to D3) */
+#define  PCI_PM_CTRL_NO_SOFT_RESET	0x0004	/* No reset for D3hot->D0 */
 #define  PCI_PM_CTRL_PME_ENABLE	0x0100	/* PME pin enable */
 #define  PCI_PM_CTRL_DATA_SEL_MASK	0x1e00	/* Data select (??) */
 #define  PCI_PM_CTRL_DATA_SCALE_MASK	0x6000	/* Data scale (??) */
@@ -816,7 +817,9 @@
 void pci_clear_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
+void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int pci_assign_resource(struct pci_dev *dev, int i);
+void pci_restore_bars(struct pci_dev *dev);
 
 /* ROM control related routines */
 void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size);

--
