Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUI0Qdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUI0Qdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUI0Qc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:32:29 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:44790 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266689AbUI0Qbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:31:53 -0400
In-Reply-To: <10963027102899@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 27 Sep 2004 09:31:51 -0700
Message-Id: <10963027111627@topspin.com>
Mime-Version: 1.0
To: greg@kroah.com, linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][2/2] [RESEND] USB: use HOTPLUG_ENV_VAR in core/usb.c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 27 Sep 2004 16:31:51.0545 (UTC) FILETIME=[7E1F9E90:01C4A4AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new HOTPLUG_ENV_VAR macro is drivers/usb/core/usb.c.  In
addition to cleaning up the code, this fixes a (probably harmless) bug
here: for each value added to the environment, the code did

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
--- linux-bk.orig/drivers/usb/core/usb.c	2004-09-12 15:21:27.000000000 -0700
+++ linux-bk/drivers/usb/core/usb.c	2004-09-12 19:28:23.000000000 -0700
@@ -564,9 +564,7 @@
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
-	char *scratch;
 	int i = 0;
-	int length = 0;
 
 	if (!dev)
 		return -ENODEV;
@@ -591,8 +589,6 @@
 		return -ENODEV;
 	}
 
-	scratch = buffer;
-
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
 	 * all the device descriptors we don't tell them about.  Or
@@ -600,37 +596,27 @@
 	 *
 	 * FIXME reduce hardwired intelligence here
 	 */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length,
+	if (HOTPLUG_ENV_VAR(buffer, buffer_size, envp, num_envp, i,
 			    "DEVICE=/proc/bus/usb/%03d/%03d",
-			    usb_dev->bus->busnum, usb_dev->devnum);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+			    usb_dev->bus->busnum, usb_dev->devnum))
 		return -ENOMEM;
-	++length;
-	scratch += length;
 #endif
 
 	/* per-device configurations are common */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
+	if (HOTPLUG_ENV_VAR(buffer, buffer_size, envp, num_envp, i,
+			    "PRODUCT=%x/%x/%x",
 			    usb_dev->descriptor.idVendor,
 			    usb_dev->descriptor.idProduct,
-			    usb_dev->descriptor.bcdDevice);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+			    usb_dev->descriptor.bcdDevice))
 		return -ENOMEM;
-	++length;
-	scratch += length;
 
 	/* class-based driver binding models */
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length, "TYPE=%d/%d/%d",
+	if (HOTPLUG_ENV_VAR(buffer, buffer_size, envp, num_envp, i,
+			    "TYPE=%d/%d/%d",
 			    usb_dev->descriptor.bDeviceClass,
 			    usb_dev->descriptor.bDeviceSubClass,
-			    usb_dev->descriptor.bDeviceProtocol);
-	if ((buffer_size - length <= 0) || (i >= num_envp))
+			    usb_dev->descriptor.bDeviceProtocol))
 		return -ENOMEM;
-	++length;
-	scratch += length;
 
 	if (usb_dev->descriptor.bDeviceClass == 0) {
 		struct usb_host_interface *alt = intf->cur_altsetting;
@@ -639,18 +625,14 @@
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
+		if (HOTPLUG_ENV_VAR(buffer, buffer_size, envp, num_envp, i,
+				    "INTERFACE=%d/%d/%d",
+				    alt->desc.bInterfaceClass,
+				    alt->desc.bInterfaceSubClass,
+				    alt->desc.bInterfaceProtocol))
 			return -ENOMEM;
-		++length;
-		scratch += length;
-
 	}
+
 	envp[i++] = NULL;
 
 	return 0;

