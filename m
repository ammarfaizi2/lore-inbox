Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRLZOGr>; Wed, 26 Dec 2001 09:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbRLZOGi>; Wed, 26 Dec 2001 09:06:38 -0500
Received: from khazad-dum.debian.net ([200.196.10.6]:1920 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S279307AbRLZOGZ>; Wed, 26 Dec 2001 09:06:25 -0500
Date: Wed, 26 Dec 2001 12:06:17 -0200
To: linux-kernel@vger.kernel.org
Subject: PDC20265 ide_dma_timeout and RAID5 issues (2.4.17)
Message-ID: <20011226120617.A1316@khazad-dum>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@rcm.org.br (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been trying to get the Linux software RAID to work with two QUANTUM
FIREBALLP AS40.0 drives. Each HD is connected as the master unit of one of
the channels of a Promise PDC20265 controller (ASUS A7V [not A7V133!] board,
newest BIOS).  The connection is done using 80-wire IDE cable, without any
slave devices.

Using dd for read and write is fine, and so is RAID1. However, if (and only
if) I try to read from a RAID5 device using the two HDs (3 disk raid,
running in degraded mode), the system loses sync with the PDC20265
controller, and starts spilling out DMA errors, and interrupt lost errors.
It requires a SYSRQ-assisted sync+boot to recover the system.

Here is the error log:
# dd if=/dev/md3 of=/dev/null
raid5: switching cache buffer size, 4096 --> 1024
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdg: status error: status=0x00 { }
hdg: drive not ready for command
hdg: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdg: read_intr: error=0x04 { DriveStatusError }
hdg: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdg: read_intr: error=0x04 { DriveStatusError }
hdg: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdg: read_intr: error=0x04 { DriveStatusError }
ide3: reset: success
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hde: read_intr: error=0x04 { DriveStatusError }
hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hde: read_intr: error=0x04 { DriveStatusError }
hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hde: read_intr: error=0x04 { DriveStatusError }
hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hde: read_intr: error=0x04 { DriveStatusError }
ide2: reset: success
hdg: lost interrupt
hdg: lost interrupt
hdg: lost interrupt
hdg: lost interrupt

The same problem also happens with 2.2.20 + IDE patches + New RAID patches.
It is very interesting that the RAID1 profile does not trigger the bug, and
doing all sort of parallel reads using dd will not trigger the bug either.
Only RAID5 seems to be able to trigger it.

Kernel is 2.4.17, with the improved K7+VIA "Athlon bug stomper" patch, plus
Debian patches (bug also shows up without K7 patch).  Attached is also the
lspci -v output for this machine, and bootup log.

Any ideas on how to fix this one? I will gladly help to debug and test
patches for this issue...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=foo

Linux version 2.4.17 (hmh@khazad-dum) (gcc version 2.95.4 20011223 (Debian prerelease)) #1 Ter Dez 25 19:35:31 BRST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
 BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=linux ro root=301
Initializing CPU#0
Detected 1210.815 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 2411.72 BogoMIPS
Memory: 254940k/262064k available (1567k kernel code, 6736k reserved, 569k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1210.7822 MHz.
..... host bus clock speed is 201.7969 MHz.
cpu: 0, clocks: 2017969, slice: 1008984
CPU0<T0:2017968,T1:1008976,D:8,S:1008984,C:2017969>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Trying to stomp on Athlon bug...
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
udf: registering filesystem
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:...................................................................................................................
115 Control Methods found and parsed (364 nodes total)
ACPI Namespace successfully loaded at root c0366ec0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.......................................
39 Devices found: 39 _STA, 0 _INI
Completing Region and Field initialization:...................
17/24 Regions, 2/2 Fields initialized (364 nodes total)
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP SERIAL_ACPI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8800-0x8807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x8808-0x880f, BIOS settings: hdg:pio, hdh:DMA
hda: QUANTUM FIREBALLlct15 30, ATA DISK drive
hdc: HL-DT-ST GCE-8160B, ATAPI CD/DVD-ROM drive
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa000-0xa007,0x9802 on irq 10
ide3 at 0x9400-0x9407,0x9002 on irq 10
hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
 hde: hde1 hde2 hde3 < hde5 hde6 hde7 hde8 hde9 >
 hdg: hdg1 hdg2 hdg3 < hdg5 hdg6 hdg7 hdg8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: CD-RW GCE-8160B   Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1850.400 MB/sec
   32regs    :  1636.800 MB/sec
   pII_mmx   :  2835.200 MB/sec
   p5_mmx    :  3628.400 MB/sec
raid5: using function: p5_mmx (3628.400 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 0000001e]
 [events: 0000001e]
 [events: 0000001e]
 [events: 0000001e]
 [events: 0000001e]
 [events: 0000001e]
 [events: 0000001e]
 [events: 0000001e]
md: autorun ...
md: considering hdg8 ...
md:  adding hdg8 ...
md:  adding hde9 ...
md: created md3
md: bind<hde9,1>
md: bind<hdg8,2>
md: running: <hdg8><hde9>
md: hdg8's event counter: 0000001e
md: hde9's event counter: 0000001e
md: md3: raid array is not clean -- starting background reconstruction
md3: max total readahead window set to 2048k
md3: 2 data-disks, max readahead per data-disk: 1024k
raid5: device hdg8 operational as raid disk 1
raid5: device hde9 operational as raid disk 0
raid5: md3, not all disks are operational -- trying to recover array
raid5: allocated 3291kB for md3
raid5: raid level 5 set md3 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde9
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg8
 disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde9
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg8
 disk 2, s:0, o:0, n:2 rd:2 us:1 dev:[dev 00:00]
md: updating md3 RAID superblock on device
md: hdg8 [events: 0000001f]<6>(write) hdg8's sb offset: 29316544
md: recovery thread got woken up ...
md3: no spare disk to reconstruct array! -- continuing in degraded mode
md: recovery thread finished ...
md: hde9 [events: 0000001f]<6>(write) hde9's sb offset: 29316544
md: considering hdg6 ...
md:  adding hdg6 ...
md:  adding hde6 ...
md: created md2
md: bind<hde6,1>
md: bind<hdg6,2>
md: running: <hdg6><hde6>
md: hdg6's event counter: 0000001e
md: hde6's event counter: 0000001e
md: md2: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md2: max total readahead window set to 124k
md2: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdg6 operational as mirror 1
raid1: device hde6 operational as mirror 0
raid1: raid set md2 not clean; reconstructing mirrors
raid1: raid set md2 active with 2 out of 2 mirrors
md: updating md2 RAID superblock on device
md: hdg6 [events: 0000001f]<6>(write) hdg6's sb offset: 1573376
md: syncing RAID array md2
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 1048704 blocks.
md: hde6 [events: 0000001f]<6>(write) hde6's sb offset: 1048704
md: considering hdg5 ...
md:  adding hdg5 ...
md:  adding hde5 ...
md: created md1
md: bind<hde5,1>
md: bind<hdg5,2>
md: running: <hdg5><hde5>
md: hdg5's event counter: 0000001e
md: hde5's event counter: 0000001e
md: md1: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdg5 operational as mirror 1
raid1: device hde5 operational as mirror 0
raid1: raid set md1 not clean; reconstructing mirrors
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hdg5 [events: 0000001f]<6>(write) hdg5's sb offset: 4292928
md: delaying resync of md1 until md2 has finished resync (they share one or more physical units)
md: hde5 [events: 0000001f]<6>(write) hde5's sb offset: 4292928
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1,1>
md: bind<hdg1,2>
md: running: <hdg1><hde1>
md: hdg1's event counter: 0000001e
md: hde1's event counter: 0000001e
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdg1 operational as mirror 1
raid1: device hde1 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdg1 [events: 0000001f]<6>(write) hdg1's sb offset: 102720
md: delaying resync of md0 until md2 has finished resync (they share one or more physical units)
md: hde1 [events: 0000001f]<6>(write) hde1's sb offset: 102720
md: ... autorun DONE.
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (2047 buckets, 16376 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ip6_tables: (c)2000 Netfilter core team
registreing ipv6 mark target
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
spurious 8259A interrupt: IRQ7.
Adding Swap: 499960k swap-space (priority 1)
Adding Swap: 262576k swap-space (priority 1)
Adding Swap: 262576k swap-space (priority 1)
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:04.2
PCI: Sharing IRQ 5 with 00:04.3
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xa400. Vers LK1.1.16
divert: allocating divert_blk for eth0
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
i2c-core.o: i2c core module version 2.6.2 (20011118)
i2c-viapro.o version 2.6.2 (20011118)
i2c-viapro.o: Found Via VT82C686A/B device
i2c-core.o: adapter SMBus Via Pro adapter at e800 registered as adapter 0.
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-proc.o version 2.6.2 (20011118)
w83781d.o version 2.6.2 (20011118)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [AS99127F chip] registered to adapter [SMBus Via Pro adapter at e800](pos. 0).
i2c-core.o: client [AS99127F subclient] registered to adapter [SMBus Via Pro adapter at e800](pos. 1).
i2c-core.o: client [AS99127F subclient] registered to adapter [SMBus Via Pro adapter at e800](pos. 2).
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: Legacy device
lp0: using parport0 (interrupt-driven).
lp0: console ready
lp0: compatibility mode
lp0: compatibility mode

--C7zPtVaVf+AK4Oqc--
