Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269365AbRGaQnM>; Tue, 31 Jul 2001 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269363AbRGaQnD>; Tue, 31 Jul 2001 12:43:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55570 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269366AbRGaQmx>;
	Tue, 31 Jul 2001 12:42:53 -0400
Date: Tue, 31 Jul 2001 17:42:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
Message-ID: <20010731174247.A21802@flint.arm.linux.org.uk>
In-Reply-To: <200107302332.f6UNWbxg001791@webber.adilger.int> <3B65F1A2.30708CC1@fc.hp.com> <000701c119cd$ebf0c720$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c119cd$ebf0c720$294b82ce@connecttech.com>; from stuartm@connecttech.com on Tue, Jul 31, 2001 at 10:34:35AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 10:34:35AM -0400, Stuart MacDonald wrote:
> That's very odd. That implies that serial consoles don't use the serial
> driver at all then, as the pci serial port setup is done at the same
> time as the regular serial port setups.
> 
> If a serial console is using serial.c, the pci serial ports will also
> be available.

No.  Console initialisation is done early, before PCI is setup.  This
means that the serial driver is relying on a static array of IO port
addresses.  At this time, the serial driver hasn't probed any ports at
all, so it doesn't really know what does and doesn't exist.

If, for example, you specify your console on ttyS25, (and you have
support for >=32 ports compiled in) I wonder what happens?  I can
see one of two things happening:

1. Kernel locks up waiting for the non-existent "transmitter" to become
   ready.
2. Kernel continues blindly writing to a non-existent port without
   locking up and you get no messages at all.

Now, this static table is updated after PCI and PNP initialisation, when
the ports are actually probed.  Your ttyS25 may now change port address
under the serial console!  I wonder what baud rate the messages come out
at?  75 baud? ;(

The more I think about this, the more that I think we need to get rid
of this early console initialisation.  I think Linus really wants early
console initialisation though, and to be honest, its an extremely useful
debugging tool for those pesky non-boots with blank displays.

[gratuitous plug]

I'm currently doing a lot of work on the serial drivers at the moment; the
ARM port currently has about 4 different uart based serial port types, and
I wasn't going to put up with 4 buggy copies of serial.c to drive each
type.

Therefore, I now have a set of serial drivers based around a serial core
(including the 16550 type) which I've been able to test out.  It is (I
hope) functionally equivalent to what is in 2.4.7.  It needs a little
more cleaning up, and a _lot_ more testing.  People interested can get
it from:

  :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot (no login password)

To access it:

  cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
  cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot co serial

  Server note: If you want to use -z, please don't use anything above -z3.
  (failure to follow this will result in anon cvs being withdrawn or
  restricted). Thanks.

What isn't provided at the moment are the patches to the Makefiles and
Config.in files.  I'll include a patch for that later this evening.

If someone would like to produce a patch which adds an option for early
console vs "normal" console initialisation...  Otherwise I'll add it to
my (longish) "to do" list.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

