Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932822AbWGBTzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbWGBTzF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWGBTzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 15:55:05 -0400
Received: from vixis.sumodave.com ([88.96.16.138]:20329 "EHLO
	vixis.sumodave.com") by vger.kernel.org with ESMTP id S932822AbWGBTzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 15:55:02 -0400
Date: Sun, 2 Jul 2006 20:54:59 +0100
From: Daniel Walrond <linux@djw.org.uk>
To: linux-kernel@vger.kernel.org
Subject: via_sata drive command timeout on EPIA 8000 SP
Message-ID: <20060702195459.GB28120@vixis.sumodave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm getting some drive command timeouts on a pair of SATA disks in a VIA
EPIA 8000 SP. I've ran the a smart extended test one of the disks and
that came back with no error. The disks are new.

I first saw problems with the default 2.6.8 kernel which comes with
Debian Sarge where I saw the follwoing errors:

Jun 28 22:07:39 homm kernel: EXT3-fs error (device md0):
ext3_free_blocks: Freeing blocks not in datazone - block = 3466911703,
count = 1
Jun 28 22:07:39 homm kernel: Remounting filesystem read-only
Jun 28 22:07:39 homm kernel: EXT3-fs error (device md0):
ext3_free_blocks: Freeing blocks not in datazone - block = 2998170450,
count = 1
[...]

The freeing blocks error repeated many times. This happend more than
once. I upgrade to 2.6.17.1 which seemed good. Later I got the following
errors:

Jun 29 09:59:10 homm kernel: ata2: command 0xea timeout, stat 0x51
host_stat 0x0
Jun 29 09:59:10 homm kernel: ata2: translated ATA stat/err 0x51/04 to
SCSI SK/ASC/ASCQ 0xb/00/00
Jun 29 09:59:10 homm kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jun 29 09:59:10 homm kernel: ata2: error=0x04 { DriveStatusError }
Jun 29 13:49:35 homm kernel: ata2: command 0xea timeout, stat 0x51
host_stat 0x0
Jun 29 13:49:35 homm kernel: ata2: translated ATA stat/err 0x51/04 to
SCSI SK/ASC/ASCQ 0xb/00/00
Jun 29 13:49:35 homm kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jun 29 13:49:35 homm kernel: ata2: error=0x04 { DriveStatusError }
Jun 29 13:54:05 homm kernel: ata2: command 0xea timeout, stat 0x51
host_stat 0x0
Jun 29 13:54:05 homm kernel: ata2: translated ATA stat/err 0x51/04 to
SCSI SK/ASC/ASCQ 0xb/00/00
Jun 29 13:54:05 homm kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Jun 29 13:54:05 homm kernel: ata2: error=0x04 { DriveStatusError }

Then later with a different kernel to work with Xen, using 2.6.16.22 I
get very similar errors for the other disk:

Jul  2 16:05:31 homm kernel: ata1: command 0x35 timeout, stat 0x51
host_stat 0x2 1
Jul  2 16:05:31 homm kernel: ata1: translated ATA stat/err 0x51/04 to
SCSI SK/ASC/ASCQ 0xb/00/00
Jul  2 16:05:31 homm kernel: ata1: status=0x51 { DriveReady SeekComplete
Error }
Jul  2 16:05:31 homm kernel: ata1: error=0x04 { DriveStatusError }
Jul  2 16:05:31 homm kernel: sd 0:0:0:0: SCSI error: return code =
0x8000002
Jul  2 16:05:31 homm kernel: sda: Current: sense key=0xb
Jul  2 16:05:31 homm kernel:     ASC=0x0 ASCQ=0x0
Jul  2 16:05:31 homm kernel: end_request: I/O error, dev sda, sector
18368916
Jul  2 16:05:31 homm kernel: raid1: Disk failure on sda3, disabling
device. 
Jul  2 16:05:31 homm kernel: ^IOperation continuing on 1 devices
Jul  2 16:05:31 homm kernel: RAID1 conf printout:
Jul  2 16:05:31 homm kernel:  --- wd:1 rd:2
Jul  2 16:05:31 homm kernel:  disk 0, wo:1, o:0, dev:sda3


>From my dmesg:

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 10
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
libata version 1.20 loaded.
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 11 (level,
low) -> IRQ 11
sata_via 0000:00:0f.0: routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 11
ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
88:203f
ata2: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_via
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb


Any clues to what could be wrong?


Dan
