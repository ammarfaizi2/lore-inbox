Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277871AbRJIRm1>; Tue, 9 Oct 2001 13:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277872AbRJIRmT>; Tue, 9 Oct 2001 13:42:19 -0400
Received: from [212.216.176.56] ([212.216.176.56]:65190 "EHLO fep31-svc.tin.it")
	by vger.kernel.org with ESMTP id <S277871AbRJIRmH>;
	Tue, 9 Oct 2001 13:42:07 -0400
X-Originating-IP: [195.110.141.30]
From: <mtassinari@tin.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 oom_killer
Date: Tue, 9 Oct 2001 19:42:32 CEST
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20011009174232.TTCM525.fep31-svc.tin.it@[127.0.0.1]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm setting up a 2.4.10 (final) abi configured platform.

Running a legacy SCO appl (which heavily stresses the system),
I systematically get an oom_killer intervention.

Sometimes (not systematically) the system oopses after recursively killing 
init (sorry I wasn't able to write it down).

It always triggers as soon as cache eats up all available memory.

The machine has a lot of swap (6.66 ramsize).

I tried to tune bdflush for vm to be less aggressive, with no results.

Browsing the list I understand this behaviour is still present in pre6.

Here some details:

root@master:/usr/ads/apoteca# ./systemtest 2>&1
reorganize prod test...

BCHECK  C-ISAM B-tree Checker version 1.07
Copyright (C) 1981-1989 Informix Software, Inc.


C-ISAM Files: prod

Checking dictionary and file sizes.
index file node size = 1024
current C-ISAM index node size = 1024
Checking data file records.
Command terminated by signal 9
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Command being timed: "/usr/ads/ads/bcheck -y prod"
 User time (seconds): 2.25
 System time (seconds): 2.24
 Percent of CPU this job got: 44%
 Elapsed (wall clock) time (h:mm:ss or m:ss): 0:10.10
 Average shared text size (kbytes): 0
 Average unshared data size (kbytes): 0
 Average stack size (kbytes): 0
 Average total size (kbytes): 0
 Maximum resident set size (kbytes): 0
 Average resident set size (kbytes): 0
 Major (requiring I/O) page faults: 24
 Minor (reclaiming a frame) page faults: 50
 Voluntary context switches: 0
 Involuntary context switches: 0
 Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

root@master:~# vmstat 5 1000
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0  51320   1020  30048   0   0    58     1  109    21   2   1  97
 0  0  0      0  51052   1020  30048   0   0     0     0  105     9   1   1  99
 0  0  0      0  51052   1020  30048   0   0     0     0  101     5   0   0 100
 1  0  0      0  51052   1020  30048   0   0     0     0  102     5   0   0 100
 0  0  0      0  50812   1020  30076   0   0     6     0  114    32   2   1  97
 0  0  0      0  50812   1020  30076   0   0     0     0  101     4   0   0 100
 0  0  0      0  50812   1020  30076   0   0     0     0  102     7   0   0 100
 0  0  0      0  50812   1020  30076   0   0     0     6  106     6   0   0 100
 1  0  0      0  44596   1056  35344   0   0  1056     0  127    43   3   4  93
 1  0  0      0   2584   1232  73372   0   0  9009     0  208   148  27  28  45
Killed

As it can be seen, it ooms before even attempting to swap.

root@master:/usr/ads/apoteca# free
             total       used       free     shared    buffers     cached
Mem:         94112      91276       2836          0        144      79020
-/+ buffers/cache:      12112      82000
Swap:       666648       3924     662724

root@master:/usr/ads/apoteca# dmesg
Linux version 2.4.10 (root@master) (gcc version 2.95.3 20010315 (release)) #1 Mon Oct 8 20:11:47 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linuxabi-2.4.10 ro root=302
Initializing CPU#0
Detected 232.966 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 465.30 BogoMIPS
Memory: 93892k/98304k available (1515k kernel code, 4024k reserved, 444k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008001bf 008005bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 008005bf 00000000 00000000
CPU:     After generic, caps: 008001bf 008005bf 00000000 00000000
CPU:             Common caps: 008001bf 008005bf 00000000 00000000
CPU: AMD-K6tm w/ multimedia extensions stepping 02
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfdba1, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
  got res[1000:101f] for resource 4 of Intel Corporation 82371AB PIIX4 USB
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.116 (20010919) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL CR13.0A, ATA DISK drive
hdc: WDC WD200BB-00AUA1, ATA DISK drive
hdd: CRD-8160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=1582/255/63, UDMA(33)
hdc: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(33)
hdd: ATAPI 16X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<7>LDM:  DEBUG (ldm.c, 877): validate_partition_table: Found basic MS-DOS pa
rtition, not a dynamic disk.
 p1 p2 p3 p4
 /dev/ide/host0/bus1/target0/lun0:<7>LDM:  DEBUG (ldm.c, 877): validate_partition_table: Found basic MS-DOS pa
rtition, not a dynamic disk.
 [PTBL] [2434/255/63] p1 p2 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
loop: loaded (max 8 devices)
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   344.400 MB/sec
   32regs    :   250.000 MB/sec
   pII_mmx   :   392.400 MB/sec
   p5_mmx    :   385.600 MB/sec
raid5: using function: pII_mmx (392.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 136512k swap-space (priority -1)
Adding Swap: 530136k swap-space (priority -2)
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
CSLIP: code copyright 1989 Regents of the University of California
SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256).
SLIP linefill/keepalive option.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
8139too Fast Ethernet driver 0.9.18a
eth0: RealTek RTL8139 Fast Ethernet at 0xc6886800, 00:60:52:09:4a:15, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139A'
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
[bcheck:212]: set personality to 7000003
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process bcheck
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process bash
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process bash
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process httpd
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process vmstat
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process syslogd
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012845e
VM: killing process sendmail

regards,

Dr. Eng. Mauro Tassinari
Computer Management Associates


