Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270432AbUJUDuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270432AbUJUDuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270532AbUJUD0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:26:17 -0400
Received: from fmr05.intel.com ([134.134.136.6]:53477 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270432AbUJUDII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:08:08 -0400
Subject: [PATCH 4/5]ACPI PNP driver
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Content-Type: multipart/mixed; boundary="=-OPhXXyHzXug7aHAeWIzA"
Message-Id: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 11:00:02 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OPhXXyHzXug7aHAeWIzA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This patch provides an ACPI based PNP driver. It is based on Matthieu
Castet's original work. With this patch, legacy device drivers (floppy
ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
directly use ACPI can be removed, since now we have unified PNP
interface for legacy devices.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li@intel.com>

The patch depends on previous 3 patches.

--- 2.6/drivers/pnp/isapnp/Kconfig.stg3	2004-10-18 17:34:17.591712040
+0800
+++ 2.6/drivers/pnp/isapnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
@@ -3,7 +3,7 @@
 #
 config ISAPNP
 	bool "ISA Plug and Play support"
-	depends on PNP
+	depends on PNP && ISA
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/isapnp.txt>.
--- 2.6/drivers/pnp/pnpbios/Kconfig.stg3	2004-10-18 17:34:31.302627664
+0800
+++ 2.6/drivers/pnp/pnpbios/Kconfig	2004-10-18 19:12:19.805479624 +0800
@@ -3,7 +3,8 @@
 #
 config PNPBIOS
 	bool "Plug and Play BIOS support (EXPERIMENTAL)"
-	depends on PNP && X86 && EXPERIMENTAL
+	depends on PNP && ISA && X86 && EXPERIMENTAL
+	default n
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
 	  Specification Version 1.0A May 5, 1994" to autodetect built-in
--- 2.6/drivers/pnp/pnpbios/core.c.stg3	2004-10-18 17:58:06.372504344
+0800
+++ 2.6/drivers/pnp/pnpbios/core.c	2004-10-18 19:14:41.820890000 +0800
@@ -533,6 +533,15 @@ int __init pnpbios_init(void)
 {
 	int ret;
 
+	/* Don't use pnpbios if pnpacpi is used */
+#ifdef CONFIG_PNPACPI
+	if (!acpi_disabled) {
+		pnpbios_disabled = 1;
+		printk(KERN_INFO "PnPBIOS: Disabled by pnpacpi\n");
+		return -ENODEV;
+	}
+#endif
+
 	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table)) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
@@ -574,6 +583,8 @@ subsys_initcall(pnpbios_init);
 
 static int __init pnpbios_thread_init(void)
 {
+	if (pnpbios_disabled)
+		return 0;
 #ifdef CONFIG_HOTPLUG
 	init_completion(&unload_sem);
 	if (kernel_thread(pnp_dock_thread, NULL, CLONE_KERNEL) > 0)
--- 2.6/drivers/pnp/Kconfig.stg3	2004-10-18 17:30:06.075948248 +0800
+++ 2.6/drivers/pnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
@@ -6,7 +6,7 @@ menu "Plug and Play support"
 
 config PNP
 	bool "Plug and Play support"
-	depends on ISA
+	depends on ISA || ACPI_BUS
 	---help---
 	  Plug and Play (PnP) is a standard for peripherals which allows those
 	  peripherals to be configured by software, e.g. assign IRQ's or other
@@ -35,5 +35,7 @@ source "drivers/pnp/isapnp/Kconfig"
 
 source "drivers/pnp/pnpbios/Kconfig"
 
+source "drivers/pnp/pnpacpi/Kconfig"
+
 endmenu
 
--- 2.6/drivers/pnp/Makefile.stg3	2004-10-18 17:30:51.964972056 +0800
+++ 2.6/drivers/pnp/Makefile	2004-10-18 17:36:19.174228688 +0800
@@ -4,5 +4,6 @@
 
 obj-y		:= core.o card.o driver.o resource.o manager.o support.o
interface.o quirks.o system.o
 
+obj-$(CONFIG_PNPACPI)		+= pnpacpi/
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
--- 2.6/drivers/pnp/pnpacpi/core.c.stg3	2004-10-18 18:34:55.532660952
+0800
+++ 2.6/drivers/pnp/pnpacpi/core.c	2004-10-18 19:04:42.528996216 +0800
@@ -0,0 +1,272 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu@free.fr>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li@intel.com>
+ * 
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+ */
+ 
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+#include <acpi/acpi_bus.h>
+#include "pnpacpi.h"
+
+static int num = 0;
+
+static char excluded_id_list[] =
+	"PNP0C0A," /* Battery */
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C09," /* EC */
+	"PNP0C0B," /* Fan */
+	"PNP0A03," /* PCI root */
+	"PNP0C0F," /* Link device */
+	"PNP0000," /* PIC */
+	"PNP0100," /* Timer */
+	;
+static inline int is_exclusive_device(struct acpi_device *dev)
+{
+	return (!acpi_match_ids(dev, excluded_id_list));
+}
+
+void *pnpacpi_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc(size, f);
+	if (p)
+		memset(p, 0, size);
+	return p;
+}
+
+/*
+ * Compatible Device IDs
+ */
+#define TEST_HEX(c) \
+	if (!(('0' <= (c) && (c) <= '9') || ('A' <= (c) && (c) <= 'F'))) \
+		return 0
+#define TEST_ALPHA(c) \
+	if (!('@' <= (c) || (c) <= 'Z')) \
+		return 0
+static int ispnpidacpi(char *id)
+{
+	TEST_ALPHA(id[0]);
+	TEST_ALPHA(id[1]);
+	TEST_ALPHA(id[2]);
+	TEST_HEX(id[3]);
+	TEST_HEX(id[4]);
+	TEST_HEX(id[5]);
+	TEST_HEX(id[6]);
+	if (id[7] != '\0')
+		return 0;
+	return 1;
+}
+
+static void pnpidacpi_to_pnpid(char *id, char *str)
+{
+	str[0] = id[0];
+	str[1] = id[1];
+	str[2] = id[2];
+	str[3] = tolower(id[3]);
+	str[4] = tolower(id[4]);
+	str[5] = tolower(id[5]);
+	str[6] = tolower(id[6]);
+	str[7] = '\0';
+}
+
+static int pnpacpi_get_resources(struct pnp_dev * dev, struct
pnp_resource_table * res)
+{
+	acpi_status status;
+	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data, 
+		&dev->res);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+static int pnpacpi_set_resources(struct pnp_dev * dev, struct
pnp_resource_table * res)
+{
+	acpi_handle handle = dev->data;
+	struct acpi_buffer buffer;
+	int ret = 0;
+	acpi_status status;
+
+	ret = pnpacpi_build_resource_template(handle, &buffer);
+	if (ret)
+		return ret;
+	ret = pnpacpi_encode_resources(res, &buffer);
+	if (ret) {
+		kfree(buffer.pointer);
+		return ret;
+	}
+	status = acpi_set_current_resources(handle, &buffer);
+	if (ACPI_FAILURE(status))
+		ret = -EINVAL;
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static int pnpacpi_disable_resources(struct pnp_dev *dev)
+{
+	acpi_status status;
+	
+	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
+	status = acpi_evaluate_object((acpi_handle)dev->data, 
+		"_DIS", NULL, NULL);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+struct pnp_protocol pnpacpi_protocol = {
+	.name	= "Plug and Play ACPI",
+	.get	= pnpacpi_get_resources,
+	.set	= pnpacpi_set_resources,
+	.disable = pnpacpi_disable_resources,
+};
+
+static int acpi_pnp_add(struct acpi_device *device)
+{
+	acpi_handle temp = NULL;
+	acpi_status status;
+	struct pnp_id *dev_id;
+	struct pnp_dev *dev;
+
+	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
+	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	if (!dev) {
+		pnp_err("Out of memory");
+		return -ENOMEM;
+	}
+	dev->data = device->handle;
+	/* .enabled means if the device can decode the resources */
+	dev->active = device->status.enabled;
+	status = acpi_get_handle(device->handle, "_SRS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_CONFIGURABLE;
+	dev->capabilities |= PNP_READ;
+	if (device->flags.dynamic_status)
+		dev->capabilities |= PNP_WRITE;
+	if (device->flags.removable)
+		dev->capabilities |= PNP_REMOVABLE;
+	status = acpi_get_handle(device->handle, "_DIS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_DISABLE;
+
+	dev->protocol = &pnpacpi_protocol;
+
+	if (strlen(acpi_device_name(device)))
+		strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
+	else
+		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
+
+	dev->number = num;
+	
+	/* set the initial values for the PnP device */
+	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id)
+		goto err;
+	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
+	pnp_add_id(dev_id, dev);
+
+	if(dev->active) {
+		/* parse allocated resource */
+		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s", dev_id->id);
+			goto err1;
+		}
+	}
+
+	if(dev->capabilities & PNP_CONFIGURABLE) {
+		status = pnpacpi_parse_resource_option_data(device->handle, 
+			dev);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s", dev_id->id);
+			goto err1;
+		}
+	}
+	
+	/* parse compatible ids */
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+
+		for (i = 0; i < cid_list->count; i++) {
+			if (!ispnpidacpi(cid_list->id[i].value))
+				continue;
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), 
+				GFP_KERNEL);
+			if (!dev_id)
+				continue;
+
+			pnpidacpi_to_pnpid(cid_list->id[i].value, dev_id->id);
+			pnp_add_id(dev_id, dev);
+		}
+	}
+
+	/* clear out the damaged flags */
+	if (!dev->active)
+		pnp_init_resource_table(&dev->res);
+	pnp_add_device(dev);
+	num ++;
+
+	acpi_driver_data(device) = dev;
+	return AE_OK;
+err1:
+	kfree(dev_id);
+err:
+	kfree(dev);
+	return -EINVAL;
+}
+
+static int acpi_pnp_remove (struct acpi_device *device, int type)
+{
+	struct pnp_dev *dev = acpi_driver_data(device);
+	if (!dev)
+		return AE_ERROR;
+
+	pnp_remove_device(dev);
+	return AE_OK;
+}
+
+static int acpi_pnp_match(struct acpi_device *device,
+	struct acpi_driver	*driver)
+{
+	return (!ispnpidacpi(acpi_device_hid(device)) ||
+		is_exclusive_device(device));
+}
+
+/* default acpi PNP device driver, support hotplug */
+static struct acpi_driver acpi_pnp_driver = {
+	.name =		"ACPI PNP Driver",
+	.class =	"acpi_pnp",
+	.ops =		{
+				.add = acpi_pnp_add,
+				.remove = acpi_pnp_remove,
+				.match = acpi_pnp_match,
+			},
+};
+
+int __init pnpacpi_init(void)
+{
+	if (acpi_disabled) {
+		pnp_info("PnP ACPI: ACPI disable");
+		return 0;
+	}
+	pnp_info("PnP ACPI init");
+	pnp_register_protocol(&pnpacpi_protocol);
+	if (acpi_bus_register_driver(&acpi_pnp_driver) < 0)
+		return -ENODEV;
+	pnp_info("PnP ACPI: found %d devices", num);
+	return 0;
+}
+subsys_initcall(pnpacpi_init);
+
+EXPORT_SYMBOL(pnpacpi_protocol);
--- 2.6/drivers/pnp/pnpacpi/Kconfig.stg3	2004-10-18 18:34:55.532660952
+0800
+++ 2.6/drivers/pnp/pnpacpi/Kconfig	2004-10-18 19:11:42.994075808 +0800
@@ -0,0 +1,18 @@
+#
+# Plug and Play ACPI configuration
+#
+config PNPACPI
+	bool "Plug and Play ACPI support (EXPERIMENTAL)"
+	depends on PNP && ACPI_BUS && EXPERIMENTAL
+	default y
+	---help---
+	  Linux uses the PNPACPI to autodetect built-in
+	  mainboard resources (e.g. parallel port resources).
+
+          Some features (e.g. real hotplug) are not currently
+          implemented.
+
+          If you would like the kernel to detect and allocate resources
to
+          your mainboard devices (on some systems they are disabled by
the
+          BIOS) say Y here.  Also the PNPACPI can help prevent resource
+          conflicts between mainboard devices and other bus devices.
--- 2.6/drivers/pnp/pnpacpi/pnpacpi.h.stg3	2004-10-18 18:34:55.532660952
+0800
+++ 2.6/drivers/pnp/pnpacpi/pnpacpi.h	2004-10-18 17:42:28.023155128
+0800
@@ -0,0 +1,13 @@
+#ifndef ACPI_PNP_H
+#define ACPI_PNP_H
+
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+
+void *pnpacpi_kmalloc(size_t size, int f);
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct
pnp_resource_table*);
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct
pnp_dev*);
+int pnpacpi_encode_resources(struct pnp_resource_table *, struct
acpi_buffer *);
+int pnpacpi_build_resource_template(acpi_handle, struct acpi_buffer*);
+#endif
--- 2.6/drivers/pnp/pnpacpi/Makefile.stg3	2004-10-18 18:34:55.532660952
+0800
+++ 2.6/drivers/pnp/pnpacpi/Makefile	2004-10-18 17:42:28.023155128 +0800
@@ -0,0 +1,5 @@
+#
+# Makefile for the kernel PNPACPI driver.
+#
+
+obj-y := core.o rsparser.o
--- 2.6/drivers/pnp/pnpacpi/rsparser.c.stg3	2004-10-18
18:34:55.532660952 +0800
+++ 2.6/drivers/pnp/pnpacpi/rsparser.c	2004-10-18 17:51:10.961656392
+0800
@@ -0,0 +1,818 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu@free.fr>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li@intel.com>
+ * 
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include "pnpacpi.h"
+
+#ifdef CONFIG_IA64
+#define valid_IRQ(i) (1)
+#else
+#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
+#endif
+
+/*
+ * Allocated Resources
+ */
+static int irq_flags(int edge_level, int active_high_low)
+{
+	int flag;
+	if (edge_level == ACPI_LEVEL_SENSITIVE) {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWLEVEL;
+		else
+			flag = IORESOURCE_IRQ_HIGHLEVEL;
+	}
+	else {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWEDGE;
+		else
+			flag = IORESOURCE_IRQ_HIGHEDGE;
+	}
+	return flag;
+}
+
+static void decode_irq_flags(int flag, int *edge_level, int
*active_high_low)
+{
+	switch (flag) {
+	case IORESOURCE_IRQ_LOWLEVEL:
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHLEVEL:	
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	case IORESOURCE_IRQ_LOWEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res,
int irq)
+{
+	int i = 0;
+	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_IRQ)
+		i++;
+	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET
flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->irq_resource[i].start =(unsigned long) irq;
+		res->irq_resource[i].end = (unsigned long) irq;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res,
int dma)
+{
+	int i = 0;
+	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_DMA)
+		i++;
+	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET
flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->dma_resource[i].start =(unsigned long) dma;
+		res->dma_resource[i].end = (unsigned long) dma;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
+	int io, int len)
+{
+	int i = 0;
+	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_PORT)
+		i++;
+	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET
flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->port_resource[i].start = (unsigned long) io;
+		res->port_resource[i].end = (unsigned long)(io + len - 1);
+	}
+}
+
+static void
+pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
+	int mem, int len)
+{
+	int i = 0;
+	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
+			(i < PNP_MAX_MEM))
+		i++;
+	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET
flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->mem_resource[i].start = (unsigned long) mem;
+		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+	}
+}
+
+
+static acpi_status pnpacpi_allocated_resource(struct acpi_resource
*res,
+	void *data)
+{
+	struct pnp_resource_table * res_table = (struct pnp_resource_table
*)data;
+
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+		if ((res->data.irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.irq.interrupts[0],
+					res->data.irq.edge_level,
+					res->data.irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.irq.interrupts[0]);
+		}
+		break;
+
+	case ACPI_RSTYPE_EXT_IRQ:
+		if ((res->data.extended_irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.extended_irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.extended_irq.interrupts[0],
+					res->data.extended_irq.edge_level,
+					res->data.extended_irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0]);
+		}
+		break;
+	case ACPI_RSTYPE_DMA:
+		if (res->data.dma.number_of_channels > 0)
+			pnpacpi_parse_allocated_dmaresource(res_table, 
+					res->data.dma.channels[0]);
+		break;
+	case ACPI_RSTYPE_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.io.min_base_address, 
+				res->data.io.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.fixed_io.base_address, 
+				res->data.fixed_io.range_length);
+		break;
+	case ACPI_RSTYPE_MEM24:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory24.min_base_address, 
+				res->data.memory24.range_length);
+		break;
+	case ACPI_RSTYPE_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory32.min_base_address, 
+				res->data.memory32.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.fixed_memory32.range_base_address, 
+				res->data.fixed_memory32.range_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS16:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address16.min_address_range, 
+				res->data.address16.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address32.min_address_range, 
+				res->data.address32.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS64:
+		pnpacpi_parse_allocated_memresource(res_table, 
+		res->data.address64.min_address_range, 
+		res->data.address64.address_length);
+		break;
+	default:
+		pnp_warn("PnPACPI: Alloc type : %d not handle", 
+				res->id);
+		return AE_ERROR;
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct
pnp_resource_table * res)
+{
+	/* Blank the resource table values */
+	pnp_init_resource_table(res);
+
+	return acpi_walk_resources(handle, METHOD_NAME__CRS,
pnpacpi_allocated_resource, res);
+}
+
+static void pnpacpi_parse_dma_option(struct pnp_option *option, struct
acpi_resource_dma *p)
+{
+	int i;
+	struct pnp_dma * dma;
+
+	if (p->number_of_channels == 0)
+		return;
+	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
+		return;
+
+	for(i = 0; i < p->number_of_channels; i++)
+		dma->map |= 1 << p->channels[i];
+	dma->flags = 0;
+	if (p->bus_master)
+		dma->flags |= IORESOURCE_DMA_MASTER;
+	switch (p->type) {
+	case ACPI_COMPATIBILITY:
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		break;
+	case ACPI_TYPE_A:
+		dma->flags |= IORESOURCE_DMA_TYPEA;
+		break;
+	case ACPI_TYPE_B:
+		dma->flags |= IORESOURCE_DMA_TYPEB;
+		break;
+	case ACPI_TYPE_F:
+		dma->flags |= IORESOURCE_DMA_TYPEF;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		pnp_err("Invalid DMA type");
+	}
+	switch (p->transfer) {
+	case ACPI_TRANSFER_8:
+		dma->flags |= IORESOURCE_DMA_8BIT;
+		break;
+	case ACPI_TRANSFER_8_16:
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		break;
+	case ACPI_TRANSFER_16:
+		dma->flags |= IORESOURCE_DMA_16BIT;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		pnp_err("Invalid DMA transfer type");
+	}
+
+	pnp_register_dma_resource(option,dma);
+	return;
+}
+
+	
+static void pnpacpi_parse_irq_option(struct pnp_option *option,
+	struct acpi_resource_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+	
+	if (p->number_of_interrupts == 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		__set_bit(p->interrupts[i], irq->map);
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void pnpacpi_parse_ext_irq_option(struct pnp_option *option,
+	struct acpi_resource_ext_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+
+	if (p->number_of_interrupts == 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		__set_bit(p->interrupts[i], irq->map);
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void
+pnpacpi_parse_port_option(struct pnp_option *option,
+	struct acpi_resource_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length == 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = io->min_base_address;
+	port->max = io->max_base_address;
+	port->align = io->alignment;
+	port->size = io->range_length;
+	port->flags = ACPI_DECODE_16 == io->io_decode ? 
+		PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_port_option(struct pnp_option *option,
+	struct acpi_resource_fixed_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length == 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = port->max = io->base_address;
+	port->size = io->range_length;
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_mem24_option(struct pnp_option *option,
+	struct acpi_resource_mem24 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length == 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_mem32_option(struct pnp_option *option,
+	struct acpi_resource_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length == 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
+	struct acpi_resource_fixed_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length == 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = mem->max = p->range_base_address;
+	mem->size = p->range_length;
+	mem->align = 0;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+struct acpipnp_parse_option_s {
+	struct pnp_option *option;
+	struct pnp_dev *dev;
+};
+
+static acpi_status pnpacpi_option_resource(struct acpi_resource *res, 
+	void *data)
+{
+	int priority = 0;
+	struct acpipnp_parse_option_s *parse_data = (struct
acpipnp_parse_option_s *)data;
+	struct pnp_dev *dev = parse_data->dev;
+	struct pnp_option *option = parse_data->option;
+
+	switch (res->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnpacpi_parse_irq_option(option, &res->data.irq);
+			break;
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnpacpi_parse_ext_irq_option(option,
+				&res->data.extended_irq);
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnpacpi_parse_dma_option(option, &res->data.dma);	
+			break;
+		case ACPI_RSTYPE_IO:
+			pnpacpi_parse_port_option(option, &res->data.io);
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnpacpi_parse_fixed_port_option(option,
+				&res->data.fixed_io);
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnpacpi_parse_mem24_option(option, &res->data.memory24);
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnpacpi_parse_mem32_option(option, &res->data.memory32);
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnpacpi_parse_fixed_mem32_option(option,
+				&res->data.fixed_memory32);
+			break;
+		case ACPI_RSTYPE_START_DPF:
+			switch (res->data.start_dpf.compatibility_priority) {
+				case ACPI_GOOD_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_PREFERRED;
+					break;
+					
+				case ACPI_ACCEPTABLE_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_ACCEPTABLE;
+					break;
+
+				case ACPI_SUB_OPTIMAL_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_FUNCTIONAL;
+					break;
+				default:
+					priority = PNP_RES_PRIORITY_INVALID;
+					break;
+			}
+			/* TBD: Considering performace/robustness bits */
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return AE_ERROR;
+			parse_data->option = option;	
+			break;
+		case ACPI_RSTYPE_END_DPF:
+			return AE_CTRL_TERMINATE;
+		default:
+			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
+			return AE_ERROR;
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle, 
+	struct pnp_dev *dev)
+{
+	acpi_status status;
+	struct acpipnp_parse_option_s parse_data;
+
+	parse_data.option = pnp_register_independent_option(dev);
+	if (!parse_data.option)
+		return AE_ERROR;
+	parse_data.dev = dev;
+	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
+		pnpacpi_option_resource, &parse_data);
+
+	return status;
+}
+
+/*
+ * Set resource
+ */
+static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
+	void *data)
+{
+	int *res_cnt = (int *)data;
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*res_cnt) ++;
+	default:
+		return AE_OK;
+	}
+	return AE_OK;
+}
+
+static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
+	void *data)
+{
+	struct acpi_resource **resource = (struct acpi_resource **)data;	
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*resource)->id = res->id;
+		(*resource)++;
+	default:
+		return AE_OK;
+	}
+
+	return AE_OK;
+}
+
+int pnpacpi_build_resource_template(acpi_handle handle, 
+	struct acpi_buffer *buffer)
+{
+	struct acpi_resource *resource;
+	int res_cnt = 0;
+	acpi_status status;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_count_resources, &res_cnt);
+	if (ACPI_FAILURE(status)) {
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	if (!res_cnt)
+		return -EINVAL;
+	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
+	buffer->pointer = pnpacpi_kmalloc(buffer->length - 1, GFP_KERNEL);
+	if (!buffer->pointer)
+		return -ENOMEM;
+	pnp_dbg("Res cnt %d", res_cnt);
+	resource = (struct acpi_resource *)buffer->pointer;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_type_resources, &resource);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer->pointer);
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	/* resource will pointer the end resource now */
+	resource->id = ACPI_RSTYPE_END_TAG;
+
+	return 0;
+}
+
+static void pnpacpi_encode_irq(struct acpi_resource *resource, 
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.irq.edge_level = edge_level;
+	resource->data.irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.irq.number_of_interrupts = 1;
+	resource->data.irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_ext_irq(struct acpi_resource *resource,
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_EXT_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
+	resource->data.extended_irq.edge_level = edge_level;
+	resource->data.extended_irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.extended_irq.number_of_interrupts = 1;
+	resource->data.extended_irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_dma(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_DMA;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
+	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
+		resource->data.dma.type = ACPI_COMPATIBILITY;
+	else if (p->flags & IORESOURCE_DMA_TYPEA)
+		resource->data.dma.type = ACPI_TYPE_A;
+	else if (p->flags & IORESOURCE_DMA_TYPEB)
+		resource->data.dma.type = ACPI_TYPE_B;
+	else if (p->flags & IORESOURCE_DMA_TYPEF)
+		resource->data.dma.type = ACPI_TYPE_F;
+	if (p->flags & IORESOURCE_DMA_8BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8;
+	else if (p->flags & IORESOURCE_DMA_8AND16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8_16;
+	else if (p->flags & IORESOURCE_DMA_16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_16;
+	resource->data.dma.bus_master = p->flags & IORESOURCE_DMA_MASTER;
+	resource->data.dma.number_of_channels = 1;
+	resource->data.dma.channels[0] = p->start;
+}
+
+static void pnpacpi_encode_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_IO;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
+	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
+		ACPI_DECODE_16 : ACPI_DECODE_10; 
+	resource->data.io.min_base_address = p->start;
+	resource->data.io.max_base_address = p->end;
+	resource->data.io.alignment = 0; /* Correct? */
+	resource->data.io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_IO;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_io.base_address = p->start;
+	resource->data.fixed_io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem24(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM24;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
+	resource->data.memory24.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory24.min_base_address = p->start;
+	resource->data.memory24.max_base_address = p->end;
+	resource->data.memory24.alignment = 0;
+	resource->data.memory24.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory32.min_base_address = p->start;
+	resource->data.memory32.max_base_address = p->end;
+	resource->data.memory32.alignment = 0;
+	resource->data.memory32.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.fixed_memory32.range_base_address = p->start;
+	resource->data.fixed_memory32.range_length = p->end - p->start + 1;
+}
+
+int pnpacpi_encode_resources(struct pnp_resource_table *res_table, 
+	struct acpi_buffer *buffer)
+{
+	int i = 0;
+	/* pnpacpi_build_resource_template allocates extra mem */
+	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
+	struct acpi_resource *resource = (struct
acpi_resource*)buffer->pointer;
+	int port = 0, irq = 0, dma = 0, mem = 0;
+
+	pnp_dbg("res cnt %d", res_cnt);
+	while (i < res_cnt) {
+		switch(resource->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnp_dbg("Encode irq");
+			pnpacpi_encode_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnp_dbg("Encode ext irq");
+			pnpacpi_encode_ext_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnp_dbg("Encode dma");
+			pnpacpi_encode_dma(resource, 
+				&res_table->dma_resource[dma]);
+			dma ++;
+			break;
+		case ACPI_RSTYPE_IO:
+			pnp_dbg("Encode io");
+			pnpacpi_encode_io(resource, 
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnp_dbg("Encode fixed io");
+			pnpacpi_encode_fixed_io(resource,
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnp_dbg("Encode mem24");
+			pnpacpi_encode_mem24(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnp_dbg("Encode mem32");
+			pnpacpi_encode_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnp_dbg("Encode fixed mem32");
+			pnpacpi_encode_fixed_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		default: /* other type */
+			pnp_warn("Invalid type");
+			return -EINVAL;
+		}
+		resource ++;
+		i ++;
+	}
+	return 0;
+}
--- 2.6/drivers/pnp/resource.c.stg3	2004-10-18 17:35:32.176373448 +0800
+++ 2.6/drivers/pnp/resource.c	2004-10-18 17:53:34.065901240 +0800
@@ -421,6 +421,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 
 int pnp_check_dma(struct pnp_dev * dev, int idx)
 {
+#ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
 	unsigned long * dma = &dev->res.dma_resource[idx].start;
@@ -470,6 +471,10 @@ int pnp_check_dma(struct pnp_dev * dev, 
 	}
 
 	return 1;
+#else
+	/* IA64 hasn't legacy DMA */
+	return 0;
+#endif
 }
 
 
--- 2.6/include/linux/pnp.h.stg3	2004-10-18 17:35:47.441052864 +0800
+++ 2.6/include/linux/pnp.h	2004-10-18 17:36:19.176228384 +0800
@@ -201,6 +201,7 @@ struct pnp_dev {
 	unsigned short	regs;		/* ISAPnP: supported registers */
 	int 		flags;		/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
+	void *data;
 };
 
 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)


--=-OPhXXyHzXug7aHAeWIzA
Content-Disposition: attachment; filename=pnp-acpi.patch
Content-Type: text/x-patch; name=pnp-acpi.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 2.6/drivers/pnp/isapnp/Kconfig.stg3	2004-10-18 17:34:17.591712040 +0800
+++ 2.6/drivers/pnp/isapnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
@@ -3,7 +3,7 @@
 #
 config ISAPNP
 	bool "ISA Plug and Play support"
-	depends on PNP
+	depends on PNP && ISA
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/isapnp.txt>.
--- 2.6/drivers/pnp/pnpbios/Kconfig.stg3	2004-10-18 17:34:31.302627664 +0800
+++ 2.6/drivers/pnp/pnpbios/Kconfig	2004-10-18 19:12:19.805479624 +0800
@@ -3,7 +3,8 @@
 #
 config PNPBIOS
 	bool "Plug and Play BIOS support (EXPERIMENTAL)"
-	depends on PNP && X86 && EXPERIMENTAL
+	depends on PNP && ISA && X86 && EXPERIMENTAL
+	default n
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
 	  Specification Version 1.0A May 5, 1994" to autodetect built-in
--- 2.6/drivers/pnp/pnpbios/core.c.stg3	2004-10-18 17:58:06.372504344 +0800
+++ 2.6/drivers/pnp/pnpbios/core.c	2004-10-18 19:14:41.820890000 +0800
@@ -533,6 +533,15 @@ int __init pnpbios_init(void)
 {
 	int ret;
 
+	/* Don't use pnpbios if pnpacpi is used */
+#ifdef CONFIG_PNPACPI
+	if (!acpi_disabled) {
+		pnpbios_disabled = 1;
+		printk(KERN_INFO "PnPBIOS: Disabled by pnpacpi\n");
+		return -ENODEV;
+	}
+#endif
+
 	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table)) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
@@ -574,6 +583,8 @@ subsys_initcall(pnpbios_init);
 
 static int __init pnpbios_thread_init(void)
 {
+	if (pnpbios_disabled)
+		return 0;
 #ifdef CONFIG_HOTPLUG
 	init_completion(&unload_sem);
 	if (kernel_thread(pnp_dock_thread, NULL, CLONE_KERNEL) > 0)
--- 2.6/drivers/pnp/Kconfig.stg3	2004-10-18 17:30:06.075948248 +0800
+++ 2.6/drivers/pnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
@@ -6,7 +6,7 @@ menu "Plug and Play support"
 
 config PNP
 	bool "Plug and Play support"
-	depends on ISA
+	depends on ISA || ACPI_BUS
 	---help---
 	  Plug and Play (PnP) is a standard for peripherals which allows those
 	  peripherals to be configured by software, e.g. assign IRQ's or other
@@ -35,5 +35,7 @@ source "drivers/pnp/isapnp/Kconfig"
 
 source "drivers/pnp/pnpbios/Kconfig"
 
+source "drivers/pnp/pnpacpi/Kconfig"
+
 endmenu
 
--- 2.6/drivers/pnp/Makefile.stg3	2004-10-18 17:30:51.964972056 +0800
+++ 2.6/drivers/pnp/Makefile	2004-10-18 17:36:19.174228688 +0800
@@ -4,5 +4,6 @@
 
 obj-y		:= core.o card.o driver.o resource.o manager.o support.o interface.o quirks.o system.o
 
+obj-$(CONFIG_PNPACPI)		+= pnpacpi/
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
--- 2.6/drivers/pnp/pnpacpi/core.c.stg3	2004-10-18 18:34:55.532660952 +0800
+++ 2.6/drivers/pnp/pnpacpi/core.c	2004-10-18 19:04:42.528996216 +0800
@@ -0,0 +1,272 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu@free.fr>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li@intel.com>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+ 
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+#include <acpi/acpi_bus.h>
+#include "pnpacpi.h"
+
+static int num = 0;
+
+static char excluded_id_list[] =
+	"PNP0C0A," /* Battery */
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C09," /* EC */
+	"PNP0C0B," /* Fan */
+	"PNP0A03," /* PCI root */
+	"PNP0C0F," /* Link device */
+	"PNP0000," /* PIC */
+	"PNP0100," /* Timer */
+	;
+static inline int is_exclusive_device(struct acpi_device *dev)
+{
+	return (!acpi_match_ids(dev, excluded_id_list));
+}
+
+void *pnpacpi_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc(size, f);
+	if (p)
+		memset(p, 0, size);
+	return p;
+}
+
+/*
+ * Compatible Device IDs
+ */
+#define TEST_HEX(c) \
+	if (!(('0' <= (c) && (c) <= '9') || ('A' <= (c) && (c) <= 'F'))) \
+		return 0
+#define TEST_ALPHA(c) \
+	if (!('@' <= (c) || (c) <= 'Z')) \
+		return 0
+static int ispnpidacpi(char *id)
+{
+	TEST_ALPHA(id[0]);
+	TEST_ALPHA(id[1]);
+	TEST_ALPHA(id[2]);
+	TEST_HEX(id[3]);
+	TEST_HEX(id[4]);
+	TEST_HEX(id[5]);
+	TEST_HEX(id[6]);
+	if (id[7] != '\0')
+		return 0;
+	return 1;
+}
+
+static void pnpidacpi_to_pnpid(char *id, char *str)
+{
+	str[0] = id[0];
+	str[1] = id[1];
+	str[2] = id[2];
+	str[3] = tolower(id[3]);
+	str[4] = tolower(id[4]);
+	str[5] = tolower(id[5]);
+	str[6] = tolower(id[6]);
+	str[7] = '\0';
+}
+
+static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+{
+	acpi_status status;
+	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data, 
+		&dev->res);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+static int pnpacpi_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+{
+	acpi_handle handle = dev->data;
+	struct acpi_buffer buffer;
+	int ret = 0;
+	acpi_status status;
+
+	ret = pnpacpi_build_resource_template(handle, &buffer);
+	if (ret)
+		return ret;
+	ret = pnpacpi_encode_resources(res, &buffer);
+	if (ret) {
+		kfree(buffer.pointer);
+		return ret;
+	}
+	status = acpi_set_current_resources(handle, &buffer);
+	if (ACPI_FAILURE(status))
+		ret = -EINVAL;
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static int pnpacpi_disable_resources(struct pnp_dev *dev)
+{
+	acpi_status status;
+	
+	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
+	status = acpi_evaluate_object((acpi_handle)dev->data, 
+		"_DIS", NULL, NULL);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+struct pnp_protocol pnpacpi_protocol = {
+	.name	= "Plug and Play ACPI",
+	.get	= pnpacpi_get_resources,
+	.set	= pnpacpi_set_resources,
+	.disable = pnpacpi_disable_resources,
+};
+
+static int acpi_pnp_add(struct acpi_device *device)
+{
+	acpi_handle temp = NULL;
+	acpi_status status;
+	struct pnp_id *dev_id;
+	struct pnp_dev *dev;
+
+	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
+	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	if (!dev) {
+		pnp_err("Out of memory");
+		return -ENOMEM;
+	}
+	dev->data = device->handle;
+	/* .enabled means if the device can decode the resources */
+	dev->active = device->status.enabled;
+	status = acpi_get_handle(device->handle, "_SRS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_CONFIGURABLE;
+	dev->capabilities |= PNP_READ;
+	if (device->flags.dynamic_status)
+		dev->capabilities |= PNP_WRITE;
+	if (device->flags.removable)
+		dev->capabilities |= PNP_REMOVABLE;
+	status = acpi_get_handle(device->handle, "_DIS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_DISABLE;
+
+	dev->protocol = &pnpacpi_protocol;
+
+	if (strlen(acpi_device_name(device)))
+		strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
+	else
+		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
+
+	dev->number = num;
+	
+	/* set the initial values for the PnP device */
+	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id)
+		goto err;
+	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
+	pnp_add_id(dev_id, dev);
+
+	if(dev->active) {
+		/* parse allocated resource */
+		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: METHOD_NAME__CRS failure for %s", dev_id->id);
+			goto err1;
+		}
+	}
+
+	if(dev->capabilities & PNP_CONFIGURABLE) {
+		status = pnpacpi_parse_resource_option_data(device->handle, 
+			dev);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: METHOD_NAME__PRS failure for %s", dev_id->id);
+			goto err1;
+		}
+	}
+	
+	/* parse compatible ids */
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+
+		for (i = 0; i < cid_list->count; i++) {
+			if (!ispnpidacpi(cid_list->id[i].value))
+				continue;
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), 
+				GFP_KERNEL);
+			if (!dev_id)
+				continue;
+
+			pnpidacpi_to_pnpid(cid_list->id[i].value, dev_id->id);
+			pnp_add_id(dev_id, dev);
+		}
+	}
+
+	/* clear out the damaged flags */
+	if (!dev->active)
+		pnp_init_resource_table(&dev->res);
+	pnp_add_device(dev);
+	num ++;
+
+	acpi_driver_data(device) = dev;
+	return AE_OK;
+err1:
+	kfree(dev_id);
+err:
+	kfree(dev);
+	return -EINVAL;
+}
+
+static int acpi_pnp_remove (struct acpi_device *device, int type)
+{
+	struct pnp_dev *dev = acpi_driver_data(device);
+	if (!dev)
+		return AE_ERROR;
+
+	pnp_remove_device(dev);
+	return AE_OK;
+}
+
+static int acpi_pnp_match(struct acpi_device *device,
+	struct acpi_driver	*driver)
+{
+	return (!ispnpidacpi(acpi_device_hid(device)) ||
+		is_exclusive_device(device));
+}
+
+/* default acpi PNP device driver, support hotplug */
+static struct acpi_driver acpi_pnp_driver = {
+	.name =		"ACPI PNP Driver",
+	.class =	"acpi_pnp",
+	.ops =		{
+				.add = acpi_pnp_add,
+				.remove = acpi_pnp_remove,
+				.match = acpi_pnp_match,
+			},
+};
+
+int __init pnpacpi_init(void)
+{
+	if (acpi_disabled) {
+		pnp_info("PnP ACPI: ACPI disable");
+		return 0;
+	}
+	pnp_info("PnP ACPI init");
+	pnp_register_protocol(&pnpacpi_protocol);
+	if (acpi_bus_register_driver(&acpi_pnp_driver) < 0)
+		return -ENODEV;
+	pnp_info("PnP ACPI: found %d devices", num);
+	return 0;
+}
+subsys_initcall(pnpacpi_init);
+
+EXPORT_SYMBOL(pnpacpi_protocol);
--- 2.6/drivers/pnp/pnpacpi/Kconfig.stg3	2004-10-18 18:34:55.532660952 +0800
+++ 2.6/drivers/pnp/pnpacpi/Kconfig	2004-10-18 19:11:42.994075808 +0800
@@ -0,0 +1,18 @@
+#
+# Plug and Play ACPI configuration
+#
+config PNPACPI
+	bool "Plug and Play ACPI support (EXPERIMENTAL)"
+	depends on PNP && ACPI_BUS && EXPERIMENTAL
+	default y
+	---help---
+	  Linux uses the PNPACPI to autodetect built-in
+	  mainboard resources (e.g. parallel port resources).
+
+          Some features (e.g. real hotplug) are not currently
+          implemented.
+
+          If you would like the kernel to detect and allocate resources to
+          your mainboard devices (on some systems they are disabled by the
+          BIOS) say Y here.  Also the PNPACPI can help prevent resource
+          conflicts between mainboard devices and other bus devices.
--- 2.6/drivers/pnp/pnpacpi/pnpacpi.h.stg3	2004-10-18 18:34:55.532660952 +0800
+++ 2.6/drivers/pnp/pnpacpi/pnpacpi.h	2004-10-18 17:42:28.023155128 +0800
@@ -0,0 +1,13 @@
+#ifndef ACPI_PNP_H
+#define ACPI_PNP_H
+
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+
+void *pnpacpi_kmalloc(size_t size, int f);
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct pnp_resource_table*);
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct pnp_dev*);
+int pnpacpi_encode_resources(struct pnp_resource_table *, struct acpi_buffer *);
+int pnpacpi_build_resource_template(acpi_handle, struct acpi_buffer*);
+#endif
--- 2.6/drivers/pnp/pnpacpi/Makefile.stg3	2004-10-18 18:34:55.532660952 +0800
+++ 2.6/drivers/pnp/pnpacpi/Makefile	2004-10-18 17:42:28.023155128 +0800
@@ -0,0 +1,5 @@
+#
+# Makefile for the kernel PNPACPI driver.
+#
+
+obj-y := core.o rsparser.o
--- 2.6/drivers/pnp/pnpacpi/rsparser.c.stg3	2004-10-18 18:34:55.532660952 +0800
+++ 2.6/drivers/pnp/pnpacpi/rsparser.c	2004-10-18 17:51:10.961656392 +0800
@@ -0,0 +1,818 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu@free.fr>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li@intel.com>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include "pnpacpi.h"
+
+#ifdef CONFIG_IA64
+#define valid_IRQ(i) (1)
+#else
+#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
+#endif
+
+/*
+ * Allocated Resources
+ */
+static int irq_flags(int edge_level, int active_high_low)
+{
+	int flag;
+	if (edge_level == ACPI_LEVEL_SENSITIVE) {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWLEVEL;
+		else
+			flag = IORESOURCE_IRQ_HIGHLEVEL;
+	}
+	else {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWEDGE;
+		else
+			flag = IORESOURCE_IRQ_HIGHEDGE;
+	}
+	return flag;
+}
+
+static void decode_irq_flags(int flag, int *edge_level, int *active_high_low)
+{
+	switch (flag) {
+	case IORESOURCE_IRQ_LOWLEVEL:
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHLEVEL:	
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	case IORESOURCE_IRQ_LOWEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+{
+	int i = 0;
+	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_IRQ)
+		i++;
+	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->irq_resource[i].start =(unsigned long) irq;
+		res->irq_resource[i].end = (unsigned long) irq;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+{
+	int i = 0;
+	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_DMA)
+		i++;
+	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->dma_resource[i].start =(unsigned long) dma;
+		res->dma_resource[i].end = (unsigned long) dma;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
+	int io, int len)
+{
+	int i = 0;
+	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_PORT)
+		i++;
+	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->port_resource[i].start = (unsigned long) io;
+		res->port_resource[i].end = (unsigned long)(io + len - 1);
+	}
+}
+
+static void
+pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
+	int mem, int len)
+{
+	int i = 0;
+	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
+			(i < PNP_MAX_MEM))
+		i++;
+	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->mem_resource[i].start = (unsigned long) mem;
+		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+	}
+}
+
+
+static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
+	void *data)
+{
+	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
+
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+		if ((res->data.irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.irq.interrupts[0],
+					res->data.irq.edge_level,
+					res->data.irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.irq.interrupts[0]);
+		}
+		break;
+
+	case ACPI_RSTYPE_EXT_IRQ:
+		if ((res->data.extended_irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.extended_irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.extended_irq.interrupts[0],
+					res->data.extended_irq.edge_level,
+					res->data.extended_irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0]);
+		}
+		break;
+	case ACPI_RSTYPE_DMA:
+		if (res->data.dma.number_of_channels > 0)
+			pnpacpi_parse_allocated_dmaresource(res_table, 
+					res->data.dma.channels[0]);
+		break;
+	case ACPI_RSTYPE_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.io.min_base_address, 
+				res->data.io.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.fixed_io.base_address, 
+				res->data.fixed_io.range_length);
+		break;
+	case ACPI_RSTYPE_MEM24:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory24.min_base_address, 
+				res->data.memory24.range_length);
+		break;
+	case ACPI_RSTYPE_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory32.min_base_address, 
+				res->data.memory32.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.fixed_memory32.range_base_address, 
+				res->data.fixed_memory32.range_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS16:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address16.min_address_range, 
+				res->data.address16.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address32.min_address_range, 
+				res->data.address32.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS64:
+		pnpacpi_parse_allocated_memresource(res_table, 
+		res->data.address64.min_address_range, 
+		res->data.address64.address_length);
+		break;
+	default:
+		pnp_warn("PnPACPI: Alloc type : %d not handle", 
+				res->id);
+		return AE_ERROR;
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct pnp_resource_table * res)
+{
+	/* Blank the resource table values */
+	pnp_init_resource_table(res);
+
+	return acpi_walk_resources(handle, METHOD_NAME__CRS, pnpacpi_allocated_resource, res);
+}
+
+static void pnpacpi_parse_dma_option(struct pnp_option *option, struct acpi_resource_dma *p)
+{
+	int i;
+	struct pnp_dma * dma;
+
+	if (p->number_of_channels == 0)
+		return;
+	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
+		return;
+
+	for(i = 0; i < p->number_of_channels; i++)
+		dma->map |= 1 << p->channels[i];
+	dma->flags = 0;
+	if (p->bus_master)
+		dma->flags |= IORESOURCE_DMA_MASTER;
+	switch (p->type) {
+	case ACPI_COMPATIBILITY:
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		break;
+	case ACPI_TYPE_A:
+		dma->flags |= IORESOURCE_DMA_TYPEA;
+		break;
+	case ACPI_TYPE_B:
+		dma->flags |= IORESOURCE_DMA_TYPEB;
+		break;
+	case ACPI_TYPE_F:
+		dma->flags |= IORESOURCE_DMA_TYPEF;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		pnp_err("Invalid DMA type");
+	}
+	switch (p->transfer) {
+	case ACPI_TRANSFER_8:
+		dma->flags |= IORESOURCE_DMA_8BIT;
+		break;
+	case ACPI_TRANSFER_8_16:
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		break;
+	case ACPI_TRANSFER_16:
+		dma->flags |= IORESOURCE_DMA_16BIT;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		pnp_err("Invalid DMA transfer type");
+	}
+
+	pnp_register_dma_resource(option,dma);
+	return;
+}
+
+	
+static void pnpacpi_parse_irq_option(struct pnp_option *option,
+	struct acpi_resource_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+	
+	if (p->number_of_interrupts == 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		__set_bit(p->interrupts[i], irq->map);
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void pnpacpi_parse_ext_irq_option(struct pnp_option *option,
+	struct acpi_resource_ext_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+
+	if (p->number_of_interrupts == 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		__set_bit(p->interrupts[i], irq->map);
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void
+pnpacpi_parse_port_option(struct pnp_option *option,
+	struct acpi_resource_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length == 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = io->min_base_address;
+	port->max = io->max_base_address;
+	port->align = io->alignment;
+	port->size = io->range_length;
+	port->flags = ACPI_DECODE_16 == io->io_decode ? 
+		PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_port_option(struct pnp_option *option,
+	struct acpi_resource_fixed_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length == 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = port->max = io->base_address;
+	port->size = io->range_length;
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_mem24_option(struct pnp_option *option,
+	struct acpi_resource_mem24 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length == 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_mem32_option(struct pnp_option *option,
+	struct acpi_resource_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length == 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
+	struct acpi_resource_fixed_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length == 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = mem->max = p->range_base_address;
+	mem->size = p->range_length;
+	mem->align = 0;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+struct acpipnp_parse_option_s {
+	struct pnp_option *option;
+	struct pnp_dev *dev;
+};
+
+static acpi_status pnpacpi_option_resource(struct acpi_resource *res, 
+	void *data)
+{
+	int priority = 0;
+	struct acpipnp_parse_option_s *parse_data = (struct acpipnp_parse_option_s *)data;
+	struct pnp_dev *dev = parse_data->dev;
+	struct pnp_option *option = parse_data->option;
+
+	switch (res->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnpacpi_parse_irq_option(option, &res->data.irq);
+			break;
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnpacpi_parse_ext_irq_option(option,
+				&res->data.extended_irq);
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnpacpi_parse_dma_option(option, &res->data.dma);	
+			break;
+		case ACPI_RSTYPE_IO:
+			pnpacpi_parse_port_option(option, &res->data.io);
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnpacpi_parse_fixed_port_option(option,
+				&res->data.fixed_io);
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnpacpi_parse_mem24_option(option, &res->data.memory24);
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnpacpi_parse_mem32_option(option, &res->data.memory32);
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnpacpi_parse_fixed_mem32_option(option,
+				&res->data.fixed_memory32);
+			break;
+		case ACPI_RSTYPE_START_DPF:
+			switch (res->data.start_dpf.compatibility_priority) {
+				case ACPI_GOOD_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_PREFERRED;
+					break;
+					
+				case ACPI_ACCEPTABLE_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_ACCEPTABLE;
+					break;
+
+				case ACPI_SUB_OPTIMAL_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_FUNCTIONAL;
+					break;
+				default:
+					priority = PNP_RES_PRIORITY_INVALID;
+					break;
+			}
+			/* TBD: Considering performace/robustness bits */
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return AE_ERROR;
+			parse_data->option = option;	
+			break;
+		case ACPI_RSTYPE_END_DPF:
+			return AE_CTRL_TERMINATE;
+		default:
+			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
+			return AE_ERROR;
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle, 
+	struct pnp_dev *dev)
+{
+	acpi_status status;
+	struct acpipnp_parse_option_s parse_data;
+
+	parse_data.option = pnp_register_independent_option(dev);
+	if (!parse_data.option)
+		return AE_ERROR;
+	parse_data.dev = dev;
+	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
+		pnpacpi_option_resource, &parse_data);
+
+	return status;
+}
+
+/*
+ * Set resource
+ */
+static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
+	void *data)
+{
+	int *res_cnt = (int *)data;
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*res_cnt) ++;
+	default:
+		return AE_OK;
+	}
+	return AE_OK;
+}
+
+static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
+	void *data)
+{
+	struct acpi_resource **resource = (struct acpi_resource **)data;	
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*resource)->id = res->id;
+		(*resource)++;
+	default:
+		return AE_OK;
+	}
+
+	return AE_OK;
+}
+
+int pnpacpi_build_resource_template(acpi_handle handle, 
+	struct acpi_buffer *buffer)
+{
+	struct acpi_resource *resource;
+	int res_cnt = 0;
+	acpi_status status;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_count_resources, &res_cnt);
+	if (ACPI_FAILURE(status)) {
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	if (!res_cnt)
+		return -EINVAL;
+	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
+	buffer->pointer = pnpacpi_kmalloc(buffer->length - 1, GFP_KERNEL);
+	if (!buffer->pointer)
+		return -ENOMEM;
+	pnp_dbg("Res cnt %d", res_cnt);
+	resource = (struct acpi_resource *)buffer->pointer;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_type_resources, &resource);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer->pointer);
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	/* resource will pointer the end resource now */
+	resource->id = ACPI_RSTYPE_END_TAG;
+
+	return 0;
+}
+
+static void pnpacpi_encode_irq(struct acpi_resource *resource, 
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.irq.edge_level = edge_level;
+	resource->data.irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.irq.number_of_interrupts = 1;
+	resource->data.irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_ext_irq(struct acpi_resource *resource,
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_EXT_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
+	resource->data.extended_irq.edge_level = edge_level;
+	resource->data.extended_irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.extended_irq.number_of_interrupts = 1;
+	resource->data.extended_irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_dma(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_DMA;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
+	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
+		resource->data.dma.type = ACPI_COMPATIBILITY;
+	else if (p->flags & IORESOURCE_DMA_TYPEA)
+		resource->data.dma.type = ACPI_TYPE_A;
+	else if (p->flags & IORESOURCE_DMA_TYPEB)
+		resource->data.dma.type = ACPI_TYPE_B;
+	else if (p->flags & IORESOURCE_DMA_TYPEF)
+		resource->data.dma.type = ACPI_TYPE_F;
+	if (p->flags & IORESOURCE_DMA_8BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8;
+	else if (p->flags & IORESOURCE_DMA_8AND16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8_16;
+	else if (p->flags & IORESOURCE_DMA_16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_16;
+	resource->data.dma.bus_master = p->flags & IORESOURCE_DMA_MASTER;
+	resource->data.dma.number_of_channels = 1;
+	resource->data.dma.channels[0] = p->start;
+}
+
+static void pnpacpi_encode_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_IO;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
+	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
+		ACPI_DECODE_16 : ACPI_DECODE_10; 
+	resource->data.io.min_base_address = p->start;
+	resource->data.io.max_base_address = p->end;
+	resource->data.io.alignment = 0; /* Correct? */
+	resource->data.io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_IO;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_io.base_address = p->start;
+	resource->data.fixed_io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem24(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM24;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
+	resource->data.memory24.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory24.min_base_address = p->start;
+	resource->data.memory24.max_base_address = p->end;
+	resource->data.memory24.alignment = 0;
+	resource->data.memory24.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory32.min_base_address = p->start;
+	resource->data.memory32.max_base_address = p->end;
+	resource->data.memory32.alignment = 0;
+	resource->data.memory32.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.fixed_memory32.range_base_address = p->start;
+	resource->data.fixed_memory32.range_length = p->end - p->start + 1;
+}
+
+int pnpacpi_encode_resources(struct pnp_resource_table *res_table, 
+	struct acpi_buffer *buffer)
+{
+	int i = 0;
+	/* pnpacpi_build_resource_template allocates extra mem */
+	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
+	struct acpi_resource *resource = (struct acpi_resource*)buffer->pointer;
+	int port = 0, irq = 0, dma = 0, mem = 0;
+
+	pnp_dbg("res cnt %d", res_cnt);
+	while (i < res_cnt) {
+		switch(resource->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnp_dbg("Encode irq");
+			pnpacpi_encode_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnp_dbg("Encode ext irq");
+			pnpacpi_encode_ext_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnp_dbg("Encode dma");
+			pnpacpi_encode_dma(resource, 
+				&res_table->dma_resource[dma]);
+			dma ++;
+			break;
+		case ACPI_RSTYPE_IO:
+			pnp_dbg("Encode io");
+			pnpacpi_encode_io(resource, 
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnp_dbg("Encode fixed io");
+			pnpacpi_encode_fixed_io(resource,
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnp_dbg("Encode mem24");
+			pnpacpi_encode_mem24(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnp_dbg("Encode mem32");
+			pnpacpi_encode_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnp_dbg("Encode fixed mem32");
+			pnpacpi_encode_fixed_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		default: /* other type */
+			pnp_warn("Invalid type");
+			return -EINVAL;
+		}
+		resource ++;
+		i ++;
+	}
+	return 0;
+}
--- 2.6/drivers/pnp/resource.c.stg3	2004-10-18 17:35:32.176373448 +0800
+++ 2.6/drivers/pnp/resource.c	2004-10-18 17:53:34.065901240 +0800
@@ -421,6 +421,7 @@ int pnp_check_irq(struct pnp_dev * dev, 
 
 int pnp_check_dma(struct pnp_dev * dev, int idx)
 {
+#ifndef CONFIG_IA64
 	int tmp;
 	struct pnp_dev *tdev;
 	unsigned long * dma = &dev->res.dma_resource[idx].start;
@@ -470,6 +471,10 @@ int pnp_check_dma(struct pnp_dev * dev, 
 	}
 
 	return 1;
+#else
+	/* IA64 hasn't legacy DMA */
+	return 0;
+#endif
 }
 
 
--- 2.6/include/linux/pnp.h.stg3	2004-10-18 17:35:47.441052864 +0800
+++ 2.6/include/linux/pnp.h	2004-10-18 17:36:19.176228384 +0800
@@ -201,6 +201,7 @@ struct pnp_dev {
 	unsigned short	regs;		/* ISAPnP: supported registers */
 	int 		flags;		/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
+	void *data;
 };
 
 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)

--=-OPhXXyHzXug7aHAeWIzA--

