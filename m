Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUEVS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUEVS4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 14:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUEVS4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 14:56:30 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:22245 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261791AbUEVS40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 14:56:26 -0400
Date: Sat, 22 May 2004 21:56:06 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6-mm4 IDE] HPT370A/i815 ATAPI problems
Message-ID: <20040522185604.GA11309613@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I attached a dvd writer (MITSUMI DW-7802TE) as a master to the second
channel of HPT370A controller. On boot I get this:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 17
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CR-4804TE, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 0000:02:06.0
PCI: Found IRQ 11 for device 0000:02:06.0
PCI: Sharing IRQ 11 with 0000:00:1f.4
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 11
    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hde: ST3120023A, ATA DISK drive
ide2 at 0x9800-0x9807,0x9c02 on irq 11
hdg: MITSUMI DW-7802TE, ATAPI CD/DVD-ROM drive
irq 11: nobody cared!
 [<c0105724>] __report_bad_irq+0x24/0x90
 [<c0105811>] note_interrupt+0x61/0x90
 [<c01056d0>] handle_IRQ_event+0x30/0x60
 [<c0105a9b>] do_IRQ+0x11b/0x130
 [<c0104008>] common_interrupt+0x18/0x20
 [<c011914d>] __do_softirq+0x2d/0x80
 [<c01191c7>] do_softirq+0x27/0x30
 [<c0105a78>] do_IRQ+0xf8/0x130
 [<c0104008>] common_interrupt+0x18/0x20
 [<c022007b>] hpt372_tune_chipset+0xeb/0x100
 [<c01058fb>] enable_irq+0x3b/0xc0
 [<c0228b88>] probe_hwif+0x248/0x410
 [<c0224a83>] idedefault_attach+0x13/0x50
 [<c022980f>] hwif_init+0x12f/0x240
 [<c0228d59>] probe_hwif_init+0x9/0x60
 [<c022c685>] ide_setup_pci_device+0x65/0x80
 [<c038d68b>] init_setup_hpt366+0x18b/0x190
 [<c0176537>] create_proc_entry+0x77/0xc0
 [<c0220b1f>] hpt366_init_one+0x2f/0x40
 [<c038e234>] ide_scan_pcidev+0x54/0x70
 [<c038e27e>] ide_scan_pcibus+0x2e/0xb0
 [<c038e1c8>] ide_init+0x48/0x60
 [<c037e62b>] do_initcalls+0x2b/0xc0
 [<c0100420>] init+0x0/0x140
 [<c0100455>] init+0x35/0x140
 [<c0102198>] kernel_thread_helper+0x0/0x18
 [<c010219d>] kernel_thread_helper+0x5/0x18

handlers:
[<c0225f20>] (ide_intr+0x0/0x180)
Disabling IRQ #11

In /proc/interrupts, there is:
  11:    1123881          XT-PIC  ide2, ide3,uhci_hcd, Ensoniq AudioPCI, Intel 82801BA-ICH2, nvidia".

The drive appears to work just fine, though. I put Mitsumi 4804TE cd-writer
there instead of the DW-7802TE, I get to error in the boot. 

I originally had both the devices attached to ICH2 (i815) secondary channel.
The DW-7802TE would lock up the machine completely (no alt-sysrq, no
ctrl-alt-del, no nothing) after a while whenever it was accessed in high
speed (ripping, reading at full speed, writing at full speed). When writing
at slower speeds, it doesn't act up. The lock up happened at least with
2.6.3, 2.6.6-mm4 (PREEMPT enabled). 4804TE never caused trouble, but then
again it is slower. I moved the cd-writer to the HPT interface so that
DW-7802TE was the sole device in the channel - that didn't help. Moving
DW-7802TE to the HPT interface seemed to help (apart from the oops above),
but I haven't tested it that thoroughly. And I just noticed DMA is not
enabled for DW-7802TE when attached to HPT.

What might cause the lock up?

Can firmware update help in these kind of situations?

 
-- v --

v@iki.fi

HW: Abit ST6R, i815 & HPT370A, Celeron 1.4GHz, hda: Seagate 80GB,
    hdc: Mitsumi 4804TE CD-RW, hde: Seagate 120GB, hdg: Mitsumi
    DW-7802TE DVD+-RW
Kernel: Linux version 2.6.6-mm4 (root) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Fri May 21 20:01:21 EEST 2004
        PREEMPT enabled
