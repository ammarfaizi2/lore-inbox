Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWD1Xm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWD1Xm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWD1Xm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:42:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:34986 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751400AbWD1XmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:42:24 -0400
X-IronPort-AV: i="4.04,165,1144047600"; 
   d="scan'208"; a="29215190:sNHT21685202"
Subject: Re: [patch 1/3] acpi: dock driver v3
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Prarit Bhargava <prarit@redhat.com>, len.brown@intel.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mochel@linux.intel.com,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru
In-Reply-To: <1145383396.10783.32.camel@whizzy>
References: <20060412221027.472109000@intel.com>
	 <1144880322.11215.44.camel@whizzy> <20060412222735.38aa0f58.akpm@osdl.org>
	 <1145054985.29319.51.camel@whizzy> <44410360.6090003@sgi.com>
	 <1145383396.10783.32.camel@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Apr 2006 16:51:58 -0700
Message-Id: <1146268318.25490.33.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 28 Apr 2006 23:42:23.0240 (UTC) FILETIME=[65C6F880:01C66B1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dock driver v3

Create a driver which lives in the acpi subsystem to handle dock events.  This 
driver is not an acpi driver, because acpi drivers require that the object
be present when the driver is loaded.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---

Changes from last version:
1.  Fix build problem so that acpiphp can be built without CONFIG_ACPI_DOCK
2.  remove all acpi debug messages
3.  change exported APIs to not use ACPI-CA isms
4.  remove return values from unregister functions
5.  Handle ACPI_DEVICE_CHECK properly.  When this is sent on an object with 
    _DCK, this should be treated as an undock request.
6.  Remove bus_event generation, as this is causing problems on some systems.
    I will add this back in after I figure out what was wrong with it.

Kristen


 drivers/acpi/Kconfig        |    7 
 drivers/acpi/Makefile       |    1 
 drivers/acpi/dock.c         |  650 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c         |   23 +
 include/acpi/acpi_bus.h     |    2 
 include/acpi/acpi_drivers.h |   17 +
 6 files changed, 699 insertions(+), 1 deletion(-)

--- /dev/null
+++ 2.6-git-kca2/drivers/acpi/dock.c
@@ -0,0 +1,650 @@
+/*
+ *  dock.c - ACPI dock station driver
+ *
+ *  Copyright (C) 2006 Kristen Carlson Accardi <kristen.c.accardi@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/notifier.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_DOCK_DRIVER_NAME "ACPI Dock Station Driver"
+
+ACPI_MODULE_NAME("dock")
+MODULE_AUTHOR("Kristen Carlson Accardi");
+MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+static struct atomic_notifier_head dock_notifier_list;
+
+struct dock_station {
+	acpi_handle handle;
+	unsigned long last_dock_time;
+	u32 flags;
+	spinlock_t dd_lock;
+	spinlock_t hp_lock;
+	struct list_head dependent_devices;
+	struct list_head hotplug_devices;
+};
+
+struct dock_dependent_device {
+	struct list_head list;
+	struct list_head hotplug_list;
+	acpi_handle handle;
+	acpi_notify_handler handler;
+	void *context;
+};
+
+#define DOCK_DOCKING	0x00000001
+
+static struct dock_station *dock_station;
+
+/*****************************************************************************
+ *                         Dock Dependent device functions                   *
+ *****************************************************************************/
+/**
+ *  alloc_dock_dependent_device - allocate and init a dependent device
+ *  @handle: the acpi_handle of the dependent device
+ *
+ *  Allocate memory for a dependent device structure for a device referenced
+ *  by the acpi handle
+ */
+static struct dock_dependent_device *
+alloc_dock_dependent_device(acpi_handle handle)
+{
+	struct dock_dependent_device *dd;
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	if (dd) {
+		dd->handle = handle;
+		INIT_LIST_HEAD(&dd->list);
+		INIT_LIST_HEAD(&dd->hotplug_list);
+	}
+	return dd;
+}
+
+/**
+ * add_dock_dependent_device - associate a device with the dock station
+ * @ds: The dock station
+ * @dd: The dependent device
+ *
+ * Add the dependent device to the dock's dependent device list.
+ */
+static void
+add_dock_dependent_device(struct dock_station *ds,
+			  struct dock_dependent_device *dd)
+{
+	spin_lock(&ds->dd_lock);
+	list_add_tail(&dd->list, &ds->dependent_devices);
+	spin_unlock(&ds->dd_lock);
+}
+
+/**
+ * dock_add_hotplug_device - associate a hotplug handler with the dock station
+ * @ds: The dock station
+ * @dd: The dependent device struct
+ *
+ * Add the dependent device to the dock's hotplug device list
+ */
+static void
+dock_add_hotplug_device(struct dock_station *ds,
+			struct dock_dependent_device *dd)
+{
+	spin_lock(&ds->hp_lock);
+	list_add_tail(&dd->hotplug_list, &ds->hotplug_devices);
+	spin_unlock(&ds->hp_lock);
+}
+
+/**
+ * dock_del_hotplug_device - remove a hotplug handler from the dock station
+ * @ds: The dock station
+ * @dd: the dependent device struct
+ *
+ * Delete the dependent device from the dock's hotplug device list
+ */
+static void
+dock_del_hotplug_device(struct dock_station *ds,
+			struct dock_dependent_device *dd)
+{
+	spin_lock(&ds->hp_lock);
+	list_del(&dd->hotplug_list);
+	spin_unlock(&ds->hp_lock);
+}
+
+/**
+ * find_dock_dependent_device - get a device dependent on this dock
+ * @ds: the dock station
+ * @handle: the acpi_handle of the device we want
+ *
+ * iterate over the dependent device list for this dock.  If the
+ * dependent device matches the handle, return.
+ */
+static struct dock_dependent_device *
+find_dock_dependent_device(struct dock_station *ds, acpi_handle handle)
+{
+	struct dock_dependent_device *dd;
+
+	spin_lock(&ds->dd_lock);
+	list_for_each_entry(dd, &ds->dependent_devices, list) {
+		if (handle == dd->handle) {
+			spin_unlock(&ds->dd_lock);
+			return dd;
+		}
+	}
+	spin_unlock(&ds->dd_lock);
+	return NULL;
+}
+
+/*****************************************************************************
+ *                         Dock functions                                    *
+ *****************************************************************************/
+/**
+ * is_dock - see if a device is a dock station
+ * @handle: acpi handle of the device
+ *
+ * If an acpi object has a _DCK method, then it is by definition a dock
+ * station, so return true.
+ */
+static int is_dock(acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status = acpi_get_handle(handle, "_DCK", &tmp);
+	if (ACPI_FAILURE(status))
+		return 0;
+	return 1;
+}
+
+/**
+ * is_dock_device - see if a device is on a dock station
+ * @handle: acpi handle of the device
+ *
+ * If this device is either the dock station itself,
+ * or is a device dependent on the dock station, then it
+ * is a dock device
+ */
+int is_dock_device(acpi_handle handle)
+{
+	if (is_dock(handle) || find_dock_dependent_device(dock_station, handle))
+		return 1;
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(is_dock_device);
+
+/**
+ * dock_present - see if the dock station is present.
+ * @ds: the dock station
+ *
+ * execute the _STA method.  note that present does not
+ * imply that we are docked.
+ */
+static int dock_present(struct dock_station *ds)
+{
+	unsigned long sta;
+	acpi_status status;
+
+	if (ds) {
+		status = acpi_evaluate_integer(ds->handle, "_STA", NULL, &sta);
+		if (ACPI_SUCCESS(status) && sta)
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * hotplug_dock_devices - insert or remove devices on the dock station
+ * @ds: the dock station
+ * @event: either bus check or eject request
+ *
+ * Some devices on the dock station need to have drivers called
+ * to perform hotplug operations after a dock event has occurred.
+ * Traverse the list of dock devices that have registered a
+ * hotplug handler, and call the handler.
+ */
+static void hotplug_dock_devices(struct dock_station *ds, u32 event)
+{
+	struct dock_dependent_device *dd;
+
+	spin_lock(&ds->hp_lock);
+	list_for_each_entry(dd, &ds->hotplug_devices, hotplug_list) {
+		if (dd->handler)
+			dd->handler(dd->handle, event, dd->context);
+	}
+	spin_unlock(&ds->hp_lock);
+}
+
+/**
+ * eject_dock - respond to a dock eject request
+ * @ds: the dock station
+ *
+ * This is called after _DCK is called, to execute the dock station's
+ * _EJ0 method.
+ */
+static void eject_dock(struct dock_station *ds)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+	acpi_handle tmp;
+
+	/* all dock devices should have _EJ0, but check anyway */
+	status = acpi_get_handle(ds->handle, "_EJ0", &tmp);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("No _EJ0 support for dock device\n");
+		return;
+	}
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(ds->handle, "_EJ0",
+					      &arg_list, NULL)))
+		pr_debug("Failed to evaluate _EJ0!\n");
+}
+
+/**
+ * handle_dock - handle a dock event
+ * @ds: the dock station
+ * @dock: to dock, or undock - that is the question
+ *
+ * Execute the _DCK method in response to an acpi event
+ */
+static acpi_status handle_dock(struct dock_station *ds, int dock)
+{
+	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	acpi_get_name(ds->handle, ACPI_FULL_PATHNAME, &name_buffer);
+	obj = name_buffer.pointer;
+
+	printk(KERN_INFO PREFIX "%s\n", dock ? "docking" : "undocking");
+
+	/* _DCK method has one argument */
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = dock;
+	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		pr_debug("%s: failed to execute _DCK\n", obj->string.pointer);
+	kfree(buffer.pointer);
+	kfree(name_buffer.pointer);
+
+	return status;
+}
+
+static inline void dock(struct dock_station *ds)
+{
+	handle_dock(ds, 1);
+}
+
+static inline void undock(struct dock_station *ds)
+{
+	handle_dock(ds, 0);
+}
+
+static inline void begin_dock(struct dock_station *ds)
+{
+	ds->flags |= DOCK_DOCKING;
+}
+
+static inline void complete_dock(struct dock_station *ds)
+{
+	ds->flags &= ~(DOCK_DOCKING);
+	ds->last_dock_time = jiffies;
+}
+
+/**
+ * dock_in_progress - see if we are in the middle of handling a dock event
+ * @ds: the dock station
+ *
+ * Sometimes while docking, false dock events can be sent to the driver
+ * because good connections aren't made or some other reason.  Ignore these
+ * if we are in the middle of doing something.
+ */
+static int dock_in_progress(struct dock_station *ds)
+{
+	if ((ds->flags & DOCK_DOCKING) ||
+	    time_before(jiffies, (ds->last_dock_time + HZ)))
+		return 1;
+	return 0;
+}
+
+/**
+ * register_dock_notifier - add yourself to the dock notifier list
+ * @nb: the callers notifier block
+ *
+ * If a driver wishes to be notified about dock events, they can
+ * use this function to put a notifier block on the dock notifier list.
+ * this notifier call chain will be called after a dock event, but
+ * before hotplugging any new devices.
+ */
+int register_dock_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&dock_notifier_list, nb);
+}
+
+EXPORT_SYMBOL_GPL(register_dock_notifier);
+
+/**
+ * unregister_dock_notifier - remove yourself from the dock notifier list
+ * @nb: the callers notifier block
+ */
+void unregister_dock_notifier(struct notifier_block *nb)
+{
+	atomic_notifier_chain_unregister(&dock_notifier_list, nb);
+}
+
+EXPORT_SYMBOL_GPL(unregister_dock_notifier);
+
+/**
+ * register_hotplug_dock_device - register a hotplug function
+ * @handle: the handle of the device
+ * @handler: the acpi_notifier_handler to call after docking
+ * @context: device specific data
+ *
+ * If a driver would like to perform a hotplug operation after a dock
+ * event, they can register an acpi_notifiy_handler to be called by
+ * the dock driver after _DCK is executed.
+ */
+int
+register_hotplug_dock_device(acpi_handle handle, acpi_notify_handler handler,
+			     void *context)
+{
+	struct dock_dependent_device *dd;
+
+	if (!dock_station)
+		return -ENODEV;
+
+	/*
+	 * make sure this handle is for a device dependent on the dock,
+	 * this would include the dock station itself
+	 */
+	dd = find_dock_dependent_device(dock_station, handle);
+	if (dd) {
+		dd->handler = handler;
+		dd->context = context;
+		dock_add_hotplug_device(dock_station, dd);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL_GPL(register_hotplug_dock_device);
+
+/**
+ * unregister_hotplug_dock_device - remove yourself from the hotplug list
+ * @handle: the acpi handle of the device
+ */
+void unregister_hotplug_dock_device(acpi_handle handle)
+{
+	struct dock_dependent_device *dd;
+
+	if (!dock_station)
+		return;
+
+	dd = find_dock_dependent_device(dock_station, handle);
+	if (dd)
+		dock_del_hotplug_device(dock_station, dd);
+}
+
+EXPORT_SYMBOL_GPL(unregister_hotplug_dock_device);
+
+/**
+ * acpi_dock_notify - act upon an acpi dock notification
+ * @handle: the dock station handle
+ * @event: the acpi event
+ * @data: our driver data struct
+ *
+ * If we are notified to dock, then check to see if the dock is
+ * present and then dock.  Notify all drivers of the dock event,
+ * and then hotplug and devices that may need hotplugging.  For undock
+ * check to make sure the dock device is still present, then undock
+ * and hotremove all the devices that may need removing.
+ */
+static void acpi_dock_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct dock_station *ds = (struct dock_station *)data;
+
+	switch (event) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		if (!dock_in_progress(ds) && dock_present(ds)) {
+			begin_dock(ds);
+			dock(ds);
+			if (!dock_present(ds)) {
+				printk(KERN_ERR PREFIX "Unable to dock!\n");
+				break;
+			}
+			atomic_notifier_call_chain(&dock_notifier_list,
+						   event, NULL);
+			hotplug_dock_devices(ds, event);
+			complete_dock(ds);
+			/* TBD - generate an event */
+		}
+		break;
+	case ACPI_NOTIFY_DEVICE_CHECK:
+	/*
+         * According to acpi spec 3.0a, if a DEVICE_CHECK notification
+         * is sent and _DCK is present, it is assumed to mean an
+         * undock request.  This notify routine will only be called
+         * for objects defining _DCK, so we will fall through to eject
+         * request here.  However, we will pass an eject request through
+	 * to the driver who wish to hotplug.
+         */
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		if (!dock_in_progress(ds) && dock_present(ds)) {
+			/*
+			 * here we need to generate the undock
+			 * event prior to actually doing the undock
+			 * so that the device struct still exists.
+			 */
+			/* TBD - generate an event */
+			hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
+			undock(ds);
+			eject_dock(ds);
+			if (dock_present(ds))
+				printk(KERN_ERR PREFIX "Unable to undock!\n");
+		}
+		break;
+	default:
+		printk(KERN_ERR PREFIX "Unknown dock event %d\n", event);
+	}
+}
+
+/**
+ * find_dock_devices - find devices on the dock station
+ * @handle: the handle of the device we are examining
+ * @lvl: unused
+ * @context: the dock station private data
+ * @rv: unused
+ *
+ * This function is called by acpi_walk_namespace.  It will
+ * check to see if an object has an _EJD method.  If it does, then it
+ * will see if it is dependent on the dock station.
+ */
+static acpi_status
+find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status status;
+	acpi_handle tmp;
+	struct dock_station *ds = (struct dock_station *)context;
+	struct dock_dependent_device *dd;
+
+	status = acpi_bus_get_ejd(handle, &tmp);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	if (tmp == ds->handle) {
+		dd = alloc_dock_dependent_device(handle);
+		if (dd)
+			add_dock_dependent_device(ds, dd);
+	}
+
+	return AE_OK;
+}
+
+/**
+ * acpi_dock_add - add a new dock station
+ * @handle: the dock station handle
+ *
+ * allocated and initialize a new dock station device.  Find all devices
+ * that are on the dock station, and register for dock event notifications.
+ */
+static int acpi_dock_add(acpi_handle handle)
+{
+	int ret;
+	acpi_status status;
+	struct dock_dependent_device *dd;
+
+	/* allocate & initialize the dock_station private data */
+	dock_station = kzalloc(sizeof(*dock_station), GFP_KERNEL);
+	if (!dock_station)
+		return -ENOMEM;
+	dock_station->handle = handle;
+	dock_station->last_dock_time = jiffies - HZ;
+	INIT_LIST_HEAD(&dock_station->dependent_devices);
+	INIT_LIST_HEAD(&dock_station->hotplug_devices);
+	spin_lock_init(&dock_station->dd_lock);
+	spin_lock_init(&dock_station->hp_lock);
+
+	/* Find dependent devices */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			    ACPI_UINT32_MAX, find_dock_devices, dock_station,
+			    NULL);
+
+	/* add the dock station as a device dependent on itself */
+	dd = alloc_dock_dependent_device(handle);
+	if (!dd) {
+		kfree(dock_station);
+		return -ENOMEM;
+	}
+	add_dock_dependent_device(dock_station, dd);
+
+	/* register for dock events */
+	status = acpi_install_notify_handler(dock_station->handle,
+					     ACPI_SYSTEM_NOTIFY,
+					     acpi_dock_notify, dock_station);
+
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "Error installing notify handler\n");
+		ret = -ENODEV;
+		goto dock_add_err;
+	}
+
+	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_NAME);
+
+	return 0;
+
+dock_add_err:
+	kfree(dock_station);
+	kfree(dd);
+	return ret;
+}
+
+/**
+ * acpi_dock_remove - free up resources related to the dock station
+ */
+static int acpi_dock_remove(void)
+{
+	struct dock_dependent_device *dd, *tmp;
+	acpi_status status;
+
+	if (!dock_station)
+		return 0;
+
+	/* remove dependent devices */
+	list_for_each_entry_safe(dd, tmp, &dock_station->dependent_devices,
+				 list)
+	    kfree(dd);
+
+	/* remove dock notify handler */
+	status = acpi_remove_notify_handler(dock_station->handle,
+					    ACPI_SYSTEM_NOTIFY,
+					    acpi_dock_notify);
+	if (ACPI_FAILURE(status))
+		printk(KERN_ERR "Error removing notify handler\n");
+
+	/* free dock station memory */
+	kfree(dock_station);
+	return 0;
+}
+
+/**
+ * find_dock - look for a dock station
+ * @handle: acpi handle of a device
+ * @lvl: unused
+ * @context: counter of dock stations found
+ * @rv: unused
+ *
+ * This is called by acpi_walk_namespace to look for dock stations.
+ */
+static acpi_status
+find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+	acpi_status status = AE_OK;
+
+	if (is_dock(handle)) {
+		if (acpi_dock_add(handle) >= 0) {
+			(*count)++;
+			status = AE_CTRL_TERMINATE;
+		}
+	}
+	return status;
+}
+
+static int __init acpi_dock_init(void)
+{
+	int num = 0;
+
+	dock_station = NULL;
+
+	/* look for a dock station */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			    ACPI_UINT32_MAX, find_dock, &num, NULL);
+
+	if (!num)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit acpi_dock_exit(void)
+{
+	acpi_dock_remove();
+}
+
+module_init(acpi_dock_init);
+module_exit(acpi_dock_exit);
--- 2.6-git-kca2.orig/drivers/acpi/Kconfig
+++ 2.6-git-kca2/drivers/acpi/Kconfig
@@ -134,6 +134,13 @@ config ACPI_FAN
 	  This driver adds support for ACPI fan devices, allowing user-mode 
 	  applications to perform basic fan control (on, off, status).
 
+config ACPI_DOCK
+	tristate "Dock"
+	depends on !ACPI_IBM_DOCK
+	default y
+	help
+	  This driver adds support for ACPI controlled docking stations
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	default y
--- 2.6-git-kca2.orig/drivers/acpi/Makefile
+++ 2.6-git-kca2/drivers/acpi/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
+obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o 
 obj-$(CONFIG_ACPI_HOTKEY)	+= hotkey.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
--- 2.6-git-kca2.orig/drivers/acpi/scan.c
+++ 2.6-git-kca2/drivers/acpi/scan.c
@@ -703,6 +703,29 @@ static int acpi_bus_find_driver(struct a
                                  Device Enumeration
    -------------------------------------------------------------------------- */
 
+acpi_status
+acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
+{
+	acpi_status status;
+	acpi_handle tmp;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+
+	status = acpi_get_handle(handle, "_EJD", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	status = acpi_evaluate_object(handle, "_EJD", NULL, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		obj = buffer.pointer;
+		status = acpi_get_handle(NULL, obj->string.pointer, ejd);
+		acpi_os_free(buffer.pointer);
+	}
+	return status;
+}
+EXPORT_SYMBOL_GPL(acpi_bus_get_ejd);
+
+
 static int acpi_bus_get_flags(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
--- 2.6-git-kca2.orig/include/acpi/acpi_bus.h
+++ 2.6-git-kca2/include/acpi/acpi_bus.h
@@ -332,7 +332,7 @@ int acpi_bus_add(struct acpi_device **ch
 		 acpi_handle handle, int type);
 int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_start(struct acpi_device *device);
-
+acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd);
 int acpi_match_ids(struct acpi_device *device, char *ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
--- 2.6-git-kca2.orig/include/acpi/acpi_drivers.h
+++ 2.6-git-kca2/include/acpi/acpi_drivers.h
@@ -110,4 +110,21 @@ int acpi_processor_set_thermal_limit(acp
 
 extern int acpi_specific_hotkey_enabled;
 
+/*--------------------------------------------------------------------------
+                                  Dock Station
+  -------------------------------------------------------------------------- */
+#if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
+extern int is_dock_device(acpi_handle handle);
+extern int register_dock_notifier(struct notifier_block *nb);
+extern void unregister_dock_notifier(struct notifier_block *nb);
+extern int register_hotplug_dock_device(acpi_handle handle,
+	acpi_notify_handler handler, void *context);
+extern void unregister_hotplug_dock_device(acpi_handle handle);
+#else
+#define is_dock_device(h)			(0)
+#define register_dock_notifier(nb) 		(-ENODEV)
+#define unregister_dock_notifier(nb)           	do { } while(0)
+#define register_hotplug_dock_device(h1, h2, c)	(-ENODEV)
+#define unregister_hotplug_dock_device(h)       do { } while(0)
+#endif
 #endif /*__ACPI_DRIVERS_H__*/
