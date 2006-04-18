Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDRMLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDRMLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDRMLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:11:49 -0400
Received: from 27.mail-out.ovh.net ([213.186.38.137]:61864 "EHLO
	27.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1750773AbWDRMLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:11:48 -0400
Subject: [PATCH] MacBook Pro touchpad support
From: Nicolas Boichat <nicolas@boichat.ch>
Reply-To: nicolas@boichat.ch
To: greg@kroah.com, linux-usb-devel@lists.sourceforge.net
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Stelian Pop <stelian@popies.net>,
       mactel-linux-devel@lists.sourceforge.net,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       frank@scirocco-5v-turbo.de, petero2@telia.com, linux-kernel@hansmi.ch
Content-Type: text/plain
Date: Tue, 18 Apr 2006 13:07:11 +0200
Message-Id: <1145358431.14816.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Ovh-Remote: 83.228.132.109 (gve-gix-adsl-dynip-132-109.vtx.ch)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <nicolas@boichat.ch>

Add support for MacBook touchpad in appletouch driver.
Thanks to Alex Harper for the informations.

Acked-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Stelian Pop <stelian@popies.net>
Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>

--- drivers/usb/input/appletouch.c.ori	2006-04-17 13:03:58.000000000 +0200
+++ drivers/usb/input/appletouch.c	2006-04-17 18:36:29.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * Apple USB Touchpad (for post-February 2005 PowerBooks) driver
+ * Apple USB Touchpad (for post-February 2005 PowerBooks and MacBooks) driver
  *
  * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
  * Copyright (C) 2005      Johannes Berg (johannes@sipsolutions.net)
@@ -7,6 +7,7 @@
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
  * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
+ * Copyright (C) 2006      Nicolas Boichat (nicolas@boichat.ch)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
@@ -44,6 +45,11 @@
 #define GEYSER_ISO_PRODUCT_ID	0x0215
 #define GEYSER_JIS_PRODUCT_ID	0x0216
 
+/* MacBook devices */
+#define GEYSER3_ANSI_PRODUCT_ID	0x0217
+#define GEYSER3_ISO_PRODUCT_ID	0x0218
+#define GEYSER3_JIS_PRODUCT_ID	0x0219
+
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -65,6 +71,10 @@ static struct usb_device_id atp_table []
 	{ ATP_DEVICE(GEYSER_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER_JIS_PRODUCT_ID) },
 
+	{ ATP_DEVICE(GEYSER3_ANSI_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER3_ISO_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER3_JIS_PRODUCT_ID) },
+
 	/* Terminating entry */
 	{ }
 };
@@ -101,6 +111,13 @@ MODULE_DEVICE_TABLE (usb, atp_table);
  */
 #define ATP_THRESHOLD	 5
 
+/* MacBook Pro (Geyser 3) initialization constants */
+#define ATP_GEYSER3_MODE_READ_REQUEST_ID 1
+#define ATP_GEYSER3_MODE_WRITE_REQUEST_ID 9
+#define ATP_GEYSER3_MODE_REQUEST_VALUE 0x300
+#define ATP_GEYSER3_MODE_REQUEST_INDEX 0
+#define ATP_GEYSER3_MODE_VENDOR_VALUE 0x04
+
 /* Structure to hold all of our device specific stuff */
 struct atp {
 	char			phys[64];
@@ -147,13 +164,22 @@ MODULE_PARM_DESC(debug, "Activate debugg
 /* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
 static inline int atp_is_geyser_2(struct atp *dev)
 {
-	int16_t productId = le16_to_cpu(dev->udev->descriptor.idProduct);
+	int productId = le16_to_cpu(dev->udev->descriptor.idProduct);
 
 	return (productId == GEYSER_ANSI_PRODUCT_ID) ||
 		(productId == GEYSER_ISO_PRODUCT_ID) ||
 		(productId == GEYSER_JIS_PRODUCT_ID);
 }
 
+static inline int atp_is_geyser_3(struct atp *dev)
+{
+	int productId = le16_to_cpu(dev->udev->descriptor.idProduct);
+
+	return (productId == GEYSER3_ANSI_PRODUCT_ID) ||
+		(productId == GEYSER3_ISO_PRODUCT_ID) ||
+		(productId == GEYSER3_JIS_PRODUCT_ID);
+}
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -219,12 +245,31 @@ static void atp_complete(struct urb* urb
 
 	/* drop incomplete datasets */
 	if (dev->urb->actual_length != dev->datalen) {
-		dprintk("appletouch: incomplete data package.\n");
+		dprintk("appletouch: incomplete data package (first byte: %d, length: %d).\n", dev->data[0], dev->urb->actual_length);
 		goto exit;
 	}
 
 	/* reorder the sensors values */
-	if (atp_is_geyser_2(dev)) {
+	if (atp_is_geyser_3(dev)) {
+		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
+
+		/*
+		 * The values are laid out like this:
+		 * -, Y1, Y2, -, Y3, Y4, -, ..., -, X1, X2, -, X3, X4, ...
+		 * '-' is an unused value.
+		 */
+
+		/* read X values */
+		for (i = 0, j = 19; i < 20; i += 2, j += 3) {
+			dev->xy_cur[i] = dev->data[j + 1];
+			dev->xy_cur[i + 1] = dev->data[j + 2];
+		}
+		/* read Y values */
+		for (i = 0, j = 1; i < 9; i += 2, j += 3) {
+			dev->xy_cur[ATP_XSENSORS + i] = dev->data[j + 1];
+			dev->xy_cur[ATP_XSENSORS + i + 1] = dev->data[j + 2];
+		}
+	} else if (atp_is_geyser_2(dev)) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
 
 		/*
@@ -267,23 +312,25 @@ static void atp_complete(struct urb* urb
 		dev->x_old = dev->y_old = -1;
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		/* 17" Powerbooks have extra X sensors */
-		for (i = (atp_is_geyser_2(dev)?15:16); i < ATP_XSENSORS; i++) {
-			if (!dev->xy_cur[i]) continue;
-
-			printk("appletouch: 17\" model detected.\n");
-			if(atp_is_geyser_2(dev))
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (20 - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
-			else
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (ATP_XSENSORS - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
+		if (!atp_is_geyser_3(dev)) { /* No 17" Macbooks (yet) */
+			/* 17" Powerbooks have extra X sensors */
+			for (i = (atp_is_geyser_2(dev) ? 15 : 16); i < ATP_XSENSORS; i++) {
+				if (!dev->xy_cur[i]) continue;
+
+				printk("appletouch: 17\" model detected.\n");
+				if (atp_is_geyser_2(dev))
+					input_set_abs_params(dev->input, ABS_X, 0,
+							     (20 - 1) *
+							     ATP_XFACT - 1,
+							     ATP_FUZZ, 0);
+				else
+					input_set_abs_params(dev->input, ABS_X, 0,
+							     (ATP_XSENSORS - 1) *
+							     ATP_XFACT - 1,
+							     ATP_FUZZ, 0);
 
-			break;
+				break;
+			}
 		}
 
 		goto exit;
@@ -414,7 +461,47 @@ static int atp_probe(struct usb_interfac
 	dev->udev = udev;
 	dev->input = input_dev;
 	dev->overflowwarn = 0;
-	dev->datalen = (atp_is_geyser_2(dev)?64:81);
+	if (atp_is_geyser_3(dev))
+		dev->datalen = 64;
+	else if (atp_is_geyser_2(dev))
+		dev->datalen = 64;
+	else
+		dev->datalen = 81;
+
+	if (atp_is_geyser_3(dev)) {
+		/*
+		 * By default Geyser 3 device sends standard USB HID mouse packets (Report ID 2).
+		 * This code changes device mode, so it sends raw sensor reports (Report ID 5).
+		 */
+		char data[8];
+		int size;
+
+		size = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+			ATP_GEYSER3_MODE_READ_REQUEST_ID,
+			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			ATP_GEYSER3_MODE_REQUEST_VALUE, ATP_GEYSER3_MODE_REQUEST_INDEX,
+			&data, 8, 5000);
+
+		if (size != 8) {
+			err("Could not do mode read request from device (Geyser 3 mode)");
+			goto err_free_devs;
+		}
+
+		/* Apply the mode switch */
+		data[0] = ATP_GEYSER3_MODE_VENDOR_VALUE;
+
+		size = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+			ATP_GEYSER3_MODE_WRITE_REQUEST_ID,
+			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			ATP_GEYSER3_MODE_REQUEST_VALUE, ATP_GEYSER3_MODE_REQUEST_INDEX,
+			&data, 8, 5000);
+
+		if (size != 8) {
+			err("Could not do mode write request to device (Geyser 3 mode)");
+			goto err_free_devs;
+		}
+		printk("appletouch Geyser 3 inited.\n");
+	}
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb) {
@@ -447,7 +534,15 @@ static int atp_probe(struct usb_interfac
 
 	set_bit(EV_ABS, input_dev->evbit);
 
-	if (atp_is_geyser_2(dev)) {
+	if (atp_is_geyser_3(dev)) {
+		/*
+		 * MacBook have 20 X sensors, 10 Y sensors
+		 */
+		input_set_abs_params(input_dev, ABS_X, 0,
+				     ((20 - 1) * ATP_XFACT) - 1, ATP_FUZZ, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0,
+				     ((10 - 1) * ATP_YFACT) - 1, ATP_FUZZ, 0);
+	} else if (atp_is_geyser_2(dev)) {
 		/*
 		 * Oct 2005 15" PowerBooks have 15 X sensors, 17" are detected
 		 * later.


