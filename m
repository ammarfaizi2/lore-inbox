Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUGQXP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUGQXP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUGQXPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:15:07 -0400
Received: from nevyn.them.org ([66.93.172.17]:61140 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S264045AbUGQXKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 19:10:13 -0400
Date: Sat, 17 Jul 2004 19:09:24 -0400
From: Daniel Jacobowitz <drow@false.org>
To: discuss@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: Intermittent panic at boot on x86-64
Message-ID: <20040717230924.GA7174@nevyn.them.org>
Mail-Followup-To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to set up a dual Opteron 244 system using Linux 2.4.7.  It
doesn't reliably boot in SMP, although I've never had a problem in UP. It's
possible that it's a hardware problem - the machine is new - but I don't
think so.

I get a lot of different results when I boot an SMP kernel: an NMI watchdog
reported lockup in smp_boot_cpus [first log below], a single processor boot
[second log below], an NMI watchdog lockup in ret_from_intr, also during
smp_boot_cpus [third log below], an OK boot (maybe 33% of the time, fourth
log below), or an error complaining that the IO-APIC and timer don't work
and I should go bug Ingo (couldn't reproduce this now but it's from
check_timer in io_apic.c).

If it does boot both processors, it seems to run OK.

I noticed that during the single processor boot it also has timer problems:
Booting processor 1/1 rip 6000 rsp 10001e69f58
Not responding.
Only one processor found.
ENABLING IO-APIC IRQs
Using IO-APIC 2
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.

Also the timer doesn't seem to work right before then; the BogoMIPS
calculation produces much lower numbers:
  Calibrating delay loop... 486.40 BogoMIPS
vs.
  Calibrating delay loop... 3538.94 BogoMIPS
normally.  The numbers seemn to fluctuate a lot; during another failed boot
it was about 2900, and I remember that when I saw the check_timer error
message it was about 45.

.config, or any other information, available on request; I haven't found
anything besides CONFIG_SMP that was necessary to produce this, and I tried
a half-dozen or so configurations.  The motherboard is an MSI K8T
Master2-FAR.

Any ideas?

Logs:

Bootdata ok (command line is root=/dev/hda5 ro console=ttyS0,115200)
Linux version 2.6.7 (drow@evandar) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #1 SMP Sat Jul 17 17:48:32 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 261856
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257760 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIAK8                                     ) @ 0x00000000000f6d50
ACPI: RSDT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3000
ACPI: FADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
ACPI: MADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee7b40
ACPI: DSDT (v001 VIAK8  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Checking aperture...
CPU 0: aperture @ e0000000 size 128 MB
CPU 1: aperture @ e0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1813.314 MHz processor.
Console: colour VGA+ 80x25
Memory: 1023272k/1047424k available (4647k kernel code, 23416k reserved, 3099k data, 596k init)
Calibrating delay loop... 3538.94 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 244 stepping 0a
per-CPU timeslice cutoff: 1023.70 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10001e69f58
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0 
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.7
RIP: 0010:[<ffffffff802abffc>] <ffffffff802abffc>{__delay+12}
RSP: 0000:0000010001e6ded0  EFLAGS: 00000212
RAX: 0000000000025f1c RBX: 000000000000894c RCX: 00000000aa415bfd
RDX: 0000000000000013 RSI: 0000000000006000 RDI: 000000000002af80
RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000000a
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808ec5c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo 0000010001e6c000, task 0000010001e6f050)
Stack: ffffffff808fbd49 0000000000000001 0000000000000001 0000000000000008 
       0000000000000000 0000000000000000 ffffffff808fc060 0000000800000001 
       0000000000001388 0000010001e0e480 
Call Trace:<ffffffff808fbd49>{do_boot_cpu+361} <ffffffff808fc060>{smp_boot_cpus+640} 
       <ffffffff8010b265>{init+69} <ffffffff801113b7>{child_rip+8} 
       <ffffffff8010b220>{init+0} <ffffffff801113af>{child_rip+0} 
       

Code: 48 39 f8 72 f4 90 c3 66 66 66 90 66 66 90 66 66 90 66 66 90 
console shuts up ...





  Bootdata ok (command line is root=/dev/hda5 ro console=ttyS0,115200)
Linux version 2.6.7 (drow@evandar) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #1 SMP Sat Jul 17 17:48:32 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 261856
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257760 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIAK8                                     ) @ 0x00000000000f6d50
ACPI: RSDT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3000
ACPI: FADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
ACPI: MADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee7b40
ACPI: DSDT (v001 VIAK8  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Checking aperture...
CPU 0: aperture @ e0000000 size 128 MB
CPU 1: aperture @ e0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1804.131 MHz processor.
Console: colour VGA+ 80x25
Memory: 1023272k/1047424k available (4647k kernel code, 23416k reserved, 3099k data, 596k init)
Calibrating delay loop... 486.40 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 244 stepping 0a
per-CPU timeslice cutoff: 1023.58 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10001e69f58
Not responding.
Only one processor found.
ENABLING IO-APIC IRQs
Using IO-APIC 2
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
time.c: Using PIT/TSC based timekeeping.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 19
PCI->APIC IRQ transform: (B0,I8,P1) -> 16
PCI->APIC IRQ transform: (B0,I11,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P1) -> 20
PCI->APIC IRQ transform: (B0,I15,P0) -> 20
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I17,P2) -> 22
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 940M
agpgart: AGP aperture is 128M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
udf: registering filesystem
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 5
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
Intel(R) PRO/10GbE Network Driver - version 1.0.66
Copyright (c) 2001-2004 Intel Corporation.
dgrs: SW=$Id: dgrs.c,v 1.13 2000/06/06 04:07:00 rick Exp $ FW=Build 550 11/16/96 03:45:15
FW Version=$Version$
pcnet32.c:v1.30c 05.25.2004 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.0.18
e100: Copyright(c) 1999-2004 Intel Corporation
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
tg3.c:v3.6 (June 12, 2004)
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:09:15:6c:b7
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
sk98lin: No adapter found.
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
winbond-840.c:v1.01-d (2.4 port) Nov-17-2001  Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/drivers.html
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800JB-00CRA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HITACHI GD-2000, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
hdc: ATAPI 20X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Red Hat/Adaptec aacraid driver (1.1.2-lk1 Jul 17 2004)
QLogic Fibre Channel HBA Driver (ffffffff8042a840)
DC390: 0 adapters found
GDT-HA: Storage RAID Controller Driver. Version: 3.04 
GDT-HA: Found 0 PCI Storage RAID Controllers
3ware Storage Controller device driver for Linux v1.26.00.039.
3w-xxxx: No cards found.
sata_via(0000:00:0f.0): routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 20
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 20
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
Databook TCIC-2 PCMCIA probe: not found.
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem ffffff00000d3000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 000000000000d400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 000000000000d800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 000000000000dc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
drivers/usb/serial/usb-serial.c: USB Serial support registered for PocketPC PDA
drivers/usb/serial/ipaq.c: USB PocketPC PDA driver v0.5
usbcore: registered new driver ipaq
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI SIO
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI 8U232AM Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI FT232BM Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for USB-UIRT Infrared Tranceiver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Home-Electronics TIRA-1 IR Transceiver
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.0:USB FTDI Serial Converters Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan PDA
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan PDA - (prerenumeration)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Xircom / Entregra PGS - (prerenumeration)
usbcore: registered new driver keyspan_pda
drivers/usb/serial/keyspan_pda.c: USB Keyspan PDA Converter driver v1.1
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan - (without firmware)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 4 port adapter
usbcore: registered new driver keyspan
drivers/usb/serial/keyspan.c: v1.1.4:Keyspan USB to Serial Converter Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for ZyXEL - omni.net lcd plus usb
usbcore: registered new driver omninet
drivers/usb/serial/omninet.c: v1.1:USB ZyXEL omni.net LCD PLUS Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi 2 port USB adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi 4 port USB adapter
usbcore: registered new driver digi_acceleport
drivers/usb/serial/digi_acceleport.c: v1.80.1.2:Digi AccelePort USB-2/USB-4 Serial Converter driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
usbcore: registered new driver belkin
drivers/usb/serial/belkin_sa.c: USB Belkin Serial converter driver v1.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for Empeg
usbcore: registered new driver empeg
drivers/usb/serial/empeg.c: v1.2:USB Empeg Mark I/II Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Magic Control Technology USB-RS232
usbcore: registered new driver mct_u232
drivers/usb/serial/mct_u232.c: Magic Control Technology USB-RS232 converter driver v1.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 4 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 8 port adapter
usbcore: registered new driver io_edgeport
drivers/usb/serial/io_edgeport.c: Edgeport USB Serial Driver v2.3
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport TI 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport TI 2 port adapter
usbcore: registered new driver io_ti
drivers/usb/serial/io_ti.c: Edgeport USB Serial Driver v0.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
drivers/usb/serial/usb-serial.c: USB Serial support registered for KOBIL USB smart card terminal
usbcore: registered new driver kobil
drivers/usb/serial/kobil_sct.c: 21/05/2004 KOBIL Systems GmbH - http://www.kobil.com
drivers/usb/serial/kobil_sct.c: KOBIL USB Smart Card Terminal Driver (experimental)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Reiner SCT Cyberjack USB card reader
usbcore: registered new driver cyberjack
drivers/usb/serial/cyberjack.c: v1.0 Matthias Bruestle
drivers/usb/serial/cyberjack.c: REINER SCT cyberJack pinpad/e-com USB Chipcard Reader Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for IR Dongle
usbcore: registered new driver ir-usb
drivers/usb/serial/ir-usb.c: USB IR Dongle driver v0.4
drivers/usb/serial/usb-serial.c: USB Serial support registered for KL5KUSB105D / PalmConnect
usbcore: registered new driver kl5kusb105d
drivers/usb/serial/kl5kusb105.c: KLSI KL5KUSB105 chipset USB->Serial Converter driver v0.3a
drivers/usb/serial/safe_serial.c: v0.0b sl@lineo.com, tbr@lineo.com
drivers/usb/serial/safe_serial.c: USB Safe Encapsulated Serial
drivers/usb/serial/safe_serial.c: vendor: 0 product: 0 safe: 1 padded: 0

drivers/usb/serial/usb-serial.c: USB Serial support registered for Safe
usbcore: registered new driver safe_serial
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   generic_sse:  5456.000 MB/sec
raid5: using function: generic_sse (5456.000 MB/sec)
raid6: int64x1   1144 MB/s
raid6: int64x2   1785 MB/s
raid6: int64x4   2132 MB/s
raid6: int64x8   1558 MB/s
raid6: sse2x1    1472 MB/s
raid6: sse2x2    1937 MB/s
raid6: sse2x4    2429 MB/s
raid6: using algorithm sse2x4 (2429 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 596k freed
INIT: version 2.85 booting

  Bootdata ok (command line is root=/dev/hda5 ro console=ttyS0,115200)
Linux version 2.6.7 (drow@evandar) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #1 SMP Sat Jul 17 17:48:32 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 261856
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257760 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIAK8                                     ) @ 0x00000000000f6d50
ACPI: RSDT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3000
ACPI: FADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
ACPI: MADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee7b40
ACPI: DSDT (v001 VIAK8  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Checking aperture...
CPU 0: aperture @ e0000000 size 128 MB
CPU 1: aperture @ e0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1834.856 MHz processor.
Console: colour VGA+ 80x25
spurious 8259A interrupt: IRQ7.
Memory: 1023272k/1047424k available (4647k kernel code, 23416k reserved, 3099k data, 596k init)
Calibrating delay loop... 2990.08 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 244 stepping 0a
per-CPU timeslice cutoff: 1023.99 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10001e69f58
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0 
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.7
RIP: 0010:[<ffffffff80115770>] <ffffffff80115770>{mask_and_ack_8259A+96}
RSP: 0000:ffffffff80894a68  EFLAGS: 00000046
RAX: 000000000000fffa RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000010001e0e060 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000000a
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000010001e6de28 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808ec5c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo 0000010001e6c000, task 0000010001e6f050)
Stack: 0000000000000092 ffffffff808e8600 0000000000000000 ffffffff80113774 
       000000000000a4a1 0000000000000001 0000000000000000 0000000000000001 
       0000000000000001 ffffffff80110e0d 
Call Trace:<IRQ> <ffffffff80113774>{do_IRQ+132} <ffffffff80110e0d>{ret_from_intr+0} 
        <EOI> <ffffffff802abffc>{__delay+12} <ffffffff808fbd49>{do_boot_cpu+361} 
       <ffffffff808fc060>{smp_boot_cpus+640} <ffffffff8010b265>{init+69} 
       <ffffffff801113b7>{child_rip+8} <ffffffff8010b220>{init+0} 
       <ffffffff801113af>{child_rip+0} 

Code: 0f b6 05 69 c7 57 00 e6 21 8d 43 60 e6 20 c6 05 fb c6 57 00 
console shuts up ...

  Bootdata ok (command line is root=/dev/hda5 ro console=ttyS0,115200)
Linux version 2.6.7 (drow@evandar) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #1 SMP Sat Jul 17 17:48:32 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 261856
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 257760 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 VIAK8                                     ) @ 0x00000000000f6d50
ACPI: RSDT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3000
ACPI: FADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
ACPI: MADT (v001 VIAK8  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee7b40
ACPI: DSDT (v001 VIAK8  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Checking aperture...
CPU 0: aperture @ e0000000 size 128 MB
CPU 1: aperture @ e0000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro console=ttyS0,115200
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1804.177 MHz processor.
Console: colour VGA+ 80x25
Memory: 1023272k/1047424k available (4647k kernel code, 23416k reserved, 3099k data, 596k init)
Calibrating delay loop... 3538.94 BogoMIPS
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 244 stepping 0a
per-CPU timeslice cutoff: 1023.58 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10001e69f58
Initializing CPU#1
Calibrating delay loop... 3604.48 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 244 stepping 0a
Total of 2 processors activated (7143.42 BogoMIPS).
ENABLING IO-APIC IRQs
Using IO-APIC 2
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
Detected 12.529 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 19
PCI->APIC IRQ transform: (B0,I8,P1) -> 16
PCI->APIC IRQ transform: (B0,I11,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P1) -> 20
PCI->APIC IRQ transform: (B0,I15,P0) -> 20
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I17,P2) -> 22
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 940M
agpgart: AGP aperture is 128M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
udf: registering filesystem
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 11 to 5
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
Intel(R) PRO/10GbE Network Driver - version 1.0.66
Copyright (c) 2001-2004 Intel Corporation.
dgrs: SW=$Id: dgrs.c,v 1.13 2000/06/06 04:07:00 rick Exp $ FW=Build 550 11/16/96 03:45:15
FW Version=$Version$
pcnet32.c:v1.30c 05.25.2004 tsbogend@alpha.franken.de
e100: Intel(R) PRO/100 Network Driver, 3.0.18
e100: Copyright(c) 1999-2004 Intel Corporation
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
tg3.c:v3.6 (June 12, 2004)
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:09:15:6c:b7
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
sk98lin: No adapter found.
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
winbond-840.c:v1.01-d (2.4 port) Nov-17-2001  Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/drivers.html
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800JB-00CRA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HITACHI GD-2000, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
hdc: ATAPI 20X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Red Hat/Adaptec aacraid driver (1.1.2-lk1 Jul 17 2004)
QLogic Fibre Channel HBA Driver (ffffffff8042a840)
DC390: 0 adapters found
GDT-HA: Storage RAID Controller Driver. Version: 3.04 
GDT-HA: Found 0 PCI Storage RAID Controllers
3ware Storage Controller device driver for Linux v1.26.00.039.
3w-xxxx: No cards found.
sata_via(0000:00:0f.0): routed to hard irq line 4
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 20
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 20
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
Databook TCIC-2 PCMCIA probe: not found.
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem ffffff00000d3000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 000000000000d400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 000000000000d800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 000000000000dc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
drivers/usb/serial/usb-serial.c: USB Serial support registered for PocketPC PDA
drivers/usb/serial/ipaq.c: USB PocketPC PDA driver v0.5
usbcore: registered new driver ipaq
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI SIO
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI 8U232AM Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI FT232BM Compatible
drivers/usb/serial/usb-serial.c: USB Serial support registered for USB-UIRT Infrared Tranceiver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Home-Electronics TIRA-1 IR Transceiver
usbcore: registered new driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.0:USB FTDI Serial Converters Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan PDA
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan PDA - (prerenumeration)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Xircom / Entregra PGS - (prerenumeration)
usbcore: registered new driver keyspan_pda
drivers/usb/serial/keyspan_pda.c: USB Keyspan PDA Converter driver v1.1
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan - (without firmware)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Keyspan 4 port adapter
usbcore: registered new driver keyspan
drivers/usb/serial/keyspan.c: v1.1.4:Keyspan USB to Serial Converter Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for ZyXEL - omni.net lcd plus usb
usbcore: registered new driver omninet
drivers/usb/serial/omninet.c: v1.1:USB ZyXEL omni.net LCD PLUS Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi 2 port USB adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Digi 4 port USB adapter
usbcore: registered new driver digi_acceleport
drivers/usb/serial/digi_acceleport.c: v1.80.1.2:Digi AccelePort USB-2/USB-4 Serial Converter driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Belkin / Peracom / GoHubs USB Serial Adapter
usbcore: registered new driver belkin
drivers/usb/serial/belkin_sa.c: USB Belkin Serial converter driver v1.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for Empeg
usbcore: registered new driver empeg
drivers/usb/serial/empeg.c: v1.2:USB Empeg Mark I/II Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Magic Control Technology USB-RS232
usbcore: registered new driver mct_u232
drivers/usb/serial/mct_u232.c: Magic Control Technology USB-RS232 converter driver v1.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 2 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 4 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport 8 port adapter
usbcore: registered new driver io_edgeport
drivers/usb/serial/io_edgeport.c: Edgeport USB Serial Driver v2.3
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport TI 1 port adapter
drivers/usb/serial/usb-serial.c: USB Serial support registered for Edgeport TI 2 port adapter
usbcore: registered new driver io_ti
drivers/usb/serial/io_ti.c: Edgeport USB Serial Driver v0.2
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
drivers/usb/serial/usb-serial.c: USB Serial support registered for KOBIL USB smart card terminal
usbcore: registered new driver kobil
drivers/usb/serial/kobil_sct.c: 21/05/2004 KOBIL Systems GmbH - http://www.kobil.com
drivers/usb/serial/kobil_sct.c: KOBIL USB Smart Card Terminal Driver (experimental)
drivers/usb/serial/usb-serial.c: USB Serial support registered for Reiner SCT Cyberjack USB card reader
usbcore: registered new driver cyberjack
drivers/usb/serial/cyberjack.c: v1.0 Matthias Bruestle
drivers/usb/serial/cyberjack.c: REINER SCT cyberJack pinpad/e-com USB Chipcard Reader Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for IR Dongle
usbcore: registered new driver ir-usb
drivers/usb/serial/ir-usb.c: USB IR Dongle driver v0.4
drivers/usb/serial/usb-serial.c: USB Serial support registered for KL5KUSB105D / PalmConnect
usbcore: registered new driver kl5kusb105d
drivers/usb/serial/kl5kusb105.c: KLSI KL5KUSB105 chipset USB->Serial Converter driver v0.3a
drivers/usb/serial/safe_serial.c: v0.0b sl@lineo.com, tbr@lineo.com
drivers/usb/serial/safe_serial.c: USB Safe Encapsulated Serial
drivers/usb/serial/safe_serial.c: vendor: 0 product: 0 safe: 1 padded: 0

drivers/usb/serial/usb-serial.c: USB Serial support registered for Safe
usbcore: registered new driver safe_serial
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   generic_sse:  5548.000 MB/sec
raid5: using function: generic_sse (5548.000 MB/sec)
raid6: int64x1    976 MB/s
raid6: int64x2   1910 MB/s
raid6: int64x4   2328 MB/s
raid6: int64x8   1574 MB/s
raid6: sse2x1     871 MB/s
raid6: sse2x2    1632 MB/s
raid6: sse2x4    2257 MB/s
raid6: using algorithm sse2x4 (2257 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
usb 4-1: new full speed USB device using address 2
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
hub 4-1:1.0: USB hub found
hub 4-1:1.0: 3 ports detected
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 596k freed
INIT: version 2.85 booting

-- 
Daniel Jacobowitz
