Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265111AbUFVUHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUFVUHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUFVUGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:06:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:39051 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265114AbUFVTx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:53:57 -0400
Subject: [PATCH] acpiphp extension for 2.6.7
From: Vernon Mauery <vernux@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh@us.ibm.com, Pat Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Jess Botts <botts@us.ibm.com>
Content-Type: text/plain
Message-Id: <1087934028.2068.57.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 12:53:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the specification, ACPI does not have a standard way of
querying or manipulating the attention LED of hotplug slots.  Here is a
patch that allows for device specific ACPI code to be registered with
the acpiphp driver as callbacks for setting/getting the status of the
attention LED.

This patch was made against the 2.6.7 mainline kernel and adds the first
driver to take advantage of the acpiphp attention LED callbacks,
supporting about 5 of IBM's platforms that use acpiphp.  It also some
other functionality in addition to the LED getter/setter callback that
IBM's active PCI team needed from their hotplug userspace program.  It
adds reading events from the hotplug slot and forwarding them on to the
ACPI subsystem and exporting a binary table in the
/sys/bus/pci/slots/apci_table file.

--Vernon


diff -Nur linux-2.6.7/drivers/pci/hotplug/Kconfig linux-2.6.7.apci/drivers/pci/hotplug/Kconfig
--- linux-2.6.7/drivers/pci/hotplug/Kconfig	2004-06-15 22:19:17.000000000 -0700
+++ linux-2.6.7.apci/drivers/pci/hotplug/Kconfig	2004-06-22 11:49:38.082484048 -0700
@@ -88,6 +88,18 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_ACPI_IBM
+	tristate "ACPI PCI Hotplug driver IBM extensions"
+	depends on HOTPLUG_PCI_ACPI
+	help
+	  Say Y here if you have an IBM system that supports PCI Hotplug using
+	  ACPI.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called acpiphp_ibm.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_CPCI
 	bool "CompactPCI Hotplug driver"
 	depends on HOTPLUG_PCI
diff -Nur linux-2.6.7/drivers/pci/hotplug/Makefile linux-2.6.7.apci/drivers/pci/hotplug/Makefile
--- linux-2.6.7/drivers/pci/hotplug/Makefile	2004-06-15 22:19:43.000000000 -0700
+++ linux-2.6.7.apci/drivers/pci/hotplug/Makefile	2004-06-22 11:49:38.083483896 -0700
@@ -7,6 +7,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
+obj-$(CONFIG_HOTPLUG_PCI_ACPI_IBM)	+= acpiphp_ibm.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
 obj-$(CONFIG_HOTPLUG_PCI_PCIE)		+= pciehp.o
diff -Nur linux-2.6.7/drivers/pci/hotplug/acpiphp.h linux-2.6.7.apci/drivers/pci/hotplug/acpiphp.h
--- linux-2.6.7/drivers/pci/hotplug/acpiphp.h	2004-06-15 22:20:26.000000000 -0700
+++ linux-2.6.7.apci/drivers/pci/hotplug/acpiphp.h	2004-06-22 11:49:38.084483744 -0700
@@ -172,6 +172,22 @@
 };
 
 
+/**
+ * struct acpiphp_attention_info - device specific attention registration
+ *
+ * ACPI has no generic method of setting/getting attention status
+ * this allows for device specific driver registration
+ */
+typedef int (*acpiphp_set_attn_callback)(struct hotplug_slot *slot, u8 status);
+typedef int (*acpiphp_get_attn_callback)(struct hotplug_slot *slot, u8 *status);
+struct acpiphp_attention_info
+{
+	acpiphp_set_attn_callback set_attn;
+	acpiphp_get_attn_callback get_attn;
+	struct module *owner;
+};
+
+
 /* PCI bus bridge HID */
 #define ACPI_PCI_HOST_HID		"PNP0A03"
 
@@ -212,6 +228,12 @@
 
 /* function prototypes */
 
+/* acpiphp_core.c */
+extern int acpiphp_register_attention_info(
+		struct acpiphp_attention_info*info);
+extern int acpiphp_unregister_attention_info(
+		struct acpiphp_attention_info *info);
+
 /* acpiphp_glue.c */
 extern int acpiphp_glue_init (void);
 extern void acpiphp_glue_exit (void);
diff -Nur linux-2.6.7/drivers/pci/hotplug/acpiphp_core.c linux-2.6.7.apci/drivers/pci/hotplug/acpiphp_core.c
--- linux-2.6.7/drivers/pci/hotplug/acpiphp_core.c	2004-06-15 22:19:37.000000000 -0700
+++ linux-2.6.7.apci/drivers/pci/hotplug/acpiphp_core.c	2004-06-22 11:49:38.084483744 -0700
@@ -51,6 +51,8 @@
 
 /* local variables */
 static int num_slots;
+static spinlock_t attn_info_lock = SPIN_LOCK_UNLOCKED;
+static struct acpiphp_attention_info attention_info;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>"
@@ -62,10 +64,15 @@
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 module_param(debug, bool, 644);
 
+/* export the attention callback registration methods */
+EXPORT_SYMBOL_GPL(acpiphp_register_attention_info);
+EXPORT_SYMBOL_GPL(acpiphp_unregister_attention_info);
+
 static int enable_slot		(struct hotplug_slot *slot);
 static int disable_slot		(struct hotplug_slot *slot);
 static int set_attention_status (struct hotplug_slot *slot, u8 value);
 static int get_power_status	(struct hotplug_slot *slot, u8 *value);
+static int get_attention_status (struct hotplug_slot *slot, u8 *value);
 static int get_address		(struct hotplug_slot *slot, u32 *value);
 static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
@@ -76,11 +83,68 @@
 	.disable_slot		= disable_slot,
 	.set_attention_status	= set_attention_status,
 	.get_power_status	= get_power_status,
+	.get_attention_status	= get_attention_status,
 	.get_latch_status	= get_latch_status,
 	.get_adapter_status	= get_adapter_status,
 	.get_address		= get_address,
 };
 
+
+/**
+    * acpiphp_register_attention_info - set attention LED callback
+    *
+    * this is used to register a hardware specific acpi driver
+    * that manipulates the attention LED.  All the fields in
+    * info must be set.
+    *
+    */
+int acpiphp_register_attention_info(struct acpiphp_attention_info *info)
+{
+	int retval = 0;
+	unsigned long flags;
+
+	if (!info || !info->owner || !info->set_attn || !info->get_attn)
+		retval = -1;
+	else {
+		spin_lock_irqsave(&attn_info_lock, flags);
+		if (!attention_info.owner)
+			memcpy(&attention_info, info,
+					sizeof(struct acpiphp_attention_info));
+		spin_unlock_irqrestore(&attn_info_lock, flags);
+	}
+	return retval;
+}
+
+
+/**
+ * acpiphp_unregister_attention_info - unset attention LED callback
+ *
+ * this is used to un-register a hardware specific acpi driver
+ * that manipulates the attention LED.  Both fields must
+ * match the current attention info to reset it.
+ *
+ */
+int acpiphp_unregister_attention_info(struct acpiphp_attention_info *info)
+{
+	int retval = 0;
+	unsigned long flags;
+
+	if (!info || !info->owner || !info->set_attn || !info->get_attn)
+		retval = -1;
+	else {
+		spin_lock_irqsave(&attn_info_lock, flags);
+		if (memcmp(&attention_info, info, 
+				sizeof(struct acpiphp_attention_info)) == 0)
+			memset(&attention_info, 0,
+					sizeof(struct acpiphp_attention_info));
+		else
+			retval = -1;
+		spin_unlock_irqrestore(&attn_info_lock, flags);
+	}
+	return retval;
+}
+
+
 /**
  * enable_slot - power on and enable a slot
  * @hotplug_slot: slot to enable
@@ -120,29 +184,33 @@
 /**
  * set_attention_status - set attention LED
  *
- * TBD:
  * ACPI doesn't have known method to manipulate
- * attention status LED.
+ * attention status LED, so we use a callback that
+ * was registered with us.  This allows hardware specific
+ * ACPI implementations to blink the light for us.
  *
  */
-static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
+static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
 {
+	int retval = -1;
+	unsigned long flags;
+	struct acpiphp_attention_info info;
+
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
-	switch (status) {
-		case 0:
-			/* FIXME turn light off */
-			hotplug_slot->info->attention_status = 0;
-			break;
-
-		case 1:
-		default:
-			/* FIXME turn light on */
-			hotplug_slot->info->attention_status = 1;
-			break;
+	spin_lock_irqsave(&attn_info_lock, flags);
+	memcpy(&info, &attention_info, sizeof(struct acpiphp_attention_info));
+	spin_unlock_irqrestore(&attn_info_lock, flags);
+
+	if (info.set_attn && try_module_get(info.owner)) {
+		retval = info.set_attn(hotplug_slot, status);
+		module_put(info.owner);
 	}
 
-	return 0;
+	if (!retval)
+		hotplug_slot->info->attention_status = (status) ? 1 : 0;
+
+	return retval;
 }
 
 /**
@@ -166,6 +234,39 @@
 }
 
 /**
+ * get_attention_status - get attention LED status
+ *
+ * ACPI doesn't have known method to determine the state
+ * of the attention status LED, so we use a callback that
+ * was registered with us.  This allows hardware specific
+ * ACPI implementations to determine its state
+ *
+ */
+static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	int retval = 0;
+	struct acpiphp_attention_info info;
+	unsigned long flags;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	spin_lock_irqsave(&attn_info_lock, flags);
+	memcpy(&info, &attention_info, sizeof(struct acpiphp_attention_info));
+	spin_unlock_irqrestore(&attn_info_lock, flags);
+
+	if (info.get_attn && try_module_get(info.owner)) {
+		retval = info.get_attn(hotplug_slot, value);
+		module_put(info.owner);
+	} else {
+		dbg("%s: no get_attn callback, returning stored value\n",
+				__FUNCTION__);
+		*value = hotplug_slot->info->attention_status;
+	}
+	return retval;
+}
+
+
+/**
  * get_latch_status - get latch status of a slot
  * @hotplug_slot: slot to get status
  * @value: pointer to store status
@@ -307,7 +408,7 @@
 
 		slot->acpi_slot = get_slot_from_id(i);
 		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
-		slot->hotplug_slot->info->attention_status = acpiphp_get_attention_status(slot->acpi_slot);
+		slot->hotplug_slot->info->attention_status = 0;
 		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
 		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
 		slot->hotplug_slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
@@ -361,6 +462,7 @@
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 	acpiphp_debug = debug;
+	memset(&attention_info, 0, sizeof(struct acpiphp_attention_info));
 
 	/* read all the ACPI info from the system */
 	retval = init_acpi();
diff -Nur linux-2.6.7/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.7.apci/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.7/drivers/pci/hotplug/acpiphp_glue.c	2004-06-15 22:19:10.000000000 -0700
+++ linux-2.6.7.apci/drivers/pci/hotplug/acpiphp_glue.c	2004-06-22 11:49:38.108480096 -0700
@@ -1302,20 +1302,6 @@
 
 
 /*
- * attention LED ON: 1
- *		OFF: 0
- *
- * TBD
- * no direct attention led status information via ACPI
- *
- */
-u8 acpiphp_get_attention_status(struct acpiphp_slot *slot)
-{
-	return 0;
-}
-
-
-/*
  * latch closed:  1
  * latch   open:  0
  */
diff -Nur linux-2.6.7/drivers/pci/hotplug/acpiphp_ibm.c linux-2.6.7.apci/drivers/pci/hotplug/acpiphp_ibm.c
--- linux-2.6.7/drivers/pci/hotplug/acpiphp_ibm.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.7.apci/drivers/pci/hotplug/acpiphp_ibm.c	2004-06-22 11:49:38.108480096 -0700
@@ -0,0 +1,471 @@
+/*
+ * ACPI PCI Hot Plug IBM Extension
+ *
+ * Copyright (C) 2004 Vernon Mauery <vernux@us.ibm.com>
+ * Copyright (C) 2004 IBM Corp.
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
+ * Send feedback to <vernux@us.ibm.com>
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <acpi/acpi_bus.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <asm/uaccess.h>
+//#include <linux/moduleparam.h>
+
+#include "acpiphp.h"
+#include "pci_hotplug.h"
+
+#define DRIVER_VERSION	"1.0.1"
+#define DRIVER_AUTHOR	"Irene Zubarev <zubarev@us.ibm.com>, Vernon Mauery <vernux@us.ibm.com>"
+#define DRIVER_DESC	"ACPI Hot Plug PCI Controller Driver IBM extension"
+
+static int debug;
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, " Debugging mode enabled or not");
+#define MY_NAME "acpiphp_ibm"
+
+#ifdef dbg
+#undef dbg
+#endif
+#define dbg(format, arg...)				\
+do {							\
+	if (debug)					\
+		printk(KERN_DEBUG "%s: " format,	\
+				MY_NAME , ## arg);	\
+} while (0)
+
+#define FOUND_APCI 0x61504349
+/* these are the names for the IBM ACPI pseudo-device */
+#define IBM_HARDWARE_ID1 "IBM37D0"
+#define IBM_HARDWARE_ID2 "IBM37D4"
+
+/* union apci_descriptor - allows access to the
+ * various device descriptors that are embedded in the
+ * aPCI table
+ */
+union apci_descriptor {
+	struct {
+		char sig[4];
+		u8   len;
+	} header;
+	struct {
+		u8  type;
+		u8  len;
+		u16 slot_id;
+		u8  bus_id;
+		u8  dev_num;
+		u8  slot_num;
+		u8  slot_attr[2];
+		u8  attn;
+		u8  status[2];
+		u8  sun;
+	} slot;
+	struct {
+		u8 type;
+		u8 len;
+	} generic;
+};
+
+/* struct notification - keeps info about the device
+ * that cause the ACPI notification event
+ */
+struct notification {
+	struct acpi_device *device;
+	u8                  event;
+};
+
+/* forward declarations of functions for this module
+ */
+static int ibm_set_attention_status (struct hotplug_slot *slot, u8 status);
+static int ibm_get_attention_status (struct hotplug_slot *slot, u8 *status);
+static void ibm_handle_events(acpi_handle handle, u32 event, void *context);
+static int ibm_get_table_from_acpi(char **bufp);
+static ssize_t ibm_read_apci_table(struct kobject *kobj,
+		char *buffer, loff_t pos, size_t size);
+static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
+		u32 lvl, void *context, void **rv);
+static int __init ibm_acpiphp_init(void);
+static void __exit ibm_acpiphp_exit(void);
+
+/* static global variables
+ */
+static acpi_handle ibm_acpi_handle = NULL;
+static struct notification ibm_note;
+static struct bin_attribute ibm_apci_table_attr = {
+	    .attr = {
+		    .name = "apci_table",
+		    .owner = THIS_MODULE,
+		    .mode = S_IRUGO,
+	    },
+	    .read = ibm_read_apci_table,
+	    .write = NULL,
+};
+static struct acpiphp_attention_info ibm_attention_info = 
+{
+	.set_attn = ibm_set_attention_status,
+	.get_attn = ibm_get_attention_status,
+	.owner = THIS_MODULE,
+};
+
+
+/*
+ * ibm_set_attention_status - callback method to set the attention LED
+ *
+ * this method is registered with the acpiphp module as a callback
+ * to do the device specific task of setting the LED status
+ *
+ */
+static int ibm_set_attention_status (struct hotplug_slot *slot, u8 status)
+{
+	int retval = 0;
+	union acpi_object args[2]; 
+	struct acpi_object_list params = { .pointer = args, .count = 2 };
+	acpi_status stat; 
+	unsigned long rc = 0;
+	struct acpiphp_slot *acpi_slot;
+
+	if (!slot || !slot->private)
+		return -1;
+	acpi_slot = ((struct slot *)(slot->private))->acpi_slot;
+	if (!acpi_slot)
+		return -1;
+
+	dbg("%s: set slot %d attention status to %d\n", __FUNCTION__,
+			acpi_slot->sun, (status ? 1 : 0));
+
+	args[0].type = ACPI_TYPE_INTEGER;
+	args[0].integer.value = acpi_slot->sun;
+	args[1].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = (status) ? 1 : 0;
+
+	stat = acpi_evaluate_integer(ibm_acpi_handle, "APLS", &params, &rc);
+	if (ACPI_FAILURE(stat)) {
+		retval = -1;
+		err("APLS evaluation failed:  0x%08x\n", stat);
+	} else if (!rc) {
+		retval = -1;
+		err("APLS method failed:  0x%08lx\n", rc);
+	}
+	return retval;
+}
+
+/*
+ * ibm_get_attention_status - callback method to get attention LED status
+ *
+ * this method is registered with the acpiphp module as a callback
+ * to do the device specific task of getting the LED status
+ * 
+ * Because there is no direct method of getting the LED status directly
+ * from an ACPI call, we read the aPCI table and parse out our
+ * slot descriptor to read the status from that.
+ *
+ */
+static int ibm_get_attention_status (struct hotplug_slot *slot, u8 *status)
+{
+	int retval = -1, ind = 0, size;
+	char *table = NULL;
+	struct acpiphp_slot *acpi_slot;
+	union apci_descriptor *des;
+
+	if (!slot || !slot->private)
+		goto get_attn_done;
+	acpi_slot = ((struct slot *)(slot->private))->acpi_slot;
+	if (!acpi_slot)
+		goto get_attn_done;
+
+	size = ibm_get_table_from_acpi(&table);
+	if (size <= 0 || !table)
+		goto get_attn_done;
+	// read the header
+	des = (union apci_descriptor *)&table[ind];
+	if (memcmp(des->header.sig, "aPCI", 4) != 0)
+		goto get_attn_done;
+	des = (union apci_descriptor *)&table[ind += des->header.len];
+	while (ind < size && (des->generic.type != 0x82 ||
+			des->slot.slot_id != acpi_slot->sun))
+		des = (union apci_descriptor *)&table[ind += des->generic.len];
+	if (ind < size && des->slot.slot_id == acpi_slot->sun) {
+		retval = 0;
+		if (des->slot.attn & 0xa0 || des->slot.status[1] & 0x08)
+			*status = 1;
+		else
+			*status = 0;
+	}
+
+	dbg("%s: get slot %d attention status is %d retval=%x\n",
+			__FUNCTION__, acpi_slot->sun, *status, retval);
+
+get_attn_done:
+	if (table)
+		kfree(table);
+	return retval;
+}
+
+/*
+ * ibm_handle_events - listens for ACPI events for the IBM37D0 device
+ *
+ * this method is registered as a callback with the ACPI subsystem
+ * it is called when this device has an event to notify the OS of
+ *
+ * the events actually come from the device as two events that get
+ * synthesized into one event with data by this function.  The event
+ * ID comes first and then the slot number that caused it.  We report
+ * this as one event to the OS.
+ *
+ */
+static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
+{
+	// FIXME: this may have re-entrancy errors with event being static...
+	u8 detail = event & 0x0f;
+	u8 subevent = event & 0xf0;
+
+	struct notification *note = (struct notification *)context;
+
+	dbg("%s: Received notification %02x\n", __FUNCTION__, event);
+
+	if (subevent == 0x80) {
+		dbg("%s: generationg bus event\n", __FUNCTION__);
+		acpi_bus_generate_event(note->device, note->event, detail);
+	} else
+		note->event = event;
+}
+
+/*
+ * ibm_get_table_from_acpi - reads the APLS buffer from ACPI
+ * 
+ * this method reads the APLS buffer in from ACPI and
+ * stores the "stripped" table into a single buffer
+ * it allocates and passes the address back in bufp
+ *
+ * if NULL is passed in as buffer, this method only calculates
+ * the size of the table and returns that without filling
+ * in the buffer
+ *
+ * returns < 0 on error or the size of the table on success
+ */
+static int ibm_get_table_from_acpi(char **bufp)
+{
+	union acpi_object *package;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	char *lbuf = NULL;
+	int i, size = -1;
+
+	status = acpi_evaluate_object(ibm_acpi_handle, "APCI", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		err("%s:  APCI evaluation failed\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	package = (union acpi_object *) buffer.pointer;
+	if(!(package) ||
+			(package->type != ACPI_TYPE_PACKAGE) ||
+			!(package->package.elements)) {
+		err("%s:  Invalid APCI object\n", __FUNCTION__);
+		goto read_table_done;
+	}
+
+	for(size = 0, i = 0; i < package->package.count; i++) {
+		if (package->package.elements[i].type != ACPI_TYPE_BUFFER) {
+			err("%s:  Invalid APCI element %d\n", __FUNCTION__, i);
+			goto read_table_done;
+		}
+		size += package->package.elements[i].buffer.length;
+	}
+
+	if (bufp == NULL)
+		goto read_table_done;
+
+	lbuf = kmalloc(size, GFP_KERNEL);
+	dbg("%s: element count: %i, ASL table size: %i, &table = 0x%x\n",
+			__FUNCTION__, package->package.count, size, (int)lbuf);
+
+	if (lbuf) {
+		*bufp = lbuf;
+		memset(lbuf, 0, size);
+	} else {
+		size = -ENOMEM;
+		goto read_table_done;
+	}
+
+	size = 0;
+	for (i=0; i<package->package.count; i++) {
+		memcpy(&lbuf[size],
+				package->package.elements[i].buffer.pointer,
+				package->package.elements[i].buffer.length);
+		size += package->package.elements[i].buffer.length;
+	}
+
+read_table_done:
+	kfree(buffer.pointer);
+	return size;
+}
+
+/* ibm_read_apci_table - callback for the sysfs apci_table file
+ *
+ * gets registered with sysfs as the reader callback
+ * to be executed when /sys/bus/pci/slots/apci_table gets read
+ *
+ * since we don't get notified on open and close for this file,
+ * things get really tricky here...
+ * our solution is to only allow reading the table in all at once
+ */
+static ssize_t ibm_read_apci_table(struct kobject *kobj,
+		char *buffer, loff_t pos, size_t size)
+{
+	int bytes_read = -EINVAL;
+	char *table = NULL;
+	
+	dbg("%s: pos = %d, size = %d\n", __FUNCTION__, (int)pos, size);
+
+	if (pos == 0) {
+		bytes_read = ibm_get_table_from_acpi(&table);
+		if (bytes_read > 0 && bytes_read <= size)
+			memcpy(buffer, table, bytes_read);
+		if (table)
+			kfree(table);
+	}
+	return bytes_read;
+}
+
+/* ibm_find_acpi_device - callback to find our ACPI device
+ *
+ * used as a callback when calling acpi_walk_namespace
+ * to find our device.  When this method returns non-zero
+ * acpi_walk_namespace quits its search and returns our value
+ */
+static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
+		u32 lvl, void *context, void **rv)
+{
+	acpi_handle *phandle = (acpi_handle *)context;
+	acpi_status status; 
+	struct acpi_device_info info; 
+	struct acpi_buffer info_buffer = {
+		.length = sizeof(struct acpi_device_info),
+		.pointer = &info,
+	};
+
+	status = acpi_get_object_info(handle, &info_buffer);
+	if (ACPI_FAILURE(status)) {
+		err("%s:  Failed to get device information", __FUNCTION__);
+		return 0;
+	}
+	info.hardware_id.value[sizeof(info.hardware_id.value) - 1] = '\0';
+
+	if(info.current_status && (info.valid & ACPI_VALID_HID) &&
+			(!strcmp(info.hardware_id.value, IBM_HARDWARE_ID1) ||
+			!strcmp(info.hardware_id.value, IBM_HARDWARE_ID2))) {
+		dbg("found hardware: %s, handle: %x\n", info.hardware_id.value,
+				(unsigned int)handle);
+		*phandle = handle;
+		/* returning non-zero causes the search to stop
+		 * and returns this value to the caller of 
+		 * acpi_walk_namespace, but it also causes some warnings
+		 * in the acpi debug code to print...
+		 */
+		return FOUND_APCI;
+	}
+	return 0;
+}
+
+static int __init ibm_acpiphp_init(void)
+{
+	int retval = 0;
+	acpi_status status;
+	struct acpi_device *device;
+	struct kobject *slotdir = &pci_hotplug_slots_subsys.kset.kobj;
+
+	dbg("%s\n", __FUNCTION__);
+
+	if (acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, ibm_find_acpi_device,
+			&ibm_acpi_handle, NULL) != FOUND_APCI) {
+		err("%s: acpi_walk_namespace failed\n", __FUNCTION__);
+		return -ENODEV;
+	}
+	dbg("%s: found IBM aPCI device\n", __FUNCTION__);
+	if (acpi_bus_get_device(ibm_acpi_handle, &device)) {
+		err("%s: acpi_bus_get_device failed\n", __FUNCTION__);
+		return -ENODEV;
+	}
+	if (acpiphp_register_attention_info(&ibm_attention_info))
+		return -ENODEV;
+
+	ibm_note.device = device;
+	status = acpi_install_notify_handler(
+			ibm_acpi_handle,
+			ACPI_DEVICE_NOTIFY,
+			ibm_handle_events,
+			(void *)&ibm_note);
+	if (ACPI_FAILURE(status))
+	{
+		err("%s:  Failed to register notification handler\n",
+				__FUNCTION__);
+		retval = -EBUSY;
+		goto init_cleanup;
+	}
+
+	ibm_apci_table_attr.size = ibm_get_table_from_acpi(NULL);
+	retval = sysfs_create_bin_file(slotdir, &ibm_apci_table_attr);
+
+	return retval;
+
+init_cleanup:
+	acpiphp_unregister_attention_info(&ibm_attention_info);
+	return retval;
+}
+
+static void __exit ibm_acpiphp_exit(void)
+{
+	acpi_status status;
+	struct kobject *slotdir = &pci_hotplug_slots_subsys.kset.kobj;
+
+	dbg("%s\n", __FUNCTION__);
+
+	if (acpiphp_unregister_attention_info(&ibm_attention_info))
+		err("%s: attention info deregistration failed", __FUNCTION__);
+
+	   status = acpi_remove_notify_handler(
+			   ibm_acpi_handle,
+			   ACPI_DEVICE_NOTIFY,
+			   ibm_handle_events);
+	   if (ACPI_FAILURE(status))
+		   err("%s:  Notification handler removal failed\n",
+				   __FUNCTION__);
+	// remove the /sys entries
+	if (sysfs_remove_bin_file(slotdir, &ibm_apci_table_attr))
+		err("%s: removal of sysfs file apci_table failed\n",
+				__FUNCTION__);
+}
+
+module_init(ibm_acpiphp_init);
+module_exit(ibm_acpiphp_exit);
+
+


