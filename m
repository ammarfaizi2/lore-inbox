Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbTCXHSP>; Mon, 24 Mar 2003 02:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTCXHSP>; Mon, 24 Mar 2003 02:18:15 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:63114 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S261454AbTCXHSI>;
	Mon, 24 Mar 2003 02:18:08 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Mon, 24 Mar 2003 08:29:10 +0100
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: [IDE SiI680] throughput drop to 1/4
Message-ID: <20030324072910.GA16596@pc11.op.pod.cz>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi!

  Recently I tried to figure out in 2.5.65, why throughput on my disk which
hangs on Silicon Image 680 dropped to 1/4 compared to 2.4.21-pre5, but didn't
found anything useful. Are there any known issues with this driver?
  Comparing those two drivers - they are exactly the same. Cabling is OK
(with 80w cable), the driver correctly detects this (checked with this simple
patch:

diff -urN -X dontdiff linux-2.5.65/drivers/ide/pci/siimage.c linux-2.5.65-sii/drivers/ide/pci/siimage.c
--- linux-2.5.65/drivers/ide/pci/siimage.c      2003-02-25 21:30:39.000000000 +0100
+++ linux-2.5.65-sii/drivers/ide/pci/siimage.c  2003-03-23 21:36:37.000000000 +0100
@@ -90,8 +90,11 @@
                        break;
                default:        return 0;
        }
-       if (!eighty_ninty_three(drive))
+       if (!eighty_ninty_three(drive)) {
                mode = min(mode, (u8)1);
+               printk(KERN_DEBUG "SiI680: using 40w cable\n");
+       } else
+               printk(KERN_DEBUG "SiI680: using 80w cable\n");
        return mode;
 }

Throughput measured with hdparm-5.3:

                              2.4.21-pre5            2.5.65
                              -----------            ------
 Timing buffer-cache reads:   88.0 MB/sec          88.0 MB/sec
 Timing buffered disk reads:  40.0 MB/sec          11.6 MB/sec

Machine: Intel Celeron-333
         320 MiB RAM
         1st disk: WDC AC24300L (on integrated piix IDE)
         2nd disk: ST380021A (on SiI680: the only thing on this interface)



	Thanks,
		Vita


---- lspci: -------------------
00:10.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3680
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at d400 [size=8]
        I/O ports at d800 [size=4]
        I/O ports at dc00 [size=8]
        I/O ports at e000 [size=4]
        I/O ports at e400 [size=16]
        Memory at e8000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at e7000000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
---- dmesg: 2.4.21-pre5 -------
[snipped]
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
SiI680: IDE controller at PCI slot 00:10.0
PCI: Found IRQ 10 for device 00:10.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide2: MMIO-DMA at 0xd4800000-0xd4800007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xd4800008-0xd480000f, BIOS settings: hdg:pio, hdh:pio
hda: WDC AC24300L, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
hde: ST380021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd4800080-0xd4800087,0xd480008a on irq 10
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: host protected area => 1
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=524/255/63
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hda: hda1 hda2 hda3 hda4
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
ide-floppy driver 0.99.newide
[snipped]
---- dmesg: 2.5.65 ------------
[snipped]
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC24300L, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI680: IDE controller at PCI slot 00:10.0
PCI: Found IRQ 10 for device 00:10.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide2: MMIO-DMA at 0xd4800000-0xd4800007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xd4800008-0xd480000f, BIOS settings: hdg:pio, hdh:pio
hde: ST380021A, ATA DISK drive
ide2 at 0xd4800080-0xd4800087,0xd480008a on irq 10
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: host protected area => 1
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=8912/15/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 hde10 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
[snipped]
---- hdparm /dev/hde: ---------------------
/dev/hde:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 16 (on)
 geometry     = 23989/16/63, sectors = 156301488, start = 0
---- hdparm -I /dev/hde: -------------------
ATA device, with non-removable media
        Model Number:       ST380021A
        Serial Number:      3HV1CHVZ
        Firmware Revision:  3.75
[snipped]
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
[snipped]
