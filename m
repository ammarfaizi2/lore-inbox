Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVCRWXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVCRWXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVCRWWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:22:33 -0500
Received: from fmr22.intel.com ([143.183.121.14]:45278 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262414AbVCRWSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:18:39 -0500
Date: Fri, 18 Mar 2005 14:18:30 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 10/12] Allow ACPI .add and .start operations to be done independently
Message-ID: <20050318141829.J1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create new interfaces to recursively add an acpi namespace object
to the acpi device list, and recursively start the namespace 
object. This is needed for ACPI based hotplug of a root bridge
hierarchy where the add operation must be performed first and 
the start operation must be performed separately after the 
hot-plugged devices have been properly configured.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/container.c      |    2 
 linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/processor_core.c |    2 
 linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/scan.c           |  126 ++++++++++---
 linux-2.6.11-mm4-iohp-rshah1/include/acpi/acpi_bus.h       |   17 +
 4 files changed, 119 insertions(+), 28 deletions(-)

diff -puN drivers/acpi/scan.c~acpi_separate_device_start drivers/acpi/scan.c
--- linux-2.6.11-mm4-iohp/drivers/acpi/scan.c~acpi_separate_device_start	2005-03-16 13:07:34.326499309 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/scan.c	2005-03-16 13:07:34.452475870 -0800
@@ -553,20 +553,29 @@ acpi_bus_driver_init (
 	 * upon possible configuration and currently allocated resources.
 	 */
 
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Driver successfully bound to device\n"));
+	return_VALUE(0);
+}
+
+int
+acpi_start_single_object (
+		struct acpi_device *device)
+{
+	int result = 0;
+	struct acpi_driver *driver;
+
+	ACPI_FUNCTION_TRACE("acpi_start_single_object");
+
+	if (!(driver = device->driver))
+		return_VALUE(0);
+
 	if (driver->ops.start) {
 		result = driver->ops.start(device);
 		if (result && driver->ops.remove)
 			driver->ops.remove(device, ACPI_BUS_REMOVAL_NORMAL);
-		return_VALUE(result);
-	}
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Driver successfully bound to device\n"));
-
-	if (driver->ops.scan) {
-		driver->ops.scan(device);
 	}
 
-	return_VALUE(0);
+	return_VALUE(result);
 }
 
 static int acpi_driver_attach(struct acpi_driver * drv)
@@ -586,6 +595,7 @@ static int acpi_driver_attach(struct acp
 
 		if (!acpi_bus_match(dev, drv)) {
 			if (!acpi_bus_driver_init(dev, drv)) {
+				acpi_start_single_object(dev);
 				atomic_inc(&drv->references);
 				count++;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
@@ -1009,8 +1019,8 @@ acpi_bus_remove (
 }
 
 
-int
-acpi_bus_add (
+static int
+acpi_add_single_object (
 	struct acpi_device	**child,
 	struct acpi_device	*parent,
 	acpi_handle		handle,
@@ -1019,7 +1029,7 @@ acpi_bus_add (
 	int			result = 0;
 	struct acpi_device	*device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_bus_add");
+	ACPI_FUNCTION_TRACE("acpi_add_single_object");
 
 	if (!child)
 		return_VALUE(-EINVAL);
@@ -1140,7 +1150,7 @@ acpi_bus_add (
 	 *
 	 * TBD: Assumes LDM provides driver hot-plug capability.
 	 */
-	acpi_bus_find_driver(device);
+	result = acpi_bus_find_driver(device);
 
 end:
 	if (!result)
@@ -1153,10 +1163,10 @@ end:
 
 	return_VALUE(result);
 }
-EXPORT_SYMBOL(acpi_bus_add);
 
 
-int acpi_bus_scan (struct acpi_device	*start)
+static int acpi_bus_scan (struct acpi_device	*start,
+		struct acpi_bus_ops *ops)
 {
 	acpi_status		status = AE_OK;
 	struct acpi_device	*parent = NULL;
@@ -1229,9 +1239,20 @@ int acpi_bus_scan (struct acpi_device	*s
 			continue;
 		}
 
-		status = acpi_bus_add(&child, parent, chandle, type);
-		if (ACPI_FAILURE(status))
-			continue;
+		if (ops->acpi_op_add)
+			status = acpi_add_single_object(&child, parent,
+					chandle, type);
+		 else
+			status = acpi_bus_get_device(chandle, &child);
+
+		 if (ACPI_FAILURE(status))
+			 continue;
+
+		if (ops->acpi_op_start) {
+			status = acpi_start_single_object(child);
+			if (ACPI_FAILURE(status))
+				continue;
+		}
 
 		/*
 		 * If the device is present, enabled, and functioning then
@@ -1257,8 +1278,50 @@ int acpi_bus_scan (struct acpi_device	*s
 
 	return_VALUE(0);
 }
-EXPORT_SYMBOL(acpi_bus_scan);
 
+int
+acpi_bus_add (
+	struct acpi_device	**child,
+	struct acpi_device	*parent,
+	acpi_handle		handle,
+	int			type)
+{
+	int result;
+	struct acpi_bus_ops ops;
+
+	ACPI_FUNCTION_TRACE("acpi_bus_add");
+
+	result = acpi_add_single_object(child, parent, handle, type);
+	if (!result) {
+		memset(&ops, 0, sizeof(ops));
+		ops.acpi_op_add = 1;
+		result = acpi_bus_scan(*child, &ops);
+	}
+	return_VALUE(result);
+}
+EXPORT_SYMBOL(acpi_bus_add);
+
+int
+acpi_bus_start (
+	struct acpi_device *device)
+{
+	int result;
+	struct acpi_bus_ops ops;
+
+	ACPI_FUNCTION_TRACE("acpi_bus_start");
+
+	if (!device)
+		return_VALUE(-EINVAL);
+
+	result = acpi_start_single_object(device);
+	if (!result) {
+		memset(&ops, 0, sizeof(ops));
+		ops.acpi_op_start = 1;
+		result = acpi_bus_scan(device, &ops);
+	}
+	return_VALUE(result);
+}
+EXPORT_SYMBOL(acpi_bus_start);
 
 static int
 acpi_bus_trim(struct acpi_device	*start,
@@ -1331,13 +1394,19 @@ acpi_bus_scan_fixed (
 	/*
 	 * Enumerate all fixed-feature devices.
 	 */
-	if (acpi_fadt.pwr_button == 0)
-		result = acpi_bus_add(&device, acpi_root, 
+	if (acpi_fadt.pwr_button == 0) {
+		result = acpi_add_single_object(&device, acpi_root,
 			NULL, ACPI_BUS_TYPE_POWER_BUTTON);
+		if (!result)
+			result = acpi_start_single_object(device);
+	}
 
-	if (acpi_fadt.sleep_button == 0)
-		result = acpi_bus_add(&device, acpi_root, 
+	if (acpi_fadt.sleep_button == 0) {
+		result = acpi_add_single_object(&device, acpi_root,
 			NULL, ACPI_BUS_TYPE_SLEEP_BUTTON);
+		if (!result)
+			result = acpi_start_single_object(device);
+	}
 
 	return_VALUE(result);
 }
@@ -1346,6 +1415,7 @@ acpi_bus_scan_fixed (
 static int __init acpi_scan_init(void)
 {
 	int result;
+	struct acpi_bus_ops ops;
 
 	ACPI_FUNCTION_TRACE("acpi_scan_init");
 
@@ -1357,17 +1427,23 @@ static int __init acpi_scan_init(void)
 	/*
 	 * Create the root device in the bus's device tree
 	 */
-	result = acpi_bus_add(&acpi_root, NULL, ACPI_ROOT_OBJECT, 
+	result = acpi_add_single_object(&acpi_root, NULL, ACPI_ROOT_OBJECT,
 		ACPI_BUS_TYPE_SYSTEM);
 	if (result)
 		goto Done;
 
+	result = acpi_start_single_object(acpi_root);
+
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
 	result = acpi_bus_scan_fixed(acpi_root);
-	if (!result) 
-		result = acpi_bus_scan(acpi_root);
+	if (!result) {
+		memset(&ops, 0, sizeof(ops));
+		ops.acpi_op_add = 1;
+		ops.acpi_op_start = 1;
+		result = acpi_bus_scan(acpi_root, &ops);
+	}
 
 	if (result)
 		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
diff -puN include/acpi/acpi_bus.h~acpi_separate_device_start include/acpi/acpi_bus.h
--- linux-2.6.11-mm4-iohp/include/acpi/acpi_bus.h~acpi_separate_device_start	2005-03-16 13:07:34.330405559 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/include/acpi/acpi_bus.h	2005-03-16 13:07:34.453452432 -0800
@@ -108,6 +108,21 @@ typedef int (*acpi_op_unbind)	(struct ac
 typedef int (*acpi_op_match)	(struct acpi_device *device,
 				 struct acpi_driver *driver);
 
+struct acpi_bus_ops {
+	u32 			acpi_op_add:1;
+	u32			acpi_op_remove:1;
+	u32			acpi_op_lock:1;
+	u32			acpi_op_start:1;
+	u32			acpi_op_stop:1;
+	u32			acpi_op_suspend:1;
+	u32			acpi_op_resume:1;
+	u32			acpi_op_scan:1;
+	u32			acpi_op_bind:1;
+	u32			acpi_op_unbind:1;
+	u32			acpi_op_match:1;
+	u32			reserved:21;
+};
+
 struct acpi_device_ops {
 	acpi_op_add		add;
 	acpi_op_remove		remove;
@@ -327,9 +342,9 @@ int acpi_bus_generate_event (struct acpi
 int acpi_bus_receive_event (struct acpi_bus_event *event);
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
-int acpi_bus_scan (struct acpi_device *start);
 int acpi_bus_add (struct acpi_device **child, struct acpi_device *parent,
 		acpi_handle handle, int type);
+int acpi_bus_start (struct acpi_device *device);
 
 
 int acpi_match_ids (struct acpi_device	*device, char	*ids);
diff -puN drivers/acpi/container.c~acpi_separate_device_start drivers/acpi/container.c
--- linux-2.6.11-mm4-iohp/drivers/acpi/container.c~acpi_separate_device_start	2005-03-16 13:07:34.335288371 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/container.c	2005-03-16 13:07:34.454428995 -0800
@@ -153,7 +153,7 @@ container_device_add(struct acpi_device 
 		return_VALUE(-ENODEV);
 	}
 
-	result = acpi_bus_scan(*device);
+	result = acpi_bus_start(*device);
 
 	return_VALUE(result);
 }
diff -puN drivers/acpi/processor_core.c~acpi_separate_device_start drivers/acpi/processor_core.c
--- linux-2.6.11-mm4-iohp/drivers/acpi/processor_core.c~acpi_separate_device_start	2005-03-16 13:07:34.339194621 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/processor_core.c	2005-03-16 13:07:34.455405557 -0800
@@ -723,7 +723,7 @@ int acpi_processor_device_add(
 		return_VALUE(-ENODEV);
 	}
 
-	acpi_bus_scan(*device);
+	acpi_bus_start(*device);
 
 	pr = acpi_driver_data(*device);
 	if (!pr)
_
