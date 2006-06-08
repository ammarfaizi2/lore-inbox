Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWFHE1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWFHE1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 00:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWFHE1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 00:27:21 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:37416 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932501AbWFHE1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 00:27:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jqq4+t1cA0PbEfnmkip+K6sxFkPxzR7vuUanrIL53z42+44tYRPO+owlk/W/GOXvcUz2uvX9lvVtGOYtFuHE7s/JCDnZK+88WSSWXHMSjPj7357/GbGhR0jOwzzIoKf5O3A2zQni+hzN7qq9jZmC4cAAUVGZEv1TuATTEmydKFM=
Message-ID: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
Date: Wed, 7 Jun 2006 21:27:19 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
mount/1219 is trying to acquire lock:
 (&ni->mrec_lock){--..}, at: [<c031e4b8>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&rl->lock){----}, at: [<f8a98e4d>] ntfs_map_runlist+0x2a/0xb5 [ntfs]

which lock already depends on the new lock,
which could lead to circular deadlocks!

the existing dependency chain (in reverse order) is:

-> #1 (&rl->lock){----}:
       [<c012ec64>] lock_acquire+0x58/0x74
       [<f8a97619>] ntfs_readpage+0x362/0x8fd [ntfs]
       [<c01415b0>] read_cache_page+0x8c/0x137
       [<f8a9eeb8>] map_mft_record+0xd7/0x1d2 [ntfs]
       [<f8a9d661>] ntfs_read_locked_inode+0x74/0xea9 [ntfs]
       [<f8a9eabb>] ntfs_read_inode_mount+0x625/0x846 [ntfs]
       [<f8aa2ff8>] ntfs_fill_super+0x8ca/0xd14 [ntfs]
       [<c01647c4>] get_sb_bdev+0xed/0x14e
       [<f8aa15ef>] ntfs_get_sb+0x10/0x12 [ntfs]
       [<c0163c11>] vfs_kern_mount+0x76/0x143
       [<c0163d17>] do_kern_mount+0x29/0x3d
       [<c0177f9f>] do_mount+0x78a/0x7e4
       [<c0178058>] sys_mount+0x5f/0x91
       [<c031fb5d>] sysenter_past_esp+0x56/0x8d

-> #0 (&ni->mrec_lock){--..}:
       [<c012ec64>] lock_acquire+0x58/0x74
       [<c031e321>] __mutex_lock_slowpath+0xa7/0x21d
       [<c031e4b8>] mutex_lock+0x21/0x24
       [<f8a9edfa>] map_mft_record+0x19/0x1d2 [ntfs]
       [<f8a98630>] ntfs_map_runlist_nolock+0x48/0x437 [ntfs]
       [<f8a98eaa>] ntfs_map_runlist+0x87/0xb5 [ntfs]
       [<f8a97739>] ntfs_readpage+0x482/0x8fd [ntfs]
       [<c01415b0>] read_cache_page+0x8c/0x137
       [<f8aa20bc>] load_system_files+0x155/0x7c7 [ntfs]
       [<f8aa30a7>] ntfs_fill_super+0x979/0xd14 [ntfs]
       [<c01647c4>] get_sb_bdev+0xed/0x14e
       [<f8aa15ef>] ntfs_get_sb+0x10/0x12 [ntfs]
       [<c0163c11>] vfs_kern_mount+0x76/0x143
       [<c0163d17>] do_kern_mount+0x29/0x3d
       [<c0177f9f>] do_mount+0x78a/0x7e4
       [<c0178058>] sys_mount+0x5f/0x91
       [<c031fb5d>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

2 locks held by mount/1219:
 #0:  (&s->s_umount#18){--..}, at: [<c0164443>] sget+0x223/0x3a1
 #1:  (&rl->lock){----}, at: [<f8a98e4d>] ntfs_map_runlist+0x2a/0xb5 [ntfs]

stack backtrace:
 [<c0103924>] show_trace_log_lvl+0x54/0xfd
 [<c01049a9>] show_trace+0xd/0x10
 [<c01049c3>] dump_stack+0x17/0x1c
 [<c012cefb>] print_circular_bug_tail+0x59/0x64
 [<c012e766>] __lock_acquire+0x7c2/0x97a
 [<c012ec64>] lock_acquire+0x58/0x74
 [<c031e321>] __mutex_lock_slowpath+0xa7/0x21d
 [<c031e4b8>] mutex_lock+0x21/0x24
 [<f8a9edfa>] map_mft_record+0x19/0x1d2 [ntfs]
 [<f8a98630>] ntfs_map_runlist_nolock+0x48/0x437 [ntfs]
 [<f8a98eaa>] ntfs_map_runlist+0x87/0xb5 [ntfs]
 [<f8a97739>] ntfs_readpage+0x482/0x8fd [ntfs]
 [<c01415b0>] read_cache_page+0x8c/0x137
 [<f8aa20bc>] load_system_files+0x155/0x7c7 [ntfs]
 [<f8aa30a7>] ntfs_fill_super+0x979/0xd14 [ntfs]
 [<c01647c4>] get_sb_bdev+0xed/0x14e
 [<f8aa15ef>] ntfs_get_sb+0x10/0x12 [ntfs]
 [<c0163c11>] vfs_kern_mount+0x76/0x143
 [<c0163d17>] do_kern_mount+0x29/0x3d
 [<c0177f9f>] do_mount+0x78a/0x7e4
 [<c0178058>] sys_mount+0x5f/0x91
 [<c031fb5d>] sysenter_past_esp+0x56/0x8d
NTFS volume version 3.1.
