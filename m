Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWARMlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWARMlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWARMlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:41:15 -0500
Received: from sipsolutions.net ([66.160.135.76]:39693 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932449AbWARMlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:41:14 -0500
Subject: [PATCH] hci_usb: implement suspend/resume
From: Johannes Berg <johannes@sipsolutions.net>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Wed, 18 Jan 2006 00:21:24 +0100
Message-Id: <1137540084.4543.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements suspend/resume for the hci_usb bluetooth
driver by simply killing all outstanding urbs on suspend, and re-issuing
them on resume.

This allows me to actually use the internal bluetooth "dongle" in my
powerbook after suspend-to-ram without taking down all userland programs
(sdpd, ...) and the hci device and reloading the module.

Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.15.1.orig/drivers/bluetooth/hci_usb.c	2006-01-18 00:08:54.840000000 +0100
+++ linux-2.6.15.1/drivers/bluetooth/hci_usb.c	2006-01-18 00:06:35.080000000 +0100
@@ -1043,11 +1043,55 @@
 	hci_free_dev(hdev);
 }
 
+static int hci_usb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct hci_usb *husb = usb_get_intfdata(intf);
+	int i;
+	unsigned long flags;
+	if (!husb || intf == husb->isoc_iface)
+		return 0;
+	
+	for (i = 0; i < 4; i++) {
+		struct _urb_queue *q = &husb->pending_q[i];
+		struct _urb *_urb;
+		spin_lock_irqsave(&q->lock, flags);
+		list_for_each_entry(_urb, &q->head, list)
+			usb_kill_urb(&_urb->urb);
+		spin_unlock_irqrestore(&q->lock, flags);
+	}
+	return 0;
+}
+
+static int hci_usb_resume(struct usb_interface *intf)
+{
+	struct hci_usb *husb = usb_get_intfdata(intf);
+	int i, err;
+	unsigned long flags;
+	if (!husb || intf == husb->isoc_iface)
+		return 0;
+	
+	for (i = 0; i < 4; i++) {
+		struct _urb_queue *q = &husb->pending_q[i];
+		struct _urb *_urb;
+		spin_lock_irqsave(&q->lock, flags);
+		list_for_each_entry(_urb, &q->head, list) {
+			err = usb_submit_urb(&_urb->urb, GFP_ATOMIC);
+			if (err) break;
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+		if (err)
+			return -EIO;
+	}
+	return 0;
+}
+
 static struct usb_driver hci_usb_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "hci_usb",
 	.probe		= hci_usb_probe,
 	.disconnect	= hci_usb_disconnect,
+	.suspend	= hci_usb_suspend,
+	.resume		= hci_usb_resume,
 	.id_table	= bluetooth_ids,
 };
 


