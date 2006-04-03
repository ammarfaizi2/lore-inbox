Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWDCIvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDCIvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWDCIvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:51:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750859AbWDCIvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:51:09 -0400
Date: Mon, 3 Apr 2006 09:50:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-git] [SERIAL] Adds DCC(JTAG) serial and the console emulation support (revised)
Message-ID: <20060403085058.GA15606@flint.arm.linux.org.uk>
Mail-Followup-To: "Hyok S. Choi" <hyok.choi@samsung.com>,
	linux-kernel@vger.kernel.org
References: <20060403082001.26644.18948.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403082001.26644.18948.stgit@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 05:20:02PM +0900, Hyok S. Choi wrote:

Thanks for looking at the previous points, this driver is much better.
However, there's still some bits which could be even better.

> +/* use ttyJ0(128) */
> +#define SERIAL_DCC_NAME		"ttyJ"
> +#define SERIAL_DCC_MINOR	(64 + 64)
> +#endif
> +#define SERIAL_DCC_MAJOR	TTY_MAJOR

Why not just get a proper legal allocation from LANANA ?

> +static inline u32
> +__dcc_getstatus(void)

Column space is not at a premium.

static inline u32 __dcc_getstatus(void)

will do just as well.  Does the double underscore here serve any purpose?

> +{
> +	u32 __ret;

The double underscore here serves no purpose.

> +
> +	asm("mrc p14, 0, %0, c0, c0	@ read comms ctrl reg"
> +		: "=r" (__ret));
> +
> +	return __ret;
> +}
> +
> +static inline char
> +__dcc_getchar(void)
> +{
> +	char __c;

Ditto.

> +
> +	asm("mrc p14, 0, %0, c1, c0	@ read comms data reg"
> +		: "=r" (__c));
> +
> +	return __c;
> +}
> +
> +static inline void
> +__dcc_putchar(char c)
> +{
> +	asm("mcr p14, 0, %0, c1, c0	@ write a char"
> +		: /* no output register */
> +		: "r" (c));
> +}
> +
> +static void
> +dcc_putchar(struct uart_port *port, int ch)
> +{
> +	while (__dcc_getstatus() & DCC_STATUS_TX)
> +		cpu_relax();
> +	__dcc_putchar((char)(ch & 0xFF));

Since this is the only place __dcc_putchar is used, might be an idea to
move it into this function?

> +}
> +
> +static inline void
> +xmit_string(struct uart_port *port, char *p, int len)
> +{
> +	for ( ; len; len--, p++)
> +		dcc_putchar(port, *p);
> +}
> +
> +static inline void
> +dcc_transmit_buffer(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->info->xmit;
> +	int pendings = uart_circ_chars_pending(xmit);
> +
> +	if(pendings + xmit->tail > UART_XMIT_SIZE)
> +	{

Mixture of bracing styles, and there should be a space between if and (.

	if (pendings + xmit->tail > UART_XMIT_SIZE) {

> +		xmit_string(port, &(xmit->buf[xmit->tail]),
> +			UART_XMIT_SIZE - xmit->tail);
> +		xmit_string(port, &(xmit->buf[0]), xmit->head);
> +	} else
> +		xmit_string(port, &(xmit->buf[xmit->tail]), pendings);
> +	
> +	xmit->tail = (xmit->tail + pendings) & (UART_XMIT_SIZE-1);
> +	port->icount.tx += pendings;
> +}
>...
> +dcc_rx_chars(struct uart_port *port)
> +{
> +	unsigned char ch;
> +	struct tty_struct *tty = port->info->tty;
> +
> +	/*
> +	 * check input.
> +	 * checking JTAG flag is better to resolve the status test.
> +	 * incount is NOT used for JTAG1 protocol.
> +	 */
> +
> +	if (__dcc_getstatus() & DCC_STATUS_RX)
> +	{

Mixture of bracing styles again.  Either always place the { at the end of
the previous line (preferred) or separately on the next line, but don't
do both in the same file.

> +		/* for JTAG 1 protocol, incount is always 1. */
> +		ch = __dcc_getchar();
> +
> +		if (tty) {
> +			tty_insert_flip_char(tty, ch, TTY_NORMAL);
> +			port->icount.rx++;
> +			tty_flip_buffer_push(tty);
> +		}
> +	}
> +}
> +
> +static inline void
> +dcc_overrun_chars(struct uart_port *port)
> +{
> +	port->icount.overrun++;
> +}

This doesn't seem to be used anywhere.

> +static int
> +dcc_startup(struct uart_port *port)
> +{
> +#ifdef DCC_IRQ_USED /* real IRQ used */
> +	int retval;
> +
> +	/* Allocate the IRQ */
> +	retval = request_irq(port->irq, dcc_int, SA_INTERRUPT,
> +			     "serial_dcc", port);
> +	if (retval)
> +		return retval;
> +#else /* emulation */
> +	/* Initialize the work, and shcedule it. */
> +	INIT_WORK(&dcc_poll_task, dcc_poll, port);
> +	spin_lock(&port->lock);
> +	if (dcc_poll_state != DCC_POLL_RUN)
> +		dcc_poll_state = DCC_POLL_RUN;
> +	schedule_delayed_work(&dcc_poll_task, 1);
> +	spin_unlock(&port->lock);

Hmm, this looks over complex:

	if (dcc_poll_state != DCC_POLL_RUN)
		dcc_poll_state = DCC_POLL_RUN;

and unnecessary (see dcc_shutdown comments.)

Secondly, wouldn't it be better to have INIT_WORK() in the driver
initialisation?

> +#endif
> +
> +	return 0;
> +}
> +
> +static void
> +dcc_shutdown(struct uart_port *port)
> +{
> +#ifdef DCC_IRQ_USED /* real IRQ used */
> +	free_irq(port->irq, port);
> +#else
> +	spin_lock(&port->lock);
> +	dcc_poll_state = DCC_POLL_STOP;
> +	spin_unlock(&port->lock);

Rather than having this dcc_poll_state, wouldn't the use of:

	cancel_rearming_delayed_work(&dcc_poll_task);

suffice?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
