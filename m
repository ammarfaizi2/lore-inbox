Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279696AbRJYHCE>; Thu, 25 Oct 2001 03:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279699AbRJYHBy>; Thu, 25 Oct 2001 03:01:54 -0400
Received: from oe19.law11.hotmail.com ([64.4.16.123]:52495 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S279696AbRJYHBk>;
	Thu, 25 Oct 2001 03:01:40 -0400
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: BUG: Promise Ultra100 (PDC20265) IRQ timeout Problem
Date: Thu, 25 Oct 2001 00:01:58 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE19PiFLlNWOT3d9AtJ00007006@hotmail.com>
X-OriginalArrivalTime: 25 Oct 2001 07:02:10.0135 (UTC) FILETIME=[F73D5E70:01C15D22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to install Mandrake 8.1 Beta 3, kernel 2.4.8, the install
crashes at some point in the middle of installing the RPM packages.  The
error happens regardless of whether or not DMA is enabled.  I used the new
ide=nodma boot parameter.  From the syslog, or by pressing ALT-F4, I get the
following errors:

****** WITH IDE=NODMA boot parameter ******

<4>hde: irq timeout: status=0xd0 {Busy}
<quite a long pause, about 20 seconds?>
<4>ide2: reset: master: formatter device error
<4>hde: set_geometry_intr: status=0x01 {Error}
<4>hde: set_geometry_intr: error=0x04 {DeviceStatusError}
<4>hde: status error: status=0x01 {Error}
<4>hde: status error: error=0x04 {DeviceStatusError}
<4>hde: drive not ready for command
<4>hde: status error: status=0x01 {Error}
<4>hde: status error: error=0x04 {DeviceStatusError}
<4>hde: drive not ready for command
<4>hde: status error: status=0x01 {Error}
<4>hde: status error: error=0x04 {DeviceStatusError}
<4>hde: drive not ready for command
<6>end_request: I/O error, dev 21:05 (hde), sector 14704392
<6>end_request: I/O error, dev 21:05 (hde), sector 14704400
<6>end_request: I/O error, dev 21:05 (hde), sector 14704408
et cetera....
(these end_request things go on for many screen-fulls)

****** WITHOUT IDE=NODMA boot parameter ******
(everything is the same except the first 4 lines below are different)

<4>hde: timeout waiting for DMA
<4>ide_dmaproc: chipset supported ide_dmaA_timeout func only: 14
<4>hde: status timeout: status=0x10 {Busy}
<4>hde: drive not ready for command
<4>ide2: reset: master: formatter device error
<4>hde: set_geometry_intr: status=0x01 {Error}
<4>hde: set_geometry_intr: error=0x04 {DeviceStatusError}
<4>hde: status error: status=0x01 {Error}
<4>hde: status error: error=0x04 {DeviceStatusError}
<4>hde: drive not ready for command
<4>hde: status error: status=0x01 {Error}
<4>hde: status error: error=0x04 {DeviceStatusError}
<4>hde: drive not ready for command
<4>hde: status error: status=0x01 {Error}
<4>hde: status error: error=0x04 {DeviceStatusError}
<4>hde: drive not ready for command
<6>end_request: I/O error, dev 21:05 (hde), sector 14704392
<6>end_request: I/O error, dev 21:05 (hde), sector 14704400
<6>end_request: I/O error, dev 21:05 (hde), sector 14704408
et cetera....
(these end_request things go on for many screen-fulls)


>From lpci, the offending device is below:
(Sorry I didn't know how to pipe these listings to somewhere useful.  Floppy
is the only place I can think of.  If someone wants to tell me how to do
this by e-mail privately, that would be nice.  I was using the mini-shell on
ALT-F2 which doesn't have the full subset of shell commands.  (Note: I don't
think "mount" is available, but I could be wrong...I think that was my
problem).)

unknown: Promise Technology, Inc. | 20265 [STORAGE_OTHER] SubVendor=0x105a
SubDevice=0x4d33

After these errors, I have to cold boot.  If I warm boot, the Promise
controller and/or the hard drive isn't detected by the BIOS.

What's going on here?  I've had these problems ever since I got my new
computer in the summer.  It has an A7V133 motherboard with a Via 686b
southbridge and the on-board Promise IDE.  The VIA doesn't work either, but
the Promise is what I'm trying to get working right now.  I've tried other
LInux distributions, and of course they are all pretty much the same.

I've looked through the source code for ide.c.  It looks like the two error
cases above are occuring probably for the same reason.  There is some
problem with the way the kernel is interfacing to the Promise chip and/or
hard drive (Quantum Fireball Plus AS).  The error messages are coming from
basically the same part of the code.  The timeout waiting for DMA is
occuring in ide_dma_timeout_retry function, which essentially disables DMA
and retries in PIO mode.  I can only suspect the PIO retry-ing is not
working at all.  This gets called inside of the ide_timer_expiry function,
which is the same function where the "irq timeout" error occurs.  So these
errors are basically the same thing in my opinion, the error messages just
change slightly.  Trying PIO mode is useless, since the drive is apparently
completely gone after the irq timeout occurs.  So my main problem here is
that this irq_timeout timer seems to be expiring, but not all the time.  If
fact, it happens very rarely if you think about it, since I can get through
installing at least 100 RPM packages in the Mandrake install before it
happens.  And once it does happen everything goes to hell.

Any ideas?  There is no "visible" problem with the drive and/or controllers.
They run fine under Windows.  If it matters (which I don't think it does) I
can get above 33 MBit/s in Windows which means that windows must be using
DMA right?  The other thing I suspect is that IRQ sharing is not working.
The Promise Controller is sharing with a device.  I think it's sharing with
my natsemi (netgear) ethernet card.

Thanks,
David Grant
