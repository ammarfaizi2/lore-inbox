Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423682AbWKPKZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423682AbWKPKZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423688AbWKPKZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:25:33 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:19811 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S1423682AbWKPKZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:25:32 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: daniel.ritz@gmx.ch
Subject: [PATCH] usb: generic calibration support
Date: Thu, 16 Nov 2006 11:25:38 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611161125.38901.hs4233@mail.mn-solutions.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Schurig <hs4233@mail.mn-solutions.de>

Generic calibration support for usbtouchscreen.

Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>

---

With build-in calibration support, the "swap_xy" kernel parameter
vanishes and usbtouchscreen instead gains a new kernel-parameter
which holds 7 integers.

This is used to calibrate the resulting output of the driver. Let
x_o and y_o be the original x,y coordinate, as reported from the
device. Then x_r,y_r (the x,y coordinate reported to the input event
subsystem) are:

    x_r = ( a*x_o + b*y_o + c ) / s
    y_r = ( c*x_o + d*y_o + e ) / s

The default values for (a,b,c,d,e,s) are (1,0,0,0,1,0,1). To
simulate swap_xy, one would set them to (0,1,0,1,0,0,1). Once can
also use swap_x or swap_y alone, or define other, linear
transpositions. The algorithm used is the same as in Qt/Embedded
3.x for the QWSCalibratedMouseHandler.

This interface allows re-calibration at runtime, without
restarting the X-Server or any other event consumer.


Please review this patch and schedule it for inclusion once 
2.6.19 comes out.


--- linux.orig/drivers/usb/input/Kconfig
+++ linux/drivers/usb/input/Kconfig
@@ -219,6 +219,32 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called usbtouchscreen.
 
+config USB_TOUCHSCREEN_CALIBRATE
+	default n
+	bool "Calibration support"
+	depends on USB_TOUCHSCREEN
+	---help---
+	  With build-in calibration support, the "swap_xy" kernel parameter
+	  vanishes and usbtouchscreen instead gains a new kernel-parameter
+	  which hold 7 integers. You can also access this with cat/echo
+	  via /sys/module/usbtouchscreen/parameters/calibration
+
+	  This is used to calibrate the resulting output of the driver. Let
+	  x_o and y_o be the original x,y coordinate, as reported from the
+	  device. Then x_r,y_r (the x,y coordinate reported to the input event
+	  subsystem) are:
+
+	      x_r = ( a*x_o + b*y_o + c ) / s
+	      y_r = ( c*x_o + d*y_o + e ) / s
+
+	  The default values for (a,b,c,d,e,s) are (1,0,0,0,1,0,1). To
+	  simulate swap_xy, one would set them to (0,1,0,1,0,0,1).
+
+	  This interface allows re-calibration at runtime, without
+	  restarting the X-Server or any other event consumer.
+
+	  If unsure, say N.
+
 config USB_TOUCHSCREEN_DMC_TSC10
 	default y
 	bool "DMC TSC-10 device support" if EMBEDDED
--- linux.orig/drivers/usb/input/usbtouchscreen.c
+++ linux/drivers/usb/input/usbtouchscreen.c
@@ -49,9 +49,16 @@
 #define DRIVER_AUTHOR		"Daniel Ritz <daniel.ritz@gmx.ch>"
 #define DRIVER_DESC		"USB Touchscreen Driver"
 
+#ifdef CONFIG_USB_TOUCHSCREEN_CALIBRATE
+static int cal[7] = {1, 0, 0,   0, 1, 0,  1 };
+module_param_array_named(calibration, cal, int, NULL, 0644);
+MODULE_PARM_DESC(calibrate, "calibration data");
+
+#else
 static int swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+#endif
 
 /* device specifc data/functions */
 struct usbtouch_usb;
@@ -499,6 +506,12 @@
 
 	input_report_key(usbtouch->input, BTN_TOUCH, touch);
 
+#ifdef CONFIG_USB_TOUCHSCREEN_CALIBRATE
+	if (cal[6]==0)
+		cal[6] = 1;
+	input_report_abs(usbtouch->input, ABS_X, (cal[0]*x + cal[1]*y + cal[2])/cal[6] );
+	input_report_abs(usbtouch->input, ABS_Y, (cal[3]*x + cal[4]*y + cal[5])/cal[6] );
+#else
 	if (swap_xy) {
 		input_report_abs(usbtouch->input, ABS_X, y);
 		input_report_abs(usbtouch->input, ABS_Y, x);
@@ -506,6 +519,7 @@
 		input_report_abs(usbtouch->input, ABS_X, x);
 		input_report_abs(usbtouch->input, ABS_Y, y);
 	}
+#endif
 	if (type->max_press)
 		input_report_abs(usbtouch->input, ABS_PRESSURE, press);
 	input_sync(usbtouch->input);

-- 
M&N Solutions GmbH
Holger Schurig
Dieselstr. 18
61191 Rosbach
06003/9141-15
