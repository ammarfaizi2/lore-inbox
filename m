Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbUDGPBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUDGPBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:01:22 -0400
Received: from nevyn.them.org ([66.93.172.17]:38272 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263707AbUDGO7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:59:31 -0400
Date: Wed, 7 Apr 2004 10:59:29 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Message-ID: <20040407145929.GA1247@nevyn.them.org>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE002F7B775@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE002F7B775@hdsmsx402.hd.intel.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 07, 2004 at 12:08:59AM -0400, Brown, Len wrote:
> >I'm assuming that it is not the fault of either of these drivers, since
> >both of those are quite straightforward; they appear to be actually
> >being triggered when nothing is going on.
> 
> If IRQ initialization is done incorrectly, it is possible
> For a driver to request_irq(X), while the hardware is actually
> on IRQ Y.
> 
> Then when that device becomes active, it would kill the other
> devices on Y because its handler is looking for interrupts on X.
> 
> If this happens with acpi enabled, but doesn't happen with acpi=off
> or pci=noacpi, then we need to compare the /proc/interrupts between
> the working and failintg configs to see if the IRQs have moved around
> when perhaps they should not have.  Dmesg from the ACPI case would
> also be needed.

Thanks for your continued help... this gave me some extremely
interesting data.  Here's some data from /proc/interrupts on
2.6.0-test9, which was quite stable for me:
 19:          0          0   IO-APIC-level  au88xx
 21:         52          0   IO-APIC-level  uhci_hcd, uhci_hcd

2.6.5 with ACPI:
 11:     300000          0   IO-APIC-level  uhci_hcd, uhci_hcd
 19:     299999          1   IO-APIC-level  au8830

2.6.5 with pci=noacpi:
  5:         54          1   IO-APIC-level  uhci_hcd, uhci_hcd, au8830

I haven't run that third setup for a lot of time yet, so I don't know
for sure that it's stable.  Sound seems much more crackly than it was
with ACPI enabled, but that could be any problem with the vortex2
driver - or it could be missing interrupts.

Here's one interesting bit that only appears in dmesg with ACPI
enabled, and only in 2.6.5:

PCI: Via IRQ fixup for 0000:00:07.2, from 5 to 11
PCI: Via IRQ fixup for 0000:00:07.3, from 5 to 11

That's the two UHCI devices.  So they get quirked off to a different
IRQ, and au88x0 somehow ends up routed to yet a third IRQ, but from the
symptoms I am guessing that the USB and au8830 are actually connected
to the same pin.  That would explain both of them getting interrupts
with no obvious source, even though they do each get their own
interrupts also.

The quirk isn't new; it's from 2002.  So presumably ACPI is now putting
them somewhere different than it used to.  Here's a some bits of the dmesg:

2.6.0-test9

ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
IOAPIC[0]: Set PCI routing entry (2-11 -> 0xc9 -> IRQ 27 Mode:1 Active:1)
00:00:07[A] -> 2-11 -> IRQ 27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
IOAPIC[0]: Set PCI routing entry (2-12 -> 0xd1 -> IRQ 28 Mode:1 Active:1)
00:00:07[B] -> 2-12 -> IRQ 28
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
IOAPIC[0]: Set PCI routing entry (2-10 -> 0xd9 -> IRQ 26 Mode:1 Active:1)
00:00:07[C] -> 2-10 -> IRQ 26
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-5 -> 0xe1 -> IRQ 21 Mode:1 Active:1)
00:00:07[D] -> 2-5 -> IRQ 21

2.6.5

ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11 Mode:1 Active:1)
00:00:07[A] -> 2-11 -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:1 Active:1)
00:00:07[B] -> 2-10 -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11


I've attached the dmesgs and /proc/interrupts.



In the interest of full disclosure, this motherboard came with a bad
_PRT.  There are a four entries in the APIC-mode _PRT which look like:
            Package(0x4) {
                0x0007ffff,
                0x0,
                0x0,
                \_SB_.PCI0.LNKA,
            },

With that, ACPI complains and/or can't boot (don't remember exactly). 
So I've fudged them to:
            Package(0x4) {
                0x0007ffff,
                0x0,
                \_SB_.PCI0.LNKA,
                0x0,
            },

I made this change some months before the 2.6.0-test9 kernel which
worked OK.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-260test9.txt"

CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.72 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3960.83 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
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
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 998.0205 MHz.
..... host bus clock speed is 133.0093 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20031002
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................
Table [DSDT](id F004) - 301 Objects with 29 Devices 70 Methods 21 Regions
ACPI Namespace successfully loaded at root c050069c
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:0 Active:0)
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000004020 on int 9
Completing Region/Field/Buffer/Package initialization:..............................................
Initialized 21/21 Regions 1/1 Fields 15/15 Buffers 9/9 Packages (309 nodes)
Executing all Device _STA and_INI methods:..............................
30 Devices found containing: 30 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Fixing up bogus APIC entry
Fixing up bogus APIC entry
Fixing up bogus APIC entry
Fixing up bogus APIC entry
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:09[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:09[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:09[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:09[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
IOAPIC[0]: Set PCI routing entry (2-11 -> 0xc9 -> IRQ 27 Mode:1 Active:1)
00:00:07[A] -> 2-11 -> IRQ 27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
IOAPIC[0]: Set PCI routing entry (2-12 -> 0xd1 -> IRQ 28 Mode:1 Active:1)
00:00:07[B] -> 2-12 -> IRQ 28
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
IOAPIC[0]: Set PCI routing entry (2-10 -> 0xd9 -> IRQ 26 Mode:1 Active:1)
00:00:07[C] -> 2-10 -> IRQ 26
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-5 -> 0xe1 -> IRQ 21 Mode:1 Active:1)
00:00:07[D] -> 2-5 -> IRQ 21
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Starting balanced_irq
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xf8806000, 00:05:5d:d1:48:34, IRQ 17
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xa000, 00:A0:CC:D6:AC:E1, IRQ 17.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 92049U6, ATA DISK drive
hdb: Hewlett-Packard DVD Writer 300, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD800BB-00CAA1, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 0000:00:0e.0
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 18
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800BB-00CAA1, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 18
hdg: WDC WD800BB-00CAA1, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 18
hda: max request size: 128KiB
hda: 39882528 sectors (20419 MB) w/2048KiB Cache, CHS=39566/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 > p3
hdc: max request size: 128KiB
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 < p5 > p2
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: max request size: 128KiB
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1 p2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DDD6
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 24
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: DVD Writer 300n   Rev: 1.25
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 35860910 512-byte hdwr sectors (18361 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target2/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 21, io base 00009400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: irq 21, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1824.000 MB/sec
   8regs_prefetch:  1464.000 MB/sec
   32regs    :   960.000 MB/sec
   32regs_prefetch:   892.000 MB/sec
   pIII_sse  :  1972.000 MB/sec
   pII_mmx   :  2472.000 MB/sec
   p5_mmx    :  2644.000 MB/sec
raid5: using function: pIII_sse (1972.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg2 ...
md:  adding hdg2 ...
md:  adding hde2 ...
md:  adding hdc2 ...
md: created md0
md: bind<hdc2>
md: bind<hde2>
md: bind<hdg2>
md: running: <hdg2><hde2><hdc2>
raid5: device hdg2 operational as raid disk 1
raid5: device hde2 operational as raid disk 2
raid5: device hdc2 operational as raid disk 0
raid5: allocated 3147kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hdc2
 disk 1, o:1, dev:hdg2
 disk 2, o:1, dev:hde2
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:07.2-1
hub 1-0:1.0: new USB device on port 2, assigned address 3
EXT3 FS on md0, internal journal
au88xx: Loading...
au88xx: Found vortex PCI device:
au88xx: id=0x0002
au88xx: bar0=0xd9000000
au88xx: irq=19
au88xx: Add device, audio=3, mixer=0, midi=2
Real Time Clock Driver v1.12
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0110
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 524280k swap on /swapfile.  Priority:-1 extents:4893
eth1: link up, 100Mbps, half-duplex, lpa 0x40A1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 304 bytes per conntrack
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
eth1: no IPv6 routers present
[drm] Initialized r128 2.5.0 20030725 on minor 0

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="interrupts-260test9.txt"

           CPU0       CPU1       
  0:     106340        165    IO-APIC-edge  timer
  1:        211          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 14:         53          1    IO-APIC-edge  ide0
 15:       3358          1    IO-APIC-edge  ide1
 16:         83          1   IO-APIC-level  aic7xxx
 17:       1179          0   IO-APIC-level  eth0, eth1
 18:       6538          5   IO-APIC-level  ide2, ide3, r128@PCI:0:13:0
 19:          0          0   IO-APIC-level  au88xx
 21:         52          0   IO-APIC-level  uhci_hcd, uhci_hcd
NMI:          0          0 
LOC:     106250     106296 
ERR:          0
MIS:          9

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-smp-acpi.txt"

CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.72 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3960.83 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 998.0152 MHz.
..... host bus clock speed is 133.0087 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:......................................................................
Table [DSDT](id F004) - 301 Objects with 29 Devices 70 Methods 21 Regions
ACPI Namespace successfully loaded at root c050cd7c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 0000000000004020 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 3 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..............................................
Initialized 21/21 Regions 1/1 Fields 15/15 Buffers 9/9 Packages (310 nodes)
Executing all Device _STA and_INI methods:................................
32 Devices found containing: 32 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Fixing up bogus APIC entry
Fixing up bogus APIC entry
Fixing up bogus APIC entry
Fixing up bogus APIC entry
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:09[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:09[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:09[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:09[D] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11 Mode:1 Active:1)
00:00:07[A] -> 2-11 -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:1 Active:1)
00:00:07[B] -> 2-10 -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
number of MP IRQ sources: 15.
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
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Starting balanced_irq
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 0000:00:07.2, from 5 to 11
PCI: Via IRQ fixup for 0000:00:07.3, from 5 to 11
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xf881c000, 00:05:5d:d1:48:34, IRQ 17
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xa000, 00:A0:CC:D6:AC:E1, IRQ 17.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 92049U6, ATA DISK drive
hdb: Hewlett-Packard DVD Writer 300, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD800BB-00CAA1, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370A: IDE controller at PCI slot 0000:00:0e.0
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 18
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800BB-00CAA1, ATA DISK drive
ide2 at 0xb400-0xb407,0xb802 on irq 18
hdg: WDC WD800BB-00CAA1, ATA DISK drive
ide3 at 0xbc00-0xbc07,0xc002 on irq 18
hda: max request size: 128KiB
hda: 39882528 sectors (20419 MB) w/2048KiB Cache, CHS=39566/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 > p3
hdc: max request size: 128KiB
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 < p5 > p2
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: max request size: 128KiB
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1 p2
hdb: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DDD6
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 24
SCSI device sda: 35860910 512-byte hdwr sectors (18361 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target2/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 0
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:07.2: irq 11, io base 00009400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:07.3: irq 11, io base 00009800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1824.000 MB/sec
   8regs_prefetch:  1460.000 MB/sec
   32regs    :   916.000 MB/sec
   32regs_prefetch:   852.000 MB/sec
   pIII_sse  :  1948.000 MB/sec
   pII_mmx   :  2472.000 MB/sec
   p5_mmx    :  2648.000 MB/sec
raid5: using function: pIII_sse (1948.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg2 ...
md:  adding hdg2 ...
md:  adding hde2 ...
md:  adding hdc2 ...
md: created md0
md: bind<hdc2>
md: bind<hde2>
md: bind<hdg2>
md: running: <hdg2><hde2><hdc2>
raid5: device hdg2 operational as raid disk 1
raid5: device hde2 operational as raid disk 2
raid5: device hdc2 operational as raid disk 0
raid5: allocated 3147kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:3 fd:0
 disk 0, o:1, dev:hdc2
 disk 1, o:1, dev:hdg2
 disk 2, o:1, dev:hde2
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 220k freed
usb 1-1: new low speed USB device using address 2
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:07.2-1
usb 1-2: new full speed USB device using address 3
EXT3 FS on md0, internal journal
Real Time Clock Driver v1.12
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0110
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 524280k swap on /swapfile.  Priority:-1 extents:4893
eth1: link up, 100Mbps, half-duplex, lpa 0x40A1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 300 bytes per conntrack
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
Vortex: init.... <6>done.
vortex: revision = 0xfe, device = 2
eth1: no IPv6 routers present
eth0: no IPv6 routers present
[drm] Initialized r128 2.5.0 20030725 on minor 0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
APIC error on CPU0: 00(02)
APIC error on CPU1: 00(08)
icmpv6_send: addr_any/mcast source
icmpv6_send: addr_any/mcast source
icmpv6_send: addr_any/mcast source
hde: 0 bytes in FIFO
hde: timeout waiting for DMA
irq 11: nobody cared!
Call Trace:
 [<c010b37a>] __report_bad_irq+0x2a/0x90
 [<c010b470>] note_interrupt+0x70/0xb0
 [<c010b7b0>] do_IRQ+0x160/0x1a0
 [<c01098b8>] common_interrupt+0x18/0x20
 [<c0106960>] default_idle+0x0/0x40
 [<c010698c>] default_idle+0x2c/0x40
 [<c0106a1b>] cpu_idle+0x3b/0x50
 [<c04c04c0>] unknown_bootoption+0x0/0x120
 [<c04c094b>] start_kernel+0x1bb/0x210
 [<c04c04c0>] unknown_bootoption+0x0/0x120

handlers:
[<c03139d0>] (usb_hcd_irq+0x0/0x70)
[<c03139d0>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #11
vortex: 0 virt=12, real=0, delta=2
icmpv6_send: addr_any/mcast source
icmpv6_send: addr_any/mcast source
irq 19: nobody cared!
Call Trace:
 [<c010b37a>] __report_bad_irq+0x2a/0x90
 [<c010b470>] note_interrupt+0x70/0xb0
 [<c010b7b0>] do_IRQ+0x160/0x1a0
 [<c01098b8>] common_interrupt+0x18/0x20
 [<c0106960>] default_idle+0x0/0x40
 [<c010698c>] default_idle+0x2c/0x40
 [<c0106a1b>] cpu_idle+0x3b/0x50
 [<c04c04c0>] unknown_bootoption+0x0/0x120
 [<c04c094b>] start_kernel+0x1bb/0x210
 [<c04c04c0>] unknown_bootoption+0x0/0x120

handlers:
[<f8997010>] (vortex_interrupt+0x0/0x200 [snd_au8830])
Disabling IRQ #19

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="interrupts-smp-acpi.txt"

           CPU0       CPU1       
  0:   57270917        151    IO-APIC-edge  timer
  1:      18860          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:     300000          0   IO-APIC-level  uhci_hcd, uhci_hcd
 14:      15036          2    IO-APIC-edge  ide0
 15:     657915          3    IO-APIC-edge  ide1
 16:      70124          1   IO-APIC-level  aic7xxx
 17:     175806          0   IO-APIC-level  eth0, eth1
 18:    5655479       1539   IO-APIC-level  ide2, ide3, r128@PCI:0:13:0
 19:     299999          1   IO-APIC-level  au8830
NMI:          0          0 
LOC:   57280325   57280398 
ERR:          2
MIS:       6416

--SLDf9lqlvOQaIe6s--
