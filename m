Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWF0T7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWF0T7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWF0T7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:59:09 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:59397 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932551AbWF0T7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:59:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 27 Jun 2006 19:59:05.0938 (UTC) FILETIME=[2525EB20:01C69A24]
Content-class: urn:content-classes:message
Subject: Re: Serial: UART_BUG_TXEN race conditions
Date: Tue, 27 Jun 2006 15:59:05 -0400
Message-ID: <Pine.LNX.4.61.0606271542530.7275@chaos.analogic.com>
In-Reply-To: <20060627211946.5le5spxmckwo0sks@mail.tu-chemnitz.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial: UART_BUG_TXEN race conditions
thread-index: AcaaJCUvA+xDZSEET8WWzdAMT7057Q==
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de><Pine.LNX.4.61.0606270813380.2135@chaos.analogic.com> <20060627211946.5le5spxmckwo0sks@mail.tu-chemnitz.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ingo van Lil" <inguin@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2006, Ingo van Lil wrote:

> "linux-os (Dick Johnson)" <linux-os@analogic.com> schrieb:
>
>> A common problem with 8250 UART code I've seen is that
>> writers often do this:
>>
>> 	clear interrupts (spinlock)
>> 	read/check status
>> 	do something
>> 	enable interrupts (spin unlock)
>>
>> This 'seems' correct, but allows sneaky things to happen between
>> when you read/check status and you actually handle it.
>
> What "sneaky thinks" could possibly happen between there? Either the
> IIR read tells you that the TX FIFO is empty (in that case you can
> safely write data into it) or it will tell you something different. In
> the latter case another interrupt will be generated as soon as the FIFO
> becomes empty.

The sneaky things are other bits being set after you read them.
Look under 'Interrupt Reset Control': Reading IIR register or
writing to the transmitter holding register. You read status,
then do something else because the THRE bit wasn't set yet. It
is now set just before you do something else, but you don't get
another edge interrupt because the IRQ line never moved. It's
always high, no more interrupts ... ever. This problem wouldn't
exist with level interrupts but the 8250/16450 doesn't use level
interrupts.

These problems are why you sometimes see the UART ISR code
being called from a timer-tick interrupt.

Whatever you do, you must completely satisfy the interrupt
condition in the ISR, or your code will never get the CPU back!
All the bits that could cause interrupts must be reset before
you return from your routine.

>
> As far as I can see the main reason for all the UART confusion is the
> requirement that the interrupt condition is to be automatically cleared
>  by an IIR read, if (and only if) the indicated state ist THRE. This
> sounds like a particularly bad idea to me, but I'm not an expert.
> Anyway, as the IIR read might have been performed by some other piece
> of code (e.g. serial8250_startup) the 8250 driver depends on the UART
> to trigger another interrupt as soon the THRE bit in the IER is set (by
> start_tx). The opencores.org UART behaves that way, and I guess that's
> what most controllers do, but some more exotic chips appear not to.
>
>> To implement the above algorithm, the following has been successful.
> [...]
>
> This seems to be pretty much what I suggested yesterday: After adding
> new characters to the ring buffer, check whether the transmitter is
> idle and, if it is, write a first load of characters into the FIFO.

Yep.

> This should be a safe for solution for all kinds of UARTs, and it would
> allow us to entirely drop the UART_BUG_TXEN detection.
>
> I'm gonna have a look at the kernel patch submission guidelines and,
> unless somebody is quicker than me, propose a patch.
>
> Cheers,
> Ingo
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.71 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
