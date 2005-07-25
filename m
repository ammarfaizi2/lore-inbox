Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVGYF5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVGYF5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVGYFzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:55:13 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:36193 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261661AbVGYFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:24 -0400
Message-Id: <20050725054533.484329000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 20/24] HID - only report events coming from interrupts to hiddev
Content-Disposition: inline; filename=hiddev-no-ctrl-in-read.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Kropelin <akropel1@rochester.rr.com>

Input: HID - only report events coming from interrupts to hiddev

Currently hid-core follows the same code path for input reports
regardless of whether they are a result of interrupt transfers or
control transfers. That leads to interrupt events erroneously being
reported to hiddev for regular control transfers.

Prior to 2.6.12 the problem was mitigated by the fact that
reporting to hiddev is supressed if the field value has not changed,
which is often the case. Said filtering was removed in 2.6.12-rc1 which
means any input reports fetched via control transfers result in hiddev
interrupt events. This behavior can quickly lead to a feedback loop
where a userspace app, in response to interrupt events, issues control
transfers which in turn create more interrupt events.

This patch prevents input reports that arrive via control transfers from
being reported to hiddev as interrupt events.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-core.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

Index: work/drivers/usb/input/hid-core.c
===================================================================
--- work.orig/drivers/usb/input/hid-core.c
+++ work/drivers/usb/input/hid-core.c
@@ -789,12 +789,12 @@ static __inline__ int search(__s32 *arra
 	return -1;
 }
 
-static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
+static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, int interrupt, struct pt_regs *regs)
 {
 	hid_dump_input(usage, value);
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_hid_event(hid, field, usage, value, regs);
-	if (hid->claimed & HID_CLAIMED_HIDDEV)
+	if (hid->claimed & HID_CLAIMED_HIDDEV && interrupt)
 		hiddev_hid_event(hid, field, usage, value, regs);
 }
 
@@ -804,7 +804,7 @@ static void hid_process_event(struct hid
  * reporting to the layer).
  */
 
-static void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data, struct pt_regs *regs)
+static void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data, int interrupt, struct pt_regs *regs)
 {
 	unsigned n;
 	unsigned count = field->report_count;
@@ -831,19 +831,19 @@ static void hid_input_field(struct hid_d
 	for (n = 0; n < count; n++) {
 
 		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
-			hid_process_event(hid, field, &field->usage[n], value[n], regs);
+			hid_process_event(hid, field, &field->usage[n], value[n], interrupt, regs);
 			continue;
 		}
 
 		if (field->value[n] >= min && field->value[n] <= max
 			&& field->usage[field->value[n] - min].hid
 			&& search(value, field->value[n], count))
-				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, regs);
+				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, interrupt, regs);
 
 		if (value[n] >= min && value[n] <= max
 			&& field->usage[value[n] - min].hid
 			&& search(field->value, value[n], count))
-				hid_process_event(hid, field, &field->usage[value[n] - min], 1, regs);
+				hid_process_event(hid, field, &field->usage[value[n] - min], 1, interrupt, regs);
 	}
 
 	memcpy(field->value, value, count * sizeof(__s32));
@@ -851,7 +851,7 @@ exit:
 	kfree(value);
 }
 
-static int hid_input_report(int type, struct urb *urb, struct pt_regs *regs)
+static int hid_input_report(int type, struct urb *urb, int interrupt, struct pt_regs *regs)
 {
 	struct hid_device *hid = urb->context;
 	struct hid_report_enum *report_enum = hid->report_enum + type;
@@ -899,7 +899,7 @@ static int hid_input_report(int type, st
 		hiddev_report_event(hid, report);
 
 	for (n = 0; n < report->maxfield; n++)
-		hid_input_field(hid, report->field[n], data, regs);
+		hid_input_field(hid, report->field[n], data, interrupt, regs);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
@@ -918,7 +918,7 @@ static void hid_irq_in(struct urb *urb, 
 
 	switch (urb->status) {
 		case 0:			/* success */
-			hid_input_report(HID_INPUT_REPORT, urb, regs);
+			hid_input_report(HID_INPUT_REPORT, urb, 1, regs);
 			break;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
@@ -1142,7 +1142,7 @@ static void hid_ctrl(struct urb *urb, st
 	switch (urb->status) {
 		case 0:			/* success */
 			if (hid->ctrl[hid->ctrltail].dir == USB_DIR_IN)
-				hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, regs);
+				hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, 0, regs);
 		case -ESHUTDOWN:	/* unplug */
 		case -EILSEQ:		/* unplug timectrl on uhci */
 			unplug = 1;

