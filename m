Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSL3UXE>; Mon, 30 Dec 2002 15:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSL3UXE>; Mon, 30 Dec 2002 15:23:04 -0500
Received: from mx3out.umbc.edu ([130.85.25.12]:42975 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S266043AbSL3UXA>;
	Mon, 30 Dec 2002 15:23:00 -0500
Date: Mon, 30 Dec 2002 15:31:17 -0500 (EST)
From: Stephen Brown <sbrown7@umbc.edu>
X-X-Sender: sbrown7@linux1.gl.umbc.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Micron Samurai chipset in 2.4.x (ide-pci.c)
In-Reply-To: <1041272579.13684.35.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.01.0212301528330.15488-100000@linux1.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Avmilter-Status: Skipped (size)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Woo-hoo!!

LILO boot: linux-pre2
Loading linux-pre2....................
Linux version 2.4.21-pre2 (root@gemini) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #3 SMP Mon Dec 30 13:41:10 EST 2002

<<snip>>

Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: MICRON   Product ID: SAMURAI      APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: BOOT_IMAGE=linux-pre2 ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.21-pre2 console=ttyS1,9600n8

<<snip>>

PCI: PCI BIOS revision 2.10 entry at 0xf5d4b, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:01.0
PCI->APIC IRQ transform: (B0,I1,P3) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I18,P0) -> 17
PCI->APIC IRQ transform: (B0,I19,P0) -> 19

<<snip>>

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:01.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
Skipping disabled SAMURAI controller.
hda: ST32531A, ATA DISK drive
hdb: IBM-DARA-206000, ATA DISK drive
blk: queue c03803e0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c038052c, I/O limit 4095Mb (mask 0xffffffff)
hdc: FX320S, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90432D2, ATA DISK drive
blk: queue c0380998, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 4996476 sectors (2558 MB), CHS=4956/16/63, DMA
hdb: host protected area => 1
hdb: 9514260 sectors (4871 MB) w/418KiB Cache, CHS=10068/15/63, UDMA(33)
hdd: host protected area => 1
hdd: 8440992 sectors (4322 MB) w/256KiB Cache, CHS=8374/16/63, UDMA(33)
hdc: ATAPI 32X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda:<6> [PTBL] [619/128/63] hda1 hda2
 hdb:<6> [PTBL] [629/240/63] hdb1 hdb2
 hdd:<6> [PTBL] [525/255/63] hdd1 hdd2

<<snip>>

		Welcome to Red Hat Linux

<<rest of boot snipped>>

Here's the patch: (just cut'n'pasted your code snippets where they
looked best)

*** generic.c~	Wed Dec 25 17:55:30 2002
--- generic.c	Mon Dec 30 13:36:17 2002
***************
*** 89,94 ****
--- 89,95 ----
  static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
  {
  	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
+ 	u16 cmd;

  	if (dev->device != d->device)
  		BUG();
***************
*** 102,107 ****
--- 103,117 ----
  	    (!(PCI_FUNC(dev->devfn) & 1)))
  		return 1;

+         pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+         if(!(cmd & PCI_COMMAND_IO))
+         {
+                 printk(KERN_INFO "Skipping disabled %s controller.\n",
+                         d->name);
+                 return 1;
+         }
+
  	ide_setup_pci_device(dev, d);
  	MOD_INC_USE_COUNT;
  	return 0;

---------------end patch-------------

Steve Brown
sbrown7@umbc.edu

