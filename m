Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTDTRlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbTDTRlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:41:21 -0400
Received: from [66.78.41.84] ([66.78.41.84]:16058 "EHLO cell01.cell01.com")
	by vger.kernel.org with ESMTP id S263650AbTDTRlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:41:17 -0400
From: Eric Northup <lkml@digitaleric.net>
Reply-To: mailing-lists@digitaleric.net
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.5.68 IDE Oops at boot
Date: Sun, 20 Apr 2003 13:48:34 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3EA286D5.30706@colorfullife.com>
In-Reply-To: <3EA286D5.30706@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304201348.34229.lkml@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cell01.cell01.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 April 2003 07:39 am, Manfred Spraul wrote:
> Hi Eric,
>
> the oops occurs in __elv_add_request, because the elevator structure is
> not initialized:
>
> Eric wrote:
> >EIP:    0060:[<00000000>]    Not tainted
> >[ snip ]
> >Call Trace:
> > [<c02839e3>] __elv_add_request+0x33/0x50
>
> A jump to an uninitialized function pointer within __elv_add_request.
>
> Eric wrote:
> >SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
> >SiI3112 Serial ATA: chipset revision 1
> >SiI3112 Serial ATA: not 100% native mode: will probe irqs later
> >    ide0: MMIO-DMA at 0xf8808000-0xf8808007, BIOS settings: hda:pio,
> > hdb:pio ide1: MMIO-DMA at 0xf8808008-0xf880800f, BIOS settings: hdc:pio,
> > hdd:pio hda: MAXTOR 6L080L4, ATA DISK drive
> >hdc: MAXTOR 6L080L4, ATA DISK drive
> >NFORCE2: IDE controller at PCI slot 00:09.0
> >NFORCE2: chipset revision 162
> >NFORCE2: not 100% native mode: will probe irqs later
> >ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2)
> > UDMA100 controller on pci00:09.0
> >    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:DMA
> >    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:DMA, hdh:DMA
> >hde: MAXTOR 6L040L2, ATA DISK drive
> >ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
>
> That line is from init_irq(), called within hwif_init(): hwif and drives
> fully initialized.
>
> >hdg: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
> >hdh: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
> >ide3 at 0x170-0x177,0x376 on irq 15
>
> Dito.
>
> Hmm. But where is "ide0 at ... on irq ..."?
>
> It seems the drives attached to the sata controller were not initialized
> properly. No idea why. Could you apply the attached patch? I assume that
> the hwif_init fails somewhere before calling init_irq(), the printks
> would show me where.

Here is the resulting boot log:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA at 0xf8808000-0xf8808007, BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA at 0xf8808008-0xf880800f, BIOS settings: hdc:pio, hdd:pio
ide_setup_pci_device for PCI device 1095:3112 (CMD Technology Inc) called.
hda: MAXTOR 6L080L4, ATA DISK drive
hwif_init: hwif ide0, stage 1.
hwif_init: hwif ide0, stage 3.
hwif_init: hwif ide0, stage 4.
hwif_init: hwif ide0, stage 5.
hwif_init: hwif ide0, stage 6.
init_irq called for hwif ide0.
hdc: MAXTOR 6L080L4, ATA DISK drive
hwif_init: hwif ide1, stage 1.
hwif_init: hwif ide1, stage 3.
hwif_init: hwif ide1, stage 4.
hwif_init: hwif ide1, stage 5.
hwif_init: hwif ide1, stage 6.
init_irq called for hwif ide1.
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller 
on pci00:09.0
    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:DMA, hdh:DMA
ide_setup_pci_device for PCI device 10de:0065 (nVidia Corporation) called.
hde: MAXTOR 6L040L2, ATA DISK drive
hwif_init: hwif ide2, stage 1.
hwif_init: hwif ide2, stage 3.
hwif_init: hwif ide2, stage 4.
hwif_init: hwif ide2, stage 5.
hwif_init: hwif ide2, stage 6.
init_irq called for hwif ide2.
blk_init_queue: c04c99d4 initialized.
ide_init_queue: drive hde has queue c04c99d4.
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hdg: PLEXTOR CD-R PX-W4012A, ATAPI CD/DVD-ROM drive
hdh: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
hwif_init: hwif ide3, stage 1.
hwif_init: hwif ide3, stage 3.
hwif_init: hwif ide3, stage 4.
hwif_init: hwif ide3, stage 5.
hwif_init: hwif ide3, stage 6.
init_irq called for hwif ide3.
blk_init_queue: c04ca2c0 initialized.
ide_init_queue: drive hdg has queue c04ca2c0.
blk_init_queue: c04ca5d8 initialized.
ide_init_queue: drive hdh has queue c04ca5d8.
ide3 at 0x170-0x177,0x376 on irq 15
hwif_init: hwif ide4, stage 1.
hwif_init: hwif ide5, stage 1.
hwif_init: hwif ide6, stage 1.
hwif_init: hwif ide7, stage 1.
hwif_init: hwif ide8, stage 1.
hwif_init: hwif ide9, stage 1.
ata_attach: trying driver c043a3e0 for drive hda(c04c87fc).
Duh. Elevator c04c87fc not initialized.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010082
EIP is at 0x0
eax: f7f9fdcc   ebx: c04c87fc   ecx: 00000002   edx: 00000000
esi: 00000000   edi: 00000202   ebp: f7f9fd80   esp: f7f9fd68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9e000 task=f7f9c040)
Stack: c0288829 c04c87fc f7f9fdcc 00000000 f7f9e000 f7f9fdcc f7f9fdb8 c02a2e05
       c04c87fc f7f9fdcc 00000001 00000000 c1b29534 00000000 f7f9fda0 f7f9fda0
       f7f9fdd4 f7f9fe94 00000000 f7f9fdcc f7f9fe68 c02a89cb c04c87ec f7f9fdcc
Call Trace:
 [<c0288829>] __elv_add_request+0x39/0x60
 [<c02a2e05>] ide_do_drive_cmd+0x85/0x100
 [<c02a89cb>] ide_diag_taskfile+0x7b/0xb0
 [<c02a8a27>] ide_raw_taskfile+0x27/0x30
 [<c02af069>] idedisk_read_native_max_address+0x49/0x90
 [<c02a7cc0>] task_no_data_intr+0x0/0xa0
 [<c02af1a4>] init_idedisk_capacity+0x34/0x240
 [<c02b02a8>] idedisk_setup+0x118/0x2f0
 [<c02acead>] ide_register_subdriver+0x16d/0x1a0
 [<c02b07d4>] idedisk_attach+0xa4/0x1c0
 [<c02ac150>] ata_attach+0x70/0x130
 [<c02ad116>] ide_register_driver+0xf6/0x110
 [<c02b0902>] idedisk_init+0x12/0x50
 [<c048078c>] do_initcalls+0x2c/0xa0
 [<c0130e92>] init_workqueues+0x12/0x40
 [<c01050a6>] init+0x36/0x190
 [<c0105070>] init+0x0/0x190
 [<c010924d>] kernel_thread_helper+0x5/0x18

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!


