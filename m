Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTLXEhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 23:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTLXEhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 23:37:20 -0500
Received: from vt-williston-cuda1k1-188.sbtnvt.adelphia.net ([69.162.184.188]:20672
	"EHLO infocalypse.jimlawson.org") by vger.kernel.org with ESMTP
	id S263435AbTLXEhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 23:37:08 -0500
Date: Tue, 23 Dec 2003 23:37:07 -0500 (EST)
From: Jim Lawson <jim+linux-kernel@jimlawson.org>
X-X-Sender: jim@infocalypse.jimlawson.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.0, SiI3112, md raid1 problem: bio too big device (128 > 15)
Message-ID: <Pine.LNX.4.58.0312232253140.7841@infocalypse.jimlawson.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am having trouble creating a raid1 array under 2.6.0.  I am able to
create raid0 and raid5 mds, but raid1s fail with "bio too big device hde3
(128 > 15)", which doesn't tell me a lot.  I can see it's in
drivers/block/ll_rw_blk.c, right at the boundary with the device driver,
but I'm not enough of a kernel wonk to find out a lot more.

I'm not sure if this has to do with a kernel bug, a bug in the driver for
the controller I have (SiI3112, Silicon Image 3112), or the disks I am
using (Seagate Barracuda 7200.7, 160 GB SATA disks) ... or the combination
thereof :-)

I'm using a VIA KT600 chipset.  I have read that 2.5/2.6 may still have
issues with the APIC under VIA chipsets, so I am booting with "noapic"
(this made a number of other problems go away - my network card is working
much better now as a result.)

Kernel version: Linux version 2.6.0-aluminum (root@aluminum) (gcc version
3.3.3 20031206 (prerelease) (Debian)) #1 Mon Dec 22 10:53:33 UTC 2003

Kernel oops: None that I can re-create, although I did get one at some
point during the creation of a raid1 set... a fluke?

What I do:

- Create 2 partitions

Disk /dev/hde: 160.0 GB, 160041885696 bytes
255 heads, 63 sectors/track, 19457 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hde1   *           1        5000    40162468+  83  Linux
/dev/hde2            5001        5063      506047+  82  Linux swap
/dev/hde3            5064       19457   115619805   fd  Linux raid
autodetect

Disk /dev/hdg: 160.0 GB, 160041885696 bytes
255 heads, 63 sectors/track, 19457 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdg3            5064       19457   115619805   fd  Linux raid
autodetect

- Create entries in /etc/raidtab

raiddev /dev/md0
        raid-level 1
        nr-raid-disks 2
        persistent-superblock 1
        chunk-size 8

        device  /dev/hde3
        raid-disk 0
        device  /dev/hdg3
        raid-disk 1

- Make the raidset

aluminum:/# mkraid /dev/md0
handling MD device /dev/md0
analyzing super-block
disk 0: /dev/hde3, 115619805kB, raid superblock at 115619712kB
disk 1: /dev/hdg3, 115619805kB, raid superblock at 115619712kB

- Get failure messages from /var/log/messages

Dec 24 11:53:21 aluminum kernel: md: bind<hde3>
Dec 24 11:53:21 aluminum kernel: md: bind<hdg3>
Dec 24 11:53:21 aluminum kernel: raid1: raid set md0 active with 2 out of
2 mirrors
Dec 24 11:53:21 aluminum kernel: md: syncing RAID array md0
Dec 24 11:53:21 aluminum kernel: md: minimum _guaranteed_ reconstruction
speed: 1000 KB/sec/disc.
Dec 24 11:53:21 aluminum kernel: md: using maximum available idle IO
bandwith (but not more than 200000 KB/sec) for reconstruction.
Dec 24 11:53:21 aluminum kernel: md: using 128k window, over a total of
115619712 blocks.
Dec 24 11:53:21 aluminum kernel: bio too big device hde3 (128 > 15)
Dec 24 11:53:21 aluminum kernel: ^IOperation continuing on 1 devices
Dec 24 11:53:21 aluminum kernel: bio too big device hdg3 (128 > 15)
Dec 24 11:53:21 aluminum kernel: md: md0: sync done.

ver_linux:

Linux aluminum 2.6.0-aluminum #1 Mon Dec 22 10:53:33 UTC 2003 i686
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.5
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         ppp_async ipv6 ppp_generic slhc tg3 rtc

Processor info:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2800+
stepping        : 0
cpu MHz         : 2083.203
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4104.19

Modules:

ppp_async 11712 0 - Live 0xe0864000
ipv6 250880 10 - Live 0xe08bf000
ppp_generic 29840 1 ppp_async, Live 0xe086e000
slhc 6976 1 ppp_generic, Live 0xe084b000
tg3 75844 0 - Live 0xe0850000
rtc 13112 0 - Live 0xe0835000

/proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-a07f : 0000:00:08.0
a400-a4ff : 0000:00:0e.0
a800-a80f : 0000:00:0f.0
  a800-a807 : ide0
  a808-a80f : ide1
ac00-ac1f : 0000:00:10.0
  ac00-ac1f : uhci_hcd
b000-b01f : 0000:00:10.1
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:10.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:10.3
  b800-b81f : uhci_hcd
bc00-bc07 : 0000:00:13.0
c000-c003 : 0000:00:13.0
c400-c407 : 0000:00:13.0
c800-c803 : 0000:00:13.0
cc00-cc0f : 0000:00:13.0

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d47ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002fd0a0 : Kernel code
  002fd0a1-003cf4ff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
  e082b000-e082b007 : ide2
  e082b008-e082b00f : ide3
  e082b010-e082b017 : ide2
  e082b018-e082b01f : ide3
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : 0000:01:00.0
e8000000-e9ffffff : PCI Bus #01
  e9000000-e9003fff : 0000:01:00.0
eb000000-eb00ffff : 0000:00:07.0
  eb000000-eb00ffff : tg3
eb010000-eb01007f : 0000:00:08.0
eb011000-eb0110ff : 0000:00:10.4
  eb011000-eb0110ff : ehci_hcd
eb012000-eb0121ff : 0000:00:13.0
  eb012000-eb0121ff : SiI3112 Serial ATA
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

lspci -vvv: really long - get it at
	http://infocalypse.jimlawson.org:8000/jim/lkml/aluminum.lspci

Hope someone can help.

BTW, congrats on releasing 2.6!  I'm very excited.

Jim Lawson

