Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbULPNXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbULPNXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbULPNWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:22:54 -0500
Received: from mail.mev.co.uk ([62.49.15.74]:7617 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S262670AbULPNR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:17:58 -0500
Message-ID: <41C18B00.1010009@mev.co.uk>
Date: Thu, 16 Dec 2004 13:17:52 +0000
From: Ian Abbott <abbotti@mev.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH 2.4] serial closing_wait and close_delay used from wrong data
 structure
Content-Type: multipart/mixed;
 boundary="------------080106090401040306090405"
X-OriginalArrivalTime: 16 Dec 2004 13:17:52.0689 (UTC) FILETIME=[A5DF2210:01C4E371]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106090401040306090405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcello,

Here's the split-off patch you requested.

In several drivers, the closing_wait and close_delay values are written 
to a struct serial_state by TIOCSSERIAL, but the values used in the 
close routine are read from a struct async_struct, with no code to 
transfer of values between the two structures.  This patch ignores the 
members in struct async_struct and uses the values from struct serial_state.

-- Ian.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

--------------080106090401040306090405
Content-Type: text/x-patch;
 name="serial-closing-wait-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-closing-wait-1.patch"

diff -urN linux-2.4.29-pre1/arch/ppc/8xx_io/uart.c linux-2.4.29-pre1-ia/arch/ppc/8xx_io/uart.c
--- linux-2.4.29-pre1/arch/ppc/8xx_io/uart.c	2003-11-28 18:26:19.000000000 +0000
+++ linux-2.4.29-pre1-ia/arch/ppc/8xx_io/uart.c	2004-12-16 12:24:24.000000000 +0000
@@ -1760,8 +1760,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1797,9 +1797,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/arch/ppc/cpm2_io/uart.c linux-2.4.29-pre1-ia/arch/ppc/cpm2_io/uart.c
--- linux-2.4.29-pre1/arch/ppc/cpm2_io/uart.c	2004-04-14 14:05:27.000000000 +0100
+++ linux-2.4.29-pre1-ia/arch/ppc/cpm2_io/uart.c	2004-12-16 12:25:41.000000000 +0000
@@ -1754,8 +1754,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1790,9 +1790,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/amiserial.c linux-2.4.29-pre1-ia/drivers/char/amiserial.c
--- linux-2.4.29-pre1/drivers/char/amiserial.c	2002-11-28 23:53:12.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/amiserial.c	2004-12-16 12:27:22.000000000 +0000
@@ -1581,8 +1581,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1614,9 +1614,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/au1x00-serial.c linux-2.4.29-pre1-ia/drivers/char/au1x00-serial.c
--- linux-2.4.29-pre1/drivers/char/au1x00-serial.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/au1x00-serial.c	2004-12-16 12:28:27.000000000 +0000
@@ -1948,8 +1948,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1976,9 +1976,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/serial.c linux-2.4.29-pre1-ia/drivers/char/serial.c
--- linux-2.4.29-pre1/drivers/char/serial.c	2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/serial.c	2004-12-16 12:35:23.000000000 +0000
@@ -2845,8 +2845,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -2873,9 +2873,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/serial_txx927.c linux-2.4.29-pre1-ia/drivers/char/serial_txx927.c
--- linux-2.4.29-pre1/drivers/char/serial_txx927.c	2002-08-03 01:39:43.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/serial_txx927.c	2004-12-16 12:36:38.000000000 +0000
@@ -1442,8 +1442,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1471,9 +1471,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/vac-serial.c linux-2.4.29-pre1-ia/drivers/char/vac-serial.c
--- linux-2.4.29-pre1/drivers/char/vac-serial.c	2004-02-18 13:36:31.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/vac-serial.c	2004-12-16 12:49:43.000000000 +0000
@@ -1699,8 +1699,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1727,9 +1727,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}

--------------080106090401040306090405--
