Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVDKVwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVDKVwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDKVwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:52:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:3533 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261931AbVDKVwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:52:41 -0400
Date: Mon, 11 Apr 2005 23:55:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Thomas Sailer <sailer@ife.ee.ethz.ch>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] usb: kfree() cleanups in drivers/usb/core/devio.c
Message-ID: <Pine.LNX.4.62.0504112350160.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for NULL before calling kfree() is redundant. This patch removes 
these redundant checks and also makes a few tiny whitespace changes.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 devio.c |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/drivers/usb/core/devio.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/core/devio.c	2005-04-11 23:49:41.000000000 +0200
@@ -213,12 +213,10 @@ static struct async *alloc_async(unsigne
 
 static void free_async(struct async *as)
 {
-        if (as->urb->transfer_buffer)
-                kfree(as->urb->transfer_buffer);
-        if (as->urb->setup_packet)
-                kfree(as->urb->setup_packet);
+	kfree(as->urb->transfer_buffer);
+	kfree(as->urb->setup_packet);
 	usb_free_urb(as->urb);
-        kfree(as);
+	kfree(as);
 }
 
 static inline void async_newpending(struct async *as)
@@ -938,17 +936,13 @@ static int proc_do_submiturb(struct dev_
 		return -EINVAL;
 	}
 	if (!(as = alloc_async(uurb->number_of_packets))) {
-		if (isopkt)
-			kfree(isopkt);
-		if (dr)
-			kfree(dr);
+		kfree(isopkt);
+		kfree(dr);
 		return -ENOMEM;
 	}
 	if (!(as->urb->transfer_buffer = kmalloc(uurb->buffer_length, GFP_KERNEL))) {
-		if (isopkt)
-			kfree(isopkt);
-		if (dr)
-			kfree(dr);
+		kfree(isopkt);
+		kfree(dr);
 		free_async(as);
 		return -ENOMEM;
 	}
@@ -967,8 +961,7 @@ static int proc_do_submiturb(struct dev_
 		as->urb->iso_frame_desc[u].length = isopkt[u].length;
 		totlen += isopkt[u].length;
 	}
-	if (isopkt)
-		kfree(isopkt);
+	kfree(isopkt);
 	as->ps = ps;
         as->userurb = arg;
 	if (uurb->endpoint & USB_DIR_IN)
@@ -1237,7 +1230,7 @@ static int proc_ioctl (struct dev_state 
 			return -ENOMEM;
 		if ((_IOC_DIR(ctrl.ioctl_code) & _IOC_WRITE)) {
 			if (copy_from_user (buf, ctrl.data, size)) {
-				kfree (buf);
+				kfree(buf);
 				return -EFAULT;
 			}
 		} else {
@@ -1246,8 +1239,7 @@ static int proc_ioctl (struct dev_state 
 	}
 
 	if (!connected(ps->dev)) {
-		if (buf)
-			kfree(buf);
+		kfree(buf);
 		return -ENODEV;
 	}
 
@@ -1309,8 +1301,8 @@ static int proc_ioctl (struct dev_state 
 			&& size > 0
 			&& copy_to_user (ctrl.data, buf, size) != 0)
 		retval = -EFAULT;
-	if (buf != NULL)
-		kfree (buf);
+
+	kfree(buf);
 	return retval;
 }
 



