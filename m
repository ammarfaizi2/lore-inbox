Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945998AbWBOQC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945998AbWBOQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWBOQC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:02:57 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:56293
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1945998AbWBOQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:02:57 -0500
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Paul Fulghum <paulkf@microgate.com>
To: Kouji Toriatama <toriatama@inter7.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060215.221135.121135595.toriatama@inter7.jp>
References: <1139863919.3868.16.camel@amdx2.microgate.com>
	 <20060215.005753.74732581.toriatama@inter7.jp>
	 <1139937159.3189.4.camel@amdx2.microgate.com>
	 <20060215.221135.121135595.toriatama@inter7.jp>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 10:02:48 -0600
Message-Id: <1140019368.3119.12.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 22:11 +0900, Kouji Toriatama wrote:

> Are there any other tests I can do to pin down the problem?

Try the following patch, and report the syslog output.

This may be lost receive data due to full flip buffer.
2.6.9 would try processing rx data in the ISR if the
flip buffer was full. This violated locking requirements
and was changed to only process rx data in scheduled work.
This can slow the processing of data.

Also try using the setserial utility to set
the 'low_latency' option for the device. That should
operate the same as 2.6.9 (which can be dangerous).

--

The improved flip buffering code in 2.6.16-rc3
should also prevent any loss of data. If possible,
try 2.6.16-rc3.

Thanks,
Paul

--- linux-2.6.15/drivers/serial/8250.c	2006-01-02 21:21:10.000000000 -0600
+++ b/drivers/serial/8250.c	2006-02-15 09:52:26.000000000 -0600
@@ -1143,6 +1143,7 @@ receive_chars(struct uart_8250_port *up,
 		/* The following is not allowed by the tty layer and
 		   unsafe. It should be fixed ASAP */
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
+			printk("receive_chars:flip full:low_latency=%d\n", tty->low_latency);
 			if (tty->low_latency) {
 				spin_unlock(&up->port.lock);
 				tty_flip_buffer_push(tty);
@@ -1152,6 +1153,8 @@ receive_chars(struct uart_8250_port *up,
 			 * If this failed then we will throw away the
 			 * bytes but must do so to clear interrupts
 			 */
+			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+				printk("receive_chars:flip full:discard char\n");
 		}
 		ch = serial_inp(up, UART_RX);
 		flag = TTY_NORMAL;
@@ -1169,6 +1172,7 @@ receive_chars(struct uart_8250_port *up,
 
 		if (unlikely(lsr & (UART_LSR_BI | UART_LSR_PE |
 				    UART_LSR_FE | UART_LSR_OE))) {
+			printk("receive_chars:char error lsr=%02X\n", lsr);
 			/*
 			 * For statistics only
 			 */



