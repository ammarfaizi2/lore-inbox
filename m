Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSJTJYa>; Sun, 20 Oct 2002 05:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbSJTJYa>; Sun, 20 Oct 2002 05:24:30 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47876 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263207AbSJTJYS>; Sun, 20 Oct 2002 05:24:18 -0400
Date: Sun, 20 Oct 2002 11:29:50 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: problems with shutting down 2.5.44
Message-ID: <20021020092950.GA830@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run linux-2.5.44 on a SMP x86 system. (see full dmesg and .config
below).

When I try to get it to shut down, there seems to be an endless loop
while scanning the global_device_list().

I've hacked device_shutdown like this:

void device_shutdown(void)
{
	struct list_head * entry;
	int i = 0;
	
	printk(KERN_EMERG "Shutting down devices\n");

	down(&device_sem);
	list_for_each(entry,&global_device_list) {
		struct device * dev = to_dev(entry);
	        printk(KERN_EMERG "found device in global_device_list present %d ID '%s' name %s head %08lx entry %08lx next %08lx prev %08lx\n", 
				device_present(dev), 
		 		dev->bus_id ? dev->bus_id : "<none>",
				dev->name ? dev->name : "<none>",
				&global_device_list, entry, entry->next, entry->prev);
		if (device_present(dev) && dev->driver && dev->driver->shutdown) {
			pr_debug("shutting down %s\n",dev->name);
			dev->driver->shutdown(dev);
		}
		if (i++ == 128) goto out;
	}
out:
	up(&device_sem);
}

Which means it dumps useful information, and doesn't try forever.

The following loop is present at the end of the output:

scsi0
0:0:1:0:gen
0:0:1:0
0:0:2:0:gen
0:0:5:0:gen
0:0:5:0
scsi0

and then it repeats itself.

I hope you can do something with this bug-report.

Kind regards,
Jurriaan

Below, find my dmesg and my .config:

full dmesg, with all DEBUG options on in drivers/base/*.c:

Linux version 2.5.44 (root@middle) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 SMP Sun Oct 20 11:14:03 CEST 2002
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
Detected 703.163 MHz processor.
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
..... CPU clock speed is 703.0064 MHz.
..... host bus clock speed is 100.0437 MHz.
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
bus type 'pci' registered
bus type 'system' registered
DEV: registering device: ID = 'sys', name = System Bus
DEV: registering device: ID = 'legacy', name = legacy bus
bus type 'platform' registered
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
driver system:cpu: registering
bus system: add driver cpu
Registering system device cpu0
DEV: registering device: ID = 'cpu0', name = 
bus system: add device cpu0
bound device 'cpu0' to driver 'cpu'
adding '' to cpu class interfaces
Registering system device cpu1
DEV: registering device: ID = 'cpu1', name = 
bus system: add device cpu1
bound device 'cpu1' to driver 'cpu'
adding '' to cpu class interfaces
bus type 'usb' registered
driver usb:usbfs: registering
bus usb: add driver usbfs
drivers/usb/core/usb.c: registered new driver usbfs
driver usb:hub: registering
bus usb: add driver hub
drivers/usb/core/usb.c: registered new driver hub
driver usb:generic: registering
bus usb: add driver generic
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
DEV: registering device: ID = 'pci0', name = Host/PCI Bridge
DEV: registering device: ID = '00:00.0', name = VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
bus pci: add device 00:00.0
DEV: registering device: ID = '00:01.0', name = VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
bus pci: add device 00:01.0
DEV: registering device: ID = '00:07.0', name = VIA Technologies, Inc. VT82C686 [Apollo Super South]
bus pci: add device 00:07.0
DEV: registering device: ID = '00:07.1', name = VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
bus pci: add device 00:07.1
DEV: registering device: ID = '00:07.2', name = VIA Technologies, Inc. USB
bus pci: add device 00:07.2
DEV: registering device: ID = '00:07.3', name = VIA Technologies, Inc. USB (#2)
bus pci: add device 00:07.3
DEV: registering device: ID = '00:07.4', name = VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
bus pci: add device 00:07.4
DEV: registering device: ID = '00:09.0', name = Promise Technology, Inc. 20265
bus pci: add device 00:09.0
DEV: registering device: ID = '00:0a.0', name = LSI Logic / Symbios Logic (formerly NCR) 53c860
bus pci: add device 00:0a.0
DEV: registering device: ID = '00:0b.0', name = Creative Labs SB Live! EMU10k1
bus pci: add device 00:0b.0
DEV: registering device: ID = '00:0b.1', name = Creative Labs SB Live! MIDI/Game Port
bus pci: add device 00:0b.1
DEV: registering device: ID = '00:0c.0', name = Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
bus pci: add device 00:0c.0
DEV: registering device: ID = '00:0e.0', name = Triones Technologies, Inc. HPT366/368/370/370A/372
bus pci: add device 00:0e.0
DEV: registering device: ID = '01:00.0', name = Matrox Graphics, Inc. MGA G400 AGP
bus pci: add device 01:00.0
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
driver system:pic: registering
bus system: add driver pic
Registering system device pic0
DEV: registering device: ID = 'pic0', name = i8259A PIC
bus system: add device pic0
bound device 'pic0' to driver 'pic'
Registering system device rtc0
DEV: registering device: ID = 'rtc0', name = i8253 Real Time Clock
bus system: add device rtc0
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
driver pci:serial: registering
bus pci: add driver serial
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
driver pci:parport_pc: registering
bus pci: add driver parport_pc
bound device '00:07.0' to driver 'parport_pc'
driver pci:matroxfb: registering
bus pci: add driver matroxfb
matroxfb: Matrox G400 (AGP) detected
MTRR: setting reg 2
MTRR: setting reg 2
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD0000000, mapped to 0xf8805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
bound device '01:00.0' to driver 'matroxfb'
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
bus type 'block' registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
DEV: registering device: ID = 'fd0', name = 
bus block: add device fd0
DEV: registering device: ID = 'fd1', name = 
bus block: add device fd1
DEV: registering device: ID = 'floppy0', name = Floppy Drive
bus platform: add device floppy0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
bus type 'ide' registered
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
bus ide: add device 0.0
hdc: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
DEV: registering device: ID = 'ide1', name = IDE Controller
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
DEV: registering device: ID = '1.0', name = IDE Drive
bus ide: add device 1.0
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
bus ide: add device 2.0
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
bus ide: add device 4.0
hdk: Maxtor 4G120J6, ATA DISK drive
DEV: registering device: ID = 'ide5', name = IDE Controller
ide5 at 0xd800-0xd807,0xdc02 on irq 18
DEV: registering device: ID = '5.0', name = IDE Drive
bus ide: add device 5.0
driver pci:HPT366 IDE: registering
bus pci: add driver HPT366 IDE
bound device '00:0e.0' to driver 'HPT366 IDE'
driver pci:Promise Old IDE: registering
bus pci: add driver Promise Old IDE
bound device '00:09.0' to driver 'Promise Old IDE'
driver pci:VIA IDE: registering
bus pci: add driver VIA IDE
bound device '00:07.1' to driver 'VIA IDE'
hda: host protected area => 1
hda: 60032448 sectors (30737 MB) w/2048KiB Cache, CHS=3736/255/63, UDMA(100)
DEV: registering device: ID = 'hda', name = 
bus block: add device hda
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
bus block: add device hde
 hde: hde1 hde2
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
hdi: host protected area => 1
hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
DEV: registering device: ID = 'hdi', name = 
bus block: add device hdi
 hdi: hdi1 hdi2
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
hdk: host protected area => 1
hdk: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
DEV: registering device: ID = 'hdk', name = 
bus block: add device hdk
 hdk: hdk1 hdk2
DEV: registering device: ID = 'p1', name = 
DEV: registering device: ID = 'p2', name = 
driver ide:ide-disk: registering
bus ide: add driver ide-disk
ide-cd: passing drive hdc to ide-scsi emulation.
driver ide:ide-cdrom: registering
bus ide: add driver ide-cdrom
SCSI subsystem driver Revision: 1.00
bus type 'scsi' registered
sym53c8xx: at PCI bus 0, device 10, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected 
sym53c860-0: rev 0x13 on pci bus 0 device 10 function 0 irq 17
sym53c860-0: ID 7, Fast-20, Parity Checking
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0118d04>] __might_sleep+0x54/0x58
 [<c01c22b7>] get_device+0x17/0x70
 [<c01c2231>] device_initialize+0x61/0x68
 [<c01c2266>] device_register+0x2e/0x68
 [<c0120d45>] tasklet_hi_action+0x85/0xe0
 [<c0120a4a>] do_softirq+0x5a/0xac
 [<c01138af>] smp_apic_timer_interrupt+0x113/0x124
 [<c0107be2>] apic_timer_interrupt+0x1a/0x20
 [<c0120068>] sys_setitimer+0xa8/0x120
 [<c0120d45>] tasklet_hi_action+0x85/0xe0
 [<c0120a4a>] do_softirq+0x5a/0xac
 [<c01138af>] smp_apic_timer_interrupt+0x113/0x124
 [<c0107be2>] apic_timer_interrupt+0x1a/0x20
 [<c022aedd>] matrox_cfbX_putcs+0x1f9/0x260
 [<c0138eb0>] __alloc_pages+0x90/0x25c
 [<c01390b6>] __get_free_pages+0x3a/0x40
 [<c0135048>] do_ccupdate_local+0x0/0x34
 [<c0135048>] do_ccupdate_local+0x0/0x34
 [<c0135036>] smp_call_function_all_cpus+0x1a/0x2c
 [<c013580e>] kmem_cache_alloc+0x22/0x16c
 [<c015a730>] alloc_inode+0x30/0x180
 [<c015a7f3>] alloc_inode+0xf3/0x180
 [<c015aed7>] new_inode+0xb/0x88
 [<c016ea04>] driverfs_get_inode+0x10/0xdc
 [<c016eb0d>] driverfs_mknod+0x3d/0x48
 [<c016eb37>] driverfs_mkdir+0x1f/0x2c
 [<c016f2a2>] driverfs_create_dir+0x9e/0xd0
 [<c01c4195>] device_create_dir+0x15/0x1c
 [<c01c437c>] bus_make_dir+0x4c/0x58
 [<c01c31df>] put_bus+0x13/0x80
 [<c01c32ec>] bus_register+0xa0/0xa8
 [<c01fffd9>] scsi_register_host+0x39/0x1e4
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
bus scsi: add device 0:0:1:0
sym53c860-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '0:0:2:0', name = 
bus scsi: add device 0:0:2:0
sym53c860-0-<5,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 7)
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '0:0:5:0', name = ZYAMAHA  CRW2100S        1.0N
bus scsi: add device 0:0:5:0
driver ide:ide-scsi: registering
bus ide: add driver ide-scsi
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
DEV: registering device: ID = 'scsi1', name = ide-scsi
  Vendor: LITE-ON   Model: LTR-40125W        Rev: WS05
  Type:   CD-ROM                             ANSI SCSI revision: 02
DEV: registering device: ID = '1:0:0:0', name = 
bus scsi: add device 1:0:0:0
st: Version 20021015, fixed bufsize 32768, wrt 30720, s/g segs 256
driver scsi:st: registering
bus scsi: add driver st
driver scsi:sd: registering
bus scsi: add driver sd
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr3 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
DEV: registering device: ID = 'sr0', name = 
bus block: add device sr0
sr1: scsi-1 drive
DEV: registering device: ID = 'sr1', name = 
bus block: add device sr1
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
DEV: registering device: ID = 'sr2', name = 
bus block: add device sr2
sr3: scsi3-mmc drive: 12x/12x writer cd/rw xa/form2 cdda tray
DEV: registering device: ID = 'sr3', name = 
bus block: add device sr3
driver scsi:sr: registering
bus scsi: add driver sr
DEV: registering device: ID = '0:0:1:0:gen', name = generic
bus scsi: add device 0:0:1:0:gen
DEV: registering device: ID = '0:0:2:0:gen', name = generic
bus scsi: add device 0:0:2:0:gen
DEV: registering device: ID = '0:0:5:0:gen', name = ZYAMAHA  CRW2100S        1.0Ngeneric
bus scsi: add device 0:0:5:0:gen
DEV: registering device: ID = '1:0:0:0:gen', name = generic
bus scsi: add device 1:0:0:0:gen
driver scsi:sg: registering
bus scsi: add driver sg
bound device '0:0:1:0:gen' to driver 'sg'
bound device '0:0:2:0:gen' to driver 'sg'
bound device '0:0:5:0:gen' to driver 'sg'
bound device '1:0:0:0:gen' to driver 'sg'
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
driver pci:uhci-hcd: registering
bus pci: add driver uhci-hcd
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, VIA Technologies, Inc. USB
drivers/usb/core/hcd-pci.c: irq 19, io base 0000a400
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
DEV: registering device: ID = 'usb1', name = USB device 0000:0000
bus usb: add device usb1
bound device 'usb1' to driver 'generic'
DEV: registering device: ID = '1-0:0', name = usb-00:07.2-0 interface 0
bus usb: add device 1-0:0
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
bound device '1-0:0' to driver 'hub'
bound device '00:07.2' to driver 'uhci-hcd'
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.3, VIA Technologies, Inc. USB (#2)
drivers/usb/core/hcd-pci.c: irq 19, io base 0000a800
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 2
DEV: registering device: ID = 'usb2', name = USB device 0000:0000
bus usb: add device usb2
bound device 'usb2' to driver 'generic'
DEV: registering device: ID = '2-0:0', name = usb-00:07.3-0 interface 0
bus usb: add device 2-0:0
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
bound device '2-0:0' to driver 'hub'
bound device '00:07.3' to driver 'uhci-hcd'
driver usb:usblp: registering
bus usb: add driver usblp
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.12: USB Printer Device Class driver
driver usb:usbscanner: registering
bus usb: add driver usbscanner
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
   8regs     :  1164.000 MB/sec
   32regs    :   896.000 MB/sec
   pIII_sse  :  1380.000 MB/sec
   pII_mmx   :  1584.000 MB/sec
   p5_mmx    :  1652.000 MB/sec
raid5: using function: pIII_sse (1380.000 MB/sec)
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
driver pci:EMU10K1/Audigy: registering
bus pci: add driver EMU10K1/Audigy
bound device '00:0b.0' to driver 'EMU10K1/Audigy'
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
driver pci:8139too: registering
bus pci: add driver 8139too
eth0: RealTek RTL8139 Fast Ethernet at 0xfa924000, 00:10:a7:0b:35:1c, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
bound device '00:0c.0' to driver '8139too'
DEV: registering device: ID = 'loop0', name = 
bus block: add device loop0
DEV: registering device: ID = 'loop1', name = 
bus block: add device loop1
DEV: registering device: ID = 'loop2', name = 
bus block: add device loop2
DEV: registering device: ID = 'loop3', name = 
bus block: add device loop3
DEV: registering device: ID = 'loop4', name = 
bus block: add device loop4
DEV: registering device: ID = 'loop5', name = 
bus block: add device loop5
DEV: registering device: ID = 'loop6', name = 
bus block: add device loop6
DEV: registering device: ID = 'loop7', name = 
bus block: add device loop7
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
driver pci:agpgart: registering
bus pci: add driver agpgart
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 256M @ 0xc0000000
bound device '00:00.0' to driver 'agpgart'
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


CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=m
CONFIG_RAW_DRIVER=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_EMU10K1=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD_ALT=y
CONFIG_USB_PRINTER=y
CONFIG_USB_SCANNER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
-- 
Morwatz said fretfully, "Why are you so interested in the mannerisms of
the race? Tonight, they intend to eat us . . ."
        Jack Vance - Big Planet
GNU/Linux 2.5.41 SMP/ReiserFS 2x1380 bogomips load av: 1.09 1.61 1.77
