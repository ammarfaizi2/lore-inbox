Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSCJOYk>; Sun, 10 Mar 2002 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293051AbSCJOYV>; Sun, 10 Mar 2002 09:24:21 -0500
Received: from tomts14.bellnexxia.net ([209.226.175.35]:7575 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S293048AbSCJOYM>; Sun, 10 Mar 2002 09:24:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Sun, 10 Mar 2002 09:23:40 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Hank Yang <hanky@promise.com.tw>, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020310142341.56FE11204@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two things.

First the patch still seems corrupted.  The tabs are now ok but each lines are terminated
with =0A= and some lines are wrapped.  For instance:

 	OUT_BYTE(rq->nr_sectors,IDE_NSECTOR_REG);=0A=
+	if ((drive->id->command_set_2 & 0x0400) && =
HWIF(drive)->pci_devid.vid=3D=3DPCI_VENDOR_ID_PROMISE) {=0A=
+		/* 48 bits data previous */=0A=

Second.  There seems to be problems with the ide reset code in pre2-ac2.  I get the following:

hde: timeout waiting for DMA
PDC202XX: Primary channel reset.
hde: ide_dma_timeout: Lets do it again!stat = 0x50, dma_stat = 0x20
hde: DMA disabled
PDC202XX: Primary channel reset.
hde: ide_set_handler: handler not null; old=c018eeb0, new=c0193de4
bug: kernel timer added twice at c018ed31.
hde: dma_intr: status=0xd0 { Busy }
hde: DMA disabled
PDC202XX: Primary channel reset.
ide2: reset: success
hdg: timeout waiting for DMA
PDC202XX: Secondary channel reset.
hdg: ide_dma_timeout: Lets do it again!stat = 0x50, dma_stat = 0x20
hdg: DMA disabled
PDC202XX: Secondary channel reset.
hdg: ide_set_handler: handler not null; old=c018eeb0, new=c0193de4
bug: kernel timer added twice at c018ed31.
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt
hde: lost interrupt

Notice the bug...  Similar problems occur with the standard kernel.  If I degrade the
controller to use UDMA2 (hdparm -X66 /dev/hde) I am usually stable for a week or so...  
IDE config follows:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20267: IDE controller on PCI bus 00 dev 48
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xac00-0xac07,0xb002 on irq 12
ide3 at 0xb400-0xb407,0xb802 on irq 12
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=1684/255/63, UDMA(33)
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
 hde: hde1 hde2 hde3 hde4 < hde5 >
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 >


#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
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
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
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
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_IDEDMA_TIMEOUT=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
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
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC_ADMA is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_ELEVATOR_NOOP is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# 

Look very much forward to an improved set of promise drivers.

TIA,

Ed Tomlinson
