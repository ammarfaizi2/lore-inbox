Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWAWJ5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWAWJ5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWAWJ5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:57:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36111 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932434AbWAWJ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:57:09 -0500
Date: Mon, 23 Jan 2006 09:57:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] serial: serial_txx9 driver update
Message-ID: <20060123095700.GB4104@flint.arm.linux.org.uk>
Mail-Followup-To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org
References: <20060122080015.GA10398@flint.arm.linux.org.uk> <20060122003307.738931b7.akpm@osdl.org> <20060122230209.GB5511@flint.arm.linux.org.uk> <20060123.150502.89066381.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123.150502.89066381.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 03:05:02PM +0900, Atsushi Nemoto wrote:
> -			if (disr & TXX9_SIDISR_UOER)
> +			if (disr & TXX9_SIDISR_UOER) {
>  				up->port.icount.overrun++;
> +				/*
> +				 * The receiver read buffer still hold
> +				 * a char which caused overrun.
> +				 * Ignore next char by adding RFDN_MASK
> +				 * to ignore_status_mask temporarily.
> +				 */
> +				next_ignore_status_mask |=
> +					TXX9_SIDISR_RFDN_MASK;
> +			}

I'm not sure what you mean here.

If we successfully received the string ABCDEFGH, and the next character
to be received (I) causes an overrun condition, what happens in the
case that overruns are not ignored?

Will you read ABCDEFG without any errors from the UART, and then H with
an overrun error?  If so, you should pass to the TTY layer ABCDEFGH and
then a NUL character with TTY_OVERRUN set.  Note that uart_insert_char()
does this for you.

Alternatively, the UART may give you: ABCDEFGI where I is marked as an
overrun error.  In this case, you want to pass to the TTY layer ABCDEFG,
then a NUL character with TTY_OVERRUN set, then I.

If overruns are ignored, you merely omit to insert the NUL character with
TTY_OVERRUN set.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
