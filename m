Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWB0PYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWB0PYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWB0PYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:24:13 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:24713 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751447AbWB0PYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:24:12 -0500
Date: Mon, 27 Feb 2006 10:24:05 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -rt] buggy UART fix
Message-ID: <Pine.LNX.4.58.0602270954520.26564@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

I'm not sure if this is the correct fix, but it fixes a problem on one of
our boards.  The uart does't set the IIR register upon receiving an
interrupt for transmit.  Thus we get processes stuck waiting to send
data out.

This doesn't seem to be a problem on vanilla, and I'm not sure why.
Perhaps the scheduling doesn't ever let the transmit buffer get full? Well
I haven't look too much into the vanilla side.

This patch forces the processing of the interrupt even if the iir doesn't
show that there was an interrupt, iff the uart has been detected as buggy
(which our board's uart is ) and the interrupt hasn't already handled
it.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rt17/drivers/serial/8250.c
===================================================================
--- linux-2.6.15-rt17.orig/drivers/serial/8250.c	2006-02-27 10:20:31.000000000 -0500
+++ linux-2.6.15-rt17/drivers/serial/8250.c	2006-02-27 10:20:53.000000000 -0500
@@ -1344,6 +1344,17 @@ static irqreturn_t serial8250_interrupt(
 				"irq%d\n", irq);
 			break;
 		}
+		/*
+		 * If we have a buggy TX line, that doesn't
+		 * notify us via iir that we need to transmit
+		 * then force the call.
+		 */
+		if (!handled && (up->bugs & UART_BUG_TXEN)) {
+			spin_lock(&up->port.lock);
+			serial8250_handle_port(up, regs);
+			spin_unlock(&up->port.lock);
+		}
+
 	} while (l != end);

 	spin_unlock(&i->lock);
