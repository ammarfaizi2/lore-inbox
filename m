Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSKFBkY>; Tue, 5 Nov 2002 20:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSKFBkY>; Tue, 5 Nov 2002 20:40:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17424 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265469AbSKFBgj>;
	Tue, 5 Nov 2002 20:36:39 -0500
Date: Tue, 5 Nov 2002 17:39:16 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106013915.GU18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com> <20021106013835.GT18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106013835.GT18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.4, 2002/11/02 23:00:20-08:00, scottm@somanetworks.com

[PATCH] 2.5.45 CompactPCI driver patch 2/4

This is patch 2 of 4 of my CompactPCI hotplug core and
drivers, consisting of the CompactPCI hotplug driver core.

It is basically a glue layer on top of the PCI hotplug core that exposes
an API roughly similiar in concept to the API implemented by MontaVista
from the PICMG 2.12 specification, minus all the Win32isms and cruft.


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Tue Nov  5 17:26:15 2002
+++ b/CREDITS	Tue Nov  5 17:26:15 2002
@@ -2218,6 +2218,14 @@
 S: Lafayette, Indiana 47905
 S: USA
 
+N: Scott Murray
+E: scottm@somanetworks.com
+E: scott@spiteful.org
+D: OPL3-SA2, OPL3-SA3 sound driver
+D: CompactPCI hotplug core
+S: Toronto, Ontario
+S: Canada
+
 N: Trond Myklebust
 E: trond.myklebust@fys.uio.no
 D: current NFS client hacker.
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Nov  5 17:26:15 2002
+++ b/MAINTAINERS	Tue Nov  5 17:26:15 2002
@@ -317,6 +317,13 @@
 W:	http://www.coda.cs.cmu.edu/
 S:	Maintained
 
+COMPACTPCI HOTPLUG CORE
+P:	Scott Murray
+M:	scottm@somanetworks.com
+M:	scott@spiteful.org
+L:	pcihpd-discuss@lists.sourceforge.net
+S:	Supported
+
 COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
 P:	Amy Vanzant-Hodge 
 M:	Amy Vanzant-Hodge (fibrechannel@compaq.com)
diff -Nru a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	Tue Nov  5 17:26:15 2002
+++ b/drivers/hotplug/Kconfig	Tue Nov  5 17:26:15 2002
@@ -73,5 +73,19 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_CPCI
+	tristate "CompactPCI Hotplug driver"
+	depends on HOTPLUG_PCI
+	help
+	  Say Y here if you have a CompactPCI system card with CompactPCI
+	  hotswap support per the PICMG 2.1 specification.
+
+	  This code is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called cpci_hotplug.o. If you want to compile it
+	  as a module, say M here and read <file:Documentation/modules.txt>.
+
+	  When in doubt, say N.
+
 endmenu
 
diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Tue Nov  5 17:26:15 2002
+++ b/drivers/hotplug/Makefile	Tue Nov  5 17:26:15 2002
@@ -2,12 +2,13 @@
 # Makefile for the Linux kernel pci hotplug controller drivers.
 #
 
-export-objs	:= pci_hotplug_core.o pci_hotplug_util.o
+export-objs	:= pci_hotplug_core.o pci_hotplug_util.o cpci_hotplug_core.o
 
 obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
+obj-$(CONFIG_HOTPLUG_PCI_CPCI)		+= cpci_hotplug.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o	\
 				pci_hotplug_util.o
@@ -27,6 +28,9 @@
 				acpiphp_glue.o	\
 				acpiphp_pci.o	\
 				acpiphp_res.o
+
+cpci_hotplug-objs	:=	cpci_hotplug_core.o	\
+				cpci_hotplug_pci.o
 
 ifdef CONFIG_HOTPLUG_PCI_ACPI
   EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi
diff -Nru a/drivers/hotplug/cpci_hotplug.h b/drivers/hotplug/cpci_hotplug.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpci_hotplug.h	Tue Nov  5 17:26:15 2002
@@ -0,0 +1,100 @@
+/*
+ * CompactPCI Hot Plug Core Functions
+ *
+ * Copyright (c) 2002 SOMA Networks, Inc.
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM Corp.
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
+ * Send feedback to <scottm@somanetworks.com>
+ */
+
+#ifndef _CPCI_HOTPLUG_H
+#define _CPCI_HOTPLUG_H
+
+#include <linux/types.h>
+#include <linux/pci.h>
+
+/* PICMG 2.12 R2.0 HS CSR bits: */
+#define HS_CSR_INS	0x0080
+#define HS_CSR_EXT	0x0040
+#define HS_CSR_PI	0x0030
+#define HS_CSR_LOO	0x0008
+#define HS_CSR_PIE	0x0004
+#define HS_CSR_EIM	0x0002
+#define HS_CSR_DHA	0x0001
+
+#define SLOT_MAGIC	0x67267322
+struct slot {
+	u32 magic;
+	u8 number;
+	unsigned int devfn;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+	unsigned int extracting;
+	struct hotplug_slot *hotplug_slot;
+	struct list_head slot_list;
+};
+
+struct cpci_hp_controller_ops {
+	int (*query_enum) (void);
+	int (*enable_irq) (void);
+	int (*disable_irq) (void);
+	int (*check_irq) (void *dev_id);
+	int (*hardware_test) (struct slot* slot, u32 value);
+	u8  (*get_power) (struct slot* slot);
+	int (*set_power) (struct slot* slot, int value);
+};
+
+struct cpci_hp_controller {
+	unsigned int irq;
+	unsigned long irq_flags;
+	char *devname;
+	void *dev_id;
+	char *name;
+	struct cpci_hp_controller_ops *ops;
+};
+
+extern int cpci_hp_register_controller(struct cpci_hp_controller *controller);
+extern int cpci_hp_unregister_controller(struct cpci_hp_controller *controller);
+extern int cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last);
+extern int cpci_hp_unregister_bus(struct pci_bus *bus);
+extern struct slot *cpci_find_slot(struct pci_bus *bus, unsigned int devfn);
+extern int cpci_hp_start(void);
+extern int cpci_hp_stop(void);
+
+/*
+ * Internal function prototypes, these functions should not be used by
+ * board/chassis drivers.
+ */
+extern u8 cpci_get_attention_status(struct slot *slot);
+extern u8 cpci_get_latch_status(struct slot *slot);
+extern u8 cpci_get_adapter_status(struct slot *slot);
+extern u16 cpci_get_hs_csr(struct slot * slot);
+extern u16 cpci_set_hs_csr(struct slot * slot, u16 hs_csr);
+extern int cpci_set_attention_status(struct slot *slot, int status);
+extern int cpci_check_and_clear_ins(struct slot * slot);
+extern int cpci_check_ext(struct slot * slot);
+extern int cpci_clear_ext(struct slot * slot);
+extern int cpci_led_on(struct slot * slot);
+extern int cpci_led_off(struct slot * slot);
+extern int cpci_configure_slot(struct slot *slot);
+extern int cpci_unconfigure_slot(struct slot *slot);
+
+#endif	/* _CPCI_HOTPLUG_H */
diff -Nru a/drivers/hotplug/cpci_hotplug_core.c b/drivers/hotplug/cpci_hotplug_core.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpci_hotplug_core.c	Tue Nov  5 17:26:15 2002
@@ -0,0 +1,927 @@
+/*
+ * CompactPCI Hot Plug Driver
+ *
+ * Copyright (c) 2002 SOMA Networks, Inc.
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM Corp.
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
+ * Send feedback to <scottm@somanetworks.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/smp_lock.h>
+#include "pci_hotplug.h"
+#include "cpci_hotplug.h"
+
+#define DRIVER_VERSION	"0.2"
+#define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
+#define DRIVER_DESC	"CompactPCI Hot Plug Core"
+
+#if !defined(CONFIG_HOTPLUG_CPCI_MODULE)
+#define MY_NAME	"cpci_hotplug"
+#else
+#define MY_NAME	THIS_MODULE->name
+#endif
+
+#define dbg(format, arg...)					\
+	do {							\
+		if(cpci_debug)					\
+			printk (KERN_DEBUG "%s: " format "\n",	\
+				MY_NAME , ## arg); 		\
+	} while(0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+
+/* local variables */
+static spinlock_t list_lock;
+static LIST_HEAD(slot_list);
+static int slots;
+int cpci_debug;
+static struct cpci_hp_controller *controller;
+static struct semaphore event_semaphore;	/* mutex for process loop (up if something to process) */
+static struct semaphore thread_exit;		/* guard ensure thread has exited before calling it quits */
+static int thread_finished = 1;
+
+static int enable_slot(struct hotplug_slot *slot);
+static int disable_slot(struct hotplug_slot *slot);
+static int set_attention_status(struct hotplug_slot *slot, u8 value);
+static int get_power_status(struct hotplug_slot *slot, u8 * value);
+static int get_attention_status(struct hotplug_slot *slot, u8 * value);
+static int get_latch_status(struct hotplug_slot *slot, u8 * value);
+static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
+
+static struct hotplug_slot_ops cpci_hotplug_slot_ops = {
+	.owner = THIS_MODULE,
+	.enable_slot = enable_slot,
+	.disable_slot = disable_slot,
+	.set_attention_status = set_attention_status,
+	.hardware_test = NULL,
+	.get_power_status = get_power_status,
+	.get_attention_status = get_attention_status,
+	.get_latch_status = get_latch_status,
+	.get_adapter_status = get_adapter_status,
+};
+
+/* Inline functions to check the sanity of a pointer that is passed to us */
+static inline int
+slot_paranoia_check(struct slot *slot, const char *function)
+{
+	if(!slot) {
+		dbg("%s - slot == NULL", function);
+		return -1;
+	}
+	if(slot->magic != SLOT_MAGIC) {
+		dbg("%s - bad magic number for slot", function);
+		return -1;
+	}
+	if(!slot->hotplug_slot) {
+		dbg("%s - slot->hotplug_slot == NULL!", function);
+		return -1;
+	}
+	return 0;
+}
+
+static inline struct slot *
+get_slot(struct hotplug_slot *hotplug_slot, const char *function)
+{
+	struct slot *slot;
+
+	if(!hotplug_slot) {
+		dbg("%s - hotplug_slot == NULL", function);
+		return NULL;
+	}
+
+	slot = (struct slot *) hotplug_slot->private;
+	if(slot_paranoia_check(slot, function))
+		return NULL;
+	return slot;
+}
+
+static int
+update_latch_status(struct hotplug_slot *hotplug_slot, u8 value)
+{
+	struct hotplug_slot_info info;
+
+	if(!(hotplug_slot && hotplug_slot->info))
+		return -EINVAL;
+	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
+	info.latch_status = value;
+	return pci_hp_change_slot_info(hotplug_slot->name, &info);
+}
+
+static int
+update_adapter_status(struct hotplug_slot *hotplug_slot, u8 value)
+{
+	struct hotplug_slot_info info;
+
+	if(!(hotplug_slot && hotplug_slot->info))
+		return -EINVAL;
+	memcpy(&info, hotplug_slot->info, sizeof(struct hotplug_slot_info));
+	info.adapter_status = value;
+	return pci_hp_change_slot_info(hotplug_slot->name, &info);
+}
+
+static int
+enable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+	int retval = 0;
+
+	if(slot == NULL)
+		return -ENODEV;
+
+	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	if(controller->ops->set_power) {
+		retval = controller->ops->set_power(slot, 1);
+	}
+
+	return retval;
+}
+
+static int
+disable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+	int retval = 0;
+
+	if(slot == NULL)
+		return -ENODEV;
+
+	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	/* Unconfigure device */
+	dbg("%s - unconfiguring slot %s",
+	    __FUNCTION__, slot->hotplug_slot->name);
+	if((retval = cpci_unconfigure_slot(slot))) {
+		err("%s - could not unconfigure slot %s",
+		    __FUNCTION__, slot->hotplug_slot->name);
+		return retval;
+	}
+	dbg("%s - finished unconfiguring slot %s",
+	    __FUNCTION__, slot->hotplug_slot->name);
+
+	/* Clear EXT (by setting it) */
+	if(cpci_clear_ext(slot)) {
+		err("%s - could not clear EXT for slot %s",
+		    __FUNCTION__, slot->hotplug_slot->name);
+		retval = -ENODEV;
+	}
+	cpci_led_on(slot);
+
+	if(controller->ops->set_power) {
+		retval = controller->ops->set_power(slot, 0);
+	}
+
+	if(update_adapter_status(slot->hotplug_slot, 0)) {
+		warn("failure to update adapter file");
+	}
+
+	slot->extracting = 0;
+
+	return retval;
+}
+
+static u8
+cpci_get_power_status(struct slot *slot)
+{
+	u8 power = 1;
+
+	if(controller->ops->get_power) {
+		power = controller->ops->get_power(slot);
+	}
+	return power;
+}
+
+static int
+get_power_status(struct hotplug_slot *hotplug_slot, u8 * value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if(slot == NULL)
+		return -ENODEV;
+	*value = cpci_get_power_status(slot);
+	return 0;
+}
+
+static int
+get_attention_status(struct hotplug_slot *hotplug_slot, u8 * value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if(slot == NULL)
+		return -ENODEV;
+	*value = cpci_get_attention_status(slot);
+	return 0;
+}
+
+static int
+set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if(slot == NULL)
+		return -ENODEV;
+	switch (status) {
+	case 0:
+		cpci_set_attention_status(slot, 0);
+		break;
+
+	case 1:
+	default:
+		cpci_set_attention_status(slot, 1);
+		break;
+	}
+
+	return 0;
+}
+
+static int
+get_latch_status(struct hotplug_slot *hotplug_slot, u8 * value)
+{
+	if(hotplug_slot == NULL || hotplug_slot->info == NULL)
+		return -ENODEV;
+	*value = hotplug_slot->info->latch_status;
+	return 0;
+}
+
+static int
+get_adapter_status(struct hotplug_slot *hotplug_slot, u8 * value)
+{
+	if(hotplug_slot == NULL || hotplug_slot->info == NULL)
+		return -ENODEV;
+	*value = hotplug_slot->info->adapter_status;
+	return 0;
+}
+
+#define SLOT_NAME_SIZE	6
+static void
+make_slot_name(struct slot *slot)
+{
+	snprintf(slot->hotplug_slot->name,
+		 SLOT_NAME_SIZE, "%02x:%02x", slot->bus->number, slot->number);
+}
+
+int
+cpci_hp_register_bus(struct pci_bus *bus, u8 first, u8 last)
+{
+	struct slot *slot;
+	struct hotplug_slot *hotplug_slot;
+	struct hotplug_slot_info *info;
+	char *name;
+	int status = 0;
+	int i;
+
+	if(!(controller && bus)) {
+		return -ENODEV;
+	}
+	if(last < first) {
+		return -EINVAL;
+	}
+
+	/*
+	 * Create a structure for each slot, and register that slot
+	 * with the pci_hotplug subsystem.
+	 */
+	for (i = first; i <= last; ++i) {
+		slot = kmalloc(sizeof (struct slot), GFP_KERNEL);
+		if(!slot)
+			return -ENOMEM;
+		memset(slot, 0, sizeof (struct slot));
+
+		hotplug_slot =
+		    kmalloc(sizeof (struct hotplug_slot), GFP_KERNEL);
+		if(!hotplug_slot) {
+			kfree(slot);
+			return -ENOMEM;
+		}
+		memset(hotplug_slot, 0, sizeof (struct hotplug_slot));
+		slot->hotplug_slot = hotplug_slot;
+
+		info = kmalloc(sizeof (struct hotplug_slot_info), GFP_KERNEL);
+		if(!info) {
+			kfree(hotplug_slot);
+			kfree(slot);
+			return -ENOMEM;
+		}
+		memset(info, 0, sizeof (struct hotplug_slot_info));
+		hotplug_slot->info = info;
+
+		name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+		if(!name) {
+			kfree(info);
+			kfree(hotplug_slot);
+			kfree(slot);
+			return -ENOMEM;
+		}
+		hotplug_slot->name = name;
+
+		slot->magic = SLOT_MAGIC;
+		slot->bus = bus;
+		slot->number = i;
+		slot->devfn = PCI_DEVFN(i, 0);
+
+		hotplug_slot->private = slot;
+		make_slot_name(slot);
+		hotplug_slot->ops = &cpci_hotplug_slot_ops;
+
+		/*
+		 * Initialize the slot info structure with some known
+		 * good values.
+		 */
+		dbg("initializing slot %s", slot->hotplug_slot->name);
+		info->power_status = cpci_get_power_status(slot);
+		info->attention_status = cpci_get_attention_status(slot);
+
+		dbg("registering slot %s", slot->hotplug_slot->name);
+		status = pci_hp_register(slot->hotplug_slot);
+		if(status) {
+			err("pci_hp_register failed with error %d", status);
+			kfree(info);
+			kfree(name);
+			kfree(hotplug_slot);
+			kfree(slot);
+			return status;
+		}
+
+		/* Add slot to our internal list */
+		spin_lock(&list_lock);
+		list_add(&slot->slot_list, &slot_list);
+		slots++;
+		spin_unlock(&list_lock);
+	}
+	return status;
+}
+
+int
+cpci_hp_unregister_bus(struct pci_bus *bus)
+{
+	struct slot *slot;
+	struct list_head *tmp;
+	int status;
+
+	if(!bus) {
+		return -ENODEV;
+	}
+
+	spin_lock(&list_lock);
+	if(!slots) {
+		spin_unlock(&list_lock);
+		return -1;
+	}
+	list_for_each(tmp, &slot_list) {
+		slot = list_entry(tmp, struct slot, slot_list);
+		if(slot->bus == bus) {
+			dbg("deregistering slot %s", slot->hotplug_slot->name);
+			status = pci_hp_deregister(slot->hotplug_slot);
+			if(status) {
+				err("pci_hp_deregister failed with error %d",
+				    status);
+				return status;
+			}
+
+			list_del(&slot->slot_list);
+			kfree(slot->hotplug_slot->info);
+			kfree(slot->hotplug_slot->name);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
+
+			slots--;
+		}
+	}
+	spin_unlock(&list_lock);
+	return 0;
+}
+
+struct slot *
+cpci_find_slot(struct pci_bus *bus, unsigned int devfn)
+{
+	struct slot *slot;
+	struct slot *found;
+	struct list_head *tmp;
+
+	if(!bus) {
+		return NULL;
+	}
+
+	spin_lock(&list_lock);
+	if(!slots) {
+		spin_unlock(&list_lock);
+		return NULL;
+	}
+	found = NULL;
+	list_for_each(tmp, &slot_list) {
+		slot = list_entry(tmp, struct slot, slot_list);
+		if(slot->bus == bus && slot->devfn == devfn) {
+			found = slot;
+			break;
+		}
+	}
+	spin_unlock(&list_lock);
+	return found;
+}
+
+/* This is the interrupt mode interrupt handler */
+void
+cpci_hp_intr(int irq, void *data, struct pt_regs *regs)
+{
+	dbg("entered cpci_hp_intr");
+
+	/* Check to see if it was our interrupt */
+	if((controller->irq_flags & SA_SHIRQ) &&
+	    !controller->ops->check_irq(controller->dev_id)) {
+		dbg("exited cpci_hp_intr, not our interrupt");
+		return;
+	}
+
+	/* Disable ENUM interrupt */
+	controller->ops->disable_irq();
+
+	/* Trigger processing by the event thread */
+	dbg("Signal event_semaphore");
+	up(&event_semaphore);
+	dbg("exited cpci_hp_intr");
+}
+
+/*
+ * According to PICMG 2.12 R2.0, section 6.3.2, upon
+ * initialization, the system driver shall clear the
+ * INS bits of the cold-inserted devices.
+ */
+static int
+init_slots(void)
+{
+	struct slot *slot;
+	struct list_head *tmp;
+	struct pci_dev* dev;
+
+	dbg("%s - enter", __FUNCTION__);
+	spin_lock(&list_lock);
+	if(!slots) {
+		spin_unlock(&list_lock);
+		return -1;
+	}
+	list_for_each(tmp, &slot_list) {
+		slot = list_entry(tmp, struct slot, slot_list);
+		dbg("%s - looking at slot %s",
+		    __FUNCTION__, slot->hotplug_slot->name);
+		if(cpci_check_and_clear_ins(slot)) {
+			dbg("%s - cleared INS for slot %s",
+			    __FUNCTION__, slot->hotplug_slot->name);
+			dev = pci_find_slot(slot->bus->number, PCI_DEVFN(slot->number, 0));
+			if(dev) {
+				if(update_adapter_status(slot->hotplug_slot, 1)) {
+					warn("failure to update adapter file");
+				}
+				if(update_latch_status(slot->hotplug_slot, 1)) {
+					warn("failure to update latch file");
+				}
+				slot->dev = dev;
+			} else {
+				err("%s - no driver attached to device in slot %s",
+				    __FUNCTION__, slot->hotplug_slot->name);
+			}
+		}
+	}
+	spin_unlock(&list_lock);
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+static int
+check_slots(void)
+{
+	struct slot *slot;
+	struct list_head *tmp;
+	int extracted;
+	int inserted;
+
+	spin_lock(&list_lock);
+	if(!slots) {
+		spin_unlock(&list_lock);
+		err("no slots registered, shutting down");
+		return -1;
+	}
+	extracted = inserted = 0;
+	list_for_each(tmp, &slot_list) {
+		slot = list_entry(tmp, struct slot, slot_list);
+		dbg("%s - looking at slot %s",
+		    __FUNCTION__, slot->hotplug_slot->name);
+		if(cpci_check_and_clear_ins(slot)) {
+			u16 hs_csr;
+
+			/* Some broken hardware (e.g. PLX 9054AB) asserts ENUM# twice... */
+			if(slot->dev) {
+				warn("slot %s already inserted", slot->hotplug_slot->name);
+				inserted++;
+				continue;
+			}
+
+			/* Process insertion */
+			dbg("%s - slot %s inserted",
+			    __FUNCTION__, slot->hotplug_slot->name);
+
+			/* GSM, debug */
+			hs_csr = cpci_get_hs_csr(slot);
+			dbg("%s - slot %s HS_CSR (1) = %04x",
+			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
+
+			/* Configure device */
+			dbg("%s - configuring slot %s",
+			    __FUNCTION__, slot->hotplug_slot->name);
+			if(cpci_configure_slot(slot)) {
+				err("%s - could not configure slot %s",
+				    __FUNCTION__, slot->hotplug_slot->name);
+				continue;
+			}
+			dbg("%s - finished configuring slot %s",
+			    __FUNCTION__, slot->hotplug_slot->name);
+
+			/* GSM, debug */
+			hs_csr = cpci_get_hs_csr(slot);
+			dbg("%s - slot %s HS_CSR (2) = %04x",
+			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
+
+			if(update_latch_status(slot->hotplug_slot, 1)) {
+				warn("failure to update latch file");
+			}
+
+			if(update_adapter_status(slot->hotplug_slot, 1)) {
+				warn("failure to update adapter file");
+			}
+
+			cpci_led_off(slot);
+
+			/* GSM, debug */
+			hs_csr = cpci_get_hs_csr(slot);
+			dbg("%s - slot %s HS_CSR (3) = %04x",
+			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
+
+			inserted++;
+		} else if(cpci_check_ext(slot)) {
+			u16 hs_csr;
+
+			/* Process extraction request */
+			dbg("%s - slot %s extracted",
+			    __FUNCTION__, slot->hotplug_slot->name);
+
+			/* GSM, debug */
+			hs_csr = cpci_get_hs_csr(slot);
+			dbg("%s - slot %s HS_CSR = %04x",
+			    __FUNCTION__, slot->hotplug_slot->name, hs_csr);
+
+			if(!slot->extracting) {
+				if(update_latch_status(slot->hotplug_slot, 0)) {
+					warn("failure to update latch file");
+				}
+				slot->extracting = 1;
+			}
+			extracted++;
+		}
+	}
+	spin_unlock(&list_lock);
+	if(inserted || extracted) {
+		return extracted;
+	}
+	else {
+		err("cannot find ENUM# source, shutting down");
+		return -1;
+	}
+}
+
+/* This is the interrupt mode worker thread body */
+static int
+event_thread(void *data)
+{
+	int rc;
+	struct slot *slot;
+	struct list_head *tmp;
+
+	lock_kernel();
+	daemonize();
+	strcpy(current->comm, "cpci_hp_eventd");
+	unlock_kernel();
+
+	dbg("%s - event thread started", __FUNCTION__);
+	while(1) {
+		dbg("event thread sleeping");
+		down_interruptible(&event_semaphore);
+		dbg("event thread woken, thread_finished = %d",
+		    thread_finished);
+		if(thread_finished || signal_pending(current))
+			break;
+		while(controller->ops->query_enum()) {
+			rc = check_slots();
+			if(rc > 0) {
+				/* Give userspace a chance to handle extraction */
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(HZ / 2);
+			} else if(rc < 0) {
+				dbg("%s - error checking slots", __FUNCTION__);
+				thread_finished = 1;
+				break;
+			}
+		}
+		/* Check for someone yanking out a board */
+		list_for_each(tmp, &slot_list) {
+			slot = list_entry(tmp, struct slot, slot_list);
+			if(slot->extracting) {
+				/*
+				 * Hmmm, we're likely hosed at this point, should we
+				 * bother trying to tell the driver or not?
+				 */
+				err("card in slot %s was improperly removed",
+				    slot->hotplug_slot->name);
+				if(update_adapter_status(slot->hotplug_slot, 0)) {
+					warn("failure to update adapter file");
+				}
+				slot->extracting = 0;
+			}
+		}
+
+		/* Re-enable ENUM# interrupt */
+		dbg("%s - re-enabling irq", __FUNCTION__);
+		controller->ops->enable_irq();
+	}
+
+	dbg("%s - event thread signals exit", __FUNCTION__);
+	up(&thread_exit);
+	return 0;
+}
+
+/* This is the polling mode worker thread body */
+static int
+poll_thread(void *data)
+{
+	int rc;
+	struct slot *slot;
+	struct list_head *tmp;
+
+	lock_kernel();
+	daemonize();
+	strcpy(current->comm, "cpci_hp_polld");
+	unlock_kernel();
+
+	while(1) {
+		if(thread_finished || signal_pending(current))
+			break;
+
+		while(controller->ops->query_enum()) {
+			rc = check_slots();
+			if(rc > 0) {
+				/* Give userspace a chance to handle extraction */
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(HZ / 2);
+			} else if(rc < 0) {
+				dbg("%s - error checking slots", __FUNCTION__);
+				thread_finished = 1;
+				break;
+			}
+		}
+		/* Check for someone yanking out a board */
+		list_for_each(tmp, &slot_list) {
+			slot = list_entry(tmp, struct slot, slot_list);
+			if(slot->extracting) {
+				/*
+				 * Hmmm, we're likely hosed at this point, should we
+				 * bother trying to tell the driver or not?
+				 */
+				err("card in slot %s was improperly removed",
+				    slot->hotplug_slot->name);
+				if(update_adapter_status(slot->hotplug_slot, 0)) {
+					warn("failure to update adapter file");
+				}
+				slot->extracting = 0;
+			}
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ / 10);
+	}
+	dbg("poll thread signals exit");
+	up(&thread_exit);
+	return 0;
+}
+
+static int
+cpci_start_thread(void)
+{
+	int pid;
+
+	/* initialize our semaphores */
+	init_MUTEX_LOCKED(&event_semaphore);
+	init_MUTEX_LOCKED(&thread_exit);
+	thread_finished = 0;
+
+	if(controller->irq) {
+		pid = kernel_thread(event_thread, 0, 0);
+	} else {
+		pid = kernel_thread(poll_thread, 0, 0);
+	}
+	if(pid < 0) {
+		err("Can't start up our thread");
+		return -1;
+	}
+	dbg("Our thread pid = %d", pid);
+	return 0;
+}
+
+static void
+cpci_stop_thread(void)
+{
+	thread_finished = 1;
+	dbg("thread finish command given");
+	if(controller->irq) {
+		up(&event_semaphore);
+	}
+	dbg("wait for thread to exit");
+	down(&thread_exit);
+}
+
+int
+cpci_hp_register_controller(struct cpci_hp_controller *new_controller)
+{
+	int status = 0;
+
+	if(!controller) {
+		controller = new_controller;
+		if(controller->irq) {
+			if(request_irq(controller->irq,
+					cpci_hp_intr,
+					controller->irq_flags,
+					MY_NAME, controller->dev_id)) {
+				err("Can't get irq %d for the hotplug cPCI controller", controller->irq);
+				status = -ENODEV;
+			}
+			dbg("%s - acquired controller irq %d", __FUNCTION__,
+			    controller->irq);
+		}
+	} else {
+		err("cPCI hotplug controller already registered");
+		status = -1;
+	}
+	return status;
+}
+
+int
+cpci_hp_unregister_controller(struct cpci_hp_controller *old_controller)
+{
+	int status = 0;
+
+	if(controller) {
+		if(!thread_finished) {
+			cpci_stop_thread();
+		}
+		if(controller->irq) {
+			free_irq(controller->irq, controller->dev_id);
+		}
+		controller = NULL;
+	} else {
+		status = -ENODEV;
+	}
+	return status;
+}
+
+int
+cpci_hp_start(void)
+{
+	static int first = 1;
+	int status;
+
+	dbg("%s - enter", __FUNCTION__);
+	if(!controller) {
+		return -ENODEV;
+	}
+
+	spin_lock(&list_lock);
+	if(!slots) {
+		spin_unlock(&list_lock);
+		return -ENODEV;
+	}
+	spin_unlock(&list_lock);
+
+	if(first) {
+		status = init_slots();
+		if(status) {
+			return status;
+		}
+		first = 0;
+	}
+
+	status = cpci_start_thread();
+	if(status) {
+		return status;
+	}
+	dbg("%s - thread started", __FUNCTION__);
+
+	if(controller->irq) {
+		/* Start enum interrupt processing */
+		dbg("%s - enabling irq", __FUNCTION__);
+		controller->ops->enable_irq();
+	}
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+int
+cpci_hp_stop(void)
+{
+	if(!controller) {
+		return -ENODEV;
+	}
+
+	if(controller->irq) {
+		/* Stop enum interrupt processing */
+		dbg("%s - disabling irq", __FUNCTION__);
+		controller->ops->disable_irq();
+	}
+	cpci_stop_thread();
+	return 0;
+}
+
+static void __exit
+cleanup_slots(void)
+{
+	struct list_head *tmp;
+	struct slot *slot;
+
+	/*
+	 * Unregister all of our slots with the pci_hotplug subsystem,
+	 * and free up all memory that we had allocated.
+	 */
+	spin_lock(&list_lock);
+	if(!slots) {
+		goto null_cleanup;
+	}
+	list_for_each(tmp, &slot_list) {
+		slot = list_entry(tmp, struct slot, slot_list);
+		list_del(&slot->slot_list);
+		pci_hp_deregister(slot->hotplug_slot);
+		kfree(slot->hotplug_slot->info);
+		kfree(slot->hotplug_slot->name);
+		kfree(slot->hotplug_slot);
+		kfree(slot);
+	}
+      null_cleanup:
+	spin_unlock(&list_lock);
+	return;
+}
+
+static int __init
+cpci_hotplug_init(void)
+{
+	spin_lock_init(&list_lock);
+
+	info(DRIVER_DESC " version: " DRIVER_VERSION);
+	return 0;
+}
+
+static void __exit
+cpci_hotplug_exit(void)
+{
+	/*
+	 * Clean everything up.
+	 */
+	cleanup_slots();
+}
+
+module_init(cpci_hotplug_init);
+module_exit(cpci_hotplug_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_PARM(cpci_debug, "i");
+MODULE_PARM_DESC(cpci_debug, "Debugging mode");
+
+EXPORT_SYMBOL_GPL(cpci_hp_register_controller);
+EXPORT_SYMBOL_GPL(cpci_hp_unregister_controller);
+EXPORT_SYMBOL_GPL(cpci_hp_register_bus);
+EXPORT_SYMBOL_GPL(cpci_hp_unregister_bus);
+EXPORT_SYMBOL_GPL(cpci_find_slot);
+EXPORT_SYMBOL_GPL(cpci_hp_start);
+EXPORT_SYMBOL_GPL(cpci_hp_stop);
diff -Nru a/drivers/hotplug/cpci_hotplug_pci.c b/drivers/hotplug/cpci_hotplug_pci.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Tue Nov  5 17:26:15 2002
@@ -0,0 +1,685 @@
+/*
+ * CompactPCI Hot Plug Driver PCI functions
+ *
+ * Copyright (c) 2002 by SOMA Networks, Inc.
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
+ * Send feedback to <scottm@somanetworks.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include "pci_hotplug.h"
+#include "cpci_hotplug.h"
+
+#if !defined(CONFIG_HOTPLUG_CPCI_MODULE)
+#define MY_NAME	"cpci_hotplug"
+#else
+#define MY_NAME	THIS_MODULE->name
+#endif
+
+extern int cpci_debug;
+
+#define dbg(format, arg...)					\
+	do {							\
+		if(cpci_debug)					\
+			printk (KERN_DEBUG "%s: " format "\n",	\
+				MY_NAME , ## arg); 		\
+	} while(0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+
+#define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
+
+
+u8 cpci_get_attention_status(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return 0;
+	}
+
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return 0;
+	}
+	return hs_csr & 0x0008 ? 1 : 0;
+}
+
+int cpci_set_attention_status(struct slot* slot, int status)
+{
+	int hs_cap;
+	u16 hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return 0;
+	}
+
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return 0;
+	}
+	if(status) {
+		hs_csr |= HS_CSR_LOO;
+	} else {
+		hs_csr &= ~HS_CSR_LOO;
+	}
+	if(pci_bus_write_config_word(slot->bus,
+				      slot->devfn,
+				      hs_cap + 2,
+				      hs_csr)) {
+		return 0;
+	}
+	return 1;
+}
+
+u16 cpci_get_hs_csr(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return 0xFFFF;
+	}
+
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return 0xFFFF;
+	}
+	return hs_csr;
+}
+
+u16 cpci_set_hs_csr(struct slot* slot, u16 hs_csr)
+{
+	int hs_cap;
+	u16 new_hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return 0xFFFF;
+	}
+
+	/* Write out the new value */
+	if(pci_bus_write_config_word(slot->bus,
+				      slot->devfn,
+				      hs_cap + 2,
+				      hs_csr)) {
+		return 0xFFFF;
+	}
+
+	/* Read back what we just wrote out */
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &new_hs_csr)) {
+		return 0xFFFF;
+	}
+	return new_hs_csr;
+}
+
+int cpci_check_and_clear_ins(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+	int ins = 0;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return 0;
+	}
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return 0;
+	}
+	if(hs_csr & HS_CSR_INS) {
+		/* Clear INS (by setting it) */
+		if(pci_bus_write_config_word(slot->bus,
+					      slot->devfn,
+					      hs_cap + 2,
+					      hs_csr)) {
+			ins = 0;
+		}
+		ins = 1;
+	}
+	return ins;
+}
+
+int cpci_check_ext(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+	int ext = 0;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return 0;
+	}
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return 0;
+	}
+	if(hs_csr & HS_CSR_EXT) {
+		ext = 1;
+	}
+	return ext;
+}
+
+int cpci_clear_ext(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return -ENODEV;
+	}
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return -ENODEV;
+	}
+	if(hs_csr & HS_CSR_EXT) {
+		/* Clear EXT (by setting it) */
+		if(pci_bus_write_config_word(slot->bus,
+					      slot->devfn,
+					      hs_cap + 2,
+					      hs_csr)) {
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+int cpci_led_on(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return -ENODEV;
+	}
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return -ENODEV;
+	}
+	if((hs_csr & HS_CSR_LOO) != HS_CSR_LOO) {
+		/* Set LOO */
+		hs_csr |= HS_CSR_LOO;
+		if(pci_bus_write_config_word(slot->bus,
+					      slot->devfn,
+					      hs_cap + 2,
+					      hs_csr)) {
+			err("Could not set LOO for slot %s",
+			    slot->hotplug_slot->name);
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+int cpci_led_off(struct slot* slot)
+{
+	int hs_cap;
+	u16 hs_csr;
+
+	hs_cap = pci_bus_find_capability(slot->bus,
+					 slot->devfn,
+					 PCI_CAP_ID_CHSWP);
+	if(!hs_cap) {
+		return -ENODEV;
+	}
+	if(pci_bus_read_config_word(slot->bus,
+				     slot->devfn,
+				     hs_cap + 2,
+				     &hs_csr)) {
+		return -ENODEV;
+	}
+	if(hs_csr & HS_CSR_LOO) {
+		/* Clear LOO */
+		hs_csr &= ~HS_CSR_LOO;
+		if(pci_bus_write_config_word(slot->bus,
+					      slot->devfn,
+					      hs_cap + 2,
+					      hs_csr)) {
+			err("Could not clear LOO for slot %s",
+			    slot->hotplug_slot->name);
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+
+/*
+ * Device configuration functions
+ */
+
+static int cpci_configure_dev(struct pci_bus *bus, struct pci_dev *dev)
+{
+	u8 irq_pin;
+	int r;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	/* NOTE: device already setup from prior scan */
+
+	/* FIXME: How would we know if we need to enable the expansion ROM? */
+	pci_write_config_word(dev, PCI_ROM_ADDRESS, 0x00L);
+
+	/* Assign resources */
+	dbg("assigning resources for %02x:%02x.%x",
+	    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	for (r = 0; r < 6; r++) {
+		struct resource *res = dev->resource + r;
+		if(res->flags)
+			pci_assign_resource(dev, r);
+	}
+	dbg("finished assigning resources for %02x:%02x.%x",
+	    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	/* Does this function have an interrupt at all? */
+	dbg("checking for function interrupt");
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq_pin);
+	if(irq_pin) {
+		dbg("function uses interrupt pin %d", irq_pin);
+	}
+
+	/*
+	 * Need to explicitly set irq field to 0 so that it'll get assigned
+	 * by the pcibios platform dependant code called by pci_enable_device.
+	 */
+	dev->irq = 0;
+
+	dbg("enabling device");
+	pci_enable_device(dev);	/* XXX check return */
+	dbg("now dev->irq = %d", dev->irq);
+	if(irq_pin && dev->irq) {
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+	}
+
+	/* Can't use pci_insert_device at the moment, do it manually for now */
+	pci_proc_attach_device(dev);
+	dbg("notifying drivers");
+	//pci_announce_device_to_drivers(dev);
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+static int cpci_configure_bridge(struct pci_bus* bus, struct pci_dev* dev)
+{
+	int rc;
+	struct pci_bus* child;
+	struct resource* r;
+	u8 max, n;
+	u16 command;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	/* Do basic bridge initialization */
+	rc = pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x40);
+	if(rc) {
+		printk(KERN_ERR "%s - write of PCI_LATENCY_TIMER failed\n", __FUNCTION__);
+	}
+	rc = pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 0x40);
+	if(rc) {
+		printk(KERN_ERR "%s - write of PCI_SEC_LATENCY_TIMER failed\n", __FUNCTION__);
+	}
+	rc = pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES / 4);
+	if(rc) {
+		printk(KERN_ERR "%s - write of PCI_CACHE_LINE_SIZE failed\n", __FUNCTION__);
+	}
+
+	/*
+	 * Set parent bridge's subordinate field so that configuration space
+	 * access will work in pci_scan_bridge and friends.
+	 */
+	max = pci_max_busnr();
+	bus->subordinate = max + 1;
+	pci_write_config_byte(bus->self, PCI_SUBORDINATE_BUS, max + 1);
+
+	/* Scan behind bridge */
+	n = pci_scan_bridge(bus, dev, max, 2);
+	child = pci_find_bus(max + 1);
+#ifdef CONFIG_PROC_FS
+	pci_proc_attach_bus(child);
+#endif
+	/*
+	 * Update parent bridge's subordinate field if there were more bridges
+	 * behind the bridge that was scanned.
+	 */
+	if(n > max) {
+		bus->subordinate = n;
+		pci_write_config_byte(bus->self, PCI_SUBORDINATE_BUS, n);
+	}
+
+	/*
+	 * Update the bridge resources of the bridge to accommodate devices
+	 * behind it.
+	 */
+	pbus_size_bridges(child);
+	pbus_assign_resources(child);
+
+	/* Enable resource mapping via command register */
+	command = PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	r = child->resource[0];
+	if(r && r->start) {
+		command |= PCI_COMMAND_IO;
+	}
+	r = child->resource[1];
+	if(r && r->start) {
+		command |= PCI_COMMAND_MEMORY;
+	}
+	r = child->resource[2];
+	if(r && r->start) {
+		command |= PCI_COMMAND_MEMORY;
+	}
+	rc = pci_write_config_word(dev, PCI_COMMAND, command);
+	if(rc) {
+		err("Error setting command register");
+		return rc;
+	}
+
+	/* Set bridge control register */
+	command = PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR | PCI_BRIDGE_CTL_NO_ISA;
+	rc = pci_write_config_word(dev, PCI_BRIDGE_CONTROL, command);
+	if(rc) {
+		err("Error setting bridge control register");
+		return rc;
+	}
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+static int configure_visit_pci_dev(struct pci_dev_wrapped *wrapped_dev,
+			struct pci_bus_wrapped *wrapped_bus)
+{
+	int rc;
+	struct pci_dev *dev = wrapped_dev->dev;
+	struct pci_bus *bus = wrapped_bus->bus;
+	struct slot* slot;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	/*
+	 * We need to fix up the hotplug representation with the Linux
+	 * representation.
+	 */
+	slot = cpci_find_slot(dev->bus, dev->devfn);
+	if(slot) {
+		slot->dev = dev;
+	}
+
+	/* If it's a bridge, scan behind it for devices */
+	if(dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		rc = cpci_configure_bridge(bus, dev);
+		if(rc)
+			return rc;
+	}
+
+	/* Actually configure device */
+	if(dev) {
+		rc = cpci_configure_dev(bus, dev);
+		if(rc)
+			return rc;
+	}
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+static int unconfigure_visit_pci_dev_phase1(struct pci_dev_wrapped *wrapped_dev,
+				 struct pci_bus_wrapped *wrapped_bus)
+{
+	struct pci_dev *dev = wrapped_dev->dev;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	dbg("attempting removal of driver for device %02x:%02x.%x",
+	    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	/* Now, remove the Linux Driver representation */
+	if(dev->driver) {
+		dbg("device is attached to a driver");
+		if(dev->driver->remove) {
+			dev->driver->remove(dev);
+			dbg("driver was removed");
+		}
+		dev->driver = NULL;
+	}
+	dbg("%s - exit", __FUNCTION__);
+	return pci_is_dev_in_use(dev);
+}
+
+static int unconfigure_visit_pci_dev_phase2(struct pci_dev_wrapped *wrapped_dev,
+					    struct pci_bus_wrapped *wrapped_bus)
+{
+	struct pci_dev *dev = wrapped_dev->dev;
+	struct slot* slot;
+
+	dbg("%s - enter", __FUNCTION__);
+	if(!dev)
+		return -ENODEV;
+
+	/* Remove the Linux representation */
+	if(pci_remove_device_safe(dev) == 0) {
+		kfree(dev);
+	} else {
+		err("Could not remove device\n");
+		return -1;
+	}
+
+	/*
+	 * Now remove the hotplug representation.
+	 */
+	slot = cpci_find_slot(dev->bus, dev->devfn);
+	if(slot) {
+		slot->dev = NULL;
+	} else {
+		dbg("No hotplug representation for %02x:%02x.%x",
+		    dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	}
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+static int unconfigure_visit_pci_bus_phase2(struct pci_bus_wrapped *wrapped_bus,
+					    struct pci_dev_wrapped *wrapped_dev)
+{
+	struct pci_bus *bus = wrapped_bus->bus;
+	struct pci_bus *parent = bus->self->bus;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	/* The cleanup code for proc entries regarding buses should be in the kernel... */
+	if(bus->procdir)
+		dbg("detach_pci_bus %s", bus->procdir->name);
+	pci_proc_detach_bus(bus);
+
+	/* The cleanup code should live in the kernel... */
+	bus->self->subordinate = NULL;
+
+	/* unlink from parent bus */
+	list_del(&bus->node);
+
+	/* Now, remove */
+	if(bus)
+		kfree(bus);
+
+	/* Update parent's subordinate field */
+	if(parent) {
+		u8 n = pci_bus_max_busnr(parent);
+		if(n < parent->subordinate) {
+			parent->subordinate = n;
+			pci_write_config_byte(parent->self, PCI_SUBORDINATE_BUS, n);
+		}
+	}
+	dbg("%s - exit", __FUNCTION__);
+	return 0;
+}
+
+static struct pci_visit configure_functions = {
+	visit_pci_dev:configure_visit_pci_dev,
+};
+
+static struct pci_visit unconfigure_functions_phase1 = {
+	post_visit_pci_dev:unconfigure_visit_pci_dev_phase1
+};
+
+static struct pci_visit unconfigure_functions_phase2 = {
+	post_visit_pci_bus:unconfigure_visit_pci_bus_phase2,
+	post_visit_pci_dev:unconfigure_visit_pci_dev_phase2
+};
+
+
+int cpci_configure_slot(struct slot* slot)
+{
+	int rc = 0;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	if(slot->dev == NULL) {
+		dbg("pci_dev null, finding %02x:%02x:%x",
+		    slot->bus->number, PCI_SLOT(slot->devfn), PCI_FUNC(slot->devfn));
+		slot->dev = pci_find_slot(slot->bus->number, slot->devfn);
+	}
+
+	/* Still NULL? Well then scan for it! */
+	if(slot->dev == NULL) {
+		struct pci_dev dev0;
+
+		dbg("pci_dev still null");
+		memset(&dev0, 0, sizeof (struct pci_dev));
+		dev0.bus = slot->bus;
+		dev0.devfn = slot->devfn;
+		dev0.sysdata = slot->bus->self->sysdata;
+
+		/*
+		 * This will generate pci_dev structures for all functions, but
+		 * we will only call this case when lookup fails.
+		 */
+		slot->dev = pci_scan_slot(&dev0);
+		if(slot->dev == NULL) {
+			err("Could not find PCI device for slot %02x", slot->number);
+			return 0;
+		}
+	}
+	dbg("slot->dev = %p", slot->dev);
+	if(slot->dev) {
+		struct pci_dev *dev;
+		struct pci_dev_wrapped wrapped_dev;
+		struct pci_bus_wrapped wrapped_bus;
+		int i;
+
+		memset(&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
+		memset(&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
+
+		for (i = 0; i < 8; i++) {
+			dev = pci_find_slot(slot->bus->number,
+					    PCI_DEVFN(PCI_SLOT(slot->dev->devfn), i));
+			if(!dev)
+				continue;
+			wrapped_dev.dev = dev;
+			wrapped_bus.bus = slot->dev->bus;
+			rc = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
+		}
+	}
+
+	dbg("%s - exit, rc = %d", __FUNCTION__, rc);
+	return rc;
+}
+
+int cpci_unconfigure_slot(struct slot* slot)
+{
+	int rc = 0;
+	int i;
+	struct pci_dev_wrapped wrapped_dev;
+	struct pci_bus_wrapped wrapped_bus;
+	struct pci_dev *dev;
+
+	dbg("%s - enter", __FUNCTION__);
+
+	if(!slot->dev) {
+		err("No device for slot %02x\n", slot->number);
+		return -ENODEV;
+	}
+
+	memset(&wrapped_dev, 0, sizeof (struct pci_dev_wrapped));
+	memset(&wrapped_bus, 0, sizeof (struct pci_bus_wrapped));
+
+	for (i = 0; i < 8; i++) {
+		dev = pci_find_slot(slot->bus->number,
+				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
+		if(dev) {
+			wrapped_dev.dev = dev;
+			wrapped_bus.bus = dev->bus;
+			dbg("%s - unconfigure phase 1", __FUNCTION__);
+			rc = pci_visit_dev(&unconfigure_functions_phase1,
+					   &wrapped_dev, &wrapped_bus);
+			if(rc) {
+				break;
+			}
+
+			dbg("%s - unconfigure phase 2", __FUNCTION__);
+			rc = pci_visit_dev(&unconfigure_functions_phase2,
+					   &wrapped_dev, &wrapped_bus);
+			if(rc)
+				break;
+		}
+	}
+	dbg("%s - exit, rc = %d", __FUNCTION__, rc);
+	return rc;
+}
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Tue Nov  5 17:26:15 2002
+++ b/drivers/hotplug/pci_hotplug.h	Tue Nov  5 17:26:15 2002
@@ -167,5 +167,9 @@
 				 struct pci_dev_wrapped *wrapped_dev,
 				 struct pci_bus_wrapped *wrapped_parent);
 
+int pci_is_dev_in_use(struct pci_dev *dev);
+
+int pci_remove_device_safe(struct pci_dev *dev);
+
 #endif
 
diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Tue Nov  5 17:26:15 2002
+++ b/drivers/hotplug/pci_hotplug_util.c	Tue Nov  5 17:26:15 2002
@@ -94,15 +94,12 @@
 
 static int pci_visit_bridge (struct pci_visit * fn, struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_parent)
 {
-	struct pci_bus *bus = wrapped_dev->dev->subordinate;
+	struct pci_bus *bus;
 	struct pci_bus_wrapped wrapped_bus;
 	int result;
 
-	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
-	wrapped_bus.bus = bus;
-
-	dbg("scanning bridge %02x, %02x\n", wrapped_dev->dev->devfn >> 3,
-	    wrapped_dev->dev->devfn & 0x7);
+	dbg("scanning bridge %02x, %02x\n", PCI_SLOT(wrapped_dev->dev->devfn),
+	    PCI_FUNC(wrapped_dev->dev->devfn));
 
 	if (fn->visit_pci_dev) {
 		result = fn->visit_pci_dev(wrapped_dev, wrapped_parent);
@@ -110,7 +107,13 @@
 			return result;
 	}
 
-	result = pci_visit_bus(fn, &wrapped_bus, wrapped_dev);
+	bus = wrapped_dev->dev->subordinate;
+	if(bus) {
+		memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
+		wrapped_bus.bus = bus;
+
+		result = pci_visit_bus(fn, &wrapped_bus, wrapped_dev);
+	}
 	return result;
 }
 
@@ -153,6 +156,62 @@
 	return result;
 }
 
+/**
+ * pci_is_dev_in_use - query devices' usage
+ * @dev: PCI device to query
+ *
+ * Queries whether a given PCI device is in use by a driver or not.
+ * Returns 1 if the device is in use, 0 if it is not.
+ */
+int pci_is_dev_in_use(struct pci_dev *dev)
+{
+	/* 
+	 * dev->driver will be set if the device is in use by a new-style 
+	 * driver -- otherwise, check the device's regions to see if any
+	 * driver has claimed them.
+	 */
+
+	int i;
+	int inuse = 0;
+
+	if (dev->driver) {
+		/* Assume driver feels responsible */
+		return 1;
+	}
+
+	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
+		if (!pci_resource_start(dev, i))
+			continue;
+		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
+			inuse = check_region(pci_resource_start(dev, i),
+					     pci_resource_len(dev, i));
+		} else if (pci_resource_flags(dev, i) & IORESOURCE_MEM) {
+			inuse = check_mem_region(pci_resource_start(dev, i),
+						 pci_resource_len(dev, i));
+		}
+	}
+	return inuse;
+}
+
+/**
+ * pci_remove_device_safe - remove an unused hotplug device
+ * @dev: the device to remove
+ *
+ * Delete the device structure from the device lists and 
+ * notify userspace (/sbin/hotplug), but only if the device
+ * in question is not being used by a driver.
+ * Returns 0 on success.
+ */
+int pci_remove_device_safe(struct pci_dev *dev)
+{
+	if (pci_is_dev_in_use(dev)) {
+		return -EBUSY;
+	}
+	pci_remove_device(dev);
+	return 0;
+}
 
 EXPORT_SYMBOL(pci_visit_dev);
+EXPORT_SYMBOL(pci_is_dev_in_use);
+EXPORT_SYMBOL(pci_remove_device_safe);
 
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Tue Nov  5 17:26:15 2002
+++ b/drivers/pci/Makefile	Tue Nov  5 17:26:15 2002
@@ -25,6 +25,11 @@
 obj-$(CONFIG_DDB5476) += setup-bus.o
 obj-$(CONFIG_SGI_IP27) += setup-irq.o
 
+# CompactPCI hotplug requires the pbus_* functions
+ifdef CONFIG_HOTPLUG_PCI_CPCI
+obj-y += setup-bus.o
+endif
+
 ifndef CONFIG_X86
 obj-y += syscall.o
 endif
