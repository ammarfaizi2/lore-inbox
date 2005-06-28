Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVF1IyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVF1IyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVF1GIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:08:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:23788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261820AbVF1Fdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:39 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi hotplug: convert acpiphp to use generic resource code
In-Reply-To: <11199367731380@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <11199367731756@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi hotplug: convert acpiphp to use generic resource code

This patch converts acpiphp to use the generic PCI resource assignment code.
It's quite large, but most of it is deleting the acpiphp_pci and acpiphp_res
files.  It's tested on an hp Integrity rx8620 (which won't work without this
patch).  Testers with other hardware welcomed.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 42f49a6ae5dca90cd0594475502bf1c43ff1dc07
tree f894d1335be0aaa10955f61aa92200540ef13624
parent 4ce448e5fae62689b06027b46f470b944e5c2193
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:53 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:42 -0700

 drivers/pci/hotplug/Makefile       |    4 
 drivers/pci/hotplug/acpiphp.h      |   47 --
 drivers/pci/hotplug/acpiphp_core.c |    9 
 drivers/pci/hotplug/acpiphp_glue.c |  455 ++++++-----------------
 drivers/pci/hotplug/acpiphp_pci.c  |  449 -----------------------
 drivers/pci/hotplug/acpiphp_res.c  |  700 ------------------------------------
 6 files changed, 134 insertions(+), 1530 deletions(-)

diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -36,9 +36,7 @@ ibmphp-objs		:=	ibmphp_core.o	\
 				ibmphp_hpc.o
 
 acpiphp-objs		:=	acpiphp_core.o	\
-				acpiphp_glue.o	\
-				acpiphp_pci.o	\
-				acpiphp_res.o
+				acpiphp_glue.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
 				rpaphp_pci.o	\
diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -7,6 +7,8 @@
  * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
  * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
  * Copyright (C) 2002,2003 NEC Corporation
+ * Copyright (C) 2003-2005 Matthew Wilcox (matthew.wilcox@hp.com)
+ * Copyright (C) 2003-2005 Hewlett Packard
  *
  * All rights reserved.
  *
@@ -52,7 +54,6 @@
 
 struct acpiphp_bridge;
 struct acpiphp_slot;
-struct pci_resource;
 
 /*
  * struct slot - slot information for each *physical* slot
@@ -65,15 +66,6 @@ struct slot {
 	struct acpiphp_slot	*acpi_slot;
 };
 
-/*
- * struct pci_resource - describes pci resource (mem, pfmem, io, bus)
- */
-struct pci_resource {
-	struct pci_resource * next;
-	u64 base;
-	u32 length;
-};
-
 /**
  * struct hpp_param - ACPI 2.0 _HPP Hot Plug Parameters
  * @cache_line_size in DWORD
@@ -101,10 +93,6 @@ struct acpiphp_bridge {
 	int type;
 	int nr_slots;
 
-	u8 seg;
-	u8 bus;
-	u8 sub;
-
 	u32 flags;
 
 	/* This bus (host bridge) or Secondary bus (PCI-to-PCI bridge) */
@@ -117,12 +105,6 @@ struct acpiphp_bridge {
 	struct hpp_param hpp;
 
 	spinlock_t res_lock;
-
-	/* available resources on this bus */
-	struct pci_resource *mem_head;
-	struct pci_resource *p_mem_head;
-	struct pci_resource *io_head;
-	struct pci_resource *bus_head;
 };
 
 
@@ -163,12 +145,6 @@ struct acpiphp_func {
 
 	u8		function;	/* pci function# */
 	u32		flags;		/* see below */
-
-	/* resources used for this function */
-	struct pci_resource *mem_head;
-	struct pci_resource *p_mem_head;
-	struct pci_resource *io_head;
-	struct pci_resource *bus_head;
 };
 
 /**
@@ -243,25 +219,6 @@ extern u8 acpiphp_get_latch_status (stru
 extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
 extern u32 acpiphp_get_address (struct acpiphp_slot *slot);
 
-/* acpiphp_pci.c */
-extern struct pci_dev *acpiphp_allocate_pcidev (struct pci_bus *pbus, int dev, int fn);
-extern int acpiphp_configure_slot (struct acpiphp_slot *slot);
-extern int acpiphp_configure_function (struct acpiphp_func *func);
-extern void acpiphp_unconfigure_function (struct acpiphp_func *func);
-extern int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge);
-extern int acpiphp_init_func_resource (struct acpiphp_func *func);
-
-/* acpiphp_res.c */
-extern struct pci_resource *acpiphp_get_io_resource (struct pci_resource **head, u32 size);
-extern struct pci_resource *acpiphp_get_resource (struct pci_resource **head, u32 size);
-extern struct pci_resource *acpiphp_get_resource_with_base (struct pci_resource **head, u64 base, u32 size);
-extern int acpiphp_resource_sort_and_combine (struct pci_resource **head);
-extern struct pci_resource *acpiphp_make_resource (u64 base, u32 length);
-extern void acpiphp_move_resource (struct pci_resource **from, struct pci_resource **to);
-extern void acpiphp_free_resource (struct pci_resource **res);
-extern void acpiphp_dump_resource (struct acpiphp_bridge *bridge); /* debug */
-extern void acpiphp_dump_func_resource (struct acpiphp_func *func); /* debug */
-
 /* variables */
 extern int acpiphp_debug;
 
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
  * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
  * Copyright (C) 2002,2003 NEC Corporation
+ * Copyright (C) 2003-2005 Matthew Wilcox (matthew.wilcox@hp.com)
+ * Copyright (C) 2003-2005 Hewlett Packard
  *
  * All rights reserved.
  *
@@ -53,8 +55,8 @@ int acpiphp_debug;
 static int num_slots;
 static struct acpiphp_attention_info *attention_info;
 
-#define DRIVER_VERSION	"0.4"
-#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>"
+#define DRIVER_VERSION	"0.5"
+#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>, Matthew Wilcox <willy@hp.com>"
 #define DRIVER_DESC	"ACPI Hot Plug PCI Controller Driver"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
@@ -281,8 +283,7 @@ static int get_adapter_status(struct hot
 /**
  * get_address - get pci address of a slot
  * @hotplug_slot: slot to get status
- * @busdev: pointer to struct pci_busdev (seg, bus, dev)
- *
+ * @value: pointer to struct pci_busdev (seg, bus, dev)
  */
 static int get_address(struct hotplug_slot *hotplug_slot, u32 *value)
 {
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
  * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
  * Copyright (C) 2002,2003 NEC Corporation
+ * Copyright (C) 2003-2005 Matthew Wilcox (matthew.wilcox@hp.com)
+ * Copyright (C) 2003-2005 Hewlett Packard
  *
  * All rights reserved.
  *
@@ -26,6 +28,16 @@
  *
  */
 
+/*
+ * Lifetime rules for pci_dev:
+ *  - The one in acpiphp_func has its refcount elevated by pci_get_slot()
+ *    when the driver is loaded or when an insertion event occurs.  It loses
+ *    a refcount when its ejected or the driver unloads.
+ *  - The one in acpiphp_bridge has its refcount elevated by pci_get_slot()
+ *    when the bridge is scanned and it loses a refcount when the bridge
+ *    is removed.
+ */
+
 #include <linux/init.h>
 #include <linux/module.h>
 
@@ -178,21 +190,18 @@ register_slot(acpi_handle handle, u32 lv
 
 		bridge->nr_slots++;
 
-		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:%d\n",
-		    slot->bridge->bus, slot->device, slot->sun);
+		dbg("found ACPI PCI Hotplug slot %d at PCI %04x:%02x:%02x\n",
+				slot->sun, pci_domain_nr(bridge->pci_bus),
+				bridge->pci_bus->number, slot->device);
 	}
 
 	newfunc->slot = slot;
 	list_add_tail(&newfunc->sibling, &slot->funcs);
 
 	/* associate corresponding pci_dev */
-	newfunc->pci_dev = pci_find_slot(bridge->bus,
+	newfunc->pci_dev = pci_get_slot(bridge->pci_bus,
 					 PCI_DEVFN(device, function));
 	if (newfunc->pci_dev) {
-		if (acpiphp_init_func_resource(newfunc) < 0) {
-			kfree(newfunc);
-			return AE_ERROR;
-		}
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
@@ -227,62 +236,6 @@ static int detect_ejectable_slots(acpi_h
 }
 
 
-/* decode ACPI _CRS data and convert into our internal resource list
- * TBD: _TRA, etc.
- */
-static acpi_status
-decode_acpi_resource(struct acpi_resource *resource, void *context)
-{
-	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *) context;
-	struct acpi_resource_address64 address;
-	struct pci_resource *res;
-
-	if (resource->id != ACPI_RSTYPE_ADDRESS16 &&
-	    resource->id != ACPI_RSTYPE_ADDRESS32 &&
-	    resource->id != ACPI_RSTYPE_ADDRESS64)
-		return AE_OK;
-
-	acpi_resource_to_address64(resource, &address);
-
-	if (address.producer_consumer == ACPI_PRODUCER && address.address_length > 0) {
-		dbg("resource type: %d: 0x%llx - 0x%llx\n", address.resource_type,
-		    (unsigned long long)address.min_address_range,
-		    (unsigned long long)address.max_address_range);
-		res = acpiphp_make_resource(address.min_address_range,
-				    address.address_length);
-		if (!res) {
-			err("out of memory\n");
-			return AE_OK;
-		}
-
-		switch (address.resource_type) {
-		case ACPI_MEMORY_RANGE:
-			if (address.attribute.memory.cache_attribute == ACPI_PREFETCHABLE_MEMORY) {
-				res->next = bridge->p_mem_head;
-				bridge->p_mem_head = res;
-			} else {
-				res->next = bridge->mem_head;
-				bridge->mem_head = res;
-			}
-			break;
-		case ACPI_IO_RANGE:
-			res->next = bridge->io_head;
-			bridge->io_head = res;
-			break;
-		case ACPI_BUS_NUMBER_RANGE:
-			res->next = bridge->bus_head;
-			bridge->bus_head = res;
-			break;
-		default:
-			/* invalid type */
-			kfree(res);
-			break;
-		}
-	}
-
-	return AE_OK;
-}
-
 /* decode ACPI 2.0 _HPP hot plug parameters */
 static void decode_hpp(struct acpiphp_bridge *bridge)
 {
@@ -346,9 +299,6 @@ static void init_bridge_misc(struct acpi
 	/* decode ACPI 2.0 _HPP (hot plug parameters) */
 	decode_hpp(bridge);
 
-	/* subtract all resources already allocated */
-	acpiphp_detect_pci_resource(bridge);
-
 	/* register all slot objects under this bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge->handle, (u32)1,
 				     register_slot, bridge, NULL);
@@ -364,16 +314,12 @@ static void init_bridge_misc(struct acpi
 	}
 
 	list_add(&bridge->list, &bridge_list);
-
-	dbg("Bridge resource:\n");
-	acpiphp_dump_resource(bridge);
 }
 
 
 /* allocate and initialize host bridge data structure */
-static void add_host_bridge(acpi_handle *handle, int seg, int bus)
+static void add_host_bridge(acpi_handle *handle, struct pci_bus *pci_bus)
 {
-	acpi_status status;
 	struct acpiphp_bridge *bridge;
 
 	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
@@ -384,52 +330,19 @@ static void add_host_bridge(acpi_handle 
 
 	bridge->type = BRIDGE_TYPE_HOST;
 	bridge->handle = handle;
-	bridge->seg = seg;
-	bridge->bus = bus;
 
-	bridge->pci_bus = pci_find_bus(seg, bus);
+	bridge->pci_bus = pci_bus;
 
 	spin_lock_init(&bridge->res_lock);
 
-	/* to be overridden when we decode _CRS	*/
-	bridge->sub = bridge->bus;
-
-	/* decode resources */
-
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-		decode_acpi_resource, bridge);
-
-	if (ACPI_FAILURE(status)) {
-		err("failed to decode bridge resources\n");
-		kfree(bridge);
-		return;
-	}
-
-	acpiphp_resource_sort_and_combine(&bridge->io_head);
-	acpiphp_resource_sort_and_combine(&bridge->mem_head);
-	acpiphp_resource_sort_and_combine(&bridge->p_mem_head);
-	acpiphp_resource_sort_and_combine(&bridge->bus_head);
-
-	dbg("ACPI _CRS resource:\n");
-	acpiphp_dump_resource(bridge);
-
-	if (bridge->bus_head) {
-		bridge->bus = bridge->bus_head->base;
-		bridge->sub = bridge->bus_head->base + bridge->bus_head->length - 1;
-	}
-
 	init_bridge_misc(bridge);
 }
 
 
 /* allocate and initialize PCI-to-PCI bridge data structure */
-static void add_p2p_bridge(acpi_handle *handle, int seg, int bus, int dev, int fn)
+static void add_p2p_bridge(acpi_handle *handle, struct pci_dev *pci_dev)
 {
 	struct acpiphp_bridge *bridge;
-	u8 tmp8;
-	u16 tmp16;
-	u64 base64, limit64;
-	u32 base, limit, base32u, limit32u;
 
 	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
 	if (bridge == NULL) {
@@ -441,133 +354,22 @@ static void add_p2p_bridge(acpi_handle *
 
 	bridge->type = BRIDGE_TYPE_P2P;
 	bridge->handle = handle;
-	bridge->seg = seg;
-
-	bridge->pci_dev = pci_find_slot(bus, PCI_DEVFN(dev, fn));
-	if (!bridge->pci_dev) {
-		err("Can't get pci_dev\n");
-		kfree(bridge);
-		return;
-	}
 
-	bridge->pci_bus = bridge->pci_dev->subordinate;
+	bridge->pci_dev = pci_dev_get(pci_dev);
+	bridge->pci_bus = pci_dev->subordinate;
 	if (!bridge->pci_bus) {
 		err("This is not a PCI-to-PCI bridge!\n");
-		kfree(bridge);
-		return;
+		goto err;
 	}
 
 	spin_lock_init(&bridge->res_lock);
 
-	bridge->bus = bridge->pci_bus->number;
-	bridge->sub = bridge->pci_bus->subordinate;
-
-	/*
-	 * decode resources under this P2P bridge
-	 */
-
-	/* I/O resources */
-	pci_read_config_byte(bridge->pci_dev, PCI_IO_BASE, &tmp8);
-	base = tmp8;
-	pci_read_config_byte(bridge->pci_dev, PCI_IO_LIMIT, &tmp8);
-	limit = tmp8;
-
-	switch (base & PCI_IO_RANGE_TYPE_MASK) {
-	case PCI_IO_RANGE_TYPE_16:
-		base = (base << 8) & 0xf000;
-		limit = ((limit << 8) & 0xf000) + 0xfff;
-		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
-		if (!bridge->io_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
-		dbg("16bit I/O range: %04x-%04x\n",
-		    (u32)bridge->io_head->base,
-		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
-		break;
-	case PCI_IO_RANGE_TYPE_32:
-		pci_read_config_word(bridge->pci_dev, PCI_IO_BASE_UPPER16, &tmp16);
-		base = ((u32)tmp16 << 16) | ((base << 8) & 0xf000);
-		pci_read_config_word(bridge->pci_dev, PCI_IO_LIMIT_UPPER16, &tmp16);
-		limit = (((u32)tmp16 << 16) | ((limit << 8) & 0xf000)) + 0xfff;
-		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
-		if (!bridge->io_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
-		dbg("32bit I/O range: %08x-%08x\n",
-		    (u32)bridge->io_head->base,
-		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
-		break;
-	case 0x0f:
-		dbg("I/O space unsupported\n");
-		break;
-	default:
-		warn("Unknown I/O range type\n");
-	}
-
-	/* Memory resources (mandatory for P2P bridge) */
-	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_BASE, &tmp16);
-	base = (tmp16 & 0xfff0) << 16;
-	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_LIMIT, &tmp16);
-	limit = ((tmp16 & 0xfff0) << 16) | 0xfffff;
-	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
-	if (!bridge->mem_head) {
-		err("out of memory\n");
-		kfree(bridge);
-		return;
-	}
-	dbg("32bit Memory range: %08x-%08x\n",
-	    (u32)bridge->mem_head->base,
-	    (u32)(bridge->mem_head->base + bridge->mem_head->length-1));
-
-	/* Prefetchable Memory resources (optional) */
-	pci_read_config_word(bridge->pci_dev, PCI_PREF_MEMORY_BASE, &tmp16);
-	base = tmp16;
-	pci_read_config_word(bridge->pci_dev, PCI_PREF_MEMORY_LIMIT, &tmp16);
-	limit = tmp16;
-
-	switch (base & PCI_MEMORY_RANGE_TYPE_MASK) {
-	case PCI_PREF_RANGE_TYPE_32:
-		base = (base & 0xfff0) << 16;
-		limit = ((limit & 0xfff0) << 16) | 0xfffff;
-		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
-		if (!bridge->p_mem_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
-		dbg("32bit Prefetchable memory range: %08x-%08x\n",
-		    (u32)bridge->p_mem_head->base,
-		    (u32)(bridge->p_mem_head->base + bridge->p_mem_head->length - 1));
-		break;
-	case PCI_PREF_RANGE_TYPE_64:
-		pci_read_config_dword(bridge->pci_dev, PCI_PREF_BASE_UPPER32, &base32u);
-		pci_read_config_dword(bridge->pci_dev, PCI_PREF_LIMIT_UPPER32, &limit32u);
-		base64 = ((u64)base32u << 32) | ((base & 0xfff0) << 16);
-		limit64 = (((u64)limit32u << 32) | ((limit & 0xfff0) << 16)) + 0xfffff;
-
-		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
-		if (!bridge->p_mem_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
-		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x\n",
-		    (u32)(bridge->p_mem_head->base >> 32),
-		    (u32)(bridge->p_mem_head->base & 0xffffffff),
-		    (u32)((bridge->p_mem_head->base + bridge->p_mem_head->length - 1) >> 32),
-		    (u32)((bridge->p_mem_head->base + bridge->p_mem_head->length - 1) & 0xffffffff));
-		break;
-	case 0x0f:
-		break;
-	default:
-		warn("Unknown prefetchale memory type\n");
-	}
-
 	init_bridge_misc(bridge);
+	return;
+ err:
+	pci_dev_put(pci_dev);
+	kfree(bridge);
+	return;
 }
 
 
@@ -577,14 +379,10 @@ find_p2p_bridge(acpi_handle handle, u32 
 {
 	acpi_status status;
 	acpi_handle dummy_handle;
-	unsigned long *segbus = context;
 	unsigned long tmp;
-	int seg, bus, device, function;
+	int device, function;
 	struct pci_dev *dev;
-
-	/* get PCI address */
-	seg = (*segbus >> 8) & 0xff;
-	bus = *segbus & 0xff;
+	struct pci_bus *pci_bus = context;
 
 	status = acpi_get_handle(handle, "_ADR", &dummy_handle);
 	if (ACPI_FAILURE(status))
@@ -599,20 +397,19 @@ find_p2p_bridge(acpi_handle handle, u32 
 	device = (tmp >> 16) & 0xffff;
 	function = tmp & 0xffff;
 
-	dev = pci_find_slot(bus, PCI_DEVFN(device, function));
-
-	if (!dev)
-		return AE_OK;
+	dev = pci_get_slot(pci_bus, PCI_DEVFN(device, function));
 
-	if (!dev->subordinate)
-		return AE_OK;
+	if (!dev || !dev->subordinate)
+		goto out;
 
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
 		dbg("found PCI-to-PCI bridge at PCI %s\n", pci_name(dev));
-		add_p2p_bridge(handle, seg, bus, device, function);
+		add_p2p_bridge(handle, dev);
 	}
 
+ out:
+	pci_dev_put(dev);
 	return AE_OK;
 }
 
@@ -624,6 +421,7 @@ static int add_bridge(acpi_handle handle
 	unsigned long tmp;
 	int seg, bus;
 	acpi_handle dummy_handle;
+	struct pci_bus *pci_bus;
 
 	/* if the bridge doesn't have _STA, we assume it is always there */
 	status = acpi_get_handle(handle, "_STA", &dummy_handle);
@@ -653,18 +451,22 @@ static int add_bridge(acpi_handle handle
 		bus = 0;
 	}
 
+	pci_bus = pci_find_bus(seg, bus);
+	if (!pci_bus) {
+		err("Can't find bus %04x:%02x\n", seg, bus);
+		return 0;
+	}
+
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
 		dbg("found PCI host-bus bridge with hot-pluggable slots\n");
-		add_host_bridge(handle, seg, bus);
+		add_host_bridge(handle, pci_bus);
 		return 0;
 	}
 
-	tmp = seg << 8 | bus;
-
 	/* search P2P bridges under this host bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     find_p2p_bridge, &tmp, NULL);
+				     find_p2p_bridge, pci_bus, NULL);
 
 	if (ACPI_FAILURE(status))
 		warn("find_p2p_bridge faied (error code = 0x%x)\n",status);
@@ -672,10 +474,59 @@ static int add_bridge(acpi_handle handle
 	return 0;
 }
 
+static struct acpiphp_bridge *acpiphp_handle_to_bridge(acpi_handle handle)
+{
+	struct list_head *head;
+	list_for_each(head, &bridge_list) {
+		struct acpiphp_bridge *bridge = list_entry(head,
+						struct acpiphp_bridge, list);
+		if (bridge->handle == handle)
+			return bridge;
+	}
+
+	return NULL;
+}
 
 static void remove_bridge(acpi_handle handle)
 {
-	/* No-op for now .. */
+	struct list_head *list, *tmp;
+	struct acpiphp_bridge *bridge;
+	struct acpiphp_slot *slot;
+	acpi_status status;
+
+	bridge = acpiphp_handle_to_bridge(handle);
+	if (!bridge) {
+		err("Could not find bridge for handle %p\n", handle);
+		return;
+	}
+
+	status = acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+					    handle_hotplug_event_bridge);
+	if (ACPI_FAILURE(status))
+		err("failed to remove notify handler\n");
+
+	slot = bridge->slots;
+	while (slot) {
+		struct acpiphp_slot *next = slot->next;
+		list_for_each_safe (list, tmp, &slot->funcs) {
+			struct acpiphp_func *func;
+			func = list_entry(list, struct acpiphp_func, sibling);
+			status = acpi_remove_notify_handler(func->handle,
+						ACPI_SYSTEM_NOTIFY,
+						handle_hotplug_event_func);
+			if (ACPI_FAILURE(status))
+				err("failed to remove notify handler\n");
+			pci_dev_put(func->pci_dev);
+			list_del(list);
+			kfree(func);
+		}
+		kfree(slot);
+		slot = next;
+	}
+
+	pci_dev_put(bridge->pci_dev);
+	list_del(&bridge->list);
+	kfree(bridge);
 }
 
 
@@ -782,70 +633,56 @@ static int power_off_slot(struct acpiphp
  */
 static int enable_device(struct acpiphp_slot *slot)
 {
-	u8 bus;
 	struct pci_dev *dev;
-	struct pci_bus *child;
+	struct pci_bus *bus = slot->bridge->pci_bus;
 	struct list_head *l;
 	struct acpiphp_func *func;
 	int retval = 0;
-	int num;
+	int num, max, pass;
 
 	if (slot->flags & SLOT_ENABLED)
 		goto err_exit;
 
 	/* sanity check: dev should be NULL when hot-plugged in */
-	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
+	dev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
 	if (dev) {
 		/* This case shouldn't happen */
 		err("pci_dev structure already exists.\n");
+		pci_dev_put(dev);
 		retval = -1;
 		goto err_exit;
 	}
 
-	/* allocate resources to device */
-	retval = acpiphp_configure_slot(slot);
-	if (retval)
-		goto err_exit;
-
-	/* returned `dev' is the *first function* only! */
-	num = pci_scan_slot(slot->bridge->pci_bus, PCI_DEVFN(slot->device, 0));
-	if (num)
-		pci_bus_add_devices(slot->bridge->pci_bus);
-	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
-
-	if (!dev) {
+	num = pci_scan_slot(bus, PCI_DEVFN(slot->device, 0));
+	if (num == 0) {
 		err("No new device found\n");
 		retval = -1;
 		goto err_exit;
 	}
 
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &bus);
-		child = (struct pci_bus*) pci_add_new_bus(dev->bus, dev, bus);
-		pci_do_scan_bus(child);
+	max = bus->secondary;
+	for (pass = 0; pass < 2; pass++) {
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (PCI_SLOT(dev->devfn) != slot->device)
+				continue;
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
+				max = pci_scan_bridge(bus, dev, max, pass);
+		}
 	}
 
+	pci_bus_assign_resources(bus);
+	pci_bus_add_devices(bus);
+
 	/* associate pci_dev to our representation */
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
-
-		func->pci_dev = pci_find_slot(slot->bridge->bus,
-					      PCI_DEVFN(slot->device,
+		func->pci_dev = pci_get_slot(bus, PCI_DEVFN(slot->device,
 							func->function));
-		if (!func->pci_dev)
-			continue;
-
-		/* configure device */
-		retval = acpiphp_configure_function(func);
-		if (retval)
-			goto err_exit;
 	}
 
 	slot->flags |= SLOT_ENABLED;
 
-	dbg("Available resources:\n");
-	acpiphp_dump_resource(slot->bridge);
-
  err_exit:
 	return retval;
 }
@@ -866,9 +703,12 @@ static int disable_device(struct acpiphp
 
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
+		if (!func->pci_dev)
+			continue;
 
-		if (func->pci_dev)
-			acpiphp_unconfigure_function(func);
+		pci_remove_bus_device(func->pci_dev);
+		pci_dev_put(func->pci_dev);
+		func->pci_dev = NULL;
 	}
 
 	slot->flags &= (~SLOT_ENABLED);
@@ -1116,46 +956,6 @@ int __init acpiphp_glue_init(void)
  */
 void __exit acpiphp_glue_exit(void)
 {
-	struct list_head *l1, *l2, *n1, *n2;
-	struct acpiphp_bridge *bridge;
-	struct acpiphp_slot *slot, *next;
-	struct acpiphp_func *func;
-	acpi_status status;
-
-	list_for_each_safe (l1, n1, &bridge_list) {
-		bridge = (struct acpiphp_bridge *)l1;
-		slot = bridge->slots;
-		while (slot) {
-			next = slot->next;
-			list_for_each_safe (l2, n2, &slot->funcs) {
-				func = list_entry(l2, struct acpiphp_func, sibling);
-				acpiphp_free_resource(&func->io_head);
-				acpiphp_free_resource(&func->mem_head);
-				acpiphp_free_resource(&func->p_mem_head);
-				acpiphp_free_resource(&func->bus_head);
-				status = acpi_remove_notify_handler(func->handle,
-								    ACPI_SYSTEM_NOTIFY,
-								    handle_hotplug_event_func);
-				if (ACPI_FAILURE(status))
-					err("failed to remove notify handler\n");
-				kfree(func);
-			}
-			kfree(slot);
-			slot = next;
-		}
-		status = acpi_remove_notify_handler(bridge->handle, ACPI_SYSTEM_NOTIFY,
-						    handle_hotplug_event_bridge);
-		if (ACPI_FAILURE(status))
-			err("failed to remove notify handler\n");
-
-		acpiphp_free_resource(&bridge->io_head);
-		acpiphp_free_resource(&bridge->mem_head);
-		acpiphp_free_resource(&bridge->p_mem_head);
-		acpiphp_free_resource(&bridge->bus_head);
-
-		kfree(bridge);
-	}
-
 	acpi_pci_unregister_driver(&acpi_pci_hp_driver);
 }
 
@@ -1173,11 +973,14 @@ int __init acpiphp_get_num_slots(void)
 
 	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
-		dbg("Bus%d %dslot(s)\n", bridge->bus, bridge->nr_slots);
+		dbg("Bus %04x:%02x has %d slot%s\n",
+				pci_domain_nr(bridge->pci_bus),
+				bridge->pci_bus->number, bridge->nr_slots,
+				bridge->nr_slots == 1 ? "" : "s");
 		num_slots += bridge->nr_slots;
 	}
 
-	dbg("Total %dslots\n", num_slots);
+	dbg("Total %d slots\n", num_slots);
 	return num_slots;
 }
 
@@ -1274,13 +1077,6 @@ int acpiphp_disable_slot(struct acpiphp_
 	if (retval)
 		goto err_exit;
 
-	acpiphp_resource_sort_and_combine(&slot->bridge->io_head);
-	acpiphp_resource_sort_and_combine(&slot->bridge->mem_head);
-	acpiphp_resource_sort_and_combine(&slot->bridge->p_mem_head);
-	acpiphp_resource_sort_and_combine(&slot->bridge->bus_head);
-	dbg("Available resources:\n");
-	acpiphp_dump_resource(slot->bridge);
-
  err_exit:
 	up(&slot->crit_sect);
 	return retval;
@@ -1335,9 +1131,10 @@ u8 acpiphp_get_adapter_status(struct acp
 u32 acpiphp_get_address(struct acpiphp_slot *slot)
 {
 	u32 address;
+	struct pci_bus *pci_bus = slot->bridge->pci_bus;
 
-	address = ((slot->bridge->seg) << 16) |
-		  ((slot->bridge->bus) << 8) |
+	address = (pci_domain_nr(pci_bus) << 16) |
+		  (pci_bus->number << 8) |
 		  slot->device;
 
 	return address;
diff --git a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
deleted file mode 100644
--- a/drivers/pci/hotplug/acpiphp_pci.c
+++ /dev/null
@@ -1,449 +0,0 @@
-/*
- * ACPI PCI HotPlug PCI configuration space management
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001,2002 IBM Corp.
- * Copyright (C) 2002 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (C) 2002 NEC Corporation
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
- * Send feedback to <t-kochi@bq.jp.nec.com>
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/acpi.h>
-#include "../pci.h"
-#include "pci_hotplug.h"
-#include "acpiphp.h"
-
-#define MY_NAME "acpiphp_pci"
-
-
-/* allocate mem/pmem/io resource to a new function */
-static int init_config_space (struct acpiphp_func *func)
-{
-	u32 bar, len;
-	u32 address[] = {
-		PCI_BASE_ADDRESS_0,
-		PCI_BASE_ADDRESS_1,
-		PCI_BASE_ADDRESS_2,
-		PCI_BASE_ADDRESS_3,
-		PCI_BASE_ADDRESS_4,
-		PCI_BASE_ADDRESS_5,
-		0
-	};
-	int count;
-	struct acpiphp_bridge *bridge;
-	struct pci_resource *res;
-	struct pci_bus *pbus;
-	int bus, device, function;
-	unsigned int devfn;
-	u16 tmp;
-
-	bridge = func->slot->bridge;
-	pbus = bridge->pci_bus;
-	bus = bridge->bus;
-	device = func->slot->device;
-	function = func->function;
-	devfn = PCI_DEVFN(device, function);
-
-	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_bus_write_config_dword(pbus, devfn,
-					   address[count], 0xFFFFFFFF);
-		pci_bus_read_config_dword(pbus, devfn, address[count], &bar);
-
-		if (!bar)	/* This BAR is not implemented */
-			continue;
-
-		dbg("Device %02x.%02x BAR %d wants %x\n", device, function, count, bar);
-
-		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
-			/* This is IO */
-
-			len = bar & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
-			len = len & ~(len - 1);
-
-			dbg("len in IO %x, BAR %d\n", len, count);
-
-			spin_lock(&bridge->res_lock);
-			res = acpiphp_get_io_resource(&bridge->io_head, len);
-			spin_unlock(&bridge->res_lock);
-
-			if (!res) {
-				err("cannot allocate requested io for %02x:%02x.%d len %x\n",
-				    bus, device, function, len);
-				return -1;
-			}
-			pci_bus_write_config_dword(pbus, devfn,
-						   address[count],
-						   (u32)res->base);
-			res->next = func->io_head;
-			func->io_head = res;
-
-		} else {
-			/* This is Memory */
-			if (bar & PCI_BASE_ADDRESS_MEM_PREFETCH) {
-				/* pfmem */
-
-				len = bar & 0xFFFFFFF0;
-				len = ~len + 1;
-
-				dbg("len in PFMEM %x, BAR %d\n", len, count);
-
-				spin_lock(&bridge->res_lock);
-				res = acpiphp_get_resource(&bridge->p_mem_head, len);
-				spin_unlock(&bridge->res_lock);
-
-				if (!res) {
-					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
-					    bus, device, function, len);
-					return -1;
-				}
-
-				pci_bus_write_config_dword(pbus, devfn,
-							   address[count],
-							   (u32)res->base);
-
-				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg("inside the pfmem 64 case, count %d\n", count);
-					count += 1;
-					pci_bus_write_config_dword(pbus, devfn,
-								   address[count],
-								   (u32)(res->base >> 32));
-				}
-
-				res->next = func->p_mem_head;
-				func->p_mem_head = res;
-
-			} else {
-				/* regular memory */
-
-				len = bar & 0xFFFFFFF0;
-				len = ~len + 1;
-
-				dbg("len in MEM %x, BAR %d\n", len, count);
-
-				spin_lock(&bridge->res_lock);
-				res = acpiphp_get_resource(&bridge->mem_head, len);
-				spin_unlock(&bridge->res_lock);
-
-				if (!res) {
-					err("cannot allocate requested pfmem for %02x:%02x.%d len %x\n",
-					    bus, device, function, len);
-					return -1;
-				}
-
-				pci_bus_write_config_dword(pbus, devfn,
-							   address[count],
-							   (u32)res->base);
-
-				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					dbg("inside mem 64 case, reg. mem, count %d\n", count);
-					count += 1;
-					pci_bus_write_config_dword(pbus, devfn,
-								   address[count],
-								   (u32)(res->base >> 32));
-				}
-
-				res->next = func->mem_head;
-				func->mem_head = res;
-
-			}
-		}
-	}
-
-	/* disable expansion rom */
-	pci_bus_write_config_dword(pbus, devfn, PCI_ROM_ADDRESS, 0x00000000);
-
-	/* set PCI parameters from _HPP */
-	pci_bus_write_config_byte(pbus, devfn, PCI_CACHE_LINE_SIZE,
-				  bridge->hpp.cache_line_size);
-	pci_bus_write_config_byte(pbus, devfn, PCI_LATENCY_TIMER,
-				  bridge->hpp.latency_timer);
-
-	pci_bus_read_config_word(pbus, devfn, PCI_COMMAND, &tmp);
-	if (bridge->hpp.enable_SERR)
-		tmp |= PCI_COMMAND_SERR;
-	if (bridge->hpp.enable_PERR)
-		tmp |= PCI_COMMAND_PARITY;
-	pci_bus_write_config_word(pbus, devfn, PCI_COMMAND, tmp);
-
-	return 0;
-}
-
-/* detect_used_resource - subtract resource under dev from bridge */
-static int detect_used_resource (struct acpiphp_bridge *bridge, struct pci_dev *dev)
-{
-	int count;
-
-	dbg("Device %s\n", pci_name(dev));
-
-	for (count = 0; count < DEVICE_COUNT_RESOURCE; count++) {
-		struct pci_resource *res;
-		struct pci_resource **head;
-		unsigned long base = dev->resource[count].start;
-		unsigned long len = dev->resource[count].end - base + 1;
-		unsigned long flags = dev->resource[count].flags;
-
-		if (!flags)
-			continue;
-
-		dbg("BAR[%d] 0x%lx - 0x%lx (0x%lx)\n", count, base,
-				base + len - 1, flags);
-
-		if (flags & IORESOURCE_IO) {
-			head = &bridge->io_head;
-		} else if (flags & IORESOURCE_PREFETCH) {
-			head = &bridge->p_mem_head;
-		} else {
-			head = &bridge->mem_head;
-		}
-
-		spin_lock(&bridge->res_lock);
-		res = acpiphp_get_resource_with_base(head, base, len);
-		spin_unlock(&bridge->res_lock);
-		if (res)
-			kfree(res);
-	}
-
-	return 0;
-}
-
-
-/**
- * acpiphp_detect_pci_resource - detect resources under bridge
- * @bridge: detect all resources already used under this bridge
- *
- * collect all resources already allocated for all devices under a bridge.
- */
-int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge)
-{
-	struct list_head *l;
-	struct pci_dev *dev;
-
-	list_for_each (l, &bridge->pci_bus->devices) {
-		dev = pci_dev_b(l);
-		detect_used_resource(bridge, dev);
-	}
-
-	return 0;
-}
-
-
-/**
- * acpiphp_init_slot_resource - gather resource usage information of a slot
- * @slot: ACPI slot object to be checked, should have valid pci_dev member
- *
- * TBD: PCI-to-PCI bridge case
- *      use pci_dev->resource[]
- */
-int acpiphp_init_func_resource (struct acpiphp_func *func)
-{
-	u64 base;
-	u32 bar, len;
-	u32 address[] = {
-		PCI_BASE_ADDRESS_0,
-		PCI_BASE_ADDRESS_1,
-		PCI_BASE_ADDRESS_2,
-		PCI_BASE_ADDRESS_3,
-		PCI_BASE_ADDRESS_4,
-		PCI_BASE_ADDRESS_5,
-		0
-	};
-	int count;
-	struct pci_resource *res;
-	struct pci_dev *dev;
-
-	dev = func->pci_dev;
-	dbg("Hot-pluggable device %s\n", pci_name(dev));
-
-	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_read_config_dword(dev, address[count], &bar);
-
-		if (!bar)	/* This BAR is not implemented */
-			continue;
-
-		pci_write_config_dword(dev, address[count], 0xFFFFFFFF);
-		pci_read_config_dword(dev, address[count], &len);
-
-		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
-			/* This is IO */
-			base = bar & 0xFFFFFFFC;
-			len = len & (PCI_BASE_ADDRESS_IO_MASK & 0xFFFF);
-			len = len & ~(len - 1);
-
-			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
-
-			res = acpiphp_make_resource(base, len);
-			if (!res)
-				goto no_memory;
-
-			res->next = func->io_head;
-			func->io_head = res;
-
-		} else {
-			/* This is Memory */
-			base = bar & 0xFFFFFFF0;
-			if (len & PCI_BASE_ADDRESS_MEM_PREFETCH) {
-				/* pfmem */
-
-				len &= 0xFFFFFFF0;
-				len = ~len + 1;
-
-				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg("prefetch mem 64\n");
-					count += 1;
-				}
-				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
-				res = acpiphp_make_resource(base, len);
-				if (!res)
-					goto no_memory;
-
-				res->next = func->p_mem_head;
-				func->p_mem_head = res;
-
-			} else {
-				/* regular memory */
-
-				len &= 0xFFFFFFF0;
-				len = ~len + 1;
-
-				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-					/* takes up another dword */
-					dbg("mem 64\n");
-					count += 1;
-				}
-				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
-				res = acpiphp_make_resource(base, len);
-				if (!res)
-					goto no_memory;
-
-				res->next = func->mem_head;
-				func->mem_head = res;
-
-			}
-		}
-
-		pci_write_config_dword(dev, address[count], bar);
-	}
-#if 1
-	acpiphp_dump_func_resource(func);
-#endif
-
-	return 0;
-
- no_memory:
-	err("out of memory\n");
-	acpiphp_free_resource(&func->io_head);
-	acpiphp_free_resource(&func->mem_head);
-	acpiphp_free_resource(&func->p_mem_head);
-
-	return -1;
-}
-
-
-/**
- * acpiphp_configure_slot - allocate PCI resources
- * @slot: slot to be configured
- *
- * initializes a PCI functions on a device inserted
- * into the slot
- *
- */
-int acpiphp_configure_slot (struct acpiphp_slot *slot)
-{
-	struct acpiphp_func *func;
-	struct list_head *l;
-	u8 hdr;
-	u32 dvid;
-	int retval = 0;
-	int is_multi = 0;
-
-	pci_bus_read_config_byte(slot->bridge->pci_bus,
-				 PCI_DEVFN(slot->device, 0),
-				 PCI_HEADER_TYPE, &hdr);
-
-	if (hdr & 0x80)
-		is_multi = 1;
-
-	list_for_each (l, &slot->funcs) {
-		func = list_entry(l, struct acpiphp_func, sibling);
-		if (is_multi || func->function == 0) {
-			pci_bus_read_config_dword(slot->bridge->pci_bus,
-						  PCI_DEVFN(slot->device,
-							    func->function),
-						  PCI_VENDOR_ID, &dvid);
-			if (dvid != 0xffffffff) {
-				retval = init_config_space(func);
-				if (retval)
-					break;
-			}
-		}
-	}
-
-	return retval;
-}
-
-/**
- * acpiphp_configure_function - configure PCI function
- * @func: function to be configured
- *
- * initializes a PCI functions on a device inserted
- * into the slot
- *
- */
-int acpiphp_configure_function (struct acpiphp_func *func)
-{
-	/* all handled by the pci core now */
-	return 0;
-}
-
-/**
- * acpiphp_unconfigure_function - unconfigure PCI function
- * @func: function to be unconfigured
- *
- */
-void acpiphp_unconfigure_function (struct acpiphp_func *func)
-{
-	struct acpiphp_bridge *bridge;
-
-	/* if pci_dev is NULL, ignore it */
-	if (!func->pci_dev)
-		return;
-
-	pci_remove_bus_device(func->pci_dev);
-
-	/* free all resources */
-	bridge = func->slot->bridge;
-
-	spin_lock(&bridge->res_lock);
-	acpiphp_move_resource(&func->io_head, &bridge->io_head);
-	acpiphp_move_resource(&func->mem_head, &bridge->mem_head);
-	acpiphp_move_resource(&func->p_mem_head, &bridge->p_mem_head);
-	acpiphp_move_resource(&func->bus_head, &bridge->bus_head);
-	spin_unlock(&bridge->res_lock);
-}
diff --git a/drivers/pci/hotplug/acpiphp_res.c b/drivers/pci/hotplug/acpiphp_res.c
deleted file mode 100644
--- a/drivers/pci/hotplug/acpiphp_res.c
+++ /dev/null
@@ -1,700 +0,0 @@
-/*
- * ACPI PCI HotPlug Utility functions
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (C) 2002 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (C) 2002 NEC Corporation
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
- * Send feedback to <gregkh@us.ibm.com>, <t-kochi@bq.jp.nec.com>
- *
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/sysctl.h>
-#include <linux/pci.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/timer.h>
-
-#include <linux/ioctl.h>
-#include <linux/fcntl.h>
-
-#include <linux/list.h>
-
-#include "pci_hotplug.h"
-#include "acpiphp.h"
-
-#define MY_NAME "acpiphp_res"
-
-
-/*
- * sort_by_size - sort nodes by their length, smallest first
- */
-static int sort_by_size(struct pci_resource **head)
-{
-	struct pci_resource *current_res;
-	struct pci_resource *next_res;
-	int out_of_order = 1;
-
-	if (!(*head))
-		return 1;
-
-	if (!((*head)->next))
-		return 0;
-
-	while (out_of_order) {
-		out_of_order = 0;
-
-		/* Special case for swapping list head */
-		if (((*head)->next) &&
-		    ((*head)->length > (*head)->next->length)) {
-			out_of_order++;
-			current_res = *head;
-			*head = (*head)->next;
-			current_res->next = (*head)->next;
-			(*head)->next = current_res;
-		}
-
-		current_res = *head;
-
-		while (current_res->next && current_res->next->next) {
-			if (current_res->next->length > current_res->next->next->length) {
-				out_of_order++;
-				next_res = current_res->next;
-				current_res->next = current_res->next->next;
-				current_res = current_res->next;
-				next_res->next = current_res->next;
-				current_res->next = next_res;
-			} else
-				current_res = current_res->next;
-		}
-	}  /* End of out_of_order loop */
-
-	return 0;
-}
-
-#if 0
-/*
- * sort_by_max_size - sort nodes by their length, largest first
- */
-static int sort_by_max_size(struct pci_resource **head)
-{
-	struct pci_resource *current_res;
-	struct pci_resource *next_res;
-	int out_of_order = 1;
-
-	if (!(*head))
-		return 1;
-
-	if (!((*head)->next))
-		return 0;
-
-	while (out_of_order) {
-		out_of_order = 0;
-
-		/* Special case for swapping list head */
-		if (((*head)->next) &&
-		    ((*head)->length < (*head)->next->length)) {
-			out_of_order++;
-			current_res = *head;
-			*head = (*head)->next;
-			current_res->next = (*head)->next;
-			(*head)->next = current_res;
-		}
-
-		current_res = *head;
-
-		while (current_res->next && current_res->next->next) {
-			if (current_res->next->length < current_res->next->next->length) {
-				out_of_order++;
-				next_res = current_res->next;
-				current_res->next = current_res->next->next;
-				current_res = current_res->next;
-				next_res->next = current_res->next;
-				current_res->next = next_res;
-			} else
-				current_res = current_res->next;
-		}
-	}  /* End of out_of_order loop */
-
-	return 0;
-}
-#endif
-
-/**
- * get_io_resource - get resource for I/O ports
- *
- * this function sorts the resource list by size and then
- * returns the first node of "size" length that is not in the
- * ISA aliasing window.  If it finds a node larger than "size"
- * it will split it up.
- *
- * size must be a power of two.
- *
- * difference from get_resource is handling of ISA aliasing space.
- *
- */
-struct pci_resource *acpiphp_get_io_resource (struct pci_resource **head, u32 size)
-{
-	struct pci_resource *prevnode;
-	struct pci_resource *node;
-	struct pci_resource *split_node;
-	u64 temp_qword;
-
-	if (!(*head))
-		return NULL;
-
-	if (acpiphp_resource_sort_and_combine(head))
-		return NULL;
-
-	if (sort_by_size(head))
-		return NULL;
-
-	for (node = *head; node; node = node->next) {
-		if (node->length < size)
-			continue;
-
-		if (node->base & (size - 1)) {
-			/* this one isn't base aligned properly
-			   so we'll make a new entry and split it up */
-			temp_qword = (node->base | (size-1)) + 1;
-
-			/* Short circuit if adjusted size is too small */
-			if ((node->length - (temp_qword - node->base)) < size)
-				continue;
-
-			split_node = acpiphp_make_resource(node->base, temp_qword - node->base);
-
-			if (!split_node)
-				return NULL;
-
-			node->base = temp_qword;
-			node->length -= split_node->length;
-
-			/* Put it in the list */
-			split_node->next = node->next;
-			node->next = split_node;
-		} /* End of non-aligned base */
-
-		/* Don't need to check if too small since we already did */
-		if (node->length > size) {
-			/* this one is longer than we need
-			   so we'll make a new entry and split it up */
-			split_node = acpiphp_make_resource(node->base + size, node->length - size);
-
-			if (!split_node)
-				return NULL;
-
-			node->length = size;
-
-			/* Put it in the list */
-			split_node->next = node->next;
-			node->next = split_node;
-		}  /* End of too big on top end */
-
-		/* For IO make sure it's not in the ISA aliasing space */
-		if ((node->base & 0x300L) && !(node->base & 0xfffff000))
-			continue;
-
-		/* If we got here, then it is the right size
-		   Now take it out of the list */
-		if (*head == node) {
-			*head = node->next;
-		} else {
-			prevnode = *head;
-			while (prevnode->next != node)
-				prevnode = prevnode->next;
-
-			prevnode->next = node->next;
-		}
-		node->next = NULL;
-		/* Stop looping */
-		break;
-	}
-
-	return node;
-}
-
-
-#if 0
-/**
- * get_max_resource - get the largest resource
- *
- * Gets the largest node that is at least "size" big from the
- * list pointed to by head.  It aligns the node on top and bottom
- * to "size" alignment before returning it.
- */
-static struct pci_resource *acpiphp_get_max_resource (struct pci_resource **head, u32 size)
-{
-	struct pci_resource *max;
-	struct pci_resource *temp;
-	struct pci_resource *split_node;
-	u64 temp_qword;
-
-	if (!(*head))
-		return NULL;
-
-	if (acpiphp_resource_sort_and_combine(head))
-		return NULL;
-
-	if (sort_by_max_size(head))
-		return NULL;
-
-	for (max = *head;max; max = max->next) {
-
-		/* If not big enough we could probably just bail,
-		   instead we'll continue to the next. */
-		if (max->length < size)
-			continue;
-
-		if (max->base & (size - 1)) {
-			/* this one isn't base aligned properly
-			   so we'll make a new entry and split it up */
-			temp_qword = (max->base | (size-1)) + 1;
-
-			/* Short circuit if adjusted size is too small */
-			if ((max->length - (temp_qword - max->base)) < size)
-				continue;
-
-			split_node = acpiphp_make_resource(max->base, temp_qword - max->base);
-
-			if (!split_node)
-				return NULL;
-
-			max->base = temp_qword;
-			max->length -= split_node->length;
-
-			/* Put it next in the list */
-			split_node->next = max->next;
-			max->next = split_node;
-		}
-
-		if ((max->base + max->length) & (size - 1)) {
-			/* this one isn't end aligned properly at the top
-			   so we'll make a new entry and split it up */
-			temp_qword = ((max->base + max->length) & ~(size - 1));
-
-			split_node = acpiphp_make_resource(temp_qword,
-							   max->length + max->base - temp_qword);
-
-			if (!split_node)
-				return NULL;
-
-			max->length -= split_node->length;
-
-			/* Put it in the list */
-			split_node->next = max->next;
-			max->next = split_node;
-		}
-
-		/* Make sure it didn't shrink too much when we aligned it */
-		if (max->length < size)
-			continue;
-
-		/* Now take it out of the list */
-		temp = (struct pci_resource*) *head;
-		if (temp == max) {
-			*head = max->next;
-		} else {
-			while (temp && temp->next != max) {
-				temp = temp->next;
-			}
-
-			temp->next = max->next;
-		}
-
-		max->next = NULL;
-		return max;
-	}
-
-	/* If we get here, we couldn't find one */
-	return NULL;
-}
-#endif
-
-/**
- * get_resource - get resource (mem, pfmem)
- *
- * this function sorts the resource list by size and then
- * returns the first node of "size" length.  If it finds a node
- * larger than "size" it will split it up.
- *
- * size must be a power of two.
- *
- */
-struct pci_resource *acpiphp_get_resource (struct pci_resource **head, u32 size)
-{
-	struct pci_resource *prevnode;
-	struct pci_resource *node;
-	struct pci_resource *split_node;
-	u64 temp_qword;
-
-	if (!(*head))
-		return NULL;
-
-	if (acpiphp_resource_sort_and_combine(head))
-		return NULL;
-
-	if (sort_by_size(head))
-		return NULL;
-
-	for (node = *head; node; node = node->next) {
-		dbg("%s: req_size =%x node=%p, base=%x, length=%x\n",
-		    __FUNCTION__, size, node, (u32)node->base, node->length);
-		if (node->length < size)
-			continue;
-
-		if (node->base & (size - 1)) {
-			dbg("%s: not aligned\n", __FUNCTION__);
-			/* this one isn't base aligned properly
-			   so we'll make a new entry and split it up */
-			temp_qword = (node->base | (size-1)) + 1;
-
-			/* Short circuit if adjusted size is too small */
-			if ((node->length - (temp_qword - node->base)) < size)
-				continue;
-
-			split_node = acpiphp_make_resource(node->base, temp_qword - node->base);
-
-			if (!split_node)
-				return NULL;
-
-			node->base = temp_qword;
-			node->length -= split_node->length;
-
-			/* Put it in the list */
-			split_node->next = node->next;
-			node->next = split_node;
-		} /* End of non-aligned base */
-
-		/* Don't need to check if too small since we already did */
-		if (node->length > size) {
-			dbg("%s: too big\n", __FUNCTION__);
-			/* this one is longer than we need
-			   so we'll make a new entry and split it up */
-			split_node = acpiphp_make_resource(node->base + size, node->length - size);
-
-			if (!split_node)
-				return NULL;
-
-			node->length = size;
-
-			/* Put it in the list */
-			split_node->next = node->next;
-			node->next = split_node;
-		}  /* End of too big on top end */
-
-		dbg("%s: got one!!!\n", __FUNCTION__);
-		/* If we got here, then it is the right size
-		   Now take it out of the list */
-		if (*head == node) {
-			*head = node->next;
-		} else {
-			prevnode = *head;
-			while (prevnode->next != node)
-				prevnode = prevnode->next;
-
-			prevnode->next = node->next;
-		}
-		node->next = NULL;
-		/* Stop looping */
-		break;
-	}
-	return node;
-}
-
-/**
- * get_resource_with_base - get resource with specific base address
- *
- * this function
- * returns the first node of "size" length located at specified base address.
- * If it finds a node larger than "size" it will split it up.
- *
- * size must be a power of two.
- *
- */
-struct pci_resource *acpiphp_get_resource_with_base (struct pci_resource **head, u64 base, u32 size)
-{
-	struct pci_resource *prevnode;
-	struct pci_resource *node;
-	struct pci_resource *split_node;
-	u64 temp_qword;
-
-	if (!(*head))
-		return NULL;
-
-	if (acpiphp_resource_sort_and_combine(head))
-		return NULL;
-
-	for (node = *head; node; node = node->next) {
-		dbg(": 1st req_base=%x req_size =%x node=%p, base=%x, length=%x\n",
-		    (u32)base, size, node, (u32)node->base, node->length);
-		if (node->base > base)
-			continue;
-
-		if ((node->base + node->length) < (base + size))
-			continue;
-
-		if (node->base < base) {
-			dbg(": split 1\n");
-			/* this one isn't base aligned properly
-			   so we'll make a new entry and split it up */
-			temp_qword = base;
-
-			/* Short circuit if adjusted size is too small */
-			if ((node->length - (temp_qword - node->base)) < size)
-				continue;
-
-			split_node = acpiphp_make_resource(node->base, temp_qword - node->base);
-
-			if (!split_node)
-				return NULL;
-
-			node->base = temp_qword;
-			node->length -= split_node->length;
-
-			/* Put it in the list */
-			split_node->next = node->next;
-			node->next = split_node;
-		}
-
-		dbg(": 2nd req_base=%x req_size =%x node=%p, base=%x, length=%x\n",
-		    (u32)base, size, node, (u32)node->base, node->length);
-
-		/* Don't need to check if too small since we already did */
-		if (node->length > size) {
-			dbg(": split 2\n");
-			/* this one is longer than we need
-			   so we'll make a new entry and split it up */
-			split_node = acpiphp_make_resource(node->base + size, node->length - size);
-
-			if (!split_node)
-				return NULL;
-
-			node->length = size;
-
-			/* Put it in the list */
-			split_node->next = node->next;
-			node->next = split_node;
-		}  /* End of too big on top end */
-
-		dbg(": got one!!!\n");
-		/* If we got here, then it is the right size
-		   Now take it out of the list */
-		if (*head == node) {
-			*head = node->next;
-		} else {
-			prevnode = *head;
-			while (prevnode->next != node)
-				prevnode = prevnode->next;
-
-			prevnode->next = node->next;
-		}
-		node->next = NULL;
-		/* Stop looping */
-		break;
-	}
-	return node;
-}
-
-
-/**
- * acpiphp_resource_sort_and_combine
- *
- * Sorts all of the nodes in the list in ascending order by
- * their base addresses.  Also does garbage collection by
- * combining adjacent nodes.
- *
- * returns 0 if success
- */
-int acpiphp_resource_sort_and_combine (struct pci_resource **head)
-{
-	struct pci_resource *node1;
-	struct pci_resource *node2;
-	int out_of_order = 1;
-
-	if (!(*head))
-		return 1;
-
-	dbg("*head->next = %p\n",(*head)->next);
-
-	if (!(*head)->next)
-		return 0;	/* only one item on the list, already sorted! */
-
-	dbg("*head->base = 0x%x\n",(u32)(*head)->base);
-	dbg("*head->next->base = 0x%x\n", (u32)(*head)->next->base);
-	while (out_of_order) {
-		out_of_order = 0;
-
-		/* Special case for swapping list head */
-		if (((*head)->next) &&
-		    ((*head)->base > (*head)->next->base)) {
-			node1 = *head;
-			(*head) = (*head)->next;
-			node1->next = (*head)->next;
-			(*head)->next = node1;
-			out_of_order++;
-		}
-
-		node1 = (*head);
-
-		while (node1->next && node1->next->next) {
-			if (node1->next->base > node1->next->next->base) {
-				out_of_order++;
-				node2 = node1->next;
-				node1->next = node1->next->next;
-				node1 = node1->next;
-				node2->next = node1->next;
-				node1->next = node2;
-			} else
-				node1 = node1->next;
-		}
-	}  /* End of out_of_order loop */
-
-	node1 = *head;
-
-	while (node1 && node1->next) {
-		if ((node1->base + node1->length) == node1->next->base) {
-			/* Combine */
-			dbg("8..\n");
-			node1->length += node1->next->length;
-			node2 = node1->next;
-			node1->next = node1->next->next;
-			kfree(node2);
-		} else
-			node1 = node1->next;
-	}
-
-	return 0;
-}
-
-
-/**
- * acpiphp_make_resource - make resource structure
- * @base: base address of a resource
- * @length: length of a resource
- */
-struct pci_resource *acpiphp_make_resource (u64 base, u32 length)
-{
-	struct pci_resource *res;
-
-	res = kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
-	if (res) {
-		memset(res, 0, sizeof(struct pci_resource));
-		res->base = base;
-		res->length = length;
-	}
-
-	return res;
-}
-
-
-/**
- * acpiphp_move_resource - move linked resources from one to another
- * @from: head of linked resource list
- * @to: head of linked resource list
- */
-void acpiphp_move_resource (struct pci_resource **from, struct pci_resource **to)
-{
-	struct pci_resource *tmp;
-
-	while (*from) {
-		tmp = (*from)->next;
-		(*from)->next = *to;
-		*to = *from;
-		*from = tmp;
-	}
-
-	/* *from = NULL is guaranteed */
-}
-
-
-/**
- * acpiphp_free_resource - free all linked resources
- * @res: head of linked resource list
- */
-void acpiphp_free_resource (struct pci_resource **res)
-{
-	struct pci_resource *tmp;
-
-	while (*res) {
-		tmp = (*res)->next;
-		kfree(*res);
-		*res = tmp;
-	}
-
-	/* *res = NULL is guaranteed */
-}
-
-
-/* debug support functions;  will go away sometime :) */
-static void dump_resource(struct pci_resource *head)
-{
-	struct pci_resource *p;
-	int cnt;
-
-	p = head;
-	cnt = 0;
-
-	while (p) {
-		dbg("[%02d] %08x - %08x\n",
-		    cnt++, (u32)p->base, (u32)p->base + p->length - 1);
-		p = p->next;
-	}
-}
-
-void acpiphp_dump_resource(struct acpiphp_bridge *bridge)
-{
-	dbg("I/O resource:\n");
-	dump_resource(bridge->io_head);
-	dbg("MEM resource:\n");
-	dump_resource(bridge->mem_head);
-	dbg("PMEM resource:\n");
-	dump_resource(bridge->p_mem_head);
-	dbg("BUS resource:\n");
-	dump_resource(bridge->bus_head);
-}
-
-void acpiphp_dump_func_resource(struct acpiphp_func *func)
-{
-	dbg("I/O resource:\n");
-	dump_resource(func->io_head);
-	dbg("MEM resource:\n");
-	dump_resource(func->mem_head);
-	dbg("PMEM resource:\n");
-	dump_resource(func->p_mem_head);
-	dbg("BUS resource:\n");
-	dump_resource(func->bus_head);
-}

