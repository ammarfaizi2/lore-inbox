Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUBXQId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUBXQIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:08:32 -0500
Received: from mx1.mail.ru ([194.67.23.21]:21006 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262208AbUBXQFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:05:07 -0500
Message-ID: <403B7627.6080805@mail.ru>
Date: Tue, 24 Feb 2004 17:04:55 +0100
From: marcel cotta <mc123@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
Followup-To: mc123@mail.ru
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 - Badness in pci_find_subsys at drivers/pci/search.c:167
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i came across this while playing with hdparm

Call Trace:
  [<c0264128>] pci_find_subsys+0xe8/0xf0
  [<c026415f>] pci_find_device+0x2f/0x40
  [<c02e5d89>] ide_system_bus_speed+0x69/0x90
  [<c02e528e>] ali15x3_tune_drive+0x1e/0x250
  [<c01389af>] mempool_free+0x4f/0xb0
  [<c0258e72>] __delay+0x12/0x20
  [<c02eb2ce>] ide_wait_stat+0x8e/0x130
  [<c02e9a14>] do_special+0x44/0x60
  [<c02e9dc8>] start_request+0x178/0x270
  [<c02ea0d7>] ide_do_request+0x1e7/0x370
  [<c02ea772>] ide_intr+0x122/0x190
  [<c02eedc0>] task_mulin_intr+0x0/0x210
  [<c010acca>] handle_IRQ_event+0x3a/0x70
  [<c010b041>] do_IRQ+0x91/0x130
  [<c01094f4>] common_interrupt+0x18/0x20
  [<c03b71b8>] ip_rcv+0x148/0x460
  [<c03a3d52>] netif_receive_skb+0x152/0x190
  [<c03a3e03>] process_backlog+0x73/0x100
  [<c03a3f04>] net_rx_action+0x74/0x110
  [<c0121190>] do_softirq+0x90/0xa0
  [<c010b0ad>] do_IRQ+0xfd/0x130
  [<c0105000>] _stext+0x0/0x60
  [<c01094f4>] common_interrupt+0x18/0x20
  [<c0105000>] _stext+0x0/0x60
  [<c02813fd>] acpi_processor_idle+0xb4/0x1c7
  [<c0105000>] _stext+0x0/0x60
  [<c01070bc>] cpu_idle+0x2c/0x40
  [<c050a6df>] start_kernel+0x17f/0x1b0
  [<c050a430>] unknown_bootoption+0x0/0x100

========================================

the bios on this machine (hp ze4423ea laptop) is horribly broken

without 'pci=noacpi pci=usepirqmask' i get:

Jan 18 13:10:52 hades kernel: ACPI: No IRQ known for interrupt pin A 
of device 0
000:00:10.0


i played with hdparm cause the whole cpu time is eaten by io-wait 
whenever there is disk-io
in this state everything slows down to a crawl and the box is nearly 
unusable while its swapping

changing unmask irq or switching from dma to non dma mode doesnt 
change anything


lspci:

00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01)
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation 
DP83815 (MacPhyter) Ethernet Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1



dmesg:

Feb 24 09:34:06 hades kernel: Inspecting /boot/System.map-2.6.3
Feb 24 09:34:06 hades kernel: Loaded 24069 symbols from 
/boot/System.map-2.6.3.
Feb 24 09:34:06 hades kernel: Symbols match kernel version 2.6.3.
Feb 24 09:34:06 hades kernel: No module symbols loaded - kernel 
modules not enabled.
Feb 24 09:34:06 hades kernel: Linux version 2.6.3 (root@hades) (gcc 
version 3.3.3 (Debian)) #18 Mon Feb 23 03:33:59 CET 2004
Feb 24 09:34:06 hades kernel: BIOS-provided physical RAM map:
Feb 24 09:34:06 hades kernel:  BIOS-e820: 0000000000000000 - 
000000000009f800 (usable)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 000000000009f800 - 
00000000000a0000 (reserved)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 00000000000d0000 - 
0000000000100000 (reserved)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 0000000000100000 - 
000000000bef0000 (usable)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 000000000bef0000 - 
000000000beff000 (ACPI data)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 000000000beff000 - 
000000000bf00000 (ACPI NVS)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 000000000bf00000 - 
000000000c000000 (reserved)
Feb 24 09:34:06 hades kernel:  BIOS-e820: 00000000fffc0000 - 
0000000100000000 (reserved)
Feb 24 09:34:06 hades kernel: 190MB LOWMEM available.
Feb 24 09:34:06 hades kernel: On node 0 totalpages: 48880
Feb 24 09:34:06 hades kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 24 09:34:06 hades kernel:   Normal zone: 44784 pages, LIFO batch:10
Feb 24 09:34:06 hades kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb 24 09:34:06 hades kernel: DMI 2.3 present.
Feb 24 09:34:06 hades kernel: ACPI: RSDP (v000 PTLTD 
                    ) @ 0x000f7290
Feb 24 09:34:06 hades kernel: ACPI: RSDT (v001 PTLTD    RSDT 
0x06040000  LTP 0x00000000) @ 0x0bef8cca
Feb 24 09:34:06 hades kernel: ACPI: FADT (v001 ATI    Raptor 
0x06040000 ATI  0x000f4240) @ 0x0befee2b
Feb 24 09:34:06 hades kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 
0x06040000  LTP 0x00000001) @ 0x0befee9f
Feb 24 09:34:06 hades kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 
0x06040000  LTP 0x00000001) @ 0x0befeec7
Feb 24 09:34:06 hades kernel: ACPI: DSDT (v001    ATI U1_M1535 
0x06040000 MSFT 0x0100000d) @ 0x00000000
Feb 24 09:34:06 hades kernel: Built 1 zonelists
Feb 24 09:34:06 hades kernel: Kernel command line: auto 
BOOT_IMAGE=Linux ro root=303 nmi_watchdog=1 splash=silent pci=noacpi 
pci=usepirqmask
Feb 24 09:34:06 hades kernel: Initializing CPU#0
Feb 24 09:34:06 hades kernel: PID hash table entries: 1024 (order 10: 
8192 bytes)
Feb 24 09:34:06 hades kernel: Detected 1788.914 MHz processor.
Feb 24 09:34:06 hades kernel: Using tsc for high-res timesource
Feb 24 09:34:06 hades kernel: Console: colour dummy device 80x25
Feb 24 09:34:06 hades kernel: Memory: 188276k/195520k available (3298k 
kernel code, 6616k reserved, 822k data, 156k init, 0k highmem)
Feb 24 09:34:06 hades kernel: Checking if this processor honours the 
WP bit even in supervisor mode... Ok.
Feb 24 09:34:06 hades kernel: Calibrating delay loop... 3538.94 BogoMIPS
Feb 24 09:34:06 hades kernel: Security Scaffold v1.0.0 initialized
Feb 24 09:34:06 hades kernel: Dentry cache hash table entries: 32768 
(order: 5, 131072 bytes)
Feb 24 09:34:06 hades kernel: Inode-cache hash table entries: 16384 
(order: 4, 65536 bytes)
Feb 24 09:34:06 hades kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Feb 24 09:34:06 hades kernel: checking if image is initramfs...it 
isn't (ungzip failed); looks like an initrd
Feb 24 09:34:06 hades kernel: Freeing initrd memory: 33k freed
Feb 24 09:34:06 hades kernel: CPU:     After generic identify, caps: 
0383f9ff c1cbf9ff 00000000 00000000
Feb 24 09:34:06 hades kernel: CPU:     After vendor identify, caps: 
0383f9ff c1cbf9ff 00000000 00000000
Feb 24 09:34:06 hades kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Feb 24 09:34:06 hades kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb 24 09:34:06 hades kernel: CPU:     After all inits, caps: 0383f9ff 
c1cbf9ff 00000000 00000020
Feb 24 09:34:06 hades kernel: Intel machine check architecture supported.
Feb 24 09:34:06 hades kernel: Intel machine check reporting enabled on 
CPU#0.
Feb 24 09:34:06 hades kernel: CPU: AMD mobile AMD Athlon(tm) XP2400+ 
stepping 00
Feb 24 09:34:06 hades kernel: Enabling fast FPU save and restore... done.
Feb 24 09:34:06 hades kernel: Enabling unmasked SIMD FPU exception 
support... done.
Feb 24 09:34:06 hades kernel: Checking 'hlt' instruction... OK.
Feb 24 09:34:06 hades kernel: POSIX conformance testing by UNIFIX
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 16
Feb 24 09:34:06 hades kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfd87b, last bus=2
Feb 24 09:34:06 hades kernel: PCI: Using configuration type 1
Feb 24 09:34:06 hades kernel: mtrr: v2.0 (20020519)
Feb 24 09:34:06 hades kernel: ACPI: Subsystem revision 20040116
Feb 24 09:34:06 hades kernel: ACPI: IRQ9 SCI: Level Trigger.
Feb 24 09:34:06 hades kernel: ACPI: Interpreter enabled
Feb 24 09:34:06 hades kernel: ACPI: Using PIC for interrupt routing
Feb 24 09:34:06 hades kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Feb 24 09:34:06 hades kernel: PCI: Probing PCI hardware (bus 00)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.AGPB._PRT]
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 
4 6 *10)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 
4 6 10)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 
4 6 10)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 
4 6 10)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 7 *11)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs *3 
4 6 10)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
Feb 24 09:34:06 hades kernel: ACPI: PCI Interrupt Link [LNKU] (IRQs 3 
4 6 10)
Feb 24 09:34:06 hades kernel: ACPI: Embedded Controller [EC0] (gpe 24)
Feb 24 09:34:06 hades kernel: SCSI subsystem initialized
Feb 24 09:34:06 hades kernel: Linux Kernel Card Services
Feb 24 09:34:06 hades kernel:   options:  [pci] [cardbus] [pm]
Feb 24 09:34:06 hades kernel: drivers/usb/core/usb.c: registered new 
driver usbfs
Feb 24 09:34:06 hades kernel: drivers/usb/core/usb.c: registered new 
driver hub
Feb 24 09:34:06 hades kernel: PCI: Probing PCI hardware
Feb 24 09:34:06 hades kernel: PCI: Using IRQ router ALI [10b9/1533] at 
0000:00:07.0
Feb 24 09:34:06 hades kernel: PCI: Found IRQ 10 for device 0000:01:05.0
Feb 24 09:34:06 hades kernel: radeonfb: Invalid ROM signature 0 should 
be 0xaa55
Feb 24 09:34:06 hades kernel: radeonfb: Retreived PLL infos from BIOS
Feb 24 09:34:06 hades kernel: radeonfb: Reference=191.86 MHz 
(RefDiv=426) Memory=160.00 Mhz, System=133.00 MHz
Feb 24 09:34:06 hades kernel: Non-DDC laptop panel detected
Feb 24 09:34:06 hades kernel: radeonfb: Monitor 1 type LCD found
Feb 24 09:34:06 hades kernel: radeonfb: Monitor 2 type no found
Feb 24 09:34:06 hades kernel: radeonfb: panel ID string: LGP
Feb 24 09:34:06 hades kernel: radeonfb: detected LVDS panel size from 
BIOS: 1024x768
Feb 24 09:34:06 hades kernel: radeondb: BIOS provided dividers will be 
used
Feb 24 09:34:06 hades kernel: radeonfb: Power Management enabled for 
Mobility chipsets
Feb 24 09:34:06 hades kernel: mtrr: base(0xe0000000) is not aligned on 
a size(0xf000000) boundary
Feb 24 09:34:06 hades kernel: radeonfb: ATI Radeon C6  SDR SGRAM 240 MB
Feb 24 09:34:06 hades kernel: SBF: Simple Boot Flag extension found 
and enabled.
Feb 24 09:34:06 hades kernel: SBF: Setting boot flags 0x80
Feb 24 09:34:06 hades kernel: Machine check exception polling timer 
started.
Feb 24 09:34:06 hades kernel: powernow: PowerNOW! Technology present. 
Can scale: frequency and voltage.
Feb 24 09:34:06 hades kernel: powernow: Found PSB header at c00f15e0
Feb 24 09:34:06 hades kernel: powernow: Table version: 0x12
Feb 24 09:34:06 hades kernel: powernow: Flags: 0x0 (Mobile voltage 
regulator)
Feb 24 09:34:06 hades kernel: powernow: Settling Time: 100 microseconds.
Feb 24 09:34:06 hades kernel: powernow: Has 14 PST tables. (Only 
dumping ones relevant to this CPU).
Feb 24 09:34:06 hades kernel: powernow: PST:12 (@c00f16cc)
Feb 24 09:34:06 hades kernel: powernow:  cpuid: 0x781^Ifsb: 
133^ImaxFID: 0x15^Istartvid: 0xb
Feb 24 09:34:06 hades kernel: powernow:    FID: 0x12 (4.0x 
[532MHz])^IVID: 0x13 (1.200V)
Feb 24 09:34:06 hades kernel: powernow:    FID: 0x4 (5.0x 
[665MHz])^IVID: 0x13 (1.200V)
Feb 24 09:34:06 hades kernel: powernow:    FID: 0x6 (6.0x 
[798MHz])^IVID: 0x13 (1.200V)
Feb 24 09:34:06 hades kernel: powernow:    FID: 0x8 (7.0x 
[931MHz])^IVID: 0x13 (1.200V)
Feb 24 09:34:06 hades kernel: powernow:    FID: 0xe (10.0x 
[1330MHz])^IVID: 0xe (1.300V)
Feb 24 09:34:06 hades kernel: powernow:    FID: 0x15 (13.5x 
[1795MHz])^IVID: 0xb (1.450V)
Feb 24 09:34:06 hades kernel:
Feb 24 09:34:06 hades kernel: powernow: Minimum speed 532 MHz. Maximum 
speed 1795 MHz.
Feb 24 09:34:06 hades kernel: SGI XFS with no debug enabled
Feb 24 09:34:06 hades kernel: Initializing Cryptographic API
Feb 24 09:34:06 hades kernel: ATI Northbridge, reserving I/O ports 
0x3b0 to 0x3bb.
Feb 24 09:34:06 hades kernel: Activating ISA DMA hang workarounds.
Feb 24 09:34:06 hades kernel: ACPI: AC Adapter [ACAD] (on-line)
Feb 24 09:34:06 hades kernel: ACPI: Battery Slot [BAT1] (battery absent)
Feb 24 09:34:06 hades kernel: ACPI: Power Button (FF) [PWRF]
Feb 24 09:34:06 hades kernel: ACPI: Lid Switch [LID]
Feb 24 09:34:06 hades kernel: ACPI: Processor [CPU0] (supports C1 C2)
Feb 24 09:34:06 hades kernel: ACPI: Thermal Zone [THRM] (41 C)
Feb 24 09:34:06 hades kernel: Console: switching to colour frame 
buffer device 128x48
Feb 24 09:34:06 hades kernel: pty: 256 Unix98 ptys configured
Feb 24 09:34:06 hades kernel: HDLC line discipline: version $Revision: 
4.8 $, maxframe=4096
Feb 24 09:34:06 hades kernel: N_HDLC line discipline registered.
Feb 24 09:34:06 hades kernel: lp: driver loaded but no devices found
Feb 24 09:34:06 hades kernel: Real Time Clock Driver v1.12
Feb 24 09:34:06 hades kernel: Software Watchdog Timer: 0.06, 
soft_margin: 60 sec, nowayout: 0
Feb 24 09:34:06 hades kernel: Linux agpgart interface v0.100 (c) Dave 
Jones
Feb 24 09:34:06 hades kernel: agpgart: Detected Ati IGP320/M chipset
Feb 24 09:34:06 hades kernel: agpgart: Maximum main memory to use for 
agp memory: 148M
Feb 24 09:34:06 hades kernel: agpgart: AGP aperture is 64M @ 0xd4000000
Feb 24 09:34:06 hades kernel: [drm] Initialized radeon 1.9.0 20020828 
on minor 0
Feb 24 09:34:06 hades kernel: Serial: 8250/16550 driver $Revision: 
1.90 $ 8 ports, IRQ sharing enabled
Feb 24 09:34:06 hades kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 24 09:34:06 hades kernel: PCI: Found IRQ 3 for device 0000:00:08.0
Feb 24 09:34:06 hades kernel: ttyS1 at I/O 0x8828 (irq = 3) is a 8250
Feb 24 09:34:06 hades kernel: ttyS2 at I/O 0x8840 (irq = 3) is a 8250
Feb 24 09:34:06 hades kernel: ttyS3 at I/O 0x8850 (irq = 3) is a 8250
Feb 24 09:34:06 hades kernel: ttyS4 at I/O 0x8860 (irq = 3) is a 8250
Feb 24 09:34:06 hades kernel: ttyS5 at I/O 0x8870 (irq = 3) is a 8250
Feb 24 09:34:06 hades kernel: parport0: PC-style at 0x378 (0x778) 
[PCSPP,TRISTATE]
Feb 24 09:34:06 hades kernel: parport0: irq 7 detected
Feb 24 09:34:06 hades kernel: parport0: cpp_daisy: aa5500ff(38)
Feb 24 09:34:06 hades kernel: parport0: assign_addrs: aa5500ff(38)
Feb 24 09:34:06 hades kernel: parport0: cpp_daisy: aa5500ff(38)
Feb 24 09:34:06 hades kernel: parport0: assign_addrs: aa5500ff(38)
Feb 24 09:34:06 hades kernel: lp0: using parport0 (polling).
Feb 24 09:34:06 hades kernel: loop: loaded (max 8 devices)
Feb 24 09:34:06 hades kernel: natsemi dp8381x driver, version 
1.07+LK1.0.17, Sep 27, 2002
Feb 24 09:34:06 hades kernel:   originally by Donald Becker 
<becker@scyld.com>
Feb 24 09:34:06 hades kernel:   http://www.scyld.com/network/natsemi.html
Feb 24 09:34:06 hades kernel:   2.4.x kernel port by Jeff Garzik, 
Tjeerd Mulder
Feb 24 09:34:06 hades kernel: PCI: Found IRQ 11 for device 0000:00:12.0
Feb 24 09:34:06 hades kernel: eth0: NatSemi DP8381[56] at 0xcd860000, 
00:0d:9d:5a:5f:35, IRQ 11.
Feb 24 09:34:06 hades kernel: PPP generic driver version 2.4.2
Feb 24 09:34:06 hades kernel: PPP Deflate Compression module registered
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 24
Feb 24 09:34:06 hades kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Feb 24 09:34:06 hades kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Feb 24 09:34:06 hades kernel: Warning: ATI Radeon IGP Northbridge is 
not yet fully tested.
Feb 24 09:34:06 hades kernel: ALI15X3: IDE controller at PCI slot 
0000:00:10.0
Feb 24 09:34:06 hades kernel: ALI15X3: chipset revision 196
Feb 24 09:34:06 hades kernel: ALI15X3: not 100%% native mode: will 
probe irqs later
Feb 24 09:34:06 hades kernel:     ide0: BM-DMA at 0x8080-0x8087, BIOS 
settings: hda:DMA, hdb:pio
Feb 24 09:34:06 hades kernel:     ide1: BM-DMA at 0x8088-0x808f, BIOS 
settings: hdc:DMA, hdd:pio
Feb 24 09:34:06 hades kernel: hda: FUJITSU MHS2030AT, ATA DISK drive
Feb 24 09:34:06 hades kernel: Using anticipatory io scheduler
Feb 24 09:34:06 hades kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 24 09:34:06 hades kernel: hdc: DW-224E, ATAPI CD/DVD-ROM drive
Feb 24 09:34:06 hades kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 24 09:34:06 hades kernel: hda: max request size: 128KiB
Feb 24 09:34:06 hades kernel: hda: 58605120 sectors (30005 MB) 
w/2048KiB Cache, CHS=58140/16/63, UDMA(100)
Feb 24 09:34:06 hades kernel:  hda: hda1 hda2 hda3 hda4
Feb 24 09:34:06 hades kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 
1658kB Cache, UDMA(33)
Feb 24 09:34:06 hades kernel: Uniform CD-ROM driver Revision: 3.20
Feb 24 09:34:06 hades kernel: st: Version 20040122, fixed bufsize 
32768, s/g segs 256
Feb 24 09:34:06 hades kernel: Console: switching to colour frame 
buffer device 128x48
Feb 24 09:34:06 hades kernel: PCI: Found IRQ 11 for device 0000:00:0a.0
Feb 24 09:34:06 hades kernel: Yenta: CardBus bridge found at 
0000:00:0a.0 [103c:0024]
Feb 24 09:34:06 hades kernel: Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Feb 24 09:34:06 hades kernel: Socket status: 30000007
Feb 24 09:34:06 hades kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' 
Host Controller (OHCI) Driver (PCI)
Feb 24 09:34:06 hades kernel: ohci_hcd: block sizes: ed 64 td 64
Feb 24 09:34:06 hades kernel: PCI: Assigned IRQ 9 for device 0000:00:02.0
Feb 24 09:34:06 hades kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
Feb 24 09:34:06 hades kernel: ohci_hcd 0000:00:02.0: irq 9, pci mem 
cd864000
Feb 24 09:34:06 hades kernel: ohci_hcd 0000:00:02.0: new USB bus 
registered, assigned bus number 1
Feb 24 09:34:06 hades kernel: hub 1-0:1.0: USB hub found
Feb 24 09:34:06 hades kernel: hub 1-0:1.0: 4 ports detected
Feb 24 09:34:06 hades kernel: drivers/usb/core/usb.c: registered new 
driver usblp
Feb 24 09:34:06 hades kernel: drivers/usb/class/usblp.c: v0.13: USB 
Printer Device Class driver
Feb 24 09:34:06 hades kernel: Initializing USB Mass Storage driver...
Feb 24 09:34:06 hades kernel: drivers/usb/core/usb.c: registered new 
driver usb-storage
Feb 24 09:34:06 hades kernel: USB Mass Storage support registered.
Feb 24 09:34:06 hades kernel: drivers/usb/core/usb.c: registered new 
driver hid
Feb 24 09:34:06 hades kernel: drivers/usb/input/hid-core.c: v2.0:USB 
HID core driver
Feb 24 09:34:06 hades kernel: mice: PS/2 mouse device common for all mice
Feb 24 09:34:06 hades kernel: input: PC Speaker
Feb 24 09:34:06 hades kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 24 09:34:06 hades kernel: Synaptics Touchpad, model: 1
Feb 24 09:34:06 hades kernel:  Firmware: 5.8
Feb 24 09:34:06 hades kernel:  Sensor: 35
Feb 24 09:34:06 hades kernel:  new absolute packet format
Feb 24 09:34:06 hades kernel:  Touchpad has extended capability bits
Feb 24 09:34:06 hades kernel:  -> multifinger detection
Feb 24 09:34:06 hades kernel:  -> palm detection
Feb 24 09:34:06 hades kernel: input: SynPS/2 Synaptics TouchPad on 
isa0060/serio1
Feb 24 09:34:06 hades kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 24 09:34:06 hades kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Feb 24 09:34:06 hades kernel: Advanced Linux Sound Architecture Driver 
Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
Feb 24 09:34:06 hades kernel: PCI: Found IRQ 5 for device 0000:00:06.0
Feb 24 09:34:06 hades kernel: ALSA device list:
Feb 24 09:34:06 hades kernel:   #0: ALI 5451 at 0x8400, irq 5
Feb 24 09:34:06 hades kernel: atkbd.c: Unknown key pressed (translated 
set 2, code 0xee on isa0060/serio0).
Feb 24 09:34:06 hades kernel: atkbd.c: Use 'setkeycodes e06e 
<keycode>' to make it known.
Feb 24 09:34:06 hades kernel: atkbd.c: Unknown key released 
(translated set 2, code 0xee on isa0060/serio0).
Feb 24 09:34:06 hades kernel: atkbd.c: Use 'setkeycodes e06e 
<keycode>' to make it known.
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 2
Feb 24 09:34:06 hades kernel: IP: routing cache hash table of 1024 
buckets, 8Kbytes
Feb 24 09:34:06 hades kernel: TCP: Hash tables configured (established 
16384 bind 32768)
Feb 24 09:34:06 hades kernel: ip_conntrack version 2.1 (1527 buckets, 
12216 max) - 296 bytes per conntrack
Feb 24 09:34:06 hades kernel: ip_tables: (C) 2000-2002 Netfilter core team
Feb 24 09:34:06 hades kernel: Initializing IPsec netlink socket
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 1
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 10
Feb 24 09:34:06 hades kernel: IPv6 over IPv4 tunneling driver
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 17
Feb 24 09:34:06 hades kernel: NET: Registered protocol family 15
Feb 24 09:34:06 hades kernel: ACPI: (supports S0 S3 S4 S5)
Feb 24 09:34:06 hades kernel: XFS mounting filesystem hda3
Feb 24 09:34:06 hades kernel: usb 1-1: new low speed USB device using 
address 2
Feb 24 09:34:06 hades kernel: Ending clean XFS mount for filesystem: hda3
Feb 24 09:34:06 hades kernel: VFS: Mounted root (xfs filesystem) readonly.
Feb 24 09:34:06 hades kernel: Freeing unused kernel memory: 156k freed
Feb 24 09:34:06 hades kernel: input: USB HID v1.10 Mouse [Logitech USB 
Mouse] on usb-0000:00:02.0-1
Feb 24 09:34:06 hades kernel: eth0: link up.
Feb 24 09:34:06 hades kernel: eth0: Setting full-duplex based on 
negotiated link capability.

