Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWAWTti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWAWTti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAWTti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:49:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932445AbWAWTth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:49:37 -0500
Date: Mon, 23 Jan 2006 19:49:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
Message-ID: <20060123194930.GA32110@flint.arm.linux.org.uk>
Mail-Followup-To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org
References: <20060122230209.GB5511@flint.arm.linux.org.uk> <20060123.150502.89066381.nemoto@toshiba-tops.co.jp> <20060123095700.GB4104@flint.arm.linux.org.uk> <20060123.223943.104642974.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123.223943.104642974.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 10:39:43PM +0900, Atsushi Nemoto wrote:
> rmk> If we successfully received the string ABCDEFGH, and the next character
> rmk> to be received (I) causes an overrun condition, what happens in the
> rmk> case that overruns are not ignored?
> 
> In this case, I will read ABCDEFG without errors, and then I with an overrun 

Duely ignored.

> rmk> Will you read ABCDEFG without any errors from the UART, and then H with
> rmk> an overrun error?  If so, you should pass to the TTY layer ABCDEFGH and
> rmk> then a NUL character with TTY_OVERRUN set.  Note that uart_insert_char()
> rmk> does this for you.
> 
> Yes, in this case I will read ABCDEFG without error, and then H with
> an overrun error.  But the UART still hold "I" in its "read buffer".
> The "read buffer" is exist outside the receiver FIFO.  So if 'J' comes
> in later, I will read "IJ".  There is no way to clear the "read
> buffer" except resetting the UART.

Ok, so if someone sent you ABCDEFGHIJ, all before you could read anything
from the UART, where I causes an overrun, you'll read ABCDEFGHJ, but the
status associated with H will indicate an overrun condition?

However, either way the behaviour after the overrun condition has no
bearing on what follows.

Your overrun behaviour is near enough to typical 8250 behaviour that you
can use the helper provided - uart_insert_char().  This eliminates the
special flag handling you seem to have created.

IOW, you want to do:

	ch = read_uart_fifo_data_register();
	status = read_uart_status_register();

	/*
	... error processing ... to set flag but omitting overrun.
	... don't do ignore processing here - uart_insert_char does
	... that for you ...
	*/

	uart_insert_char(port, status, STATUS_OVERRUN_BIT, ch, flag);

For an example, see receive_chars() in 8250.c.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
