Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUL1NR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUL1NR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 08:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUL1NR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 08:17:29 -0500
Received: from rainstorm.omikk.bme.hu ([152.66.114.242]:62981 "EHLO
	rainstorm.org") by vger.kernel.org with ESMTP id S261175AbUL1NRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 08:17:12 -0500
Date: Tue, 28 Dec 2004 14:17:00 +0100 (CET)
From: PALFFY Daniel <dpalffy-lists@rainstorm.org>
To: linux-kernel@vger.kernel.org
cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: sata_sil data corruption
Message-ID: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
X-Spam-Report: SpamAssassin, running on "rainstorm.org", analysis results
	(contact the administrator of that system for details):
	Content analysis details:   0.0 points
	pts rule name              description
	--- ---------------------- ------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to set up a machine with a si3112a controller (lspci: 1095:3112
(rev 01) Subsystem: 1095:6112, cheap PCI card) and a ST3200822AS Rev:
3.01 disk and I see continuous silent data corruption while reading the
disk. Writing seems to be ok. I have 2.6.10-ac1 built with conservative
options (UP, no PREEMPT, 8k stack, no regparm). After seeing problems I
tried to blacklist my drive to do MOD15, but it didn't help.

Finally I did

    unsigned long long i = 0;
    while (write(1, &i, sizeof(i)) != -1) i++;

to the only primary partition while running sata_sil. Reading it back with

    unsigned long long i=0, j;
    while (read(0, &j, sizeof(i)) == sizeof(i)) {
        if (j != i) fprintf(stderr, "diff at %llx: read: %llx\n", i, j);
        i++;
    }

gives similar results, but always different:
diff at 5efff: read: 5ef24
diff at 7ffff: read: 7ff08
diff at 8ffff: read: 8ff51
diff at 97fff: read: 97f00
diff at affff: read: aff00
diff at bffff: read: bffac
diff at dffff: read: dff00
diff at efffe: read: eff00
diff at effff: read: eff00
diff at fffbf: read: fffff
and so on.

Reading back the same data with the ide siimage driver worked for at least
500MB without corrupted data, but dma doesn't work with that driver, this
is logged on about the first read attempt:

hde: dma_intr: bad DMA status (dma_stat=76)
hde: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown
hde: DMA disabled
ide2: reset phy, status=0x00000113, siimage_reset
ide2: reset: success

The machine is an old Compaq Prosignia 200, with a p2 300 and
0000:00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
chipset. Relevant parts from dmesg:

sata_sil:

libata version 1.10 loaded.
sata_sil version 0.8
ata1: SATA max UDMA/100 cmd 0xC886A080 ctl 0xC886A08A bmdma 0xC886A000 irq 10
ata2: SATA max UDMA/100 cmd 0xC886A0C0 ctl 0xC886A0CA bmdma 0xC886A008 irq 10
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata1(0): applying Seagate errata fix
ata1: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata2: no device found (phy stat 00000000)
scsi2 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back

siimage:

SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0a.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: 100% native mode on irq 10
    ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: ST3200822AS, ATA DISK drive
hde: applying pessimistic Seagate errata fix
ide2 at 0xc886a080-0xc886a087,0xc886a08a on irq 10
hde: max request size: 7KiB
hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
hde: cache flushes supported
 hde:<3>hde: dma_intr: bad DMA status (dma_stat=76)
hde: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown
 hde1
Probing IDE interface ide3...
hdg: no response (status = 0xfe)
hde: dma_intr: bad DMA status (dma_stat=76)
hde: dma_intr: status=0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown


Any ideas how to fix this? Please tell me if you need more information.

Thanks in advance

--
Daniel
			...and Linux for all.

