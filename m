Return-Path: <linux-kernel-owner+w=401wt.eu-S932692AbXAJDE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbXAJDE5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXAJDE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:04:57 -0500
Received: from ns.suse.de ([195.135.220.2]:46833 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692AbXAJDE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:04:56 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 10 Jan 2007 14:04:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17828.22466.495121.918754@notabene.brown>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - RFC] allow setting vm_dirty below 1% for large memory
 machines
In-Reply-To: message from Andrew Morton on Tuesday January 9
References: <17827.22798.625018.673326@notabene.brown>
	<20070109021017.447b682d.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday January 9, akpm@osdl.org wrote:
> 
> Could be IO scheduler borkage, could be ext3 borkage.  A well-timed sysrq-T
> will tell us, and is worth doing (please).

The problem has been reported against reiserfs and ext3, and against
SLES9 and SLES10.  The big machine I can test with is currently
running SLES9 (2.6.5 (plus lots of stuff)) and has a reiserfs
filesystem.  In that config, the blocked process seems to be:

Jan 10 02:19:18 macallan kernel: sh            D a000000100037b60     0  9852   9815                     (NOTLB)
Jan 10 02:19:18 macallan kernel:
Jan 10 02:19:18 macallan kernel: Call Trace:
Jan 10 02:19:18 macallan kernel:  [<a000000100098970>] schedule+0xf50/0x2b60
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da79c0 bsp=e000001fe9da1550
Jan 10 02:19:18 macallan kernel:  [<a000000100037b60>] __down+0x200/0x320
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da79f0 bsp=e000001fe9da14e8
Jan 10 02:19:18 macallan kernel:  [<a00000021c2e0f30>] do_journal_begin_r+0x3b0/0x880 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7a20 bsp=e000001fe9da1468
Jan 10 02:19:18 macallan kernel:  [<a00000021c2e1920>] journal_begin+0x260/0x360 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7a60 bsp=e000001fe9da1430
Jan 10 02:19:18 macallan kernel:  [<a00000021c2b0ac0>] reiserfs_dirty_inode+0xe0/0x240 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7a60 bsp=e000001fe9da1408
Jan 10 02:19:18 macallan kernel:  [<a0000001001c76f0>] __mark_inode_dirty+0x330/0x340
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7aa0 bsp=e000001fe9da13c0
Jan 10 02:19:18 macallan kernel:  [<a0000001001b4400>] __update_atime+0x180/0x200
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7aa0 bsp=e000001fe9da1380
Jan 10 02:19:18 macallan kernel:  [<a000000100111e80>] do_generic_mapping_read+0x8a0/0x1300
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7ac0 bsp=e000001fe9da12b0
Jan 10 02:19:18 macallan kernel:  [<a0000001001141c0>] __generic_file_aio_read+0x2c0/0x400
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7b20 bsp=e000001fe9da1240
Jan 10 02:19:18 macallan kernel:  [<a000000100114550>] generic_file_read+0x110/0x160
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7b40 bsp=e000001fe9da1200
Jan 10 02:19:18 macallan kernel:  [<a00000010016ebb0>] vfs_read+0x250/0x3a0
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7c30 bsp=e000001fe9da11a8
Jan 10 02:19:18 macallan kernel:  [<a00000010018ddb0>] kernel_read+0x50/0x80
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7c30 bsp=e000001fe9da1168
Jan 10 02:19:18 macallan kernel:  [<a00000010018f490>] do_execve+0x210/0x760
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7c40 bsp=e000001fe9da10e8
Jan 10 02:19:18 macallan kernel:  [<a0000001000184a0>] sys_execve+0x60/0xc0
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7e30 bsp=e000001fe9da10b0
Jan 10 02:19:18 macallan kernel:  [<a00000010000f770>] ia64_execve+0x30/0x160
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7e30 bsp=e000001fe9da1060
Jan 10 02:19:18 macallan kernel:  [<a000000100010060>] ia64_ret_from_syscall+0x0/0x20
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da7e30 bsp=e000001fe9da1060
Jan 10 02:19:18 macallan kernel:  [<a000000000010640>] 0xa000000000010640
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe9da8000 bsp=e000001fe9da1060

while the background generate-dirty-data process is:

Jan 10 02:19:18 macallan kernel: cp            D a000000100037b60     0  9814   9800                     (NOTLB)
Jan 10 02:19:18 macallan kernel:
Jan 10 02:19:18 macallan kernel: Call Trace:
Jan 10 02:19:18 macallan kernel:  [<a000000100098970>] schedule+0xf50/0x2b60
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97b50 bsp=e000001fe2f91788
Jan 10 02:19:18 macallan kernel:  [<a000000100037b60>] __down+0x200/0x320
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97b80 bsp=e000001fe2f91720
Jan 10 02:19:18 macallan kernel:  [<a00000021c2d6340>] flush_commit_list+0x9e0/0xec0 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97bb0 bsp=e000001fe2f91678
Jan 10 02:19:18 macallan kernel:  [<a00000021c2d69c0>] flush_older_commits+0x1a0/0x220 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97bc0 bsp=e000001fe2f91628
Jan 10 02:19:18 macallan kernel:  [<a00000021c2d5f40>] flush_commit_list+0x5e0/0xec0 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97bc0 bsp=e000001fe2f91578
Jan 10 02:19:18 macallan kernel:  [<a00000021c2e08d0>] do_journal_end+0x18f0/0x1ba0 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97bd0 bsp=e000001fe2f91428
Jan 10 02:19:18 macallan kernel:  [<a00000021c2980c0>] restart_transaction+0x100/0x1e0 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97be0 bsp=e000001fe2f913e8
Jan 10 02:19:18 macallan kernel:  [<a00000021c2a1130>] reiserfs_allocate_blocks_for_region+0x410/0x2d40 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97be0 bsp=e000001fe2f91300
Jan 10 02:19:18 macallan kernel:  [<a00000021c2a45f0>] reiserfs_file_write+0xb90/0x1020 [reiserfs]
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97d10 bsp=e000001fe2f91218
Jan 10 02:19:18 macallan kernel:  [<a00000010016e190>] vfs_write+0x250/0x3a0
Jan 10 02:19:18 macallan kernel:                                 sp=e000001fe2f97de0 bsp=e000001fe2f911c0
Jan 10 02:19:18 macallan kernel:  [<a00000010016e700>] sys_write+0x140/0x220


and pdflush is doing:

Jan 10 02:19:17 macallan kernel: pdflush       D a00000010009b410     0    81     10            83    80 (L-TLB)
Jan 10 02:19:17 macallan kernel:
Jan 10 02:19:17 macallan kernel: Call Trace:
Jan 10 02:19:17 macallan kernel:  [<a000000100098970>] schedule+0xf50/0x2b60
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e179f0 bsp=e000000039e11710
Jan 10 02:19:17 macallan kernel:  [<a00000010009b410>] io_schedule+0xb0/0x1a0
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17a20 bsp=e000000039e116e8
Jan 10 02:19:17 macallan kernel:  [<a0000001003e9aa0>] get_request_wait+0x200/0x240
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17a20 bsp=e000000039e116a8
Jan 10 02:19:17 macallan kernel:  [<a0000001003ea5c0>] __make_request+0x340/0xf40
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17a80 bsp=e000000039e11640
Jan 10 02:19:17 macallan kernel:  [<a0000001003e6f40>] generic_make_request+0x2c0/0x440
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17a90 bsp=e000000039e115f0
Jan 10 02:19:17 macallan kernel:  [<a0000001003e7220>] submit_bio+0x160/0x300
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17ab0 bsp=e000000039e115b8
Jan 10 02:19:17 macallan kernel:  [<a000000100172d40>] submit_bh+0x360/0x420
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17ad0 bsp=e000000039e11578
Jan 10 02:19:17 macallan kernel:  [<a00000021c2d4330>] write_ordered_chunk+0x110/0x180 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17ad0 bsp=e000000039e11530
Jan 10 02:19:17 macallan kernel:  [<a00000021c2d30b0>] add_to_chunk+0xb0/0x140 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17ad0 bsp=e000000039e114e8
Jan 10 02:19:17 macallan kernel:  [<a00000021c2d5610>] write_ordered_buffers+0x6d0/0x9c0 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17ad0 bsp=e000000039e11470
Jan 10 02:19:17 macallan kernel:  [<a00000021c2d5c10>] flush_commit_list+0x2b0/0xec0 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17c00 bsp=e000000039e113c0
Jan 10 02:19:17 macallan kernel:  [<a00000021c2d6ec0>] check_journal_end+0x480/0x740 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17c10 bsp=e000000039e11358
Jan 10 02:19:17 macallan kernel:  [<a00000021c2df1c0>] do_journal_end+0x1e0/0x1ba0 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17c10 bsp=e000000039e11208
Jan 10 02:19:17 macallan kernel:  [<a00000021c2b0480>] reiserfs_write_super+0x1a0/0x200 [reiserfs]
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17c20 bsp=e000000039e111e0
Jan 10 02:19:17 macallan kernel:  [<a000000100181950>] sync_supers+0x290/0x2a0
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17c60 bsp=e000000039e111a0
Jan 10 02:19:17 macallan kernel:  [<a000000100121c80>] wb_kupdate+0xa0/0x360
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17c60 bsp=e000000039e11148
Jan 10 02:19:17 macallan kernel:  [<a000000100122dc0>] pdflush+0x320/0x580
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17de0 bsp=e000000039e110b0
Jan 10 02:19:17 macallan kernel:  [<a0000001000ddc40>] kthread+0x220/0x280
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17e10 bsp=e000000039e11068
Jan 10 02:19:17 macallan kernel:  [<a000000100018200>] kernel_thread_helper+0xe0/0x100
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17e30 bsp=e000000039e11040
Jan 10 02:19:17 macallan kernel:  [<a000000100009060>] start_kernel_thread+0x20/0x40
Jan 10 02:19:17 macallan kernel:                                 sp=e000000039e17e30 bsp=e000000039e11040


I'll see about getting an ext3 trace on a more recent kernel.


NeilBrown
