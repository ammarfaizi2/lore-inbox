Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJIWlW>; Wed, 9 Oct 2002 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSJIWlW>; Wed, 9 Oct 2002 18:41:22 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:1036 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262443AbSJIWjE>;
	Wed, 9 Oct 2002 18:39:04 -0400
Date: Wed, 9 Oct 2002 15:40:42 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.41
Message-ID: <20021009224041.GE18646@kroah.com>
References: <20021009223848.GB18646@kroah.com> <20021009223945.GC18646@kroah.com> <20021009224015.GD18646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009224015.GD18646@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.742   -> 1.743  
#	drivers/hotplug/Makefile	1.5     -> 1.6    
#	drivers/hotplug/Config.in	1.3     -> 1.4    
#	drivers/hotplug/Config.help	1.2     -> 1.3    
#	               (new)	        -> 1.1     drivers/hotplug/acpiphp_pci.c
#	               (new)	        -> 1.1     drivers/hotplug/acpiphp_glue.c
#	               (new)	        -> 1.1     drivers/hotplug/acpiphp_res.c
#	               (new)	        -> 1.1     drivers/hotplug/acpiphp_core.c
#	               (new)	        -> 1.1     drivers/hotplug/acpiphp.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/09	t-kouchi@mvf.biglobe.ne.jp	1.743
# [PATCH] ACPI PCI hotplug driver for 2.5
# 
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/Config.help b/drivers/hotplug/Config.help
--- a/drivers/hotplug/Config.help	Wed Oct  9 15:37:29 2002
+++ b/drivers/hotplug/Config.help	Wed Oct  9 15:37:29 2002
@@ -40,3 +40,14 @@
 
   When in doubt, say N.
 
+CONFIG_HOTPLUG_PCI_ACPI
+  Say Y here if you have a system that supports PCI Hotplug using
+  ACPI.
+
+  This code is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called acpiphp.o. If you want to compile it
+  as a module, say M here and read <file:Documentation/modules.txt>.
+
+  When in doubt, say N.
+
diff -Nru a/drivers/hotplug/Config.in b/drivers/hotplug/Config.in
--- a/drivers/hotplug/Config.in	Wed Oct  9 15:37:29 2002
+++ b/drivers/hotplug/Config.in	Wed Oct  9 15:37:29 2002
@@ -11,5 +11,6 @@
 if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
    dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
 fi
+dep_tristate '  ACPI PCI Hotplug driver' CONFIG_HOTPLUG_PCI_ACPI $CONFIG_APCI $CONFIG_HOTPLUG_PCI
 
 endmenu
diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Wed Oct  9 15:37:29 2002
+++ b/drivers/hotplug/Makefile	Wed Oct  9 15:37:29 2002
@@ -7,6 +7,7 @@
 obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
 obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
+obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o	\
 				pci_hotplug_util.o
@@ -21,6 +22,18 @@
 				ibmphp_pci.o	\
 				ibmphp_res.o	\
 				ibmphp_hpc.o
+
+acpiphp-objs		:=	acpiphp_core.o	\
+				acpiphp_glue.o	\
+				acpiphp_pci.o	\
+				acpiphp_res.o
+
+ifdef CONFIG_HOTPLUG_PCI_ACPI
+  EXTRA_CFLAGS  += -D_LINUX -I$(TOPDIR)/drivers/acpi
+  ifdef CONFIG_ACPI_DEBUG
+    EXTRA_CFLAGS += -DACPI_DEBUG_OUTPUT
+  endif
+endif
 
 ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM),y)
 	cpqphp-objs += cpqphp_nvram.o
diff -Nru a/drivers/hotplug/acpiphp.h b/drivers/hotplug/acpiphp.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/acpiphp.h	Wed Oct  9 15:37:29 2002
@@ -0,0 +1,263 @@
+/*
+ * ACPI PCI Hot Plug Controller Driver
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM Corp.
+ * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (c) 2002 Takayoshi Kochi (t-kouchi@cq.jp.nec.com)
+ * Copyright (c) 2002 NEC Corporation
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
+ * Send feedback to <gregkh@us.ibm.com>,
+ *		    <h-aono@ap.jp.nec.com>,
+ *		    <t-kouchi@cq.jp.nec.com>
+ *
+ */
+
+#ifndef _ACPIPHP_H
+#define _ACPIPHP_H
+
+#include "include/acpi.h"
+#include "pci_hotplug.h"
+#include "acpi_bus.h"
+
+#define dbg(format, arg...)					\
+	do {							\
+		if (acpiphp_debug)				\
+			printk (KERN_DEBUG "%s: " format "\n",	\
+				MY_NAME , ## arg); 		\
+	} while (0)
+#define err(format, arg...) printk (KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
+#define info(format, arg...) printk (KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
+#define warn(format, arg...) printk (KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+
+#define SLOT_MAGIC	0x67267322
+/* name size which is used for entries in pcihpfs */
+#define SLOT_NAME_SIZE	32		/* ACPI{_SUN}-{BUS}:{DEV} */
+
+struct acpiphp_bridge;
+struct acpiphp_slot;
+struct pci_resource;
+
+/*
+ * struct slot - slot information for each *physical* slot
+ */
+struct slot {
+	u32 magic;
+	u8 number;
+	struct hotplug_slot	*hotplug_slot;
+	struct list_head	slot_list;
+
+	struct acpiphp_slot	*acpi_slot;
+};
+
+/*
+ * struct pci_resource - describes pci resource (mem, pfmem, io, bus)
+ */
+struct pci_resource {
+	struct pci_resource * next;
+	u64 base;
+	u32 length;
+};
+
+/**
+ * struct hpp_param - ACPI 2.0 _HPP Hot Plug Parameters
+ * @cache_line_size in DWORD
+ * @latency_timer in PCI clock
+ * @enable_SERR 0 or 1
+ * @enable_PERR 0 or 1
+ */
+struct hpp_param {
+	u8 cache_line_size;
+	u8 latency_timer;
+	u8 enable_SERR;
+	u8 enable_PERR;
+};
+
+
+/**
+ * struct acpiphp_bridge - PCI bridge information
+ *
+ * for each bridge device in ACPI namespace
+ */
+struct acpiphp_bridge {
+	struct list_head list;
+	acpi_handle handle;
+	struct acpiphp_slot *slots;
+	int type;
+	int nr_slots;
+
+	u8 seg;
+	u8 bus;
+	u8 sub;
+
+	u32 flags;
+
+	/* This bus (host bridge) or Secondary bus (PCI-to-PCI bridge) */
+	struct pci_bus *pci_bus;
+
+	/* PCI-to-PCI bridge device */
+	struct pci_dev *pci_dev;
+
+	/* ACPI 2.0 _HPP parameters */
+	struct hpp_param hpp;
+
+	spinlock_t res_lock;
+
+	/* available resources on this bus */
+	struct pci_resource *mem_head;
+	struct pci_resource *p_mem_head;
+	struct pci_resource *io_head;
+	struct pci_resource *bus_head;
+};
+
+
+/**
+ * struct acpiphp_slot - PCI slot information
+ *
+ * PCI slot information for each *physical* PCI slot
+ */
+struct acpiphp_slot {
+	struct acpiphp_slot *next;
+	struct acpiphp_bridge *bridge;	/* parent */
+	struct list_head funcs;		/* one slot may have different
+					   objects (i.e. for each function) */
+	struct semaphore crit_sect;
+
+	u32		id;		/* slot id (serial #) for hotplug core */
+	u8		device;		/* pci device# */
+
+	u32		sun;		/* ACPI _SUN (slot unique number) */
+	u32		slotno;		/* slot number relative to bridge */
+	u32		flags;		/* see below */
+};
+
+
+/**
+ * struct acpiphp_func - PCI function information
+ *
+ * PCI function information for each object in ACPI namespace
+ * typically 8 objects per slot (i.e. for each PCI function)
+ */
+struct acpiphp_func {
+	struct acpiphp_slot *slot;	/* parent */
+
+	struct list_head sibling;
+	struct pci_dev *pci_dev;
+
+	acpi_handle	handle;
+
+	u8		function;	/* pci function# */
+	u32		flags;		/* see below */
+
+	/* resources used for this function */
+	struct pci_resource *mem_head;
+	struct pci_resource *p_mem_head;
+	struct pci_resource *io_head;
+	struct pci_resource *bus_head;
+};
+
+
+/* PCI bus bridge HID */
+#define ACPI_PCI_HOST_HID		"PNP0A03"
+
+/* PCI BRIDGE type */
+#define BRIDGE_TYPE_HOST		0
+#define BRIDGE_TYPE_P2P			1
+
+/* ACPI _STA method value (ignore bit 4; battery present) */
+#define ACPI_STA_PRESENT		(0x00000001)
+#define ACPI_STA_ENABLED		(0x00000002)
+#define ACPI_STA_SHOW_IN_UI		(0x00000004)
+#define ACPI_STA_FUNCTIONING		(0x00000008)
+#define ACPI_STA_ALL			(0x0000000f)
+
+/* bridge flags */
+#define BRIDGE_HAS_STA		(0x00000001)
+#define BRIDGE_HAS_EJ0		(0x00000002)
+#define BRIDGE_HAS_HPP		(0x00000004)
+#define BRIDGE_HAS_PS0		(0x00000010)
+#define BRIDGE_HAS_PS1		(0x00000020)
+#define BRIDGE_HAS_PS2		(0x00000040)
+#define BRIDGE_HAS_PS3		(0x00000080)
+
+/* slot flags */
+
+#define SLOT_POWEREDON		(0x00000001)
+#define SLOT_ENABLED		(0x00000002)
+#define SLOT_MULTIFUNCTION	(x000000004)
+
+/* function flags */
+
+#define FUNC_HAS_STA		(0x00000001)
+#define FUNC_HAS_EJ0		(0x00000002)
+#define FUNC_HAS_PS0		(0x00000010)
+#define FUNC_HAS_PS1		(0x00000020)
+#define FUNC_HAS_PS2		(0x00000040)
+#define FUNC_HAS_PS3		(0x00000080)
+
+/* not yet */
+#define SLOT_SUPPORT_66MHZ	(0x00010000)
+#define SLOT_SUPPORT_100MHZ	(0x00020000)
+#define SLOT_SUPPORT_133MHZ	(0x00040000)
+#define SLOT_SUPPORT_PCIX	(0x00080000)
+
+/* function prototypes */
+
+/* acpiphp_glue.c */
+extern int acpiphp_glue_init (void);
+extern void acpiphp_glue_exit (void);
+extern int acpiphp_get_num_slots (void);
+extern struct acpiphp_slot *get_slot_from_id (int id);
+typedef int (*acpiphp_callback)(struct acpiphp_slot *slot, void *data);
+extern int acpiphp_for_each_slot (acpiphp_callback fn, void *data);
+
+extern int acpiphp_check_bridge (struct acpiphp_bridge *bridge);
+extern int acpiphp_enable_slot (struct acpiphp_slot *slot);
+extern int acpiphp_disable_slot (struct acpiphp_slot *slot);
+extern u8 acpiphp_get_power_status (struct acpiphp_slot *slot);
+extern u8 acpiphp_get_attention_status (struct acpiphp_slot *slot);
+extern u8 acpiphp_get_latch_status (struct acpiphp_slot *slot);
+extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
+
+/* acpiphp_pci.c */
+extern struct pci_dev *acpiphp_allocate_pcidev (struct pci_bus *pbus, int dev, int fn);
+extern int acpiphp_configure_slot (struct acpiphp_slot *slot);
+extern int acpiphp_configure_function (struct acpiphp_func *func);
+extern int acpiphp_unconfigure_function (struct acpiphp_func *func);
+extern int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge);
+extern int acpiphp_init_func_resource (struct acpiphp_func *func);
+
+/* acpiphp_res.c */
+extern struct pci_resource *acpiphp_get_io_resource (struct pci_resource **head, u32 size);
+extern struct pci_resource *acpiphp_get_max_resource (struct pci_resource **head, u32 size);
+extern struct pci_resource *acpiphp_get_resource (struct pci_resource **head, u32 size);
+extern struct pci_resource *acpiphp_get_resource_with_base (struct pci_resource **head, u64 base, u32 size);
+extern int acpiphp_resource_sort_and_combine (struct pci_resource **head);
+extern struct pci_resource *acpiphp_make_resource (u64 base, u32 length);
+extern void acpiphp_move_resource (struct pci_resource **from, struct pci_resource **to);
+extern void acpiphp_free_resource (struct pci_resource **res);
+extern void acpiphp_dump_resource (struct acpiphp_bridge *bridge); /* debug */
+extern void acpiphp_dump_func_resource (struct acpiphp_func *func); /* debug */
+
+/* variables */
+extern int acpiphp_debug;
+
+#endif /* _ACPIPHP_H */
diff -Nru a/drivers/hotplug/acpiphp_core.c b/drivers/hotplug/acpiphp_core.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/acpiphp_core.c	Wed Oct  9 15:37:29 2002
@@ -0,0 +1,502 @@
+/*
+ * ACPI PCI Hot Plug Controller Driver
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM Corp.
+ * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (c) 2002 Takayoshi Kochi (t-kouchi@cq.jp.nec.com)
+ * Copyright (c) 2002 NEC Corporation
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
+ * Send feedback to <gregkh@us.ibm.com>,
+ *                  <h-aono@ap.jp.nec.com>,
+ *		    <t-kouchi@cq.jp.nec.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include "pci_hotplug.h"
+#include "acpiphp.h"
+
+static LIST_HEAD(slot_list);
+
+#if !defined(CONFIG_HOTPLUG_PCI_ACPI_MODULE)
+	#define MY_NAME	"acpiphp"
+#else
+	#define MY_NAME	THIS_MODULE->name
+#endif
+
+int acpiphp_debug;
+
+/* local variables */
+static int num_slots;
+
+#define DRIVER_VERSION	"0.4"
+#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kouchi@cq.jp.nec.com>"
+#define DRIVER_DESC	"ACPI Hot Plug PCI Controller Driver"
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_PARM(acpiphp_debug, "i");
+MODULE_PARM_DESC(acpiphp_debug, "Debugging mode enabled or not");
+
+static int enable_slot		(struct hotplug_slot *slot);
+static int disable_slot		(struct hotplug_slot *slot);
+static int set_attention_status (struct hotplug_slot *slot, u8 value);
+static int hardware_test	(struct hotplug_slot *slot, u32 value);
+static int get_power_status	(struct hotplug_slot *slot, u8 *value);
+static int get_attention_status	(struct hotplug_slot *slot, u8 *value);
+static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
+static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
+static int get_max_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
+static int get_cur_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
+
+static struct hotplug_slot_ops acpi_hotplug_slot_ops = {
+	.owner			= THIS_MODULE,
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+	.set_attention_status	= set_attention_status,
+	.hardware_test		= hardware_test,
+	.get_power_status	= get_power_status,
+	.get_attention_status	= get_attention_status,
+	.get_latch_status	= get_latch_status,
+	.get_adapter_status	= get_adapter_status,
+	.get_max_bus_speed	= get_max_bus_speed,
+	.get_cur_bus_speed	= get_cur_bus_speed,
+};
+
+
+/* Inline functions to check the sanity of a pointer that is passed to us */
+static inline int slot_paranoia_check (struct slot *slot, const char *function)
+{
+	if (!slot) {
+		dbg("%s - slot == NULL", function);
+		return -1;
+	}
+	if (slot->magic != SLOT_MAGIC) {
+		dbg("%s - bad magic number for slot", function);
+		return -1;
+	}
+	if (!slot->hotplug_slot) {
+		dbg("%s - slot->hotplug_slot == NULL!", function);
+		return -1;
+	}
+	return 0;
+}
+
+
+static inline struct slot *get_slot (struct hotplug_slot *hotplug_slot, const char *function)
+{ 
+	struct slot *slot;
+
+	if (!hotplug_slot) {
+		dbg("%s - hotplug_slot == NULL", function);
+		return NULL;
+	}
+
+	slot = (struct slot *)hotplug_slot->private;
+	if (slot_paranoia_check (slot, function))
+                return NULL;
+	return slot;
+}
+
+
+/**
+ * enable_slot - power on and enable a slot
+ * @hotplug_slot: slot to enable
+ *
+ * Actual tasks are done in acpiphp_enable_slot()
+ *
+ */
+static int enable_slot (struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	int retval = 0;
+	
+	if (slot == NULL)
+		return -ENODEV;
+
+	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	/* enable the specified slot */
+	retval = acpiphp_enable_slot (slot->acpi_slot);
+
+	return retval;
+}
+
+
+/**
+ * disable_slot - disable and power off a slot
+ * @hotplug_slot: slot to disable
+ *
+ * Actual tasks are done in acpiphp_disable_slot()
+ *
+ */
+static int disable_slot (struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	int retval = 0;
+
+	if (slot == NULL)
+		return -ENODEV;
+	
+	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	/* disable the specified slot */
+	retval = acpiphp_disable_slot (slot->acpi_slot);
+
+	return retval;
+}
+
+
+/**
+ * set_attention_status - set attention LED
+ *
+ * TBD:
+ * ACPI doesn't have known method to manipulate
+ * attention status LED.
+ *
+ */
+static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
+{
+	int retval = 0;
+	
+	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	switch (status) {
+		case 0:
+			/* FIXME turn light off */
+			hotplug_slot->info->attention_status = 0;
+			break;
+
+		case 1:
+		default:
+			/* FIXME turn light on */
+			hotplug_slot->info->attention_status = 1;
+			break;
+	}
+
+	return retval;
+}
+
+
+/**
+ * hardware_test - hardware test
+ *
+ * We have nothing to do for now...
+ *
+ */
+static int hardware_test (struct hotplug_slot *hotplug_slot, u32 value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	int retval = 0;
+	
+	if (slot == NULL)
+		return -ENODEV;
+	
+	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	err ("No hardware tests are defined for this driver");
+	retval = -ENODEV;
+
+	return retval;
+}
+
+
+/**
+ * get_power_status - get power status of a slot
+ * @hotplug_slot: slot to get status
+ * @value: pointer to store status
+ *
+ * Some platforms may not implement _STA method properly.
+ * In that case, the value returned may not be reliable.
+ *
+ */
+static int get_power_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	int retval = 0;
+	
+	if (slot == NULL)
+		return -ENODEV;
+	
+	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_power_status (slot->acpi_slot);
+
+	return retval;
+}
+
+
+/**
+ * get_attention_status - get attention LED status
+ *
+ * TBD:
+ * ACPI doesn't provide any formal means to access attention LED status.
+ *
+ */
+static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	int retval = 0;
+	
+	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	*value = hotplug_slot->info->attention_status;
+
+	return retval;
+}
+
+
+/**
+ * get_latch_status - get latch status of a slot
+ * @hotplug_slot: slot to get status
+ * @value: pointer to store status
+ *
+ * ACPI doesn't provide any formal means to access latch status.
+ * Instead, we fake latch status from _STA
+ *
+ */
+static int get_latch_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	int retval = 0;
+	
+	if (slot == NULL)
+		return -ENODEV;
+	
+	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_latch_status (slot->acpi_slot);
+
+	return retval;
+}
+
+
+/**
+ * get_adapter_status - get adapter status of a slot
+ * @hotplug_slot: slot to get status
+ * @value: pointer to store status
+ *
+ * ACPI doesn't provide any formal means to access adapter status.
+ * Instead, we fake adapter status from _STA
+ *
+ */
+static int get_adapter_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	int retval = 0;
+	
+	if (slot == NULL)
+		return -ENODEV;
+	
+	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_adapter_status (slot->acpi_slot);
+
+	return retval;
+}
+
+
+/* return dummy value because ACPI doesn't provide any method... */
+static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	
+	if (slot == NULL)
+		return -ENODEV;
+	
+	*value = PCI_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+
+/* return dummy value because ACPI doesn't provide any method... */
+static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	
+	if (slot == NULL)
+		return -ENODEV;
+	
+	*value = PCI_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+
+static int init_acpi (void)
+{
+	int retval;
+
+	/* initialize internal data structure etc. */
+	retval = acpiphp_glue_init();
+
+	/* read initial number of slots */
+	if (!retval) {
+		num_slots = acpiphp_get_num_slots();
+		if (num_slots == 0)
+			retval = -ENODEV;
+	}
+
+	return retval;
+}
+
+
+/**
+ * make_slot_name - make a slot name that appears in pcihpfs
+ * @slot: slot to name
+ *
+ */
+static void make_slot_name (struct slot *slot)
+{
+	snprintf (slot->hotplug_slot->name, SLOT_NAME_SIZE, "ACPI%d-%02x:%02x",
+		  slot->acpi_slot->sun,
+		  slot->acpi_slot->bridge->bus,
+		  slot->acpi_slot->device);
+}
+
+/**
+ * init_slots - initialize 'struct slot' structures for each slot
+ *
+ */
+static int init_slots (void)
+{
+	struct slot *slot;
+	int retval = 0;
+	int i;
+
+	for (i = 0; i < num_slots; ++i) {
+		slot = kmalloc (sizeof (struct slot), GFP_KERNEL);
+		if (!slot)
+			return -ENOMEM;
+		memset(slot, 0, sizeof(struct slot));
+
+		slot->hotplug_slot = kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
+		if (!slot->hotplug_slot) {
+			kfree (slot);
+			return -ENOMEM;
+		}
+		memset(slot->hotplug_slot, 0, sizeof (struct hotplug_slot));
+
+		slot->hotplug_slot->info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
+		if (!slot->hotplug_slot->info) {
+			kfree (slot->hotplug_slot);
+			kfree (slot);
+			return -ENOMEM;
+		}
+		memset(slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
+
+		slot->hotplug_slot->name = kmalloc (SLOT_NAME_SIZE, GFP_KERNEL);
+		if (!slot->hotplug_slot->name) {
+			kfree (slot->hotplug_slot->info);
+			kfree (slot->hotplug_slot);
+			kfree (slot);
+			return -ENOMEM;
+		}
+
+		slot->magic = SLOT_MAGIC;
+		slot->number = i;
+
+		slot->hotplug_slot->private = slot;
+		slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
+
+		slot->acpi_slot = get_slot_from_id (i);
+		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
+		slot->hotplug_slot->info->attention_status = acpiphp_get_attention_status(slot->acpi_slot);
+		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
+		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
+
+		make_slot_name (slot);
+
+		retval = pci_hp_register (slot->hotplug_slot);
+		if (retval) {
+			err ("pci_hp_register failed with error %d", retval);
+			kfree (slot->hotplug_slot->info);
+			kfree (slot->hotplug_slot->name);
+			kfree (slot->hotplug_slot);
+			kfree (slot);
+			return retval;
+		}
+
+		/* add slot to our internal list */
+		list_add (&slot->slot_list, &slot_list);
+		info("Slot [%s] registered", slot->hotplug_slot->name);
+	}
+
+	return retval;
+}
+
+
+static void cleanup_slots (void)
+{
+	struct list_head *tmp, *n;
+	struct slot *slot;
+
+	list_for_each_safe (tmp, n, &slot_list) {
+		slot = list_entry (tmp, struct slot, slot_list);
+		list_del (&slot->slot_list);
+		pci_hp_deregister (slot->hotplug_slot);
+		kfree (slot->hotplug_slot->info);
+		kfree (slot->hotplug_slot->name);
+		kfree (slot->hotplug_slot);
+		kfree (slot);
+	}
+
+	return;
+}
+
+
+static int __init acpiphp_init(void)
+{
+	int retval;
+
+	info (DRIVER_DESC " version: " DRIVER_VERSION);
+
+	/* read all the ACPI info from the system */
+	retval = init_acpi();
+	if (retval)
+		return retval;
+
+	retval = init_slots();
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+
+static void __exit acpiphp_exit(void)
+{
+	cleanup_slots();
+	/* deallocate internal data structures etc. */
+	acpiphp_glue_exit();
+}
+
+module_init(acpiphp_init);
+module_exit(acpiphp_exit);
diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/acpiphp_glue.c	Wed Oct  9 15:37:29 2002
@@ -0,0 +1,1463 @@
+/*
+ * ACPI PCI HotPlug glue functions to ACPI CA subsystem
+ *
+ * Copyright (c) 2002 Takayoshi Kochi (t-kouchi@cq.jp.nec.com)
+ * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (c) 2002 NEC Corporation
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
+ * Send feedback to <t-kouchi@cq.jp.nec.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <asm/semaphore.h>
+
+#include "pci_hotplug.h"
+#include "acpiphp.h"
+
+static LIST_HEAD(bridge_list);
+
+#define MY_NAME "acpiphp_glue"
+
+static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
+static void handle_hotplug_event_func (acpi_handle, u32, void *);
+
+/*
+ * initialization & terminatation routines
+ */
+
+/**
+ * is_ejectable - determine if a slot is ejectable
+ * @handle: handle to acpi namespace
+ *
+ * Ejectable slot should satisfy at least these conditions:
+ *
+ *  1. has _ADR method
+ *  2. has _EJ0 method
+ *
+ * optionally
+ *
+ *  1. has _STA method
+ *  2. has _PS0 method
+ *  3. has _PS3 method
+ *  4. ..
+ *
+ */
+static int is_ejectable (acpi_handle handle)
+{
+	acpi_status status;
+	acpi_handle tmp;
+
+	status = acpi_get_handle(handle, "_ADR", &tmp);
+	if (ACPI_FAILURE(status)) {
+		return 0;
+	}
+
+	status = acpi_get_handle(handle, "_EJ0", &tmp);
+	if (ACPI_FAILURE(status)) {
+		return 0;
+	}
+
+	return 1;
+}
+
+
+/* callback routine to check the existence of ejectable slots */
+static acpi_status
+is_ejectable_slot (acpi_handle handle, u32 lvl,	void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	if (is_ejectable(handle)) {
+		(*count)++;
+		/* only one ejectable slot is enough */
+		return AE_CTRL_TERMINATE;
+	} else {
+		return AE_OK;
+	}
+}
+
+
+/* callback routine to register each ACPI PCI slot object */
+static acpi_status
+register_slot (acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *)context;
+	struct acpiphp_slot *slot;
+	struct acpiphp_func *newfunc;
+	acpi_handle tmp;
+	acpi_status status = AE_OK;
+	unsigned long adr, sun;
+	int device, function;
+	static int num_slots = 0;	/* XXX if we support I/O node hotplug... */
+
+	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
+
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	status = acpi_get_handle(handle, "_EJ0", &tmp);
+
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	device = (adr >> 16) & 0xffff;
+	function = adr & 0xffff;
+
+	newfunc = kmalloc(sizeof(struct acpiphp_func), GFP_KERNEL);
+	if (!newfunc)
+		return AE_NO_MEMORY;
+	memset(newfunc, 0, sizeof(struct acpiphp_func));
+
+	INIT_LIST_HEAD(&newfunc->sibling);
+	newfunc->handle = handle;
+	newfunc->function = function;
+	newfunc->flags = FUNC_HAS_EJ0;
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_STA", &tmp)))
+		newfunc->flags |= FUNC_HAS_STA;
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_PS0", &tmp)))
+		newfunc->flags |= FUNC_HAS_PS0;
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_PS3", &tmp)))
+		newfunc->flags |= FUNC_HAS_PS3;
+
+	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
+	if (ACPI_FAILURE(status))
+		sun = -1;
+
+	/* search for objects that share the same slot */
+	for (slot = bridge->slots; slot; slot = slot->next)
+		if (slot->device == device) {
+			if (slot->sun != sun)
+				warn("sibling found, but _SUN doesn't match!");
+			break;
+		}
+
+	if (!slot) {
+		slot = kmalloc(sizeof(struct acpiphp_slot), GFP_KERNEL);
+		if (!slot) {
+			kfree(newfunc);
+			return AE_NO_MEMORY;
+		}
+
+		memset(slot, 0, sizeof(struct acpiphp_slot));
+		slot->bridge = bridge;
+		slot->id = num_slots++;
+		slot->device = device;
+		slot->sun = sun;
+		INIT_LIST_HEAD(&slot->funcs);
+		init_MUTEX(&slot->crit_sect);
+
+		slot->next = bridge->slots;
+		bridge->slots = slot;
+
+		bridge->nr_slots++;
+
+		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:0x%x",
+		    slot->bridge->bus, slot->device, slot->sun);
+	}
+
+	newfunc->slot = slot;
+	list_add_tail(&newfunc->sibling, &slot->funcs);
+
+	/* associate corresponding pci_dev */
+	newfunc->pci_dev = pci_find_slot(bridge->bus,
+					 PCI_DEVFN(device, function));
+	if (newfunc->pci_dev) {
+		if (acpiphp_init_func_resource(newfunc) < 0) {
+			kfree(newfunc);
+			return AE_ERROR;
+		}
+		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
+	}
+
+	/* install notify handler */
+	status = acpi_install_notify_handler(handle,
+					     ACPI_SYSTEM_NOTIFY,
+					     handle_hotplug_event_func,
+					     newfunc);
+
+	if (ACPI_FAILURE(status)) {
+		err("failed to register interrupt notify handler");
+		return status;
+	}
+
+	return AE_OK;
+}
+
+
+/* see if it's worth looking at this bridge */
+static int detect_ejectable_slots (acpi_handle *bridge_handle)
+{
+	acpi_status status;
+	int count;
+
+	count = 0;
+
+	/* only check slots defined directly below bridge object */
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle, (u32)1,
+				     is_ejectable_slot, (void *)&count, NULL);
+
+	return count;
+}
+
+
+/* decode ACPI _CRS data and convert into our internal resource list
+ * TBD: _TRA, etc.
+ */
+static void
+decode_acpi_resource (acpi_resource *resource, struct acpiphp_bridge *bridge)
+{
+	acpi_resource_address16 *address16_data;
+	acpi_resource_address32 *address32_data;
+	acpi_resource_address64 *address64_data;
+	struct pci_resource *res;
+
+	u32 resource_type, producer_consumer, address_length;
+	u64 min_address_range, max_address_range;
+	u16 cache_attribute = 0;
+
+	int done = 0, found;
+
+	/* shut up gcc */
+	resource_type = producer_consumer = address_length = 0;
+	min_address_range = max_address_range = 0;
+
+	while (!done) {
+		found = 0;
+
+		switch (resource->id) {
+		case ACPI_RSTYPE_ADDRESS16:
+			address16_data = (acpi_resource_address16 *)&resource->data;
+			resource_type = address16_data->resource_type;
+			producer_consumer = address16_data->producer_consumer;
+			min_address_range = address16_data->min_address_range;
+			max_address_range = address16_data->max_address_range;
+			address_length = address16_data->address_length;
+			if (resource_type == ACPI_MEMORY_RANGE)
+				cache_attribute = address16_data->attribute.memory.cache_attribute;
+			found = 1;
+			break;
+
+		case ACPI_RSTYPE_ADDRESS32:
+			address32_data = (acpi_resource_address32 *)&resource->data;
+			resource_type = address32_data->resource_type;
+			producer_consumer = address32_data->producer_consumer;
+			min_address_range = address32_data->min_address_range;
+			max_address_range = address32_data->max_address_range;
+			address_length = address32_data->address_length;
+			if (resource_type == ACPI_MEMORY_RANGE)
+				cache_attribute = address32_data->attribute.memory.cache_attribute;
+			found = 1;
+			break;
+
+		case ACPI_RSTYPE_ADDRESS64:
+			address64_data = (acpi_resource_address64 *)&resource->data;
+			resource_type = address64_data->resource_type;
+			producer_consumer = address64_data->producer_consumer;
+			min_address_range = address64_data->min_address_range;
+			max_address_range = address64_data->max_address_range;
+			address_length = address64_data->address_length;
+			if (resource_type == ACPI_MEMORY_RANGE)
+				cache_attribute = address64_data->attribute.memory.cache_attribute;
+			found = 1;
+			break;
+
+		case ACPI_RSTYPE_END_TAG:
+			done = 1;
+			break;
+
+		default:
+			/* ignore */
+			break;
+		}
+
+		resource = (acpi_resource *)((char*)resource + resource->length);
+
+		if (found && producer_consumer == ACPI_PRODUCER && address_length > 0) {
+			switch (resource_type) {
+			case ACPI_MEMORY_RANGE:
+				if (cache_attribute == ACPI_PREFETCHABLE_MEMORY) {
+					dbg("resource type: prefetchable memory 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+					res = acpiphp_make_resource(min_address_range,
+							    address_length);
+					if (!res) {
+						err("out of memory");
+						return;
+					}
+					res->next = bridge->p_mem_head;
+					bridge->p_mem_head = res;
+				} else {
+					dbg("resource type: memory 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+					res = acpiphp_make_resource(min_address_range,
+							    address_length);
+					if (!res) {
+						err("out of memory");
+						return;
+					}
+					res->next = bridge->mem_head;
+					bridge->mem_head = res;
+				}
+				break;
+			case ACPI_IO_RANGE:
+				dbg("resource type: io 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+				res = acpiphp_make_resource(min_address_range,
+						    address_length);
+				if (!res) {
+					err("out of memory");
+					return;
+				}
+				res->next = bridge->io_head;
+				bridge->io_head = res;
+				break;
+			case ACPI_BUS_NUMBER_RANGE:
+				dbg("resource type: bus number %d - %d", (u32)min_address_range, (u32)max_address_range);
+				res = acpiphp_make_resource(min_address_range,
+						    address_length);
+				if (!res) {
+					err("out of memory");
+					return;
+				}
+				res->next = bridge->bus_head;
+				bridge->bus_head = res;
+				break;
+			default:
+				/* invalid type */
+				break;
+			}
+		}
+	}
+
+	acpiphp_resource_sort_and_combine(&bridge->io_head);
+	acpiphp_resource_sort_and_combine(&bridge->mem_head);
+	acpiphp_resource_sort_and_combine(&bridge->p_mem_head);
+	acpiphp_resource_sort_and_combine(&bridge->bus_head);
+#if 1
+	info("ACPI _CRS resource:");
+	acpiphp_dump_resource(bridge);
+#endif
+}
+
+
+/* find pci_bus structure associated to specific bus number */
+static struct pci_bus *find_pci_bus(const struct list_head *list, int bus)
+{
+	const struct list_head *l;
+
+	list_for_each(l, list) {
+		struct pci_bus *b = pci_bus_b(l);
+		if (b->number == bus)
+			return b;
+
+		if (!list_empty(&b->children)) {
+			/* XXX recursive call */
+			b = find_pci_bus(&b->children, bus);
+
+			if (b)
+				return b;
+		}
+	}
+
+	return NULL;
+}
+
+
+/* decode ACPI 2.0 _HPP hot plug parameters */
+static void decode_hpp(struct acpiphp_bridge *bridge)
+{
+	acpi_status status;
+	acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
+			       .pointer = NULL};
+	acpi_object *package;
+	int i;
+
+	/* default numbers */
+	bridge->hpp.cache_line_size = 0x10;
+	bridge->hpp.latency_timer = 0x40;
+	bridge->hpp.enable_SERR = 0;
+	bridge->hpp.enable_PERR = 0;
+
+	status = acpi_evaluate_object(bridge->handle, "_HPP", NULL, &buffer);
+
+	if (ACPI_FAILURE(status)) {
+		dbg("_HPP evaluation failed");
+		return;
+	}
+
+	package = (acpi_object *) buffer.pointer;
+
+	if (!package || package->type != ACPI_TYPE_PACKAGE ||
+	    package->package.count != 4 || !package->package.elements) {
+		err("invalid _HPP object; ignoring");
+		goto err_exit;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (package->package.elements[i].type != ACPI_TYPE_INTEGER) {
+			err("invalid _HPP parameter type; ignoring");
+			goto err_exit;
+		}
+	}
+
+	bridge->hpp.cache_line_size = package->package.elements[0].integer.value;
+	bridge->hpp.latency_timer = package->package.elements[1].integer.value;
+	bridge->hpp.enable_SERR = package->package.elements[2].integer.value;
+	bridge->hpp.enable_PERR = package->package.elements[3].integer.value;
+
+	dbg("_HPP parameter = (%02x, %02x, %02x, %02x)",
+	    bridge->hpp.cache_line_size,
+	    bridge->hpp.latency_timer,
+	    bridge->hpp.enable_SERR,
+	    bridge->hpp.enable_PERR);
+
+	bridge->flags |= BRIDGE_HAS_HPP;
+
+ err_exit:
+	kfree(buffer.pointer);
+}
+
+
+/* initialize miscellaneous stuff for both root and PCI-to-PCI bridge */
+static void init_bridge_misc (struct acpiphp_bridge *bridge)
+{
+	acpi_status status;
+
+	/* decode ACPI 2.0 _HPP (hot plug parameters) */
+	decode_hpp(bridge);
+
+	/* subtract all resources already allocated */
+	acpiphp_detect_pci_resource(bridge);
+
+	/* register all slot objects under this bridge */
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge->handle, (u32)1,
+				     register_slot, bridge, NULL);
+
+	/* install notify handler */
+	status = acpi_install_notify_handler(bridge->handle,
+					     ACPI_SYSTEM_NOTIFY,
+					     handle_hotplug_event_bridge,
+					     bridge);
+
+	if (ACPI_FAILURE(status)) {
+		err("failed to register interrupt notify handler");
+	}
+
+	list_add(&bridge->list, &bridge_list);
+
+#if 1
+	dbg("Bridge resource:");
+	acpiphp_dump_resource(bridge);
+#endif
+}
+
+
+/* allocate and initialize host bridge data structure */
+static void add_host_bridge (acpi_handle *handle, int seg, int bus)
+{
+	acpi_status status;
+	acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
+			       .pointer = NULL};
+
+	struct acpiphp_bridge *bridge;
+
+	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
+	if (bridge == NULL)
+		return;
+
+	memset(bridge, 0, sizeof(struct acpiphp_bridge));
+
+	bridge->type = BRIDGE_TYPE_HOST;
+	bridge->handle = handle;
+	bridge->seg = seg;
+	bridge->bus = bus;
+
+	bridge->pci_bus = find_pci_bus(&pci_root_buses, bus);
+
+	bridge->res_lock = SPIN_LOCK_UNLOCKED;
+
+	/* to be overridden when we decode _CRS	*/
+	bridge->sub = bridge->bus;
+
+	/* decode resources */
+
+	status = acpi_get_current_resources(handle, &buffer);
+
+	if (ACPI_FAILURE(status)) {
+		err("failed to decode bridge resources");
+		kfree(bridge);
+		return;
+	}
+
+	decode_acpi_resource(buffer.pointer, bridge);
+	kfree(buffer.pointer);
+
+	if (bridge->bus_head) {
+		bridge->bus = bridge->bus_head->base;
+		bridge->sub = bridge->bus_head->base + bridge->bus_head->length - 1;
+	}
+
+	init_bridge_misc(bridge);
+}
+
+
+/* allocate and initialize PCI-to-PCI bridge data structure */
+static void add_p2p_bridge (acpi_handle *handle, int seg, int bus, int dev, int fn)
+{
+	struct acpiphp_bridge *bridge;
+	u8 tmp8;
+	u16 tmp16;
+	u64 base64, limit64;
+	u32 base, limit, base32u, limit32u;
+
+	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
+	if (bridge == NULL) {
+		err("out of memory");
+		return;
+	}
+
+	memset(bridge, 0, sizeof(struct acpiphp_bridge));
+
+	bridge->type = BRIDGE_TYPE_P2P;
+	bridge->handle = handle;
+	bridge->seg = seg;
+
+	bridge->pci_dev = pci_find_slot(bus, PCI_DEVFN(dev, fn));
+	if (!bridge->pci_dev) {
+		err("Can't get pci_dev");
+		kfree(bridge);
+		return;
+	}
+
+	bridge->pci_bus = bridge->pci_dev->subordinate;
+	if (!bridge->pci_bus) {
+		err("This is not a PCI-to-PCI bridge!");
+		kfree(bridge);
+		return;
+	}
+
+	bridge->res_lock = SPIN_LOCK_UNLOCKED;
+
+	bridge->bus = bridge->pci_bus->number;
+	bridge->sub = bridge->pci_bus->subordinate;
+
+	/*
+	 * decode resources under this P2P bridge
+	 */
+
+	/* I/O resources */
+	pci_read_config_byte(bridge->pci_dev, PCI_IO_BASE, &tmp8);
+	base = tmp8;
+	pci_read_config_byte(bridge->pci_dev, PCI_IO_LIMIT, &tmp8);
+	limit = tmp8;
+
+	switch (base & PCI_IO_RANGE_TYPE_MASK) {
+	case PCI_IO_RANGE_TYPE_16:
+		base = (base << 8) & 0xf000;
+		limit = ((limit << 8) & 0xf000) + 0xfff;
+		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
+		if (!bridge->io_head) {
+			err("out of memory");
+			return;
+		}
+		dbg("16bit I/O range: %04x-%04x",
+		    (u32)bridge->io_head->base,
+		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
+		break;
+	case PCI_IO_RANGE_TYPE_32:
+		pci_read_config_word(bridge->pci_dev, PCI_IO_BASE_UPPER16, &tmp16);
+		base = ((u32)tmp16 << 16) | ((base << 8) & 0xf000);
+		pci_read_config_word(bridge->pci_dev, PCI_IO_LIMIT_UPPER16, &tmp16);
+		limit = (((u32)tmp16 << 16) | ((limit << 8) & 0xf000)) + 0xfff;
+		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
+		if (!bridge->io_head) {
+			err("out of memory");
+			return;
+		}
+		dbg("32bit I/O range: %08x-%08x",
+		    (u32)bridge->io_head->base,
+		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
+		break;
+	case 0x0f:
+		dbg("I/O space unsupported");
+		break;
+	default:
+		warn("Unknown I/O range type");
+	}
+
+	/* Memory resources (mandatory for P2P bridge) */
+	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_BASE, &tmp16);
+	base = (tmp16 & 0xfff0) << 16;
+	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_LIMIT, &tmp16);
+	limit = ((tmp16 & 0xfff0) << 16) | 0xfffff;
+	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
+	if (!bridge->mem_head) {
+		err("out of memory");
+		return;
+	}
+	dbg("32bit Memory range: %08x-%08x",
+	    (u32)bridge->mem_head->base,
+	    (u32)(bridge->mem_head->base + bridge->mem_head->length-1));
+
+	/* Prefetchable Memory resources (optional) */
+	pci_read_config_word(bridge->pci_dev, PCI_PREF_MEMORY_BASE, &tmp16);
+	base = tmp16;
+	pci_read_config_word(bridge->pci_dev, PCI_PREF_MEMORY_LIMIT, &tmp16);
+	limit = tmp16;
+
+	switch (base & PCI_MEMORY_RANGE_TYPE_MASK) {
+	case PCI_PREF_RANGE_TYPE_32:
+		base = (base & 0xfff0) << 16;
+		limit = ((limit & 0xfff0) << 16) | 0xfffff;
+		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
+		if (!bridge->p_mem_head) {
+			err("out of memory");
+			return;
+		}
+		dbg("32bit Prefetchable memory range: %08x-%08x",
+		    (u32)bridge->p_mem_head->base,
+		    (u32)(bridge->p_mem_head->base + bridge->p_mem_head->length - 1));
+		break;
+	case PCI_PREF_RANGE_TYPE_64:
+		pci_read_config_dword(bridge->pci_dev, PCI_PREF_BASE_UPPER32, &base32u);
+		pci_read_config_dword(bridge->pci_dev, PCI_PREF_LIMIT_UPPER32, &limit32u);
+		base64 = ((u64)base32u << 32) | ((base & 0xfff0) << 16);
+		limit64 = (((u64)limit32u << 32) | ((limit & 0xfff0) << 16)) + 0xfffff;
+
+		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
+		if (!bridge->p_mem_head) {
+			err("out of memory");
+			return;
+		}
+		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x",
+		    (u32)(bridge->p_mem_head->base >> 32),
+		    (u32)(bridge->p_mem_head->base & 0xffffffff),
+		    (u32)((bridge->p_mem_head->base + bridge->p_mem_head->length - 1) >> 32),
+		    (u32)((bridge->p_mem_head->base + bridge->p_mem_head->length - 1) & 0xffffffff));
+		break;
+	case 0x0f:
+		break;
+	default:
+		warn("Unknown prefetchale memory type");
+	}
+
+	init_bridge_misc(bridge);
+}
+
+
+/* callback routine to find P2P bridges */
+static acpi_status
+find_p2p_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status status;
+	acpi_handle dummy_handle;
+	unsigned long *segbus = context;
+	unsigned long tmp;
+	int seg, bus, device, function;
+	struct pci_dev *dev;
+
+	/* get PCI address */
+	seg = (*segbus >> 8) & 0xff;
+	bus = *segbus & 0xff;
+
+	status = acpi_get_handle(handle, "_ADR", &dummy_handle);
+	if (ACPI_FAILURE(status))
+		return AE_OK;		/* continue */
+
+	status = acpi_evaluate_integer(handle, "_ADR", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		dbg("%s: _ADR evaluation failure", __FUNCTION__);
+		return AE_OK;
+	}
+
+	device = (tmp >> 16) & 0xffff;
+	function = tmp & 0xffff;
+
+	dev = pci_find_slot(bus, PCI_DEVFN(device, function));
+
+	if (!dev)
+		return AE_OK;
+
+	if (!dev->subordinate)
+		return AE_OK;
+
+	/* check if this bridge has ejectable slots */
+	if (detect_ejectable_slots(handle) > 0) {
+		dbg("found PCI-to-PCI bridge at PCI %02x:%02x.%d", bus, device, function);
+		add_p2p_bridge(handle, seg, bus, device, function);
+	}
+
+	return AE_OK;
+}
+
+
+/* find hot-pluggable slots, and then find P2P bridge */
+static int add_bridges (acpi_handle *handle)
+{
+	acpi_status status;
+	unsigned long tmp;
+	int seg, bus;
+	acpi_handle dummy_handle;
+
+	/* if the bridge doesn't have _STA, we assume it is always there */
+	status = acpi_get_handle(handle, "_STA", &dummy_handle);
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_evaluate_integer(handle, "_STA", NULL, &tmp);
+		if (ACPI_FAILURE(status)) {
+			dbg("%s: _STA evaluation failure", __FUNCTION__);
+			return 0;
+		}
+		if ((tmp & ACPI_STA_FUNCTIONING) == 0)
+			/* don't register this object */
+			return 0;
+	}
+
+	/* get PCI segment number */
+	status = acpi_evaluate_integer(handle, "_SEG", NULL, &tmp);
+
+	seg = ACPI_SUCCESS(status) ? tmp : 0;
+
+	/* get PCI bus number */
+	status = acpi_evaluate_integer(handle, "_BBN", NULL, &tmp);
+
+	if (ACPI_SUCCESS(status)) {
+		bus = tmp;
+	} else {
+		warn("can't get bus number, assuming 0");
+		bus = 0;
+	}
+
+	/* check if this bridge has ejectable slots */
+	if (detect_ejectable_slots(handle) > 0) {
+		dbg("found PCI host-bus bridge with hot-pluggable slots");
+		add_host_bridge(handle, seg, bus);
+		return 0;
+	}
+
+	tmp = seg << 8 | bus;
+
+	/* search P2P bridges under this host bridge */
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
+				     find_p2p_bridge, &tmp, NULL);
+
+	if (ACPI_FAILURE(status))
+		warn("find_p2p_bridge faied (error code = 0x%x)",status);
+
+	return 0;
+}
+
+
+/* callback routine to enumerate all the bridges in ACPI namespace */
+static acpi_status
+find_host_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status status;
+	acpi_device_info info;
+	char objname[5];
+	acpi_buffer buffer = { .length = sizeof(objname),
+			       .pointer = objname };
+
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status)) {
+		dbg("%s: failed to get bridge information", __FUNCTION__);
+		return AE_OK;		/* continue */
+	}
+
+	info.hardware_id[sizeof(info.hardware_id)-1] = '\0';
+
+	/* TBD use acpi_get_devices() API */
+	if (info.current_status &&
+	    (info.valid & ACPI_VALID_HID) &&
+	    strcmp(info.hardware_id, ACPI_PCI_HOST_HID) == 0) {
+		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
+		dbg("checking PCI-hotplug capable bridges under [%s]", objname);
+		add_bridges(handle);
+	}
+	return AE_OK;
+}
+
+
+static int power_on_slot (struct acpiphp_slot *slot)
+{
+	acpi_status status;
+	struct acpiphp_func *func;
+	struct list_head *l;
+	int retval = 0;
+
+	/* is this already enabled? */
+	if (slot->flags & SLOT_POWEREDON)
+		goto err_exit;
+
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		if (func->flags & FUNC_HAS_PS0) {
+			dbg("%s: executing _PS0 on %02x:%02x.%d", __FUNCTION__,
+			    slot->bridge->bus, slot->device, func->function);
+			status = acpi_evaluate_object(func->handle, "_PS0", NULL, NULL);
+			if (ACPI_FAILURE(status)) {
+				warn("%s: _PS0 failed", __FUNCTION__);
+				retval = -1;
+				goto err_exit;
+			}
+		}
+	}
+
+	/* TBD: evaluate _STA to check if the slot is enabled */
+
+	slot->flags |= SLOT_POWEREDON;
+
+ err_exit:
+	return retval;
+}
+
+
+static int power_off_slot (struct acpiphp_slot *slot)
+{
+	acpi_status status;
+	struct acpiphp_func *func;
+	struct list_head *l;
+	acpi_object_list arg_list;
+	acpi_object arg;
+
+	int retval = 0;
+
+	/* is this already enabled? */
+	if ((slot->flags & SLOT_POWEREDON) == 0)
+		goto err_exit;
+
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		if (func->flags & FUNC_HAS_PS3) {
+			dbg("%s: executing _PS3 on %02x:%02x.%d", __FUNCTION__,
+			    slot->bridge->bus, slot->device, func->function);
+			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
+			if (ACPI_FAILURE(status)) {
+				warn("%s: _PS3 failed", __FUNCTION__);
+				retval = -1;
+				goto err_exit;
+			}
+		}
+	}
+
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		if (func->flags & FUNC_HAS_EJ0) {
+			dbg("%s: executing _EJ0 on %02x:%02x.%d", __FUNCTION__,
+			    slot->bridge->bus, slot->device, func->function);
+
+			/* _EJ0 method take one argument */
+			arg_list.count = 1;
+			arg_list.pointer = &arg;
+			arg.type = ACPI_TYPE_INTEGER;
+			arg.integer.value = 1;
+
+			status = acpi_evaluate_object(func->handle, "_EJ0", &arg_list, NULL);
+			if (ACPI_FAILURE(status)) {
+				warn("%s: _EJ0 failed", __FUNCTION__);
+				retval = -1;
+				goto err_exit;
+			}
+		}
+	}
+
+	/* TBD: evaluate _STA to check if the slot is disabled */
+
+	slot->flags &= (~SLOT_POWEREDON);
+
+ err_exit:
+	return retval;
+}
+
+
+/**
+ * enable_device - enable, configure a slot
+ * @slot: slot to be enabled
+ *
+ * This function should be called per *physical slot*,
+ * not per each slot object in ACPI namespace.
+ *
+ */
+static int enable_device (struct acpiphp_slot *slot)
+{
+	u8 bus;
+	struct pci_dev dev0, *dev;
+	struct pci_bus *child;
+	struct list_head *l;
+	struct acpiphp_func *func;
+	int retval = 0;
+
+	if (slot->flags & SLOT_ENABLED)
+		goto err_exit;
+
+	/* sanity check: dev should be NULL when hot-plugged in */
+	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
+	if (dev) {
+		/* This case shouldn't happen */
+		err("pci_dev structure already exists.");
+		retval = -1;
+		goto err_exit;
+	}
+
+	/* allocate resources to device */
+	retval = acpiphp_configure_slot(slot);
+	if (retval)
+		goto err_exit;
+
+	memset(&dev0, 0, sizeof (struct pci_dev));
+
+	dev0.bus = slot->bridge->pci_bus;
+	dev0.devfn = PCI_DEVFN(slot->device, 0);
+	dev0.sysdata = dev0.bus->sysdata;
+	dev0.dev.parent = dev0.bus->dev;
+	dev0.dev.bus = &pci_bus_type;
+
+	/* returned `dev' is the *first function* only! */
+	dev = pci_scan_slot (&dev0);
+
+	if (!dev) {
+		err("No new device found");
+		retval = -1;
+		goto err_exit;
+	}
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &bus);
+		child = (struct pci_bus*) pci_add_new_bus(dev->bus, dev, bus);
+		pci_do_scan_bus(child);
+	}
+
+	/* associate pci_dev to our representation */
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		func->pci_dev = pci_find_slot(slot->bridge->bus,
+					      PCI_DEVFN(slot->device,
+							func->function));
+		if (!func->pci_dev)
+			continue;
+
+		/* configure device */
+		retval = acpiphp_configure_function(func);
+		if (retval)
+			goto err_exit;
+	}
+
+	slot->flags |= SLOT_ENABLED;
+
+#if 1
+	dbg("Available resources:");
+	acpiphp_dump_resource(slot->bridge);
+#endif
+
+ err_exit:
+	return retval;
+}
+
+
+/**
+ * disable_device - disable a slot
+ */
+static int disable_device (struct acpiphp_slot *slot)
+{
+	int retval = 0;
+	struct acpiphp_func *func;
+	struct list_head *l;
+
+	/* is this slot already disabled? */
+	if (!(slot->flags & SLOT_ENABLED))
+		goto err_exit;
+
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		if (func->pci_dev) {
+			if (acpiphp_unconfigure_function(func) == 0) {
+				func->pci_dev = NULL;
+			} else {
+				err("failed to unconfigure device");
+				retval = -1;
+				goto err_exit;
+			}
+		}
+	}
+
+	slot->flags &= (~SLOT_ENABLED);
+
+ err_exit:
+	return retval;
+}
+
+
+/**
+ * get_slot_status - get ACPI slot status
+ *
+ * if a slot has _STA for each function and if any one of them
+ * returned non-zero status, return it
+ *
+ * if a slot doesn't have _STA and if any one of its functions'
+ * configuration space is configured, return 0x0f as a _STA
+ *
+ * otherwise return 0
+ */
+static unsigned int get_slot_status (struct acpiphp_slot *slot)
+{
+	acpi_status status;
+	unsigned long sta = 0;
+	u32 dvid;
+	struct list_head *l;
+	struct acpiphp_func *func;
+
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		if (func->flags & FUNC_HAS_STA) {
+			status = acpi_evaluate_integer(func->handle, "_STA", NULL, &sta);
+			if (ACPI_SUCCESS(status) && sta)
+				break;
+		} else {
+			pci_bus_read_config_dword(slot->bridge->pci_bus,
+						  PCI_DEVFN(slot->device,
+							    func->function),
+						  PCI_VENDOR_ID, &dvid);
+			if (dvid != 0xffffffff) {
+				sta = ACPI_STA_ALL;
+				break;
+			}
+		}
+	}
+
+	return (unsigned int)sta;
+}
+
+
+/*
+ * ACPI event handlers
+ */
+
+/**
+ * handle_hotplug_event_bridge - handle ACPI event on bridges
+ *
+ * @handle: Notify()'ed acpi_handle 
+ * @type: Notify code
+ * @context: pointer to acpiphp_bridge structure
+ *
+ * handles ACPI event notification on {host,p2p} bridges
+ *
+ */
+static void handle_hotplug_event_bridge (acpi_handle handle, u32 type, void *context)
+{
+	struct acpiphp_bridge *bridge;
+	char objname[64];
+	acpi_buffer buffer = { .length = sizeof(objname),
+			       .pointer = objname };
+
+	bridge = (struct acpiphp_bridge *)context;
+
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+
+	switch (type) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		/* bus re-enumerate */
+		dbg("%s: Bus check notify on %s", __FUNCTION__, objname);
+		acpiphp_check_bridge(bridge);
+		break;
+
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		/* device check */
+		dbg("%s: Device check notify on %s", __FUNCTION__, objname);
+		acpiphp_check_bridge(bridge);
+		break;
+
+	case ACPI_NOTIFY_DEVICE_WAKE:
+		/* wake event */
+		dbg("%s: Device wake notify on %s", __FUNCTION__, objname);
+		break;
+
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		/* request device eject */
+		dbg("%s: Device eject notify on %s", __FUNCTION__, objname);
+		break;
+
+	default:
+		warn("notify_handler: unknown event type 0x%x for %s", type, objname);
+		break;
+	}
+}
+
+
+/**
+ * handle_hotplug_event_func - handle ACPI event on functions (i.e. slots)
+ *
+ * @handle: Notify()'ed acpi_handle 
+ * @type: Notify code
+ * @context: pointer to acpiphp_func structure
+ *
+ * handles ACPI event notification on slots
+ *
+ */
+static void handle_hotplug_event_func (acpi_handle handle, u32 type, void *context)
+{
+	struct acpiphp_func *func;
+	char objname[64];
+	acpi_buffer buffer = { .length = sizeof(objname),
+			       .pointer = objname };
+
+	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
+
+	func = (struct acpiphp_func *)context;
+
+	switch (type) {
+	case ACPI_NOTIFY_BUS_CHECK:
+		/* bus re-enumerate */
+		dbg("%s: Bus check notify on %s", __FUNCTION__, objname);
+		acpiphp_enable_slot(func->slot);
+		break;
+
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		/* device check : re-enumerate from parent bus */
+		dbg("%s: Device check notify on %s", __FUNCTION__, objname);
+		acpiphp_check_bridge(func->slot->bridge);
+		break;
+
+	case ACPI_NOTIFY_DEVICE_WAKE:
+		/* wake event */
+		dbg("%s: Device wake notify on %s", __FUNCTION__, objname);
+		break;
+
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		/* request device eject */
+		dbg("%s: Device eject notify on %s", __FUNCTION__, objname);
+		acpiphp_disable_slot(func->slot);
+		break;
+
+	default:
+		warn("notify_handler: unknown event type 0x%x for %s", type, objname);
+		break;
+	}
+}
+
+
+/**
+ * acpiphp_glue_init - initializes all PCI hotplug - ACPI glue data structures
+ *
+ */
+int acpiphp_glue_init (void)
+{
+	acpi_status status;
+
+	if (list_empty(&pci_root_buses))
+		return -1;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, find_host_bridge,
+				     NULL, NULL);
+
+	if (ACPI_FAILURE(status)) {
+		err("%s: acpi_walk_namespace() failed", __FUNCTION__);
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/**
+ * acpiphp_glue_exit - terminates all PCI hotplug - ACPI glue data structures
+ *
+ * This function frees all data allocated in acpiphp_glue_init()
+ */
+void acpiphp_glue_exit (void)
+{
+	struct list_head *l1, *l2, *n1, *n2;
+	struct acpiphp_bridge *bridge;
+	struct acpiphp_slot *slot, *next;
+	struct acpiphp_func *func;
+	acpi_status status;
+
+	list_for_each_safe(l1, n1, &bridge_list) {
+		bridge = (struct acpiphp_bridge *)l1;
+		slot = bridge->slots;
+		while (slot) {
+			next = slot->next;
+			list_for_each_safe(l2, n2, &slot->funcs) {
+				func = list_entry(l2, struct acpiphp_func, sibling);
+				acpiphp_free_resource(&func->io_head);
+				acpiphp_free_resource(&func->mem_head);
+				acpiphp_free_resource(&func->p_mem_head);
+				acpiphp_free_resource(&func->bus_head);
+				status = acpi_remove_notify_handler(func->handle,
+								    ACPI_SYSTEM_NOTIFY,
+								    handle_hotplug_event_func);
+				if (ACPI_FAILURE(status))
+					err("failed to remove notify handler");
+				kfree(func);
+			}
+			kfree(slot);
+			slot = next;
+		}
+		status = acpi_remove_notify_handler(bridge->handle, ACPI_SYSTEM_NOTIFY,
+						    handle_hotplug_event_bridge);
+		if (ACPI_FAILURE(status))
+			err("failed to remove notify handler");
+
+		acpiphp_free_resource(&bridge->io_head);
+		acpiphp_free_resource(&bridge->mem_head);
+		acpiphp_free_resource(&bridge->p_mem_head);
+		acpiphp_free_resource(&bridge->bus_head);
+
+		kfree(bridge);
+	}
+}
+
+
+/**
+ * acpiphp_get_num_slots - count number of slots in a system
+ */
+int acpiphp_get_num_slots (void)
+{
+	struct list_head *node;
+	struct acpiphp_bridge *bridge;
+	int num_slots;
+
+	num_slots = 0;
+
+	list_for_each(node, &bridge_list) {
+		bridge = (struct acpiphp_bridge *)node;
+		dbg("Bus%d %dslot(s)", bridge->bus, bridge->nr_slots);
+		num_slots += bridge->nr_slots;
+	}
+
+	dbg("Total %dslots", num_slots);
+	return num_slots;
+}
+
+
+/**
+ * acpiphp_for_each_slot - call function for each slot
+ * @fn: callback function
+ * @data: context to be passed to callback function
+ *
+ */
+int acpiphp_for_each_slot(acpiphp_callback fn, void *data)
+{
+	struct list_head *node;
+	struct acpiphp_bridge *bridge;
+	struct acpiphp_slot *slot;
+	int retval = 0;
+
+	list_for_each(node, &bridge_list) {
+		bridge = (struct acpiphp_bridge *)node;
+		for (slot = bridge->slots; slot; slot = slot->next) {
+			retval = fn(slot, data);
+			if (!retval)
+				goto err_exit;
+		}
+	}
+
+ err_exit:
+	return retval;
+}
+
+
+/* search matching slot from id  */
+struct acpiphp_slot *get_slot_from_id (int id)
+{
+	struct list_head *node;
+	struct acpiphp_bridge *bridge;
+	struct acpiphp_slot *slot;
+
+	list_for_each(node, &bridge_list) {
+		bridge = (struct acpiphp_bridge *)node;
+		for (slot = bridge->slots; slot; slot = slot->next)
+			if (slot->id == id)
+				return slot;
+	}
+
+	/* should never happen! */
+	err("%s: no object for id %d",__FUNCTION__, id);
+	return 0;
+}
+
+
+/**
+ * acpiphp_enable_slot - power on slot
+ */
+int acpiphp_enable_slot (struct acpiphp_slot *slot)
+{
+	int retval;
+
+	down(&slot->crit_sect);
+
+	/* wake up all functions */
+	retval = power_on_slot(slot);
+	if (retval)
+		goto err_exit;
+
+	if (get_slot_status(slot) == ACPI_STA_ALL)
+		/* configure all functions */
+		retval = enable_device(slot);
+
+ err_exit:
+	up(&slot->crit_sect);
+	return retval;
+}
+
+
+/**
+ * acpiphp_disable_slot - power off slot
+ */
+int acpiphp_disable_slot (struct acpiphp_slot *slot)
+{
+	int retval = 0;
+
+	down(&slot->crit_sect);
+
+	/* unconfigure all functions */
+	retval = disable_device(slot);
+	if (retval)
+		goto err_exit;
+
+	/* power off all functions */
+	retval = power_off_slot(slot);
+	if (retval)
+		goto err_exit;
+
+	acpiphp_resource_sort_and_combine(&slot->bridge->io_head);
+	acpiphp_resource_sort_and_combine(&slot->bridge->mem_head);
+	acpiphp_resource_sort_and_combine(&slot->bridge->p_mem_head);
+	acpiphp_resource_sort_and_combine(&slot->bridge->bus_head);
+	dbg("Available resources:");
+	acpiphp_dump_resource(slot->bridge);
+
+ err_exit:
+	up(&slot->crit_sect);
+	return retval;
+}
+
+
+/**
+ * acpiphp_check_bridge - re-enumerate devices
+ */
+int acpiphp_check_bridge (struct acpiphp_bridge *bridge)
+{
+	struct acpiphp_slot *slot;
+	unsigned int sta;
+	int retval = 0;
+	int enabled, disabled;
+
+	enabled = disabled = 0;
+
+	for (slot = bridge->slots; slot; slot = slot->next) {
+		sta = get_slot_status(slot);
+		if (slot->flags & SLOT_ENABLED) {
+			/* if enabled but not present, disable */
+			if (sta != ACPI_STA_ALL) {
+				retval = acpiphp_disable_slot(slot);
+				if (retval) {
+					err("Error occured in enabling");
+					up(&slot->crit_sect);
+					goto err_exit;
+				}
+				enabled++;
+			}
+		} else {
+			/* if disabled but present, enable */
+			if (sta == ACPI_STA_ALL) {
+				retval = acpiphp_enable_slot(slot);
+				if (retval) {
+					err("Error occured in enabling");
+					up(&slot->crit_sect);
+					goto err_exit;
+				}
+				disabled++;
+			}
+		}
+	}
+
+	dbg("%s: %d enabled, %d disabled", __FUNCTION__, enabled, disabled);
+
+ err_exit:
+	return retval;
+}
+
+
+/*
+ * slot enabled:  1
+ * slot disabled: 0
+ */
+u8 acpiphp_get_power_status (struct acpiphp_slot *slot)
+{
+	unsigned int sta;
+
+	sta = get_slot_status(slot);
+
+	return (sta & ACPI_STA_ENABLED) ? 1 : 0;
+}
+
+
+/*
+ * attention LED ON: 1
+ *              OFF: 0
+ *
+ * TBD
+ * no direct attention led status information via ACPI
+ *
+ */
+u8 acpiphp_get_attention_status (struct acpiphp_slot *slot)
+{
+	return 0;
+}
+
+
+/*
+ * latch closed:  1
+ * latch   open:  0
+ */
+u8 acpiphp_get_latch_status (struct acpiphp_slot *slot)
+{
+	unsigned int sta;
+
+	sta = get_slot_status(slot);
+
+	return (sta & ACPI_STA_SHOW_IN_UI) ? 1 : 0;
+}
+
+
+/*
+ * adapter presence : 1
+ *          absence : 0
+ */
+u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot)
+{
+	unsigned int sta;
+
+	sta = get_slot_status(slot);
+
+	return (sta == 0) ? 0 : 1;
+}
diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/acpiphp_pci.c	Wed Oct  9 15:37:29 2002
@@ -0,0 +1,692 @@
+/*
+ * ACPI PCI HotPlug PCI configuration space management
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (c) 2002 Takayoshi Kochi (t-kouchi@cq.jp.nec.com)
+ * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (c) 2002 NEC Corporation
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
+ * Send feedback to <t-kouchi@cq.jp.nec.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include "pci_hotplug.h"
+#include "acpiphp.h"
+
+#define MY_NAME "acpiphp_pci"
+
+
+/* allocate mem/pmem/io resource to a new function */
+static int init_config_space (struct acpiphp_func *func)
+{
+	u32 bar, len;
+	u32 address[] = {
+		PCI_BASE_ADDRESS_0,
+		PCI_BASE_ADDRESS_1,
+		PCI_BASE_ADDRESS_2,
+		PCI_BASE_ADDRESS_3,
+		PCI_BASE_ADDRESS_4,
+		PCI_BASE_ADDRESS_5,
+		0
+	};
+	int count;
+	struct acpiphp_bridge *bridge;
+	struct pci_resource *res;
+	struct pci_bus *pbus;
+	int bus, device, function;
+	unsigned int devfn;
+	u16 tmp;
+
+	bridge = func->slot->bridge;
+	pbus = bridge->pci_bus;
+	bus = bridge->bus;
+	device = func->slot->device;
+	function = func->function;
+	devfn = PCI_DEVFN(device, function);
+
+	for (count = 0; address[count]; count++) {	/* for 6 BARs */
+		pci_bus_write_config_dword(pbus, devfn,
+					   address[count], 0xFFFFFFFF);
+		pci_bus_read_config_dword(pbus, devfn, address[count], &bar);
+
+		if (!bar)	/* This BAR is not implemented */
+			continue;
+
+		dbg("Device %02x.%02x BAR %d wants %x", device, function, count, bar);
+
+		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
+			/* This is IO */
+
+			len = bar & 0xFFFFFFFC;
+			len = ~len + 1;
+
+			dbg ("len in IO %x, BAR %d", len, count);
+
+			spin_lock(&bridge->res_lock);
+			res = acpiphp_get_io_resource(&bridge->io_head, len);
+			spin_unlock(&bridge->res_lock);
+
+			if (!res) {
+				err("cannot allocate requested io for %02x:%02x.%d len %x\n",
+				    bus, device, function, len);
+				return -1;
+			}
+			pci_bus_write_config_dword(pbus, devfn,
+						   address[count],
+						   (u32)res->base);
+			res->next = func->io_head;
+			func->io_head = res;
+
+		} else {
+			/* This is Memory */
+			if (bar & PCI_BASE_ADDRESS_MEM_PREFETCH) {
+				/* pfmem */
+
+				len = bar & 0xFFFFFFF0;
+				len = ~len + 1;
+
+				dbg("len in PFMEM %x, BAR %d", len, count);
+
+				spin_lock(&bridge->res_lock);
+				res = acpiphp_get_resource(&bridge->p_mem_head, len);
+				spin_unlock(&bridge->res_lock);
+
+				if (!res) {
+					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
+					    bus, device, function, len);
+					return -1;
+				}
+
+				pci_bus_write_config_dword(pbus, devfn,
+							   address[count],
+							   (u32)res->base);
+
+				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
+					dbg ("inside the pfmem 64 case, count %d", count);
+					count += 1;
+					pci_bus_write_config_dword(pbus, devfn,
+								   address[count],
+								   (u32)(res->base >> 32));
+				}
+
+				res->next = func->p_mem_head;
+				func->p_mem_head = res;
+
+			} else {
+				/* regular memory */
+
+				len = bar & 0xFFFFFFF0;
+				len = ~len + 1;
+
+				dbg("len in MEM %x, BAR %d", len, count);
+
+				spin_lock(&bridge->res_lock);
+				res = acpiphp_get_resource(&bridge->mem_head, len);
+				spin_unlock(&bridge->res_lock);
+
+				if (!res) {
+					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
+					    bus, device, function, len);
+					return -1;
+				}
+
+				pci_bus_write_config_dword(pbus, devfn,
+							   address[count],
+							   (u32)res->base);
+
+				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+					/* takes up another dword */
+					dbg ("inside mem 64 case, reg. mem, count %d", count);
+					count += 1;
+					pci_bus_write_config_dword(pbus, devfn,
+								   address[count],
+								   (u32)(res->base >> 32));
+				}
+
+				res->next = func->mem_head;
+				func->mem_head = res;
+
+			}
+		}
+	}
+
+	/* disable expansion rom */
+	pci_bus_write_config_dword(pbus, devfn, PCI_ROM_ADDRESS, 0x00000000);
+
+	/* set PCI parameters from _HPP */
+	pci_bus_write_config_byte(pbus, devfn, PCI_CACHE_LINE_SIZE,
+				  bridge->hpp.cache_line_size);
+	pci_bus_write_config_byte(pbus, devfn, PCI_LATENCY_TIMER,
+				  bridge->hpp.latency_timer);
+
+	pci_bus_read_config_word(pbus, devfn, PCI_COMMAND, &tmp);
+	if (bridge->hpp.enable_SERR)
+		tmp |= PCI_COMMAND_SERR;
+	if (bridge->hpp.enable_PERR)
+		tmp |= PCI_COMMAND_PARITY;
+	pci_bus_write_config_word(pbus, devfn, PCI_COMMAND, tmp);
+
+	return 0;
+}
+
+
+/* enable pci_dev */
+static int configure_pci_dev (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
+{
+	struct acpiphp_func *func;
+	struct acpiphp_bridge *bridge;
+	struct pci_dev *dev;
+
+	func = (struct acpiphp_func *)wrapped_dev->data;
+	bridge = (struct acpiphp_bridge *)wrapped_bus->data;
+	dev = wrapped_dev->dev;
+
+	/* TBD: support PCI-to-PCI bridge case */
+	if (!func || !bridge)
+		return 0;
+
+	//pci_proc_attach_device(dev);
+	//pci_announce_device_to_drivers(dev);
+	info("Device %s configured", dev->slot_name);
+
+	return 0;
+}
+
+
+static int is_pci_dev_in_use (struct pci_dev* dev) 
+{
+	/* 
+	 * dev->driver will be set if the device is in use by a new-style 
+	 * driver -- otherwise, check the device's regions to see if any
+	 * driver has claimed them
+	 */
+
+	int i, inuse=0;
+
+	if (dev->driver) return 1; //assume driver feels responsible
+
+	for (i = 0; !dev->driver && !inuse && (i < 6); i++) {
+		if (!pci_resource_start(dev, i))
+			continue;
+
+		if (pci_resource_flags(dev, i) & IORESOURCE_IO)
+			inuse = check_region(pci_resource_start(dev, i),
+					     pci_resource_len(dev, i));
+		else if (pci_resource_flags(dev, i) & IORESOURCE_MEM)
+			inuse = check_mem_region(pci_resource_start(dev, i),
+						 pci_resource_len(dev, i));
+	}
+
+	return inuse;
+}
+
+
+static int pci_hp_remove_device (struct pci_dev *dev)
+{
+	if (is_pci_dev_in_use(dev)) {
+		err("***Cannot safely power down device -- "
+		       "it appears to be in use***\n");
+		return -EBUSY;
+	}
+	pci_remove_device(dev);
+	return 0;
+}
+
+
+/* remove device driver */
+static int unconfigure_pci_dev_driver (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
+{
+	struct pci_dev *dev = wrapped_dev->dev;
+
+	dbg("attempting removal of driver for device %s", dev->slot_name);
+
+	/* Now, remove the Linux Driver Representation */
+	if (dev->driver) {
+		if (dev->driver->remove) {
+			dev->driver->remove(dev);
+			dbg("driver was properly removed");
+		}
+		dev->driver = NULL;
+	}
+
+	return is_pci_dev_in_use(dev);
+}
+
+
+/* remove pci_dev itself from system */
+static int unconfigure_pci_dev (struct pci_dev_wrapped *wrapped_dev, struct pci_bus_wrapped *wrapped_bus)
+{
+	struct pci_dev *dev = wrapped_dev->dev;
+
+	/* Now, remove the Linux Representation */
+	if (dev) {
+		if (pci_hp_remove_device(dev) == 0) {
+			info("Device %s removed", dev->slot_name);
+			kfree(dev); /* Now, remove */
+		} else {
+			return -1; /* problems while freeing, abort visitation */
+		}
+	}
+
+	return 0;
+}
+
+
+/* remove pci_bus itself from system */
+static int unconfigure_pci_bus (struct pci_bus_wrapped *wrapped_bus, struct pci_dev_wrapped *wrapped_dev)
+{
+	struct pci_bus *bus = wrapped_bus->bus;
+
+#ifdef CONFIG_PROC_FS
+	/* Now, remove the Linux Representation */
+	if (bus->procdir) {
+		pci_proc_detach_bus(bus);
+	}
+#endif
+	/* the cleanup code should live in the kernel ... */
+	bus->self->subordinate = NULL;
+	/* unlink from parent bus */
+	list_del(&bus->node);
+
+	/* Now, remove */
+	if (bus)
+		kfree(bus);
+
+	return 0;
+}
+
+
+/* detect_used_resource - subtract resource under dev from bridge */
+static int detect_used_resource (struct acpiphp_bridge *bridge, struct pci_dev *dev)
+{
+	u32 bar, len;
+	u64 base;
+	u32 address[] = {
+		PCI_BASE_ADDRESS_0,
+		PCI_BASE_ADDRESS_1,
+		PCI_BASE_ADDRESS_2,
+		PCI_BASE_ADDRESS_3,
+		PCI_BASE_ADDRESS_4,
+		PCI_BASE_ADDRESS_5,
+		0
+	};
+	int count;
+	struct pci_resource *res;
+
+	dbg("Device %s", dev->slot_name);
+
+	for (count = 0; address[count]; count++) {	/* for 6 BARs */
+		pci_read_config_dword(dev, address[count], &bar);
+
+		if (!bar)	/* This BAR is not implemented */
+			continue;
+
+		pci_write_config_dword(dev, address[count], 0xFFFFFFFF);
+		pci_read_config_dword(dev, address[count], &len);
+
+		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
+			/* This is IO */
+			base = bar & 0xFFFFFFFC;
+			len &= 0xFFFFFFFC;
+			len = ~len + 1;
+
+			dbg("BAR[%d] %08x - %08x (IO)", count, (u32)base, (u32)base + len - 1);
+
+			spin_lock(&bridge->res_lock);
+			res = acpiphp_get_resource_with_base(&bridge->io_head, base, len);
+			spin_unlock(&bridge->res_lock);
+			if (res)
+				kfree(res);
+		} else {
+			/* This is Memory */
+			base = bar & 0xFFFFFFF0;
+			if (len & PCI_BASE_ADDRESS_MEM_PREFETCH) {
+				/* pfmem */
+
+				len &= 0xFFFFFFF0;
+				len = ~len + 1;
+
+				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
+					dbg ("prefetch mem 64");
+					count += 1;
+				}
+				dbg("BAR[%d] %08x - %08x (PMEM)", count, (u32)base, (u32)base + len - 1);
+				spin_lock(&bridge->res_lock);
+				res = acpiphp_get_resource_with_base(&bridge->p_mem_head, base, len);
+				spin_unlock(&bridge->res_lock);
+				if (res)
+					kfree(res);
+			} else {
+				/* regular memory */
+
+				len &= 0xFFFFFFF0;
+				len = ~len + 1;
+
+				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+					/* takes up another dword */
+					dbg ("mem 64");
+					count += 1;
+				}
+				dbg("BAR[%d] %08x - %08x (MEM)", count, (u32)base, (u32)base + len - 1);
+				spin_lock(&bridge->res_lock);
+				res = acpiphp_get_resource_with_base(&bridge->mem_head, base, len);
+				spin_unlock(&bridge->res_lock);
+				if (res)
+					kfree(res);
+			}
+		}
+
+		pci_write_config_dword(dev, address[count], bar);
+	}
+
+	return 0;
+}
+
+
+/* detect_pci_resource_bus - subtract resource under pci_bus */
+static void detect_used_resource_bus(struct acpiphp_bridge *bridge, struct pci_bus *bus)
+{
+	struct list_head *l;
+	struct pci_dev *dev;
+
+	list_for_each(l, &bus->devices) {
+		dev = pci_dev_b(l);
+		detect_used_resource(bridge, dev);
+		/* XXX recursive call */
+		if (dev->subordinate)
+			detect_used_resource_bus(bridge, dev->subordinate);
+	}
+}
+
+
+/**
+ * acpiphp_detect_pci_resource - detect resources under bridge
+ * @bridge: detect all resources already used under this bridge
+ *
+ * collect all resources already allocated for all devices under a bridge.
+ */
+int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge)
+{
+	detect_used_resource_bus(bridge, bridge->pci_bus);
+
+	return 0;
+}
+
+
+/**
+ * acpiphp_init_slot_resource - gather resource usage information of a slot
+ * @slot: ACPI slot object to be checked, should have valid pci_dev member
+ *
+ * TBD: PCI-to-PCI bridge case
+ *      use pci_dev->resource[]
+ */
+int acpiphp_init_func_resource (struct acpiphp_func *func)
+{
+	u64 base;
+	u32 bar, len;
+	u32 address[] = {
+		PCI_BASE_ADDRESS_0,
+		PCI_BASE_ADDRESS_1,
+		PCI_BASE_ADDRESS_2,
+		PCI_BASE_ADDRESS_3,
+		PCI_BASE_ADDRESS_4,
+		PCI_BASE_ADDRESS_5,
+		0
+	};
+	int count;
+	struct pci_resource *res;
+	struct pci_dev *dev;
+
+	dev = func->pci_dev;
+	dbg("Hot-pluggable device %s", dev->slot_name);
+
+	for (count = 0; address[count]; count++) {	/* for 6 BARs */
+		pci_read_config_dword (dev, address[count], &bar);
+
+		if (!bar)	/* This BAR is not implemented */
+			continue;
+
+		pci_write_config_dword (dev, address[count], 0xFFFFFFFF);
+		pci_read_config_dword (dev, address[count], &len);
+
+		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
+			/* This is IO */
+			base = bar & 0xFFFFFFFC;
+			len &= 0xFFFFFFFC;
+			len = ~len + 1;
+
+			dbg("BAR[%d] %08x - %08x (IO)", count, (u32)base, (u32)base + len - 1);
+
+			res = acpiphp_make_resource(base, len);
+			if (!res)
+				goto no_memory;
+
+			res->next = func->io_head;
+			func->io_head = res;
+
+		} else {
+			/* This is Memory */
+			base = bar & 0xFFFFFFF0;
+			if (len & PCI_BASE_ADDRESS_MEM_PREFETCH) {
+				/* pfmem */
+
+				len &= 0xFFFFFFF0;
+				len = ~len + 1;
+
+				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
+					dbg ("prefetch mem 64");
+					count += 1;
+				}
+				dbg("BAR[%d] %08x - %08x (PMEM)", count, (u32)base, (u32)base + len - 1);
+				res = acpiphp_make_resource(base, len);
+				if (!res)
+					goto no_memory;
+
+				res->next = func->p_mem_head;
+				func->p_mem_head = res;
+
+			} else {
+				/* regular memory */
+
+				len &= 0xFFFFFFF0;
+				len = ~len + 1;
+
+				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+					/* takes up another dword */
+					dbg ("mem 64");
+					count += 1;
+				}
+				dbg("BAR[%d] %08x - %08x (MEM)", count, (u32)base, (u32)base + len - 1);
+				res = acpiphp_make_resource(base, len);
+				if (!res)
+					goto no_memory;
+
+				res->next = func->mem_head;
+				func->mem_head = res;
+
+			}
+		}
+
+		pci_write_config_dword (dev, address[count], bar);
+	}
+#if 1
+	acpiphp_dump_func_resource(func);
+#endif
+
+	return 0;
+
+ no_memory:
+	err("out of memory");
+	acpiphp_free_resource(&func->io_head);
+	acpiphp_free_resource(&func->mem_head);
+	acpiphp_free_resource(&func->p_mem_head);
+
+	return -1;
+}
+
+
+/**
+ * acpiphp_configure_slot - allocate PCI resources
+ * @slot: slot to be configured
+ *
+ * initializes a PCI functions on a device inserted
+ * into the slot
+ *
+ */
+int acpiphp_configure_slot (struct acpiphp_slot *slot)
+{
+	struct acpiphp_func *func;
+	struct list_head *l;
+	u8 hdr;
+	u32 dvid;
+	int retval = 0;
+	int is_multi = 0;
+
+	pci_bus_read_config_byte(slot->bridge->pci_bus,
+				 PCI_DEVFN(slot->device, 0),
+				 PCI_HEADER_TYPE, &hdr);
+
+	if (hdr & 0x80)
+		is_multi = 1;
+
+	list_for_each(l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+		if (is_multi || func->function == 0) {
+			pci_bus_read_config_dword(slot->bridge->pci_bus,
+						  PCI_DEVFN(slot->device,
+							    func->function),
+						  PCI_VENDOR_ID, &dvid);
+			if (dvid != 0xffffffff) {
+				retval = init_config_space(func);
+
+				if (retval)
+					break;
+			}
+		}
+	}
+
+	return retval;
+}
+
+
+/* for pci_visit_dev() */
+static struct pci_visit configure_functions = {
+	.post_visit_pci_dev =	configure_pci_dev
+};
+
+static struct pci_visit unconfigure_functions_phase1 = {
+	.post_visit_pci_dev =	unconfigure_pci_dev_driver
+};
+
+static struct pci_visit unconfigure_functions_phase2 = {
+	.post_visit_pci_bus =	unconfigure_pci_bus,
+	.post_visit_pci_dev =	unconfigure_pci_dev
+};
+
+
+/**
+ * acpiphp_configure_function - configure PCI function
+ * @func: function to be configured
+ *
+ * initializes a PCI functions on a device inserted
+ * into the slot
+ *
+ */
+int acpiphp_configure_function (struct acpiphp_func *func)
+{
+	int retval = 0;
+	struct pci_dev_wrapped wrapped_dev;
+	struct pci_bus_wrapped wrapped_bus;
+	struct acpiphp_bridge *bridge;
+
+	/* if pci_dev is NULL, ignore it */
+	if (!func->pci_dev)
+		goto err_exit;
+
+	bridge = func->slot->bridge;
+
+	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
+	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
+	wrapped_dev.dev = func->pci_dev;
+	wrapped_dev.data = func;
+	wrapped_bus.bus = bridge->pci_bus;
+	wrapped_bus.data = bridge;
+
+	retval = pci_visit_dev(&configure_functions, &wrapped_dev, &wrapped_bus);
+	if (retval)
+		goto err_exit;
+
+ err_exit:
+	return retval;
+}
+
+
+/**
+ * acpiphp_unconfigure_function - unconfigure PCI function
+ * @func: function to be unconfigured
+ *
+ */
+int acpiphp_unconfigure_function (struct acpiphp_func *func)
+{
+	struct acpiphp_bridge *bridge;
+	struct pci_dev_wrapped wrapped_dev;
+	struct pci_bus_wrapped wrapped_bus;
+	int retval = 0;
+
+	/* if pci_dev is NULL, ignore it */
+	if (!func->pci_dev)
+		goto err_exit;
+
+	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
+	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
+	wrapped_dev.dev = func->pci_dev;
+	//wrapped_dev.data = func;
+	wrapped_bus.bus = func->slot->bridge->pci_bus;
+	//wrapped_bus.data = func->slot->bridge;
+
+	retval = pci_visit_dev(&unconfigure_functions_phase1, &wrapped_dev, &wrapped_bus);
+	if (retval)
+		goto err_exit;
+
+	retval = pci_visit_dev(&unconfigure_functions_phase2, &wrapped_dev, &wrapped_bus);
+	if (retval)
+		goto err_exit;
+
+	/* free all resources */
+	bridge = func->slot->bridge;
+
+	spin_lock(&bridge->res_lock);
+	acpiphp_move_resource(&func->io_head, &bridge->io_head);
+	acpiphp_move_resource(&func->mem_head, &bridge->mem_head);
+	acpiphp_move_resource(&func->p_mem_head, &bridge->p_mem_head);
+	acpiphp_move_resource(&func->bus_head, &bridge->bus_head);
+	spin_unlock(&bridge->res_lock);
+
+ err_exit:
+	return retval;
+}
diff -Nru a/drivers/hotplug/acpiphp_res.c b/drivers/hotplug/acpiphp_res.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/acpiphp_res.c	Wed Oct  9 15:37:29 2002
@@ -0,0 +1,699 @@
+/*
+ * ACPI PCI HotPlug Utility functions
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM Corp.
+ * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (c) 2002 Takayoshi Kochi (t-kouchi@cq.jp.nec.com)
+ * Copyright (c) 2002 NEC Corporation
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
+ * Send feedback to <gregkh@us.ibm.com>,<h-aono@ap.jp.nec.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/sysctl.h>
+#include <linux/pci.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/timer.h>
+
+#include <linux/ioctl.h>
+#include <linux/fcntl.h>
+
+#include <linux/list.h>
+
+#include "pci_hotplug.h"
+#include "acpiphp.h"
+
+#define MY_NAME "acpiphp_res"
+
+
+/*
+ * sort_by_size - sort nodes by their length, smallest first
+ */
+static int sort_by_size(struct pci_resource **head)
+{
+	struct pci_resource *current_res;
+	struct pci_resource *next_res;
+	int out_of_order = 1;
+
+	if (!(*head))
+		return 1;
+
+	if (!((*head)->next))
+		return 0;
+
+	while (out_of_order) {
+		out_of_order = 0;
+
+		/* Special case for swapping list head */
+		if (((*head)->next) &&
+		    ((*head)->length > (*head)->next->length)) {
+			out_of_order++;
+			current_res = *head;
+			*head = (*head)->next;
+			current_res->next = (*head)->next;
+			(*head)->next = current_res;
+		}
+
+		current_res = *head;
+
+		while (current_res->next && current_res->next->next) {
+			if (current_res->next->length > current_res->next->next->length) {
+				out_of_order++;
+				next_res = current_res->next;
+				current_res->next = current_res->next->next;
+				current_res = current_res->next;
+				next_res->next = current_res->next;
+				current_res->next = next_res;
+			} else
+				current_res = current_res->next;
+		}
+	}  /* End of out_of_order loop */
+
+	return 0;
+}
+
+
+/*
+ * sort_by_max_size - sort nodes by their length, largest first
+ */
+static int sort_by_max_size(struct pci_resource **head)
+{
+	struct pci_resource *current_res;
+	struct pci_resource *next_res;
+	int out_of_order = 1;
+
+	if (!(*head))
+		return 1;
+
+	if (!((*head)->next))
+		return 0;
+
+	while (out_of_order) {
+		out_of_order = 0;
+
+		/* Special case for swapping list head */
+		if (((*head)->next) &&
+		    ((*head)->length < (*head)->next->length)) {
+			out_of_order++;
+			current_res = *head;
+			*head = (*head)->next;
+			current_res->next = (*head)->next;
+			(*head)->next = current_res;
+		}
+
+		current_res = *head;
+
+		while (current_res->next && current_res->next->next) {
+			if (current_res->next->length < current_res->next->next->length) {
+				out_of_order++;
+				next_res = current_res->next;
+				current_res->next = current_res->next->next;
+				current_res = current_res->next;
+				next_res->next = current_res->next;
+				current_res->next = next_res;
+			} else
+				current_res = current_res->next;
+		}
+	}  /* End of out_of_order loop */
+
+	return 0;
+}
+
+/**
+ * get_io_resource - get resource for I/O ports
+ *
+ * this function sorts the resource list by size and then
+ * returns the first node of "size" length that is not in the
+ * ISA aliasing window.  If it finds a node larger than "size"
+ * it will split it up.
+ *
+ * size must be a power of two.
+ *
+ * difference from get_resource is handling of ISA aliasing space.
+ *
+ */
+struct pci_resource *acpiphp_get_io_resource (struct pci_resource **head, u32 size)
+{
+	struct pci_resource *prevnode;
+	struct pci_resource *node;
+	struct pci_resource *split_node;
+	u64 temp_qword;
+
+	if (!(*head))
+		return NULL;
+
+	if (acpiphp_resource_sort_and_combine(head))
+		return NULL;
+
+	if (sort_by_size(head))
+		return NULL;
+
+	for (node = *head; node; node = node->next) {
+		if (node->length < size)
+			continue;
+
+		if (node->base & (size - 1)) {
+			/* this one isn't base aligned properly
+			   so we'll make a new entry and split it up */
+			temp_qword = (node->base | (size-1)) + 1;
+
+			/* Short circuit if adjusted size is too small */
+			if ((node->length - (temp_qword - node->base)) < size)
+				continue;
+
+			split_node = acpiphp_make_resource(node->base, temp_qword - node->base);
+
+			if (!split_node)
+				return NULL;
+
+			node->base = temp_qword;
+			node->length -= split_node->length;
+
+			/* Put it in the list */
+			split_node->next = node->next;
+			node->next = split_node;
+		} /* End of non-aligned base */
+
+		/* Don't need to check if too small since we already did */
+		if (node->length > size) {
+			/* this one is longer than we need
+			   so we'll make a new entry and split it up */
+			split_node = acpiphp_make_resource(node->base + size, node->length - size);
+
+			if (!split_node)
+				return NULL;
+
+			node->length = size;
+
+			/* Put it in the list */
+			split_node->next = node->next;
+			node->next = split_node;
+		}  /* End of too big on top end */
+
+		/* For IO make sure it's not in the ISA aliasing space */
+		if (node->base & 0x300L)
+			continue;
+
+		/* If we got here, then it is the right size
+		   Now take it out of the list */
+		if (*head == node) {
+			*head = node->next;
+		} else {
+			prevnode = *head;
+			while (prevnode->next != node)
+				prevnode = prevnode->next;
+
+			prevnode->next = node->next;
+		}
+		node->next = NULL;
+		/* Stop looping */
+		break;
+	}
+
+	return node;
+}
+
+
+/**
+ * get_max_resource - get the largest resource
+ *
+ * Gets the largest node that is at least "size" big from the
+ * list pointed to by head.  It aligns the node on top and bottom
+ * to "size" alignment before returning it.
+ */
+struct pci_resource *acpiphp_get_max_resource (struct pci_resource **head, u32 size)
+{
+	struct pci_resource *max;
+	struct pci_resource *temp;
+	struct pci_resource *split_node;
+	u64 temp_qword;
+
+	if (!(*head))
+		return NULL;
+
+	if (acpiphp_resource_sort_and_combine(head))
+		return NULL;
+
+	if (sort_by_max_size(head))
+		return NULL;
+
+	for (max = *head;max; max = max->next) {
+
+		/* If not big enough we could probably just bail, 
+		   instead we'll continue to the next. */
+		if (max->length < size)
+			continue;
+
+		if (max->base & (size - 1)) {
+			/* this one isn't base aligned properly
+			   so we'll make a new entry and split it up */
+			temp_qword = (max->base | (size-1)) + 1;
+
+			/* Short circuit if adjusted size is too small */
+			if ((max->length - (temp_qword - max->base)) < size)
+				continue;
+
+			split_node = acpiphp_make_resource(max->base, temp_qword - max->base);
+
+			if (!split_node)
+				return NULL;
+
+			max->base = temp_qword;
+			max->length -= split_node->length;
+
+			/* Put it next in the list */
+			split_node->next = max->next;
+			max->next = split_node;
+		}
+
+		if ((max->base + max->length) & (size - 1)) {
+			/* this one isn't end aligned properly at the top
+			   so we'll make a new entry and split it up */
+			temp_qword = ((max->base + max->length) & ~(size - 1));
+
+			split_node = acpiphp_make_resource(temp_qword,
+							   max->length + max->base - temp_qword);
+
+			if (!split_node)
+				return NULL;
+
+			max->length -= split_node->length;
+
+			/* Put it in the list */
+			split_node->next = max->next;
+			max->next = split_node;
+		}
+
+		/* Make sure it didn't shrink too much when we aligned it */
+		if (max->length < size)
+			continue;
+
+		/* Now take it out of the list */
+		temp = (struct pci_resource*) *head;
+		if (temp == max) {
+			*head = max->next;
+		} else {
+			while (temp && temp->next != max) {
+				temp = temp->next;
+			}
+
+			temp->next = max->next;
+		}
+
+		max->next = NULL;
+		return max;
+	}
+
+	/* If we get here, we couldn't find one */
+	return NULL;
+}
+
+
+/**
+ * get_resource - get resource (mem, pfmem)
+ *
+ * this function sorts the resource list by size and then
+ * returns the first node of "size" length.  If it finds a node
+ * larger than "size" it will split it up.
+ *
+ * size must be a power of two.
+ *
+ */
+struct pci_resource *acpiphp_get_resource (struct pci_resource **head, u32 size)
+{
+	struct pci_resource *prevnode;
+	struct pci_resource *node;
+	struct pci_resource *split_node;
+	u64 temp_qword;
+
+	if (!(*head))
+		return NULL;
+
+	if (acpiphp_resource_sort_and_combine(head))
+		return NULL;
+
+	if (sort_by_size(head))
+		return NULL;
+
+	for (node = *head; node; node = node->next) {
+		dbg("%s: req_size =%x node=%p, base=%x, length=%x",
+		    __FUNCTION__, size, node, (u32)node->base, node->length);
+		if (node->length < size)
+			continue;
+
+		if (node->base & (size - 1)) {
+			dbg("%s: not aligned", __FUNCTION__);
+			/* this one isn't base aligned properly
+			   so we'll make a new entry and split it up */
+			temp_qword = (node->base | (size-1)) + 1;
+
+			/* Short circuit if adjusted size is too small */
+			if ((node->length - (temp_qword - node->base)) < size)
+				continue;
+
+			split_node = acpiphp_make_resource(node->base, temp_qword - node->base);
+
+			if (!split_node)
+				return NULL;
+
+			node->base = temp_qword;
+			node->length -= split_node->length;
+
+			/* Put it in the list */
+			split_node->next = node->next;
+			node->next = split_node;
+		} /* End of non-aligned base */
+
+		/* Don't need to check if too small since we already did */
+		if (node->length > size) {
+			dbg("%s: too big", __FUNCTION__);
+			/* this one is longer than we need
+			   so we'll make a new entry and split it up */
+			split_node = acpiphp_make_resource(node->base + size, node->length - size);
+
+			if (!split_node)
+				return NULL;
+
+			node->length = size;
+
+			/* Put it in the list */
+			split_node->next = node->next;
+			node->next = split_node;
+		}  /* End of too big on top end */
+
+		dbg("%s: got one!!!", __FUNCTION__);
+		/* If we got here, then it is the right size
+		   Now take it out of the list */
+		if (*head == node) {
+			*head = node->next;
+		} else {
+			prevnode = *head;
+			while (prevnode->next != node)
+				prevnode = prevnode->next;
+
+			prevnode->next = node->next;
+		}
+		node->next = NULL;
+		/* Stop looping */
+		break;
+	}
+	return node;
+}
+
+/**
+ * get_resource_with_base - get resource with specific base address
+ *
+ * this function 
+ * returns the first node of "size" length located at specified base address.
+ * If it finds a node larger than "size" it will split it up.
+ *
+ * size must be a power of two.
+ *
+ */
+struct pci_resource *acpiphp_get_resource_with_base (struct pci_resource **head, u64 base, u32 size)
+{
+	struct pci_resource *prevnode;
+	struct pci_resource *node;
+	struct pci_resource *split_node;
+	u64 temp_qword;
+
+	if (!(*head))
+		return NULL;
+
+	if (acpiphp_resource_sort_and_combine(head))
+		return NULL;
+
+	for (node = *head; node; node = node->next) {
+		dbg(": 1st req_base=%x req_size =%x node=%p, base=%x, length=%x",
+		    (u32)base, size, node, (u32)node->base, node->length);
+		if (node->base > base)
+			continue;
+
+		if ((node->base + node->length) < (base + size))
+			continue;
+
+		if (node->base < base) {
+			dbg(": split 1");
+			/* this one isn't base aligned properly
+			   so we'll make a new entry and split it up */
+			temp_qword = base;
+
+			/* Short circuit if adjusted size is too small */
+			if ((node->length - (temp_qword - node->base)) < size)
+				continue;
+
+			split_node = acpiphp_make_resource(node->base, temp_qword - node->base);
+
+			if (!split_node)
+				return NULL;
+
+			node->base = temp_qword;
+			node->length -= split_node->length;
+
+			/* Put it in the list */
+			split_node->next = node->next;
+			node->next = split_node;
+		}
+
+		dbg(": 2nd req_base=%x req_size =%x node=%p, base=%x, length=%x",
+		    (u32)base, size, node, (u32)node->base, node->length);
+
+		/* Don't need to check if too small since we already did */
+		if (node->length > size) {
+			dbg(": split 2");
+			/* this one is longer than we need
+			   so we'll make a new entry and split it up */
+			split_node = acpiphp_make_resource(node->base + size, node->length - size);
+
+			if (!split_node)
+				return NULL;
+
+			node->length = size;
+
+			/* Put it in the list */
+			split_node->next = node->next;
+			node->next = split_node;
+		}  /* End of too big on top end */
+
+		dbg(": got one!!!");
+		/* If we got here, then it is the right size
+		   Now take it out of the list */
+		if (*head == node) {
+			*head = node->next;
+		} else {
+			prevnode = *head;
+			while (prevnode->next != node)
+				prevnode = prevnode->next;
+
+			prevnode->next = node->next;
+		}
+		node->next = NULL;
+		/* Stop looping */
+		break;
+	}
+	return node;
+}
+
+
+/**
+ * acpiphp_resource_sort_and_combine
+ *
+ * Sorts all of the nodes in the list in ascending order by
+ * their base addresses.  Also does garbage collection by
+ * combining adjacent nodes.
+ *
+ * returns 0 if success
+ */
+int acpiphp_resource_sort_and_combine (struct pci_resource **head)
+{
+	struct pci_resource *node1;
+	struct pci_resource *node2;
+	int out_of_order = 1;
+
+	if (!(*head))
+		return 1;
+
+	dbg("*head->next = %p",(*head)->next);
+
+	if (!(*head)->next)
+		return 0;	/* only one item on the list, already sorted! */
+
+	dbg("*head->base = 0x%x",(u32)(*head)->base);
+	dbg("*head->next->base = 0x%x", (u32)(*head)->next->base);
+	while (out_of_order) {
+		out_of_order = 0;
+
+		/* Special case for swapping list head */
+		if (((*head)->next) &&
+		    ((*head)->base > (*head)->next->base)) {
+			node1 = *head;
+			(*head) = (*head)->next;
+			node1->next = (*head)->next;
+			(*head)->next = node1;
+			out_of_order++;
+		}
+
+		node1 = (*head);
+
+		while (node1->next && node1->next->next) {
+			if (node1->next->base > node1->next->next->base) {
+				out_of_order++;
+				node2 = node1->next;
+				node1->next = node1->next->next;
+				node1 = node1->next;
+				node2->next = node1->next;
+				node1->next = node2;
+			} else
+				node1 = node1->next;
+		}
+	}  /* End of out_of_order loop */
+
+	node1 = *head;
+
+	while (node1 && node1->next) {
+		if ((node1->base + node1->length) == node1->next->base) {
+			/* Combine */
+			dbg("8..");
+			node1->length += node1->next->length;
+			node2 = node1->next;
+			node1->next = node1->next->next;
+			kfree(node2);
+		} else
+			node1 = node1->next;
+	}
+
+	return 0;
+}
+
+
+/**
+ * acpiphp_make_resource - make resource structure
+ * @base: base address of a resource
+ * @length: length of a resource
+ */
+struct pci_resource *acpiphp_make_resource (u64 base, u32 length)
+{
+	struct pci_resource *res;
+
+	res = kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+	if (res) {
+		memset(res, 0, sizeof(struct pci_resource));
+		res->base = base;
+		res->length = length;
+	}
+
+	return res;
+}
+
+
+/**
+ * acpiphp_move_resource - move linked resources from one to another
+ * @from: head of linked resource list
+ * @to: head of linked resource list
+ */
+void acpiphp_move_resource (struct pci_resource **from, struct pci_resource **to)
+{
+	struct pci_resource *tmp;
+
+	while (*from) {
+		tmp = (*from)->next;
+		(*from)->next = *to;
+		*to = *from;
+		*from = tmp;
+	}
+
+	/* *from = NULL is guaranteed */
+}
+
+
+/**
+ * acpiphp_free_resource - free all linked resources
+ * @res: head of linked resource list
+ */
+void acpiphp_free_resource (struct pci_resource **res)
+{
+	struct pci_resource *tmp;
+
+	while (*res) {
+		tmp = (*res)->next;
+		kfree(*res);
+		*res = tmp;
+	}
+
+	/* *res = NULL is guaranteed */
+}
+
+
+/* debug support functions;  will go away sometime :) */
+static void dump_resource(struct pci_resource *head)
+{
+	struct pci_resource *p;
+	int cnt;
+
+	p = head;
+	cnt = 0;
+
+	while (p) {
+		dbg("[%02d] %08x - %08x",
+		    cnt++, (u32)p->base, (u32)p->base + p->length - 1);
+		p = p->next;
+	}
+}
+
+void acpiphp_dump_resource(struct acpiphp_bridge *bridge)
+{
+	dbg("I/O resource:");
+	dump_resource(bridge->io_head);
+	dbg("MEM resource:");
+	dump_resource(bridge->mem_head);
+	dbg("PMEM resource:");
+	dump_resource(bridge->p_mem_head);
+	dbg("BUS resource:");
+	dump_resource(bridge->bus_head);
+}
+
+void acpiphp_dump_func_resource(struct acpiphp_func *func)
+{
+	dbg("I/O resource:");
+	dump_resource(func->io_head);
+	dbg("MEM resource:");
+	dump_resource(func->mem_head);
+	dbg("PMEM resource:");
+	dump_resource(func->p_mem_head);
+	dbg("BUS resource:");
+	dump_resource(func->bus_head);
+}
