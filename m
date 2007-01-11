Return-Path: <linux-kernel-owner+w=401wt.eu-S1030227AbXAKOyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbXAKOyy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbXAKOyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:54:54 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:48754 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030227AbXAKOyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:54:53 -0500
Message-Id: <20070111145422.383583876@delta.onse.fi>
References: <20070111145115.405679742@delta.onse.fi>
User-Agent: quilt/0.45-1
Date: Thu, 11 Jan 2007 16:51:17 +0200
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 2/3] hid: quirk for multi-input devices with unneeded output reports
Content-Disposition: inline; filename=input-hid-multi-input-skip-output-report.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add new quirk HID_QUIRK_SKIP_OUTPUT_REPORTS to skip output reports
when enumerating reports on a hid-input device. Add this quirk and
HID_QUIRK_MULTI_INPUT to 0810:0001.

PantherLord Twin USB Joystick, 0810:0001 has separate input reports
for 2 distinct game controllers in the same interface, so it needs
HID_QUIRK_MULTI_INPUT. However, the device also contains one output
report per controller which is used to control the force feedback
function, and we do not want those to appear as separate input
devices as well. The simplest approach seems to be to add a quirk to
skip output reports on 0810:0001, and allow the force feedback
driver to handle those.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/hid/hid-input.c      |    6 +++++-
 drivers/usb/input/hid-core.c |    5 +++++
 include/linux/hid.h          |    1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

Index: linux-2.6.20-rc3-ptr/drivers/hid/hid-input.c
===================================================================
--- linux-2.6.20-rc3-ptr.orig/drivers/hid/hid-input.c	2007-01-06 00:38:33.000000000 +0200
+++ linux-2.6.20-rc3-ptr/drivers/hid/hid-input.c	2007-01-07 21:07:34.000000000 +0200
@@ -796,6 +796,7 @@ int hidinput_connect(struct hid_device *
 	struct hid_input *hidinput = NULL;
 	struct input_dev *input_dev;
 	int i, j, k;
+	int max_report_type = HID_OUTPUT_REPORT;
 
 	INIT_LIST_HEAD(&hid->inputs);
 
@@ -808,7 +809,10 @@ int hidinput_connect(struct hid_device *
 	if (i == hid->maxcollection)
 		return -1;
 
-	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++)
+	if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
+		max_report_type = HID_INPUT_REPORT;
+
+	for (k = HID_INPUT_REPORT; k <= max_report_type; k++)
 		list_for_each_entry(report, &hid->report_enum[k].report_list, list) {
 
 			if (!report->maxfield)
Index: linux-2.6.20-rc3-ptr/drivers/usb/input/hid-core.c
===================================================================
--- linux-2.6.20-rc3-ptr.orig/drivers/usb/input/hid-core.c	2007-01-07 20:53:21.000000000 +0200
+++ linux-2.6.20-rc3-ptr/drivers/usb/input/hid-core.c	2007-01-07 21:02:39.000000000 +0200
@@ -791,6 +791,9 @@ void usbhid_init_reports(struct hid_devi
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_USB_RECEIVER	0xc101
 
+#define USB_VENDOR_ID_PANTHERLORD	0x0810
+#define USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK	0x0001
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -965,6 +968,8 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_USB_RECEIVER, HID_QUIRK_BAD_RELATIVE_KEYS },
 
+	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
+
 	{ 0, 0 }
 };
 
Index: linux-2.6.20-rc3-ptr/include/linux/hid.h
===================================================================
--- linux-2.6.20-rc3-ptr.orig/include/linux/hid.h	2007-01-07 20:53:42.000000000 +0200
+++ linux-2.6.20-rc3-ptr/include/linux/hid.h	2007-01-07 20:56:10.000000000 +0200
@@ -264,6 +264,7 @@ struct hid_item {
 #define HID_QUIRK_INVERT_HWHEEL			0x00004000
 #define HID_QUIRK_POWERBOOK_ISO_KEYBOARD        0x00008000
 #define HID_QUIRK_BAD_RELATIVE_KEYS		0x00010000
+#define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00020000
 
 /*
  * This is the global environment of the parser. This information is

--
Anssi Hannula
