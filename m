Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUKIPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUKIPxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUKIPwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:52:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40398 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261562AbUKIPvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:51:08 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041109144723.C15570@flint.arm.linux.org.uk>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
	 <1099998926.15462.21.camel@localhost.localdomain>
	 <20041109132810.A15570@flint.arm.linux.org.uk>
	 <1100006241.15742.6.camel@localhost.localdomain>
	 <20041109144723.C15570@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100011669.16043.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 14:47:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-09 at 14:47, Russell King wrote:
> On Tue, Nov 09, 2004 at 01:17:22PM +0000, Alan Cox wrote:
> > So its broken, totally and utterly. Its the kind of undefined,
> > unserialized crap that I'm trying to get _OUT_ of the serial layer.
> 
> I think you mean the tty layer here - the tty layer is where most of

Out of the serial layer too. While the serial layer does stuff like call
line discipline functions from the wrong context and sick hacks like
calling functions out of tty layer workqueues its also involved.

Right now calls into the ldisc side are all sane (there are two corner
cases left that need the other side fixing). The calls into serial
driver side is still pending repair and also needs the flip buffers
fixing first.

> the serialisation problems remain, and the locking in the serial
> layer is mostly there to work around the tty layers deficiencies.
> 
> I would have liked to have rewritten the tty layer along the lines
> that Ted was suggesting, but that would've been far too much work
> for me to do alone.

I'm working on it. It would be helpful if the drivers/serial code would
use helpers and not dig in places it shouldnt so that the transition can
be cleaner.

Something like this for 8250.c - it fixes the sick hacks calling into
tty
workqueues, the deadlock on overrun and cleans up flip buffer whacking
to use the helper. The helpers handle the overrun case internally so
that cleans up some code, they also happen to be API's I think I can
preserve when updating while direct buffer whacking is probably a nono.

In general tty driver hacking folks should expect

- direct flip buffer poking to break
- flip buffer length checking to break (DMA cards and virtualised
machines want
  variable sized buffers)

so if they can move towards tty_insert_flip_char() they'll make life
easier down the line. I'll try and push a few more "fake" helpers as I
try and get the dynamic flip buffers into shape.

--- ../linux.vanilla-2.6.10rc1/drivers/serial/8250.c	2004-11-05 15:42:15.000000000 +0000
+++ drivers/serial/8250.c	2004-11-09 15:42:49.102511656 +0000
@@ -32,7 +32,7 @@
 #include <linux/serialP.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-
+#include <linux/tty_flip.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
@@ -978,16 +978,19 @@
 	struct tty_struct *tty = up->port.info->tty;
 	unsigned char ch, lsr = *status;
 	int max_count = 256;
+	char flag;
 
 	do {
+		/* The following is not allowed by the tty layer and
+		   unsafe. It should be fixed ASAP */
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
-			tty->flip.work.func((void *)tty);
-			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-				return; // if TTY_DONT_FLIP is set
+			if(tty->low_latency)
+				tty_flip_buffer_push(tty);
+			/* If this failed then we will throw away the
+			   bytes but must do so to clear interrupts */
 		}
 		ch = serial_inp(up, UART_RX);
-		*tty->flip.char_buf_ptr = ch;
-		*tty->flip.flag_buf_ptr = TTY_NORMAL;
+		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -1030,18 +1033,16 @@
 
 			if (lsr & UART_LSR_BI) {
 				DEBUG_INTR("handling break....");
-				*tty->flip.flag_buf_ptr = TTY_BREAK;
+				flag = TTY_BREAK;
 			} else if (lsr & UART_LSR_PE)
-				*tty->flip.flag_buf_ptr = TTY_PARITY;
+				flag = TTY_PARITY;
 			else if (lsr & UART_LSR_FE)
-				*tty->flip.flag_buf_ptr = TTY_FRAME;
+				flag = TTY_FRAME;
 		}
 		if (uart_handle_sysrq_char(&up->port, ch, regs))
 			goto ignore_char;
 		if ((lsr & up->port.ignore_status_mask) == 0) {
-			tty->flip.flag_buf_ptr++;
-			tty->flip.char_buf_ptr++;
-			tty->flip.count++;
+			tty_insert_flip_char(tty, ch, flag);
 		}
 		if ((lsr & UART_LSR_OE) &&
 		    tty->flip.count < TTY_FLIPBUF_SIZE) {
@@ -1050,10 +1051,7 @@
 			 * immediately, and doesn't affect the current
 			 * character.
 			 */
-			*tty->flip.flag_buf_ptr = TTY_OVERRUN;
-			tty->flip.flag_buf_ptr++;
-			tty->flip.char_buf_ptr++;
-			tty->flip.count++;
+			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
 		}
 	ignore_char:
 		lsr = serial_inp(up, UART_LSR);



