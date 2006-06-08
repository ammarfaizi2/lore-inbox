Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWFHKGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWFHKGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWFHKGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:06:47 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:16109 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932094AbWFHKGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:06:47 -0400
From: Duncan Sands <baldrick@free.fr>
To: Ingo Molnar <mingo@elte.hu>
Subject: NTFS possible circular locking deadlock (Was: Re: 2.6.17-rc6-mm1)
Date: Thu, 8 Jun 2006 12:06:41 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Anton Altaparmakov <aia21@cantab.net>
References: <20060607104724.c5d3d730.akpm@osdl.org> <200606072354.41443.rjw@sisk.pl> <20060607221142.GB6287@elte.hu>
In-Reply-To: <20060607221142.GB6287@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081206.42852.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> could you try the current lock validator combo patch from:
> 
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm1.patch
> 
> does that fix this for you?

With the combo patch applied:

[   58.778002] NTFS driver 2.1.27 [Flags: R/W MODULE].
[   58.891035]
[   58.891039] =====================================================
[   58.913817] [ BUG: possible circular locking deadlock detected! ]
[   58.932102] -----------------------------------------------------
[   58.950388] mount/2175 is trying to acquire lock:
[   58.964491]  (&ni->mrec_lock){--..}, at: [<c0292700>] mutex_lock+0x21/0x24
[   58.985426]
[   58.985428] but task is already holding lock:
[   59.002985]  (&rl->lock){----}, at: [<e0b274d2>] ntfs_map_runlist+0x0/0xb5 [ntfs]
[   59.025738]
[   59.025739] which lock already depends on the new lock,
[   59.045892] which could lead to circular deadlocks!
[   59.060516]
[   59.060517] the existing dependency chain (in reverse order) is:
[   59.083009]
[   59.083010] -> #1 (&rl->lock){----}:
[   59.098464]        [<c012a6b0>] lock_acquire+0x58/0x74
[   59.114489]        [<e0b23c81>] ntfs_readpage+0x344/0x8f1 [ntfs]
[   59.133137]        [<c013642f>] read_cache_page+0x8e/0x137
[   59.150229]        [<e0b32cdf>] map_mft_record+0xda/0x1e5 [ntfs]
[   59.168878]        [<e0b31081>] ntfs_read_locked_inode+0x74/0xeca [ntfs]
[   59.189605]        [<e0b32527>] ntfs_read_inode_mount+0x650/0x88a [ntfs]
[   59.210332]        [<e0b3e923>] ntfs_fill_super+0x9d7/0xe86 [ntfs]
[   59.229500]        [<c0156fee>] get_sb_bdev+0xed/0x14e
[   59.245526]        [<e0b3b49e>] ntfs_get_sb+0x10/0x12 [ntfs]
[   59.263136]        [<c01564b4>] vfs_kern_mount+0x30/0x9e
[   59.279682]        [<c015655b>] do_kern_mount+0x29/0x3d
[   59.295968]        [<c0169cfe>] do_mount+0x6c4/0x702
[   59.311475]        [<c0169d9b>] sys_mount+0x5f/0x96
[   59.326720]        [<c0293dbd>] sysenter_past_esp+0x56/0x8d
[   59.344045]
[   59.344046] -> #0 (&ni->mrec_lock){--..}:
[   59.360797]        [<c012a6b0>] lock_acquire+0x58/0x74
[   59.376822]        [<c0292569>] __mutex_lock_slowpath+0xa7/0x21d
[   59.395447]        [<c0292700>] mutex_lock+0x21/0x24
[   59.411785]        [<e0b32c1e>] map_mft_record+0x19/0x1e5 [ntfs]
[   59.430433]        [<e0b26cc7>] ntfs_map_runlist_nolock+0x48/0x443 [ntfs]
[   59.451420]        [<e0b27559>] ntfs_map_runlist+0x87/0xb5 [ntfs]
[   59.470329]        [<e0b23da7>] ntfs_readpage+0x46a/0x8f1 [ntfs]
[   59.488977]        [<c013642f>] read_cache_page+0x8e/0x137
[   59.506042]        [<e0b3c918>] load_system_files+0x1da/0x180e [ntfs]
[   59.525989]        [<e0b3e9c8>] ntfs_fill_super+0xa7c/0xe86 [ntfs]
[   59.545160]        [<c0156fee>] get_sb_bdev+0xed/0x14e
[   59.561186]        [<e0b3b49e>] ntfs_get_sb+0x10/0x12 [ntfs]
[   59.578795]        [<c01564b4>] vfs_kern_mount+0x30/0x9e
[   59.595341]        [<c015655b>] do_kern_mount+0x29/0x3d
[   59.611625]        [<c0169cfe>] do_mount+0x6c4/0x702
[   59.627133]        [<c0169d9b>] sys_mount+0x5f/0x96
[   59.642379]        [<c0293dbd>] sysenter_past_esp+0x56/0x8d
[   59.659703]
[   59.659704] other info that might help us debug this:
[   59.659706]
[   59.683833] 2 locks held by mount/2175:
[   59.695340]  #0:  (&s->s_umount#17){--..}, at: [<c0156bd7>] sget+0x173/0x384
[   59.716923]  #1:  (&rl->lock){----}, at: [<e0b274d2>] ntfs_map_runlist+0x0/0xb5 [ntfs]
[   59.741054]
[   59.741056] stack backtrace:
[   59.754432]  [<c0102fef>] show_trace_log_lvl+0x54/0xfd
[   59.769927]  [<c0104078>] show_trace+0xd/0x10
[   59.783096]  [<c0104092>] dump_stack+0x17/0x19
[   59.796525]  [<c012892b>] print_circular_bug_tail+0x59/0x64
[   59.813451]  [<c012a1b2>] __lock_acquire+0x7c6/0x97e
[   59.828548]  [<c012a6b0>] lock_acquire+0x58/0x74
[   59.842622]  [<c0292569>] __mutex_lock_slowpath+0xa7/0x21d
[   59.859261]  [<c0292700>] mutex_lock+0x21/0x24
[   59.872792]  [<e0b32c1e>] map_mft_record+0x19/0x1e5 [ntfs]
[   59.889363]  [<e0b26cc7>] ntfs_map_runlist_nolock+0x48/0x443 [ntfs]
[   59.908250]  [<e0b27559>] ntfs_map_runlist+0x87/0xb5 [ntfs]
[   59.925056]  [<e0b23da7>] ntfs_readpage+0x46a/0x8f1 [ntfs]
[   59.941599]  [<c013642f>] read_cache_page+0x8e/0x137
[   59.956736]  [<e0b3c918>] load_system_files+0x1da/0x180e [ntfs]
[   59.974601]  [<e0b3e9c8>] ntfs_fill_super+0xa7c/0xe86 [ntfs]
[   59.991693]  [<c0156fee>] get_sb_bdev+0xed/0x14e
[   60.005897]  [<e0b3b49e>] ntfs_get_sb+0x10/0x12 [ntfs]
[   60.021427]  [<c01564b4>] vfs_kern_mount+0x30/0x9e
[   60.036128]  [<c015655b>] do_kern_mount+0x29/0x3d
[   60.050569]  [<c0169cfe>] do_mount+0x6c4/0x702
[   60.064291]  [<c0169d9b>] sys_mount+0x5f/0x96
[   60.077732]  [<c0293dbd>] sysenter_past_esp+0x56/0x8d
[   60.144343] NTFS volume version 3.1.
[   60.155117] NTFS-fs warning (device hda1): load_system_files(): Unsupported volume flags 0x4000 encountered.
[   60.184594] NTFS-fs error (device hda1): load_system_files(): Volume has unsupported flags set.  Mounting read-only.  Run chkdsk and mount in Windows.
