Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUFVSHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUFVSHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUFVSFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:05:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:41141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265060AbUFVRn0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:26 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926110895@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:50 -0700
Message-Id: <1087926110510@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.57, 2004/06/08 16:28:02-07:00, rmk@arm.linux.org.uk

[PATCH] Add platform_get_resource()

This patch adds management of platform device resources to the
device model, allowing drivers to lookup resources, IRQs and DMA
numbers in the platform device resource array.  We also add a
couple of functions which allow platform devices and their resources
to be registered.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h  |    5 ++
 2 files changed, 91 insertions(+)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Tue Jun 22 09:47:40 2004
+++ b/drivers/base/platform.c	Tue Jun 22 09:47:40 2004
@@ -19,6 +19,90 @@
 };
 
 /**
+ *	platform_get_resource - get a resource for a device
+ *	@dev: platform device
+ *	@type: resource type
+ *	@num: resource index
+ */
+struct resource *
+platform_get_resource(struct platform_device *dev, unsigned int type,
+		      unsigned int num)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if ((r->flags & (IORESOURCE_IO|IORESOURCE_MEM|
+				 IORESOURCE_IRQ|IORESOURCE_DMA))
+		    == type)
+			if (num-- == 0)
+				return r;
+	}
+	return NULL;
+}
+
+/**
+ *	platform_get_irq - get an IRQ for a device
+ *	@dev: platform device
+ *	@num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
+
+	return r ? r->start : 0;
+}
+
+/**
+ *	platform_add_device - add one platform device
+ *	@dev: platform device
+ *
+ *	Adds one platform device, claiming the memory resources
+ */
+int platform_add_device(struct platform_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *p, *r = &dev->resource[i];
+
+		r->name = dev->dev.bus_id;
+
+		p = NULL;
+		if (r->flags & IORESOURCE_MEM)
+			p = &iomem_resource;
+		else if (r->flags & IORESOURCE_IO)
+			p = &ioport_resource;
+
+		if (p && request_resource(p, r)) {
+			printk(KERN_ERR
+			       "%s%d: failed to claim resource %d\n",
+			       dev->name, dev->id, i);
+			break;
+		}
+	}
+	if (i == dev->num_resources)
+		platform_device_register(dev);
+	return 0;
+}
+
+/**
+ *	platform_add_devices - add a numbers of platform devices
+ *	@devs: array of platform devices to add
+ *	@num: number of platform devices in array
+ */
+int platform_add_devices(struct platform_device **devs, int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		platform_add_device(devs[i]);
+
+	return 0;
+}
+
+/**
  *	platform_device_register - add a platform-level device
  *	@dev:	platform device we're adding
  *
@@ -114,3 +198,5 @@
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
+EXPORT_SYMBOL(platform_get_irq);
+EXPORT_SYMBOL(platform_get_resource);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jun 22 09:47:40 2004
+++ b/include/linux/device.h	Tue Jun 22 09:47:40 2004
@@ -377,6 +377,11 @@
 extern struct bus_type platform_bus_type;
 extern struct device platform_bus;
 
+extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
+extern int platform_get_irq(struct platform_device *, unsigned int);
+extern int platform_add_device(struct platform_device *);
+extern int platform_add_devices(struct platform_device **, int);
+
 /* drivers/base/power.c */
 extern void device_shutdown(void);
 

