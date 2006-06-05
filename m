Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750765AbWFEIeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFEIeX (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWFEIeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:34:23 -0400
Received: from peabody.ximian.com ([130.57.169.10]:18830 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750769AbWFEIeW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:34:22 -0400
Subject: [PATCH 1/9]  PCI  PM: reorganize power management code
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:45:45 -0400
Message-Id: <1149497145.7831.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves all existing PCI power management functions to a new
file: drivers/pci/pm.c.  Although there may be some stylistic changes,
all code is functionally equivalent to the original version.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 Makefile |    2
 pci.c    |  279 --------------------------------------------------------
 pm.c     |  309 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 280 deletions(-)

diff -urN a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2006-03-20 00:53:29.000000000 -0500
+++ b/drivers/pci/Makefile	2006-05-31 17:21:40.000000000 -0400
@@ -2,7 +2,7 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
+obj-y		+= access.o bus.o probe.o remove.o pci.o pm.o quirks.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -urN a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2006-05-30 21:41:14.000000000 -0400
+++ b/drivers/pci/pci.c	2006-05-31 17:11:59.000000000 -0400
@@ -247,229 +247,6 @@
 }
 
 /**
- * pci_restore_bars - restore a devices BAR values (e.g. after wake-up)
- * @dev: PCI device to have its BARs restored
- *
- * Restore the BAR values for a given device, so as to make it
- * accessible by its driver.
- */
-void
-pci_restore_bars(struct pci_dev *dev)
-{
-	int i, numres;
-
-	switch (dev->hdr_type) {
-	case PCI_HEADER_TYPE_NORMAL:
-		numres = 6;
-		break;
-	case PCI_HEADER_TYPE_BRIDGE:
-		numres = 2;
-		break;
-	case PCI_HEADER_TYPE_CARDBUS:
-		numres = 1;
-		break;
-	default:
-		/* Should never get here, but just in case... */
-		return;
-	}
-
-	for (i = 0; i < numres; i ++)
-		pci_update_resource(dev, &dev->resource[i], i);
-}
-
-int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
-
-/**
- * pci_set_power_state - Set the power state of a PCI device
- * @dev: PCI device to be suspended
- * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
- *
- * Transition a device to a new power state, using the Power Management 
- * Capabilities in the device's config space.
- *
- * RETURN VALUE: 
- * -EINVAL if trying to enter a lower state than we're already in.
- * 0 if we're already in the requested state.
- * -EIO if device does not support PCI PM.
- * 0 if we can successfully change the power state.
- */
-int
-pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-{
-	int pm, need_restore = 0;
-	u16 pmcsr, pmc;
-
-	/* bound the state we're entering */
-	if (state > PCI_D3hot)
-		state = PCI_D3hot;
-
-	/* Validate current state:
-	 * Can enter D0 from any state, but if we can only go deeper 
-	 * to sleep if we're already in a low power state
-	 */
-	if (state != PCI_D0 && dev->current_state > state) {
-		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
-			__FUNCTION__, pci_name(dev), state, dev->current_state);
-		return -EINVAL;
-	} else if (dev->current_state == state)
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
-
-	/* check if this device supports the desired state */
-	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
-		return -EIO;
-	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
-		return -EIO;
-
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
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
-	case PCI_UNKNOWN: /* Boot-up */
-		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
-		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = 1;
-		/* Fall-through: force to D0 */
-	default:
-		pmcsr = 0;
-		break;
-	}
-
-	/* enter specified state */
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
-
-	/* Mandatory power management transition delays */
-	/* see PCI PM 1.1 5.6.1 table 18 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
-		msleep(10);
-	else if (state == PCI_D2 || dev->current_state == PCI_D2)
-		udelay(200);
-
-	/*
-	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
-	 * Firmware method after natice method ?
-	 */
-	if (platform_pci_set_power_state)
-		platform_pci_set_power_state(dev, state);
-
-	dev->current_state = state;
-
-	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
-	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
-	 * from D3hot to D0 _may_ perform an internal reset, thereby
-	 * going to "D0 Uninitialized" rather than "D0 Initialized".
-	 * For example, at least some versions of the 3c905B and the
-	 * 3c556B exhibit this behaviour.
-	 *
-	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
-	 * devices in a D3hot state at boot.  Consequently, we need to
-	 * restore at least the BARs so that the device will be
-	 * accessible to its driver.
-	 */
-	if (need_restore)
-		pci_restore_bars(dev);
-
-	return 0;
-}
-
-int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
- 
-/**
- * pci_choose_state - Choose the power state of a PCI device
- * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system. This is the value
- *	that is passed to suspend() function.
- *
- * Returns PCI power state suitable for given device and given system
- * message.
- */
-
-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
-{
-	int ret;
-
-	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
-		return PCI_D0;
-
-	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
-		if (ret >= 0)
-			state.event = ret;
-	}
-
-	switch (state.event) {
-	case PM_EVENT_ON:
-		return PCI_D0;
-	case PM_EVENT_FREEZE:
-	case PM_EVENT_SUSPEND:
-		return PCI_D3hot;
-	default:
-		printk("They asked me for state %d\n", state.event);
-		BUG();
-	}
-	return PCI_D0;
-}
-
-EXPORT_SYMBOL(pci_choose_state);
-
-/**
- * pci_save_state - save the PCI configuration space of a device before suspending
- * @dev: - PCI device that we're dealing with
- */
-int
-pci_save_state(struct pci_dev *dev)
-{
-	int i;
-	/* XXX: 100% dword access ok here? */
-	for (i = 0; i < 16; i++)
-		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
-	if ((i = pci_save_msi_state(dev)) != 0)
-		return i;
-	if ((i = pci_save_msix_state(dev)) != 0)
-		return i;
-	return 0;
-}
-
-/** 
- * pci_restore_state - Restore the saved state of a PCI device
- * @dev: - PCI device that we're dealing with
- */
-int 
-pci_restore_state(struct pci_dev *dev)
-{
-	int i;
-
-	for (i = 0; i < 16; i++)
-		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
-	pci_restore_msi_state(dev);
-	pci_restore_msix_state(dev);
-	return 0;
-}
-
-/**
  * pci_enable_device_bars - Initialize some of a device for use
  * @dev: PCI device to be initialized
  * @bars: bitmask of BAR's that must be configured
@@ -545,56 +322,6 @@
 	dev->is_enabled = 0;
 }
 
-/**
- * pci_enable_wake - enable device to generate PME# when suspended
- * @dev: - PCI device to operate on
- * @state: - Current state of device.
- * @enable: - Flag to enable or disable generation
- * 
- * Set the bits in the device's PM Capabilities to generate PME# when
- * the system is suspended. 
- *
- * -EIO is returned if device doesn't have PM Capabilities. 
- * -EINVAL is returned if device supports it, but can't generate wake events.
- * 0 if operation is successful.
- * 
- */
-int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
-{
-	int pm;
-	u16 value;
-
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-
-	/* If device doesn't support PM Capabilities, but request is to disable
-	 * wake events, it's a nop; otherwise fail */
-	if (!pm) 
-		return enable ? -EIO : 0; 
-
-	/* Check device's ability to generate PME# */
-	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
-
-	value &= PCI_PM_CAP_PME_MASK;
-	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
-
-	/* Check if it can generate PME# from requested state. */
-	if (!value || !(value & (1 << state))) 
-		return enable ? -EINVAL : 0;
-
-	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
-
-	/* Clear PME_Status by writing 1 to it and enable PME# */
-	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
-
-	if (!enable)
-		value &= ~PCI_PM_CTRL_PME_ENABLE;
-
-	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
-	
-	return 0;
-}
-
 int
 pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
 {
@@ -930,7 +657,6 @@
 EXPORT_SYMBOL(isa_bridge);
 #endif
 
-EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
@@ -949,11 +675,6 @@
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
 
-EXPORT_SYMBOL(pci_set_power_state);
-EXPORT_SYMBOL(pci_save_state);
-EXPORT_SYMBOL(pci_restore_state);
-EXPORT_SYMBOL(pci_enable_wake);
-
 /* Quirk info */
 
 EXPORT_SYMBOL(isa_dma_bridge_buggy);
diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/pci/pm.c	2006-05-31 17:27:18.000000000 -0400
@@ -0,0 +1,309 @@
+/*
+ * pm.c - PCI Device Power Management
+ *
+ * This code was derived from drivers/pci/pci.c,
+ *
+ * Copyright 1993 - 1997 Drew Eckhardt, Frederic Potter, David Mosberger-Tang
+ * Copyright 1997 - 2000 Martin Mares <mj@ucw.cz>
+ * Copyright 2005 - 2006 Adam Belay <abelay@novell.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+
+
+/*
+ * Saving and Restoring Device Context
+ */
+
+/**
+ * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
+ * @dev: PCI device to have its BARs restored
+ *
+ * Restore the BAR values for a given device, so as to make it
+ * accessible by its driver.
+ */
+void pci_restore_bars(struct pci_dev *dev)
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
+EXPORT_SYMBOL_GPL(pci_restore_bars);
+
+/**
+ * pci_save_state - save the PCI configuration space of a device
+ * @dev: PCI device from which to save context
+ */
+int pci_save_state(struct pci_dev *dev)
+{
+	int i;
+	/* XXX: 100% dword access ok here? */
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
+	if ((i = pci_save_msi_state(dev)) != 0)
+		return i;
+	if ((i = pci_save_msix_state(dev)) != 0)
+		return i;
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_save_state);
+
+/**
+ * pci_restore_state - restore the saved PCI configuration space of a device
+ * @dev: PCI device for which to restore context
+ */
+int pci_restore_state(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		pci_write_config_dword(dev,i * 4, dev->saved_config_space[i]);
+	pci_restore_msi_state(dev);
+	pci_restore_msix_state(dev);
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_restore_state);
+
+
+/*
+ * Power States
+ */
+
+int (*platform_pci_set_power_state)(struct pci_dev *dev, pci_power_t t);
+
+/**
+ * pci_set_power_state - Set the power state of a PCI device
+ * @dev: PCI device to be suspended
+ * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
+ *
+ * Transition a device to a new power state, using the Power Management 
+ * Capabilities in the device's config space.
+ *
+ * RETURN VALUE: 
+ * -EINVAL if trying to enter a lower state than we're already in.
+ * 0 if we're already in the requested state.
+ * -EIO if device does not support PCI PM.
+ * 0 if we can successfully change the power state.
+ */
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	int pm, need_restore = 0;
+	u16 pmcsr, pmc;
+
+	/* bound the state we're entering */
+	if (state > PCI_D3hot)
+		state = PCI_D3hot;
+
+	/* Validate current state:
+	 * Can enter D0 from any state, but if we can only go deeper 
+	 * to sleep if we're already in a low power state
+	 */
+	if (state != PCI_D0 && dev->current_state > state) {
+		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
+			__FUNCTION__, pci_name(dev), state, dev->current_state);
+		return -EINVAL;
+	} else if (dev->current_state == state)
+		return 0;        /* we're already there */
+
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	
+	/* abort if the device doesn't support PM capabilities */
+	if (!pm)
+		return -EIO; 
+
+	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
+	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
+		printk(KERN_DEBUG
+		       "PCI: %s has unsupported PM cap regs version (%u)\n",
+		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
+		return -EIO;
+	}
+
+	/* check if this device supports the desired state */
+	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
+		return -EIO;
+	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+		return -EIO;
+
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+
+	/* If we're (effectively) in D3, force entire word to 0.
+	 * This doesn't affect PME_Status, disables PME_En, and
+	 * sets PowerState to 0.
+	 */
+	switch (dev->current_state) {
+	case PCI_D0:
+	case PCI_D1:
+	case PCI_D2:
+		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+		pmcsr |= state;
+		break;
+	case PCI_UNKNOWN: /* Boot-up */
+		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
+		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
+			need_restore = 1;
+		/* Fall-through: force to D0 */
+	default:
+		pmcsr = 0;
+		break;
+	}
+
+	/* enter specified state */
+	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
+
+	/* Mandatory power management transition delays */
+	/* see PCI PM 1.1 5.6.1 table 18 */
+	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+		msleep(10);
+	else if (state == PCI_D2 || dev->current_state == PCI_D2)
+		udelay(200);
+
+	/*
+	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
+	 * Firmware method after natice method ?
+	 */
+	if (platform_pci_set_power_state)
+		platform_pci_set_power_state(dev, state);
+
+	dev->current_state = state;
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
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_set_power_state);
+
+
+int (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+
+/**
+ * pci_choose_state - Choose the power state of a PCI device
+ * @dev: PCI device to be suspended
+ * @state: target sleep state for the whole system. This is the value
+ *	that is passed to suspend() function.
+ *
+ * Returns PCI power state suitable for given device and given system
+ * message.
+ */
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
+{
+	int ret;
+
+	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+		return PCI_D0;
+
+	if (platform_pci_choose_state) {
+		ret = platform_pci_choose_state(dev, state);
+		if (ret >= 0)
+			state.event = ret;
+	}
+
+	switch (state.event) {
+	case PM_EVENT_ON:
+		return PCI_D0;
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_SUSPEND:
+		return PCI_D3hot;
+	default:
+		printk("They asked me for state %d\n", state.event);
+		BUG();
+	}
+	return PCI_D0;
+}
+
+EXPORT_SYMBOL(pci_choose_state);
+
+
+/*
+ * PME# Events
+ */
+
+/**
+ * pci_enable_wake - enable device to generate PME# when suspended
+ * @dev: - PCI device on which to enable wake
+ * @state: - Current state of device.
+ * @enable: - Flag to enable or disable generation
+ *
+ * Set the bits in the device's PM Capabilities to generate PME# when
+ * the system is suspended. 
+ *
+ * -EIO is returned if device doesn't have PM Capabilities. 
+ * -EINVAL is returned if device supports it, but can't generate wake events.
+ * 0 if operation is successful.
+ *
+ */
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
+{
+	int pm;
+	u16 value;
+
+	/* find PCI PM capability in list */
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+
+	/* If device doesn't support PM Capabilities, but request is to disable
+	 * wake events, it's a nop; otherwise fail */
+	if (!pm) 
+		return enable ? -EIO : 0; 
+
+	/* Check device's ability to generate PME# */
+	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
+
+	value &= PCI_PM_CAP_PME_MASK;
+	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
+
+	/* Check if it can generate PME# from requested state. */
+	if (!value || !(value & (1 << state))) 
+		return enable ? -EINVAL : 0;
+
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
+
+	/* Clear PME_Status by writing 1 to it and enable PME# */
+	value |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
+
+	if (!enable)
+		value &= ~PCI_PM_CTRL_PME_ENABLE;
+
+	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
+	
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_enable_wake);


