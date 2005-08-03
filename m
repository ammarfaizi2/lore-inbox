Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVHCMR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVHCMR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVHCMP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:15:58 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:16457 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262220AbVHCMOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:14:15 -0400
Subject: Segfaults in mkdir under high load. Software or hardware?
From: Jules Colding <colding@omesc.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 14:14:03 +0200
Message-Id: <1123071243.6758.18.camel@omc-2.omesc.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing segfaults in mkdir, and mkdir alone, under high load.
I have tried to eliminate the RAM by letting memtest86plus run overnight
(no errors found). dmesg does report other filesystem related segfaults
and some others that I am not so sure of.

I am not really qualified to guess whether this is software or hardware
so please see this mail as information for those more qualified. Info
below.

Regards,
  jules


##### Hardware #####
Dual AMD Opteron 252.
8x1GB ECC RAM (CMX1024RE-3200-Black).
LSI Logic MegaRAID SCSI 320-4X.
4 Seagate Cheetah 73.4 GB 15KRPM Ultra 320 68pin SCSI in raid5 (ST373453LW).
Tyan Thunder K8W S2885.
Kernel gentoo-sources 2.6.12-r6.
Most filesystems mounted as reiserfs with noatime and notail.

##### Output of script #####
./memtest.sh: line 107: 19536 Segmentation fault      mkdir $j
./memtest.sh: line 107: 19553 Segmentation fault      mkdir $j
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!
Inconsistency detected by ld.so: dynamic-link.h: 151: elf_get_dynamic_info: Assertion `info[20]->d_un.d_val == 7' failed!


##### /var/log/messages #####
Aug  2 10:43:33 omc-2 [393507.742750] mkdir[19536]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffffe2c4b0 error 4
Aug  2 10:43:33 omc-2 [393507.818660] mkdir[19553]: segfault at 0000000000000000 rip 000000000040184d rsp 00007ffffffdb2e0 error 4

##### The script #####
#!/bin/bash
#
# memtest.sh
#
# Shell script to help isolate memory failures under linux
#
# Author: Doug Ledford  + contributors
#
# (C) Copyright 2000-2002 Doug Ledford; Red Hat, Inc.
# This shell script is released under the terms of the GNU General
# Public License Version 2, June 1991.  If you do not have a copy
# of the GNU General Public License Version 2, then one may be
# retrieved from http://people.redhat.com/dledford/GPL.html
#
# Note, this needs bash2 for the wait command support.

# This is where we will run the tests at
TEST_DIR=/home/colding/tmp

# The location of the linux kernel source file we will be using
if [ -z "$SOURCE_FILE" ]; then
  SOURCE_FILE=$TEST_DIR/linux.tar.gz
fi

if [ ! -f "$SOURCE_FILE" ]; then
  echo "Missing source file $SOURCE_FILE"
  exit 1
fi

# How many passes to run of this test, higher numbers are better
if [ -z "$NR_PASSES" ]; then
  NR_PASSES=20
fi

# Guess how many megs the unpacked archive is
if [ -z "$MEG_PER_COPY" ]; then
  MEG_PER_COPY=$(ls -l $SOURCE_FILE | awk '{print int($5/1024/1024) * 4}')
fi

# How many trees do we have to unpack in order to make our trees be larger
# than physical RAM?  If we don't unpack more data than memory can hold
# before we start to run the diff program on the trees then we won't
# actually flush the data to disk and force the system to reread the data
# from disk.  Instead, the system will do everything in RAM.  That doesn't
# work (as far as the memory test is concerned).  It's the simultaneous
# unpacking of data in memory and the read/writes to hard disk via DMA that
# breaks the memory subsystem in most cases.  Doing everything in RAM without
# causing disk I/O will pass bad memory far more often than when you add
# in the disk I/O.
if [ -z "$NR_SIMULTANEOUS" ]; then
  NR_SIMULTANEOUS=$(free | awk -v meg_per_copy=$MEG_PER_COPY 'NR == 2 {print int($2*1.5/1024/meg_per_copy + (($2/1024)%meg_per_copy >= (meg_per_copy/2)) + (($2/1024/32) < 1))}')
fi

# Should we unpack/diff the $NR_SIMULTANEOUS trees in series or in parallel?
if [ ! -z "$PARALLEL" ]; then
  PARALLEL="yes"
else
  PARALLEL="no"
fi
PARALLEL="yes"

if [ ! -z "$JUST_INFO" ]; then
  echo "TEST_DIR:		$TEST_DIR"
  echo "SOURCE_FILE:		$SOURCE_FILE"
  echo "NR_PASSES:		$NR_PASSES"
  echo "MEG_PER_COPY:		$MEG_PER_COPY"
  echo "NR_SIMULTANEOUS:	$NR_SIMULTANEOUS"
  echo "PARALLEL:		$PARALLEL"
  echo
  exit
fi

cd $TEST_DIR

# Remove any possible left over directories from a cancelled previous run
rm -fr linux linux.orig linux.pass.*

# Unpack the one copy of the source tree that we will be comparing against
tar -xzf $SOURCE_FILE
mv linux linux.orig

i=0
while [ "$i" -lt "$NR_PASSES" ]; do
  j=0
  while [ "$j" -lt "$NR_SIMULTANEOUS" ]; do
    if [ $PARALLEL = "yes" ]; then
      (mkdir $j; tar -xzf $SOURCE_FILE -C $j; mv $j/linux linux.pass.$j; rmdir $j) &
    else
      tar -xzf $SOURCE_FILE
      mv linux linux.pass.$j
    fi
    j=`expr $j + 1`
  done
  wait
  j=0
  while [ "$j" -lt "$NR_SIMULTANEOUS" ]; do
    if [ $PARALLEL = "yes" ]; then
      (diff -U 3 -rN linux.orig linux.pass.$j; rm -fr linux.pass.$j) &
    else
      diff -U 3 -rN linux.orig linux.pass.$j
      rm -fr linux.pass.$j
    fi
    j=`expr $j + 1`
  done
  wait
  i=`expr $i + 1`
done

# Clean up after ourselves
rm -fr linux linux.orig linux.pass.*


##### dmesg #####

[    0.000000] Bootdata ok (command line is root=/dev/sda4 vga=0x31B video=vesafb:mtrr,ywrap)
[    0.000000] Linux version 2.6.12-gentoo-r6 (root@omc-2) (gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #6 SMP Mon Jul 25 13:50:58 CEST 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000ca000000 (usable)
[    0.000000]  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] Number of nodes 2
[    0.000000] Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
[    0.000000] Node 1 MemBase 0000000100000000 Limit 00000001ffffffff
[    0.000000] node 1 shift 24 addr 100000000 conflict 0
[    0.000000] node 1 shift 25 addr 1fe000000 conflict 0
[    0.000000] Using node hash shift of 26
[    0.000000] Bootmem setup node 0 0000000000000000-00000000ffffffff
[    0.000000] Bootmem setup node 1 0000000100000000-00000001ffffffff
[    0.000000] On node 0 totalpages: 1048575
[    0.000000]   DMA zone: 4096 pages, LIFO batch:1
[    0.000000]   Normal zone: 1044479 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] On node 1 totalpages: 1048575
[    0.000000]   DMA zone: 0 pages, LIFO batch:1
[    0.000000]   Normal zone: 1048575 pages, LIFO batch:31
[    0.000000]   HighMem zone: 0 pages, LIFO batch:1
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] OEM ID: TYAN     <6>Product ID: RHAPSODY     <6>APIC at: 0xFEE00000
[    0.000000] Processor #0 15:5 APIC version 16
[    0.000000] Processor #1 15:5 APIC version 16
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] I/O APIC #3 Version 17 at 0xFA9FE000.
[    0.000000] I/O APIC #4 Version 17 at 0xFA9FF000.
[    0.000000] Setting APIC routing to flat
[    0.000000] Processors: 2
[    0.000000] Allocating PCI resources starting at ca000000 (gap: ca000000:35780000)
[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ f0000000 size 128 MB
[    0.000000] CPU 1: aperture @ f0000000 size 128 MB
[    0.000000] Built 2 zonelists
[    0.000000] Kernel command line: root=/dev/sda4 vga=0x31B video=vesafb:mtrr,ywrap
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 1.193182 MHz PIT timer.
[    0.000000] time.c: Detected 2589.930 MHz processor.
[   87.532329] Console: colour dummy device 80x25
[   87.542714] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[   87.559298] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[   87.773569] Memory: 7358640k/8388608k available (2819k kernel code, 0k reserved, 984k data, 192k init)
[   87.773630] Calibrating delay loop... 5095.42 BogoMIPS (lpj=2547712)
[   87.796029] Mount-cache hash table entries: 256
[   87.796099] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   87.796103] CPU: L2 Cache: 1024K (64 bytes/line)
[   87.796353] Using IO-APIC 2
[   87.796359] Using IO-APIC 3
[   87.796363] Using IO-APIC 4
[   87.806615] Using local APIC timer interrupts.
[   87.845192] Detected 12.451 MHz APIC timer.
[   87.845265] Booting processor 1/1 rip 6000 rsp ffff81010506ff58
[   87.855369] Initializing CPU#1
[   87.856480] Calibrating delay loop... 4702.20 BogoMIPS (lpj=2351104)
[   87.878811] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   87.878812] CPU: L2 Cache: 1024K (64 bytes/line)
[   87.878818] AMD Opteron(tm) Processor 252 stepping 01
[   87.878820] CPU 1: Syncing TSC to CPU 0.
[   87.879000] CPU 1: synchronized TSC with CPU 0 (last diff -12 cycles, maxerr 1265 cycles)
[   87.879011] Brought up 2 CPUs
[   87.879080] time.c: Using PIT/TSC based timekeeping.
[   87.879082] testing NMI watchdog ... OK.
[   87.888913] CPU0 attaching sched-domain:
[   87.888915]  domain 0: span 1
[   87.888917]   groups: 1
[   87.888919]   domain 1: span 3
[   87.888921]    groups: 1 2
[   87.888923] CPU1 attaching sched-domain:
[   87.888924]  domain 0: span 2
[   87.888926]   groups: 2
[   87.888927]   domain 1: span 3
[   87.888929]    groups: 2 1
[   87.889190] NET: Registered protocol family 16
[   87.889532] PCI: Using configuration type 1
[   87.889535] mtrr: v2.0 (20020519)
[   87.890122] SCSI subsystem initialized
[   87.890154] usbcore: registered new driver usbfs
[   87.890168] usbcore: registered new driver hub
[   87.890208] PCI: Probing PCI hardware
[   87.890211] PCI: Probing PCI hardware (bus 00)
[   87.891718] Boot video device is 0000:06:00.0
[   87.891753] PCI: Discovered primary peer bus 06 [IRQ]
[   87.891758] PCI: Using IRQ router default [1022/746b] at 0000:00:07.3
[   87.891768] PCI->APIC IRQ transform: 0000:00:07.2[D] -> IRQ 161
[   87.891777] PCI->APIC IRQ transform: 0000:04:00.0[D] -> IRQ 161
[   87.891781] PCI->APIC IRQ transform: 0000:04:00.1[D] -> IRQ 161
[   87.891785] PCI->APIC IRQ transform: 0000:04:0a.0[A] -> IRQ 145
[   87.891790] PCI->APIC IRQ transform: 0000:04:0a.2[B] -> IRQ 153
[   87.891794] PCI->APIC IRQ transform: 0000:03:09.0[A] -> IRQ 169
[   87.891798] PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 177
[   87.891801] PCI->APIC IRQ transform: 0000:06:00.0[A] -> IRQ 145
[   87.891868] PCI-DMA: Disabling AGP.
[   87.891920] PCI-DMA: aperture base @ f0000000 size 131072 KB
[   87.891926] PCI-DMA: Reserving 128MB of IOMMU area in the AGP aperture
[   87.892229] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
[   87.892627] Total HugeTLB memory allocated, 0
[   87.892702] inotify device minor=63
[   87.892824] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   87.892971] Initializing Cryptographic API
[   87.892977] PCI: MSI quirk detected. pci_msi_quirk set.
[   87.892981] PCI: MSI quirk detected. pci_msi_quirk set.
[   87.903086] Real Time Clock Driver v1.12
[   87.903090] Linux agpgart interface v0.101 (c) Dave Jones
[   87.903162] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc20000000000, using 10240k, total 262144k
[   87.903167] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[   87.903169] vesafb: scrolling: redraw
[   87.903172] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   87.979582] Console: switching to colour frame buffer device 160x64
[   87.979863] fb0: VESA VGA frame buffer device
[   87.981539] serio: i8042 AUX port at 0x60,0x64 irq 12
[   87.981814] serio: i8042 KBD port at 0x60,0x64 irq 1
[   87.982068] mice: PS/2 mouse device common for all mice
[   87.982293] io scheduler noop registered
[   87.982502] io scheduler cfq registered
[   87.982739] Floppy drive(s): fd0 is 1.44M
[   87.997968] FDC 0 is a post-1991 82077
[   87.999463] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   88.000138] loop: loaded (max 8 devices)
[   88.000330] pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
[   88.000701] tg3.c:v3.31 (June 8, 2005)
[   88.005191] eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:2f:8a:1c
[   88.005772] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[   88.006130] eth0: dma_rwctrl[769f4000]
[   88.006321] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   88.006595] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   88.006962] AMD8111: IDE controller at PCI slot 0000:00:07.1
[   88.007213] AMD8111: chipset revision 3
[   88.007378] AMD8111: not 100% native mode: will probe irqs later
[   88.007641] AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
[   88.007901]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
[   88.008237] Probing IDE interface ide0...
[   88.168824] input: AT Translated Set 2 keyboard on isa0060/serio0
[   88.271883] hda: Maxtor 6Y120P0, ATA DISK drive
[   88.679475] hdb: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM drive
[   88.730843] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   88.731133] Probing IDE interface ide1...
[   89.243800] Probing IDE interface ide2...
[   89.756289] Probing IDE interface ide3...
[   90.268778] Probing IDE interface ide4...
[   90.781266] Probing IDE interface ide5...
[   91.293784] hda: max request size: 128KiB
[   91.294528] hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
[   91.295084] hda: cache flushes supported
[   91.295297]  hda: hda1
[   91.303909] hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   91.304320] Uniform CD-ROM driver Revision: 3.20
[   91.306066] megaraid: found 0x1000:0x0407:bus 2:slot 0:func 0
[   91.306363] scsi0:Found MegaRAID controller at 0xffffc20000a02000, IRQ:177
[   91.306891] megaraid: [413B:H409] detected 1 logical drives.
[   91.307159] megaraid: supports extended CDBs.
[   91.307390] megaraid: channel[0] is raid.
[   91.307563] megaraid: channel[1] is raid.
[   91.307736] megaraid: channel[2] is raid.
[   91.320007] megaraid: channel[3] is raid.
[   91.332577] scsi0 : LSI Logic MegaRAID 413B 254 commands 16 targs 7 chans 7 luns
[   91.345050] scsi0: scanning scsi channel 0 for logical drives.
[   91.357860]   Vendor: MegaRAID  Model: LD 0 RAID5  210G  Rev: 413B
[   91.370977]   Type:   Direct-Access                      ANSI SCSI revision: 02
[   91.385054] scsi0: scanning scsi channel 1 for logical drives.
[   91.399007] scsi0: scanning scsi channel 2 for logical drives.
[   91.412727] scsi0: scanning scsi channel 4 [P0] for physical devices.
[   94.176479] scsi0: scanning scsi channel 5 [P1] for physical devices.
[   97.937312] scsi0: scanning scsi channel 6 [P2] for physical devices.
[  101.698165] scsi0: scanning scsi channel 7 [P3] for physical devices.
[  105.458735] SCSI device sda: 430098432 512-byte hdwr sectors (220210 MB)
[  105.471197] sda: asking for cache data failed
[  105.483671] sda: assuming drive cache: write through
[  105.496195] SCSI device sda: 430098432 512-byte hdwr sectors (220210 MB)
[  105.508990] sda: asking for cache data failed
[  105.521781] sda: assuming drive cache: write through
[  105.534350]  sda: sda1 sda2 sda3 sda4
[  105.547216] Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
[  105.559799] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[  105.559837] ohci_hcd 0000:04:00.0: OHCI Host Controller
[  105.595186] ohci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 1
[  105.607663] ohci_hcd 0000:04:00.0: irq 161, io mem 0xfa8fc000
[  105.672988] hub 1-0:1.0: USB hub found
[  105.685460] hub 1-0:1.0: 3 ports detected
[  105.700063] ohci_hcd 0000:04:00.1: OHCI Host Controller
[  105.736033] ohci_hcd 0000:04:00.1: new USB bus registered, assigned bus number 2
[  105.748376] ohci_hcd 0000:04:00.1: irq 161, io mem 0xfa8fd000
[  105.813812] hub 2-0:1.0: USB hub found
[  105.826272] hub 2-0:1.0: 3 ports detected
[  105.840912] Initializing USB Mass Storage driver...
[  106.018065] usb 2-1: new low speed USB device using ohci_hcd and address 2
[  106.145612] usbcore: registered new driver usb-storage
[  106.158245] USB Mass Storage support registered.
[  106.185577] input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:04:00.1-1
[  106.198264] usbcore: registered new driver usbhid
[  106.210804] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[  106.223392] Creative EMU10K1 PCI Audio Driver, version 0.20a, 13:50:00 Jul 25 2005
[  106.235969] emu10k1: Audigy rev 4 model 0x2002 found, IO at 0xb800-0xb83f, IRQ 145
[  106.248498] ac97_codec: AC97 Audio codec, id: 0x6a90:0x7650 (Unknown)
[  106.272526] oprofile: using NMI interrupt.
[  106.284713] NET: Registered protocol family 2
[  106.306477] IP: routing cache hash table of 32768 buckets, 512Kbytes
[  106.318852] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[  106.333624] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[  106.346369] TCP: Hash tables configured (established 262144 bind 65536)
[  106.358848] NET: Registered protocol family 1
[  106.371051] NET: Registered protocol family 17
[  106.383024] NET: Registered protocol family 15
[  106.408804] ReiserFS: sda4: found reiserfs format "3.6" with standard journal
[  106.420823] cfq: depth 4 reached, tagging now on
[  108.770115] ReiserFS: sda4: using ordered data mode
[  108.790428] ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  108.816390] ReiserFS: sda4: checking transaction log (sda4)
[  108.872104] ReiserFS: sda4: Using r5 hash to sort names
[  108.884448] VFS: Mounted root (reiserfs filesystem) readonly.
[  108.896974] Freeing unused kernel memory: 192k freed
[  110.197038] Adding 1004052k swap on /dev/sda3.  Priority:-1 extents:1
[  113.054563] nvidia: module license 'NVIDIA' taints kernel.
[  113.057702] NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 11:43:48 PST 2004
[  113.685728] kjournald starting.  Commit interval 5 seconds
[  113.688940] EXT3 FS on sda1, internal journal
[  113.688949] EXT3-fs: mounted filesystem with ordered data mode.
[  113.694833] ReiserFS: sda2: found reiserfs format "3.6" with standard journal
[  113.804978] ReiserFS: sda2: using ordered data mode
[  113.808454] ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  113.809262] ReiserFS: sda2: checking transaction log (sda2)
[  113.823223] ReiserFS: sda2: Using r5 hash to sort names
[  120.287606] tg3: eth0: Link is up at 1000 Mbps, full duplex.
[  120.287611] tg3: eth0: Flow control is on for TX and on for RX.
[  127.676386] /dev/vmmon[7044]: Module vmmon: registered with major=10 minor=165
[  127.676393] /dev/vmmon[7044]: Module vmmon: initialized
[  127.803327] /dev/vmnet: open called by PID 7099 (vmnet-bridge)
[  127.803337] /dev/vmnet: hub 0 does not exist, allocating memory.
[  127.803352] /dev/vmnet: port on hub 0 successfully opened
[  127.803363] bridge-eth0: enabling the bridge
[  127.803367] bridge-eth0: up
[  127.803369] bridge-eth0: already up
[  127.803371] bridge-eth0: attached
[  129.359053] NVRM: not using NVAGP, kernel was compiled with GART_IOMMU support!
[  129.941161] NVRM: not using NVAGP, kernel was compiled with GART_IOMMU support!
[225323.609396] atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
[284685.024408] ATAPI device hdb:
[284685.024414]   Unknown Error Type: No sense data -- (Sense key=0x00)
[284685.024418]   No additional sense information -- (asc=0x00, ascq=0x00)
[284685.024421]   The failed "Test Unit Ready" packet command was: 
[284685.024422]   "00 81 ff ff b0 8d 17 80 ff ff ff ff 04 00 00 00 "
[308631.832310] cat[19616] general protection rip:2aaaaaaac274 rsp:7ffffffbdee0 error:0
[308873.156860] chmod[12380] general protection rip:404207 rsp:7fffffb05ac0 error:0
[309003.588382] sed[5664] general protection rip:40870a rsp:7fffffb17f60 error:0
[309421.205860] sed[7699] general protection rip:40870a rsp:7fffffb18f50 error:0
[309490.580696] pwd[16033]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffeac870 error 4
[309490.589110] pwd[16036]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007ffffff74890 error 4
[309528.146609] sed[20915] general protection rip:40870a rsp:7ffffff18ec0 error:0
[310001.001223] pwd[23379]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffff931710 error 4
[310001.738485] pwd[23477]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffff848950 error 4
[310001.845031] pwd[23498]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffb3f5a0 error 4
[310001.860687] pwd[23502]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffb4a240 error 4
[310001.913105] pwd[23511]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffbf7360 error 4
[310356.530988] sed[13525] general protection rip:40870a rsp:7fffffb17f90 error:0
[310368.857555] sed[15750] general protection rip:40870a rsp:7fffffb198c0 error:0
[311225.640566] pwd[7030]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffa64880 error 4
[311225.654714] pwd[7032]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffaf3b50 error 4
[311225.709145] pwd[7042]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffff9b8110 error 4
[311333.330108] pwd[13807]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffdb6330 error 4
[315194.008029] pwd[6498]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffff98c9e0 error 4
[315451.698188] pwd[9078]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffff89ba40 error 4
[315451.712617] pwd[9082]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffdd3840 error 4
[316683.957938] pwd[5545]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffc4bfd0 error 4
[317584.234574] pwd[31849]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffff8abab0 error 4
[317584.243981] pwd[31860]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffa1e8e0 error 4
[317643.781223] pwd[8047]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffa61030 error 4
[318466.995903] pwd[17114]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffb5b3e0 error 4
[319219.800230] pwd[27897]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffed9020 error 4
[322011.169739] pwd[15704]: segfault at 0000000000000008 rip 00002aaaaaab345d rsp 00007fffffab9ae0 error 4
[322050.077224] mkdir[22064]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffffaff4d0 error 4
[324311.265283] end_request: I/O error, dev fd0, sector 0
[393507.742750] mkdir[19536]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffffe2c4b0 error 4
[393507.818660] mkdir[19553]: segfault at 0000000000000000 rip 000000000040184d rsp 00007ffffffdb2e0 error 4
[398294.139465] mkdir[20557]: segfault at 0000000000000000 rip 000000000040184d rsp 00007ffffffc0a50 error 4
[405679.843140] /dev/vmnet: open called by PID 17120 (vmware-vmx)
[405679.843167] device eth0 entered promiscuous mode
[405679.843169] bridge-eth0: enabled promiscuous mode
[405679.843171] /dev/vmnet: port on hub 0 successfully opened
[405679.882843] /dev/vmmon[17128]: host clock rate change request 0 -> 19
[405679.883047] /dev/vmmon[17128]: host clock rate change request 19 -> 83
[405689.908382] /dev/vmmon[17128]: host clock rate change request 83 -> 19
[405695.595691] /dev/vmmon[17128]: host clock rate change request 19 -> 83
[405788.932681] ioctl32(vmware-vmx:17151): Unknown cmd fd(138) cmd(40109980){00} arg(ffff7250) on /proc/bus/usb/002/001
[405788.999166] /dev/vmnet: open called by PID 17151 (vmware-vmx)
[405788.999181] /dev/vmnet: port on hub 0 successfully opened
[405803.785276] /dev/vmnet: open called by PID 17159 (vmware-vmx)
[405803.785287] /dev/vmnet: port on hub 0 successfully opened
[407902.283414] /dev/vmnet: open called by PID 17159 (vmware-vmx)
[407902.283425] /dev/vmnet: port on hub 0 successfully opened
[407902.722532] vmmon: Had to deallocate locked 238838 pages from vm driver ffff81017000c000
[407902.736282] vmmon: Had to deallocate AWE 2876 pages from vm driver ffff81017000c000
[407903.511157] /dev/vmmon[17128]: host clock rate change request 83 -> 1043
[407913.530953] /dev/vmmon[17128]: host clock rate change request 1043 -> 83
[408746.978957] mkdir[20395]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffff9c6eb0 error 4
[408752.965448] mkdir[22194]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffffbc7110 error 4
[409165.403876] mkdir[9485]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffffa130e0 error 4
[454431.920854] mkdir[24440]: segfault at 0000000000000000 rip 000000000040184d rsp 00007fffff944ab0 error 4
[475054.904769] device eth0 left promiscuous mode
[475054.904785] bridge-eth0: disabled promiscuous mode
[475055.306847] /dev/vmmon[17120]: host clock rate change request 83 -> 0
[475055.327951] vmmon: Had to deallocate locked 459 pages from vm driver ffff81009bfb4000
[475055.341945] vmmon: Had to deallocate AWE 3208 pages from vm driver ffff81009bfb4000
[482250.227934] sed[12661] general protection rip:40870a rsp:7fffff919520 error:0
[482257.722422] sed[15691] general protection rip:40870a rsp:7ffffff19530 error:0
[482529.639385] sed[27380] general protection rip:40870a rsp:7fffffd197b0 error:0
[482535.426168] sed[31172] general protection rip:40870a rsp:7ffffff186e0 error:0
[482715.756053] sed[4672] general protection rip:40870a rsp:7fffffb19c80 error:0
[482733.501103] sed[15737] general protection rip:40870a rsp:7ffffff19590 error:0
[483607.368010] sed[8522] general protection rip:40870a rsp:7fffffb19b50 error:0


