Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWBVTRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWBVTRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBVTRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:17:33 -0500
Received: from fmr20.intel.com ([134.134.136.19]:54989 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751311AbWBVTR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:17:28 -0500
Subject: [patch 2/3] acpiphp: add dock event handling
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, muneda.takahiro@jp.fujitsu.com,
       pavel@ucw.cz, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
References: <20060222190839.268403000@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Feb 2006 11:21:27 -0800
Message-Id: <1140636088.32574.20.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 22 Feb 2006 19:16:12.0323 (UTC) FILETIME=[7184AF30:01C637E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add generic dock event handling to acpiphp.  If there are
pci devices that need to be inserted/removed after the dock event, the
event notification will be handed down to the normal pci hotplug event
handler in acpiphp so that new bridges/devices can be enumerated.

Because some dock stations do not have pci bridges or pci devices that
need to be inserted after a dock, acpiphp will remain loaded to handle
dock events even if no hotpluggable pci slots are discovered.

You probably need to have the pci=assign-busses kernel parameter enabled 
to use these patches, and you may not allow ibm_acpi to handle docking
notifications and use this patch.

This patch incorporates feedback provided by many.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/pci/hotplug/Makefile       |    3 
 drivers/pci/hotplug/acpiphp.h      |   36 +++
 drivers/pci/hotplug/acpiphp_core.c |    7 
 drivers/pci/hotplug/acpiphp_dock.c |  437 +++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/acpiphp_glue.c |   82 +++++-
 5 files changed, 545 insertions(+), 20 deletions(-)

--- linux-dock-mm.orig/drivers/pci/hotplug/acpiphp.h
+++ linux-dock-mm/drivers/pci/hotplug/acpiphp.h
@@ -161,6 +161,25 @@ struct acpiphp_attention_info
 	struct module *owner;
 };
 
+
+struct dependent_device {
+	struct list_head device_list;
+	struct list_head pci_list;
+	acpi_handle handle;
+	struct acpiphp_func *func;
+};
+
+
+struct acpiphp_dock_station {
+	acpi_handle handle;
+	u32 last_dock_time;
+	u32 flags;
+	struct acpiphp_func *dock_bridge;
+	struct list_head dependent_devices;
+	struct list_head pci_dependent_devices;
+};
+
+
 /* PCI bus bridge HID */
 #define ACPI_PCI_HOST_HID		"PNP0A03"
 
@@ -198,6 +217,12 @@ struct acpiphp_attention_info
 #define FUNC_HAS_PS1		(0x00000020)
 #define FUNC_HAS_PS2		(0x00000040)
 #define FUNC_HAS_PS3		(0x00000080)
+#define FUNC_HAS_DCK            (0x00000100)
+#define FUNC_IS_DD              (0x00000200)
+
+/* dock station flags */
+#define DOCK_DOCKING            (0x00000001)
+#define DOCK_HAS_BRIDGE         (0x00000002)
 
 /* function prototypes */
 
@@ -211,6 +236,7 @@ extern void acpiphp_glue_exit (void);
 extern int acpiphp_get_num_slots (void);
 extern struct acpiphp_slot *get_slot_from_id (int id);
 typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
+void handle_hotplug_event_func(acpi_handle, u32, void*);
 
 extern int acpiphp_enable_slot (struct acpiphp_slot *slot);
 extern int acpiphp_disable_slot (struct acpiphp_slot *slot);
@@ -220,6 +246,16 @@ extern u8 acpiphp_get_latch_status (stru
 extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
 extern u32 acpiphp_get_address (struct acpiphp_slot *slot);
 
+/* acpiphp_dock.c */
+extern int find_dock_station(void);
+extern void remove_dock_station(void);
+extern void add_dependent_device(struct dependent_device *new_dd);
+extern void add_pci_dependent_device(struct dependent_device *new_dd);
+extern struct dependent_device *get_dependent_device(acpi_handle handle);
+extern int is_dependent_device(acpi_handle handle);
+extern int detect_dependent_devices(acpi_handle *bridge_handle);
+extern struct dependent_device *alloc_dependent_device(acpi_handle handle);
+
 /* variables */
 extern int acpiphp_debug;
 
--- linux-dock-mm.orig/drivers/pci/hotplug/acpiphp_core.c
+++ linux-dock-mm/drivers/pci/hotplug/acpiphp_core.c
@@ -429,14 +429,17 @@ static void __exit cleanup_slots (void)
 static int __init acpiphp_init(void)
 {
 	int retval;
+	int docking_station;
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 	acpiphp_debug = debug;
 
+	docking_station = find_dock_station();
+
 	/* read all the ACPI info from the system */
 	retval = init_acpi();
-	if (retval)
+	if (retval && !(docking_station))
 		return retval;
 
 	return init_slots();
@@ -448,6 +451,8 @@ static void __exit acpiphp_exit(void)
 	cleanup_slots();
 	/* deallocate internal data structures etc. */
 	acpiphp_glue_exit();
+
+	remove_dock_station();
 }
 
 module_init(acpiphp_init);
--- /dev/null
+++ linux-dock-mm/drivers/pci/hotplug/acpiphp_dock.c
@@ -0,0 +1,437 @@
+/*
+ * ACPI PCI HotPlug dock functions to ACPI CA subsystem
+ *
+ * Copyright (C) 2006 Kristen Carlson Accardi (kristen.c.accardi@intel.com)
+ * Copyright (C) 2006 Intel Corporation
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
+ * Send feedback to <kristen.c.accardi@intel.com>
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/smp_lock.h>
+#include <linux/mutex.h>
+
+#include "../pci.h"
+#include "pci_hotplug.h"
+#include "acpiphp.h"
+
+static struct acpiphp_dock_station *ds;
+#define MY_NAME "acpiphp_dock"
+
+
+int is_dependent_device(acpi_handle handle)
+{
+	return (get_dependent_device(handle) ? 1 : 0);
+}
+
+
+static acpi_status
+find_dependent_device(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	if (is_dependent_device(handle)) {
+		(*count)++;
+		return AE_CTRL_TERMINATE;
+	} else {
+		return AE_OK;
+	}
+}
+
+
+
+
+void add_dependent_device(struct dependent_device *new_dd)
+{
+	list_add_tail(&new_dd->device_list, &ds->dependent_devices);
+}
+
+
+void add_pci_dependent_device(struct dependent_device *new_dd)
+{
+	list_add_tail(&new_dd->pci_list, &ds->pci_dependent_devices);
+}
+
+
+
+struct dependent_device * get_dependent_device(acpi_handle handle)
+{
+	struct dependent_device *dd;
+
+	if (!ds)
+		return NULL;
+
+	list_for_each_entry(dd, &ds->dependent_devices, device_list) {
+		if (handle == dd->handle)
+			return dd;
+	}
+	return NULL;
+}
+
+
+
+struct dependent_device *alloc_dependent_device(acpi_handle handle)
+{
+	struct dependent_device *dd;
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	if (dd) {
+		INIT_LIST_HEAD(&dd->pci_list);
+		INIT_LIST_HEAD(&dd->device_list);
+		dd->handle = handle;
+	}
+	return dd;
+}
+
+
+
+static int is_dock(acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status = acpi_get_handle(handle, "_DCK", &tmp);
+	if (ACPI_FAILURE(status)) {
+		return 0;
+	}
+	return 1;
+}
+
+
+
+static int dock_present(void)
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
+
+
+static void eject_dock(void)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(ds->handle, "_EJ0",
+					&arg_list, NULL)) || dock_present())
+		warn("%s: failed to eject dock!\n", __FUNCTION__);
+
+	return;
+}
+
+
+
+
+static acpi_status handle_dock(int dock)
+{
+	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	dbg("%s: %s\n", __FUNCTION__, dock ? "docking" : "undocking");
+
+	/* _DCK method has one argument */
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = dock;
+	status = acpi_evaluate_object(ds->handle, "_DCK",
+					&arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		err("%s: failed to execute _DCK\n", __FUNCTION__);
+	acpi_os_free(buffer.pointer);
+
+	return status;
+}
+
+
+
+static inline void dock(void)
+{
+	handle_dock(1);
+}
+
+
+
+static inline void undock(void)
+{
+	handle_dock(0);
+}
+
+
+
+/*
+ * the _DCK method can do funny things... and sometimes not
+ * hah-hah funny.
+ *
+ * TBD - figure out a way to only call fixups for
+ * systems that require them.
+ */
+static void post_dock_fixups(void)
+{
+	struct pci_bus *bus;
+	u32 buses;
+	struct dependent_device *dd;
+
+	list_for_each_entry(dd, &ds->pci_dependent_devices, pci_list) {
+		bus = dd->func->slot->bridge->pci_bus;
+
+		/* fixup bad _DCK function that rewrites
+	 	 * secondary bridge on slot
+	 	 */
+		pci_read_config_dword(bus->self,
+				PCI_PRIMARY_BUS,
+				&buses);
+
+		if (((buses >> 8) & 0xff) != bus->secondary) {
+			buses = (buses & 0xff000000)
+	     			| ((unsigned int)(bus->primary)     <<  0)
+	     			| ((unsigned int)(bus->secondary)   <<  8)
+	     			| ((unsigned int)(bus->subordinate) << 16);
+			pci_write_config_dword(bus->self,
+					PCI_PRIMARY_BUS,
+					buses);
+		}
+	}
+}
+
+
+
+static void hotplug_pci(u32 type)
+{
+	struct dependent_device *dd;
+
+	list_for_each_entry(dd, &ds->pci_dependent_devices, pci_list)
+		handle_hotplug_event_func(dd->handle, type, dd->func);
+}
+
+
+
+static inline void begin_dock(void)
+{
+	ds->flags |= DOCK_DOCKING;
+}
+
+
+static inline void complete_dock(void)
+{
+	ds->flags &= ~(DOCK_DOCKING);
+	ds->last_dock_time = jiffies;
+}
+
+
+static int dock_in_progress(void)
+{
+	if (ds->flags & DOCK_DOCKING ||
+		ds->last_dock_time == jiffies) {
+		dbg("dock in progress\n");
+		return 1;
+	}
+	return 0;
+}
+
+
+
+static void
+handle_hotplug_event_dock(acpi_handle handle, u32 type, void *context)
+{
+	dbg("%s: enter\n", __FUNCTION__);
+
+	switch (type) {
+		case ACPI_NOTIFY_BUS_CHECK:
+			dbg("BUS Check\n");
+			if (!dock_in_progress() && dock_present()) {
+				begin_dock();
+				dock();
+				if (!dock_present()) {
+					err("Unable to dock!\n");
+					break;
+				}
+				post_dock_fixups();
+				hotplug_pci(type);
+				complete_dock();
+			}
+			break;
+		case ACPI_NOTIFY_EJECT_REQUEST:
+			dbg("EJECT request\n");
+			if (!dock_in_progress() && dock_present()) {
+				hotplug_pci(type);
+				undock();
+				eject_dock();
+				if (dock_present())
+					err("Unable to undock!\n");
+			}
+			break;
+	}
+}
+
+
+
+
+static acpi_status
+find_dock_ejd(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status status;
+	acpi_handle tmp;
+	acpi_handle dck_handle = (acpi_handle) context;
+	char objname[64];
+	struct acpi_buffer buffer = { .length = sizeof(objname),
+				      .pointer = objname };
+	struct acpi_buffer ejd_buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *ejd_obj;
+
+	status = acpi_get_handle(handle, "_EJD", &tmp);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	/* make sure we are dependent on the dock device,
+	 * by executing the _EJD method, then getting a handle
+	 * to the device referenced by that name.  If that
+	 * device handle is the same handle as the dock station
+	 * handle, then we are a device dependent on the dock station
+	 */
+	acpi_get_name(dck_handle, ACPI_FULL_PATHNAME, &buffer);
+	status = acpi_evaluate_object(handle, "_EJD", NULL, &ejd_buffer);
+	if (ACPI_FAILURE(status)) {
+		err("Unable to execute _EJD!\n");
+		goto find_ejd_out;
+	}
+	ejd_obj = ejd_buffer.pointer;
+	status = acpi_get_handle(NULL, ejd_obj->string.pointer, &tmp);
+	if (ACPI_FAILURE(status))
+		goto find_ejd_out;
+
+	if (tmp == dck_handle) {
+		struct dependent_device *dd;
+		dbg("%s: found device dependent on dock\n", __FUNCTION__);
+		dd = alloc_dependent_device(handle);
+		if (!dd) {
+			err("Can't allocate memory for dependent device!\n");
+			goto find_ejd_out;
+		}
+		add_dependent_device(dd);
+	}
+
+find_ejd_out:
+	acpi_os_free(ejd_buffer.pointer);
+	return AE_OK;
+}
+
+
+
+int detect_dependent_devices(acpi_handle *bridge_handle)
+{
+	acpi_status status;
+	int count;
+
+	count = 0;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle,
+					(u32)1, find_dependent_device,
+					(void *)&count, NULL);
+
+	return count;
+}
+
+
+
+
+
+static acpi_status
+find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	if (is_dock(handle)) {
+		dbg("%s: found dock\n", __FUNCTION__);
+		ds = kzalloc(sizeof(*ds), GFP_KERNEL);
+		ds->handle = handle;
+		INIT_LIST_HEAD(&ds->dependent_devices);
+		INIT_LIST_HEAD(&ds->pci_dependent_devices);
+
+		/* look for devices dependent on dock station */
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, find_dock_ejd, handle, NULL);
+
+		acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+			handle_hotplug_event_dock, ds);
+		(*count)++;
+	}
+
+	return AE_OK;
+}
+
+
+
+
+int find_dock_station(void)
+{
+	int num = 0;
+
+	ds = NULL;
+
+	/* start from the root object, because some laptops define
+	 * _DCK methods outside the scope of PCI (IBM x-series laptop)
+	 */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, find_dock, &num, NULL);
+
+	return num;
+}
+
+
+
+void remove_dock_station(void)
+{
+	struct dependent_device *dd;
+	if (ds) {
+		if (ACPI_FAILURE(acpi_remove_notify_handler(ds->handle,
+			ACPI_SYSTEM_NOTIFY, handle_hotplug_event_dock)))
+			err("failed to remove dock notify handler\n");
+
+		/* free all dependent devices */
+		list_for_each_entry(dd, &ds->dependent_devices, device_list)
+			kfree(dd);
+
+		/* no need to touch the pci_dependent_device list,
+		 * cause all memory was freed above
+		 */
+		kfree(ds);
+	}
+}
+
+
--- linux-dock-mm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-dock-mm/drivers/pci/hotplug/acpiphp_glue.c
@@ -57,7 +57,6 @@ static LIST_HEAD(bridge_list);
 #define MY_NAME "acpiphp_glue"
 
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
-static void handle_hotplug_event_func (acpi_handle, u32, void *);
 static void acpiphp_sanitize_bus(struct pci_bus *bus);
 static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
 
@@ -125,6 +124,7 @@ register_slot(acpi_handle handle, u32 lv
 	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *)context;
 	struct acpiphp_slot *slot;
 	struct acpiphp_func *newfunc;
+	struct dependent_device *dd;
 	acpi_handle tmp;
 	acpi_status status = AE_OK;
 	unsigned long adr, sun;
@@ -138,7 +138,7 @@ register_slot(acpi_handle handle, u32 lv
 
 	status = acpi_get_handle(handle, "_EJ0", &tmp);
 
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status) && !(is_dependent_device(handle)))
 		return AE_OK;
 
 	device = (adr >> 16) & 0xffff;
@@ -152,7 +152,8 @@ register_slot(acpi_handle handle, u32 lv
 	INIT_LIST_HEAD(&newfunc->sibling);
 	newfunc->handle = handle;
 	newfunc->function = function;
-	newfunc->flags = FUNC_HAS_EJ0;
+	if (ACPI_SUCCESS(status))
+		newfunc->flags = FUNC_HAS_EJ0;
 
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_STA", &tmp)))
 		newfunc->flags |= FUNC_HAS_STA;
@@ -163,6 +164,19 @@ register_slot(acpi_handle handle, u32 lv
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_PS3", &tmp)))
 		newfunc->flags |= FUNC_HAS_PS3;
 
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_DCK", &tmp))) {
+		newfunc->flags |= FUNC_HAS_DCK;
+		/* add to devices dependent on dock station,
+		 * because this may actually be the dock bridge
+		 */
+		dd = alloc_dependent_device(handle);
+                if (!dd)
+                        err("Can't allocate memory for "
+				"new dependent device!\n");
+		else
+			add_dependent_device(dd);
+	}
+
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
 	if (ACPI_FAILURE(status))
 		sun = -1;
@@ -210,18 +224,35 @@ register_slot(acpi_handle handle, u32 lv
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
+	/* if this is a device dependent on a dock station,
+	 * associate the acpiphp_func to the dependent_device
+ 	 * struct.
+	 */
+	if ((dd = get_dependent_device(handle))) {
+		newfunc->flags |= FUNC_IS_DD;
+		/*
+		 * we don't want any devices which is dependent
+		 * on the dock to have it's _EJ0 method executed.
+		 * because we need to run _DCK first.
+		 */
+		newfunc->flags &= ~FUNC_HAS_EJ0;
+		dd->func = newfunc;
+		add_pci_dependent_device(dd);
+	}
+
 	/* install notify handler */
-	status = acpi_install_notify_handler(handle,
+	if (!(newfunc->flags & FUNC_HAS_DCK)) {
+		status = acpi_install_notify_handler(handle,
 					     ACPI_SYSTEM_NOTIFY,
 					     handle_hotplug_event_func,
 					     newfunc);
 
-	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler\n");
-		return status;
-	}
+		if (ACPI_FAILURE(status))
+			err("failed to register interrupt notify handler\n");
+	} else
+		status = AE_OK;
 
-	return AE_OK;
+	return status;
 }
 

@@ -410,7 +441,8 @@ find_p2p_bridge(acpi_handle handle, u32 
 		goto out;
 
 	/* check if this bridge has ejectable slots */
-	if (detect_ejectable_slots(handle) > 0) {
+	if ((detect_ejectable_slots(handle) > 0) ||
+		(detect_dependent_devices(handle) > 0)) {
 		dbg("found PCI-to-PCI bridge at PCI %s\n", pci_name(dev));
 		add_p2p_bridge(handle, dev);
 	}
@@ -512,11 +544,13 @@ static void cleanup_bridge(struct acpiph
 		list_for_each_safe (list, tmp, &slot->funcs) {
 			struct acpiphp_func *func;
 			func = list_entry(list, struct acpiphp_func, sibling);
-			status = acpi_remove_notify_handler(func->handle,
+			if (!(func->flags & FUNC_HAS_DCK)) {
+				status = acpi_remove_notify_handler(func->handle,
 						ACPI_SYSTEM_NOTIFY,
 						handle_hotplug_event_func);
-			if (ACPI_FAILURE(status))
-				err("failed to remove notify handler\n");
+				if (ACPI_FAILURE(status))
+					err("failed to remove notify handler\n");
+			}
 			pci_dev_put(func->pci_dev);
 			list_del(list);
 			kfree(func);
@@ -828,11 +862,21 @@ static int acpiphp_bus_add(struct acpiph
 		dbg("no parent device, assuming NULL\n");
 		pdevice = NULL;
 	}
+	if (!acpi_bus_get_device(func->handle, &device)) {
+		dbg("bus exists... trim\n");
+		/* this shouldn't be in here, so remove
+		 * the bus then re-add it...
+		 */
+		ret_val = acpi_bus_trim(device, 1);
+		dbg("acpi_bus_trim return %x\n", ret_val);
+	}
 	ret_val = acpi_bus_add(&device, pdevice, func->handle,
-			ACPI_BUS_TYPE_DEVICE);
-	if (ret_val)
-		dbg("cannot add bridge to acpi list\n");
-
+		ACPI_BUS_TYPE_DEVICE);
+	if (ret_val) {
+		dbg("error adding bus, %x\n",
+			-ret_val);
+		goto acpiphp_bus_add_out;
+	}
 	/*
 	 * try to start anyway.  We could have failed to add
 	 * simply because this bus had previously been added
@@ -840,7 +884,9 @@ static int acpiphp_bus_add(struct acpiph
 	 * we just keep going.
 	 */
 	ret_val = acpi_bus_start(device);
+	dbg("acpi_bus_start returns %x\n", ret_val);
 
+acpiphp_bus_add_out:
 	return ret_val;
 }
 
@@ -1302,7 +1348,7 @@ static void handle_hotplug_event_bridge(
  * handles ACPI event notification on slots
  *
  */
-static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
+void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
 {
 	struct acpiphp_func *func;
 	char objname[64];
--- linux-dock-mm.orig/drivers/pci/hotplug/Makefile
+++ linux-dock-mm/drivers/pci/hotplug/Makefile
@@ -37,7 +37,8 @@ ibmphp-objs		:=	ibmphp_core.o	\
 				ibmphp_hpc.o
 
 acpiphp-objs		:=	acpiphp_core.o	\
-				acpiphp_glue.o
+				acpiphp_glue.o  \
+				acpiphp_dock.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
 				rpaphp_pci.o	\

--
