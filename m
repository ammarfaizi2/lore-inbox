Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUFRTfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUFRTfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUFRTb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:31:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53266 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266777AbUFRT37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:29:59 -0400
Date: Fri, 18 Jun 2004 20:29:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040618202949.B17516@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20040610144658.31403.qmail@web81309.mail.yahoo.com> <20040610191740.B6833@flint.arm.linux.org.uk> <20040610212552.C6833@flint.arm.linux.org.uk> <200406161751.03574.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406161751.03574.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Wed, Jun 16, 2004 at 05:51:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 05:51:03PM -0500, Dmitry Torokhov wrote:
> What about freeing the resources? Can it be put in platform_device_unregister
> or is it release handler task? I'd put it in unregister because when I call
> unregister I expect device be half-dead and release as much resources as it
> can.

Greg,

Here's the updated patch - to be applied on top of the
platform_get_resource() patch sent previously.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/base/platform.c linux/drivers/base/platform.c
--- orig/drivers/base/platform.c	Fri Jun 18 20:28:13 2004
+++ linux/drivers/base/platform.c	Fri Jun 18 20:24:02 2004
@@ -55,51 +55,24 @@ int platform_get_irq(struct platform_dev
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
@@ -109,6 +82,8 @@ int platform_add_devices(struct platform
  */
 int platform_device_register(struct platform_device * pdev)
 {
+	int i, ret = 0;
+
 	if (!pdev)
 		return -EINVAL;
 
@@ -119,15 +94,53 @@ int platform_device_register(struct plat
 	
 	snprintf(pdev->dev.bus_id,BUS_ID_SIZE,"%s%u",pdev->name,pdev->id);
 
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
 		 pdev->dev.bus_id,pdev->dev.parent->bus_id);
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
 
 
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/device.h linux/include/linux/device.h
--- orig/include/linux/device.h	Fri Jun 18 20:28:13 2004
+++ linux/include/linux/device.h	Thu Jun 10 19:15:03 2004
@@ -392,7 +392,6 @@ extern struct device platform_bus;
 
 extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
 extern int platform_get_irq(struct platform_device *, unsigned int);
-extern int platform_add_device(struct platform_device *);
 extern int platform_add_devices(struct platform_device **, int);
 
 /* drivers/base/power.c */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
