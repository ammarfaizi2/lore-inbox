Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFATmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFATmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFATlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:41:40 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:43218 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261261AbVFATkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:40:32 -0400
From: David Brownell <david-b@pacbell.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: External USB2 HDD affects speed hda
Date: Wed, 1 Jun 2005 12:40:09 -0700
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl>
In-Reply-To: <429DFD90.10802@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200506011240.09540.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 11:25 am, Rene Herman wrote:
> Pavel Machek wrote:
> > On Út 31-05-05 01:21:37, Rene Herman wrote:
> 
> [ internal IDE HDD slowdown after switching on external USB2 HDD ]
> 
> > USB controller generating extra DMA load? Try rmmoding usb to see if
> > it goes away.
> 
> I was sceptical about this since the drive is idle (or even switched off 
> again) but I recompiled EHCI modular and rmmodding ehci_hcd does in fact 
> bring back my 50 MB/s:
> 
> 				: hdparm -t /dev/hda = 50 MB/s
> 1. modprobe ehci_hcd		: hdparm -t /dev/hda = 50 MB/s
> 2. switch on USB2 drive	: hdparm -t /dev/hda = 42 MB/s
> 3. switch off USB drive	: hdparm -t /dev/hda = 42 MB/s
> 4. modprobe -r ehci_hcd	: hdparm -t /dev/hda = 50 MB/s

So it's as if the controller remembers that the drive was once turned
on, and then chews up 8+ MB/sec of bus bandwidth somehow until its driver
is removed -- right?  Unplugging the drive (vs just poweroff), same?

One more experiment to try:  with CONFIG_USB_DEBUG, have a look at
the relevant /sys/class/usb_host/usbN/registers file.  Here's what
one looks like on one system:

	bus pci, device 0000:00:02.2 (driver 10 Dec 2004)
	nVidia Corporation nForce2 USB Controller
	EHCI 1.00, hcd state 1
	ownership 01000001 linux
	SMI sts/enable 0xe0080000
	structural params 0x00102486
	capability params 0x0000a086
	status 0008 FLR
	command 010009 (park)=0 ithresh=1 period=256 RUN
	intrenable 37 IAA FATAL PCD ERR INT
	uframe 0e1e
	port 1 status 001000 POWER sig=se0
	port 2 status 001005 POWER sig=se0 PE CONNECT
	port 3 status 001000 POWER sig=se0
	port 4 status 001000 POWER sig=se0
	port 5 status 003802 POWER OWNER sig=j CSC
	port 6 status 001000 POWER sig=se0
	irq normal 28 err 1 reclaim 18 (lost 0)
	complete 29 unlink 0

So there's a USB2 disk on port 2, a full speed device on port 5,
and the controller isn't doing anything much at all ... the RUN
command bit is set, which means it's sending out SOF tokens on
all enabled port(s).  (And it's not suspended, so there's probably
a clock at 48 MHz or so.)  But no transactions are active -- the
"periodic" and "async" schedules are empty, ditto the Periodic
and Async command bits are clear -- so it should be staying away
from PCI, no DMA load at all.

The experiment:  verify that only the RUN bit is set on your
machine too.  If "Periodic" and/or "Async" bits are set, then
the controller is _supposed_ to be issuing DMA transfers over
PCI, so less bandwidth will be available.  Otherwise, not.


> There would not seem to be any extra DMA load with a drive that's idle 
> or switched off again though? Is the (VIA) USB2 controller playing bus 
> monopolizing tricks or something sinister like that? (the speed doesn't 
> drop immediately after loading ehci_hcd though, only after switching on 
> the USB2 HDD)

VIA's EHCI has been more consistently wierd than any other vendor's
implementation.  The VT6202 (initial implementation) has never seemed
to work right.  And although the newer implementations appear to work
OK with the current driver, that's largely due to workarounds that
address some fairly important IRQ dropouts.  I've always suspected
they have strange things going on with their DMA, too; performance
patterns were just too wierd to explain otherwise.


> More detail --- it's a VIA VT6212L EHCI controller, on unshared IRQ3. 
> IDE0 is AMD756 on unshared IRQ14/15. The USB2 HDD does 30 MB/s (after a 
> hdparm -a 1024; with the default 256 it's 25MB/s) which I did think was 
> a very good speed.

The VT6212 never showed me any problems the last time I tested with it,
other than the IRQ lossage I've seen with all VIA EHCI silicon.  And
yes, 30 MB/sec is pretty good; not all disks, or hosts, will do that.

A more hardware-oriented experiment would be to see if a non-VIA card
does the same thing ... most NEC cards won't get you that same data
transfer rate (newer ones might), maybe ALI will.

The most hardware-oriented experiment is to stick a logic analyser on
your PCI bus and see what's up.  Maybe it's not doing DMA, but it's
still arbitrating for the bus or something.  And maybe the AMD PCI is
fighting with the VIA PCI somehow; I seem to recall problems of that
ilk from chips of that era.

- Dave

