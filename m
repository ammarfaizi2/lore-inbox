Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVF1F63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVF1F63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVF1FtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:49:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:15084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261713AbVF1Fdh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:37 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Allow ACPI .add and .start operations to be done independently
In-Reply-To: <11199367732527@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <11199367731380@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Allow ACPI .add and .start operations to be done independently

Create new interfaces to recursively add an acpi namespace object to the acpi
device list, and recursively start the namespace object.  This is needed for
ACPI based hotplug of a root bridge hierarchy where the add operation must be
performed first and the start operation must be performed separately after the
hot-plugged devices have been properly configured.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3fb02738b0fd36f47710a2bf207129efd2f5daa2
tree 56bd70ea1b957b601402745ee03b4c1b293ab23b
parent f7d473d919627262816459f8dba70d72812be074
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:52 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:42 -0700

 drivers/acpi/container.c      |    2 -
 drivers/acpi/processor_core.c |    2 -
 drivers/acpi/scan.c           |  126 +++++++++++++++++++++++++++++++++--------
 include/acpi/acpi_bus.h       |   17 +++++-
 4 files changed, 119 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -153,7 +153,7 @@ container_device_add(struct acpi_device 
 		return_VALUE(-ENODEV);
 	}
 
-	result = acpi_bus_scan(*device);
+	result = acpi_bus_start(*device);
 
 	return_VALUE(result);
 }
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -723,7 +723,7 @@ int acpi_processor_device_add(
 		return_VALUE(-ENODEV);
 	}
 
-	acpi_bus_scan(*device);
+	acpi_bus_start(*device);
 
 	pr = acpi_driver_data(*device);
 	if (!pr)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
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
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
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

