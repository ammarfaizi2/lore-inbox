Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbULQX5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbULQX5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbULQX5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:57:45 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:13100 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262235AbULQX5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:57:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=RJsDQW1vs8nhFUbTXrz9jQlEgFcdHA2xWZWxBg69P5We/Kxyyo3dscDr2cl9ziDuMGYV8Sbm0mt9xAXzzhBNpfGOfsonjDAFeHZxUIw9Orwv9XIgFk9WYiaW16r+r33dp3TswVQzRnQyrIvWGdq21X10jby7yo1iDQLEkXnB/V8=
Subject: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
	Interval
From: Mikkel Krautz <krautz@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz, krautz@gmail.com
Content-Type: text/plain
Date: Sat, 18 Dec 2004 02:12:50 +0000
Message-Id: <1103335970.15567.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds the option "USB HID Mouse Interrupt Polling Interval"
to drivers/usb/input/Kconfig, and a few lines of code to
drivers/usb/input/hid-core.c, to make the config option function.

It allows people to change the interval, at which their USB HID mice
are polled at. This is extremely useful for people who require high
precision, or just likes the feeling of a very precise mouse. ;)

As the Kconfig help implies, setting a lower polling interval is known
to work on several mice produced by Logitech and Microsoft. I only
have a Logitech MX500 to test it on. My results have been positive,
and so have many other people's.

Mikkel Krautz




Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

--- clean/drivers/usb/input/Kconfig
+++ dirty/drivers/usb/input/Kconfig
@@ -24,6 +24,38 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbhid.
 
+config USB_HID_MOUSE_POLLING_INTERVAL
+	int "USB HID Mouse Interrupt Polling Interval"
+	default 10
+	depends on USB_HID
+	help
+	  The "USB HID Mouse Interrupt Polling Interval" is the interval, at
+	  which your USB HID mouse is to be polled at. The interval is
+	  specified in miliseconds.
+
+	  Decreasing the interval will, of course, give you a much more
+	  precise mouse.
+
+	  Generally speaking, a polling interval of 2 ms should be more than
+	  enough for most people, and is great for gaming and other things
+	  that require high precision.
+
+	  An interval lower than the default is not guaranteed work on your
+	  specific piece of hardware. If you want to play it safe, don't
+	  change this value.
+
+	  Now, if you indeed want to feel the joy of a precise mouse, the
+	  following mice are known to work without problems, when the interval
+	  is set to at least 2 ms:
+
+	    * Logitech's MX-family
+	    * Logitech Mouse Man Dual Optical
+	    * Logitech iFeel
+	    * Microsoft Intellimouse Explorer
+	    * Microsoft Intellimouse Optical 1.1
+
+	  If unsure, keep it at 10 ms.
+
 comment "Input core support is needed for USB HID input layer or HIDBP
support"
 	depends on USB_HID && INPUT=n
 
--- clean/drivers/usb/input/hid-core.c
+++ dirty/drivers/usb/input/hid-core.c
@@ -37,7 +37,7 @@
  * Version Information
  */
 
-#define DRIVER_VERSION "v2.0"
+#define DRIVER_VERSION "v2.01"
 #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
 #define DRIVER_DESC "USB HID core driver"
 #define DRIVER_LICENSE "GPL"
@@ -1663,6 +1663,12 @@
 		if ((endpoint->bmAttributes & 3) != 3)		/* Not an interrupt endpoint
*/
 			continue;
 
+		/* Set the interrupt polling interval of mice, to the one specified
in the config. */
+		if (hid->collection->usage == HID_GD_MOUSE
+				&& CONFIG_USB_HID_MOUSE_POLLING_INTERVAL > 0
+				&& CONFIG_USB_HID_MOUSE_POLLING_INTERVAL < 255)
+			endpoint->bInterval = CONFIG_USB_HID_MOUSE_POLLING_INTERVAL;
+
 		/* handle potential highspeed HID correctly */
 		interval = endpoint->bInterval;
 		if (dev->speed == USB_SPEED_HIGH)



