Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVGHBAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVGHBAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 21:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVGHBAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 21:00:47 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:27145 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262398AbVGHBAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 21:00:00 -0400
Date: Thu, 7 Jul 2005 20:59:37 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: [patch 2.6.13-rc2] pci: restore BAR values in pci_set_power_state for D3hot->D0
Message-ID: <20050708005934.GB13384@tuxdriver.com>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	linux-pm <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>, Adam Belay <ambx1@neo.rr.com>
References: <20050624022807.GF28077@tuxdriver.com> <20050630171010.GD11369@kroah.com> <20050701014056.GA13710@tuxdriver.com> <20050701022634.GA5629.1@tuxdriver.com> <20050702072954.GA14091@colo.lackof.org> <20050702090913.B1506@flint.arm.linux.org.uk> <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk> <20050705224620.B15292@flint.arm.linux.org.uk> <20050706033454.A706@den.park.msu.ru> <20050708005701.GA13384@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708005701.GA13384@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some PCI devices lose all configuration (including BARs) when
transitioning from D3hot->D0.  This leaves such a device in an
inaccessible state.  The patch below causes the BARs to be restored
when enabling such a device, so that its driver will be able to
access it.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Some firmware leaves devices in D3hot after a (re)boot.  Most drivers
call pci_enable_device very early, so devices left in D3hot that lose
configuration during the D3hot->D0 transition will be inaccessible to
their drivers.

Drivers could be modified to account for this, but it would
be difficult to know which drivers need modification.  This is
especially true since often many devices are covered by the same
driver.  It likely would be necessary to replicate code across dozens
of drivers.

The patch below should trigger only when transitioning from D3hot->D0
(or at boot), and only for devices that have the "no soft reset" bit
cleared in the PM control register.  I believe it is safe to include as
part of the PCI infrastructure.

 drivers/pci/pci.c   |   74 +++++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h |    1 
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -222,6 +222,59 @@ pci_find_parent_resource(const struct pc
 }
 
 /**
+ * pci_restore_bars - restore a devices BAR values (e.g. after wake-up)
+ * @dev: PCI device to have its BARs restored
+ *
+ * Restore the BAR values for a given device, so as to make it
+ * accessible by its driver.
+ */
+static void
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
+	for (i = 0; i < numres; i ++) {
+		struct pci_bus_region region;
+		u32 val;
+		int reg;
+
+		if (!dev->resource[i].flags)
+			continue;
+
+		pcibios_resource_to_bus(dev, &region, &dev->resource[i]);
+
+		val = region.start
+		    | (dev->resource[i].flags & PCI_REGION_FLAG_MASK);
+
+		reg = PCI_BASE_ADDRESS_0 + (i * 4);
+
+		pci_write_config_dword(dev, reg, val);
+
+		if ((val & (PCI_BASE_ADDRESS_SPACE
+		          | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
+		 == (PCI_BASE_ADDRESS_SPACE_MEMORY
+		   | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+			pci_write_config_dword(dev, reg + 4, 0);
+		}
+	}
+}
+
+/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
@@ -239,7 +292,7 @@ pci_find_parent_resource(const struct pc
 int
 pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int pm;
+	int pm, need_restore = 0;
 	u16 pmcsr, pmc;
 
 	/* bound the state we're entering */
@@ -278,14 +331,17 @@ pci_set_power_state(struct pci_dev *dev,
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
@@ -301,6 +357,16 @@ pci_set_power_state(struct pci_dev *dev,
 		udelay(200);
 	dev->current_state = state;
 
+	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
+	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
+	 * from D3hot to D0 _may_ perform an internal reset, thereby
+	 * going to "D0 Uninitialized" rather than "D0 Initialized".
+	 * In that case, we need to restore at least the BARs so that
+	 * the device will be accessible to its driver.
+	 */
+	if (need_restore)
+		pci_restore_bars(dev);
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -225,6 +225,7 @@
 #define  PCI_PM_CAP_PME_D3cold  0x8000  /* PME# from D3 (cold) */
 #define PCI_PM_CTRL		4	/* PM control and status register */
 #define  PCI_PM_CTRL_STATE_MASK	0x0003	/* Current power state (D0 to D3) */
+#define  PCI_PM_CTRL_NO_SOFT_RESET	0x0004	/* No reset for D3hot->D0 */
 #define  PCI_PM_CTRL_PME_ENABLE	0x0100	/* PME pin enable */
 #define  PCI_PM_CTRL_DATA_SEL_MASK	0x1e00	/* Data select (??) */
 #define  PCI_PM_CTRL_DATA_SCALE_MASK	0x6000	/* Data scale (??) */
-- 
John W. Linville
linville@tuxdriver.com
