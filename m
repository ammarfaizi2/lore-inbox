Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbWEOVRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbWEOVRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWEOVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:16:13 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:7083 "EHLO
	pne-smtpout4-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965243AbWEOVPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:15:55 -0400
Message-Id: <20060515211510.113732000@gmail.com>
References: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:37 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 08/11] input: force feedback driver for Zeroplus devices
Content-Disposition: inline; filename=ff-refactoring-new-driver-zpff.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add force feedback driver for some PSX-style Zeroplus devices.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/usb/input/Kconfig    |    7 ++
 drivers/usb/input/Makefile   |    3 +
 drivers/usb/input/hid-ff.c   |    4 +
 drivers/usb/input/hid-zpff.c |  128 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/input/hid.h      |    1 
 5 files changed, 143 insertions(+)

Index: linux-2.6.16-rc1-git11/drivers/usb/input/hid-ff.c
===================================================================
--- linux-2.6.16-rc1-git11.orig/drivers/usb/input/hid-ff.c	2006-04-15 16:22:52.000000000 +0300
+++ linux-2.6.16-rc1-git11/drivers/usb/input/hid-ff.c	2006-04-15 16:23:50.000000000 +0300
@@ -54,6 +54,10 @@ static struct hid_ff_initializer inits[]
 #ifdef CONFIG_THRUSTMASTER_FF
 	{0x44f, 0xb304, hid_tmff_init},
 #endif
+#ifdef CONFIG_ZEROPLUS_FF
+	{0xc12, 0x0005, zpff_init},
+	{0xc12, 0x0030, zpff_init},
+#endif
 	{0, 0, NULL} /* Terminating entry */
 };
 
Index: linux-2.6.16-rc1-git11/drivers/usb/input/hid-zpff.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc1-git11/drivers/usb/input/hid-zpff.c	2006-04-15 16:26:58.000000000 +0300
@@ -0,0 +1,128 @@
+/*
+ *  Force feedback support for Zeroplus based devices
+ *
+ *  Copyright (c) 2005, 2006 Anssi Hannula <anssi.hannula@gmail.com>
+ */
+
+/*
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include "hid.h"
+
+/* #define DEBUG */
+
+#ifdef DEBUG
+#define debug(format, arg...) printk(KERN_DEBUG "hid-zpff: " format "\n" , ## arg)
+#else
+#define debug(format, arg...) do {} while (0)
+#endif
+
+struct zpff_device {
+	struct hid_report *report;
+};
+
+static int zpff_play(struct input_dev *dev, struct ff_effect *effect,
+		     struct ff_effect *old)
+{
+	struct hid_device *hid = dev->private;
+	struct zpff_device *zpff = hid->ff_private;
+	int left, right;
+
+	/* The following is specified the other way around in the Zeroplus
+	   datasheet, but the order below is correct for the XFX Executioner */
+	/* However it is possible that the XFX Executioner is an exception */
+
+	left = effect->u.rumble.strong_magnitude;
+	right = effect->u.rumble.weak_magnitude;
+	debug("called with 0x%04x 0x%04x", left, right);
+
+	left = left * 0x7f / 0xffff;
+	right = right * 0x7f / 0xffff;
+
+	zpff->report->field[2]->value[0] = left;
+	zpff->report->field[3]->value[0] = right;
+	debug("running with 0x%02x 0x%02x", left, right);
+	hid_submit_report(hid, zpff->report, USB_DIR_OUT);
+	return 0;
+}
+
+static void zpff_exit(struct hid_device *hid)
+{
+	struct zpff_device *zpff = hid->ff_private;
+	hid->ff_private = NULL;
+	kfree(zpff);
+}
+
+static struct ff_driver zpff_driver = {
+	.upload = zpff_play,
+};
+
+int zpff_init(struct hid_device *hid)
+{
+	struct zpff_device *zpff;
+	struct hid_report *report;
+	struct hid_input *hidinput =
+	    list_entry(hid->inputs.next, struct hid_input, list);
+	struct input_dev *dev = hidinput->input;
+	int ret;
+
+	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {
+		printk(KERN_ERR "hid-zpff: no output report found\n");
+		return -1;
+	}
+	report =
+	    list_entry(hid->report_enum[HID_OUTPUT_REPORT].report_list.next,
+		       struct hid_report, list);
+
+	if (report->maxfield < 4) {
+		printk(KERN_ERR "hid-zpff: not enough fields in report\n");
+		return -1;
+	}
+
+	ret = input_ff_allocate(dev);
+	if (ret)
+		return ret;
+
+	zpff = kzalloc(sizeof(*zpff), GFP_KERNEL);
+	if (!zpff) {
+		return -ENOMEM;
+	}
+
+	hid->ff_private = zpff;
+	hid->ff_exit = zpff_exit;
+
+	set_bit(FF_RUMBLE, dev->ff->flags);
+
+	zpff->report = report;
+	zpff->report->field[0]->value[0] = 0x00;
+	zpff->report->field[1]->value[0] = 0x02;
+	zpff->report->field[2]->value[0] = 0x00;
+	zpff->report->field[3]->value[0] = 0x00;
+	hid_submit_report(hid, zpff->report, USB_DIR_OUT);
+
+	ret = input_ff_register(dev, &zpff_driver);
+	if (ret) {
+		kfree(zpff);
+		return ret;
+	}
+
+	printk(KERN_INFO "Force feedback for Zeroplus based devices by "
+	       "Anssi Hannula <anssi.hannula@gmail.com>\n");
+
+	return 0;
+}
Index: linux-2.6.16-rc1-git11/drivers/usb/input/Kconfig
===================================================================
--- linux-2.6.16-rc1-git11.orig/drivers/usb/input/Kconfig	2006-04-15 16:22:52.000000000 +0300
+++ linux-2.6.16-rc1-git11/drivers/usb/input/Kconfig	2006-04-15 16:23:50.000000000 +0300
@@ -87,6 +87,13 @@ config THRUSTMASTER_FF
 	  Note: if you say N here, this device will still be supported, but without
 	  force feedback.
 
+config ZEROPLUS_FF
+	bool "Zeroplus based game controller support"
+	depends on HID_FF
+	help
+	  Say Y here if you have a Zeroplus based game controller and want to
+	  enable force feedback for it.
+
 config USB_HIDDEV
 	bool "/dev/hiddev raw HID device support"
 	depends on USB_HID
Index: linux-2.6.16-rc1-git11/drivers/usb/input/Makefile
===================================================================
--- linux-2.6.16-rc1-git11.orig/drivers/usb/input/Makefile	2006-04-15 16:22:52.000000000 +0300
+++ linux-2.6.16-rc1-git11/drivers/usb/input/Makefile	2006-04-15 16:23:50.000000000 +0300
@@ -22,6 +22,9 @@ endif
 ifeq ($(CONFIG_THRUSTMASTER_FF),y)
 	usbhid-objs	+= hid-tmff.o
 endif
+ifeq ($(CONFIG_ZEROPLUS_FF),y)
+	usbhid-objs	+= hid-zpff.o
+endif
 ifeq ($(CONFIG_HID_FF),y)
 	usbhid-objs	+= hid-ff.o
 endif
Index: linux-2.6.16-rc1-git11/drivers/usb/input/hid.h
===================================================================
--- linux-2.6.16-rc1-git11.orig/drivers/usb/input/hid.h	2006-04-15 16:22:52.000000000 +0300
+++ linux-2.6.16-rc1-git11/drivers/usb/input/hid.h	2006-04-15 16:23:50.000000000 +0300
@@ -527,6 +527,7 @@ static inline void hid_ff_exit(struct hi
 
 int hid_lgff_init(struct hid_device* hid);
 int hid_tmff_init(struct hid_device* hid);
+int zpff_init(struct hid_device* hid);
 
 #ifdef CONFIG_HID_PID
 int pidff_init(struct hid_device *hid);

--
Anssi Hannula
