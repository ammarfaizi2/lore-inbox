Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWIUShd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWIUShd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWIUShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:37:33 -0400
Received: from support.nepaug.com ([64.194.250.210]:58858 "EHLO
	support.nepaug.com") by vger.kernel.org with ESMTP id S1751361AbWIUShc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:37:32 -0400
Message-ID: <4512DBEF.7040706@gmail.com>
Date: Thu, 21 Sep 2006 14:37:35 -0400
From: Adam Buchbinder <adam.buchbinder@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6.18] xpad: dance pad support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominic Cerquetti <binary1230@yahoo.com>

Adds support for dance pads to the xpad driver. Dance pads require the
d-pad to be mapped to four buttons instead of two axes, so that
combinations of up/down and left/right can be hit simultaneously.
Known dance pads are detected, and there is a module parameter added
to default unknown xpad devices to map the d-pad to buttons if this is
desired. (dpad_to_buttons). The patch was significantly modified from
Dominic Cerquetti's original version by Adam Buchbinder.

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
This patch was originally from Dominic Cerquetti originally written
for kernel 2.6.11.4, with minor modifications (API changes for USB,
spelling fixes to the documentation added in the original patch) made
to apply to the current kernel. I have modified Dominic's original
patch per some suggestions from Dmitry Torokhov. (There was nothing
in the patch format description about multiple From: lines, so I
haven't added myself there.) I've redone the diff to apply to
2.6.18 now. (Also added myself to the authors list in xpad.c.)

If there's anything that could be improved about this patch, please
lease let me know. Thanks!

 Documentation/input/xpad.txt |  117 ++++++++++++++++++++++++++++-------
 drivers/usb/input/xpad.c     |  141 +++++++++++++++++++++++++++++--------------
 2 files changed, 188 insertions(+), 70 deletions(-)
diff -uprN -X linux-2.6.18.orig/Documentation/dontdiff linux-2.6.18.orig/Documentation/input/xpad.txt linux-2.6.18/Documentation/input/xpad.txt
--- linux-2.6.18.orig/Documentation/input/xpad.txt	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18/Documentation/input/xpad.txt	2006-09-21 12:46:28.000000000 -0400
@@ -3,20 +3,37 @@ xpad - Linux USB driver for X-Box gamepa
 This is the very first release of a driver for X-Box gamepads.
 Basically, this was hacked away in just a few hours, so don't expect
 miracles.
+
 In particular, there is currently NO support for the rumble pack.
 You won't find many ff-aware linux applications anyway.
 
 
-0. Status
----------
+0. Notes
+--------
+
+Driver updated for kernel 2.6.17.11. (Based on a patch for 2.6.11.4.)
 
-For now, this driver has only been tested on just one Linux-Box.
-This one is running a 2.4.18 kernel with usb-uhci on an amd athlon 600.
+The number of buttons/axes reported varies based on 3 things:
+- if you are using a known controller
+- if you are using a known dance pad
+- if using an unknown device (one not listed below), what you set in the
+  module configuration for "Map D-PAD to buttons rather than axes for unknown
+  pads" (module option dpad_to_buttons)
+
+If you set dpad_to_buttons to 0 and you are using an unknown device (one
+not listed below), the driver will map the directional pad to axes (X/Y),
+if you said N it will map the d-pad to buttons, which is needed for dance
+style games to function correctly.  The default is Y.
 
-The jstest-program from joystick-1.2.15 (jstest-version 2.1.0) reports
-8 axes and 10 buttons.
+dpad_to_buttons has no effect for known pads.
 
-Alls 8 axes work, though they all have the same range (-32768..32767)
+0.1 Normal Controllers
+----------------------
+With a normal controller, the directional pad is mapped to its own X/Y axes.
+The jstest-program from joystick-1.2.15 (jstest-version 2.1.0) will report 8
+axes and 10 buttons.
+
+All 8 axes work, though they all have the same range (-32768..32767)
 and the zero-setting is not correct for the triggers (I don't know if that
 is some limitation of jstest, since the input device setup should be fine. I
 didn't have a look at jstest itself yet).
@@ -30,16 +47,50 @@ in game functionality were OK. However, 
 play first person shooters with a pad. Your mileage may vary.
 
 
+0.2 Xbox Dance Pads
+-------------------
+When using a known dance pad, jstest will report 6 axes and 14 buttons.
+
+For dance style pads (like the redoctane pad) several changes
+have been made.  The old driver would map the d-pad to axes, resulting
+in the driver being unable to report when the user was pressing both
+left+right or up+down, making DDR style games unplayable.
+
+Known dance pads automatically map the d-pad to buttons and will work
+correctly out of the box.
+
+If your dance pad is recognized by the driver but is using axes instead
+of buttons, see section 0.3 - Unknown Controllers
+
+I've tested this with Stepmania, and it works quite well.
+
+
+0.3 Unkown Controllers
+----------------------
+If you have an unkown xbox controller, it should work just fine with
+the default settings.
+
+HOWEVER if you have an unknown dance pad not listed below, it will not
+work UNLESS you set "dpad_to_buttons" to 1 in the module configuration.
+
+PLEASE if you have an unkown controller, email Dom <binary1230@yahoo.com> with
+a dump from /proc/bus/usb and a description of the pad (manufacturer, country,
+whether it is a dance pad or normal controller) so that we can add your pad
+to the list of supported devices, ensuring that it will work out of the
+box in the future.
+
+
 1. USB adapter
 --------------
 
 Before you can actually use the driver, you need to get yourself an
-adapter cable to connect the X-Box controller to your Linux-Box.
+adapter cable to connect the X-Box controller to your Linux-Box. You
+can buy these online fairly cheap, or build your own.
 
-Such a cable is pretty easy to build. The Controller itself is a USB compound
-device (a hub with three ports for two expansion slots and the controller
-device) with the only difference in a nonstandard connector (5 pins vs. 4 on
-standard USB connector).
+Such a cable is pretty easy to build. The Controller itself is a USB
+compound device (a hub with three ports for two expansion slots and
+the controller device) with the only difference in a nonstandard connector
+(5 pins vs. 4 on standard USB connector).
 
 You just need to solder a USB connector onto the cable and keep the
 yellow wire unconnected. The other pins have the same order on both
@@ -51,36 +102,36 @@ original one. You can buy an extension c
 you can still use the controller with your X-Box, if you have one ;)
 
 
-2. driver installation
+2. Driver Installation
 ----------------------
 
 Once you have the adapter cable and the controller is connected, you need
 to load your USB subsystem and should cat /proc/bus/usb/devices.
 There should be an entry like the one at the end [4].
 
-Currently (as of version 0.0.4), the following three devices are included:
+Currently (as of version 0.0.6), the following devices are included:
  original Microsoft XBOX controller (US), vendor=0x045e, product=0x0202
+ smaller  Microsoft XBOX controller (US), vendor=0x045e, product=0x0289
  original Microsoft XBOX controller (Japan), vendor=0x045e, product=0x0285
  InterAct PowerPad Pro (Germany), vendor=0x05fd, product=0x107a
+ RedOctane Xbox Dance Pad (US), vendor=0x0c12, product=0x8809
 
-If you have another controller that is not listed above and is not recognized
-by the driver, please drop me a line with the appropriate info (that is, include
-the name, vendor and product ID, as well as the country where you bought it;
-sending the whole dump out of /proc/bus/usb/devices along would be even better).
-
-In theory, the driver should work with other controllers than mine
-(InterAct PowerPad pro, bought in Germany) just fine, but I cannot test this
-for I only have this one controller.
+The driver should work with xbox pads not listed above as well, however
+you will need to do something extra for dance pads to work.
+
+If you have a controller not listed above, see 0.3 - Unknown Controllers
 
 If you compiled and installed the driver, test the functionality:
 > modprobe xpad
 > modprobe joydev
 > jstest /dev/js0
 
-There should be a single line showing 18 inputs (8 axes, 10 buttons), and
-it's values should change if you move the sticks and push the buttons.
+If you're using a normal controller, there should be a single line showing
+18 inputs (8 axes, 10 buttons), and its values should change if you move
+the sticks and push the buttons.  If you're using a dance pad, it should
+show 20 inputs (6 axes, 14 buttons).
 
-It works? Voila, your done ;)
+It works? Voila, you're done ;)
 
 
 3. Thanks
@@ -111,6 +162,22 @@ I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) 
 E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl= 10ms
 E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl= 10ms
 
+5. /proc/bus/usb/devices - dump from Redoctane Xbox Dance Pad (US):
+
+T:  Bus=01 Lev=02 Prnt=09 Port=00 Cnt=01 Dev#= 10 Spd=12  MxCh= 0
+D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
+P:  Vendor=0c12 ProdID=8809 Rev= 0.01
+S:  Product=XBOX DDR
+C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
+I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=xpad
+E:  Ad=82(I) Atr=03(Int.) MxPS=  32 Ivl=4ms
+E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=4ms
+
 -- 
 Marko Friedemann <mfr@bmx-chemnitz.de>
 2002-07-16
+ - original doc
+
+Dominic Cerquetti <binary1230@yahoo.com>
+2005-03-19
+ - added stuff for dance pads, new d-pad->axes mappings
diff -uprN -X linux-2.6.18.orig/Documentation/dontdiff linux-2.6.18.orig/drivers/usb/input/xpad.c linux-2.6.18/drivers/usb/input/xpad.c
--- linux-2.6.18.orig/drivers/usb/input/xpad.c	2006-09-19 23:42:06.000000000 -0400
+++ linux-2.6.18/drivers/usb/input/xpad.c	2006-09-21 14:24:53.000000000 -0400
@@ -1,8 +1,9 @@
 /*
- * X-Box gamepad - v0.0.5
+ * X-Box gamepad - v0.0.6
  *
  * Copyright (c) 2002 Marko Friedemann <mfr@bmx-chemnitz.de>
- *
+ *               2005 Dominic Cerquetti <binary1230@yahoo.com>
+ *               2006 Adam Buchbinder <adam.buchbinder@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -30,9 +31,10 @@
  *  - Greg Kroah-Hartman - usb-skeleton driver
  *
  * TODO:
- *  - fine tune axes
+ *  - fine tune axes (especially trigger axes)
  *  - fix "analog" buttons (reported as digital now)
  *  - get rumble working
+ *  - need USB IDs for other dance pads
  *
  * History:
  *
@@ -57,25 +59,40 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/smp_lock.h>
 #include <linux/usb/input.h>
 
-#define DRIVER_VERSION "v0.0.5"
+#define DRIVER_VERSION "v0.0.6"
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
 
 #define XPAD_PKT_LEN 32
 
+/* xbox d-pads should map to buttons, as is required for DDR pads
+   but we map them to axes when possible to simplify things */
+#define MAP_DPAD_TO_BUTTONS    0
+#define MAP_DPAD_TO_AXES       1
+#define MAP_DPAD_UNKNOWN       -1
+
+static int dpad_to_buttons = 0;
+module_param(dpad_to_buttons, bool, S_IRUGO);
+MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than axes for unknown pads");
+
 static const struct xpad_device {
 	u16 idVendor;
 	u16 idProduct;
 	char *name;
+	u8 dpad_mapping;
 } xpad_device[] = {
-	{ 0x045e, 0x0202, "Microsoft X-Box pad (US)" },
-	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)" },
-	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)" },
-	{ 0x0000, 0x0000, "X-Box pad" }
+	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", MAP_DPAD_TO_AXES },
+	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AXES },
+	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AXES },
+	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", MAP_DPAD_TO_AXES },
+	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS },
+	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN }
 };
 
 static const signed short xpad_btn[] = {
@@ -84,11 +101,23 @@ static const signed short xpad_btn[] = {
 	-1						/* terminating entry */
 };
 
+/* only used if MAP_DPAD_TO_BUTTONS */
+static const signed short xpad_btn_pad[] = {
+	BTN_LEFT, BTN_RIGHT,		/* d-pad left, right */
+	BTN_0, BTN_1,			/* d-pad up, down (XXX names??) */
+	-1				/* terminating entry */
+};
+
 static const signed short xpad_abs[] = {
 	ABS_X, ABS_Y,		/* left stick */
 	ABS_RX, ABS_RY,		/* right stick */
 	ABS_Z, ABS_RZ,		/* triggers left/right */
-	ABS_HAT0X, ABS_HAT0Y,	/* digital pad */
+	-1			/* terminating entry */
+};
+
+/* only used if MAP_DPAD_TO_AXES */
+static const signed short xpad_abs_pad[] = {
+	ABS_HAT0X, ABS_HAT0Y,	/* d-pad axes */
 	-1			/* terminating entry */
 };
 
@@ -100,14 +129,16 @@ static struct usb_device_id xpad_table [
 MODULE_DEVICE_TABLE (usb, xpad_table);
 
 struct usb_xpad {
-	struct input_dev *dev;			/* input device interface */
-	struct usb_device *udev;		/* usb device */
+	struct input_dev *dev;		/* input device interface */
+	struct usb_device *udev;	/* usb device */
 
-	struct urb *irq_in;			/* urb for interrupt in report */
-	unsigned char *idata;			/* input data */
+	struct urb *irq_in;		/* urb for interrupt in report */
+	unsigned char *idata;		/* input data */
 	dma_addr_t idata_dma;
 
-	char phys[65];				/* physical device path */
+	char phys[65];			/* physical device path */
+	
+	int dpad_mapping;		/* map d-pad to buttons or to axes */
 };
 
 /*
@@ -139,14 +170,21 @@ static void xpad_process_packet(struct u
 	input_report_abs(dev, ABS_RZ, data[11]);
 
 	/* digital pad */
-	input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) - !!(data[2] & 0x04));
-	input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) - !!(data[2] & 0x01));
+	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
+		input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) - !!(data[2] & 0x04));
+		input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) - !!(data[2] & 0x01));
+	} else /* xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS */ {
+		input_report_key(dev, BTN_LEFT,  data[2] & 0x04);
+		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
+		input_report_key(dev, BTN_0,     data[2] & 0x01); // up
+		input_report_key(dev, BTN_1,     data[2] & 0x02); // down
+	}
 
 	/* start/back buttons and stick press left/right */
-	input_report_key(dev, BTN_START, (data[2] & 0x10) >> 4);
-	input_report_key(dev, BTN_BACK, (data[2] & 0x20) >> 5);
-	input_report_key(dev, BTN_THUMBL, (data[2] & 0x40) >> 6);
-	input_report_key(dev, BTN_THUMBR, data[2] >> 7);
+	input_report_key(dev, BTN_START,  data[2] & 0x10);
+	input_report_key(dev, BTN_BACK,   data[2] & 0x20);
+	input_report_key(dev, BTN_THUMBL, data[2] & 0x40);
+	input_report_key(dev, BTN_THUMBR, data[2] & 0x80);
 
 	/* "analog" buttons A, B, X, Y */
 	input_report_key(dev, BTN_A, data[4]);
@@ -208,6 +246,28 @@ static void xpad_close (struct input_dev
 	usb_kill_urb(xpad->irq_in);
 }
 
+static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
+{
+	set_bit(abs, input_dev->absbit);
+
+	switch (abs) {
+		case ABS_X:
+		case ABS_Y:
+		case ABS_RX:
+		case ABS_RY:	/* the two sticks */
+			input_set_abs_params(input_dev, abs, -32768, 32767, 16, 128);
+			break;
+		case ABS_Z:
+		case ABS_RZ:	/* the triggers */
+			input_set_abs_params(input_dev, abs, 0, 255, 0, 0);
+			break;
+		case ABS_HAT0X:
+		case ABS_HAT0Y:	/* the d-pad (only if MAP_DPAD_TO_AXES) */
+			input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
+			break;
+	}
+}
+
 static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev (intf);
@@ -237,6 +297,9 @@ static int xpad_probe(struct usb_interfa
 		goto fail2;
 
 	xpad->udev = udev;
+	xpad->dpad_mapping = xpad_device[i].dpad_mapping;
+	if (xpad->dpad_mapping == MAP_DPAD_UNKNOWN)
+		xpad->dpad_mapping = dpad_to_buttons;
 	xpad->dev = input_dev;
 	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
 	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
@@ -251,32 +314,19 @@ static int xpad_probe(struct usb_interfa
 
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
+	/* set up buttons */
 	for (i = 0; xpad_btn[i] >= 0; i++)
 		set_bit(xpad_btn[i], input_dev->keybit);
-
-	for (i = 0; xpad_abs[i] >= 0; i++) {
-
-		signed short t = xpad_abs[i];
-
-		set_bit(t, input_dev->absbit);
-
-		switch (t) {
-			case ABS_X:
-			case ABS_Y:
-			case ABS_RX:
-			case ABS_RY:	/* the two sticks */
-				input_set_abs_params(input_dev, t, -32768, 32767, 16, 128);
-				break;
-			case ABS_Z:
-			case ABS_RZ:	/* the triggers */
-				input_set_abs_params(input_dev, t, 0, 255, 0, 0);
-				break;
-			case ABS_HAT0X:
-			case ABS_HAT0Y:	/* the d-pad */
-				input_set_abs_params(input_dev, t, -1, 1, 0, 0);
-				break;
-		}
-	}
+	if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS)
+		for (i = 0; xpad_btn_pad[i] >= 0; i++)
+			set_bit(xpad_btn_pad[i], input_dev->keybit);
+
+	/* set up axes */
+	for (i = 0; xpad_abs[i] >= 0; i++)
+		xpad_set_up_abs(input_dev, xpad_abs[i]);
+	if (xpad->dpad_mapping == MAP_DPAD_TO_AXES)
+		for (i = 0; xpad_abs_pad[i] >= 0; i++)
+		    xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
 
 	ep_irq_in = &intf->cur_altsetting->endpoint[0].desc;
 	usb_fill_int_urb(xpad->irq_in, udev,
@@ -307,7 +357,8 @@ static void xpad_disconnect(struct usb_i
 		usb_kill_urb(xpad->irq_in);
 		input_unregister_device(xpad->dev);
 		usb_free_urb(xpad->irq_in);
-		usb_buffer_free(interface_to_usbdev(intf), XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
+		usb_buffer_free(interface_to_usbdev(intf), XPAD_PKT_LEN,
+				xpad->idata, xpad->idata_dma);
 		kfree(xpad);
 	}
 }
