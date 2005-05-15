Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVEOBfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVEOBfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 21:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEOBee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 21:34:34 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:16604 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261534AbVEOBcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 21:32:51 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Karol Kozimor <sziwan@hell.org.pl>
Date: Sun, 15 May 2005 11:32:24 +1000
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Re: [XFS] 2.6.12-rc4: Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
Message-ID: <20050515013224.GL31449@cse.unsw.EDU.AU>
References: <20050512193647.GA22976@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512193647.GA22976@hell.org.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karol

The guys from SGI suggested this patch, it reduces the messages but
not completely on our Ia64 box.

[SGI]
We hit this internally as well with our tests.  Christoph suggested the
following:

We're trylocking now if wbc->sync_mode is WB_SYNC_NONE, so having
page_dirty set on startio isn't fatal.  It should go away with the patch
below:

Index: linux-2.6/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_aops.c  2005-05-06
13:36:10.000000000 +0200
+++ linux-2.6/fs/xfs/linux-2.6/xfs_aops.c       2005-05-10
10:33:37.000000000 +0200
@@ -886,7 +886,7 @@
                SetPageUptodate(page);

        if (startio) {
-               WARN_ON(page_dirty);
+               WARN_ON(page_dirty && wbc->sync_mode != WB_SYNC_NONE);
                xfs_submit_page(page, wbc, bh_arr, cnt, 0, !page_dirty);
        }


On Thu, 12 May 2005, Karol Kozimor wrote:

> Hi,
> Just happened to notice, a couple of WARNs and possibly minor fs
> corruption (after the system booted I went straight with SysRq+U, B and
> still got some garbage in the logs).
> Traces below.
> 
> -- 
> Karol 'sziwan' Kozimor
> sziwan@hell.org.pl
> 
> VFS: Mounted root (xfs filesystem) readonly.
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01d271c>] xfs_mod_incore_sb_batch+0x5c/0xc0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01e4369>] pagebuf_rele+0x19/0x100
>  [<c01d7b0d>] xfs_trans_unlock_chunk+0x9d/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c014500e>] handle_mm_fault+0xce/0x170
>  [<c0111164>] do_page_fault+0x174/0x562
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c01754de>] sync_inodes_sb+0x6e/0xa0
>  [<c015432a>] fsync_super+0xa/0x80
>  [<c015994d>] do_remount_sb+0x3d/0xe0
>  [<c016f163>] do_remount+0x93/0xd0
>  [<c016fb0a>] do_mount+0x16a/0x180
>  [<c016f939>] copy_mount_options+0x59/0xc0
>  [<c016fe6f>] sys_mount+0x7f/0xd0
>  [<c01030f5>] syscall_call+0x7/0xb
> [...]
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01e49d4>] _pagebuf_ioapply+0x1d4/0x280
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027ae30>] generic_make_request+0x150/0x1f0
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01e49d4>] _pagebuf_ioapply+0x1d4/0x280
>  [<c01e4369>] pagebuf_rele+0x19/0x100
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c01d67c6>] xfs_trans_first_ail+0x16/0x30
>  [<c01c8193>] xfs_log_need_covered+0x73/0xc0
>  [<c01d9d37>] xfs_syncsub+0x117/0x270
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0175443>] writeback_inodes+0xf3/0x120
>  [<c013bc95>] wb_kupdate+0x95/0x100
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c013bc00>] wb_kupdate+0x0/0x100
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c0112ada>] scheduler_tick+0x18a/0x380
>  [<c011f122>] run_timer_softirq+0x132/0x1d0
>  [<c016cb94>] generic_forget_inode+0x54/0x140
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c01754de>] sync_inodes_sb+0x6e/0xa0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c015432a>] fsync_super+0xa/0x80
>  [<c015994d>] do_remount_sb+0x3d/0xe0
>  [<c0159aca>] do_emergency_remount+0xda/0xf0
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c01599f0>] do_emergency_remount+0x0/0xf0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c0112ada>] scheduler_tick+0x18a/0x380
>  [<c011f122>] run_timer_softirq+0x132/0x1d0
>  [<c016cb94>] generic_forget_inode+0x54/0x140
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c01754de>] sync_inodes_sb+0x6e/0xa0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c015432a>] fsync_super+0xa/0x80
>  [<c015994d>] do_remount_sb+0x3d/0xe0
>  [<c0159aca>] do_emergency_remount+0xda/0xf0
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c01599f0>] do_emergency_remount+0x0/0xf0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c0112ada>] scheduler_tick+0x18a/0x380
>  [<c011f122>] run_timer_softirq+0x132/0x1d0
>  [<c016cb94>] generic_forget_inode+0x54/0x140
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c01754de>] sync_inodes_sb+0x6e/0xa0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c015432a>] fsync_super+0xa/0x80
>  [<c015994d>] do_remount_sb+0x3d/0xe0
>  [<c0159aca>] do_emergency_remount+0xda/0xf0
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c01599f0>] do_emergency_remount+0x0/0xf0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
>  [<c01eaad6>] linvfs_write_inode+0x36/0x70
>  [<c0174dba>] __sync_single_inode+0x6a/0x200
>  [<c0174fb0>] __writeback_single_inode+0x60/0x150
>  [<c0112ada>] scheduler_tick+0x18a/0x380
>  [<c011f122>] run_timer_softirq+0x132/0x1d0
>  [<c016cb94>] generic_forget_inode+0x54/0x140
>  [<c017523d>] sync_sb_inodes+0x19d/0x2b0
>  [<c01754de>] sync_inodes_sb+0x6e/0xa0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c015432a>] fsync_super+0xa/0x80
>  [<c015994d>] do_remount_sb+0x3d/0xe0
>  [<c0159aca>] do_emergency_remount+0xda/0xf0
>  [<c013c575>] __pdflush+0xd5/0x200
>  [<c013c6ba>] pdflush+0x1a/0x20
>  [<c01599f0>] do_emergency_remount+0x0/0xf0
>  [<c013c6a0>] pdflush+0x0/0x20
>  [<c0129f38>] kthread+0x98/0xa0
>  [<c0129ea0>] kthread+0x0/0xa0
>  [<c010133d>] kernel_thread_helper+0x5/0x18
> Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
>  [<c01e2a14>] xfs_page_state_convert+0x334/0x660
>  [<c027af27>] submit_bio+0x57/0xf0
>  [<c012a430>] autoremove_wake_function+0x0/0x50
>  [<c01f4e49>] radix_tree_gang_lookup_tag+0x49/0x70
>  [<c01e332c>] linvfs_writepage+0x5c/0xf0
>  [<c017678f>] mpage_writepages+0x23f/0x3a0
>  [<c01e4674>] pagebuf_iostart+0x44/0xb0
>  [<c01e32d0>] linvfs_writepage+0x0/0xf0
>  [<c01df687>] xfs_inode_flush+0xd7/0x1d0
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
