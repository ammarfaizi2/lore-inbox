Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274684AbRJQFh2>; Wed, 17 Oct 2001 01:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274746AbRJQFhS>; Wed, 17 Oct 2001 01:37:18 -0400
Received: from astcc-281.astound.net ([24.219.123.215]:7175 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S274684AbRJQFhO>; Wed, 17 Oct 2001 01:37:14 -0400
Date: Tue, 16 Oct 2001 22:35:42 -0700 (PDT)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE initialization fix
In-Reply-To: <3BCCD31E.B94CA05A@sun.com>
Message-ID: <Pine.LNX.4.10.10110162223350.2087-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tim,

On Tue, 16 Oct 2001, Tim Hockin wrote:

> Andre Hedrick wrote:
> Andre, The summary of the change is this: without this change, the PCI init
> for chipsets does not get called.  I'll speak specifically about the CSB5. 
> The CSB5 in non-native mode has a PCI irqline register forced to 0.  The
> PCI probe then skips it's PCI init and it never gets called.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks CSB5: IDE controller on PCI bus 00 dev 79
ServerWorks CSB5: chipset revision 146
ServerWorks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 5T020H2, ATA DISK drive
hdb: Maxtor 5T020H2, ATA DISK drive
hdc: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
hdd: Imation Travan 20GB Tape, ATAPI TAPE drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63, UDMA(100)
hdb: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63, UDMA(100)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)

Oh like this one ??


00:0f.1 IDE interface: ServerWorks: Unknown device 0212 (rev 92)
00: 66 11 12 02 05 00 00 02 92 8a 01 01 08 40 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: b1 08 00 00 01 10 00 00 00 00 00 00 66 11 12 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 20 20 20 20 20 20 20 20 f0 50 44 44 00 00 00 00
50: 00 00 00 00 07 00 55 02 0f 04 03 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

> We then see that there is no file in /proc/ide for the serverworks
> chipset.  With this fix, there is.


beetle:/proc/ide # cat svwks

                                ServerWorks CSB5 Chipset.
------------------------------- General Status ---------------------------------
--------------- Primary Channel ---------------- Secondary Channel ------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
UDMA enabled:   yes              yes             yes               no
UDMA enabled:   5                5               2                 0
DMA enabled:    2                2               2                 2
PIO  enabled:   4                4               4                 4

> Is there something else we aren't doing, instead?  This seems obvious -
> there is NOWHERE else that calls the init_chipset() method.

Why are you putting it in non-native mode?
Oh, are you trying to run the RAID features?

> I put a printk in the pci_init_svwks routine, and it doesn't get called.

                    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD649) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_OSB4) ||
+                   IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB5) ||
                    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))) {

Try this....

Andre Hedrick
Linux Disk Certification Project		Linux ATA Development

