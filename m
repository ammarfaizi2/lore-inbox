Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269678AbUJSRAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269678AbUJSRAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269858AbUJSRAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:00:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:45508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269678AbUJSQik convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:40 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038272844@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:37:09 -0700
Message-Id: <10982038294134@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1994, 2004/09/29 17:26:15-07:00, roland@topspin.com

[PATCH] USB: use add_hotplug_env_var() in core/usb.c

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
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/usb.c |   59 +++++++++++++++++++------------------------------
 1 files changed, 23 insertions(+), 36 deletions(-)


diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2004-10-19 09:20:30 -07:00
+++ b/drivers/usb/core/usb.c	2004-10-19 09:20:30 -07:00
@@ -566,7 +566,6 @@
 {
 	struct usb_interface *intf;
 	struct usb_device *usb_dev;
-	char *scratch;
 	int i = 0;
 	int length = 0;
 
@@ -593,8 +592,6 @@
 		return -ENODEV;
 	}
 
-	scratch = buffer;
-
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
 	 * all the device descriptors we don't tell them about.  Or
@@ -602,37 +599,30 @@
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
@@ -641,18 +631,15 @@
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

