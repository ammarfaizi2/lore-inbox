Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWE3BeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWE3BeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWE3Bbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932095AbWE3Bbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:32 -0400
Date: Mon, 29 May 2006 18:35:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 36/61] lock validator: special locking: serial
Message-Id: <20060529183533.75381871.akpm@osdl.org>
In-Reply-To: <20060529212604.GJ3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212604.GJ3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:26:04 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (dual-initialized) locking code to the lock validator.
> Has no effect on non-lockdep kernels.
> 

This isn't an adequate description of the problem which this patch is
solving, IMO.

I _assume_ the validator is using the instruction pointer of the
spin_lock_init() site (or the file-n-line) as the lock's identifier.  Or
something?

> 
> Index: linux/drivers/serial/serial_core.c
> ===================================================================
> --- linux.orig/drivers/serial/serial_core.c
> +++ linux/drivers/serial/serial_core.c
> @@ -1849,6 +1849,12 @@ static const struct baud_rates baud_rate
>  	{      0, B38400  }
>  };
>  
> +/*
> + * lockdep: port->lock is initialized in two places, but we
> + *          want only one lock-type:
> + */
> +static struct lockdep_type_key port_lock_key;
> +
>  /**
>   *	uart_set_options - setup the serial console parameters
>   *	@port: pointer to the serial ports uart_port structure
> @@ -1869,7 +1875,7 @@ uart_set_options(struct uart_port *port,
>  	 * Ensure that the serial console lock is initialised
>  	 * early.
>  	 */
> -	spin_lock_init(&port->lock);
> +	spin_lock_init_key(&port->lock, &port_lock_key);
>  
>  	memset(&termios, 0, sizeof(struct termios));
>  
> @@ -2255,7 +2261,7 @@ int uart_add_one_port(struct uart_driver
>  	 * initialised.
>  	 */
>  	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
> -		spin_lock_init(&port->lock);
> +		spin_lock_init_key(&port->lock, &port_lock_key);
>  
>  	uart_configure_port(drv, state, port);
>  

Is there a cleaner way of doing this?

Perhaps write a new helper function which initialises the spinlock, call
that?  Rather than open-coding lockdep stuff?

