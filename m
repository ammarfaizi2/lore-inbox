Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318884AbSHEVil>; Mon, 5 Aug 2002 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSHEVil>; Mon, 5 Aug 2002 17:38:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:6595 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318884AbSHEVik>;
	Mon, 5 Aug 2002 17:38:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 5 Aug 2002 23:42:09 +0200 (MEST)
Message-Id: <UTC200208052142.g75Lg9C25845.aeb@smtp.cwi.nl>
To: greg@kroah.com
Subject: [PATCH] usb_string fix
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[I thought I sent this yesterday night, but don't see it on l-k,
maybe I forgot. Sorry if I send it twice.]

Things are indeed as conjectured, and I can reproduce the situation
where usb_string() returns -EPIPE. Now that this is an internal
error code for the USB subsystem, and not meant to get out to the
user, I made these driverfs files empty in case of error.
(While if there is no error but the string has length 0,
the file will consist of a single '\n'.)

One fewer random memory corruption. Unfortunately, there are more.

Andries

diff -r -u /linux/2.5/linux-2.5.30/linux/drivers/usb/core/usb.c ./usb.c
--- /linux/2.5/linux-2.5.30/linux/drivers/usb/core/usb.c	Sun Aug  4 14:16:57 2002
+++ ./usb.c	Sun Aug  4 23:00:22 2002
@@ -863,9 +863,11 @@
 		return 0;
 	udev = to_usb_device (dev);
 
-	len = usb_string(udev, udev->descriptor.iProduct, buf, PAGE_SIZE); 
+	len = usb_string(udev, udev->descriptor.iProduct, buf, PAGE_SIZE);
+	if (len < 0)
+		return 0;
 	buf[len] = '\n';
-	buf[len+1] = 0x00;
+	buf[len+1] = 0;
 	return len+1;
 }
 static DEVICE_ATTR(product,"product",S_IRUGO,show_product,NULL);
@@ -881,9 +883,11 @@
 		return 0;
 	udev = to_usb_device (dev);
 
-	len = usb_string(udev, udev->descriptor.iManufacturer, buf, PAGE_SIZE); 
+	len = usb_string(udev, udev->descriptor.iManufacturer, buf, PAGE_SIZE);
+	if (len < 0)
+		return 0;
 	buf[len] = '\n';
-	buf[len+1] = 0x00;
+	buf[len+1] = 0;
 	return len+1;
 }
 static DEVICE_ATTR(manufacturer,"manufacturer",S_IRUGO,show_manufacturer,NULL);
@@ -899,9 +903,11 @@
 		return 0;
 	udev = to_usb_device (dev);
 
-	len = usb_string(udev, udev->descriptor.iSerialNumber, buf, PAGE_SIZE); 
+	len = usb_string(udev, udev->descriptor.iSerialNumber, buf, PAGE_SIZE);
+	if (len < 0)
+		return 0;
 	buf[len] = '\n';
-	buf[len+1] = 0x00;
+	buf[len+1] = 0;
 	return len+1;
 }
 static DEVICE_ATTR(serial,"serial",S_IRUGO,show_serial,NULL);
@@ -918,13 +924,13 @@
 	unsigned claimed = 0;
 
 	/* FIXME should get called for each new configuration not just the
-	 * first one for a device. switching configs (or altesettings) should
+	 * first one for a device. switching configs (or altsettings) should
 	 * undo driverfs and HCD state for the previous interfaces.
 	 */
 	for (ifnum = 0; ifnum < dev->actconfig->bNumInterfaces; ifnum++) {
 		struct usb_interface *interface = &dev->actconfig->interface[ifnum];
 		struct usb_interface_descriptor *desc = interface->altsetting;
-		
+
 		/* register this interface with driverfs */
 		interface->dev.parent = &dev->dev;
 		interface->dev.bus = &usb_bus_type;
