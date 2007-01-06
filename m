Return-Path: <linux-kernel-owner+w=401wt.eu-S1751319AbXAFJwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXAFJwy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 04:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAFJwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 04:52:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:59718 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbXAFJww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 04:52:52 -0500
From: Torsten Kaiser <kernel@bardioc.dyndns.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Date: Sat, 6 Jan 2007 10:51:59 +0100
User-Agent: KMail/1.9.5
Cc: Fengguang Wu <fengguang.wu@gmail.com>, Jens Axboe <jens.axboe@oracle.com>,
       linux-kernel@vger.kernel.org
References: <368051775.16914@ustc.edu.cn> <20070105195911.37c40e94.akpm@osdl.org>
In-Reply-To: <20070105195911.37c40e94.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701061052.00455.kernel@bardioc.dyndns.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:22445e7a21522a805aae47a273aa1695
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2007 04:59, Andrew Morton wrote:
>
> http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1x.bz2 is basically
> 2.6.20-rc3-mm1, minus git-block.patch.  Can you and Torsten please test
> that, see if the hangs go away?

Works for me too.

Also the locking imbalance reported in Bugzilla-Bug 7775 has disapeared:
[   24.587727] =====================================
[   24.606374] [ BUG: bad unlock balance detected! ]
[   24.620506] -------------------------------------
[   24.634639] swapper/0 is trying to release lock (inode_lock) at:
[   24.652797] [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   24.669345] but there are no more locks to release!
[   24.683997]
[   24.683998] other info that might help us debug this:
[   24.703690] 1 lock held by swapper/0:
[   24.714704]  #0:  (&type->s_umount_key){--..}, at: [<c0168fcc>] 
sget+0x1cc/0x370
[   24.737279]
[   24.737280] stack backtrace:
[   24.750452]  [<c0138274>] print_unlock_inbalance_bug+0x104/0x120
[   24.768558]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   24.785366]  [<c013942a>] trace_hardirqs_on+0xba/0x160
[   24.800876]  [<c012d9a8>] __kernel_text_address+0x18/0x30
[   24.817162]  [<c0104f66>] dump_trace+0x56/0xa0
[   24.830594]  [<c010a4bc>] save_stack_trace+0x1c/0x40
[   24.845583]  [<c01378b0>] save_trace+0x40/0xa0
[   24.859013]  [<c013795b>] add_lock_to_list+0x4b/0xc0
[   24.874004]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   24.890812]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   24.907619]  [<c013abee>] lock_release+0x8e/0x180
[   24.921830]  [<c041fd34>] _spin_unlock+0x14/0x20
[   24.935780]  [<c0184738>] generic_sync_sb_inodes+0xa8/0x2d0
[   24.952589]  [<c0184a03>] sync_inodes_sb+0x83/0xa0
[   24.967058]  [<c016917a>] __fsync_super+0xa/0x70
[   24.980983]  [<c01691e8>] fsync_super+0x8/0x20
[   24.994387]  [<c016922c>] do_remount_sb+0x2c/0x120
[   25.008858]  [<c01697f1>] get_sb_single+0x61/0xd0
[   25.023067]  [<c01a5540>] sysfs_fill_super+0x0/0xb0
[snip]

I now see this, but the system works:
[   11.800000] Freeing unused kernel memory: 204k freed
[   35.300000]
[   35.300000] =============================================
[   35.300000] [ INFO: possible recursive locking detected ]
[   35.300000] 2.6.20-rc3-mm1x #0
[   35.300000] ---------------------------------------------
[   35.300000] mount/3795 is trying to acquire lock:
[   35.300000]  (&(&ip->i_lock)->mr_lock){----}, at: [<c020a1f1>] 
xfs_ilock+0x71/0xa0
[   35.300000]
[   35.300000] but task is already holding lock:
[   35.300000]  (&(&ip->i_lock)->mr_lock){----}, at: [<c020a1f1>] 
xfs_ilock+0x71/0xa0
[   35.300000]
[   35.300000] other info that might help us debug this:
[   35.300000] 2 locks held by mount/3795:
[   35.300000]  #0:  (&inode->i_mutex){--..}, at: [<c01721df>] 
open_namei+0xef/0x610
[   35.300000]  #1:  (&(&ip->i_lock)->mr_lock){----}, at: [<c020a1f1>] 
xfs_ilock+0x71/0xa0
[   35.300000]
[   35.300000] stack backtrace:
[   35.300000]  [<c013a256>] __lock_acquire+0xa96/0x1020
[   35.300000]  [<c01393fa>] debug_check_no_locks_freed+0xca/0x180
[   35.300000]  [<c013a837>] lock_acquire+0x57/0x70
[   35.300000]  [<c020a1f1>] xfs_ilock+0x71/0xa0
[   35.300000]  [<c0133c3d>] down_write+0x3d/0x60
[   35.300000]  [<c020a1f1>] xfs_ilock+0x71/0xa0
[   35.300000]  [<c020a1f1>] xfs_ilock+0x71/0xa0
[   35.300000]  [<c020ae43>] xfs_iget+0x463/0x6f0
[   35.300000]  [<c02247e4>] xfs_trans_iget+0x104/0x170
[   35.300000]  [<c020f4ce>] xfs_ialloc+0xce/0x540
[   35.300000]  [<c0225395>] xfs_dir_ialloc+0x85/0x2e0
[   35.300000]  [<c020a1f1>] xfs_ilock+0x71/0xa0
[   35.300000]  [<c0133c3d>] down_write+0x3d/0x60
[   35.300000]  [<c022c125>] xfs_create+0x395/0x6c0
[   35.300000]  [<c020a155>] xfs_iunlock+0x75/0x90
[   35.300000]  [<c0236901>] xfs_vn_mknod+0x2c1/0x480
[   35.300000]  [<c01632c6>] kmem_cache_free+0x66/0x90
[   35.300000]  [<c013928a>] trace_hardirqs_on+0xba/0x160
[   35.300000]  [<c01f62e4>] xfs_da_brelse+0x74/0xc0
[   35.300000]  [<c01fd7f7>] xfs_dir2_leaf_lookup_int+0x237/0x270
[   35.300000]  [<c01fdd0e>] xfs_dir2_leaf_lookup+0x1e/0xa0
[   35.300000]  [<c01fa59e>] xfs_dir_lookup+0xee/0x100
[   35.300000]  [<c0229456>] xfs_access+0x26/0x50
[   35.300000]  [<c0178450>] d_rehash+0x20/0x50
[   35.300000]  [<c017926a>] d_alloc+0x12a/0x1d0
[   35.300000]  [<c016f374>] vfs_create+0xd4/0x130
[   35.300000]  [<c01726ab>] open_namei+0x5bb/0x610
[   35.300000]  [<c0165a0f>] get_unused_fd+0x1f/0xb0
[   35.300000]  [<c0154539>] __handle_mm_fault+0x179/0x8b0
[   35.300000]  [<c0165d4e>] do_filp_open+0x2e/0x60
[   35.300000]  [<c041fef4>] _spin_unlock+0x14/0x20
[   35.300000]  [<c0165a8c>] get_unused_fd+0x9c/0xb0
[   35.300000]  [<c0165dca>] do_sys_open+0x4a/0xe0
[   35.300000]  [<c0165e9c>] sys_open+0x1c/0x20
[   35.300000]  [<c0104022>] sysenter_past_esp+0x5f/0x99
[   35.300000]  =======================
[   37.390000] kjournald starting.  Commit interval 5 seconds
