Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUAKUXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUAKUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:23:37 -0500
Received: from mail.netbeat.de ([193.254.185.26]:57017 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S265975AbUAKUX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:23:29 -0500
Subject: 2.6.1-mm2: BUG in kswapd?
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073842387.3720.5.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 18:33:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

After 24 hours running 2.6.1-mm2 I got the following BUG in kswapd:

Jan 11 06:27:41 JHome kernel: ------------[ cut here ]------------
Jan 11 06:27:41 JHome kernel: kernel BUG at include/linux/list.h:148!
Jan 11 06:27:41 JHome kernel: invalid operand: 0000 [#1]
Jan 11 06:27:41 JHome kernel: PREEMPT 
Jan 11 06:27:41 JHome kernel: CPU:    0
Jan 11 06:27:41 JHome kernel: EIP:    0060:[<c016fc36>]    Tainted: GF  VLI
Jan 11 06:27:41 JHome kernel: EFLAGS: 00010206
Jan 11 06:27:41 JHome kernel: EIP is at prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: eax: 00000000   ebx: dc3b06c0   ecx: dc3b06d4   edx: dca6585c
Jan 11 06:27:41 JHome kernel: esi: dc3b0730   edi: dfdd8000   ebp: 00000067   esp: dfdd9e7c
Jan 11 06:27:41 JHome kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 06:27:41 JHome kernel: Process kswapd0 (pid: 8, threadinfo=dfdd8000 task=dfddece0)
Jan 11 06:27:41 JHome kernel: Stack: df683cc0 00000000 00000080 dfdd8000 000001ac dffeeb60 c01700f3 00000080 
Jan 11 06:27:41 JHome kernel: c0146dde 00000080 000000d0 000159b5 07a9b6c8 00000000 000005ac 00000000 
Jan 11 06:27:41 JHome kernel: 00000162 c034d674 00000001 ffffff4f c01481b2 00000162 000000d0 000000d0 
Jan 11 06:27:41 JHome kernel: Call Trace:
Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
Jan 11 06:27:41 JHome kernel: 
Jan 11 06:27:41 JHome kernel: Code: 4f 14 a8 08 75 11 8b 47 08 ff 4f 14 a8 08 74 b3 e8 60 fb fa ff eb ac e8 59 fb fa ff eb e8 0f 0b 95 00 3d fe 2f c0 e9 33 ff ff ff <0f> 0b 94 00 3d fe 2f c0 e9 1a ff ff ff 8d b6 00 00 00 00 8d bc 
Jan 11 06:27:41 JHome kernel: Badness in set_palette at drivers/char/vt.c:2859
Jan 11 06:27:41 JHome kernel: Call Trace:
Jan 11 06:27:41 JHome kernel: [<c010dac0>] do_invalid_op+0x0/0xd0
Jan 11 06:27:41 JHome kernel: [<c022d53a>] set_palette+0x6a/0x70
Jan 11 06:27:41 JHome kernel: [<c022d33b>] unblank_screen+0x8b/0x140
Jan 11 06:27:41 JHome kernel: [<c011d2ec>] bust_spinlocks+0x2c/0x60
Jan 11 06:27:41 JHome kernel: [<c010d775>] die+0x95/0x100
Jan 11 06:27:41 JHome kernel: [<c010db89>] do_invalid_op+0xc9/0xd0
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c0126f36>] tasklet_action+0x46/0x70
Jan 11 06:27:41 JHome kernel: [<c010eced>] do_IRQ+0xfd/0x130
Jan 11 06:27:41 JHome kernel: [<c02f0de8>] common_interrupt+0x18/0x20
Jan 11 06:27:41 JHome kernel: [<c015b081>] invalidate_inode_buffers+0x11/0x70
Jan 11 06:27:41 JHome kernel: [<c0171683>] clear_inode+0x13/0xb0
Jan 11 06:27:41 JHome kernel: [<c0172c6f>] wake_up_inode+0xf/0x30
Jan 11 06:27:41 JHome kernel: [<c02f0e27>] error_code+0x2f/0x38
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
Jan 11 06:27:41 JHome kernel: 
Jan 11 06:27:41 JHome kernel: <6>note: kswapd0[8] exited with preempt_count 2
Jan 11 06:27:41 JHome kernel: bad: scheduling while atomic!
Jan 11 06:27:41 JHome kernel: Call Trace:
Jan 11 06:27:41 JHome kernel: [<c011f775>] schedule+0x5a5/0x5b0
Jan 11 06:27:41 JHome kernel: [<c01916e1>] ext3_ordered_commit_write+0xd1/0xe0
Jan 11 06:27:41 JHome kernel: [<c0191530>] ext3_journal_dirty_data+0x0/0x60
Jan 11 06:27:41 JHome kernel: [<c013efb9>] generic_file_aio_write_nolock+0x5c9/0xaf0
Jan 11 06:27:41 JHome kernel: [<c02282df>] scrup+0x14f/0x170
Jan 11 06:27:41 JHome kernel: [<c02712f8>] vgacon_cursor+0xe8/0x1e0
Jan 11 06:27:41 JHome kernel: [<c0123427>] __call_console_drivers+0x57/0x60
Jan 11 06:27:41 JHome kernel: [<c0123525>] call_console_drivers+0x65/0x120
Jan 11 06:27:41 JHome kernel: [<c01d3367>] vsnprintf+0x227/0x450
Jan 11 06:27:41 JHome kernel: [<c013f5f7>] generic_file_aio_write+0x77/0xa0
Jan 11 06:27:41 JHome kernel: [<c018eca4>] ext3_file_write+0x44/0xc0
Jan 11 06:27:41 JHome kernel: [<c0158c7b>] do_sync_write+0x8b/0xc0
Jan 11 06:27:41 JHome kernel: [<c012a894>] __mod_timer+0x134/0x1a0
Jan 11 06:27:41 JHome kernel: [<c013c2f0>] check_free_space+0xe0/0x170
Jan 11 06:27:41 JHome kernel: [<c013c8ac>] do_acct_process+0x27c/0x290
Jan 11 06:27:41 JHome kernel: [<c013c906>] acct_process+0x46/0x8c
Jan 11 06:27:41 JHome kernel: [<c01251b5>] do_exit+0x85/0x410
Jan 11 06:27:41 JHome kernel: [<c010dac0>] do_invalid_op+0x0/0xd0
Jan 11 06:27:41 JHome kernel: [<c010d7d9>] die+0xf9/0x100
Jan 11 06:27:41 JHome kernel: [<c010db89>] do_invalid_op+0xc9/0xd0
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c0126f36>] tasklet_action+0x46/0x70
Jan 11 06:27:41 JHome kernel: [<c010eced>] do_IRQ+0xfd/0x130
Jan 11 06:27:41 JHome kernel: [<c02f0de8>] common_interrupt+0x18/0x20
Jan 11 06:27:41 JHome kernel: [<c015b081>] invalidate_inode_buffers+0x11/0x70
Jan 11 06:27:41 JHome kernel: [<c0171683>] clear_inode+0x13/0xb0
Jan 11 06:27:41 JHome kernel: [<c0172c6f>] wake_up_inode+0xf/0x30
Jan 11 06:27:41 JHome kernel: [<c02f0e27>] error_code+0x2f/0x38
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200Jan 11 06:27:41 JHome kernel: ------------[ cut here ]------------
Jan 11 06:27:41 JHome kernel: kernel BUG at include/linux/list.h:148!
Jan 11 06:27:41 JHome kernel: invalid operand: 0000 [#1]
Jan 11 06:27:41 JHome kernel: PREEMPT 
Jan 11 06:27:41 JHome kernel: CPU:    0
Jan 11 06:27:41 JHome kernel: EIP:    0060:[<c016fc36>]    Tainted: GF  VLI
Jan 11 06:27:41 JHome kernel: EFLAGS: 00010206
Jan 11 06:27:41 JHome kernel: EIP is at prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: eax: 00000000   ebx: dc3b06c0   ecx: dc3b06d4   edx: dca6585c
Jan 11 06:27:41 JHome kernel: esi: dc3b0730   edi: dfdd8000   ebp: 00000067   esp: dfdd9e7c
Jan 11 06:27:41 JHome kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 06:27:41 JHome kernel: Process kswapd0 (pid: 8, threadinfo=dfdd8000 task=dfddece0)
Jan 11 06:27:41 JHome kernel: Stack: df683cc0 00000000 00000080 dfdd8000 000001ac dffeeb60 c01700f3 00000080 
Jan 11 06:27:41 JHome kernel: c0146dde 00000080 000000d0 000159b5 07a9b6c8 00000000 000005ac 00000000 
Jan 11 06:27:41 JHome kernel: 00000162 c034d674 00000001 ffffff4f c01481b2 00000162 000000d0 000000d0 
Jan 11 06:27:41 JHome kernel: Call Trace:
Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
Jan 11 06:27:41 JHome kernel: 
Jan 11 06:27:41 JHome kernel: Code: 4f 14 a8 08 75 11 8b 47 08 ff 4f 14 a8 08 74 b3 e8 60 fb fa ff eb ac e8 59 fb fa ff eb e8 0f 0b 95 00 3d fe 2f c0 e9 33 ff ff ff <0f> 0b 94 00 3d fe 2f c0 e9 1a ff ff ff 8d b6 00 00 00 00 8d bc 
Jan 11 06:27:41 JHome kernel: Badness in set_palette at drivers/char/vt.c:2859
Jan 11 06:27:41 JHome kernel: Call Trace:
Jan 11 06:27:41 JHome kernel: [<c010dac0>] do_invalid_op+0x0/0xd0
Jan 11 06:27:41 JHome kernel: [<c022d53a>] set_palette+0x6a/0x70
Jan 11 06:27:41 JHome kernel: [<c022d33b>] unblank_screen+0x8b/0x140
Jan 11 06:27:41 JHome kernel: [<c011d2ec>] bust_spinlocks+0x2c/0x60
Jan 11 06:27:41 JHome kernel: [<c010d775>] die+0x95/0x100
Jan 11 06:27:41 JHome kernel: [<c010db89>] do_invalid_op+0xc9/0xd0
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c0126f36>] tasklet_action+0x46/0x70
Jan 11 06:27:41 JHome kernel: [<c010eced>] do_IRQ+0xfd/0x130
Jan 11 06:27:41 JHome kernel: [<c02f0de8>] common_interrupt+0x18/0x20
Jan 11 06:27:41 JHome kernel: [<c015b081>] invalidate_inode_buffers+0x11/0x70
Jan 11 06:27:41 JHome kernel: [<c0171683>] clear_inode+0x13/0xb0
Jan 11 06:27:41 JHome kernel: [<c0172c6f>] wake_up_inode+0xf/0x30
Jan 11 06:27:41 JHome kernel: [<c02f0e27>] error_code+0x2f/0x38
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
Jan 11 06:27:41 JHome kernel: 
Jan 11 06:27:41 JHome kernel: <6>note: kswapd0[8] exited with preempt_count 2
Jan 11 06:27:41 JHome kernel: bad: scheduling while atomic!
Jan 11 06:27:41 JHome kernel: Call Trace:
Jan 11 06:27:41 JHome kernel: [<c011f775>] schedule+0x5a5/0x5b0
Jan 11 06:27:41 JHome kernel: [<c01916e1>] ext3_ordered_commit_write+0xd1/0xe0
Jan 11 06:27:41 JHome kernel: [<c0191530>] ext3_journal_dirty_data+0x0/0x60
Jan 11 06:27:41 JHome kernel: [<c013efb9>] generic_file_aio_write_nolock+0x5c9/0xaf0
Jan 11 06:27:41 JHome kernel: [<c02282df>] scrup+0x14f/0x170
Jan 11 06:27:41 JHome kernel: [<c02712f8>] vgacon_cursor+0xe8/0x1e0
Jan 11 06:27:41 JHome kernel: [<c0123427>] __call_console_drivers+0x57/0x60
Jan 11 06:27:41 JHome kernel: [<c0123525>] call_console_drivers+0x65/0x120
Jan 11 06:27:41 JHome kernel: [<c01d3367>] vsnprintf+0x227/0x450
Jan 11 06:27:41 JHome kernel: [<c013f5f7>] generic_file_aio_write+0x77/0xa0
Jan 11 06:27:41 JHome kernel: [<c018eca4>] ext3_file_write+0x44/0xc0
Jan 11 06:27:41 JHome kernel: [<c0158c7b>] do_sync_write+0x8b/0xc0
Jan 11 06:27:41 JHome kernel: [<c012a894>] __mod_timer+0x134/0x1a0
Jan 11 06:27:41 JHome kernel: [<c013c2f0>] check_free_space+0xe0/0x170
Jan 11 06:27:41 JHome kernel: [<c013c8ac>] do_acct_process+0x27c/0x290
Jan 11 06:27:41 JHome kernel: [<c013c906>] acct_process+0x46/0x8c
Jan 11 06:27:41 JHome kernel: [<c01251b5>] do_exit+0x85/0x410
Jan 11 06:27:41 JHome kernel: [<c010dac0>] do_invalid_op+0x0/0xd0
Jan 11 06:27:41 JHome kernel: [<c010d7d9>] die+0xf9/0x100
Jan 11 06:27:41 JHome kernel: [<c010db89>] do_invalid_op+0xc9/0xd0
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c0126f36>] tasklet_action+0x46/0x70
Jan 11 06:27:41 JHome kernel: [<c010eced>] do_IRQ+0xfd/0x130
Jan 11 06:27:41 JHome kernel: [<c02f0de8>] common_interrupt+0x18/0x20
Jan 11 06:27:41 JHome kernel: [<c015b081>] invalidate_inode_buffers+0x11/0x70
Jan 11 06:27:41 JHome kernel: [<c0171683>] clear_inode+0x13/0xb0
Jan 11 06:27:41 JHome kernel: [<c0172c6f>] wake_up_inode+0xf/0x30
Jan 11 06:27:41 JHome kernel: [<c02f0e27>] error_code+0x2f/0x38
Jan 11 06:27:41 JHome kernel: [<c016fc36>] prune_dcache+0x1d6/0x1f0
Jan 11 06:27:41 JHome kernel: [<c01700f3>] shrink_dcache_memory+0x23/0x30
Jan 11 06:27:41 JHome kernel: [<c0146dde>] shrink_slab+0x11e/0x170
Jan 11 06:27:41 JHome kernel: [<c01481b2>] balance_pgdat+0x1d2/0x200
Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
Jan 11 06:27:41 JHome kernel: 
Jan 11 06:27:41 JHome kernel: [<c01482f7>] kswapd+0x117/0x130
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c02f0b5e>] ret_from_fork+0x6/0x14
Jan 11 06:27:41 JHome kernel: [<c0120fa0>] autoremove_wake_function+0x0/0x50
Jan 11 06:27:41 JHome kernel: [<c01481e0>] kswapd+0x0/0x130
Jan 11 06:27:41 JHome kernel: [<c010b289>] kernel_thread_helper+0x5/0xc
Jan 11 06:27:41 JHome kernel: 

-- 
Jan Ischebeck <mail@jan-ischebeck.de>

