Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWAVP1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWAVP1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 10:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWAVP1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 10:27:54 -0500
Received: from ccerelrim02.cce.hp.com ([161.114.21.23]:37423 "EHLO
	ccerelrim02.cce.hp.com") by vger.kernel.org with ESMTP
	id S932223AbWAVP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 10:27:54 -0500
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts (updated
	spinlocking)
From: Alex Williamson <alex.williamson@hp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: rmk+serial@arm.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060122082402.GB1543@elf.ucw.cz>
References: <1137869586.16056.146.camel@localhost>
	 <20060122082402.GB1543@elf.ucw.cz>
Content-Type: text/plain
Organization: OSLO R&D
Date: Sun, 22 Jan 2006 08:27:49 -0700
Message-Id: <1137943669.21864.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.01.22.070606
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 09:24 +0100, Pavel Machek wrote:

> is this going to cause increased timer activity on non-buggy systems?

   No, the buggy hardware is detected and the backup timer is only
enabled if it is found.

> > +	if (is_real_interrupt(up->port.irq))
> > +		serial_out(up, UART_IER, ier);
> > +
> > +	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
> 
> Eh? What units is timeout in, anyway?

  I believe timeout is in jiffies, see:

driver/serial/serial_core.c:uart_update_timeout()

This looks strange, but it's consistent with the timeout calculation
throughout the 8250 driver.

> > +	mod_timer(&up->timer, jiffies + (timeout * 100));
> 
> Does this work in HZ!=100 situations?

   Yes, with timeout in jiffies we're simply waiting 100 times longer
than we would if we were relying on this as the primary trigger.  In
practice this seems to work fine and provides the UART a kick regularly
enough to keep bits moving.  I did try adding a fixed interval, like
(HZ/10), but I didn't notice much difference from the scaling factor
above.  The dropped interrupt happens rarely, so I wanted to keep the
backup timer at a low enough frequency that it doesn't fire too often.

> > +	/* Wait up to 1s for flow control if necessary */
> > +	if (up->port.flags & UPF_CONS_FLOW) {
> > +		tmout = 1000000;
> > +		while (--tmout &&
> > +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> > +			udelay(1);
> 
> Could you s/tmout/timeout/ while you are modifying this?

   We probably could, but is it any different than the existing polling
mode of the driver timing out here?  (Note this chunk is simply moving
existing code to avoid forward declarations)  serial8250_console_write()
already disables interrupts in the IER around calling this function,
perhaps it would be a good idea to del_timer_sync() pending timers on
the port around this as well.  Russell, any thoughts there?

> > +		if (iir & UART_IIR_NO_INT) {
> > +			unsigned int timeout = up->port.timeout;
> > +
> > +			pr_debug("ttyS%d - using backup timer\n", port->line);
> > +			timeout = timeout > 6 ? (timeout / 2 - 2) : 1;
> 
> Same strange computation, again. Inline function?

   Just trying to be consistent with timeout setup elsewhere.  Thanks
for the comments,

	Alex

