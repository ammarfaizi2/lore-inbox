Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUEaOi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUEaOi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEaOi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:38:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26034 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264638AbUEaOiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:38:13 -0400
Date: Mon, 31 May 2004 11:39:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: loop/highmem related 2.4.26 lockup
Message-ID: <20040531143915.GA20653@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens, 

We are seeing a deadlock on our SMP buildserver, running 2.4.26. 
It seems to be related to loop/HIGHMEM (it does intensive use of loop).

It usually takes 9 days of relatively high load (loadavg = 2.5)

Any clues?

MemTotal:      2069596 kB
MemFree:         25956 kB
MemShared:           0 kB
Buffers:         52332 kB
Cached:        1126108 kB
SwapCached:        516 kB
Active:         152892 kB
Inactive:      1058772 kB
HighTotal:     1179584 kB
HighFree:        19768 kB

I can post full ksymoops output if required (all tasks). I pasted
the ones I think are relevant:


Proc;  kswapd
>>EIP; f7bf1ed0 <END_OF_CODE+37857c58/????>   <=====
Trace; c01463ae <__wait_on_buffer+6e/a0>
Trace; c0149e48 <sync_page_buffers+78/d0>
Trace; c0149fe0 <try_to_free_buffers+140/160>
Trace; c013b45a <shrink_cache+35a/430>
Trace; c013b6da <shrink_caches+4a/60>
Trace; c013b752 <try_to_free_pages_zone+62/100>
Trace; c013b91c <kswapd_balance_pgdat+6c/b0>
Trace; c013b988 <kswapd_balance+28/40>
Trace; c013bacc <kswapd+9c/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c013ba30 <kswapd+0/c0>
Proc;  bdflush
>>EIP; f7bca000 <END_OF_CODE+3782fd88/????>   <=====
Trace; c01280aa <update_process_times+3a/b0>
Trace; c01463ae <__wait_on_buffer+6e/a0>
Trace; c0149e48 <sync_page_buffers+78/d0>
Trace; c0149fe0 <try_to_free_buffers+140/160>
Trace; c013b45a <shrink_cache+35a/430>
Trace; c013b6da <shrink_caches+4a/60>
Trace; c013b752 <try_to_free_pages_zone+62/100>
Trace; c013c74e <balance_classzone+4e/1f0>
Trace; c013ca78 <__alloc_pages+188/290>
Trace; c0142882 <alloc_bounce_page+12/a0>
Trace; c0142a0c <create_bounce+4c/180>
Trace; c01d792c <loop_make_request+23c/270>
Trace; c01d4a4c <generic_make_request+dc/140>
Trace; c01d4b0a <submit_bh+5a/100>
Trace; c014643c <write_locked_buffers+2c/40>
Trace; c014653e <write_some_buffers+ee/150>
Trace; c014a458 <bdflush+c8/f0>
Trace; c0105000 <_stext+0/0>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c014a390 <bdflush+0/f0>

Proc;  loop0
>>EIP; 00000000 Before first symbol
Trace; c0107c68 <__down_interruptible+88/f0>
Trace; c0107d36 <__down_failed_interruptible+6/c>
Trace; c01d8ae6 <.text.lock.loop+bc/136>
Trace; c0109172 <ret_from_fork+6/20>
Trace; c01d7960 <loop_thread+0/250>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01d7960 <loop_thread+0/250>

Proc;  loop1
>>EIP; 00000000 Before first symbol
Trace; c0107c68 <__down_interruptible+88/f0>
Trace; c0107d36 <__down_failed_interruptible+6/c>
Trace; c01d8ae6 <.text.lock.loop+bc/136>
Trace; c0109172 <ret_from_fork+6/20>
Trace; c01d7960 <loop_thread+0/250>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01d7960 <loop_thread+0/250>

Proc;  loop2
>>EIP; e5d145c0 <END_OF_CODE+2597a348/????>   <=====
Trace; c0189ec8 <journal_alloc_journal_head+18/80>
Trace; c0189fa2 <journal_add_journal_head+52/140>
Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845fe <.text.lock.transaction+4/246>
Trace; c018204a <new_handle+4a/70>
Trace; c0182114 <journal_start+a4/c0>
Trace; c017bc3c <ext3_writepage_trans_blocks+1c/a0>
Trace; c01795ec <ext3_prepare_write+24c/260>
Trace; c013349e <find_or_create_page+5e/150>
Trace; c01d6f84 <lo_send+124/2e0>
Trace; c01d7408 <do_bh_filebacked+b8/c0>
Trace; c01d7b84 <loop_thread+224/250>
Trace; c0109172 <ret_from_fork+6/20>
Trace; c01d7960 <loop_thread+0/250>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01d7960 <loop_thread+0/250>


There are several processes like this

Proc;  sshd
>>EIP; f7b59400 <END_OF_CODE+377bf188/????>   <=====
Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845fe <.text.lock.transaction+4/246>
Trace; c018204a <new_handle+4a/70>
Trace; c0182114 <journal_start+a4/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d434 <__mark_inode_dirty+b4/c0>
Trace; c015ef0a <update_atime+6a/70>
Trace; c013413c <generic_file_read+bc/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3e <old_mmap+de/120>
Trace; c0144d62 <sys_read+a2/160>
Trace; c014def8 <sys_fstat64+48/80>
Trace; c01091be <system_call+32/38>


