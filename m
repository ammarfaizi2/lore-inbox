Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWFZUZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFZUZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWFZUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:25:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23054 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750719AbWFZUZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:25:43 -0400
Date: Mon, 26 Jun 2006 21:25:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo van Lil <inguin@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: UART_BUG_TXEN race conditions
Message-ID: <20060626202536.GJ21272@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo van Lil <inguin@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:07:47PM +0200, Ingo van Lil wrote:
> Correct me if I'm mistaken, but I see two possible race conditions with 
> that piece of code:
> 
> 1. What if the IIR actually equals UART_IIR_THRI at that point? The
>    read access will clear the interrupt condition and the workaround
>    will effect the actual opposite of its intention: Neither
>    serial8250_start_tx() nor the interrupt handler will start
>    transmitting characters for the ring buffer.

Gah, looks like you're right - reading the IIR will clear the transmit
pending interrupt, so we should probably just load the transmitter up
with characters anyway if the TEMT bit is set.

> 2. What if an interrupt is triggered shortly after reading the IIR?
>    Both serial8250_start_tx() and the interrupt handler will start
>    a transmission simultaneously.

This function is run under the port spinlock, so the interrupt handler
will be held off until it completes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
