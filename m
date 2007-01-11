Return-Path: <linux-kernel-owner+w=401wt.eu-S1030264AbXAKOyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbXAKOyx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXAKOyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:54:53 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:48754 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030227AbXAKOyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:54:52 -0500
Message-Id: <20070111145422.748329689@delta.onse.fi>
References: <20070111145115.405679742@delta.onse.fi>
User-Agent: quilt/0.45-1
Date: Thu, 11 Jan 2007 16:51:18 +0200
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 3/3] hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter
Content-Disposition: inline; filename=input-hid-ff-pantherlord.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a force feedback driver for PantherLord USB/PS2 2in1 Adapter,
0810:0001. The device identifies itself as "Twin USB Joystick".

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/usb/input/Kconfig    |    8 ++
 drivers/usb/input/Makefile   |    3 +
 drivers/usb/input/hid-ff.c   |    3 +
 drivers/usb/input/hid-plff.c |  129 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h          |    1 
 5 files changed, 144 insertions(+)

Index: linux-2.6.20-rc3-ptr/drivers/usb/input/hid-ff.c
===================================================================
--- linux-2.6.20-rc3-ptr.orig/drivers/usb/input/hid-ff.c	2007-01-07 20:53:42.000000000 +0200
+++ linux-2.6.20-rc3-ptr/drivers/usb/input/hid-ff.c	2007-01-07 21:08:16.000000000 +0200
@@ -57,6 +57,9 @@ static struct hid_ff_initializer inits[]
 	{ 0x46d, 0xc295, hid_lgff_init }, /* Logitech MOMO force wheel */
 	{ 0x46d, 0xc219, hid_lgff_init }, /* Logitech Cordless rumble pad 2 */
 #endif
+#ifdef CONFIG_PANTHERLORD_FF
+	{ 0x810, 0x0001, hid_plff_init },
+#endif
 #ifdef CONFIG_THRUSTMASTER_FF
 	{ 0x44f, 0xb304, hid_tmff_init },
 #endif
Index: linux-2.6.20-rc3-ptr/drivers/usb/input/hid-plff.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.20-rc3-ptr/drivers/usb/input/hid-plff.c	2007-01-11 16:10:10.000000000 +0200
@@ -0,0 +1,129 @@
+/*
+ *  Force feedback support for PantherLord USB/PS2 2in1 Adapter devices
+ *
+ *  Copyright (c) 2007 Anssi Hannula <anssi.hannula@gmail.com>
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
+
+/* #define DEBUG */
+
+#define debug(format, arg...) pr_debug("hid-plff: " format "\n" , ## arg)
+
+#include <linux/input.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include "usbhid.h"
+
+struct plff_device {
+	struct hid_report *report;
+};
+
+static int hid_plff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = dev->private;
+	struct plff_device *plff = data;
+	int left, right;
+
+	left = effect->u.rumble.strong_magnitude;
+	right = effect->u.rumble.weak_magnitude;
+	debug("called with 0x%04x 0x%04x", left, right);
+
+	left = left * 0x7f / 0xffff;
+	right = right * 0x7f / 0xffff;
+
+	plff->report->field[0]->value[2] = left;
+	plff->report->field[0]->value[3] = right;
+	debug("running with 0x%02x 0x%02x", left, right);
+	usbhid_submit_report(hid, plff->report, USB_DIR_OUT);
+
+	return 0;
+}
+
+int hid_plff_init(struct hid_device *hid)
+{
+	struct plff_device *plff;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct list_head *report_list =
+			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct list_head *report_ptr = report_list;
+	struct input_dev *dev;
+	int error;
+
+	/* The device contains 2 output reports (one for each
+	   HID_QUIRK_MULTI_INPUT device), both containing 1 field, which
+	   contains 4 ff00.0002 usages and 4 16bit absolute values.
+
+	   The 2 input reports also contain a field which contains
+	   8 ff00.0001 usages and 8 boolean values. Their meaning is
+	   currently unknown. */
+
+	if (list_empty(report_list)) {
+		printk(KERN_ERR "hid-plff: no output reports found\n");
+		return -ENODEV;
+	}
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+
+		report_ptr = report_ptr->next;
+
+		if (report_ptr == report_list) {
+			printk(KERN_ERR "hid-plff: required output report is missing\n");
+			return -ENODEV;
+		}
+
+		report = list_entry(report_ptr, struct hid_report, list);
+		if (report->maxfield < 1) {
+			printk(KERN_ERR "hid-plff: no fields in the report\n");
+			return -ENODEV;
+		}
+
+		if (report->field[0]->report_count < 4) {
+			printk(KERN_ERR "hid-plff: not enough values in the field\n");
+			return -ENODEV;
+		}
+
+		plff = kzalloc(sizeof(struct plff_device), GFP_KERNEL);
+		if (!plff)
+			return -ENOMEM;
+
+		dev = hidinput->input;
+
+		set_bit(FF_RUMBLE, dev->ffbit);
+
+		error = input_ff_create_memless(dev, plff, hid_plff_play);
+		if (error) {
+			kfree(plff);
+			return error;
+		}
+
+		plff->report = report;
+		plff->report->field[0]->value[0] = 0x00;
+		plff->report->field[0]->value[1] = 0x00;
+		plff->report->field[0]->value[2] = 0x00;
+		plff->report->field[0]->value[3] = 0x00;
+		usbhid_submit_report(hid, plff->report, USB_DIR_OUT);
+	}
+
+	printk(KERN_INFO "hid-plff: Force feedback for PantherLord USB/PS2 "
+	       "2in1 Adapters by Anssi Hannula <anssi.hannula@gmail.com>\n");
+
+	return 0;
+}
Index: linux-2.6.20-rc3-ptr/drivers/usb/input/Kconfig
===================================================================
--- linux-2.6.20-rc3-ptr.orig/drivers/usb/input/Kconfig	2007-01-07 20:53:42.000000000 +0200
+++ linux-2.6.20-rc3-ptr/drivers/usb/input/Kconfig	2007-01-11 15:41:54.000000000 +0200
@@ -71,6 +71,14 @@ config LOGITECH_FF
 	  Note: if you say N here, this device will still be supported, but without
 	  force feedback.
 
+config PANTHERLORD_FF
+	bool "PantherLord USB/PS2 2in1 Adapter support"
+	depends on HID_FF
+	select INPUT_FF_MEMLESS if USB_HID
+	help
+	  Say Y here if you have a PantherLord USB/PS2 2in1 Adapter and want
+	  to enable force feedback support for it.
+
 config THRUSTMASTER_FF
 	bool "ThrustMaster FireStorm Dual Power 2 support (EXPERIMENTAL)"
 	depends on HID_FF && EXPERIMENTAL
Index: linux-2.6.20-rc3-ptr/drivers/usb/input/Makefile
===================================================================
--- linux-2.6.20-rc3-ptr.orig/drivers/usb/input/Makefile	2007-01-07 20:53:42.000000000 +0200
+++ linux-2.6.20-rc3-ptr/drivers/usb/input/Makefile	2007-01-07 21:08:17.000000000 +0200
@@ -17,6 +17,9 @@ endif
 ifeq ($(CONFIG_LOGITECH_FF),y)
 	usbhid-objs	+= hid-lgff.o
 endif
+ifeq ($(CONFIG_PANTHERLORD_FF),y)
+	usbhid-objs	+= hid-plff.o
+endif
 ifeq ($(CONFIG_THRUSTMASTER_FF),y)
 	usbhid-objs	+= hid-tmff.o
 endif
Index: linux-2.6.20-rc3-ptr/include/linux/hid.h
===================================================================
--- linux-2.6.20-rc3-ptr.orig/include/linux/hid.h	2007-01-07 20:56:10.000000000 +0200
+++ linux-2.6.20-rc3-ptr/include/linux/hid.h	2007-01-07 21:08:17.000000000 +0200
@@ -505,6 +505,7 @@ struct hid_device *hid_parse_report(__u8
 int hid_ff_init(struct hid_device *hid);
 
 int hid_lgff_init(struct hid_device *hid);
+int hid_plff_init(struct hid_device *hid);
 int hid_tmff_init(struct hid_device *hid);
 int hid_zpff_init(struct hid_device *hid);
 #ifdef CONFIG_HID_PID

--
Anssi Hannula
