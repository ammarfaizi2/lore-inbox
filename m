Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265610AbSJSP2g>; Sat, 19 Oct 2002 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265611AbSJSP2g>; Sat, 19 Oct 2002 11:28:36 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:5385 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265610AbSJSP22>; Sat, 19 Oct 2002 11:28:28 -0400
Date: Sat, 19 Oct 2002 17:34:17 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44: problemn when shutting down, drivers/base/power.c and the global_device_list
Message-ID: <20021019153417.GA567@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I shut my system down, the last line I saw was

Shutting down devices.

I've hacked drivers/base/power.c:device_shutdown() like this:

void device_shutdown(void)
{
        struct list_head * entry;

        printk(KERN_EMERG "Shutting down devices\n");

        down(&device_sem);
        list_for_each(entry,&global_device_list) {
                struct device * dev = to_dev(entry);
                printk(KERN_EMERG "found device in global_device_list present %d ID '%s' name %s\n", device_present(dev),
                 dev->bus_id ? dev->bus_id : "<none>", dev->name ? dev->name : "<none>");
                if (device_present(dev) && dev->driver && dev->driver->shutdown) {
                        pr_debug("shutting down %s\n",dev->name);
                        dev->driver->shutdown(dev);
                }
        }
        up(&device_sem);
}

And I've enabled DEBUG in drivers/base/core.c. It seems the same 2
devices are being found in my global_device_list alternating, and the
list_for_each is in effect an endless loop.

dmesg | grep "^DEV:" gives:
DEV: registering device: ID = 'sys', name = System Bus
DEV: registering device: ID = 'legacy', name = legacy bus
DEV: registering device: ID = 'cpu0', name = 
DEV: registering device: ID = 'cpu1', name = 
DEV: registering device: ID = 'pci0', name = Host/PCI Bridge
DEV: registering device: ID = '00:00.0', name = VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
DEV: registering device: ID = '00:01.0', name = VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
DEV: registering device: ID = '00:07.0', name = VIA Technologies, Inc. VT82C686 [Apollo Super South]
DEV: registering device: ID = '00:07.1', name = VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
DEV: registering device: ID = '00:07.2', name = VIA Technologies, Inc. USB
DEV: registering device: ID = '00:07.3', name = VIA Technologies, Inc. USB (#2)
DEV: registering device: ID = '00:07.4', name = VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
DEV: registering device: ID = '00:09.0', name = Promise Technology, Inc. 20265
DEV: registering device: ID = '00:0a.0', name = LSI Logic / Symbios Logic (formerly NCR) 53c860
DEV: registering device: ID = '00:0b.0', name = Creative Labs SB Live! EMU10k1
DEV: registering device: ID = '00:0b.1', name = Creative Labs SB Live! MIDI/Game Port
DEV: registering device: ID = '00:0c.0', name = Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
DEV: registering device: ID = '00:0e.0', name = Triones Technologies, Inc. HPT366/368/370/370A/372
DEV: registering device: ID = '01:00.0', name = Matrox Graphics, Inc. MGA G400 AGP
DEV: registering device: ID = 'pic0', name = i8259A PIC
DEV: registering device: ID = 'rtc0', name = i8253 Real Time Clock
DEV: registering device: ID = 'fd0', name = 
DEV: registering device: ID = 'fd1', name = 
DEV: registering device: ID = 'floppy0', name = Floppy Drive
DEV: registering device: ID = 'ide0', name = IDE Controller
DEV: registering device: ID = '0.0', name = IDE Drive
DEV: registering device: ID = 'ide1', name = IDE Controller
DEV: registering device: ID = '1.0', name = IDE Drive
DEV: registering device: ID = 'ide2', name = IDE Controller
DEV: registering device: ID = '2.0', name = IDE Drive
DEV: registering device: ID = 'ide4', name = IDE Controller
DEV: registering device: ID = '4.0', name = IDE Drive
DEV: registering device: ID = 'ide5', name = IDE Controller
DEV: registering device: ID = '5.0', name = IDE Drive
DEV: registering device: ID = 'hda', name = 
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
DEV: registering device: ID = 'p5', name = 
DEV: registering device: ID = 'p6', name = 
DEV: registering device: ID = 'p7', name = 
DEV: registering device: ID = 'p8', name = 
DEV: registering device: ID = 'p9', name = 
DEV: registering device: ID = 'p10', name = 
DEV: registering device: ID = 'p11', name = 
DEV: registering device: ID = 'p12', name = 
DEV: registering device: ID = 'hde', name = 
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
DEV: registering device: ID = 'hdi', name = 
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
DEV: registering device: ID = 'hdk', name = 
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
DEV: registering device: ID = 'scsi0', name = sym53c8xx
DEV: registering device: ID = 'scsi0', name = sym53c8xx
DEV: registering device: ID = '0:0:1:0', name = 
DEV: registering device: ID = '0:0:2:0', name = 
DEV: registering device: ID = '0:0:5:0', name = ZYAMAHA  CRW2100S        1.0N
DEV: registering device: ID = 'scsi1', name = ide-scsi
DEV: registering device: ID = '1:0:0:0', name = 
DEV: registering device: ID = 'sr0', name = 
DEV: registering device: ID = 'sr1', name = 
DEV: registering device: ID = 'sr2', name = 
DEV: registering device: ID = 'sr3', name = 
DEV: registering device: ID = '0:0:1:0:gen', name = generic
DEV: registering device: ID = '0:0:2:0:gen', name = generic
DEV: registering device: ID = '0:0:5:0:gen', name = ZYAMAHA  CRW2100S        1.0Ngeneric
DEV: registering device: ID = '1:0:0:0:gen', name = generic
DEV: registering device: ID = 'usb1', name = USB device 0000:0000
DEV: registering device: ID = '1-0:0', name = usb-00:07.2-0 interface 0
DEV: registering device: ID = 'usb2', name = USB device 0000:0000
DEV: registering device: ID = '2-0:0', name = usb-00:07.3-0 interface 0
DEV: registering device: ID = 'loop0', name = 
DEV: registering device: ID = 'loop1', name = 
DEV: registering device: ID = 'loop2', name = 
DEV: registering device: ID = 'loop3', name = 
DEV: registering device: ID = 'loop4', name = 
DEV: registering device: ID = 'loop5', name = 
DEV: registering device: ID = 'loop6', name = 
DEV: registering device: ID = 'loop7', name = 

On shutdown, I see these lines alternating:

found device in global_device_list present 1 ID '0:0:5:0:gen' name ZYAMAHA  CRW2100S        1.0Ngeneric
found device in global_device_list present 1 ID '0:0:2:0:gen' name = generic

I can't imagine the global_device_list is corrupt in some way.

Any hints? Full dmesg below.
I think I'm going to dump the full global_device_list() any time before
and after something is added during boot...

Thanks,
Jurriaan

Linux version 2.5.44 (root@middle) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 SMP Sat Oct 19 17:08:45 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000003fff0000 (usable)
 user: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 user: 000000003fff3000 - 0000000040000000 (ACPI data)
 user: 00000000fec00000 - 00000000fec01000 (reserved)
 user: 00000000fee00000 - 00000000fee01000 (reserved)
 user: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 32752 pages
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=power-off mem=1048512K
ide_setup: hdc=scsi
Initializing CPU#0
Detected 703.169 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1380.35 BogoMIPS
Memory: 1033396k/1048512k available (1900k kernel code, 14728k reserved, 1569k data, 332k init, 131008k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 730.87 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1404.92 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2785.28 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 703.0098 MHz.
..... host bus clock speed is 100.0442 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
DEV: registering device: ID = 'sys', name = System Bus
DEV: registering device: ID = 'legacy', name = legacy bus
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
Registering system device cpu0
DEV: registering device: ID = 'cpu0', name = 
adding '' to cpu class interfaces
Registering system device cpu1
DEV: registering device: ID = 'cpu1', name = 
adding '' to cpu class interfaces
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
DEV: registering device: ID = 'pci0', name = Host/PCI Bridge
DEV: registering device: ID = '00:00.0', name = VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
DEV: registering device: ID = '00:01.0', name = VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
DEV: registering device: ID = '00:07.0', name = VIA Technologies, Inc. VT82C686 [Apollo Super South]
DEV: registering device: ID = '00:07.1', name = VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
DEV: registering device: ID = '00:07.2', name = VIA Technologies, Inc. USB
DEV: registering device: ID = '00:07.3', name = VIA Technologies, Inc. USB (#2)
DEV: registering device: ID = '00:07.4', name = VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
DEV: registering device: ID = '00:09.0', name = Promise Technology, Inc. 20265
DEV: registering device: ID = '00:0a.0', name = LSI Logic / Symbios Logic (formerly NCR) 53c860
DEV: registering device: ID = '00:0b.0', name = Creative Labs SB Live! EMU10k1
DEV: registering device: ID = '00:0b.1', name = Creative Labs SB Live! MIDI/Game Port
DEV: registering device: ID = '00:0c.0', name = Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
DEV: registering device: ID = '00:0e.0', name = Triones Technologies, Inc. HPT366/368/370/370A/372
DEV: registering device: ID = '01:00.0', name = Matrox Graphics, Inc. MGA G400 AGP
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Registering system device pic0
DEV: registering device: ID = 'pic0', name = i8259A PIC
Registering system device rtc0
DEV: registering device: ID = 'rtc0', name = i8253 Real Time Clock
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: disabled - APM is not SMP safe (power off active).
apm: WARNING: not running on first cpu!
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Capability LSM initialized
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 9 to 3
PCI: Via IRQ fixup for 00:07.3, from 9 to 3
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
matroxfb: Matrox G400 (AGP) detected
MTRR: setting reg 2
MTRR: setting reg 2
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD0000000, mapped to 0xf8805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
DEV: registering device: ID = 'fd0', name = 
DEV: registering device: ID = 'fd1', name = 
DEV: registering device: ID = 'floppy0', name = Floppy Drive
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 33073H3, ATA DISK drive
DEV: registering device: ID = 'ide0', name = IDE Controller
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
DEV: registering device: ID = '0.0', name = IDE Drive
hdc: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
DEV: registering device: ID = 'ide1', name = IDE Controller
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
DEV: registering device: ID = '1.0', name = IDE Drive
PDC20265: IDE controller at PCI slot 00:09.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: IBM-DTLA-307045, ATA DISK drive
DEV: registering device: ID = 'ide2', name = IDE Controller
ide2 at 0xac00-0xac07,0xb002 on irq 16
DEV: registering device: ID = '2.0', name = IDE Drive
HPT370: IDE controller at PCI slot 00:0e.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xe000-0xe007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xe008-0xe00f, BIOS settings: hdk:DMA, hdl:pio
hdi: Maxtor 4G120J6, ATA DISK drive
DEV: registering device: ID = 'ide4', name = IDE Controller
ide4 at 0xd000-0xd007,0xd402 on irq 18
DEV: registering device: ID = '4.0', name = IDE Drive
hdk: Maxtor 4G120J6, ATA DISK drive
DEV: registering device: ID = 'ide5', name = IDE Controller
ide5 at 0xd800-0xd807,0xdc02 on irq 18
DEV: registering device: ID = '5.0', name = IDE Drive
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
DEV: registering device: ID = 'hda', name = 
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
DEV: registering device: ID = 'p5', name = 
DEV: registering device: ID = 'p6', name = 
DEV: registering device: ID = 'p7', name = 
DEV: registering device: ID = 'p8', name = 
DEV: registering device: ID = 'p9', name = 
DEV: registering device: ID = 'p10', name = 
DEV: registering device: ID = 'p11', name = 
DEV: registering device: ID = 'p12', name = 
hde: host protected area => 1
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
DEV: registering device: ID = 'hde', name = 
 hde: hde1 hde2
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
hdi: host protected area => 1
hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
DEV: registering device: ID = 'hdi', name = 
 hdi: hdi1 hdi2
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
hdk: host protected area => 1
hdk: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
DEV: registering device: ID = 'hdk', name = 
 hdk: hdk1 hdk2
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
ide-cd: passing drive hdc to ide-scsi emulation.
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected 
sym53c860-0: rev 0x13 on pci bus 0 device 10 function 0 irq 17
sym53c860-0: ID 7, Fast-20, Parity Checking
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0118cf4>] __might_sleep+0x54/0x58
 [<c01c2297>] get_device+0x17/0x70
 [<c01c2209>] device_initialize+0x61/0x6c
 [<c01c2246>] device_register+0x32/0x6c
 [<c02235f0>] cursor_timer_handler+0x0/0x28
 [<c0120d35>] tasklet_hi_action+0x85/0xe0
 [<c0120a3a>] do_softirq+0x5a/0xac
 [<c011389f>] smp_apic_timer_interrupt+0x113/0x124
 [<c0107be2>] apic_timer_interrupt+0x1a/0x20
 [<c0120d35>] tasklet_hi_action+0x85/0xe0
 [<c0120a3a>] do_softirq+0x5a/0xac
 [<c011389f>] smp_apic_timer_interrupt+0x113/0x124
 [<c0107be2>] apic_timer_interrupt+0x1a/0x20
 [<c022adcd>] matrox_cfbX_putcs+0x1f9/0x260
 [<c0138ea0>] __alloc_pages+0x90/0x25c
 [<c01390a6>] __get_free_pages+0x3a/0x40
 [<c0135038>] do_ccupdate_local+0x0/0x34
 [<c0135038>] do_ccupdate_local+0x0/0x34
 [<c0135026>] smp_call_function_all_cpus+0x1a/0x2c
 [<c01357fe>] kmem_cache_alloc+0x22/0x16c
 [<c015a720>] alloc_inode+0x30/0x180
 [<c015a7e3>] alloc_inode+0xf3/0x180
 [<c015aec7>] new_inode+0xb/0x88
 [<c016e9f4>] driverfs_get_inode+0x10/0xdc
 [<c016eafd>] driverfs_mknod+0x3d/0x48
 [<c016eb27>] driverfs_mkdir+0x1f/0x2c
 [<c016f292>] driverfs_create_dir+0x9e/0xd0
 [<c01c4085>] device_create_dir+0x15/0x1c
 [<c01c426c>] bus_make_dir+0x4c/0x58
 [<c01c310f>] put_bus+0x13/0x80
 [<c01c320f>] bus_register+0x93/0x9c
 [<c01ffec9>] scsi_register_host+0x39/0x1e4
 [<c01050ab>] init+0x47/0x1ac
 [<c0105064>] init+0x0/0x1ac
 [<c01054f1>] kernel_thread_helper+0x5/0xc

DEV: registering device: ID = 'scsi0', name = sym53c8xx
scsi0 : sym53c8xx-1.7.3c-20010512
DEV: registering device: ID = 'scsi0', name = sym53c8xx
sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '0:0:1:0', name = 
sym53c860-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '0:0:2:0', name = 
sym53c860-0-<5,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 7)
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '0:0:5:0', name = ZYAMAHA  CRW2100S        1.0N
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
DEV: registering device: ID = 'scsi1', name = ide-scsi
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '1:0:0:0', name = 
st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
DEV: registering device: ID = 'sr0', name = 
sr1: scsi-1 drive
DEV: registering device: ID = 'sr1', name = 
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
DEV: registering device: ID = 'sr2', name = 
sr3: scsi3-mmc drive: 12x/12x writer cd/rw xa/form2 cdda tray
DEV: registering device: ID = 'sr3', name = 
DEV: registering device: ID = '0:0:1:0:gen', name = generic
DEV: registering device: ID = '0:0:2:0:gen', name = generic
DEV: registering device: ID = '0:0:5:0:gen', name = ZYAMAHA  CRW2100S        1.0Ngeneric
DEV: registering device: ID = '1:0:0:0:gen', name = generic
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, VIA Technologies, Inc. USB
drivers/usb/core/hcd-pci.c: irq 19, io base 0000a400
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
DEV: registering device: ID = 'usb1', name = USB device 0000:0000
DEV: registering device: ID = '1-0:0', name = usb-00:07.2-0 interface 0
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.3, VIA Technologies, Inc. USB (#2)
drivers/usb/core/hcd-pci.c: irq 19, io base 0000a800
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 2
DEV: registering device: ID = 'usb2', name = USB device 0000:0000
DEV: registering device: ID = '2-0:0', name = usb-00:07.3-0 interface 0
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.12: USB Printer Device Class driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.6:USB Scanner Driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1152.000 MB/sec
   32regs    :   896.000 MB/sec
   pIII_sse  :  1408.000 MB/sec
   pII_mmx   :  1568.000 MB/sec
   p5_mmx    :  1652.000 MB/sec
raid5: using function: pIII_sse (1408.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Advanced Linux Sound Architecture Driver Version 0.9.0rc3 (Mon Oct 14 16:41:26 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
ALSA device list:
  #0: Sound Blaster Live! at 0xc400, irq 17
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 332k freed
Adding 1574328k swap on /dev/hda9.  Priority:-1 extents:1
Real Time Clock Driver v1.11
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xfa924000, 00:10:a7:0b:35:1c, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
DEV: registering device: ID = 'loop0', name = 
DEV: registering device: ID = 'loop1', name = 
DEV: registering device: ID = 'loop2', name = 
DEV: registering device: ID = 'loop3', name = 
DEV: registering device: ID = 'loop4', name = 
DEV: registering device: ID = 'loop5', name = 
DEV: registering device: ID = 'loop6', name = 
DEV: registering device: ID = 'loop7', name = 
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xc0000000 256MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
NTFS driver 2.1.0 [Flags: R/O MODULE].
udf: registering filesystem
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,1)) for (ide2(33,1))
Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,11), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,11)) for (ide0(3,11))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,12), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,12)) for (ide0(3,12))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide2(33,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide2(33,2)) for (ide2(33,2))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide4(56,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide4(56,1)) for (ide4(56,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide4(56,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide4(56,2)) for (ide4(56,2))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide5(57,1), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide5(57,1)) for (ide5(57,1))
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide5(57,2), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide5(57,2)) for (ide5(57,2))
Using r5 hash to sort names
NTFS volume version 3.0.
FAT: Unrecognized mount option mode
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
-- 
Tell a man there are 300 billion stars in the universe and he'll believe you.
Tell him a seat has wet paint on it and he'll have to touch it to be sure.
	Anonymous
GNU/Linux 2.5.44 SMP/ReiserFS 2x1380 bogomips load av: 0.15 0.14 0.06
