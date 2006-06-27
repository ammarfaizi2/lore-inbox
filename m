Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWF0NFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWF0NFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWF0NFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:05:40 -0400
Received: from spirit.analogic.com ([204.178.40.4]:24077 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932203AbWF0NFj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:05:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 27 Jun 2006 13:05:38.0420 (UTC) FILETIME=[62B71340:01C699EA]
Content-class: urn:content-classes:message
Subject: Re: Serial: UART_BUG_TXEN race conditions
Date: Tue, 27 Jun 2006 09:05:38 -0400
Message-ID: <Pine.LNX.4.61.0606270813380.2135@chaos.analogic.com>
In-Reply-To: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial: UART_BUG_TXEN race conditions
thread-index: AcaZ6mK+PmlBO+IMRKWpuQegwGzipA==
References: <20060626220747.zmkyd4smqs0o044s@mail.tu-chemnitz.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ingo van Lil" <inguin@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2006, Ingo van Lil wrote:

> Hello everybody,
>
> I'm currently working with Linux on a custom ASIC system with two
> crappy UART ports that show a behaviour quite similar to the problem
> that the UART_BUG_TXEN workaround is supposed to deal with. The
> interesting lines are in serial8250_start_tx
> (drivers/serial/8250.c:1127)
>
> 	if (up->bugs & UART_BUG_TXEN) {
> 		unsigned char lsr, iir;
> 		lsr = serial_in(up, UART_LSR);
> 		iir = serial_in(up, UART_IIR);
> 		if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
> 			transmit_chars(up);
> 	}
>
> Correct me if I'm mistaken, but I see two possible race conditions with
> that piece of code:
>
> 1. What if the IIR actually equals UART_IIR_THRI at that point? The
>    read access will clear the interrupt condition and the workaround
>    will effect the actual opposite of its intention: Neither
>    serial8250_start_tx() nor the interrupt handler will start
>    transmitting characters for the ring buffer.
>
> 2. What if an interrupt is triggered shortly after reading the IIR?
>    Both serial8250_start_tx() and the interrupt handler will start
>    a transmission simultaneously.
>
> Problem #1 should be quite easy to deal with: If the IIR read comes out
> as UART_IIR_THRI then the interrupt handler won't initiate a
> transmission, so we should. I'm not entirely sure how to deal with #2,
> though. Maybe it's enough to clear the THRE bit while transmitting
> characters, maybe some kind of locking is required.
>
> Cheers,
> Ingo
>

With 8250 UARTs and clones, an interrupt occurs when the
transmitter holding register __becomes__ empty. That means
it must have had something in it.

Normally, one starts a transmit sequence by polling for
THRE (transmitter holding-register empty) from non-interrupt
code with interrupts enabled. It will usually not appear empty
when polled in this manner, until the last character(s)
have been sent out of the user buffer by interrupt code.
Once it appears empty (*), code sends the first byte from the
buffer. The interrupt code (for transmit) just puts each
new byte from the output buffer into the transmitter.
Ping/pong transmit buffers help synchronize operations.

(*) Even if it is not really empty, it will be by the time
the first byte is put into the TX holding register because
interrupts are NOT disabled and the interrupt that would
have cleared it was able to complete.

A common problem with 8250 UART code I've seen is that
writers often do this:

 	clear interrupts (spinlock)
 	read/check status
 	do something
 	enable interrupts (spin unlock)

This 'seems' correct, but allows sneaky things to happen between
when you read/check status and you actually handle it. To prevent
this, some writers set up a loop with the interrupts disabled.
Now, under heavy activity, the machine ends up being permanently
polled with the interrupts off. This is NotGood(tm).

To implement the above algorithm, the following has been successful.

user_write(....user_len)
{
     buf_len = check_output_buffer_space();	// Head - tail ? will
 						// always get larger or
 						// remain the same.
     len = MIN(buf_len, user_len);

     copy_from_user(transfer_buffer, user_buffer, len);	// Get user data

     spin_lock_irqsave(&uart_lock, flags);
     memcpy(&output_buffer[tail], transfer_buffer, len);
     tail += len;
     spin_unlock_irqrestore(&uart_lock, flags);
     do_transmit();	// With interrupts enabled
     return len;
}

//
// Used by both ISR and user write code. When called from
// the user write code, data will always be available unless
// it was just sent out by interrupt, at which case you
// accomplished the required task anyway.
//

do_transmit()
{
    if(output_buffer_has_data && uart_status(THRE))
        put_byte_into_UART();
}


isr()
{
    (interrupts are off by default)
    spin_lock(&uart_lock);
    do_transmit();
    do_receive();
    do_modem();
    spin_unlock(&uart_lock);
}




Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
