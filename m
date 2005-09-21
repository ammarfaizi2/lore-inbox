Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVIUHLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVIUHLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 03:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVIUHLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 03:11:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13580 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751043AbVIUHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 03:11:22 -0400
Date: Wed, 21 Sep 2005 08:11:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pantelis Antoniou <pantelis@embeddedalley.com>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Au1x00 8250 uart support (Updated).
Message-ID: <20050921071111.GA12590@flint.arm.linux.org.uk>
Mail-Followup-To: Pantelis Antoniou <pantelis@embeddedalley.com>,
	linux-kernel@vger.kernel.org, cw@f00f.org,
	Pete Popov <ppopov@embeddedalley.com>,
	Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
References: <200509192340.10450.pantelis@embeddedalley.com> <20050920163748.GA6680@flint.arm.linux.org.uk> <200509202050.03979.pantelis@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509202050.03979.pantelis@embeddedalley.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 08:50:03PM +0300, Pantelis Antoniou wrote:
> @@ -251,9 +251,60 @@ static const struct serial8250_config ua
>  	},
>  };
>  
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +
> +/* Au1x00 UART hardware has a weird register layout */
> +static const u8 au_io_in_map[] = {
> +	[UART_RX]  = 0,
> +	[UART_IER] = 2,
> +	[UART_IIR] = 3,
> +	[UART_LCR] = 5,
> +	[UART_MCR] = 6,
> +	[UART_LSR] = 7,
> +	[UART_MSR] = 8,
> +};
> +
> +static const u8 au_io_out_map[] = {
> +	[UART_TX]  = 1,
> +	[UART_IER] = 2,
> +	[UART_FCR] = 4,
> +	[UART_LCR] = 5,
> +	[UART_MCR] = 6,
> +};
> +
> +/* sane hardware needs no mapping */
> +static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
> +{
> +	if (up->port.iotype != UPIO_AU)
> +		return offset;
> +	return au_io_in_map[offset];
> +}
> +
> +static inline int map_8250_out_reg(struct uart_8250_port *up, int offset)
> +{
> +	if (up->port.iotype != UPIO_AU)
> +		return offset;
> +	return au_io_out_map[offset];
> +}
> +
> +#else
> +
> +/* sane hardware needs no mapping */
> +static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
> +{
> +	return offset;
> +}
> +
> +static inline int map_8250_out_reg(struct uart_8250_port *up, int offset)
> +{
> +	return offset;
> +}
> +
> +#endif

I'm not sure this is any cleaner.  Maybe:

#define map_8250_in_reg(port,offset)	(offset)
#define map_8250_out_reg(port,offset)	(offset)

would be better for the null case?

> @@ -1774,7 +1847,7 @@ serial8250_set_termios(struct uart_port 
>  	 * CTS flow control flag and modem status interrupts
>  	 */
>  	up->ier &= ~UART_IER_MSI;
> -	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
> +	if (!(up->bugs & UART_BUG_NOMSR) && UART_ENABLE_MS(&up->port, termios->c_cflag))

This should probably be wrapped thusly:

	if (!(up->bugs & UART_BUG_NOMSR) &&
	    UART_ENABLE_MS(&up->port, termios->c_cflag))

> +static struct platform_device au1x00_device = {
> +	.name			= "serial8250",
> +	.id			= PLAT8250_DEV_AU1X00,
> +	.dev			= {
> +		.platform_data	= au1x00_data,
> +	},
> +};
> +
> +static int __init au1x00_init(void)
> +{
> +	int i;
> +	unsigned int uartclk;
> +
> +	/* get uart clock */
> +	uartclk = get_au1x00_uart_baud_base() * 16;
> +
> +	/* fill up uartclk */
> +	for (i = 0; au1x00_data[i].flags ; i++)
> +		au1x00_data[i].uartclk = uartclk;
> +
> +	return platform_device_register(&au1x00_device);
> +}
> +
> +static void __exit au1x00_exit(void)
> +{
> +	platform_device_unregister(&au1x00_device);
> +}
> +
> +module_init(au1x00_init);
> +module_exit(au1x00_exit);

This is also buggy - the problem this has is that although you're
unregistering the platform device, references can still remain after
the module has been unloaded.  This means you have two options:

1. never allow code with statically allocated platform devices to be
   modules.
2. use something like platform_device_register_simple() (which doesn't
   currently exist in a useful form for devices with platform data.)

> diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
> --- a/include/asm-mips/mach-au1x00/au1000.h
> +++ b/include/asm-mips/mach-au1x00/au1000.h
> @@ -906,6 +906,8 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
>  #define UART_BASE                 UART0_ADDR
>  #define UART_DEBUG_BASE           UART3_ADDR
>  
> +#ifdef CONFIG_SERIAL_AU1X00
> +
>  #define UART_RX		0	/* Receive buffer */
>  #define UART_TX		4	/* Transmit buffer */
>  #define UART_IER	8	/* Interrupt Enable Register */
> @@ -996,6 +998,8 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
>  #define UART_MSR_DCTS	0x01	/* Delta CTS */
>  #define UART_MSR_ANY_DELTA 0x0F	/* Any of the delta bits! */
>  
> +#endif
> +

Are these defines required anymore?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
