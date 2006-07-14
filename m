Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWGNFh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWGNFh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 01:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWGNFh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 01:37:58 -0400
Received: from mga07.intel.com ([143.182.124.22]:60848 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161210AbWGNFh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 01:37:57 -0400
X-IronPort-AV: i="4.06,239,1149490800"; 
   d="scan'208"; a="65802431:sNHT72118746"
Subject: Re: [PATCH 5/5] PCI-Express AER implemetation: pcie_portdrv error
	handler
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1152855124.28493.297.camel@ymzhang-perf.sh.intel.com>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	 <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
	 <1152854873.28493.289.camel@ymzhang-perf.sh.intel.com>
	 <1152854937.28493.291.camel@ymzhang-perf.sh.intel.com>
	 <1152855040.28493.294.camel@ymzhang-perf.sh.intel.com>
	 <1152855124.28493.297.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1152855338.28493.300.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 14 Jul 2006 13:35:38 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry. The patch number in subject is incorrect. Resend the last patch.

From: Zhang, Yanmin <yanmin.zhang@intel.com>

Patch 5 implements error handlers for pcie_portdrv.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.17/drivers/pci/pcie/portdrv_pci.c	2006-06-22 16:27:35.000000000 +0800
+++ linux-2.6.17_aer/drivers/pci/pcie/portdrv_pci.c	2006-06-22 16:46:29.000000000 +0800
@@ -14,8 +14,10 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/pcieport_if.h>
+#include <linux/aer.h>
 
 #include "portdrv.h"
+#include "aer/aerdrv.h"
 
 /*
  * Version Information
@@ -76,6 +78,8 @@ static int __devinit pcie_portdrv_probe 
 	if (pcie_port_device_register(dev)) 
 		return -ENOMEM;
 
+	pci_enable_pcie_error_reporting(dev);
+
 	return 0;
 }
 
@@ -102,6 +106,146 @@ static int pcie_portdrv_resume (struct p
 }
 #endif
 
+static int error_detected_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+	struct aer_broadcast_data *result_data;
+	pci_ers_result_t status;
+
+	result_data = (struct aer_broadcast_data *) data;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (!driver ||
+			!driver->err_handler ||
+			!driver->err_handler->error_detected)
+			return 0;
+
+		pcie_device = to_pcie_device(device);
+
+		/* Forward error detected message to service drivers */
+		status = driver->err_handler->error_detected(
+			pcie_device->port,
+			result_data->state);
+		result_data->result =
+			merge_result(result_data->result, status);
+	}
+
+	return 0;
+}
+
+static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
+					enum pci_channel_state error)
+{
+	struct aer_broadcast_data result_data =
+			{error, PCI_ERS_RESULT_CAN_RECOVER};
+	
+	device_for_each_child(&dev->dev, &result_data, error_detected_iter);
+
+	/* If fatal, save cfg space for possible link reset at upstream */
+	if (error == pci_channel_io_frozen)
+		pcie_portdrv_save_config(dev);
+
+	return result_data.result;
+}
+
+static int mmio_enabled_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+	pci_ers_result_t status, *result;
+
+	result = (pci_ers_result_t *) data;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver &&
+			driver->err_handler &&
+			driver->err_handler->mmio_enabled) {
+			pcie_device = to_pcie_device(device);
+
+			/* Forward error message to service drivers */
+			status = driver->err_handler->mmio_enabled(
+					pcie_device->port);
+			*result = merge_result(*result, status);
+		}
+	}
+
+	return 0;
+}
+
+static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
+{
+	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
+
+	device_for_each_child(&dev->dev, &status, mmio_enabled_iter);
+	return status;
+}
+
+static int slot_reset_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+	pci_ers_result_t status, *result;
+
+	result = (pci_ers_result_t *) data;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver &&
+			driver->err_handler &&
+			driver->err_handler->slot_reset) {
+			pcie_device = to_pcie_device(device);
+
+			/* Forward error message to service drivers */
+			status = driver->err_handler->slot_reset(
+					pcie_device->port);
+			*result = merge_result(*result, status);
+		}
+	}
+
+	return 0;
+}
+
+static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
+{
+	pci_ers_result_t status;
+
+	/* If fatal, restore cfg space for possible link reset at upstream */
+	if (dev->error_state == pci_channel_io_frozen)
+		pcie_portdrv_restore_config(dev);
+
+	device_for_each_child(&dev->dev, &status, slot_reset_iter);
+
+	return status;
+}
+
+static int resume_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver &&
+			driver->err_handler &&
+			driver->err_handler->resume) { 
+			pcie_device = to_pcie_device(device);
+
+			/* Forward error message to service drivers */
+			driver->err_handler->resume(pcie_device->port);
+		}
+	}
+
+	return 0;
+}
+
+static void pcie_portdrv_err_resume(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, NULL, resume_iter);
+}
+
 /*
  * LINUX Device Driver Model
  */
@@ -112,6 +256,13 @@ static const struct pci_device_id port_p
 };
 MODULE_DEVICE_TABLE(pci, port_pci_ids);
 
+static struct pci_error_handlers pcie_portdrv_err_handler = {
+		.error_detected = pcie_portdrv_error_detected,
+		.mmio_enabled = pcie_portdrv_mmio_enabled,
+		.slot_reset = pcie_portdrv_slot_reset,
+		.resume = pcie_portdrv_err_resume,
+};
+
 static struct pci_driver pcie_portdrv = {
 	.name		= (char *)device_name,
 	.id_table	= &port_pci_ids[0],
@@ -123,6 +274,8 @@ static struct pci_driver pcie_portdrv = 
 	.suspend	= pcie_portdrv_suspend,
 	.resume		= pcie_portdrv_resume,
 #endif	/* PM */
+
+	.err_handler 	= &pcie_portdrv_err_handler,
 };
 
 static int __init pcie_portdrv_init(void)
