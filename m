Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUI2CWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUI2CWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 22:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUI2CUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 22:20:49 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:21993 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268155AbUI2CT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 22:19:58 -0400
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409281919.aKAVlO4yKkPzE7f0@topspin.com>
X-Mailer: roland_patchbomb
Date: Tue, 28 Sep 2004 19:19:34 -0700
Message-Id: <200409281919.8RXPZodVBIYTqtXg@topspin.com>
Mime-Version: 1.0
To: greg@kroah.com, pj@sgi.com
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][2/2] [take 2] USB: use add_hotplug_env_var in core/usb.c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Sep 2004 02:19:35.0293 (UTC) FILETIME=[C35E4AD0:01C4A5CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new add_hotplug_env_var() function in drivers/usb/core/usb.c.
In addition to cleaning up the code, this fixes a (probably harmless)
bug here: for each value added to the environment, the code did

	length += sprintf(...);

and then

	scratch += length;

which means that we skip the sum of the lengths of all the values
we've put so far, rather than just the length of the value we just
put.  This is probably harmless since we're unlikely to run out of
space but if nothing else it's setting a bad example....

I've tested this on a system with USB floppy and CD-ROM; hotplug gets
the same environment with the patch as without.


Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/drivers/usb/core/usb.c
===================================================================
--- linux-bk.orig/drivers/usb/core/usb.c	2004-09-28 09:25:55.000000000 -0700
+++ linux-bk/drivers/usb/core/usb.c	2004-09-28 10:19:22.000000000 -0700
@@ -564,7 +564,6 @@
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
-	char *scratch;
 	int i = 0;
 	int length = 0;
 
@@ -591,8 +590,6 @@
 		return -ENODEV;
 	}
 
-	scratch = buffer;
-
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
 	 * all the device descriptors we don't tell them about.  Or
@@ -600,37 +597,30 @@
 	 *
 	 * FIXME reduce hardwired intelligence here
 	 */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length,
-			    "DEVICE=/proc/bus/usb/%03d/%03d",
-			    usb_dev->bus->busnum, usb_dev->devnum);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	if (add_hotplug_env_var(envp, num_envp, &i,
+				buffer, buffer_size, &length,
+				"DEVICE=/proc/bus/usb/%03d/%03d",
+				usb_dev->bus->busnum, usb_dev->devnum))
 		return -ENOMEM;
-	++length;
-	scratch += length;
 #endif
 
 	/* per-device configurations are common */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
-			    usb_dev->descriptor.idVendor,
-			    usb_dev->descriptor.idProduct,
-			    usb_dev->descriptor.bcdDevice);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	if (add_hotplug_env_var(envp, num_envp, &i,
+				buffer, buffer_size, &length,
+				"PRODUCT=%x/%x/%x",
+				usb_dev->descriptor.idVendor,
+				usb_dev->descriptor.idProduct,
+				usb_dev->descriptor.bcdDevice))
 		return -ENOMEM;
-	++length;
-	scratch += length;
 
 	/* class-based driver binding models */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length, "TYPE=%d/%d/%d",
-			    usb_dev->descriptor.bDeviceClass,
-			    usb_dev->descriptor.bDeviceSubClass,
-			    usb_dev->descriptor.bDeviceProtocol);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+	if (add_hotplug_env_var(envp, num_envp, &i,
+				buffer, buffer_size, &length,
+				"TYPE=%d/%d/%d",
+				usb_dev->descriptor.bDeviceClass,
+				usb_dev->descriptor.bDeviceSubClass,
+				usb_dev->descriptor.bDeviceProtocol))
 		return -ENOMEM;
-	++length;
-	scratch += length;
 
 	if (usb_dev->descriptor.bDeviceClass == 0) {
 		struct usb_host_interface *alt = intf->cur_altsetting;
@@ -639,18 +629,15 @@
 		 * agents are called for all interfaces, and can use
 		 * $DEVPATH/bInterfaceNumber if necessary.
 		 */
-		envp [i++] = scratch;
-		length += snprintf (scratch, buffer_size - length,
-			    "INTERFACE=%d/%d/%d",
-			    alt->desc.bInterfaceClass,
-			    alt->desc.bInterfaceSubClass,
-			    alt->desc.bInterfaceProtocol);
-		if ((buffer_size - length <= 0) || (i >= num_envp))
+		if (add_hotplug_env_var(envp, num_envp, &i,
+					buffer, buffer_size, &length,
+					"INTERFACE=%d/%d/%d",
+					alt->desc.bInterfaceClass,
+					alt->desc.bInterfaceSubClass,
+					alt->desc.bInterfaceProtocol))
 			return -ENOMEM;
-		++length;
-		scratch += length;
-
 	}
+
 	envp[i++] = NULL;
 
 	return 0;

