Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265978AbRGCUFr>; Tue, 3 Jul 2001 16:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265993AbRGCUFh>; Tue, 3 Jul 2001 16:05:37 -0400
Received: from PO9.ANDREW.CMU.EDU ([128.2.10.109]:21892 "EHLO
	po9.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S265999AbRGCUFc>; Tue, 3 Jul 2001 16:05:32 -0400
Message-ID: <IvEWK2Rz00018DeGw=@andrew.cmu.edu>
Date: Tue,  3 Jul 2001 16:05:22 -0400 (EDT)
From: James R Bruce <bruce+@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: serial port O_SYNC functionality in 2.4.5
Cc: tytso@mit.edu, stuartm@connecttech.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Re: serial port O_SYNC func.. by "Stuart MacDonald"@conne 
> From: "James R Bruce" <bruce+@andrew.cmu.edu>
> > As far as I can tell from observed operation and from perusing the
> > code, O_SYNC doesn't seem to be supported by the serial driver in
> > 2.4.5.  Writes are forced as far as the serial.c's circular queue, but
> > O_SYNC seems to be ignored from there on, so any application trying to
> > do small synchronous writes to the serial port will end up backing it
> > up PAGE_SIZE bytes rather than getting synchronous operation (which is
> > incidentally what I was trying to do when I ran into this :).
> >
> > I'm unfamiliar with the serial driver so I'm not sure the right way to
> > fix it is, but perhaps using a smaller value for WAKEUP_CHARS from
> > drivers/char/serial.c when the port is opened with O_SYNC
> > functionality might do the trick (i.e. 0 rather than 256).
>
> That might help, but it might not. That will only make sure that the
> tx circular buffer is empty before getting another byte from the tty
> layer into the buffer.

The overall size of the circular buffer would have to be decreased
too, but that's more of a hack to fix it now; Which I guess is what it
comes to.

> I think you will find that the real problem is that bytes written
> into the hardware go into the fifo, and there's no general way to
> tell when a byte has be actually txed; not in regular operation.

This is not really a problem; 16 bytes of hardware buffering I can
live with; at 19200 baud this is 7ms of lag.  The 4096 byte software
buffer causes 1706ms of lag; That *is* a problem.  It's a bit like the
difference between a hard disk drive's local buffer and the OS's (much
larger) buffering.  O_SYNC on a disk garuntees that the output has
been flushed to the disk, but maybe not the physical medium.  On a
serial port, similar functionality would be to have output to pushed
to the UART, but maybe not yet over the actual port.

> You want to run the port in polled mode, which ensures one byte is
> txed/rxed at a time. It's slow and cpu intensive though. setserial's
> man page might have some info on this, also known as "low latency";
> meaning a specific byte has a low period of time between being rxed
> and read/written and txed.

The manpage seems to imply this would work, but it doesn't seem to
affect the software buffering at all (I tried this yesterday).  AFAICT
from looking at the driver, the low_latency mode only applies to
reading, not writing: tty_flip_buffer_push(tty) is the only place the
latency flag is ever checked, and that is only called in receive_chars
in serial.c.  The application that caused this doesn't get any serial
input whatsoever, so that won't (or at least shouldn't) get called.

I changed WAKEUP_CHARS to 1 rather than 256 (0 would cause processes
to hang forever, btw), and SERIAL_XMIT_SIZE to 16 rather than
PAGE_SIZE.  A proper solution would make this conditional on O_SYNC or
low_latency or even a kernel option.  Suggestions?

 - Jim Bruce

