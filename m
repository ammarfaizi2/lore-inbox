Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSBGJDN>; Thu, 7 Feb 2002 04:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSBGJCw>; Thu, 7 Feb 2002 04:02:52 -0500
Received: from cm-24-161-45-249.nycap.rr.com ([24.161.45.249]:10880 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S286411AbSBGJCi>; Thu, 7 Feb 2002 04:02:38 -0500
Date: Thu, 7 Feb 2002 04:02:37 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: D state processes in 2.4.18-pre7-ac3
Message-ID: <20020207090237.GA2137@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux incandescent 2.4.18-pre7-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux incandescent 2.4.18-pre7-ac3 #1 Tue Feb 5 01:00:50 EST 2002 i686 unknown

I came home today to a bunch of processes apparently hung in jbd's
do_get_write_access(); apparently, something deadlocked, where no
processes could write to one of my partition's journal.  That's my
theory, anyways.  Several processes had stacks similar to:

Call Trace: [<c011271d>] [<d08ecac7>] [<d08ecd08>] [<d08fb892>]
[<d08ec262>] 
   [<d08fb92a>] [<d08fb9d7>] [<c014367e>] [<c01260c0>] [<c01a452e>]
[<d08f7916>]   [<c0131286>] [<c01016c4b>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c011271c <sleep_on+3c/50>
Trace; d08ecac6 <[jbd]do_get_write_access+2e6/4f0>
Trace; d08ecd08 <[jbd]journal_get_write_access+38/60>
Trace; d08fb892 <[ext3]ext3_reserve_inode_write+32/b0>
Trace; d08ec262 <[jbd]__kstrtab_journal_update_format+2/20>
Trace; d08fb92a <[ext3]ext3_mark_inode_dirty+1a/40>
Trace; d08fb9d6 <[ext3]ext3_dirty_inode+86/d0>
Trace; c014367e <igrab+2e/60>
Trace; c01260c0 <generic_file_write+330/750>
Trace; c01a452e <sock_read+8e/a0>
Trace; d08f7916 <[ext3]ext3_file_write+46/50>
Trace; c0131286 <sys_write+96/d0>
Trace; 0000000c01016c4a <END_OF_CODE+b3068a72c/????>

And, kjournald had the following:

Call Trace: [<c0131f0a>] [<d08ee6e6>] [<c0112380>] [<d08f08eb>]
[<d08f07c0>] 
   [<c010f4e8>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0131f0a <__wait_on_buffer+6a/90>
Trace; d08ee6e6 <[jbd]journal_commit_transaction+776/dd6>
Trace; c0112380 <schedule+2c0/2f0>
Trace; d08f08ea <[jbd]kjournald+10a/1a0>
Trace; d08f07c0 <[jbd]commit_timeout+0/10>
Trace; c010f4e8 <mtrr_read+68/80>

Not sure what caused the actual deadlock; the partition uses lvm and
ext3, and the underlying controller uses hedrick's pdc driver.

Machine info:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at e7dff000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at c800 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: e7e00000-e7efffff
	Prefetchable memory behind bridge: dfc00000-dfcfffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
	Subsystem: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at ebfbf000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
	Subsystem: Unknown device 4942:4c4c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c400 [size=64]

00:09.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at ebff0000 [disabled] [size=64K]

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=8]
	Region 1: I/O ports at d800 [size=4]
	Region 2: I/O ports at d400 [size=8]
	Region 3: I/O ports at d000 [size=4]
	Region 4: I/O ports at cc00 [size=64]
	Region 5: Memory at ebfc0000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at ebfe0000 [disabled] [size=64K]

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: D-Link System Inc DFE-538TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at ebfbef00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

Module                  Size  Used by    Tainted: P 
ipt_MASQUERADE          1312   1 (autoclean)
iptable_nat            14420   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           14092   1 (autoclean) [ipt_MASQUERADE iptable_nat]
ip_tables              10752   4 [ipt_MASQUERADE iptable_nat]
lvm-mod                47712   3
8139too                13536   1 (autoclean)
mii                     1120   0 (autoclean) [8139too]
3c515                  13468   1 (autoclean)
ext3                   56992   1 (autoclean)
jbd                    35848   1 (autoclean) [ext3]
ide-scsi                7680   0
sr_mod                 11832   0 (unused)
cdrom                  29248   0 [sr_mod]
scsi_mod               50524   2 [ide-scsi sr_mod]
es1370                 25936   1
soundcore               3684   4 [es1370]

partition in question:
/dev/site/lvol1
              ext3   297364216 165087832 132276384  56% /mnt/site

Linux version 2.4.18-pre7-ac3 (dilinger@incandescent) (gcc version 2.95.4 (Debian prerelease)) #1 Tue Feb 5 01:00:50 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: root=/dev/hda2 devfs=mount  mem=262080K
Initializing CPU#0
Detected 704.939 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1405.74 BogoMIPS
Memory: 256776k/262080k available (911k kernel code, 4916k reserved, 229k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 704.9229 MHz.
..... host bus clock speed is 201.4065 MHz.
cpu: 0, clocks: 2014065, slice: 1007032
CPU0<T0:2014064,T1:1007024,D:8,S:1007032,C:2014065>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router AMD756 VIPER [1022/740b] at 00:07.3
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20262: IDE controller on PCI bus 00 dev 58
AMD756: dev 105a:4d38, router pirq : 3 get irq : 10
PCI: Found IRQ 10 for device 00:0b.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0xebfe0000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:DMA, hdh:pio
hda: IBM-DJNA-352030, ATA DISK drive
hdb: Maxtor 92041U4, ATA DISK drive
hdc: Maxtor 54098H8, ATA DISK drive
hdd: WDC WD450AA-00BAA0, ATA DISK drive
hde: IC35L060AVER07-0, ATA DISK drive
hdf: IC35L060AVER07-0, ATA DISK drive
hdg: WDC WD800AB-00BTA0, ATA DISK drive
hdh: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xdc00-0xdc07,0xd802 on irq 10
ide3 at 0xd400-0xd407,0xd002 on irq 10
hda: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=2482/255/63, UDMA(33)
hdb: 40020624 sectors (20491 MB) w/512KiB Cache, CHS=2491/255/63, UDMA(33)
hdc: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63, UDMA(33)
hdd: 87930864 sectors (45021 MB) w/2048KiB Cache, CHS=87233/16/63, UDMA(33)
hde: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
hdf: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(66)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: p1
 /dev/ide/host0/bus1/target1/lun0: p1
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [7476/255/63] p1
 /dev/ide/host2/bus0/target1/lun0: p1
 /dev/ide/host2/bus1/target0/lun0: p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:02) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 63 transactions in 10 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 208k freed
Adding Swap: 136512k swap-space (priority -1)
es1370: version v0.37 time 01:07:48 Feb  5 2002
AMD756: dev 1274:5000, router pirq : 4 get irq :  5
PCI: Found IRQ 5 for device 00:08.0
PCI: Sharing IRQ 5 with 00:07.4
PCI: Sharing IRQ 5 with 00:0c.0
es1370: found adapter at io 0xc400 irq 5
es1370: features: joystick off, line in, mic impedance 0
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX140E    Rev: 1.0n
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 20x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Journalled Block Device driver loaded
3c515.c:v0.99t 17-Nov-2001 becker@scyld.com and others
3c515 Resource configuration register 0x00a9, DCR 1485.
eth0: 3Com 3c515 at 0x2a0, 00:10:4b:d4:40:27, DMA 5, IRQ 9
  64K word-wide RAM 1:1 Rx:Tx split, autoselect/10baseT interface.
1 3c515 cards found.
8139too Fast Ethernet driver 0.9.23
AMD756: dev 10ec:8139, router pirq : 4 get irq :  5
PCI: Found IRQ 5 for device 00:0c.0
PCI: Sharing IRQ 5 with 00:07.4
PCI: Sharing IRQ 5 with 00:08.0
eth1: RealTek RTL8139 Fast Ethernet at 0xd0911f00, 00:50:ba:d8:1a:16, IRQ 5
eth1:  Identified 8139 chip type 'RTL-8139B'
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
spurious 8259A interrupt: IRQ7.
LVM version 1.0.1-rc4(ish)(03/10/2001) module loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,0), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack (2047 buckets, 16376 max)


I'm sure it'll happen again, so if anyone has any ideas about what may
be causing this, or what to look for the next time this happens..




-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>
