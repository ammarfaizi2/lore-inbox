Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932914AbWJIQAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWJIQAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWJIQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:00:17 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:4019 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932914AbWJIQAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:00:16 -0400
Date: Mon, 9 Oct 2006 18:00:00 +0200
Message-id: <3244545353454@muni.cz>
Subject: [PATCH 2/3] Char: mxser_new, reverse if-else-paths patch
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
X-Muni-Spam-TestIP: 147.251.51.201
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, reverse if-else-paths patch

This patch was intorduced in mxser to 1.9.1 conversion, but causes endless
sleep in tcdrain userspace call.
Thanks to Sergei Organov <osv@javad.com> for testing and pointing this out.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 9c1c1abbe9e875e258bb238b74077d002414c950
tree 4a734348f557a63cea50b061d9aa5b3d4d13d06c
parent e48623373bf13133bf9b76e54bc64f3ab5b46517
author Jiri Slaby <jirislaby@gmail.com> Mon, 09 Oct 2006 14:57:03 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Mon, 09 Oct 2006 14:57:03 +0200

 drivers/char/mxser_new.c |   27 +++++++--------------------
 1 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 28c41a6..08ad269 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -1218,12 +1218,7 @@ static int mxser_write_room(struct tty_s
 static int mxser_chars_in_buffer(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	int len = info->xmit_cnt;
-
-	if (!(inb(info->ioaddr + UART_LSR) & UART_LSR_THRE))
-		len++;
-
-	return len;
+	return info->xmit_cnt;
 }
 
 static void mxser_flush_buffer(struct tty_struct *tty)
@@ -1953,7 +1948,7 @@ static void mxser_stoprx(struct tty_stru
 		if (info->board->chip_flag) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
 			outb(info->IER, info->ioaddr + UART_IER);
-		} else if (!(info->flags & ASYNC_CLOSING)) {
+		} else {
 			info->x_char = STOP_CHAR(tty);
 			outb(0, info->ioaddr + UART_IER);
 			info->IER |= UART_IER_THRI;
@@ -1990,7 +1985,7 @@ static void mxser_unthrottle(struct tty_
 			if (info->board->chip_flag) {
 				info->IER |= MOXA_MUST_RECV_ISR;
 				outb(info->IER, info->ioaddr + UART_IER);
-			} else if (!(info->flags & ASYNC_CLOSING)) {
+			} else {
 				info->x_char = START_CHAR(tty);
 				outb(0, info->ioaddr + UART_IER);
 				info->IER |= UART_IER_THRI;
@@ -2265,10 +2260,8 @@ static void mxser_receive_chars(struct m
 					flag = TTY_OVERRUN;
 /* added by casper 1/11/2000 */
 					port->icount.overrun++;
-				} else
-					flags = TTY_BREAK;
-			} else
-				flags = 0;
+				}
+			}
 			tty_insert_flip_char(tty, ch, flag);
 			cnt++;
 			if (cnt >= recv_room) {
@@ -2324,14 +2317,8 @@ static void mxser_transmit_chars(struct 
 	if (port->xmit_buf == 0)
 		goto unlock;
 
-	if (port->xmit_cnt == 0) {
-		if (port->xmit_cnt < WAKEUP_CHARS) { /* XXX what's this for?? */
-			set_bit(MXSER_EVENT_TXLOW, &port->event);
-			schedule_work(&port->tqueue);
-		}
-		goto unlock;
-	}
-	if (port->tty->stopped || (port->tty->hw_stopped &&
+	if ((port->xmit_cnt <= 0) || port->tty->stopped ||
+			(port->tty->hw_stopped &&
 			(port->type != PORT_16550A) &&
 			(!port->board->chip_flag))) {
 		port->IER &= ~UART_IER_THRI;
