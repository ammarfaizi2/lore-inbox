Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUFJU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUFJU0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUFJU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:26:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8465 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262954AbUFJUZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:25:57 -0400
Date: Thu, 10 Jun 2004 21:25:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040610212552.C6833@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20040610144658.31403.qmail@web81309.mail.yahoo.com> <20040610170607.A5830@flint.arm.linux.org.uk> <20040610161442.GC31787@kroah.com> <20040610191740.B6833@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040610191740.B6833@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jun 10, 2004 at 07:17:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 07:17:40PM +0100, Russell King wrote:
> On Thu, Jun 10, 2004 at 09:14:42AM -0700, Greg KH wrote:
> > On Thu, Jun 10, 2004 at 05:06:07PM +0100, Russell King wrote:
> > > 
> > > Now that I can see the platform device interfaces multipling like rabbits,
> > > (to GregKH) I think that the patch I submitted for platform_add_device
> > > suffers from this problem as well, and I should've thrown that code
> > > into platform_register_device itself.
> > > 
> > > Greg - comments?  Would you like a new patch which does that, or do you
> > > think that's too risky?
> > 
> > Hm, I don't think it's too risky.  Make up a patch and let's see how it
> > looks.
> > 
> > I'm just worried that this "simple" interface really isn't so simple, as
> > it's almost just as much work to manage it as a normal platform device.
> 
> Ok, here's a patch so you can see what I'm suggesting above.  This is
> on top of the previous patch I sent.  Merely discards one over-eager
> rabbit [1] and moves the code into platform_device_register().
> 
> [1]: No animals were harmed in the creation of this patch.

And for added good behaviour, particularly when things go wrong.

diff -u -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej linux-tolinus/drivers/base/platform.c linux/drivers/base/platform.c
--- linux-tolinus/drivers/base/platform.c	Thu Jun 10 18:52:45 2004
+++ linux/drivers/base/platform.c	Thu Jun 10 20:22:50 2004
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
 
@@ -119,9 +94,38 @@
 	
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
diff -u -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej linux-tolinus/include/linux/device.h linux/include/linux/device.h
--- linux-tolinus/include/linux/device.h	Thu Jun 10 18:52:46 2004
+++ linux/include/linux/device.h	Thu Jun 10 19:15:03 2004
@@ -392,7 +392,6 @@
 
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
