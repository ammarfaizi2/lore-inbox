Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLNOEv>; Thu, 14 Dec 2000 09:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbQLNOEl>; Thu, 14 Dec 2000 09:04:41 -0500
Received: from die-macht.oph.RWTH-Aachen.DE ([137.226.147.190]:29752 "EHLO
	die-macht") by vger.kernel.org with ESMTP id <S129401AbQLNOEc>;
	Thu, 14 Dec 2000 09:04:32 -0500
Message-ID: <3A38CC43.C20E26FD@die-macht.oph.rwth-aachen.de>
Date: Thu, 14 Dec 2000 14:33:55 +0100
From: Stefan Becker <stefan@die-macht.oph.rwth-aachen.de>
Reply-To: Stefan Becker <stefan@oph.rwth-aachen.de>
Organization: Otto Petersen Haus - Aachen
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dan Merillat <harik@chaos.ao.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE hang when using v4l (bttv) on all kernels.
In-Reply-To: <200012131411.eBDEBWo14000@vulpine.ao.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I see similar effects with IDE DMA. It isn't that bad but it may be
related.
The difference is that I use 2.2.18. Whether I use the
ide.2.2.18.1209.patch or not makes no difference.

My box doesn't lockup, but since I bought a second IDE harddisk I cannot
use DMA anymore.

Boot messages from IDE-driver:

[...]
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 93073U6, ATA DISK drive
hdc: Maxtor 34098H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: Maxtor 93073U6, 29311MB w/2048kB Cache, CHS=59554/16/63, (U)DMA
hdc: setmax LBA 80043264, native  66055248
hdc: Maxtor 34098H4, 32253MB w/2048kB Cache, CHS=65531/16/63, (U)DMA
[...]

My BIOS reject harddisks bigger than 33.8GB. It's a ASUSP2T4 with Intel
HX430 chipset.

Dan Merillat wrote:

> spurious 8259A interrupt: IRQ7.
> Failed to read 258048 bytes, got 0: Success
>  ^^^^^ my v4l program.
> ide_dmaproc: chipset supported ide_dma_losirq func only: 13
> hda: lost interrupt
> ide_dmaproc: chipset supported ide_dma_losirq func only: 13
> hda: lost interrupt
> <repeats forever>

On my box it looks like this (it happens after copying a big amount of
data from /dev/hda to /dev/hdc):

[...]
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: status timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: drive not ready for command
ide1: reset: success
msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0xd0 { Busy }
hda: DMA disabled
ide0: reset: success
[...]

The line 
msp34xx: giving up... 
makes me think it's also related to bttv.

The difference to Dan's problem is that I can use my box after this. But
DMA stays disabled.
I can reenable DMA on both harddisks, but after some time I get the same
messages again.

> harik@burned:~$ lspci
> 00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
> 00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
> 00:07.1 IDE interface: Intel Corporation 82371FB PIIX IDE [Triton I] (rev 02)
> 00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II]
> 00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
> 00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
> 00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 (rev 12)

[root@die-macht:~ ] lspci
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II]
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II]
00:09.0 Ethernet controller: Compex ReadyLink 2000 (rev 0a)
00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W
[Millennium] (rev 01)
00:0b.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 10)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
00:0c.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)


Okay, I thought 'use the source Luke' and looked at ide.c. 
I tried some boot-time parameters and had success with "ide0=serialize
ide1=serialize".
After reboot I can use DMA just fine and my box is stable.

Now I get this boot messages:

die-macht kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
die-macht kernel: ide1 at 0x170-0x177,0x376 on irq 15 (serialized with
ide0)

I seems to work and DMA isn't getting disabled when I access my disks.

Greetings,
Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
