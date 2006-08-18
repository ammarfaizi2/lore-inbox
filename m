Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWHRPoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWHRPoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWHRPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:44:10 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:14354 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161035AbWHRPoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:44:08 -0400
Date: Fri, 18 Aug 2006 16:43:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] UART driver for PNX8550/8950 and friends
Message-ID: <20060818154359.GB21101@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vitalywool@gmail.com>,
	jean-paul.saman@philips.com, linux-kernel@vger.kernel.org
References: <20060818191838.54eb5df9.vitalywool@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818191838.54eb5df9.vitalywool@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 07:18:38PM +0400, Vitaly Wool wrote:
> +/* We've been assigned a range on the "Low-density serial ports" major */

No you haven't.  You're re-using the StrongARM sa1100 serial port major/
minor.

> +#define SERIAL_PNX8XXX_MAJOR	204
> +#define MINOR_START		5
...
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
> +		if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE |
> +					PNX8XXX_UART_FIFO_RXPAR)) {

What about overrun status?

> +			if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXPAR))
> +				sport->port.icount.parity++;
> +			else if (status & FIFO_TO_SM(PNX8XXX_UART_FIFO_RXFE))
> +				sport->port.icount.frame++;
> +			if (status & ISTAT_TO_SM(PNX8XXX_UART_INT_RXOVRN))
> +				sport->port.icount.overrun++;

You're not masking with the status that we want to know about - which
means you're going to be marking characters with parity/frame errors
which should otherwise be ignored.  This is important since there's
termios modes to enable parity checking by the port _but_ ignore the
status when it occurs.

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
> +
> +		if (uart_handle_sysrq_char(&sport->port, ch, regs))
> +			goto ignore_char;
> +
> +		uart_insert_char(&sport->port, status, UART_LSR_OE, ch, flg);

Does UART_LSR_OE really tie up with one of your flags in "status" meaning
"overrun" ?

When you get an overrun status flag set, is the character you read valid?
If it isn't, you shouldn't use uart_insert_char() since that assumes it
is valid.

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
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_FRERR);
> +	}
> +
> +	/* Break signal received */
> +	if (status & PNX8XXX_UART_INT_BREAK) {
> +		sport->port.icount.brk++;
> +		serial_out(sport, PNX8XXX_ICLR, PNX8XXX_UART_INT_BREAK);

If there's no break handling, you can remove the call to
uart_handle_sysrq_char() in your receive function - it'll never do
anything useful.

> +	}
> +
...
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
> +	sport->port.read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
> +	if (termios->c_iflag & INPCK)
> +		sport->port.read_status_mask |= UART_LSR_FE | UART_LSR_PE;
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		sport->port.read_status_mask |= UART_LSR_BI;

Doubt this is correct.

> +
> +	/*
> +	 * Characters to ignore
> +	 */
> +	sport->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		sport->port.ignore_status_mask |= UART_LSR_PE | UART_LSR_FE;
> +	if (termios->c_iflag & IGNBRK) {
> +		sport->port.ignore_status_mask |= UART_LSR_BI;
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			sport->port.ignore_status_mask |= UART_LSR_OE;
> +	}

Ditto.  In which case you probably don't want serial_reg.h included (you
don't want it in any case - your device is not 8250 compatible and you're
using your own register definitions.)

...
> +static int pnx8xxx_serial_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct pnx8xxx_port *sport = platform_get_drvdata(pdev);
> +
> +	uart_suspend_port(&pnx8xxx_reg, &sport->port);

What if uart_suspend_port() wanted to return an error?

> +	return 0;
> +}
> +
> +static int pnx8xxx_serial_resume(struct platform_device *pdev)
> +{
> +	struct pnx8xxx_port *sport = platform_get_drvdata(pdev);
> +
> +	uart_resume_port(&pnx8xxx_reg, &sport->port);

What if uart_resume_port() wanted to return an error?

> +
> +	return 0;
> +}

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
