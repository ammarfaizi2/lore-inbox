Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVBGSyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVBGSyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVBGSya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:54:30 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:15785 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261232AbVBGSyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:54:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=bFpoO7Nm7/klFarF68ijcImJQpy7f+KFs8ar4I27E5QvKKJ9i6xxAxdgLIt2wc0A6ehXAjVnzDOHDqT+m93TjMpeVIi0Mq62ysqTvtnAJGZ6eczviWhINGEn/pIuEZCNTG0nd0kMSH8ucByas2A82S6UDjwwfpwMHuu0id/0WT4=
Date: Mon, 7 Feb 2005 19:57:06 +0100
From: Mikkel Krautz <krautz@gmail.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050207185706.GA6701@omnipotens.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This includes the kernel-parameters.txt-patch, and the hid-core.c-patch, without the extra else-statement.

Thanks,
Mikkel

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---
--- clean/Documentation/kernel-parameters.txt
+++ dirty/Documentation/kernel-parameters.txt
@@ -73,6 +73,7 @@
 	SWSUSP	Software suspension is enabled.
 	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
+	USBHID	USB Human Interface Device support is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
@@ -1393,6 +1394,9 @@
 			Format: <io>,<irq>
 
 	usb-handoff	[HW] Enable early USB BIOS -> OS handoff
+
+	usbhid.mousepoll=
+			[USBHID] The interval which mice are to be polled at.
  
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
--- clean/drivers/usb/input/hid-core.c
+++ dirty/drivers/usb/input/hid-core.c
@@ -37,13 +37,20 @@
  * Version Information
  */
 
-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.01"
 #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
 
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+/*
+ * Module parameters.
+ */
+
+static unsigned int hid_mousepoll_interval;
+module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
+MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
 
 /*
  * Register a new report for a device.
@@ -1695,6 +1702,10 @@
 		if (dev->speed == USB_SPEED_HIGH)
 			interval = 1 << (interval - 1);
 
+		/* Change the polling interval of mice. */
+		if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
+			interval = hid_mousepoll_interval;
+		
 		if (endpoint->bEndpointAddress & USB_DIR_IN) {
 			if (hid->urbin)
 				continue;


