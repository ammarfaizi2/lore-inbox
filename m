Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTJTUfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTJTUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:35:40 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:46039 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262792AbTJTUfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:35:23 -0400
Subject: LVM on md0: raid0_make_request bug: can't convert block across
	chunks or bigger than 64k
From: Karl Vogel <karl.vogel@seagha.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066682115.1799.15.camel@kvo.local.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Mon, 20 Oct 2003 22:35:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following kernel messages on V2.6.0-test8-mm1 (I've also
tried plain -test7 and some kernels before that) when copying moderately
sized files from a raid-0/LVM volume:

--- snip ---
raid0_make_request bug: can't convert block across chunks or bigger than
64k 24081064 64
raid0_make_request bug: can't convert block across chunks or bigger than
64k 24080656 64
raid0_make_request bug: can't convert block across chunks or bigger than
64k 24080784 64
raid0_make_request bug: can't convert block across chunks or bigger than
64k 24080928 64
--- snip ---

The data was created on a V2.4 kernel. The partition contains 1 LVM
volume, which is using a RAID-0 md0 as the physical volume:

# ./lvm lvdisplay
  --- Logical volume ---
  LV Name                /dev/system/root
  VG Name                system
  LV UUID                000000-0000-0000-0000-0000-0000-000000
  LV Write Access        read/write
  LV Status              available
  # open                 2
  LV Size                11.58 GB
  Current LE             2964
  Segments               1
  Allocation             next free
  Read ahead sectors     10000
  Block device           254:0

# ./lvm pvdisplay
  --- Physical volume ---
  PV Name               /dev/md0
  VG Name               system
  PV Size               11.58 GB / not usable 4.31 MB
  Allocatable           yes (but full)
  PE Size (KByte)       4096
  Total PE              2964
  Free PE               0
  Allocated PE          2964
  PV UUID               uYHQYU-TmrF-I3Ws-674P-v3Rx-4CPz-mOe5Tu

# ./lvm vgdisplay
  --- Volume group ---
  VG Name               system
  System ID             kvo.local.org1047770061
  Format                lvm1
  VG Access             read/write
  VG Status             resizable
  MAX LV                256
  Cur LV                1
  Open LV               0
  Max PV                256
  Cur PV                1
  Act PV                1
  VG Size               11.58 GB
  PE Size               4.00 MB
  Total PE              2964
  Alloc PE / Size       2964 / 11.58 GB
  Free  PE / Size       0 / 0
  VG UUID               AE3SH5-7pbd-itL5-firC-Sxis-0IXE-qMa5dD

The RAID-0 is setup as:

# cat /etc/raidtab
raiddev /dev/md0
        raid-level              0
        nr-raid-disks           2
        persistent-superblock   0
        chunk-size              8

        device                  /dev/hdd1
        raid-disk               0
        device                  /dev/hdc2
        raid-disk               1

The boot message of the md0 initializing looks like:

Oct 20 20:44:55 kvo kernel: md: Autodetecting RAID arrays.
Oct 20 20:44:55 kvo kernel: md: autorun ...
Oct 20 20:44:55 kvo kernel: md: considering hdd1 ...
Oct 20 20:44:55 kvo kernel: md:  adding hdd1 ...
Oct 20 20:44:55 kvo kernel: md:  adding hdc2 ...
Oct 20 20:44:55 kvo kernel: md: created md0
Oct 20 20:44:55 kvo kernel: md: bind<hdc2>
Oct 20 20:44:55 kvo kernel: md: bind<hdd1>
Oct 20 20:44:55 kvo kernel: md: running: <hdd1><hdc2>
Oct 20 20:44:55 kvo kernel: md0: setting max_sectors to 128, segment
boundary to 32767
Oct 20 20:44:55 kvo kernel: raid0: looking at hdd1
Oct 20 20:44:55 kvo kernel: raid0:   comparing hdd1(6345600) with
hdd1(6345600)
Oct 20 20:44:55 kvo kernel: raid0:   END
Oct 20 20:44:55 kvo syslog: klogd startup succeeded
Oct 20 20:44:55 kvo kernel: raid0:   ==> UNIQUE
Oct 20 20:44:55 kvo kernel: raid0: 1 zones
Oct 20 20:44:55 kvo kernel: raid0: looking at hdc2
Oct 20 20:44:55 kvo kernel: raid0:   comparing hdc2(5799360) with
hdd1(6345600)
Oct 20 20:44:55 kvo kernel: raid0:   NOT EQUAL
Oct 20 20:44:55 kvo kernel: raid0:   comparing hdc2(5799360) with
hdc2(5799360)
Oct 20 20:44:55 kvo kernel: raid0:   END
Oct 20 20:44:55 kvo kernel: raid0:   ==> UNIQUE
Oct 20 20:44:55 kvo kernel: raid0: 2 zones
Oct 20 20:44:55 kvo kernel: raid0: FINAL 2 zones
Oct 20 20:44:55 kvo kernel: raid0: zone 1
Oct 20 20:44:55 kvo kernel: raid0: checking hdc2 ... nope.
Oct 20 20:44:55 kvo kernel: raid0: checking hdd1 ... contained as device
0
Oct 20 20:44:55 kvo kernel:   (6345600) is smallest!.
Oct 20 20:44:55 kvo kernel: raid0: zone->nb_dev: 1, size: 546240
Oct 20 20:44:55 kvo kernel: raid0: current zone offset: 6345600
Oct 20 20:44:55 kvo kernel: raid0: done.
Oct 20 20:44:55 kvo kernel: raid0 : md_size is 12144960 blocks.
Oct 20 20:44:55 kvo kernel: raid0 : conf->hash_spacing is 11598720
blocks.
Oct 20 20:44:55 kvo kernel: raid0 : nb_zone is 2.
Oct 20 20:44:55 kvo kernel: raid0 : Allocating 8 bytes for hash.
Oct 20 20:44:55 kvo kernel: md: ... autorun DONE.

I'm using LVM2.1.95.15 with the V1 interface (am getting errors when
compiling the latest LVM2 tools, but that's a different story :)


Please use reply-all if you require more details.

Regards,
Karl


