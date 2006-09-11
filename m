Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWIKUmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWIKUmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWIKUmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:42:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:48035 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751327AbWIKUmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:42:08 -0400
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060911094641.GA3336@atrey.karlin.mff.cuni.cz>
References: <20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
	 <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
	 <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906172733.GC14345@atrey.karlin.mff.cuni.cz>
	 <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>
	 <20060907223048.GD22549@atrey.karlin.mff.cuni.cz>
	 <4500F2B2.4010204@us.ibm.com>
	 <20060908082531.GA28397@atrey.karlin.mff.cuni.cz>
	 <45017FAA.1070203@us.ibm.com>
	 <20060911094641.GA3336@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed; boundary="=-0yHj/92wgGAdamjiIVuZ"
Date: Mon, 11 Sep 2006 13:45:28 -0700
Message-Id: <1158007528.30318.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0yHj/92wgGAdamjiIVuZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-09-11 at 11:46 +0200, Jan Kara wrote:
...
> > 
> > I don't have any performance tests handy. We have some automated tests I 
> > can schedule to run to verify the stability aspects.
>   OK. I've run IOZONE rewrite throughput test on my computer with
> iozone -t 10 -i 0 -s 10M -e
>   2.6.18-rc6 and the same kernel + my patch seem to give almost the same
> results. The strange thing was that both in vanilla and patched kernel there
> were several runs where a write througput (when iozone was creating the file)
> was suddenly 10% of the usual value (18MB/s vs. 2MB/s). The rewrite numbers
> were always fine. Maybe that has something to do with block allocation
> code. Anyway, it is not a regression of my patch so unless your test
> finds some problem I think the patch should be ready for inclusion into
> -mm...

Your patch seems to be working fine. I haven't found any major
regression yet. 

I spent lot of time trying to reproduce the problem with buffer-debug
Andrew sent out - I really wanted to get to bottom of whats really
happening here (since your patch made it go away).

Yes. Your theory is correct. journal_dirty_data() is moving the
buffer-head from commited transaction to current one and
journal_unmap_buffer() is discarding and cleaning up the buffer-head.
Later set_page_dirty() dirties the buffer-head there by causing
BUG() in submit_bh().

Here is the buffer-trace-debug output to confirm it. I can sleep better
now :) Now we can figure out, if your fix is the right one or not ..

Thanks,
Badari



--=-0yHj/92wgGAdamjiIVuZ
Content-Disposition: attachment; filename=buffer-trace.out
Content-Type: text/plain; name=buffer-trace.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

buffer trace for buffer at 0xffff8101d8540678 (I am CPU 3)
 journal_dirty_data():[fs/jbd/transaction.c:939] entry
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:1 b_jcount:1 pg_dirty:1
 journal_dirty_data():[fs/jbd/transaction.c:971] has transaction
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:1 b_jcount:1 pg_dirty:1
 journal_dirty_data():[fs/jbd/transaction.c:973] belongs to older transaction
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:1 b_jcount:1 pg_dirty:1
 journal_dirty_data():[fs/jbd/transaction.c:1037] unfile from commit
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:1 b_jcount:1 pg_dirty:1
 __journal_temp_unlink_buffer():[fs/jbd/transaction.c:1501] entry
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:1 b_jcount:1 pg_dirty:1
 journal_dirty_data():[fs/jbd/transaction.c:1055] not on correct data list: unfile
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __journal_temp_unlink_buffer():[fs/jbd/transaction.c:1501] entry
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 journal_dirty_data():[fs/jbd/transaction.c:1059] file as data
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __journal_file_buffer():[fs/jbd/transaction.c:1948] entry
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __journal_temp_unlink_buffer():[fs/jbd/transaction.c:1501] entry
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __journal_file_buffer():[fs/jbd/transaction.c:2011] filed
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 journal_dirty_data():[fs/jbd/transaction.c:1074] exit
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __block_commit_write():[fs/buffer.c:2098] mark dirty
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 mark_buffer_dirty():[fs/buffer.c:1290] entry
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 end_buffer_write_sync():[fs/buffer.c:140] uptodate
     b_state:0x402f b_jlist:BJ_SyncData cpu:2 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 submit_bh():[fs/buffer.c:2862] enter
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 submit_bh():[fs/buffer.c:2879] write
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 sync_buffer():[fs/buffer.c:66] enter
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 end_buffer_write_sync():[fs/buffer.c:140] uptodate
     b_state:0x402d b_jlist:BJ_SyncData cpu:2 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 journal_unmap_buffer():[fs/jbd/transaction.c:1763] entry
     b_state:0x402d b_jlist:BJ_SyncData cpu:3 b_count:14 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 __dispose_buffer():[fs/jbd/transaction.c:1693] unfile
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:14 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __journal_temp_unlink_buffer():[fs/jbd/transaction.c:1501] entry
     b_state:0x10402d b_jlist:BJ_SyncData cpu:3 b_count:14 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:1 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:1
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __dispose_buffer():[fs/jbd/transaction.c:1702] on running transaction
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:14 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __brelse():[fs/buffer.c:1304] entry
     b_state:0x10402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:1 pg_dirty:1
 __journal_remove_journal_head():[fs/jbd/journal.c:1876] remove journal_head
     b_state:0x30402d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:1 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 __brelse():[fs/buffer.c:1304] entry
     b_state:0x30002d b_jlist:BJ_None cpu:3 b_count:15 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 __brelse():[fs/buffer.c:1304] entry
     b_state:0x30002d b_jlist:BJ_None cpu:3 b_count:14 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 journal_unmap_buffer():[fs/jbd/transaction.c:1882] unmap-clean
     b_state:0x2d b_jlist:BJ_None cpu:3 b_count:13 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 __set_page_dirty_buffers():[fs/buffer.c:867] set dirty
     b_state:0x1 b_jlist:BJ_None cpu:3 b_count:13 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 __set_page_dirty_buffers():[fs/buffer.c:867] set dirty
     b_state:0x3 b_jlist:BJ_None cpu:3 b_count:13 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 submit_bh():[fs/buffer.c:2862] enter
     b_state:0x5 b_jlist:BJ_None cpu:3 b_count:14 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
 print_buffer_trace():[fs/jbd-kernel.c:229]
     b_state:0x5 b_jlist:BJ_None cpu:3 b_count:14 b_blocknr:45037
     b_jbd:0 b_frozen_data:0000000000000000 b_committed_data:0000000000000000
     b_transaction:0 b_next_transaction:0 b_cp_transaction:0 b_trans_is_running:0
     b_trans_is_comitting:0 b_jcount:0 pg_dirty:1
b_blocknr:45037 b_count:14
b_this_page:ffff8101d859f5b8 b_data:ffff8101d8a42c00 b_page:ffff8101dfe63e70

Call Trace:
 [<ffffffff8020b395>] show_trace+0xb5/0x380
 [<ffffffff8020b675>] dump_stack+0x15/0x20
 [<ffffffff802b6b7c>] print_buffer_trace+0x1fc/0x220
 [<ffffffff802b6bca>] buffer_assertion_failure+0x2a/0x30
 [<ffffffff802831de>] submit_bh+0x7e/0x220
 [<ffffffff802847a9>] ll_rw_block+0x79/0xd0
 [<ffffffff80310f69>] journal_commit_transaction+0x4d9/0x13e0
 [<ffffffff803159ce>] kjournald+0xde/0x290
 [<ffffffff802456bc>] kthread+0xdc/0x110
 [<ffffffff8020abe4>] child_rip+0xa/0x12

Assertion failure in submit_bh() at fs/buffer.c:2865: "buffer_mapped(bh)"
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:2865
invalid opcode: 0000 [1] SMP
CPU 3
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc scsi_mod acpi_cpufreq ipv6 thermal processor fan button battery ac dm_mod floppy parport_pc lp parport
Pid: 4122, comm: kjournald Not tainted 2.6.18-rc6 #4
RIP: 0010:[<ffffffff8028320e>]  [<ffffffff8028320e>] submit_bh+0xae/0x220
RSP: 0018:ffff8101bea83d00  EFLAGS: 00010286
RAX: 000000000000004d RBX: ffff8101d8540678 RCX: 0000000000040000
RDX: 0000000000009dba RSI: 0000000000040000 RDI: ffffffff805dd600
RBP: ffff8101bea83d20 R08: 00000000fffffffe R09: fffffffffffffffc
R10: ffff8101bea83c20 R11: 0000000000000000 R12: ffff810176609568
R13: 0000000000000001 R14: 0000000000000003 R15: 0000000000000080
FS:  00002ba0d7a506d0(0000) GS:ffff8101c00efec0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002ba0d77cb000 CR3: 0000000000201000 CR4: 00000000000006e0
Process kjournald (pid: 4122, threadinfo ffff8101bea82000, task ffff81019c8c2810)
Stack:  ffff810198cdd038 ffff8101d8540678 ffff810176609568 000000000000002d
 ffff8101bea83d60 ffffffff802847a9 ffff8101bea83d60 ffff8101dcc704f8
 ffff8101dc01a0d0 ffff81019f4272c0 ffff810174bc3a00 0000000000000080
Call Trace:
 [<ffffffff802847a9>] ll_rw_block+0x79/0xd0
 [<ffffffff80310f69>] journal_commit_transaction+0x4d9/0x13e0
 [<ffffffff803159ce>] kjournald+0xde/0x290
 [<ffffffff802456bc>] kthread+0xdc/0x110
 [<ffffffff8020abe4>] child_rip+0xa/0x12

Code: 0f 0b 68 73 3e 51 80 c2 31 0b 48 83 7b 38 00 75 41 48 89 df
RIP  [<ffffffff8028320e>] submit_bh+0xae/0x220
 RSP <ffff8101bea83d00>
 <1>Unable to handle kernel paging request at 00000001501403e0 RIP:
 [<ffffffff80227838>] task_rq_lock+0x38/0x90
PGD 19c9fb067 PUD 0
Oops: 0000 [2] SMP
CPU 1
Modules linked in: sg sd_mod qla2xxx firmware_class scsi_transport_fc scsi_mod acpi_cpufreq ipv6 thermal processor fan button battery ac dm_mod floppy parport_pc lp parport


--=-0yHj/92wgGAdamjiIVuZ--

