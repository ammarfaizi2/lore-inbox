Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVKFIoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVKFIoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVKFIoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:44:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60428 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932292AbVKFIod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:44:33 -0500
Date: Sun, 6 Nov 2005 08:44:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pantelis Antoniou <pantelis@embeddedalley.com>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org,
       Pete Popov <ppopov@embeddedalley.com>,
       Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Au1x00 8250 uart support (Updated - take #4).
Message-ID: <20051106084424.GC25134@flint.arm.linux.org.uk>
Mail-Followup-To: Pantelis Antoniou <pantelis@embeddedalley.com>,
	linux-kernel@vger.kernel.org, cw@f00f.org,
	Pete Popov <ppopov@embeddedalley.com>,
	Matt Porter <mporter@embeddedalley.com>, ralf@linux-mips.org
References: <200509192340.10450.pantelis@embeddedalley.com> <200509211914.10460.pantelis@embeddedalley.com> <20050921191737.GA13246@flint.arm.linux.org.uk> <200509222211.22674.pantelis@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509222211.22674.pantelis@embeddedalley.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 10:11:21PM +0300, Pantelis Antoniou wrote:
> Once more, with the MEM32 chunks out.
> 
> Regards
> 
> Pantelis

Do you have a description and sign-off for this patch?


> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -251,9 +251,53 @@ static const struct serial8250_config ua
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
> +#define map_8250_in_reg(up, offset) (offset)
> +#define map_8250_out_reg(up, offset) (offset)
> +
> +#endif
> +
>  static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
>  {
> -	offset <<= up->port.regshift;
> +	offset = map_8250_in_reg(up, offset) << up->port.regshift;
>  
>  	switch (up->port.iotype) {
>  	case UPIO_HUB6:
> @@ -266,6 +310,11 @@ static _INLINE_ unsigned int serial_in(s
>  	case UPIO_MEM32:
>  		return readl(up->port.membase + offset);
>  
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +	case UPIO_AU:
> +		return __raw_readl(up->port.membase + offset);
> +#endif
> +
>  	default:
>  		return inb(up->port.iobase + offset);
>  	}
> @@ -274,7 +323,7 @@ static _INLINE_ unsigned int serial_in(s
>  static _INLINE_ void
>  serial_out(struct uart_8250_port *up, int offset, int value)
>  {
> -	offset <<= up->port.regshift;
> +	offset = map_8250_out_reg(up, offset) << up->port.regshift;
>  
>  	switch (up->port.iotype) {
>  	case UPIO_HUB6:
> @@ -290,6 +339,12 @@ serial_out(struct uart_8250_port *up, in
>  		writel(value, up->port.membase + offset);
>  		break;
>  
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +	case UPIO_AU:
> +		__raw_writel(value, up->port.membase + offset);
> +		break;
> +#endif
> +
>  	default:
>  		outb(value, up->port.iobase + offset);
>  	}
> @@ -910,6 +965,13 @@ static void autoconfig(struct uart_8250_
>  		}
>  	}
>  #endif
> +
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +	/* if access method is AU, it is a 16550 with a quirk */
> +	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
> +		up->bugs |= UART_BUG_NOMSR;
> +#endif
> +
>  	serial_outp(up, UART_LCR, save_lcr);
>  
>  	if (up->capabilities != uart_config[up->port.type].flags) {
> @@ -1057,6 +1119,10 @@ static void serial8250_enable_ms(struct 
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
>  
> +	/* no MSR capabilities */
> +	if (up->bugs & UART_BUG_NOMSR)
> +		return;
> +
>  	up->ier |= UART_IER_MSI;
>  	serial_out(up, UART_IER, up->ier);
>  }
> @@ -1774,7 +1840,8 @@ serial8250_set_termios(struct uart_port 
>  	 * CTS flow control flag and modem status interrupts
>  	 */
>  	up->ier &= ~UART_IER_MSI;
> -	if (UART_ENABLE_MS(&up->port, termios->c_cflag))
> +	if (!(up->bugs & UART_BUG_NOMSR) &&
> +			UART_ENABLE_MS(&up->port, termios->c_cflag))
>  		up->ier |= UART_IER_MSI;
>  	if (up->capabilities & UART_CAP_UUE)
>  		up->ier |= UART_IER_UUE | UART_IER_RTOIE;
> diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
> --- a/drivers/serial/8250.h
> +++ b/drivers/serial/8250.h
> @@ -49,6 +49,7 @@ struct serial8250_config {
>  
>  #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
>  #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
> +#define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
>  
>  #if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
>  #define _INLINE_ inline
> diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/serial/8250_au1x00.c
> @@ -0,0 +1,102 @@
> +/*
> + * Serial Device Initialisation for Au1x00
> + *
> + * (C) Copyright Embedded Alley Solutions, Inc 2005
> + * Author: Pantelis Antoniou <pantelis@embeddedalley.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/serial_core.h>
> +#include <linux/signal.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <linux/serial_8250.h>
> +
> +#include <asm/mach-au1x00/au1000.h>
> +
> +#include "8250.h"
> +
> +#define PORT(_base, _irq)				\
> +	{						\
> +		.iobase		= _base,		\
> +		.membase	= (void __iomem *)_base,\
> +		.mapbase	= _base,		\
> +		.irq		= _irq,			\
> +		.uartclk	= 0,	/* filled */	\
> +		.regshift	= 2,			\
> +		.iotype		= UPIO_AU,		\
> +		.flags		= UPF_SKIP_TEST | 	\
> +				  UPF_IOREMAP,		\
> +	}
> +
> +static struct plat_serial8250_port au1x00_data[] = {
> +#if defined(CONFIG_SOC_AU1000)
> +	PORT(UART0_ADDR, AU1000_UART0_INT),
> +	PORT(UART1_ADDR, AU1000_UART1_INT),
> +	PORT(UART2_ADDR, AU1000_UART2_INT),
> +	PORT(UART3_ADDR, AU1000_UART3_INT),
> +#elif defined(CONFIG_SOC_AU1500)
> +	PORT(UART0_ADDR, AU1500_UART0_INT),
> +	PORT(UART3_ADDR, AU1500_UART3_INT),
> +#elif defined(CONFIG_SOC_AU1100)
> +	PORT(UART0_ADDR, AU1100_UART0_INT),
> +	PORT(UART1_ADDR, AU1100_UART1_INT),
> +	PORT(UART2_ADDR, AU1100_UART2_INT),
> +	PORT(UART3_ADDR, AU1100_UART3_INT),
> +#elif defined(CONFIG_SOC_AU1550)
> +	PORT(UART0_ADDR, AU1550_UART0_INT),
> +	PORT(UART1_ADDR, AU1550_UART1_INT),
> +	PORT(UART2_ADDR, AU1550_UART2_INT),
> +	PORT(UART3_ADDR, AU1550_UART3_INT),
> +#elif defined(CONFIG_SOC_AU1200)
> +	PORT(UART0_ADDR, AU1200_UART0_INT),
> +	PORT(UART1_ADDR, AU1200_UART1_INT),
> +#endif
> +	{ },
> +};
> +
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
> +/* XXX: Yes, I know this doesn't yet work. */
> +static void __exit au1x00_exit(void)
> +{
> +	platform_device_unregister(&au1x00_device);
> +}
> +
> +module_init(au1x00_init);
> +module_exit(au1x00_exit);
> +
> +MODULE_AUTHOR("Pantelis Antoniou <pantelis@embeddedalley.com>");
> +MODULE_DESCRIPTION("8250 serial probe module for Au1x000 cards");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -207,6 +207,14 @@ config SERIAL_8250_ACORN
>  	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
>  	  cards.  If unsure, say N.
>  
> +config SERIAL_8250_AU1X00
> +	bool "AU1X00 serial port support"
> +	depends on SERIAL_8250 != n && SOC_AU1X00
> +	help
> +	  If you have an Au1x00 board and want to use the serial port, say Y
> +	  to this option.  The driver can handle 1 or 2 serial ports.
> +	  If unsure, say N.
> +
>  comment "Non-8250 serial port support"
>  
>  config SERIAL_AMBA_PL010
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT) += 8250
>  obj-$(CONFIG_SERIAL_8250_BOCA) += 8250_boca.o
>  obj-$(CONFIG_SERIAL_8250_HUB6) += 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_MCA) += 8250_mca.o
> +obj-$(CONFIG_SERIAL_8250_AU1X00) += 8250_au1x00.o
>  obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
>  obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
>  obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
> diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -1960,6 +1960,7 @@ uart_report_port(struct uart_driver *drv
>  		break;
>  	case UPIO_MEM:
>  	case UPIO_MEM32:
> +	case UPIO_AU:
>  		snprintf(address, sizeof(address),
>  			 "MMIO 0x%lx", port->mapbase);
>  		break;
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -42,6 +42,7 @@ enum {
>  	PLAT8250_DEV_BOCA,
>  	PLAT8250_DEV_HUB6,
>  	PLAT8250_DEV_MCA,
> +	PLAT8250_DEV_AU1X00,
>  };
>  
>  /*
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -209,6 +209,7 @@ struct uart_port {
>  #define UPIO_HUB6		(1)
>  #define UPIO_MEM		(2)
>  #define UPIO_MEM32		(3)
> +#define UPIO_AU			(4)			/* Au1x00 type IO */
>  
>  	unsigned int		read_status_mask;	/* driver specific */
>  	unsigned int		ignore_status_mask;	/* driver specific */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
