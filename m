Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWHSP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWHSP6s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWHSP6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:58:48 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:9489 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750952AbWHSP6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:58:47 -0400
Date: Sat, 19 Aug 2006 16:58:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] UART driver for PNX8330/8550/8950: next iteration
Message-ID: <20060819155837.GE25767@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>,
	jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
References: <20060819160644.0000620f.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819160644.0000620f.vitalywool@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 04:06:44PM +0400, Vitaly Wool wrote:
> please find the patch that adds PNX8xxx UART support with your latest
> comments taken into account inlined.

Okay, I'm now happy with this - thanks for addressing those points so far.

Consider the following two comments non-show stoppers, which can be fixed
up later.  If you do want to submit another patch which these two addressed
that's also fine - I won't be applying any patches for at least a couple
of hours.  If not, I'll apply this patch as is.

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
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_RXOVRN);
> +	}
> +
> +	/* RX Frame Error */
> +	if (status & PNX8XXX_UART_INT_FRERR) {
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

Would it be more efficient to write to ICLR once at the end of the
function, rather than once per status bit?  Could you do this instead:

	if (status & PNX8XXX_UART_INT_BREAK) {
		sport->port.icount.brk++;
		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_BREAK);
		uart_handle_break(&sport->port);
	}

	if (status & PNX8XXX_UART_INT_RX)
		pnx8xxx_rx_chars(sport, regs);

	if (status & PNX8XXX_UART_INT_TX)
		pnx8xxx_tx_chars(sport);

	serial_out(sport, PNX8XXX_ICLR, status);

?

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
> +	serial_out(sport, PNX8XXX_LCR,
> +		serial_in(sport, PNX8XXX_LCR) & ~PNX8XXX_UART_LCR_TXBREAK);
> +
> +	/*
> +	 * Reset the Tx and Rx FIFOS
> +	 */
> +	serial_out(sport, PNX8XXX_LCR, serial_in(sport, PNX8XXX_LCR) |
> +			    PNX8XXX_UART_LCR_TX_RST |
> +			    PNX8XXX_UART_LCR_RX_RST);

Hmm, two read-modify-writes to the LCR in succession.  Wouldn't:

	lcr = serial_in(sport, PNX8XXX_LCR);
	lcr &= ~PNX8XXX_UART_LCR_TXBREAK;
	lcr |= PNX8XXX_UART_LCR_TX_RST | PNX8XXX_UART_LCR_RX_RST;
	serial_out(sport, PNX8XXX_LCR, lcr);

be more efficient/smaller code?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
