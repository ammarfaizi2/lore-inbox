Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWCHUOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWCHUOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCHUOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:14:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:27057 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750749AbWCHUOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:14:10 -0500
Date: Wed, 8 Mar 2006 15:14:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usbcore: Don't assume a USB configuration includes any
 interfaces
In-Reply-To: <200603081033.21584.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0603081509100.5360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places, usbcore assumes that a USB device configuration 
will have a nonzero number of interfaces.  Having no interfaces may or may 
not be allowed by the USB spec; in any event we shouldn't die if we 
encounter such a thing.  This patch (as662) removes the assumptions.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/usb/core/hub.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -1179,8 +1179,11 @@ static int choose_configuration(struct u
 	c = udev->config;
 	num_configs = udev->descriptor.bNumConfigurations;
 	for (i = 0; i < num_configs; (i++, c++)) {
-		struct usb_interface_descriptor	*desc =
-				&c->intf_cache[0]->altsetting->desc;
+		struct usb_interface_descriptor	*desc = NULL;
+
+		/* It's possible that a config has no interfaces! */
+		if (c->desc.bNumInterfaces > 0)
+			desc = &c->intf_cache[0]->altsetting->desc;
 
 		/*
 		 * HP's USB bus-powered keyboard has only one configuration
@@ -1215,7 +1218,8 @@ static int choose_configuration(struct u
 		/* If the first config's first interface is COMM/2/0xff
 		 * (MSFT RNDIS), rule it out unless Linux has host-side
 		 * RNDIS support. */
-		if (i == 0 && desc->bInterfaceClass == USB_CLASS_COMM
+		if (i == 0 && desc
+				&& desc->bInterfaceClass == USB_CLASS_COMM
 				&& desc->bInterfaceSubClass == 2
 				&& desc->bInterfaceProtocol == 0xff) {
 #ifndef CONFIG_USB_NET_RNDIS
@@ -1231,8 +1235,8 @@ static int choose_configuration(struct u
 		 * than a vendor-specific driver. */
 		else if (udev->descriptor.bDeviceClass !=
 						USB_CLASS_VENDOR_SPEC &&
-				desc->bInterfaceClass !=
-						USB_CLASS_VENDOR_SPEC) {
+				(!desc || desc->bInterfaceClass !=
+						USB_CLASS_VENDOR_SPEC)) {
 			best = c;
 			break;
 		}
@@ -3022,7 +3026,7 @@ int usb_reset_device(struct usb_device *
 	parent_hub = hdev_to_hub(parent_hdev);
 
 	/* If we're resetting an active hub, take some special actions */
-	if (udev->actconfig &&
+	if (udev->actconfig && udev->actconfig->desc.bNumInterfaces > 0 &&
 			udev->actconfig->interface[0]->dev.driver ==
 				&hub_driver.driver &&
 			(hub = hdev_to_hub(udev)) != NULL) {

