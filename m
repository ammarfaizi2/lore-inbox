Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbVLWWaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbVLWWaT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbVLWW35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:29:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:47816 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161082AbVLWW2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:28:44 -0500
Date: Fri, 23 Dec 2005 14:27:32 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 04/11] USB: always export interface information for modalias
Message-ID: <20051223222732.GE18252@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-interface-modalias-fix.patch"
In-Reply-To: <20051223222652.GA18252@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

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

--- linux-2.6.14.1.orig/drivers/usb/core/sysfs.c
+++ linux-2.6.14.1/drivers/usb/core/sysfs.c
@@ -292,30 +292,23 @@ static ssize_t show_modalias(struct devi
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
 
--- linux-2.6.14.1.orig/drivers/usb/core/usb.c
+++ linux-2.6.14.1/drivers/usb/core/usb.c
@@ -557,6 +557,7 @@ static int usb_hotplug (struct device *d
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
+	struct usb_host_interface *alt;
 	int i = 0;
 	int length = 0;
 
@@ -573,7 +574,8 @@ static int usb_hotplug (struct device *d
 
 	intf = to_usb_interface(dev);
 	usb_dev = interface_to_usbdev (intf);
-	
+	alt = intf->cur_altsetting;
+
 	if (usb_dev->devnum < 0) {
 		pr_debug ("usb %s: already deleted?\n", dev->bus_id);
 		return -ENODEV;
@@ -615,46 +617,27 @@ static int usb_hotplug (struct device *d
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
 

--
