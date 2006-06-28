Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWF1IA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWF1IA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423209AbWF1IA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:00:28 -0400
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:21951 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1423208AbWF1IA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:00:26 -0400
Date: Wed, 28 Jun 2006 10:00:25 +0200
From: Ingo van Lil <inguin@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Serial: UART_BUG_TXEN race conditions
Message-ID: <20060628080025.GA22725@csn.tu-chemnitz.de>
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de> <20060626202536.GJ21272@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626202536.GJ21272@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.2 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 54eda96f4aacf00656d591f16f252d14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 09:25:36PM +0100, Russell King wrote:

> > 1. What if the IIR actually equals UART_IIR_THRI at that point? The
> >    read access will clear the interrupt condition and the workaround
> >    will effect the actual opposite of its intention: Neither
> >    serial8250_start_tx() nor the interrupt handler will start
> >    transmitting characters for the ring buffer.
> 
> Gah, looks like you're right - reading the IIR will clear the transmit
> pending interrupt, so we should probably just load the transmitter up
> with characters anyway if the TEMT bit is set.

Proposed patch. It's my first submission, I hope it meets this list's
standards.
The patch drops the buggy UART detection and always writes a first load
of characters into the transmitter FIFO if it's currently idle. This
should be fine for both well-behaved and broken UARTs.

Cheers,
Ingo


Signed-off-by: Ingo van Lil <inguin@gmx.de>
---

diff -u linux-2.6.17.1/drivers/serial/8250.c.orig linux-2.6.17.1/drivers/serial/8250.c
--- linux-2.6.17.1/drivers/serial/8250.c.orig	2006-06-27 21:37:41.000000000 +0200
+++ linux-2.6.17.1/drivers/serial/8250.c	2006-06-27 21:56:20.000000000 +0200
@@ -1119,18 +1119,13 @@
 static void serial8250_start_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned char lsr;
 
 	if (!(up->ier & UART_IER_THRI)) {
 		up->ier |= UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
-
-		if (up->bugs & UART_BUG_TXEN) {
-			unsigned char lsr, iir;
-			lsr = serial_in(up, UART_LSR);
-			iir = serial_in(up, UART_IIR);
-			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
-				transmit_chars(up);
-		}
+		lsr = serial_in(up, UART_LSR);
+		if (lsr & UART_LSR_TEMT) transmit_chars(up);
 	}
 
 	/*
@@ -1529,7 +1524,6 @@
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
-	unsigned char lsr, iir;
 	int retval;
 
 	up->capabilities = uart_config[up->port.type].flags;
@@ -1634,25 +1628,6 @@
 
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
 
-	/*
-	 * Do a quick test to see if we receive an
-	 * interrupt when we enable the TX irq.
-	 */
-	serial_outp(up, UART_IER, UART_IER_THRI);
-	lsr = serial_in(up, UART_LSR);
-	iir = serial_in(up, UART_IIR);
-	serial_outp(up, UART_IER, 0);
-
-	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
-		if (!(up->bugs & UART_BUG_TXEN)) {
-			up->bugs |= UART_BUG_TXEN;
-			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
-				 port->line);
-		}
-	} else {
-		up->bugs &= ~UART_BUG_TXEN;
-	}
-
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	/*
diff -u linux-2.6.17.1/drivers/serial/8250.h.orig linux-2.6.17.1/drivers/serial/8250.h
--- linux-2.6.17.1/drivers/serial/8250.h.orig	2006-06-27 21:46:13.000000000 +0200
+++ linux-2.6.17.1/drivers/serial/8250.h	2006-06-27 21:46:35.000000000 +0200
@@ -48,8 +48,7 @@
 #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
-#define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
-#define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
+#define UART_BUG_NOMSR	(1 << 1)	/* UART has buggy MSR status bits (Au1x00) */
 
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
