Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313736AbSDIFc1>; Tue, 9 Apr 2002 01:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313742AbSDIFc0>; Tue, 9 Apr 2002 01:32:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60681
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313736AbSDIFcY>; Tue, 9 Apr 2002 01:32:24 -0400
Date: Mon, 8 Apr 2002 22:31:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] IDE tagged command queueing support
In-Reply-To: <20020408120713.GB25984@suse.de>
Message-ID: <Pine.LNX.4.10.10204082222410.21890-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It fails for the most part because there are (3) three holes in the state
diagram.  Intel works because the hardware is smart.  Highpoint 366 works
because of the host polling timer (will add soon in 2.4).  The majority
will fail because of the invalid state the drive leaves the host.  Since
the host does not receive proper notice of the command block execution as
a direct result of the device failing to default to a fixed state, it
becomes a mess.  In short, until the intelligent host hardware hits the
market, nobody supports Tagged Command Queue.  The reason it is randomly
supported by FreeBSD is because it uses the host hardware polling
interrupt.  Otherwise the overhead for spinning and chortling cpu clock
cycles is a lark.

Well have fun but expect little success on most hardware.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Mon, 8 Apr 2002, Jens Axboe wrote:

> Hi,
> 
> I've implemented tagged command queueing for ATA disk drives, and it's
> now ready for people to give it a test spin. As it has had only limited
> testing so far, please be very careful with it. It has been tested on
> two drives so far, a GXP75-30gb and a GXP120-40gb, and with a PIIX4
> controller:
> 
> Intel Corp. 82371AB PIIX4 IDE: IDE controller on PCI slot 00:04.1
> Intel Corp. 82371AB PIIX4 IDE: chipset revision 1
> Intel Corp. 82371AB PIIX4 IDE: not 100% native mode: will probe irqs later
> PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:04.1
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> hda: IC35L040AVVA07-0, ATA DISK drive
> hdc: IBM-DTLA-307030, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: tagged command queueing enabled, command queue depth 32
> hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(33)
> hdc: tagged command queueing enabled, command queue depth 32
> hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(33)
> 
> I haven't patched hdparm to support enabling TCQ yet, so please use the
> 'TCQ on by default' option. If TCQ has been selected an enabled, there
> should be a 'tcq' file in the ide proc directory which will give you a
> bit of info about the current state of the drive:
> 
> bart:~ # cat /proc/ide/hdc/tcq 
> Max queue depth:        32
> Max achieved depth:     23
> Max depth since last:   16
> Current depth:          10
> ar dfd9e120 is tag 2
> ar dfd9e360 is tag 3
> ar dfd9e660 is tag 4
> ar dfd9e5a0 is tag 5
> ar dfd9e7e0 is tag 6
> ar dfd9e600 is tag 7
> ar dfd9e480 is tag 8
> ar dfd9e2a0 is tag 9
> ar dfd9e300 is tag 14
> ar dfd9e720 is tag 15
> hwgroup busy
> dma busy
> oldest command 5
> immed rel 1153, immed comp 12370
> 
> As this is the first release, some of this info is a bit
> user-unfriendly. Let me explain the fields:
> 
> The first four are about the queue depth: maximum supported, maximum
> achieved during operations, maximum achieved since last cat of file, and
> the current depth at the time of the file cat. Then follows a listing of
> the requests in progress. Then some debug info about hwgroup and dma
> busy states, and oldest command (in jiffies) in the queue. The last line
> indicates the status of sent commands -- either they released the bus
> immediately (immed rel: data not ready, we can queue another), or the
> drive chose to fetch data immediately (immed comp, no bus release).
> 
> I could talk a bit about the IDE cores changes needed to make this
> happen (ata_request_t stuff), but I'm too lazy and will wait until
> people ask about it. Note that I'm no particular fan of hungarian
> notation either, but (again) due to laziness I've used that because it's
> easier on the typing fingers. Things are bound to change from this first
> alpha release anyways, so I'll just wait.
> 
> If you have a recent IBM Deskstar drive (these are the only ones that
> support TCQ current, to my knowledge), I would appreciate if you could
> give it a spin and report success and failure to me.
> 
> Random notes:
> 
> - For this release, only a single drive on a channel has been tested. So
>   don't bother filing bug reports if you don't have a similar setup in
>   that regard.
> - Interrupt handler timer needs to be changed to be per-ata_request, not
>   per hwgroup.
> - General ata_request stuff isn't design complete yet, this could be
>   taken much further.
> - Due to memory consumption friendliness, block queues are configured
>   for a maximum of 32 segments at this time. This is still enough to
>   achieve the full 128kb for a dma request that we support anyways
>   (modulo 48-bit lba, doesn't matter).
> - TCQ can't be supported on Promise controllers at all, it intercepts
>   interrupts so we don't see them.
> - Backing off TCQ in case of failure is untested.
> - ide.h TCQ stuff needs some cleaning
> 
> That said, please give it a go if you can! Patch is against 2.5.8-pre2.
> 
> -- 
> Jens Axboe
> 
> 

