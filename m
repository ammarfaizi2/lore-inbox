Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVK3Xq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVK3Xq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVK3Xq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:46:57 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:12573 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751278AbVK3Xq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:46:56 -0500
Date: Thu, 1 Dec 2005 00:46:53 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051130234653.GB15102@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20051130223917.GA15102@hansmi.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 30, 2005 at 11:39:17PM +0100, Michael Hanselmann wrote:
> The patch is attached for easier use.

There was a mistake in it due to which the mouse button wouldn't work.
Fixed in the now attached patch.

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.15-rc3-appletouch-relayfs-0x0215.diff"

--- linux-2.6.15-rc3/drivers/usb/input/appletouch.c.orig	2005-11-29 21:30:37.000000000 +0100
+++ linux-2.6.15-rc3/drivers/usb/input/appletouch.c	2005-11-30 23:40:19.000000000 +0100
@@ -6,9 +6,19 @@
  * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
+ * Copyright (C) 2005      Parag Warudkar (parag.warudkar@gmail.com)
+ * Copyright (C) 2005      Michael hanselmann (linux-kernel@hansmi.ch)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
+ * Nov 2005 - Parag Warudkar 
+ *  o Added ability to export data via relayfs
+ *
+ * Nov 2005 - Michael Hanselmann
+ *  o Compile relayfs support only if enabled in the kernel
+ *  o Enable relayfs only if requested by the user
+ *  o Added support for new October 2005 PowerBooks (0x0215)
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -35,6 +45,10 @@
 #include <linux/input.h>
 #include <linux/usb_input.h>
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+#include <linux/relayfs_fs.h>
+#endif
+
 /* Apple has powerbooks which have the keyboard with different Product IDs */
 #define APPLE_VENDOR_ID		0x05AC
 
@@ -51,14 +65,17 @@
 static struct usb_device_id atp_table [] = {
 	{ ATP_DEVICE(0x020E) },
 	{ ATP_DEVICE(0x020F) },
+	{ ATP_DEVICE(0x0215) },	/* PowerBook 1.67 GHz, Oct 2005, PowerBook5,8 */
 	{ ATP_DEVICE(0x030A) },
 	{ ATP_DEVICE(0x030B) },
 	{ }					/* Terminating entry */
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
@@ -108,6 +125,9 @@
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	int			is0215;		/* is the device a 0x0215? */
+	int			overflowwarn;	/* overflow warning printed? */
+	int			datalen;	/* size of a USB urb transfer */
 };
 
 #define dbg_dump(msg, tab) \
@@ -132,6 +152,10 @@
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+static int relayfs = 0;
+module_param(relayfs, int, 0644);
+MODULE_PARM_DESC(relayfs, "Activate relayfs support");
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -175,6 +199,13 @@
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
@@ -189,23 +220,84 @@
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
+	if (dev->is0215) {
+		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
+
+		// Read the X values
+		i = 0;
+		dev->xy_cur[i++] = dev->data[19];
+		dev->xy_cur[i++] = dev->data[20];
+		dev->xy_cur[i++] = dev->data[22];
+		dev->xy_cur[i++] = dev->data[23];
+		dev->xy_cur[i++] = dev->data[25];
+		dev->xy_cur[i++] = dev->data[26];
+		dev->xy_cur[i++] = dev->data[28];
+		dev->xy_cur[i++] = dev->data[29];
+		dev->xy_cur[i++] = dev->data[31];
+		dev->xy_cur[i++] = dev->data[32];
+		dev->xy_cur[i++] = dev->data[34];
+		dev->xy_cur[i++] = dev->data[35];
+		dev->xy_cur[i++] = dev->data[37];
+		dev->xy_cur[i++] = dev->data[38];
+		dev->xy_cur[i++] = dev->data[40];
+
+		// Read the Y values
+		i = ATP_XSENSORS;
+		dev->xy_cur[i++] = dev->data[1];
+		dev->xy_cur[i++] = dev->data[2];
+		dev->xy_cur[i++] = dev->data[4];
+		dev->xy_cur[i++] = dev->data[5];
+		dev->xy_cur[i++] = dev->data[7];
+		dev->xy_cur[i++] = dev->data[8];
+		dev->xy_cur[i++] = dev->data[10];
+		dev->xy_cur[i++] = dev->data[11];
+		dev->xy_cur[i++] = dev->data[13];
+
+#if 0
+		/* Some debug code */
+		for (i = 0; i < dev->urb->actual_length; i++) {
+			printk("%2x,", (unsigned char)dev->data[i]);
+		}
+		printk("\n");
+#endif
+
+		/* Prints the read values */
+		if (debug > 1) {
+			printk("appletouch: X=");
+			for (i = 0; i < 15; i++) {
+				printk("%2x,", (unsigned char)dev->xy_cur[i]);
+			}
+			printk("  Y=");
+			for (i = ATP_XSENSORS; i < (ATP_XSENSORS + (9 - 1)); i++) {
+				printk("%2x,", (unsigned char)dev->xy_cur[i]);
+			}
+			printk("\n");
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
@@ -216,16 +308,18 @@
 		dev->x_old = dev->y_old = -1;
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		/* 17" Powerbooks have 10 extra X sensors */
-		for (i = 16; i < ATP_XSENSORS; i++)
-			if (dev->xy_cur[i]) {
-				printk("appletouch: 17\" model detected.\n");
-				input_set_abs_params(dev->input, ABS_X, 0,
-						     (ATP_XSENSORS - 1) *
-						     ATP_XFACT - 1,
-						     ATP_FUZZ, 0);
-				break;
-			}
+		if (!dev->is0215) {
+			/* 17" Powerbooks have 10 extra X sensors */
+			for (i = 16; i < ATP_XSENSORS; i++)
+				if (dev->xy_cur[i]) {
+					printk("appletouch: 17\" model detected.\n");
+					input_set_abs_params(dev->input, ABS_X, 0,
+							     (ATP_XSENSORS - 1) *
+							     ATP_XFACT - 1,
+							     ATP_FUZZ, 0);
+					break;
+				}
+		}
 
 		goto exit;
 	}
@@ -323,7 +417,6 @@
 	int int_in_endpointAddr = 0;
 	int i, retval = -ENOMEM;
 
-
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
 	iface_desc = iface->cur_altsetting;
@@ -335,6 +428,8 @@
 					== USB_ENDPOINT_XFER_INT)) {
 			/* we found an interrupt in endpoint */
 			int_in_endpointAddr = endpoint->bEndpointAddress;
+			printk(KERN_INFO "appletouch: atp_probe found interrupt "
+			       "in endpoint: %d\n", int_in_endpointAddr);
 			break;
 		}
 	}
@@ -353,6 +448,13 @@
 
 	dev->udev = udev;
 	dev->input = input_dev;
+	dev->is0215 = (le16_to_cpu(dev->udev->descriptor.idProduct) == 0x0215);
+	dev->overflowwarn = 0;
+	if (dev->is0215) {
+		dev->datalen = 64;
+	} else {
+		dev->datalen = 81;
+	}
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb) {
@@ -360,7 +462,7 @@
 		goto err_free_devs;
 	}
 
-	dev->data = usb_buffer_alloc(dev->udev, ATP_DATASIZE, GFP_KERNEL,
+	dev->data = usb_buffer_alloc(dev->udev, dev->datalen, GFP_KERNEL,
 				     &dev->urb->transfer_dma);
 	if (!dev->data) {
 		retval = -ENOMEM;
@@ -369,7 +471,7 @@
 
 	usb_fill_int_urb(dev->urb, udev,
 			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, ATP_DATASIZE, atp_complete, dev, 1);
+			 dev->data, dev->datalen, atp_complete, dev, 1);
 
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
@@ -385,14 +487,21 @@
 
 	set_bit(EV_ABS, input_dev->evbit);
 
-	/*
-	 * 12" and 15" Powerbooks only have 16 x sensors,
-	 * 17" models are detected later.
-	 */
-	input_set_abs_params(input_dev, ABS_X, 0,
-			     (16 - 1) * ATP_XFACT - 1, ATP_FUZZ, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0,
-			     (ATP_YSENSORS - 1) * ATP_YFACT - 1, ATP_FUZZ, 0);
+	if (dev->is0215) {
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
@@ -427,7 +536,7 @@
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
 		usb_free_urb(dev->urb);
-		usb_buffer_free(dev->udev, ATP_DATASIZE,
+		usb_buffer_free(dev->udev, dev->datalen,
 				dev->data, dev->urb->transfer_dma);
 		kfree(dev);
 	}
@@ -463,11 +572,30 @@
 
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
 

--ADZbWkCsHQ7r3kzd--
