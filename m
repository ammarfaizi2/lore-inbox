Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVEJTCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVEJTCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVEJTCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:02:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:16362 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261738AbVEJTCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:02:03 -0400
Date: Tue, 10 May 2005 21:05:54 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sf.net, Maxim Krasnyansky <maxk@qualcomm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: kill redundant NULL checks and casts before kfree
Message-ID: <Pine.LNX.4.62.0505102100150.2386@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please keep me on CC when replying)


There's no need to check for NULL before calling kfree() on a pointer, and 
since kfree() takes a void* argument there's no need to cast pointers to 
other types before passing them to kfree().
This patch cleans that up in drivers/bluetooth/

Please apply.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/bluetooth/bpa10x.c   |    7 ++-----
 drivers/bluetooth/hci_usb.c  |    6 ++----
 drivers/bluetooth/hci_vhci.c |    8 +++-----
 3 files changed, 7 insertions(+), 14 deletions(-)

diff -upr linux-2.6.12-rc3-mm3-orig/drivers/bluetooth/bpa10x.c linux-2.6.12-rc3-mm3/drivers/bluetooth/bpa10x.c
--- linux-2.6.12-rc3-mm3-orig/drivers/bluetooth/bpa10x.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/bluetooth/bpa10x.c	2005-05-10 20:53:56.000000000 +0200
@@ -367,11 +367,8 @@ static inline void bpa10x_free_urb(struc
 	if (!urb)
 		return;
 
-	if (urb->setup_packet)
-		kfree(urb->setup_packet);
-
-	if (urb->transfer_buffer)
-		kfree(urb->transfer_buffer);
+	kfree(urb->setup_packet);
+	kfree(urb->transfer_buffer);
 
 	usb_free_urb(urb);
 }
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/bluetooth/hci_usb.c linux-2.6.12-rc3-mm3/drivers/bluetooth/hci_usb.c
--- linux-2.6.12-rc3-mm3-orig/drivers/bluetooth/hci_usb.c	2005-04-30 18:24:53.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/bluetooth/hci_usb.c	2005-05-10 20:56:17.000000000 +0200
@@ -387,10 +387,8 @@ static void hci_usb_unlink_urbs(struct h
 			urb = &_urb->urb;
 			BT_DBG("%s freeing _urb %p type %d urb %p",
 					husb->hdev->name, _urb, _urb->type, urb);
-			if (urb->setup_packet)
-				kfree(urb->setup_packet);
-			if (urb->transfer_buffer)
-				kfree(urb->transfer_buffer);
+			kfree(urb->setup_packet);
+			kfree(urb->transfer_buffer);
 			_urb_free(_urb);
 		}
 
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/bluetooth/hci_vhci.c linux-2.6.12-rc3-mm3/drivers/bluetooth/hci_vhci.c
--- linux-2.6.12-rc3-mm3-orig/drivers/bluetooth/hci_vhci.c	2005-04-30 18:24:53.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/bluetooth/hci_vhci.c	2005-05-10 20:58:23.000000000 +0200
@@ -78,12 +78,10 @@ static int hci_vhci_close(struct hci_dev
 
 static void hci_vhci_destruct(struct hci_dev *hdev)
 {
-	struct hci_vhci_struct *vhci;
+	if (!hdev)
+		return;
 
-	if (!hdev) return;
-
-	vhci = (struct hci_vhci_struct *) hdev->driver_data;
-	kfree(vhci);
+	kfree(hdev->driver_data)
 }
 
 static int hci_vhci_send_frame(struct sk_buff *skb)



