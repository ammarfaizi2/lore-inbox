Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWF0TTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWF0TTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWF0TTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:19:48 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:28363 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932545AbWF0TTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:19:47 -0400
Message-ID: <20060627211946.5le5spxmckwo0sks@mail.tu-chemnitz.de>
Date: Tue, 27 Jun 2006 21:19:46 +0200
From: Ingo van Lil <inguin@gmx.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial: UART_BUG_TXEN race conditions
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
	<Pine.LNX.4.61.0606270813380.2135@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0606270813380.2135@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
X-Scan-Signature: ddb05343e7e50baad047250fd48c5445
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os (Dick Johnson)" <linux-os@analogic.com> schrieb:

> A common problem with 8250 UART code I've seen is that
> writers often do this:
>
> 	clear interrupts (spinlock)
> 	read/check status
> 	do something
> 	enable interrupts (spin unlock)
>
> This 'seems' correct, but allows sneaky things to happen between
> when you read/check status and you actually handle it.

What "sneaky thinks" could possibly happen between there? Either the 
IIR read tells you that the TX FIFO is empty (in that case you can 
safely write data into it) or it will tell you something different. In 
the latter case another interrupt will be generated as soon as the FIFO 
becomes empty.

As far as I can see the main reason for all the UART confusion is the 
requirement that the interrupt condition is to be automatically cleared 
  by an IIR read, if (and only if) the indicated state ist THRE. This 
sounds like a particularly bad idea to me, but I'm not an expert.
Anyway, as the IIR read might have been performed by some other piece 
of code (e.g. serial8250_startup) the 8250 driver depends on the UART 
to trigger another interrupt as soon the THRE bit in the IER is set (by 
start_tx). The opencores.org UART behaves that way, and I guess that's 
what most controllers do, but some more exotic chips appear not to.

> To implement the above algorithm, the following has been successful.
[...]

This seems to be pretty much what I suggested yesterday: After adding 
new characters to the ring buffer, check whether the transmitter is 
idle and, if it is, write a first load of characters into the FIFO. 
This should be a safe for solution for all kinds of UARTs, and it would 
allow us to entirely drop the UART_BUG_TXEN detection.

I'm gonna have a look at the kernel patch submission guidelines and, 
unless somebody is quicker than me, propose a patch.

Cheers,
Ingo


