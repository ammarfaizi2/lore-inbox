Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVBQDvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVBQDvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 22:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVBQDvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 22:51:46 -0500
Received: from it4systems-kln-gw.de.clara.net ([212.6.222.118]:29919 "EHLO
	frankbuss.de") by vger.kernel.org with ESMTP id S262203AbVBQDvh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 22:51:37 -0500
From: "Frank Buss" <fb@frank-buss.de>
To: <linux-kernel@vger.kernel.org>
Cc: <david-b@pacbell.net>
Subject: RE: SL811 problem on mach-pxa
Date: Thu, 17 Feb 2005 04:51:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-reply-to: <20050214190301.769C75B8A5@frankbuss.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcUSx87lYxEcl86VRaq372C/cIGYJwB2aO2A
Message-Id: <20050217035136.462465B80B@frankbuss.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now the driver is working, at least on my platform. Currently I'm using
version 2.6.11-rc1 as my base, but the diff output is only this:

--- linux-2.6.11-rc1.orig/drivers/usb/host/sl811-hcd.c  Wed Jan 12 05:00:38
2005
+++ linux-2.6.11-rc4.orig/drivers/usb/host/sl811-hcd.c  Sun Feb 13 04:05:51
2005
@@ -1042,7 +1042,7 @@

        usb_put_dev(ep->udev);
        kfree(ep);
-       hep->hcpriv = 0;
+       hep->hcpriv = NULL;
 }

 static int


Below is the patch. Comments are included for the changed parts. I don't
know, if Outlook preserves tabs, so you can download the patch here:

http://www.frank-buss.de/tmp/sl811-hcd.c-patch.txt

and the whole changed file:

http://www.frank-buss.de/tmp/sl811-hcd.c

There is still an important error: When a device is plugged, then opened and
then unplugged while open, it looks like the process freezes, which opened
the device (I've tried "cat /dev/input/mice" and I can't break it after
unplugged). After plugging the device again, it is not recognized any more.
When the device is not open or after closing the device, unlugging and
plugging again is no problem.


--- linux-2.6.11-rc1.orig/drivers/usb/host/sl811-hcd.c	Wed Jan 12 05:00:38
2005
+++ linux-2.6.11-rc1/drivers/usb/host/sl811-hcd.c	Thu Feb 17 04:37:55
2005
@@ -83,8 +83,9 @@
  */
 #define	DISABLE_ISO
 
-// #define	QUIRK2
-#define	QUIRK3
+/* with other QUIRK combinations it crashes */
+#define	QUIRK2
+//#define	QUIRK3
 
 static const char hcd_name[] = "sl811-hcd";
 
@@ -831,8 +832,11 @@
 #endif
 
 	/* avoid all allocations within spinlocks */
-	if (!hep->hcpriv)
+	if (!hep->hcpriv) {
 		ep = kcalloc(1, sizeof *ep, mem_flags);
+		/* set hep, otherwise sl811h_ep	*start(struct sl811 *sl811,
u8 bank) crashes */
+		ep->hep = hep;
+	}
 
 	spin_lock_irqsave(&sl811->lock, flags);
 
@@ -952,7 +956,11 @@
 		retval = 0;
 		goto fail;
 	}
-	urb->hcpriv = hep;
+	
+	/* when uncommented, causes this error on mouse open: 
+		drivers/usb/input/usbmouse.c: can't resubmit intr,
sl811-hcd-1/input0, status -22
+		urb->hcpriv = hep;  */
+	
 	spin_unlock(&urb->lock);
 
 	start_transfer(sl811);
@@ -1037,6 +1045,9 @@
 	/* assume we'd just wait for the irq */
 	if (!list_empty(&hep->urb_list))
 		msleep(3);
+
+	/* this error occurs, when the device is connected, opened and then
disconnected;
+	   after this warning, the process freezes */
 	if (!list_empty(&hep->urb_list))
 		WARN("ep %p not empty?\n", ep);
 
@@ -1580,6 +1591,14 @@
 	if (sl811->board && sl811->board->power)
 		hub_set_power_budget(udev, sl811->board->power * 2);
 
+	// enable power and interupts	
+	port_power(sl811, 1);
+
+	/* reset USB (without this the devices were not detected at boot,
only after plugging) */
+	sl811_write(sl811, SL11H_CTLREG1, 0x08);
+	mdelay(20);
+	sl811_write(sl811, SL11H_CTLREG1, 0);
+
 	return 0;
 }
 
@@ -1639,11 +1658,11 @@
 	free_irq(hcd->irq, hcd);
 
 	iounmap(sl811->data_reg);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, 1);
 
 	iounmap(sl811->addr_reg);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	release_mem_region(res->start, 1);
 
 	usb_put_hcd(hcd);
@@ -1674,8 +1693,28 @@
 	if (pdev->num_resources < 3)
 		return -ENODEV;
 
-	addr = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	/* IORESOURCE_IO, because I think it is IO access. The following
+		resources in the platform description file works:
+		static struct resource usb_resources[] = {
+			[0] = {
+				.start	= YOUR_PLATFORM_USB_PHYS,
+				.end	= YOUR_PLATFORM_USB_PHYS + 256
+				.flags	= IORESOURCE_IO,
+			},
+			[1] = {
+				.start	= YOUR_PLATFORM_USB_PHYS + 0x010000,
+				.end	= YOUR_PLATFORM_USB_PHYS + 0x010000
+ 256
+				.flags	= IORESOURCE_MEM,
+			},
+			[2] = {
+				.start	= USB_IRQ,
+				.end	= USB_IRQ,
+				.flags	= IORESOURCE_IRQ,
+			},
+		};*/
+
+	addr = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	data = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!addr || !data || irq < 0)
 		return -ENODEV;
@@ -1700,7 +1739,7 @@
 		retval = -EBUSY;
 		goto err3;
 	}
-	data_reg = ioremap(data->start, resource_len(addr));
+	data_reg = ioremap(data->start, resource_len(data));
 	if (data_reg == NULL) {
 		retval = -ENOMEM;
 		goto err4;
@@ -1728,7 +1767,6 @@
 	sl811->timer.data = (unsigned long) sl811;
 	sl811->addr_reg = addr_reg;
 	sl811->data_reg = data_reg;
-
 	spin_lock_irq(&sl811->lock);
 	port_power(sl811, 0);
 	spin_unlock_irq(&sl811->lock);





-- 
Frank Buﬂ, fb@frank-buss.de
http://www.frank-buss.de, http://www.it4-systems.de

