Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVBULZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVBULZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 06:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVBULZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 06:25:48 -0500
Received: from rainstorm.omikk.bme.hu ([152.66.114.242]:15109 "EHLO
	rainstorm.org") by vger.kernel.org with ESMTP id S261948AbVBULZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 06:25:21 -0500
Date: Mon, 21 Feb 2005 12:25:09 +0100 (CET)
From: PALFFY Daniel <dpalffy-lists@rainstorm.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: sata_sil data corruption
In-Reply-To: <421778E4.8060705@pobox.com>
Message-ID: <Pine.LNX.4.58.0502211219250.23186@rainstorm.org>
References: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org> <421778E4.8060705@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin, running on "rainstorm.org", analysis results
	(contact the administrator of that system for details):
	Content analysis details:   -2.8 points
	pts rule name              description
	--- ---------------------- ------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2005, Jeff Garzik wrote:

> PALFFY Daniel wrote:
> > Hi,
> >
> > I'm trying to set up a machine with a si3112a controller (lspci: 1095:3112
> > (rev 01) Subsystem: 1095:6112, cheap PCI card) and a ST3200822AS Rev:
> > 3.01 disk and I see continuous silent data corruption while reading the
> > disk. Writing seems to be ok. I have 2.6.10-ac1 built with conservative
> > options (UP, no PREEMPT, 8k stack, no regparm). After seeing problems I
> > tried to blacklist my drive to do MOD15, but it didn't help.
> >
> > Finally I did
> >
> >     unsigned long long i = 0;
> >     while (write(1, &i, sizeof(i)) != -1) i++;
> >
> > to the only primary partition while running sata_sil. Reading it back with
> >
> >     unsigned long long i=0, j;
> >     while (read(0, &j, sizeof(i)) == sizeof(i)) {
> >         if (j != i) fprintf(stderr, "diff at %llx: read: %llx\n", i, j);
> >         i++;
> >     }
> >
> > gives similar results, but always different:
> > diff at 5efff: read: 5ef24
> > diff at 7ffff: read: 7ff08
> > diff at 8ffff: read: 8ff51
> > diff at 97fff: read: 97f00
> > diff at affff: read: aff00
> > diff at bffff: read: bffac
> > diff at dffff: read: dff00
> > diff at efffe: read: eff00
> > diff at effff: read: eff00
> > diff at fffbf: read: fffff
> > and so on.
> >
> > Reading back the same data with the ide siimage driver worked for at least
> > 500MB without corrupted data, but dma doesn't work with that driver, this
> > is logged on about the first read attempt:
> >
> > hde: dma_intr: bad DMA status (dma_stat=76)
> > hde: dma_intr: status=0x50 { DriveReady SeekComplete }
> >
> > ide: failed opcode was: unknown
> > hde: DMA disabled
> > ide2: reset phy, status=0x00000113, siimage_reset
> > ide2: reset: success
> >
> > The machine is an old Compaq Prosignia 200, with a p2 300 and
> > 0000:00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
> > chipset. Relevant parts from dmesg:
> >
> > sata_sil:
> >
> > libata version 1.10 loaded.
> > sata_sil version 0.8
> > ata1: SATA max UDMA/100 cmd 0xC886A080 ctl 0xC886A08A bmdma 0xC886A000 irq 10
> > ata2: SATA max UDMA/100 cmd 0xC886A0C0 ctl 0xC886A0CA bmdma 0xC886A008 irq 10
> > ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
> > ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
> > ata1(0): applying Seagate errata fix
> > ata1: dev 0 configured for UDMA/100
> > scsi1 : sata_sil
> > ata2: no device found (phy stat 00000000)
> > scsi2 : sata_sil
> >   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
> > SCSI device sdb: drive cache: write back
> >
> > siimage:
> >
> > SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0a.0
> > SiI3112 Serial ATA: chipset revision 1
> > SiI3112 Serial ATA: 100% native mode on irq 10
> >     ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
> >     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
> > Probing IDE interface ide2...
> > hde: ST3200822AS, ATA DISK drive
> > hde: applying pessimistic Seagate errata fix
> > ide2 at 0xc886a080-0xc886a087,0xc886a08a on irq 10
> > hde: max request size: 7KiB
> > hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
> > hde: cache flushes supported
> >  hde:<3>hde: dma_intr: bad DMA status (dma_stat=76)
> > hde: dma_intr: status=0x50 { DriveReady SeekComplete }
> >
> > ide: failed opcode was: unknown
> >  hde1
> > Probing IDE interface ide3...
> > hdg: no response (status = 0xfe)
> > hde: dma_intr: bad DMA status (dma_stat=76)
> > hde: dma_intr: status=0x50 { DriveReady SeekComplete }
> >
> > ide: failed opcode was: unknown

Hi,

> Don't use --two-- drivers for the same hardware.
>
> Can you re-test with siimage disabled?

Of course it was disabled while testing sata_sil and vice-versa. I've just
tried that driver to test if the hardware was faulty. Since then, I've
tested the same disk/controller combo in a BX based PentiumII system, and
it worked perfectly fine, but in the Compaq machine it still failed with
2.6.10-ac10. So I think it might be some low-level hardware
incompatibility...

--
Daniel
			...and Linux for all.

