Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbUCUAtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbUCUAtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:49:03 -0500
Received: from 62.79.102.158.adsl.arc.worldonline.dk ([62.79.102.158]:3857
	"EHLO mail.bitplanet.net") by vger.kernel.org with ESMTP
	id S263581AbUCUArk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:47:40 -0500
Message-ID: <405CE626.3000301@bitplanet.net>
Date: Sun, 21 Mar 2004 01:47:34 +0100
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI IRQ routing problems with Thinkpad T40
Content-Type: multipart/mixed;
 boundary="------------000008030504050809080904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008030504050809080904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've been trying to track down a problem where an interrupt from a
cardbus card is being routed incorrectly.  I'm running 2.6.3 with ACPI
enabled on an IBM Thinkpad T40 which has a TI1250 cardbus controller.
The cardbus controller I'm using is a PCILynx IEEE1394 controller, but
that doesn't seem to be the problem as I get the same behavior with a
OHCI IEEE1394 controller.

The problem is that when I use the second cardbus slot the device gets
assigned IRQ 9, but it generates interrupts on IRQ 5.  After a short
while the kernel disables IRQ 5 as nobody is handling the interrupt.

I've tried to print out dev->irq before calling pci_enable_device() and
at this point it's 5, but after enabling it has been set to 9.

I've attached the output of lspci -vv and dmesg.  Before loading the
driver for the cardbus device lspci reports IRQ 5, after loading the
driver lspci reports IRQ 9. One thing that looks strange to me is that
the cardbus device (07:00.0) has interrupt pin A, but the cardbus
controller that it is attached to (02:00.1) has interrupt pin B.  Or is 
it a problem with the cardbus controller not honoring the new IRQ that's 
assigned to it?

I'm booting with pci=noacpi now, which fixes the problem, but I'm ready
to help track this down, if somebody has a suggestion.  I've also
attached noacpi versions of lspci and dmesg outputs (after loading the 
driver).

Kristian


--------------000008030504050809080904
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.3 (krh@localhost.localdomain) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #2 SMP Wed Feb 25 21:48:42 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                                       ) @ 0x000f6b40
ACPI: XSDT (v001 IBM    TP-1R    0x00002020  LTP 0x00000000) @ 0x1ff6c273
ACPI: FADT (v003 IBM    TP-1R    0x00002020 IBM  0x00000001) @ 0x1ff6c300
ACPI: SSDT (v001 IBM    TP-1R    0x00002020 MSFT 0x0100000e) @ 0x1ff6c4b4
ACPI: ECDT (v001 IBM    TP-1R    0x00002020 IBM  0x00000001) @ 0x1ff77e16
ACPI: TCPA (v001 IBM    TP-1R    0x00002020 PTL  0x00000001) @ 0x1ff77e68
ACPI: BOOT (v001 IBM    TP-1R    0x00002020  LTP 0x00000001) @ 0x1ff77fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00002020 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 rhgb
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1495.512 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513384k/523648k available (2628k kernel code, 9496k reserved, 981k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2957.31 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) M processor 1500MHz stepping 05
per-CPU timeslice cutoff: 2925.79 usecs.
task migration cache decay timeout: 3 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1494.0939 MHz.
..... host bus clock speed is 99.0662 MHz.
Starting migration thread for cpu 0
Brought up 0 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Found ECDT
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.USB7._INI] (Node dfef2560), AE_AML_REGION_LIMIT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=260.00 Mhz, System=183.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768                
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LW  DDR SGRAM 32 MB
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (47 C)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
[drm] Initialized i830 1.3.2 20021108 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.00 loaded.
Console: switching to colour frame buffer device 128x48
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 9, pci mem e1882000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49438 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xc0000c00, irq 5
oprofile: using NMI interrupt.
pktgen.c: v1.3: Packet Generator for packet performance testing.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
EXT3 FS on hda2, internal journal
Adding 521632k swap on /dev/hda3.  Priority:-1 extents:1
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
Copyright (c) 1999-2004 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0088, PCI irq 9
Socket status: 30000020
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0088, PCI irq 5
Socket status: 30000020

--------------000008030504050809080904
Content-Type: text/plain;
 name="dmesg-noacpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-noacpi"

0: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                                       ) @ 0x000f6b40
ACPI: XSDT (v001 IBM    TP-1R    0x00002020  LTP 0x00000000) @ 0x1ff6c273
ACPI: FADT (v003 IBM    TP-1R    0x00002020 IBM  0x00000001) @ 0x1ff6c300
ACPI: SSDT (v001 IBM    TP-1R    0x00002020 MSFT 0x0100000e) @ 0x1ff6c4b4
ACPI: ECDT (v001 IBM    TP-1R    0x00002020 IBM  0x00000001) @ 0x1ff77e16
ACPI: TCPA (v001 IBM    TP-1R    0x00002020 PTL  0x00000001) @ 0x1ff77e68
ACPI: BOOT (v001 IBM    TP-1R    0x00002020  LTP 0x00000001) @ 0x1ff77fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00002020 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 pci=noacpi 3
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1495.539 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513384k/523648k available (2628k kernel code, 9496k reserved, 981k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2957.31 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) M processor 1500MHz stepping 05
per-CPU timeslice cutoff: 2925.79 usecs.
task migration cache decay timeout: 3 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1494.0916 MHz.
..... host bus clock speed is 99.0660 MHz.
Starting migration thread for cpu 0
Brought up 0 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Found ECDT
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.USB7._INI] (Node dfef2560), AE_AML_REGION_LIMIT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/24cc] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:02:02.0
PCI: Found IRQ 9 for device 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:02:00.0
PCI: Sharing IRQ 9 with 0000:02:01.0
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=260.00 Mhz, System=183.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768                
radeonfb: detected LVDS panel size from BIOS: 1024x768
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LW  DDR SGRAM 32 MB
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (47 C)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
[drm] Initialized i830 1.3.2 20021108 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
PCI: Found IRQ 5 for device 0000:00:1f.6
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:02:00.1
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:02:02.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.00 loaded.
Console: switching to colour frame buffer device 128x48
PCI: Found IRQ 9 for device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 9, pci mem e1882000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 9 for device 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:02:00.0
PCI: Sharing IRQ 9 with 0000:02:01.0
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:02.0
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
PCI: Found IRQ 5 for device 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.6
PCI: Sharing IRQ 5 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49431 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xc0000c00, irq 5
oprofile: using NMI interrupt.
pktgen.c: v1.3: Packet Generator for packet performance testing.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
EXT3 FS on hda2, internal journal
Adding 521632k swap on /dev/hda3.  Priority:-1 extents:1
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k1
Copyright (c) 1999-2004 Intel Corporation.
PCI: Found IRQ 9 for device 0000:02:01.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:02:00.0
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 0000:02:00.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:02:01.0
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0088, PCI irq 9
Socket status: 30000006
PCI: Found IRQ 5 for device 0000:02:00.1
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.6
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0088, PCI irq 5
Socket status: 30000020
pin=0x01, dword=0xdfd9b680
dev=0000:07:00.0, old-pin=1, new-pin=1, parent=0000:02:00.1, parent_pin=2
nosy: probe of 0000:07:00.0 failed with error -6
Loaded nosy.
Unloaded nosy.
irq=5, dev=0000:07:00.0, old-pin=1, new-pin=1, parent=0000:02:00.1, parent_pin=2
nosy: probe of 0000:07:00.0 failed with error -6
Loaded nosy.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
PCI: Found IRQ 9 for device 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:02:00.0
PCI: Sharing IRQ 9 with 0000:02:01.0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Unloaded nosy.
PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
PCI: Setting latency timer of device 0000:07:00.0 to 64
Initialized PCILynx IEEE1394 card, irq=5
Loaded nosy.
pin=0x01, dword=0xdfd9b780
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[20800000-208007ff]  Max Packet=[1024]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[003095241000e38e]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node removed: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
doh, someone wants to mess with state set
ieee1394: ConfigROM quadlet transaction error for node 0-01:1023
ieee1394: ConfigROM quadlet transaction error for node 0-02:1023
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
doh, someone wants to mess with state set
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0009a74000009000]
ieee1394: Node changed: 0-00:1023 -> 0-02:1023
ieee1394: Node changed: 0-02:1023 -> 0-00:1023
ieee1394: Node removed: ID:BUS[0-01:1023]  GUID[0009a74000009000]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node removed: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node removed: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node removed: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0009a74000009000]
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023

--------------000008030504050809080904
Content-Type: text/plain;
 name="lspci-vv"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-vv"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 01)
	Subsystem: IBM: Unknown device 0537
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0525
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0530
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
	Subsystem: IBM: Unknown device 0549
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 8000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2551
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at c0210000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

03:00.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink] Host Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 0063
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 20800000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 20801000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 20801100 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

07:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller (rev 04) (prog-if 00 [Generic])
	Subsystem: Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 21020000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Region 1: Memory at 21000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 2: Memory at 21010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Expansion ROM at 20c00000 [disabled] [size=64K]


--------------000008030504050809080904
Content-Type: text/plain;
 name="lspci-vv-noacpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-vv-noacpi"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 01)
	Subsystem: IBM: Unknown device 0537
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0525
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0530
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
	Subsystem: IBM: Unknown device 0549
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 8000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2551
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at c0210000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

03:00.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink] Host Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 0063
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 20800000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 20801000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 20801100 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

07:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller (rev 04) (prog-if 00 [Generic])
	Subsystem: Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 21020000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 21000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 21010000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 20c00000 [disabled] [size=64K]


--------------000008030504050809080904
Content-Type: text/plain;
 name="lspci-vv-after-driver"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-vv-after-driver"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
	Subsystem: IBM: Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
	Subsystem: IBM: Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 01)
	Subsystem: IBM: Unknown device 0537
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0525
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 0530
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller (rev 01)
	Subsystem: IBM ThinkPad T30
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 20
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:01.0 Ethernet controller: Intel Corp.: Unknown device 101e (rev 03)
	Subsystem: IBM: Unknown device 0549
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at 8000 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

02:02.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corp.: Unknown device 2551
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at c0210000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

03:00.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink] Host Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation: Unknown device 0063
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 20800000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 20801000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 20801100 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

07:00.0 FireWire (IEEE 1394): Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller (rev 04) (prog-if 00 [Generic])
	Subsystem: Texas Instruments PCILynx/PCILynx2 IEEE 1394 Link Layer Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 500ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 21020000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at 21000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 21010000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 20c00000 [disabled] [size=64K]


--------------000008030504050809080904--
