Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266168AbUAGJy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUAGJyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:54:20 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:32454 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S266164AbUAGJxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:53:35 -0500
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: raid0_make_request bug: can't convert block across chunks or bigger
 than
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 07 Jan 2004 10:53:30 +0100
Message-ID: <yw1xznd0ult1.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using Linux 2.6.0 on an Alpha SX164 machine.  Using four ATA
disks, hd[egik], on a Highpoint hpt374 controller, I created two raid0
arrays from hd[eg]1 and hd[ik]1, md0 and md1.  From these, I created a
raid1 mirror, md4, on which I created an XFS filesystem.  For various
reasons, I first ran md4 with only md0 as a member and filled it with
some files, all going well.  Then, I added md1, and it was synced
properly.  Now, I can mount md4 without problems.  However, when I
read things, I get this in the kernel log:

raid0_make_request bug: can't convert block across chunks or bigger than 32k 439200 32
raid1: Disk failure on md1, disabling device. 
	Operation continuing on 1 devices
raid1: md1: rescheduling sector 439200
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439264 24
raid1: md0: rescheduling sector 439264
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
 disk 1, wo:1, o:0, dev:md1
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
raid1: md0: redirecting sector 439200 to another mirror
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439200 32
raid1: md0: redirecting sector 439264 to another mirror
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439264 24

It's always md1 that fails this way.  Mounting md0 or md1 works fine.

I noticed that in raid0.c, just before the place it fails there is a
comment /* Sanity check -- queue functions should prevent this
happening */.  Apparently raid1 is misbehaving here.  Any quick fix?

FWIW, hdi is slightly different from the other disks, see the dmesg
output below.

Linux version 2.6.0 (mru@random) (gcc version 3.3 20030505 (prerelease)) #6 Mon Jan 5 21:09:11 CET 2004
Booting on EB164 variation SX164 using machine vector SX164 from SRM
Major Options: EV56 LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
Command line: root=/dev/hda1
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    98293
memcluster 2, usage 1, start    98293, end    98304
freeing pages 256:384
freeing pages 848:98293
reserving pages 848:850
pci: cia revision 1 (pyxis)
On node 0 totalpages: 98293
  DMA zone: 98293 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/hda1
PID hash table entries: 4096 (order 12: 65536 bytes)
Using epoch = 2000
Console: colour VGA+ 80x25
Memory: 772224k/786344k available (2543k kernel code, 11728k reserved, 522k data, 144k init)
Calibrating delay loop... 1059.80 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
pci: tbia workaround enabled
pci: enabling save/restore of SRM state
SMC37c669 Super I/O Controller found @ 0x3f0
SCSI subsystem initialized
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS for Linux with ACLs, large block/inode numbers, no debug enabled
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 0000:00:07.0
HPT374: chipset revision 7
HPT37X: using 33MHz PCI clock
HPT374: 100% native mode on irq 26
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0x8800-0x8807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8808-0x880f, BIOS settings: hdk:pio, hdl:pio
hde: ST3120022A, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0x8c10-0x8c17,0x8c32 on irq 26
hdg: ST3120022A, ATA DISK drive
ide3 at 0x8c18-0x8c1f,0x8c36 on irq 26
hdi: ST3120024A, ATA DISK drive
ide4 at 0x8c20-0x8c27,0x8c3a on irq 26
hdk: ST3120022A, ATA DISK drive
ide5 at 0x8c28-0x8c2f,0x8c3e on irq 26
CY82C693: IDE controller at PCI slot 0000:00:08.1
CY82C693: chipset revision 0
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
    ide0: BM-DMA at 0x8c00-0x8c07, BIOS settings: hda:DMA, hdb:DMA
PCI: Enabling device: (0000:00:08.2), cmd 7
    ide1: BM-DMA at 0x8c08-0x8c0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST38641A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hde: max request size: 1024KiB
hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: max request size: 1024KiB
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1 p2
hdi: max request size: 128KiB
hdi: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host4/bus0/target0/lun0: p1 p2
hdk: max request size: 1024KiB
hdk: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host4/bus1/target0/lun0: p1 p2
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/128KiB Cache, CHS=16383/16/63, (U)DMA
 /dev/ide/host0/bus0/target0/lun0: p1 p3
mice: PS/2 mouse device common for all mice
atkbd.c: keyboard reset failed on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Raw Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdk2 ...
md:  adding hdk2 ...
md: hdk1 has different UUID to hdk2
md:  adding hdi2 ...
md: hdi1 has different UUID to hdk2
md: hdg2 has different UUID to hdk2
md: hdg1 has different UUID to hdk2
md: hde2 has different UUID to hdk2
md: hde1 has different UUID to hdk2
md: created md3
md: bind<hdi2>
md: bind<hdk2>
md: running: <hdk2><hdi2>
md3: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdk2
raid0:   comparing hdk2(117081600) with hdk2(117081600)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdi2
raid0:   comparing hdi2(117081600) with hdk2(117081600)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 234163200 blocks.
raid0 : conf->hash_spacing is 234163200 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering hdk1 ...
md:  adding hdk1 ...
md:  adding hdi1 ...
md: hdg2 has different UUID to hdk1
md: hdg1 has different UUID to hdk1
md: hde2 has different UUID to hdk1
md: hde1 has different UUID to hdk1
md: created md1
md: bind<hdi1>
md: bind<hdk1>
md: running: <hdk1><hdi1>
md1: setting max_sectors to 64, segment boundary to 16383
raid0: looking at hdk1
raid0:   comparing hdk1(136448) with hdk1(136448)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdi1
raid0:   comparing hdi1(136448) with hdk1(136448)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 272896 blocks.
raid0 : conf->hash_spacing is 272896 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering hdg2 ...
md:  adding hdg2 ...
md: hdg1 has different UUID to hdg2
md:  adding hde2 ...
md: hde1 has different UUID to hdg2
md: created md2
md: bind<hde2>
md: bind<hdg2>
md: running: <hdg2><hde2>
md2: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hdg2
raid0:   comparing hdg2(117081600) with hdg2(117081600)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde2
raid0:   comparing hde2(117081600) with hdg2(117081600)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 234163200 blocks.
raid0 : conf->hash_spacing is 234163200 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdg1>
md: running: <hdg1><hde1>
md0: setting max_sectors to 64, segment boundary to 16383
raid0: looking at hdg1
raid0:   comparing hdg1(136448) with hdg1(136448)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(136448) with hdg1(136448)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 272896 blocks.
raid0 : conf->hash_spacing is 272896 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
EXT3 FS on hda1, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:09.2: EHCI Host Controller
ehci_hcd 0000:00:09.2: irq 32, pci mem fffffc8809063000
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
drivers/usb/core/usb.c: registered new driver usbnet
hub 1-0:1.0: new USB device on port 1, assigned address 2
hub 1-0:1.0: new USB device on port 2, assigned address 3
eth0: register usbnet at usb-0000:00:09.2-2, Netgear FA-120 USB Ethernet
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
md: md4 stopped.
md: bind<md1>
md: bind<md0>
raid1: raid set md4 active with 1 out of 2 mirrors
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
 disk 1, wo:1, o:1, dev:md1
md: syncing RAID array md4
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
md: using 256k window, over a total of 272832 blocks.
md: md4: sync done.
RAID1 conf printout:
 --- wd:2 rd:2
 disk 0, wo:0, o:1, dev:md0
 disk 1, wo:0, o:1, dev:md1
XFS mounting filesystem 
Ending clean XFS mount for filesystem: 
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439200 32
raid1: Disk failure on md1, disabling device. 
	Operation continuing on 1 devices
raid1: md1: rescheduling sector 439200
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439264 24
raid1: md0: rescheduling sector 439264
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
 disk 1, wo:1, o:0, dev:md1
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:0, o:1, dev:md0
raid1: md0: redirecting sector 439200 to another mirror
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439200 32
raid1: md0: redirecting sector 439264 to another mirror
raid0_make_request bug: can't convert block across chunks or bigger than 32k 439264 24


-- 
Måns Rullgård
mru@kth.se
