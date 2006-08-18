Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWHRM46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWHRM46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWHRM46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:56:58 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35854 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751267AbWHRM45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:56:57 -0400
Date: Fri, 18 Aug 2006 13:56:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: jean-paul.saman@philips.com, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, vitalywool@gmail.com
Subject: Re: ip3106_uart oddity
Message-ID: <20060818125645.GA21101@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@ru.mvista.com>,
	jean-paul.saman@philips.com, linux-kernel@vger.kernel.org,
	linux-kernel-owner@vger.kernel.org, vitalywool@gmail.com
References: <20060817202954.GC28474@flint.arm.linux.org.uk> <OF21337E37.31820A4F-ONC12571CE.002682FD-C12571CE.002AB6EB@philips.com> <20060818082756.GB6901@flint.arm.linux.org.uk> <20060818152346.b1d4c7f3.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20060818152346.b1d4c7f3.vwool@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2006 at 03:23:46PM +0400, Vitaly Wool wrote:
> On Fri, 18 Aug 2006 09:27:56 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > There are no plans what so ever to "restore" what was never even there.
> > Searching around, there was a pnx0105 driver submitted but needed some
> > additional work which was never done.
> 
> pnx0105's uart fits well into 8250 concept, so I don't think it will ever show up.
>  
> > The same situation seems to apply to this driver.  Ralf submitted a
> > driver called ip3106_uart.c which claimed to be a rewrite of
> > pnx8550_uart.c.  Comments were given at that time, no real feedback
> > came of that.
> 
> Is it possbile that you include comments in the reply to this message? TIA! :)

Attached.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--CE+1k2dSO48ffgeK
Content-Type: message/rfc822
Content-Disposition: inline

Date: Fri, 28 Oct 2005 21:48:01 +0100
Subject: Re: [PATCH] Serial driver for the Philips PNX8550 SOC.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015015957.GA27829@linux-mips.org>
User-Agent: Mutt/1.4.1i

On Sat, Oct 15, 2005 at 02:59:57AM +0100, Ralf Baechle wrote:
> Serial driver for the Philips PNX8550 SOC.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

> +static void
> +ip3106_rx_chars(struct ip3106_port *sport, struct pt_regs *regs)
> +{
> +	struct tty_struct *tty = sport->port.info->tty;
> +	unsigned int status, ch, flg, ignored = 0;
> +
> +	status = FIFO_TO_SM(serial_in(sport, IP3106_FIFO)) |
> +		 ISTAT_TO_SM(serial_in(sport, IP3106_ISTAT));
> +	while (status & FIFO_TO_SM(IP3106_UART_FIFO_RXFIFO)) {
> +		ch = serial_in(sport, IP3106_FIFO);
> +
> +		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
> +			goto ignore_char;
> +		sport->port.icount.rx++;
> +
> +		flg = TTY_NORMAL;
> +
> +		/*
> +		 * note that the error handling code is
> +		 * out of the main execution path
> +		 */
> +		if (status & FIFO_TO_SM(IP3106_UART_FIFO_RXFE |
> +					IP3106_UART_FIFO_RXPAR))
> +			goto handle_error;
> +
> +		if (uart_handle_sysrq_char(&sport->port, ch, regs))
> +			goto ignore_char;
> +
> +	error_return:
> +		tty_insert_flip_char(tty, ch, flg);
> +	ignore_char:
> +		serial_out(sport, IP3106_LCR, serial_in(sport, IP3106_LCR) |
> +				IP3106_UART_LCR_RX_NEXT);
> +		status = FIFO_TO_SM(serial_in(sport, IP3106_FIFO)) |
> +			 ISTAT_TO_SM(serial_in(sport, IP3106_ISTAT));
> +	}
> + out:
> +	tty_flip_buffer_push(tty);
> +	return;
> +
> + handle_error:
> +	if (status & FIFO_TO_SM(IP3106_UART_FIFO_RXPAR))
> +		sport->port.icount.parity++;
> +	else if (status & FIFO_TO_SM(IP3106_UART_FIFO_RXFE))
> +		sport->port.icount.frame++;
> +	if (status & ISTAT_TO_SM(IP3106_UART_INT_RXOVRN))
> +		sport->port.icount.overrun++;
> +
> +	if (status & sport->port.ignore_status_mask) {
> +		if (++ignored > 100)
> +			goto out;
> +		goto ignore_char;
> +	}
> +
> +//	status &= sport->port.read_status_mask;
> +
> +	if (status & FIFO_TO_SM(IP3106_UART_FIFO_RXPAR))
> +		flg = TTY_PARITY;
> +	else if (status & FIFO_TO_SM(IP3106_UART_FIFO_RXFE))
> +		flg = TTY_FRAME;
> +
> +	if (status & ISTAT_TO_SM(IP3106_UART_INT_RXOVRN)) {
> +		/*
> +		 * overrun does *not* affect the character
> +		 * we read from the FIFO
> +		 */
> +		tty_insert_flip_char(tty, ch, flg);
> +		ch = 0;
> +		flg = TTY_OVERRUN;
> +	}
> +#ifdef SUPPORT_SYSRQ
> +	sport->port.sysrq = 0;
> +#endif
> +	goto error_return;
> +}

I removed these kinds of gotos in the other drivers to clean them up -
they don't actually buy anything.  I also added uart_insert_char() to
ensure that the overflow and ignoring handling was correct - it's
actually not correct above.  Please see current drivers/serial/sa1100.c
for the correct method.

> +#if	0	/* REVISIT */
> +	sport->port.read_status_mask &= UTSR0_TO_SM(UTSR0_TFS);
> +	sport->port.read_status_mask |= UTSR1_TO_SM(UTSR1_ROR);
> +	if (termios->c_iflag & INPCK)
> +		sport->port.read_status_mask |=
> +				UTSR1_TO_SM(UTSR1_FRE | UTSR1_PRE);
> +	if (termios->c_iflag & (BRKINT | PARMRK))
> +		sport->port.read_status_mask |=
> +				UTSR0_TO_SM(UTSR0_RBB | UTSR0_REB);
> +
> +	/*
> +	 * Characters to ignore
> +	 */
> +	sport->port.ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		sport->port.ignore_status_mask |=
> +				UTSR1_TO_SM(UTSR1_FRE | UTSR1_PRE);
> +	if (termios->c_iflag & IGNBRK) {
> +		sport->port.ignore_status_mask |=
> +				UTSR0_TO_SM(UTSR0_RBB | UTSR0_REB);
> +		/*
> +		 * If we're ignoring parity and break indicators,
> +		 * ignore overruns too (for real raw support).
> +		 */
> +		if (termios->c_iflag & IGNPAR)
> +			sport->port.ignore_status_mask |=
> +				UTSR1_TO_SM(UTSR1_ROR);
> +	}
> +#endif

I'm slightly worried about this - it means that you're not capable of
handing some of the termios modes that programs may request.  If that
isn't a problem, you should force the termios settings to reflect that
(eg) you can't ignore parity.

I don't actually see any reason why you can't support any of these
settings though.

> +static int ip3106_serial_suspend(struct device *_dev, u32 state, u32 level)

This requires fixing up - u32 state is now pm_message_t state, and
u32 level has completely gone.

> +{
> +	struct ip3106_port *sport = dev_get_drvdata(_dev);
> +
> +	if (sport && level == SUSPEND_DISABLE)
> +		uart_suspend_port(&ip3106_reg, &sport->port);
> +
> +	return 0;
> +}
> +
> +static int ip3106_serial_resume(struct device *_dev, u32 level)

u32 level has completely gone.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--CE+1k2dSO48ffgeK--
