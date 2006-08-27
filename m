Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWH0R6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWH0R6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWH0R6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:58:14 -0400
Received: from mx01.qsc.de ([213.148.129.14]:3465 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932214AbWH0R6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:58:11 -0400
Subject: [PATCH 2/2] acpi hotplug cleanups, move install notifier to add
	function
From: Thomas Renninger <mail@renninger.de>
Reply-To: mail@renninger.de
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: trenn@suse.de, akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       naveen.b.s@intel.com
In-Reply-To: <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
References: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com>
	 <1155643418.4302.1154.camel@queen.suse.de>
	 <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
Content-Type: multipart/mixed; boundary="=-xVMqEQU8vziYVJWUa8by"
Date: Sun, 27 Aug 2006 19:58:21 +0200
Message-Id: <1156701501.1852.20.camel@linux-1vxn.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xVMqEQU8vziYVJWUa8by
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-08-25 at 20:59 +0900, Yasunori Goto wrote:
> > I sent a patch a while ago that gets rid of the whole namespace walking
> > by making acpi_memoryhotplug an acpi device and making use of the .add
> > callback function and the acpi_bus_register_driver call.
> > 
> > I am not sure whether this is possible if you have multiple memory
> > devices, though (if not maybe it should be made possible?)...
> > 
> > Yasunori even tested the patch and sent an Ok:
> > http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2
> > 
> > If this is acceptable I can rebase the patch on a current kernel.
> 
> Hi. Thomas-san.
> Did you rebase your patch?
> 
> I'm trying to do it now too. 
> But, current code (2.6.18-rc4) seems to register handler for
> only enable status devices at boot time.
> So, notification is -discarded- due to no handler for new memory
> device when hot-add event occurs. Hmmm. :-(

Some more cleanups (on top of the last one)...
Compile tested, patched against 2.6.18-rc4.

acpi_memory_hotplug cleanups [2/2]

 - get rid of unused acpi_memory_device->state (is set, but never evaluated)
 - Make use of global acpi_bus_get_status(device) func instead of evaluate
   _STA with own func -> gets rid of acpi_memory_check_device and _STA defines
 - pass mem_device pointer as callback data to notify handler func
   -> get rid of acpi_memory_get_device()
 - check for availabe _STA and _EJ0/EJD early in acpi_memory_device_add(),
   those are mandotary for a working memory device

Signed-off-by: Thomas Renninger <mail@renninger.de>

 acpi_memhotplug.c |  155 +++++++++++-------------------------------------------
 1 file changed, 34 insertions(+), 121 deletions(-)

Index: linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
@@ -45,16 +45,6 @@ ACPI_MODULE_NAME("acpi_memory")
 MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-/* ACPI _STA method values */
-#define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
-#define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
-#define ACPI_MEMORY_STA_FUNCTIONAL	(0x00000008UL)
-
-/* Memory Device States */
-#define MEMORY_INVALID_STATE	0
-#define MEMORY_POWER_ON_STATE	1
-#define MEMORY_POWER_OFF_STATE	2
-
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
 static int acpi_memory_device_start(struct acpi_device *device);
@@ -81,7 +71,6 @@ struct acpi_memory_info {
 
 struct acpi_memory_device {
 	struct acpi_device * device;
-	unsigned int state;	/* State of the memory device */
 	struct list_head res_list;
 };
 
@@ -144,73 +133,6 @@ acpi_memory_get_device_resources(struct 
 	return 0;
 }
 
-static int
-acpi_memory_get_device(acpi_handle handle,
-		       struct acpi_memory_device **mem_device)
-{
-	acpi_status status;
-	acpi_handle phandle;
-	struct acpi_device *device = NULL;
-	struct acpi_device *pdevice = NULL;
-
-
-	if (!acpi_bus_get_device(handle, &device) && device)
-		goto end;
-
-	status = acpi_get_parent(handle, &phandle);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot find acpi parent"));
-		return -EINVAL;
-	}
-
-	/* Get the parent device */
-	status = acpi_bus_get_device(phandle, &pdevice);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot get acpi bus device"));
-		return -EINVAL;
-	}
-
-	/*
-	 * Now add the notified device.  This creates the acpi_device
-	 * and invokes .add function
-	 */
-	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot add acpi bus"));
-		return -EINVAL;
-	}
-
-      end:
-	*mem_device = acpi_driver_data(device);
-	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int acpi_memory_check_device(struct acpi_memory_device *mem_device)
-{
-	unsigned long current_status;
-
-
-	/* Get device present/absent information from the _STA */
-	if (ACPI_FAILURE(acpi_evaluate_integer(mem_device->device->handle, "_STA",
-					       NULL, &current_status)))
-		return -ENODEV;
-	/*
-	 * Check for device status. Device should be
-	 * present/enabled/functioning.
-	 */
-	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
-	      && (current_status & ACPI_MEMORY_STA_ENABLED)
-	      && (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))
-		return -ENODEV;
-
-	return 0;
-}
-
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	int result, num_enabled = 0;
@@ -222,7 +144,6 @@ static int acpi_memory_enable_device(str
 	result = acpi_memory_get_device_resources(mem_device);
 	if (result) {
 		printk(KERN_ERR PREFIX "get_device_resources failed\n");
-		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}
 
@@ -246,7 +167,6 @@ static int acpi_memory_enable_device(str
 	}
 	if (!num_enabled) {
 		printk(KERN_ERR PREFIX "add_memory failed\n");
-		mem_device->state = MEMORY_INVALID_STATE;
 		return -EINVAL;
 	}
 
@@ -257,16 +177,15 @@ static int acpi_memory_powerdown_device(
 {
 	acpi_status status;
 	struct acpi_object_list arg_list;
+	struct acpi_device *device = mem_device->device;
 	union acpi_object arg;
-	unsigned long current_status;
-
 
 	/* Issue the _EJ0 command */
 	arg_list.count = 1;
 	arg_list.pointer = &arg;
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = 1;
-	status = acpi_evaluate_object(mem_device->device->handle,
+	status = acpi_evaluate_object(device->handle,
 				      "_EJ0", &arg_list, NULL);
 	/* Return on _EJ0 failure */
 	if (ACPI_FAILURE(status)) {
@@ -275,15 +194,14 @@ static int acpi_memory_powerdown_device(
 	}
 
 	/* Evalute _STA to check if the device is disabled */
-	status = acpi_evaluate_integer(mem_device->device->handle, "_STA",
-				       NULL, &current_status);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
+	acpi_bus_get_status(device);
 	/* Check for device status.  Device should be disabled */
-	if (current_status & ACPI_MEMORY_STA_ENABLED)
+	if (device->status.enabled){
+		printk (KERN_ERR PREFIX "Could not powerdown memory"
+			"device %s",
+			acpi_device_bid(device));
 		return -EINVAL;
-
+	}
 	return 0;
 }
 
@@ -308,21 +226,20 @@ static int acpi_memory_disable_device(st
 
 	/* Power-off and eject the device */
 	result = acpi_memory_powerdown_device(mem_device);
-	if (result) {
-		/* Set the status of the device to invalid */
-		mem_device->state = MEMORY_INVALID_STATE;
+	if (result)
 		return result;
-	}
 
-	mem_device->state = MEMORY_POWER_OFF_STATE;
 	return result;
 }
 
 static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_memory_device *mem_device;
+	struct acpi_memory_device *mem_device = (struct acpi_memory_device*) data;
 	struct acpi_device *device;
 
+	if (!mem_device || !mem_device->device)
+		return;
+	device = mem_device->device;
 
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
@@ -333,31 +250,20 @@ static void acpi_memory_device_notify(ac
 		if (event == ACPI_NOTIFY_DEVICE_CHECK)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "\nReceived DEVICE CHECK notification for device\n"));
-		if (acpi_memory_get_device(handle, &mem_device)) {
-			printk(KERN_ERR PREFIX "Cannot find driver data\n");
-			return;
-		}
 
-		if (!acpi_memory_check_device(mem_device)) {
+		acpi_bus_get_status(device);
+		if (!(device->status.present &&
+		      device->status.enabled &&
+		      device->status.functional)){
 			if (acpi_memory_enable_device(mem_device))
 				printk(KERN_ERR PREFIX
-					    "Cannot enable memory device\n");
+				       "Cannot enable memory device\n");
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "\nReceived EJECT REQUEST notification for device\n"));
 
-		if (acpi_bus_get_device(handle, &device)) {
-			printk(KERN_ERR PREFIX "Device doesn't exist\n");
-			break;
-		}
-		mem_device = acpi_driver_data(device);
-		if (!mem_device) {
-			printk(KERN_ERR PREFIX "Driver Data is NULL\n");
-			break;
-		}
-
 		/*
 		 * Currently disabling memory device from kernel mode
 		 * TBD: Can also be disabled from user mode scripts
@@ -390,6 +296,13 @@ static int acpi_memory_device_add(struct
 	if (!device)
 		return -EINVAL;
 
+	/* Check for _STA and EJ0 func */
+	if (!device->flags.dynamic_status || !device->flags.ejectable){
+		printk(KERN_INFO PREFIX "Memory device %s has no _STA or"
+		       "EJ0/EJD function", acpi_device_bid(device));
+		return -ENODEV;
+	}
+
 	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
 	if (!mem_device)
 		return -ENOMEM;
@@ -410,15 +323,13 @@ static int acpi_memory_device_add(struct
 
 	/* register notify handler */
 	status = acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
-					     acpi_memory_device_notify, NULL);
+					     acpi_memory_device_notify, mem_device);
 
 	if (ACPI_FAILURE(status)){
 		ACPI_EXCEPTION((AE_INFO, status, "Could not install notify"
 				"handler for memory device: %s",
 				acpi_device_bid(device)));
 	}
-	/* Set the device state */
-	mem_device->state = MEMORY_POWER_ON_STATE;
 
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
@@ -450,13 +361,15 @@ static int acpi_memory_device_start (str
 
 	mem_device = acpi_driver_data(device);
 
-	if (!acpi_memory_check_device(mem_device)) {
-		/* call add_memory func */
-		result = acpi_memory_enable_device(mem_device);
-		if (result)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error in acpi_memory_enable_device\n"));
+	acpi_bus_get_status(device);
+	if (!(device->status.present &&
+	      device->status.enabled &&
+	      device->status.functional)){
+		if (acpi_memory_enable_device(mem_device))
+			printk(KERN_ERR PREFIX
+			       "Error in acpi_memory_enable_device\n");
 	}
+
 	return result;
 }
 


--=-xVMqEQU8vziYVJWUa8by
Content-Disposition: attachment; filename=acpi_memory_hotplug_state_cleanup.patch
Content-Type: text/x-patch; name=acpi_memory_hotplug_state_cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

acpi_memory_hotplug cleanups [2/2]

 - get rid of unused acpi_memory_device->state (is set, but never evaluated)
 - Make use of global acpi_bus_get_status(device) func instead of evaluate
   _STA with own func -> gets rid of acpi_memory_check_device and _STA defines
 - pass mem_device pointer as callback data to notify handler func
   -> get rid of acpi_memory_get_device()
 - check for availabe _STA and _EJ0/EJD early in acpi_memory_device_add(),
   those are mandotary for a working memory device

Signed-off-by: Thomas Renninger <mail@renninger.de>

 acpi_memhotplug.c |  155 +++++++++++-------------------------------------------
 1 file changed, 34 insertions(+), 121 deletions(-)

Index: linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
@@ -45,16 +45,6 @@ ACPI_MODULE_NAME("acpi_memory")
 MODULE_DESCRIPTION(ACPI_MEMORY_DEVICE_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-/* ACPI _STA method values */
-#define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
-#define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
-#define ACPI_MEMORY_STA_FUNCTIONAL	(0x00000008UL)
-
-/* Memory Device States */
-#define MEMORY_INVALID_STATE	0
-#define MEMORY_POWER_ON_STATE	1
-#define MEMORY_POWER_OFF_STATE	2
-
 static int acpi_memory_device_add(struct acpi_device *device);
 static int acpi_memory_device_remove(struct acpi_device *device, int type);
 static int acpi_memory_device_start(struct acpi_device *device);
@@ -81,7 +71,6 @@ struct acpi_memory_info {
 
 struct acpi_memory_device {
 	struct acpi_device * device;
-	unsigned int state;	/* State of the memory device */
 	struct list_head res_list;
 };
 
@@ -144,73 +133,6 @@ acpi_memory_get_device_resources(struct 
 	return 0;
 }
 
-static int
-acpi_memory_get_device(acpi_handle handle,
-		       struct acpi_memory_device **mem_device)
-{
-	acpi_status status;
-	acpi_handle phandle;
-	struct acpi_device *device = NULL;
-	struct acpi_device *pdevice = NULL;
-
-
-	if (!acpi_bus_get_device(handle, &device) && device)
-		goto end;
-
-	status = acpi_get_parent(handle, &phandle);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot find acpi parent"));
-		return -EINVAL;
-	}
-
-	/* Get the parent device */
-	status = acpi_bus_get_device(phandle, &pdevice);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot get acpi bus device"));
-		return -EINVAL;
-	}
-
-	/*
-	 * Now add the notified device.  This creates the acpi_device
-	 * and invokes .add function
-	 */
-	status = acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Cannot add acpi bus"));
-		return -EINVAL;
-	}
-
-      end:
-	*mem_device = acpi_driver_data(device);
-	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int acpi_memory_check_device(struct acpi_memory_device *mem_device)
-{
-	unsigned long current_status;
-
-
-	/* Get device present/absent information from the _STA */
-	if (ACPI_FAILURE(acpi_evaluate_integer(mem_device->device->handle, "_STA",
-					       NULL, &current_status)))
-		return -ENODEV;
-	/*
-	 * Check for device status. Device should be
-	 * present/enabled/functioning.
-	 */
-	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
-	      && (current_status & ACPI_MEMORY_STA_ENABLED)
-	      && (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))
-		return -ENODEV;
-
-	return 0;
-}
-
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	int result, num_enabled = 0;
@@ -222,7 +144,6 @@ static int acpi_memory_enable_device(str
 	result = acpi_memory_get_device_resources(mem_device);
 	if (result) {
 		printk(KERN_ERR PREFIX "get_device_resources failed\n");
-		mem_device->state = MEMORY_INVALID_STATE;
 		return result;
 	}
 
@@ -246,7 +167,6 @@ static int acpi_memory_enable_device(str
 	}
 	if (!num_enabled) {
 		printk(KERN_ERR PREFIX "add_memory failed\n");
-		mem_device->state = MEMORY_INVALID_STATE;
 		return -EINVAL;
 	}
 
@@ -257,16 +177,15 @@ static int acpi_memory_powerdown_device(
 {
 	acpi_status status;
 	struct acpi_object_list arg_list;
+	struct acpi_device *device = mem_device->device;
 	union acpi_object arg;
-	unsigned long current_status;
-
 
 	/* Issue the _EJ0 command */
 	arg_list.count = 1;
 	arg_list.pointer = &arg;
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = 1;
-	status = acpi_evaluate_object(mem_device->device->handle,
+	status = acpi_evaluate_object(device->handle,
 				      "_EJ0", &arg_list, NULL);
 	/* Return on _EJ0 failure */
 	if (ACPI_FAILURE(status)) {
@@ -275,15 +194,14 @@ static int acpi_memory_powerdown_device(
 	}
 
 	/* Evalute _STA to check if the device is disabled */
-	status = acpi_evaluate_integer(mem_device->device->handle, "_STA",
-				       NULL, &current_status);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
+	acpi_bus_get_status(device);
 	/* Check for device status.  Device should be disabled */
-	if (current_status & ACPI_MEMORY_STA_ENABLED)
+	if (device->status.enabled){
+		printk (KERN_ERR PREFIX "Could not powerdown memory"
+			"device %s",
+			acpi_device_bid(device));
 		return -EINVAL;
-
+	}
 	return 0;
 }
 
@@ -308,21 +226,20 @@ static int acpi_memory_disable_device(st
 
 	/* Power-off and eject the device */
 	result = acpi_memory_powerdown_device(mem_device);
-	if (result) {
-		/* Set the status of the device to invalid */
-		mem_device->state = MEMORY_INVALID_STATE;
+	if (result)
 		return result;
-	}
 
-	mem_device->state = MEMORY_POWER_OFF_STATE;
 	return result;
 }
 
 static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_memory_device *mem_device;
+	struct acpi_memory_device *mem_device = (struct acpi_memory_device*) data;
 	struct acpi_device *device;
 
+	if (!mem_device || !mem_device->device)
+		return;
+	device = mem_device->device;
 
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
@@ -333,31 +250,20 @@ static void acpi_memory_device_notify(ac
 		if (event == ACPI_NOTIFY_DEVICE_CHECK)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "\nReceived DEVICE CHECK notification for device\n"));
-		if (acpi_memory_get_device(handle, &mem_device)) {
-			printk(KERN_ERR PREFIX "Cannot find driver data\n");
-			return;
-		}
 
-		if (!acpi_memory_check_device(mem_device)) {
+		acpi_bus_get_status(device);
+		if (!(device->status.present &&
+		      device->status.enabled &&
+		      device->status.functional)){
 			if (acpi_memory_enable_device(mem_device))
 				printk(KERN_ERR PREFIX
-					    "Cannot enable memory device\n");
+				       "Cannot enable memory device\n");
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "\nReceived EJECT REQUEST notification for device\n"));
 
-		if (acpi_bus_get_device(handle, &device)) {
-			printk(KERN_ERR PREFIX "Device doesn't exist\n");
-			break;
-		}
-		mem_device = acpi_driver_data(device);
-		if (!mem_device) {
-			printk(KERN_ERR PREFIX "Driver Data is NULL\n");
-			break;
-		}
-
 		/*
 		 * Currently disabling memory device from kernel mode
 		 * TBD: Can also be disabled from user mode scripts
@@ -390,6 +296,13 @@ static int acpi_memory_device_add(struct
 	if (!device)
 		return -EINVAL;
 
+	/* Check for _STA and EJ0 func */
+	if (!device->flags.dynamic_status || !device->flags.ejectable){
+		printk(KERN_INFO PREFIX "Memory device %s has no _STA or"
+		       "EJ0/EJD function", acpi_device_bid(device));
+		return -ENODEV;
+	}
+
 	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
 	if (!mem_device)
 		return -ENOMEM;
@@ -410,15 +323,13 @@ static int acpi_memory_device_add(struct
 
 	/* register notify handler */
 	status = acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
-					     acpi_memory_device_notify, NULL);
+					     acpi_memory_device_notify, mem_device);
 
 	if (ACPI_FAILURE(status)){
 		ACPI_EXCEPTION((AE_INFO, status, "Could not install notify"
 				"handler for memory device: %s",
 				acpi_device_bid(device)));
 	}
-	/* Set the device state */
-	mem_device->state = MEMORY_POWER_ON_STATE;
 
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
@@ -450,13 +361,15 @@ static int acpi_memory_device_start (str
 
 	mem_device = acpi_driver_data(device);
 
-	if (!acpi_memory_check_device(mem_device)) {
-		/* call add_memory func */
-		result = acpi_memory_enable_device(mem_device);
-		if (result)
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				"Error in acpi_memory_enable_device\n"));
+	acpi_bus_get_status(device);
+	if (!(device->status.present &&
+	      device->status.enabled &&
+	      device->status.functional)){
+		if (acpi_memory_enable_device(mem_device))
+			printk(KERN_ERR PREFIX
+			       "Error in acpi_memory_enable_device\n");
 	}
+
 	return result;
 }
 

--=-xVMqEQU8vziYVJWUa8by--

