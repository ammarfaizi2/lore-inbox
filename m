Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWARAyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWARAyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWARAyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:54:35 -0500
Received: from fmr18.intel.com ([134.134.136.17]:33746 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964979AbWARAyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:54:18 -0500
Subject: [patch 2/4]  acpiphp: handle dock bridges
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
References: <20060116200218.275371000@whizzy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 16:56:59 -0800
Message-Id: <1137545819.19858.47.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 00:54:07.0560 (UTC) FILETIME=[AFA15480:01C61BC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will modify the acpiphp driver to handle docking and undocking
events and hot adding of the PCI devices on the dock station. It currently 
has a workaround for a problem with acpi where the
acpi threads will deadlock and never return from executing the _DCK method.
As a workaround, I spawn a separate thread to do the dock. In addition, 
I've found that some _DCK methods do some bad things, so have implemented
a fixups section for after docking that will no doubt grow as more laptops
get tested.  This patch CONFLICTS with some acpi plugins that try to do
their own docking support (such as ibm_acpi), so you cannot use this driver 
and the conflicting driver simultaneously. 


Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>


 drivers/pci/hotplug/acpiphp.h      |    2 
 drivers/pci/hotplug/acpiphp_glue.c |  207 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 204 insertions(+), 5 deletions(-)

--- linux-2.6.15-mm.orig/drivers/pci/hotplug/acpiphp.h
+++ linux-2.6.15-mm/drivers/pci/hotplug/acpiphp.h
@@ -189,6 +189,7 @@ struct acpiphp_attention_info
 #define SLOT_POWEREDON		(0x00000001)
 #define SLOT_ENABLED		(0x00000002)
 #define SLOT_MULTIFUNCTION	(0x00000004)
+#define SLOT_DOCKING		(0x00000008)
 
 /* function flags */
 
@@ -198,6 +199,7 @@ struct acpiphp_attention_info
 #define FUNC_HAS_PS1		(0x00000020)
 #define FUNC_HAS_PS2		(0x00000040)
 #define FUNC_HAS_PS3		(0x00000080)
+#define FUNC_HAS_DCK		(0x00000100)
 
 /* function prototypes */
 
--- linux-2.6.15-mm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-2.6.15-mm/drivers/pci/hotplug/acpiphp_glue.c
@@ -55,12 +55,14 @@
 static LIST_HEAD(bridge_list);
 
 #define MY_NAME "acpiphp_glue"
-
+static struct work_struct dock_task;
+static int enable_device(struct acpiphp_slot *slot);
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void handle_hotplug_event_func (acpi_handle, u32, void *);
 static void acpiphp_sanitize_bus(struct pci_bus *bus);
 static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
-
+static void dock(void *data);
+static unsigned int get_slot_status(struct acpiphp_slot *slot);
 
 /*
  * initialization & terminatation routines
@@ -118,6 +120,30 @@ is_ejectable_slot(acpi_handle handle, u3
 }
 

+static acpi_status handle_dock(struct acpiphp_func *func, int dock)
+{
+	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	dbg("%s: enter\n", __FUNCTION__);
+
+	/* _DCK method has one argument */
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = dock;
+	status = acpi_evaluate_object(func->handle, "_DCK",
+					&arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		err("%s: failed to dock!!\n", MY_NAME);
+
+	return status;
+}
+
+
+
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
 register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
@@ -210,6 +236,12 @@ register_slot(acpi_handle handle, u32 lv
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
+	/* install dock notify handler */
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_DCK", &tmp))) {
+		newfunc->flags |= FUNC_HAS_DCK;
+		INIT_WORK(&dock_task, dock, slot);
+	}
+
 	/* install notify handler */
 	status = acpi_install_notify_handler(handle,
 					     ACPI_SYSTEM_NOTIFY,
@@ -681,6 +713,88 @@ static int acpiphp_configure_ioapics(acp
 	return 0;
 }
 
+/*
+ * the _DCK method can do funny things... and sometimes not
+ * hah-hah funny.
+ */
+static void post_dock_fixups(struct acpiphp_slot *slot,
+			     struct acpiphp_func *func)
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
+static int acpiphp_bus_add(struct acpiphp_func *func)
+{
+	acpi_handle phandle;
+	struct acpi_device *device, *pdevice;
+	int ret_val;
+
+	acpi_get_parent(func->handle, &phandle);
+	if (acpi_bus_get_device(phandle, &pdevice)) {
+		dbg("no parent device, assuming NULL\n");
+		pdevice = NULL;
+	}
+	ret_val = acpi_bus_add(&device, pdevice, func->handle,
+			ACPI_BUS_TYPE_DEVICE);
+	if (ret_val)
+		dbg("cannot add bridge to acpi list\n");
+
+	/*
+	 * try to start anyway.  We could have failed to add
+	 * simply because this bus had previously been added
+	 * on another dock.  Don't bother with the return value
+	 * we just keep going.
+	 */
+	ret_val = acpi_bus_start(device);
+
+	return ret_val;
+}
+
+
+
+static void dock(void *data)
+{
+	struct list_head *l;
+	struct acpiphp_func *func;
+	struct acpiphp_slot *slot = data;
+
+	down(&slot->crit_sect);
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+		if (func->flags & FUNC_HAS_DCK) {
+			handle_dock(func, 1);
+			post_dock_fixups(slot, func);
+			slot->flags |= SLOT_POWEREDON;
+			if (get_slot_status(slot) == ACPI_STA_ALL) {
+				enable_device(slot);
+			}
+		}
+	}
+	slot->flags &= (~SLOT_DOCKING);
+	up(&slot->crit_sect);
+}
+
+
+
 static int power_on_slot(struct acpiphp_slot *slot)
 {
 	acpi_status status;
@@ -705,6 +819,19 @@ static int power_on_slot(struct acpiphp_
 			} else
 				break;
 		}
+
+		if (func->flags & FUNC_HAS_DCK) {
+			dbg("%s: executing _DCK\n", __FUNCTION__);
+			slot->flags |= SLOT_DOCKING;
+			/*
+			 * FIXME - work around for acpi.  Right
+			 * now if we call _DCK from this thread,
+			 * we block forever.
+			 */
+			schedule_work(&dock_task);
+			retval = -1;
+			goto err_exit;
+		}
 	}
 
 	/* TBD: evaluate _STA to check if the slot is enabled */
@@ -730,7 +857,11 @@ static int power_off_slot(struct acpiphp
 
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
-
+		if (func->flags & FUNC_HAS_DCK) {
+			dbg("%s: undock commencing\n", __FUNCTION__);
+			handle_dock(func, 0);
+			dbg("%s: undock complete\n", __FUNCTION__);
+		}
 		if (func->flags & FUNC_HAS_PS3) {
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
@@ -752,6 +883,63 @@ static int power_off_slot(struct acpiphp
 

 /**
+ * get_func - given pci_dev & slot, get the matching acpiphp_func
+ * @slot: slot to be scanned.
+ * @dev: pci_dev to match
+ *
+ * This function will check the list of acpiphp functions for
+ * this slot and return the one that represents the given
+ * pci_dev structure.
+ */
+static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
+					struct pci_dev *dev)
+{
+	struct list_head *l;
+	struct acpiphp_func *func;
+	struct pci_bus *bus = slot->bridge->pci_bus;
+
+	list_for_each (l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+		if (pci_get_slot(bus, PCI_DEVFN(slot->device,
+					func->function)) == dev)
+			return func;
+	}
+	return NULL;
+}
+
+
+
+/** acpiphp_max_busnr - find the max reserved busnr for this bus
+ *  @bus: the bus to scan
+ */
+static unsigned char
+acpiphp_max_busnr(struct pci_bus *bus)
+{
+	struct list_head *tmp;
+	unsigned char max, n;
+
+	/*
+	 * pci_bus_max_busnr will return the highest
+	 * reserved busnr for all these children.
+ 	 * that is equivalent to the bus->subordinate
+	 * value.  We don't want to use the parent's
+	 * bus->subordinate value because it could have
+	 * padding in it.
+	 */
+	max = bus->secondary;
+
+	list_for_each(tmp, &bus->children) {
+		n = pci_bus_max_busnr(pci_bus_b(tmp));
+		if (n > max)
+			max = n;
+	}
+	return max;
+}
+
+
+
+
+/**
  * enable_device - enable, configure a slot
  * @slot: slot to be enabled
  *
@@ -788,7 +976,7 @@ static int enable_device(struct acpiphp_
 		goto err_exit;
 	}
 
-	max = bus->secondary;
+	max = acpiphp_max_busnr(bus);
 	for (pass = 0; pass < 2; pass++) {
 		list_for_each_entry(dev, &bus->devices, bus_list) {
 			if (PCI_SLOT(dev->devfn) != slot->device)
@@ -796,8 +984,12 @@ static int enable_device(struct acpiphp_
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 				max = pci_scan_bridge(bus, dev, max, pass);
-				if (pass && dev->subordinate)
+				if (pass && dev->subordinate) {
 					pci_bus_size_bridges(dev->subordinate);
+					func = get_func(slot, dev);
+					if (func)
+						acpiphp_bus_add(func);
+				}
 			}
 		}
 	}
@@ -1231,6 +1423,11 @@ static void handle_hotplug_event_func(ac
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
+		if (func->slot->flags & SLOT_DOCKING) {
+			/* ignore if we are in the middle of docking */
+			dbg("eject request in the middle of a dock\n");
+			break;
+		}
 		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
 		if (!(acpiphp_disable_slot(func->slot)))
 			acpiphp_eject_slot(func->slot);

