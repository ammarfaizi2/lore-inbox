Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbTBKLvF>; Tue, 11 Feb 2003 06:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbTBKLvE>; Tue, 11 Feb 2003 06:51:04 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:5381 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S267648AbTBKLvA>;
	Tue, 11 Feb 2003 06:51:00 -0500
Date: Tue, 11 Feb 2003 13:00:44 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
Message-ID: <Pine.LNX.4.33.0302111241560.1173-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hell

I reported earlier a problem with getting 2 flash disks to work in
true-IDE mode with 2.4.[18|20]
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0302.0/0918.html).
Today I tried 2.5.60. Tried with 2 flash-disks and with 1 only. With 2
flash-disks connected the kernel panics (notice, hda disappears after the
initial detection):

...

Kernel command line: BOOT_IMAGE=4 ro root=301 hdb=flash console=ttyS0,38400 console=tty1
ide_setup: hdb=flash

...

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:pio, hdb:pio
hda: Hitachi CV 7.1.1, CFA DISK drive
hdb: SunDisk SDP3B-220, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: 430080 sectors (220 MB) w/1KiB Cache, CHS=840/16/32, BUG
 hdb:hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x04 { DriveStatusError }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x04 { DriveStatusError }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x04 { DriveStatusError }
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x04 { DriveStatusError }
hdb: DMA disabled
ide0: reset: success
 hdb1
 hdb: hdb1
Badness in kobject_register at lib/kobject.c:152
Call Trace:
 [<c01972ba>] kobject_register+0x3e/0x54
 [<c015d816>] add_partition+0x56/0x60
 [<c015d95a>] register_disk+0xfa/0x128
 [<c01b8ed1>] add_disk+0x35/0x44
 [<c01b8e70>] exact_match+0x0/0xc
 [<c01b8e7c>] exact_lock+0x0/0x20
 [<c01cdebe>] idedisk_attach+0x17a/0x18c
 [<c01ca6f6>] ata_attach+0x46/0xac
 [<c01cb23e>] ide_register_driver+0x9a/0xcc
 [<c01cdedd>] idedisk_init+0xd/0x20
 [<c010502c>] init+0x0/0x144
 [<c0105049>] init+0x1d/0x144
 [<c010502c>] init+0x0/0x144
 [<c0107001>] kernel_thread_helper+0x5/0xc

...

VFS: Cannot open root device "301" or 03:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:01

With only one (hda) disk the system boots, but there's still an error
message:

...

Kernel command line: BOOT_IMAGE=4 ro root=301 hdb=flash console=ttyS0,38400 console=tty1
ide_setup: hdb=flash

...

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc90-0xfc97, BIOS settings: hda:pio, hdb:pio
hda: Hitachi CV 7.1.1, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 31488 sectors (16 MB) w/1KiB Cache, CHS=246/4/32, BUG
 hda:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x04 { DriveStatusError }
hda: DMA disabled
ide0: reset: success
 hda1
 hda: hda1
Badness in kobject_register at lib/kobject.c:152
Call Trace:
 [<c01972ba>] kobject_register+0x3e/0x54
 [<c015d816>] add_partition+0x56/0x60
 [<c015d95a>] register_disk+0xfa/0x128
 [<c01b8ed1>] add_disk+0x35/0x44
 [<c01b8e70>] exact_match+0x0/0xc
 [<c01b8e7c>] exact_lock+0x0/0x20
 [<c01cdebe>] idedisk_attach+0x17a/0x18c
 [<c01ca6f6>] ata_attach+0x46/0xac
 [<c01cb23e>] ide_register_driver+0x9a/0xcc
 [<c01cdedd>] idedisk_init+0xd/0x20
 [<c010502c>] init+0x0/0x144
 [<c0105049>] init+0x1d/0x144
 [<c010502c>] init+0x0/0x144
 [<c0107001>] kernel_thread_helper+0x5/0xc

...

 hda: hda1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 88k freed

The configuration:

...

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y

...

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y

...

CONFIG_BLK_DEV_PIIX=y

...

CONFIG_BLK_DEV_IDE_MODES=y

...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

