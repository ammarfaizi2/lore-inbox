Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVFUCMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVFUCMH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVFUCLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:11:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:38116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261752AbVFTW7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:51 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Use driver_for_each_device() instead of manually walking list.
In-Reply-To: <1119308364330@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <11193083644157@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Use driver_for_each_device() instead of manually walking list.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: gregkh-2.6/drivers/usb/core/usb.c
===================================================================

---
commit 6034a080f98b0bbc0a058e2ac65a538f75cffeee
tree 3e3bb5b4afcce4aafd4cf287377c5298bd7211b2
parent 8d618afdd61ccaacbab4976a556c0ddcf36e2d8a
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 11:09:40 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:13 -0700

 drivers/usb/core/usb.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -462,6 +462,25 @@ usb_match_id(struct usb_interface *inter
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
@@ -473,26 +492,12 @@ usb_match_id(struct usb_interface *inter
  */
 struct usb_interface *usb_find_interface(struct usb_driver *drv, int minor)
 {
-	struct list_head *entry;
-	struct device *dev;
-	struct usb_interface *intf;
-
-	list_for_each(entry, &drv->driver.devices) {
-		dev = container_of(entry, struct device, driver_list);
+	struct usb_interface *intf = (struct usb_interface *)minor;
+	int ret;
 
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
+	ret = driver_for_each_device(&drv->driver, NULL, &intf, __find_interface);
 
-	/* no device found that matches */
-	return NULL;	
+	return ret ? intf : NULL;
 }
 
 static int usb_device_match (struct device *dev, struct device_driver *drv)

