Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUBPSWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 13:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUBPSWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 13:22:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:63169 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265444AbUBPSV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 13:21:26 -0500
Subject: Re: [PATCH] PPC64 PCI Hotplug Driver for RPA
From: John Rose <johnrose@austin.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@us.ibm.com,
       Mike Wortman <wortman@us.ibm.com>
In-Reply-To: <20040215222211.4F99817DE7@ozlabs.au.ibm.com>
References: <20040215222211.4F99817DE7@ozlabs.au.ibm.com>
Content-Type: text/plain
Message-Id: <1076955716.10484.21.camel@verve.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 16 Feb 2004 12:21:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Argh, botched that email.  Apologies.  Patch below, this time the entire
one :)

> Please:
> 	module_param(debug, int, 0644);

diff -Nru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	Mon Feb 16 12:12:05 2004
+++ b/drivers/pci/hotplug/Kconfig	Mon Feb 16 12:12:05 2004
@@ -122,5 +122,16 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_RPA
+	tristate "RPA PCI Hotplug driver"
+	depends on HOTPLUG_PCI && PPC_PSERIES && PPC64
+	help
+	  Say Y here if you have a a RPA system that supports PCI Hotplug.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rpaphp.
+
+	  When in doubt, say N.
+
 endmenu
 
diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Mon Feb 16 12:12:05 2004
+++ b/drivers/pci/hotplug/Makefile	Mon Feb 16 12:12:05 2004
@@ -9,6 +9,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI_GENERIC)	+= cpcihp_generic.o
+obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o
 
@@ -32,6 +33,9 @@
 				acpiphp_glue.o	\
 				acpiphp_pci.o	\
 				acpiphp_res.o
+
+rpaphp-objs		:=	rpaphp_core.o	\
+				rpaphp_pci.o	
 
 ifdef CONFIG_HOTPLUG_PCI_ACPI
   EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpaphp.h	Mon Feb 16 12:12:05 2004
@@ -0,0 +1,106 @@
+/*
+ * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
+ *
+ * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
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
+ * Send feedback to <lxie@us.ibm.com>,
+ *
+ */
+
+#ifndef _PPC64PHP_H
+#define _PPC64PHP_H
+#include "pci_hotplug.h"
+
+#define DR_INDICATOR 9002
+#define DR_ENTITY_SENSE 9003
+
+#define POWER_ON	100
+#define POWER_OFF	0
+
+#define LED_OFF		0 
+#define LED_ON		1	/* continuous on */ 
+#define LED_ID		2	/* slow blinking */
+#define LED_ACTION	3	/* fast blinking */
+
+#define SLOT_NAME_SIZE 12
+
+/* Error status from rtas_get-sensor */
+#define NEED_POWER    -9000     /* slot must be power up and unisolated to get state */
+#define PWR_ONLY      -9001     /* slot must be powerd up to get state, leave isolated */
+#define ERR_SENSE_USE -9002     /* No DR operation will succeed, slot is unusable  */
+
+/* Sensor values from rtas_get-sensor */
+#define EMPTY	0       /* No card in slot */
+#define PRESENT	1       /* Card in slot */
+
+#if !defined(CONFIG_HOTPLUG_PCI_MODULE)
+	#define MY_NAME "rpaphp"
+#else
+	#define MY_NAME THIS_MODULE->name
+#endif
+
+
+#define dbg(format, arg...)					\
+	do {							\
+		if (rpaphp_debug)				\
+			printk(KERN_DEBUG "%s: " format,	\
+				MY_NAME , ## arg); 		\
+	} while (0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME , ## arg)
+
+#define SLOT_MAGIC	0x67267322
+
+/* slot states */
+
+#define	NOT_VALID	3
+#define	NOT_CONFIGURED	2
+#define	CONFIGURED	1
+#define	EMPTY		0
+
+/*
+ * struct slot - slot information for each *physical* slot
+ */
+struct slot {
+	u32	magic;
+	int     state;
+	u32     index;
+	u32     type;
+	u32     power_domain;
+	char    *name;
+	struct	device_node *dn;/* slot's device_node in OFDT		*/
+				/* dn has phb info			*/
+	struct	pci_dev	*bridge;/* slot's pci_dev in pci_devices	*/
+
+	struct	pci_dev	*dev;	/* pci_dev of device in this slot 	*/
+				/* it will be used for unconfig		*/ 
+				/* NULL if slot is empty		*/
+
+	struct  hotplug_slot    *hotplug_slot;
+	struct list_head	rpaphp_slot_list;
+};
+
+extern struct pci_dev *rpaphp_find_pci_dev(struct device_node *dn);
+extern int rpaphp_add_slot(char *slot_name);
+extern int rpaphp_remove_slot(struct slot *slot);
+extern int rpaphp_claim_resource(struct pci_dev *dev, int resource);
+
+#endif /* _PPC64PHP_H */
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpaphp_core.c	Mon Feb 16 12:12:05 2004
@@ -0,0 +1,965 @@
+/*
+ * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
+ * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
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
+ * Send feedback to <lxie@us.ibm.com>
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <asm/rtas.h>		/* rtas_call */
+#include <asm/pci-bridge.h>	/* for pci_controller */
+#include "../pci.h"		/* for pci_add_new_bus*/
+				/* and pci_do_scan_bus*/
+#include "rpaphp.h"
+#include "pci_hotplug.h"
+
+
+static int debug = 1;
+static struct semaphore rpaphp_sem;
+static int rpaphp_debug;
+static LIST_HEAD (rpaphp_slot_head);
+static int num_slots = 0;
+
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"Linda Xie <lxie@us.ibm.com>"
+#define DRIVER_DESC	"RPA HOT Plug PCI Controller Driver"
+
+#define MAX_LOC_CODE 128
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+module_param(debug, int, 0644);
+
+static int enable_slot		(struct hotplug_slot *slot);
+static int disable_slot		(struct hotplug_slot *slot);
+static int set_attention_status (struct hotplug_slot *slot, u8 value);
+static int get_power_status	(struct hotplug_slot *slot, u8 *value);
+static int get_attention_status	(struct hotplug_slot *slot, u8 *value);
+static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
+static int get_max_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
+static int get_cur_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
+
+static struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
+	.owner			= THIS_MODULE,
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+	.set_attention_status	= set_attention_status,
+	.get_power_status	= get_power_status,
+	.get_attention_status	= get_attention_status,
+	.get_adapter_status	= get_adapter_status,
+	.get_max_bus_speed	= get_max_bus_speed,
+	.get_cur_bus_speed	= get_cur_bus_speed,
+};
+
+static int rpaphp_get_sensor_state(int index, int *state)
+{
+	int rc;
+
+	rc = rtas_get_sensor(DR_ENTITY_SENSE, index, state);
+
+	if (rc) {
+		if (rc ==  NEED_POWER || rc == PWR_ONLY) {
+			dbg("%s: slot must be power up to get sensor-state\n",
+				__FUNCTION__);
+		} else if (rc == ERR_SENSE_USE)
+			info("%s: slot is unusable\n", __FUNCTION__);
+		   else err("%s failed to get sensor state\n", __FUNCTION__);
+	}
+	return rc;
+}
+
+static struct pci_dev *rpaphp_find_bridge_pdev(struct slot *slot)
+{
+	struct pci_dev		*retval_dev = NULL;
+
+	retval_dev = rpaphp_find_pci_dev(slot->dn);
+
+	return retval_dev;
+}
+
+static struct pci_dev *rpaphp_find_adapter_pdev(struct slot *slot)
+{
+	struct pci_dev * retval_dev = NULL;
+
+	retval_dev = rpaphp_find_pci_dev(slot->dn->child);
+
+	return retval_dev;
+}
+
+
+/* Inline functions to check the sanity of a pointer that is passed to us */
+static inline int slot_paranoia_check(struct slot *slot, const char *function)
+{
+	if (!slot) {
+		dbg("%s - slot == NULL\n", function);
+		return -1;
+	}
+
+	if (!slot->hotplug_slot) {
+		dbg("%s - slot->hotplug_slot == NULL!\n", function);
+		return -1;
+	}
+	return 0;
+}
+
+static inline struct slot *get_slot(struct hotplug_slot *hotplug_slot, const char *function)
+{
+	struct slot *slot;
+
+	if (!hotplug_slot) {
+		dbg("%s - hotplug_slot == NULL\n", function);
+		return NULL;
+	}
+
+	slot = (struct slot *)hotplug_slot->private;
+	if (slot_paranoia_check(slot, function))
+		return NULL;
+	return slot;
+}
+
+static inline int rpaphp_set_attention_status(struct slot *slot, u8 status)
+{
+	int	rc;
+
+	/* status: LED_OFF or LED_ON */
+	rc = rtas_set_indicator(DR_INDICATOR, slot->index, status);
+	if (rc)
+		err("slot(%s) set attention-status(%d) failed! rc=0x%x\n",
+			slot->name, status, rc);
+	
+	return rc;
+}
+
+static int rpaphp_get_power_status(struct slot *slot, u8 *value)
+{
+	int	rc;
+
+	rc = rtas_get_power_level(slot->power_domain, (int *)value);
+	if (rc)
+		err("failed to get power-level for slot(%s), rc=0x%x\n",
+			slot->name, rc);
+
+	return rc;
+}
+
+static int rpaphp_get_attention_status(struct slot *slot)
+{
+
+	return slot->hotplug_slot->info->attention_status;
+}
+
+/**
+ * set_attention_status - set attention LED
+ * echo 0 > attention -- set LED OFF
+ * echo 1 > attention -- set LED ON
+ * echo 2 > attention -- set LED ID(identify, light is blinking)
+ *
+ */
+static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 value)
+{
+	int retval = 0;
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	down(&rpaphp_sem);
+	switch (value) {
+		case 0:
+			retval = rpaphp_set_attention_status(slot, LED_OFF);
+			hotplug_slot->info->attention_status = 0;
+			break;
+
+		case 1:
+		default:
+			retval = rpaphp_set_attention_status(slot, LED_ON);
+			hotplug_slot->info->attention_status = 1;
+			break;
+
+		case 2:
+			retval = rpaphp_set_attention_status(slot, LED_ID);
+			hotplug_slot->info->attention_status = 2;
+			break;
+
+	}
+	up(&rpaphp_sem);
+	
+	return retval;
+}
+
+/**
+ * get_power_status - get power status of a slot
+ * @hotplug_slot: slot to get status
+ * @value: pointer to store status
+ *
+ *
+ */
+static int get_power_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	int retval;
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	down(&rpaphp_sem);
+	retval = rpaphp_get_power_status(slot, value);
+	up(&rpaphp_sem);
+
+	return retval;
+}
+
+/**
+ * get_attention_status - get attention LED status
+ *
+ *
+ */
+static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	int retval = 0;
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+
+	down(&rpaphp_sem);
+	*value = rpaphp_get_attention_status(slot);
+	up(&rpaphp_sem);
+
+	return retval;
+}
+
+/*
+ * get_adapter_status - get  the status of a slot
+ *
+ * 0-- slot is empty
+ * 1-- adapter is configured
+ * 2-- adapter is not configured
+ * 3-- not valid
+ */
+static int rpaphp_get_adapter_status(struct slot *slot, int is_init, u8 *value)
+{
+	int	state, rc;
+
+	*value 		  = NOT_VALID;
+
+	rc = rpaphp_get_sensor_state(slot->index, &state);
+
+	if (rc)
+		return rc;
+
+	if (state == PRESENT) {
+		dbg("slot is occupied\n");
+
+		if (!is_init) /* at run-time slot->state can be changed by */
+			  /* config/unconfig adapter	 		   */
+			*value = slot->state;
+		else {
+		if (!slot->dn->child)
+			dbg("%s: %s is not valid OFDT node\n",
+				__FUNCTION__, slot->dn->full_name);
+		else
+			if (rpaphp_find_pci_dev(slot->dn->child))
+				*value = CONFIGURED;
+			else {
+				dbg("%s: can't find pdev of adapter in slot[%s]\n",
+					__FUNCTION__, slot->name);
+				*value = NOT_CONFIGURED;
+				}
+		}
+	}
+	else
+		if (state == EMPTY) {
+		dbg("slot is empty\n");
+			*value = state;
+		}
+	
+	return 0;
+}
+
+static int get_adapter_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+	int retval = 0;
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	down(&rpaphp_sem);
+
+	/*  have to go through this */
+	retval = rpaphp_get_adapter_status(slot, 0, value);
+
+	up(&rpaphp_sem);
+
+	return retval;
+}
+
+
+static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	down(&rpaphp_sem);
+
+	switch (slot->type) {
+		case 1:
+		case 2:
+		case 3:
+		case 4:
+		case 5:
+		case 6:
+			*value = PCI_SPEED_33MHz;	/* speed for case 1-6 */
+			break;
+		case 7:
+		case 8:
+			*value = PCI_SPEED_66MHz;
+			break;
+		case 11:
+		case 14:
+			*value = PCI_SPEED_66MHz_PCIX;
+			break;
+		case 12:
+		case 15:
+			*value = PCI_SPEED_100MHz_PCIX;
+			break;
+		case 13:
+		case 16:
+			*value = PCI_SPEED_133MHz_PCIX;
+			break;
+		default:
+			*value = PCI_SPEED_UNKNOWN;
+			break;
+
+	}
+
+	up(&rpaphp_sem);
+
+	return 0;
+}
+
+
+/* return dummy value because not sure if PRA provides any method... */
+static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	*value = PCI_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+/*
+ * rpaphp_validate_slot - make sure the name of the slot matches
+ * 				the location code , if the slots is not
+ *				empty.
+ */
+static int rpaphp_validate_slot(const char *slot_name, const int slot_index)
+{
+	struct device_node	*dn;
+
+	for(dn = find_all_nodes(); dn; dn = dn->next) {
+
+		int 		*index;
+		unsigned char	*loc_code;
+
+		index  = (int *)get_property(dn, "ibm,my-drc-index", NULL);
+
+		if (index && *index == slot_index) {
+			char *slash, *tmp_str;
+
+			loc_code = get_property(dn, "ibm,loc-code", NULL);
+			if (!loc_code) { 
+				return -1;
+			}
+
+			tmp_str = kmalloc(MAX_LOC_CODE, GFP_KERNEL); 
+			if (!tmp_str) {
+				err("%s: out of memory\n", __FUNCTION__);
+				return -1;
+			}
+				
+			strcpy(tmp_str, loc_code);
+			slash = strrchr(tmp_str, '/');
+			if (slash) 
+				*slash = '\0';
+			
+			if (strcmp(slot_name, tmp_str)) {
+				kfree(tmp_str);
+				return -1;
+			}
+
+			kfree(tmp_str);
+			break;
+		}
+	}
+	
+	return 0;
+}
+
+/* Must be called before pci_bus_add_devices */
+static void rpaphp_fixup_new_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+	/*
+	 * Skip already-present devices (which are on the
+	 * global device list.)
+	 */
+		if (list_empty(&dev->global_list)) {
+			int i;
+			pcibios_fixup_device_resources(dev, bus);
+			pci_read_irq_line(dev);
+			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+				struct resource *r = &dev->resource[i];
+				if (r->parent || !r->start || !r->flags)
+					continue;
+				rpaphp_claim_resource(dev, i);
+			}
+		}
+	}
+}
+
+static struct pci_dev *rpaphp_config_adapter(struct slot *slot)
+{
+	struct pci_bus 		*pci_bus;
+	struct device_node	*dn;
+	int 			num;
+	struct pci_dev		*dev = NULL;
+
+	if (slot->bridge) {
+
+		pci_bus = slot->bridge->subordinate;
+
+		if (!pci_bus) {
+			err("%s: can't find bus structure\n", __FUNCTION__);
+			goto exit;
+		}
+
+		for (dn = slot->dn->child; dn; dn = dn->sibling) {
+			dbg("child dn's devfn=[%x]\n", dn->devfn);
+				num = pci_scan_slot(pci_bus,
+				PCI_DEVFN(PCI_SLOT(dn->devfn),  0));
+
+				dbg("pci_scan_slot return num=%d\n", num);
+
+			if (num) {
+				rpaphp_fixup_new_devices(pci_bus);
+				pci_bus_add_devices(pci_bus);
+			}
+		}
+
+		dev = rpaphp_find_pci_dev(slot->dn->child);
+	}
+	else {
+		/* slot is not enabled */
+		err("slot doesn't have pci_dev structure\n");
+		dev = NULL;
+		goto exit;
+	}
+
+exit:
+	dbg("Exit %s: pci_dev %s\n", __FUNCTION__, dev? "found":"not found");
+
+	return dev;
+}
+
+static int rpaphp_unconfig_adapter(struct slot *slot)
+{
+	if (!slot->dev) {
+		info("%s: no card in slot[%s]\n",
+			__FUNCTION__, slot->name);
+
+		return -EINVAL;
+	}
+
+	/* remove the device from the pci core */
+	pci_remove_bus_device(slot->dev);
+
+	pci_dev_put(slot->dev);
+	slot->state = NOT_CONFIGURED;
+
+	dbg("%s: adapter in slot[%s] unconfigured.\n", __FUNCTION__, slot->name);
+
+	return 0;
+}
+
+/* free up the memory user be a slot */
+
+static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return;
+
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	pci_dev_put(slot->bridge);
+	pci_dev_put(slot->dev);
+	kfree(slot);
+}
+
+int rpaphp_remove_slot(struct slot *slot)
+{
+	int retval = 0;
+
+  	sysfs_remove_link(slot->hotplug_slot->kobj.parent,
+			slot->bridge->slot_name);
+
+	list_del(&slot->rpaphp_slot_list);
+	retval = pci_hp_deregister(slot->hotplug_slot);
+	if (retval)
+		err("Problem unregistering a slot %s\n", slot->name);
+	num_slots--;
+
+	return retval;
+}
+
+static int is_php_dn(struct device_node *dn, int **indexes,  int **names, int **types, int **power_domains)
+{
+	*indexes = (int *)get_property(dn, "ibm,drc-indexes", NULL);
+	if (!*indexes)
+		return(0);
+
+	/* &names[1] contains NULL terminated slot names */
+	*names = (int *)get_property(dn, "ibm,drc-names", NULL);
+	if (!*names)
+		return(0);
+
+	/* &types[1] contains NULL terminated slot types */
+	*types = (int *)get_property(dn, "ibm,drc-types", NULL);
+	if (!*types)
+		return(0);
+
+	/* power_domains[1...n] are the slot power domains */
+	*power_domains = (int *)get_property(dn,
+		"ibm,drc-power-domains", NULL);
+	if (!*power_domains)
+		return(0);
+
+	if (!get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL))
+		return(0);
+
+	return(1);
+}
+
+static struct slot *alloc_slot_struct(void)
+{
+	struct slot *slot;
+
+	slot = kmalloc(sizeof(struct slot), GFP_KERNEL);
+	if (!slot)
+		return (NULL);
+	memset(slot, 0, sizeof(struct slot));
+	slot->hotplug_slot = kmalloc(sizeof(struct hotplug_slot),
+		GFP_KERNEL);
+	if (!slot->hotplug_slot) {
+		kfree(slot);
+		return (NULL);
+	}
+	memset(slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
+	slot->hotplug_slot->info = kmalloc(sizeof(struct hotplug_slot_info),
+		GFP_KERNEL);
+	if (!slot->hotplug_slot->info) {
+		kfree(slot->hotplug_slot);
+		kfree(slot);
+		return (NULL);
+	}
+	memset(slot->hotplug_slot->info, 0, sizeof(struct hotplug_slot_info));
+	slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
+	if (!slot->hotplug_slot->name) {
+		kfree(slot->hotplug_slot->info);
+		kfree(slot->hotplug_slot);
+		kfree(slot);
+		return (NULL);
+	}
+	return (slot);
+}
+
+static int setup_hotplug_slot_info(struct slot *slot)
+{
+	rpaphp_get_power_status(slot,
+		&slot->hotplug_slot->info->power_status);
+
+	rpaphp_get_adapter_status(slot, 1,
+		&slot->hotplug_slot->info->adapter_status);
+
+	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
+		dbg("%s: NOT_VALID: skip dn->full_name=%s\n",
+			__FUNCTION__, slot->dn->full_name);
+		    kfree(slot->hotplug_slot->info);
+		    kfree(slot->hotplug_slot->name);
+		    kfree(slot->hotplug_slot);
+		    kfree(slot);
+		return (-1);
+	}
+	return (0);
+}
+
+static int register_slot(struct slot *slot)
+{
+	int retval;
+
+	retval = pci_hp_register(slot->hotplug_slot);
+	if (retval) {
+		err("pci_hp_register failed with error %d\n", retval);
+		rpaphp_release_slot(slot->hotplug_slot);
+		return (retval);
+	}
+	/* create symlink between slot->name and it's bus_id */
+	dbg("%s: sysfs_create_link: %s --> %s\n", __FUNCTION__,
+		slot->bridge->slot_name, slot->name);
+	retval = sysfs_create_link(slot->hotplug_slot->kobj.parent,
+			&slot->hotplug_slot->kobj,
+			slot->bridge->slot_name);
+	if (retval) {
+		err("sysfs_create_link failed with error %d\n", retval);
+		rpaphp_release_slot(slot->hotplug_slot);
+		return (retval);
+	}
+	/* add slot to our internal list */
+	dbg("%s adding slot[%s] to rpaphp_slot_list\n",
+		__FUNCTION__, slot->name);
+
+	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
+
+	info("Slot [%s] (bus_id=%s) registered\n",
+		slot->name, slot->bridge->slot_name);
+	return (0);
+}
+
+/*************************************
+ * Add  Hot Plug slot(s) to sysfs
+ *
+ ************************************/
+int rpaphp_add_slot(char *slot_name)
+{
+	struct slot		*slot;
+	int 			retval = 0;
+	int 			i;
+	struct device_node 	*dn;
+	int 			*indexes, *names, *types, *power_domains;
+	char 			*name, *type;
+
+	for (dn = find_all_nodes(); dn; dn = dn->next) {
+
+		if (dn->name != 0 && strcmp(dn->name, "pci") == 0)	{
+			if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
+				continue;
+
+			dbg("%s : found device_node in OFDT full_name=%s, name=%s\n",
+				__FUNCTION__, dn->full_name, dn->name);
+
+			name = (char *)&names[1];
+			type = (char *)&types[1];
+
+			for (i = 0; i < indexes[0];
+				i++,
+				name += (strlen(name) + 1),
+				type += (strlen(type) + 1)) {
+
+				dbg("%s: name[%s] index[%x]\n",
+					__FUNCTION__, name, indexes[i+1]);
+
+				if (slot_name && strcmp(slot_name, name))
+					continue;
+
+				if (rpaphp_validate_slot(name, indexes[i + 1])) {
+					dbg("%s: slot(%s, 0x%x) is invalid.\n",
+						__FUNCTION__, name, indexes[i+ 1]);
+					continue;
+				}
+
+				slot = alloc_slot_struct();
+				if (!slot) {
+					retval = -ENOMEM;
+					goto exit;
+				}
+
+				slot->name = slot->hotplug_slot->name;
+				slot->index = indexes[i + 1];
+				strcpy(slot->name, name);
+				slot->type = simple_strtoul(type, NULL, 10);
+				if (slot->type < 1  || slot->type > 16)
+					slot->type = 0;
+
+				slot->power_domain = power_domains[i + 1];
+				slot->magic = SLOT_MAGIC;
+				slot->hotplug_slot->private = slot;
+				slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
+				slot->hotplug_slot->release = &rpaphp_release_slot;
+				slot->dn = dn;
+
+				/*
+			 	* Initilize the slot info structure with some known
+			 	* good values.
+			 	*/
+				if (setup_hotplug_slot_info(slot))
+					continue;
+
+				slot->bridge = rpaphp_find_bridge_pdev(slot);
+				if (!slot->bridge && slot_name) { /* slot being added doesn't have pci_dev yet*/
+					dbg("%s: no pci_dev for bridge dn %s\n",
+							__FUNCTION__, slot_name);
+					kfree(slot->hotplug_slot->info);
+					kfree(slot->hotplug_slot->name);
+					kfree(slot->hotplug_slot);
+					kfree(slot);
+					continue;
+				}
+
+				/* find slot's pci_dev if it's not empty*/
+				if (slot->hotplug_slot->info->adapter_status == EMPTY) {
+					slot->state = EMPTY;  /* slot is empty */
+					slot->dev = NULL;
+				}
+				else {  /* slot is occupied */
+					if(!(slot->dn->child)) { /* non-empty slot has to have child */
+						err("%s: slot[%s]'s device_node doesn't have child for adapter\n",
+						__FUNCTION__, slot->name);
+						kfree(slot->hotplug_slot->info);
+						kfree(slot->hotplug_slot->name);
+						kfree(slot->hotplug_slot);
+						kfree(slot);
+						continue;
+
+					}
+
+					slot->dev = rpaphp_find_adapter_pdev(slot);
+					if(slot->dev) {
+						slot->state = CONFIGURED;
+						pci_dev_get(slot->dev);
+					}
+					else {
+						/* DLPAR add as opposed to
+						 * boot time */
+						slot->state = NOT_CONFIGURED;
+					}
+				}
+				dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
+					__FUNCTION__, dn->full_name, slot->index, slot->name,
+					slot->power_domain, slot->type);
+
+				retval = register_slot(slot);
+				if (retval)
+					goto exit;
+
+				num_slots++;
+
+				if (slot_name)
+					goto exit;
+
+			}/* for indexes */
+		}/* "pci" */
+	}/* find_all_nodes */
+exit:
+	dbg("%s - Exit: num_slots=%d rc[%d]\n",
+		__FUNCTION__, num_slots, retval);
+	return retval;
+}
+
+/*
+ * init_slots - initialize 'struct slot' structures for each slot
+ *
+ */
+static int init_slots (void)
+{
+	int 			retval = 0;
+
+	retval = rpaphp_add_slot(NULL);
+
+	return retval;
+}
+
+
+static int init_rpa (void)
+{
+	int 			retval = 0;
+
+	init_MUTEX(&rpaphp_sem);
+
+	/* initialize internal data structure etc. */
+	retval = init_slots();
+	if (!num_slots)
+		retval = -ENODEV;
+
+	return retval;
+}
+
+static void cleanup_slots (void)
+{
+	struct list_head *tmp, *n;
+	struct slot *slot;
+
+	/*
+	 * Unregister all of our slots with the pci_hotplug subsystem,
+	 * and free up all memory that we had allocated.
+	 * memory will be freed in release_slot callback.
+	 */
+
+	list_for_each_safe (tmp, n, &rpaphp_slot_head) {
+		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+		sysfs_remove_link(slot->hotplug_slot->kobj.parent,
+			slot->bridge->slot_name);
+		list_del(&slot->rpaphp_slot_list);
+		pci_hp_deregister(slot->hotplug_slot);
+	}
+
+	return;
+}
+
+
+static int __init rpaphp_init(void)
+{
+	int retval = 0;
+
+	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	rpaphp_debug = debug;
+
+	/* read all the PRA info from the system */
+	retval = init_rpa();
+
+	return retval;
+}
+
+
+static void __exit rpaphp_exit(void)
+{
+	cleanup_slots();
+}
+
+
+static int enable_slot(struct hotplug_slot *hotplug_slot)
+{
+	int retval = 0, state;
+
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	if (slot->state == CONFIGURED) {
+		dbg("%s: %s is already enabled\n",
+			__FUNCTION__, slot->name);
+		goto exit;
+	}
+
+	dbg("ENABLING SLOT %s\n", slot->name);
+
+	down(&rpaphp_sem);
+
+	retval = rpaphp_get_sensor_state(slot->index, &state);
+
+	if (retval)
+		goto exit;
+
+	dbg("%s: sensor state[%d]\n", __FUNCTION__, state);
+
+	/* if slot is not empty, enable the adapter */
+	if (state == PRESENT) {
+		dbg("%s : slot[%s] is occupid.\n", __FUNCTION__, slot->name);
+
+		
+		slot->dev = rpaphp_config_adapter(slot);
+		if (slot->dev != NULL) {
+			slot->state = CONFIGURED;
+
+			dbg("%s: adapter %s in slot[%s] has been configured\n",
+				__FUNCTION__, slot->dev->slot_name,
+				slot->name);
+		}
+		else {
+			slot->state = NOT_CONFIGURED;
+
+			dbg("%s: no pci_dev struct for adapter in slot[%s]\n",
+				__FUNCTION__, slot->name);
+		}
+
+	}
+	else if (state == EMPTY) {
+		dbg("%s : slot[%s] is empty\n", __FUNCTION__, slot->name);
+		slot->state = EMPTY;
+	}
+	else {
+		err("%s: slot[%s] is in invalid state\n", __FUNCTION__, slot->name);
+		slot->state = NOT_VALID;
+		retval = -EINVAL;
+	}
+
+exit:
+	if (slot->state != NOT_VALID)
+		rpaphp_set_attention_status(slot, LED_ON);
+	else
+		rpaphp_set_attention_status(slot, LED_ID);
+
+	up(&rpaphp_sem);
+
+	return retval;
+}
+
+static int disable_slot(struct hotplug_slot *hotplug_slot)
+{
+	int	retval;
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	dbg("DISABLING SLOT %s\n", slot->name);
+
+	down(&rpaphp_sem);
+
+	rpaphp_set_attention_status(slot, LED_ID);
+
+	retval = rpaphp_unconfig_adapter(slot);
+
+	rpaphp_set_attention_status(slot, LED_OFF);
+
+	up(&rpaphp_sem);
+
+	return retval;
+}
+
+module_init(rpaphp_init);
+module_exit(rpaphp_exit);
+
+EXPORT_SYMBOL_GPL(rpaphp_add_slot);
+EXPORT_SYMBOL_GPL(rpaphp_remove_slot);
diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpaphp_pci.c	Mon Feb 16 12:12:05 2004
@@ -0,0 +1,75 @@
+/*
+ * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
+ * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
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
+ * Send feedback to <lxie@us.ibm.com>
+ *
+ */
+#include <linux/pci.h>
+#include <asm/pci-bridge.h>	/* for pci_controller */
+#include "rpaphp.h"
+
+
+struct pci_dev *rpaphp_find_pci_dev(struct device_node *dn)
+{
+	struct pci_dev		*retval_dev = NULL, *dev = NULL;
+
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		if(!dev->bus)
+			continue;
+
+		if (dev->devfn != dn->devfn)
+			continue;
+
+		if (dn->phb->global_number == pci_domain_nr(dev->bus) &&
+		    dn->busno == dev->bus->number) {
+			retval_dev = dev;
+			break;
+		}
+	}
+
+	return retval_dev;
+
+}
+
+int rpaphp_claim_resource(struct pci_dev *dev, int resource)
+{
+	struct resource *res = &dev->resource[resource];
+	struct resource *root = pci_find_parent_resource(dev, res);
+	char *dtype = resource < PCI_BRIDGE_RESOURCES ? "device" : "bridge";
+	int err;
+
+	err = -EINVAL;
+	if (root != NULL) {
+		err = request_resource(root, res);
+	}
+
+	if (err) {
+		err("PCI: %s region %d of %s %s [%lx:%lx]\n",
+			root ? "Address space collision on" :
+			"No parent found for",
+			resource, dtype, pci_name(dev), res->start, res->end);
+	}
+
+	return err;
+}
+
+EXPORT_SYMBOL_GPL(rpaphp_find_pci_dev);
+EXPORT_SYMBOL_GPL(rpaphp_claim_resource);


