Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753250AbWKQVv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbWKQVv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbWKQVv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:51:58 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:37049 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1753250AbWKQVv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:51:57 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>
Subject: [PATCH] usbtouchscreen: add support for DMC TSC-10/25 devices
Date: Fri, 17 Nov 2006 22:50:15 +0100
User-Agent: KMail/1.7.2
Cc: "linux-usb" <linux-usb-devel@lists.sourceforge.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       Holger Schurig <hs4233@mail.mn-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611172250.17159.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-04.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] usbtouchscreen: add support for DMC TSC-10/25 devices

From: Holger Schurig <hs4233@mail.mn-solutions.de>

Adds support for the DMC TSC-10 and TSC-25 usb touchscreen controllers.

Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>
Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>


diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
index 20db364..661af7a 100644
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -221,6 +221,7 @@ config USB_TOUCHSCREEN
 	  - ITM
 	  - some other eTurboTouch
 	  - Gunze AHL61
+	  - DMC TSC-10/25
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
 	  a usage description and the required user-space stuff.
@@ -258,6 +259,11 @@ config USB_TOUCHSCREEN_GUNZE
 	bool "Gunze AHL61 device support" if EMBEDDED
 	depends on USB_TOUCHSCREEN
 
+config USB_TOUCHSCREEN_DMC_TSC10
+	default y
+	bool "DMC TSC-10/25 device support" if EMBEDDED
+	depends on USB_TOUCHSCREEN
+
 config USB_YEALINK
 	tristate "Yealink usb-p1k voip phone"
 	depends on USB && INPUT && EXPERIMENTAL
diff --git a/drivers/usb/input/usbtouchscreen.c b/drivers/usb/input/usbtouchscreen.c
index 933cedd..49704d4 100644
--- a/drivers/usb/input/usbtouchscreen.c
+++ b/drivers/usb/input/usbtouchscreen.c
@@ -8,6 +8,7 @@
  *  - PanJit TouchSet
  *  - eTurboTouch
  *  - Gunze AHL61
+ *  - DMC TSC-10/25
  *
  * Copyright (C) 2004-2006 by Daniel Ritz <daniel.ritz@gmx.ch>
  * Copyright (C) by Todd E. Johnson (mtouchusb.c)
@@ -30,6 +31,8 @@
  * - ITM parts are from itmtouch.c
  * - 3M parts are from mtouchusb.c
  * - PanJit parts are from an unmerged driver by Lanslott Gish
+ * - DMC TSC 10/25 are from Holger Schurig, with ideas from an unmerged
+ *   driver from Marius Vollmer
  *
  *****************************************************************************/
 
@@ -44,7 +47,7 @@
 #include <linux/usb/input.h>
 
 
-#define DRIVER_VERSION		"v0.4"
+#define DRIVER_VERSION		"v0.5"
 #define DRIVER_AUTHOR		"Daniel Ritz <daniel.ritz@gmx.ch>"
 #define DRIVER_DESC		"USB Touchscreen Driver"
 
@@ -103,6 +106,7 @@ enum {
 	DEVTYPE_ITM,
 	DEVTYPE_ETURBO,
 	DEVTYPE_GUNZE,
+	DEVTYPE_DMC_TSC10,
 };
 
 static struct usb_device_id usbtouch_devices[] = {
@@ -139,6 +143,10 @@ static struct usb_device_id usbtouch_dev
 	{USB_DEVICE(0x0637, 0x0001), .driver_info = DEVTYPE_GUNZE},
 #endif
 
+#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC10
+	{USB_DEVICE(0x0afa, 0x03e8), .driver_info = DEVTYPE_DMC_TSC10},
+#endif
+
 	{}
 };
 
@@ -313,6 +321,80 @@ static int gunze_read_data(unsigned char
 #endif
 
 /*****************************************************************************
+ * DMC TSC-10/25 Part
+ *
+ * Documentation about the controller and it's protocol can be found at
+ *   http://www.dmccoltd.com/files/controler/tsc10usb_pi_e.pdf
+ *   http://www.dmccoltd.com/files/controler/tsc25_usb_e.pdf
+ */
+#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC10
+
+/* supported data rates. currently using 130 */
+#define TSC10_RATE_POINT	0x50
+#define TSC10_RATE_30		0x40
+#define TSC10_RATE_50		0x41
+#define TSC10_RATE_80		0x42
+#define TSC10_RATE_100		0x43
+#define TSC10_RATE_130		0x44
+#define TSC10_RATE_150		0x45
+
+/* commands */
+#define TSC10_CMD_RESET		0x55
+#define TSC10_CMD_RATE		0x05
+#define TSC10_CMD_DATA1		0x01
+
+static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
+{
+	struct usb_device *dev = usbtouch->udev;
+	int ret;
+	unsigned char buf[2];
+
+	/* reset */
+	buf[0] = buf[1] = 0xFF;
+	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
+	                      TSC10_CMD_RESET,
+	                      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      0, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (buf[0] != 0x06 || buf[1] != 0x00)
+		return -ENODEV;
+
+	/* set coordinate output rate */
+	buf[0] = buf[1] = 0xFF;
+	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
+	                      TSC10_CMD_RATE,
+	                      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      TSC10_RATE_150, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (buf[0] != 0x06 || buf[1] != 0x00)
+		return -ENODEV;
+
+	/* start sending data */
+	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
+	                      TSC10_CMD_DATA1,
+	                      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+	                      0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+
+static int dmc_tsc10_read_data(unsigned char *pkt, int *x, int *y, int *touch, int *press)
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
@@ -389,6 +471,18 @@ static struct usbtouch_device_info usbto
 		.read_data	= gunze_read_data,
 	},
 #endif
+
+#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC10
+	[DEVTYPE_DMC_TSC10] = {
+		.min_xc		= 0x0,
+		.max_xc		= 0x03ff,
+		.min_yc		= 0x0,
+		.max_yc		= 0x03ff,
+		.rept_size	= 5,
+		.init		= dmc_tsc10_init,
+		.read_data	= dmc_tsc10_read_data,
+	},
+#endif
 };
 
 

