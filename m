Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264515AbTCZD6m>; Tue, 25 Mar 2003 22:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264529AbTCZD6m>; Tue, 25 Mar 2003 22:58:42 -0500
Received: from user-0can0ud.cable.mindspring.com ([24.171.131.205]:40838 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id <S264515AbTCZD6g>;
	Tue, 25 Mar 2003 22:58:36 -0500
Date: Tue, 25 Mar 2003 20:09:46 -0800
From: Eric Wong <eric@yhbt.net>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Logitech USB mice/trackball extensions
Message-ID: <20030326040946.GB13242@BL4ST>
References: <20030326022938.GA5187@bl4st.yhbt.net> <20030326030330.GC12549@BL4ST> <20030326034841.GA20858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326034841.GA20858@kroah.com>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
> On Tue, Mar 25, 2003 at 07:03:30PM -0800, Eric Wong wrote:
> > Oops, ignore this part, it's part of a separate patch :)
> 
> Can you send me an updated patch?

here ya go

diff -ruN a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
--- a/drivers/usb/input/Kconfig	2003-03-17 13:44:22.000000000 -0800
+++ b/drivers/usb/input/Kconfig	2003-03-25 20:04:54.000000000 -0800
@@ -90,6 +90,36 @@
 
 	  If unsure, say Y.
 
+config USB_HIDLOGITECH
+ 	bool "Logitech HID extensions"
+ 	default n
+ 	depends on USB_HID
+ 	help
+ 	  Say Y here will enable control of Logitech specific extensions
+ 
+	  module parameter: 'hid_logitech_sms' type: boolean
+	  
+	  Toggle simulated scrolling with the Smart Scroll / Cruise Control
+ 	  buttons (7 and 8) on the following Logitech devices: 
+ 	  - MX500 Optical Mouse
+ 	  - Receiver for Cordless Elite Duo
+ 	  - Receiver for MX700 Optical Mouse
+ 	  - Receiver for Cordless Optical TrackMan
+
+  	  default: 1 (Smart Scroll / Cruise Control enabled)
+ 
+	  module parameter: 'hid_logitech_res' type: boolean
+	  Toggle 400 / 800 cpi (characters per inch) resolution on Logitech
+ 	  devices that support it:
+ 	  - Wheel Mouse Optical
+ 	  - MouseMan Traveler
+ 	  - MouseMan Dual Optical
+ 	  - MX300 Optical Mouse
+ 	  - MX500 Optical Mouse
+ 	  - iFeel Mouse (silver)
+	  
+ 	  default: 0 (400 cpi)
+
 menu "USB HID Boot Protocol drivers"
 	depends on USB!=n && USB_HID!=y
 
diff -ruN a/drivers/usb/input/Makefile b/drivers/usb/input/Makefile
--- a/drivers/usb/input/Makefile	2003-03-17 13:44:11.000000000 -0800
+++ b/drivers/usb/input/Makefile	2003-03-25 20:04:54.000000000 -0800
@@ -25,6 +25,9 @@
 ifeq ($(CONFIG_HID_FF),y)
 	hid-objs	+= hid-ff.o
 endif
+ifeq ($(CONFIG_USB_HIDLOGITECH),y)
+	hid-objs	+= hid-logitech.o
+endif
 
 obj-$(CONFIG_USB_AIPTEK)	+= aiptek.o
 obj-$(CONFIG_USB_HID)		+= hid.o
diff -ruN a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2003-03-24 19:22:13.000000000 -0800
+++ b/drivers/usb/input/hid-core.c	2003-03-25 20:05:21.000000000 -0800
@@ -1610,6 +1610,7 @@
 	hid_dump_device(hid);
 
 	hid_ff_init(hid);
+	hid_logitech_extras(hid);
 
 	if (!hidinput_connect(hid))
 		hid->claimed |= HID_CLAIMED_INPUT;
diff -ruN a/drivers/usb/input/hid-logitech.c b/drivers/usb/input/hid-logitech.c
--- a/drivers/usb/input/hid-logitech.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/usb/input/hid-logitech.c	2003-03-25 20:04:54.000000000 -0800
@@ -0,0 +1,156 @@
+/*
+ *  Copyright (c) 2003 Eric Wong <eric@yhbt.net>
+ *
+ *  Logitech extensions for HID devices
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/usb.h>
+#include "hid.h"
+
+/* 
+ * Logitech USB extra features 
+ */
+
+#define HID_QUIRK_LOGI_HIRES	0x01
+#define HID_QUIRK_LOGI_SMS	0x02
+
+#if 0
+#define HID_QUIRK_LOGI_CSR	0x04 /* not implemented */
+#endif
+
+/*
+ * RES - Resolution switching between 400 cpi and 800 cpi
+ *                type  req  value  index  length   
+ * Set 400 cpi    40    02   0E 00  03 00  00 00  
+ * Set 800 cpi    40    02   0E 00  04 00  00 00  
+ * Get resolution C0    01   0E 00  00 00  01 00 
+ * 	returns: 03 for 400 cpi or 04 for 800 cpi
+ *
+ * SMS - Smart Scroll / Cruise Control
+ *                type  req  value  index  length   
+ * Enable SMS     40    02   17 00  01 00  00 00  
+ * Disable SMS    40    02   17 00  00 00  00 00  
+ * Get SMS mode   C0    01   17 00  00 00  01 00 
+ * 	returns: 00 for disabled, 01 for enabled
+ */
+
+#define USB_VENDOR_ID_LOGITECH		0x046d
+
+/* mice */
+#define USB_DEVICE_ID_LOGITECH_WMOPT	0xc00e	/* Wheel Mouse Optical */
+#define USB_DEVICE_ID_LOGITECH_MMTRAV	0xc00f	/* MouseMan Traveler */
+#define USB_DEVICE_ID_LOGITECH_MMDUAL	0xc012	/* MouseMan Dual Optical */
+#define USB_DEVICE_ID_LOGITECH_MX300	0xc024	/* MX300 Optical Mouse */
+#define USB_DEVICE_ID_LOGITECH_MX500	0xc025	/* MX500 Optical Mouse */
+#define USB_DEVICE_ID_LOGITECH_IFEEL	0xc031	/* iFeel Mouse (silver) */
+
+/* receivers for cordless devices */
+#define USB_DEVICE_ID_LOGITECH_CEDUO	0xc505	/* Cordless Elite Duo */
+#define USB_DEVICE_ID_LOGITECH_MX700	0xc506	/* MX700 Optical Mouse */
+#define USB_DEVICE_ID_LOGITECH_COTRACK	0xc508	/* Cordless Optical TrackMan */
+
+/*
+ * keep this separate from the main hid-core.c blacklist to avoid bloating the
+ * code for people who don't use these Logitech products.  This isn't a
+ * blacklist, it's a whitelist :)
+ */
+
+struct hid_logitech_quirklist {
+	__u16 idVendor;
+	__u16 idProduct;
+	unsigned features;
+} hid_logitech_quirklist[] = { 
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WMOPT,
+		HID_QUIRK_LOGI_HIRES },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MMTRAV,
+		HID_QUIRK_LOGI_HIRES },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MMDUAL,
+		HID_QUIRK_LOGI_HIRES },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MX300,
+		HID_QUIRK_LOGI_HIRES },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_IFEEL,
+		HID_QUIRK_LOGI_HIRES },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MX500,
+		HID_QUIRK_LOGI_HIRES | HID_QUIRK_LOGI_SMS },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_CEDUO,
+		HID_QUIRK_LOGI_SMS },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MX700,
+		HID_QUIRK_LOGI_SMS },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_COTRACK,
+		HID_QUIRK_LOGI_SMS },
+	{ 0, 0 }
+};
+	
+/* 
+ * Logitech SMS and RES
+ * these are the logitech defaults for dpi and smart scrolling 
+ * I don't like them, but they're the defaults. Also why I made this patch
+ */
+
+#define HID_LOGITECH_RES	0
+#define HID_LOGITECH_SMS	1
+
+static int hid_logitech_res = HID_LOGITECH_RES;
+static int hid_logitech_sms = HID_LOGITECH_SMS;
+
+void hid_logitech_extras (struct hid_device *hid) 
+{
+	unsigned features = 0;
+	int n;
+	for (n = 0; hid_logitech_quirklist[n].idVendor; ++n)
+		if ((hid_logitech_quirklist[n].idVendor == hid->dev->descriptor.idVendor) &&
+			(hid_logitech_quirklist[n].idProduct == hid->dev->descriptor.idProduct))
+				features = hid_logitech_quirklist[n].features;
+
+	if ( (features & HID_QUIRK_LOGI_SMS) && !hid_logitech_sms ) 
+		/* disable sms */
+	        usb_control_msg(hid->dev, usb_sndctrlpipe(hid->dev, 0),
+				0x02, 0x40, 0x0017, 0x0000, NULL, 0, HZ);
+	else if ( (features & HID_QUIRK_LOGI_SMS) && hid_logitech_sms ) 
+		/* enable sms */
+	        usb_control_msg(hid->dev, usb_sndctrlpipe(hid->dev, 0),
+				0x02, 0x40, 0x0017, 0x0001, NULL, 0, HZ);
+
+	if ( (features & HID_QUIRK_LOGI_HIRES) && hid_logitech_res ) 
+		/* 800 cpi resolution */
+	        usb_control_msg(hid->dev,usb_sndctrlpipe(hid->dev, 0),
+				0x02, 0x40, 0x000e, 0x0004, NULL, 0, HZ);
+	else if ( (features & HID_QUIRK_LOGI_HIRES) && !hid_logitech_res ) 
+		/* 400 cpi resolution */
+	        usb_control_msg(hid->dev,usb_sndctrlpipe(hid->dev, 0),
+				0x02, 0x40, 0x000e, 0x0003, NULL, 0, HZ);
+}
+
+MODULE_PARM(hid_logitech_res, "i");
+MODULE_PARM_DESC(hid_logitech_res, "resolution, 1 = 800cpi | 0 = 400cpi (default)");
+MODULE_PARM(hid_logitech_sms, "i");
+MODULE_PARM_DESC(hid_logitech_sms, "auto-repeat, 1 = enabled (default) | 0 = disabled");
+
+#ifndef MODULE
+static int __init hid_logitech_res_setup(char *str)
+{
+	get_option(&str,&hid_logitech_res);
+	return 1;
+}
+
+static int __init hid_logitech_sms_setup(char *str)
+{
+	get_option(&str,&hid_logitech_sms);
+	return 1;
+}
+__setup("hid_logitech_res=", hid_logitech_res_setup);
+__setup("hid_logitech_sms=", hid_logitech_sms_setup);
+#endif
+
diff -ruN a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	2003-03-17 13:43:37.000000000 -0800
+++ b/drivers/usb/input/hid.h	2003-03-25 20:04:54.000000000 -0800
@@ -432,6 +432,12 @@
 static inline void hidinput_disconnect(struct hid_device *hid) { }
 #endif
 
+#ifdef CONFIG_USB_HIDLOGITECH
+extern void hid_logitech_extras (struct hid_device *);
+#else
+static inline void hid_logitech_extras (struct hid_device *hid) { }
+#endif 
+
 int hid_open(struct hid_device *);
 void hid_close(struct hid_device *);
 int hid_find_field(struct hid_device *, unsigned int, unsigned int, struct hid_field **);

-- 
Eric Wong
