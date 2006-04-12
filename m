Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWDLJ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWDLJ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDLJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:27:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14600 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751088AbWDLJ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:27:23 -0400
Date: Wed, 12 Apr 2006 10:26:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gerd Hoffmann <kraxel@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial: fix UART_BUG_TXEN test
Message-ID: <20060412092631.GA25799@flint.arm.linux.org.uk>
Mail-Followup-To: Gerd Hoffmann <kraxel@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <44339A8F.7030305@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44339A8F.7030305@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 12:23:11PM +0200, Gerd Hoffmann wrote:
> There is a bug in the UART_BUG_TXEN test: It gives false positives in
> case the UART_IER_THRI bit is set.  Fixed by explicitly clearing the
> UART_IER register first.
> 
> It may trigger with an active serial console as serial console writes
> set the UART_IER_THRI bit.

Actually, I think Alan's (f91a3715db2bb44fcf08cec642e68f919b70f7f4)
idea of setting UART_IER_THRI after serial console writes is buggy.
If the serial port being used as a console is sharing its interrupt
line with other devices, then there's the very real possibility for
causing spurious interrupts.

I think that's what needs to be fixed rather than working around this
potentially buggy behaviour.

Maybe we have no option but to take the spinlock in the serial console
code, and suck it if we oops with that spinlock held.

> Signed-off-by: Gerd Hoffmann <kraxel@suse.de>
> --- linux-2.6.16/drivers/serial/8250.c.serial	2006-04-05 12:04:31.000000000 +0200
> +++ linux-2.6.16/drivers/serial/8250.c	2006-04-05 12:04:49.000000000 +0200
> @@ -1712,6 +1712,7 @@
>  	 * Do a quick test to see if we receive an
>  	 * interrupt when we enable the TX irq.
>  	 */
> +	serial_outp(up, UART_IER, 0);
>  	serial_outp(up, UART_IER, UART_IER_THRI);
>  	lsr = serial_in(up, UART_LSR);
>  	iir = serial_in(up, UART_IIR);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
