Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319266AbSH2SWM>; Thu, 29 Aug 2002 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319283AbSH2SWM>; Thu, 29 Aug 2002 14:22:12 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:65296 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S319266AbSH2SWJ>;
	Thu, 29 Aug 2002 14:22:09 -0400
Date: Thu, 29 Aug 2002 21:26:31 +0300 (EEST)
From: Meelis Roos <mroos@tartu.cyber.ee>
To: linux-kernel@vger.kernel.org
Subject: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
Message-ID: <Pine.LNX.4.44.0208292051520.25834-100000@ondatra.tartu-labor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old computer (from 1997), K6/200 with 430TX chipset. It has 
served me well so far. It ran 2.4.18 OK since February. But 2.4.19 and 
2.4.20-pre5 both hang frequently. 2.2.15 works well but it looks to be 
running in PIO mode. 2.4.18 ran in udma33 mode but maybe the computer is 
broken now.

The hangs appear when I'm doing disk-intensive work (compiling kernel, bk 
clone, bk co, ...). Sometimes disk IO just hangs at some point and 
everything depending on disk gets into D state. Usually I was in X and 
didn't see any details but later I was at the console and got some 
information.

vmstat 1 was running at one crash and reported that I have 17M swap used 
(64M total) and 6M free memory so these are not memory shortages that I 
suspected first.

I also got Sysrq-P and Sysrq-T info. Sysrq-P showed it looping in 
addresses 00088XXX (or was it 08088XXX). System.map didn't have these 
addresses :(

Sysrq-T showed that many tasks were in D state but EIP was usually either 
00000000 or 7FFFFFFF (also on some sleeping tasks). Is this normal?

I installed 2.4.20-pre5 (after several iterations of compile+boot I got it 
compiled since both of my kernels were too new). Still the same.

I do my heavy work on hdd which is an old Seagate 2.5G (non-udma but dma 
mode 2). This disk is even older than the computer, it was a new model 
when bought. It shows some disturbing pre-errors with smart but no errors 
in kernel log.

The hang happened 2-3 times just after 'sync' command done after some big 
operations like bk clone or bk co.

Tried both ext2 and ext3 filesysyems on the data partition, root is ext2. 
The hangs happen in both cases.

The HDD LED is (almost) always on during the hangs.

After Sysrq-B the computer sometimes just hangs with HDD LED on, sometimes 
boots. This symptom is old on this computer, it ocassionaly hangs on 
reboot with HDD LED on, both when booting from linux and rebooting from 
win95 that I had a long time ago.

When pressing Sysrq-S during the hang, it gets to Syncing 03:03 (hda3, my 
root partition) and hangs there. So maybe it's not the old Seagate disk 
that is at fault. hda and hdb are almost identical 1.6G Quantums.

I'm compiling 2.4.18 now to see whether I can reproduce the problem with 
it (my old 2.4.18 binary doesn't work any more since it falsely detects 
that hda has Acorn PowerTec partition table - something changed inside hda 
data; 2.4.19 without Acorn partition table support and 2.2.15 find the 
partitions OK).

smartctl tells some high error rates about hdd; hda and hdb are 
normal. hdc is cdrom used via ide-scsi.

smartctl, atapci, hdparm, lspci, dmesg output are below.

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 5
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000a   114   099   000       72998123
(  3)Spin Up Time            0x0006   097   097   000       3
(  4)Start Stop Count        0x0013   100   100   020       107
(  5)Reallocated Sector Ct   0x0013   100   100   036       0
(  7)Seek Error Rate         0x000b   065   053   030       24096359
( 10)Spin Retry Count        0x0013   100   100   097       0
( 12)Power Cycle Count       0x0013   100   100   020       102

pcibus = 33333
00:07.1 vendor=8086 device=7111 class=0101 irq=0 base4=f001
----------PIIX BusMastering IDE Configuration---------------
Driver Version:                     1.3
South Bridge:                       28945
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Prefetch+Post:        yes       yes       yes       yes
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       90ns      90ns      90ns      90ns
Cmd Active:         360ns     360ns     360ns     360ns
Cmd Recovery:       540ns     540ns     540ns     540ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      90ns      30ns
Cycle Time:         120ns     120ns     180ns     120ns
Transfer Rate:   16.6MB/s  16.6MB/s  11.1MB/s  16.6MB/s

(taken from 2.2)

/dev/hda:

 Model=QUANTUM FIREBALL ST1.6A, FwRev=A0F.0800, SerialNo=851715434518
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3128/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
 BuffType=DualPortCache, BuffSize=81kB, MaxMultSect=16, MultSect=off
 CurCHS=3128/16/63, CurSects=3153024, LBA=yes, LBAsects=3153024
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3

/dev/hdb:

 Model=QUANTUM FIREBALL ST1.6A, FwRev=A0F.0400, SerialNo=851712135299
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3128/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
 BuffType=DualPortCache, BuffSize=81kB, MaxMultSect=16, MultSect=off
 CurCHS=3128/16/63, CurSects=3153024, LBA=yes, LBAsects=3153024
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3

/dev/hdd:

 Model=ST32531A, FwRev=0.62, SerialNo=VE047143
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=4956/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=off
 CurCHS=4956/16/63, CurSects=4996476, LBA=yes, LBAsects=4996476
 IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2
 AdvancedPM=no
Segmentation fault

(yes, hdparm 4.5-1.2 from Debian testing segfaults on this one and it's a 
userspace segfault, not a syscall one, as shown by strace).


00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6300

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:10.0 VGA compatible controller: ATI Technologies Inc 264VT [Mach64 VT] (rev 48) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Mach64VT Reference
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 6400

00:12.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6500
	Region 1: Memory at e1000000 (32-bit, non-prefetchable)

00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6600
	Region 1: Memory at e1001000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Linux version 2.4.20-pre5 (mroos@roos) (gcc version 2.95.4 20011002 (Debian prerelease)) #8 Thu Aug 29 19:11:21 EEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
64MB LOWMEM available.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux ro root=303 reboot=warm hdc=ide-scsi idebus=33
ide_setup: hdc=ide-scsi
ide_setup: idebus=33
Initializing CPU#0
Detected 200.459 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 399.76 BogoMIPS
Memory: 62532k/65536k available (1133k kernel code, 2616k reserved, 472k data, 84k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008001bf 008005bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 008005bf 00000000 00000000
CPU:     After generic, caps: 008001bf 008005bf 00000000 00000000
CPU:             Common caps: 008001bf 008005bf 00000000 00000000
CPU: AMD-K6tm w/ multimedia extensions stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative ViBRA16C PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: System description tables not found
    ACPI-0068: *** Error: Acpi_load_tables: Could not get RSDP, AE_ERROR
    ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: AE_ERROR
ACPI: System description table load failed
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL ST1.6A, ATA DISK drive
hdb: QUANTUM FIREBALL ST1.6A, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6002B, ATAPI CD/DVD-ROM drive
hdd: ST32531A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02cc144, I/O limit 4095Mb (mask 0xffffffff)
hda: 3153024 sectors (1614 MB) w/81KiB Cache, CHS=782/64/63, UDMA(33)
blk: queue c02cc280, I/O limit 4095Mb (mask 0xffffffff)
hdb: 3153024 sectors (1614 MB) w/81KiB Cache, CHS=782/64/63, UDMA(33)
blk: queue c02cc5c4, I/O limit 4095Mb (mask 0xffffffff)
hdd: 4996476 sectors (2558 MB), CHS=4956/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target1/lun0: p1
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: CD-ROM XM-6002B   Rev: 0527
  Type:   CD-ROM                             ANSI SCSI revision: 02
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 84k freed
Adding Swap: 66524k swap-space (priority -1)
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative ViBRA16C PnP detected
sb: ISAPnP reports 'Creative ViBRA16C PnP' at i/o 0x220, irq 5, dma 1, 5
SB 4.13 detected OK (220)
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
<Yamaha OPL3> at 0x388
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide1(22,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #17 config 1000 status 782d advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0xc4859000, 00:48:54:12:83:3F, IRQ 10.
8139too Fast Ethernet driver 0.9.26
eth1: RealTek RTL8139 Fast Ethernet at 0xc4862000, 00:50:22:82:62:f0, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139C'
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
eth0: Setting full-duplex based on MII#17 link partner capability of 45e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

-- 
Meelis Roos (mroos@tartu.cyber.ee)

