Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262553AbSJBTSS>; Wed, 2 Oct 2002 15:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbSJBTSS>; Wed, 2 Oct 2002 15:18:18 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:13585 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S262553AbSJBTSQ>;
	Wed, 2 Oct 2002 15:18:16 -0400
Date: Wed, 02 Oct 2002 15:23:46 -0400
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre8 swaps ide controller order on A7V266-E
Message-ID: <15570000.1033586626@chorus.cs.wm.edu>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Starting with 2.4.19 and continuing in 2.4.20-pre8, the order the kernel 
associates with the two IDE controllers (one VIA vt8233 and one PDC20265 
intended for RAID use) on the A7V266-E has been reversed.  The BIOS and 
GRUB consider the VIA to be first, so root(hd0,0) loads the kernel from the 
first device on the VIA controller.  Prior to 2.4.19, the OS then booted 
with that drive identified as hda.  Beginning with 2.4.19, however, the 
kernel instead identifies the PDC as ide0 and ide1, and puts the VIA at 
ide2 and ide3, resulting in the boot drive being hde.

I found an earlier mention of this on the mailing list, but no solution or 
workaround was suggested.  We are using a workaround where 2.4.19 and later 
kernels are booted with root=/dev/hde1 and earlier with hda1, and fstab 
lists both hda2 and hde2 as swap partitions, simply failing to insert one. 
This works, but the general ugliness and maintenance headaches since this 
is different than the typical machine config we use around here make it 
difficult to use in the long run.

I'm not sure what the process of identifying order of controllers involves, 
but the discrepancy between the BIOS, older kernels, and newer kernels 
seems like something that should be fixed if possible.

Thanks for any help,
Bruce Lowekamp
------------------------
lspci reports the same information in 2.4.18, 2.4.19, and 2.4.20-pre8:
00:06.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)

The relevant portion of the bootup messages from dmesg:
2.4.18:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 30
PCI: Found IRQ 9 for device 00:06.0
PCI: Sharing IRQ 9 with 00:11.2
PCI: Sharing IRQ 9 with 00:11.3
PCI: Sharing IRQ 9 with 00:11.4
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: Found IRQ 11 for device 00:11.1
PCI: Sharing IRQ 11 with 01:00.0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

2.4.20-pre8:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 30
PCI: Found IRQ 9 for device 00:06.0
PCI: Sharing IRQ 9 with 00:11.2
PCI: Sharing IRQ 9 with 00:11.3
PCI: Sharing IRQ 9 with 00:11.4
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: Found IRQ 11 for device 00:11.1
PCI: Sharing IRQ 11 with 01:00.0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide2: BM-DMA at 0x9400-0x9407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x9408-0x940f, BIOS settings: hdg:DMA, hdh:pio
hde: IC35L060AVER07-0, ATA DISK drive
hdg: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15

