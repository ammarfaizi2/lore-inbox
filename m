Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVC3O4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVC3O4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVC3O4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:56:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261920AbVC3Ozv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:55:51 -0500
Date: Wed, 30 Mar 2005 15:55:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 2/5] drivers/serial/jsm: new serial device driver
Message-ID: <20050330155535.A13781@flint.arm.linux.org.uk>
Mail-Followup-To: Wen Xiong <wendyx@us.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com> <422F2FDD.4050908@us.ltcfwd.linux.ibm.com> <20050309185800.GA27268@kroah.com> <4231B9F9.2080401@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4231B9F9.2080401@us.ltcfwd.linux.ibm.com>; from wendyx@us.ibm.com on Fri, Mar 11, 2005 at 10:32:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some belated comments.  I won't even pretend to understand
any of your (imo overcomplex) driver - which is the reason I haven't
bothered commenting before now.

However, it seems that there may be some duplication between what
you're doing and what the rest of the kernel is doing for you.
This may not be desirable, and may actually cause subtle problems,
especially if you and the rest of the kernel decides to send, eg,
an XOFF character (so the remote end sees two XOFF characters).

On Fri, Mar 11, 2005 at 10:32:09AM -0500, Wen Xiong wrote:
> diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_tty.c linux-2.6.11.new/drivers/serial/jsm/jsm_tty.c
> --- linux-2.6.11.org/drivers/serial/jsm/jsm_tty.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.11.new/drivers/serial/jsm/jsm_tty.c	2005-03-10 16:34:37.342965976 -0600
> +static void jsm_tty_close(struct uart_port *port)
> +{
> +	struct jsm_board *bd;
> +	struct termios *ts;
> +	struct jsm_channel *channel = (struct jsm_channel *)port;
> +
> +	jsm_printk(CLOSE, INFO, &channel->ch_bd->pci_dev, "start\n");
> +
> +	bd = channel->ch_bd;
> +	ts = channel->uart_port.info->tty->termios;
> +
> +	channel->ch_flags &= ~(CH_STOPI);
> +
> +	channel->ch_open_count--;
> +
> +	/*
> +	 * If we have HUPCL set, lower DTR and RTS
> +	 */
> +	if (channel->ch_c_cflag & HUPCL) {
> +		jsm_printk(CLOSE, INFO, &channel->ch_bd->pci_dev,
> +			"Close. HUPCL set, dropping DTR/RTS\n");
> +
> +		/* Drop RTS/DTR */
> +		channel->ch_mostat &= ~(UART_MCR_DTR | UART_MCR_RTS);
> +		bd->bd_ops->assert_modem_signals(channel);
> +	}

This is not necessary.  Since you're using the serial core, if you
look at what it's already doing for you, you'll see that uart_shutdown()
already takes care of this.

> +void jsm_check_queue_flow_control(struct jsm_channel *ch)
> +{
> +	int qleft = 0;
> +
> +	/* Store how much space we have left in the queue */
> +	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
> +		qleft += RQUEUEMASK + 1;
> +
> +	/*
> +	 * Check to see if we should enforce flow control on our queue because
> +	 * the ld (or user) isn't reading data out of our queue fast enuf.
> +	 *
> +	 * NOTE: This is done based on what the current flow control of the
> +	 * port is set for.
> +	 *
> +	 * 1) HWFLOW (RTS) - Turn off the UART's Receive interrupt.
> +	 *	This will cause the UART's FIFO to back up, and force
> +	 *	the RTS signal to be dropped.
> +	 * 2) SWFLOW (IXOFF) - Keep trying to send a stop character to
> +	 *	the other side, in hopes it will stop sending data to us.
> +	 * 3) NONE - Nothing we can do.  We will simply drop any extra data
> +	 *	that gets sent into us when the queue fills up.
> +	 */
> +	if (qleft < 256) {
> +		/* HWFLOW */
> +		if (ch->ch_c_cflag & CRTSCTS) {
> +			if(!(ch->ch_flags & CH_RECEIVER_OFF)) {
> +				ch->ch_bd->bd_ops->disable_receiver(ch);
> +				ch->ch_flags |= (CH_RECEIVER_OFF);
> +				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
> +					"Internal queue hit hilevel mark (%d)! Turning off interrupts.\n",
> +					qleft);
> +			}
> +		}
> +		/* SWFLOW */
> +		else if (ch->ch_c_iflag & IXOFF) {
> +			if (ch->ch_stops_sent <= MAX_STOPS_SENT) {
> +				ch->ch_bd->bd_ops->send_stop_character(ch);
> +				ch->ch_stops_sent++;
> +				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
> +					"Sending stop char! Times sent: %x\n", ch->ch_stops_sent);
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * Check to see if we should unenforce flow control because
> +	 * ld (or user) finally read enuf data out of our queue.
> +	 *
> +	 * NOTE: This is done based on what the current flow control of the
> +	 * port is set for.
> +	 *
> +	 * 1) HWFLOW (RTS) - Turn back on the UART's Receive interrupt.
> +	 *	This will cause the UART's FIFO to raise RTS back up,
> +	 *	which will allow the other side to start sending data again.
> +	 * 2) SWFLOW (IXOFF) - Send a start character to
> +	 *	the other side, so it will start sending data to us again.
> +	 * 3) NONE - Do nothing. Since we didn't do anything to turn off the
> +	 *	other side, we don't need to do anything now.
> +	 */
> +	if (qleft > (RQUEUESIZE / 2)) {
> +		/* HWFLOW */
> +		if (ch->ch_c_cflag & CRTSCTS) {
> +			if (ch->ch_flags & CH_RECEIVER_OFF) {
> +				ch->ch_bd->bd_ops->enable_receiver(ch);
> +				ch->ch_flags &= ~(CH_RECEIVER_OFF);
> +				jsm_printk(READ, INFO, &ch->ch_bd->pci_dev,
> +					"Internal queue hit lowlevel mark (%d)! Turning on interrupts.\n",
> +					qleft);
> +			}
> +		}
> +		/* SWFLOW */
> +		else if (ch->ch_c_iflag & IXOFF && ch->ch_stops_sent) {
> +			ch->ch_stops_sent = 0;
> +			ch->ch_bd->bd_ops->send_start_character(ch);
> +			jsm_printk(READ, INFO, &ch->ch_bd->pci_dev, "Sending start char!\n");
> +		}
> +	}
> +}

Wouldn't you think the kernel already takers are of flow control, given
that it already handles the sending of the X* characters?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
