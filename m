Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFZWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFZWTF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFZWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:19:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18450 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261415AbVFZWSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:18:51 -0400
Date: Sun, 26 Jun 2005 23:18:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT:PATCH] 3/3: Disable OX950 transmitter for flow control
Message-ID: <20050626221848.GB5789@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk> <20050626221750.GA5789@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626221750.GA5789@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the transmitter whenever we want to prevent characters
being transmitted by flow control.  However, if we run out of
characters to send and want to only disable the TX interrupt,
allow that scenario.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Index: drivers/serial/8250.c
===================================================================
--- d1d56a4a3295f62a01fc06ffc764da474d2aa9b1/drivers/serial/8250.c  (mode:100644)
+++ uncommitted/drivers/serial/8250.c  (mode:100644)
@@ -1007,21 +1007,24 @@
 	up->port.irq = (irq > 0) ? irq : 0;
 }
 
+static inline void __stop_tx(struct uart_8250_port *p)
+{
+	if (p->ier & UART_IER_THRI) {
+		p->ier &= ~UART_IER_THRI;
+		serial_out(p, UART_IER, p->ier);
+	}
+}
+
 static void serial8250_stop_tx(struct uart_port *port, unsigned int tty_stop)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
-	if (up->ier & UART_IER_THRI) {
-		up->ier &= ~UART_IER_THRI;
-		serial_out(up, UART_IER, up->ier);
-	}
+	__stop_tx(up);
 
 	/*
-	 * We only do this from uart_stop - if we run out of
-	 * characters to send, we don't want to prevent the
-	 * FIFO from emptying.
+	 * We really want to stop the transmitter from sending.
 	 */
-	if (up->port.type == PORT_16C950 && tty_stop) {
+	if (up->port.type == PORT_16C950) {
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
@@ -1045,10 +1048,11 @@
 				transmit_chars(up);
 		}
 	}
+
 	/*
-	 * We only do this from uart_start
+	 * Re-enable the transmitter if we disabled it.
 	 */
-	if (tty_start && up->port.type == PORT_16C950) {
+	if (up->port.type == PORT_16C950 && up->acr & UART_ACR_TXDIS) {
 		up->acr &= ~UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
@@ -1169,7 +1173,7 @@
 		return;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial8250_stop_tx(&up->port, 0);
+		__stop_tx(up);
 		return;
 	}
 
@@ -1188,7 +1192,7 @@
 	DEBUG_INTR("THRE...");
 
 	if (uart_circ_empty(xmit))
-		serial8250_stop_tx(&up->port, 0);
+		__stop_tx(up);
 }
 
 static _INLINE_ void check_modem_status(struct uart_8250_port *up)
