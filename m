Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVLIXdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVLIXdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVLIXdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:33:51 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:6173 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932510AbVLIXdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:33:50 -0500
Date: Sat, 10 Dec 2005 00:33:42 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andy Botting <andy@andybotting.com>
Cc: Stelian Pop <stelian@popies.net>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051209233342.GA23980@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch> <20051130234653.GB15102@hansmi.ch> <1133533712.23129.25.camel@localhost.localdomain> <20051204224221.GA28218@hansmi.ch> <1133840316.10415.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133840316.10415.4.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I managed to get this working on my 15" PowerBook, but the USB id for my
> Keyboard/Trackpad is 0x0214 as opposed to the 0x0215 you have in the
> patch. Are you going to add 0x0214 (and any others?) to this patch
> before sending it off?

This patch adds support for 0x0214 and 0x0216 in addition to 0x0215. I
found those IDs in the Info.plist of Mac OS X (see comment in the patch).
It applies cleanly to 2.6.15-rc5 (vanilla).

---
--- linux-2.6.15-rc5/drivers/usb/input/appletouch.c.orig	2005-12-04 20:25:21.000000000 +0100
+++ linux-2.6.15-rc5/drivers/usb/input/appletouch.c	2005-12-09 21:02:55.000000000 +0100
@@ -6,9 +6,19 @@
  * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
+ * Copyright (C) 2005      Parag Warudkar (parag.warudkar@gmail.com)
+ * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
+ * Nov 2005 - Parag Warudkar 
+ *  o Added ability to export data via relayfs
+ *
+ * Nov 2005 - Michael Hanselmann
+ *  o Compile relayfs support only if enabled in the kernel
+ *  o Enable relayfs only if requested by the user
+ *  o Added support for new October 2005 PowerBooks (Geyser 2)
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -35,9 +45,18 @@
 #include <linux/input.h>
 #include <linux/usb_input.h>
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+#include <linux/relayfs_fs.h>
+#endif
+
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
@@ -53,12 +72,21 @@
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
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+struct rchan* rch = NULL;
+struct rchan_callbacks* rcb = NULL;
+#endif
 
 /*
  * number of sensors. Note that only 16 instead of 26 X (horizontal)
@@ -73,6 +101,7 @@
 
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
+
 /*
  * multiplication factor for the X and Y coordinates.
  * We try to keep the touchpad aspect ratio while still doing only simple
@@ -108,6 +137,8 @@
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	int			overflowwarn;	/* overflow warning printed? */
+	int			datalen;	/* size of an USB urb transfer */
 };
 
 #define dbg_dump(msg, tab) \
@@ -124,7 +155,7 @@
 		if (debug) printk(format, ##a);				\
 	} while (0)
 
-MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
+MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Parag Warudkar, Michael Hanselmann");
 MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
 MODULE_LICENSE("GPL");
 
@@ -132,6 +163,20 @@
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+static int relayfs = 0;
+module_param(relayfs, int, 0644);
+MODULE_PARM_DESC(relayfs, "Activate relayfs support");
+
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
@@ -175,6 +220,13 @@
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
@@ -189,23 +241,83 @@
 	}
 
 	/* drop incomplete datasets */
-	if (dev->urb->actual_length != ATP_DATASIZE) {
+	if (dev->urb->actual_length != dev->datalen) {
 		dprintk("appletouch: incomplete data package.\n");
 		goto exit;
 	}
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+	if (relayfs && dev->data) {
+		relay_write(rch, dev->data, dev->urb->actual_length);
+	}
+#endif
+
 	/* reorder the sensors values */
-	for (i = 0; i < 8; i++) {
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
+		 * This code is called about 100 times per second for each
+		 * interrupt from the touchpad. Therefore it should be as fast
+		 * as possible. Writing the following code in a loop would take
+		 * about twice the time to run if not more.
+		 */
+
 		/* X values */
-		dev->xy_cur[i     ] = dev->data[5 * i +  2];
-		dev->xy_cur[i +  8] = dev->data[5 * i +  4];
-		dev->xy_cur[i + 16] = dev->data[5 * i + 42];
-		if (i < 2)
-			dev->xy_cur[i + 24] = dev->data[5 * i + 44];
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
 
 		/* Y values */
-		dev->xy_cur[i + 26] = dev->data[5 * i +  1];
-		dev->xy_cur[i + 34] = dev->data[5 * i +  3];
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
@@ -216,16 +328,23 @@
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
+			break;
+		}
 
 		goto exit;
 	}
@@ -282,7 +401,8 @@
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
-	input_report_key(dev->input, BTN_LEFT, !!dev->data[80]);
+	input_report_key(dev->input, BTN_LEFT,
+			 !!dev->data[dev->datalen - 1]);
 
 	input_sync(dev->input);
 
@@ -323,7 +443,6 @@
 	int int_in_endpointAddr = 0;
 	int i, retval = -ENOMEM;
 
-
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
 	iface_desc = iface->cur_altsetting;
@@ -353,6 +472,8 @@
 
 	dev->udev = udev;
 	dev->input = input_dev;
+	dev->overflowwarn = 0;
+	dev->datalen = (atp_is_geyser_2(dev)?64:81);
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb) {
@@ -360,7 +481,7 @@
 		goto err_free_devs;
 	}
 
-	dev->data = usb_buffer_alloc(dev->udev, ATP_DATASIZE, GFP_KERNEL,
+	dev->data = usb_buffer_alloc(dev->udev, dev->datalen, GFP_KERNEL,
 				     &dev->urb->transfer_dma);
 	if (!dev->data) {
 		retval = -ENOMEM;
@@ -369,7 +490,7 @@
 
 	usb_fill_int_urb(dev->urb, udev,
 			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, ATP_DATASIZE, atp_complete, dev, 1);
+			 dev->data, dev->datalen, atp_complete, dev, 1);
 
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
@@ -385,14 +506,25 @@
 
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
@@ -427,7 +559,7 @@
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
 		usb_free_urb(dev->urb);
-		usb_buffer_free(dev->udev, ATP_DATASIZE,
+		usb_buffer_free(dev->udev, dev->datalen,
 				dev->data, dev->urb->transfer_dma);
 		kfree(dev);
 	}
@@ -463,11 +595,30 @@
 
 static int __init atp_init(void)
 {
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+	if (relayfs) {
+		rcb = kmalloc(sizeof(struct rchan_callbacks), GFP_KERNEL);
+		rcb->subbuf_start = NULL;
+		rcb->buf_mapped = NULL;
+		rcb->buf_unmapped = NULL;
+		rch = relay_open("atpdata", NULL, 256, 256, NULL);
+		if (!rch) return -ENOMEM;
+		printk("appletouch: Relayfs enabled.\n");
+	} else {
+		printk("appletouch: Relayfs disabled.\n");
+	}
+#endif
 	return usb_register(&atp_driver);
 }
 
 static void __exit atp_exit(void)
 {
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+	if (relayfs) {
+		relay_close(rch);
+		kfree(rcb);
+	}
+#endif
 	usb_deregister(&atp_driver);
 }
 
