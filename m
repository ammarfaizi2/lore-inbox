Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUJWNa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUJWNa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUJWNa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:30:27 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:24403 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261173AbUJWNaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:30:24 -0400
Subject: Re: Linux 2.4.28-rc1
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041022185953.GA4886@logos.cnet>
References: <20041022185953.GA4886@logos.cnet>
Content-Type: text/plain
Message-Id: <1098538220.5960.2.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 23 Oct 2004 08:30:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 13:59, Marcelo Tosatti wrote:
> Here goes the first release candidate of v2.4.28.

Any chance of getting this in?

-- 
Paul Fulghum
paulkf@microgate.com

>From paulkf@microgate.com Fri Oct  8 13:20:56 2004
Subject: [PATCH] serial receive lockup fix
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>

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



