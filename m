Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVBKAB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVBKAB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVBKAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:01:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54163 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261952AbVBKABx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:01:53 -0500
Date: Thu, 10 Feb 2005 16:01:49 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB 2.4.30: hid for ia64
Message-ID: <20050210160149.12a56e18@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, the HP rx5670 fails to reboot if a USB keyboard if attached
without this patch (and the OHCI fix we accepted for 2.4.29).

This bug is better known for its effect on Altix, but SGI ships a magic
kernel anyhow, so I don't want to use that as justification.

The original patch comes from Jes Sorensen, but then I corrupted his
idea with my simplifications and a partial backport from 2.6, so if this
fails do not e-mail him.

diff -urpN -X dontdiff linux-2.4.30-pre1/drivers/usb/hid-core.c linux-2.4.30-pre1-usb/drivers/usb/hid-core.c
--- linux-2.4.30-pre1/drivers/usb/hid-core.c	2004-11-22 23:04:18.000000000 -0800
+++ linux-2.4.30-pre1-usb/drivers/usb/hid-core.c	2005-02-10 11:18:08.000000000 -0800
@@ -1064,18 +1064,31 @@ static int hid_submit_out(struct hid_dev
 static void hid_ctrl(struct urb *urb)
 {
 	struct hid_device *hid = urb->context;
+	unsigned long flags;
 
 	if (urb->status)
 		warn("ctrl urb status %d received", urb->status);
 
+	spin_lock_irqsave(&hid->outlock, flags);
+
 	hid->outtail = (hid->outtail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
-	if (hid->outhead != hid->outtail)
-		hid_submit_out(hid);
+	if (hid->outhead != hid->outtail) {
+		if (hid_submit_out(hid)) {
+			clear_bit(HID_OUT_RUNNING, &hid->iofl);
+		}
+		spin_unlock_irqrestore(&hid->outlock, flags);
+		return;
+	}
+
+	clear_bit(HID_OUT_RUNNING, &hid->iofl);
+	spin_unlock_irqrestore(&hid->outlock, flags);
 }
 
 void hid_write_report(struct hid_device *hid, struct hid_report *report)
 {
+	unsigned long flags;
+
 	if (hid->report_enum[report->type].numbered) {
 		hid->out[hid->outhead].buffer[0] = report->id;
 		hid_output_report(report, hid->out[hid->outhead].buffer + 1);
@@ -1087,13 +1100,18 @@ void hid_write_report(struct hid_device 
 
 	hid->out[hid->outhead].dr.wValue = cpu_to_le16(((report->type + 1) << 8) | report->id);
 
+	spin_lock_irqsave(&hid->outlock, flags);
+
 	hid->outhead = (hid->outhead + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
 	if (hid->outhead == hid->outtail)
 		hid->outtail = (hid->outtail + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
-	if (hid->urbout.status != -EINPROGRESS)
-		hid_submit_out(hid);
+	if (!test_and_set_bit(HID_OUT_RUNNING, &hid->iofl))
+		if (hid_submit_out(hid))
+			clear_bit(HID_OUT_RUNNING, &hid->iofl);
+
+	spin_unlock_irqrestore(&hid->outlock, flags);
 }
 
 int hid_open(struct hid_device *hid)
@@ -1333,6 +1351,8 @@ static struct hid_device *usb_hid_config
 		return NULL;
 	}
 
+	spin_lock_init(&hid->outlock);
+
 	hid->version = hdesc->bcdHID;
 	hid->country = hdesc->bCountryCode;
 	hid->dev = dev;
diff -urpN -X dontdiff linux-2.4.30-pre1/drivers/usb/hid.h linux-2.4.30-pre1-usb/drivers/usb/hid.h
--- linux-2.4.30-pre1/drivers/usb/hid.h	2005-01-26 13:04:23.000000000 -0800
+++ linux-2.4.30-pre1-usb/drivers/usb/hid.h	2005-02-10 11:26:43.000000000 -0800
@@ -302,6 +302,8 @@ struct hid_control_fifo {
 #define HID_CLAIMED_INPUT	1
 #define HID_CLAIMED_HIDDEV	2
 
+#define HID_OUT_RUNNING		2
+
 struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
@@ -322,12 +324,15 @@ struct hid_device {							/* device repo
 	struct usb_device *dev;						/* USB device */
 	int ifnum;							/* USB interface number */
 
+	unsigned long iofl;						/* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
+
 	struct urb urb;							/* USB URB structure */
 	char buffer[HID_BUFFER_SIZE];					/* Rx buffer */
 
 	struct urb urbout;						/* Output URB */
 	struct hid_control_fifo out[HID_CONTROL_FIFO_SIZE];		/* Transmit buffer */
 	unsigned char outhead, outtail;					/* Tx buffer head & tail */
+	spinlock_t outlock;						/* Output fifo spinlock */
 
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */	
 	unsigned quirks;						/* Various quirks the device can pull on us */
