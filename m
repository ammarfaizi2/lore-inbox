Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264742AbTFCA7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264743AbTFCA7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:59:19 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:30337 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264742AbTFCA7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:59:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: CFQ - 2.5.70-mm3 BUGs
Date: Tue, 3 Jun 2003 11:13:49 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306031113.49405.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd give the cfq another run since some change has made it into this 
patch and got these BUGs together (note, preempt enabled and UP +IDE):

------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1580!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<40257ff5>]    Not tainted VLI
EFLAGS: 00010097
EIP is at __blk_put_request+0x5d/0x108
eax: 40431dfc   ebx: 41390ae8   ecx: 40431dfc   edx: 00000000
esi: 00000001   edi: 40431dfc   ebp: 40431e7c   esp: 41299b58
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=41298000 task=412bf940)
Stack: 41390b7c 41390ae8 40431dfc 00000008 40258246 40431dfc 41390ae8 00000000
       41390b7c 40431dfc 40258509 40431dfc 41390b7c 41390ae8 4fd04d00 00000008
       00000003 00000008 00240029 00000008 00000001 00000000 41390b7c 40258945
Call Trace:
 [<40258246>] attempt_merge+0xae/0xbc
 [<40258509>] __make_request+0x245/0x4a8
 [<40258945>] generic_make_request+0x1d9/0x1ec
 [<40114924>] autoremove_wake_function+0x0/0x38
 [<40143088>] bio_alloc+0x11c/0x1a0
 [<402589a9>] submit_bio+0x51/0x5c
 [<40142a42>] submit_bh+0xfa/0x100
 [<401413c8>] __block_write_full_page+0x208/0x30c
 [<401428d4>] block_write_full_page+0xa8/0xb0
 [<40144f94>] blkdev_get_block+0x0/0x48
 [<401450a0>] blkdev_writepage+0x14/0x18
 [<40144f94>] blkdev_get_block+0x0/0x48
 [<4015baa6>] mpage_writepages+0x1c2/0x2bc
 [<4014508c>] blkdev_writepage+0x0/0x18
 [<40140e73>] __find_get_block+0xbb/0xc4
 [<40146119>] generic_writepages+0x11/0x15
 [<4012bca0>] do_writepages+0x18/0x2c
 [<401270cb>] __filemap_fdatawrite+0x93/0xa0
 [<401270e4>] filemap_fdatawrite+0xc/0x10
 [<4013fccb>] sync_blockdev+0x1b/0x3c
 [<4017b62e>] journal_recover+0x8a/0x98
 [<4017e146>] journal_load+0x46/0x7c
 [<40177640>] ext3_load_journal+0x13c/0x180
 [<40176e8d>] ext3_fill_super+0x6f5/0xa38
 [<40144a71>] get_sb_bdev+0xe5/0x130
 [<40177bf3>] ext3_get_sb+0x1f/0x24
 [<40176798>] ext3_fill_super+0x0/0xa38
 [<40144c32>] do_kern_mount+0x4a/0xb4
 [<40157959>] do_add_mount+0x69/0x138
 [<40157c42>] do_mount+0x152/0x16c
 [<40158060>] sys_mount+0xa4/0x110
 [<403d69af>] do_mount_root+0x1f/0x94
 [<403d6a72>] mount_block_root+0x4e/0x108
 [<403d6b59>] mount_root+0x2d/0x34
 [<403d6be2>] prepare_namespace+0x82/0xc0
 [<4010508b>] init+0x33/0x178
 [<40105058>] init+0x0/0x178
 [<40106f7d>] kernel_thread_helper+0x5/0xc

Code: ff c7 43 3c ff ff ff ff c7 43 5c 00 00 00 00 c7 43 60 00 00 00 00 83 c4 
08 85 ed 0f 84 af 00 00 00 8b 73 08 83 e6 01 39 1b 74 0b <0f> 0b 2c 06 1f ab 
2f 40 8d 76 00 53 57 e8 1d e4 ff ff 8b 87 88
 <0><4>------------[ cut here ]------------
kernel BUG at fs/buffer.c:579!
invalid operand: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<40140221>]    Not tainted VLI
EFLAGS: 00010046
EIP is at end_buffer_async_write+0x11/0xcc
eax: 00000019   ebx: 4fdb1540   ecx: 00000000   edx: 4fdb1540
esi: 00000001   edi: 40431dec   ebp: 41299880   esp: 4129981c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=41298000 task=412bf940)
Stack: 4fd04a00 00000000 40431dec 40142933 4fdb1540 00000001 4fd04a00 401439bc
       4fd04a00 00000000 00000000 00000000 4fd04a00 40258c84 4fd04a00 00000000
       00000000 41390ae8 00000008 40431dec 40431f38 00000000 00000000 00000000
Call Trace:
 [<40142933>] end_bio_bh_io_sync+0x1b/0x30
 [<401439bc>] bio_endio+0x4c/0x54
 [<40258c84>] __end_that_request_first+0x100/0x1d0
 [<40258d6b>] end_that_request_first+0x17/0x1c
 [<4026bc9e>] ide_end_request+0x7e/0x11c
 [<40274c08>] default_end_request+0x14/0x18
 [<40278b65>] ide_dma_intr+0x6d/0xac
 [<4026cfb1>] ide_intr+0xfd/0x174
 [<40278af8>] ide_dma_intr+0x0/0xac
 [<40109f97>] handle_IRQ_event+0x2b/0x50
 [<4010a273>] do_IRQ+0x8f/0x128
 [<40108d1c>] common_interrupt+0x18/0x20
 [<4024007b>] change_termios+0x3b/0x174
 [<40251934>] serial_in+0x44/0x4c
 [<402535e8>] serial8250_console_write+0x64/0x1d8
 [<40116726>] __call_console_drivers+0x3e/0x50
 [<4011678b>] _call_console_drivers+0x53/0x58
 [<40116845>] call_console_drivers+0xb5/0xe0
 [<40116a9e>] release_console_sem+0x4a/0xb4
 [<401169f7>] printk+0x11f/0x148
 [<40116221>] panic+0x31/0xe4
 [<40117d44>] do_exit+0x40/0x350
 [<40109307>] die+0xe7/0xe8
 [<401094fc>] do_invalid_op+0x0/0x8c
 [<4010957e>] do_invalid_op+0x82/0x8c
 [<40257ff5>] __blk_put_request+0x5d/0x108
 [<4012d7b5>] cache_alloc_refill+0x1a1/0x1e4
 [<40129e63>] mempool_alloc_slab+0xf/0x14
 [<40129cf0>] mempool_alloc+0x6c/0x14c
 [<40108d59>] error_code+0x2d/0x38
 [<40257ff5>] __blk_put_request+0x5d/0x108
 [<40258246>] attempt_merge+0xae/0xbc
 [<40258509>] __make_request+0x245/0x4a8
 [<40258945>] generic_make_request+0x1d9/0x1ec
 [<40114924>] autoremove_wake_function+0x0/0x38
 [<40143088>] bio_alloc+0x11c/0x1a0
 [<402589a9>] submit_bio+0x51/0x5c
 [<40142a42>] submit_bh+0xfa/0x100
 [<401413c8>] __block_write_full_page+0x208/0x30c
 [<401428d4>] block_write_full_page+0xa8/0xb0
 [<40144f94>] blkdev_get_block+0x0/0x48
 [<401450a0>] blkdev_writepage+0x14/0x18
 [<40144f94>] blkdev_get_block+0x0/0x48
 [<4015baa6>] mpage_writepages+0x1c2/0x2bc
 [<4014508c>] blkdev_writepage+0x0/0x18
 [<40140e73>] __find_get_block+0xbb/0xc4
 [<40146119>] generic_writepages+0x11/0x15
 [<4012bca0>] do_writepages+0x18/0x2c
 [<401270cb>] __filemap_fdatawrite+0x93/0xa0
 [<401270e4>] filemap_fdatawrite+0xc/0x10
 [<4013fccb>] sync_blockdev+0x1b/0x3c
 [<4017b62e>] journal_recover+0x8a/0x98
 [<4017e146>] journal_load+0x46/0x7c
 [<40177640>] ext3_load_journal+0x13c/0x180
 [<40176e8d>] ext3_fill_super+0x6f5/0xa38
 [<40144a71>] get_sb_bdev+0xe5/0x130
 [<40177bf3>] ext3_get_sb+0x1f/0x24
 [<40176798>] ext3_fill_super+0x0/0xa38
 [<40144c32>] do_kern_mount+0x4a/0xb4
 [<40157959>] do_add_mount+0x69/0x138
 [<40157c42>] do_mount+0x152/0x16c
 [<40158060>] sys_mount+0xa4/0x110
 [<403d69af>] do_mount_root+0x1f/0x94
 [<403d6a72>] mount_block_root+0x4e/0x108
 [<403d6b59>] mount_root+0x2d/0x34
 [<403d6be2>] prepare_namespace+0x82/0xc0
 [<4010508b>] init+0x33/0x178
 [<40105058>] init+0x0/0x178
 [<40106f7d>] kernel_thread_helper+0x5/0xc

Code: ff 21 e0 ff 48 14 8b 40 08 a8 08 74 05 e8 c0 31 fd ff 5b 5e 5f 5d c3 8d 
76 00 57 56 53 8b 5c 24 10 8b 74 24 14 8b 03 a8 80 75 0f <0f> 0b 43 02 46 a8 
2d 40 8d b4 26 00 00 00 00 8b 7b 0c 85 f6 74
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


Con
