Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291430AbSAaXsR>; Thu, 31 Jan 2002 18:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291431AbSAaXsI>; Thu, 31 Jan 2002 18:48:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1284 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291430AbSAaXrz>; Thu, 31 Jan 2002 18:47:55 -0500
Date: Thu, 31 Jan 2002 23:47:48 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Stefani Seibold <stefani@seibold.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix for shared interrupt in serial i/o
Message-ID: <20020131234748.A1967@flint.arm.linux.org.uk>
In-Reply-To: <16WQOh-04YPE8C@fmrl10.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16WQOh-04YPE8C@fmrl10.sul.t-online.com>; from stefani@seibold.net on Fri, Feb 01, 2002 at 12:12:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:12:33AM +0100, Stefani Seibold wrote:
> the serial driver in linux seems to have some troubles with
> shared serial interrupts in all know linux kernel.

Could you describe your serial port setup please?

> I don't know, who is currently the maintainer of the serial driver.
> Can anybody can tell me ;-)

I suppose that'd be me, but I'm not intending to be responsible for
the existing drivers, just the new driver that (hopefully) will make
it into 2.5 soonish.

Note that anything I've left out of the notes below doesn't mean that
that part is ok...

> If you like the patch, please apply it. I can make also this patch for
> kernel 2.4 and 2.5 available, if somebody want apply it to this
> kernel tree.

There are several things in this patch that could be simplified.
You can check the IRQ status of any port by reading one register -
the interrupt reason register (UART_IIR) and checking one bit.
This means you shouldn't need to modify receive_chars(),
transmit_chars(), nor check_modem_status(), and you'll be more
efficient.

> -#ifdef SERIAL_DEBUG_INTR
> +#ifndef SERIAL_DEBUG_INTR
>  	printk("rs_interrupt(%d)...", irq);
>  #endif

If serial interrupt debugging is not selected, you want to send messages
to the console?

> +	for(info=IRQ_ports[irq];info;info=info->next_port)
> +		serial_out(info, UART_IER, 0);
> +
> +	info = IRQ_ports[irq];
> +

Hmm, if we're scanning all ports on this IRQ line anyway, then why not
do this step within the main loop?

> -	info->timeout = ((info->xmit_fifo_size*HZ*bits*quot) / baud_base);
> -	info->timeout += HZ/50;		/* Add .02 seconds of slop */
> +	info->timeout = ((info->xmit_fifo_size*HZ*bits+(baud_base/quot-1))*quot) / baud_base;

I don't think you described your reasoning behind this change, however it
does look overly complex.  Unfortunately, its a potential division by zero
bug (when quot = 1).

Lets simplify it a bit anyway:

  (fifosize*HZ*bits*quot) / baudbase + (baudbase / quot - 1) * (quot / baudbase)
  (fifosize*HZ*bits*quot) / baudbase + (baudbase * quot) / (baudbase * (quot - 1))
  (fifosize*HZ*bits*quot) / baudbase + quot / (quot - 1)

And n/(n-1) will be:

  n  n/(n-1)
  1  infinity
  2  2
>=3  1

We used to always add HZ/50 (which comes out as '2') for all causes.

> +
> +	if (info->x_char || 

'x_char' isn't anything to do with the transmit queue - its the XON/XOFF
1 byte buffer.  I don't think you explained the purpose of these changes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

