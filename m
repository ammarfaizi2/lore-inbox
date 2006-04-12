Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWDLWKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWDLWKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWDLWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:10:26 -0400
Received: from mga03.intel.com ([143.182.124.21]:7236 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932340AbWDLWKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:10:16 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22497359:sNHT19570712"
Subject: [patch 2/3] acpiphp: use new dock driver
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com, greg@kroah.com
Cc: linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mochel@linux.intel.com,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
References: <20060412221027.472109000@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 15:18:45 -0700
Message-Id: <1144880325.11215.45.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 12 Apr 2006 22:10:13.0916 (UTC) FILETIME=[DF6F15C0:01C65E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the acpiphp driver to use the acpi dock driver for dock notifications.
Only load the acpiphp driver if we find we have pci dock devices

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/pci/hotplug/acpiphp_dock.c |  438 -------------------------------------
 drivers/pci/hotplug/Makefile       |    3 
 drivers/pci/hotplug/acpiphp.h      |   35 --
 drivers/pci/hotplug/acpiphp_core.c |   19 -
 drivers/pci/hotplug/acpiphp_glue.c |  110 +++++++--
 5 files changed, 86 insertions(+), 519 deletions(-)

--- 2.6-git-kca2.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ 2.6-git-kca2/drivers/pci/hotplug/acpiphp_glue.c
@@ -116,6 +116,59 @@ is_ejectable_slot(acpi_handle handle, u3
 	}
 }
 
+/* callback routine to check for the existance of a pci dock device */
+static acpi_status
+is_pci_dock_device(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	if (is_dock_device(handle)) {
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
+/*
+ * the _DCK method can do funny things... and sometimes not
+ * hah-hah funny.
+ *
+ * TBD - figure out a way to only call fixups for
+ * systems that require them.
+ */
+static int post_dock_fixups(struct notifier_block *nb, unsigned long val,
+	void *v)
+{
+	struct acpiphp_func *func = container_of(nb, struct acpiphp_func, nb);
+	struct pci_bus *bus = func->slot->bridge->pci_bus;
+	u32 buses;
+
+	if (!bus->self)
+		return  NOTIFY_OK;
+
+	/* fixup bad _DCK function that rewrites
+	 * secondary bridge on slot
+	 */
+	pci_read_config_dword(bus->self,
+			PCI_PRIMARY_BUS,
+			&buses);
+
+	if (((buses >> 8) & 0xff) != bus->secondary) {
+		buses = (buses & 0xff000000)
+	     		| ((unsigned int)(bus->primary)     <<  0)
+	     		| ((unsigned int)(bus->secondary)   <<  8)
+	     		| ((unsigned int)(bus->subordinate) << 16);
+		pci_write_config_dword(bus->self, PCI_PRIMARY_BUS, buses);
+	}
+	return NOTIFY_OK;
+}
+
+
+
 
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
@@ -124,7 +177,6 @@ register_slot(acpi_handle handle, u32 lv
 	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *)context;
 	struct acpiphp_slot *slot;
 	struct acpiphp_func *newfunc;
-	struct dependent_device *dd;
 	acpi_handle tmp;
 	acpi_status status = AE_OK;
 	unsigned long adr, sun;
@@ -137,7 +189,7 @@ register_slot(acpi_handle handle, u32 lv
 
 	status = acpi_get_handle(handle, "_EJ0", &tmp);
 
-	if (ACPI_FAILURE(status) && !(is_dependent_device(handle)))
+	if (ACPI_FAILURE(status) && !(is_dock_device(handle)))
 		return AE_OK;
 
 	device = (adr >> 16) & 0xffff;
@@ -162,18 +214,8 @@ register_slot(acpi_handle handle, u32 lv
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_PS3", &tmp)))
 		newfunc->flags |= FUNC_HAS_PS3;
 
-	if (ACPI_SUCCESS(acpi_get_handle(handle, "_DCK", &tmp))) {
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_DCK", &tmp)))
 		newfunc->flags |= FUNC_HAS_DCK;
-		/* add to devices dependent on dock station,
-		 * because this may actually be the dock bridge
-		 */
-		dd = alloc_dependent_device(handle);
-                if (!dd)
-                        err("Can't allocate memory for "
-				"new dependent device!\n");
-		else
-			add_dependent_device(dd);
-	}
 
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
 	if (ACPI_FAILURE(status))
@@ -225,20 +267,22 @@ register_slot(acpi_handle handle, u32 lv
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
-	/* if this is a device dependent on a dock station,
-	 * associate the acpiphp_func to the dependent_device
- 	 * struct.
-	 */
-	if ((dd = get_dependent_device(handle))) {
-		newfunc->flags |= FUNC_IS_DD;
-		/*
-		 * we don't want any devices which is dependent
-		 * on the dock to have it's _EJ0 method executed.
-		 * because we need to run _DCK first.
+	if (is_dock_device(handle)) {
+		/* we don't want to call this device's _EJ0
+		 * because we want the dock notify handler
+		 * to call it after it calls _DCK
 		 */
 		newfunc->flags &= ~FUNC_HAS_EJ0;
-		dd->func = newfunc;
-		add_pci_dependent_device(dd);
+		status = register_hotplug_dock_device(handle, handle_hotplug_event_func,
+			newfunc);
+		if (ACPI_FAILURE(status))
+			dbg("failed to register dock device\n");
+		/* we need to be notified when dock events happen
+		 * outside of the hotplug operation, since we may
+		 * need to do fixups before we can hotplug.
+		 */
+		newfunc->nb.notifier_call = post_dock_fixups;
+		register_dock_notifier(&newfunc->nb);
 	}
 
 	/* install notify handler */
@@ -277,6 +321,15 @@ static int detect_ejectable_slots(acpi_h
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle, (u32)1,
 				     is_ejectable_slot, (void *)&count, NULL);
 
+	/*
+	 * we also need to add this bridge if there is a dock bridge or
+	 * other pci device on a dock station (removable)
+	 */
+	if (!count)
+		status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle,
+				(u32)1, is_pci_dock_device, (void *)&count,
+				NULL);
+
 	return count;
 }
 
@@ -413,8 +466,7 @@ find_p2p_bridge(acpi_handle handle, u32 
 		goto out;
 
 	/* check if this bridge has ejectable slots */
-	if ((detect_ejectable_slots(handle) > 0) ||
-		(detect_dependent_devices(handle) > 0)) {
+	if ((detect_ejectable_slots(handle) > 0)) {
 		dbg("found PCI-to-PCI bridge at PCI %s\n", pci_name(dev));
 		add_p2p_bridge(handle, dev);
 	}
@@ -522,6 +574,10 @@ static void cleanup_bridge(struct acpiph
 		list_for_each_safe (list, tmp, &slot->funcs) {
 			struct acpiphp_func *func;
 			func = list_entry(list, struct acpiphp_func, sibling);
+			if (is_dock_device(func->handle)) {
+				unregister_hotplug_dock_device(func->handle);
+				unregister_dock_notifier(&func->nb);
+			}
 			if (!(func->flags & FUNC_HAS_DCK)) {
 				status = acpi_remove_notify_handler(func->handle,
 						ACPI_SYSTEM_NOTIFY,
--- 2.6-git-kca2.orig/drivers/pci/hotplug/Makefile
+++ 2.6-git-kca2/drivers/pci/hotplug/Makefile
@@ -40,8 +40,7 @@ ibmphp-objs		:=	ibmphp_core.o	\
 				ibmphp_hpc.o
 
 acpiphp-objs		:=	acpiphp_core.o	\
-				acpiphp_glue.o  \
-				acpiphp_dock.o
+				acpiphp_glue.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
 				rpaphp_pci.o	\
--- 2.6-git-kca2.orig/drivers/pci/hotplug/acpiphp.h
+++ 2.6-git-kca2/drivers/pci/hotplug/acpiphp.h
@@ -125,7 +125,7 @@ struct acpiphp_func {
 
 	struct list_head sibling;
 	struct pci_dev *pci_dev;
-
+	struct notifier_block nb;
 	acpi_handle	handle;
 
 	u8		function;	/* pci function# */
@@ -146,24 +146,6 @@ struct acpiphp_attention_info
 };
 

-struct dependent_device {
-	struct list_head device_list;
-	struct list_head pci_list;
-	acpi_handle handle;
-	struct acpiphp_func *func;
-};
-
-
-struct acpiphp_dock_station {
-	acpi_handle handle;
-	u32 last_dock_time;
-	u32 flags;
-	struct acpiphp_func *dock_bridge;
-	struct list_head dependent_devices;
-	struct list_head pci_dependent_devices;
-};
-
-
 /* PCI bus bridge HID */
 #define ACPI_PCI_HOST_HID		"PNP0A03"
 
@@ -202,11 +184,6 @@ struct acpiphp_dock_station {
 #define FUNC_HAS_PS2		(0x00000040)
 #define FUNC_HAS_PS3		(0x00000080)
 #define FUNC_HAS_DCK            (0x00000100)
-#define FUNC_IS_DD              (0x00000200)
-
-/* dock station flags */
-#define DOCK_DOCKING            (0x00000001)
-#define DOCK_HAS_BRIDGE         (0x00000002)
 
 /* function prototypes */
 
@@ -231,16 +208,6 @@ extern u8 acpiphp_get_latch_status (stru
 extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
 extern u32 acpiphp_get_address (struct acpiphp_slot *slot);
 
-/* acpiphp_dock.c */
-extern int find_dock_station(void);
-extern void remove_dock_station(void);
-extern void add_dependent_device(struct dependent_device *new_dd);
-extern void add_pci_dependent_device(struct dependent_device *new_dd);
-extern struct dependent_device *get_dependent_device(acpi_handle handle);
-extern int is_dependent_device(acpi_handle handle);
-extern int detect_dependent_devices(acpi_handle *bridge_handle);
-extern struct dependent_device *alloc_dependent_device(acpi_handle handle);
-
 /* variables */
 extern int acpiphp_debug;
 
--- 2.6-git-kca2.orig/drivers/pci/hotplug/acpiphp_core.c
+++ 2.6-git-kca2/drivers/pci/hotplug/acpiphp_core.c
@@ -416,27 +416,12 @@ void acpiphp_unregister_hotplug_slot(str
 
 static int __init acpiphp_init(void)
 {
-	int retval;
-	int docking_station;
-
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 	acpiphp_debug = debug;
 
-	docking_station = find_dock_station();
-
 	/* read all the ACPI info from the system */
-	retval = init_acpi();
-
-	/* if we have found a docking station, we should
-	 * go ahead and load even if init_acpi has found
-	 * no slots.  This handles the case when the _DCK
-	 * method not defined under the actual dock bridge
-	 */
-	if (docking_station)
-		return 0;
-	else
-		return retval;
+	return init_acpi();
 }
 

@@ -444,8 +429,6 @@ static void __exit acpiphp_exit(void)
 {
 	/* deallocate internal data structures etc. */
 	acpiphp_glue_exit();
-
-	remove_dock_station();
 }
 
 module_init(acpiphp_init);
--- 2.6-git-kca2.orig/drivers/pci/hotplug/acpiphp_dock.c
+++ /dev/null
@@ -1,438 +0,0 @@
-/*
- * ACPI PCI HotPlug dock functions to ACPI CA subsystem
- *
- * Copyright (C) 2006 Kristen Carlson Accardi (kristen.c.accardi@intel.com)
- * Copyright (C) 2006 Intel Corporation
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <kristen.c.accardi@intel.com>
- *
- */
-#include <linux/init.h>
-#include <linux/module.h>
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/smp_lock.h>
-#include <linux/mutex.h>
-
-#include "../pci.h"
-#include "pci_hotplug.h"
-#include "acpiphp.h"
-
-static struct acpiphp_dock_station *ds;
-#define MY_NAME "acpiphp_dock"
-
-
-int is_dependent_device(acpi_handle handle)
-{
-	return (get_dependent_device(handle) ? 1 : 0);
-}
-
-
-static acpi_status
-find_dependent_device(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	int *count = (int *)context;
-
-	if (is_dependent_device(handle)) {
-		(*count)++;
-		return AE_CTRL_TERMINATE;
-	} else {
-		return AE_OK;
-	}
-}
-
-
-
-
-void add_dependent_device(struct dependent_device *new_dd)
-{
-	list_add_tail(&new_dd->device_list, &ds->dependent_devices);
-}
-
-
-void add_pci_dependent_device(struct dependent_device *new_dd)
-{
-	list_add_tail(&new_dd->pci_list, &ds->pci_dependent_devices);
-}
-
-
-
-struct dependent_device * get_dependent_device(acpi_handle handle)
-{
-	struct dependent_device *dd;
-
-	if (!ds)
-		return NULL;
-
-	list_for_each_entry(dd, &ds->dependent_devices, device_list) {
-		if (handle == dd->handle)
-			return dd;
-	}
-	return NULL;
-}
-
-
-
-struct dependent_device *alloc_dependent_device(acpi_handle handle)
-{
-	struct dependent_device *dd;
-
-	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
-	if (dd) {
-		INIT_LIST_HEAD(&dd->pci_list);
-		INIT_LIST_HEAD(&dd->device_list);
-		dd->handle = handle;
-	}
-	return dd;
-}
-
-
-
-static int is_dock(acpi_handle handle)
-{
-	acpi_status status;
-	acpi_handle tmp;
-
-	status = acpi_get_handle(handle, "_DCK", &tmp);
-	if (ACPI_FAILURE(status)) {
-		return 0;
-	}
-	return 1;
-}
-
-
-
-static int dock_present(void)
-{
-	unsigned long sta;
-	acpi_status status;
-
-	if (ds) {
-		status = acpi_evaluate_integer(ds->handle, "_STA", NULL, &sta);
-		if (ACPI_SUCCESS(status) && sta)
-			return 1;
-	}
-	return 0;
-}
-
-
-
-static void eject_dock(void)
-{
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = 1;
-
-	if (ACPI_FAILURE(acpi_evaluate_object(ds->handle, "_EJ0",
-					&arg_list, NULL)) || dock_present())
-		warn("%s: failed to eject dock!\n", __FUNCTION__);
-
-	return;
-}
-
-
-
-
-static acpi_status handle_dock(int dock)
-{
-	acpi_status status;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-
-	dbg("%s: %s\n", __FUNCTION__, dock ? "docking" : "undocking");
-
-	/* _DCK method has one argument */
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = dock;
-	status = acpi_evaluate_object(ds->handle, "_DCK",
-					&arg_list, &buffer);
-	if (ACPI_FAILURE(status))
-		err("%s: failed to execute _DCK\n", __FUNCTION__);
-	acpi_os_free(buffer.pointer);
-
-	return status;
-}
-
-
-
-static inline void dock(void)
-{
-	handle_dock(1);
-}
-
-
-
-static inline void undock(void)
-{
-	handle_dock(0);
-}
-
-
-
-/*
- * the _DCK method can do funny things... and sometimes not
- * hah-hah funny.
- *
- * TBD - figure out a way to only call fixups for
- * systems that require them.
- */
-static void post_dock_fixups(void)
-{
-	struct pci_bus *bus;
-	u32 buses;
-	struct dependent_device *dd;
-
-	list_for_each_entry(dd, &ds->pci_dependent_devices, pci_list) {
-		bus = dd->func->slot->bridge->pci_bus;
-
-		/* fixup bad _DCK function that rewrites
-	 	 * secondary bridge on slot
-	 	 */
-		pci_read_config_dword(bus->self,
-				PCI_PRIMARY_BUS,
-				&buses);
-
-		if (((buses >> 8) & 0xff) != bus->secondary) {
-			buses = (buses & 0xff000000)
-	     			| ((unsigned int)(bus->primary)     <<  0)
-	     			| ((unsigned int)(bus->secondary)   <<  8)
-	     			| ((unsigned int)(bus->subordinate) << 16);
-			pci_write_config_dword(bus->self,
-					PCI_PRIMARY_BUS,
-					buses);
-		}
-	}
-}
-
-
-
-static void hotplug_pci(u32 type)
-{
-	struct dependent_device *dd;
-
-	list_for_each_entry(dd, &ds->pci_dependent_devices, pci_list)
-		handle_hotplug_event_func(dd->handle, type, dd->func);
-}
-
-
-
-static inline void begin_dock(void)
-{
-	ds->flags |= DOCK_DOCKING;
-}
-
-
-static inline void complete_dock(void)
-{
-	ds->flags &= ~(DOCK_DOCKING);
-	ds->last_dock_time = jiffies;
-}
-
-
-static int dock_in_progress(void)
-{
-	if (ds->flags & DOCK_DOCKING ||
-		ds->last_dock_time == jiffies) {
-		dbg("dock in progress\n");
-		return 1;
-	}
-	return 0;
-}
-
-
-
-static void
-handle_hotplug_event_dock(acpi_handle handle, u32 type, void *context)
-{
-	dbg("%s: enter\n", __FUNCTION__);
-
-	switch (type) {
-		case ACPI_NOTIFY_BUS_CHECK:
-			dbg("BUS Check\n");
-			if (!dock_in_progress() && dock_present()) {
-				begin_dock();
-				dock();
-				if (!dock_present()) {
-					err("Unable to dock!\n");
-					break;
-				}
-				post_dock_fixups();
-				hotplug_pci(type);
-				complete_dock();
-			}
-			break;
-		case ACPI_NOTIFY_EJECT_REQUEST:
-			dbg("EJECT request\n");
-			if (!dock_in_progress() && dock_present()) {
-				hotplug_pci(type);
-				undock();
-				eject_dock();
-				if (dock_present())
-					err("Unable to undock!\n");
-			}
-			break;
-	}
-}
-
-
-
-
-static acpi_status
-find_dock_ejd(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	acpi_status status;
-	acpi_handle tmp;
-	acpi_handle dck_handle = (acpi_handle) context;
-	char objname[64];
-	struct acpi_buffer buffer = { .length = sizeof(objname),
-				      .pointer = objname };
-	struct acpi_buffer ejd_buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	union acpi_object *ejd_obj;
-
-	status = acpi_get_handle(handle, "_EJD", &tmp);
-	if (ACPI_FAILURE(status))
-		return AE_OK;
-
-	/* make sure we are dependent on the dock device,
-	 * by executing the _EJD method, then getting a handle
-	 * to the device referenced by that name.  If that
-	 * device handle is the same handle as the dock station
-	 * handle, then we are a device dependent on the dock station
-	 */
-	acpi_get_name(dck_handle, ACPI_FULL_PATHNAME, &buffer);
-	status = acpi_evaluate_object(handle, "_EJD", NULL, &ejd_buffer);
-	if (ACPI_FAILURE(status)) {
-		err("Unable to execute _EJD!\n");
-		goto find_ejd_out;
-	}
-	ejd_obj = ejd_buffer.pointer;
-	status = acpi_get_handle(NULL, ejd_obj->string.pointer, &tmp);
-	if (ACPI_FAILURE(status))
-		goto find_ejd_out;
-
-	if (tmp == dck_handle) {
-		struct dependent_device *dd;
-		dbg("%s: found device dependent on dock\n", __FUNCTION__);
-		dd = alloc_dependent_device(handle);
-		if (!dd) {
-			err("Can't allocate memory for dependent device!\n");
-			goto find_ejd_out;
-		}
-		add_dependent_device(dd);
-	}
-
-find_ejd_out:
-	acpi_os_free(ejd_buffer.pointer);
-	return AE_OK;
-}
-
-
-
-int detect_dependent_devices(acpi_handle *bridge_handle)
-{
-	acpi_status status;
-	int count;
-
-	count = 0;
-
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle,
-					(u32)1, find_dependent_device,
-					(void *)&count, NULL);
-
-	return count;
-}
-
-
-
-
-
-static acpi_status
-find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	int *count = (int *)context;
-
-	if (is_dock(handle)) {
-		dbg("%s: found dock\n", __FUNCTION__);
-		ds = kzalloc(sizeof(*ds), GFP_KERNEL);
-		ds->handle = handle;
-		INIT_LIST_HEAD(&ds->dependent_devices);
-		INIT_LIST_HEAD(&ds->pci_dependent_devices);
-
-		/* look for devices dependent on dock station */
-		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, find_dock_ejd, handle, NULL);
-
-		acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-			handle_hotplug_event_dock, ds);
-		(*count)++;
-	}
-
-	return AE_OK;
-}
-
-
-
-
-int find_dock_station(void)
-{
-	int num = 0;
-
-	ds = NULL;
-
-	/* start from the root object, because some laptops define
-	 * _DCK methods outside the scope of PCI (IBM x-series laptop)
-	 */
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, find_dock, &num, NULL);
-
-	return num;
-}
-
-
-
-void remove_dock_station(void)
-{
-	struct dependent_device *dd, *tmp;
-	if (ds) {
-		if (ACPI_FAILURE(acpi_remove_notify_handler(ds->handle,
-			ACPI_SYSTEM_NOTIFY, handle_hotplug_event_dock)))
-			err("failed to remove dock notify handler\n");
-
-		/* free all dependent devices */
-		list_for_each_entry_safe(dd, tmp, &ds->dependent_devices,
-				device_list)
-			kfree(dd);
-
-		/* no need to touch the pci_dependent_device list,
-		 * cause all memory was freed above
-		 */
-		kfree(ds);
-	}
-}
-
-

--
