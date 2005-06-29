Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVF2Aqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVF2Aqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF2AqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:46:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30105 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262242AbVF2AAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:00:35 -0400
Date: Tue, 28 Jun 2005 19:00:27 -0500
To: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Greg KH <greg@kroah.com>,
       ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: [PATCH 13/13]: PCI Err: RPA-PHP-specific error recovery driver
Message-ID: <20050629000027.GA6494@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


pci-err-13-rpaphp-eeh.patch

PCI Error recovery driver, ppc64-specific implementation.  
For various historical reasons, this driver is in the pci 
hotplug directory, although it could be moved to arch/ppc64
It is here because the driver falls back to using the pci
hotplug routines if the device driver does not support 
native error recovery.

Signed-off-by: Linas Vepstas <linas@linas.org>

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-err-13-rpaphp-eeh.patch"

--- linux-2.6.12-git10/drivers/pci/hotplug/rpaphp.h.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/hotplug/rpaphp.h	2005-06-22 15:28:29.000000000 -0500
@@ -113,6 +113,8 @@ extern int rpaphp_enable_pci_slot(struct
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
+extern void init_eeh_handler (void);
+extern void exit_eeh_handler (void);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
--- linux-2.6.12-git10/drivers/pci/hotplug/rpaphp_core.c.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/hotplug/rpaphp_core.c	2005-06-22 15:28:29.000000000 -0500
@@ -460,12 +460,18 @@ static int __init rpaphp_init(void)
 {
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
+	/* Get set to handle EEH events. */
+	init_eeh_handler();
+
 	/* read all the PRA info from the system */
 	return init_rpa();
 }
 
 static void __exit rpaphp_exit(void)
 {
+	/* Let EEH know we are going away. */
+	exit_eeh_handler();
+
 	cleanup_slots();
 }
 
--- drivers/pci/hotplug/rpaphp_eeh.c.linas-orig	2005-06-28 12:47:20.000000000 -0500
+++ drivers/pci/hotplug/rpaphp_eeh.c	2005-06-28 17:36:17.000000000 -0500
@@ -0,0 +1,383 @@
+/*
+ * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
+ * Copyright (C) 2004, 2005 Linas Vepstas <linas@linas.org>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <linas@us.ibm.com>
+ *
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <asm/eeh.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+
+#include "../pci.h"
+#include "rpaphp.h"
+
+/**
+ * pci_search_bus_for_dev - return 1 if device is under this bus, else 0
+ * @bus: the bus to search for this device.
+ * @dev: the pci device we are looking for.
+ *
+ * XXX should this be moved to drivers/pci/search.c ?
+ */
+static int pci_search_bus_for_dev (struct pci_bus *bus, struct pci_dev *dev)
+{
+	struct list_head *ln;
+
+	if (!bus) return 0;
+
+	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
+		struct pci_dev *pdev = pci_dev_b(ln);
+		if (pdev == dev)
+			return 1;
+		if (pdev->subordinate) {
+			int rc;
+			rc = pci_search_bus_for_dev (pdev->subordinate, dev);
+			if (rc)
+				return 1;
+		}
+	}
+	return 0;
+}
+
+/** pci_walk_bus - walk bus under this device, calling callback.
+ *  @top      device whose peers should be walked
+ *  @cb       callback to be called for each device found
+ *  @userdata arbitrary pointer to be passed to callback.
+ *
+ *  Walk the bus on which this device sits, including any
+ *  bridged devices on busses under this bus.  Call the provided
+ *  callback on each device found.
+ */
+typedef void (*pci_buswalk_cb)(struct pci_dev *, void *);
+
+static void
+pci_walk_bus (struct pci_dev *top, pci_buswalk_cb cb, void *userdata)
+{
+	struct pci_dev *dev, *tmp;
+
+	spin_lock(&pci_bus_lock);
+	list_for_each_entry_safe (dev, tmp, &top->bus->devices, bus_list) {
+	   pci_dev_get(dev);
+		spin_unlock(&pci_bus_lock);
+
+		/* Run device routines with the bus unlocked */
+		cb (dev, userdata);
+		if (dev->subordinate) {
+			pci_walk_bus (pci_dev_b(&dev->subordinate->devices), cb, userdata);
+		}
+		spin_lock(&pci_bus_lock);
+	   pci_dev_put(dev);
+	}
+	spin_unlock(&pci_bus_lock);
+}
+
+/**
+ * rpaphp_find_slot - find and return the slot holding the device
+ * @dev: pci device for which we want the slot structure.
+ */
+static struct slot *rpaphp_find_slot(struct pci_dev *dev)
+{
+	struct list_head *tmp, *n;
+	struct slot	*slot;
+
+	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
+		struct pci_bus *bus;
+
+		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+
+		/* PHB's don't have bridges. */
+		if (slot->bridge == NULL)
+			continue;
+
+		/* The PCI device could be the slot itself. */
+		if (slot->bridge == dev)
+			return slot;
+
+		bus = slot->bridge->subordinate;
+		if (!bus) {
+			printk (KERN_WARNING "PCI bridge is missing bus: %s %s\n",
+			    pci_name (slot->bridge), pci_pretty_name (slot->bridge));
+			continue;  /* should never happen? */
+		}
+
+		if (pci_search_bus_for_dev (bus, dev))
+			return slot;
+	}
+	return NULL;
+}
+
+/* ------------------------------------------------------- */
+/** eeh_report_error - report an EEH error to each device,
+ *  collect up and merge the device responses.
+ */
+
+static void eeh_report_error(struct pci_dev *dev, void *userdata)
+{
+	enum pcierr_result rc, *res = userdata;
+	struct pci_driver *driver = dev->driver;
+
+	if (!driver) 
+		return;
+	driver->err_handler.error_state = pci_channel_io_frozen;
+	if (!driver->err_handler.error_detected)
+		return;
+	
+	rc = driver->err_handler.error_detected (dev, pci_channel_io_frozen);
+	if (*res == PCIERR_RESULT_NONE) *res = rc;
+	if (*res == PCIERR_RESULT_NEED_RESET) return;
+	if (*res == PCIERR_RESULT_DISCONNECT &&
+	     rc == PCIERR_RESULT_NEED_RESET) *res = rc;
+}
+
+/** eeh_report_reset -- tell this device that the pci slot
+ *  has been reset.
+ */
+
+static void eeh_report_reset(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver = dev->driver;
+
+	if (!driver) 
+		return;
+	if (!driver->err_handler.slot_reset)
+		return;
+	
+	driver->err_handler.slot_reset (dev);
+}
+
+static void eeh_report_resume(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver = dev->driver;
+
+	if (!driver) 
+		return;
+	driver->err_handler.error_state = pci_channel_io_normal;
+	if (!driver->err_handler.resume)
+		return;
+
+	driver->err_handler.resume (dev);
+}
+
+static void eeh_report_failure(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver = dev->driver;
+
+	if (!driver) 
+		return;
+	driver->err_handler.error_state = pci_channel_io_perm_failure;
+	if (!driver->err_handler.error_detected)
+		return;
+
+	driver->err_handler.error_detected (dev, pci_channel_io_perm_failure);
+}
+
+/* ------------------------------------------------------- */
+/**
+ * handle_eeh_events -- reset a PCI device after hard lockup.
+ *
+ * pSeries systems will isolate a PCI slot if the PCI-Host
+ * bridge detects address or data parity errors, DMA's
+ * occuring to wild addresses (which usually happen due to
+ * bugs in device drivers or in PCI adapter firmware).
+ * Slot isolations also occur if #SERR, #PERR or other misc
+ * PCI-related errors are detected.
+ *
+ * Recovery process consists of unplugging the device driver
+ * (which generated hotplug events to userspace), then issuing
+ * a PCI #RST to the device, then reconfiguring the PCI config
+ * space for all bridges & devices under this slot, and then
+ * finally restarting the device drivers (which cause a second
+ * set of hotplug events to go out to userspace).
+ */
+
+int eeh_reset_device (struct pci_dev *dev, struct device_node *dn, int reconfig)
+{
+	struct slot *frozen_slot= NULL;
+
+	if (!dev)
+		return 1;
+
+	if (reconfig)
+		frozen_slot = rpaphp_find_slot(dev);
+
+	if (reconfig && frozen_slot) rpaphp_unconfig_pci_adapter (frozen_slot);
+
+	/* Reset the pci controller. (Asserts RST#; resets config space).
+	 * Reconfigure bridges and devices */
+	rtas_set_slot_reset (dn->child);
+
+	/* Walk over all functions on this device */
+	struct device_node *peer = dn->child;
+	while (peer) {
+		rtas_configure_bridge(peer);
+		eeh_restore_bars(peer);
+		peer = peer->sibling;
+	}
+
+	/* Give the system 5 seconds to finish running the user-space
+	 * hotplug scripts, e.g. ifdown for ethernet.  Yes, this is a hack,
+	 * but if we don't do this, weird things happen.
+	 */
+	if (reconfig && frozen_slot) {
+		ssleep (5);
+		rpaphp_enable_pci_slot (frozen_slot);
+	}
+	return 0;
+}
+
+/* The longest amount of time to wait for a pci device
+ * to come back on line, in seconds.
+ */
+#define MAX_WAIT_FOR_RECOVERY 15
+
+int handle_eeh_events (struct notifier_block *self,
+                       unsigned long reason, void *ev)
+{
+	int freeze_count=0;
+	struct device_node *frozen_device;
+	struct peh_event *event = ev;
+	struct pci_dev *dev = event->dev;
+	int perm_failure = 0;
+
+	if (!dev)
+	{
+		printk ("EEH: EEH error caught, but no PCI device specified!\n");
+		return 1;
+	}
+
+	frozen_device = pci_bus_to_OF_node(dev->bus);
+	if (!frozen_device)
+	{
+		printk (KERN_ERR "EEH: Cannot find PCI controller for %s %s\n",
+				pci_name(dev), pci_pretty_name (dev));
+
+		return 1;
+	}
+	BUG_ON (frozen_device->phb==NULL);
+
+	/* We get "permanent failure" messages on empty slots.
+	 * These are false alarms. Empty slots have no child dn. */
+	if ((event->state == pci_channel_io_perm_failure) && (frozen_device == NULL))
+		return 0;
+
+	if (frozen_device)
+		freeze_count = frozen_device->eeh_freeze_count;
+	freeze_count ++;
+	if (freeze_count > EEH_MAX_ALLOWED_FREEZES)
+		perm_failure = 1;
+
+	/* If the reset state is a '5' and the time to reset is 0 (infinity)
+	 * or is more then 15 seconds, then mark this as a permanent failure.
+	 */
+	if ((event->state == pci_channel_io_perm_failure) &&
+	    ((event->time_unavail <= 0) ||
+	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000)))
+		perm_failure = 1;
+
+	/* Log the error with the rtas logger. */
+	if (perm_failure) {
+		/*
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards.
+		 */
+		printk (KERN_ERR
+		   "EEH: device %s:%s has failed %d times \n"
+			"and has been permanently disabled.  Please try reseating\n"
+		   "this device or replacing it.\n",
+			pci_name (dev),
+			pci_pretty_name (dev),
+			freeze_count);
+
+		eeh_slot_error_detail (frozen_device, 2 /* Permanent Error */);
+
+		/* Notify all devices that they're about to go down. */
+		pci_walk_bus (dev, eeh_report_failure, 0);
+
+		/* If there's a hotplug slot, unconfigure it */
+		// XXX we need alternate way to deconfigure non-hotplug slots.
+		struct slot * frozen_slot = rpaphp_find_slot(dev);
+		if (frozen_slot)
+			rpaphp_unconfig_pci_adapter (frozen_slot);
+		return 1;
+	} else {
+		eeh_slot_error_detail (frozen_device, 1 /* Temporary Error */);
+	}
+
+	printk (KERN_WARNING
+	   "EEH: This device has failed %d times since last reboot: %s:%s\n",
+		freeze_count,
+		pci_name (dev),
+		pci_pretty_name (dev));
+
+	/* Walk the various device drivers attached to this slot,
+	 * letting each know about the EEH bug.
+	 */
+	enum pcierr_result result = PCIERR_RESULT_NONE;
+	pci_walk_bus (dev, eeh_report_error, &result);
+
+	/* If all device drivers were EEH-unaware, then pci hotplug
+	 * the device, and hope that clears the error. */
+	if (result == PCIERR_RESULT_NONE) {
+		eeh_reset_device (dev, frozen_device, 1);
+	}
+
+	/* If any device called out for a reset, then reset the slot */
+	if (result == PCIERR_RESULT_NEED_RESET) {
+		eeh_reset_device (dev, frozen_device, 0);
+		pci_walk_bus (dev, eeh_report_reset, 0);
+	}
+
+	/* If all devices reported they can proceed, the re-enable PIO */
+	if (result == PCIERR_RESULT_CAN_RECOVER) {
+		/* XXX Not supported; we brute-force reset the device */
+		eeh_reset_device (dev, frozen_device, 0);
+		pci_walk_bus (dev, eeh_report_reset, 0);
+	}
+
+	/* Tell all device drivers that they can resume operations */
+	pci_walk_bus (dev, eeh_report_resume, 0);
+
+	/* Store the freeze count with the pci adapter, and not the slot.
+	 * This way, if the device is replaced, the count is cleared.
+	 */
+	frozen_device->eeh_freeze_count = freeze_count;
+
+	return 1;
+}
+
+static struct notifier_block eeh_block;
+
+void __init init_eeh_handler (void)
+{
+	eeh_block.notifier_call = handle_eeh_events;
+	peh_register_notifier (&eeh_block);
+}
+
+void __exit exit_eeh_handler (void)
+{
+	peh_unregister_notifier (&eeh_block);
+}
+
--- linux-2.6.12-git10/drivers/pci/hotplug/Makefile.linas-orig	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.12-git10/drivers/pci/hotplug/Makefile	2005-06-22 15:28:29.000000000 -0500
@@ -41,6 +41,7 @@ acpiphp-objs		:=	acpiphp_core.o	\
 				acpiphp_res.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
+				rpaphp_eeh.o	\
 				rpaphp_pci.o	\
 				rpaphp_slot.o	\
 				rpaphp_vio.o

--fUYQa+Pmc3FrFX/N--
