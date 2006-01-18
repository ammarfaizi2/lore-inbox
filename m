Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWARSjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWARSjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWARSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:39:48 -0500
Received: from sipsolutions.net ([66.160.135.76]:42758 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1030258AbWARSjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:39:48 -0500
Subject: Re: [PATCH] hci_usb: implement suspend/resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <1137589998.27515.8.camel@localhost>
References: <1137540084.4543.15.camel@localhost>
	 <1137589998.27515.8.camel@localhost>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 17:38:43 +0100
Message-Id: <1137602323.4543.29.camel@localhost>
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

--- linux-2.6.git.orig/drivers/bluetooth/hci_usb.c
+++ linux-2.6.git/drivers/bluetooth/hci_usb.c
@@ -1043,10 +1043,65 @@
 	hci_free_dev(hdev);
 }
 
+static int hci_usb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct hci_usb *husb = usb_get_intfdata(intf);
+	int i;
+	unsigned long flags;
+	struct list_head killed;
+
+	if (!husb || intf == husb->isoc_iface)
+		return 0;
+
+	INIT_LIST_HEAD(&killed);
+
+	for (i = 0; i < 4; i++) {
+		struct _urb_queue *q = &husb->pending_q[i];
+		struct _urb *_urb, *_tmp;
+		while ((_urb = _urb_dequeue(q))) {
+			/* reset queue since _urb_dequeue sets it to NULL */
+			_urb->queue = q;
+			usb_kill_urb(&_urb->urb);
+			list_add(&_urb->list, &killed);
+		}
+		spin_lock_irqsave(&q->lock, flags);
+		list_for_each_entry_safe(_urb, _tmp, &killed, list) {
+			list_move_tail(&_urb->list, &q->head);
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+	}
+	return 0;
+}
+
+static int hci_usb_resume(struct usb_interface *intf)
+{
+	struct hci_usb *husb = usb_get_intfdata(intf);
+	int i, err = 0;
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
 	.name		= "hci_usb",
 	.probe		= hci_usb_probe,
 	.disconnect	= hci_usb_disconnect,
+	.suspend	= hci_usb_suspend,
+	.resume		= hci_usb_resume,
 	.id_table	= bluetooth_ids,
 };
 


