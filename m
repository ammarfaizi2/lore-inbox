Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVIIKSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVIIKSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVIIKSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:18:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20499 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030217AbVIIKSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:18:39 -0400
Date: Fri, 9 Sep 2005 11:18:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mathias Adam <a2@adamis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250.c: Fix to make 16C950 UARTs work
Message-ID: <20050909111835.D17575@flint.arm.linux.org.uk>
Mail-Followup-To: Mathias Adam <a2@adamis.de>, linux-kernel@vger.kernel.org
References: <20050909013144.GA6660@adamis.de> <4320EC45.1080108@stesmi.com> <20050909024926.GA13643@adamis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050909024926.GA13643@adamis.de>; from a2@adamis.de on Fri, Sep 09, 2005 at 04:49:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of comments - see below.

On Fri, Sep 09, 2005 at 04:49:27AM +0200, Mathias Adam wrote:
> --- linux-2.6.13-org/drivers/serial/8250.c	2005-08-29 01:41:01.000000000 +0200
> +++ linux-2.6.13/drivers/serial/8250.c	2005-09-09 02:16:49.000000000 +0200
> @@ -1665,7 +1665,7 @@
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
>  	unsigned char cval, fcr = 0;
>  	unsigned long flags;
> -	unsigned int baud, quot;
> +	unsigned int baud, quot, max_baud;
>  
>  	switch (termios->c_cflag & CSIZE) {
>  	case CS5:
> @@ -1697,9 +1697,28 @@
>  	/*
>  	 * Ask the core to calculate the divisor for us.
>  	 */
> -	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
> +	max_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
> +	baud = uart_get_baud_rate(port, termios, old, 0, max_baud); 
>  	quot = serial8250_get_divisor(port, baud);
>  
> +	/* 
> +	 * 16C950 supports additional prescaler ratios between 1:16 and 1:4
> +	 * thus increasing max baud rate to uartclk/4. The following was taken
> +	 * from kernel 2.4 by Mathias Adam <a2@adamis.de> to make the Socket
> +	 * Bluetooth CF Card work under 2.6.13.
> +	 */
> +	if (up->port.type == PORT_16C950) {
> +		unsigned int baud_base = port->uartclk/16;

baud_base appears unused.

> +		if (baud <= port->uartclk/16)
> +			serial_icr_write(up, UART_TCR, 0);
> +		else if (baud <= port->uartclk/8) {
> +			serial_icr_write(up, UART_TCR, 0x8);
> +		} else if (baud <= port->uartclk/4) {
> +			serial_icr_write(up, UART_TCR, 0x4);
> +		} else
> +			serial_icr_write(up, UART_TCR, 0);

baud can't be larger than port->uartclk/4 since you limited it above.

> +	}
> +	
>  	/*
>  	 * Oxford Semi 952 rev B workaround
>  	 */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
