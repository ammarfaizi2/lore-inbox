Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311523AbSCTE4K>; Tue, 19 Mar 2002 23:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311554AbSCTE4B>; Tue, 19 Mar 2002 23:56:01 -0500
Received: from cs24344-28.austin.rr.com ([24.243.44.28]:22280 "EHLO
	explorer.dummynet") by vger.kernel.org with ESMTP
	id <S311523AbSCTEzu>; Tue, 19 Mar 2002 23:55:50 -0500
Date: Tue, 19 Mar 2002 22:55:35 -0600
From: Dan Hopper <ku4nf@austin.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Promise 20265 IDE chip gets detected in wrong order 2.4.x
Message-ID: <20020320045535.GA2242@yoda.dummynet>
Mail-Followup-To: Dan Hopper <ku4nf@austin.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I appear to have an issue with the detection order of IDE devices,
such that on-board IDE controllers get detected in the wrong order,
causing grief.

Details:  Soyo Dragon+ motherboard (KT266A-based) with Promise
PDC20265 ATA100 controller on the motherboard.  The Via and Promise
IDE controllers can be enabled simultaneously, and I have the
Promise chip in normal IDE (i.e. not RAID) mode.  I have three hard
drives on the Via chip, and a CDROM on the first cable of the
Promise controller.  

With the PDC20265 disabled, boot-up messages are thus, and the world
is fine with respect to loading Linux properly off of hda:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L080J4, ATA DISK drive
hdb: IC35L060AVER07-0, ATA DISK drive
hdc: ST380021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(100)
hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/63, UDMA(100)
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdb: hdb1 < hdb5 >
 hdc: unknown partition table

(Note that hdc is as yet unformatted so don't sweat that partition
table warning up there.)


Now, when I enable the Promise controller in the BIOS, problems
ensue with respect to the ordering of the assignments of ide0/1 and
ide3/4:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 68
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:pio
hde: MAXTOR 6L080J4, ATA DISK drive
hdf: IC35L060AVER07-0, ATA DISK drive
hdg: ST380021A, ATA DISK drive
hda: Pioneer DVD-ROM ATAPIModel DVD-114 0110, ATAPI CD/DVD-ROM drive
ide0 at 0x1400-0x1407,0xc802 on irq 5
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15

And so, things go downhill from there ending in a kernel panic since
it can't find the root Linux partition, which is now unfortunately
located on what it's calling hde instead of hda.  This is just too
bad.


And finally, the only "fix" I've found so far, which is to stick an
append="ide0=0x1f0,0x3f6 ide1=0x170,0x376"
in lilo.conf.  This results in a successful boot with everything
back where I'd expect:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 68
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:DMA
    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L080J4, ATA DISK drive
hdb: IC35L060AVER07-0, ATA DISK drive
hdc: ST380021A, ATA DISK drive
hde: Pioneer DVD-ROM ATAPIModel DVD-114 0110, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x1400-0x1407,0xc802 on irq 5
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(100)
hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/63, UDMA(100)
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hde: ATAPI DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdb: hdb1 < hdb5 >
 hdc: unknown partition table


So, to summarize, my question is:  Why the heck is it assigning the
first and second IDE channels, which are properly on ports 0x1f0 and
0x170, to ide2 and ide3 instead of ide0 and ide1?  This seems at
odds with the IDE docs I've looked at.

True, I have a workaround, but that's quite a kernel parameter to
have to lug around from now on.  I'd rather it just "do the right
thing", which seems to me to always put the Via controller on 0x1f0
and 0x170 to ide0/ide1.  Anyone have any suggestions?  Looks kind of
like a bug to me, but it could be a misunderstanding on my part.

Thanks!
Dan Hopper
