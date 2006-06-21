Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWFUWsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWFUWsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWFUWsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:48:13 -0400
Received: from smtp.ono.com ([62.42.230.12]:340 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1751510AbWFUWsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:48:13 -0400
Date: Thu, 22 Jun 2006 00:48:11 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Using libata for ICH5 PATA
Message-ID: <20060622004811.0009937c@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.3.1cvs9 (GTK+ 2.9.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I want to try to use libata for my ide disks also.
Board is an ASUS PC-DL, it has an ICH5R controller:

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)

with 2 IDE100 busses and 2 sata ports,
and a Promise one:

03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 378/SATA 378) (rev 02)

with one IDE133 bus and 2 sata ports.
More details here:
http://www.asus.com/products.aspx?l1=9&l2=39&l3=99&model=104&modelmenu=1

I boot from a SATA drive in ICH5, no initrd/initramfs, so SATA support for
ICH5 is compiled in.

I have now 2.6.17-mm1 installed, configured with:

CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_PIIX=m
CONFIG_SCSI=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_PATA_OLDPIIX=m
CONFIG_SCSI_ATA_PIIX=y
CONFIG_SCSI_SATA_PROMISE=m

The ata_piix does not show the PATA bus.

libata version 1.30 loaded.
ata_piix 0000:00:1f.2: version 1.10tj1ac3
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi0 : ata_piix
ata1: ENTER, pcs=0x13 base=0
ata1: LEAVE, pcs=0x13 present_mask=0x1
ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ata2: ENTER, pcs=0x13 base=2
ata2: LEAVE, pcs=0x11 present_mask=0x0
ata2: SATA port has no device.
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3

If I modprobe sata_promise, it works as I expected:

Jun 22 00:11:03 werewolf kernel: sata_promise 0000:03:04.0: version 1.04
Jun 22 00:11:03 werewolf kernel: ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 17
Jun 22 00:11:03 werewolf kernel: sata_promise PATA port found
Jun 22 00:11:03 werewolf kernel: ata3: SATA max UDMA/133 cmd 0xF8B8A200 ctl 0xF8B8A238 bmdma 0x0 irq 17
Jun 22 00:11:03 werewolf kernel: ata4: SATA max UDMA/133 cmd 0xF8B8A280 ctl 0xF8B8A2B8 bmdma 0x0 irq 17
Jun 22 00:11:03 werewolf kernel: ata5: PATA max UDMA/133 cmd 0xF8B8A300 ctl 0xF8B8A338 bmdma 0x0 irq 17
Jun 22 00:11:03 werewolf kernel: scsi2 : sata_promise
Jun 22 00:11:03 werewolf kernel: ata3: SATA link down (SStatus 0 SControl 300)
Jun 22 00:11:03 werewolf kernel: scsi3 : sata_promise
Jun 22 00:11:04 werewolf kernel: ata4: SATA link down (SStatus 0 SControl 0)
Jun 22 00:11:04 werewolf kernel: scsi4 : sata_promise
Jun 22 00:11:05 werewolf kernel: ata5: disabling port

Finds both SATAs and the PATA.

This is what the 'old way' with piix gives:

Jun 22 00:12:42 werewolf kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Jun 22 00:12:42 werewolf kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
Jun 22 00:12:42 werewolf kernel: ICH5: chipset revision 2
Jun 22 00:12:42 werewolf kernel: ICH5: not 100% native mode: will probe irqs later 
Jun 22 00:12:42 werewolf kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
Jun 22 00:12:42 werewolf kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Jun 22 00:12:42 werewolf kernel: Probing IDE interface ide0...
Jun 22 00:12:42 werewolf kernel: hda: HL-DT-ST DVDRAM GSA-4120B, ATAPI CD/DVD-ROM drive
Jun 22 00:12:43 werewolf kernel: hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Jun 22 00:12:43 werewolf kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 22 00:12:43 werewolf kernel: hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jun 22 00:12:43 werewolf kernel: Uniform CD-ROM driver Revision: 3.20
Jun 22 00:12:43 werewolf kernel: Probing IDE interface ide1...
Jun 22 00:12:43 werewolf kernel: ide-floppy driver 0.99.newide
Jun 22 00:12:43 werewolf kernel: hdb: No disk in drive
Jun 22 00:12:43 werewolf kernel: hdb: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Jun 22 00:12:43 werewolf kernel: hdb: No disk in drive
Jun 22 00:12:43 werewolf kernel: hdb: No disk in drive
Jun 22 00:12:43 werewolf udevd-event[2800]: find_free_number: %e is deprecated, will be removed and is unlikely to work correctly. Don't use it.
Jun 22 00:12:43 werewolf kernel: hdc: ST3120022A, ATA DISK drive
Jun 22 00:12:44 werewolf kernel: hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
Jun 22 00:12:44 werewolf kernel: ide1 at 0x170-0x177,0x376 on irq 15 
Jun 22 00:12:44 werewolf kernel: hdd: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
Jun 22 00:12:44 werewolf kernel: hdc: max request size: 512KiB
Jun 22 00:12:44 werewolf kernel: hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
Jun 22 00:12:44 werewolf kernel: hdc: cache flushes supported
Jun 22 00:12:44 werewolf kernel:  hdc: hdc1 

What do I need to let libata drive the ICH5 pata ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
