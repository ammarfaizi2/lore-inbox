Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVCUUz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVCUUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVCUUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:55:26 -0500
Received: from digitalimplant.org ([64.62.235.95]:18828 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261891AbVCUUsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:50 -0500
Date: Mon, 21 Mar 2005 12:48:45 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [5/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211245060.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2234, 2005-03-21 11:09:40-08:00, mochel@digitalimplant.org
  [usb] Use driver_for_each_device() instead of manually walking list.



  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2005-03-21 12:30:37 -08:00
+++ b/drivers/usb/core/usb.c	2005-03-21 12:30:37 -08:00
@@ -469,6 +469,25 @@
 	return NULL;
 }

+
+static int __find_interface(struct device * dev, void * data)
+{
+	struct usb_interface ** ret = (struct usb_interface **)data;
+	struct usb_interface * intf = *ret;
+	int *minor = (int *)data;
+
+	/* can't look at usb devices, only interfaces */
+	if (dev->driver == &usb_generic_driver)
+		return 0;
+
+	intf = to_usb_interface(dev);
+	if (intf->minor != -1 && intf->minor == *minor) {
+		*ret = intf;
+		return 1;
+	}
+	return 0;
+}
+
 /**
  * usb_find_interface - find usb_interface pointer for driver and device
  * @drv: the driver whose current configuration is considered
@@ -480,26 +499,12 @@
  */
 struct usb_interface *usb_find_interface(struct usb_driver *drv, int minor)
 {
-	struct list_head *entry;
-	struct device *dev;
-	struct usb_interface *intf;
-
-	list_for_each(entry, &drv->driver.devices) {
-		dev = container_of(entry, struct device, driver_list);
-
-		/* can't look at usb devices, only interfaces */
-		if (dev->driver == &usb_generic_driver)
-			continue;
-
-		intf = to_usb_interface(dev);
-		if (intf->minor == -1)
-			continue;
-		if (intf->minor == minor)
-			return intf;
-	}
+	struct usb_interface *intf = (struct usb_interface *)minor;
+	int ret;
+
+	ret = driver_for_each_device(&drv->driver, NULL, &intf, __find_interface);

-	/* no device found that matches */
-	return NULL;
+	return ret ? intf : NULL;
 }

 static int usb_device_match (struct device *dev, struct device_driver *drv)
