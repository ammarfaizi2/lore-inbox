Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWGWAzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWGWAzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWGWAzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:55:41 -0400
Received: from tornado.reub.net ([202.89.145.182]:17837 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750821AbWGWAzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:55:40 -0400
Message-ID: <44C2C90B.6090108@reub.net>
Date: Sun, 23 Jul 2006 12:55:39 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0a1 (Windows/20060721)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: John McCutchan <john@johnmccutchan.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc1-mm2
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2006 5:48 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/
> 
> - Patches were merged, added, dropped and fixed.  Nothing particularly exciting.
> 
> - Added the avr32 architecture.  Review is sought, please.

Just spotted this in logs:

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
imap/30033 is trying to acquire lock:
  (iprune_mutex){--..}, at: [<ffffffff80263f71>] mutex_lock+0x19/0x20

but task is already holding lock:
  (&dev->ev_mutex){--..}, at: [<ffffffff80263f71>] mutex_lock+0x19/0x20

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&dev->ev_mutex){--..}:
        [<ffffffff8029b639>] lock_acquire+0x4e/0x75
        [<ffffffff80263def>] __mutex_lock_slowpath+0xd3/0x23c
        [<ffffffff80263f70>] mutex_lock+0x18/0x20
        [<ffffffff8021d583>] inotify_dev_queue_event+0x33/0x140
        [<ffffffff802da926>] inotify_remove_watch_locked+0x34/0x3a
        [<ffffffff802daa0c>] inotify_rm_wd+0x8b/0xb5
        [<ffffffff802dafd8>] sys_inotify_rm_watch+0x4a/0x6b
        [<ffffffff8025f3a1>] system_call+0x7d/0x83

-> #2 (&ih->mutex){--..}:
        [<ffffffff8029b639>] lock_acquire+0x4e/0x75
        [<ffffffff80263def>] __mutex_lock_slowpath+0xd3/0x23c
        [<ffffffff80263f70>] mutex_lock+0x18/0x20
        [<ffffffff802da5d8>] inotify_find_update_watch+0x49/0x9d
        [<ffffffff8024d4fd>] sys_inotify_add_watch+0xd8/0x1ac
        [<ffffffff8025f3a1>] system_call+0x7d/0x83

-> #1 (&inode->inotify_mutex){--..}:
        [<ffffffff8029b639>] lock_acquire+0x4e/0x75
        [<ffffffff80263def>] __mutex_lock_slowpath+0xd3/0x23c
        [<ffffffff80263f70>] mutex_lock+0x18/0x20
        [<ffffffff8025b984>] inotify_unmount_inodes+0xd4/0x1d0
        [<ffffffff802ce62b>] invalidate_inodes+0x46/0x10b
        [<ffffffff802c61d7>] generic_shutdown_super+0x77/0x16c
        [<ffffffff802c62f1>] kill_block_super+0x25/0x3b
        [<ffffffff802c63bf>] deactivate_super+0x4b/0x6c
        [<ffffffff8022d040>] mntput_no_expire+0x57/0x92
        [<ffffffff802325e1>] path_release_on_umount+0x1c/0x2b
        [<ffffffff802d01e1>] sys_umount+0x251/0x29b
        [<ffffffff8025f3a1>] system_call+0x7d/0x83

-> #0 (iprune_mutex){--..}:
        [<ffffffff8029b639>] lock_acquire+0x4e/0x75
        [<ffffffff80263def>] __mutex_lock_slowpath+0xd3/0x23c
        [<ffffffff80263f70>] mutex_lock+0x18/0x20
        [<ffffffff8022d9f1>] shrink_icache_memory+0x41/0x270
        [<ffffffff80240dc3>] shrink_slab+0x11c/0x1c9
        [<ffffffff802b5103>] try_to_free_pages+0x186/0x244
        [<ffffffff8020efec>] __alloc_pages+0x1cc/0x2e0
        [<ffffffff8025e1f7>] cache_alloc_refill+0x3f7/0x821
        [<ffffffff8020a5e4>] kmem_cache_alloc+0x84/0xcb
        [<ffffffff802db026>] kernel_event+0x2d/0x122
        [<ffffffff8021d61b>] inotify_dev_queue_event+0xcb/0x140
        [<ffffffff802da926>] inotify_remove_watch_locked+0x34/0x3a
        [<ffffffff802daa0c>] inotify_rm_wd+0x8b/0xb5
        [<ffffffff802dafd8>] sys_inotify_rm_watch+0x4a/0x6b
        [<ffffffff8025f3a1>] system_call+0x7d/0x83

other info that might help us debug this:

4 locks held by imap/30033:
  #0:  (&inode->inotify_mutex){--..}, at: [<ffffffff80263f71>] mutex_lock+0x19/0x20
  #1:  (&ih->mutex){--..}, at: [<ffffffff80263f71>] mutex_lock+0x19/0x20
  #2:  (&dev->ev_mutex){--..}, at: [<ffffffff80263f71>] mutex_lock+0x19/0x20
  #3:  (shrinker_rwsem){----}, at: [<ffffffff80240cd9>] shrink_slab+0x32/0x1c9

stack backtrace:

Call Trace:
  [<ffffffff8026963e>] show_trace+0xae/0x265
  [<ffffffff8026980a>] dump_stack+0x15/0x1b
  [<ffffffff8029996d>] print_circular_bug_tail+0x6d/0x80
  [<ffffffff8029b2fd>] __lock_acquire+0x9cd/0xcbb
  [<ffffffff8029b63a>] lock_acquire+0x4f/0x75
  [<ffffffff80263df0>] __mutex_lock_slowpath+0xd4/0x23c
  [<ffffffff80263f71>] mutex_lock+0x19/0x20
  [<ffffffff8022d9f2>] shrink_icache_memory+0x42/0x270
  [<ffffffff80240dc4>] shrink_slab+0x11d/0x1c9
  [<ffffffff802b5104>] try_to_free_pages+0x187/0x244
  [<ffffffff8020efed>] __alloc_pages+0x1cd/0x2e0
  [<ffffffff8025e1f8>] cache_alloc_refill+0x3f8/0x821
  [<ffffffff8020a5e5>] kmem_cache_alloc+0x85/0xcb
  [<ffffffff802db027>] kernel_event+0x2e/0x122
  [<ffffffff8021d61c>] inotify_dev_queue_event+0xcc/0x140
  [<ffffffff802da927>] inotify_remove_watch_locked+0x35/0x3a
  [<ffffffff802daa0d>] inotify_rm_wd+0x8c/0xb5
  [<ffffffff802dafd9>] sys_inotify_rm_watch+0x4b/0x6b
  [<ffffffff8025f3a2>] system_call+0x7e/0x83
  [<000000350ced0247>]


Reuben
