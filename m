Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbVIICsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbVIICsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbVIICsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:48:53 -0400
Received: from smtp01.gra.de ([62.146.73.187]:36225 "EHLO minne.gra.de")
	by vger.kernel.org with ESMTP id S965243AbVIICsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:48:52 -0400
Date: Fri, 9 Sep 2005 04:49:27 +0200
From: Mathias Adam <a2@adamis.de>
To: linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] 8250.c: Fix to make 16C950 UARTs work
Message-ID: <20050909024926.GA13643@adamis.de>
References: <20050909013144.GA6660@adamis.de> <4320EC45.1080108@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4320EC45.1080108@stesmi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Mathias Adam wrote:
> > Currently serial8250_set_termios() refuses to program a baud rate larger
> > than uartclk/16. However the 16C950 supports baud rates up to uartclk/4.
> > This worked already with Linux 2.4 so the biggest part of this patch was
> > simply taken from there and adapted to 2.6.
> > -	unsigned int baud, quot;
> > +	unsigned int baud, quot, max_baud;
>                                ^^^^^^^^
> > -	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
> > +	MAX_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
>       ^^^^^^^^
> 
> Did you even compile test this?

Oops, I really really wonder how THIS could have happened as I just attached
my existing patch file (which was and still is correct) without touching
it - at least that's what I thought...  Sorry!


Mathias Adam

I hope everything's alright this time:

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
+	max_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
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
