Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVGLTWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVGLTWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVGLTWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:22:13 -0400
Received: from sd291.sivit.org ([194.146.225.122]:50700 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262318AbVGLTWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:22:02 -0400
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
From: Stelian Pop <stelian@popies.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Peter Osterlund <petero2@telia.com>,
       Johannes Berg <johannes@sipsolutions.net>,
       Frank Arnold <frank@scirocco-5v-turbo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050712181315.GB1456@ucw.cz>
References: <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
	 <1121078371.12621.36.camel@localhost.localdomain>
	 <20050711110024.GA23333@ucw.cz>
	 <1121080115.12627.44.camel@localhost.localdomain>
	 <20050711112121.GA24345@ucw.cz>
	 <1121159126.4656.14.camel@localhost.localdomain>
	 <d120d5000507120713646089ee@mail.gmail.com>
	 <1121178794.4648.31.camel@localhost.localdomain>
	 <d120d5000507120747692ffc7@mail.gmail.com>  <20050712181315.GB1456@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 12 Jul 2005 21:21:57 +0200
Message-Id: <1121196117.17924.1.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 juillet 2005 à 20:13 +0200, Vojtech Pavlik a écrit :

> Stelian, can you please update the patch to use usb_to_input_id()? It'll
> go through -mm first, anyway, so there shouldn't be any issue with
> Linus's kernels not having that function yet.

Sure, here it comes.

Stelian.

Changes:
	* removed local version number
	* use usb_to_input_id() instead of manually setting the fields

Signed-off-by: Stelian Pop <stelian@popies.net>

 Documentation/input/appletouch.txt |   84 ++++++
 drivers/usb/input/Kconfig          |   19 +
 drivers/usb/input/Makefile         |    1 
 drivers/usb/input/appletouch.c     |  467 +++++++++++++++++++++++++++++++++++++
 4 files changed, 571 insertions(+)

Index: linux-2.6.git/drivers/usb/input/Makefile
===================================================================
--- linux-2.6.git.orig/drivers/usb/input/Makefile	2005-07-12 09:47:53.000000000 +0200
+++ linux-2.6.git/drivers/usb/input/Makefile	2005-07-12 09:49:17.000000000 +0200
@@ -39,3 +39,4 @@
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
 obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
+obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
Index: linux-2.6.git/drivers/usb/input/Kconfig
===================================================================
--- linux-2.6.git.orig/drivers/usb/input/Kconfig	2005-07-12 09:47:53.000000000 +0200
+++ linux-2.6.git/drivers/usb/input/Kconfig	2005-07-12 09:49:17.000000000 +0200
@@ -259,3 +259,22 @@
 	  To compile this driver as a module, choose M here: the module will be
 	  called ati_remote.
 
+config USB_APPLETOUCH
+	tristate "Apple USB Touchpad support"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want to use an Apple USB Touchpad.
+
+	  These are the touchpads that can be found on post-February 2005
+	  Apple Powerbooks (prior models have a Synaptics touchpad connected
+	  to the ADB bus).
+
+	  This driver provides a basic mouse driver but can be interfaced
+	  with the synaptics X11 driver to provide acceleration and
+	  scrolling in X11.
+
+	  For further information, see
+	  <file:Documentation/input/appletouch.txt>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called appletouch.
Index: linux-2.6.git/Documentation/input/appletouch.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.git/Documentation/input/appletouch.txt	2005-07-12 10:22:23.000000000 +0200
@@ -0,0 +1,84 @@
+Apple Touchpad Driver (appletouch)
+----------------------------------
+	Copyright (C) 2005 Stelian Pop <stelian@popies.net>
+
+appletouch is a Linux kernel driver for the USB touchpad found on post
+February 2005 Apple Alu Powerbooks.
+
+This driver is derived from Johannes Berg's appletrackpad driver[1], but it has
+been improved in some areas:
+	* appletouch is a full kernel driver, no userspace program is necessary
+	* appletouch can be interfaced with the synaptics X11 driver, in order
+	  to have touchpad acceleration, scrolling, etc.
+
+Credits go to Johannes Berg for reverse-engineering the touchpad protocol,
+Frank Arnold for further improvements, and Alex Harper for some additional
+information about the inner workings of the touchpad sensors.
+
+Usage:
+------
+
+In order to use the touchpad in the basic mode, compile the driver and load
+the module. A new input device will be detected and you will be able to read
+the mouse data from /dev/input/mice (using gpm, or X11).
+
+In X11, you can configure the touchpad to use the synaptics X11 driver, which
+will give additional functionalities, like acceleration, scrolling, 2 finger
+tap for middle button mouse emulation, 3 finger tap for right button mouse
+emulation, etc. In order to do this, make sure you're using a recent version of
+the synaptics driver (tested with 0.14.2, available from [2]), and configure a
+new input device in your X11 configuration file (take a look below for an
+example). For additional configuration, see the synaptics driver documentation.
+
+	Section "InputDevice"
+        	Identifier      "Synaptics Touchpad"
+	        Driver          "synaptics"
+		Option          "SendCoreEvents"        "true"
+		Option          "Device"                "/dev/input/mice"
+		Option          "Protocol"              "auto-dev"
+		Option		"LeftEdge"		"0"
+		Option		"RightEdge"		"850"
+		Option		"TopEdge"		"0"
+		Option		"BottomEdge"		"645"
+		Option		"MinSpeed"		"0.4"
+		Option		"MaxSpeed"		"1"
+		Option		"AccelFactor"		"0.02"
+		Option		"FingerLow"		"0"
+		Option		"FingerHigh"		"30"
+		Option		"MaxTapMove"		"20"
+		Option		"MaxTapTime"		"100"
+		Option		"HorizScrollDelta"	"0"
+		Option		"VertScrollDelta"	"30"
+		Option		"SHMConfig"		"on"
+	EndSection
+
+	Section "ServerLayout"
+		...
+		InputDevice	"Mouse"
+		InputDevice	"Synaptics Touchpad"
+	...
+	EndSection
+
+Fuzz problems:
+--------------
+
+The touchpad sensors are very sensitive to heat, and will generate a lot of
+noise when the temperature changes. This is especially true when you power-on
+the laptop for the first time.
+
+The appletouch driver tries to handle this noise and auto adapt itself, but it
+is not perfect. If finger movements are not recognized anymore, try reloading
+the driver.
+
+You can activate debugging using the 'debug' module parameter. A value of 0
+deactivates any debugging, 1 activates tracing of invalid samples, 2 activates
+full tracing (each sample is being traced):
+	modprobe appletouch debug=1
+		or
+	echo "1" > /sys/module/appletouch/parameters/debug
+
+Links:
+------
+
+[1]: http://johannes.sipsolutions.net/PowerBook/touchpad/
+[2]: http://web.telia.com/~u89404340/touchpad/index.html
Index: linux-2.6.git/drivers/usb/input/appletouch.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.git/drivers/usb/input/appletouch.c	2005-07-12 21:15:25.000000000 +0200
@@ -0,0 +1,467 @@
+/*
+ * Apple USB Touchpad (for post-February 2005 PowerBooks) driver
+ *
+ * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2005      Johannes Berg (johannes@sipsolutions.net)
+ * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
+ * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
+ * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
+ *
+ * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/input.h>
+#include <linux/usb_input.h>
+
+/* Apple has powerbooks which have the keyboard with different Product IDs */
+#define APPLE_VENDOR_ID		0x05AC
+#define ATP_12INCH_ID1		0x030A
+#define ATP_15INCH_ID1		0x020E
+#define ATP_15INCH_ID2		0x020F
+#define ATP_17INCH_ID1		0xFFFF /* XXX need a tester !!! */
+
+#define ATP_DEVICE(prod)					\
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |   		\
+		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
+		       USB_DEVICE_ID_MATCH_INT_PROTOCOL,	\
+	.idVendor = APPLE_VENDOR_ID,				\
+	.idProduct = (prod),					\
+	.bInterfaceClass = 0x03,				\
+	.bInterfaceProtocol = 0x02
+
+/* table of devices that work with this driver */
+static struct usb_device_id atp_table [] = {
+	{ ATP_DEVICE(ATP_12INCH_ID1) },
+	{ ATP_DEVICE(ATP_15INCH_ID1) },
+	{ ATP_DEVICE(ATP_15INCH_ID2) },
+#if 0
+	Disabled until someone gives us the real USB id and tests the driver
+	{ ATP_DEVICE(ATP_17INCH_ID1) },
+#endif
+	{ }					/* Terminating entry */
+};
+MODULE_DEVICE_TABLE (usb, atp_table);
+
+/* size of a USB urb transfer */
+#define ATP_DATASIZE	81
+
+/*
+ * number of sensors. Note that only 16 instead of 26 X (horizontal)
+ * sensors exist on 12" and 15" PowerBooks. All models have 16 Y
+ * (vertical) sensors.
+ */
+#define ATP_XSENSORS	26
+#define ATP_YSENSORS	16
+
+/* amount of fuzz this touchpad generates */
+#define ATP_FUZZ	16
+
+/* maximum pressure this driver will report */
+#define ATP_PRESSURE	300
+/*
+ * multiplication factor for the X and Y coordinates.
+ * We try to keep the touchpad aspect ratio while still doing only simple
+ * arithmetics.
+ * The factors below give coordinates like:
+ * 	0 <= x <  960 on 12" and 15" Powerbooks
+ * 	0 <= x < 1600 on 17" Powerbooks
+ * 	0 <= y <  646
+ */
+#define ATP_XFACT	64
+#define ATP_YFACT	43
+
+/*
+ * Threshold for the touchpad sensors. Any change less than ATP_THRESHOLD is
+ * ignored.
+ */
+#define ATP_THRESHOLD	 5
+
+/* Structure to hold all of our device specific stuff */
+struct atp {
+	struct usb_device *	udev;		/* usb device */
+	struct urb *		urb;		/* usb request block */
+	signed char *		data;		/* transferred data */
+	int			open;		/* non-zero if opened */
+	struct input_dev	input;		/* input dev */
+	int			valid;		/* are the sensors valid ? */
+	int			x_old;		/* last reported x/y, */
+	int			y_old;		/* used for smoothing */
+						/* current value of the sensors */
+	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
+						/* last value of the sensors */
+	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
+						/* accumulated sensors */
+	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+};
+
+#define dbg_dump(msg, tab) \
+	if (debug > 1) {						\
+		int i;							\
+		printk("appletouch: %s %lld", msg, (long long)jiffies); \
+		for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++)	\
+			printk("%02x ", tab[i]); 			\
+		printk("\n"); 						\
+	}
+
+#define dprintk(format, a...) 						\
+	do {								\
+		if (debug) printk(format, ##a);				\
+	} while (0)
+
+MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
+MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
+MODULE_LICENSE("GPL");
+
+static int debug = 1;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Activate debugging output");
+
+static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
+			     int *z, int *fingers)
+{
+	int i;
+	/* values to calculate mean */
+	int pcum = 0, psum = 0;
+
+	*fingers = 0;
+
+	for (i = 0; i < nb_sensors; i++) {
+		if (xy_sensors[i] < ATP_THRESHOLD)
+			continue;
+		if ((i - 1 < 0) || (xy_sensors[i - 1] < ATP_THRESHOLD))
+			(*fingers)++;
+		pcum += xy_sensors[i] * i;
+		psum += xy_sensors[i];
+	}
+
+	if (psum > 0) {
+		*z = psum;
+		return pcum * fact / psum;
+	}
+
+	return 0;
+}
+
+static inline void atp_report_fingers(struct input_dev *input, int fingers)
+{
+	input_report_key(input, BTN_TOOL_FINGER, fingers == 1);
+	input_report_key(input, BTN_TOOL_DOUBLETAP, fingers == 2);
+	input_report_key(input, BTN_TOOL_TRIPLETAP, fingers > 2);
+}
+
+static void atp_complete(struct urb* urb, struct pt_regs* regs)
+{
+	int x, y, x_z, y_z, x_f, y_f;
+	int retval, i;
+	struct atp *dev = urb->context;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* This urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d",
+		    __FUNCTION__, urb->status);
+		return;
+	default:
+		dbg("%s - nonzero urb status received: %d",
+		    __FUNCTION__, urb->status);
+		goto exit;
+	}
+
+	/* drop incomplete datasets */
+	if (dev->urb->actual_length != ATP_DATASIZE) {
+		dprintk("appletouch: incomplete data package.\n");
+		goto exit;
+	}
+
+	/* reorder the sensors values */
+	for (i = 0; i < 8; i++) {
+		/* X values */
+		dev->xy_cur[i     ] = dev->data[5 * i +  2];
+		dev->xy_cur[i +  8] = dev->data[5 * i +  4];
+		dev->xy_cur[i + 16] = dev->data[5 * i + 42];
+		if (i < 2)
+			dev->xy_cur[i + 24] = dev->data[5 * i + 44];
+
+		/* Y values */
+		dev->xy_cur[i + 26] = dev->data[5 * i +  1];
+		dev->xy_cur[i + 34] = dev->data[5 * i +  3];
+	}
+
+	dbg_dump("sample", dev->xy_cur);
+
+	if (!dev->valid) {
+		/* first sample */
+		dev->valid = 1;
+		dev->x_old = dev->y_old = -1;
+		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
+		goto exit;
+	}
+
+	for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++) {
+		/* accumulate the change */
+		signed char change = dev->xy_old[i] - dev->xy_cur[i];
+		dev->xy_acc[i] -= change;
+
+		/* prevent down drifting */
+		if (dev->xy_acc[i] < 0)
+			dev->xy_acc[i] = 0;
+	}
+
+	memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
+
+	dbg_dump("accumulator", dev->xy_acc);
+
+	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
+			      ATP_XFACT, &x_z, &x_f);
+	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
+			      ATP_YFACT, &y_z, &y_f);
+
+	if (x && y) {
+		if (dev->x_old != -1) {
+			x = (dev->x_old * 3 + x) >> 2;
+			y = (dev->y_old * 3 + y) >> 2;
+			dev->x_old = x;
+			dev->y_old = y;
+
+			if (debug > 1)
+				printk("appletouch: X: %3d Y: %3d "
+				       "Xz: %3d Yz: %3d\n",
+				       x, y, x_z, y_z);
+
+			input_report_key(&dev->input, BTN_TOUCH, 1);
+			input_report_abs(&dev->input, ABS_X, x);
+			input_report_abs(&dev->input, ABS_Y, y);
+			input_report_abs(&dev->input, ABS_PRESSURE,
+					 min(ATP_PRESSURE, x_z + y_z));
+			atp_report_fingers(&dev->input, max(x_f, y_f));
+		}
+		dev->x_old = x;
+		dev->y_old = y;
+	}
+	else if (!x && !y) {
+
+		dev->x_old = dev->y_old = -1;
+		input_report_key(&dev->input, BTN_TOUCH, 0);
+		input_report_abs(&dev->input, ABS_PRESSURE, 0);
+		atp_report_fingers(&dev->input, 0);
+
+		/* reset the accumulator on release */
+		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
+	}
+
+	input_report_key(&dev->input, BTN_LEFT, !!dev->data[80]);
+
+	input_sync(&dev->input);
+
+exit:
+	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
+	if (retval) {
+		err("%s - usb_submit_urb failed with result %d",
+		    __FUNCTION__, retval);
+	}
+}
+
+static int atp_open(struct input_dev *input)
+{
+	struct atp *dev = input->private;
+
+	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
+		return -EIO;
+
+	dev->open = 1;
+	return 0;
+}
+
+static void atp_close(struct input_dev *input)
+{
+	struct atp *dev = input->private;
+
+	usb_kill_urb(dev->urb);
+	dev->open = 0;
+}
+
+static int atp_probe(struct usb_interface *iface, const struct usb_device_id *id)
+{
+	struct atp *dev = NULL;
+	struct usb_host_interface *iface_desc;
+	struct usb_endpoint_descriptor *endpoint;
+	int int_in_endpointAddr = 0;
+	int i, retval = -ENOMEM;
+
+	/* allocate memory for our device state and initialize it */
+	dev = kmalloc(sizeof(struct atp), GFP_KERNEL);
+	if (dev == NULL) {
+		err("Out of memory");
+		goto err_kmalloc;
+	}
+	memset(dev, 0, sizeof(struct atp));
+
+	dev->udev = interface_to_usbdev(iface);
+
+	/* set up the endpoint information */
+	/* use only the first interrupt-in endpoint */
+	iface_desc = iface->cur_altsetting;
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		endpoint = &iface_desc->endpoint[i].desc;
+		if (!int_in_endpointAddr &&
+		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
+		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
+					== USB_ENDPOINT_XFER_INT)) {
+			/* we found an interrupt in endpoint */
+			int_in_endpointAddr = endpoint->bEndpointAddress;
+			break;
+		}
+	}
+	if (!int_in_endpointAddr) {
+		retval = -EIO;
+		err("Could not find int-in endpoint");
+		goto err_endpoint;
+	}
+
+	/* save our data pointer in this interface device */
+	usb_set_intfdata(iface, dev);
+
+	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!dev->urb) {
+		retval = -ENOMEM;
+		goto err_usballoc;
+	}
+	dev->data = usb_buffer_alloc(dev->udev, ATP_DATASIZE, GFP_KERNEL,
+				     &dev->urb->transfer_dma);
+	if (!dev->data) {
+		retval = -ENOMEM;
+		goto err_usbbufalloc;
+	}
+	usb_fill_int_urb(dev->urb, dev->udev,
+			 usb_rcvintpipe(dev->udev, int_in_endpointAddr),
+			 dev->data, ATP_DATASIZE, atp_complete, dev, 1);
+
+	init_input_dev(&dev->input);
+	dev->input.name = "appletouch";
+	dev->input.dev = &iface->dev;
+	dev->input.private = dev;
+	dev->input.open = atp_open;
+	dev->input.close = atp_close;
+
+	usb_to_input_id(dev->udev, &dev->input.id);
+
+	set_bit(EV_ABS, dev->input.evbit);
+	if (id->idProduct == ATP_17INCH_ID1)
+		input_set_abs_params(&dev->input, ABS_X, 0,
+				     (ATP_XSENSORS - 1) * ATP_XFACT - 1,
+				     ATP_FUZZ, 0);
+	else
+		/* 12" and 15" Powerbooks only have 16 x sensors */
+		input_set_abs_params(&dev->input, ABS_X, 0,
+				     (16 - 1) * ATP_XFACT - 1,
+				     ATP_FUZZ, 0);
+	input_set_abs_params(&dev->input, ABS_Y, 0,
+			     (ATP_YSENSORS - 1) * ATP_YFACT - 1,
+			     ATP_FUZZ, 0);
+	input_set_abs_params(&dev->input, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);
+
+	set_bit(EV_KEY, dev->input.evbit);
+	set_bit(BTN_TOUCH, dev->input.keybit);
+	set_bit(BTN_TOOL_FINGER, dev->input.keybit);
+	set_bit(BTN_TOOL_DOUBLETAP, dev->input.keybit);
+	set_bit(BTN_TOOL_TRIPLETAP, dev->input.keybit);
+	set_bit(BTN_LEFT, dev->input.keybit);
+
+	input_register_device(&dev->input);
+
+	printk(KERN_INFO "input: appletouch connected\n");
+
+	return 0;
+
+err_usbbufalloc:
+	usb_free_urb(dev->urb);
+err_usballoc:
+	usb_set_intfdata(iface, NULL);
+err_endpoint:
+	kfree(dev);
+err_kmalloc:
+	return retval;
+}
+
+static void atp_disconnect(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+
+	usb_set_intfdata(iface, NULL);
+	if (dev) {
+		usb_kill_urb(dev->urb);
+		input_unregister_device(&dev->input);
+		usb_free_urb(dev->urb);
+		usb_buffer_free(dev->udev, ATP_DATASIZE,
+				dev->data, dev->urb->transfer_dma);
+		kfree(dev);
+	}
+	printk(KERN_INFO "input: appletouch disconnected\n");
+}
+
+static int atp_suspend(struct usb_interface *iface, pm_message_t message)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+	usb_kill_urb(dev->urb);
+	dev->valid = 0;
+	return 0;
+}
+
+static int atp_resume(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+		return -EIO;
+
+	return 0;
+}
+
+static struct usb_driver atp_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "appletouch",
+	.probe		= atp_probe,
+	.disconnect	= atp_disconnect,
+	.suspend	= atp_suspend,
+	.resume		= atp_resume,
+	.id_table	= atp_table,
+};
+
+static int __init atp_init(void)
+{
+	return usb_register(&atp_driver);
+}
+
+static void __exit atp_exit(void)
+{
+	usb_deregister(&atp_driver);
+}
+
+module_init(atp_init);
+module_exit(atp_exit);

-- 
Stelian Pop <stelian@popies.net>

