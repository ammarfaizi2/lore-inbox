Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTJWVuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJWVuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:50:07 -0400
Received: from twin.jikos.cz ([213.151.79.26]:58603 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S261798AbTJWVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:50:00 -0400
Date: Thu, 23 Oct 2003 23:49:59 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org
cc: linux-xfs@oss.sgi.com
Subject: 2.6.0-test8 XFS bug
Message-ID: <Pine.LNX.4.58.0310232336180.6971@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've installed 2.6.0-test8 on machine attached to HW raid, made 5.5TB 
partition (using LVM) and made XFS filesystem on this partition. This 
partittion was exported to cca 25 nodes. I started some stress tests 
(writing and reading files through NFS) from these nodes to this partition 
and went home.
The other day I found out that syslog filled up /var/log/messages with 
backtraces (see below), and the XFS filesystem went just totally crappy 
(for example when I had some file on this partition, and did simple cp to 
another name, the content of the new file was corrupted (NFS was not 
involved in this)).

When I make this partition ext3, things seem to work well.

The backtrace:

Oct 22 13:12:56 storage2 kernel: 0x0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Oct 22 13:12:56 storage2 kernel: Filesystem "dm-0": XFS internal error xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01e8f5c
Oct 22 13:12:56 storage2 kernel: Call Trace:
Oct 22 13:12:56 storage2 kernel:  [<c01e93d4>] xfs_alloc_read_agf+0x19e/0x214
Oct 22 13:12:56 storage2 kernel:  [<c01e8f5c>] xfs_alloc_fix_freelist+0x458/0x46e
Oct 22 13:12:56 storage2 last message repeated 2 times
Oct 22 13:12:56 storage2 kernel:  [<c023cdf8>] xfs_trans_log_buf+0x6e/0xa8
Oct 22 13:12:56 storage2 kernel:  [<c0204733>] xfs_bmbt_get_state+0x2f/0x3c
Oct 22 13:12:56 storage2 kernel:  [<c01e973e>] xfs_alloc_vextent+0x2f4/0x520
Oct 22 13:12:56 storage2 kernel:  [<c01f89d9>] xfs_bmap_alloc+0x8eb/0x1856
Oct 22 13:12:56 storage2 kernel:  [<c02515b0>] xfs_iomap_write_delay+0x35e/0x40a
Oct 22 13:12:56 storage2 kernel:  [<c0204733>] xfs_bmbt_get_state+0x2f/0x3c
Oct 22 13:12:56 storage2 kernel:  [<c01fd9f9>] xfs_bmapi+0xfaf/0x165c
Oct 22 13:12:56 storage2 kernel:  [<c0250581>] _xfs_imap_to_bmap+0x35/0x28e
Oct 22 13:12:56 storage2 kernel:  [<c0204733>] xfs_bmbt_get_state+0x2f/0x3c
Oct 22 13:12:56 storage2 kernel:  [<c01fb286>] xfs_bmap_do_search_extents+0xb8/0x3f0
Oct 22 13:12:56 storage2 kernel:  [<c023c1f5>] xfs_trans_unlocked_item+0x39/0x58
Oct 22 13:12:56 storage2 kernel:  [<c022bbaf>] xfs_log_reserve+0xc1/0xc6
Oct 22 13:12:56 storage2 kernel:  [<c0251911>] xfs_iomap_write_allocate+0x2b5/0x4c4
Oct 22 13:12:56 storage2 kernel:  [<c0134194>] generic_file_aio_write_nolock+0x244/0xa9e
Oct 22 13:12:56 storage2 kernel:  [<c0250beb>] xfs_iomap+0x411/0x54a
Oct 22 13:12:56 storage2 kernel:  [<c024b63c>] map_blocks+0x72/0x128
Oct 22 13:12:56 storage2 kernel:  [<c024c770>] page_state_convert+0x4fa/0x626
Oct 22 13:12:56 storage2 kernel:  [<c03f389b>] ip_local_deliver+0x1b7/0x1c8
Oct 22 13:12:56 storage2 kernel:  [<c03f3bed>] ip_rcv+0x341/0x4a2
Oct 22 13:12:56 storage2 kernel:  [<c024cfb0>] linvfs_writepage+0x60/0x10c
Oct 22 13:12:56 storage2 kernel:  [<c016fac9>] mpage_writepages+0x21f/0x2f6
Oct 22 13:12:56 storage2 kernel:  [<c03e04cc>] process_backlog+0x6e/0xfe
Oct 22 13:12:56 storage2 kernel:  [<c024cf50>] linvfs_writepage+0x0/0x10c
Oct 22 13:12:56 storage2 kernel:  [<c013773c>] do_writepages+0x36/0x38
Oct 22 13:12:56 storage2 kernel:  [<c01320d7>] __filemap_fdatawrite+0xe3/0xec
Oct 22 13:12:57 storage2 kernel:  [<c01320f7>] filemap_fdatawrite+0x17/0x1c
Oct 22 13:12:57 storage2 kernel:  [<c01c2c05>] nfsd_sync+0x63/0xc0
Oct 22 13:12:57 storage2 kernel:  [<c014de20>] vfs_writev+0x60/0x64
Oct 22 13:12:57 storage2 kernel:  [<c01c330f>] nfsd_write+0x1c7/0x356
Oct 22 13:12:57 storage2 kernel:  [<c0417495>] udp_sendpage+0x16d/0x2d0
Oct 22 13:12:57 storage2 kernel:  [<c03dd0ab>] skb_copy_and_csum_bits+0x1e3/0x2b0
Oct 22 13:12:57 storage2 kernel:  [<c01c0424>] nfsd_proc_write+0xa8/0x122
Oct 22 13:12:57 storage2 kernel:  [<c01bf4cc>] nfsd_dispatch+0xe8/0x1e8
Oct 22 13:12:57 storage2 kernel:  [<c01bf3e4>] nfsd_dispatch+0x0/0x1e8
Oct 22 13:12:57 storage2 kernel:  [<c04357ed>] svc_process+0x4f9/0x684
Oct 22 13:12:57 storage2 kernel:  [<c01bf21d>] nfsd+0x1ff/0x3c6
Oct 22 13:12:57 storage2 kernel:  [<c01bf01e>] nfsd+0x0/0x3c6
Oct 22 13:12:57 storage2 kernel:  [<c01070cd>] kernel_thread_helper+0x5/0xc

P.S.: I am subscribed only to LKML, so please if replying to linux-xfs 
mailing list, be so kind and CC: me.

Thanks.

-- 
JiKos.
