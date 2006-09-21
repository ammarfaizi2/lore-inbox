Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWIUF1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWIUF1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 01:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWIUF1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 01:27:31 -0400
Received: from xenotime.net ([66.160.160.81]:46753 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751234AbWIUF1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 01:27:30 -0400
Date: Wed, 20 Sep 2006 22:28:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Message-Id: <20060920222837.8b2d2a88.rdunlap@xenotime.net>
In-Reply-To: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 11:33:05 +0800 Luke Yang wrote:

> This is the serial driver for Blackfin. It is designed for the serial
> core framework.
> 
> As to other drivers, I'll send them one by one later.
> 
> Signed-off-by: Luke Yang <luke.adi@gmail.com>
> 
>  drivers/serial/Kconfig      |   35 +
>  drivers/serial/Makefile     |    3
>  drivers/serial/bfin_5xx.c   |  903 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h |    3
>  4 files changed, 943 insertions(+), 1 deletion(-)
> 
> diff -urN linux-2.6.18.patch1/drivers/serial/Kconfig
> linux-2.6.18.patch2/drivers/serial/Kconfig
> --- linux-2.6.18.patch1/drivers/serial/Kconfig	2006-09-21
> 09:14:42.000000000 +0800
> +++ linux-2.6.18.patch2/drivers/serial/Kconfig	2006-09-21
> 09:38:17.000000000 +0800
> @@ -488,6 +488,41 @@
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
> 
> +config SERIAL_BFIN
> +	bool "Blackfin serial port support (EXPERIMENTAL)"
> +	depends on BFIN && EXPERIMENTAL
> +	select SERIAL_CORE

Just curious:  why bool and not tristate?  (i.e., why is loadable
module not allowed?)

> +config SERIAL_BFIN_CONSOLE
> +	bool "Console on Blackfin serial port"
> +	depends on SERIAL_BFIN
> +	select SERIAL_CORE_CONSOLE
> +
> +choice
> +        prompt  "Blackfin UART Mode"
> +        depends on SERIAL_BFIN
> +        default SERIAL_BFIN_DMA
> +        ---help---
> +          This driver supports the built-in serial ports of the
> Blackfin family of CPUs
> +
> +config SERIAL_BFIN_DMA
> +        bool "Blackfin UART DMA mode"
> +        depends on DMA_UNCACHED_1M
> +        help
> +          This driver works under DMA mode. If this option is
> selected, the blackfin simple dma driver is also enabled.

Please break that long line at < 80 columns (so that left-right
scrolling is not required to read it in menuconfig).

> +config SERIAL_BFIN_PIO
> +        bool "Blackfin UART PIO mode"
> +        help
> +          This driver works under PIO mode.
> +endchoice
> +
> +config SERIAL_BFIN_CTSRTS
> +	bool "Enable hardware flow control"
> +	depends on SERIAL_BFIN
> +	help
> +	  Enable hardware flow control in the driver. Using GPIO emulate the
> CTS/RTS signal.

Split the long help text into 2 lines.

>  config SERIAL_IMX
>  	bool "IMX serial port support"
>  	depends on ARM && ARCH_IMX

> diff -urN linux-2.6.18.patch1/drivers/serial/Makefile
> linux-2.6.18.patch2/drivers/serial/Makefile
> --- linux-2.6.18.patch1/drivers/serial/Makefile	2006-09-21
> 09:14:42.000000000 +0800
> +++ linux-2.6.18.patch2/drivers/serial/Makefile	2006-09-21
> 09:38:17.000000000 +0800
> @@ -55,4 +56,4 @@
>  obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
>  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
>  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
> -obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> +obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> \ No newline at end of file

What is the purpose of the change above?

> diff -urN linux-2.6.18.patch1/drivers/serial/bfin_5xx.c
> linux-2.6.18.patch2/drivers/serial/bfin_5xx.c
> --- linux-2.6.18.patch1/drivers/serial/bfin_5xx.c	1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.18.patch2/drivers/serial/bfin_5xx.c	2006-09-21
> 09:38:17.000000000 +0800
> @@ -0,0 +1,903 @@
> +
> +#include <linux/config.h>

Don't include the config.h header file.  That's done automatically
by the build system.

> +static irqreturn_t bfin_serial_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct bfin_serial_port *uart = dev_id;
> +	unsigned short status;
> +
> +	spin_lock(&uart->port.lock);
> +	status = UART_GET_IIR(uart);
> +	do {
> +		if ((status & IIR_STATUS) == IIR_TX_READY)
> +			bfin_serial_tx_chars(uart);
> +		if ((status & IIR_STATUS) == IIR_RX_READY)
> +			bfin_serial_rx_chars(uart, regs);
> +		status = UART_GET_IIR(uart);
> +	} while (status &(IIR_TX_READY | IIR_RX_READY));
> +	spin_unlock(&uart->port.lock);
> +	return IRQ_HANDLED;

So, the interrupt is requested as Shared, but then the int. handler
code (above here) does not check to see if the interrupt was
for this device.  Shouldn't it do that and then return IRQ_NONE
if it wasn't for this device?

> +}
> +	bfin_serial_mctrl_check(uart);
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_SERIAL_BFIN_DMA
> +static void bfin_serial_dma_tx_chars(struct bfin_serial_port *uart)
> +{
> +	struct circ_buf *xmit = &uart->port.info->xmit;
> +	unsigned short ier;
> +	int flags = 0;
> +
> +	if (!uart->tx_done)
> +		return;
> +
> +	uart->tx_done = 0;
> +
> +	if (uart->port.x_char) {
> +		UART_PUT_CHAR(uart, uart->port.x_char);
> +		uart->port.icount.tx++;
> +		uart->port.x_char = 0;
> +		uart->tx_done = 1;
> +		return;
> +	}
> +	/*
> +	 * Check the modem control lines before
> +	 * transmitting anything.
> +	 */
> +	bfin_serial_mctrl_check(uart);
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(&uart->port)) {
> +		bfin_serial_stop_tx(&uart->port);
> +		uart->tx_done = 1;
> +		return;
> +	}
> +
> +	local_irq_save(flags);
> +	uart->tx_count = CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE);
> +	if (uart->tx_count > (UART_XMIT_SIZE - xmit->tail))
> +	uart->tx_count = UART_XMIT_SIZE - xmit->tail;

odd indentation above.

> +	blackfin_dcache_flush_range((unsigned long)(xmit->buf+xmit->tail),
> +					(unsigned long)(xmit->buf+xmit->tail+uart->tx_count));
> +	set_dma_config(uart->tx_dma_channel,
> +		set_bfin_dma_config(DIR_READ, DMA_FLOW_STOP,
> +			INTR_ON_BUF,
> +			DIMENSION_LINEAR,
> +			DATA_SIZE_8));
> +	set_dma_start_addr(uart->tx_dma_channel, (unsigned
> long)(xmit->buf+xmit->tail));
> +	set_dma_x_count(uart->tx_dma_channel, uart->tx_count);
> +	set_dma_x_modify(uart->tx_dma_channel, 1);
> +	enable_dma(uart->tx_dma_channel);
> +	ier = UART_GET_IER(uart);
> +	ier |= ETBEI;
> +	UART_PUT_IER(uart, ier);
> +	local_irq_restore(flags);
> +}
> +

> +static irqreturn_t bfin_serial_dma_tx_int(int irq, void *dev_id,
> struct pt_regs *regs)

"struct" line above is a separate line but does not have a
beginning '+' mark, so the patch is malformed/corrupted.
This happened in a few other places also, so something is
breaking/splitting lines badly for us.  :(

> +{
> +	struct bfin_serial_port *uart = dev_id;
> +	struct circ_buf *xmit = &uart->port.info->xmit;
> +	unsigned short ier;
> +
> +	spin_lock(&uart->port.lock);
> +	if (!(get_dma_curr_irqstat(uart->tx_dma_channel)&DMA_RUN)) {
> +		clear_dma_irqstat(uart->tx_dma_channel);
> +		disable_dma(uart->tx_dma_channel);
> +		ier = UART_GET_IER(uart);
> +		ier &= ~ETBEI;
> +		UART_PUT_IER(uart, ier);
> +		xmit->tail = (xmit->tail+uart->tx_count) &(UART_XMIT_SIZE -1);
> +		uart->port.icount.tx+=uart->tx_count;
> +
> +		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +			uart_write_wakeup(&uart->port);
> +
> +		if (uart_circ_empty(xmit))
> +			bfin_serial_stop_tx(&uart->port);
> +		uart->tx_done = 1;
> +	}
> +
> +	spin_unlock(&uart->port.lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bfin_serial_dma_rx_int(int irq, void *dev_id,
> struct pt_regs *regs)
> +{
> +	struct bfin_serial_port *uart = dev_id;
> +	unsigned short irqstat;
> +
> +	uart->rx_dma_nrows++;
> +	if (uart->rx_dma_nrows == DMA_RX_YCOUNT) {
> +		uart->rx_dma_nrows = 0;
> +		uart->rx_dma_buf.tail = DMA_RX_XCOUNT*DMA_RX_YCOUNT;
> +		bfin_serial_dma_rx_chars(uart);
> +		uart->rx_dma_buf.head = uart->rx_dma_buf.tail = 0;
> +	}
> +	spin_lock(&uart->port.lock);
> +	irqstat = get_dma_curr_irqstat(uart->rx_dma_channel);
> +	clear_dma_irqstat(uart->rx_dma_channel);
> +
> +	spin_unlock(&uart->port.lock);
> +	return IRQ_HANDLED;
> +}
> +#endif

> +static unsigned int bfin_serial_get_mctrl(struct uart_port *port)
> +{
> +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> +	if (bfin_read16(CTS_PORT) & (1<<CTS_PIN))
> +		return TIOCM_DSR | TIOCM_CAR;
> +	else
> +#endif
> +		return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;

Hardcoded return value, without reading a port, right?

> +}
> +
> +static void bfin_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
> +	if (mctrl & TIOCM_RTS)
> +		bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)&(~1<<RTS_PIN));
> +	else
> +		bfin_write16(RTS_PORT, bfin_read16(RTS_PORT)|(1<<RTS_PIN));
> +#endif
> +}

> +int bfin_serial_startup(struct uart_port *port)
> +{
> +	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
> +
> +#ifdef CONFIG_SERIAL_BFIN_DMA
> +	dma_addr_t dma_handle;
> +
> +	if (request_dma(uart->rx_dma_channel, "BFIN_UART_RX") < 0) {
> +		printk(KERN_NOTICE "Unable to attach Blackfin UART RX DMA channel\n");
> +		return -EBUSY;
> +	} else
> +		set_dma_callback(uart->rx_dma_channel, bfin_serial_dma_rx_int, uart);
> +
> +	if (request_dma(uart->tx_dma_channel, "BFIN_UART_TX") < 0) {
> +		printk(KERN_NOTICE "Unable to attach Blackfin UART TX DMA channel\n");

Before returning, this failure path needs to free_dma() for the
first request_dma() that succeeded.
I would also suggest doing the set_dma_callback() calls after
both request_dma() calls have succeeded.

> +		return -EBUSY;
> +	} else
> +		set_dma_callback(uart->tx_dma_channel, bfin_serial_dma_tx_int, uart);
> +
> +	uart->rx_dma_buf.buf = (unsigned char *)dma_alloc_coherent(NULL,
> PAGE_SIZE, &dma_handle, GFP_DMA);

bad line split.

> +	uart->rx_dma_buf.head = 0;
> +	uart->rx_dma_buf.tail = 0;
> +	uart->rx_dma_nrows = 0;
> +
> +	set_dma_config(uart->rx_dma_channel,
> +		set_bfin_dma_config(DIR_WRITE, DMA_FLOW_AUTO,
> +				INTR_ON_ROW, DIMENSION_2D,
> +				DATA_SIZE_8));
> +	set_dma_x_count(uart->rx_dma_channel, DMA_RX_XCOUNT);
> +	set_dma_x_modify(uart->rx_dma_channel, 1);
> +	set_dma_y_count(uart->rx_dma_channel, DMA_RX_YCOUNT);
> +	set_dma_y_modify(uart->rx_dma_channel, 1);
> +	set_dma_start_addr(uart->rx_dma_channel, (unsigned long)uart->rx_dma_buf.buf);

ditto

> +	enable_dma(uart->rx_dma_channel);
> +
> +	uart->rx_dma_timer.data = (unsigned long)(uart);
> +	uart->rx_dma_timer.function = (void *)bfin_serial_rx_dma_timeout;
> +	uart->rx_dma_timer.expires = jiffies + DMA_RX_FLUSH_JIFFIES;
> +	add_timer(&(uart->rx_dma_timer));
> +#else
> +	if (request_irq
> +	    (uart->port.irq, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,

The request_irq() parameters have changed a bit recently.
SA_SHIRQ is now IRQF_SHARED and SA_INTERRUPT is IRQF_DISABLED.
Please change to use the new interface.
It is documented in Documentation/DocBook/genericirq*

> +	     "BFIN_UART0_RX", uart)) {
> +		printk(KERN_NOTICE "Unable to attach BlackFin UART RX interrupt\n");
> +		return -EBUSY;
> +	}
> +
> +	if (request_irq
> +	    (uart->port.irq+1, bfin_serial_int, SA_INTERRUPT | SA_SHIRQ,
> +	     "BFIN_UART0_TX", uart)) {
> +		printk(KERN_NOTICE "Unable to attach BlackFin UART TX interrupt\n");

This second request_irq() failure needs to call free_irq() for the
first request_irq() that succeeded...

> +		return -EBUSY;
> +	}
> +#endif
> +	UART_PUT_IER(uart, UART_GET_IER(uart) | ERBFI);
> +	return 0;
> +}

> +static int bfin_serial_calc_baud(unsigned int uartclk)
> +{
> +	int baud;
> +	baud = get_sclk()/(uartclk*8);

Throw a few spaces in there, like so:
	baud = get_sclk() / (uartclk * 8);

> +	if ((baud & 0x1) == 1) {
> +		baud++;
> +	}
> +	return baud/2;
> +}

---
~Randy
