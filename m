Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268436AbUI2OSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268436AbUI2OSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUI2OQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:16:22 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:29784 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268483AbUI2ONm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:13:42 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <200409291509.39187.roland.cassebohm@visionsystems.de>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <1096409562.14082.53.camel@localhost.localdomain>
	 <1096420364.6003.29.camel@at2.pipehead.org>
	 <200409291509.39187.roland.cassebohm@visionsystems.de>
Content-Type: text/plain
Message-Id: <1096467213.1964.9.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 09:13:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is Roland's change in patch form with added comment.
(against 2.4.28-pre3)

Roland: can you test this?

All: Comments?

-- 
Paul Fulghum
paulkf@microgate.com

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


