Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWHBPRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWHBPRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWHBPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:17:47 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:16653 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751187AbWHBPRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:17:47 -0400
Date: Wed, 2 Aug 2006 16:17:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] at91_serial: Fix break handling
Message-ID: <20060802151741.GB32102@flint.arm.linux.org.uk>
Mail-Followup-To: Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
References: <11545303083273-git-send-email-hskinnemoen@atmel.com> <11545303082669-git-send-email-hskinnemoen@atmel.com> <11545303083943-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11545303083943-git-send-email-hskinnemoen@atmel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 04:51:47PM +0200, Haavard Skinnemoen wrote:
> @@ -269,9 +271,14 @@ static void at91_rx_chars(struct uart_po
>  			UART_PUT_CR(port, AT91_US_RSTSTA);	/* clear error */
>  			if (status & AT91_US_RXBRK) {
>  				status &= ~(AT91_US_PARE | AT91_US_FRAME);	/* ignore side-effect */
> -				port->icount.brk++;
> -				if (uart_handle_break(port))
> +				if (at91_port->break_active) {
> +					at91_port->break_active = 0;
> +				} else {
> +					at91_port->break_active = 1;
> +					port->icount.brk++;
> +					uart_handle_break(port);
>  					goto ignore_char;
> +				}

Two points here.

1. Effectively, this just ignores every second break status.  We've no idea
   _which_ break interrupt is going to be ignored.
2. it breaks break handling.  uart_handle_break returns a value for a
   reason.  Use it - don't unconditionally ignore the received character.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
