Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTETPs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTETPs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:48:57 -0400
Received: from fepz.post.tele.dk ([195.41.46.133]:58044 "EHLO
	fepZ.post.tele.dk") by vger.kernel.org with ESMTP id S263771AbTETPsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:48:52 -0400
To: Linux kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: "Speed warnings UDMA 3/4/5 is not functional" with SiI3112 and
 2.4.21-rc2-ac1
From: jeSPer Holm <jesper@zoonet.dk>
Date: Tue, 20 May 2003 18:04:39 +0200
Message-ID: <878yt11u5k.fsf@zoonet.dk>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi,

I'm trying to get my SATA harddrive running in UDMA 6 mode but I
cannot get it to anything faster than UDMA 2. So the question is: Is
it possible to get the my system running in UMDA 6, if yes, how? 
Firstly, some basic system configuration information (details below):

Motherboard: ASUS, A7N8X DeLuxe, Sil-3112A
Harddrive: Seagate Barracuda 80GB, SATA150 (connected with SATA)

Linux 2.4.21-rc2-ac1

AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller on pci00:09.0
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA at 0xf880d000-0xf880d007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf880d008-0xf880d00f, BIOS settings: hdg:pio, hdh:pio



At first I couldn't get it running in UDMA at all, but then I found
this [1] tip, which got me going at UDMA 2:

---
echo max_kb_per_request:15 > /proc/ide/hde/settings
hdparm -X66 /dev/hde 
hdparm -d1 /dev/hde

hdparm -i /dev/hde
 
/dev/hde:
 
 Model=ST380013AS, FwRev=3.05, SerialNo=3JV1SG6S
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6
---


If I try to set anything higher than 66 I'll get: "Speed warnings UDMA
3/4/5 is not functional":

---
hdparm -X67 /dev/hde
 
/dev/hde:
 setting xfermode to 67 (UltraDMA mode3)
 HDIO_DRIVE_CMD(setxfermode) failed: Input/output error

dmesg
hde: Speed warnings UDMA 3/4/5 is not functional.
---


However, my hardware should support udma6:

---
hdparm -I /dev/hde

dev/hde:
 
ATA device, with non-removable media
        Model Number:       ST380013AS
        Serial Number:      3JV1SG6S
        Firmware Revision:  3.05
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2
        Supported: 6 5 4 3
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  156301488
        LBA48  user addressable sectors:  156301488
        device size with M = 1024*1024:       76319 MBytes
        device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
---


Full dmesg output:
---
Linux version 2.4.21-rc2-ac1 (root@valfred) (gcc version 3.2.3) #1 man maj 19 18:30:33 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=2102
Initializing CPU#0
Detected 1830.024 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3643.80 BogoMIPS
Memory: 905128k/917504k available (1277k kernel code, 11988k reserved, 306k data, 276k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/01e0] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:01.0: 3Com PCI 3c905C Tornado 2 at 0xc000. Vers LK1.1.18-ac
 00:26:54:08:9d:1a, IRQ 5
  product code ffff rev 00.0 date 15-31-127
  Internal config register is 1600000, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 2, status 786d.
  Enabling bus-master transmits and whole-frame receives.
02:01.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA at 0xf880d000-0xf880d007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf880d008-0xf880d00f, BIOS settings: hdg:pio, hdh:pio
hde: ST380013AS, ATA DISK drive
hdg: no response (status = 0xfe)
ide2 at 0xf880d080-0xf880d087,0xf880d08a on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63
ide-floppy driver 0.99.newide
Partition check:
 hde: hde1 hde2 hde3
ide-floppy driver 0.99.newide
Guestimating sector 156280064 for superblock
driver for Silicon Image(tm) Medley(tm) hardware version 0.0.1: No raid array found
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 930C
lp0: using parport0 (polling).
lp0: console ready
blk: queue c02fc3f8, I/O limit 4095Mb (mask 0xffffffff)
spurious 8259A interrupt: IRQ15.
spurious 8259A interrupt: IRQ7.
hde: Speed warnings UDMA 3/4/5 is not functional.
hde: Speed warnings UDMA 3/4/5 is not functional.
hde: Speed warnings UDMA 3/4/5 is not functional.
hde: Speed warnings UDMA 3/4/5 is not functional.
---


   Cheers, 


Footnotes: 
[1]  http://www.nforcershq.com/forum/viewtopic.php?t=15875&sid=02a0b2cfa1f0ce9775da9e280609fd1d

-- 
zoonet.dk                                                  jeSPer Holm
                                                      jesper@zoonet.dk
