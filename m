Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbQLIObM>; Sat, 9 Dec 2000 09:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130849AbQLIObC>; Sat, 9 Dec 2000 09:31:02 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2052 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130188AbQLIOay>; Sat, 9 Dec 2000 09:30:54 -0500
Date: Sat, 9 Dec 2000 14:00:20 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [FIXED] Re: USB-related lockup in test12-pre5
In-Reply-To: <20001208200504.G15095@sventech.com>
Message-ID: <Pine.LNX.4.30.0012091349010.1122-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>EIP; c0270c21 <stext_lock+4e6d/8f50>   <=====
Trace; c01f488e <usb_submit_urb+1e/30>
Trace; ca8578be <[audio]usbout_completed+7e/c0>
Trace; c01ffc3e <process_urb+1de/230>
Trace; c01ffd49 <uhci_interrupt+b9/120>

1. process_urb() obtains the urb_list_lock.
2. Then calls urb->complete() which is audio.c::usbout_complete()
3. Which in turn calls usb_submit_urb()
4. Which calls uhci_submit_urb()
5. Which tries to obtain urb_list_lock --> BOOM!

As it seems that we were already able to drop the lock in process_urb()
and not worry about the consequences, I've just made it do so.

Index: drivers/usb/usb-uhci.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/usb/usb-uhci.c,v
retrieving revision 1.1.2.21
diff -u -r1.1.2.21 usb-uhci.c
--- drivers/usb/usb-uhci.c	2000/12/07 09:36:19	1.1.2.21
+++ drivers/usb/usb-uhci.c	2000/12/09 13:49:50
@@ -2626,14 +2626,14 @@
 			// Completion
 			if (urb->complete) {
 				urb->dev = NULL;
+				spin_unlock(&s->urb_list_lock);
 				urb->complete ((struct urb *) urb);
 				// Re-submit the URB if ring-linked
 				if (is_ring && (urb->status != -ENOENT) &&
!contains_killed) {
 					urb->dev=usb_dev;
-					spin_unlock(&s->urb_list_lock);
 					uhci_submit_urb (urb);
-					spin_lock(&s->urb_list_lock);
 				}
+				spin_lock(&s->urb_list_lock);
 			}

 			usb_dec_dev_use (usb_dev);

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
