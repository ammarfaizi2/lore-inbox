Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTEVPeC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTEVPeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:34:01 -0400
Received: from greenie.frogspace.net ([64.6.248.2]:5788 "EHLO
	greenie.frogspace.net") by vger.kernel.org with ESMTP
	id S261950AbTEVPd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:33:56 -0400
Date: Thu, 22 May 2003 08:46:45 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: DMA gone on ALI 1533
Message-ID: <Pine.LNX.4.44.0305220846010.23179-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 2.5.69 kernel kicks butt -- Debian is now releasing a version in sid
and it runs stable on my vpr matrix 205A laptop. What works: nfs, samba,
v4l, the nVidia driver (patched), everything I've tested so far. And sound
-- the ALSA sound is great (headphone jack still dead). ACPI now detects
my battery, and I'm working on software suspend.

The ALI chipset (1671 northbridge, 1533 ISA bridge, 5229 IDE interface, 
7101 bridge) gives me
DMA 33 with 2.4.20:

    hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=4864/255/63, UDMA(33)

but no dma with 2.5.69.  Timing buffered disk reads now come in at
3.17MB/s -- in 2.4.20 I get 19.88 MB/sec. hdparm gives part number
IC25N040ATCS04-0, a Travelstar 40GN, which I believe supports a 100MHz
bus. The "idebus=66" never made a difference afaict.

Aside from the slower harddrive (see details below), I've had no issues 
with this kernel.

Is there a workaround for the dma, or something I'm missing? Incidentally,
it would be handy to have a bit more information in dmesg, along the lines
of the 2.4 kernel -- chipset, dma and bus speed per drive.

Cheers,
Peter




dmesg 2.5.69:

Kernel command line: root=/dev/hda5 ro hdc=scsi idebus=66 resume=/dev/hda6
ide_setup: hdc=scsi
ide_setup: idebus=66
No local APIC present or hardware disabled

PCI: PCI BIOS revision 2.10 entry at 0xfd88e, last bus=1
PCI: Using configuration type 1

PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
hda: IC25N040ATCS04-0, ATA DISK drive
hdc: MATSHITACD-RW CW-8121, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63
 hda: hda1 hda2 < hda5 hda6 hda7 > hda3 hda4
ide-cd: passing drive hdc to ide-scsi emulation.

hdparm -i claims to be using dma5:

hdparm -i /dev/hda

/dev/hda:

 Model=IC25N040ATCS04-0, FwRev=CA4OA71A, SerialNo=CSH405DCLW5UVB
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1768kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 3:  2 3 4 5

In contrast, hdparm /dev/hda claims dma is off:

# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 11984/16/63, sectors = 78140160, start = 0

The disk read speed in 2.5.69 indicates dma is off:

# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.46 seconds =280.74 MB/sec
 Timing buffered disk reads:  64 MB in 20.18 seconds =  3.17 MB/sec

# cat kernel-2.5.69.config | grep DMA
CONFIG_GENERIC_ISA_DMA=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set

Here's what 2.4.20 produces:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
hdc: MATSHITACD-RW CW-8121, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0335ee4, I/O limit 4095Mb (mask 0xffffffff)
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=4864/255/63, UDMA(33)

Disk information under 2.4.20 -- claims to be using dma2:

Model=IC25N040ATCS04-0, FwRev=CA4OA71A, SerialNo=CSH405DCLW5UVB
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
BuffType=DualPortCache, BuffSize=1768kB, MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 mdma2
UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5
AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
Drive conforms to: ATA/ATAPI-5 T13 1321D revision 3: 2 3 4 5

This fits with the disk read speed:

Timing buffer-cache reads: 128 MB in 0.44 seconds =290.91 MB/sec
Timing buffered disk reads: 64 MB in 3.22 seconds = 19.88 MB/sec

cat kernel-2.4.20-5-5.config | grep DMA
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_SOUND_DMAP is not set


