Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSHGU1q>; Wed, 7 Aug 2002 16:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSHGU1q>; Wed, 7 Aug 2002 16:27:46 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:22025 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316753AbSHGU1o>; Wed, 7 Aug 2002 16:27:44 -0400
Date: Wed, 7 Aug 2002 22:27:07 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Nick Orlov <nick.orlov@mail.ru>, Bill Davidsen <davidsen@tmr.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
Message-ID: <20020807202707.GA7132@louise.pinerecords.com>
References: <20020807035623.GA3411@nikolas.hn.org> <Pine.LNX.4.10.10208071127430.15852-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10208071127430.15852-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 64 days, 11:17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It worked just fine until you all decided to let an OEM get in the game
> and dictate the changes.  Back out the cruft and return sanity to an
> insane world.  Just because and OEM makes hardware does not mean they can
> make it run proper.

Btw, Andre, I have this system with an extra PDC20268 controller that
I can't get to work in UDMA >2, *but only* until I actually I force it
to using "ide2=ata66 ide3=ata66". You wouldn't happen to have an idea
as to what could be the cause here, would you?

This applies for all the recent 2.4 kernels that I've tested, both
vanilla and -ac.

A comment in ide.c reads:

 * Added idex=ata66 for the quirky chipsets that are
 * ATA-66 compliant, but have yet to determine a method
 * of verification of the 80c cable presence.
 * Specifically Promise's PDC20262 chipset.

i.e. it talks of a chipset different from what I have here.
All right. Supposing CONFIG_BLK_DEV_IDEPCI=y and "idex=ata66"
hasn't been specified as a boot option, the value of
hwif->udma_four remains unset during setup and is to
be determined later:

	if (hwif->udma_four) {
		printk("%s: ATA-66/100 forced bit set (WARNING)!!\n", d->name);
	} else {
		hwif->udma_four = (d->ata66_check) ? d->ata66_check(hwif) : 0;
	}

If I parse this right, then if a function has been defined that can find
out about the chipset's ability to support DMA4+, it's called to do its
job, otherwise we assume UDMA4+ can't be had. This narrows my problem down
to: 1) either this cunning function doesn't exist for PDC20268, or 2) for
some weird reason it exists but is not nearly as cunning, because it doesn't
know it should be returning a nice "one" for my controller.

Trouble is, I have failed to find where the value of ata66_check in struct
ide_pci_device_s is assigned for the controller so I couldn't go on tracking
the problem. The code is sooooo beautifully messy. <g>

T.

ide_setup: ide2=ata66
ide_setup: ide3=ata66
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 21
PCI: Enabling device 00:04.1 (0000 -> 0001)
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
PDC20268: IDE controller on PCI bus 00 dev 30
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ATA-66/100 forced bit set (WARNING)!!
    ide2: BM-DMA at 0xf8b0-0xf8b7, BIOS settings: hde:pio, hdf:pio
PDC20268: ATA-66/100 forced bit set (WARNING)!!
    ide3: BM-DMA at 0xf8b8-0xf8bf, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD205BA, ATA DISK drive
hdg: IBM-DJNA-351520, ATA DISK drive
ide2 at 0xf898-0xf89f,0xf8aa on irq 9
ide3 at 0xf8a0-0xf8a7,0xf8ae on irq 9
hde: host protected area => 1
hde: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63, UDMA(66)
hdg: host protected area => 1
hdg: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=29795/16/63, UDMA(33)

00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra100TX2
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 9
        I/O ports at f898 [size=8]
        I/O ports at f8a8 [size=4]
        I/O ports at f8a0 [size=8]
        I/O ports at f8ac [size=4]
        I/O ports at f8b0 [size=16]
        Memory at fedfc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=m

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ADMA100 is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
