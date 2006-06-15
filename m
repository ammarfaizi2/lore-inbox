Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031131AbWFOTAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031131AbWFOTAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031133AbWFOTAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:00:22 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:36287 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031131AbWFOTAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:00:20 -0400
Message-ID: <4491BC5A.3020306@oracle.com>
Date: Thu, 15 Jun 2006 13:00:26 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, marcel@holtmann.org, maxk@qualcomm.com
Subject: [Ubuntu PATCH] bluetooth/hci_usb: Fix failures for suspend/resume
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[UBUNTU:bluetooth] Fix failures for suspend/resume

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=58db2683478e24009dbae33ea76beafe47b356bb

Plus whitespace cleanups by Randy Dunlap.

Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 drivers/bluetooth/hci_usb.c |   57 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+)

--- linux-2617-rc6g7.orig/drivers/bluetooth/hci_usb.c
+++ linux-2617-rc6g7/drivers/bluetooth/hci_usb.c
@@ -1043,9 +1043,66 @@ static void hci_usb_disconnect(struct us
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
+
+	if (!husb || intf == husb->isoc_iface)
+		return 0;
+
+	for (i = 0; i < 4; i++) {
+		struct _urb_queue *q = &husb->pending_q[i];
+		struct _urb *_urb;
+		spin_lock_irqsave(&q->lock, flags);
+		list_for_each_entry(_urb, &q->head, list) {
+			err = usb_submit_urb(&_urb->urb, GFP_ATOMIC);
+			if (err)
+				break;
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
+	.suspend	= hci_usb_suspend,
+	.resume		= hci_usb_resume,
 	.disconnect	= hci_usb_disconnect,
 	.id_table	= bluetooth_ids,
 };



