Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288897AbSAOLbI>; Tue, 15 Jan 2002 06:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289001AbSAOLa7>; Tue, 15 Jan 2002 06:30:59 -0500
Received: from linux2.viasys.com ([194.100.28.129]:263 "HELO mail.viasys.com")
	by vger.kernel.org with SMTP id <S288897AbSAOLal>;
	Tue, 15 Jan 2002 06:30:41 -0500
Message-ID: <00b401c19db8$0bbec700$b71c64c2@viasys.com>
From: "Jani Forssell" <jani.forssell@viasys.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.21pre2 VIA IDE lockup during boot
Date: Tue, 15 Jan 2002 13:30:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported earlier about a lockup during boot with a VIA KT133 (Abit KT7)
based motherboard using the 2.2.21pre2 kernel. We now tried Krzysztof
Oledzki's patch which has the new 2.4.x kernel VIA driver and Andre
Hedrick's
ide.2.2.19.05042001 patch ported to 2.2.21pre2. This version also locked up
in similar fashion.

We added some debug prints to disable_irq() so that we get the stack trace
when it is called with IRQ 14 as the parameter. It seems that it gets stuck
in the while loop waiting for IRQ_INPROGRESS.

Some combinations of IDE devices work, but the following triggers the
problem:
(the same combination does work with a 2.4.18pre2 kernel):

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 98
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:pio
hda: SAMSUNG SV8004H, ATA DISK drive
hdb: CD-ROM 52X/AKH, ATAPI CDROM drive
[Trace #1] Called disable_irq with IRQ 14
[Trace #2] Called disable_irq with IRQ 14
hdc: SAMSUNG SV8004H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
[Trace #3] Called disable_irq with IRQ 14

Trace #1:
Trace; c010a0ad <disable_irq+1d/44>
Trace; c01ec060 <error_table+ea0/35c0>
Trace; c01853dc <ide_config_drive_speed+74/384>
Trace; c0109ddf <do_8259A_IRQ+7f/a8>
Trace; c0109dfd <do_8259A_IRQ+9d/a8>
Trace; c01994a3 <via_set_drive+53/168>
Trace; c0183ffa <ide_delay_50ms+e/18>
Trace; c0196aaf <do_probe+20b/220>
Trace; c01995f5 <via82cxxx_tune_drive+3d/68>
Trace; c0197013 <probe_hwif+257/268>
Trace; c019790b <ideprobe_init+73/c4>
Trace; c0106000 <get_options+0/74>

Trace #2:
Trace; c010a0ad <disable_irq+1d/44>
Trace; c01ec060 <error_table+ea0/35c0>
Trace; c01853dc <ide_config_drive_speed+74/384>
Trace; c01994a3 <via_set_drive+53/168>
Trace; c01995f5 <via82cxxx_tune_drive+3d/68>
Trace; c0197013 <probe_hwif+257/268>
Trace; c019790b <ideprobe_init+73/c4>
Trace; c0106000 <get_options+0/74>
Trace; c0106000 <get_options+0/74>
Trace; c0106093 <init+7/150>
Trace; c0107a37 <kernel_thread+23/30>

Trace #3:

Trace; c010a0ad <disable_irq+1d/44>
Trace; c01ec060 <error_table+ea0/35c0>
Trace; c01853dc <ide_config_drive_speed+74/384>
Trace; c01994a3 <via_set_drive+53/168>
Trace; c020444f <dm_head_vals.500+4327/46f8>
Trace; c0153359 <proc_register+15/80>
Trace; c01996a8 <via82cxxx_dmaproc+88/b8>
Trace; c0184dac <ide_register_subdriver+80/d0>
Trace; c019bf6d <idedisk_init+15/98>
Trace; c0106000 <get_options+0/74>
Trace; c0106000 <get_options+0/74>
Trace; c0106093 <init+7/150>
Trace; c0107a37 <kernel_thread+23/30>

lspci:

0:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev
03)

The third trace is where it gets stuck. If anyone has any pointers as to how
to try to further debug or isolate this problem, we are willing to run more
tests.

Jani Forssell
jani.forssell@viasys.com

