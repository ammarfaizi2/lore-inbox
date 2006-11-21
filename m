Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966946AbWKUJ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966946AbWKUJ2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966952AbWKUJ2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:28:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:7626 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966946AbWKUJ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:27:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:cc:content-type:content-transfer-encoding;
        b=mP350jguUwomDw1A76rqWEqga4ptWURuB3wufbRPdFGy2C+p20kb/cZDL4GBmeel6lDAL+2sm+IhZ+Jmi7iSUwcsXew67T1AcuOEnfUCClfbjqsV8BzrTENz4DozvIf5RAd556Ta5ORrsQNMLbK/XK1jR9tsFUvDD8i0G190jag=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Date: Tue, 21 Nov 2006 10:27:41 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611211027.41971.jesper.juhl@gmail.com>
Cc: xfs@oss.sgi.com, xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a server that has long suffered from spontaneous reboots and random 
crashes.
The problems seem to be partly SMP related since the machine is rock solid 
with a UP version of 2.6.11.11, but the same kernel compiled for SMP has 
issues.

The server initially had 1 Intel Xeon CPU with HT and was very recently 
upgraded with an additional one (in the blind hope that the issues would be 
fixed). The kernel *seems* to die faster with 2 CPU's and a SMP kernel than 
it previously did with just one (HT) CPU and a SMP kernel.

I've been trying newer kernels, such as 2.6.17.x, 2.6.18.x, 2.6.19-rc* 
(all SMP), hoping that the problem(s) would be fixed, but that does not seem
to be the case.

Recently I've been using netconsole and have lots of debug options enabled 
in the hope that I could capture some relevant info. Unfortunately nothing 
ever really made it to the remote log - except one little incomplete bit I 
got the other day (with 2.6.19-rc6) :

 do_IRQ: stack overflow: 492

That is all that made it to the log, but it does indicate that the problem 
might be stack-usage related.
Since the kernel was compiled with 4K stacks, perhaps if it was changed to 
use 8K stacks it would stay up long enough for a complete dump to reach the 
logs. But, if 8K stacks really did help, it would be nice if the dumps still
happened at the same point where they would have with 4K stacks. 
So, I changed STACK_WARN in include/asm/thread_info.h from (THREAD_SIZE/8) 
to(4608). This way I should get stack traces at the point where the kernel 
would be in trouble with a 4K stack but since it's actually using a 8K stack
it should survive and let me capture the trace.

I got more than I could ever have hoped for.  I still got spontaneous 
reboots, but this time my remote log server captured tons of stack dumps.
I've got far too many to send here (more than 2G) and most of them are 
identical anyway, so I'll just submit a few representative samples 
initially.

Most of the traces include XFS functions and some also involve scsi and/or 
networking. This is the reason I'm submitting this to the XFS & netdev lists
in addition to LKML.

All of these traces were collected with 2.6.19-rc6 with the modification 
mentioned above.

Hardware details and software environment info is at the end of the email.


This is the most often captured trace :

do_IRQ: stack overflow: 4416
 [<c01039a7>] dump_trace+0x1e7/0x1fd
 [<c0103a67>] show_trace_log_lvl+0x1c/0x33
 [<c0103a90>] show_trace+0x12/0x16
 [<c0103b8f>] dump_stack+0x19/0x1d
 [<c0105133>] do_IRQ+0xaf/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c011ee20>] __do_softirq+0x59/0xd0
 [<c011eece>] do_softirq+0x37/0x39
 [<c011ef09>] irq_exit+0x39/0x3b
 [<c01050f8>] do_IRQ+0x74/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c02ee313>] make_request+0x320/0x426
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c02fbac7>] __map_bio+0x4c/0x93
 [<c02fbcfd>] __clone_and_map+0xdb/0x30a
 [<c02fbfd0>] __split_bio+0xa4/0xc7
 [<c02fc093>] dm_request+0xa0/0xbf
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c020992a>] xlog_bdstrat_cb+0x19/0x41
 [<c020a212>] xlog_sync+0x24e/0x457
 [<c020b7ce>] xlog_state_release_iclog+0x75/0xd0
 [<c020bc8d>] xlog_state_sync+0x175/0x269
 [<c0208ef6>] _xfs_log_force+0x7f/0x88
 [<c01d1786>] xfs_alloc_search_busy+0xdf/0xe1
 [<c01d0d1c>] xfs_alloc_get_freelist+0xe7/0xf5
 [<c01d2d9b>] xfs_alloc_newroot+0x21/0x34f
 [<c01d25c4>] xfs_alloc_insrec+0x3b0/0x3ce
 [<c01d3cdf>] xfs_alloc_insert+0x5a/0xc3
 [<c01d071a>] xfs_free_ag_extent+0x57f/0x5f2
 [<c01d09f9>] xfs_alloc_fix_freelist+0x220/0x45c
 [<c01d1285>] xfs_alloc_vextent+0x24e/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2
 [<c0173278>] writeback_inodes+0xb2/0xbe
 [<c0141395>] background_writeout+0x66/0x9a
 [<c0141f37>] __pdflush+0xcf/0x184
 [<c014201e>] pdflush+0x32/0x36
 [<c012c918>] kthread+0xa9/0xae
 [<c010373b>] kernel_thread_helper+0x7/0x10

another very common one is this one :

do_IRQ: stack overflow: 4532
 [<c01039a7>] dump_trace+0x1e7/0x1fd
 [<c0103a67>] show_trace_log_lvl+0x1c/0x33
 [<c0103a90>] show_trace+0x12/0x16
 [<c0103b8f>] dump_stack+0x19/0x1d
 [<c0105133>] do_IRQ+0xaf/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c02255a7>] xfs_buf_bio_end_io+0xd9/0x11f
 [<c017a546>] bio_endio+0x55/0x7a
 [<c02fb914>] dec_pending+0x3d/0x6b
 [<c02fb9c7>] clone_endio+0x85/0xb1
 [<c017a546>] bio_endio+0x55/0x7a
 [<c0237435>] __end_that_request_first+0x1df/0x271
 [<c02374dc>] end_that_request_chunk+0x8/0xa
 [<c02adab9>] scsi_end_request+0x25/0xcb
 [<c02adca4>] scsi_io_completion+0x82/0x301
 [<c02b6b6d>] sd_rw_intr+0x76/0x20f
 [<c02a9bf5>] scsi_finish_command+0x43/0x5e
 [<c02ae3df>] scsi_softirq_done+0x70/0xd5
 [<c0237540>] blk_done_softirq+0x62/0x6b
 [<c011ee82>] __do_softirq+0xbb/0xd0
 [<c011eece>] do_softirq+0x37/0x39
 [<c011ef09>] irq_exit+0x39/0x3b
 [<c01050f8>] do_IRQ+0x74/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c013edf8>] mempool_alloc+0x21/0xce
 [<c01796dd>] bio_alloc_bioset+0x79/0x13f
 [<c02fbbdb>] clone_bio+0x36/0x7d
 [<c02fbcf0>] __clone_and_map+0xce/0x30a
 [<c02fbfd0>] __split_bio+0xa4/0xc7
 [<c02fc093>] dm_request+0xa0/0xbf
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c02254a4>] xfs_buf_iostart+0x6d/0x97
 [<c0224e32>] xfs_buf_read_flags+0x8a/0x8c
 [<c021768e>] xfs_trans_read_buf+0x153/0x2fc
 [<c01eb559>] xfs_btree_read_bufs+0x6e/0x84
 [<c01d27d9>] xfs_alloc_lookup+0x10a/0x39e
 [<c01d3d76>] xfs_alloc_lookup_ge+0x17/0x1a
 [<c01cf314>] xfs_alloc_ag_vextent_near+0x5f/0x957
 [<c01cf107>] xfs_alloc_ag_vextent+0x104/0x106
 [<c01d13a9>] xfs_alloc_vextent+0x372/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2
 [<c0173278>] writeback_inodes+0xb2/0xbe
 [<c0141478>] wb_kupdate+0x80/0xe9
 [<c0141f37>] __pdflush+0xcf/0x184
 [<c014201e>] pdflush+0x32/0x36
 [<c012c918>] kthread+0xa9/0xae
 [<c010373b>] kernel_thread_helper+0x7/0x10

This one seems to involve scsi : 

do_IRQ: stack overflow: 4568
 [<c01039a7>] dump_trace+0x1e7/0x1fd
 [<c0103a67>] show_trace_log_lvl+0x1c/0x33
 [<c0103a90>] show_trace+0x12/0x16
 [<c0103b8f>] dump_stack+0x19/0x1d
 [<c0105133>] do_IRQ+0xaf/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c03872bf>] _spin_unlock_irq+0xa/0xb
 [<c0235974>] blk_run_queue+0x42/0x77
 [<c02ad99e>] scsi_run_queue+0xc9/0xf1
 [<c02ada4f>] scsi_next_command+0x33/0x49
 [<c02adb44>] scsi_end_request+0xb0/0xcb
 [<c02adca4>] scsi_io_completion+0x82/0x301
 [<c02b6b6d>] sd_rw_intr+0x76/0x20f
 [<c02a9bf5>] scsi_finish_command+0x43/0x5e
 [<c02ae3df>] scsi_softirq_done+0x70/0xd5
 [<c0237540>] blk_done_softirq+0x62/0x6b
 [<c011ee82>] __do_softirq+0xbb/0xd0
 [<c011eece>] do_softirq+0x37/0x39
 [<c011ef09>] irq_exit+0x39/0x3b
 [<c01050f8>] do_IRQ+0x74/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c03872bf>] _spin_unlock_irq+0xa/0xb
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c02fbac7>] __map_bio+0x4c/0x93
 [<c02fbcfd>] __clone_and_map+0xdb/0x30a
 [<c02fbfd0>] __split_bio+0xa4/0xc7
 [<c02fc093>] dm_request+0xa0/0xbf
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c02254a4>] xfs_buf_iostart+0x6d/0x97
 [<c0224e32>] xfs_buf_read_flags+0x8a/0x8c
 [<c021768e>] xfs_trans_read_buf+0x153/0x2fc
 [<c01eb559>] xfs_btree_read_bufs+0x6e/0x84
 [<c01d27d9>] xfs_alloc_lookup+0x10a/0x39e
 [<c01d3d5c>] xfs_alloc_lookup_eq+0x14/0x17
 [<c01ceef8>] xfs_alloc_fixup_trees+0x252/0x2a9
 [<c01cff24>] xfs_alloc_ag_vextent_size+0x318/0x405
 [<c01cf0e5>] xfs_alloc_ag_vextent+0xe2/0x106
 [<c01d13a9>] xfs_alloc_vextent+0x372/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2
 [<c0173278>] writeback_inodes+0xb2/0xbe
 [<c0141395>] background_writeout+0x66/0x9a
 [<c0141f37>] __pdflush+0xcf/0x184
 [<c014201e>] pdflush+0x32/0x36
 [<c012c918>] kthread+0xa9/0xae
 [<c010373b>] kernel_thread_helper+0x7/0x10

And then there are some where stack space is really low, which would 
certainly have killed us if running with 4K stacks :

First this :

do_IRQ: stack overflow: 3376
 [<c01039a7>] dump_trace+0x1e7/0x1fd
 [<c0103a67>] show_trace_log_lvl+0x1c/0x33
 [<c0103a90>] show_trace+0x12/0x16
 [<c0103b8f>] dump_stack+0x19/0x1d
 [<c0105133>] do_IRQ+0xaf/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c03872b2>] _spin_unlock_irqrestore+0xd/0x10
 [<c029ab47>] e1000_xmit_frame+0x269/0x3b1
 [<c0315f1f>] dev_hard_start_xmit+0x5a/0xd3
 [<c03224da>] __qdisc_run+0x95/0x1d7
 [<c03161b8>] dev_queue_xmit+0x220/0x285
 [<c03841c1>] vlan_dev_hwaccel_hard_start_xmit+0x8a/0x92
 [<c0315f1f>] dev_hard_start_xmit+0x5a/0xd3
 [<c03160f7>] dev_queue_xmit+0x15f/0x285
 [<c031b63e>] neigh_connected_output+0x93/0xba
 [<c0330869>] ip_output+0x170/0x250
 [<c0330d21>] ip_queue_xmit+0x3d8/0x4e1
 [<c03415da>] tcp_transmit_skb+0x29e/0x45d
 [<c0344511>] tcp_send_ack+0xb3/0xf4
 [<c033e343>] tcp_send_dupack+0x28/0x7f
 [<c033fa7f>] tcp_rcv_established+0x141/0x6c8
 [<c03478c9>] tcp_v4_do_rcv+0xcb/0xcd
 [<c0347f3e>] tcp_v4_rcv+0x673/0x7e3
 [<c032d351>] ip_local_deliver+0xf8/0x22d
 [<c032d6ca>] ip_rcv+0x244/0x4e4
 [<c031667f>] netif_receive_skb+0x1f9/0x26a
 [<c029bbea>] e1000_clean_rx_irq+0x17f/0x4b9
 [<c029b6f9>] e1000_clean+0x66/0xfb
 [<c0316890>] net_rx_action+0x96/0x174
 [<c011ee82>] __do_softirq+0xbb/0xd0
 [<c011eece>] do_softirq+0x37/0x39
 [<c011ef09>] irq_exit+0x39/0x3b
 [<c01050f8>] do_IRQ+0x74/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c02fba08>] max_io_len+0x15/0x88
 [<c02fbc66>] __clone_and_map+0x44/0x30a
 [<c02fbfd0>] __split_bio+0xa4/0xc7
 [<c02fc093>] dm_request+0xa0/0xbf
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c02254a4>] xfs_buf_iostart+0x6d/0x97
 [<c0224e32>] xfs_buf_read_flags+0x8a/0x8c
 [<c021768e>] xfs_trans_read_buf+0x153/0x2fc
 [<c01eb559>] xfs_btree_read_bufs+0x6e/0x84
 [<c01d27d9>] xfs_alloc_lookup+0x10a/0x39e
 [<c01d3d76>] xfs_alloc_lookup_ge+0x17/0x1a
 [<c01cf314>] xfs_alloc_ag_vextent_near+0x5f/0x957
 [<c01cf107>] xfs_alloc_ag_vextent+0x104/0x106
 [<c01d13a9>] xfs_alloc_vextent+0x372/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2
 [<c0173278>] writeback_inodes+0xb2/0xbe
 [<c014117f>] balance_dirty_pages+0xa6/0x15c
 [<c01412ca>] balance_dirty_pages_ratelimited_nr+0x59/0x5b
 [<c013dc7f>] generic_file_buffered_write+0x2ef/0x61f
 [<c022ae09>] xfs_write+0x96f/0xb1c
 [<c0226774>] xfs_file_aio_write+0x78/0x8a
 [<c01586d9>] do_sync_write+0xc1/0x100
 [<c01587a9>] vfs_write+0x91/0x137
 [<c01588fb>] sys_write+0x41/0x6b
 [<c0102b93>] syscall_call+0x7/0xb
 [<b7f6b95e>] 0xb7f6b95e

and this :

e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <d49>
  TDT                  <d49>
  next_to_use          <d49>
  next_to_clean        <d8e>
buffer_info[next_to_clean]
  time_stamp           <aaa1fc>
  next_to_watch        <d8e>
  jiffies              <aaae6f>
  next_to_watch.status <1>
do_IRQ: stack overflow: 3836
 [<c01039a7>] dump_trace+0x1e7/0x1fd
 [<c0103a67>] show_trace_log_lvl+0x1c/0x33
 [<c0103a90>] show_trace+0x12/0x16
 [<c0103b8f>] dump_stack+0x19/0x1d
 [<c0105133>] do_IRQ+0xaf/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c02443d0>] csum_partial+0xb8/0x120
DWARF2 unwinder stuck at csum_partial+0xb8/0x120
Leftover inexact backtrace:
 [<c0313833>] __skb_checksum_complete+0x20/0x67
 [<c035c397>] nf_ip_checksum+0xe0/0x125
 [<c035fb91>] udp_error+0x105/0x184
 [<c035da4c>] ip_conntrack_in+0x7d/0x294
 [<c0326add>] nf_iterate+0x62/0x7c
 [<c0326b4f>] nf_hook_slow+0x58/0xbf
 [<c032d892>] ip_rcv+0x40c/0x4e4
 [<c031667f>] netif_receive_skb+0x1f9/0x26a
 [<c029bbea>] e1000_clean_rx_irq+0x17f/0x4b9
 [<c029b6f9>] e1000_clean+0x66/0xfb
 [<c0316890>] net_rx_action+0x96/0x174
 [<c011ee82>] __do_softirq+0xbb/0xd0
 [<c011eece>] do_softirq+0x37/0x39
 [<c011ef09>] irq_exit+0x39/0x3b
 [<c01050f8>] do_IRQ+0x74/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c02fbc66>] __clone_and_map+0x44/0x30a
 [<c02fbfd0>] __split_bio+0xa4/0xc7
 [<c02fc093>] dm_request+0xa0/0xbf
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c02254a4>] xfs_buf_iostart+0x6d/0x97
 [<c0224e32>] xfs_buf_read_flags+0x8a/0x8c
 [<c021768e>] xfs_trans_read_buf+0x153/0x2fc
 [<c01eb559>] xfs_btree_read_bufs+0x6e/0x84
 [<c01d27d9>] xfs_alloc_lookup+0x10a/0x39e
 [<c01d3d76>] xfs_alloc_lookup_ge+0x17/0x1a
 [<c01cf314>] xfs_alloc_ag_vextent_near+0x5f/0x957
 [<c01cf107>] xfs_alloc_ag_vextent+0x104/0x106
 [<c01d13a9>] xfs_alloc_vextent+0x372/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2
 [<c0173278>] writeback_inodes+0xb2/0xbe
 [<c014117f>] balance_dirty_pages+0xa6/0x15c
 [<c01412ca>] balance_dirty_pages_ratelimited_nr+0x59/0x5b
 [<c013dc7f>] generic_file_buffered_write+0x2ef/0x61f
 [<c022ae09>] xfs_write+0x96f/0xb1c
 [<c0226774>] xfs_file_aio_write+0x78/0x8a
 [<c01586d9>] do_sync_write+0xc1/0x100
 [<c01587a9>] vfs_write+0x91/0x137
 [<c01588fb>] sys_write+0x41/0x6b
 [<c0102b93>] syscall_call+0x7/0xb

and finally this one :

do_IRQ: stack overflow: 3916
 [<c01039a7>] dump_trace+0x1e7/0x1fd
 [<c0103a67>] show_trace_log_lvl+0x1c/0x33
 [<c0103a90>] show_trace+0x12/0x16
 [<c0103b8f>] dump_stack+0x19/0x1d
 [<c0105133>] do_IRQ+0xaf/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c0342148>] tcp_init_tso_segs+0x17/0x4c
 [<c0342ac2>] tcp_write_xmit+0x5d/0x266
 [<c0342cf4>] __tcp_push_pending_frames+0x29/0x81
 [<c033fb46>] tcp_rcv_established+0x208/0x6c8
 [<c03478c9>] tcp_v4_do_rcv+0xcb/0xcd
 [<c0347f3e>] tcp_v4_rcv+0x673/0x7e3
 [<c032d351>] ip_local_deliver+0xf8/0x22d
 [<c032d6ca>] ip_rcv+0x244/0x4e4
 [<c031667f>] netif_receive_skb+0x1f9/0x26a
 [<c029bbea>] e1000_clean_rx_irq+0x17f/0x4b9
 [<c029b6f9>] e1000_clean+0x66/0xfb
 [<c0316890>] net_rx_action+0x96/0x174
 [<c011ee82>] __do_softirq+0xbb/0xd0
 [<c011eece>] do_softirq+0x37/0x39
 [<c011ef09>] irq_exit+0x39/0x3b
 [<c01050f8>] do_IRQ+0x74/0xd6
 [<c01034fe>] common_interrupt+0x1a/0x20
 [<c02fba08>] max_io_len+0x15/0x88
 [<c02fbc66>] __clone_and_map+0x44/0x30a
 [<c02fbfd0>] __split_bio+0xa4/0xc7
 [<c02fc093>] dm_request+0xa0/0xbf
 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c02254a4>] xfs_buf_iostart+0x6d/0x97
 [<c0224e32>] xfs_buf_read_flags+0x8a/0x8c
 [<c021768e>] xfs_trans_read_buf+0x153/0x2fc
 [<c01eb559>] xfs_btree_read_bufs+0x6e/0x84
 [<c01d27d9>] xfs_alloc_lookup+0x10a/0x39e
 [<c01d3d76>] xfs_alloc_lookup_ge+0x17/0x1a
 [<c01cf314>] xfs_alloc_ag_vextent_near+0x5f/0x957
 [<c01cf107>] xfs_alloc_ag_vextent+0x104/0x106
 [<c01d13a9>] xfs_alloc_vextent+0x372/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2
 [<c0173278>] writeback_inodes+0xb2/0xbe
 [<c014117f>] balance_dirty_pages+0xa6/0x15c
 [<c01412ca>] balance_dirty_pages_ratelimited_nr+0x59/0x5b
 [<c013dc7f>] generic_file_buffered_write+0x2ef/0x61f
 [<c022ae09>] xfs_write+0x96f/0xb1c
 [<c0226774>] xfs_file_aio_write+0x78/0x8a
 [<c01586d9>] do_sync_write+0xc1/0x100
 [<c01587a9>] vfs_write+0x91/0x137
 [<c01588fb>] sys_write+0x41/0x6b
 [<c0102b93>] syscall_call+0x7/0xb
 [<b7f6b95e>] 0xb7f6b95e

And there are lots of other ones as well that differ slightly from the ones 
above.


Some hardware/software details :

# scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux server.mydomain.net 2.6.19-rc6 #1 SMP Mon Nov 20 14:33:26 CET 2006 i686 
GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
xfsprogs               2.6.20
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         sky2 piix ide_core eeprom

# lspci -vvx
0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 0c)
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [4105]
00: 86 80 90 35 46 01 90 00 0c 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.1 ff00: Intel Corp. Memory Controller Hub Error Reporting Register 
(rev 0c)
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
00: 86 80 91 35 00 01 00 00 0c 00 00 ff 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 System peripheral: Intel Corp. Memory Controller Hub DMA 
Controller (rev 0c)
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fcbff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [b0] Message Signalled Interrupts: 64bit- Queue=0/1 
Enable-
                Address: fee00000  Data: 0000
00: 86 80 94 35 02 01 10 00 0c 00 80 08 00 00 00 00
10: 00 f0 bf fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 b0 00 00 00 00 00 00 00 0a 01 00 00

0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A0 
(rev 0c) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: fcc00000-fcefffff
        Prefetchable memory behind bridge: 00000000fa000000-00000000fb700000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 
Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]
00: 86 80 95 35 47 01 10 00 0c 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 03 00 b0 c0 00 00
20: c0 fc e0 fc 01 fa 71 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 06 00

0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B0 
(rev 0c) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 
Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]
00: 86 80 97 35 44 01 10 00 0c 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 06 00

0000:00:05.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B1 
(rev 0c) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fcf00000-fcffffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 
Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]
00: 86 80 98 35 47 01 18 00 0c 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 05 05 00 d0 d0 00 00
20: f0 fc f0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 07 00

0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port C0 
(rev 0c) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 
Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]
00: 86 80 99 35 44 01 10 00 0c 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 06 06 00 f0 00 00 20
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 06 00

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at a880 [size=32]
00: 86 80 d2 24 05 00 80 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 a8 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 7
        Region 4: I/O ports at ac00 [size=32]
00: 86 80 d4 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ac 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 07 02 00 00

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 15
        Region 4: I/O ports at ac80 [size=32]
00: 86 80 d7 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 ac 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 03 00 00

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at fcbfec00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]
00: 86 80 dd 24 06 01 90 02 02 20 03 0c 00 00 00 00
10: 00 ec bf fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 00 00

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fd000000-febfffff
        Prefetchable memory behind bridge: fb800000-fbffffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 86 80 4e 24 47 01 80 00 c2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 07 07 20 e0 e0 80 02
20: 00 fd b0 fe 80 fb f0 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0b 00

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 
02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 d0 24 4f 01 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 88000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 db 24 07 00 88 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 fc 00 00 00 00 00 88 00 00 00 00 86 80 39 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corp.: Unknown device 3460
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at a800 [size=8]
        Region 1: I/O ports at a480 [size=4]
        Region 2: I/O ports at a400 [size=8]
        Region 3: I/O ports at a080 [size=4]
        Region 4: I/O ports at a000 [size=16]
00: 86 80 d1 24 45 00 a0 02 02 8f 01 01 00 00 00 00
10: 01 a8 00 00 81 a4 00 00 01 a4 00 00 81 a0 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 86 80 60 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 00 00

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 
02)
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 22
        Region 4: I/O ports at 0540 [size=32]
00: 86 80 d3 24 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 05 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

0000:01:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=48
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fcd00000-fcdfffff
        Prefetchable memory behind bridge: 00000000fa000000-00000000faf00000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] 00: 86 80 29 03 47 01 10 00 09 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 01 02 02 30 b0 b0 a0 02
20: d0 fc d0 fc 01 fa f1 fa 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 07 00

0000:01:00.1 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller A 
(rev 09) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fccfe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] #10 [0001]
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 26 03 46 01 10 00 09 20 00 08 00 00 80 00
10: 00 e0 cf fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=48
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fce00000-fcefffff
        Prefetchable memory behind bridge: 00000000fb000000-00000000fb700000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] 00: 86 80 2a 03 47 01 10 00 09 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 01 03 03 30 c0 c0 a0 02
20: e0 fc e0 fc 01 fb 71 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 07 00

0000:01:00.3 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller B 
(rev 09) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fccff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] #10 [0001]
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 27 03 46 01 10 00 09 20 00 08 00 00 80 00
10: 00 f0 cf fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00

0000:02:02.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2250ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at bc00 [size=256]
        Region 1: Memory at fcdffc00 (64-bit, non-prefetchable) [size=256]
        Region 3: Memory at fa800000 (64-bit, prefetchable) [size=8M]
        Expansion ROM at fcde0000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 13 02 10 5f 01 30 02 00 00 04 01 10 20 00 00
10: 01 bc 00 00 04 fc df fc 00 00 00 00 0c 00 80 fa
20: 00 00 00 00 00 00 00 00 00 00 00 00 c1 13 02 10
30: 00 00 de fc 48 00 00 00 00 00 00 00 0a 01 09 00

0000:02:03.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2250ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at fcdff800 (64-bit, non-prefetchable) [size=256]
        Region 3: Memory at fa000000 (64-bit, prefetchable) [size=8M]
        Expansion ROM at fcdd0000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=255 Dev=31 Func=0 64bit+ 133MHz+ SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 13 02 10 5f 01 30 02 00 00 04 01 10 20 00 00
10: 01 b8 00 00 04 f8 df fc 00 00 00 00 0c 00 00 fa
20: 00 00 00 00 00 00 00 00 00 00 00 00 c1 13 02 10
30: 00 00 dd fc 40 00 00 00 00 00 00 00 0a 01 09 00

0000:03:01.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2250ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at fceffc00 (64-bit, non-prefetchable) [size=256]
        Region 3: Memory at fb000000 (64-bit, prefetchable) [size=8M]
        Expansion ROM at fcee0000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 13 02 10 5f 01 30 02 00 00 04 01 10 20 00 00
10: 01 cc 00 00 04 fc ef fc 00 00 00 00 0c 00 00 fb
20: 00 00 00 00 00 00 00 00 00 00 00 00 c1 13 02 10
30: 00 00 ee fc 48 00 00 00 00 00 00 00 0a 01 09 00

0000:05:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown 
device 4361 (rev 18)
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 223
        Region 0: Memory at fcffc000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at dc00 [size=256]
        Expansion ROM at fcfc0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable+
                Address: 00000000fee0f00c  Data: 41e1
        Capabilities: [e0] #10 [0011]
00: ab 11 61 43 47 05 10 00 18 00 00 02 10 00 00 00
10: 04 c0 ff fc 00 00 00 00 01 dc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 fc fc 48 00 00 00 00 00 00 00 0a 01 00 00

0000:07:04.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet 
Controller (rev 05)
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ec80 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=2, DMOST=0, DMCRS=0, RSCEM-
00: 86 80 76 10 57 01 30 02 05 00 00 02 10 20 00 00
10: 00 00 be fe 00 00 00 00 81 ec 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 ff 00

0000:07:06.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2250ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at febdbc00 (64-bit, non-prefetchable) [size=256]
        Region 3: Memory at fb800000 (64-bit, prefetchable) [size=8M]
        Expansion ROM at fe020000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c1 13 02 10 5f 01 30 02 00 00 04 01 10 20 00 00
10: 01 e8 00 00 04 bc bd fe 00 00 00 00 0c 00 80 fb
20: 00 00 00 00 00 00 00 00 00 00 00 00 c1 13 02 10
30: 00 00 bc fe 48 00 00 00 00 00 00 00 0f 01 09 00

0000:07:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
        Subsystem: Intel Corp.: Unknown device 3439
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at e400 [size=256]
        Region 2: Memory at febda000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 52 47 87 00 90 02 27 00 00 03 10 20 00 00
10: 00 00 00 fd 01 e4 00 00 00 a0 bd fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 39 34
30: 00 00 ba fe 5c 00 00 00 00 00 00 00 0b 01 08 00

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 10
cpu MHz         : 3192.358
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc pni monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips        : 6388.75

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 10
cpu MHz         : 3192.358
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc pni monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips        : 6384.53

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 10
cpu MHz         : 3192.358
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc pni monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips        : 6384.50

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 10
cpu MHz         : 3192.358
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc pni monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips        : 6384.54

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:   17246519       2140       2140       2148   IO-APIC-edge      timer
  1:          3          3          2          2   IO-APIC-edge      i8042
  8:          3          0          1          0   IO-APIC-edge      rtc
  9:          0          0          0          0   IO-APIC-fasteoi   acpi
 12:          0          1          0          2   IO-APIC-edge      i8042
 14:          0          0          0          0   IO-APIC-edge      libata
 15:          0          0          0          0   IO-APIC-edge      libata
 16:   31000929    7811302   39894575   15870447   IO-APIC-fasteoi   eth0
 17:    1078416    3044826    2489404    1780707   IO-APIC-fasteoi   3w-9xxx
 18:    7107793     931865    5531801     862511   IO-APIC-fasteoi   3w-9xxx
 19:     494962     141885      25640     282908   IO-APIC-fasteoi   3w-9xxx
 20:    2130674    3511229    1293435    2256288   IO-APIC-fasteoi   3w-9xxx, 
libata
 21:          0          0          0          0   IO-APIC-fasteoi   
ehci_hcd:usb1
223:          0          0          0          1   PCI-MSI-edge      eth1
NMI:   17252842   17252814   17252813   17252812
LOC:   17234121   17234121   17231585   17231584
ERR:          0
MIS:          0

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: AMCC     Model: 9500S-12MI DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: AMCC     Model: 9500S-8MI  DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: AMCC     Model: 9500S-8MI  DISK  Rev: 2.08
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3200822AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05



Any advice on how to go about fixing this would be appreciated.



Kind regards,

 Jesper Juhl <jesper.juhl@gmail.com>


PS. Please keep me on Cc: when replying.


 
