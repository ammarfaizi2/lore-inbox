Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVFWU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVFWU5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVFWUzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:55:11 -0400
Received: from quark.didntduck.org ([69.55.226.66]:61617 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262703AbVFWUrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:47:41 -0400
Message-ID: <42BB2027.3090800@didntduck.org>
Date: Thu, 23 Jun 2005 16:48:39 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PATCH] Serial updates
References: <20050623193304.GA15536@dyn-67.arm.linux.org.uk>
In-Reply-To: <20050623193304.GA15536@dyn-67.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> This update changes the following files:
> 
>  drivers/serial/8250.c |   54 ++++++++++++++++++++++++++++++++++++++++----------
>  drivers/serial/8250.h |    3 ++
>  2 files changed, 47 insertions(+), 10 deletions(-)
> 
> through these changes:
> 
> From: Russell King: Thu Jun 23 15:05:41 BST 2005
> 	
> 	[PATCH] Serial: Mobility's 16550A ports need a helping hand
> 	
> 	The Mobility 16550A serial ports don't behave the same as standard
> 	16550A ports, and need a helping hand to get them going once the
> 	transmitter has drained and been disabled.
> 	
> 	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> From: Russell King: Thu Jun 23 10:43:04 BST 2005
> 	
> 	[PATCH] Serial: Convert 8250 revision-based bug fixes to bug bitmask
> 	
> 	For some 8250 port types, we used to check the type of the port, and
> 	then determine whether the chip revision means the device is buggy.
> 	Instead, introduce a bit array, and set the appropriate bit(s) when
> 	we discover a buggy device.
> 	
> 	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Index: drivers/serial/8250.c
> ===================================================================
> --- 06cba21e92755bf6b815221d5124ca0f9faf7985/drivers/serial/8250.c  (mode:100644)
> +++ ba48375ac5262a8587eb6237134ed0aa57e7174a/drivers/serial/8250.c  (mode:100644)
> @@ -132,9 +132,9 @@
>  	struct uart_port	port;
>  	struct timer_list	timer;		/* "no irq" timer */
>  	struct list_head	list;		/* ports on this IRQ */
> -	unsigned int		capabilities;	/* port capabilities */
> +	unsigned short		capabilities;	/* port capabilities */
> +	unsigned short		bugs;		/* port bugs */
>  	unsigned int		tx_loadsz;	/* transmit fifo load size */
> -	unsigned short		rev;
>  	unsigned char		acr;
>  	unsigned char		ier;
>  	unsigned char		lcr;
> @@ -560,7 +560,14 @@
>  	if (id1 == 0x16 && id2 == 0xC9 &&
>  	    (id3 == 0x50 || id3 == 0x52 || id3 == 0x54)) {
>  		up->port.type = PORT_16C950;
> -		up->rev = rev | (id3 << 8);
> +
> +		/*
> +		 * Enable work around for the Oxford Semiconductor 952 rev B
> +		 * chip which causes it to seriously miscalculate baud rates
> +		 * when DLL is 0.
> +		 */
> +		if (id3 == 0x52 && rev == 0x01)
> +			up->bugs |= UART_BUG_QUOT;
>  		return;
>  	}
>  	
> @@ -577,8 +584,6 @@
>  
>  	id2 = id1 >> 8;
>  	if (id2 == 0x10 || id2 == 0x12 || id2 == 0x14) {
> -		if (id2 == 0x10)
> -			up->rev = id1 & 255;
>  		up->port.type = PORT_16850;
>  		return;
>  	}
> @@ -809,6 +814,7 @@
>  //	save_flags(flags); cli();
>  
>  	up->capabilities = 0;
> +	up->bugs = 0;
>  
>  	if (!(up->port.flags & UPF_BUGGY_UART)) {
>  		/*
> @@ -1021,6 +1027,8 @@
>  	}
>  }
>  
> +static void transmit_chars(struct uart_8250_port *up);
> +
>  static void serial8250_start_tx(struct uart_port *port, unsigned int tty_start)
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
> @@ -1028,6 +1036,14 @@
>  	if (!(up->ier & UART_IER_THRI)) {
>  		up->ier |= UART_IER_THRI;
>  		serial_out(up, UART_IER, up->ier);
> +
> +		if (up->capabilities & UART_BUG_TXEN) {

Shouldn't this be up->bugs?

> +			unsigned char lsr, iir;
> +			lsr = serial_in(up, UART_LSR);
> +			iir = serial_in(up, UART_IIR);
> +			if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
> +				transmit_chars(up);
> +		}
>  	}
>  	/*
>  	 * We only do this from uart_start
> @@ -1433,6 +1449,7 @@
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
>  	unsigned long flags;
> +	unsigned char lsr, iir;
>  	int retval;
>  
>  	up->capabilities = uart_config[up->port.type].flags;
> @@ -1536,6 +1553,26 @@
>  			up->port.mctrl |= TIOCM_OUT2;
>  
>  	serial8250_set_mctrl(&up->port, up->port.mctrl);
> +
> +	/*
> +	 * Do a quick test to see if we receive an
> +	 * interrupt when we enable the TX irq.
> +	 */
> +	serial_outp(up, UART_IER, UART_IER_THRI);
> +	lsr = serial_in(up, UART_LSR);
> +	iir = serial_in(up, UART_IIR);
> +	serial_outp(up, UART_IER, 0);
> +
> +	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
> +		if (!(up->capabilities & UART_BUG_TXEN)) {
> +			up->capabilities |= UART_BUG_TXEN;
> +			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
> +				 port->line);
> +		}
> +	} else {
> +		up->capabilities &= ~UART_BUG_TXEN;

ditto

> +	}
> +
>  	spin_unlock_irqrestore(&up->port.lock, flags);
>  
>  	/*
> @@ -1677,12 +1714,9 @@
>  	quot = serial8250_get_divisor(port, baud);
>  
>  	/*
> -	 * Work around a bug in the Oxford Semiconductor 952 rev B
> -	 * chip which causes it to seriously miscalculate baud rates
> -	 * when DLL is 0.
> +	 * Oxford Semi 952 rev B workaround
>  	 */
> -	if ((quot & 0xff) == 0 && up->port.type == PORT_16C950 &&
> -	    up->rev == 0x5201)
> +	if (up->bugs & UART_BUG_QUOT && (quot & 0xff) == 0)
>  		quot ++;
>  
>  	if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
> Index: drivers/serial/8250.h
> ===================================================================
> --- 06cba21e92755bf6b815221d5124ca0f9faf7985/drivers/serial/8250.h  (mode:100644)
> +++ ba48375ac5262a8587eb6237134ed0aa57e7174a/drivers/serial/8250.h  (mode:100644)
> @@ -51,6 +51,9 @@
>  #define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
>  #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
>  
> +#define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
> +#define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> +
>  #if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
>  #define _INLINE_ inline
>  #else
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

