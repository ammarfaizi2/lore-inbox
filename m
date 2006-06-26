Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932989AbWFZUHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbWFZUHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbWFZUHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:07:49 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:4795 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932989AbWFZUHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:07:48 -0400
Message-ID: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
Date: Mon, 26 Jun 2006 22:07:47 +0200
From: Ingo van Lil <inguin@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Serial: UART_BUG_TXEN race conditions
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
X-Scan-Signature: aa86db5e7f3e85aa9355d5c307b12c26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I'm currently working with Linux on a custom ASIC system with two 
crappy UART ports that show a behaviour quite similar to the problem 
that the UART_BUG_TXEN workaround is supposed to deal with. The 
interesting lines are in serial8250_start_tx 
(drivers/serial/8250.c:1127)

	if (up->bugs & UART_BUG_TXEN) {
		unsigned char lsr, iir;
		lsr = serial_in(up, UART_LSR);
		iir = serial_in(up, UART_IIR);
		if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
			transmit_chars(up);
	}

Correct me if I'm mistaken, but I see two possible race conditions with 
that piece of code:

1. What if the IIR actually equals UART_IIR_THRI at that point? The
    read access will clear the interrupt condition and the workaround
    will effect the actual opposite of its intention: Neither
    serial8250_start_tx() nor the interrupt handler will start
    transmitting characters for the ring buffer.

2. What if an interrupt is triggered shortly after reading the IIR?
    Both serial8250_start_tx() and the interrupt handler will start
    a transmission simultaneously.

Problem #1 should be quite easy to deal with: If the IIR read comes out 
as UART_IIR_THRI then the interrupt handler won't initiate a 
transmission, so we should. I'm not entirely sure how to deal with #2, 
though. Maybe it's enough to clear the THRE bit while transmitting 
characters, maybe some kind of locking is required.

Cheers,
Ingo


