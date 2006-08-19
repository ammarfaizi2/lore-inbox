Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWHSJEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWHSJEi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWHSJEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:04:38 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:56329 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751268AbWHSJEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:04:37 -0400
Date: Sat, 19 Aug 2006 10:04:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] UART driver for PNX8550/8950 revised
Message-ID: <20060819090427.GB25767@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>,
	jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
References: <20060819122600.000017e6.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819122600.000017e6.vitalywool@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 12:26:00PM +0400, Vitaly Wool wrote:
> Hello Russell,
> 
> please find the patch that adds PNX8xxx UART support with your
> comments taken into account inlined.

On the whole, it's good, but still not quite there yet.

There's a couple of comments that seem to have been missed from last time
around - if you don't understand them or know how to correct them, feel
free to discuss them.  I've picked up a few more points as well.

> +
> +#include <linux/config.h>

linux/config.h is not required anymore.

> +
> +#if defined(CONFIG_SERIAL_PNX8XXX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/sysrq.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/serial_pnx8xxx.h>

serial_pnx8xxx.h just contains structure and register definitions for
this driver - wouldn't it make more sense for it to be in drivers/serial
along side this driver?

> +
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +
> +#include <uart.h>

What is uart.h?  It isn't in this patch, neither is it part of mainline.

> +static void
> +pnx8xxx_rx_chars(struct pnx8xxx_port *sport, struct pt_regs *regs)
> +{
> +	struct tty_struct *tty = sport->port.info->tty;
> +	unsigned int status, ch, flg;
> +
> +	status = FIFO_TO_SM(serial_in(sport, PNX8XXX_FIFO)) |
> +		 ISTAT_TO_SM(serial_in(sport, PNX8XXX_ISTAT));
> +	while (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFIFO)) {
> +		ch = serial_in(sport, PNX8XXX_FIFO);
> +
> +		sport->port.icount.rx++;
> +
> +		flg = TTY_NORMAL;
> +
> +		/*
> +		 * note that the error handling code is
> +		 * out of the main execution path
> +		 */
> +		if (status & (FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE |
> +					PNX8XXX_UART_FIFO_RXPAR) |
> +			      ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN))) {
> +			if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR))
> +				sport->port.icount.parity++;
> +			else if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE))
> +				sport->port.icount.frame++;
> +			if (status & ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN))
> +				sport->port.icount.overrun++;

Still not using read_status_mask here, as detailed in my previous review.

			status &= sport->port.read_status_mask;

is what's missing.

> +
> +			if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR))
> +				flg = TTY_PARITY;
> +			else if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE))
> +				flg = TTY_FRAME;
> +
> +#ifdef SUPPORT_SYSRQ
> +			sport->port.sysrq = 0;
> +#endif
> +	}

Weird indentation - is this close brace part of the while loop (as its
indentation suggests) or the if () clause (as it seems to be in reality).

> +
> +		if (uart_handle_sysrq_char(&sport->port, ch, regs))
> +			goto ignore_char;
> +
> +		uart_insert_char(&sport->port, status,
> +				ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN), ch, flg);
> +
> +	ignore_char:
> +		serial_out(sport, PNX8XXX_LCR, serial_in(sport, PNX8XXX_LCR) |
> +				PNX8XXX_UART_LCR_RX_NEXT);
> +		status = FIFO_TO_SM(serial_in(sport, PNX8XXX_FIFO)) |
> +			 ISTAT_TO_SM(serial_in(sport, PNX8XXX_ISTAT));
> +	}
> +	tty_flip_buffer_push(tty);
> +}
...
> +static irqreturn_t pnx8xxx_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct pnx8xxx_port *sport = dev_id;
> +	unsigned int status;
> +
> +	spin_lock(&sport->port.lock);
> +	/* Get the interrupts */
> +	status  = serial_in(sport, PNX8XXX_ISTAT) & serial_in(sport, PNX8XXX_IEN);
> +
> +	/* RX Receiver Holding Register Overrun */
> +	if (status & PNX8XXX_UART_INT_RXOVRN) {
> +		sport->port.icount.overrun++;
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_RXOVRN);
> +	}
> +
> +	/* RX Frame Error */
> +	if (status & PNX8XXX_UART_INT_FRERR) {
> +		sport->port.icount.frame++;

Aren't frame/parity/overrun errors handled in your receive function?
Does this mean that if you have one framing error, you increment
icount.frame twice?  Please check the behaviour of your uart.

> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_FRERR);
> +	}
> +
> +	/* Break signal received */
> +	if (status & PNX8XXX_UART_INT_BREAK) {
> +		sport->port.icount.brk++;
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_BREAK);
> +		uart_handle_break(&sport->port);
> +	}
> +
> +	/* RX Parity Error */
> +	if (status & PNX8XXX_UART_INT_PARITY) {
> +		sport->port.icount.parity++;
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_PARITY);
> +	}
> +
> +	/* Byte received */
> +	if (status & PNX8XXX_UART_INT_RX) {
> +		pnx8xxx_rx_chars(sport, regs);
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_RX);
> +	}
> +
> +	/* TX holding register empty - transmit a byte */
> +	if (status & PNX8XXX_UART_INT_TX) {
> +		pnx8xxx_tx_chars(sport);
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_TX);
> +	}
> +
> +	/* TX shift register and holding register empty  */
> +	if (status & PNX8XXX_UART_INT_EMPTY) {
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_EMPTY);
> +	}
> +
> +	/* Receiver time out */
> +	if (status & PNX8XXX_UART_INT_RCVTO) {
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_RCVTO);
> +	}
> +	spin_unlock(&sport->port.lock);
> +	return IRQ_HANDLED;
> +}
...
> +static void pnx8xxx_shutdown(struct uart_port *port)
> +{
> +	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
> +
> +	/*
> +	 * Stop our timer.
> +	 */
> +	del_timer_sync(&sport->timer);
> +
> +	/*
> +	 * Disable all interrupts, port and break condition.
> +	 */
> +	serial_out(sport, PNX8XXX_IEN, 0);

This comment's not correct - where is the break condition disabled?
I thought it might be in the next serial_out() but it seems to be
missing from there as well?

> +
> +	/*
> +	 * Reset the Tx and Rx FIFOS
> +	 */
> +	serial_out(sport, PNX8XXX_LCR, serial_in(sport, PNX8XXX_LCR) |
> +			    PNX8XXX_UART_LCR_TX_RST |
> +			    PNX8XXX_UART_LCR_RX_RST);
> +
> +	/*
> +	 * Clear all interrupts
> +	 */
> +	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_ALLRX |
> +			     PNX8XXX_UART_INT_ALLTX);
> +
> +	/*
> +	 * Free the interrupt
> +	 */
> +	free_irq(sport->port.irq, sport);
> +}
> +
> +static void
> +pnx8xxx_set_termios(struct uart_port *port, struct termios *termios,
> +		   struct termios *old)
> +{
> +	struct pnx8xxx_port *sport = (struct pnx8xxx_port *)port;
> +	unsigned long flags;
> +	unsigned int lcr_fcr, old_ien, baud, quot;
> +	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
> +
> +	/*
> +	 * We only support CS7 and CS8.
> +	 */
> +	while ((termios->c_cflag & CSIZE) != CS7 &&
> +	       (termios->c_cflag & CSIZE) != CS8) {
> +		termios->c_cflag &= ~CSIZE;
> +		termios->c_cflag |= old_csize;
> +		old_csize = CS8;
> +	}
> +
> +	if ((termios->c_cflag & CSIZE) == CS8)
> +		lcr_fcr = PNX8XXX_UART_LCR_8BIT;
> +	else
> +		lcr_fcr = 0;
> +
> +	if (termios->c_cflag & CSTOPB)
> +		lcr_fcr |= PNX8XXX_UART_LCR_2STOPB;
> +	if (termios->c_cflag & PARENB) {
> +		lcr_fcr |= PNX8XXX_UART_LCR_PAREN;
> +		if (!(termios->c_cflag & PARODD))
> +			lcr_fcr |= PNX8XXX_UART_LCR_PAREVN;
> +	}
> +
> +	/*
> +	 * Ask the core to calculate the divisor for us.
> +	 */
> +	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
> +	quot = uart_get_divisor(port, baud);
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +
> +	sport->port.read_status_mask = ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN) |
> +				ISTAT_TO_SM(PNX8XXX_UART_INT_EMPTY) |
> +				ISTAT_TO_SM(PNX8XXX_UART_INT_RX);
> +	if (termios->c_iflag & INPCK)
> +		sport->port.read_status_mask |=
> +			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE) |
> +			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR);
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		sport->port.read_status_mask |=
> +			ISTAT_TO_SM(PNX8XXX_UART_INT_BREAK);
> +
> +	/*
> +	 * Characters to ignore
> +	 */
> +	sport->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		sport->port.ignore_status_mask |=
> +			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE) |
> +			FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR);
> +	if (termios->c_iflag & IGNBRK) {
> +		sport->port.ignore_status_mask |=
> +			ISTAT_TO_SM(PNX8XXX_UART_INT_BREAK);
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			sport->port.ignore_status_mask |=
> +				ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN);
> +	}

How about CREAD support?

> +
> +	del_timer_sync(&sport->timer);
> +
> +	/*
> +	 * Update the per-port timeout.
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	/*
> +	 * disable interrupts and drain transmitter
> +	 */
> +	old_ien = serial_in(sport, PNX8XXX_IEN);
> +	serial_out(sport, PNX8XXX_IEN, old_ien & ~(PNX8XXX_UART_INT_ALLTX |
> +					PNX8XXX_UART_INT_ALLRX));
> +
> +	while (serial_in(sport, PNX8XXX_FIFO) & PNX8XXX_UART_FIFO_TXFIFO_STA)
> +		barrier();
> +
> +	/* then, disable everything */
> +	serial_out(sport, PNX8XXX_IEN, 0);
> +
> +	/* Reset the Rx and Tx FIFOs too */
> +	lcr_fcr |= PNX8XXX_UART_LCR_TX_RST;
> +	lcr_fcr |= PNX8XXX_UART_LCR_RX_RST;
> +
> +	/* set the parity, stop bits and data size */
> +	serial_out(sport, PNX8XXX_LCR, lcr_fcr);
> +
> +	/* set the baud rate */
> +	quot -= 1;
> +	serial_out(sport, PNX8XXX_BAUD, quot);
> +
> +	serial_out(sport, PNX8XXX_ICLR, -1);
> +
> +	serial_out(sport, PNX8XXX_IEN, old_ien);
> +
> +	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
> +		pnx8xxx_enable_ms(&sport->port);
> +
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +}
...
> +/*
> + * Interrupts are disabled on entering
> + */
> +static void
> +pnx8xxx_console_write(struct console *co, const char *s, unsigned int count)
> +{
> +	struct pnx8xxx_port *sport = &pnx8xxx_ports[co->index];
> +	unsigned int old_ien, status, i;
> +
> +	/*
> +	 *	First, save IEN and then disable interrupts
> +	 */
> +	old_ien = serial_in(sport, PNX8XXX_IEN);
> +	serial_out(sport, PNX8XXX_IEN, old_ien & ~(PNX8XXX_UART_INT_ALLTX |
> +					PNX8XXX_UART_INT_ALLRX));
> +
> +	/*
> +	 *	Now, do each character
> +	 */
> +	for (i = 0; i < count; i++) {
> +		do {
> +			/* Wait for UART_TX register to empty */
> +			status = serial_in(sport, PNX8XXX_FIFO);
> +		} while (status & PNX8XXX_UART_FIFO_TXFIFO);
> +		serial_out(sport, PNX8XXX_FIFO, s[i]);
> +		if (s[i] == '\n') {
> +			do {
> +				status = serial_in(sport, PNX8XXX_FIFO);
> +			} while (status & PNX8XXX_UART_FIFO_TXFIFO);
> +			serial_out(sport, PNX8XXX_FIFO, '\r');
> +		}
> +	}

Still not using uart_console_write().

> +
> +	/*
> +	 *	Finally, wait for transmitter to become empty
> +	 *	and restore IEN
> +	 */
> +	do {
> +		/* Wait for UART_TX register to empty */
> +		status = serial_in(sport, PNX8XXX_FIFO);
> +	} while (status & PNX8XXX_UART_FIFO_TXFIFO);
> +
> +	/* Clear TX and EMPTY interrupt */
> +	serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_TX |
> +			     PNX8XXX_UART_INT_EMPTY);
> +
> +	serial_out(sport, PNX8XXX_IEN, old_ien);
> +}

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
