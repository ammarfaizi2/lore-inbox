Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVDHOUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVDHOUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVDHOUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:20:41 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:60562 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262828AbVDHOTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:19:48 -0400
Message-ID: <42569300.7070008@f2s.com>
Date: Fri, 08 Apr 2005 15:19:44 +0100
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: PATCH add support for system on chip (SoC) devices.
Content-Type: multipart/mixed;
 boundary="------------000705020704080901020508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000705020704080901020508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

This patch add support for a new 'System on Chip' or SoC bus type.

This allows common drivers used in different SoC devices to be shared in 
a clean and healthy manner, for example, the MMC function on toshiba 
t7l66xb, tc6393xb, and Compaq IPAQ ASIC3.

This is in common use in the handhelds.org CVS tree.

The only real issue is that drivers using this currently tend to assume 
that the SoC is attached to a platfrom_bus. This can be resolved as and 
when it becomes an issue for people.

Please apply.

--------------000705020704080901020508
Content-Type: text/x-patch;
 name="soc_device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="soc_device.patch"

--- /dev/null	2005-04-07 12:25:59.352775184 +0100
+++ soc/drivers/base/soc-device.c	2005-04-08 15:06:48.448881114 +0100
@@ -0,0 +1,239 @@
+/*
+* Driver/bus support for the system on chip (SOC)
+* On-chip devices attached to on-chip buses.
+*
+* Copyright 2003 Hewlett-Packard Company
+*
+* Use consistent with the GNU GPL is permitted, provided that this
+* copyright notice is preserved in its entirety in all copies and
+* derived works.
+*
+* HEWLET-PACKARD COMPANY MAKES NO WARRANTIES, EXPRESSED OR IMPLIED, AS
+* TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS FITNESS FOR ANY
+* PARTICULAR PURPOSE.
+*
+* Author:  Jamey Hicks
+*          <Jamey.Hicks@hp.com>
+*          July 2003
+*
+*/
+
+#include <linux/device.h>
+#include <linux/soc-device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+
+static int soc_bus_match(struct device * dev, struct device_driver *drv)
+{
+	const struct soc_device *soc_dev = to_soc_device(dev);
+	const struct soc_device_driver *soc_drv = to_soc_device_driver(drv);
+	soc_device_id *device_ids = soc_drv->device_ids;
+	soc_device_id dev_device_id = soc_dev->device_id;
+	soc_device_id drv_device_id;
+	while (drv_device_id = *device_ids++, drv_device_id.id != 0) {
+		if (drv_device_id.id == dev_device_id.id)
+			return 1;
+	}
+	return 0;
+}
+
+static int soc_bus_hotplug (struct device *dev, char **envp, 
+			    int num_envp, char *buffer, int buffer_size)
+{
+	const struct soc_device *soc_dev = to_soc_device(dev);
+	int i = 0;
+	int length = 0;
+
+	if (add_hotplug_env_var (envp, num_envp, &i,
+				 buffer, buffer_size, &length,
+				 "SOC_ID=%08x", soc_dev->device_id.id))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+
+	return 0;
+}
+
+static int soc_bus_suspend(struct device * dev, u32 state)
+{
+	struct device_driver * drv = dev->driver;
+	int ret = 0;
+
+	if (drv && drv->suspend) {
+		ret = drv->suspend(dev, state, SUSPEND_DISABLE);
+		if (ret == 0)
+			ret = drv->suspend(dev, state, SUSPEND_SAVE_STATE);
+		if (ret == 0)
+			ret = drv->suspend(dev, state, SUSPEND_POWER_DOWN);
+	}
+
+	return ret;
+}
+
+static int soc_bus_resume(struct device * dev)
+{
+	struct device_driver * drv = dev->driver;
+	int ret = 0;
+
+	if (drv && drv->resume) {
+		ret = drv->resume(dev, RESUME_POWER_ON);
+		if (ret == 0)
+			ret = drv->resume(dev, RESUME_RESTORE_STATE);
+		if (ret == 0)
+			ret = drv->resume(dev, RESUME_ENABLE);
+	}
+
+	return ret;
+}
+
+struct bus_type soc_bus_type = {
+	.name = "soc",
+	.match  = soc_bus_match,
+	.hotplug = soc_bus_hotplug,
+	.suspend = soc_bus_suspend,
+	.resume  = soc_bus_resume
+};
+
+extern int soc_driver_register(struct soc_device_driver * drv)
+{
+	drv->driver.bus = &soc_bus_type;
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL(soc_driver_register);
+
+extern void soc_driver_unregister(struct soc_device_driver * drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(soc_driver_unregister);
+
+extern int soc_device_register(struct soc_device * dev)
+{
+	int i, j, rc = 0;
+	struct platform_device *pdev = to_platform_device (dev->device.parent);
+
+	dev->device.bus = &soc_bus_type;
+
+	snprintf(dev->device.bus_id, BUS_ID_SIZE, "%s", dev->name);
+
+	if (dev->num_resources) {
+		dev->parent_resource = kmalloc (dev->num_resources * sizeof (struct resource *), GFP_KERNEL);
+		if (!dev->parent_resource)
+			return -ENOMEM;
+	} else
+		dev->parent_resource = NULL;
+	dev->num_parent_resources = 0;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *res = &dev->resource[i];
+		int best = -1;
+
+		res->name = dev->device.bus_id;
+
+		/* For now just skip bus-specific resources */
+		if (res->flags & (IORESOURCE_BITS | IORESOURCE_SOC_VIRTUAL))
+			continue;
+
+		/* We must claim the platform resource containing this subresource */
+		for (j = 0; j < pdev->num_resources; j++) {
+			/* Shamelessly borrowed from pci.c */
+			struct resource *r = &pdev->resource[j];
+			if (res->start && !(res->start >= r->start && res->end <= r->end))
+				continue;	/* Not contained */
+			if ((res->flags ^ r->flags) & (IORESOURCE_IO | IORESOURCE_MEM))
+				continue;	/* Wrong type */
+			if (!((res->flags ^ r->flags) & IORESOURCE_PREFETCH)) {
+				best = j;	/* Exact match */
+				break;
+			}
+			if ((res->flags & IORESOURCE_PREFETCH) && !(r->flags & IORESOURCE_PREFETCH))
+				best = j;	/* Approximating prefetchable by non-prefetchable */
+		}
+		if (best >= 0) {
+			struct resource *r = &pdev->resource[best];
+			if ((rc = request_resource (r, res))) {
+				printk(KERN_ERR "%s: failed to claim resource %d (at %08lx-%08lx)\n",
+				       dev->name, i, res->start, res->end);
+				goto err1;
+			}
+			dev->parent_resource[dev->num_parent_resources++] = res;
+		} else {
+			if (!(res->flags & IORESOURCE_SOC_VIRTUAL)) {
+				printk (KERN_ERR "%s: cannot find resource %d in platform resources\n",
+					dev->name, i);
+				rc = -ENOENT;
+				goto err1;
+			}
+		}
+	}
+
+	if (!(rc = device_register(&dev->device)))
+		return 0;
+
+err1:
+	for (i = 0; i < dev->num_parent_resources; i++) {
+		struct resource *r = dev->parent_resource[i];
+		release_resource (r); 
+	}
+	if (dev->parent_resource)
+		kfree (dev->parent_resource);
+	return rc;
+}
+EXPORT_SYMBOL(soc_device_register);
+
+extern void soc_device_unregister(struct soc_device * dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_parent_resources; i++) {
+		struct resource *r = dev->parent_resource[i];
+		release_resource (r); 
+	}
+
+	if (dev->parent_resource)
+		kfree (dev->parent_resource);
+
+	device_unregister(&dev->device);
+}
+EXPORT_SYMBOL(soc_device_unregister);
+
+struct soc_device *soc_device_get(struct soc_device *dev)
+{
+	struct device *tmp;
+
+	if (!dev)
+		return NULL;
+
+	tmp = get_device(&dev->device);
+	if (tmp)        
+		return to_soc_device(tmp);
+	else
+		return NULL;
+}
+
+void soc_device_put(struct soc_device *dev)
+{
+	if (dev)
+		put_device(&dev->device);
+}
+
+static int __init soc_driver_init(void)
+{
+	return bus_register(&soc_bus_type);
+}
+
+static void __exit soc_driver_exit(void)
+{
+	bus_unregister (&soc_bus_type);
+}
+
+postcore_initcall(soc_driver_init);
+module_exit(soc_driver_exit);
+
+MODULE_AUTHOR("Jamey Hicks <Jamey.Hicks@hp.com>");
+MODULE_DESCRIPTION("Driver/bus support for the system on chip (SOC)");
+MODULE_LICENSE("GPL");
+
--- /dev/null	2005-04-07 12:25:59.352775184 +0100
+++ soc/include/linux/soc-device.h	2005-04-08 15:07:51.048215855 +0100
@@ -0,0 +1,100 @@
+/*
+* Driver/bus support for the system on chip (SOC)
+* On-chip devices attached to on-chip buses.
+*
+* Copyright 2003 Hewlett-Packard Company
+*
+* Use consistent with the GNU GPL is permitted,
+* provided that this copyright notice is
+* preserved in its entirety in all copies and derived works.
+*
+* COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
+* AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
+* FITNESS FOR ANY PARTICULAR PURPOSE.
+*
+* Author:  Jamey Hicks
+*          <Jamey.Hicks@hp.com>
+*          July 2003
+*
+*/
+
+#ifndef _SOC_DEVICE_H_
+#define _SOC_DEVICE_H_
+
+#include <linux/device.h>
+
+extern struct bus_type soc_bus_type;
+
+typedef struct soc_device_id {
+	__u32 id;
+} soc_device_id;
+
+struct soc_device_driver {
+	soc_device_id *device_ids;
+	struct device_driver driver;
+};
+
+#define	to_soc_device_driver(n) container_of(n, struct soc_device_driver, driver)
+
+extern int soc_driver_register(struct soc_device_driver * drv);
+extern void soc_driver_unregister(struct soc_device_driver * drv);
+
+
+struct soc_device {
+	soc_device_id	device_id;
+	char		*name;
+	u32		num_resources;
+	struct resource	*resource;
+	u32		num_parent_resources;
+	struct resource **parent_resource;
+	struct device	device;
+};
+
+#define	to_soc_device(n) container_of(n, struct soc_device, device)
+
+extern int soc_device_register(struct soc_device * dev);
+extern void soc_device_unregister(struct soc_device * dev);
+
+#define IORESOURCE_SOC_VIRTUAL		0x00000001
+
+/* device ID definitions */
+#define	IPAQ_ASIC2_ADC_DEVICE_ID	0x00000001
+#define	IPAQ_ASIC2_SPI_DEVICE_ID	0x00000003
+#define	IPAQ_ASIC2_GPIO_DEVICE_ID	0x00000004
+#define	IPAQ_ASIC2_KPIO_DEVICE_ID	0x00000005
+
+#define	IPAQ_SAMCOP_USBH_DEVICE_ID	0x00000101
+#define IPAQ_SAMCOP_SRAM_DEVICE_ID	0x00000102
+#define IPAQ_SAMCOP_ONEWIRE_DEVICE_ID	0x00000103
+#define IPAQ_SAMCOP_ADC_DEVICE_ID	0x00000104
+#define IPAQ_SAMCOP_DMA_DEVICE_ID	0x00000105
+#define IPAQ_SAMCOP_NAND_DEVICE_ID	0x00000106
+#define IPAQ_SAMCOP_FSI_DEVICE_ID	0x00000107
+#define IPAQ_SAMCOP_EPS_DEVICE_ID	0x00000108
+#define IPAQ_SAMCOP_SDI_DEVICE_ID	0x00000109
+
+#define IPAQ_HAMCOP_SRAM_DEVICE_ID	0x00000111
+#define IPAQ_HAMCOP_NAND_DEVICE_ID	0x00000115
+#define IPAQ_HAMCOP_LED_DEVICE_ID	0x00000116
+
+#define IPAQ_DS2760_DEVICE_ID		0x00000201
+
+/* MediaQ 1100/1132/1168/1178/1188 subdevices */
+#define MEDIAQ_11XX_FB_DEVICE_ID	0x00000301
+#define MEDIAQ_11XX_FP_DEVICE_ID	0x00000302
+#define MEDIAQ_11XX_UDC_DEVICE_ID	0x00000303
+#define MEDIAQ_11XX_UHC_DEVICE_ID	0x00000304
+#define MEDIAQ_11XX_SPI_DEVICE_ID	0x00000305
+#define MEDIAQ_11XX_I2S_DEVICE_ID	0x00000306
+
+/* ATI W3220 devices */
+#define ATI_W3220_FB_DEVICE_ID          0x00000401
+#define ATI_W3220_USB_DEVICE_ID         0x00000402
+
+/* Toshiba T7L66XB TC6393XB etc. devices (aka, tmio) */
+#define TMIO_NAND_DEVICE_ID             0x00000501
+#define TMIO_USB_DEVICE_ID              0x00000502
+#define TMIO_MMC_DEVICE_ID              0x00000503
+#define TMIO_FB_DEVICE_ID               0x00000504
+
+#endif /* _SOC_DEVICE_H_ */
--- /dev/null	2005-04-07 12:25:59.352775184 +0100
+++ soc/Documentation/soc.txt	2005-04-08 15:06:28.000000000 +0100
@@ -0,0 +1,67 @@
+Linux System-On-a-Chip (SoC) support.
+=====================================
+
+(c) 2005 Ian Molton <spyro@f2s.com
+
+This document describes the SoC bus model and its API.
+
+Why do we need a SoC bus?
+-------------------------
+
+Particularly in embedded platforms, it is now becomming common to find that
+chips are being developed to contain many 'subdevices', including video
+display, audio, serial, USB, etc. From now on, the 'subdevices' will be
+referred to as 'cells'.
+
+These cells may also share local memory pools and power control, perhaps via
+common register sets.
+
+The SoC bus doesnt directly address issues relating to the above, but it does
+provide a framework for them to be tackled, and a method for registering such
+devices cleanly.
+
+
+How does SoC work?
+------------------
+
+A SoC system will include a single SoC base driver, typically in drivers/soc
+and one or more SoC cell drivers, which would be kept in the appropriate place
+in the device hierarchy (drivers/video for a fb device, drivers/usb/host/ for
+a usb host type device, etc.).
+
+The SoC base driver handles registration and allocation of basic resources,
+along with any initialisation required to bring up the core of the device. It
+is not specified wether the base driver is to handle mapping of any IO
+regions - this is left to the discretion of the driver author to decide as
+best fits each case. Some SoC drivers pass virtual addresses to their cell
+drivers, others may pass physical addresses.
+
+The SoC cell drivers handle the specific functions of the chip (FB, USB, etc.)
+and will do any further initialisation required over that performed by the SoC
+base drivers.
+
+The base and cell drivers are tied together by their name fields, and also by
+their SoC device IDs. the latter allows a cell driver to identify what base
+driver it is attached to, and adjust its behaviour appropriately if required.
+
+The SoC API
+-----------
+
+SoC base and cell drivers should #include <linux/soc-device.h> which defines:-
+
+ * A list of SoC device ids for use by cell drivers
+ * the struct soc_device
+ * the struct soc_device_driver
+
+SoC cell drivers may put headers in linux/soc/
+
+A soc base driver will want to fill in a struct soc_device for each device it
+contains. Optionally, it can pass resources, which it will need to allocate
+also.
+
+Once it has setup the struct soc_device, it simply calls soc_device_register.
+
+Cell drivers work much like any normal driver - they supply probe_ and remove_
+functions, and register them in a struct soc_device_driver, via a call to
+soc_driver_register().
+

--------------000705020704080901020508--
