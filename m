Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSCCQki>; Sun, 3 Mar 2002 11:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSCCQk3>; Sun, 3 Mar 2002 11:40:29 -0500
Received: from nef.ens.fr ([129.199.96.32]:24080 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S287425AbSCCQkW>;
	Sun, 3 Mar 2002 11:40:22 -0500
Date: Sun, 3 Mar 2002 17:40:14 +0100
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: hard drive UDMA weirdness
Message-ID: <20020303174014.A3393@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

[Summary: the very same hard drive works fine in UDMA-33 mode on one
computer and not on another, whereas they run the same version of
Linux and have near-identical motherboards and BIOS versions.]

[Detailed hardware configuration is given at bottom.]

[Long description of problem follows.]

IDE/ATA hard drives have given me nothing but headaches (though SCSI
has always been worse, but I digress).  Their propensity for reverting
to their (s)lowest (non-DMA) possible mode of operation at the
slightest imagined problem is simply maddening.  And I found that the
problem is frequently quite impossible to track.  So I ask for help
with my present trouble, which may or may not be Linux-related.

I have two computers with nearly identical configurations.  One, which
I shall call "vega", is a dual-PentiumII with an Asus P2B-D
motherboard; the other, which I shall call "orion", is a (single)
PentiumII with an Asus P2B-S motherboard.  Both feature Intel 440BX
chipsets, which, as far as I figure, is the relevant datum as far as
IDE support is concerned.  I am not completely clear as to what IDE
operation modes are, but I believe these motherboards are aware of
UDMA-33 but not of the higher modes (UDMA-66 and UDMA-100).

I use a large hard drive to mass transfer data between those two
computers.  Up to recently, I had a 40Gb IBM drive, UDMA-100
compliant, which worked fine, apparently in UDMA-33 mode, on both
computers, except that I had had to upgrade the (Award) BIOS version
from release 1011 to release 1012 (resp. 1012B on vega) for the
computers to boot with the new hard drive.  This drive, however,
developed a case of damaged sectors, so I bought a new one, this time
an 80Gb Western Digital.  I had to upgrade the BIOS version a second
time, to release 1013 (resp. 1013beta7 on vega) because the former
version only worked for drives of up to 65Gb (here I restrain with
great difficutly from calling the Award programmers all sorts of nasty
names).

On both computers the new WD drive is correctly detected by the (new)
BIOS.  The BIOS menu settings are, as far as I can see, essentially
identical, and demand that the drive be operated in UDMA mode.  And,
indeed, the Linux kernel seems to agree on that when it boots - it
says something like

    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:DMA

(here the concerned drive is hdb).  I then run hdparm on the drive
with the following options: -d1 -u1 -m16 -c3 (the -d1 is necessary
because I have CONFIG_IDEDMA_PCI_AUTO=N for "safety").  This seems to
succeed.  At this point the behavior is exactly the same on both
computers.

However, at the next step they diverge.  I run hdparm -tT on the
drive: on vega the kernel reports no error and the speed measured by
hdparm for buffered disk reads is roughly 20Mb/s.  On orion, the
kernel outputs the following messages:

hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: master: error (0x51?)

and hdparm measures a speed of roughly 8Mb/s.  The -d switch of hdparm
is then automagically turned off.  If I force it on again, the drive
becomes non-functional (every attempt to read fails with an I/O error)
and the kernel can even freeze.

I cannot understand the reason for the difference between vega (which
works) and orion (which does not).  The chipset is the same, the
kernel version is the same (2.4.17), the BIOS settings are essentially
the same, and so are most relevant kernel settings; the Award BIOS
version is very small (1013beta7 for vega, which works, and 1013 for
orion, which does not).  On vega the drive is slave with to a master
which functions correctly; on orion it is single, but I have tried it
in every functioning mode (master, slave, single, cable select) to no
avail.

Any hints as to what could be causing the problem are welcome.  Any
indication on what to test and how to test it are also.  And general
explanations concerning IDE/ATA and UDMA modes might also be useful.

[Detailed config follows.]

The drive itself (which only works on vega): Western Digital WDC
WD800BB-00CAA0, 80Gb capacity, 7200rpm.

The former drive (which worked on both computers): IBM Deskstar 60GXP
IC35L040AVER07-0, 40Gb capacity.

The computer on which the drive works ("vega"): dual PentiumII@450MHz,
Asus P2B-D motherboard, 256Mb RAM, Award BIOS (downloaded from Asus'
web site) revision 1013beta7; master drive for IDE controller: Western
Digital WDC WD136AA.

The computer on which the drive does not work ("orion"):
PentiumII@400MHz, Asus P2B-S motherboard, 256Mb RAM, Award BIOS
(downloaded from Asus' ftp site) revision 1013; no other drive on IDE
controller (incriminated drive was tested in all possible
configurations).

Software configuration: between RedHat-7.1 and RedHat-7.2; Linux
kernel version 2.4.17 (pristine from ftp.kernel.org) configured for
SMP on vega.

Kernel configuration excerpt:

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y

(identical on both machines).

Boot messages excerpt on vega:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD136AA, ATA DISK drive
hdb: WDC WD800BB-00CAA0, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
hdd: Memorex DVD-ROM DVD-632, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63

Boot messages excerpt on orion:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hdb: C/H/S=20510/81/228 from BIOS ignored
hdb: WDC WD800BB-00CAA0, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63


[Please send Cc of replies to <david.madore@ens.fr>]

Thanks for any hints!

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
