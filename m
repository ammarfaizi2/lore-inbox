Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbVIPMKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbVIPMKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 08:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbVIPMKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 08:10:55 -0400
Received: from smtp01.gra.de ([62.146.73.187]:54983 "EHLO minne.gra.de")
	by vger.kernel.org with ESMTP id S1161047AbVIPMKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 08:10:54 -0400
Date: Fri, 16 Sep 2005 14:11:16 +0200
From: Mathias Adam <a2@adamis.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250.c: Fix to make 16C950 UARTs work
Message-ID: <20050916121116.GA6195@adamis.de>
Mail-Followup-To: Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20050909013144.GA6660@adamis.de> <4320EC45.1080108@stesmi.com> <20050909024926.GA13643@adamis.de> <20050909111835.D17575@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909111835.D17575@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reworked the patch a little. Now it should enable both the 230400 and
the 460800 baud rates on any serial port which is using a 16C95x UART.
However as my 16C950 device is part of a Bluetooth dongle I couldn't
test the 460800 baud rate myself (I am able to set this rate with stty
though).
Please, could someone who owns such a UART try this out?
Any other comments?

Regards
Mathias



--- linux-2.6.13-org/drivers/serial/8250.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/serial/8250.c	2005-09-16 12:18:14.000000000 +0200
@@ -7,6 +7,9 @@
  *
  *  Copyright (C) 2001 Russell King.
  *
+ *  2005/09/16: Enabled higher baud rates for 16C95x.
+ *		(Mathias Adam <a2@adamis.de>)
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -1652,6 +1655,14 @@
 	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
 		 baud == (port->uartclk/8))
 		quot = 0x8002;
+	/*
+	 * For 16C950s UART_TCR is used in combination with divisor==1
+	 * to achieve baud rates up to baud_base*4.
+	 */
+	else if ((port->type == PORT_16C950) &&
+		 baud > (port->uartclk/16))
+		quot = 1;
+
 	else
 		quot = uart_get_divisor(port, baud);
 
@@ -1665,7 +1676,7 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, max_baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -1697,7 +1708,8 @@
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	max_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud); 
 	quot = serial8250_get_divisor(port, baud);
 
 	/*
@@ -1733,6 +1745,19 @@
 	 */
 	spin_lock_irqsave(&up->port.lock, flags);
 
+	/* 
+	 * 16C950 supports additional prescaler ratios between 1:16 and 1:4
+	 * thus increasing max baud rate to uartclk/4.
+	 */
+	if (up->port.type == PORT_16C950) {
+		if (baud == port->uartclk/4)
+			serial_icr_write(up, UART_TCR, 0x4);
+		else if (baud == port->uartclk/8)
+			serial_icr_write(up, UART_TCR, 0x8);
+		else
+			serial_icr_write(up, UART_TCR, 0);
+	}
+	
 	/*
 	 * Update the per-port timeout.
 	 */
