Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268959AbUJEK1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268959AbUJEK1B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUJEK1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:27:01 -0400
Received: from math.ut.ee ([193.40.5.125]:5589 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S268959AbUJEK0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:26:53 -0400
Date: Tue, 5 Oct 2004 13:26:52 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: LVM snapshot creation hang
Message-ID: <Pine.GSO.4.44.0410051312370.16512-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experimenting with LVM2 tools (x86, Debian unstable, 2.6.8-rc3+BK as
of 20041004). Since I didn't have a spare disk available (on a laptop),
I started my experiments with loopback device.

I created a dense 1G file on ext3 and made it loop0. pvcreate, vgcreate,
lvcreate (using only this single disk as a physical volume). Then I
tried XFS and Reiserfs resizing and snapshots. Resizing worked well but
snapshot creation hangs the process (lvcreate):
lvcreate --snapshot --name snap --size 100M /dev/vg/vol

For XFS, it's in D state but has no WCHAN. CPU load is <1. Any other
process touching this volume group hangs too (and sync too).

For reiserfs, I got out of memory error and dmesg showed a message about
0-order allocation failure:
lvcreate: page allocation failure. order:0, mode:0xd0
 [<c0132840>] __alloc_pages+0x1b0/0x330
 [<d8a712e7>] alloc_pl+0x27/0x40 [dm_mod]
 [<d8a713c5>] client_alloc_pages+0x15/0x50 [dm_mod]
 [<d8a71d95>] kcopyd_client_create+0x65/0xb0 [dm_mod]
 [<d8a6c907>] dm_vcalloc+0x27/0x60 [dm_mod]
 [<d8b5b131>] dm_create_persistent+0xb1/0x120 [dm_snapshot]
 [<d8b597d5>] snapshot_ctr+0x295/0x360 [dm_snapshot]
 [<d8a6d533>] dm_table_add_target+0x123/0x1c0 [dm_mod]
 [<d8a6fa90>] populate_table+0x80/0xd0 [dm_mod]
 [<d8a6fae0>] table_load+0x0/0x110 [dm_mod]
 [<d8a6fb31>] table_load+0x51/0x110 [dm_mod]
 [<d8a702a2>] ctl_ioctl+0xd2/0x130 [dm_mod]
 [<c01579e5>] sys_ioctl+0xc5/0x220
 [<c0103db9>] sysenter_past_esp+0x52/0x71
device-mapper: : Could not create kcopyd client

The physical volume was about 1G in size and logical volume 500-600M,
snapshot size was 100M.

I tested XFS on 2 hosts, one with Celeron 1.1 and 256M RAM (single user
running KDE) and another with Duron 1300 (384M RAM, single user running
KDE) - both have about half of the RAM used as filesystem cache so
should not be low on memory.

I suspected problems with loopback device and devmapper combo and
decided to try with real block devices. I did put a 128M smartmedia card
is usb reader and experimented with this. 124M physical volume, 100M
logical volume, 20M for scratch during snapshot.

XFS snapshot creation, use and freeing worked OK and AFAIR I used
xfs_freeze too before the snapshot creation.

Then I tried it on the laptop again, did a successful snapshot without
doing xfs_freeze, understood my mistake, lvremoved snapshot, xfs_freezed
the volume and tried to take snapshot again - same hang as with XFS
before.

Where to start the debugging?

-- 
Meelis Roos (mroos@linux.ee)

