Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTEXUXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTEXUXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 16:23:34 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:37273 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261153AbTEXUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 16:23:21 -0400
From: rankincj@yahoo.com
Message-Id: <200305242036.h4OKaOGt002064@twopit.underworld>
Subject: [BUG] IDE DMA timeout, then crash on reenable (2.4.20-SMP)
To: linux-kernel@vger.kernel.org
Date: Sat, 24 May 2003 21:36:24 +0100 (BST)
Cc: andre@linux-ide.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.20-SMP, dual 933 PIII Coppermine, 1 GB RAM, devfs, compiled
with gcc-3.2.3.

Hi,

Today, this message appeared in my log file:

May 24 12:02:33 twopit kernel: hda: status timeout: status=0x80 { Busy }
May 24 12:02:33 twopit kernel: hda: DMA disabled
May 24 12:02:33 twopit kernel: hda: drive not ready for command
May 24 12:02:40 twopit kernel: ide0: reset: success

I was downloading Mozilla 1.3.1 at the time, so must have been
receiving a lot of Ethernet interrupts (if that's relevant). Anyway,
since this message usually means bad news I waited for the download to
finish and then synced my disks. I then reenabled DMA using hdparm -
still OK. Then I tried syncing my discs again... and the command
blocked, the hard disc light came on and stayed on, there was a
whirring sound from the drive, processes hung when I tried to shut
them down and finally the box hung so hard that I couldn't even reboot
it with Alt-SysRq-B.

This isn't the first time that this has happened; I typically get
total IDE failures after about 1 month of uptime. For example, I
returned from work one day last week to discover the hard drive
whirring away (as described above) and the entire machine hung
hard. Nothing had been written into the logs to help explain it
either; nothing to do except hit the Big Beige Button. (As above.)

This month, I was running with the following patch because I thought
that it might help... It obviously didn't.

--- linux-2.4.20/drivers/block/ll_rw_blk.c.orig Mon Apr 14 22:03:14 2003
+++ linux-2.4.20/drivers/block/ll_rw_blk.c  Mon Apr 14 22:06:54 2003
@@ -1376,11 +1376,12 @@

 void end_that_request_last(struct request *req)
 {
- if (req->waiting != NULL)
-   complete(req->waiting);
- req_finished_io(req);
+ struct completion *waiting = req->waiting;

+ req_finished_io(req);
  blkdev_release_request(req);
+ if (waiting)
+   complete(waiting);
 }

 int __init blk_dev_init(void)


My CD-ROM is also a CD burner, and so I had the ide-scsi module loaded
(as usual) and a CD in the drive. Could this be relevant?

Anyway, IDE timeouts I can understand. It's the crash on reenabling
DMA that really worries me because that MUST mean a bug in the kernel
somewhere. Is there any (small, localised) patch in 2.4.21-pre that I
could try? Is this DMA issue at least understood, so that I might be
able to avoid this happening again before 2.4.21 is finally released?

I have appended my boot-log and PCI details.
Thanks,
Chris

Loaded 16555 symbols from /boot/System.map-2.4.20.
Symbols match kernel version 2.4.20.
Loaded 173 symbols from 10 modules.
Linux version 2.4.20 (chris@twopit) (gcc version 3.2.3) #3 SMP Sat Apr 26 14:35:23 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffe0000 (usable)
 BIOS-e820: 000000003ffe0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000faf50
hm, page 000fa000 reserved twice.
hm, page 000fb000 reserved twice.
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
On node 0 totalpages: 262112
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32736 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: _AMI_    Product ID: 840_CARMEL__ APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFD8FF000.
Processors: 2
Kernel command line: BOOT_IMAGE=Linux-profile ro root=301 profile=2 ide0=autotune nmi_watchdog=1
ide_setup: ide0=autotune
Initializing CPU#0
Detected 932.906 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1861.22 BogoMIPS
Memory: 1032156k/1048448k available (1280k kernel code, 15896k reserved, 443k data, 112k init, 130944k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 732.10 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000084
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1861.22 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3722.44 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
..changing IO-APIC physical APIC ID to 3 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 3-19, 3-20, 3-21, 3-22, 3-23 not connected.
.TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 29.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 24.
testing the IO APIC.......................

IO APIC #2......
... register #00: 02000000
......    : physical APIC id: 02
... register #01: 00170020
......     : max redirection entries: 0017
......     : PRQ implemented: 0
......     : IO APIC version: 0020
... register #02: 00000000
......     : arbitration: 00
... IRQ redirection table:
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
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
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

IO APIC #3......
... register #00: 03000000
......    : physical APIC id: 03
... register #01: 00178020
......     : max redirection entries: 0017
......     : PRQ implemented: 1
......     : IO APIC version: 0020
... register #02: 09000000
......     : arbitration: 09
... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 932.8906 MHz.
.... host bus clock speed is 133.2699 MHz.
cpu: 0, clocks: 1332699, slice: 444233
CPU0<T0:1332688,T1:888448,D:7,S:444233,C:1332699>
cpu: 1, clocks: 1332699, slice: 444233
CPU1<T0:1332688,T1:444208,D:14,S:444233,C:1332699>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801AA PCI Bridge
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B5,I0,P0) -> 16
PCI->APIC IRQ transform: (B1,I1,P0) -> 17
PCI->APIC IRQ transform: (B1,I7,P0) -> 19
PCI->APIC IRQ transform: (B1,I8,P0) -> 16
PCI->APIC IRQ transform: (B2,I12,P0) -> 18
PCI->APIC IRQ transform: (B2,I13,P0) -> 19
PCI->APIC IRQ transform: (B2,I13,P1) -> 16
PCI->APIC IRQ transform: (B2,I13,P2) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller on PCI bus 00 dev f9
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: ST320420A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-116 0122, ATAPI CD/DVD-ROM drive
hdd: SONY CD-RW CRX145E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c031eb24, I/O limit 4095Mb (mask 0xffffffff)
hda: 39851760 sectors (20404 MB) w/2048KiB Cache, CHS=2480/255/63, UDMA(66)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 498004k swap-space (priority 1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
microcode: CPU0 updated from revision 0 to 7, date=05052000
microcode: CPU1 updated from revision 0 to 7, date=05052000
microcode: freed 4096 bytes
loop: loaded (max 8 devices)
ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[19]  MMIO=[fd7fe800-fd7fefff]  Max Packet=[2048]
ohci1394_1: Unexpected PCI resource length of 1000!
ohci1394_1: OHCI-1394 1.0 (PCI): IRQ=[18]  MMIO=[fd2fc000-fd2fc7ff]  Max Packet=[1024]
ieee1394: Host added: Node[00:1023]  GUID[0011060000003675]  [Linux OHCI-1394]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
hcd.c: ehci-hcd @ 02:0d.2, NEC Corporation USB 2.0
hcd.c: irq 17, pci mem f8889f00
usb.c: new USB bus registered, assigned bus number 1
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 0.95
hub.c: USB hub found
hub.c: 5 ports detected
ieee1394: Host added: Node[00:1023]  GUID[0090a9400800472c]  [Linux OHCI-1394]
usb-ohci.c: USB OHCI at membase 0xf8891000, IRQ 16
usb-ohci.c: usb-02:0d.1, NEC Corporation USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-ohci.c: USB OHCI at membase 0xf88a4000, IRQ 19
usb-ohci.c: usb-02:0d.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xef80, IRQ 19
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:21:0C:51, IRQ 16.
  Board assembly 389911-037, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Power Resource: found
Power Resource: found
Power Resource: found
Power Resource: found
ACPI: System firmware supports S0 S1 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
ACPI: Power Button (FF) found
ACPI: Sleep Button (CM) found
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.12
ide-cd: ignoring drive hdd
i2c-core.o: i2c core module
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-proc.o version 2.6.1 (20010825)
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801 adapter at efa0](pos. 0).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801 adapter at efa0](pos. 1).
lm87.o version 2.6.5 (20020915)
i2c-core.o: driver LM87 sensor driver registered.
i2c-core.o: client [LM87 chip] registered to adapter [SMBus I801 adapter at efa0](pos. 2).
i2c-core.o: client [LM87 chip] registered to adapter [SMBus I801 adapter at efa0](pos. 3).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Intel i840 chipset
agpgart: AGP aperture is 32M @ 0xfa000000
[drm] AGP 0.99 aperture @ 0xfa000000 32MB
[drm] Initialized mga 3.1.0 20021029 on minor 0
mice: PS/2 mouse device common for all mice
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
SCSI subsystem driver Revision: 1.00
scsi: host order: ide-scsi:sbp2:sbp2:usb-storage-0:usb-storage-1:ppa
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX145E    Rev: 1.0b
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000
[drm] Module unloaded
[drm] AGP 0.99 aperture @ 0xfa000000 32MB
[drm] Initialized mga 3.1.0 20021029 on minor 0


00:00.0 Host bridge: Intel Corp. 82840 840 (Carmel) Chipset Host Bridge (Hub A) (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at fa000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82840 840 (Carmel) Chipset AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fda00000-feafffff
	Prefetchable memory behind bridge: f5000000-f90fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 PCI bridge: Intel Corp. 82840 840 (Carmel) Chipset PCI Bridge (Hub B) (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=64
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: fd800000-fd9fffff
	Prefetchable memory behind bridge: f4e00000-f4ffffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: fd200000-fd7fffff
	Prefetchable memory behind bridge: f4c00000-f4dfffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp. 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at ef80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
	Subsystem: Intel Corp. 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at efa0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
	Subsystem: Unknown device 4352:5934
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ef00 [size=64]

01:01.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at af80 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:01.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at aff0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:06.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fd200000-fd2fffff
	Prefetchable memory behind bridge: f4c00000-f4cfffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [90] #06 [0000]

01:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd7fe800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at ac00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Alert On LAN II* Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd7ff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at af00 [size=64]
	Region 2: Memory at fd600000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fd500000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0c.0 FireWire (IEEE 1394): NEC Corporation IEEE 1394 [OrangeLink] Host Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Orange Micro Root hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd2fc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Orange Micro Root Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd2fd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Orange Micro Root Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 0: Memory at fd2fe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.2 USB Controller: NEC Corporation USB 2.0 (rev 01) (prog-if 20 [EHCI])
	Subsystem: Orange Micro Root hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at fd2fff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fd800000-fd8fffff
	Prefetchable memory behind bridge: f4e00000-f4efffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

04:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82806AA PCI64 Hub APIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fd8ff000 (32-bit, non-prefetchable) [size=4K]

05:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at feae0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

