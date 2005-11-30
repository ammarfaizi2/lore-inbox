Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVK3NEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVK3NEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVK3NEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:04:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42258 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751207AbVK3NEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:04:35 -0500
Date: Wed, 30 Nov 2005 13:04:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ssant@in.ibm.com
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051130130429.GB25032@flint.arm.linux.org.uk>
Mail-Followup-To: Sachin Sant <sachinp@in.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, ssant@in.ibm.com
References: <438D8A3A.9030400@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438D8A3A.9030400@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 04:47:14PM +0530, Sachin Sant wrote:
> The following patch will allow a user to use sysrq keys over a serial 
> console using the ctrl-o key sequence. This is similar to functionality 
> provided by the hvc console drivers on PPC boxes.

Several problems:
1. ^O is normally the "flush" control code, for discarding unsent output.
2. ^O might be inadvertantly received due to a connected PC trying to
   auto-detect connected devices.
3. see review below.

> diff -Naurp linux-2.6.14.3/drivers/serial/8250.c linux-2.6.14.3-new/drivers/serial/8250.c
> --- linux-2.6.14.3/drivers/serial/8250.c	2005-11-11 11:03:12.000000000 +0530
> +++ linux-2.6.14.3-new/drivers/serial/8250.c	2005-11-17 15:12:42.000000000 +0530
> @@ -1084,6 +1084,23 @@ receive_chars(struct uart_8250_port *up,
>  			 */
>  		}
>  		ch = serial_inp(up, UART_RX);
> +
> +#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
> +		/* Handle the SysRq ^O Hack */
> +		if (ch == '\x0f') {
> +			up->port.sysrq = jiffies + HZ*5;

Why are you doing this and not using uart_handle_break()?

Do you realise that this enables sysrq support for _any_ 8250 serial
port, be it console or not?

> +			goto ignore_char; 
> +		}
> +		if (up->port.sysrq) {
> +			int swallow;
> +			spin_unlock(&up->port.lock);
> +			swallow = uart_handle_sysrq_char(&up->port, ch, regs);
> +			spin_lock(&up->port.lock);

We don't drop the lock when calling uart_handle_sysrq_char() further
down in this function.  Why is this needed?  Also, why is this needed
to be duplicated?

> +			if (swallow)
> +				goto ignore_char;
> +		}
> +#endif /* CONFIG_MAGIC_SYSRQ && CONFIG_SERIAL_CORE_CONSOLE */
> +
>  		flag = TTY_NORMAL;
>  		up->port.icount.rx++;
>  

Sorry, NACK.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
