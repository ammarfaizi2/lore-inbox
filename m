Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUAGRg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUAGRg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:36:56 -0500
Received: from twin.jikos.cz ([213.151.79.26]:55702 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S266250AbUAGRgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:36:51 -0500
Date: Wed, 7 Jan 2004 18:36:49 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: XFS over 7.7TB LVM partition through NFS
Message-ID: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing problems with LVM2 XFS partition in 2.6.0 being accessed 
over NFS. After exporting the filesystem clients start writing files to 
this partition over NFS, and after a short while we get this call trace, 
repeating indefinitely on the screen and the machine stops responding 
(keyboard, network):

Jan  8 01:40:28 storage2 kernel: Call Trace:
Jan  8 01:40:28 storage2 kernel:  [xfs_alloc_read_agf+321/582] xfs_alloc_read_agf+0x141/0x246
Jan  8 01:40:28 storage2 kernel:  [xfs_alloc_fix_freelist+452/1200] xfs_alloc_fix_freelist+0x1c4/0x4b0
Jan  8 01:40:28 storage2 last message repeated 2 times
Jan  8 01:40:28 storage2 kernel:  [xfs_alloc_vextent+711/1324] xfs_alloc_vextent+0x2c7/0x52c
Jan  8 01:40:28 storage2 kernel:  [xfs_bmap_alloc+4129/6483] xfs_bmap_alloc+0x1021/0x1953
Jan  8 01:40:28 storage2 kernel:  [handle_IRQ_event+58/100] handle_IRQ_event+0x3a/0x64
Jan  8 01:40:28 storage2 kernel:  [ata_output_data+187/207] ata_output_data+0xbb/0xcf
Jan  8 01:40:28 storage2 kernel:  [xfs_bmbt_get_state+47/59] xfs_bmbt_get_state+0x2f/0x3b
Jan  8 01:40:28 storage2 kernel:  [xfs_bmapi+1611/5752] xfs_bmapi+0x64b/0x1678
Jan  8 01:40:28 storage2 kernel:  [update_process_times+70/82] update_process_times+0x46/0x52
Jan  8 01:40:28 storage2 kernel:  [xfs_bmbt_get_state+47/59] xfs_bmbt_get_state+0x2f/0x3b
Jan  8 01:40:28 storage2 kernel:  [xfs_log_reserve+142/211] xfs_log_reserve+0x8e/0xd3
Jan  8 01:40:28 storage2 kernel:  [xfs_iomap_write_allocate+594/1341] xfs_iomap_write_allocate+0x252/0x53d
Jan  8 01:40:28 storage2 kernel:  [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
Jan  8 01:40:28 storage2 kernel:  [xfs_iunlock+74/116] xfs_iunlock+0x4a/0x74
Jan  8 01:40:28 storage2 kernel:  [xfs_iomap+1001/1357] xfs_iomap+0x3e9/0x54d
Jan  8 01:40:28 storage2 kernel:  [map_blocks+120/345] map_blocks+0x78/0x159
Jan  8 01:40:28 storage2 kernel:  [page_state_convert+1200/1628] page_state_convert+0x4b0/0x65c
Jan  8 01:40:28 storage2 kernel:  [pagebuf_iorequest+170/354] pagebuf_iorequest+0xaa/0x162
Jan  8 01:40:28 storage2 kernel:  [xfs_xlate_dinode_core+1319/2142] xfs_xlate_dinode_core+0x527/0x85e
Jan  8 01:40:28 storage2 kernel:  [xfs_bdstrat_cb+58/72] xfs_bdstrat_cb+0x3a/0x48
Jan  8 01:40:28 storage2 kernel:  [pagebuf_iostart+72/162] pagebuf_iostart+0x48/0xa2
Jan  8 01:40:28 storage2 kernel:  [xfs_iflush+652/1288] xfs_iflush+0x28c/0x508
Jan  8 01:40:28 storage2 kernel:  [linvfs_writepage+96/282] linvfs_writepage+0x60/0x11a
Jan  8 01:40:28 storage2 kernel:  [mpage_writepages+532/794] mpage_writepages+0x214/0x31a
Jan  8 01:40:28 storage2 kernel:  [linvfs_writepage+0/282] linvfs_writepage+0x0/0x11a
Jan  8 01:40:28 storage2 kernel:  [do_writepages+54/58] do_writepages+0x36/0x3a
Jan  8 01:40:28 storage2 kernel:  [__sync_single_inode+211/545] __sync_single_inode+0xd3/0x221
Jan  8 01:40:28 storage2 kernel:  [sync_sb_inodes+381/675] sync_sb_inodes+0x17d/0x2a3
Jan  8 01:40:28 storage2 kernel:  [writeback_inodes+80/163] writeback_inodes+0x50/0xa3
Jan  8 01:40:28 storage2 kernel:  [balance_dirty_pages+72/318] balance_dirty_pages+0x48/0x13e
Jan  8 01:40:28 storage2 kernel:  [generic_file_aio_write_nolock+1292/3062] generic_file_aio_write_nolock+0x50c/0xbf6
Jan  8 01:40:28 storage2 kernel:  [schedule+612/1485] schedule+0x264/0x5cd
Jan  8 01:40:28 storage2 kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
Jan  8 01:40:28 storage2 kernel:  [xfs_ichgtime+83/300] xfs_ichgtime+0x53/0x12c
Jan  8 01:40:28 storage2 kernel:  [xfs_iunlock+74/116] xfs_iunlock+0x4a/0x74
Jan  8 01:40:28 storage2 kernel:  [xfs_write+637/2192] xfs_write+0x27d/0x890
Jan  8 01:40:28 storage2 kernel:  [xfs_ichgtime+250/300] xfs_ichgtime+0xfa/0x12c
Jan  8 01:40:28 storage2 kernel:  [linvfs_write+213/333] linvfs_write+0xd5/0x14d
Jan  8 01:40:28 storage2 kernel:  [do_sync_write+139/205] do_sync_write+0x8b/0xcd
Jan  8 01:40:28 storage2 kernel:  [update_process_times+70/82] update_process_times+0x46/0x52
Jan  8 01:40:28 storage2 kernel:  [update_wall_time+13/54] update_wall_time+0xd/0x36
Jan  8 01:40:28 storage2 kernel:  [do_IRQ+277/307] do_IRQ+0x115/0x133
Jan  8 01:40:28 storage2 kernel:  [do_sync_write+0/205] do_sync_write+0x0/0xcd
Jan  8 01:40:28 storage2 kernel:  [vfs_write+211/322] vfs_write+0xd3/0x142
Jan  8 01:40:28 storage2 kernel:  [sys_write+66/99] sys_write+0x42/0x63
Jan  8 01:40:28 storage2 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

We are using kernel 2.6.0, LVM2.2.00.08 and device-mapper.1.00.07

The partition is approximately 7.7TB large.

(please CC: me on reply, as I am only subscribed to LKML and not to 
linux-xfs).

Thanks in advance.

-- 
JiKos.
