Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVIIBb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVIIBb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIIBb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:31:26 -0400
Received: from smtp01.gra.de ([62.146.73.187]:18654 "EHLO minne.gra.de")
	by vger.kernel.org with ESMTP id S965224AbVIIBb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:31:26 -0400
Date: Fri, 9 Sep 2005 03:31:45 +0200
From: Mathias Adam <a2@adamis.de>
To: linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: [PATCH] 8250.c: Fix to make 16C950 UARTs work
Message-ID: <20050909013144.GA6660@adamis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently serial8250_set_termios() refuses to program a baud rate larger
than uartclk/16. However the 16C950 supports baud rates up to uartclk/4.
This worked already with Linux 2.4 so the biggest part of this patch was
simply taken from there and adapted to 2.6.

I needed this to get a Socket Bluetooth CF Card to work with BlueZ under
2.6 (the card did work under 2.4 already).

I posted the patch a while ago on the BlueZ mailing list and got reports
that it works as it should for a number of people so one could consider
including it into the standard kernel - opinions?

Please CC me as I'm not subscribed to the list.

Mathias Adam


--- linux-2.6.13-org/drivers/serial/8250.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/serial/8250.c	2005-09-09 02:16:49.000000000 +0200
@@ -1665,7 +1665,7 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, max_baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -1697,9 +1697,28 @@
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	MAX_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud); 
 	quot = serial8250_get_divisor(port, baud);
 
+	/* 
+	 * 16C950 supports additional prescaler ratios between 1:16 and 1:4
+	 * thus increasing max baud rate to uartclk/4. The following was taken
+	 * from kernel 2.4 by Mathias Adam <a2@adamis.de> to make the Socket
+	 * Bluetooth CF Card work under 2.6.13.
+	 */
+	if (up->port.type == PORT_16C950) {
+		unsigned int baud_base = port->uartclk/16;
+		if (baud <= port->uartclk/16)
+			serial_icr_write(up, UART_TCR, 0);
+		else if (baud <= port->uartclk/8) {
+			serial_icr_write(up, UART_TCR, 0x8);
+		} else if (baud <= port->uartclk/4) {
+			serial_icr_write(up, UART_TCR, 0x4);
+		} else
+			serial_icr_write(up, UART_TCR, 0);
+	}
+	
 	/*
 	 * Oxford Semi 952 rev B workaround
 	 */
