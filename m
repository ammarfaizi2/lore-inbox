Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVGHKRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVGHKRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVGHKRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:17:45 -0400
Received: from sd291.sivit.org ([194.146.225.122]:19987 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262420AbVGHKRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:17:33 -0400
Date: Fri, 8 Jul 2005 12:17:32 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Johannes Berg <johannes@sipsolutions.net>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050708101731.GM18608@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Arnold <frank@scirocco-5v-turbo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a driver for the USB touchpad which can be found on
post-February 2005 Apple PowerBooks (PowerBook5,6).

This driver is derived from Johannes Berg's appletrackpad driver [1],
but it has been improved in some areas:
    * appletouch is a full kernel driver, no userspace program is necessary
    * appletouch can be interfaced with the synaptics X11 driver[2], in order
      to have touchpad acceleration, scrolling, etc. 

This driver has been tested by the readers of the 'debian-powerpc'
mailing list for a few weeks now and I believe it is now ready for
inclusion into the mainline kernel.

Credits go to Johannes Berg for reverse-engineering the touchpad
protocol, Frank Arnold for further improvements, and Alex Harper for
some additional information about the inner workings of the touchpad
sensors.

Please apply.

Stelian.

[1]: http://johannes.sipsolutions.net/PowerBook/touchpad/
[2]: http://web.telia.com/~u89404340/touchpad/index.html


Index: linux-2.6-trunk.git/drivers/usb/input/Makefile
===================================================================
--- linux-2.6-trunk.git.orig/drivers/usb/input/Makefile	2005-06-28 10:25:42.000000000 +0200
+++ linux-2.6-trunk.git/drivers/usb/input/Makefile	2005-07-08 11:10:29.000000000 +0200
@@ -39,3 +39,4 @@
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
 obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
+obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
Index: linux-2.6-trunk.git/drivers/usb/input/Kconfig
===================================================================
--- linux-2.6-trunk.git.orig/drivers/usb/input/Kconfig	2005-06-28 10:25:42.000000000 +0200
+++ linux-2.6-trunk.git/drivers/usb/input/Kconfig	2005-07-08 11:14:48.000000000 +0200
@@ -259,3 +259,21 @@
 	  To compile this driver as a module, choose M here: the module will be
 	  called ati_remote.
 
+config USB_APPLETOUCH
+	tristate "Apple USB Touchpad support"
+	depends on USB && INPUT
+	---help---
+	  Say Y here if you want to use an Apple USB Touchpad.
+
+	  These are the touchpads that can be found on post-February 2005
+	  Apple Powerbooks (PowerBook5,6).
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
Index: linux-2.6-trunk.git/Documentation/input/appletouch.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-trunk.git/Documentation/input/appletouch.txt	2005-07-08 11:15:03.000000000 +0200
@@ -0,0 +1,120 @@
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
+will give additional functionalities, like acceleration, scrolling etc. In
+order to do this, make sure you're using a recent version of the synaptics
+driver (tested with 0.14.2, available from [2]), and configure a new input
+device in your X11 configuration file (take a look below for an example). For
+additional configuration, see the synaptics driver documentation.
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
+		Option		"FingerLow"		"55"
+		Option		"FingerHigh"		"60"
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
+Synaptics re-detection problems:
+--------------------------------
+
+The synaptics X11 driver tries to re-open the touchpad input device file
+(/dev/input/eventX) each time you change from text mode back to X11. If the
+input device file does not exist at this precise moment, the synaptics driver
+will give up searching for a touchpad, permanently. You will need to restart
+X11 if you want to reissue a scan.
+
+In normal circumstances, this is not a problem since the touchpad driver is
+loaded before X11 starts, so all will go well.
+
+But if you rmmod/insmod the appletouch driver (because you're hacking it), or
+if you need to unload the usb modules before doing a suspend to disk (like I
+need to), you will get into problems.
+
+The solution I found is to modify udev configuration files in order to create a
+stable device file for the touchpad (/dev/input/appletouch), and point the
+synaptics driver to this fixed device file.
+
+You need to add this rule to /etc/udev/udev.rules:
+
+	# Add a symlink for the touchpad
+	KERNEL="event[0-9]*",	BUS="usb", SYSFS{interface}="Touchpad", SYMLINK="input/appletouch"
+
+And of course instruct X11 to look at /dev/input/appletouch instead of
+/dev/input/mice:
+
+	Section "InputDevice"
+	        Identifier      "Synaptics Touchpad"
+		Driver          "synaptics"
+		Option          "SendCoreEvents"        "true"
+		Option          "Device"                "/dev/input/appletouch"
+		Option          "Protocol"              "event"
+		...
+	EndSection
+
+Links:
+------
+
+[1]: http://johannes.sipsolutions.net/PowerBook/touchpad/
+[2]: http://web.telia.com/~u89404340/touchpad/index.html
Index: linux-2.6-trunk.git/drivers/usb/input/appletouch.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-trunk.git/drivers/usb/input/appletouch.c	2005-07-08 11:35:06.000000000 +0200
@@ -0,0 +1,515 @@
+/*
+ * Apple USB Touchpad (PowerBook5,6) driver
+ *
+ * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2005      Johannes Berg (johannes@sipsolutions.net)
+ * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
+ * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
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
+
+/* Apple has powerbooks which have the keyboard with different Product IDs */
+#define APPLE_VENDOR_ID		0x05AC
+#define ATP_12INCH_ID1		0x030A
+#define ATP_15INCH_ID1		0x020E
+#define ATP_15INCH_ID2		0x020F
+#define ATP_17INCH_ID1		0xFFFF /* XXX need a tester !!! */
+
+#define ATP_DRIVER_VERSION	0x0006 /* 00.06 */
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
+ * number of sensors. Note that only 16 of the 26 x sensors are used on
+ * 12" and 15" Powerbooks.
+ */
+#define ATP_XSENSORS	26
+#define ATP_YSENSORS	16
+
+/* amount of fuzz this touchpad generates */
+#define ATP_FUZZ	16
+
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
+#define ATP_THRESHOLD	 4
+
+/*
+ * Size of the history for smoothing.
+ */
+#define ATP_HSIZE	 5
+
+struct point {
+	unsigned int		x;
+	unsigned int		y;
+};
+
+/* Structure to hold all of our device specific stuff */
+struct atp {
+	struct usb_device *	udev;		/* usb device */
+	struct urb *		urb;		/* usb request block */
+	signed char *		data;		/* transferred data */
+	int			open;		/* open count */
+	struct input_dev	input;		/* input dev */
+	int			h_count;	/* history for smoothing */
+	struct point		h[ATP_HSIZE];
+	unsigned int		h_index;
+};
+
+#define dbg_dump(msg, tab) \
+	if (debug > 1) {						\
+		int i;							\
+		printk("appletouch: %s ", msg);				\
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
+MODULE_DESCRIPTION("Touchpad driver for Apple Powerbooks Alu (PowerBook5,6)");
+MODULE_LICENSE("GPL");
+
+static int debug = 1;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Activate debugging output");
+
+/* are the sensors in a valid state ? */
+static int valid = 0;
+
+/*
+ * Smooth the data sequence by estimating the slope for the data sequence
+ * [x3, x2, x1, x0] by using linear regression to fit a line to the data and
+ * use the slope of the line. Taken from the synaptics X driver.
+ */
+
+#define HIST(a) (dev->h[((dev->h_index - (a) + ATP_HSIZE) % ATP_HSIZE)])
+
+static inline void store_history(struct atp *atp, int x, int y)
+{
+	atp->h_index = (atp->h_index + 1) % ATP_HSIZE;
+	atp->h[atp->h_index].x = x;
+	atp->h[atp->h_index].y = y;
+	atp->h_count++;
+}
+
+static inline int smooth_history(int x0, int x1, int x2, int x3)
+{
+	return x0 - ( x0 * 3 + x1 - x2 - x3 * 3 ) / 10;
+}
+
+static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact) {
+	int i;
+	/* values to calculate mean */
+	int pcum = 0, psum = 0;
+	/* indexes of the first and last triggered sensors */
+	int istart = -1, iend = -1;
+
+	for (i = 0; i < nb_sensors; i++) {
+		if (xy_sensors[i] > ATP_THRESHOLD && istart == -1)
+			istart = i;
+		if (xy_sensors[i] < ATP_THRESHOLD && istart != -1 && iend == -1)
+			iend = i;
+		if (xy_sensors[i] > ATP_THRESHOLD && iend != -1) {
+			/*
+			 * in the future, we could add here code to search for
+			 * a second finger...
+			 * for now, scrolling using the synaptics X driver is
+			 * much more simpler to achieve.
+			 */
+			dprintk("appletouch: invalid sensor at %d"
+				" (2 fingers ?)\n", i);
+			return -1;
+		}
+	}
+
+	if (istart == -1)
+		return 0;
+
+	if (iend == -1)
+		iend = nb_sensors;
+
+	for (i = istart; i < iend; i++) {
+		pcum += xy_sensors[i] * i;
+		psum += xy_sensors[i];
+	}
+
+	return pcum * fact / psum;
+}
+
+static void atp_complete(struct urb* urb, struct pt_regs* regs) {
+	static int xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	static signed char xy_cur[ATP_XSENSORS + ATP_YSENSORS];
+	static signed char xy_old[ATP_XSENSORS + ATP_YSENSORS];
+	int retval, i;
+	int x_hw, y_hw;
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
+	        return;
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
+		xy_cur[i     ] = dev->data[5 * i +  2];
+		xy_cur[i +  8] = dev->data[5 * i +  4];
+		xy_cur[i + 16] = dev->data[5 * i + 42];
+		if (i < 2)
+			xy_cur[i + 24] = dev->data[5 * i + 44];
+
+		/* Y values */
+		xy_cur[i + 26] = dev->data[5 * i +  1];
+		xy_cur[i + 34] = dev->data[5 * i +  3];
+	}
+
+	dbg_dump("sample", xy_cur);
+
+	if (!valid) {
+		/* first sample */
+		valid = 1;
+		memcpy(xy_old, xy_cur, sizeof(xy_old));
+		dev->h_count = 0;
+		goto exit;
+	}
+
+	for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++) {
+
+		/* accumulate the change */
+		signed char change = xy_old[i] - xy_cur[i];
+		xy_acc[i] -= change;
+
+		/* prevent down drifting */
+		if (xy_acc[i] < 0)
+			xy_acc[i] = 0;
+	}
+
+	memcpy(xy_old, xy_cur, sizeof(xy_old));
+
+	dbg_dump("accumulator", xy_acc);
+
+	x_hw = atp_calculate_abs(xy_acc,
+				 ATP_XSENSORS, ATP_XFACT);
+	y_hw = atp_calculate_abs(xy_acc + ATP_XSENSORS,
+				 ATP_YSENSORS, ATP_YFACT);
+
+	if (x_hw < 0 || y_hw < 0) {
+		memset(xy_acc, 0, sizeof(xy_acc));
+		goto exit;
+	}
+
+	if (x_hw && y_hw) {
+
+		/* need at least 3 points to smooth */
+		if (dev->h_count > 3) {
+			unsigned int x_sm, y_sm;
+			x_sm = smooth_history(x_hw, HIST(0).x,
+					      HIST(1).x, HIST(2).x);
+			y_sm = smooth_history(y_hw, HIST(0).y,
+					      HIST(1).y, HIST(2).y);
+
+			if (debug > 1)
+				printk("appletouch: Xhw: %3d Yhw: %3d "
+				       "Xsm: %3d Ysm: %3d\n",
+				       x_hw, y_hw, x_sm, y_sm);
+
+			input_report_key(&dev->input, BTN_TOUCH, 1);
+			input_report_abs(&dev->input, ABS_X, x_sm);
+			input_report_abs(&dev->input, ABS_Y, y_sm);
+			input_report_abs(&dev->input, ABS_PRESSURE, 100);
+			input_report_key(&dev->input, BTN_TOOL_FINGER, 1);
+		}
+		store_history(dev, x_hw, y_hw);
+	}
+	else if (!x_hw && !y_hw) {
+
+		dev->h_count = 0;
+		input_report_key(&dev->input, BTN_TOUCH, 0);
+		input_report_abs(&dev->input, ABS_PRESSURE, 0);
+		input_report_key(&dev->input, BTN_TOOL_FINGER, 0);
+
+		/* reset the accumulator on release */
+		memset(xy_acc, 0, sizeof(xy_acc));
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
+        if (dev->open++)
+                return 0;
+
+	if (usb_submit_urb(dev->urb, GFP_ATOMIC)) {
+		dev->open--;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void atp_close(struct input_dev *input)
+{
+	struct atp *dev = input->private;
+
+	if (!--dev->open)
+		usb_kill_urb(dev->urb);
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
+                    (endpoint->bEndpointAddress & USB_DIR_IN) &&
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
+	dev->input.id.bustype = BUS_USB;
+	dev->input.id.vendor = id->idVendor;
+	dev->input.id.product = id->idProduct;
+	dev->input.id.version = ATP_DRIVER_VERSION;
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
+	input_set_abs_params(&dev->input, ABS_PRESSURE, 0, 100, 0, 0);
+
+	set_bit(EV_KEY, dev->input.evbit);
+	set_bit(BTN_TOUCH, dev->input.keybit);
+	set_bit(BTN_TOOL_FINGER, dev->input.keybit);
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
+	if (dev->open)
+		usb_kill_urb(dev->urb);
+	valid = 0;
+	return 0;
+}
+
+static int atp_resume(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC)) {
+		dev->open--;
+		return -EIO;
+	}
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
+module_init (atp_init);
+module_exit (atp_exit);
-- 
Stelian Pop <stelian@popies.net>    
