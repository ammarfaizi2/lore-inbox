Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUCPO1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUCPOY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:24:57 -0500
Received: from styx.suse.cz ([82.208.2.94]:4738 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261955AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467782137@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 40/44] Fix for HID devices which need nonzero idle for the ctrl pipe
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467783749@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.14, 2004-03-10 09:05:31+01:00, davidm@hpl.hp.com
  input: When reading input reports from a device via the ctrl pipe,
         set idle time of the device. This makes buggy devices which
         take the idle time into account for the ctrl pipe work.


 hid-core.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:17:37 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:17:37 2004
@@ -1108,7 +1108,9 @@
 	hid->cr->wIndex = cpu_to_le16(hid->ifnum);
 	hid->cr->wLength = cpu_to_le16(len);
 
-	dbg("submitting ctrl urb");
+	dbg("submitting ctrl urb: %s wValue=0x%04x wIndex=0x%04x wLength=%u",
+	    hid->cr->bRequest == HID_REQ_SET_REPORT ? "Set_Report" : "Get_Report",
+	    hid->cr->wValue, hid->cr->wIndex, hid->cr->wLength);
 
 	if (usb_submit_urb(hid->urbctrl, GFP_ATOMIC)) {
 		err("usb_submit_urb(ctrl) failed");
@@ -1286,6 +1288,23 @@
 	struct list_head *list;
 	int err, ret;
 
+	/*
+	 * The Set_Idle request is supposed to affect only the
+	 * "Interrupt In" pipe. Unfortunately, buggy devices such as
+	 * the BTC keyboard (ID 046e:5303) the request also affects
+	 * Get_Report requests on the control pipe.  In the worst
+	 * case, if the device was put on idle for an indefinite
+	 * amount of time (as we do below) and there are no input
+	 * events to report, the Get_Report requests will just hang
+	 * until we get a USB timeout.  To avoid this, we temporarily
+	 * establish a minimal idle time of 1ms.  This shouldn't hurt
+	 * bugfree devices and will cause a worst-case extra delay of
+	 * 1ms for buggy ones.
+	 */
+	usb_control_msg(hid->dev, usb_sndctrlpipe(hid->dev, 0),
+			HID_REQ_SET_IDLE, USB_TYPE_CLASS | USB_RECIP_INTERFACE, (1 << 8),
+			hid->ifnum, NULL, 0, HZ * USB_CTRL_SET_TIMEOUT);
+
 	report_enum = hid->report_enum + HID_INPUT_REPORT;
 	list = report_enum->report_list.next;
 	while (list != &report_enum->report_list) {
@@ -1319,7 +1338,7 @@
 	while (list != &report_enum->report_list) {
 		report = (struct hid_report *) list;
 		usb_control_msg(hid->dev, usb_sndctrlpipe(hid->dev, 0),
-			0x0a, USB_TYPE_CLASS | USB_RECIP_INTERFACE, report->id,
+			HID_REQ_SET_IDLE, USB_TYPE_CLASS | USB_RECIP_INTERFACE, report->id,
 			hid->ifnum, NULL, 0, HZ * USB_CTRL_SET_TIMEOUT);
 		list = list->next;
 	}

