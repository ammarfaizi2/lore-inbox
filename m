Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265735AbTFNUc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbTFNUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:32:28 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27882 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265710AbTFNUap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:30:45 -0400
Date: Sat, 14 Jun 2003 22:44:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Fix sending reports in USB HID  [10/13]
Message-ID: <20030614224432.I25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <20030614224052.E25997@ucw.cz> <20030614224149.F25997@ucw.cz> <20030614224253.G25997@ucw.cz> <20030614224358.H25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614224358.H25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:43:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.27, 2003-06-11 16:57:39+02:00, vsu@altlinux.ru
  hid: fix HID feature/output report writing to devices. This should
  fix most problems with UPS shutdown.


 hid-core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Sat Jun 14 22:23:57 2003
+++ b/drivers/usb/input/hid-core.c	Sat Jun 14 22:23:57 2003
@@ -957,6 +957,10 @@
 void hid_output_report(struct hid_report *report, __u8 *data)
 {
 	unsigned n;
+
+	if (report->id > 0)
+		*data++ = report->id;
+
 	for (n = 0; n < report->maxfield; n++)
 		hid_output_field(report->field[n], data);
 }
@@ -1051,7 +1055,7 @@
 	report = hid->out[hid->outtail];
 
 	hid_output_report(report, hid->outbuf);
-	hid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1;
+	hid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 	hid->urbout->dev = hid->dev;
 
 	dbg("submitting out urb");
@@ -1075,7 +1079,7 @@
 	if (dir == USB_DIR_OUT)
 		hid_output_report(report, hid->ctrlbuf);
 
-	hid->urbctrl->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + ((report->id > 0) && (dir != USB_DIR_OUT));
+	hid->urbctrl->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 	hid->urbctrl->pipe = (dir == USB_DIR_OUT) ?  usb_sndctrlpipe(hid->dev, 0) : usb_rcvctrlpipe(hid->dev, 0);
 	hid->urbctrl->dev = hid->dev;
 
