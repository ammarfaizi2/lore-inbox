Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934960AbWKXQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934960AbWKXQSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934961AbWKXQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:18:12 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:16060 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S934960AbWKXQSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:18:10 -0500
Message-ID: <45671B11.5010801@lwfinger.net>
Date: Fri, 24 Nov 2006 10:17:21 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, aia21@cantab.net
Subject: Possible circular locking in ntfs on 2.6.19-rc5-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On kernel 2.6.19-rc5-mm2, my log shows the following dump of a possible circular locking problem. 
The dump occurred while running an updatedb command that was initiated by cron.

Nov 24 02:13:23 larrylap kernel: =======================================================
Nov 24 02:13:23 larrylap kernel: [ INFO: possible circular locking dependency detected ]
Nov 24 02:13:23 larrylap kernel: 2.6.19-rc5-mm2-DSCA #4
Nov 24 02:13:23 larrylap kernel: -------------------------------------------------------
Nov 24 02:13:23 larrylap kernel: find/32325 is trying to acquire lock:
Nov 24 02:13:23 larrylap kernel:  (iprune_mutex){--..}, at: [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:23 larrylap kernel:
Nov 24 02:13:23 larrylap kernel: but task is already holding lock:
Nov 24 02:13:23 larrylap kernel:  (&ni->mrec_lock){--..}, at: [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:23 larrylap kernel:
Nov 24 02:13:23 larrylap kernel: which lock already depends on the new lock.
Nov 24 02:13:23 larrylap kernel:
Nov 24 02:13:25 larrylap kernel:
Nov 24 02:13:25 larrylap kernel: the existing dependency chain (in reverse order) is:
Nov 24 02:13:25 larrylap kernel:
Nov 24 02:13:25 larrylap kernel: -> #2 (&ni->mrec_lock){--..}:
Nov 24 02:13:25 larrylap kernel:        [<c01334ad>] add_lock_to_list+0x3d/0xb0
Nov 24 02:13:25 larrylap kernel:        [<c0135b07>] __lock_acquire+0xac7/0xcd0
Nov 24 02:13:25 larrylap kernel:        [<c0136092>] lock_acquire+0x62/0x80
Nov 24 02:13:25 larrylap kernel:        [<c032545f>] __mutex_lock_slowpath+0x7f/0x280
Nov 24 02:13:25 larrylap kernel:        [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:25 larrylap kernel:        [<e583b0bc>] map_mft_record+0x1c/0x260 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<e5832d9c>] ntfs_map_runlist_nolock+0x3dc/0x520 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<e5833304>] ntfs_map_runlist+0x54/0x80 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<e5831af8>] ntfs_readpage+0x7d8/0x930 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<c0144ce3>] read_cache_page+0xa3/0x180
Nov 24 02:13:25 larrylap kernel:        [<e5834f86>] ntfs_lookup_inode_by_name+0x3c6/0xde0 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<e583bb25>] ntfs_lookup+0x65/0x5e0 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<c016d184>] do_lookup+0x144/0x190
Nov 24 02:13:25 larrylap kernel:        [<c016d314>] __link_path_walk+0x144/0xe00
Nov 24 02:13:25 larrylap kernel:        [<c016e01e>] link_path_walk+0x4e/0xe0
Nov 24 02:13:25 larrylap kernel:        [<c016e3ec>] do_path_lookup+0x8c/0x1d0
Nov 24 02:13:25 larrylap kernel:        [<c016ea7a>] __path_lookup_intent_open+0x4a/0x90
Nov 24 02:13:25 larrylap kernel:        [<c016eb4a>] path_lookup_open+0x2a/0x30
Nov 24 02:13:25 larrylap kernel:        [<c016edd7>] open_namei+0x77/0x6a0
Nov 24 02:13:25 larrylap kernel:        [<c0163c28>] do_filp_open+0x38/0x60
Nov 24 02:13:25 larrylap kernel:        [<c0163c9b>] do_sys_open+0x4b/0x100
Nov 24 02:13:25 larrylap kernel:        [<c0163da7>] sys_open+0x27/0x30
Nov 24 02:13:25 larrylap kernel:        [<c0102fb2>] sysenter_past_esp+0x5f/0x99
Nov 24 02:13:25 larrylap kernel:        [<b7f72410>] 0xb7f72410
Nov 24 02:13:25 larrylap kernel:        [<ffffffff>] 0xffffffff
Nov 24 02:13:25 larrylap kernel:
Nov 24 02:13:25 larrylap kernel: -> #1 (&rl->lock){----}:
Nov 24 02:13:25 larrylap kernel:        [<c01334ad>] add_lock_to_list+0x3d/0xb0
Nov 24 02:13:25 larrylap kernel:        [<c0135b07>] __lock_acquire+0xac7/0xcd0
Nov 24 02:13:25 larrylap kernel:        [<c0136092>] lock_acquire+0x62/0x80
Nov 24 02:13:25 larrylap kernel:        [<c0130165>] down_write+0x55/0x70
Nov 24 02:13:25 larrylap kernel:        [<e5837965>] __ntfs_clear_inode+0x15/0x160 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<e5837b99>] ntfs_clear_big_inode+0x69/0xf0 [ntfs]
Nov 24 02:13:25 larrylap kernel:        [<c0178a62>] clear_inode+0x92/0x130
Nov 24 02:13:25 larrylap kernel:        [<c0178b28>] dispose_list+0x28/0x100
Nov 24 02:13:25 larrylap kernel:        [<c0178ded>] shrink_icache_memory+0x1ed/0x220
Nov 24 02:13:26 larrylap kernel:        [<c014deb2>] shrink_slab+0x122/0x1a0
Nov 24 02:13:26 larrylap kernel:        [<c014ef97>] kswapd+0x287/0x420
Nov 24 02:13:26 larrylap kernel:        [<c012c68b>] kthread+0xdb/0xe0
Nov 24 02:13:26 larrylap kernel:        [<c0103373>] kernel_thread_helper+0x7/0x14
Nov 24 02:13:26 larrylap kernel:        [<ffffffff>] 0xffffffff
Nov 24 02:13:26 larrylap kernel:
Nov 24 02:13:26 larrylap kernel: -> #0 (iprune_mutex){--..}:
Nov 24 02:13:26 larrylap kernel:        [<c0133706>] print_circular_bug_tail+0x46/0x90
Nov 24 02:13:26 larrylap kernel:        [<c0135969>] __lock_acquire+0x929/0xcd0
Nov 24 02:13:26 larrylap kernel:        [<c0136092>] lock_acquire+0x62/0x80
Nov 24 02:13:26 larrylap kernel:        [<c032545f>] __mutex_lock_slowpath+0x7f/0x280
Nov 24 02:13:26 larrylap kernel:        [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:26 larrylap kernel:        [<c0178c61>] shrink_icache_memory+0x61/0x220
Nov 24 02:13:26 larrylap kernel:        [<c014deb2>] shrink_slab+0x122/0x1a0
Nov 24 02:13:26 larrylap kernel:        [<c014f5c6>] try_to_free_pages+0x146/0x230
Nov 24 02:13:26 larrylap kernel:        [<c014904a>] __alloc_pages+0x13a/0x340
Nov 24 02:13:26 larrylap kernel:        [<c0144cb8>] read_cache_page+0x78/0x180
Nov 24 02:13:26 larrylap kernel:        [<e583b157>] map_mft_record+0xb7/0x260 [ntfs]
Nov 24 02:13:26 larrylap kernel:        [<e5838ea9>] ntfs_read_locked_inode+0x59/0x1580 [ntfs]
Nov 24 02:13:26 larrylap kernel:        [<e583b026>] ntfs_iget+0x66/0x90 [ntfs]
Nov 24 02:13:26 larrylap kernel:        [<e583bbc1>] ntfs_lookup+0x101/0x5e0 [ntfs]
Nov 24 02:13:26 larrylap kernel:        [<c016d184>] do_lookup+0x144/0x190
Nov 24 02:13:26 larrylap kernel:        [<c016da26>] __link_path_walk+0x856/0xe00
Nov 24 02:13:26 larrylap kernel:        [<c016e01e>] link_path_walk+0x4e/0xe0
Nov 24 02:13:26 larrylap kernel:        [<c016e3ec>] do_path_lookup+0x8c/0x1d0
Nov 24 02:13:26 larrylap kernel:        [<c016eb89>] __user_walk_fd+0x39/0x60
Nov 24 02:13:26 larrylap kernel:        [<c016799f>] vfs_lstat_fd+0x1f/0x60
Nov 24 02:13:26 larrylap kernel:        [<c0167a00>] vfs_lstat+0x20/0x30
Nov 24 02:13:26 larrylap kernel:        [<c01682c9>] sys_lstat64+0x19/0x30
Nov 24 02:13:26 larrylap kernel:        [<c0102fb2>] sysenter_past_esp+0x5f/0x99
Nov 24 02:13:26 larrylap kernel:        [<b7f67410>] 0xb7f67410
Nov 24 02:13:26 larrylap kernel:        [<ffffffff>] 0xffffffff
Nov 24 02:13:26 larrylap kernel:
Nov 24 02:13:26 larrylap kernel: other info that might help us debug this:
Nov 24 02:13:26 larrylap kernel:
Nov 24 02:13:26 larrylap kernel: 3 locks held by find/32325:
Nov 24 02:13:26 larrylap kernel:  #0:  (&inode->i_mutex){--..}, at: [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:26 larrylap kernel:  #1:  (&ni->mrec_lock){--..}, at: [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:26 larrylap kernel:  #2:  (shrinker_rwsem){----}, at: [<c014ddb2>] shrink_slab+0x22/0x1a0
Nov 24 02:13:26 larrylap kernel:
Nov 24 02:13:26 larrylap kernel: stack backtrace:
Nov 24 02:13:26 larrylap kernel:  [<c01039d0>] dump_trace+0x210/0x220
Nov 24 02:13:26 larrylap kernel:  [<c0103a06>] show_trace_log_lvl+0x26/0x40
Nov 24 02:13:26 larrylap kernel:  [<c0103dfb>] show_trace+0x1b/0x20
Nov 24 02:13:27 larrylap kernel:  [<c0103e24>] dump_stack+0x24/0x30
Nov 24 02:13:27 larrylap kernel:  [<c0133741>] print_circular_bug_tail+0x81/0x90
Nov 24 02:13:27 larrylap kernel:  [<c0135969>] __lock_acquire+0x929/0xcd0
Nov 24 02:13:27 larrylap kernel:  [<c0136092>] lock_acquire+0x62/0x80
Nov 24 02:13:27 larrylap kernel:  [<c032545f>] __mutex_lock_slowpath+0x7f/0x280
Nov 24 02:13:27 larrylap kernel:  [<c0325689>] mutex_lock+0x29/0x30
Nov 24 02:13:27 larrylap kernel:  [<c0178c61>] shrink_icache_memory+0x61/0x220
Nov 24 02:13:27 larrylap kernel:  [<c014deb2>] shrink_slab+0x122/0x1a0
Nov 24 02:13:27 larrylap kernel:  [<c014f5c6>] try_to_free_pages+0x146/0x230
Nov 24 02:13:27 larrylap kernel:  [<c014904a>] __alloc_pages+0x13a/0x340
Nov 24 02:13:27 larrylap kernel:  [<c0144cb8>] read_cache_page+0x78/0x180
Nov 24 02:13:27 larrylap kernel:  [<e583b157>] map_mft_record+0xb7/0x260 [ntfs]
Nov 24 02:13:27 larrylap kernel:  [<e5838ea9>] ntfs_read_locked_inode+0x59/0x1580 [ntfs]
Nov 24 02:13:27 larrylap kernel:  [<e583b026>] ntfs_iget+0x66/0x90 [ntfs]
Nov 24 02:13:27 larrylap kernel:  [<e583bbc1>] ntfs_lookup+0x101/0x5e0 [ntfs]
Nov 24 02:13:27 larrylap kernel:  [<c016d184>] do_lookup+0x144/0x190
Nov 24 02:13:27 larrylap kernel:  [<c016da26>] __link_path_walk+0x856/0xe00
Nov 24 02:13:27 larrylap kernel:  [<c016e01e>] link_path_walk+0x4e/0xe0
Nov 24 02:13:27 larrylap kernel:  [<c016e3ec>] do_path_lookup+0x8c/0x1d0
Nov 24 02:13:27 larrylap kernel:  [<c016eb89>] __user_walk_fd+0x39/0x60
Nov 24 02:13:27 larrylap kernel:  [<c016799f>] vfs_lstat_fd+0x1f/0x60
Nov 24 02:13:27 larrylap kernel:  [<c0167a00>] vfs_lstat+0x20/0x30
Nov 24 02:13:27 larrylap kernel:  [<c01682c9>] sys_lstat64+0x19/0x30
Nov 24 02:13:27 larrylap kernel:  [<c0102fb2>] sysenter_past_esp+0x5f/0x99
Nov 24 02:13:27 larrylap kernel:  [<b7f67410>] 0xb7f67410
Nov 24 02:13:27 larrylap kernel:  =======================
