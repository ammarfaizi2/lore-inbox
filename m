Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWAUBwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWAUBwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWAUBwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:52:41 -0500
Received: from fmr17.intel.com ([134.134.136.16]:24267 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932374AbWAUBwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:52:40 -0500
Subject: [PATCH] acpiphp: treat dck separate from dock bridge
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
In-Reply-To: <1137545819.19858.47.camel@whizzy>
References: <20060116200218.275371000@whizzy>
	 <1137545819.19858.47.camel@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 17:55:06 -0800
Message-Id: <1137808506.16192.69.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 21 Jan 2006 01:52:02.0898 (UTC) FILETIME=[46551320:01C61E2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an addition to the acpiphp dock station patch for interested
people to try.  It has a problem that I've not solved yet that will
cause the driver to oops if you boot your laptop docked, then load the
driver, then try to undock.  But, it works for me if you boot undocked,
then load the driver, then dock/undock etc.  This patch is different
from the original in that I no longer assume that _DCK is defined under
the actual p2p dock bridge.  However, the solution I came up with is not
actually very good.  I have to somehow find out which device is the
actual p2p bridge, and what I try to do here is:
1) find the device that _DCK is defined under
2) if this is a bridged device, we are done (i.e. is has _ADR and is
ejectable)
3) if not, then walk the namespace looking for _EJD.  If you find one,
see if the dependency is on the dock device.  The dock bridge should be
dependent on the dock device.  

	- when you find something that is dependent on the dock device,
	  see if it has an _ADR and a _PRT entry.  If so, then it is the
	  p2p dock bridge.

So, this is likely a wrong assumption, so I will be thinking some more
about how to tell which acpi device is the dock bridge.  But meanwhile,
this patch could be tested/reviewed to see if it gets us a step further
in the right direction.

I patched against 2.6.16-rc1-mm2 because I wasn't sure if it was safe to
just drop my other patch (since actually trying to just revert the
broken out patch didn't actually work).  So this patches the file with
my original patch applied.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

 drivers/pci/hotplug/acpiphp.h      |   11 +
 drivers/pci/hotplug/acpiphp_glue.c |  354 +++++++++++++++++++++++++++----------
 2 files changed, 272 insertions(+), 93 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/acpiphp.h
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp.h
@@ -148,6 +148,17 @@ struct acpiphp_func {
 	u32		flags;		/* see below */
 };
 
+
+struct acpiphp_dock_bridge {
+	acpi_handle dock_bridge_handle;
+	acpi_handle dck_handle;
+	struct acpiphp_func *func;
+	struct acpiphp_slot *slot;
+	u32 last_dock_time;
+	u32 flags;
+};
+
+
 /**
  * struct acpiphp_attention_info - device specific attention registration
  *
--- linux-2.6.16-rc1.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2.6.16-rc1/drivers/pci/hotplug/acpiphp_glue.c
@@ -53,15 +53,14 @@
 #include "acpiphp.h"
 
 static LIST_HEAD(bridge_list);
+static struct acpiphp_dock_bridge dock_bridge;
 
 #define MY_NAME "acpiphp_glue"
-static struct work_struct dock_task;
 static int enable_device(struct acpiphp_slot *slot);
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void handle_hotplug_event_func (acpi_handle, u32, void *);
 static void acpiphp_sanitize_bus(struct pci_bus *bus);
 static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
-static void dock(void *data);
 static unsigned int get_slot_status(struct acpiphp_slot *slot);
 
 /*
@@ -104,13 +103,26 @@ static int is_ejectable(acpi_handle hand
 }
 
 
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
 /* callback routine to check the existence of ejectable slots */
 static acpi_status
 is_ejectable_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	int *count = (int *)context;
 
-	if (is_ejectable(handle)) {
+	if (is_ejectable(handle) || (handle == dock_bridge.dock_bridge_handle)) {
 		(*count)++;
 		/* only one ejectable slot is enough */
 		return AE_CTRL_TERMINATE;
@@ -120,7 +132,9 @@ is_ejectable_slot(acpi_handle handle, u3
 }
 
 
-static acpi_status handle_dock(struct acpiphp_func *func, int dock)
+
+
+static acpi_status handle_dock(int dock)
 {
 	acpi_status status;
 	struct acpi_object_list arg_list;
@@ -134,10 +148,13 @@ static acpi_status handle_dock(struct ac
 	arg_list.pointer = &arg;
 	arg.type = ACPI_TYPE_INTEGER;
 	arg.integer.value = dock;
-	status = acpi_evaluate_object(func->handle, "_DCK",
+	status = acpi_evaluate_object(dock_bridge.dck_handle, "_DCK",
 					&arg_list, &buffer);
 	if (ACPI_FAILURE(status))
 		err("%s: failed to dock!!\n", MY_NAME);
+	acpi_os_free(buffer.pointer);
+
+	dbg("%s: exit\n", __FUNCTION__);
 
 	return status;
 }
@@ -157,6 +174,7 @@ register_slot(acpi_handle handle, u32 lv
 	int device, function;
 	static int num_slots = 0;	/* XXX if we support I/O node hotplug... */
 
+
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 
 	if (ACPI_FAILURE(status))
@@ -164,9 +182,10 @@ register_slot(acpi_handle handle, u32 lv
 
 	status = acpi_get_handle(handle, "_EJ0", &tmp);
 
-	if (ACPI_FAILURE(status))
+	if ((handle != dock_bridge.dock_bridge_handle) && ACPI_FAILURE(status))
 		return AE_OK;
 
+
 	device = (adr >> 16) & 0xffff;
 	function = adr & 0xffff;
 
@@ -178,7 +197,8 @@ register_slot(acpi_handle handle, u32 lv
 	INIT_LIST_HEAD(&newfunc->sibling);
 	newfunc->handle = handle;
 	newfunc->function = function;
-	newfunc->flags = FUNC_HAS_EJ0;
+	if (ACPI_SUCCESS(status))
+		newfunc->flags = FUNC_HAS_EJ0;
 
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_STA", &tmp)))
 		newfunc->flags |= FUNC_HAS_STA;
@@ -189,6 +209,9 @@ register_slot(acpi_handle handle, u32 lv
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_PS3", &tmp)))
 		newfunc->flags |= FUNC_HAS_PS3;
 
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_DCK", &tmp)))
+		newfunc->flags |= FUNC_HAS_DCK;
+
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
 	if (ACPI_FAILURE(status))
 		sun = -1;
@@ -236,24 +259,22 @@ register_slot(acpi_handle handle, u32 lv
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
-	/* install dock notify handler */
-	if (ACPI_SUCCESS(acpi_get_handle(handle, "_DCK", &tmp))) {
-		newfunc->flags |= FUNC_HAS_DCK;
-		INIT_WORK(&dock_task, dock, slot);
-	}
 
 	/* install notify handler */
-	status = acpi_install_notify_handler(handle,
+	if (!(newfunc->flags & FUNC_HAS_DCK)) {
+		status = acpi_install_notify_handler(handle,
 					     ACPI_SYSTEM_NOTIFY,
 					     handle_hotplug_event_func,
 					     newfunc);
-
-	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler\n");
-		return status;
+		if (ACPI_FAILURE(status))
+			err("failed to register interrupt notify handler\n");
+	} else if (handle == dock_bridge.dock_bridge_handle) {
+		dock_bridge.func = newfunc;
+		dock_bridge.slot = slot;
+		status = AE_OK;
 	}
 
-	return AE_OK;
+	return status;
 }
 
 
@@ -544,11 +565,13 @@ static void cleanup_bridge(struct acpiph
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
@@ -713,33 +736,6 @@ static int acpiphp_configure_ioapics(acp
 	return 0;
 }
 
-/*
- * the _DCK method can do funny things... and sometimes not
- * hah-hah funny.
- */
-static void post_dock_fixups(struct acpiphp_slot *slot,
-			     struct acpiphp_func *func)
-{
-	struct pci_bus *bus = slot->bridge->pci_bus;
-	u32 buses;
-
-	/* fixup bad _DCK function that rewrites
-	 * secondary bridge on slot
-	 */
-	pci_read_config_dword(bus->self,
-				PCI_PRIMARY_BUS,
-				&buses);
-
-	if (((buses >> 8) & 0xff) != bus->secondary) {
-		buses = (buses & 0xff000000)
-	     		| ((unsigned int)(bus->primary)     <<  0)
-	     		| ((unsigned int)(bus->secondary)   <<  8)
-	     		| ((unsigned int)(bus->subordinate) << 16);
-		pci_write_config_dword(bus->self,
-					PCI_PRIMARY_BUS,
-					buses);
-	}
-}
 
 
 static int acpiphp_bus_add(struct acpiphp_func *func)
@@ -771,26 +767,32 @@ static int acpiphp_bus_add(struct acpiph
 
 
 
-static void dock(void *data)
+
+/*
+ * the _DCK method can do funny things... and sometimes not
+ * hah-hah funny.
+ */
+static void post_dock_fixups(void)
 {
-	struct list_head *l;
-	struct acpiphp_func *func;
-	struct acpiphp_slot *slot = data;
+	struct pci_bus *bus = dock_bridge.slot->bridge->pci_bus;
+	u32 buses;
 
-	mutex_lock(&slot->crit_sect);
-	list_for_each(l, &slot->funcs) {
-		func = list_entry(l, struct acpiphp_func, sibling);
-		if (func->flags & FUNC_HAS_DCK) {
-			handle_dock(func, 1);
-			post_dock_fixups(slot, func);
-			slot->flags |= SLOT_POWEREDON;
-			if (get_slot_status(slot) == ACPI_STA_ALL) {
-				enable_device(slot);
-			}
-		}
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
 	}
-	slot->flags &= (~SLOT_DOCKING);
-	mutex_unlock(&slot->crit_sect);
 }
 
 
@@ -819,19 +821,6 @@ static int power_on_slot(struct acpiphp_
 			} else
 				break;
 		}
-
-		if (func->flags & FUNC_HAS_DCK) {
-			dbg("%s: executing _DCK\n", __FUNCTION__);
-			slot->flags |= SLOT_DOCKING;
-			/*
-			 * FIXME - work around for acpi.  Right
-			 * now if we call _DCK from this thread,
-			 * we block forever.
-			 */
-			schedule_work(&dock_task);
-			retval = -1;
-			goto err_exit;
-		}
 	}
 
 	/* TBD: evaluate _STA to check if the slot is enabled */
@@ -857,11 +846,6 @@ static int power_off_slot(struct acpiphp
 
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
-		if (func->flags & FUNC_HAS_DCK) {
-			dbg("%s: undock commencing\n", __FUNCTION__);
-			handle_dock(func, 0);
-			dbg("%s: undock complete\n", __FUNCTION__);
-		}
 		if (func->flags & FUNC_HAS_PS3) {
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
@@ -871,6 +855,7 @@ static int power_off_slot(struct acpiphp
 			} else
 				break;
 		}
+
 	}
 
 	/* TBD: evaluate _STA to check if the slot is disabled */
@@ -882,6 +867,8 @@ static int power_off_slot(struct acpiphp
 }
 
 
+
+
 /**
  * get_func - given pci_dev & slot, get the matching acpiphp_func
  * @slot: slot to be scanned.
@@ -889,22 +876,27 @@ static int power_off_slot(struct acpiphp
  *
  * This function will check the list of acpiphp functions for
  * this slot and return the one that represents the given
- * pci_dev structure.
+ * pci_dev structure.  This function will incremente the ref
+ * pointer of the pci_dev struct as a side effect, so the caller
+ * must call pci_dev_put when they are done.
  */
 static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
 					struct pci_dev *dev)
 {
-	struct list_head *l;
-	struct acpiphp_func *func;
+	struct acpiphp_func *func = NULL;
 	struct pci_bus *bus = slot->bridge->pci_bus;
+	struct pci_dev *pdev;
 
-	list_for_each (l, &slot->funcs) {
-		func = list_entry(l, struct acpiphp_func, sibling);
-		if (pci_get_slot(bus, PCI_DEVFN(slot->device,
-					func->function)) == dev)
-			return func;
+	list_for_each_entry (func, &slot->funcs, sibling) {
+		pdev = pci_get_slot(bus, PCI_DEVFN(slot->device,
+					func->function));
+		if (pdev) {
+			if (pdev == dev)
+				break;
+			pci_dev_put(pdev);
+		}
 	}
-	return NULL;
+	return func;
 }
 
 
@@ -987,8 +979,11 @@ static int enable_device(struct acpiphp_
 				if (pass && dev->subordinate) {
 					pci_bus_size_bridges(dev->subordinate);
 					func = get_func(slot, dev);
-					if (func)
+					if (func) {
 						acpiphp_bus_add(func);
+						/* side effect of get_func() */
+						pci_dev_put(dev);
+					}
 				}
 			}
 		}
@@ -1306,6 +1301,7 @@ static void handle_bridge_insertion(acpi
  * ACPI event handlers
  */
 
+
 /**
  * handle_hotplug_event_bridge - handle ACPI event on bridges
  *
@@ -1439,6 +1435,47 @@ static void handle_hotplug_event_func(ac
 	}
 }
 
+
+
+static void
+handle_hotplug_event_dock(acpi_handle handle, u32 type, void *context)
+{
+	acpi_handle dock = dock_bridge.dock_bridge_handle;
+
+	switch (type) {
+		case ACPI_NOTIFY_BUS_CHECK:
+			dbg("%s: Bus check notify\n",
+				__FUNCTION__);
+			dock_bridge.flags |= SLOT_DOCKING;
+			handle_dock(1);
+			if (dock) {
+				post_dock_fixups();
+				handle_hotplug_event_func(dock,
+					type, dock_bridge.func);
+			}
+			dock_bridge.flags &= ~(SLOT_DOCKING);
+			dock_bridge.last_dock_time = jiffies;
+			break;
+		case ACPI_NOTIFY_EJECT_REQUEST:
+			if (dock_bridge.flags & SLOT_DOCKING ||
+				dock_bridge.last_dock_time == jiffies) {
+				dbg("%s: Ignore bogus eject request\n",
+					__FUNCTION__);
+			} else {
+				dbg("%s: Eject notify\n", __FUNCTION__);
+				handle_dock(0);
+				handle_hotplug_event_func(dock,
+					type, dock_bridge.func);
+			}
+			break;
+		default:
+			warn("%s: unknown event type 0x%x\n",
+				__FUNCTION__, type);
+	}
+}
+
+
+
 static int is_root_bridge(acpi_handle handle)
 {
 	acpi_status status;
@@ -1468,6 +1505,118 @@ static int is_root_bridge(acpi_handle ha
 	return 0;
 }
 
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
+	struct acpi_buffer ejd_buffer = { .length = sizeof(ejd_objname),
+					  .pointer = ejd_objname };
+	union acpi_object *ejd_obj;
+	union acpi_object *dck_obj;
+
+	status = acpi_get_handle(handle, "_EJD", &tmp);
+	if (ACPI_FAILURE(status)) {
+		return 0;
+	}
+
+	/* make sure we are dependent on the dock device */
+	acpi_get_name(dck_handle, ACPI_FULL_PATHNAME, &buffer);
+	status = acpi_evaluate_object(handle, "_EJD", NULL, &ejd_buffer);
+	if (ACPI_FAILURE(status)) {
+		err("Unable to execute _EJD!\n");
+		return 0;
+	}
+
+	ejd_obj = ejd_buffer.pointer;
+	dck_obj = buffer.pointer;
+	if (!strncmp(ejd_obj->string.pointer, dck_obj->string.pointer,
+		ejd_obj->string.length)) {
+		/* ok, this device is dependent on the dock device,
+		 * if it was the actual dock bridge, it would have
+		 * a PRT associated with it.
+		 */
+		status = acpi_get_handle(handle, "_PRT", &tmp);
+		if (ACPI_FAILURE(status))
+			return 0;
+
+		/* yippee, we found the dock bridge! */
+		*(rv) = handle;
+		return AE_CTRL_TERMINATE;
+	}
+	return AE_OK;
+}
+
+
+static acpi_handle
+get_dock_handle(acpi_handle handle)
+{
+	acpi_handle dock_bridge_handle = NULL;
+
+	/*
+	 * first see if we are the dock bridge.
+	 */
+	if (is_ejectable(handle))
+		return handle;
+
+	/*
+	 * otherwise, we are going to have to find
+	 * the dock bridge by checking the _EJD list.
+	 */
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+		ACPI_UINT32_MAX, find_dock_ejd, handle, &dock_bridge_handle);
+
+	return dock_bridge_handle;
+}
+
+
+
+static acpi_status
+find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	if (is_dock(handle)) {
+		/* found a dock.  Now we have to determine if
+		 * the _DCK method is within the scope of the
+		 * dock bridge, or outside it (as in the IBM x-series)
+		 */
+		dock_bridge.dock_bridge_handle = get_dock_handle(handle);
+		dock_bridge.dck_handle = handle;
+		acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+			handle_hotplug_event_dock, NULL);
+		(*count)++;
+	}
+
+	return AE_OK;
+}
+
+
+
+
+static int
+find_dock_bridge(void)
+{
+	int num = 0;
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
+
 static acpi_status
 find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
@@ -1494,6 +1643,8 @@ int __init acpiphp_glue_init(void)
 {
 	int num = 0;
 
+	num = find_dock_bridge();
+
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 			ACPI_UINT32_MAX, find_root_bridges, &num, NULL);
 
@@ -1513,6 +1664,17 @@ int __init acpiphp_glue_init(void)
  */
 void __exit acpiphp_glue_exit(void)
 {
+	acpi_handle handle = dock_bridge.dck_handle;
+
+	/* if we have a dock station handle, we should
+	 * remove the notify handler
+	 */
+	if (handle) {
+		if (ACPI_FAILURE(acpi_remove_notify_handler(handle,
+			ACPI_SYSTEM_NOTIFY, handle_hotplug_event_dock)))
+			err("failed to remove dock notify handler\n");
+	}
+
 	acpi_pci_unregister_driver(&acpi_pci_hp_driver);
 }
 
@@ -1537,6 +1699,12 @@ int __init acpiphp_get_num_slots(void)
 		num_slots += bridge->nr_slots;
 	}
 
+	/* it's possible to have a dock station that doesn't actually
+	 * use a pci dock bridge.  For now, continue to allow this
+	 * to be handled by this driver.
+	 */
+	if (dock_bridge.dck_handle && !dock_bridge.dock_bridge_handle)
+		num_slots++;
 	dbg("Total %d slots\n", num_slots);
 	return num_slots;
 }

