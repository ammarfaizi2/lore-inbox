Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSFWL0z>; Sun, 23 Jun 2002 07:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSFWL0y>; Sun, 23 Jun 2002 07:26:54 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:40206 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S317005AbSFWL0u>; Sun, 23 Jun 2002 07:26:50 -0400
Date: Sun, 23 Jun 2002 13:29:54 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.24: false(?) ide-errors during ext3-recovery
Message-ID: <Pine.LNX.4.21.0206230928330.2295-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

well, probably hard to reproduce, but IMHO worth to get reported anyway:

1) box locked up hard with 2.5.24 under moderate disk activity (untar some
larger bz2-archive) - no oops or something, no SysRq, no cursor, just
nothing but big-red-button-time. Might be the same thing which was already
reported about 2.5.24 ide dying.

2) during following reboot the ext3-recovery had problems with one
partition where several uncorrectable ide-errors (status=0x51,
error=0x40) were reported. Interesting (IMHO) observation is this was
every 8th sector i.e. every 4k=1block.

Result was mount reporting "wrong fs type, bad option, bad superblock on
/dev/hda6 or too many mounted file systems". However, dmesg shows a second
ext3-recovery initiated on hda6 later and the system came up with
/dev/hda6 mounted just fine - and everything is still working as usual
without any problem. Furthermore note that hda6 is my /usr which was
probably not written and thus in sync before the crash happened.

I've done some intensive testing like several "dd if=/dev/hda ..." both
in parallel and series which had absolutely no problem reading the whole
raw disk.

Well, the ide-error might have happened on disk-write, but the first error
	hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
	hda: ide_dma_intr: error=0x40 [ uncorrectable error] , 
		LBAsect=3080202, sector=3079959
	hda: max number of retries exceeded!
	end_request: I/O error, dev 03:00, sector 3079959
	Buffer I/O error on device ide0(3,6), logical block 939
	JBD: Failed to read block at offset 429
	JBD: recovery failed
	EXT3-fs: error loading journal.
suggests it couldn't read the journal - which contradicts with the fact I
can read the whole raw disk without error. So my impression is the
ide-errors must be either false or non-permanent. And the box is
rock-solid under 2.4 with all kinds of ide loads so I tend to rule out
trivial stuff like flaky device or controller or cabling issues. I've
also checked the logs back some days and there's no single other
ide-error there.

3) For a number of intentionally triggered further such ide-deadlocks all
ext3-recoveries succeeded without any ide-error.

System is 2.5.24 SMP on UP, with SiS 5513/5591 ide in ata33 mode, no tcq.
rootfs is ext2, all other fs are ext3 with data=ordered (default).

config and dmesg from unsuccessful recovery below.

Regards,
Martin

------------------------------------

#
# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC6280_BURST is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_IVB is not set
CONFIG_ATAPI=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

------------------------------

Linux version 2.5.24 (root@srv.diehl.home) (gcc version 2.96 20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #1 SMP Sat Jun 22 00:48:50 CEST 2002
Video mode to be used for restore is 314
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
192MB LOWMEM available.
On node 0 totalpages: 49152
zone(0): 4096 pages.
zone(1): 45056 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux2524 ro root=301 video=atyfb:1280x1024-8@76,font:SUN12x22 devfs=nomount textboot console=ttyS0,9600 console=tty0 3
No local APIC present or hardware disabled
Initializing CPU#0
Detected 299.999 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 598.01 BogoMIPS
Memory: 192228k/196608k available (1181k kernel code, 3992k reserved, 284k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 008001bf 808009bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 808009bf 00000000 00000000
CPU:     After generic, caps: 008001bf 808009bf 00000000 00000000
CPU:             Common caps: 008001bf 808009bf 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 008001bf 808009bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 808009bf 00000000 00000000
CPU:     After generic, caps: 008001bf 808009bf 00000000 00000000
CPU:             Common caps: 008001bf 808009bf 00000000 00000000
CPU0: AMD-K6(tm) 3D processor stepping 00
per-CPU timeslice cutoff: 182.85 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
migration_task 0 on cpu=0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf04c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.17 (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 8M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 106x46
fb0: ATY Mach64 frame buffer device on PCI
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Silicon Integrated Systems [SiS] 5513 [IDE], PCI slot 00:00.1
ATA: chipset rev.: 208
ATA: non-legacy mode: IRQ probe delayed
SiS5591
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 4K040H2, DISK drive
hdb: LTN403, ATAPI CD/DVD-ROM drive
hdc: IBM-DHEA-36480, DISK drive
hdd: CR-2801TE, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 66055248 sectors w/2000KiB Cache, CHS=65531/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
 hdc: 12692736 sectors w/476KiB Cache, CHS=12592/16/63, UDMA(33)
 /dev/ide/host1/bus1/target0/lun0: [PTBL] [790/255/63] p1 p2 < p5 p6 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Real Time Clock Driver v1.11
Adding 512056k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3079959
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3079959
Buffer I/O error on device ide0(3,6), logical block 939
JBD: Failed to read block at offset 429
JBD: recovery failed
EXT3-fs: error loading journal.
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3079967
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3079967
Buffer I/O error on device ide0(3,6), logical block 940
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3079975
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3079975
Buffer I/O error on device ide0(3,6), logical block 941
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3079983
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3079983
Buffer I/O error on device ide0(3,6), logical block 942
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3079991
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3079991
Buffer I/O error on device ide0(3,6), logical block 943
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3079999
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3079999
Buffer I/O error on device ide0(3,6), logical block 944
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080007
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080007
Buffer I/O error on device ide0(3,6), logical block 945
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080015
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080015
Buffer I/O error on device ide0(3,6), logical block 946
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080023
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080023
Buffer I/O error on device ide0(3,6), logical block 947
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080031
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080031
Buffer I/O error on device ide0(3,6), logical block 948
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080039
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080039
Buffer I/O error on device ide0(3,6), logical block 949
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080047
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080047
Buffer I/O error on device ide0(3,6), logical block 950
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080055
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080055
Buffer I/O error on device ide0(3,6), logical block 951
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080063
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080063
Buffer I/O error on device ide0(3,6), logical block 952
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080071
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080071
Buffer I/O error on device ide0(3,6), logical block 953
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080079
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080079
Buffer I/O error on device ide0(3,6), logical block 954
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080087
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080087
Buffer I/O error on device ide0(3,6), logical block 955
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080095
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080095
Buffer I/O error on device ide0(3,6), logical block 956
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080103
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080103
Buffer I/O error on device ide0(3,6), logical block 957
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080111
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080111
Buffer I/O error on device ide0(3,6), logical block 958
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080119
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080119
Buffer I/O error on device ide0(3,6), logical block 959
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080127
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080127
Buffer I/O error on device ide0(3,6), logical block 960
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080135
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080135
Buffer I/O error on device ide0(3,6), logical block 961
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080143
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080143
Buffer I/O error on device ide0(3,6), logical block 962
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080151
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080151
Buffer I/O error on device ide0(3,6), logical block 963
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080159
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080159
Buffer I/O error on device ide0(3,6), logical block 964
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080167
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080167
Buffer I/O error on device ide0(3,6), logical block 965
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080175
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080175
Buffer I/O error on device ide0(3,6), logical block 966
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080183
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080183
Buffer I/O error on device ide0(3,6), logical block 967
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080191
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080191
Buffer I/O error on device ide0(3,6), logical block 968
hda: ide_dma_intr: status=0x51 [ drive ready,seek complete,error] 
hda: ide_dma_intr: error=0x40 [ uncorrectable error] , LBAsect=3080202, sector=3080199
hda: max number of retries exceeded!
end_request: I/O error, dev 03:00, sector 3080199
Buffer I/O error on device ide0(3,6), logical block 969
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 11 for device 00:0c.0
eth0: RealTek RTL-8029 found at 0xa800, IRQ 11, 00:00:B4:5E:66:7E.
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:01.2
hcd-pci.c: ohci-hcd @ 00:01.2, Silicon Integrated Systems [SiS] 7001
hcd-pci.c: irq 11, pci mem cd068000
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
usb.c: registered new driver usblp
printer.c: v0.12: USB Printer Device Class driver
hub.c: new USB device 00:01.2-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x9c4/0x11) is not claimed by any active driver.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x278 [PCSPP(,...)]
lp0: using parport0 (polling).

