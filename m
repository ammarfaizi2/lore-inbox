Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTE2SMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTE2SMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:12:32 -0400
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:12959 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id S262486AbTE2SMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:12:23 -0400
Date: Thu, 29 May 2003 18:25:35 +0100 (BST)
From: Ben <linux-kernel-1@slimyhorror.com>
X-X-Sender: ben@baphomet.bogo.bogus
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-mm9, CMD649 IDE controller 2nd IDE channel doesn't work
Message-ID: <Pine.LNX.4.53.0305291823400.27969@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure if this is already a known problem - there's another CMD649 
bug in bugzilla.kernel.org (bug 113) which might be the same issue. Maybe 
this email might help track down the problem?

Anyway, I tried out 2.5.69-mm9 on a server here, and ran into problems 
with the CMD649 initialisation. The full gory dmesg log is appended below. 
The system booted but dropped into a recovery shell because partitions on 
/dev/hdg could not be mounted. The CMD error messages complain of IRQ 
problems; I tried booting again with 'pci=noacpi', but then the system 
couldn't even find root on /dev/hde. (Sorry, no logs for this, 
hyperterminal ate the serial console output:( )

lspci -vv for the CMD649 card:

00:0a.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3649
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at b800 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at a800 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-


Here's a snippet of the dmesg from this system when booting in 2.4, where 
the CMD649 driver detects everything:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
CMD649: IDE controller at PCI slot 00:0a.0
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: CD-RW CRX100E, ATAPI CD/DVD-ROM drive
blk: queue c0371fc0, I/O limit 4095Mb (mask 0xffffffff)
hdd: FUJITSU MPC3084AT, ATA DISK drive
blk: queue c0372588, I/O limit 4095Mb (mask 0xffffffff)
hde: IC35L040AVER07-0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
blk: queue c03728b0, I/O limit 4095Mb (mask 0xffffffff)
hdg: IBM-DJNA-372200, ATA DISK drive
blk: queue c0372d28, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd000-0xd007,0xb802 on irq 18
ide3 at 0xb400-0xb407,0xb002 on irq 18
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(33)
hdd: attached ide-disk driver.
hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=0x04 { DriveStatusError }
hdd: 16514064 sectors (8455 MB), CHS=16383/16/63, UDMA(33)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=43800/16/63, UDMA(33)
Partition check:
 hda: hda1
 hdd: [PTBL] [1027/255/63] hdd1 hdd2
 hde: hde1 hde2 hde3
 hdg: [PTBL] [2748/255/63] hdg1 hdg2


Finally, here's the full dmesg from 2.5.69-mm9:



Linux version 2.5.69-mm9 (ben@baphomet) (gcc version 3.3 (Debian)) #1 SMP Sun May 25 15:56:27 BST 2003
Video mode to be used for restore is fffe
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
 BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f6ec0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131069
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126973 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 ASUS                       ) @ 0x000f80f0
ACPI: RSDT (v001 ASUS   P2B-D    22616.11826) @ 0x1fffd000
ACPI: FADT (v001 ASUS   P2B-D    22616.11826) @ 0x1fffd100
ACPI: BOOT (v001 ASUS   P2B-D    22616.11826) @ 0x1fffd040
ACPI: MADT (v001 ASUS   P2B-D    00000.00000) @ 0x1fffd080
ACPI: DSDT (v001   ASUS P2B-D    00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x14] polarity[0x1] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux root=2101 console=tty0 console=ttyS0,9600
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 350.897 MHz processor.
Calibrating delay loop... 692.22 BogoMIPS
Memory: 515680k/524276k available (1702k kernel code, 7820k reserved, 516k data, 140k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium II (Deschutes) stepping 01
per-CPU timeslice cutoff: 1463.72 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 700.41 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 01
Total of 2 processors activated (1392.64 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
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
 14 001 01  1    1    0   0   0    1    1    71
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
IRQ9 -> 0:9-> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 350.0751 MHz.
..... host bus clock speed is 100.0214 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16)
00:00:0c[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17)
00:00:0c[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18)
00:00:0c[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19)
00:00:0c[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 1
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
Journalled Block Device driver loaded
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
hda: IBM-DTLA-307030, ATA DISK drive
hdb: CD-RW CRX100E, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: FUJITSU MPC3084AT, ATA DISK drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
CMD649: IDE controller at PCI slot 00:0a.0
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hde: IC35L040AVER07-0, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
anticipatory scheduling elevator
ide2 at 0xd000-0xd007,0xb802 on irq 18
hdg: IBM-DJNA-372200, ATA DISK drive
hdg: IRQ probe failed (0xffeb3ffa)
hdh: IRQ probe failed (0xffeb3ffa)
hdh: IRQ probe failed (0xffeb3ffa)
ide3: DISABLED, NO IRQ
ide3: I/O resource 0xB400-0xB400 not free.
ide3: I/O resource 0xB401-0xB401 not free.
ide3: I/O resource 0xB402-0xB402 not free.
ide3: I/O resource 0xB403-0xB403 not free.
ide3: I/O resource 0xB404-0xB404 not free.
ide3: I/O resource 0xB405-0xB405 not free.
ide3: I/O resource 0xB406-0xB406 not free.
ide3: I/O resource 0xB407-0xB407 not free.
ide3: I/O resource 0xB002-0xB002 not free.
hdg: ERROR, PORTS ALREADY IN USE
hda: max request size: 128KiB
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(33)
 hda: hda1
hdd: max request size: 128KiB
hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=0x04 { DriveStatusError }
hdd: 16514064 sectors (8455 MB), CHS=16383/16/63, UDMA(33)
 hdd: hdd1 hdd2
hde: max request size: 128KiB
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 hde: hde1 hde2 hde3
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hde1, internal journal
Real Time Clock Driver v1.11
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
