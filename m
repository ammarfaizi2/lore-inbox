Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVIFOSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVIFOSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 10:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVIFOSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 10:18:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21450 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964850AbVIFOR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 10:17:59 -0400
Subject: PATCH: USB white heat update for new tty buffers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 15:42:34 +0100
Message-Id: <1126017754.22131.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This got missed originally as it is marked BROKEN_ON_SMP (I can't see
why however). Updated and compile tested. I don't have hardware

Signed-off-by: Alan Cox <alan@redhat.com>

--- ../linux.vanilla-2.6.13-rc6-mm2/drivers/usb/serial/whiteheat.c	2005-08-25 17:04:32.000000000 +0100
+++ drivers/usb/serial/whiteheat.c	2005-09-06 14:50:38.000000000 +0100
@@ -1430,7 +1430,9 @@
 		urb = wrap->urb;
 
 		if (tty && urb->actual_length) {
-			if (urb->actual_length > TTY_FLIPBUF_SIZE - tty->flip.count) {
+			int len = tty_buffer_request_room(tty, urb->actual_length);
+			/* This stuff can go away now I suspect */
+			if (unlikely(len < urb->actual_length)) {
 				spin_lock_irqsave(&info->lock, flags);
 				list_add(tmp, &info->rx_urb_q);
 				spin_unlock_irqrestore(&info->lock, flags);
@@ -1438,11 +1440,8 @@
 				schedule_work(&info->rx_work);
 				return;
 			}
-
-			memcpy(tty->flip.char_buf_ptr, urb->transfer_buffer, urb->actual_length);
-			tty->flip.char_buf_ptr += urb->actual_length;
-			tty->flip.count += urb->actual_length;
-			sent += urb->actual_length;
+			tty_insert_flip_string(tty, urb->transfer_buffer, len);
+			sent += len;
 		}
 
 		urb->dev = port->serial->dev;

