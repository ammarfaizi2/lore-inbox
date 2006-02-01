Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423032AbWBAXbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWBAXbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbWBAXbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:31:15 -0500
Received: from rigel.cs.pdx.edu ([131.252.208.59]:41896 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id S1423028AbWBAXbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:31:13 -0500
Date: Wed, 1 Feb 2006 15:30:05 -0800
From: Kristen Carlson Accardi <kristenc@cs.pdx.edu>
To: pcihpd-discuss@lists.sourceforge.net
Cc: greg@kroah.com, len.brown@intel.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, muneda.takahiro@jp.fujitsu.com,
       linux-acpi@vger.kernel.org
Subject: [patch] acpiphp: handle dock stations
Message-ID: <20060201233005.GA4999@nerpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: kristen.c.accardi@intel.com

This patch will add hot add/remove of docking stations to acpiphp.  Because
some docking stations will have a _DCK method that is not associated with
a dock bridge, we use the _EJD method to determine which devices are 
dependent on the dock device, then try to find which of these dependent
devices are pci devices.  We register a separate event handler with acpi
to handle dock notifications, but if we have discovered any pci devices
dependent on the dock station, we notify the acpiphp driver to rescan
the correct bus.  If no pci devices are found, but there is still a _DCK method
present, the driver will stay loaded to deal with the dock notifications.

This patch does not implement full _EJD support yet - it just uses it
to find the dock bridge (if it exists) for rescanning pci.  It also does
not attempt to add devices that are not enumerable via pci.  It will
stay loaded even if we find a dock station with no p2p dock bridge
to handle the dock notifications.  I will likely move all the dependent
device stuff out of acpiphp and into acpi in the future because some
of that code can be used by any device that has _EJD, not just pci 
hotplug - but for now we'll leave it here.

You cannot use this patch and the ibm_acpi driver at same time due to
the fact that both drivers attempt to register for dock notifications.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
Greg - this patch is against 2.6.16-rc1-git5 and replaces the patch
pci-hotplug-acpiphp-handle-dock-bridges.patch in your tree.  I assume
the other patches I sent originally are still applied.  I moved all
the dock stuff into a separate file because I felt it was starting
to clutter acpiphp_glue.c a bit.  I don't think this will conflict
with anything anyone else is working on.

 drivers/pci/hotplug/Makefile       |    3 
 drivers/pci/hotplug/acpiphp.h      |   36 +++
 drivers/pci/hotplug/acpiphp_core.c |    7 
 drivers/pci/hotplug/acpiphp_dock.c |  368 +++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/acpiphp_glue.c |   53 ++++-
 5 files changed, 452 insertions(+), 15 deletions(-)

Index: linux-2.6.16-rc1/drivers/pci/hotplug/Makefile
===================================================================
--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/Makefile
+++ linux-2.6.16-rc1/drivers/pci/hotplug/Makefile
@@ -37,7 +37,8 @@ ibmphp-objs		:=	ibmphp_core.o	\
 				ibmphp_hpc.o
 
 acpiphp-objs		:=	acpiphp_core.o	\
-				acpiphp_glue.o
+				acpiphp_glue.o  \
+				acpiphp_dock.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
 				rpaphp_pci.o	\
Index: linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp.h
===================================================================
--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/acpiphp.h
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp.h
@@ -160,6 +160,25 @@ struct acpiphp_attention_info
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
 
@@ -197,6 +216,12 @@ struct acpiphp_attention_info
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
 
@@ -210,6 +235,7 @@ extern void acpiphp_glue_exit (void);
 extern int acpiphp_get_num_slots (void);
 extern struct acpiphp_slot *get_slot_from_id (int id);
 typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
+void handle_hotplug_event_func(acpi_handle, u32, void*);
 
 extern int acpiphp_enable_slot (struct acpiphp_slot *slot);
 extern int acpiphp_disable_slot (struct acpiphp_slot *slot);
@@ -219,6 +245,16 @@ extern u8 acpiphp_get_latch_status (stru
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
 
Index: linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_core.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/acpiphp_core.c
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_core.c
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
Index: linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_dock.c
===================================================================
--- /dev/null
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_dock.c
@@ -0,0 +1,368 @@
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
+	struct dependent_device *dd;
+
+	if (!ds)
+		return 0;
+
+	list_for_each_entry(dd, &ds->dependent_devices, device_list) {
+		if (handle == dd->handle)
+			return 1;
+	}
+	return 0;
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
+static acpi_status handle_dock(acpi_handle handle, int dock)
+{
+	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	/* _DCK method has one argument */
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = dock;
+	status = acpi_evaluate_object(handle, "_DCK",
+					&arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		err("%s: failed to dock!!\n", __FUNCTION__);
+	acpi_os_free(buffer.pointer);
+
+	return status;
+}
+
+
+
+/*
+ * the _DCK method can do funny things... and sometimes not
+ * hah-hah funny.
+ */
+static void post_dock_fixups(struct acpiphp_slot *slot)
+{
+	struct pci_bus *bus = slot->bridge->pci_bus;
+	u32 buses;
+
+	/* fixup bad _DCK function that rewrites
+	 * secondary bridge on slot
+	 */
+	pci_read_config_dword(bus->self,
+				PCI_PRIMARY_BUS,
+				&buses);
+
+	if (((buses >> 8) & 0xff) != bus->secondary) {
+		buses = (buses & 0xff000000)
+	     		| ((unsigned int)(bus->primary)     <<  0)
+	     		| ((unsigned int)(bus->secondary)   <<  8)
+	     		| ((unsigned int)(bus->subordinate) << 16);
+		pci_write_config_dword(bus->self,
+					PCI_PRIMARY_BUS,
+					buses);
+	}
+}
+
+
+
+
+static void
+handle_hotplug_event_dock(acpi_handle handle, u32 type, void *context)
+{
+	struct acpiphp_dock_station *station =
+				(struct acpiphp_dock_station *) context;
+	struct dependent_device *dd;
+
+	switch (type) {
+		case ACPI_NOTIFY_BUS_CHECK:
+			station->flags |= DOCK_DOCKING;
+			handle_dock(station->handle, 1);
+			/* TBD - this should be done probably similar
+			 * to pci quirks, because only certain laptops
+			 * will need certain fixups done.
+			 */
+			list_for_each_entry(dd, &ds->pci_dependent_devices,
+						pci_list)
+				post_dock_fixups(dd->func->slot);
+
+			list_for_each_entry(dd, &ds->pci_dependent_devices,
+					pci_list)
+				handle_hotplug_event_func(dd->handle,
+						type, dd->func);
+			station->flags &= ~(DOCK_DOCKING);
+			station->last_dock_time = jiffies;
+			break;
+		case ACPI_NOTIFY_EJECT_REQUEST:
+			if (station->flags & DOCK_DOCKING ||
+				station->last_dock_time == jiffies) {
+			} else {
+				handle_dock(station->handle, 0);
+				list_for_each_entry(dd,
+					&ds->pci_dependent_devices, pci_list)
+
+ 					handle_hotplug_event_func(dd->handle,
+						type, dd->func);
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
+	char ejd_objname[64];
+	struct acpi_buffer buffer = { .length = sizeof(objname),
+				      .pointer = objname };
+	struct acpi_buffer ejd_buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer ejd_name_buffer = { .length = sizeof(objname),
+						.pointer = ejd_objname };
+	union acpi_object *ejd_obj;
+	union acpi_object *dck_obj;
+
+	status = acpi_get_handle(handle, "_EJD", &tmp);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	/* make sure we are dependent on the dock device */
+	acpi_get_name(dck_handle, ACPI_FULL_PATHNAME, &buffer);
+	status = acpi_evaluate_object(handle, "_EJD", NULL, &ejd_buffer);
+	if (ACPI_FAILURE(status)) {
+		err("Unable to execute _EJD!\n");
+		goto find_ejd_out;
+	}
+
+	/* because acpi_get_name will pad the names if they are less
+	 * than 4 characters, we can't compare the strings returned
+	 * from _EJD with those returned from acpi_get_name.  So,
+	 * we have to get a handle to the object referenced by _EJD
+	 * and then call get name on that.
+	 */
+	ejd_obj = ejd_buffer.pointer;
+	status = acpi_get_handle(NULL, ejd_obj->string.pointer, &tmp);
+	if (ACPI_FAILURE(status))
+		goto find_ejd_out;
+	acpi_get_name(tmp, ACPI_FULL_PATHNAME, &ejd_name_buffer);
+
+	dck_obj = buffer.pointer;
+	if (!strncmp(ejd_objname, objname, strlen(ejd_objname))) {
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
+		list_for_each_entry(dd, &ds->dependent_devices, device_list) {
+			list_del(&dd->device_list);
+			kfree(dd);
+		}
+
+		/* no need to touch the pci_dependent_device list,
+		 * cause all memory was freed above
+		 */
+		kfree(ds);
+	}
+}
+
+
Index: linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_glue.c
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
@@ -210,18 +224,28 @@ register_slot(acpi_handle handle, u32 lv
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
+	/* if this is a device dependent on a dock station,
+	 * associate the acpiphp_func to the dependent_device
+ 	 * struct.
+	 */
+	if ((dd = get_dependent_device(handle))) {
+		newfunc->flags |= FUNC_IS_DD;
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
+		if (ACPI_FAILURE(status))
+			err("failed to register interrupt notify handler\n");
 	}
 
-	return AE_OK;
+	return status;
 }
 
 
@@ -410,7 +434,8 @@ find_p2p_bridge(acpi_handle handle, u32 
 		goto out;
 
 	/* check if this bridge has ejectable slots */
-	if (detect_ejectable_slots(handle) > 0) {
+	if ((detect_ejectable_slots(handle) > 0) ||
+		(detect_dependent_devices(handle) > 0)) {
 		dbg("found PCI-to-PCI bridge at PCI %s\n", pci_name(dev));
 		add_p2p_bridge(handle, dev);
 	}
@@ -512,11 +537,13 @@ static void cleanup_bridge(struct acpiph
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
@@ -1302,7 +1329,7 @@ static void handle_hotplug_event_bridge(
  * handles ACPI event notification on slots
  *
  */
-static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
+void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
 {
 	struct acpiphp_func *func;
 	char objname[64];

