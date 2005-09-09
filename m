Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVIIOle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVIIOle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVIIOle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:41:34 -0400
Received: from smtp01.gra.de ([62.146.73.187]:14539 "EHLO minne.gra.de")
	by vger.kernel.org with ESMTP id S964945AbVIIOld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:41:33 -0400
Date: Fri, 9 Sep 2005 16:42:08 +0200
From: Mathias Adam <a2@adamis.de>
To: linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] 8250.c: Fix to make 16C950 UARTs work
Message-ID: <20050909144208.GA1993@adamis.de>
References: <20050909013144.GA6660@adamis.de> <4320EC45.1080108@stesmi.com> <20050909024926.GA13643@adamis.de> <20050909111835.D17575@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909111835.D17575@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Sep 09, 2005 at 04:49:27AM +0200, Mathias Adam wrote:
> > +	if (up->port.type == PORT_16C950) {
> > +		unsigned int baud_base = port->uartclk/16;
> 
> baud_base appears unused.

you're right, it's not necessary anymore. (New patch below)

> > +		if (baud <= port->uartclk/16)
> > +			serial_icr_write(up, UART_TCR, 0);
> > +		else if (baud <= port->uartclk/8) {
> > +			serial_icr_write(up, UART_TCR, 0x8);
> > +		} else if (baud <= port->uartclk/4) {
> > +			serial_icr_write(up, UART_TCR, 0x4);
> > +		} else
> > +			serial_icr_write(up, UART_TCR, 0);
> 
> baud can't be larger than port->uartclk/4 since you limited it above.

Those lines come from 2.4.29's drivers/char/serial.c (>= line 1686). I
left in the last "else" to have some fallback if uart_get_baud_rate()
would change its behaviour to something else (i.e. does allow baud to
be larger than max_baud). However this would lead to an incorrect baud
rate to be set anyway (as the maximum baud rate of 16C950 is uartclk/4),
so one could simply set the "/4" mode for everything larger than uartclk/8.

Btw, if you look at lines 1700-1701 of original 2.6.13's 8250.c:

    baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
    quot = serial8250_get_divisor(port, baud);

baud is limited to uartclk/16 here, but serial8250_get_divisor() tests
it for being uartclk/4 or uartclk/8...
I'm afraid that max_baud thing has to become somewhat more general, or
do I miss something?

Hmm and I don't get the point in the calculation of "quot" - is that
formula correct in every case? I'll look into that a little bit now.

Mathias Adam

PS: I'm now subscribed to the list.


--- linux-2.6.13-org/drivers/serial/8250.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/serial/8250.c	2005-09-09 15:33:23.000000000 +0200
@@ -1665,7 +1665,7 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, max_baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -1697,9 +1697,25 @@
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
+		if (baud <= port->uartclk/16)
+			serial_icr_write(up, UART_TCR, 0);
+		else if (baud <= port->uartclk/8) {
+			serial_icr_write(up, UART_TCR, 0x8);
+		} else
+			serial_icr_write(up, UART_TCR, 0x4);
+	}
+	
 	/*
 	 * Oxford Semi 952 rev B workaround
 	 */
