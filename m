Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWH0ReM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWH0ReM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWH0ReM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:34:12 -0400
Received: from mx01.qsc.de ([213.148.129.14]:3488 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S932200AbWH0ReK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:34:10 -0400
Subject: [PATCH 1/2] acpi hotplug cleanups, move install notifier to add
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
Content-Type: multipart/mixed; boundary="=-gDZ95eFo9kmlQqq8Z5wJ"
Date: Sun, 27 Aug 2006 19:19:47 +0200
Message-Id: <1156699188.1852.13.camel@linux-1vxn.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gDZ95eFo9kmlQqq8Z5wJ
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

Trying again with a real mailer, sorry about the previous junk ...
The email address of the module author (naveen.b.s@intel.com) seems to
be invalid?

    Thomas


ACPI memhotplug cleanup: Move "install notify handler" to .add() function

Signed-off-by: Thomas Renninger <mail@renninger.de>

 acpi_memhotplug.c |  113 +++++++-----------------------------------------------
 1 file changed, 16 insertions(+), 97 deletions(-)

Index: linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
@@ -384,6 +384,7 @@ static int acpi_memory_device_add(struct
 {
 	int result;
 	struct acpi_memory_device *mem_device = NULL;
+	acpi_status status;
 

 	if (!device)
@@ -407,6 +408,15 @@ static int acpi_memory_device_add(struct
 		return result;
 	}
 
+	/* register notify handler */
+	status = acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
+					     acpi_memory_device_notify, NULL);
+
+	if (ACPI_FAILURE(status)){
+		ACPI_EXCEPTION((AE_INFO, status, "Could not install notify"
+				"handler for memory device: %s",
+				acpi_device_bid(device)));
+	}
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
@@ -423,6 +433,10 @@ static int acpi_memory_device_remove(str
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
+	acpi_remove_notify_handler(device->handle,
+				   ACPI_SYSTEM_NOTIFY,
+				   acpi_memory_device_notify);
+
 	mem_device = (struct acpi_memory_device *)acpi_driver_data(device);
 	kfree(mem_device);
 
@@ -446,117 +460,22 @@ static int acpi_memory_device_start (str
 	return result;
 }
 
-/*
- * Helper function to check for memory device
- */
-static acpi_status is_memory_device(acpi_handle handle)
-{
-	char *hardware_id;
-	acpi_status status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device_info *info;
-
-
-	status = acpi_get_object_info(handle, &buffer);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	info = buffer.pointer;
-	if (!(info->valid & ACPI_VALID_HID)) {
-		kfree(buffer.pointer);
-		return AE_ERROR;
-	}
-
-	hardware_id = info->hardware_id.value;
-	if ((hardware_id == NULL) ||
-	    (strcmp(hardware_id, ACPI_MEMORY_DEVICE_HID)))
-		status = AE_ERROR;
-
-	kfree(buffer.pointer);
-	return status;
-}
-
-static acpi_status
-acpi_memory_register_notify_handler(acpi_handle handle,
-				    u32 level, void *ctxt, void **retv)
-{
-	acpi_status status;
-
-
-	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return AE_OK;	/* continue */
-	}
-
-	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-					     acpi_memory_device_notify, NULL);
-	/* continue */
-	return AE_OK;
-}
-
-static acpi_status
-acpi_memory_deregister_notify_handler(acpi_handle handle,
-				      u32 level, void *ctxt, void **retv)
-{
-	acpi_status status;
-
-
-	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return AE_OK;	/* continue */
-	}
-
-	status = acpi_remove_notify_handler(handle,
-					    ACPI_SYSTEM_NOTIFY,
-					    acpi_memory_device_notify);
-
-	return AE_OK;	/* continue */
-}
-
 static int __init acpi_memory_device_init(void)
 {
 	int result;
-	acpi_status status;
-
 
+	/* Register driver and notify handlers in .add func */
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0)
 		return -ENODEV;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     acpi_memory_register_notify_handler,
-				     NULL, NULL);
-
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
-		acpi_bus_unregister_driver(&acpi_memory_device_driver);
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
 static void __exit acpi_memory_device_exit(void)
 {
-	acpi_status status;
-
-
-	/*
-	 * Adding this to un-install notification handlers for all the device
-	 * handles.
-	 */
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     acpi_memory_deregister_notify_handler,
-				     NULL, NULL);
-
-	if (ACPI_FAILURE(status))
-		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
-
+	/* Unregister driver and notify handlers in .add func */
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
 	return;


--=-gDZ95eFo9kmlQqq8Z5wJ
Content-Disposition: attachment; filename=acpi_memhotplug_cleanup.patch
Content-Type: text/x-patch; name=acpi_memhotplug_cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

ACPI memhotplug cleanup: Move "install notify handler" to .add() function

Signed-off-by: Thomas Renninger <mail@renninger.de>

 acpi_memhotplug.c |  113 +++++++-----------------------------------------------
 1 file changed, 16 insertions(+), 97 deletions(-)

Index: linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.18-rc4/drivers/acpi/acpi_memhotplug.c
@@ -384,6 +384,7 @@ static int acpi_memory_device_add(struct
 {
 	int result;
 	struct acpi_memory_device *mem_device = NULL;
+	acpi_status status;
 
 
 	if (!device)
@@ -407,6 +408,15 @@ static int acpi_memory_device_add(struct
 		return result;
 	}
 
+	/* register notify handler */
+	status = acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
+					     acpi_memory_device_notify, NULL);
+
+	if (ACPI_FAILURE(status)){
+		ACPI_EXCEPTION((AE_INFO, status, "Could not install notify"
+				"handler for memory device: %s",
+				acpi_device_bid(device)));
+	}
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
@@ -423,6 +433,10 @@ static int acpi_memory_device_remove(str
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
+	acpi_remove_notify_handler(device->handle,
+				   ACPI_SYSTEM_NOTIFY,
+				   acpi_memory_device_notify);
+
 	mem_device = (struct acpi_memory_device *)acpi_driver_data(device);
 	kfree(mem_device);
 
@@ -446,117 +460,22 @@ static int acpi_memory_device_start (str
 	return result;
 }
 
-/*
- * Helper function to check for memory device
- */
-static acpi_status is_memory_device(acpi_handle handle)
-{
-	char *hardware_id;
-	acpi_status status;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device_info *info;
-
-
-	status = acpi_get_object_info(handle, &buffer);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	info = buffer.pointer;
-	if (!(info->valid & ACPI_VALID_HID)) {
-		kfree(buffer.pointer);
-		return AE_ERROR;
-	}
-
-	hardware_id = info->hardware_id.value;
-	if ((hardware_id == NULL) ||
-	    (strcmp(hardware_id, ACPI_MEMORY_DEVICE_HID)))
-		status = AE_ERROR;
-
-	kfree(buffer.pointer);
-	return status;
-}
-
-static acpi_status
-acpi_memory_register_notify_handler(acpi_handle handle,
-				    u32 level, void *ctxt, void **retv)
-{
-	acpi_status status;
-
-
-	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return AE_OK;	/* continue */
-	}
-
-	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-					     acpi_memory_device_notify, NULL);
-	/* continue */
-	return AE_OK;
-}
-
-static acpi_status
-acpi_memory_deregister_notify_handler(acpi_handle handle,
-				      u32 level, void *ctxt, void **retv)
-{
-	acpi_status status;
-
-
-	status = is_memory_device(handle);
-	if (ACPI_FAILURE(status)){
-		ACPI_EXCEPTION((AE_INFO, status, "handle is no memory device"));
-		return AE_OK;	/* continue */
-	}
-
-	status = acpi_remove_notify_handler(handle,
-					    ACPI_SYSTEM_NOTIFY,
-					    acpi_memory_device_notify);
-
-	return AE_OK;	/* continue */
-}
-
 static int __init acpi_memory_device_init(void)
 {
 	int result;
-	acpi_status status;
-
 
+	/* Register driver and notify handlers in .add func */
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0)
 		return -ENODEV;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     acpi_memory_register_notify_handler,
-				     NULL, NULL);
-
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
-		acpi_bus_unregister_driver(&acpi_memory_device_driver);
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
 static void __exit acpi_memory_device_exit(void)
 {
-	acpi_status status;
-
-
-	/*
-	 * Adding this to un-install notification handlers for all the device
-	 * handles.
-	 */
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX,
-				     acpi_memory_deregister_notify_handler,
-				     NULL, NULL);
-
-	if (ACPI_FAILURE(status))
-		ACPI_EXCEPTION((AE_INFO, status, "walk_namespace failed"));
-
+	/* Unregister driver and notify handlers in .add func */
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
 	return;

--=-gDZ95eFo9kmlQqq8Z5wJ--

