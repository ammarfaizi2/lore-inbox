Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVLQBTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVLQBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVLQBTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 20:19:09 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:34589 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751349AbVLQBTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 20:19:07 -0500
Date: Sat, 17 Dec 2005 02:19:00 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linux-kernel@vger.kernel.org
Cc: olof@lixom.net, kernel-stuff@comcast.net, linuxppc-dev@ozlabs.org,
       linux-input@atrey.karlin.mff.cuni.cz, stelian@popies.net,
       johannes@sipsolutions.net
Subject: Re: [PATCH 2.6 2/2] usb/input: Add Geyser 2 support to appletouch driver
Message-ID: <20051217011900.GA4134@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch> <20051213224019.GC20017@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213224019.GC20017@hansmi.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Geyser 2 touchpads used on post Oct 2005
Apple PowerBooks to the appletouch driver.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>  
Acked-by: Johannes Berg <johannes@sipsolutions.net>  
Acked-by: Stelian Pop <stelian@popies.net>
---
Rediffed without relayfs and made loops out of the manually unrolled
assignment code.

diff -rup linux-2.6.15-rc5.orig/Documentation/input/appletouch.txt b/Documentation/input/appletouch.txt
--- linux-2.6.15-rc5.orig/Documentation/input/appletouch.txt	2005-12-13 00:09:24.000000000 +0100
+++ b/Documentation/input/appletouch.txt	2005-12-17 02:06:27.000000000 +0100
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
diff -rup linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c b/drivers/usb/input/appletouch.c
--- linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c	2005-12-13 22:44:24.000000000 +0100
+++ b/drivers/usb/input/appletouch.c	2005-12-17 02:13:02.000000000 +0100
@@ -6,6 +6,7 @@
  * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
+ * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
@@ -38,6 +39,11 @@
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
@@ -53,13 +59,17 @@ static struct usb_device_id atp_table []
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
 
-/* size of a USB urb transfer */
-#define ATP_DATASIZE	81
-
 /*
  * number of sensors. Note that only 16 instead of 26 X (horizontal)
  * sensors exist on 12" and 15" PowerBooks. All models have 16 Y
@@ -108,6 +118,8 @@ struct atp {
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	int			overflowwarn;	/* overflow warning printed? */
+	int			datalen;	/* size of an USB urb transfer */
 };
 
 #define dbg_dump(msg, tab) \
@@ -124,7 +136,7 @@ struct atp {
 		if (debug) printk(format, ##a);				\
 	} while (0)
 
-MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
+MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Michael Hanselmann");
 MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
 MODULE_LICENSE("GPL");
 
@@ -132,6 +144,16 @@ static int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
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
@@ -168,13 +190,20 @@ static inline void atp_report_fingers(st
 static void atp_complete(struct urb* urb, struct pt_regs* regs)
 {
 	int x, y, x_z, y_z, x_f, y_f;
-	int retval, i;
+	int retval, i, j;
 	struct atp *dev = urb->context;
 
 	switch (urb->status) {
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
@@ -189,23 +218,45 @@ static void atp_complete(struct urb* urb
 	}
 
 	/* drop incomplete datasets */
-	if (dev->urb->actual_length != ATP_DATASIZE) {
+	if (dev->urb->actual_length != dev->datalen) {
 		dprintk("appletouch: incomplete data package.\n");
 		goto exit;
 	}
 
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
+		 * Y1, Y2, -, Y3, Y4, -, ..., X1, X2, -, X3, X4, -, ...
+		 * '-' is an unused value.
+		 */
+
+		/* read X values */
+		for (i = 0, j = 19; i < 20; i += 2, j += 3) {
+			dev->xy_cur[i] = dev->data[j];
+			dev->xy_cur[i + 1] = dev->data[j + 1];
+		}
+
+		/* read Y values */
+		for (i = 0, j = 1; i < 9; i += 2, j += 3) {
+			dev->xy_cur[ATP_XSENSORS + i] = dev->data[j];
+			dev->xy_cur[ATP_XSENSORS + i + 1] = dev->data[j + 1];
+		}
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
@@ -216,16 +267,24 @@ static void atp_complete(struct urb* urb
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
@@ -282,7 +341,8 @@ static void atp_complete(struct urb* urb
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
-	input_report_key(dev->input, BTN_LEFT, !!dev->data[80]);
+	input_report_key(dev->input, BTN_LEFT,
+			 !!dev->data[dev->datalen - 1]);
 
 	input_sync(dev->input);
 
@@ -353,6 +413,8 @@ static int atp_probe(struct usb_interfac
 
 	dev->udev = udev;
 	dev->input = input_dev;
+	dev->overflowwarn = 0;
+	dev->datalen = (atp_is_geyser_2(dev)?64:81);
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb) {
@@ -360,7 +422,7 @@ static int atp_probe(struct usb_interfac
 		goto err_free_devs;
 	}
 
-	dev->data = usb_buffer_alloc(dev->udev, ATP_DATASIZE, GFP_KERNEL,
+	dev->data = usb_buffer_alloc(dev->udev, dev->datalen, GFP_KERNEL,
 				     &dev->urb->transfer_dma);
 	if (!dev->data) {
 		retval = -ENOMEM;
@@ -369,7 +431,7 @@ static int atp_probe(struct usb_interfac
 
 	usb_fill_int_urb(dev->urb, udev,
 			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, ATP_DATASIZE, atp_complete, dev, 1);
+			 dev->data, dev->datalen, atp_complete, dev, 1);
 
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
@@ -385,14 +447,25 @@ static int atp_probe(struct usb_interfac
 
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
@@ -427,7 +500,7 @@ static void atp_disconnect(struct usb_in
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
 		usb_free_urb(dev->urb);
-		usb_buffer_free(dev->udev, ATP_DATASIZE,
+		usb_buffer_free(dev->udev, dev->datalen,
 				dev->data, dev->urb->transfer_dma);
 		kfree(dev);
 	}
