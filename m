Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWIMPCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWIMPCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWIMPCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:02:54 -0400
Received: from lixom.net ([66.141.50.11]:38024 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750942AbWIMPCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:02:53 -0400
Date: Wed, 13 Sep 2006 10:01:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Message-ID: <20060913100110.1e33d885@localhost.localdomain>
In-Reply-To: <871wqfyjgi.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk>
	<871wqfyjgi.fsf@slug.be.48ers.dk>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 15:39:09 +0200 Peter Korsgaard <jacmet@sunsite.dk> wrote:

> >>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
> 
>  Olof> 2. There seems to be some timeout issues with tx_empty.
> 
>  Peter> Huh, that's odd - I haven't noticed that. I'll test it again and get
>  Peter> back to you.
> 
> Ahh, found it - I didn't update the uart timeout in set_termios so it
> used a very long timeout. Please give the updated patch a try.

Looks good. Thanks.

> Additional changes:
> - Actually add the fixes I did in May on request of Russell
> - Update for 2.6.18 (devfs and new IRQF defines)
> - Removed the SERIAL_UARTLITE_NR_UARTS config option as we only have 4
>   minors reserved with lanana anyway.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Acked-by: Olof Johansson <olof@lixom.net>

> 
> diff -urpN linux-2.6.18-rc7.orig/drivers/serial/Kconfig linux-2.6.18-rc7/drivers/serial/Kconfig
> --- linux-2.6.18-rc7.orig/drivers/serial/Kconfig	2006-09-13 15:01:24.000000000 +0200
> +++ linux-2.6.18-rc7/drivers/serial/Kconfig	2006-09-13 15:01:51.000000000 +0200
> @@ -511,6 +511,25 @@ config SERIAL_IMX_CONSOLE
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>  
> +config SERIAL_UARTLITE
> +	tristate "Xilinx uartlite serial port support"
> +	depends on PPC32
> +	select SERIAL_CORE
> +	help
> +	  Say Y here if you want to use the Xilinx uartlite serial controller.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called uartlite.ko.
> +
> +config SERIAL_UARTLITE_CONSOLE
> +	bool "Support for console on Xilinx uartlite serial port"
> +	depends on SERIAL_UARTLITE=y
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  Say Y here if you wish to use a Xilinx uartlite as the system
> +	  console (the system console is the device which receives all kernel
> +	  messages and warnings and which allows logins in single user mode).
> +
>  config SERIAL_SUNCORE
>  	bool
>  	depends on SPARC
> diff -urpN linux-2.6.18-rc7.orig/drivers/serial/Makefile linux-2.6.18-rc7/drivers/serial/Makefile
> --- linux-2.6.18-rc7.orig/drivers/serial/Makefile	2006-09-13 15:01:24.000000000 +0200
> +++ linux-2.6.18-rc7/drivers/serial/Makefile	2006-09-13 15:01:51.000000000 +0200
> @@ -55,4 +55,5 @@ obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_si
>  obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
>  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
>  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
> +obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
>  obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> diff -urpN linux-2.6.18-rc7.orig/drivers/serial/uartlite.c linux-2.6.18-rc7/drivers/serial/uartlite.c
> --- linux-2.6.18-rc7.orig/drivers/serial/uartlite.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.18-rc7/drivers/serial/uartlite.c	2006-09-13 15:01:51.000000000 +0200
> @@ -0,0 +1,496 @@
> +/*
> + * uartlite.c: Serial driver for Xilinx uartlite serial controller
> + *
> + * Peter Korsgaard <jacmet@sunsite.dk>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/console.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/tty.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <asm/io.h>
> +
> +#define ULITE_MAJOR		204
> +#define ULITE_MINOR		187
> +#define ULITE_NR_UARTS		4
> +
> +/* For register details see datasheet:
> +   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
> +*/
> +#define ULITE_RX		0x00
> +#define ULITE_TX		0x04
> +#define ULITE_STATUS		0x08
> +#define ULITE_CONTROL		0x0c
> +
> +#define ULITE_REGION		16
> +
> +#define ULITE_STATUS_RXVALID	0x01
> +#define ULITE_STATUS_RXFULL	0x02
> +#define ULITE_STATUS_TXEMPTY	0x04
> +#define ULITE_STATUS_TXFULL	0x08
> +#define ULITE_STATUS_IE		0x10
> +#define ULITE_STATUS_OVERRUN	0x20
> +#define ULITE_STATUS_FRAME	0x40
> +#define ULITE_STATUS_PARITY	0x80
> +
> +#define ULITE_CONTROL_RST_TX	0x01
> +#define ULITE_CONTROL_RST_RX	0x02
> +#define ULITE_CONTROL_IE	0x10
> +
> +
> +static struct uart_port ports[ULITE_NR_UARTS];
> +
> +static int ulite_receive(struct uart_port *port, int stat)
> +{
> +	struct tty_struct *tty = port->info->tty;
> +	unsigned char ch = 0;
> +	char flag = TTY_NORMAL;
> +
> +	if ((stat & (ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
> +		     | ULITE_STATUS_FRAME)) == 0)
> +		return 0;
> +
> +	/* stats */
> +	if (stat & ULITE_STATUS_RXVALID) {
> +		port->icount.rx++;
> +		ch = readb(port->membase + ULITE_RX);
> +
> +		if (stat & ULITE_STATUS_PARITY)
> +			port->icount.parity++;
> +	}
> +
> +	if (stat & ULITE_STATUS_OVERRUN)
> +		port->icount.overrun++;
> +
> +	if (stat & ULITE_STATUS_FRAME)
> +		port->icount.frame++;
> +
> +
> +	/* drop byte with parity error if IGNPAR specificed */
> +	if (stat & port->ignore_status_mask & ULITE_STATUS_PARITY)
> +		stat &= ~ULITE_STATUS_RXVALID;
> +
> +	stat &= port->read_status_mask;
> +
> +	if (stat & ULITE_STATUS_PARITY)
> +		flag = TTY_PARITY;
> +
> +
> +	stat &= ~port->ignore_status_mask;
> +
> +	if (stat & ULITE_STATUS_RXVALID)
> +		tty_insert_flip_char(tty, ch, flag);
> +
> +	if (stat & ULITE_STATUS_FRAME)
> +		tty_insert_flip_char(tty, 0, TTY_FRAME);
> +
> +	if (stat & ULITE_STATUS_OVERRUN)
> +		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +
> +	return 1;
> +}
> +
> +static int ulite_transmit(struct uart_port *port, int stat)
> +{
> +	struct circ_buf *xmit  = &port->info->xmit;
> +
> +	if (stat & ULITE_STATUS_TXFULL)
> +		return 0;
> +
> +	if (port->x_char) {
> +		writeb(port->x_char, port->membase + ULITE_TX);
> +		port->x_char = 0;
> +		port->icount.tx++;
> +		return 1;
> +	}
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +		return 0;
> +
> +	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
> +	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
> +	port->icount.tx++;
> +
> +	/* wake up */
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	return 1;
> +}
> +
> +static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = (struct uart_port *)dev_id;
> +	int busy;
> +
> +	do {
> +		int stat = readb(port->membase + ULITE_STATUS);
> +		busy  = ulite_receive(port, stat);
> +		busy |= ulite_transmit(port, stat);
> +	} while (busy);
> +
> +	tty_flip_buffer_push(port->info->tty);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static unsigned int ulite_tx_empty(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	unsigned int ret;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	ret = readb(port->membase + ULITE_STATUS);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
> +}
> +
> +static unsigned int ulite_get_mctrl(struct uart_port *port)
> +{
> +	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
> +static void ulite_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_stop_tx(struct uart_port *port)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_start_tx(struct uart_port *port)
> +{
> +	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
> +}
> +
> +static void ulite_stop_rx(struct uart_port *port)
> +{
> +	/* don't forward any more data (like !CREAD) */
> +	port->ignore_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_PARITY
> +		| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
> +}
> +
> +static void ulite_enable_ms(struct uart_port *port)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_break_ctl(struct uart_port *port, int ctl)
> +{
> +	/* N/A */
> +}
> +
> +static int ulite_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	ret = request_irq(port->irq, ulite_isr,
> +			  IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "uartlite", port);
> +	if (ret)
> +		return ret;
> +
> +	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
> +	       port->membase + ULITE_CONTROL);
> +	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
> +
> +	return 0;
> +}
> +
> +static void ulite_shutdown(struct uart_port *port)
> +{
> +	writeb(0, port->membase + ULITE_CONTROL);
> +	free_irq(port->irq, port);
> +}
> +
> +static void ulite_set_termios(struct uart_port *port, struct termios *termios,
> +			      struct termios *old)
> +{
> +	unsigned long flags;
> +	unsigned int baud;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	port->read_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
> +		| ULITE_STATUS_TXFULL;
> +
> +	if (termios->c_iflag & INPCK)
> +		port->read_status_mask |=
> +			ULITE_STATUS_PARITY | ULITE_STATUS_FRAME;
> +
> +	port->ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		port->ignore_status_mask |= ULITE_STATUS_PARITY
> +			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
> +
> +	/* ignore all characters if CREAD is not set */
> +	if ((termios->c_cflag & CREAD) == 0)
> +		port->ignore_status_mask |=
> +			ULITE_STATUS_RXVALID | ULITE_STATUS_PARITY
> +			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
> +
> +	/* update timeout */
> +	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static const char *ulite_type(struct uart_port *port)
> +{
> +	return port->type == PORT_UARTLITE ? "uartlite" : NULL;
> +}
> +
> +static void ulite_release_port(struct uart_port *port)
> +{
> +	release_mem_region(port->mapbase, ULITE_REGION);
> +	iounmap(port->membase);
> +	port->membase = 0;
> +}
> +
> +static int ulite_request_port(struct uart_port *port)
> +{
> +	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
> +		dev_err(port->dev, "Memory region busy\n");
> +		return -EBUSY;
> +	}
> +
> +	port->membase = ioremap(port->mapbase, ULITE_REGION);
> +	if (!port->membase) {
> +		dev_err(port->dev, "Unable to map registers\n");
> +		release_mem_region(port->mapbase, ULITE_REGION);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ulite_config_port(struct uart_port *port, int flags)
> +{
> +	ulite_request_port(port);
> +	port->type = PORT_UARTLITE;
> +}
> +
> +static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
> +{
> +	/* we don't want the core code to modify any port params */
> +	return -EINVAL;
> +}
> +
> +static struct uart_ops ulite_ops = {
> +	.tx_empty	= ulite_tx_empty,
> +	.set_mctrl	= ulite_set_mctrl,
> +	.get_mctrl	= ulite_get_mctrl,
> +	.stop_tx	= ulite_stop_tx,
> +	.start_tx	= ulite_start_tx,
> +	.stop_rx	= ulite_stop_rx,
> +	.enable_ms	= ulite_enable_ms,
> +	.break_ctl	= ulite_break_ctl,
> +	.startup	= ulite_startup,
> +	.shutdown	= ulite_shutdown,
> +	.set_termios	= ulite_set_termios,
> +	.type		= ulite_type,
> +	.release_port	= ulite_release_port,
> +	.request_port	= ulite_request_port,
> +	.config_port	= ulite_config_port,
> +	.verify_port	= ulite_verify_port
> +};
> +
> +#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
> +static void ulite_console_wait_tx(struct uart_port *port)
> +{
> +	int i;
> +
> +	/* wait up to 10ms for the character(s) to be sent */
> +	for (i=0; i<10000; i++) {
> +		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
> +			break;
> +		udelay(1);
> +	}
> +}
> +
> +static void ulite_console_putchar(struct uart_port *port, int ch)
> +{
> +	ulite_console_wait_tx(port);
> +	writeb(ch, port->membase + ULITE_TX);
> +}
> +
> +static void ulite_console_write(struct console *co, const char *s,
> +				unsigned int count)
> +{
> +	struct uart_port *port = &ports[co->index];
> +	unsigned long flags;
> +	unsigned int ier;
> +	int locked = 1;
> +
> +	if (oops_in_progress) {
> +		locked = spin_trylock_irqsave(&port->lock, flags);
> +	} else
> +		spin_lock_irqsave(&port->lock, flags);
> +
> +	/* save and disable interrupt */
> +	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
> +	writeb(0, port->membase + ULITE_CONTROL);
> +
> +	uart_console_write(port, s, count, ulite_console_putchar);
> +
> +	ulite_console_wait_tx(port);
> +
> +	/* restore interrupt state */
> +	if (ier)
> +		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
> +
> +	if (locked)
> +		spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static int __init ulite_console_setup(struct console *co, char *options)
> +{
> +	struct uart_port *port;
> +
> +	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
> +		return -EINVAL;
> +
> +	port = &ports[co->index];
> +
> +	/* not initialized yet? */
> +	if (!port->membase)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static struct uart_driver ulite_uart_driver;
> +
> +static struct console ulite_console = {
> +	.name	= "ttyUL",
> +	.write	= ulite_console_write,
> +	.device	= uart_console_device,
> +	.setup	= ulite_console_setup,
> +	.flags	= CON_PRINTBUFFER,
> +	.index	= -1, /* Specified on the cmdline (e.g. console=ttyUL0 ) */
> +	.data	= &ulite_uart_driver,
> +};
> +
> +static int __init ulite_console_init(void)
> +{
> +	register_console(&ulite_console);
> +	return 0;
> +}
> +
> +console_initcall(ulite_console_init);
> +
> +#endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
> +
> +static struct uart_driver ulite_uart_driver = {
> +	.owner		= THIS_MODULE,
> +	.driver_name	= "uartlite",
> +	.dev_name	= "ttyUL",
> +	.major		= ULITE_MAJOR,
> +	.minor		= ULITE_MINOR,
> +	.nr		= ULITE_NR_UARTS,
> +#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
> +	.cons		= &ulite_console,
> +#endif
> +};
> +
> +static int __devinit ulite_probe(struct platform_device *pdev)
> +{
> +	struct resource *res, *res2;
> +	struct uart_port *port;
> +
> +	if (pdev->id < 0 || pdev->id >= ULITE_NR_UARTS)
> +		return -EINVAL;
> +
> +	if (ports[pdev->id].membase)
> +		return -EBUSY;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res2)
> +		return -ENODEV;
> +
> +	port = &ports[pdev->id];
> +
> +	port->fifosize	= 16;
> +	port->regshift	= 2;
> +	port->iotype	= UPIO_MEM;
> +	port->iobase	= 1; /* mark port in use */
> +	port->mapbase	= res->start;
> +	port->membase	= 0;
> +	port->ops	= &ulite_ops;
> +	port->irq	= res2->start;
> +	port->flags	= UPF_BOOT_AUTOCONF;
> +	port->dev	= &pdev->dev;
> +	port->type	= PORT_UNKNOWN;
> +
> +	uart_add_one_port(&ulite_uart_driver, port);
> +	platform_set_drvdata(pdev, port);
> +
> +	return 0;
> +}
> +
> +static int ulite_remove(struct platform_device *pdev)
> +{
> +	struct uart_port *port = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	if (port)
> +		uart_remove_one_port(&ulite_uart_driver, port);
> +
> +	/* mark port as free */
> +	port->membase = 0;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ulite_platform_driver = {
> +	.probe	= ulite_probe,
> +	.remove	= ulite_remove,
> +	.driver	= {
> +		   .owner = THIS_MODULE,
> +		   .name  = "uartlite",
> +		   },
> +};
> +
> +int __init ulite_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&ulite_uart_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&ulite_platform_driver);
> +	if (ret)
> +		uart_unregister_driver(&ulite_uart_driver);
> +
> +	return ret;
> +}
> +
> +void __exit ulite_exit(void)
> +{
> +	platform_driver_unregister(&ulite_platform_driver);
> +	uart_unregister_driver(&ulite_uart_driver);
> +}
> +
> +module_init(ulite_init);
> +module_exit(ulite_exit);
> +
> +MODULE_AUTHOR("Peter Korsgaard <jacmet@sunsite.dk>");
> +MODULE_DESCRIPTION("Xilinx uartlite serial driver");
> +MODULE_LICENSE("GPL");
> diff -urpN linux-2.6.18-rc7.orig/include/linux/serial_core.h linux-2.6.18-rc7/include/linux/serial_core.h
> --- linux-2.6.18-rc7.orig/include/linux/serial_core.h	2006-09-13 15:01:25.000000000 +0200
> +++ linux-2.6.18-rc7/include/linux/serial_core.h	2006-09-13 15:01:51.000000000 +0200
> @@ -132,6 +132,8 @@
>  
>  #define PORT_S3C2412	73
>  
> +/* Xilinx uartlite */
> +#define PORT_UARTLITE	74
>  
>  #ifdef __KERNEL__
>  
> diff -urpN linux-2.6.18-rc7.orig/MAINTAINERS linux-2.6.18-rc7/MAINTAINERS
> --- linux-2.6.18-rc7.orig/MAINTAINERS	2006-09-13 15:01:20.000000000 +0200
> +++ linux-2.6.18-rc7/MAINTAINERS	2006-09-13 15:01:51.000000000 +0200
> @@ -3303,6 +3303,12 @@ W:	http://oss.sgi.com/projects/xfs
>  T:	git git://oss.sgi.com:8090/xfs/xfs-2.6
>  S:	Supported
>  
> +XILINX UARTLITE SERIAL DRIVER
> +P:	Peter Korsgaard
> +M:	jacmet@sunsite.dk
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +
>  X86 3-LEVEL PAGING (PAE) SUPPORT
>  P:	Ingo Molnar
>  M:	mingo@redhat.com
> 
