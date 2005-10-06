Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVJFXrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVJFXrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJFXrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:47:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:45744 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750905AbVJFXro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:47:44 -0400
Date: Thu, 6 Oct 2005 18:47:42 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 15/22] ppc64: PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20051006234742.GP29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI Error Recovery: PPC64 core recovery routines

Various PCI bus errors can be signaled by newer PCI controllers.  The
core error recovery routines are architecture dependent.  This patch adds
a recovery infrastructure for the  PPC64 pSeries systems.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-10-06 17:53:52.475544639 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-10-06 17:54:14.494455177 -0500
@@ -486,6 +486,11 @@
 		if (PCI_DN(dn)) {
 			PCI_DN(dn)->eeh_mode |= mode_flag;
 
+			/* Mark the pci device driver too */
+			struct pci_dev *dev = PCI_DN(dn)->pcidev;
+			if (dev && dev->driver)
+				dev->error_state = pci_channel_io_frozen;
+
 			if (dn->child)
 				__eeh_mark_slot (dn->child, mode_flag);
 		}
@@ -545,6 +550,7 @@
 	int rets[3];
 	unsigned long flags;
 	struct pci_dn *pdn;
+	enum pci_channel_state state;
 	int rc = 0;
 
 	__get_cpu_var(total_mmio_ffs)++;
@@ -649,8 +655,13 @@
 	eeh_mark_slot (dn, EEH_MODE_ISOLATED);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	eeh_send_failure_event (dn, dev, rets[0], rets[2]);
-	
+	state = pci_channel_io_normal;
+	if ((rets[0] == 2) || (rets[0] == 4))
+		state = pci_channel_io_frozen;
+	if (rets[0] == 5)
+		state = pci_channel_io_perm_failure;
+	eeh_send_failure_event (dn, dev, state, rets[2]);
+
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
@@ -954,8 +965,10 @@
 	 * But there are a few cases like display devices that make sense.
 	 */
 	enable = 1;	/* i.e. we will do checking */
+#if 0
 	if ((*class_code >> 16) == PCI_BASE_CLASS_DISPLAY)
 		enable = 0;
+#endif
 
 	if (!enable)
 		pdn->eeh_mode |= EEH_MODE_NOCHECK;
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh_driver.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh_driver.c	2005-10-06 17:54:14.495455037 -0500
@@ -0,0 +1,376 @@
+/*
+ * PCI Error Recovery Driver for RPA-compliant PPC64 platform.
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
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <asm/eeh.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+
+#include "eeh_event.h"
+#include "pci.h"
+
+static inline const char * pcid_name (struct pci_dev *pdev)
+{
+	if (pdev->dev.driver)
+		return pdev->dev.driver->name;
+	return "";
+}
+
+/**
+ * Return the "partitionable endpoint" (pe) under which this device lies
+ */
+static struct device_node * find_device_pe(struct device_node *dn)
+{
+	while ((dn->parent) && PCI_DN(dn->parent) &&
+	      (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
+		dn = dn->parent;
+	}
+	return dn;
+}
+
+
+#ifdef DEBUG
+static void print_device_node_tree (struct pci_dn *pdn, int dent)
+{
+	int i;
+	if (!pdn) return;
+	for (i=0;i<dent; i++)
+		printk(" ");
+	printk("dn=%s mode=%x \tcfg_addr=%x pe_addr=%x \tfull=%s\n",
+		pdn->node->name, pdn->eeh_mode, pdn->eeh_config_addr,
+		pdn->eeh_pe_config_addr, pdn->node->full_name);
+	dent += 3;
+	struct device_node *pc = pdn->node->child;
+	while (pc) {
+		print_device_node_tree(PCI_DN(pc), dent);
+		pc = pc->sibling;
+	}
+}
+#endif
+
+/** 
+ * irq_in_use - return true if this irq is being used 
+ */
+static int irq_in_use(unsigned int irq)
+{
+	int rc = 0;
+	unsigned long flags;
+   struct irq_desc *desc = irq_desc + irq;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	if (desc->action)
+		rc = 1;
+	spin_unlock_irqrestore(&desc->lock, flags);
+	return rc;
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
+	dev->error_state = pci_channel_io_frozen;
+
+	if (!driver)
+		return;
+
+	if (irq_in_use (dev->irq)) {
+		struct device_node *dn = pci_device_to_OF_node(dev);
+		PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
+		disable_irq_nosync(dev->irq);
+	}
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->error_detected)
+		return;
+
+	rc = driver->err_handler->error_detected (dev, pci_channel_io_frozen);
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
+	struct device_node *dn = pci_device_to_OF_node(dev);
+
+	if (!driver)
+		return;
+
+	if ((PCI_DN(dn)->eeh_mode) & EEH_MODE_IRQ_DISABLED) {
+		PCI_DN(dn)->eeh_mode &= ~EEH_MODE_IRQ_DISABLED;
+		enable_irq(dev->irq);
+	}
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->slot_reset)
+		return;
+
+	driver->err_handler->slot_reset(dev);
+}
+
+static void eeh_report_resume(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver = dev->driver;
+
+	dev->error_state = pci_channel_io_normal;
+
+	if (!driver)
+		return;
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->resume)
+		return;
+
+	driver->err_handler->resume(dev);
+}
+
+static void eeh_report_failure(struct pci_dev *dev, void *userdata)
+{
+	struct pci_driver *driver = dev->driver;
+
+	dev->error_state = pci_channel_io_perm_failure;
+
+	if (!driver)
+		return;
+
+	if (irq_in_use (dev->irq)) {
+		struct device_node *dn = pci_device_to_OF_node(dev);
+		PCI_DN(dn)->eeh_mode |= EEH_MODE_IRQ_DISABLED;
+		disable_irq_nosync(dev->irq);
+	}
+	if (!driver->err_handler)
+		return;
+	if (!driver->err_handler->error_detected)
+		return;
+	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
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
+/**
+ * eeh_reset_device() -- perform actual reset of a pci slot
+ * Args: bus: pointer to the pci bus structure corresponding
+ *            to the isolated slot. A non-null value will
+ *            cause all devices under the bus to be removed
+ *            and then re-added.
+ *     pe_dn: pointer to a "Partionable Endpoint" device node.
+ *            This is the top-level structure on which pci
+ *            bus resets can be performed.
+ */
+
+static void eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
+{
+	if (bus)
+		pcibios_remove_pci_devices(bus);
+
+	/* Reset the pci controller. (Asserts RST#; resets config space).
+	 * Reconfigure bridges and devices */
+	rtas_set_slot_reset(pe_dn);
+
+	/* Walk over all functions on this device */
+	rtas_configure_bridge(pe_dn);
+	eeh_restore_bars(pe_dn);
+
+	/* Give the system 5 seconds to finish running the user-space
+	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes, 
+	 * this is a hack, but if we don't do this, and try to bring 
+	 * the device up before the scripts have taken it down, 
+	 * potentially weird things happen.
+	 */
+	if (bus) {
+		ssleep (5);
+		pcibios_add_pci_devices(bus);
+	}
+}
+
+/* The longest amount of time to wait for a pci device
+ * to come back on line, in seconds.
+ */
+#define MAX_WAIT_FOR_RECOVERY 15
+
+void handle_eeh_events (struct eeh_event *event)
+{
+	struct device_node *frozen_dn;
+	struct pci_dn *frozen_pdn;
+	struct pci_bus *frozen_bus;
+	struct pci_dev *dev = event->dev;
+	int perm_failure = 0;
+
+	/* We might not have a pci device, if it was a config space read
+	 * that failed.  Find the pci device now.  */
+	if (!dev) {
+		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+			if (pci_device_to_OF_node(dev) == event->dn)
+				break;
+		}
+	}
+
+	frozen_dn = find_device_pe(event->dn);
+	frozen_bus = pcibios_find_pci_bus(frozen_dn);
+
+	if (!frozen_dn) {
+		printk(KERN_ERR "EEH: Cannot find PCI controller for %s\n",
+		        pci_name(dev));
+		return;
+	}
+
+	/* There are two different styles for coming up with the PE.
+	 * In the old style, it was the highest EEH-capable device
+	 * which was always an EADS pci bridge.  In the new style,
+	 * there might not be any EADS bridges, and even when there are,
+	 * the firmware marks them as "EEH incapable". So another
+	 * two-step is needed to find the pci bus.. */
+	if (!frozen_bus)
+		frozen_bus = pcibios_find_pci_bus (frozen_dn->parent);
+
+	if (!frozen_bus) {
+		printk(KERN_ERR "EEH: Cannot find PCI bus for %s\n",
+		        frozen_dn->full_name);
+		return;
+	}
+
+	if (!dev)
+		dev = frozen_bus->self;
+
+#if 0
+	/* We may get "permanent failure" messages on empty slots.
+	 * These are false alarms. Empty slots have no child dn. */
+	if ((event->state == pci_channel_io_perm_failure) && (frozen_device == NULL))
+		return;
+#endif
+
+	frozen_pdn = PCI_DN(frozen_dn);
+	frozen_pdn->eeh_freeze_count++;
+	
+	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
+		perm_failure = 1;
+
+	/* If the reset state is a '5' and the time to reset is 0 (infinity)
+	 * or is more then 15 seconds, then mark this as a permanent failure.
+	 */
+	if ((event->state == pci_channel_io_perm_failure) &&
+	    ((event->time_unavail <= 0) ||
+	     (event->time_unavail > MAX_WAIT_FOR_RECOVERY*1000)))
+	{
+		perm_failure = 1;
+	}
+
+	/* Log the error with the rtas logger. */
+	if (perm_failure) {
+		/*
+		 * About 90% of all real-life EEH failures in the field
+		 * are due to poorly seated PCI cards. Only 10% or so are
+		 * due to actual, failed cards.
+		 */
+		printk(KERN_ERR
+		   "EEH: PCI device %s - %s has failed %d times \n"
+			"and has been permanently disabled.  Please try reseating\n"
+		   "this device or replacing it.\n",
+			pci_name (dev), pcid_name(dev), frozen_pdn->eeh_freeze_count);
+
+		eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
+
+		/* Notify all devices that they're about to go down. */
+		pci_walk_bus(frozen_bus, eeh_report_failure, 0);
+
+		/* Shut down the device drivers for good. */
+		pcibios_remove_pci_devices(frozen_bus);
+		return;
+	}
+
+	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
+	printk(KERN_WARNING
+	   "EEH: This PCI device has failed %d times since last reboot: %s - %s\n",
+		frozen_pdn->eeh_freeze_count,
+		pci_name (dev), pcid_name(dev));
+
+	/* Walk the various device drivers attached to this slot through
+	 * a reset sequence, giving each an opportunity to do what it needs
+	 * to accomplish the reset.  Each child gets a report of the
+	 * status ... if any child can't handle the reset, then the entire
+	 * slot is dlpar removed and added.
+	 */
+	enum pcierr_result result = PCIERR_RESULT_NONE;
+	pci_walk_bus(frozen_bus, eeh_report_error, &result);
+
+	/* If all device drivers were EEH-unaware, then shut
+	 * down all of the device drivers, and hope they
+	 * go down willingly, without panicing the system.
+	 */
+	if (result == PCIERR_RESULT_NONE) {
+		eeh_reset_device(frozen_pdn, frozen_bus);
+	}
+
+	/* If any device called out for a reset, then reset the slot */
+	if (result == PCIERR_RESULT_NEED_RESET) {
+		eeh_reset_device(frozen_pdn, NULL);
+		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
+	}
+
+	/* If all devices reported they can proceed, the re-enable PIO */
+	if (result == PCIERR_RESULT_CAN_RECOVER) {
+		/* XXX Not supported; we brute-force reset the device */
+		eeh_reset_device(frozen_pdn, NULL);
+		pci_walk_bus(frozen_bus, eeh_report_reset, 0);
+	}
+
+	/* Tell all device drivers that they can resume operations */
+	pci_walk_bus(frozen_bus, eeh_report_resume, 0);
+}
+
+/* ---------- end of file ---------- */
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh_event.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh_event.c	2005-10-06 17:50:24.089783186 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh_event.c	2005-10-06 17:56:14.461622651 -0500
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include "eeh_event.h"
+#include "pci.h"
 
 /** Overview:
  *  EEH error states may be detected within exception handlers;
@@ -36,30 +37,7 @@
 static void eeh_thread_launcher(void *);
 DECLARE_WORK(eeh_event_wq, eeh_thread_launcher, NULL);
 
-/**
- * eeh_panic - call panic() for an eeh event that cannot be handled.
- * The philosophy of this routine is that it is better to panic and
- * halt the OS than it is to risk possible data corruption by
- * oblivious device drivers that don't know better.
- *
- * @dev pci device that had an eeh event
- * @reset_state current reset state of the device slot
- */
-static void eeh_panic(struct pci_dev *dev, int reset_state)
-{
-	/*
-	 * Since the panic_on_oops sysctl is used to halt the system
-	 * in light of potential corruption, we can use it here.
-	 */
-	if (panic_on_oops) {
-		panic("EEH: MMIO failure (%d) on device:%s\n", reset_state,
-		      pci_name(dev));
-	}
-	else {
-		printk(KERN_INFO "EEH: Ignored MMIO failure (%d) on device:%s\n",
-		       reset_state, pci_name(dev));
-	}
-}
+int handle_eeh_events (struct eeh_event *event);
 
 /**
  * eeh_event_handler - dispatch EEH events.  The detection of a frozen
@@ -82,10 +60,16 @@
 
 		spin_lock_irqsave(&eeh_eventlist_lock, flags);
 		event = NULL;
+
+		/* Unqueue the event, get ready to process. */
 		if (!list_empty(&eeh_eventlist)) {
 			event = list_entry(eeh_eventlist.next, struct eeh_event, list);
 			list_del(&event->list);
 		}
+		
+		if (event)
+			eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
+
 		spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
 		if (event == NULL)
 			break;
@@ -93,8 +77,11 @@
 		printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
 		       pci_name(event->dev));
 
-		eeh_panic (event->dev, event->state);
+		handle_eeh_events(event);
+
+		eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
 
+		pci_dev_put(event->dev);
 		kfree(event);
 	}
 
@@ -122,7 +109,7 @@
  */
 int eeh_send_failure_event (struct device_node *dn,
                             struct pci_dev *dev,
-                            int state,
+                            enum pci_channel_state state,
                             int time_unavail)
 {
 	unsigned long flags;
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh_event.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh_event.h	2005-10-06 17:50:24.089783186 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh_event.h	2005-10-06 17:54:14.496454897 -0500
@@ -29,7 +29,7 @@
 	struct list_head     list;
 	struct device_node 	*dn;   /* struct device node */
 	struct pci_dev       *dev;  /* affected device */
-	int                  state;
+	enum pci_channel_state state; /* PCI bus state for the affected device */
 	int time_unavail;    /* milliseconds until device might be available */
 };
 
@@ -46,7 +46,7 @@
  */
 int eeh_send_failure_event (struct device_node *dn,
                             struct pci_dev *dev,
-                            int reset_state,
+                            enum pci_channel_state state,
                             int time_unavail);
 
 #endif /* ASM_PPC64_EEH_EVENT_H */
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/Makefile
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/Makefile	2005-10-06 17:54:00.307445749 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/Makefile	2005-10-06 17:54:14.496454897 -0500
@@ -37,7 +37,7 @@
 			 bpa_iic.o spider-pic.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o
-obj-$(CONFIG_EEH)		+= eeh.o eeh_event.o pci_dlpar.o
+obj-$(CONFIG_EEH)		+= eeh.o eeh_driver.o eeh_event.o pci_dlpar.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_SMP)		+= smp.o
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci.h	2005-10-06 17:53:02.165603605 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h	2005-10-06 17:54:14.497454757 -0500
@@ -54,6 +54,15 @@
 /* ---- EEH internal-use-only related routines ---- */
 #ifdef CONFIG_EEH
 /**
+ * eeh_slot_error_detail -- record and EEH error condition to the log
+ * @severity: 1 if temporary, 2 if permanent failure.
+ *
+ * Obtains the the EEH error details from the RTAS subsystem,
+ * and then logs these details with the RTAS error log system.
+ */
+void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
+
+/**
  * rtas_set_slot_reset -- unfreeze a frozen slot
  *
  * Clear the EEH-frozen condition on a slot.  This routine
Index: linux-2.6.14-rc2-git6/include/asm-ppc64/eeh.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-ppc64/eeh.h	2005-10-06 17:53:52.476544499 -0500
+++ linux-2.6.14-rc2-git6/include/asm-ppc64/eeh.h	2005-10-06 17:55:48.203306937 -0500
@@ -31,9 +31,11 @@
 #ifdef CONFIG_EEH
 
 /* Values for eeh_mode bits in device_node */
-#define EEH_MODE_SUPPORTED	(1<<0)
-#define EEH_MODE_NOCHECK	(1<<1)
-#define EEH_MODE_ISOLATED	(1<<2)
+#define EEH_MODE_SUPPORTED     (1<<0)
+#define EEH_MODE_NOCHECK       (1<<1)
+#define EEH_MODE_ISOLATED      (1<<2)
+#define EEH_MODE_RECOVERING    (1<<3)
+#define EEH_MODE_IRQ_DISABLED  (1<<4)
 
 /* Max number of EEH freezes allowed before we consider the device
  * to be permanently disabled. */
