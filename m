Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUFVSSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUFVSSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUFVSSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:18:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:16309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264404AbUFVRnK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:10 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261133613@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:53 -0700
Message-Id: <10879261133723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.28, 2004/06/18 13:37:04-07:00, rmk+lkml@arm.linux.org.uk

[PATCH] Couple of sysfs patches

On Wed, Jun 16, 2004 at 05:51:03PM -0500, Dmitry Torokhov wrote:
> What about freeing the resources? Can it be put in platform_device_unregister
> or is it release handler task? I'd put it in unregister because when I call
> unregister I expect device be half-dead and release as much resources as it
> can.


Here's the updated patch - to be applied on top of the
platform_get_resource() patch sent previously.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |   91 +++++++++++++++++++++++++++---------------------
 include/linux/device.h  |    1 
 2 files changed, 52 insertions(+), 40 deletions(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Tue Jun 22 09:46:38 2004
+++ b/drivers/base/platform.c	Tue Jun 22 09:46:38 2004
@@ -55,51 +55,24 @@
 }
 
 /**
- *	platform_add_device - add one platform device
- *	@dev: platform device
- *
- *	Adds one platform device, claiming the memory resources
- */
-int platform_add_device(struct platform_device *dev)
-{
-	int i;
-
-	for (i = 0; i < dev->num_resources; i++) {
-		struct resource *p, *r = &dev->resource[i];
-
-		r->name = dev->dev.bus_id;
-
-		p = NULL;
-		if (r->flags & IORESOURCE_MEM)
-			p = &iomem_resource;
-		else if (r->flags & IORESOURCE_IO)
-			p = &ioport_resource;
-
-		if (p && request_resource(p, r)) {
-			printk(KERN_ERR
-			       "%s%d: failed to claim resource %d\n",
-			       dev->name, dev->id, i);
-			break;
-		}
-	}
-	if (i == dev->num_resources)
-		platform_device_register(dev);
-	return 0;
-}
-
-/**
  *	platform_add_devices - add a numbers of platform devices
  *	@devs: array of platform devices to add
  *	@num: number of platform devices in array
  */
 int platform_add_devices(struct platform_device **devs, int num)
 {
-	int i;
+	int i, ret = 0;
 
-	for (i = 0; i < num; i++)
-		platform_add_device(devs[i]);
+	for (i = 0; i < num; i++) {
+		ret = platform_device_register(devs[i]);
+		if (ret) {
+			while (--i >= 0)
+				platform_device_unregister(devs[i]);
+			break;
+		}
+	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -109,6 +82,8 @@
  */
 int platform_device_register(struct platform_device * pdev)
 {
+	int i, ret = 0;
+
 	if (!pdev)
 		return -EINVAL;
 
@@ -122,15 +97,53 @@
 	else
 		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *p, *r = &pdev->resource[i];
+
+		r->name = pdev->dev.bus_id;
+
+		p = NULL;
+		if (r->flags & IORESOURCE_MEM)
+			p = &iomem_resource;
+		else if (r->flags & IORESOURCE_IO)
+			p = &ioport_resource;
+
+		if (p && request_resource(p, r)) {
+			printk(KERN_ERR
+			       "%s: failed to claim resource %d\n",
+			       pdev->dev.bus_id, i);
+			ret = -EBUSY;
+			goto failed;
+		}
+	}
+
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
 		 pdev->dev.bus_id, pdev->dev.parent->bus_id);
-	return device_register(&pdev->dev);
+
+	ret = device_register(&pdev->dev);
+	if (ret == 0)
+		return ret;
+
+ failed:
+	while (--i >= 0)
+		if (pdev->resource[i].flags & (IORESOURCE_MEM|IORESOURCE_IO))
+			release_resource(&pdev->resource[i]);
+	return ret;
 }
 
 void platform_device_unregister(struct platform_device * pdev)
 {
-	if (pdev)
+	int i;
+
+	if (pdev) {
 		device_unregister(&pdev->dev);
+
+		for (i = 0; i < pdev->num_resources; i++) {
+			struct resource *r = &pdev->resource[i];
+			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
+				release_resource(r);
+		}
+	}
 }
 
 
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jun 22 09:46:38 2004
+++ b/include/linux/device.h	Tue Jun 22 09:46:38 2004
@@ -379,7 +379,6 @@
 
 extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
 extern int platform_get_irq(struct platform_device *, unsigned int);
-extern int platform_add_device(struct platform_device *);
 extern int platform_add_devices(struct platform_device **, int);
 
 /* drivers/base/power.c */

