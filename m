Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVA0RQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVA0RQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVA0RPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:15:04 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:61663 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262665AbVA0ROO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:14:14 -0500
Subject: [PATCH 2/6] Handle -EILSEQ return code in the HID driver
In-Reply-To: <1106846038373@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 27 Jan 2005 18:13:58 +0100
Message-Id: <11068460381254@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1972, 2005-01-13 13:32:43+01:00, vojtech@suse.cz
  input: Handle -EILSEQ return code in the HID driver completion
         handlers as unplug.
         Flush request queue on unplug, too.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-core.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2005-01-27 17:48:07 +01:00
+++ b/drivers/usb/input/hid-core.c	2005-01-27 17:48:07 +01:00
@@ -925,8 +925,9 @@
 			break;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 		case -EPERM:
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timeout on uhci */
 			return;
 		case -ETIMEDOUT:	/* NAK */
 			break;
@@ -1136,12 +1137,15 @@
 {
 	struct hid_device *hid = urb->context;
 	unsigned long flags;
+	int unplug = 0;
 
 	switch (urb->status) {
 		case 0:			/* success */
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timeout on uhci */
+			unplug = 1;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 			break;
 		default:		/* error */
 			warn("output irq status %d received", urb->status);
@@ -1149,7 +1153,10 @@
 
 	spin_lock_irqsave(&hid->outlock, flags);
 
-	hid->outtail = (hid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
+	if (unplug)
+		hid->outtail = hid->outhead;
+	else
+		hid->outtail = (hid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
 	if (hid->outhead != hid->outtail) {
 		if (hid_submit_out(hid)) {
@@ -1173,6 +1180,7 @@
 {
 	struct hid_device *hid = urb->context;
 	unsigned long flags;
+	int unplug = 0;
 
 	spin_lock_irqsave(&hid->ctrllock, flags);
 
@@ -1180,16 +1188,21 @@
 		case 0:			/* success */
 			if (hid->ctrl[hid->ctrltail].dir == USB_DIR_IN) 
 				hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, regs);
+		case -ESHUTDOWN:	/* unplug */
+		case -EILSEQ:		/* unplug timectrl on uhci */
+			unplug = 1;
 		case -ECONNRESET:	/* unlink */
 		case -ENOENT:
-		case -ESHUTDOWN:
 		case -EPIPE:		/* report not available */
 			break;
 		default:		/* error */
 			warn("ctrl urb status %d received", urb->status);
 	}
 
-	hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
+	if (unplug)
+		hid->ctrltail = hid->ctrlhead;
+	else
+		hid->ctrltail = (hid->ctrltail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
 	if (hid->ctrlhead != hid->ctrltail) {
 		if (hid_submit_ctrl(hid)) {

