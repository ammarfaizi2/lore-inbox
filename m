Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUI0U5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUI0U5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUI0Uzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:55:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:54699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267367AbUI0Uwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:52:46 -0400
Subject: Re: kernel 2.6.9-rc2-mm1 system hangup
From: Chris Mason <mason@suse.com>
To: Roel van der Made <roel@telegraafnet.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040924075416.GH7334@telegraafnet.nl>
References: <20040924075416.GH7334@telegraafnet.nl>
Content-Type: text/plain
Date: Mon, 27 Sep 2004 16:53:23 -0400
Message-Id: <1096318403.19249.46.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 09:54 +0200, Roel van der Made wrote:
> Hi there,
> 
> I'm having problems with servers hanging spontanely without any logging
> or console output. They're running a 2.6.9-rc2-mm1 kernel and are Dell
> PowerEdge 1750 dual Xeon servers with 4G ECC Reg. and 3 disks in
> sw-raid 5.
> 
> The systems still responds to ping and listens to ie. the mysql port, but does
> not give a MySQL prompt, seems the disks are in deadlock state or so ?
> 
> Using the sysrq showTasks I see the following traces (I will only show
> some since the total log is much too long to show here, the full log
> including the .config can be found on http://roel.net/backtrace/):

For reiserfs deadlocks, it's usually the task stuck in do_journal_end
that everyone else is waiting on.  Those two procs are below, anyone
have ideas where the md code is stuck?

pdflush       D 00000008     0    57     15            59    56 (L-TLB)
f7cbbba4 00000046 f7cbbb94 00000008 00000001 00000008 00000008 94891fbc
       0000003e f7c77000 f7cbbc28 00081600 f650fa80 f7e7db50 f7cbbc28
00000000
       f7c77000 00000008 00000000 b31919b8 0000000d c2fba020 00000001
f7c77154
Call Trace:
 [<c026942f>] as_update_arq+0x2e/0x75
 [<c0362a8c>] wait_for_completion+0x90/0xef
 [<c011818f>] default_wake_function+0x0/0x12
 [<c011818f>] default_wake_function+0x0/0x12
 [<c0261b6f>] elv_merged_request+0x1f/0x21
 [<c02fd432>] sync_page_io+0xa3/0xb1
 [<c02fd373>] bi_complete+0x0/0x1c
 [<c02fec51>] write_disk_sb+0x78/0xb0
 [<c02fecb4>] sync_sbs+0x2b/0x43
 [<c02fed75>] md_update_sb+0xa9/0xdb
 [<c0117cb3>] load_balance_newidle+0x35/0x98
 [<c03021a8>] md_write_start+0x95/0xa0
 [<c02f9c92>] make_request+0x1df/0x226
 [<c026508f>] generic_make_request+0x113/0x194
 [<c01395d2>] mempool_alloc+0x8b/0x15d
 [<c012f9ab>] autoremove_wake_function+0x0/0x57
 [<c0265180>] submit_bio+0x70/0x121
 [<c0159707>] bio_alloc+0xd9/0x1ac
 [<c0158fba>] submit_bh+0xe0/0x133
 [<c0159075>] ll_rw_block+0x68/0x88
 [<c01ae555>] flush_commit_list+0x454/0x48f
 [<c01b30b1>] do_journal_end+0x898/0xb63
 [<c013caa9>] pdflush+0x0/0x2c
 [<c01b1e39>] journal_end_sync+0x4d/0x89
 [<c019e9e5>] reiserfs_sync_fs+0x65/0xa8
 [<c015b041>] sync_supers+0x9b/0x9d
 [<c013befb>] wb_kupdate+0x60/0x13b
 [<c013c9d7>] __pdflush+0xbf/0x191
 [<c013cad1>] pdflush+0x28/0x2c
 [<c013be9b>] wb_kupdate+0x0/0x13b
 [<c013caa9>] pdflush+0x0/0x2c
 [<c012f4e5>] kthread+0xb7/0xbd
 [<c012f42e>] kthread+0x0/0xbd
 [<c0103f59>] kernel_thread_helper+0x5/0xb

and

munin-node    D 00000008     0 23920    978         23921 23533 (NOTLB)
e9cd59a0 00000086 e9cd598c 00000008 00000003 00000008 00000008 f753ac80
       00000007 ea202550 e9cd5a24 00201c00 f6466300 00000082 c04830c0 f6449550
       00000000 f6888e1c 00000008 c45a45e6 0000000d c2fca020 00000003 ea2026a4
Call Trace:
 [<c0362a8c>] wait_for_completion+0x90/0xef
 [<c011818f>] default_wake_function+0x0/0x12
 [<c015701f>] __find_get_block+0x5e/0xc2
 [<c011818f>] default_wake_function+0x0/0x12
 [<c01a76d6>] is_tree_node+0x6f/0x71
 [<c02fd432>] sync_page_io+0xa3/0xb1
 [<c02fd373>] bi_complete+0x0/0x1c
 [<c02fec51>] write_disk_sb+0x78/0xb0
 [<c02fecb4>] sync_sbs+0x2b/0x43
 [<c02fed75>] md_update_sb+0xa9/0xdb
 [<c0193ca4>] inode2sd+0xcc/0x116
 [<c03021a8>] md_write_start+0x95/0xa0
 [<c02f9c92>] make_request+0x1df/0x226
 [<c026508f>] generic_make_request+0x113/0x194
 [<c01395d2>] mempool_alloc+0x8b/0x15d
 [<c012f9ab>] autoremove_wake_function+0x0/0x57
 [<c0265180>] submit_bio+0x70/0x121
 [<c015701f>] __find_get_block+0x5e/0xc2
 [<c0159707>] bio_alloc+0xd9/0x1ac
 [<c01a76d6>] is_tree_node+0x6f/0x71
 [<c0158fba>] submit_bh+0xe0/0x133
 [<c01ad9c8>] submit_logged_buffer+0x5e/0x62
 [<c01adad0>] write_chunk+0x3d/0x47
 [<c01af127>] kupdate_transactions+0x129/0x14c
 [<c0157000>] __find_get_block+0x3f/0xc2
 [<c015e4d9>] inode_get_bytes+0x3d/0x54
 [<c012484c>] run_timer_softirq+0x109/0x19d
 [<c01180b8>] scheduler_tick+0x192/0x269
 [<c0156f8f>] bh_lru_install+0xb0/0xe2
 [<c01af209>] flush_used_journal_lists+0xbf/0xe1
 [<c01b27fa>] flush_old_journal_lists+0x3f/0x5e
 [<c01b2fcf>] do_journal_end+0x7b6/0xb63
 [<c01b1bd5>] journal_end+0xa2/0xc0
 [<c019f66e>] reiserfs_dirty_inode+0x8c/0xd3
 [<c013a30b>] __rmqueue+0xe8/0x139
 [<c0174982>] __mark_inode_dirty+0x1d2/0x1d7
 [<c013a38b>] rmqueue_bulk+0x2f/0x6f
 [<c016ea47>] inode_update_time+0xac/0xd6
 [<c019a218>] reiserfs_file_write+0x2f4/0x7a3
 [<c0145716>] do_wp_page+0x20a/0x380
 [<c01442ed>] pte_alloc_map+0xaa/0xd1
 [<c0146658>] handle_mm_fault+0x15c/0x172
 [<c01154fd>] do_page_fault+0x19f/0x5c9
 [<c01280e9>] do_sigaction+0x1e7/0x203
 [<c012484c>] run_timer_softirq+0x109/0x19d
 [<c0154905>] vfs_write+0xbc/0x127
 [<c030a069>] sys_socketcall+0xf7/0x256
 [<c0154a41>] sys_write+0x51/0x80
 [<c0105dab>] syscall_call+0x7/0xb

