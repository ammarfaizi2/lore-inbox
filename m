Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTFLQyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTFLQyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:54:21 -0400
Received: from over.ny.us.ibm.com ([32.97.182.111]:43438 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S264896AbTFLQxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:53:42 -0400
Subject: Re: 2.5.70-mm6
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbadari@us.ibm.com
In-Reply-To: <20030610201242.7fde819b.akpm@digeo.com>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<3EE690AC.70500@us.ibm.com>  <20030610201242.7fde819b.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Jun 2003 09:37:42 -0700
Message-Id: <1055435864.1466.9.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > I run 50 fsx tests on ext3 filesystem on 2.5.70-mm6 kernel. Serveral fsx 
> >  tests hang with the status D, after the tests run for a while.  No oops, 
> >  no error messages.  I found same problem on mm5, but 2.5.70 is fine.
Sorry, the tests in 2.5.70 also failed, same problem.

On Tue, 2003-06-10 at 20:12, Andrew Morton wrote
> If you could, please retest with "elevator=deadline"?
> 
Thanks for your feedback.

This time I got more fsx tests hang(about 25).  Before normally I saw 5
or 10 tests fail. Here is the stack info.

kjournald     D 00000001   849      1           900   847 (L-TLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c015b14c>] sync_dirty_buffer+0x6c/0xd0
 [<c0157587>] __wait_on_buffer+0x17/0x20
 [<c01a43b7>] journal_commit_transaction+0xbf7/0x122b
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011bc47>] schedule+0x207/0x4f0
 [<c01a7246>] kjournald+0x236/0x260
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0109352>] ret_from_fork+0x6/0x14
 [<c01a6ff0>] commit_timeout+0x0/0x10
 [<c01a7010>] kjournald+0x0/0x260
 [<c010722d>] kernel_thread_helper+0x5/0x18

fsx           D 00000001   900      1           901   849 (NOTLB)
Call Trace:
 [<c01a1862>] do_get_write_access+0x522/0x680
 [<c011bf30>] default_wake_function+0x0/0x30
 [<c01951f3>] ext3_get_inode_loc+0x103/0x1a0
 [<c01a19f9>] journal_get_write_access+0x39/0x60
 [<c0195d46>] ext3_reserve_inode_write+0x86/0xe0
 [<c0195dcb>] ext3_mark_inode_dirty+0x2b/0x60
 [<c0195e8c>] ext3_dirty_inode+0x8c/0x90
 [<c0177a56>] __mark_inode_dirty+0xf6/0x100
 [<c0171680>] inode_update_time+0x80/0xb0
 [<c013a455>] generic_file_aio_write_nolock+0x215/0xa50
 [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
 [<c0158d97>] __bread+0x27/0x50
 [<c01951f3>] ext3_get_inode_loc+0x103/0x1a0
 [<c013adee>] generic_file_aio_write+0x9e/0x120
 [<c0190bf4>] ext3_file_write+0x44/0xe0
 [<c0156046>] do_sync_write+0xb6/0xf0
 [<c0177a56>] __mark_inode_dirty+0xf6/0x100
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011b7ee>] scheduler_tick+0x16e/0x3b0
 [<c015613e>] vfs_write+0xbe/0x130
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0156262>] sys_write+0x42/0x70
 [<c010943f>] syscall_call+0x7/0xb

fsx           D C3812E48   901      1           902   900 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c015b390>] block_sync_page+0x0/0x10
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   902      1           903   901 (NOTLB)
Call Trace:
 [<c015b390>] block_sync_page+0x0/0x10
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   903      1           904   902 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c015af00>] submit_bh+0x90/0x1e0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c02b1cc4>] submit_bio+0x54/0xa0
 [<c0158acd>] __bread_slow_wq+0xad/0xf0
 [<c0158db6>] __bread+0x46/0x50
 [<c018eb98>] read_block_bitmap+0x58/0xa0
 [<c018f902>] ext3_new_block+0x1a2/0x590
 [<c0158c73>] __find_get_block+0x73/0x100
 [<c01922f7>] ext3_alloc_block+0x37/0x40
 [<c01926ba>] ext3_alloc_branch+0x4a/0x2c0
 [<c01924c2>] ext3_get_branch+0x72/0x100
 [<c0192cbc>] ext3_get_block_handle+0x18c/0x360
 [<c015b501>] alloc_buffer_head+0x41/0x50
 [<c0192ef4>] ext3_get_block+0x64/0xb0
 [<c0159827>] __block_prepare_write+0x227/0x4b0
 [<c015a364>] block_prepare_write+0x34/0x50
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c01934d1>] ext3_prepare_write+0x71/0x130
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c013a5cd>] generic_file_aio_write_nolock+0x38d/0xa50
 [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
 [<c01715a2>] update_atime+0x92/0xf0
 [<c01393d4>] __generic_file_aio_read+0x1c4/0x210
 [<c013adee>] generic_file_aio_write+0x9e/0x120
 [<c0190bf4>] ext3_file_write+0x44/0xe0
 [<c0156046>] do_sync_write+0xb6/0xf0
 [<c0177a56>] __mark_inode_dirty+0xf6/0x100
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c015613e>] vfs_write+0xbe/0x130
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0156262>] sys_write+0x42/0x70
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   904      1           925   903 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D EF963DD4   925      1           926   904 (NOTLB)
Call Trace:
 [<c02b0537>] generic_unplug_device+0x67/0x70
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D C3810004   926      1           927   925 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c015b390>] block_sync_page+0x0/0x10
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D EF95FDA8   927      1           928   926 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   928      1           929   927 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c015af00>] submit_bh+0x90/0x1e0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c02b1cc4>] submit_bio+0x54/0xa0
 [<c0158acd>] __bread_slow_wq+0xad/0xf0
 [<c0158db6>] __bread+0x46/0x50
 [<c018eb98>] read_block_bitmap+0x58/0xa0
 [<c018f902>] ext3_new_block+0x1a2/0x590
 [<c0158c73>] __find_get_block+0x73/0x100
 [<c01922f7>] ext3_alloc_block+0x37/0x40
 [<c01926ba>] ext3_alloc_branch+0x4a/0x2c0
 [<c01924c2>] ext3_get_branch+0x72/0x100
 [<c0192cbc>] ext3_get_block_handle+0x18c/0x360
 [<c015b501>] alloc_buffer_head+0x41/0x50
 [<c0192ef4>] ext3_get_block+0x64/0xb0
 [<c0159827>] __block_prepare_write+0x227/0x4b0
 [<c015a364>] block_prepare_write+0x34/0x50
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c01934d1>] ext3_prepare_write+0x71/0x130
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c013a5cd>] generic_file_aio_write_nolock+0x38d/0xa50
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c0158d97>] __bread+0x27/0x50
 [<c01951f3>] ext3_get_inode_loc+0x103/0x1a0
 [<c013adee>] generic_file_aio_write+0x9e/0x120
 [<c0190bf4>] ext3_file_write+0x44/0xe0
 [<c0156046>] do_sync_write+0xb6/0xf0
 [<c0177a56>] __mark_inode_dirty+0xf6/0x100
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c015613e>] vfs_write+0xbe/0x130
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0156262>] sys_write+0x42/0x70
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   929      1           935   928 (NOTLB)
Call Trace:
 [<c01a1862>] do_get_write_access+0x522/0x680
 [<c011bf30>] default_wake_function+0x0/0x30
 [<c0158c73>] __find_get_block+0x73/0x100
 [<c01a19f9>] journal_get_write_access+0x39/0x60
 [<c0194879>] ext3_free_data+0x39/0x150
 [<c0194a7d>] ext3_free_branches+0xed/0x280
 [<c019508e>] ext3_truncate+0x47e/0x4e0
 [<c014703c>] invalidate_mmap_range+0x7c/0x100
 [<c0194c10>] ext3_truncate+0x0/0x4e0
 [<c014714c>] vmtruncate+0x8c/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   935      1           936   929 (NOTLB)
Call Trace:
 [<c02b0537>] generic_unplug_device+0x67/0x70
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D EF8FBDD4   936      1           937   935 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c02b007b>] ll_front_merge_fn+0x4b/0x120
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   937      1           938   936 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   938      1           939   937 (NOTLB)
Call Trace:
 [<c01a1862>] do_get_write_access+0x522/0x680
 [<c011bf30>] default_wake_function+0x0/0x30
 [<c01a19f9>] journal_get_write_access+0x39/0x60
 [<c0194879>] ext3_free_data+0x39/0x150
 [<c0194e9b>] ext3_truncate+0x28b/0x4e0
 [<c014703c>] invalidate_mmap_range+0x7c/0x100
 [<c0194c10>] ext3_truncate+0x0/0x4e0
 [<c014714c>] vmtruncate+0x8c/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   939      1           940   938 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c015af00>] submit_bh+0x90/0x1e0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c02b1cc4>] submit_bio+0x54/0xa0
 [<c0158acd>] __bread_slow_wq+0xad/0xf0
 [<c0158db6>] __bread+0x46/0x50
 [<c018eb98>] read_block_bitmap+0x58/0xa0
 [<c018f902>] ext3_new_block+0x1a2/0x590
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c01922f7>] ext3_alloc_block+0x37/0x40
 [<c01926ba>] ext3_alloc_branch+0x4a/0x2c0
 [<c0158bc9>] bh_lru_install+0xb9/0xf0
 [<c0192cbc>] ext3_get_block_handle+0x18c/0x360
 [<c015b501>] alloc_buffer_head+0x41/0x50
 [<c0192ef4>] ext3_get_block+0x64/0xb0
 [<c0159827>] __block_prepare_write+0x227/0x4b0
 [<c015a364>] block_prepare_write+0x34/0x50
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c01934d1>] ext3_prepare_write+0x71/0x130
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c013a5cd>] generic_file_aio_write_nolock+0x38d/0xa50
 [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
 [<c011bf5a>] default_wake_function+0x2a/0x30
 [<c011de17>] autoremove_wake_function+0x27/0x50
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c013adee>] generic_file_aio_write+0x9e/0x120
 [<c0190bf4>] ext3_file_write+0x44/0xe0
 [<c0156046>] do_sync_write+0xb6/0xf0
 [<c02f689e>] scsi_put_command+0x6e/0x90
 [<c02fb63e>] scsi_end_request+0xae/0xc0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c03332b3>] qla2x00_intr_handler+0x203/0x220
 [<c015613e>] vfs_write+0xbe/0x130
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0156262>] sys_write+0x42/0x70
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   940      1           941   939 (NOTLB)
Call Trace:
 [<c02b0537>] generic_unplug_device+0x67/0x70
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D C3815338   941      1           942   940 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c015b390>] block_sync_page+0x0/0x10
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   942      1           943   941 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   943      1           944   942 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014703c>] invalidate_mmap_range+0x7c/0x100
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   944      1           945   943 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c015af00>] submit_bh+0x90/0x1e0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c02b1cc4>] submit_bio+0x54/0xa0
 [<c0158acd>] __bread_slow_wq+0xad/0xf0
 [<c0158db6>] __bread+0x46/0x50
 [<c018eb98>] read_block_bitmap+0x58/0xa0
 [<c018f902>] ext3_new_block+0x1a2/0x590
 [<c0158c73>] __find_get_block+0x73/0x100
 [<c01922f7>] ext3_alloc_block+0x37/0x40
 [<c01926ba>] ext3_alloc_branch+0x4a/0x2c0
 [<c01924c2>] ext3_get_branch+0x72/0x100
 [<c0192cbc>] ext3_get_block_handle+0x18c/0x360
 [<c015b501>] alloc_buffer_head+0x41/0x50
 [<c0192ef4>] ext3_get_block+0x64/0xb0
 [<c0159827>] __block_prepare_write+0x227/0x4b0
 [<c015a364>] block_prepare_write+0x34/0x50
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c01934d1>] ext3_prepare_write+0x71/0x130
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c013a5cd>] generic_file_aio_write_nolock+0x38d/0xa50
 [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
 [<c011de17>] autoremove_wake_function+0x27/0x50
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c013adee>] generic_file_aio_write+0x9e/0x120
 [<c0190bf4>] ext3_file_write+0x44/0xe0
 [<c0156046>] do_sync_write+0xb6/0xf0
 [<c02fb63e>] scsi_end_request+0xae/0xc0
 [<c02fb95d>] scsi_io_completion+0x14d/0x470
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0342c31>] sd_rw_intr+0x61/0x270
 [<c02f6fdc>] scsi_finish_command+0x8c/0xc0
 [<c03332b3>] qla2x00_intr_handler+0x203/0x220
 [<c015613e>] vfs_write+0xbe/0x130
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0156262>] sys_write+0x42/0x70
 [<c010943f>] syscall_call+0x7/0xb

fsx           D C0109E2E   945      1           946   944 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D C380CA70   946      1           947   945 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c015b390>] block_sync_page+0x0/0x10
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0138be6>] find_get_pages+0x36/0x60
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c014230e>] pagevec_lookup+0x2e/0x40
 [<c01426fc>] truncate_inode_pages+0x1cc/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D 00000001   947      1           948   946 (NOTLB)
Call Trace:
 [<c011c546>] io_schedule+0x26/0x30
 [<c0157565>] __wait_on_buffer_wq+0xf5/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c015af00>] submit_bh+0x90/0x1e0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c02b1cc4>] submit_bio+0x54/0xa0
 [<c0158acd>] __bread_slow_wq+0xad/0xf0
 [<c0158db6>] __bread+0x46/0x50
 [<c018eb98>] read_block_bitmap+0x58/0xa0
 [<c018f902>] ext3_new_block+0x1a2/0x590
 [<c0195ca9>] ext3_mark_iloc_dirty+0x29/0x40
 [<c01922f7>] ext3_alloc_block+0x37/0x40
 [<c01926ba>] ext3_alloc_branch+0x4a/0x2c0
 [<c0192cbc>] ext3_get_block_handle+0x18c/0x360
 [<c015b501>] alloc_buffer_head+0x41/0x50
 [<c0192ef4>] ext3_get_block+0x64/0xb0
 [<c0159827>] __block_prepare_write+0x227/0x4b0
 [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
 [<c015a364>] block_prepare_write+0x34/0x50
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c01934d1>] ext3_prepare_write+0x71/0x130
 [<c0192e90>] ext3_get_block+0x0/0xb0
 [<c013a5cd>] generic_file_aio_write_nolock+0x38d/0xa50
 [<c0195808>] ext3_do_update_inode+0x1c8/0x3d0
 [<c011bf5a>] default_wake_function+0x2a/0x30
 [<c011de17>] autoremove_wake_function+0x27/0x50
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c013adee>] generic_file_aio_write+0x9e/0x120
 [<c0190bf4>] ext3_file_write+0x44/0xe0
 [<c0156046>] do_sync_write+0xb6/0xf0
 [<c02f689e>] scsi_put_command+0x6e/0x90
 [<c02fb63e>] scsi_end_request+0xae/0xc0
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011bf9a>] __wake_up_common+0x3a/0x60
 [<c03332b3>] qla2x00_intr_handler+0x203/0x220
 [<c015613e>] vfs_write+0xbe/0x130
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0156262>] sys_write+0x42/0x70
 [<c010943f>] syscall_call+0x7/0xb

fsx           D C0109E2E   948      1           949   947 (NOTLB)
Call Trace:
 [<c0109e2e>] apic_timer_interrupt+0x1a/0x20
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb

fsx           D EF86BDD4   949      1           988   948 (NOTLB)
Call Trace:
 [<c02b0537>] generic_unplug_device+0x67/0x70
 [<c011c546>] io_schedule+0x26/0x30
 [<c01386ac>] wait_on_page_bit_wq+0xcc/0x100
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c011ddf0>] autoremove_wake_function+0x0/0x50
 [<c0142815>] truncate_inode_pages+0x2e5/0x2f0
 [<c014712b>] vmtruncate+0x6b/0x100
 [<c0171e94>] inode_setattr+0x134/0x150
 [<c0195aca>] ext3_setattr+0x7a/0x1a0
 [<c0160f6e>] cp_new_stat64+0xfe/0x110
 [<c0172080>] notify_change+0x160/0x19d
 [<c0153f3a>] do_truncate+0x6a/0x90
 [<c0161037>] sys_fstat64+0x37/0x40
 [<c0154228>] sys_ftruncate+0x118/0x1b0
 [<c01558f0>] generic_file_llseek+0x0/0xf0
 [<c0155c29>] sys_lseek+0x69/0xb0
 [<c010943f>] syscall_call+0x7/0xb



