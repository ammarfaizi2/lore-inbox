Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbUDGTY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDGTY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:24:59 -0400
Received: from [202.28.93.1] ([202.28.93.1]:42770 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S264156AbUDGTY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:24:28 -0400
Date: Thu, 8 Apr 2004 02:24:19 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040408022419.52ef7a29.kitt@gear.kku.ac.th>
In-Reply-To: <200404071741.47624.daniel.ritz@gmx.ch>
References: <200404060227.58325.daniel.ritz@gmx.ch>
	<20040406093510.33c937e3.kitt@gear.kku.ac.th>
	<200404071741.47624.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

> looks like you need a little workaround in the interuput routing code...please
> apply the attached patch, send dmesg output plus output of dmidecode
> ( http://www.nongnu.org/demidecode/ ).

Guess so, I've tried on 2.6.5 with acpi=off, pci=biosirq, and excluded irq 11 in /etc/pcmcia/config.opts. They still routed to irq 11. 

Anyway, my orinoco card (hardwired on TI cardbus controller) works with 2.4.xx + pcmcia-cs package using i82365 and do_scan=0. But the system freezed when I inserted a PCMCIA card into one of those controlled by o2micro. Below is dmesg when I start pcmcia service on 2.4.22-6_1.2174.nptl: 

Linux PCMCIA Card Services 3.2.7
  kernel build: 2.4.22-6_1.2174.nptl_01tlecustom #7 Mon Apr 5 05:31:52 ICT 2004
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 10 for device 01:05.0
PCI: Sharing IRQ 10 with 01:08.0
  TI 1410 rev 01 PCI-to-CardBus at slot 01:05, mem 0x10001000
    host opts [0]: [pci only] [pci irq 10] [lat 32/176] [bus 2/5]
    PCI card interrupts, PCI status changes
PCI: Found IRQ 11 for device 01:09.0
PCI: Sharing IRQ 11 with 00:1d.1
PCI: Sharing IRQ 11 with 01:09.1
PCI: Found IRQ 11 for device 01:09.1
PCI: Sharing IRQ 11 with 00:1d.1
PCI: Sharing IRQ 11 with 01:09.0
  O2Micro OZ6933 rev 02 PCI-to-CardBus at slot 01:09, mem 0x10002000
    host opts [0]: [pci/way] [pci irq 11] [lat 32/176] [bus 6/9]
    host opts [1]: [pci/way] [pci irq 11] [lat 32/176] [bus 10/13]
    ISA irqs (default) = 3,4,5,7 PCI status changes
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
cs: IO port probe 0x0100-0x037f: excluding 0x240-0x247 0x378-0x37f
cs: IO port probe 0x0400-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
eth1: Station identity 001f:0001:0006:0010
eth1: Looks like a Lucent/Agere firmware version 6.16
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:46:11:44
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 10, io 0x0100-0x

> on the other side it could be that the o2micro bridge is wrongly programmed.
> what looks a bit weired is that both functions of the o2micro show Pin A
> routed to IRQ 11. this could be wrong. i'm reading the spec now.
>
> do you happen to have the redmond OS on this machine? it would be nice to see
> which interrupt windoze assignes to the o2micro bridge.

Ah, I'm about to tell you this :) Win XP used irq 9 for all cardbus bridges.

> and one more question: any change in the interrupt assignment if you use full ACPI?

The bridges still used irq 11 when I passed just "acpi=on".

I have a few questions here: do I need APIC and IO-APIC in the kernel ? I used to enable them but /proc/interrupts showed only XT-PIC so I disabled them. And, should I try to upgrade the BIOS ? 

Below is dmesg / dmidecode after patched. 

# dmesg
h table entries: 1024 (order 10: 8192 bytes)
Detected 999.945 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 247580k/253824k available (1931k kernel code, 5508k reserved, 755k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1982.46 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: BIOS32 Service Directory structure at 0xc00f0280
PCI: BIOS32 Service Directory entry at 0xf0210
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: IDE base address fixup for 0000:00:1f.1
PCI: IDE base address trash cleared for 0000:00:1f.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Peer bridge fixup
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fb700
00:02 slot=00 0:60/0800 1:00/0000 2:00/0000 3:00/0000
00:1f slot=00 0:60/1ef8 1:61/1ef8 2:62/1ef8 3:63/1ef8
00:1d slot=00 0:60/0800 1:63/0800 2:62/0800 3:00/0000
01:09 slot=00 0:63/0800 1:63/0800 2:00/0000 3:00/0000
01:08 slot=00 0:68/0400 1:00/0000 2:00/0000 3:00/0000
01:03 slot=00 0:69/0400 1:00/0000 2:00/0000 3:00/0000
01:05 slot=00 0:68/0400 1:00/0000 2:00/0000 3:00/0000
PCI: Attempting to find IRQ router for 8086:248c
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ fixup
0000:00:1f.1: ignoring bogus IRQ 255
IRQ for 0000:00:1f.1:0 -> PIRQ 60, mask 1ef8, excl 0000<4>PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=0 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Allocating resources
PCI: Resource 98000000-9fffffff (f=1208, d=0, p=0)
PCI: Resource 90100000-9017ffff (f=200, d=0, p=0)
PCI: Resource 88000000-8fffffff (f=1208, d=0, p=0)
PCI: Resource 80200000-8027ffff (f=200, d=0, p=0)
PCI: Resource 0000a4a0-0000a4bf (f=101, d=0, p=0)
PCI: Resource 0000a4e0-0000a4ff (f=101, d=0, p=0)
PCI: Resource 0000a800-0000a81f (f=101, d=0, p=0)
PCI: Resource 0000a890-0000a89f (f=101, d=0, p=0)
PCI: Resource 00008000-0000801f (f=101, d=0, p=0)
PCI: Resource 00009800-000098ff (f=101, d=0, p=0)
PCI: Resource 00009c00-00009c3f (f=101, d=0, p=0)
PCI: Resource 0000a000-0000a0ff (f=101, d=0, p=0)
PCI: Resource 0000a400-0000a47f (f=101, d=0, p=0)
PCI: Resource 80100000-801007ff (f=200, d=0, p=0)
PCI: Resource 80104000-80107fff (f=200, d=0, p=0)
PCI: Resource 80101000-80101fff (f=200, d=0, p=0)
PCI: Resource 00007000-0000703f (f=101, d=0, p=0)
PCI: Sorting device list...
vesafb: framebuffer at 0x98000000, mapped to 0xd000e000, size 8000k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x6e set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THR1] (57 C)
ACPI: Thermal Zone [THR2] (51 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0x98000000
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
IRQ for 0000:00:1f.6:1 -> PIRQ 61, mask 1ef8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
IRQ for 0000:00:1f.1:0 -> PIRQ 60, mask 1ef8, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa890-0xa897, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa898-0xa89f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4025GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DV-28E-B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
IRQ for 0000:00:1d.0:0 -> PIRQ 60, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000a4a0
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
IRQ for 0000:00:1d.1:1 -> PIRQ 63, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:01:09.1
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0000a4e0
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
IRQ for 0000:00:1d.2:2 -> PIRQ 62, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:1d.2
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000a800
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [A4Tech USB Optical Mouse] on usb-0000:00:1d.0-1
EXT3 FS on hda2, internal journal
Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1
IRQ for 0000:00:1f.5:1 -> PIRQ 61, mask 1ef8, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49566 usecs
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1172 $ Ben Collins <bcollins@debian.org>
IRQ for 0000:01:03.0:0 -> PIRQ 69, mask 0400, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 0000:01:03.0
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[80100000-801007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0120900300000000]
microcode: error! Bad data in microcode data file
microcode: Error in the microcode data
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
IRQ for 0000:01:08.0:0 -> PIRQ 68, mask 0400, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 0000:01:08.0
PCI: Sharing IRQ 10 with 0000:01:05.0
e100: eth0: e100_probe: addr 0x80101000, irq 10, MAC addr 00:00:E2:61:54:AE
mtrr: base(0x98000000) is not aligned on a size(0x180000) boundary
IRQ for 0000:00:02.0:0 -> PIRQ 60, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:00:02.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x400000
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
cdrom: This disc doesn't have any tracks I recognize!
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:01:05.0 (0000 -> 0002)
IRQ for 0000:01:05.0:0 -> PIRQ 68, mask 0400, excl 0000 -> newirq=10 -> got IRQ 10
PCI: Found IRQ 10 for device 0000:01:05.0
PCI: Sharing IRQ 10 with 0000:01:08.0
Yenta: CardBus bridge found at 0000:01:05.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 10
Socket status: 30000011
IRQ for 0000:01:09.0:0 -> PIRQ 63, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:01:09.0
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.1
Yenta: CardBus bridge found at 0000:01:09.0 [1025:1022]
irq 10: nobody cared!
Call Trace:
 [<c0108eca>] __report_bad_irq+0x2a/0x90
 [<c0108fc0>] note_interrupt+0x70/0xb0
 [<c0109270>] do_IRQ+0x120/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c01217ee>] do_softirq+0x3e/0xa0
 [<c010924a>] do_IRQ+0xfa/0x130
 [<c0107618>] common_interrupt+0x18/0x20
 [<c0113284>] delay_pmtmr+0x14/0x20
 [<c01cf512>] __delay+0x12/0x20
 [<d0dba9fe>] yenta_probe_irq+0xfe/0x140 [yenta_socket]
 [<d0dbaa7a>] yenta_get_socket_capabilities+0x3a/0x70 [yenta_socket]
 [<d0dbadc7>] yenta_probe+0x1a7/0x240 [yenta_socket]
 [<c01d3712>] pci_device_probe_static+0x52/0x70
 [<c01d376c>] __pci_device_probe+0x3c/0x50
 [<c01d37ac>] pci_device_probe+0x2c/0x50
 [<c0232b1f>] bus_match+0x3f/0x70
 [<c0232c4c>] driver_attach+0x5c/0xa0
 [<c0232f78>] bus_add_driver+0xa8/0xc0
 [<c02333cf>] driver_register+0x2f/0x40
 [<c01d399c>] pci_register_driver+0x5c/0x90
 [<d0dbe00f>] yenta_socket_init+0xf/0x11 [yenta_socket]
 [<c0134722>] sys_init_module+0x142/0x280
 [<c0107459>] sysenter_past_esp+0x52/0x71
 
handlers:
[<d0913890>] (snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
[<d090ba10>] (ohci_irq_handler+0x0/0x860 [ohci1394])
[<d0db98a0>] (yenta_interrupt+0x0/0x40 [yenta_socket])
Disabling IRQ #10
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000006
IRQ for 0000:01:09.1:0 -> PIRQ 63, mask 0800, excl 0000 -> newirq=11 -> got IRQ 11
PCI: Found IRQ 11 for device 0000:01:09.1
PCI: Sharing IRQ 11 with 0000:00:1d.1
PCI: Sharing IRQ 11 with 0000:01:09.0
Yenta: CardBus bridge found at 0000:01:09.1 [1025:1022]
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000410
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x240-0x247 0x378-0x38f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0006:0010
eth1: Looks like a Lucent/Agere firmware version 6.16
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:2D:46:11:44
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 3.3, irq 10, io 0x0100-0x013f

[root@peorth root]# dmidecode
# dmidecode 2.2
SMBIOS 2.3 present.
37 structures occupying 1234 bytes.
Table at 0x000FB880.
Handle 0x0000
        DMI type 0, 19 bytes.
        BIOS Information
                Vendor: ACER
                Version: V3.3 R01-B1   EN
                Release Date: 12/10/2001
                Address: 0xF0000
                Runtime Size: 64 kB
                ROM Size: 512 kB
                Characteristics:
                        ISA is supported
                        PCI is supported
                        PC Card (PCMCIA) is supported
                        PNP is supported
                        APM is supported
                        BIOS is upgradeable
                        BIOS shadowing is allowed
                        Boot from CD is supported
                        Selectable boot is supported
                        EDD is supported
                        Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
                        Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
                        3.5"/720 KB floppy services are supported (int 13h)
                        3.5"/2.88 MB floppy services are supported (int 13h)
                        Print screen service is supported (int 5h)
                        8042 keyboard services are supported (int 9h)
                        Serial services are supported (int 14h)
                        Printer services are supported (int 17h)
                        CGA/mono video services are supported (int 10h)
                        ACPI is supported
                        AGP is supported
                        Smart battery is supported
Handle 0x0100
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: Acer
                Product Name: TravelMate 360
                Version: -1
                Serial Number: 9145S0111T209003A4K000
                UUID: FFFFD8C7-F860-2BB7-11D6-A4A3AB8B57C8
                Wake-up Type: <OUT OF SPEC>
Handle 0x0200
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer: Acer
                Product Name: Intel Almador-M
                Version: -1
                Serial Number: 9145S0111T209003A4K000
Handle 0x0300
        DMI type 3, 13 bytes.
        Chassis Information
                Manufacturer: Acer
                Type: Notebook
                Lock: Not Present
                Version: -1
                Serial Number: 9145S0111T209003A4K000
                Asset Tag:
                Boot-up State: Unknown
                Power Supply State: Unknown
                Thermal State: Unknown
                Security Status: Unknown
Handle 0x0400
        DMI type 4, 32 bytes.
        Processor Information
                Socket Designation: U11
                Type: Central Processor
                Family: Pentium III
                Manufacturer: Intel
                ID: B1 06 00 00 FF F9 83 03
                Signature: Type 0, Family 6, Model B, Stepping 1
                Flags:
                        FPU (Floating-point unit on-chip)
                        VME (Virtual mode extension)
                        DE (Debugging extension)
                        PSE (Page size extension)
                        TSC (Time stamp counter)
                        MSR (Model specific registers)
                        PAE (Physical address extension)
                        MCE (Machine check exception)
                        CX8 (CMPXCHG8 instruction supported)
                        SEP (Fast system call)
                        MTRR (Memory type range registers)
                        PGE (Page global enable)
                        MCA (Machine check architecture)
                        CMOV (Conditional move instruction supported)
                        PAT (Page attribute table)
                        PSE-36 (36-bit page size extension)
                        MMX (MMX technology supported)
                        FXSR (Fast floating-point save and restore)
                        SSE (Streaming SIMD extensions)
                Version: Pentium(R) III
                Voltage: 1.6 V
                External Clock: 133 MHz
                Max Speed: 1000 MHz
                Current Speed: 1000 MHz
                Status: Unpopulated
                Upgrade: Daughter Board
                L1 Cache Handle: 0x0700
                L2 Cache Handle: 0x0701
                L3 Cache Handle: Not Provided
Handle 0x0500
        DMI type 5, 20 bytes.
        Memory Controller Information
                Error Detecting Method: None
                Error Correcting Capabilities:
                        None
                Supported Interleave: Unknown
                Current Interleave: Unknown
                Maximum Memory Module Size: 256 MB
                Maximum Total Memory Size: 512 MB
                Supported Speeds:
                        Unknown
                Supported Memory Types:
                        DIMM
                        SDRAM
                Memory Module Voltage: 3.3 V
                Associated Memory Slots: 2
                        0x0600
                        0x0601
                Enabled Error Correcting Capabilities:
                        None
Handle 0x0600
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: DM2
                Bank Connections: None
                Current Speed: Unknown
                Type: Unknown
                Installed Size: Not Installed (Single-bank Connection)
                Enabled Size: Not Installed (Single-bank Connection)
                Error Status: OK
Handle 0x0601
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: CN22
                Bank Connections: 2 3
                Current Speed: Unknown
                Type: DIMM SDRAM
                Installed Size: 256 MB (Single-bank Connection)
                Enabled Size: 256 MB (Single-bank Connection)
                Error Status: OK
Handle 0x0700
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: U11
                Configuration: Enabled, Not Socketed, Level 1
                Operational Mode: Write Back
                Location: Internal
                Installed Size: 32 KB
                Maximum Size: 32 KB
                Supported SRAM Types:
                        Unknown
                Installed SRAM Type: Unknown
                Speed: Unknown
                Error Correction Type: Unknown
                System Type: Unified
                Associativity: Unknown
Handle 0x0701
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: U37
                Configuration: Enabled, Not Socketed, Level 2
                Operational Mode: Write Back
                Location: Internal
                Installed Size: 512 KB
                Maximum Size: 512 KB
                Supported SRAM Types:
                        Pipeline Burst
                        Synchronous
                Installed SRAM Type: Pipeline Burst
                Speed: Unknown
                Error Correction Type: Single-bit ECC
                System Type: Unified
                Associativity: Fully Associative
Handle 0x0800
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN2
                Internal Connector Type: None
                External Reference Designator: Serial 1
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible
Handle 0x0801
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: U1
                Internal Connector Type: None
                External Reference Designator: Infrared
                External Connector Type: Infrared
                Port Type: Other
Handle 0x0802
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN3
                Internal Connector Type: None
                External Reference Designator: Parallel
                External Connector Type: DB-25 female
                Port Type: Parallel Port ECP
Handle 0x0803
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN1
                Internal Connector Type: None
                External Reference Designator: KEYBOARD
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x0804
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN1
                Internal Connector Type: None
                External Reference Designator: MOUSE
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x0805
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN5
                Internal Connector Type: None
                External Reference Designator: USB
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0806
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN6
                Internal Connector Type: None
                External Reference Designator: USB
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0807
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN26
                Internal Connector Type: None
                External Reference Designator: MODEM
                External Connector Type: RJ-11
                Port Type: Modem Port
Handle 0x0808
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: U49
                Internal Connector Type: None
                External Reference Designator: LAN
                External Connector Type: RJ-45
                Port Type: Network Port
Handle 0x0809
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN24
                Internal Connector Type: Proprietary
                External Reference Designator: LINE-IN JACK
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x080A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN24
                Internal Connector Type: Proprietary
                External Reference Designator: HEADPHONE-OUT JACK
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x080B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN24
                Internal Connector Type: Proprietary
                External Reference Designator: MICROPHONE-IN JACK
                External Connector Type: Mini Jack (headphones)
                Port Type: Audio Port
Handle 0x080C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: CN2
                Internal Connector Type: None
                External Reference Designator: EXTERNAL DISPLAY
                External Connector Type: DB-15 female
                Port Type: Video Port
Handle 0x0900
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: CN13A
                Type: 32-bit PC Card (PCMCIA)
                Current Usage: Available
                Length: Long
                ID: Adapter 0, Socket 1
                Characteristics:
                        5.0 V is provided
                        3.3 V is provided
                        PME signal is supported
Handle 0x0901
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: CN13B
                Type: 32-bit PC Card (PCMCIA)
                Current Usage: Available
                Length: Long
                ID: Adapter 0, Socket 2
                Characteristics:
                        5.0 V is provided
                        3.3 V is provided
                        PME signal is supported
Handle 0x0A00
        DMI type 10, 8 bytes.
        On Board Device Information
                Type: Video
                Status: Enabled
                Description: Trident 9525DVD
        On Board Device Information
                Type: Sound
                Status: Enabled
                Description: Intel AC97
Handle 0x0D00
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 1
                        en|US|iso8859-1
                Currently Installed Language: en|US|iso8859-1
Handle 0x1000
        DMI type 16, 15 bytes.
        Physical Memory Array
                Location: System Board Or Motherboard
                Use: System Memory
                Error Correction Type: None
                Maximum Capacity: 256 MB
                Error Information Handle: Not Provided
                Number Of Devices: 2
Handle 0x1100
        DMI type 17, 23 bytes.
        Memory Device
                Array Handle: 0x1000
                Error Information Handle: Not Provided
                Total Width: 64 bits
                Data Width: 64 bits
                Size: No Module Installed
                Form Factor: DIMM
                Set: 2
                Locator: DM2
                Bank Locator: BANK 0
                Type: SDRAM
                Type Detail: Synchronous
                Speed: Unknown
Handle 0x1101
        DMI type 17, 23 bytes.
        Memory Device
                Array Handle: 0x1000
                Error Information Handle: Not Provided
                Total Width: 64 bits
                Data Width: 64 bits
                Size: 256 MB
                Form Factor: DIMM
                Set: 2
                Locator: CN22
                Bank Locator: BANK 1
                Type: SDRAM
                Type Detail: Synchronous
                Speed: Unknown
Handle 0x1300
        DMI type 19, 15 bytes.
        Memory Array Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0000FFFFFFF
                Range Size: 256 MB
                Physical Array Handle: 0x1000
                Partition Width: 0
Handle 0x1400
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x000000003FF
                Range Size: 1 kB
                Physical Device Handle: 0x1100
                Memory Array Mapped Address Handle: 0x1300
                Partition Row Position: 1
Handle 0x1401
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0000FFFFFFF
                Range Size: 256 MB
                Physical Device Handle: 0x1101
                Memory Array Mapped Address Handle: 0x1300
                Partition Row Position: 1
Handle 0x1500
        DMI type 21, 7 bytes.
        Built-in Pointing Device
                Type: Touch Pad
                Interface: PS/2
                Buttons: 4
Handle 0x1600
        DMI type 22, 16 bytes.
        Portable Battery
                Location: On the Right-hand side
                Manufacturer:
                Manufacture Date:
                Serial Number:
                Name:
                Chemistry: Lithium Ion
                Design Capacity: Unknown
                Design Voltage: Unknown
                SBDS Version:
                Maximum Error: 6%
Handle 0x2000
        DMI type 32, 11 bytes.
        System Boot Information
                Status: No errors detected
Handle 0x7F00
        DMI type 127, 4 bytes.
        End Of Table
Wrong DMI structures length: 1234 bytes announced, structures occupy 1228 bytes.
