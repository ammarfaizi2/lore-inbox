Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWF2BfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWF2BfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 21:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWF2BfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 21:35:12 -0400
Received: from mga05.intel.com ([192.55.52.89]:10800 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751854AbWF2BfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 21:35:09 -0400
X-IronPort-AV: i="4.06,190,1149490800"; 
   d="scan'208"; a="90841909:sNHT263350822"
Subject: Re: [PATCH 5/6] PCI-Express AER implemetation
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1151544614.28493.82.camel@ymzhang-perf.sh.intel.com>
References: <1151543547.28493.70.camel@ymzhang-perf.sh.intel.com>
	 <1151543881.28493.74.camel@ymzhang-perf.sh.intel.com>
	 <1151544150.28493.78.camel@ymzhang-perf.sh.intel.com>
	 <1151544614.28493.82.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1151544836.28493.87.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 29 Jun 2006 09:33:56 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 5 implements the core part of PCI-Express AER. When an AER error
happens, the error would be processed based on its type 
(Correctable/non-fatal/fatal).

As for Correctable errors, the patch chooses to just clear the correctable
error status register of the device.

As for the non-fatal error, the patch follows generic PCI error handler rules
to call the error callback functions of the endpoint's driver. If the device
is a bridge, the patch chooses to broadcast the error to downstream devices.

As for the fatal error, the patch resets the pci-express link and follows
generic PCI error handler rules to call the error callback functions of
the endpoint's driver. If the device is a bridge, the patch chooses to
broadcast the error to downstream devices.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.17/drivers/pci/pcie/aer/aerdrv_acpi.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/aer/aerdrv_acpi.c	2006-06-22 16:46:29.000000000 +0800
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2006 Intel
+ *	Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *	Zhang Yanmin (yanmin.zhang@intel.com)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/acpi.h>
+#include <linux/pci-acpi.h>
+#include <linux/delay.h>
+#include "aerdrv.h"
+
+/**
+ * aer_osc_setup - run ACPI _OSC method
+ *
+ * Return: 
+ *	Zero if success. Nonzero for otherwise.
+ *
+ * Invoked when PCIE bus loads AER service driver. To avoid conflict with
+ * BIOS AER support requires BIOS to yield AER control to OS native driver.
+ **/
+int aer_osc_setup(struct pci_dev *dev)
+{
+	int retval = OSC_METHOD_RUN_SUCCESS;
+	acpi_status status;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+	struct pci_dev *pdev = dev;
+	struct pci_bus *parent;
+
+	while (!handle) {
+		if (!pdev || !pdev->bus->parent)
+			break;
+		parent = pdev->bus->parent;
+		if (!parent->self)
+			/* Parent must be a host bridge */
+			handle = acpi_get_pci_rootbridge_handle(
+					pci_domain_nr(parent),
+					parent->number);
+		else
+			handle = DEVICE_ACPI_HANDLE(
+					&(parent->self->dev));
+		pdev = parent->self;
+	}
+
+	if (!handle)
+		return OSC_METHOD_NOT_SUPPORTED;
+
+	pci_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
+	status = pci_osc_control_set(handle, OSC_PCI_EXPRESS_AER_CONTROL |
+		OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_SUPPORT) 
+			retval = OSC_METHOD_NOT_SUPPORTED;
+	 	else
+			retval = OSC_METHOD_RUN_FAILURE;
+	}
+
+	return retval;
+}
+
--- linux-2.6.17/drivers/pci/pcie/aer/aerdrv_core.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/aer/aerdrv_core.c	2006-06-22 16:46:29.000000000 +0800
@@ -0,0 +1,758 @@
+/*
+ * Copyright (C) 2006 Intel
+ *	Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *	Zhang Yanmin (yanmin.zhang@intel.com)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/acpi.h>
+#include <linux/pci-acpi.h>
+#include <linux/delay.h>
+#include "aerdrv.h"
+
+static LIST_HEAD(rc_list);		/* Define Root Complex List */
+
+static int forceload;
+module_param(forceload, bool, 0);
+
+#define PCI_CFG_SPACE_SIZE	(0x100)
+int pci_find_aer_capability(struct pci_dev *dev)
+{
+	int pos;
+	u32 reg32 = 0;
+
+	/* Check if it's a pci-express device */
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos)
+		return 0;
+
+	/* Check if it supports pci-express AER */
+	pos = PCI_CFG_SPACE_SIZE;
+	while (pos) {
+		if (pci_read_config_dword(dev, pos, &reg32))
+			return 0;
+
+		/* some broken boards return ~0 */
+		if (reg32 == 0xffffffff)
+			return 0;
+
+		if (PCI_EXT_CAP_ID(reg32) == PCI_EXT_CAP_ID_ERR)
+			break;
+
+		pos = reg32 >> 20;
+	}
+
+	return pos;
+}
+
+int pci_enable_pcie_error_reporting(struct pci_dev *dev)
+{
+	u16 reg16 = 0;
+	int pos;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos)
+		return -EIO;
+
+	pci_read_config_word(dev, pos+PCI_EXP_DEVCTL, &reg16);
+	reg16 = reg16 |
+		PCI_EXP_DEVCTL_CERE |
+		PCI_EXP_DEVCTL_NFERE |
+		PCI_EXP_DEVCTL_FERE |
+		PCI_EXP_DEVCTL_URRE;
+	pci_write_config_word(dev, pos+PCI_EXP_DEVCTL,
+			reg16);
+	return 0;
+}
+
+int pci_disable_pcie_error_reporting(struct pci_dev *dev)
+{
+	u16 reg16 = 0;
+	int pos;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	if (!pos)
+		return -EIO;
+
+	pci_read_config_word(dev, pos+PCI_EXP_DEVCTL, &reg16);
+	reg16 = reg16 & ~(PCI_EXP_DEVCTL_CERE |
+		PCI_EXP_DEVCTL_NFERE |
+		PCI_EXP_DEVCTL_FERE |
+		PCI_EXP_DEVCTL_URRE);
+	pci_write_config_word(dev, pos+PCI_EXP_DEVCTL,
+			reg16);
+	return 0;
+}
+
+int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
+{
+	int pos;
+	u32 status, mask;
+
+	pos = pci_find_aer_capability(dev);
+	if (!pos)
+		return -EIO;
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
+	if (dev->error_state == pci_channel_io_normal)
+		status &= ~mask; /* Clear corresponding nonfatal bits */
+	else
+		status &= mask; /* Clear corresponding fatal bits */
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+
+	return 0;
+}
+
+static int find_device_iter(struct device *device, void *data)
+{
+	struct pci_dev *dev;
+	u16 id = *(unsigned long *)data;
+	u8 secondary, subordinate, d_bus = id >> 8;
+
+	if (device->bus == &pci_bus_type) {
+		dev = to_pci_dev(device);
+		if (id == ((dev->bus->number << 8) | dev->devfn)) {
+			/*
+			 * Device ID match
+			 */
+			*(unsigned long*)data = (unsigned long)device;
+			return 1;
+		}
+
+		/* 
+		 * If device is P2P, check if it is an upstream?
+		 */
+		if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE) {
+			pci_read_config_byte(dev, PCI_SECONDARY_BUS,
+				&secondary);
+			pci_read_config_byte(dev, PCI_SUBORDINATE_BUS,
+				&subordinate);
+			if (d_bus >= secondary && d_bus <= subordinate) {
+				*(unsigned long*)data = (unsigned long)device;
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * find_source_device - search through device hierarchy for source device
+ * @p_dev: pointer to Root Port pci_dev data structure
+ * @id: device ID of agent who sends an error message to this Root Port
+ *
+ * Invoked when error is detected at the Root Port.
+ **/
+static struct device* find_source_device(struct pci_dev *parent, u16 id)
+{
+	struct pci_dev *dev = parent;
+	struct device *device;
+	unsigned long device_addr;
+	int status;
+
+	/* Is Root Port an agent that sends error message? */
+	if (id == ((dev->bus->number << 8) | dev->devfn)) 
+		return &dev->dev;
+
+	do {
+		device_addr = id;
+ 		if ((status = device_for_each_child(&dev->dev,
+			&device_addr, find_device_iter))) {
+			device = (struct device*)device_addr;
+			dev = to_pci_dev(device);
+			if (id == ((dev->bus->number << 8) | dev->devfn))
+				return device;
+		}
+ 	}while (status);
+
+	return NULL;
+}
+
+static void report_error_detected(struct pci_dev *dev, void *data)
+{
+	pci_ers_result_t vote;
+	struct pci_error_handlers *err_handler;
+	struct aer_broadcast_data *result_data;
+	result_data = (struct aer_broadcast_data *) data;
+
+	dev->error_state = result_data->state;
+
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->error_detected) {
+		if (result_data->state == pci_channel_io_frozen &&
+			!(dev->hdr_type & PCI_HEADER_TYPE_BRIDGE)) {
+			/* 
+			 * In case of fatal recovery, if one of down-
+			 * stream device has no driver. We might be
+			 * unable to recover because a later insmod
+			 * of a driver for this device is unaware of
+			 * its hw state.
+			 */
+			printk(KERN_DEBUG "Device ID[%s] has %s\n",
+					dev->dev.bus_id, (dev->driver) ?
+					"no AER-aware driver" : "no driver");
+		}
+		return;
+	}
+
+	err_handler = dev->driver->err_handler;
+	vote = err_handler->error_detected(dev, result_data->state);
+	result_data->result = merge_result(result_data->result, vote);
+	return;
+}
+
+static void report_mmio_enabled(struct pci_dev *dev, void *data)
+{
+	pci_ers_result_t vote;
+	struct pci_error_handlers *err_handler;
+	struct aer_broadcast_data *result_data;
+	result_data = (struct aer_broadcast_data *) data;
+
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->mmio_enabled)
+		return;
+
+	err_handler = dev->driver->err_handler;
+	vote = err_handler->mmio_enabled(dev);
+	result_data->result = merge_result(result_data->result, vote);
+	return;
+}
+
+static void report_slot_reset(struct pci_dev *dev, void *data)
+{
+	pci_ers_result_t vote;
+	struct pci_error_handlers *err_handler;
+	struct aer_broadcast_data *result_data;
+	result_data = (struct aer_broadcast_data *) data;
+
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->slot_reset)
+		return;
+
+	err_handler = dev->driver->err_handler;
+	vote = err_handler->slot_reset(dev);
+	result_data->result = merge_result(result_data->result, vote);
+	return;
+}
+
+static void report_resume(struct pci_dev *dev, void *data)
+{
+	struct pci_error_handlers *err_handler;
+
+	dev->error_state = pci_channel_io_normal;
+
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->slot_reset)
+		return;
+
+	err_handler = dev->driver->err_handler;
+	err_handler->resume(dev);
+	return;
+}
+
+/**
+ * broadcast_error_message - handle message broadcast to downstream drivers
+ * @device: pointer to from where in a hierarchy message is broadcasted down
+ * @api: callback to be broadcasted
+ * @state: error state
+ *
+ * Invoked during error recovery process. Once being invoked, the content
+ * of error severity will be broadcasted to all downstream drivers in a 
+ * hierarchy in question.
+ **/
+static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
+	enum pci_channel_state state,
+	char *error_mesg,
+	void (*cb)(struct pci_dev *, void *))
+{
+	struct aer_broadcast_data result_data;
+
+	printk(KERN_DEBUG "Broadcast %s message\n", error_mesg);
+	result_data.state = state;
+	if (cb == report_error_detected)
+		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
+	else
+		result_data.result = PCI_ERS_RESULT_RECOVERED;
+
+	if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE) {
+		/*
+		 * If the error is reported by a bridge, we think this error
+		 * is related to the downstream link of the bridge, so we
+		 * do error recovery on all subordinates of the bridge instead
+		 * of the bridge and clear the error status of the bridge.
+		 */
+		if (cb == report_error_detected)
+			dev->error_state = state;
+		pci_walk_bus(dev->subordinate, cb, &result_data);
+		if (cb == report_resume) {
+			pci_cleanup_aer_uncorrect_error_status(dev);
+			dev->error_state = pci_channel_io_normal;
+		}
+	}
+	else {
+		/*
+		 * If the error is reported by an end point, we think this
+		 * error is related to the upstream link of the end point.
+		 */
+		pci_walk_bus(dev->bus, cb, &result_data);
+	}
+
+	return result_data.result;
+}
+
+struct find_aer_service_data {
+        struct pcie_port_service_driver *aer_driver;
+        int is_downstream;
+};
+
+static int find_aer_service_iter(struct device *device, void *data)
+{
+	struct device_driver *driver;
+	struct pcie_port_service_driver *service_driver;
+	struct pcie_device *pcie_dev;
+	struct find_aer_service_data *result;
+
+	result = (struct find_aer_service_data *) data;
+
+	if (device->bus == &pcie_port_bus_type) {
+		pcie_dev = to_pcie_device(device);
+		if (pcie_dev->id.port_type == PCIE_SW_DOWNSTREAM_PORT)
+			result->is_downstream = 1;
+
+		driver = device->driver;
+		if (driver) {
+			service_driver = to_service_driver(driver);
+			if (service_driver->id_table->service_type ==
+					PCIE_PORT_SERVICE_AER) {
+				result->aer_driver = service_driver;
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void find_aer_service(struct pci_dev *dev,
+		struct find_aer_service_data *data)
+{
+	device_for_each_child(&dev->dev, data, find_aer_service_iter);
+}
+
+static pci_ers_result_t reset_link(struct pcie_device *aerdev,
+		struct pci_dev *dev)
+{
+	struct pci_dev *udev;
+	pci_ers_result_t status;
+	struct find_aer_service_data data;
+
+	if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE)
+		udev = dev;
+	else
+		udev= dev->bus->self;
+
+	data.is_downstream = 0;
+	data.aer_driver = NULL;
+	find_aer_service(udev, &data);
+
+	/*
+	 * Use the aer driver of the error agent firstly.
+	 * If it hasn't the aer driver, use the root port's
+	 */
+	if (!data.aer_driver || !data.aer_driver->reset_link) {
+		if (data.is_downstream &&
+			aerdev->device.driver &&
+			to_service_driver(aerdev->device.driver)->reset_link) {
+			data.aer_driver =
+				to_service_driver(aerdev->device.driver);
+		} else {
+			printk(KERN_DEBUG "No link-reset support to Device ID"
+				"[%s]\n",
+				dev->dev.bus_id);
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+	}
+
+	status = data.aer_driver->reset_link(udev);
+	if (status != PCI_ERS_RESULT_RECOVERED) {
+		printk(KERN_DEBUG "Link reset at upstream Device ID"
+			"[%s] failed\n",
+			udev->dev.bus_id);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return status;
+}
+
+/**
+ * do_recovery - handle nonfatal/fatal error recovery process
+ * @aerdev: pointer to a pcie_device data structure of root port
+ * @dev: pointer to a pci_dev data structure of agent detecting an error
+ * @severity: error severity type
+ *
+ * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
+ * error detected message to all downstream drivers within a hierarchy in 
+ * question and return the returned code.
+ **/
+static pci_ers_result_t do_recovery(struct pcie_device *aerdev,
+		struct pci_dev *dev,
+		int severity)
+{
+	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
+	enum pci_channel_state state;
+
+	if (severity == AER_FATAL)
+		state = pci_channel_io_frozen;
+	else
+		state = pci_channel_io_normal;
+
+	status = broadcast_error_message(dev,
+			state,
+			"error_detected",
+			report_error_detected);
+
+	if (severity == AER_FATAL) {
+		result = reset_link(aerdev, dev);
+		if (result != PCI_ERS_RESULT_RECOVERED) {
+			/* TODO: Should panic here? */
+			return result;
+		}
+	}
+
+	if (status == PCI_ERS_RESULT_CAN_RECOVER)
+		status = broadcast_error_message(dev,
+				state,
+				"mmio_enabled",
+				report_mmio_enabled);
+
+	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		/*
+		 * TODO: Should call platform-specific
+		 * functions to reset slot before calling
+		 * drivers' slot_reset callbacks?
+		 */
+		status = broadcast_error_message(dev,
+				state,
+				"slot_reset",
+				report_slot_reset);
+	}
+
+	if (status == PCI_ERS_RESULT_RECOVERED)
+		broadcast_error_message(dev,
+				state,
+				"resume",
+				report_resume);
+
+	return status;
+}
+
+/**
+ * handle_error_source - handle logging error into an event log
+ * @aerdev: pointer to pcie_device data structure of the root port
+ * @dev: pointer to pci_dev data structure of error source device
+ * @info: comprehensive error information
+ *
+ * Invoked when an error being detected by Root Port.
+ **/
+static void handle_error_source(struct pcie_device * aerdev,
+	struct pci_dev *dev,
+	struct aer_err_info info)
+{
+	pci_ers_result_t status = 0;
+	int pos;
+
+	if (info.severity == AER_CORRECTABLE) {
+		/* 
+		 * Correctable error does not need software intevention.
+		 * No need to go through error recovery process.
+		 */
+		pos = pci_find_aer_capability(dev);
+		if (pos)
+			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
+					info.status);
+	} else {
+		status = do_recovery(aerdev, dev, info.severity);
+		if (status == PCI_ERS_RESULT_RECOVERED) {
+			printk(KERN_DEBUG "AER driver successfully recovered\n");
+		} else {
+			/* TODO: Should kernel panic here? */ 
+			printk(KERN_DEBUG "AER driver didn't recover\n");
+		}
+	}
+}
+
+/**
+ * enable_root_aer - enable Root Port's interrupts when receiving messages
+ * @rpc: pointer to a Root Port data structure
+ *
+ * Invoked when PCIE bus loads AER service driver.
+ **/
+static void enable_root_aer(struct aer_rpc *rpc)
+{
+	struct pci_dev *pdev = rpc->rpd->port;
+	int pos, aer_pos;
+	u16 reg16;
+	u32 reg32;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+	/* Clear PCIE Capability's Device Status */
+	pci_read_config_word(pdev, pos+PCI_EXP_DEVSTA, &reg16);
+	pci_write_config_word(pdev, pos+PCI_EXP_DEVSTA, reg16);
+
+	/* Disable system error generation in response to error messages */
+	pci_read_config_word(pdev, pos + PCI_EXP_RTCTL, &reg16);
+	reg16 &= ~(SYSTEM_ERROR_INTR_ON_MESG_MASK);
+	pci_write_config_word(pdev, pos + PCI_EXP_RTCTL, reg16);
+
+	aer_pos = pci_find_aer_capability(pdev);
+	/* Clear error status */
+	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, &reg32);
+	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, reg32);
+	pci_read_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, &reg32);
+	pci_write_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, reg32);
+	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
+	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
+
+	/* Enable Root Port device reporting error itself */
+	pci_read_config_word(pdev, pos+PCI_EXP_DEVCTL, &reg16);
+	reg16 = reg16 |
+		PCI_EXP_DEVCTL_CERE |
+		PCI_EXP_DEVCTL_NFERE |
+		PCI_EXP_DEVCTL_FERE |
+		PCI_EXP_DEVCTL_URRE;
+	pci_write_config_word(pdev, pos+PCI_EXP_DEVCTL,
+		reg16);
+
+	/* Enable Root Port's interrupt in response to error messages */
+	pci_write_config_dword(pdev,
+		aer_pos + PCI_ERR_ROOT_COMMAND,
+		ROOT_PORT_INTR_ON_MESG_MASK);
+}
+
+/**
+ * disable_root_aer - disable Root Port's interrupts when receiving messages
+ * @rpc: pointer to a Root Port data structure
+ *
+ * Invoked when PCIE bus unloads AER service driver.
+ **/
+static void disable_root_aer(struct aer_rpc *rpc)
+{
+	struct pci_dev *pdev = rpc->rpd->port;
+	u32 reg32;
+	int pos;
+
+	pos = pci_find_aer_capability(pdev);
+	/* Disable Root's interrupt in response to error messages */
+	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, 0);
+
+	/* Clear Root's error status reg */
+	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, &reg32);
+	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, reg32);
+}
+
+/**
+ * get_e_source - retrieve an error source
+ * @rpc: pointer to the root port which holds an error
+ *
+ * Invoked by DPC handler to consume an error.
+ **/
+static struct aer_err_source* get_e_source(struct aer_rpc *rpc)
+{
+	struct aer_err_source *e_source;
+	unsigned long flags;
+
+	/* Lock access to Root error producer/consumer index */
+	spin_lock_irqsave(&rpc->e_lock, flags);
+	if (rpc->prod_idx == rpc->cons_idx) {
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return NULL;
+	}
+	e_source = &rpc->e_sources[rpc->cons_idx];
+	rpc->cons_idx++;
+	if (rpc->cons_idx == AER_ERROR_SOURCES_MAX)
+		rpc->cons_idx = 0;
+	spin_unlock_irqrestore(&rpc->e_lock, flags);
+	
+	return e_source;
+}
+
+static int get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
+{
+	int pos;
+
+	pos = pci_find_aer_capability(dev);
+
+	/* The device might not support AER */
+	if (!pos)
+		return AER_SUCCESS;
+
+	if (info->severity == AER_CORRECTABLE) {
+		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
+			&info->status);
+		if (!(info->status & ERR_CORRECTABLE_ERROR_MASK))
+			return AER_UNSUCCESS; 
+	} else if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE ||
+		info->severity == AER_NONFATAL) {
+
+		/* Link is still healthy for IO reads */
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
+			&info->status);
+		if (!(info->status & ERR_UNCORRECTABLE_ERROR_MASK))
+			return AER_UNSUCCESS;
+
+		if (info->status & AER_LOG_TLP_MASKS) {
+			info->flags |= AER_TLP_HEADER_VALID_FLAG;
+			pci_read_config_dword(dev, 
+				pos + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
+			pci_read_config_dword(dev, 
+				pos + PCI_ERR_HEADER_LOG + 4, &info->tlp.dw1);
+			pci_read_config_dword(dev, 
+				pos + PCI_ERR_HEADER_LOG + 8, &info->tlp.dw2);
+			pci_read_config_dword(dev, 
+				pos + PCI_ERR_HEADER_LOG + 12, &info->tlp.dw3);
+		}
+	}
+
+	return AER_SUCCESS;
+}
+
+/**
+ * aer_isr - consume an error detected by root port
+ * @context: pointer to a private data of pcie device
+ *
+ * Invoked, as DPC, when root port records new detected error
+ **/
+void aer_isr(void *context)
+{
+	struct pcie_device *p_device = (struct pcie_device *) context;
+	struct device *s_device;
+	struct aer_rpc *rpc = get_service_data(p_device);
+	struct aer_err_source *e_src;
+	struct aer_err_info e_info = {0, 0, 0,};
+	int i;
+	u16 id;
+
+	/* 
+	 * Lock access into an error buffer associated with this Root Port.
+	 * Process one error at a time.
+	 */
+	down(&rpc->rpc_sema);
+	if (!(e_src = get_e_source(rpc))) {
+		printk(KERN_DEBUG "%s->DPC fails to get an error source\n",
+			__FUNCTION__);
+		up(&rpc->rpc_sema);
+		return;
+	}
+
+	/*
+	 * There is a possibility that both correctable error and 
+	 * uncorrectable error being logged. Report correctable error first.
+	 */
+	for (i = 1; i & ROOT_ERR_STATUS_MASKS ; i <<= 2) {
+		if (i > 4)
+			break;
+		if (!(e_src->status & i))
+			continue;
+
+		/* Init comprehensive error information */
+		if (i & PCI_ERR_ROOT_COR_RCV) {
+			id = ERR_COR_ID(e_src->id);
+			e_info.severity = AER_CORRECTABLE;
+		} else {
+			id = ERR_UNCOR_ID(e_src->id);
+			e_info.severity = ((e_src->status >> 6) & 1);
+		}
+		if (e_src->status &
+			(PCI_ERR_ROOT_MULTI_COR_RCV |
+			 PCI_ERR_ROOT_MULTI_UNCOR_RCV))
+			e_info.flags |= AER_MULTI_ERROR_VALID_FLAG;
+		if (!(s_device = find_source_device(p_device->port, id))) {
+			printk(KERN_DEBUG "%s->can't find device of ID%04x\n",
+				__FUNCTION__, id);
+			continue;
+		}
+		if (get_device_error_info(to_pci_dev(s_device), &e_info) ==
+				AER_SUCCESS) {
+			aer_print_error(to_pci_dev(s_device), &e_info);
+			handle_error_source(p_device,
+				to_pci_dev(s_device),
+				e_info);
+		}
+	}
+	up(&rpc->rpc_sema);
+}
+
+/**
+ * aer_add_rootport - add a new root port into Root Complex's port hierarchy
+ * @rpc: pointer to a new root port device being added
+ *
+ * Invoked when AER service loaded on a new Root Port
+ **/
+void aer_add_rootport(struct aer_rpc *rpc)
+{
+	/* Add new Root Port into RC List */
+	list_add_tail(&rpc->node, &rc_list);
+
+	/* Enable root port AER itself */
+	enable_root_aer(rpc);
+}
+
+/**
+ * aer_delete_rootport - delete a root port from Root Complex's port hierarchy
+ * @rpc: pointer to a root port device being deleted
+ *
+ * Invoked when AER service unloaded on a specific Root Port
+ **/
+void aer_delete_rootport(struct aer_rpc *rpc)
+{
+	/* Disable root port AER itself */
+	disable_root_aer(rpc);
+	
+	/* Free all source nodes under this root port */
+	list_del(&rpc->node);
+	kfree(rpc);
+}
+
+/**
+ * aer_init - provide AER initialization
+ * @dev: pointer to AER pcie device
+ *
+ * Invoked when AER service driver is loaded.
+ **/
+int aer_init(struct pcie_device *dev)
+{
+	int status;
+
+	/* Run _OSC Method */
+	status = aer_osc_setup(dev->port);
+
+	if(status != OSC_METHOD_RUN_SUCCESS) {
+		printk(KERN_DEBUG "%s: AER service init fails - %s\n",
+		__FUNCTION__,
+		(status == OSC_METHOD_NOT_SUPPORTED) ?
+			"No ACPI _OSC support" : "Run ACPI _OSC fails");
+
+		if (!forceload)
+			return status;
+	}
+
+	return AER_SUCCESS;
+}
+
+EXPORT_SYMBOL(pci_find_aer_capability);
+EXPORT_SYMBOL(pci_enable_pcie_error_reporting);
+EXPORT_SYMBOL(pci_disable_pcie_error_reporting);
+EXPORT_SYMBOL(pci_cleanup_aer_uncorrect_error_status);
+
--- linux-2.6.17/include/linux/aer.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17_aer/include/linux/aer.h	2006-06-22 16:46:29.000000000 +0800
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2006 Intel
+ *     Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *     Zhang Yanmin (yanmin.zhang@intel.com)
+ */
+
+#ifndef _AER_H_
+#define _AER_H_
+
+#if defined(CONFIG_PCIEAER) ||		\
+	(defined(MODULE) && defined(CONFIG_PCIEAER_MODULE))
+extern int pci_find_aer_capability(struct pci_dev *dev);
+extern int pci_enable_pcie_error_reporting(struct pci_dev *dev);
+extern int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+extern int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+#else
+#define pci_find_aer_capability(dev)			do { } while (0)
+#define pci_enable_pcie_error_reporting(dev)		do { } while (0)
+#define pci_disable_pcie_error_reporting(dev)		do { } while (0)
+#define pci_cleanup_aer_uncorrect_error_status(dev)	do { } while (0)
+#endif
+
+#endif //_AER_H_
+
--- linux-2.6.17/include/linux/pcieport_if.h	2006-06-22 16:26:32.000000000 +0800
+++ linux-2.6.17_aer/include/linux/pcieport_if.h	2006-06-22 16:46:29.000000000 +0800
@@ -61,6 +61,12 @@ struct pcie_port_service_driver {
 	void (*remove) (struct pcie_device *dev);
 	int (*suspend) (struct pcie_device *dev, pm_message_t state);
 	int (*resume) (struct pcie_device *dev);
+	
+	/* Service Error Recovery Handler */
+	struct pci_error_handlers *err_handler;
+
+	/* Link Reset Capability - AER service driver specific */
+	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
 
 	const struct pcie_port_service_id *id_table;
 	struct device_driver driver;
--- linux-2.6.17/drivers/pci/pcie/aer/aerdrv.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/aer/aerdrv.h	2006-06-22 16:46:29.000000000 +0800
@@ -0,0 +1,137 @@
+/*
+ * Copyright (C) 2006 Intel
+ *	Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *	Zhang Yanmin (yanmin.zhang@intel.com)
+ *
+ */
+
+#ifndef _AERDRV_H_
+#define _AERDRV_H_
+
+#include <linux/pcieport_if.h>
+#include <linux/aer.h>
+
+#define AER_NONFATAL			0
+#define AER_FATAL			1
+#define AER_CORRECTABLE			2
+#define AER_UNCORRECTABLE		4
+#define AER_ERROR_MASK			0x001fffff
+#define AER_ERROR(d)			(d & AER_ERROR_MASK)
+
+#define VERBOSE_LIMIT_DISPLAY		1
+#define VERBOSE_FULL_DISPLAY		2
+#define VERBOSE_RAW_DISPLAY		3
+#define VERBOSE_MASK			0x3
+
+#define OSC_METHOD_RUN_SUCCESS		0
+#define OSC_METHOD_NOT_SUPPORTED	1
+#define OSC_METHOD_RUN_FAILURE		2
+
+/* Root Error Status Register Bits */
+#define ROOT_ERR_STATUS_MASKS			0x0f
+
+#define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
+					PCI_EXP_RTCTL_SENFEE|	\
+					PCI_EXP_RTCTL_SEFEE)
+#define ROOT_PORT_INTR_ON_MESG_MASK	(PCI_ERR_ROOT_CMD_COR_EN|	\
+					PCI_ERR_ROOT_CMD_NONFATAL_EN|	\
+					PCI_ERR_ROOT_CMD_FATAL_EN)
+#define ERR_COR_ID(d)			(d & 0xffff)
+#define ERR_UNCOR_ID(d)			(d >> 16)
+
+#define AER_SUCCESS			0
+#define AER_UNSUCCESS			1
+#define AER_ERROR_SOURCES_MAX		100
+
+#define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
+					PCI_ERR_UNC_ECRC|		\
+					PCI_ERR_UNC_UNSUP|		\
+					PCI_ERR_UNC_COMP_ABORT|		\
+					PCI_ERR_UNC_UNX_COMP|		\
+					PCI_ERR_UNC_MALF_TLP)
+
+/* AER Error Info Flags */
+#define AER_TLP_HEADER_VALID_FLAG	0x00000001
+#define AER_MULTI_ERROR_VALID_FLAG	0x00000002
+
+#define ERR_CORRECTABLE_ERROR_MASK	0x000031c1
+#define ERR_UNCORRECTABLE_ERROR_MASK	0x001ff010
+
+struct header_log_regs {
+	unsigned int dw0;
+	unsigned int dw1;
+	unsigned int dw2;
+	unsigned int dw3;
+};
+
+struct aer_err_info {
+	int severity;			/* 0:NONFATAL | 1:FATAL | 2:COR */
+	int flags;			
+	unsigned int status;		/* COR/UNCOR Error Status */
+	struct header_log_regs tlp; 	/* TLP Header */
+};
+
+struct aer_err_source {
+	unsigned int status;
+	unsigned int id;
+};
+
+struct aer_rpc {
+ 	struct list_head node;
+ 	struct list_head children;	/* AER children of this root port */
+	struct pcie_device *rpd;	/* Root Port device */
+	struct work_struct dpc_handler;
+	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
+	unsigned short prod_idx;	/* Error Producer Index */
+	unsigned short cons_idx;	/* Error Consumer Index */
+	int isr;
+	spinlock_t e_lock;		/* 
+					 * Lock access to Error Status/ID Regs
+					 * and error producer/consumer index
+					 */
+ 
+	struct semaphore rpc_sema;	/* 
+					 * Semaphore access required to
+					 * access, add, remove, or print AER
+				 	 * aware devices in this RPC hierarchy
+					 */
+};
+
+struct aer_broadcast_data {
+	enum pci_channel_state state;
+	enum pci_ers_result result;
+};
+
+static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
+		enum pci_ers_result new)
+{
+	switch (orig) {
+	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_RECOVERED:
+		orig = new;
+		break;
+	case PCI_ERS_RESULT_DISCONNECT:
+		if (new == PCI_ERS_RESULT_NEED_RESET)
+			orig = new;
+		break;
+	default:
+		break;
+	}
+
+	return orig;
+}
+
+extern struct bus_type pcie_port_bus_type;
+extern void aer_add_rootport(struct aer_rpc *rpc);
+extern void aer_delete_rootport(struct aer_rpc *rpc);
+extern int aer_init(struct pcie_device *dev);
+extern void aer_isr(void *context);
+extern void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+
+#ifdef CONFIG_ACPI
+extern int aer_osc_setup(struct pci_dev *dev);
+#else
+#define  aer_osc_setup(dev)		(OSC_METHOD_NOT_SUPPORTED)
+#endif
+
+#endif //_AERDRV_H_
