Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280648AbRKJNe7>; Sat, 10 Nov 2001 08:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280646AbRKJNeu>; Sat, 10 Nov 2001 08:34:50 -0500
Received: from [196.31.58.45] ([196.31.58.45]:8840 "EHLO
	montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S280634AbRKJNeg>; Sat, 10 Nov 2001 08:34:36 -0500
Message-Id: <200111101336.fAADapr02433@montezuma.mastecende.com>
Content-Type: text/plain; charset=US-ASCII
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockup in IDE code
Date: Sat, 10 Nov 2001 15:36:51 +0200
X-Mailer: KMail [version 1.2.3]
Cc: rgooch@ras.ucalgary.ca
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hdb: CRD-8480B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

He only has the one device on IDE as you can see that the probe only shows 
hdb, and i have a PIIX4 too and they do UDMA33 well enough, in fact i'm not 
aware of any DMA problems with the PIIX4. Richard, have you tried disabling 
CONFIG_IDEDMA_AUTO and CONFIG_PIIX_TUNING ?

But looking at the code in ide-features.c it doesn't look like we have 
enabled DMA by the time we get to that code.

     if (error) {
                (void) ide_dump_status(drive, "set_drive_speed_status", stat);
                return error;
        }

<----- snip ----- >
#if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
        if (speed > XFER_PIO_4) {
                outb(inb(hwif->dma_base+2)|(1<<(5+unit)), hwif->dma_base+2);  
      } else {
                outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), 
hwif->dma_base+2);
        }
#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */

But bear in mind i'm far from being remotely knowledgeable about this 
specific code ;)
