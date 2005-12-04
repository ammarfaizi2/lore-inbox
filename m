Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVLDWma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVLDWma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVLDWma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:42:30 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:40220 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932386AbVLDWm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:42:29 -0500
Date: Sun, 4 Dec 2005 23:42:21 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Stelian Pop <stelian@popies.net>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051204224221.GA28218@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch> <20051130234653.GB15102@hansmi.ch> <1133533712.23129.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133533712.23129.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 03:28:31PM +0100, Stelian Pop wrote:
> Is this version really working well on the new Powerbooks ? From what
> I've seen in this thread there are still issues and it's still a work
> in progress, so it may be too early to integrate the changes in the
> kernel.

It works fine for the 15" PowerBooks (Oct 2005) and has been tested by
at least three people. 17" should work too, but I can't test that until
later this week.

> +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> +#include <linux/relayfs_fs.h>
> +#endif

> While the relayfs code is ok for debugging, I'm wondering if it should
> be left in the final version at all.

It doesn't hurt as it's not much code, it makes updating the driver for
newer devices easier and it's only enabled if requested. Because of
that, I would leave it in. However, I can split it into a separate patch
if wanted.

> +       int                     overflowwarn;   /* overflow warning printed? */

> I would use a static variable in the case -OVERFLOW: block here.

As there could be, due to whatever reason, multiple devices using the
same driver, one could overflow while another doesn't. Therefore, it
should be device specific.

> +               dev->xy_cur[i++] = dev->data[19];
> +               dev->xy_cur[i++] = dev->data[20];
> +               dev->xy_cur[i++] = dev->data[22];
> +               dev->xy_cur[i++] = dev->data[23];

> There is obviously a pattern here:

> 	for (i = 0; i < 15; i++)
> 		dev->xy_cur[i] = dev->data[ 19 + (i * 3) / 2 ]

It's not that easy. This code wouldn't work as it should.

I wrote a working loop into the patch below, but as the code's called
about 1'000 times a second I unrolled the loop myself. A friend of mine
calculated that the code would take at least twice the time to run when
written using a loop.

> I'm wondering if the same formula doesn't apply for more X and Y
> sensors (like 16 X and 16 Y sensors on the old Powerbooks, 26 for the
> 17" models)

It does and is addressed in the new patch below.

> What is the point in doing this since the dbg_dump is called a few lines
> later ?

Those were some leftovers from my debugging and would have been deleted
before submitting. I just didn't want to take everything out if someone
else wants to do some extensive debugging or so.

Here's an updated patch including support for the 17" PowerBooks (Oct
2005). The informations about the 17" one are from Alex Harper.

---
--- linux-2.6.15-rc5/drivers/usb/input/appletouch.c.orig	2005-12-04 20:25:21.000000000 +0100
+++ linux-2.6.15-rc5/drivers/usb/input/appletouch.c	2005-12-04 23:37:29.000000000 +0100
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
@@ -35,8 +45,13 @@
 #include <linux/input.h>
 #include <linux/usb_input.h>
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+#include <linux/relayfs_fs.h>
+#endif
+
 /* Apple has powerbooks which have the keyboard with different Product IDs */
 #define APPLE_VENDOR_ID		0x05AC
+#define GEYSER_2_PRODUCT_ID	0x0215
 
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -51,14 +66,17 @@
 static struct usb_device_id atp_table [] = {
 	{ ATP_DEVICE(0x020E) },
 	{ ATP_DEVICE(0x020F) },
+	{ ATP_DEVICE(GEYSER_2_PRODUCT_ID) },	/* PowerBooks Oct 2005 */
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
@@ -73,6 +91,7 @@
 
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
+
 /*
  * multiplication factor for the X and Y coordinates.
  * We try to keep the touchpad aspect ratio while still doing only simple
@@ -108,6 +127,8 @@
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	int			overflowwarn;	/* overflow warning printed? */
+	int			datalen;	/* size of an USB urb transfer */
 };
 
 #define dbg_dump(msg, tab) \
@@ -124,7 +145,11 @@
 		if (debug) printk(format, ##a);				\
 	} while (0)
 
-MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
+/* Checks if the device a Geyser 2 */
+#define IS_GEYSER_2(dev) \
+	(le16_to_cpu(dev->udev->descriptor.idProduct) == GEYSER_2_PRODUCT_ID)
+
+MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Parag Warudkar, Michael Hanselmann");
 MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
 MODULE_LICENSE("GPL");
 
@@ -132,6 +157,10 @@
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+static int relayfs = 0;
+module_param(relayfs, int, 0644);
+MODULE_PARM_DESC(relayfs, "Activate relayfs support");
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -175,6 +204,13 @@
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
@@ -189,23 +225,83 @@
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
+	if (IS_GEYSER_2(dev)) {
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
+		 * This code is called about 1'000 times per second for each
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
@@ -216,16 +312,23 @@
 		dev->x_old = dev->y_old = -1;
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		/* 17" Powerbooks have 10 extra X sensors */
-		for (i = 16; i < ATP_XSENSORS; i++)
-			if (dev->xy_cur[i]) {
-				printk("appletouch: 17\" model detected.\n");
+		/* 17" Powerbooks have extra X sensors */
+		for (i = (IS_GEYSER_2(dev)?15:16); i < ATP_XSENSORS; i++) {
+			if (!dev->xy_cur[i]) continue;
+
+			printk("appletouch: 17\" model detected.\n");
+			if(IS_GEYSER_2(dev))
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
@@ -282,7 +385,8 @@
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
-	input_report_key(dev->input, BTN_LEFT, !!dev->data[80]);
+	input_report_key(dev->input, BTN_LEFT,
+			 !!dev->data[dev->datalen - 1]);
 
 	input_sync(dev->input);
 
@@ -323,7 +427,6 @@
 	int int_in_endpointAddr = 0;
 	int i, retval = -ENOMEM;
 
-
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
 	iface_desc = iface->cur_altsetting;
@@ -353,6 +456,8 @@
 
 	dev->udev = udev;
 	dev->input = input_dev;
+	dev->overflowwarn = 0;
+	dev->datalen = (IS_GEYSER_2(dev)?64:81);
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb) {
@@ -360,7 +465,7 @@
 		goto err_free_devs;
 	}
 
-	dev->data = usb_buffer_alloc(dev->udev, ATP_DATASIZE, GFP_KERNEL,
+	dev->data = usb_buffer_alloc(dev->udev, dev->datalen, GFP_KERNEL,
 				     &dev->urb->transfer_dma);
 	if (!dev->data) {
 		retval = -ENOMEM;
@@ -369,7 +474,7 @@
 
 	usb_fill_int_urb(dev->urb, udev,
 			 usb_rcvintpipe(udev, int_in_endpointAddr),
-			 dev->data, ATP_DATASIZE, atp_complete, dev, 1);
+			 dev->data, dev->datalen, atp_complete, dev, 1);
 
 	usb_make_path(udev, dev->phys, sizeof(dev->phys));
 	strlcat(dev->phys, "/input0", sizeof(dev->phys));
@@ -385,14 +490,25 @@
 
 	set_bit(EV_ABS, input_dev->evbit);
 
-	/*
-	 * 12" and 15" Powerbooks only have 16 x sensors,
-	 * 17" models are detected later.
-	 */
-	input_set_abs_params(input_dev, ABS_X, 0,
-			     (16 - 1) * ATP_XFACT - 1, ATP_FUZZ, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0,
-			     (ATP_YSENSORS - 1) * ATP_YFACT - 1, ATP_FUZZ, 0);
+	if (IS_GEYSER_2(dev)) {
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
@@ -427,7 +543,7 @@
 		usb_kill_urb(dev->urb);
 		input_unregister_device(dev->input);
 		usb_free_urb(dev->urb);
-		usb_buffer_free(dev->udev, ATP_DATASIZE,
+		usb_buffer_free(dev->udev, dev->datalen,
 				dev->data, dev->urb->transfer_dma);
 		kfree(dev);
 	}
@@ -463,11 +579,30 @@
 
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
 
