Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVGKATi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVGKATi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVGKARd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:17:33 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:26106 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262075AbVGKAQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:16:15 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Stelian Pop <stelian@popies.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
References: <20050708101731.GM18608@sd291.sivit.org>
	<1120821481.5065.2.camel@localhost>
	<20050708121005.GN18608@sd291.sivit.org>
	<20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com>
	<20050710120425.GC3018@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jul 2005 02:15:49 +0200
In-Reply-To: <20050710120425.GC3018@ucw.cz>
Message-ID: <m3y88e9ozu.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sun, Jul 10, 2005 at 12:48:30AM +0200, Peter Osterlund wrote:
> > Vojtech Pavlik <vojtech@suse.cz> writes:
> > 
> > > Btw, what I don't completely understand is why you need linear
> > > regression, when you're not trying to detect motion or something like
> > > that. Basic floating average, or even simpler filtering like the input
> > > core uses for fuzz could work well enough I believe.
> > 
> > Indeed, this function doesn't make much sense:
> > 
> > +static inline int smooth_history(int x0, int x1, int x2, int x3)
> > +{
> > +	return x0 - ( x0 * 3 + x1 - x2 - x3 * 3 ) / 10;
> > +}
>  
> Using a function like
> 
> 	return (x_old * 3 + x) / 4;
> 
> eliminates the need for a FIFO, and has similar (if not better)
> properties to floating average, because its coefficients are
> [ .25 .18 .14 .10 ... ].

Agreed.

> Setting
> 
> 	absfuzz[ABS_X] = some number;

The patch already does that.

> activates the abovementioned filtering (with additional cutoff and fast
> motion compensation) directly in input.c, which should eliminate a lot
> of the code in the appletouch driver.

I took the liberty to modify the patch myself, making these changes:

* Removed the extra filtering.
* Converted the "open" counter to an "open" flag. (It is still needed
  by the atp_resume() function.)
* CodingStyle fixes.

I have only compile tested this as I don't have access to the
hardware, so I don't know how well this works in practice. It's
possible that the "dev->h_count > 3" test in the old patch filtered
out spikes in the input signal.

Also, it might be a good idea to compute an ABS_PRESSURE value instead
of hardcoding it to 100. I think the psum variable in
atp_calculate_abs() can be used, possibly after rescaling.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 Documentation/input/appletouch.txt |  120 +++++++++
 drivers/usb/input/Kconfig          |   19 +
 drivers/usb/input/Makefile         |    1 
 drivers/usb/input/appletouch.c     |  461 ++++++++++++++++++++++++++++++++++++
 4 files changed, 601 insertions(+), 0 deletions(-)

diff --git a/Documentation/input/appletouch.txt b/Documentation/input/appletouch.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/input/appletouch.txt
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
diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
--- a/drivers/usb/input/Kconfig
+++ b/drivers/usb/input/Kconfig
@@ -259,3 +259,22 @@ config USB_ATI_REMOTE
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
diff --git a/drivers/usb/input/Makefile b/drivers/usb/input/Makefile
--- a/drivers/usb/input/Makefile
+++ b/drivers/usb/input/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_USB_POWERMATE)	+= powermate
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
 obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
+obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
diff --git a/drivers/usb/input/appletouch.c b/drivers/usb/input/appletouch.c
new file mode 100644
--- /dev/null
+++ b/drivers/usb/input/appletouch.c
@@ -0,0 +1,461 @@
+/*
+ * Apple USB Touchpad (for post-February 2005 PowerBooks) driver
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
+/* Structure to hold all of our device specific stuff */
+struct atp {
+	struct usb_device *	udev;		/* usb device */
+	struct urb *		urb;		/* usb request block */
+	signed char *		data;		/* transferred data */
+	int			open;		/* non-zero if opened */
+	struct input_dev	input;		/* input dev */
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
+MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
+MODULE_LICENSE("GPL");
+
+static int debug = 1;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Activate debugging output");
+
+/* are the sensors in a valid state ? */
+static int valid = 0;
+
+static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact)
+{
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
+static void atp_complete(struct urb* urb, struct pt_regs* regs)
+{
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
+		goto exit;
+	}
+
+	for (i = 0; i < ATP_XSENSORS + ATP_YSENSORS; i++) {
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
+		if (debug > 1)
+			printk("appletouch: Xhw: %3d Yhw: %3d "
+			       "Xsm: %3d Ysm: %3d\n",
+			       x_hw, y_hw, x_hw, y_hw);
+
+		input_report_key(&dev->input, BTN_TOUCH, 1);
+		input_report_abs(&dev->input, ABS_X, x_hw);
+		input_report_abs(&dev->input, ABS_Y, y_hw);
+		input_report_abs(&dev->input, ABS_PRESSURE, 100);
+		input_report_key(&dev->input, BTN_TOOL_FINGER, 1);
+	} else if (!x_hw && !y_hw) {
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
+	usb_kill_urb(dev->urb);
+	valid = 0;
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
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
