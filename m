Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265999AbRGCUjM>; Tue, 3 Jul 2001 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265996AbRGCUjC>; Tue, 3 Jul 2001 16:39:02 -0400
Received: from [64.7.140.42] ([64.7.140.42]:57283 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S265999AbRGCUiv>;
	Tue, 3 Jul 2001 16:38:51 -0400
Message-ID: <040a01c10400$9c6a2e40$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "James R Bruce" <bruce+@andrew.cmu.edu>, <linux-kernel@vger.kernel.org>
Cc: <tytso@mit.edu>
In-Reply-To: <IvEWK2Rz00018DeGw=@andrew.cmu.edu>
Subject: Re: serial port O_SYNC functionality in 2.4.5
Date: Tue, 3 Jul 2001 16:42:00 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "James R Bruce" <bruce+@andrew.cmu.edu>
> The overall size of the circular buffer would have to be decreased
> too, but that's more of a hack to fix it now; Which I guess is what it
> comes to.

I see what you're saying; AFAIUnderstand, the low latency patches
bypass the circular buffer. Or make it size one.

> This is not really a problem; 16 bytes of hardware buffering I can
> live with; at 19200 baud this is 7ms of lag.  The 4096 byte software
> buffer causes 1706ms of lag; That *is* a problem.  It's a bit like the
> difference between a hard disk drive's local buffer and the OS's (much
> larger) buffering.  O_SYNC on a disk garuntees that the output has
> been flushed to the disk, but maybe not the physical medium.  On a
> serial port, similar functionality would be to have output to pushed
> to the UART, but maybe not yet over the actual port.

Gotchya.

> The manpage seems to imply this would work, but it doesn't seem to
> affect the software buffering at all (I tried this yesterday).  AFAICT
> from looking at the driver, the low_latency mode only applies to
> reading, not writing: tty_flip_buffer_push(tty) is the only place the
> latency flag is ever checked, and that is only called in receive_chars
> in serial.c.  The application that caused this doesn't get any serial
> input whatsoever, so that won't (or at least shouldn't) get called.

Hm. I haven't looked at the low_latency stuff, I was just repeating what
I'd heard...

> I changed WAKEUP_CHARS to 1 rather than 256 (0 would cause processes
> to hang forever, btw), and SERIAL_XMIT_SIZE to 16 rather than
> PAGE_SIZE.  A proper solution would make this conditional on O_SYNC or
> low_latency or even a kernel option.  Suggestions?

If you check the code, the circ buffer will never have a count < 0, so the
hang
is predictible; tty is never called for more tx chars.

I'd say it should be part of low_latency. Although it's probably best to
have
rx low_latency and tx low_latency separately configurable. Honouring O_SYNC
might not be a bad idea as well.

Whatever option probably should make SERIAL_XMIT_SIZE == WAKEUP_CHARS;
SERIAL needs to be a power of two, so 2, 4, 8 or 16 would be good choices.
Probably should be similar to the rx low_latency.

Best way to get this in the serial driver is to do some patches for it
and send them to Ted. :-)

..Stu


