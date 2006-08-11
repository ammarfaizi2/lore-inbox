Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWHKIwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWHKIwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWHKIwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:52:07 -0400
Received: from mail.oxtel.com ([195.219.3.158]:44813 "EHLO oxtel.com")
	by vger.kernel.org with ESMTP id S1750900AbWHKIwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:52:06 -0400
Message-ID: <44DC4530.4040906@miranda.com>
Date: Fri, 11 Aug 2006 09:52:00 +0100
From: Chris Pringle <chris.pringle@miranda.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial driver 8250 hangs the kernel with the VIA Nehemiah...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: chris.pringle
X-Server: VPOP3 Enterprise V2.3.0e - Registered
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having problems with the 8250 serial driver. We have some custom
hardware that sits on the ISA bus, and has a number of 16C950/954 UARTs
on it. However, when the port is receiving a lot of data, it has the
tendency to either get corrupted data, or to crash the kernel.

I'm using the 2.6.13.1 kernel with low latency patches. I've also tried
the 2.6.17 kernel with low latency patches, and they also seem to fail.

The offending bit of code seems to be here:

static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int
offset)
{
        offset <<= up->port.regshift;

        switch (up->port.iotype) {
        case UPIO_HUB6:
                outb(up->port.hub6 - 1 + offset, up->port.iobase);
                return inb(up->port.iobase + 1);

        case UPIO_MEM:
                return readb(up->port.membase + offset);

        case UPIO_MEM32:
                return readl(up->port.membase + offset);

        default:
                return inb(up->port.iobase + offset);
        }

}

The "inb" as it is will sometimes return bad data - I'm guessing this
is due to ISA bus instability... Anyway I changed it to "inb_p" which
cured the corruption problem, but has introduced another issue - it
hangs the kernel.

Interestingly, it only hangs on systems with a VIA Nehemiah CPU, the
Intel Celerons seem to work fine. Could this be a problem with writing
to that dreaded port 0x080 within inb_p?

I've added in some of the kernel hacking options, including spinlock
detection etc. and it's not told me anything. And as expected, there's
nothing in the log files either. SysRq doesn't work, however the num
lock key does still flash if you hit NumLock.

I tried getting rid of the paused versions of inb, and adding in a
udelay of 2 immediately before - this helped a lot, but instead of
crashing after 15 minutes of continous activity, it takes around 12-36
hours. I've played with moving the udelay after the inb call as well -
but the results where the same.

Does anyone have any ideas what may be causing these issues? Why does
it only occur on the VIA chip and not the Celeron? I don't think the
problem is there when the low latency patches are not applied - so I'm
thinking it's probably a timing problem of some sort.

I wasn't sure whether the writing to port 0x080 was a problem for the
inb_p (in io.h) - so I tried changing it to the jumping approach, and
also tried the very long delays in io.h as well - however, neither had
any affect - if anything, they made it worse.

It should be noted that the Small Board Computer and the ISA cards are
exactly the same on all systems - it's only the CPU that's been
changed.

If anyone has any ideas how I can try and track down exactly where it's
crashing, or what the possibly causes might be, I would be very
grateful if you could give me some hints!

Cheers,
Chris.

-- 

______________________________
Chris Pringle
Software Engineer

Miranda Technologies Ltd.
Hithercroft Road
Wallingford
Oxfordshire OX10 9DG
UK

Tel. +44 1491 820206
Fax. +44 1491 820001
www.miranda.com

