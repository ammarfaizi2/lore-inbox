Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTAYL1C>; Sat, 25 Jan 2003 06:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTAYL1C>; Sat, 25 Jan 2003 06:27:02 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:54973 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S266286AbTAYL04>; Sat, 25 Jan 2003 06:26:56 -0500
Message-ID: <3E327699.5020104@bogonomicon.net>
Date: Sat, 25 Jan 2003 05:35:53 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PDC202XX DMA loss in 2.4.21-pre3-ac4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending this out now to see if others are noticing the same problem.

Under heavy disk IO I'm loosing DMA on a disk disk is being handled by 
the new PDC202XX driver.  The HD controller is a PDC20269 based 
controler like those in the Maxtor HD/Controller bundles.  Sofar it has 
lost DMA 4 times under heavy loads when multiple disks are being 
accessed at once.  It appears to lose DMA at a random point durring 
heavy disk IO.  It has gone hours before it happened to lasting less 
than 30 minutes.  I'm doing a test over night to see if it happens when 
it is the only disk being accessed heavily.  My first guess is it is 
dropping a DMA finish interrupt then failing when it tries to set one up 
again but I'm not sure on that.  The other idea I had is that when the 
code is trying to get a DMA channel all are in use and it fails.  Any 
help on what to look into would be appreciated.

Jan 24 22:41:14 blip kernel: hde: dma_intr: status=0xd0 { Busy }
Jan 24 22:41:14 blip kernel:
Jan 24 22:41:14 blip kernel: hde: DMA disabled
Jan 24 22:41:14 blip kernel: PDC202XX: Primary channel reset.
Jan 24 22:41:14 blip kernel: ide2: reset: success

The mother board is an ASUS A7N8X and it has assigned ide2, ide2 (both
controllers on the Promices card), the nVidia sound, and the display to
the same interrupt.  I've was trying to see if that was the problem but
dissabling other devices didn't seam to help.  It still happened.

The PDC20269 controller has one Maxtor 4G160J8 (160GB) disk per channel 
and each is jumpered to be master.  (hdparm -I ouputs below)  I've also 
added in the current dmesg output, and a cat of /proc/interrupts.

---------------------
# dmesg
Linux version 2.4.21-pre3-ac4 (root@blip) (gcc version 2.95.4 20011002 
(Debian prerelease)) #21 SMP Sun Jan 19 13:54:23 CST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 ide0=ata66 ide1=ata66
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Found and enabled local APIC!
Initializing CPU#0
Detected 1737.306 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515228k/524224k available (1600k kernel code, 8604k reserved, 
676k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU0: AMD Athlon(tm) XP 2100+ stepping 02
per-CPU timeslice cutoff: 731.30 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1737.2981 MHz.
..... host bus clock speed is 267.2766 MHz.
cpu: 0, clocks: 2672766, slice: 1336383
CPU0<T0:2672752,T1:1336368,D:1,S:1336383,C:2672766>
migration_task 0 on cpu=0
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unsupported bridge
agpgart: no supported devices found.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
PDC20269: IDE controller at PCI slot 01:07.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
hda: C/H/S=22070/16/255 from BIOS ignored
hda: Maxtor 54610H6, ATA DISK drive
hdb: CREATIVE DVD-ROM DVD1241E, ATAPI CD/DVD-ROM drive
blk: queue c03c0e40, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 54610H6, ATA DISK drive
blk: queue c03c12ac, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 4G160J8, ATA DISK drive
blk: queue c03c1718, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4G160J8, ATA DISK drive
blk: queue c03c1b84, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa000-0xa007,0xa402 on irq 10
ide3 at 0xa800-0xa807,0xac02 on irq 10
hda: host protected area => 1
hda: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hdc: host protected area => 1
hdc: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=89331/16/63, UDMA(100)
hde: host protected area => 1
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)
hdb: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
  hdc: hdc1 hdc2 hdc3 < hdc5 hdc6 hdc7 >
  hde: hde1 hde2
  hdg: hdg1 hdg2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 1999832k swap-space (priority -1)
Adding Swap: 1999832k swap-space (priority -2)
Adding Swap: 530104k swap-space (priority -3)
Adding Swap: 530104k swap-space (priority -4)
ide: no cache flush required.
ide: no cache flush required.
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
nvidia: loading NVIDIA Linux x86 NVdriver Kernel Module  1.0-3123  Tue 
Aug 27 15:56:48 PDT 2002
PCI: Setting latency timer of device 00:04.0 to 64
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
  [events: 00000022]
md: bind<hdc7,1>
  [events: 00000022]
md: bind<hda7,2>
md: hda7's event counter: 00000022
md: hdc7's event counter: 00000022
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device hda7 operational as mirror 0
raid1: device hdc7 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: hda7 [events: 00000023]<6>(write) hda7's sb offset: 28772736
md: hdc7 [events: 00000023]<6>(write) hdc7's sb offset: 28772736
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide3(34,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
spurious 8259A interrupt: IRQ7.
NVRM: AGPGART: unable to retrieve symbol table
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
---------------------------------
# hdparm -I /dev/hde

/dev/hde:
  readahead    =  8 (on)

non-removable ATA device, with non-removable media
         Model Number:           Maxtor 4G160J8
         Serial Number:          G807W03E
         Firmware Revision:      GAK819K0
Standards:
         Supported: 1 2 3 4 5 6
         Likely used: 6
Configuration:
         Logical         max     current
         cylinders       16383   65535
         heads           16      1
         sectors/track   63      63
         bytes/track:    0               (obsolete)
         bytes/sector:   0               (obsolete)
         current sector capacity: 4128705
         LBA user addressable sectors = 268435455
Capabilities:
         LBA, IORDY(can be disabled)
         Buffer size: 2048.0kB   ECC bytes: 57   Queue depth: 1
         Standby timer values: spec'd by standard, no device specific 
minimum
         r/w multiple sector transfer: Max = 16  Current = 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    look-ahead
            *    write cache
            *    Power Management feature set
                 SMART feature set
                 SET MAX security extension
                 Advanced Power Management feature set
            *    DOWNLOAD MICROCODE cmd
HW reset results:
         CBLID- above Vih
         Device num = 0 determined by the jumper
Checksum: correct
----------------------------
# hdparm -I /dev/hdg

/dev/hdg:

non-removable ATA device, with non-removable media
         Model Number:           Maxtor 4G160J8
         Serial Number:          G807L10E
         Firmware Revision:      GAK819K0
Standards:
         Supported: 1 2 3 4 5 6
         Likely used: 6
Configuration:
         Logical         max     current
         cylinders       16383   65535
         heads           16      1
         sectors/track   63      63
         bytes/track:    0               (obsolete)
         bytes/sector:   0               (obsolete)
         current sector capacity: 4128705
         LBA user addressable sectors = 268435455
Capabilities:
         LBA, IORDY(can be disabled)
         Buffer size: 2048.0kB   ECC bytes: 57   Queue depth: 1
         Standby timer values: spec'd by standard, no device specific 
minimum
         r/w multiple sector transfer: Max = 16  Current = 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    look-ahead
            *    write cache
            *    Power Management feature set
                 SMART feature set
                 SET MAX security extension
                 Advanced Power Management feature set
            *    DOWNLOAD MICROCODE cmd
HW reset results:
         CBLID- above Vih
         Device num = 0 determined by the jumper
Checksum: correct
------------------------
# cat /proc/interrupts
            CPU0
   0:     400911          XT-PIC  timer
   1:       9181          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:     244184          XT-PIC  eth0
   8:          3          XT-PIC  rtc
  10:    1665100          XT-PIC  ide2, ide3, nvidia
  12:     118311          XT-PIC  PS/2 Mouse
  14:      21064          XT-PIC  ide0
  15:       8894          XT-PIC  ide1
NMI:          0
LOC:     400875
ERR:        227
MIS:          0
--------------------------


- Bryan



