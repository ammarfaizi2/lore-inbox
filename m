Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUJHTNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUJHTNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUJHTJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 15:09:46 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:4700 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270083AbUJHSU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:20:59 -0400
Subject: [PATCH] serial receive lockup fix
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097259655.1475.3.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 13:20:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lockup caused by serial driver not clearing
receive interrupt if flip buffer becomes full.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>



--- a/drivers/char/serial.c	2004-09-29 09:08:35.000000000 -0500
+++ b/drivers/char/serial.c	2004-09-29 09:09:07.000000000 -0500
@@ -573,8 +573,19 @@
 	do {
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
 			tty->flip.tqueue.routine((void *) tty);
-			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+				/* no room in flip buffer, discard rx FIFO contents to clear IRQ
+				 * *FIXME* Hardware with auto flow control
+				 * would benefit from leaving the data in the FIFO and
+				 * disabling the rx IRQ until space becomes available.
+				 */
+				do {
+					serial_inp(info, UART_RX);
+					icount->overrun++;
+					*status = serial_inp(info, UART_LSR);
+				} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 				return;		// if TTY_DONT_FLIP is set
+			}
 		}
 		ch = serial_inp(info, UART_RX);
 		*tty->flip.char_buf_ptr = ch;


