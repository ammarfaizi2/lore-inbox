Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWFAXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWFAXRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWFAXRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:17:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750883AbWFAXRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:17:43 -0400
Date: Thu, 1 Jun 2006 16:20:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [patch 1/3] acpi: dock driver v6
Message-Id: <20060601162039.02fcd8e1.akpm@osdl.org>
In-Reply-To: <1149203128.14279.17.camel@whizzy>
References: <20060412221027.472109000@intel.com>
	<1144880322.11215.44.camel@whizzy>
	<20060412222735.38aa0f58.akpm@osdl.org>
	<1145054985.29319.51.camel@whizzy>
	<44410360.6090003@sgi.com>
	<1145383396.10783.32.camel@whizzy>
	<1146268318.25490.33.camel@whizzy>
	<1147373152.15308.14.camel@whizzy>
	<1149203128.14279.17.camel@whizzy>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Accardi <kristen.c.accardi@intel.com> wrote:
>
> Changed from last version:

It would be much preferred if you could issue patches against the previous
version please (ie: the thing in -mm), instead of reissuing the patch each
time.

It tells us that you, the developer, have been testing the code which we
intend to send upstream, rather than testing some possibly-divergent thing
which lives on your hard-drive.

And it makes it much easier to review the changes.  And it saves me from
having to generate the incremental diff so _I_ can see what you've changed.


And lo, when I did that:

diff -puN drivers/acpi/dock.c~acpi-dock-driver-v6 drivers/acpi/dock.c
--- 25/drivers/acpi/dock.c~acpi-dock-driver-v6	Thu Jun  1 16:12:31 2006
+++ 25-akpm/drivers/acpi/dock.c	Thu Jun  1 16:12:31 2006
@@ -190,6 +190,9 @@ static int is_dock(acpi_handle handle)
  */
 int is_dock_device(acpi_handle handle)
 {
+	if (!dock_station)
+		return 0;
+
 	if (is_dock(handle) || find_dock_dependent_device(dock_station, handle))
 		return 1;
 
@@ -218,6 +221,66 @@ static int dock_present(struct dock_stat
 	return 0;
 }
 
+
+
+/**
+ * dock_create_acpi_device - add new devices to acpi
+ * @handle - handle of the device to add
+ *
+ *  This function will create a new acpi_device for the given
+ *  handle if one does not exist already.  This should cause
+ *  acpi to scan for drivers for the given devices, and call
+ *  matching driver's add routine.
+ *
+ *  Returns a pointer to the acpi_device corresponding to the handle.
+ */
+static struct acpi_device * dock_create_acpi_device(acpi_handle handle)
+{
+	struct acpi_device *device = NULL;
+	struct acpi_device *parent_device;
+	acpi_handle parent;
+	int ret;
+
+	if (acpi_bus_get_device(handle, &device)) {
+		/*
+		 * no device created for this object,
+		 * so we should create one.
+		 */
+		acpi_get_parent(handle, &parent);
+		if (acpi_bus_get_device(parent, &parent_device))
+			parent_device = NULL;
+
+		ret = acpi_bus_add(&device, parent_device, handle,
+			ACPI_BUS_TYPE_DEVICE);
+		if (ret) {
+			pr_debug("error adding bus, %x\n",
+				-ret);
+			return NULL;
+		}
+	}
+	return device;
+}
+
+/**
+ * dock_remove_acpi_device - remove the acpi_device struct from acpi
+ * @handle - the handle of the device to remove
+ *
+ *  Tell acpi to remove the acpi_device.  This should cause any loaded
+ *  driver to have it's remove routine called.
+ */
+static void dock_remove_acpi_device(acpi_handle handle)
+{
+	struct acpi_device *device;
+	int ret;
+
+	if (acpi_bus_get_device(handle, &device)) {
+		ret = acpi_bus_trim(device, 1);
+		if (ret)
+			pr_debug("error removing bus, %x\n", -ret);
+	}
+}
+
+
 /**
  * hotplug_dock_devices - insert or remove devices on the dock station
  * @ds: the dock station
@@ -233,39 +296,37 @@ static void hotplug_dock_devices(struct 
 	struct dock_dependent_device *dd;
 
 	spin_lock(&ds->hp_lock);
+
+	/*
+	 * First call driver specific hotplug functions
+	 */
 	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
 		if (dd->handler)
 			dd->handler(dd->handle, event, dd->context);
 	}
+
+	/*
+	 * Now make sure that an acpi_device is created for each
+	 * dependent device, or removed if this is an eject request.
+	 * This will cause acpi_drivers to be stopped/started if they
+	 * exist
+	 */
+	list_for_each_entry(dd, &ds->dependent_devices, list) {
+		if (event == ACPI_NOTIFY_EJECT_REQUEST)
+			dock_remove_acpi_device(dd->handle);
+		else
+			dock_create_acpi_device(dd->handle);
+	}
 	spin_unlock(&ds->hp_lock);
 }
 
-
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
 	struct acpi_device *device;
-	struct acpi_device *parent_device;
-	acpi_handle parent;
-	int ret;
 
-	if (acpi_bus_get_device(ds->handle, &device)) {
-		/*
-		 * no device created for this object,
-		 * so we should create one.
-		 */
-		acpi_get_parent(ds->handle, &parent);
-		if (acpi_bus_get_device(parent, &parent_device))
-			parent_device = NULL;
-
-		ret = acpi_bus_add(&device, parent_device, ds->handle,
-			ACPI_BUS_TYPE_DEVICE);
-		if (ret) {
-			pr_debug("error adding bus, %x\n",
-				-ret_val);
-			return;
-		}
-	}
-	kobject_uevent(&device->kobj, num);
+	device = dock_create_acpi_device(ds->handle);
+	if (device)
+		kobject_uevent(&device->kobj, num);
 }
 
 /**
@@ -674,5 +735,5 @@ static void __exit dock_exit(void)
 	dock_remove();
 }
 
-module_init(dock_init);
+postcore_initcall(dock_init);
 module_exit(dock_exit);
diff -puN drivers/acpi/scan.c~acpi-dock-driver-v6 drivers/acpi/scan.c
--- 25/drivers/acpi/scan.c~acpi-dock-driver-v6	Thu Jun  1 16:12:31 2006
+++ 25-akpm/drivers/acpi/scan.c	Thu Jun  1 16:12:31 2006
@@ -670,7 +670,7 @@ acpi_bus_get_ejd(acpi_handle handle, acp
 	if (ACPI_SUCCESS(status)) {
 		obj = buffer.pointer;
 		status = acpi_get_handle(NULL, obj->string.pointer, ejd);
-		kfree(buffer.pointer);
+		acpi_os_free(buffer.pointer);
 	}
 	return status;
 }
_

I see an acpi_os_free().   There ain't any such function.
