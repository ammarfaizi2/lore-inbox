Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWIDFjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWIDFjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWIDFjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:39:44 -0400
Received: from support.nepaug.com ([64.194.250.210]:63380 "EHLO
	support.nepaug.com") by vger.kernel.org with ESMTP id S932310AbWIDFjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:39:43 -0400
Message-ID: <44FBBC24.7070808@gmail.com>
Date: Mon, 04 Sep 2006 01:39:48 -0400
From: Adam Buchbinder <adam.buchbinder@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6.17.11] xpad: dance pad support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominic Cerquetti <binary1230@yahoo.com>

Adds support for dance pads to the xpad driver. Dance pads require the
d-pad to be mapped to four buttons instead of two axes, so that
combinations of up/down and left/right can be hit simultaneously.
Known dance pads are detected, and there is a kernel configuration
option added to default unknown xpad devices to map the d-pad to
buttons if this is desired. (CONFIG_USB_XPAD_DPAD_MAPPING). Minor
modifications were made to port the changes in the original patch to a
newer kernel version.

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
This patch was originally from Dominic Cerquetti originally written
for kernel 2.6.11.4, with minor modifications (API changes for USB,
spelling fixes to the documentation added in the original patch) made
to apply to the current kernel. This is my first time submitting a
patch; I've attempted to follow the format laid out in
SubmittingPatches, but if there's something amiss here (I should have
listed myself as an author, or I should have moved the documentation
into another patch), please let me know. Thanks! (This is a third
attempt at submitting, and I'm really sorry about Thunderbird mucking
up the line wrapping. I tested this with an email to myself, and it
worked then.)

 Documentation/input/xpad.txt |  122 ++++++++++++++++++++++++++-------
 drivers/usb/input/Kconfig    |   23 +++++-
 drivers/usb/input/xpad.c     |  101 +++++++++++++++++++++------
 3 files changed, 197 insertions(+), 49 deletions(-)

diff -uprN -X linux-2.6.17.11/Documentation/dontdiff linux-2.6.17.11.orig/Documentation/input/xpad.txt linux-2.6.17.11/Documentation/input/xpad.txt
--- linux-2.6.17.11.orig/Documentation/input/xpad.txt        2006-08-31 11:00:48.000000000 -0400
+++ linux-2.6.17.11/Documentation/input/xpad.txt        2006-08-31 16:36:41.000000000 -0400
@@ -1,22 +1,43 @@
 xpad - Linux USB driver for X-Box gamepads
+document ver 1.1
 
+Intro
+-----
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
+  kernel configuration for "Map d-pad to axes for unkown xbox pads"
+  (USB_XPAD_DPAD_MAPPING)
+
+If you said Y to "Map d-pad to axes for unkown xbox pads" and you
+are using an unknown device (one not listed below), the driver will
+map the directional pad to axes (X/Y), if you said N it will map the
+d-pad to buttons, which is needed for dance style games to function
+correctly.  The default is Y.
 
-The jstest-program from joystick-1.2.15 (jstest-version 2.1.0) reports
-8 axes and 10 buttons.
+"Map d-pad to axes for unkown xbox pads" has no effect for known pads.
+
+0.1 Normal Controllers
+----------------------
+With a normal controller, the directional pad is mapped to its own X/Y axes.
+The jstest-program from joystick-1.2.15 (jstest-version 2.1.0) will report 8
+axes and 10 buttons.
 
-Alls 8 axes work, though they all have the same range (-32768..32767)
+All 8 axes work, though they all have the same range (-32768..32767)
 and the zero-setting is not correct for the triggers (I don't know if that
 is some limitation of jstest, since the input device setup should be fine. I
 didn't have a look at jstest itself yet).
@@ -30,16 +51,51 @@ in game functionality were OK. However, 
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
+work UNLESS you set "Map d-pad to axes for unkown xbox pads" to N in the
+kernel configuration.
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
@@ -51,36 +107,36 @@ original one. You can buy an extension c
 you can still use the controller with your X-Box, if you have one ;)
 
 
-2. driver installation
+2. Driver Installation
 ----------------------
 
 Once you have the adapter cable and the controller is connected, you need
 to load your USB subsystem and should cat /proc/bus/usb/devices.
 There should be an entry like the one at the end [4].
 
-Currently (as of version 0.0.4), the following three devices are included:
+Currently (as of version 0.0.6), the following three devices are included:
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
@@ -111,6 +167,22 @@ I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) 
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
diff -uprN -X linux-2.6.17.11/Documentation/dontdiff linux-2.6.17.11.orig/drivers/usb/input/Kconfig linux-2.6.17.11/drivers/usb/input/Kconfig
--- linux-2.6.17.11.orig/drivers/usb/input/Kconfig        2006-08-31 11:01:56.000000000 -0400
+++ linux-2.6.17.11/drivers/usb/input/Kconfig        2006-08-31 14:59:23.000000000 -0400
@@ -263,7 +263,28 @@ config USB_XPAD
 
           To compile this driver as a module, choose M here: the
           module will be called xpad.
-          
+
+config USB_XPAD_DPAD_MAPPING
+        bool "Map d-pad to axes for unkown xbox pads"
+        default y
+        depends on USB_XPAD
+        ---help---
+          Say Y here if you want the XBOX directional pad (dpad) to map
+          to X/Y axes instead of buttons.  This is useful in order to
+          simplify controls for regular controllers.  You usually want
+          to say Y here.
+ 
+          However, if you own a dance pad, this behavior makes it
+          impossible to detect when you are pressing both up+down or
+          left+right, making dance games unplayable.
+ 
+          Dance pads the driver knows about (currently just the
+          Redoctane pads) work correctly regardless of this option.
+ 
+          If you own a dance pad and jumps don't work by default, say N,
+          and see <file:Documentation/input/xpad.txt> to help fix it,
+          or else just say Y.
+
 config USB_ATI_REMOTE
         tristate "ATI / X10 USB RF remote control"
         depends on USB && INPUT
diff -uprN -X linux-2.6.17.11/Documentation/dontdiff linux-2.6.17.11.orig/drivers/usb/input/xpad.c linux-2.6.17.11/drivers/usb/input/xpad.c
--- linux-2.6.17.11.orig/drivers/usb/input/xpad.c        2006-08-31 11:01:56.000000000 -0400
+++ linux-2.6.17.11/drivers/usb/input/xpad.c        2006-08-31 14:57:43.000000000 -0400
@@ -1,8 +1,8 @@
 /*
- * X-Box gamepad - v0.0.5
+ * X-Box gamepad - v0.0.6
  *
  * Copyright (c) 2002 Marko Friedemann <mfr@bmx-chemnitz.de>
- *
+ *               2005 Dominic Cerquetti <binary1230@yahoo.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -30,9 +30,10 @@
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
@@ -52,6 +53,16 @@
  *  - fixed d-pad to axes mapping
  *
  * 2002-07-17 - 0.0.5 : simplified d-pad handling
+ *
+ * 2005-03-15 - 0.0.6 : Dom's patch: d-pad handling for dance style pads
+ *  - old handler mapped d-pad to axes, but some dance style games
+ *    need to know when you are pressing both left+right or up+down
+ *  - mapping of d-pad to buttons or axes now done
+ *    on the fly via product/vendor ID's
+ *  - for (known) dance pads, the mapping is d-pads to buttons, for all
+ *    others, mapping defaults to axes to make things easier.
+ *  - added 'Redoctane Xbox Dance Pad' USB ID's (props to helpful techs)
+ *  - added 'Microsoft smaller Xbox Pad' USB ID's
  */
 
 #include <linux/config.h>
@@ -64,26 +75,44 @@
 #include <linux/usb.h>
 #include <linux/usb_input.h>
 
-#define DRIVER_VERSION "v0.0.5"
+#define DRIVER_VERSION "v0.0.6"
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
 
+
+
 #define XPAD_PKT_LEN 32
 
+/* xbox d-pads should map to buttons, as is required for DDR pads
+   but we map them to axes when possible to simplify things */
+#define MAP_DPAD_TO_BUTTONS    0
+#define MAP_DPAD_TO_AXES       1
+#define MAP_DPAD_DEFAULT       CONFIG_USB_XPAD_DPAD_MAPPING    /* from config */
+
+#define FAKE_ENTRY             -2
+
 static const struct xpad_device {
         u16 idVendor;
         u16 idProduct;
         char *name;
+        int dpad_mapping;
 } xpad_device[] = {
-        { 0x045e, 0x0202, "Microsoft X-Box pad (US)" },
-        { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)" },
-        { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)" },
-        { 0x0000, 0x0000, "X-Box pad" }
+        { 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", MAP_DPAD_TO_AXES },
+        { 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AXES },
+        { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AXES },
+        { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", MAP_DPAD_TO_AXES },
+        { 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS },
+        { 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_DEFAULT }
 };
 
 static const signed short xpad_btn[] = {
         BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z,        /* "analog" buttons */
         BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR,        /* start/back/sticks */
+        FAKE_ENTRY,                                     /* (break entry) */
+                                                        /* only used if MAP_DPAD_TO_BUTTONS */
+
+        BTN_LEFT, BTN_RIGHT,                            /* d-pad left, right */
+        BTN_0, BTN_1,                                   /* d-pad up, down (XXX names??) */
         -1                                                /* terminating entry */
 };
 
@@ -92,7 +121,11 @@ static const signed short xpad_abs[] = {
         ABS_RX, ABS_RY,                /* right stick */
         ABS_Z, ABS_RZ,                /* triggers left/right */
         ABS_HAT0X, ABS_HAT0Y,        /* digital pad */
-        -1                        /* terminating entry */
+        FAKE_ENTRY,             /* (break entry) */
+                                /* only used if MAP_DPAD_TO_AXES */
+
+        ABS_HAT0X, ABS_HAT0Y,   /* d-pad axes */
+        -1                      /* terminating entry */
 };
 
 static struct usb_device_id xpad_table [] = {
@@ -111,6 +144,8 @@ struct usb_xpad {
         dma_addr_t idata_dma;
 
         char phys[65];                                /* physical device path */
+        
+        int dpad_mapping;                       /* whether to map d-pad to buttons or axes */
 };
 
 /*
@@ -142,8 +177,15 @@ static void xpad_process_packet(struct u
         input_report_abs(dev, ABS_RZ, data[11]);
 
         /* digital pad */
-        input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) - !!(data[2] & 0x04));
-        input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) - !!(data[2] & 0x01));
+        if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
+                input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) - !!(data[2] & 0x04));
+                input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) - !!(data[2] & 0x01));
+        } else if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS) {
+                input_report_key(dev, BTN_LEFT, (data[2] & 0x04) >> 2); // left
+                input_report_key(dev, BTN_RIGHT,(data[2] & 0x08) >> 3); // right
+                input_report_key(dev, BTN_0,    (data[2] & 0x01)); // up
+                input_report_key(dev, BTN_1,    (data[2] & 0x02) >> 1); // down
+        }
 
         /* start/back buttons and stick press left/right */
         input_report_key(dev, BTN_START, (data[2] & 0x10) >> 4);
@@ -240,6 +282,7 @@ static int xpad_probe(struct usb_interfa
                 goto fail2;
 
         xpad->udev = udev;
+        xpad->dpad_mapping = xpad_device[i].dpad_mapping;
         xpad->dev = input_dev;
         usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
         strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
@@ -254,29 +297,39 @@ static int xpad_probe(struct usb_interfa
 
         input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
-        for (i = 0; xpad_btn[i] >= 0; i++)
-                set_bit(xpad_btn[i], input_dev->keybit);
-
-        for (i = 0; xpad_abs[i] >= 0; i++) {
-
-                signed short t = xpad_abs[i];
+        /* set up buttons */
+        for (i = 0; (xpad_btn[i] >= 0) ||
+                (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS && xpad_btn[i] == FAKE_ENTRY);
+                i++) {
+                if (xpad_btn[i] == FAKE_ENTRY)
+                        i++;    /* skip fake entry */
+ 
+                set_bit(xpad_btn[i], input_dev->keybit);
+        }
+
+        /* set up axes */
+        for (i = 0; (xpad_abs[i] >= 0) ||
+                (xpad->dpad_mapping == MAP_DPAD_TO_AXES && xpad_abs[i] == FAKE_ENTRY);
+                i++) {
+                if (xpad_btn[i] == FAKE_ENTRY)
+                        i++;    /* skip fake entry */
 
-                set_bit(t, input_dev->absbit);
+                set_bit(xpad_abs[i], input_dev->absbit);
 
-                switch (t) {
+                switch (xpad_abs[i]) {
                         case ABS_X:
                         case ABS_Y:
                         case ABS_RX:
                         case ABS_RY:        /* the two sticks */
-                                input_set_abs_params(input_dev, t, -32768, 32767, 16, 128);
+                                input_set_abs_params(input_dev, xpad_abs[i], -32768, 32767, 16, 128);
                                 break;
                         case ABS_Z:
                         case ABS_RZ:        /* the triggers */
-                                input_set_abs_params(input_dev, t, 0, 255, 0, 0);
+                                input_set_abs_params(input_dev, xpad_abs[i], 0, 255, 0, 0);
                                 break;
                         case ABS_HAT0X:
-                        case ABS_HAT0Y:        /* the d-pad */
-                                input_set_abs_params(input_dev, t, -1, 1, 0, 0);
+                        case ABS_HAT0Y:        /* the d-pad (only if MAP_DPAD_TO_AXES) */
+                                input_set_abs_params(input_dev, xpad_abs[i], -1, 1, 0, 0);
                                 break;
                 }
         }
@@ -290,6 +343,8 @@ static int xpad_probe(struct usb_interfa
         xpad->irq_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
         input_register_device(xpad->dev);
+        printk(KERN_INFO "input: %s on %s (dpad-to-axes=%u)\n",
+                        xpad->dev->name, xpad->phys, xpad->dpad_mapping);
 
         usb_set_intfdata(intf, xpad);
         return 0;

-- 
VGER BF report: H 0
