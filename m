Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUJHVDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUJHVDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJHVDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:03:15 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:9317 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264997AbUJHVDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:03:03 -0400
Subject: [PATCH] 8250 receive lockup fix
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097269371.2647.2.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 16:02:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lockup caused by 8520 serial driver not clearing
receive interrupt if flip buffer becomes full.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>


--- linux-2.6.9-rc3-mm3/drivers/serial/8250.c	2004-10-08 15:51:04.000000000 -0500
+++ bluedillo/drivers/serial/8250.c	2004-10-08 15:51:44.000000000 -0500
@@ -872,8 +872,19 @@ receive_chars(struct uart_8250_port *up,
 	do {
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
 			tty->flip.work.func((void *)tty);
-			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+				/* no room in flip buffer, discard rx FIFO contents to clear IRQ
+				 * *FIXME* Hardware with auto flow control
+				 * would benefit from leaving the data in the FIFO and
+				 * disabling the rx IRQ until space becomes available.
+				 */
+				do {
+					serial_inp(up, UART_RX);
+					up->port.icount.overrun++;
+					*status = serial_inp(up, UART_LSR);
+				} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 				return;	/* if TTY_DONT_FLIP is set */
+			}
 		}
 		ch = serial_inp(up, UART_RX);
 		*tty->flip.char_buf_ptr = ch;


