Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVBXPAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVBXPAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVBXO7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:59:52 -0500
Received: from wasp.net.au ([203.190.192.17]:25988 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262360AbVBXOuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:50:39 -0500
Message-ID: <421DE9A9.4090902@wasp.net.au>
Date: Thu, 24 Feb 2005 18:50:17 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       RAID Linux <linux-raid@vger.kernel.org>
Subject: Raid-6 hang on write.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

I have a painful issue with a RAID-6 box. It only manifests itself on a fully complete and synced up 
array, and I can't reproduce it on an array smaller than the entire drives which means after every 
attempt at debugging I have to endure a 12 hour resync before I try again.

I have a single 3TB array as md0 and on top of that I have an ext3 filesystem. While the array is 
degraded I can read/write to/from it to my hearts content. When it's fully synced up a dd to the 
filesystem results in a lockup like the following.
dd hangs in a D state, as does any attempt to access the filesystem or /proc/mdstat. I then have to 
reboot the box using the doorbell or alt-sysrq which results in a dirty array and another 12 hours 
of rebuild. I have not managed to reproduce this issue on a partitioned array smaller than the full 
drives.

I have reproduced this on 2.6.11-rc4-bk4->bk10 and 2.6.11-rc4-mm1 with no other patches.

I'm waiting for it to resync again and I figure I'll try and backup the superblocks, therefore when 
it locks up I should be able to restore the clean superblocks before I try and start the array to 
fool it into thinking the array is clean and skip the long resync.

The write *always* sits in get_active_stripe.

I'll continue to hack on it over the weekend, but I thought I'd post it here in case someone spotted 
a thinko I might have missed.

Here is an alt-sysqr-t of the stuck process. It *always* hangs here like this and is completely 
reproducible on a clean synced array.

Feb 24 14:08:50 storage1 kernel: dd            D C041D9A0     0   366    353                     (NOTLB)
Feb 24 14:08:50 storage1 kernel: f60158e0 00000086 f6be35e0 c041d9a0 00000004 f713a400 00000004 
f713a390
Feb 24 14:08:50 storage1 kernel:        000009a5 02fa1650 000009b8 f6be35e0 f6be3704 f6014000 
c1ba60b8 00000000
Feb 24 14:08:50 storage1 kernel:        c1ba6060 c0268574 f7d67200 06528800 00000000 0b05cf72 
c1ba60c0 f6014000
Feb 24 14:08:50 storage1 kernel: Call Trace:
Feb 24 14:08:50 storage1 kernel:  [<c0268574>] get_active_stripe+0x224/0x260
Feb 24 14:08:50 storage1 kernel:  [<c01113a0>] default_wake_function+0x0/0x20
Feb 24 14:08:50 storage1 kernel:  [<c026afea>] make_request+0x19a/0x2e0
Feb 24 14:08:50 storage1 kernel:  [<c0127480>] autoremove_wake_function+0x0/0x60
Feb 24 14:08:50 storage1 kernel:  [<c0127480>] autoremove_wake_function+0x0/0x60
Feb 24 14:08:50 storage1 kernel:  [<c023d702>] generic_make_request+0x172/0x210
Feb 24 14:08:50 storage1 kernel:  [<c0132399>] buffered_rmqueue+0xf9/0x1e0
Feb 24 14:08:50 storage1 kernel:  [<c0127480>] autoremove_wake_function+0x0/0x60
Feb 24 14:08:50 storage1 last message repeated 2 times
Feb 24 14:08:50 storage1 kernel:  [<c023d802>] submit_bio+0x62/0x100
Feb 24 14:08:50 storage1 kernel:  [<c01502c4>] bio_alloc_bioset+0xe4/0x1c0
Feb 24 14:08:50 storage1 kernel:  [<c01503c0>] bio_alloc+0x20/0x30
Feb 24 14:08:50 storage1 kernel:  [<c014fbfa>] submit_bh+0x13a/0x1a0
Feb 24 14:08:50 storage1 kernel:  [<c014da38>] __bread_slow+0x48/0x80
Feb 24 14:08:50 storage1 kernel:  [<c014dd1d>] __bread+0x3d/0x50
Feb 24 14:08:50 storage1 kernel:  [<c017f818>] read_block_bitmap+0x58/0xa0
Feb 24 14:08:50 storage1 kernel:  [<c018094d>] ext3_new_block+0x17d/0x560
Feb 24 14:08:50 storage1 kernel:  [<c014db8a>] __find_get_block+0x5a/0xe0
Feb 24 14:08:50 storage1 kernel:  [<c0183380>] ext3_alloc_branch+0x50/0x2d0
Feb 24 14:08:50 storage1 kernel:  [<c0183187>] ext3_get_branch+0x67/0xf0
Feb 24 14:08:50 storage1 kernel:  [<c018395e>] ext3_get_block_handle+0x16e/0x360
Feb 24 14:08:50 storage1 kernel:  [<c0185f32>] __ext3_get_inode_loc+0x62/0x260
Feb 24 14:08:50 storage1 kernel:  [<c0183bb4>] ext3_get_block+0x64/0xb0
Feb 24 14:08:50 storage1 kernel:  [<c014e546>] __block_prepare_write+0x206/0x410
Feb 24 14:08:50 storage1 kernel:  [<c014ef64>] block_prepare_write+0x34/0x50
Feb 24 14:08:50 storage1 kernel:  [<c0183b50>] ext3_get_block+0x0/0xb0
Feb 24 14:08:50 storage1 kernel:  [<c0184149>] ext3_prepare_write+0x69/0x140
Feb 24 14:08:50 storage1 kernel:  [<c0183b50>] ext3_get_block+0x0/0xb0
Feb 24 14:08:50 storage1 kernel:  [<c012d994>] add_to_page_cache+0x54/0x80
Feb 24 14:08:50 storage1 kernel:  [<c012f966>] generic_file_buffered_write+0x1b6/0x630
Feb 24 14:08:50 storage1 kernel:  [<c0106bee>] timer_interrupt+0x4e/0x100
Feb 24 14:08:50 storage1 kernel:  [<c0164682>] inode_update_time+0x52/0xe0
Feb 24 14:08:50 storage1 kernel:  [<c01300ad>] __generic_file_aio_write_nolock+0x2cd/0x500
Feb 24 14:08:50 storage1 kernel:  [<c0118c7d>] __do_softirq+0x7d/0x90
Feb 24 14:08:50 storage1 kernel:  [<c0130592>] generic_file_aio_write+0x72/0xe0
Feb 24 14:08:50 storage1 kernel:  [<c0181b34>] ext3_file_write+0x44/0xd0
Feb 24 14:08:50 storage1 kernel:  [<c014b49e>] do_sync_write+0xbe/0xf0
Feb 24 14:08:50 storage1 kernel:  [<c01645bf>] update_atime+0x5f/0xd0
Feb 24 14:08:50 storage1 kernel:  [<c0127480>] autoremove_wake_function+0x0/0x60
Feb 24 14:08:50 storage1 kernel:  [<c0157017>] pipe_read+0x37/0x40
Feb 24 14:08:50 storage1 kernel:  [<c014b56f>] vfs_write+0x9f/0x120
Feb 24 14:08:50 storage1 kernel:  [<c014b6c1>] sys_write+0x51/0x80
Feb 24 14:08:50 storage1 kernel:  [<c0102405>] syscall_call+0x7/0xb

storage1:/home/brad# mdadm --detail /dev/md0
/dev/md0:
         Version : 00.90.01
   Creation Time : Thu Feb 24 14:51:17 2005
      Raid Level : raid6
      Array Size : 3186525056 (3038.91 GiB 3263.00 GB)
     Device Size : 245117312 (233.76 GiB 251.00 GB)
    Raid Devices : 15
   Total Devices : 15
Preferred Minor : 0
     Persistence : Superblock is persistent

     Update Time : Thu Feb 24 14:51:17 2005
           State : clean, resyncing
  Active Devices : 15
Working Devices : 15
  Failed Devices : 0
   Spare Devices : 0

      Chunk Size : 128K

  Rebuild Status : 29% complete

            UUID : 6a710026:bd55303e:9a273103:30d741e1
          Events : 0.277

     Number   Major   Minor   RaidDevice State
        0       8        0        0      active sync   /dev/devfs/scsi/host0/bus0/target0/lun0/disc
        1       8       16        1      active sync   /dev/devfs/scsi/host1/bus0/target0/lun0/disc
        2       8       32        2      active sync   /dev/devfs/scsi/host2/bus0/target0/lun0/disc
        3       8       48        3      active sync   /dev/devfs/scsi/host3/bus0/target0/lun0/disc
        4       8       64        4      active sync   /dev/devfs/scsi/host4/bus0/target0/lun0/disc
        5       8       80        5      active sync   /dev/devfs/scsi/host5/bus0/target0/lun0/disc
        6       8       96        6      active sync   /dev/devfs/scsi/host6/bus0/target0/lun0/disc
        7       8      112        7      active sync   /dev/devfs/scsi/host7/bus0/target0/lun0/disc
        8       8      128        8      active sync   /dev/devfs/scsi/host8/bus0/target0/lun0/disc
        9       8      144        9      active sync   /dev/devfs/scsi/host9/bus0/target0/lun0/disc
       10       8      160       10      active sync   /dev/devfs/scsi/host10/bus0/target0/lun0/disc
       11       8      176       11      active sync   /dev/devfs/scsi/host11/bus0/target0/lun0/disc
       12       8      192       12      active sync   /dev/devfs/scsi/host12/bus0/target0/lun0/disc
       13       8      208       13      active sync   /dev/devfs/scsi/host13/bus0/target0/lun0/disc
       14       8      224       14      active sync   /dev/devfs/scsi/host14/bus0/target0/lun0/disc

storage1:/home/brad# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi9 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi11 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi12 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi13 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi14 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
   Type:   Direct-Access                    ANSI SCSI revision: 05

storage1:/home/brad# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Sempron(TM) 2600+
stepping        : 1
cpu MHz         : 1833.218
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr 
sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 3612.67

storage1:/home/brad# cat /proc/meminfo
MemTotal:      1035964 kB
MemFree:        986180 kB
Buffers:             8 kB
Cached:          12712 kB
SwapCached:          0 kB
Active:          15068 kB
Inactive:         2204 kB
HighTotal:      131052 kB
HighFree:       112616 kB
LowTotal:       904912 kB
LowFree:        873564 kB
SwapTotal:     2047992 kB
SwapFree:      2047992 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:           9324 kB
Slab:            12460 kB
CommitLimit:   2565972 kB
Committed_AS:    12388 kB
PageTables:        320 kB
VmallocTotal:   114680 kB
VmallocUsed:      2640 kB
VmallocChunk:   111624 kB

storage1:/home/brad# lspci -v
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Flags: bus master, 66MHz, medium devsel, latency 0
         Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [80] AGP version 3.5
         Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: e6000000-e7dfffff
         Prefetchable memory behind bridge: e7f00000-efffffff
         Capabilities: [80] Power Management version 2

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
         Memory at e5800000 (32-bit, non-prefetchable) [size=16K]
         I/O ports at d800 [size=256]
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data

0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 19
         I/O ports at d400 [size=64]
         I/O ports at d000 [size=16]
         I/O ports at b800 [size=128]
         Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
         Memory at e4800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2

0000:00:0d.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 16
         I/O ports at b400 [size=64]
         I/O ports at b000 [size=16]
         I/O ports at a800 [size=128]
         Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
         Memory at e3800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2

0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
         I/O ports at a400 [size=64]
         I/O ports at a000 [size=16]
         I/O ports at 9800 [size=128]
         Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
         Memory at e2800000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 32
         I/O ports at 9400 [size=8]
         I/O ports at 9000 [size=4]
         I/O ports at 8800 [size=8]
         I/O ports at 8400 [size=4]
         I/O ports at 8000 [size=16]
         I/O ports at 7800 [size=256]
         Capabilities: [c0] Power Management version 2

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: medium devsel, IRQ 14
         I/O ports at 7400 [disabled] [size=16]
         Capabilities: [c0] Power Management version 2

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 32
         I/O ports at 7000 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 32
         I/O ports at 6800 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 32
         I/O ports at 6400 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 
(prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 32
         I/O ports at 6000 [size=32]
         Capabilities: [80] Power Management version 2

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, medium devsel, latency 32
         Memory at e2000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
         Subsystem: Asustek Computer, Inc. A7V600 motherboard
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
         Subsystem: Promise Technology, Inc. PDC20318 (SATA150 TX4)
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
         I/O ports at 5800 [size=64]
         I/O ports at 5400 [size=16]
         I/O ports at 5000 [size=128]
         Memory at e1800000 (32-bit, non-prefetchable) [size=4K]
         Memory at e1000000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2

0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1) 
(prog-if 00 [VGA])
         Subsystem: Unknown device 1682:201a
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
         Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
         Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at e7fe0000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
         Capabilities: [44] AGP version 3.0

Feb 24 14:29:27 storage1 kernel: Linux version 2.6.11-rc4-mm1 (brad@srv) (gcc version 3.3.5 (Debian 
1:3.3.5-8)) #1 Thu Feb 24 10:55:35 GST 2005
Feb 24 14:29:27 storage1 kernel: BIOS-provided physical RAM map:
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 0000000000100000 - 000000003fffb000 (usable)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 000000003fffb000 - 000000003ffff000 (ACPI data)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb 24 14:29:27 storage1 kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Feb 24 14:29:27 storage1 kernel: 127MB HIGHMEM available.
Feb 24 14:29:27 storage1 kernel: 896MB LOWMEM available.
Feb 24 14:29:27 storage1 kernel: On node 0 totalpages: 262139
Feb 24 14:29:27 storage1 kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 24 14:29:27 storage1 kernel:   Normal zone: 225280 pages, LIFO batch:16
Feb 24 14:29:27 storage1 kernel:   HighMem zone: 32763 pages, LIFO batch:7
Feb 24 14:29:27 storage1 kernel: DMI 2.3 present.

-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
