Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSGFX5g>; Sat, 6 Jul 2002 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGFX5f>; Sat, 6 Jul 2002 19:57:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54794 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313867AbSGFX5e>; Sat, 6 Jul 2002 19:57:34 -0400
Date: Sun, 7 Jul 2002 01:00:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Serial: updated serial drivers
Message-ID: <20020707010009.C5242@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been maintaining a serial driver "off the side" of the ARM port
which cleans up the serial driver mess that we currently have, with
many duplications of serial.c, each with subtle bugs.

Since ARM seems to have a poliferation of various UARTs, each of them
different, if this were to carry on we'd end up with 6 or 7 more
copies of serial.c.  This is obviously unacceptable.

So, with a view to cutting down on this duplication, I split serial.c
into a core driver, which can be used by various "low level" serial
hardware drivers, including the ARM ones, but also the 8250/16550
drivers.

Jeff and Arjan (iirc) expressed some concern about the PCI and PNP
code in serial.c, so that got separated out in what has now come to
be known as the serial rewrite.

The only non-ARM driver this patch affects is the 8250/16550 serial.c
driver.  The others have not been ported to this infrastructure yet.

The patch does contain details on the interface between the low level
and core serial drivers.

This project was first announced to linux-kernel on 6 November 2001:

 http://marc.theaimsgroup.com/?l=linux-kernel&m=100504194616062&w=2

Linus has expressed an interest in merging this work; hence this
message.  Before I do send it to Linus, I would like to get some
feedback on the code.  So, here is the latest patch against 2.5.24:

 http://www.home.arm.linux.org.uk/cvs/serial-2.5.24.diff.bz2

It should cleanly apply to 2.5.24.  The names of the serial options
have changed, so use your favourite configuration program to select
the relevant options.

This patch affects the following mainline drivers:
	- 8250/16550 "generic" serial driver (serial.o)
	- PCMCIA serial probe module (serial_cs.o)

Please send any bug reports in my direction.  There is one specific
area that I'm unable to test here - 8250/16x50 "shared" interrupts
(where multiple 8250/16x50 devices share the same interrupt line).
I'm expecting my mailbox to overflow tomorrow, so...

Note that, as ever, 8250/16x50 sharing with non-serial devices is
NOT guaranteed to work on edge-based IRQ systems like PCs (and if
you want this to work you can either configure your kernel
appropriately, or pass "share_irqs=1" in modules.conf for
serial_8250.o)

The future:

 - work with tytso to integrate any relevant bits of serial_core.c
   with the tty layer.
 - fix bugs
 - there seems to be a fair number of people wanting support for
   the higher speeds of UARTs (eg 16C950 and most motherboard
   devices)
 - add support for driverfs
 - remove the silly situation where we have ports openable, but
   no hardware behind them (and use some other method to create
   serial devices on demand if still required)
 - remove callout functionality, which has been marked as such for
   a few years now.  tytso mentions that the only program this
   might break is minicom, which should be fixed.

I'm sure there's other stuff people want. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

