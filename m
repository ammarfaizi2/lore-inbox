Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755608AbWKQJcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbWKQJcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbWKQJcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:32:32 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:65134 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S1755604AbWKQJcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:32:31 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [PATCH] usb: Support for DMC TSC-10 (take 2)
Date: Fri, 17 Nov 2006 10:32:48 +0100
User-Agent: KMail/1.9.5
Cc: daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611160917.35828.hs4233@mail.mn-solutions.de> <200611161945.51499.daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200611161945.51499.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171032.48841.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic support support for the USB-based DMC TSC-10
touchscreen controller.

Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>

---

Changelog:

* mentioned where I got tooks ideas from (unmerged code
  from Marius Vollmer)
* mentioned DMC TSC-25 as well
* sorted device list alphabetically (both in the comment
  and in Kconfig)
* mentioned documentation for TSC-25 as well
* removed wrapper around usb_contrl_msg()
* return in case of errors while initializing device
* use USB_CTRL_SET_TIMEOUT 
* dropped debug code


--- linux.orig/drivers/usb/input/Kconfig
+++ linux/drivers/usb/input/Kconfig
@@ -211,6 +211,7 @@
 	  - ITM
 	  - some other eTurboTouch
 	  - Gunze AHL61
+	  - DMC TSC-10/25
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
 	  a usage description and the required user-space stuff.
@@ -218,24 +219,19 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbtouchscreen.
 
-config USB_TOUCHSCREEN_EGALAX
-	default y
-	bool "eGalax, eTurboTouch CT-410/510/700 device support" if EMBEDDED
-	depends on USB_TOUCHSCREEN
-
-config USB_TOUCHSCREEN_PANJIT
+config USB_TOUCHSCREEN_3M
 	default y
-	bool "PanJit device support" if EMBEDDED
+	bool "3M/Microtouch EX II series device support" if EMBEDDED
 	depends on USB_TOUCHSCREEN
 
-config USB_TOUCHSCREEN_3M
+config USB_TOUCHSCREEN_DMC_TSC1025
 	default y
-	bool "3M/Microtouch EX II series device support" if EMBEDDED
+	bool "DMC TSC-10/25 device support" if EMBEDDED
 	depends on USB_TOUCHSCREEN
 
-config USB_TOUCHSCREEN_ITM
+config USB_TOUCHSCREEN_EGALAX
 	default y
-	bool "ITM device support" if EMBEDDED
+	bool "eGalax, eTurboTouch CT-410/510/700 device support" if EMBEDDED
 	depends on USB_TOUCHSCREEN
 
 config USB_TOUCHSCREEN_ETURBO
@@ -248,6 +244,16 @@
 	bool "Gunze AHL61 device support" if EMBEDDED
 	depends on USB_TOUCHSCREEN
 
+config USB_TOUCHSCREEN_ITM
+	default y
+	bool "ITM device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
+config USB_TOUCHSCREEN_PANJIT
+	default y
+	bool "PanJit device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
 config USB_YEALINK
 	tristate "Yealink usb-p1k voip phone"
 	depends on USB && INPUT && EXPERIMENTAL
--- linux.orig/drivers/usb/input/usbtouchscreen.c
+++ linux/drivers/usb/input/usbtouchscreen.c
@@ -1,13 +1,13 @@
 /******************************************************************************
  * usbtouchscreen.c
  * Driver for USB Touchscreens, supporting those devices:
- *  - eGalax Touchkit
- *    includes eTurboTouch CT-410/510/700
  *  - 3M/Microtouch  EX II series
- *  - ITM
- *  - PanJit TouchSet
+ *  - DMC TSC-10/25
+ *  - eGalax Touchkit includes eTurboTouch CT-410/510/700
  *  - eTurboTouch
  *  - Gunze AHL61
+ *  - ITM
+ *  - PanJit TouchSet
  *
  * Copyright (C) 2004-2006 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -30,6 +30,8 @@
  * - ITM parts are from itmtouch.c
  * - 3M parts are from mtouchusb.c
  * - PanJit parts are from an unmerged driver by Lanslott Gish
+ * - DMC TSC 10/25 are from Holger Schurig, with ideas from an unmerged
+ *   driver from Marius Vollmer
  *
  *****************************************************************************/
 
@@ -44,7 +46,7 @@
 #include <linux/usb/input.h>
 
 
-#define DRIVER_VERSION		"v0.4"
+#define DRIVER_VERSION		"v0.5"
 #define DRIVER_AUTHOR		"Daniel Ritz <daniel.ritz@gmx.ch>"
 #define DRIVER_DESC		"USB Touchscreen Driver"
 
@@ -103,6 +105,7 @@
 	DEVTYPE_ITM,
 	DEVTYPE_ETURBO,
 	DEVTYPE_GUNZE,
+	DEVTYPE_DMC_TSC1025,
 };
 
 static struct usb_device_id usbtouch_devices[] = {
@@ -139,6 +142,10 @@
 	{USB_DEVICE(0x0637, 0x0001), .driver_info = DEVTYPE_GUNZE},
 #endif
 
+#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC1025
+	{USB_DEVICE(0x0afa, 0x03e8), .driver_info = DEVTYPE_DMC_TSC1025},
+#endif
+
 	{}
 };
 
@@ -313,6 +320,83 @@
 #endif
 
 /*****************************************************************************
+ * DMC TSC-10/25 Part
+ *
+ * Documentation about the controller and it's protocol can be found at
+ * http://www.dmccoltd.com/files/controler/tsc10usb_pi_e.pdf
+ * http://www.dmccoltd.com/files/controler/tsc25_usb_e.pdf
+ */
+#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC1025
+
+/* At which rate should coordinates transferred? This list goes from
+ * slowest rate to fastest rate. */
+#define TSC1025_RATE_POINT 0x50
+#define TSC1025_RATE_30    0x40
+#define TSC1025_RATE_50    0x41
+#define TSC1025_RATE_80    0x42
+#define TSC1025_RATE_100   0x43
+#define TSC1025_RATE_130   0x44
+#define TSC1025_RATE_150   0x45
+
+/* Some commands that we send */
+#define TSC1025_CMD_RESET  0x55
+#define TSC1025_CMD_RATE   0x05
+#define TSC1025_CMD_DATA1  0x01
+
+static int dmc_tsc1025_init(struct usbtouch_usb *usbtouch)
+{
+	int ret;
+	unsigned char buf[2];
+	struct usb_device *dev = usbtouch->udev;
+
+	// reset
+	buf[0] = buf[1] = 0xFF;
+	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
+	                      TSC1025_CMD_RESET,
+	                      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      0, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	// Expect normal response
+	if (buf[0] != 0x06 || buf[1] != 0x00)
+		return -ENODEV;
+
+	// Set Coordinate output rate setting
+	buf[0] = buf[1] = 0xFF;
+	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
+	                      TSC1025_CMD_RATE,
+	                      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      TSC1025_RATE_150, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	// Expect normal response
+	if (buf[0] != 0x06 || buf[1] != 0x00)
+		return -ENODEV;
+
+	// Coordinate data send start
+	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
+	                      TSC1025_CMD_DATA1,
+	                      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+
+static int dmc_tsc1025_read_data(unsigned char *pkt, int *x, int *y, int *touch, int *press)
+{
+	*x = ((pkt[2] & 0x03) << 8) | pkt[1];
+	*y = ((pkt[4] & 0x03) << 8) | pkt[3];
+	*touch = pkt[0] & 0x01;
+
+	return 1;
+}
+#endif
+
+
+/*****************************************************************************
  * the different device descriptors
  */
 static struct usbtouch_device_info usbtouch_dev_info[] = {
@@ -389,6 +473,18 @@
 		.read_data	= gunze_read_data,
 	},
 #endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC1025
+	[DEVTYPE_DMC_TSC1025] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x03ff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x03ff,
+		.rept_size	= 5,
+		.init		= dmc_tsc1025_init,
+		.read_data	= dmc_tsc1025_read_data,
+	},
+#endif
 };
 
 
