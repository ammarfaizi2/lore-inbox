Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVAHHyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVAHHyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVAHHyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:54:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:38533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261851AbVAHFsM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:12 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163259922@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <1105163259187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.8, 2004/12/17 14:11:24-08:00, galak@linen.sps.mot.com

[PATCH] Driver Core: Add platform_get_resource_byname & platform_get_resource_byirq

Adds the ability to find a resource or irq on a platform device by its
resource name.  This patch also tweaks how resource names get set.
Before, resources names were set to pdev->dev.bus_id, now that only
happens if the resource name has not been previous set.

All of this allows us to find a resource without assuming what order the
resources are in.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |   40 +++++++++++++++++++++++++++++++++++++++-
 include/linux/device.h  |    2 ++
 2 files changed, 41 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2005-01-07 15:46:02 -08:00
+++ b/drivers/base/platform.c	2005-01-07 15:46:02 -08:00
@@ -58,6 +58,41 @@
 }
 
 /**
+ *	platform_get_resource_byname - get a resource for a device by name
+ *	@dev: platform device
+ *	@type: resource type
+ *	@name: resource name
+ */
+struct resource *
+platform_get_resource_byname(struct platform_device *dev, unsigned int type,
+		      char *name)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if ((r->flags & (IORESOURCE_IO|IORESOURCE_MEM|
+				 IORESOURCE_IRQ|IORESOURCE_DMA)) == type)
+			if (!strcmp(r->name, name))
+				return r;
+	}
+	return NULL;
+}
+
+/**
+ *	platform_get_irq - get an IRQ for a device
+ *	@dev: platform device
+ *	@name: IRQ name
+ */
+int platform_get_irq_byname(struct platform_device *dev, char *name)
+{
+	struct resource *r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
+
+	return r ? r->start : 0;
+}
+
+/**
  *	platform_add_devices - add a numbers of platform devices
  *	@devs: array of platform devices to add
  *	@num: number of platform devices in array
@@ -103,7 +138,8 @@
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct resource *p, *r = &pdev->resource[i];
 
-		r->name = pdev->dev.bus_id;
+		if (r->name == NULL)
+			r->name = pdev->dev.bus_id;
 
 		p = NULL;
 		if (r->flags & IORESOURCE_MEM)
@@ -308,3 +344,5 @@
 EXPORT_SYMBOL_GPL(platform_device_unregister);
 EXPORT_SYMBOL_GPL(platform_get_irq);
 EXPORT_SYMBOL_GPL(platform_get_resource);
+EXPORT_SYMBOL_GPL(platform_get_irq_byname);
+EXPORT_SYMBOL_GPL(platform_get_resource_byname);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-01-07 15:46:02 -08:00
+++ b/include/linux/device.h	2005-01-07 15:46:02 -08:00
@@ -382,6 +382,8 @@
 
 extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
 extern int platform_get_irq(struct platform_device *, unsigned int);
+extern struct resource *platform_get_resource_byname(struct platform_device *, unsigned int, char *);
+extern int platform_get_irq_byname(struct platform_device *, char *);
 extern int platform_add_devices(struct platform_device **, int);
 
 extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);

