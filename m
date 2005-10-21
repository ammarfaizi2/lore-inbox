Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVJUUSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVJUUSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVJUUR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:17:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:53453 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965146AbVJUUR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:17:58 -0400
Date: Fri, 21 Oct 2005 13:17:25 -0700
From: Greg KH <gregkh@suse.de>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] USB: always export interface information for modalias
Message-ID: <20051021201725.GA27921@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that is needed for systems that rely on udev to only load
the modules.  It seems that we were getting the modalias values wrong
for some types of devices (I know it shows up for devices that use the
cdc_acm driver).  This patch should fix this.

If anyone objects to this, or it doesn't work for them, please let me
know.

thanks,

greg k-h


-----------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [RFC PATCH] USB: always export interface information for modalias

This fixes a problem with some cdc acm devices that were not getting
automatically loaded as the module alias was not being reported
properly.

This check was for back in the days when we only reported hotplug events
for the main usb device, not the interfaces.  We should always give the
interface information for MODALIAS/modalias as it can be needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/sysfs.c |   33 +++++++++---------------
 drivers/usb/core/usb.c   |   63 +++++++++++++++++------------------------------
 2 files changed, 36 insertions(+), 60 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/sysfs.c
+++ gregkh-2.6/drivers/usb/core/sysfs.c
@@ -462,30 +462,23 @@ static ssize_t show_modalias(struct devi
 {
 	struct usb_interface *intf;
 	struct usb_device *udev;
-	int len;
+	struct usb_host_interface *alt;
 
 	intf = to_usb_interface(dev);
 	udev = interface_to_usbdev(intf);
+	alt = intf->cur_altsetting;
 
-	len = sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic",
-			       le16_to_cpu(udev->descriptor.idVendor),
-			       le16_to_cpu(udev->descriptor.idProduct),
-			       le16_to_cpu(udev->descriptor.bcdDevice),
-			       udev->descriptor.bDeviceClass,
-			       udev->descriptor.bDeviceSubClass,
-			       udev->descriptor.bDeviceProtocol);
-	buf += len;
-
-	if (udev->descriptor.bDeviceClass == 0) {
-		struct usb_host_interface *alt = intf->cur_altsetting;
-
-		return len + sprintf(buf, "%02Xisc%02Xip%02X\n",
-			       alt->desc.bInterfaceClass,
-			       alt->desc.bInterfaceSubClass,
-			       alt->desc.bInterfaceProtocol);
- 	} else {
-		return len + sprintf(buf, "*isc*ip*\n");
-	}
+	return sprintf(buf, "usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02X"
+			"ic%02Xisc%02Xip%02X\n",
+			le16_to_cpu(udev->descriptor.idVendor),
+			le16_to_cpu(udev->descriptor.idProduct),
+			le16_to_cpu(udev->descriptor.bcdDevice),
+			udev->descriptor.bDeviceClass,
+			udev->descriptor.bDeviceSubClass,
+			udev->descriptor.bDeviceProtocol,
+			alt->desc.bInterfaceClass,
+			alt->desc.bInterfaceSubClass,
+			alt->desc.bInterfaceProtocol);
 }
 static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
 
--- gregkh-2.6.orig/drivers/usb/core/usb.c
+++ gregkh-2.6/drivers/usb/core/usb.c
@@ -569,6 +569,7 @@ static int usb_hotplug (struct device *d
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
+	struct usb_host_interface *alt;
 	int i = 0;
 	int length = 0;
 
@@ -585,7 +586,8 @@ static int usb_hotplug (struct device *d
 
 	intf = to_usb_interface(dev);
 	usb_dev = interface_to_usbdev (intf);
-	
+	alt = intf->cur_altsetting;
+
 	if (usb_dev->devnum < 0) {
 		pr_debug ("usb %s: already deleted?\n", dev->bus_id);
 		return -ENODEV;
@@ -627,46 +629,27 @@ static int usb_hotplug (struct device *d
 				usb_dev->descriptor.bDeviceProtocol))
 		return -ENOMEM;
 
-	if (usb_dev->descriptor.bDeviceClass == 0) {
-		struct usb_host_interface *alt = intf->cur_altsetting;
+	if (add_hotplug_env_var(envp, num_envp, &i,
+				buffer, buffer_size, &length,
+				"INTERFACE=%d/%d/%d",
+				alt->desc.bInterfaceClass,
+				alt->desc.bInterfaceSubClass,
+				alt->desc.bInterfaceProtocol))
+		return -ENOMEM;
 
-		/* 2.4 only exposed interface zero.  in 2.5, hotplug
-		 * agents are called for all interfaces, and can use
-		 * $DEVPATH/bInterfaceNumber if necessary.
-		 */
-		if (add_hotplug_env_var(envp, num_envp, &i,
-					buffer, buffer_size, &length,
-					"INTERFACE=%d/%d/%d",
-					alt->desc.bInterfaceClass,
-					alt->desc.bInterfaceSubClass,
-					alt->desc.bInterfaceProtocol))
-			return -ENOMEM;
-
-		if (add_hotplug_env_var(envp, num_envp, &i,
-					buffer, buffer_size, &length,
-					"MODALIAS=usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X",
-					le16_to_cpu(usb_dev->descriptor.idVendor),
-					le16_to_cpu(usb_dev->descriptor.idProduct),
-					le16_to_cpu(usb_dev->descriptor.bcdDevice),
-					usb_dev->descriptor.bDeviceClass,
-					usb_dev->descriptor.bDeviceSubClass,
-					usb_dev->descriptor.bDeviceProtocol,
-					alt->desc.bInterfaceClass,
-					alt->desc.bInterfaceSubClass,
-					alt->desc.bInterfaceProtocol))
-			return -ENOMEM;
- 	} else {
-		if (add_hotplug_env_var(envp, num_envp, &i,
-					buffer, buffer_size, &length,
-					"MODALIAS=usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic*isc*ip*",
-					le16_to_cpu(usb_dev->descriptor.idVendor),
-					le16_to_cpu(usb_dev->descriptor.idProduct),
-					le16_to_cpu(usb_dev->descriptor.bcdDevice),
-					usb_dev->descriptor.bDeviceClass,
-					usb_dev->descriptor.bDeviceSubClass,
-					usb_dev->descriptor.bDeviceProtocol))
-			return -ENOMEM;
-	}
+	if (add_hotplug_env_var(envp, num_envp, &i,
+				buffer, buffer_size, &length,
+				"MODALIAS=usb:v%04Xp%04Xd%04Xdc%02Xdsc%02Xdp%02Xic%02Xisc%02Xip%02X",
+				le16_to_cpu(usb_dev->descriptor.idVendor),
+				le16_to_cpu(usb_dev->descriptor.idProduct),
+				le16_to_cpu(usb_dev->descriptor.bcdDevice),
+				usb_dev->descriptor.bDeviceClass,
+				usb_dev->descriptor.bDeviceSubClass,
+				usb_dev->descriptor.bDeviceProtocol,
+				alt->desc.bInterfaceClass,
+				alt->desc.bInterfaceSubClass,
+				alt->desc.bInterfaceProtocol))
+		return -ENOMEM;
 
 	envp[i] = NULL;
 
