Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVIOFUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVIOFUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVIOFUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:20:53 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:50597 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965214AbVIOFUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:20:52 -0400
Message-ID: <4356.10.124.102.246.1126761649.squirrel@dominion>
In-Reply-To: <01ac01c5b864$291f1370$dba0220a@CARREN>
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net>
    <20050907224911.H19199@flint.arm.linux.org.uk>
    <4394.10.124.102.246.1126165652.squirrel@dominion>
    <20050913091740.A8256@flint.arm.linux.org.uk>
    <00b601c5b858$8a8c4ad0$dba0220a@CARREN>
    <20050913125326.A14342@flint.arm.linux.org.uk>
    <20050913130229.B14342@flint.arm.linux.org.uk>
    <01ac01c5b864$291f1370$dba0220a@CARREN>
Date: Thu, 15 Sep 2005 14:20:49 +0900 (JST)
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch
 added to -mm tree
From: "Taku Izumi" <izumi2005@soft.fujitsu.com>
To: rmk+lkml@arm.linux.org.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hishii@soft.fujitsu.com
Reply-To: izumi2005@soft.fujitsu.com
User-Agent: SquirrelMail/1.4.5-1_rh4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050915142049_51394"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------=_20050915142049_51394
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit

Dear Russel:

I change my patch based on the result of discussion.

The change is as follows:

  - add a member to uart_8250_port structure in order to check if FIFO is
    enable or not.
  - use FIFO at serial8250_console_write function only when FIFO is enable.

I tested my patch on i386 and ia64 architecture.

signed-off-by: Taku Izumi <izumi2005@soft.fujitsu.com>

------=_20050915142049_51394
Content-Type: text/plain; name="serial.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="serial.patch"

diff -urNp linux-2.6.14-rc1.org/drivers/serial/8250.c linux-2.6.14-rc1/drivers/serial/8250.c
--- linux-2.6.14-rc1.org/drivers/serial/8250.c	2005-09-13 12:12:09.000000000 +0900
+++ linux-2.6.14-rc1/drivers/serial/8250.c	2005-09-15 09:38:46.000000000 +0900
@@ -128,6 +128,7 @@ struct uart_8250_port {
 	unsigned char		mcr_mask;	/* mask of user bits */
 	unsigned char		mcr_force;	/* mask of forced bits */
 	unsigned char		lsr_break_flag;
+	unsigned char		fcr;
 
 	/*
 	 * We provide a per-port pm hook.
@@ -332,6 +333,7 @@ static unsigned int serial_icr_read(stru
 static inline void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
+		p->fcr = 0;
 		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
 		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO |
 			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
@@ -1809,8 +1811,10 @@ serial8250_set_termios(struct uart_port 
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
 	 */
-	if (up->port.type == PORT_16750)
+	if (up->port.type == PORT_16750) {
 		serial_outp(up, UART_FCR, fcr);
+		up->fcr = fcr;
+	}
 
 	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
 	up->lcr = cval;					/* Save LCR */
@@ -1820,6 +1824,7 @@ serial8250_set_termios(struct uart_port 
 			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 		}
 		serial_outp(up, UART_FCR, fcr);		/* set fcr */
+		up->fcr = fcr;
 	}
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -2140,6 +2145,7 @@ serial8250_console_write(struct console 
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 	unsigned int ier;
 	int i;
+	int tx_loadsz;
 
 	/*
 	 *	First save the UER then disable the interrupts
@@ -2152,20 +2158,39 @@ serial8250_console_write(struct console 
 		serial_out(up, UART_IER, 0);
 
 	/*
+	 *	Check whether FIFO is enabled
+	 */ 
+	tx_loadsz = (up->fcr & UART_FCR_ENABLE_FIFO ? up->tx_loadsz : 1);
+	/*
 	 *	Now, do each character
 	 */
-	for (i = 0; i < count; i++, s++) {
-		wait_for_xmitr(up);
+	for (i = 0; i < count; ) {
+		int	fifo;
 
+		wait_for_xmitr(up);
+		fifo = tx_loadsz;
 		/*
-		 *	Send the character out.
+		 *	Send the character out using FIFO.
 		 *	If a LF, also do CR...
 		 */
-		serial_out(up, UART_TX, *s);
-		if (*s == 10) {
-			wait_for_xmitr(up);
-			serial_out(up, UART_TX, 13);
-		}
+		do {
+			serial_out(up, UART_TX, *s);
+			fifo--;
+			if (*s == 10) {
+				if (fifo > 0) {
+					serial_out(up, UART_TX, 13);
+					fifo--;
+				} else {
+					/* No room to add CR */
+					wait_for_xmitr(up);
+					fifo = tx_loadsz;
+					serial_out(up, UART_TX, 13);
+					fifo--;
+				}
+			}
+			i++;
+			s++;
+		} while (fifo > 0 && i < count);
 	}
 
 	/*

------=_20050915142049_51394--


