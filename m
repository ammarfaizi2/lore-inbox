Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWGaHX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWGaHX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWGaHX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:23:27 -0400
Received: from mga05.intel.com ([192.55.52.89]:49574 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750841AbWGaHX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:23:26 -0400
X-IronPort-AV: i="4.07,197,1151910000"; 
   d="scan'208"; a="107647159:sNHT605394279"
Subject: Re: [PATCH 3/4] PCI-Express AER implemetation: AER core and
	aerdriver
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1154330319.27051.76.camel@ymzhang-perf.sh.intel.com>
References: <1154330118.27051.73.camel@ymzhang-perf.sh.intel.com>
	 <1154330319.27051.76.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1154330492.27051.79.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 31 Jul 2006 15:21:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 3 implements the core part of PCI-Express AER and aerdrv
port service driver.

When a root port service device is probed, the aerdrv will call
request_irq to register irq handler for AER error interrupt.

When a device sends an PCI-Express error message to the root port,
the root port will trigger an interrupt, by either MSI or IO-APIC,
then kernel would run the irq handler. The handler collects root
error status register and schedules a work. The work will call
the core part to process the error based on its type
(Correctable/non-fatal/fatal).

As for Correctable errors, the patch chooses to just clear the correctable
error status register of the device.

As for the non-fatal error, the patch follows generic PCI error handler
rules to call the error callback functions of the endpoint's driver. If
the device is a bridge, the patch chooses to broadcast the error to
downstream devices.

As for the fatal error, the patch resets the pci-express link and
follows generic PCI error handler rules to call the error callback
functions of the endpoint's driver. If the device is a bridge, the patch
chooses to broadcast the error to downstream devices.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.18-rc3/drivers/pci/pcie/aer/aerdrv_acpi.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/aerdrv_acpi.c	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,68 @@
+/*
+ * Access ACPI _OSC method
+ *
+ * Copyright (C) 2006 Intel Corp.
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
--- linux-2.6.18-rc3/drivers/pci/pcie/aer/aerdrv_core.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/aerdrv_core.c	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,757 @@
+/*
+ * drivers/pci/pcie/aer/aerdrv_core.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file implements the core part of PCI-Express AER. When an pci-express
+ * error is delivered, an error message will be collected and printed to
+ * console, then, an error recovery procedure will be executed by following
+ * the pci error recovery rules.
+ * 
+ * Copyright (C) 2006 Intel Corp.
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
+			PCI_EXP_DEVCTL_NFERE |
+			PCI_EXP_DEVCTL_FERE |
+			PCI_EXP_DEVCTL_URRE);
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
+	struct pcie_port_service_driver *aer_driver;
+	int is_downstream;
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
+ * aer_enable_rootport - enable Root Port's interrupts when receiving messages
+ * @rpc: pointer to a Root Port data structure
+ *
+ * Invoked when PCIE bus loads AER service driver.
+ **/
+void aer_enable_rootport(struct aer_rpc *rpc)
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
+ * aer_isr_one_error - consume an error detected by root port
+ * @p_device: pointer to error root port service device
+ * @e_src: pointer to an error source
+ **/
+static void aer_isr_one_error(struct pcie_device *p_device,
+		struct aer_err_source *e_src)
+{
+	struct device *s_device;
+	struct aer_err_info e_info = {0, 0, 0,};
+	int i;
+	u16 id;
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
+}
+
+/**
+ * aer_isr - consume errors detected by root port
+ * @context: pointer to a private data of pcie device
+ *
+ * Invoked, as DPC, when root port records new detected error
+ **/
+void aer_isr(void *context)
+{
+	struct pcie_device *p_device = (struct pcie_device *) context;
+	struct aer_rpc *rpc = get_service_data(p_device);
+	struct aer_err_source *e_src;
+
+	mutex_lock(&rpc->rpc_mutex);
+	e_src = get_e_source(rpc);
+	while (e_src) {
+		aer_isr_one_error(p_device, e_src);
+		e_src = get_e_source(rpc);
+	}
+	mutex_unlock(&rpc->rpc_mutex);
+
+	wake_up(&rpc->wait_release);
+}
+
+/**
+ * aer_delete_rootport - disable root port aer and delete service data 
+ * @rpc: pointer to a root port device being deleted
+ *
+ * Invoked when AER service unloaded on a specific Root Port
+ **/
+void aer_delete_rootport(struct aer_rpc *rpc)
+{
+	/* Disable root port AER itself */
+	disable_root_aer(rpc);
+	
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
--- linux-2.6.18-rc3/include/linux/aer.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/include/linux/aer.h	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2006 Intel Corp.
+ *     Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *     Zhang Yanmin (yanmin.zhang@intel.com)
+ */
+
+#ifndef _AER_H_
+#define _AER_H_
+
+#if defined(CONFIG_PCIEAER)
+/* pci-e port driver needs this function to enable aer */
+extern int pci_enable_pcie_error_reporting(struct pci_dev *dev);
+extern int pci_find_aer_capability(struct pci_dev *dev);
+extern int pci_disable_pcie_error_reporting(struct pci_dev *dev);
+extern int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+#else
+#define pci_enable_pcie_error_reporting(dev)		do { } while (0)
+#define pci_find_aer_capability(dev)			do { } while (0)
+#define pci_disable_pcie_error_reporting(dev)		do { } while (0)
+#define pci_cleanup_aer_uncorrect_error_status(dev)	do { } while (0)
+#endif
+
+#endif //_AER_H_
+
--- linux-2.6.18-rc3/include/linux/pcieport_if.h	2006-07-31 14:38:39.000000000 +0800
+++ linux-2.6.18-rc3_aer/include/linux/pcieport_if.h	2006-07-31 14:43:34.000000000 +0800
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
--- linux-2.6.18-rc3/drivers/pci/pcie/aer/aerdrv.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/aerdrv.h	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,135 @@
+/*
+ * Copyright (C) 2006 Intel Corp.
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
+	struct mutex rpc_mutex;		/* 
+					 * only one thread could do
+					 * recovery on the same
+					 * root port hierachy
+					 */
+	wait_queue_head_t wait_release;
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
+extern void aer_enable_rootport(struct aer_rpc *rpc);
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
--- linux-2.6.18-rc3/drivers/pci/pcie/aer/aerdrv.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/aerdrv.c	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,346 @@
+/*
+ * drivers/pci/pcie/aer/aerdrv.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This file implements the AER root port service driver. The driver will
+ * register an irq handler. When root port triggers an AER interrupt, the irq
+ * handler will collect root port status and schedule a work.
+ *
+ * Copyright (C) 2006 Intel Corp.
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
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/pcieport_if.h>
+
+#include "aerdrv.h"
+
+/*
+ * Version Information
+ */
+#define DRIVER_VERSION "v1.0"
+#define DRIVER_AUTHOR "tom.l.nguyen@intel.com"
+#define DRIVER_DESC "Root Port Advanced Error Reporting Driver"
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+static int __devinit aer_probe (struct pcie_device *dev,
+	const struct pcie_port_service_id *id );
+static void aer_remove(struct pcie_device *dev);
+static int aer_suspend(struct pcie_device *dev, pm_message_t state)
+{return 0;}
+static int aer_resume(struct pcie_device *dev) {return 0;}
+static pci_ers_result_t aer_error_detected(struct pci_dev *dev,
+	enum pci_channel_state error);
+static void aer_error_resume(struct pci_dev *dev);
+static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
+
+/*
+ * PCI Express bus's AER Root service driver data structure
+ */
+static struct pcie_port_service_id aer_id[] = {
+	{
+	.vendor 	= PCI_ANY_ID, 
+	.device 	= PCI_ANY_ID,
+	.port_type 	= PCIE_RC_PORT, 
+	.service_type 	= PCIE_PORT_SERVICE_AER,
+	},
+	{ /* end: all zeroes */ }
+};
+
+static struct pci_error_handlers aer_error_handlers = {
+	.error_detected = aer_error_detected,
+	.resume = aer_error_resume,
+};
+
+static struct pcie_port_service_driver aerdrv = {
+	.name		= "aer",
+	.id_table	= &aer_id[0],
+
+	.probe		= aer_probe,
+	.remove		= aer_remove,
+
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
+
+	.err_handler	= &aer_error_handlers,
+
+	.reset_link	= aer_root_reset,
+};
+
+/**
+ * aer_irq - Root Port's ISR
+ * @irq: IRQ assigned to Root Port
+ * @context: pointer to Root Port data structure
+ * @r: pointer struct pt_regs
+ *
+ * Invoked when Root Port detects AER messages.
+ **/
+static irqreturn_t aer_irq(int irq, void *context, struct pt_regs * r)
+{
+	unsigned int status, id;
+	struct pcie_device *pdev = (struct pcie_device *)context;
+	struct aer_rpc *rpc = get_service_data(pdev);
+	int next_prod_idx;
+	unsigned long flags;
+	int pos;
+
+	pos = pci_find_aer_capability(pdev->port);
+	/* 
+	 * Must lock access to Root Error Status Reg, Root Error ID Reg, 
+	 * and Root error producer/consumer index 
+	 */
+	spin_lock_irqsave(&rpc->e_lock, flags);
+
+	/* Read error status */
+	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, &status);
+	if (!(status & ROOT_ERR_STATUS_MASKS)) {
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return IRQ_NONE;
+	}
+
+	/* Read error source and clear error status */
+	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_COR_SRC, &id);
+	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
+
+	/* Store error source for later DPC handler */
+	next_prod_idx = rpc->prod_idx + 1;
+	if (next_prod_idx == AER_ERROR_SOURCES_MAX)
+		next_prod_idx = 0;
+	if (next_prod_idx == rpc->cons_idx) {
+		/* 
+		 * Error Storm Condition - possibly the same error occurred.
+		 * Drop the error.
+		 */
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return IRQ_HANDLED;
+	}
+	rpc->e_sources[rpc->prod_idx].status =  status;
+	rpc->e_sources[rpc->prod_idx].id = id;
+	rpc->prod_idx = next_prod_idx;
+	spin_unlock_irqrestore(&rpc->e_lock, flags);
+
+	/*  Invoke DPC handler */
+	schedule_work(&rpc->dpc_handler);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * aer_alloc_rpc - allocate Root Port data structure
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Invoked when Root Port's AER service is loaded.
+ **/
+static struct aer_rpc* aer_alloc_rpc(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc;
+
+	if (!(rpc = (struct aer_rpc *)kmalloc(sizeof(struct aer_rpc), 
+		GFP_KERNEL)))
+		return NULL;
+
+	memset(rpc, 0, sizeof(struct aer_rpc));
+	/* 
+	 * Initialize Root lock access, e_lock, to Root Error Status Reg, 
+	 * Root Error ID Reg, and Root error producer/consumer index. 
+	 */
+	rpc->e_lock = SPIN_LOCK_UNLOCKED;
+
+	rpc->rpd = dev;
+	INIT_WORK(&rpc->dpc_handler, aer_isr, (void *)dev);
+	rpc->prod_idx = rpc->cons_idx = 0;
+	mutex_init(&rpc->rpc_mutex);
+	init_waitqueue_head(&rpc->wait_release);
+
+	/* Use PCIE bus function to store rpc into PCIE device */
+	set_service_data(dev, rpc);
+
+	return rpc;
+}
+
+/**
+ * aer_remove - clean up resources
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Invoked when PCI Express bus unloads or AER probe fails.
+ **/
+static void aer_remove(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	if (rpc) {
+		/* If register interrupt service, it must be free. */
+		if (rpc->isr)
+			free_irq(dev->irq, dev);
+
+		wait_event(rpc->wait_release, rpc->prod_idx == rpc->cons_idx);
+
+		aer_delete_rootport(rpc);
+		set_service_data(dev, NULL);
+	}
+}
+
+/**
+ * aer_probe - initialize resources
+ * @dev: pointer to the pcie_dev data structure
+ * @id: pointer to the service id data structure
+ *
+ * Invoked when PCI Express bus loads AER service driver.
+ **/
+static int __devinit aer_probe (struct pcie_device *dev, 
+				const struct pcie_port_service_id *id )
+{
+	int status;
+	struct aer_rpc *rpc;
+	struct device *device = &dev->device;
+
+	/* Init */
+	if ((status = aer_init(dev)))
+		return status;
+
+	/* Alloc rpc data structure */
+	if (!(rpc = aer_alloc_rpc(dev))) {
+		printk(KERN_DEBUG "%s: Alloc rpc fails on PCIE device[%s]\n",
+			__FUNCTION__, device->bus_id);
+		aer_remove(dev);
+		return -ENOMEM;
+	}
+
+	/* Request IRQ ISR */
+	if ((status = request_irq(dev->irq, aer_irq, SA_SHIRQ, "aerdrv", 
+				dev))) {
+		printk(KERN_DEBUG "%s: Request ISR fails on PCIE device[%s]\n", 
+			__FUNCTION__, device->bus_id);
+		aer_remove(dev);
+		return status;
+	}
+
+	rpc->isr = 1;
+
+	aer_enable_rootport(rpc);
+
+	return status;
+}
+
+/**
+ * aer_root_reset - reset link on Root Port
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver when performing link reset at Root Port.
+ **/
+static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
+{
+	u16 p2p_ctrl;
+	u32 status;
+	int pos;
+
+	pos = pci_find_aer_capability(dev);
+
+	/* Disable Root's interrupt in response to error messages */ 
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, 0);
+
+	/* Assert Secondary Bus Reset */
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &p2p_ctrl);
+	p2p_ctrl |= PCI_CB_BRIDGE_CTL_CB_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, p2p_ctrl);
+
+	/* De-assert Secondary Bus Reset */
+	p2p_ctrl &= ~PCI_CB_BRIDGE_CTL_CB_RESET;
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, p2p_ctrl);
+
+	/* 
+	 * System software must wait for at least 100ms from the end 
+	 * of a reset of one or more device before it is permitted
+	 * to issue Configuration Requests to those devices.
+	 */
+	msleep(200);
+	printk(KERN_DEBUG "Complete link reset at Root[%s]\n", dev->dev.bus_id);
+
+	/* Enable Root Port's interrupt in response to error messages */ 
+	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, status);
+	pci_write_config_dword(dev,
+		pos + PCI_ERR_ROOT_COMMAND,
+		ROOT_PORT_INTR_ON_MESG_MASK);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * aer_error_detected - update severity status
+ * @dev: pointer to Root Port's pci_dev data structure
+ * @error: error severity being notified by port bus
+ *
+ * Invoked by Port Bus driver during error recovery.
+ **/
+static pci_ers_result_t aer_error_detected(struct pci_dev *dev,
+			enum pci_channel_state error)
+{
+	/* Root Port has no impact. Always recovers. */
+	return PCI_ERS_RESULT_CAN_RECOVER;
+}
+
+/**
+ * aer_error_resume - clean up corresponding error status bits
+ * @dev: pointer to Root Port's pci_dev data structure
+ *
+ * Invoked by Port Bus driver during nonfatal recovery.
+ **/
+static void aer_error_resume(struct pci_dev *dev)
+{
+	int pos;
+	u32 status, mask;
+	u16 reg16;
+
+	/* Clean up Root device status */
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	pci_read_config_word(dev, pos + PCI_EXP_DEVSTA, &reg16);
+	pci_write_config_word(dev, pos + PCI_EXP_DEVSTA, reg16);
+
+	/* Clean AER Root Error Status */
+	pos = pci_find_aer_capability(dev);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
+	if (dev->error_state == pci_channel_io_normal)
+		status &= ~mask; /* Clear corresponding nonfatal bits */
+	else
+		status &= mask; /* Clear corresponding fatal bits */
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+}
+
+/**
+ * aer_service_init - register AER root service driver
+ *
+ * Invoked when AER root service driver is loaded.
+ **/
+static int __init aer_service_init(void)
+{
+	return pcie_port_service_register(&aerdrv);
+}
+
+/**
+ * aer_service_exit - unregister AER root service driver
+ *
+ * Invoked when AER root service driver is unloaded.
+ **/
+static void __exit aer_service_exit(void) 
+{
+	pcie_port_service_unregister(&aerdrv);
+}
+
+module_init(aer_service_init);
+module_exit(aer_service_exit);
--- linux-2.6.18-rc3/drivers/pci/pcie/aer/Kconfig	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/Kconfig	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,12 @@
+#
+# PCI Express Root Port Device AER Configuration
+#
+
+config PCIEAER
+	boolean "Root Port Advanced Error Reporting support"
+	depends on PCIEPORTBUS 
+	default y
+	help
+	  This enables PCI Express Root Port Advanced Error Reporting
+	  (AER) driver support. Error reporting messages sent to Root
+	  Port will be handled by PCI Express AER driver.
--- linux-2.6.18-rc3/drivers/pci/pcie/aer/Makefile	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/Makefile	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,10 @@
+#
+# Makefile for PCI-Express Root Port Advanced Error Reporting Driver
+#
+
+obj-$(CONFIG_PCIEAER)		+= aerdriver.o
+aerdrv_acpi-$(CONFIG_ACPI)	+= aerdrv_acpi.o
+
+aerdriver-objs		:= aerdrv_errprint.o aerdrv_core.o aerdrv.o
+aerdriver-objs		+= $(aerdrv_acpi-y)
+
--- linux-2.6.18-rc3/drivers/pci/pcie/Kconfig	2006-07-31 14:38:48.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/Kconfig	2006-07-31 14:43:34.000000000 +0800
@@ -34,3 +34,4 @@ config HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
 	   
 	  When in doubt, say N.
 
+source "drivers/pci/pcie/aer/Kconfig"
--- linux-2.6.18-rc3/drivers/pci/pcie/Makefile	2006-07-31 14:38:48.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/Makefile	2006-07-31 14:43:34.000000000 +0800
@@ -5,3 +5,6 @@
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
+
+# Build PCI Express AER if needed
+obj-$(CONFIG_PCIEAER)		+= aer/
--- linux-2.6.18-rc3/drivers/pci/pcie/aer/aerdrv_errprint.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18-rc3_aer/drivers/pci/pcie/aer/aerdrv_errprint.c	2006-07-31 14:43:34.000000000 +0800
@@ -0,0 +1,248 @@
+/*
+ * drivers/pci/pcie/aer/aerdrv_errprint.c
+ * 
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Format error messages and print them to console.
+ * 
+ * Copyright (C) 2006 Intel Corp. 
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
+
+#include "aerdrv.h"
+
+#define AER_AGENT_RECEIVER		0
+#define AER_AGENT_REQUESTER		1
+#define AER_AGENT_COMPLETER		2
+#define AER_AGENT_TRANSMITTER		3		
+
+#define AER_AGENT_REQUESTER_MASK	(PCI_ERR_UNC_COMP_TIME|	\
+					PCI_ERR_UNC_UNSUP)
+
+#define AER_AGENT_COMPLETER_MASK	PCI_ERR_UNC_COMP_ABORT
+
+#define AER_AGENT_TRANSMITTER_MASK(t, e) (e & (PCI_ERR_COR_REP_ROLL| \
+	((t == AER_CORRECTABLE) ? PCI_ERR_COR_REP_TIMER: 0))) 
+
+#define AER_GET_AGENT(t, e)						\
+	((e & AER_AGENT_COMPLETER_MASK) ? AER_AGENT_COMPLETER :		\
+	(e & AER_AGENT_REQUESTER_MASK) ? AER_AGENT_REQUESTER :		\
+	(AER_AGENT_TRANSMITTER_MASK(t, e)) ? AER_AGENT_TRANSMITTER :	\
+	AER_AGENT_RECEIVER)
+
+#define AER_PHYSICAL_LAYER_ERROR_MASK	PCI_ERR_COR_RCVR
+#define AER_DATA_LINK_LAYER_ERROR_MASK(t, e)	\
+		(PCI_ERR_UNC_DLP|		\
+		PCI_ERR_COR_BAD_TLP| 		\
+		PCI_ERR_COR_BAD_DLLP|		\
+		PCI_ERR_COR_REP_ROLL| 		\
+		((t == AER_CORRECTABLE) ?	\
+		PCI_ERR_COR_REP_TIMER: 0))
+
+#define AER_PHYSICAL_LAYER_ERROR	0
+#define AER_DATA_LINK_LAYER_ERROR	1
+#define AER_TRANSACTION_LAYER_ERROR	2
+
+#define AER_GET_LAYER_ERROR(t, e)				\
+	((e & AER_PHYSICAL_LAYER_ERROR_MASK) ?			\
+	AER_PHYSICAL_LAYER_ERROR :				\
+	(e & AER_DATA_LINK_LAYER_ERROR_MASK(t, e)) ?		\
+		AER_DATA_LINK_LAYER_ERROR : 			\
+		AER_TRANSACTION_LAYER_ERROR)
+
+/* 
+ * AER error strings 
+ */
+static char* aer_error_severity_string[] = {
+	"Uncorrected (Non-Fatal)", 
+	"Uncorrected (Fatal)",
+	"Corrected"
+};
+
+static char* aer_error_layer[] = {
+	"Physical Layer",
+	"Data Link Layer",
+	"Transaction Layer" 
+};
+static char* aer_correctable_error_string[] = {
+	"Receiver Error        ",	/* Bit Position 0 	*/
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"Bad TLP               ",	/* Bit Position 6 	*/
+	"Bad DLLP              ",	/* Bit Position 7 	*/
+	"RELAY_NUM Rollover    ",	/* Bit Position 8 	*/
+	NULL,
+	NULL,
+	NULL,
+	"Replay Timer Timeout  ",	/* Bit Position 12 	*/
+	"Advisory Non-Fatal    ", 	/* Bit Position 13	*/
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static char* aer_uncorrectable_error_string[] = {
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"Data Link Protocol    ",	/* Bit Position 4	*/
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"Poisoned TLP          ",	/* Bit Position 12 	*/
+	"Flow Control Protocol ",	/* Bit Position 13	*/
+	"Completion Timeout    ",	/* Bit Position 14 	*/
+	"Completer Abort       ",	/* Bit Position 15 	*/
+	"Unexpected Completion ",	/* Bit Position 16	*/
+	"Receiver Overflow     ",	/* Bit Position 17	*/
+	"Malformed TLP         ",	/* Bit Position 18	*/
+	"ECRC                  ",	/* Bit Position 19	*/
+	"Unsupported Request   ",	/* Bit Position 20	*/
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+};
+
+static char* aer_agent_string[] = {
+	"Receiver ID",
+	"Requester ID",
+	"Completer ID",
+	"Transmitter ID"
+};
+
+static char * aer_get_error_source_name(int severity,
+			unsigned int status,
+			char errmsg_buff[])
+{
+	int i;
+	char * errmsg = NULL;
+
+	for (i = 0; i < 32; i++) {
+		if (!(status & (1 << i)))
+			continue;
+
+		if (severity == AER_CORRECTABLE)
+			errmsg = aer_correctable_error_string[i];
+		else
+			errmsg = aer_uncorrectable_error_string[i];
+
+		if (!errmsg) {
+			sprintf(errmsg_buff, "Unknown Error Bit %2d  ", i);
+			errmsg = errmsg_buff;
+		}
+
+		break;
+	}
+
+	return errmsg;
+}
+
+static DEFINE_SPINLOCK(logbuf_lock);
+static char errmsg_buff[100];
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	char * errmsg;
+	int err_layer, agent;
+	char * loglevel;
+
+	if (info->severity == AER_CORRECTABLE)
+		loglevel = KERN_WARNING;
+	else
+		loglevel = KERN_ERR;
+
+	printk("%s+------ PCI-Express Device Error ------+\n", loglevel);
+	printk("%sError Severity\t\t: %s\n", loglevel,
+		aer_error_severity_string[info->severity]);
+
+	if ( info->status == 0) {
+		printk("%sPCIE Bus Error type\t: (Unaccessible)\n", loglevel);
+		printk("%sUnaccessible Received\t: %s\n", loglevel,
+			info->flags & AER_MULTI_ERROR_VALID_FLAG ?
+				"Multiple" : "First");
+		printk("%sUnregistered Agent ID\t: %04x\n", loglevel,
+			(dev->bus->number << 8) | dev->devfn);
+	} else {
+		err_layer = AER_GET_LAYER_ERROR(info->severity, info->status);
+		printk("%sPCIE Bus Error type\t: %s\n", loglevel,
+			aer_error_layer[err_layer]);
+
+		spin_lock(&logbuf_lock);
+		errmsg = aer_get_error_source_name(info->severity,
+				info->status,
+				errmsg_buff);
+		printk("%s%s\t: %s\n", loglevel, errmsg,
+			info->flags & AER_MULTI_ERROR_VALID_FLAG ?
+				"Multiple" : "First");
+		spin_unlock(&logbuf_lock);
+
+		agent = AER_GET_AGENT(info->severity, info->status);
+		printk("%s%s\t\t: %04x\n", loglevel,
+			aer_agent_string[agent],
+			(dev->bus->number << 8) | dev->devfn);
+
+		printk("%sVendorID=%04xh, DeviceID=%04xh,"
+			" Bus=%02xh, Device=%02xh, Function=%02xh\n",
+			loglevel,
+			dev->vendor,
+			dev->device,
+			dev->bus->number,
+			PCI_SLOT(dev->devfn),
+			PCI_FUNC(dev->devfn));
+
+		if (info->flags & AER_TLP_HEADER_VALID_FLAG) {
+			unsigned char *tlp = (unsigned char *) &info->tlp;
+			printk("%sTLB Header:\n", loglevel);
+			printk("%s%02x%02x%02x%02x %02x%02x%02x%02x"
+				" %02x%02x%02x%02x %02x%02x%02x%02x\n",
+				loglevel,
+				*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
+				*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
+				*(tlp + 11), *(tlp + 10), *(tlp + 9),
+				*(tlp + 8), *(tlp + 15), *(tlp + 14),
+				*(tlp + 13), *(tlp + 12));
+		}
+	}
+}
+
