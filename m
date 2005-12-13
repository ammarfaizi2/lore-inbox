Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbVLMWkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbVLMWkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVLMWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:40:25 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:3357 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1030319AbVLMWkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:40:23 -0500
Date: Tue, 13 Dec 2005 23:40:19 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       kernel-stuff@comcast.net
Subject: [PATCH 2.6 2/2] usb/input: Add Geyser 2 support to appletouch driver
Message-ID: <20051213224019.GC20017@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213223659.GB20017@hansmi.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Geyser 2 touchpads used on Post-Oct 2005
Apple PowerBooks to the appletouch driver.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>  
Acked-by: Johannes Berg <johannes@sipsolutions.net>  
---
diff -Npur linux-2.6.15-rc5.orig/Documentation/input/appletouch.txt linux-2.6.15-rc5/Documentation/input/appletouch.txt
--- linux-2.6.15-rc5.orig/Documentation/input/appletouch.txt	2005-12-13 00:09:24.000000000 +0100
+++ linux-2.6.15-rc5/Documentation/input/appletouch.txt	2005-12-13 21:28:26.000000000 +0100
@@ -3,7 +3,7 @@ Apple Touchpad Driver (appletouch)
 	Copyright (C) 2005 Stelian Pop <stelian@popies.net>
 
 appletouch is a Linux kernel driver for the USB touchpad found on post
-February 2005 Apple Alu Powerbooks.
+February 2005 and October 2005 Apple Aluminium Powerbooks.
 
 This driver is derived from Johannes Berg's appletrackpad driver[1], but it has
 been improved in some areas:
@@ -13,7 +13,8 @@ been improved in some areas:
 
 Credits go to Johannes Berg for reverse-engineering the touchpad protocol,
 Frank Arnold for further improvements, and Alex Harper for some additional
-information about the inner workings of the touchpad sensors.
+information about the inner workings of the touchpad sensors. Michael
+Hanselmann added support for the October 2005 models.
 
 Usage:
 ------

diff -Npur linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c linux-2.6.15-rc5/drivers/usb/input/appletouch.c
--- linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c	2005-12-13 22:44:36.000000000 +0100
+++ linux-2.6.15-rc5/drivers/usb/input/appletouch.c	2005-12-13 22:55:19.000000000 +0100
@@ -17,6 +17,7 @@
  * Nov/Dec 2005 - Michael Hanselmann
  *  o Compile relayfs support only if enabled in the kernel
  *  o Enable relayfs only if requested by the user
+ *  o Added support for new October 2005 PowerBooks (Geyser 2)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -51,6 +52,11 @@
 /* Apple has powerbooks which have the keyboard with different Product IDs */
 #define APPLE_VENDOR_ID		0x05AC
 
+/* These names come from Info.plist in AppleUSBTrackpad.kext */
+#define GEYSER_ANSI_PRODUCT_ID	0x0214
+#define GEYSER_ISO_PRODUCT_ID	0x0215
+#define GEYSER_JIS_PRODUCT_ID	0x0216
+
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -66,7 +72,14 @@ static struct usb_device_id atp_table []
 	{ ATP_DEVICE(0x020F) },
 	{ ATP_DEVICE(0x030A) },
 	{ ATP_DEVICE(0x030B) },
-	{ }					/* Terminating entry */
+
+	/* PowerBooks Oct 2005 */
+	{ ATP_DEVICE(GEYSER_ANSI_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER_ISO_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER_JIS_PRODUCT_ID) },
+
+	/* Terminating entry */
+	{ }
 };
 MODULE_DEVICE_TABLE (usb, atp_table);
 
@@ -75,9 +88,6 @@ struct rchan* rch = NULL;
 struct rchan_callbacks* rcb = NULL;
 #endif
 
-/* size of a USB urb transfer */
-#define ATP_DATASIZE	81
-
 /*
  * number of sensors. Note that only 16 instead of 26 X (horizontal)
  * sensors exist on 12" and 15" PowerBooks. All models have 16 Y
@@ -127,6 +137,8 @@ struct atp {
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	int			overflowwarn;	/* overflow warning printed? */
+	int			datalen;	/* size of an USB urb transfer */
 };
 
 #define dbg_dump(msg, tab) \
@@ -157,6 +169,16 @@ module_param(relayfs, int, 0644);
 MODULE_PARM_DESC(relayfs, "Activate relayfs support");
 #endif
 
+/* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
+static inline int atp_is_geyser_2(struct atp *dev)
+{
+	int16_t productId = le16_to_cpu(dev->udev->descriptor.idProduct);
+
+	return (productId == GEYSER_ANSI_PRODUCT_ID) ||
+		(productId == GEYSER_ISO_PRODUCT_ID) ||
+		(productId == GEYSER_JIS_PRODUCT_ID);
+}
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -200,6 +222,13 @@ static void atp_complete(struct urb* urb
 	case 0:
 		/* success */
 		break;
+	case -EOVERFLOW:
+		if(!dev->overflowwarn) {
+			printk("appletouch: OVERFLOW with data "
+				"length %d, actual length is %d\n",
+				dev->datalen, dev->urb->actual_length);
+			dev->overflowwarn = 1;
+		}
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
@@ -214,7 +243,7 @@ static void atp_complete(struct urb* urb
 	}
 
 	/* drop incomplete datasets */
-	if (dev->urb->actual_length != ATP_DATASIZE) {
+	if (dev->urb->actual_length != dev->datalen) {
 		dprintk("appletouch: incomplete data package.\n");
 		goto exit;
 	}
@@ -227,17 +256,72 @@ static void atp_complete(struct urb* urb
 #endif
 
 	/* reorder the sensors values */
-	for (i = 0; i < 8; i++) {
-		/* X values */
-		dev->xy_cur[i     ] = dev->data[5 * i +  2];
-		dev->xy_cur[i +  8] = dev->data[5 * i +  4];
-		dev->xy_cur[i + 16] = dev->data[5 * i + 42];
-		if (i < 2)
-			dev->xy_cur[i + 24] = dev->data[5 * i + 44];
-
-		/* Y values */
-		dev->xy_cur[i + 26] = dev->data[5 * i +  1];
-		dev->xy_cur[i + 34] = dev->data[5 * i +  3];
+	if (atp_is_geyser_2(dev)) {
+		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
+
+		/*
+		 * The values are laid out like this:
+		 * Y1, Y2, -, Y3, Y4, -, ...
+		 * '-' is an unused value.
+		 *
+		 * The logic in a loop:
+		 * for (i = 0, j = 19; i < 20; i += 2, j += 3) {
+		 *	dev->xy_cur[i] = dev->data[j];
+		 *	dev->xy_cur[i + 1] = dev->data[j + 1];
+		 * }
+		 *
+		 * This code is called about 100 times per second because it is
+		 * called for each interrupt transfer from the touchpad.
+		 * Therefore it should be as fast as possible. Writing the
+		 * following code in a loop would take about twice the time to
+		 * run if not more.
+		 */
+
+		/* read X values */
+		dev->xy_cur[0] = dev->data[19];
+		dev->xy_cur[1] = dev->data[20];
+		dev->xy_cur[2] = dev->data[22];
+		dev->xy_cur[3] = dev->data[23];
+		dev->xy_cur[4] = dev->data[25];
+		dev->xy_cur[5] = dev->data[26];
+		dev->xy_cur[6] = dev->data[28];
+		dev->xy_cur[7] = dev->data[29];
+		dev->xy_cur[8] = dev->data[31];
+		dev->xy_cur[9] = dev->data[32];
+		dev->xy_cur[10] = dev->data[34];
+		dev->xy_cur[11] = dev->data[35];
+		dev->xy_cur[12] = dev->data[37];
+		dev->xy_cur[13] = dev->data[38];
+		dev->xy_cur[14] = dev->data[40];
+		dev->xy_cur[15] = dev->data[41];
+		dev->xy_cur[16] = dev->data[43];
+		dev->xy_cur[17] = dev->data[44];
+		dev->xy_cur[18] = dev->data[46];
+		dev->xy_cur[19] = dev->data[47];
+
+		/* read Y values */
+		dev->xy_cur[ATP_XSENSORS + 0] = dev->data[1];
+		dev->xy_cur[ATP_XSENSORS + 1] = dev->data[2];
+		dev->xy_cur[ATP_XSENSORS + 2] = dev->data[4];
+		dev->xy_cur[ATP_XSENSORS + 3] = dev->data[5];
+		dev->xy_cur[ATP_XSENSORS + 4] = dev->data[7];
+		dev->xy_cur[ATP_XSENSORS + 5] = dev->data[8];
+		dev->xy_cur[ATP_XSENSORS + 6] = dev->data[10];
+		dev->xy_cur[ATP_XSENSORS + 7] = dev->data[11];
+		dev->xy_cur[ATP_XSENSORS + 8] = dev->data[13];
+	} else {
+		for (i = 0; i < 8; i++) {
+			/* X values */
+			dev->xy_cur[i     ] = dev->data[5 * i +  2];
+			dev->xy_cur[i +  8] = dev->data[5 * i +  4];
+			dev->xy_cur[i + 16] = dev->data[5 * i + 42];
+			if (i < 2)
+				dev->xy_cur[i + 24] = dev->data[5 * i + 44];
+
+			/* Y values */
+			dev->xy_cur[i + 26] = dev->data[5 * i +  1];
+			dev->xy_cur[i + 34] = dev->data[5 * i +  3];
+		}
 	}
 
 	dbg_dump("sample", dev->xy_cur);
@@ -248,16 +332,24 @@ static void atp_complete(struct urb* urb
 		dev->x_old = dev->y_old = -1;
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		/* 17" Powerbooks have 10 extra X sensors */
-		for (i = 16; i < ATP_XSENSORS; i++)
-			if (dev->xy_cur[i]) {
-				printk("appletouch: 17\" model detected.\n");
+		/* 17" Powerbooks have extra X sensors */
+		for (i = (atp_is_geyser_2(dev)?15:16); i < ATP_XSENSORS; i++) {
+			if (!dev->xy_cur[i]) continue;
+
+			printk("appletouch: 17\" model detected.\n");
+			if(atp_is_geyser_2(dev))
+				input_set_abs_params(dev->input, ABS_X, 0,
+						     (20 - 1) *
+						     ATP_XFACT - 1,
+						     ATP_FUZZ, 0);
+			else
 				input_set_abs_params(dev->input, ABS_X, 0,
 						     (ATP_XSENSORS - 1) *
 						     ATP_XFACT - 1,
 						     ATP_FUZZ, 0);
-				break;
-			}
+
+			break;
+		}
 
 		goto exit;
 	}
@@ -314,7 +406,8 @@ static void atp_complete(struct urb* urb
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
-	input_report_key(dev->input, BTN_LEFT, !!dev->data[80]);
+	input_report_key(dev->input, BTN_LEFT,
+			 !!dev->data[dev->datalen - 1]);
 
 	input_sync(dev->input);
 
@@ -355,7 +448,6 @@ static int atp_probe(struct usb_interfac
 	int int_in_endpointAddr = 0;
 	int i, retval = -ENOMEM;
 
-
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
 	iface_desc = iface->cur_altsetting;
@@ -385,6 +477,8 @@ static int atp_probe(struct usb_interfac
 
 	dev->udev = udev;
 	dev->input = input_dev;
+	dev->overflowwarn = 0;
+	dev->datalen = (atp_is_geyser_2(dev)?64:81);
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb) {
@@ -392,7 +486,7 @@ static int atp_probe(struct usb_interfac
 		goto err_free_devs;
 	}
 
-	dev->data = usb_buffer_alloc(dev->udev, ATP_DATASIZE, GFP_KERNEL,
+	dev->data = usb_buffer_alloc(dev->udev, dev->datalen, GFP_KERNEL,
 				     &dev->urb->transfer_dma);
 	if (!dev->data) {
 		retval = -ENOMEM;
@@ -401,7 +495,7 @@ static int atp_probe(struct usb_interfac
 
 	usb_fill_int_urb(dev->urb, udev,
 			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, ATP_DATASIZE, atp_complete, dev, 1);
+			 dev->data, dev->datalen, atp_complete, dev, 1);
 
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
@@ -417,14 +511,25 @@ static int atp_probe(struct usb_interfac
 
 	set_bit(EV_ABS, input_dev->evbit);
 
-	/*
-	 * 12" and 15" Powerbooks only have 16 x sensors,
-	 * 17" models are detected later.
-	 */
-	input_set_abs_params(input_dev, ABS_X, 0,
-			     (16 - 1) * ATP_XFACT - 1, ATP_FUZZ, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0,
-			     (ATP_YSENSORS - 1) * ATP_YFACT - 1, ATP_FUZZ, 0);
+	if (atp_is_geyser_2(dev)) {
+		/*
+		 * Oct 2005 15" PowerBooks have 15 X sensors, 17" are detected
+		 * later.
+		 */
+		input_set_abs_params(input_dev, ABS_X, 0,
+				     ((15 - 1) * ATP_XFACT) - 1, ATP_FUZZ, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0,
+				     ((9 - 1) * ATP_YFACT) - 1, ATP_FUZZ, 0);
+	} else {
+		/*
+		 * 12" and 15" Powerbooks only have 16 x sensors,
+		 * 17" models are detected later.
+		 */
+		input_set_abs_params(input_dev, ABS_X, 0,
+				     (16 - 1) * ATP_XFACT - 1, ATP_FUZZ, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0,
+				     (ATP_YSENSORS - 1) * ATP_YFACT - 1, ATP_FUZZ, 0);
+	}
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);
 
 	set_bit(EV_KEY, input_dev->evbit);
@@ -459,7 +564,7 @@ static void atp_disconnect(struct usb_in
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
 		usb_free_urb(dev->urb);
-		usb_buffer_free(dev->udev, ATP_DATASIZE,
+		usb_buffer_free(dev->udev, dev->datalen,
 				dev->data, dev->urb->transfer_dma);
 		kfree(dev);
 	}
