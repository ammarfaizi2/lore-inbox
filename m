Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTLCPXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264599AbTLCPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:23:30 -0500
Received: from news.cistron.nl ([62.216.30.38]:10988 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264593AbTLCPXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:23:14 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: irq 19: nobody cared! with siimage and hdparm -X66 -d1
Date: Wed, 3 Dec 2003 15:23:13 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bqkv51$4nf$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1070464993 4847 62.216.29.200 (3 Dec 2003 15:23:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got "irq 19: nobody cared!" when using the siimage driver on
2.6.0-test11 and executing hdparm -X66 -d1.

I have the following disks in this machine:

1x maxtor PATA on Intel ICH5 (ide0)
2x maxtor SATA on Intel ICH5 (ide1)
2x maxtor SATA on siimage    (ide2, ide3)

This is the relevant part of the bootlog:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 6Y080M0, ATA DISK drive
hdd: Maxtor 6Y080M0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:03:03.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 19
    ide2: MMIO-DMA at 0xf8807e00-0xf8807e07, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf8807e08-0xf8807e0f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y080M0, ATA DISK drive
ide2 at 0xf8807e80-0xf8807e87,0xf8807e8a on irq 19
hdg: Maxtor 6Y080M0, ATA DISK drive
ide3 at 0xf8807ec0-0xf8807ec7,0xf8807eca on irq 19
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
 hdc: hdc1 hdc2
hdd: max request size: 128KiB
hdd: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
 hdd: hdd1
hde: max request size: 64KiB
hde: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63
 hde: hde1
hdg: max request size: 64KiB
hdg: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63
 hdg: hdg1

The drives on the siimage controller show a bit less performance
than the drives on the Intel controller:

# hdparm -t /dev/hdc
 Timing buffered disk reads:  64 MB in  1.27 seconds = 50.52 MB/sec
# hdparm -t /dev/hde
 Timing buffered disk reads:  64 MB in  1.42 seconds = 45.11 MB/sec

Because the hde and hdg drives didn't show that DMA was
enabled, I enabled it with hdparm:

quantum:/etc/init.d# hdparm -X66 -d1 /dev/hdg
 
And that resulted in this kernel message:

blk: queue f7dfac00, /dev/hdg:
 setting using_dma to 1 (on)
I/O limit 4095Mb (mask 0xffffffff)
 setting xfermode to 66 (UltraDMA mode2)
 using_dma    =  1 (on)

irq 19: nobody cared!
Call Trace:
 [<c010aaba>] __report_bad_irq+0x32/0x90
 [<c010ab90>] note_interrupt+0x50/0x78
 [<c010ad90>] do_IRQ+0xc0/0x124
 [<c0105000>] _stext+0x0/0x48
 [<c0109644>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x48
 [<c0106de9>] default_idle+0x29/0x34
 [<c0106e6c>] cpu_idle+0x30/0x40
 [<c0105045>] _stext+0x45/0x48
 [<c031c771>] start_kernel+0x14d/0x154
                                       
handlers:
[<c01ee814>] (ide_intr+0x0/0x158)
[<c01ee814>] (ide_intr+0x0/0x158)
Disabling IRQ #19

For now, I have rebooted and don't use -X66 -d1. It looks like
DMA is enabled anyway:

# hdparm -I /dev/hdg
ATA device, with non-removable media
        Model Number:       Maxtor 6Y080M0
        Serial Number:      Y3J7GL5E
        Firmware Revision:  YAR51BW0
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

It even shows "udma5" while the disks on the ICH5 controller show:

# hdparm -I /dev/hdc
ATA device, with non-removable media
        Model Number:       Maxtor 6Y080M0
        Serial Number:      Y3J7GKAE
        Firmware Revision:  YAR51BW0
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

Hmm, udma2, no multiple sector support. I'm beginning to think all
this is nonsense for SATA controllers/disks, since udma2 could
never get 50 MB/sec. Right ?

Mike.

