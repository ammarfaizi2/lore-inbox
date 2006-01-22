Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWAVIYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWAVIYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWAVIYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:24:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35806 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932218AbWAVIYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:24:20 -0500
Date: Sun, 22 Jan 2006 09:24:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: rmk+serial@arm.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts (updated spinlocking)
Message-ID: <20060122082402.GB1543@elf.ucw.cz>
References: <1137869586.16056.146.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137869586.16056.146.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 21-01-06 11:53:06, Alex Williamson wrote:
> 
>    This is an update to the following patch current found in the -mm
> tree:
> 
> backup-timer-for-uarts-that-lose-interrupts-take-3.patch
> 
> The only change is that the spinlocks around 8250_handle_port() have
> been removed to be consistent with changes to upstream.  Original submit
> message below.  Thanks

is this going to cause increased timer activity on non-buggy systems?

> +	if (is_real_interrupt(up->port.irq))
> +		serial_out(up, UART_IER, ier);
> +
> +	timeout = timeout > 6 ? (timeout / 2 - 2) : 1;

Eh? What units is timeout in, anyway?

> +	mod_timer(&up->timer, jiffies + (timeout * 100));

Does this work in HZ!=100 situations?

> +	/* Wait up to 1s for flow control if necessary */
> +	if (up->port.flags & UPF_CONS_FLOW) {
> +		tmout = 1000000;
> +		while (--tmout &&
> +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> +			udelay(1);

Could you s/tmout/timeout/ while you are modifying this?

> +		if (iir & UART_IIR_NO_INT) {
> +			unsigned int timeout = up->port.timeout;
> +
> +			pr_debug("ttyS%d - using backup timer\n", port->line);
> +			timeout = timeout > 6 ? (timeout / 2 - 2) : 1;

Same strange computation, again. Inline function?
							Pavel
-- 
Thanks, Sharp!
