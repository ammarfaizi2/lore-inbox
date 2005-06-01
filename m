Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFAWV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFAWV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFAWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:18:55 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:42371 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261195AbVFAWRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:17:00 -0400
Message-ID: <429E3338.9000401@keyaccess.nl>
Date: Thu, 02 Jun 2005 00:14:16 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net>
In-Reply-To: <200506011240.09540.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> On Wednesday 01 June 2005 11:25 am, Rene Herman wrote:

>>				: hdparm -t /dev/hda = 50 MB/s
>>1. modprobe ehci_hcd		: hdparm -t /dev/hda = 50 MB/s
>>2. switch on USB2 drive	: hdparm -t /dev/hda = 42 MB/s
>>3. switch off USB drive	: hdparm -t /dev/hda = 42 MB/s
>>4. modprobe -r ehci_hcd	: hdparm -t /dev/hda = 50 MB/s
> 
> 
> So it's as if the controller remembers that the drive was once turned
> on, and then chews up 8+ MB/sec of bus bandwidth somehow until its driver
> is removed -- right?

Right.

> Unplugging the drive (vs just poweroff), same?

Yes, unplugging does not make a difference.

> One more experiment to try:  with CONFIG_USB_DEBUG, have a look at
> the relevant /sys/class/usb_host/usbN/registers file.

[ snip ]

> The experiment: verify that only the RUN bit is set on your machine
> too. If "Periodic" and/or "Async" bits are set, then the controller
> is _supposed_ to be issuing DMA transfers over PCI, so less bandwidth
> will be available. Otherwise, not.

Thanks for all the explanation. Indeed only the run bit is set here it 
seems. Here are two instances of /sys/class/usb_host/usb1/registers; the 
first one immediately after modprobe ehci_hcd, while hdparm -t /dev/hda 
still gives me 50 MB/s:

===
bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
EHCI 1.00, hcd state 1
structural params 0x00002204
capability params 0x00006872
status 0008 FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 01d4
port 1 status 001000 POWER sig=se0
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001000 POWER sig=se0
irq normal 0 err 0 reclaim 0 (lost 0)
complete 0 unlink 0
===

and one after switching on the USB2 HDD, when the hdparm result for hda 
has dropped to 42 MB/s:

===
bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
EHCI 1.00, hcd state 1
structural params 0x00002204
capability params 0x00006872
status a008 Async Recl FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 21cc
port 1 status 001005 POWER sig=se0  PE CONNECT
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001000 POWER sig=se0
irq normal 136 err 0 reclaim 17 (lost 0)
complete 27 unlink 0
===

Not much difference between the two but I though I'd post them both in 
case that "reclaim" number means anything to you. In any case, the 
"command" line is the same as the example one you posted so no answers 
there it seems.

> VIA's EHCI has been more consistently wierd than any other vendor's
> implementation.  The VT6202 (initial implementation) has never seemed
> to work right.  And although the newer implementations appear to work
> OK with the current driver, that's largely due to workarounds that
> address some fairly important IRQ dropouts.  I've always suspected
> they have strange things going on with their DMA, too; performance
> patterns were just too wierd to explain otherwise.

"Strange goings on" I can confirm at least. By the way, as seen from the 
above, the USB2 HDD is now on port1. It was on port 3, with a (Iiyama 
monitor) USB 1.1 HUB on port 1, with my mouse connected to that hub. 
After seeing you comment in the other thread that UHCI did always do DMA 
I compiled out UHCI, re-enabled my onboard OHCI controller (I have it 
disabled since I put in this controller since it takes yet another IRQ 
and seems rather superfluous) and plugged the monitor hub into that again.

No change whatsoever unfortunately (but I guess I should keep it this 
way, EHCI and OHCI, no UHCI?)

No change with UHCI _nor_ OHCI loaded either.

The VT6212 is on a combo controller with a unused NEC firewire 
controller, different IRQ. Also no change between ohci1394 loaded or 
unloaded.

Which was to be expected, but hey, I'll try anything by now...

>>More detail --- it's a VIA VT6212L EHCI controller, on unshared IRQ3. 
>>IDE0 is AMD756 on unshared IRQ14/15. The USB2 HDD does 30 MB/s (after a 
>>hdparm -a 1024; with the default 256 it's 25MB/s) which I did think was 
>>a very good speed.
> 
> 
> The VT6212 never showed me any problems the last time I tested with it,
> other than the IRQ lossage I've seen with all VIA EHCI silicon.  And
> yes, 30 MB/sec is pretty good; not all disks, or hosts, will do that.

The disk is a Western Digital Essential 160G.

> A more hardware-oriented experiment would be to see if a non-VIA card
> does the same thing ... most NEC cards won't get you that same data
> transfer rate (newer ones might), maybe ALI will.

Unfortunately I don't have a second controller available to test. Until 
recently I only had the onboard OHCI controller. Bought this one 
together with the drive. Thought I was buying a NEC one by the way; the 
information on the manufacturer's website said so, but when it arrived 
it was a "Rev. B" with the VIA VT6212L. I _really_ hope this is not some 
VIA specific crapola again...

> The most hardware-oriented experiment is to stick a logic analyser on
> your PCI bus and see what's up.  Maybe it's not doing DMA, but it's
> still arbitrating for the bus or something.  And maybe the AMD PCI is
> fighting with the VIA PCI somehow; I seem to recall problems of that
> ilk from chips of that era.

Sound scary. Must say I do generally have a lot of faith in this chipset 
(AMD751/756). The machine's been as stable as a rock for years now. A 
logic analyser I do not have, nor the ability to interpret it if I did.

I did just now try two different PCI slots. Again no change.

Erhhm. rmmoding ehci-hcd works. I suppose it tells the hardware to shut 
up on module_exit. is there any way to have it tell the hardware the 
same while keeping it loaded? Any other ideas?

Thanks,
Rene.
