Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWEFUBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWEFUBW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 16:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWEFUBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 16:01:22 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51961 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750806AbWEFUBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 16:01:21 -0400
Date: Sat, 06 May 2006 14:01:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: High load average on disk I/O on 2.6.17-rc3
In-reply-to: <200605061123.02077.jasons@pioneer-pra.com>
To: Jason Schoonover <jasons@pioneer-pra.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <445D0083.3050901@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <69c8K-3Bu-57@gated-at.bofh.it>
 <200605052139.49241.jasons@pioneer-pra.com> <445CDAD0.1000203@shaw.ca>
 <200605061123.02077.jasons@pioneer-pra.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Schoonover wrote:
> Hi Robert,
> 
> I did started a ncftpget and managed to get 6 pdflush processes running in 
> state D, hopefully this will give us a chance to debug it.
> 
> I've attached the entire Alt+SysReq+T output here because I have no idea how 
> to read it.

Well, I think the relevant parts would be:

>  pdflush       D 37E8BE80     0  5842     11          6085  3699 (L-TLB)
>         c7803eec b1bfa900 b1bfa920 37e8be80 00000000 00000000 fc4c7fab 000f9668 
>         dfe67688 dfe67580 b21a0540 b2014340 805ef140 000f966c 00000001 00000000 
>         00000286 b011e999 00000286 b011e999 c7803efc c7803efc 00000286 00000000 
>  Call Trace:
>   <b011e999> lock_timer_base+0x15/0x2f   <b011e999> lock_timer_base+0x15/0x2f
>   <b026fd89> schedule_timeout+0x6c/0x8b   <b011ecff> process_timeout+0x0/0x9
>   <b026ebf5> io_schedule_timeout+0x29/0x33   <b01387eb> pdflush+0x0/0x1b5
>   <b01a0a1d> blk_congestion_wait+0x55/0x69   <b01271dc> autoremove_wake_function+0x0/0x3a
>   <b0137f01> background_writeout+0x7d/0x8b   <b01388ee> pdflush+0x103/0x1b5
>   <b0137e84> background_writeout+0x0/0x8b   <b01271a1> kthread+0xa3/0xd0
>   <b01270fe> kthread+0x0/0xd0   <b0100bc5> kernel_thread_helper+0x5/0xb
>  ncftpget      D 568FC100     0  6115   5762                     (NOTLB)
>         cb351a88 87280008 b013595f 568fc100 00000008 00051615 f2a64c80 b21cc340 
>         dfbc7b58 dfbc7a50 b02b0480 b200c340 77405900 000f966c 00000000 00000282 
>         b011e999 f2a64cd8 00000000 dfec8b84 00000000 dfec8b84 b01a216b 00000000 
>  Call Trace:
>   <b013595f> mempool_alloc+0x21/0xbf   <b011e999> lock_timer_base+0x15/0x2f
>   <b01a216b> get_request+0x55/0x283   <b026f9b5> io_schedule+0x26/0x30
>   <b01a2432> get_request_wait+0x99/0xd3   <b01271dc> autoremove_wake_function+0x0/0x3a
>   <b01a2786> __make_request+0x2b9/0x350   <b01a0268> generic_make_request+0x168/0x17a
>   <b013595f> mempool_alloc+0x21/0xbf   <b01a0ad6> submit_bio+0xa5/0xaa
>   <b015032c> bio_alloc+0x13/0x22   <b014dad0> submit_bh+0xe6/0x107
>   <b014f9d9> __block_write_full_page+0x20e/0x301   <f88e17e8> ext3_get_block+0x0/0xad [ext3]
>   <f88e0633> ext3_ordered_writepage+0xcb/0x137 [ext3]   <f88e17e8> ext3_get_block+0x0/0xad [ext3]
>   <f88def99> bget_one+0x0/0xb [ext3]   <b016a1d3> mpage_writepages+0x193/0x2e9
>   <f88e0568> ext3_ordered_writepage+0x0/0x137 [ext3]   <b013813f> do_writepages+0x30/0x39
>   <b0168988> __writeback_single_inode+0x166/0x2e2   <b01aa9d3> __next_cpu+0x11/0x20
>   <b0136421> read_page_state_offset+0x33/0x41   <b0168f5e> sync_sb_inodes+0x185/0x23a
>   <b01691c6> writeback_inodes+0x6e/0xbb   <b0138246> balance_dirty_pages_ratelimited_nr+0xcb/0x152
>   <b013429e> generic_file_buffered_write+0x47d/0x56f   <f88e698a> __ext3_journal_stop+0x19/0x37 [ext3]
>   <f88dfde0> ext3_dirty_inode+0x5e/0x64 [ext3]   <b0168b4c> __mark_inode_dirty+0x28/0x14c
>   <b01354da> __generic_file_aio_write_nolock+0x3c8/0x405   <b0211c91> sock_aio_read+0x56/0x63
>   <b013573c> generic_file_aio_write+0x61/0xb3   <f88dde72> ext3_file_write+0x26/0x92 [ext3]
>   <b014b99a> do_sync_write+0xc0/0xf3   <b016201a> notify_change+0x2d4/0x2e5
>   <b01271dc> autoremove_wake_function+0x0/0x3a   <b014bdb0> vfs_write+0xa3/0x13a
>   <b014c630> sys_write+0x3b/0x64   <b010267b> syscall_call+0x7/0xb

It looks like the pdflush threads are sitting in uninterruptible sleep 
waiting for a block queue to become uncongested. This seems somewhat 
reasonable to me in this situation, but someone more familiar with the 
block layer would likely have to comment on whether this is the expected 
behavior..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

