Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWFQRH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWFQRH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWFQRH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 13:07:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750742AbWFQRHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 13:07:25 -0400
Date: Sat, 17 Jun 2006 10:07:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Charles C. Bennett, Jr." <ccb@acm.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: BUG: write-lock lockup
Message-Id: <20060617100710.ec05131f.akpm@osdl.org>
In-Reply-To: <1150142023.3621.22.camel@cbox.memecycle.com>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 15:53:43 -0400
"Charles C. Bennett, Jr." <ccb@acm.org> wrote:

> 
> Hi All -
> 
> 	I'm seeing write-lock lockups...  this is happening with
> the Fedora kernels from at least as far back as their 2.6.15-1.1833_FC4
> (2.6.15.5) and as recently as their 2.6.16-1.2111_FC4 (2.6.16.17).
> 
> It's a beefy box:
>  Gateway 9515R - Intel ICH5/ICH5R
>  Two Dual Core 3.0 ghz Xeons, 4GB RAM
>  All disks via Emulex LP101-H (thor), switched fabric to
>   Hitachi WMS SAN storage.
> 
> The lockups are not process-specific.  Running mke2fs on large
> filesystems seems to get it happen sooner rather than later.

Apart from these messages, does the machine otherwise work OK?

> I can fish out any other data you need, run tests, etc.
>
>
> Jun  9 20:43:40 localhost kernel: BUG: write-lock lockup on CPU#6, mkfs.ext2/3258, f799c864 (Not tainted)
> Jun  9 20:43:40 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
> Jun  9 20:43:40 localhost kernel:  [<c015532c>] shrink_list+0x197/0x45d     [<c01557a3>] shrink_cache+0xe7/0x29b
> Jun  9 20:43:40 localhost kernel:  [<c014d955>] bad_range+0x22/0x2f     [<c014dfe3>] __rmqueue+0xd1/0x156
> Jun  9 20:43:40 localhost kernel:  [<c0155db9>] shrink_zone+0x89/0xd8     [<c0155e6e>] shrink_caches+0x66/0x74
> Jun  9 20:43:40 localhost kernel:  [<c0155f29>] try_to_free_pages+0xad/0x1b7  [<c014e8a5>] __alloc_pages+0x136/0x2ec
> Jun  9 20:43:40 localhost kernel:  [<c016ca3e>] __block_commit_write+0x83/0x8f    [<c014be23>] generic_file_buffered_write+0x16b/0x655
> Jun  9 20:43:40 localhost kernel:  [<c012a04b>] current_fs_time+0x5a/0x75     [<c012a04b>] current_fs_time+0x5a/0x75
> Jun  9 20:43:40 localhost kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 [<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9
> Jun  9 20:43:40 localhost kernel:  [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92     [<c01719e0>] blkdev_file_write+0x0/0x24
> Jun  9 20:43:40 localhost kernel:  [<c014c99c>] generic_file_write_nolock+0x85/0x9f     [<c0139196>] autoremove_wake_function+0x0/0x37
> Jun  9 20:43:40 localhost kernel:  [<c0171a00>] blkdev_file_write+0x20/0x24 [<c01699f2>] vfs_write+0xa2/0x15a
> Jun  9 20:43:40 localhost kernel:  [<c0169b55>] sys_write+0x41/0x6a     [<c0104035>] syscall_call+0x7/0xb
> Jun  9 21:02:58 localhost kernel: BUG: write-lock lockup on CPU#1, mkfs.ext2/3259, f799c864 (Not tainted)
> Jun  9 21:02:58 localhost kernel:  [<c01f21d7>] __write_lock_debug+0xb4/0xdd  [<c01f223f>] _raw_write_lock+0x3f/0x7c
> Jun  9 21:02:58 localhost kernel:  [<c032bd15>] _write_lock_irqsave+0x9/0xd [<c015070d>] test_clear_page_writeback+0x2d/0xa6
> Jun  9 21:02:58 localhost kernel:  [<c014a09c>] end_page_writeback+0x76/0x84  [<c016b2c9>] end_buffer_async_write+0xbf/0x12a
> Jun  9 21:02:58 localhost kernel:  [<c01f1167>] memmove+0x24/0x2d     [<c014d292>] mempool_free+0x3a/0x73
> Jun  9 21:02:58 localhost kernel:  [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f [<c016db6a>] end_bio_bh_io_sync+0x0/0x4f
> Jun  9 21:02:58 localhost kernel:  [<c016db8d>] end_bio_bh_io_sync+0x23/0x4f  [<c016f307>] bio_endio+0x3e/0x69
> Jun  9 21:02:58 localhost kernel:  [<c01e2e88>] __end_that_request_first+0x101/0x235     [<f885c8af>] scsi_end_request+0x1b/0xb0 [scsi_mod]
> Jun  9 21:02:58 localhost kernel:  [<f885cbd5>] scsi_io_completion+0x151/0x4d2 [scsi_mod]     [<f8833c97>] sd_rw_intr+0x70/0x3c1 [sd_mod]
> Jun  9 21:02:58 localhost kernel:  [<f8857cad>] scsi_finish_command+0x82/0xd0 [scsi_mod]     [<f8857b8e>] scsi_softirq+0xc0/0x137 [scsi_mod]
> Jun  9 21:02:58 localhost kernel:  [<c012a1f2>] __do_softirq+0x72/0xdc     [<c0106383>] do_softirq+0x4b/0x4f
> Jun  9 21:02:58 localhost kernel:  =======================
> Jun  9 21:02:58 localhost kernel:  [<c0106265>] do_IRQ+0x55/0x86     [<c0104a7a>] common_interrupt+0x1a/0x20
> Jun  9 21:03:05 localhost kernel:  [<c014e387>] free_hot_cold_page+0xd5/0x126   [<c014eaf4>] __pagevec_free+0x1f/0x2e
> Jun  9 21:03:08 localhost kernel:  [<c0154371>] __pagevec_release_nonlru+0x29/0x8b     [<c01553aa>] shrink_list+0x215/0x45d
> Jun  9 21:03:09 localhost kernel:  [<c01557a3>] shrink_cache+0xe7/0x29b     [<c0155db9>] shrink_zone+0x89/0xd8
> Jun  9 21:03:09 localhost kernel:  [<c0155e6e>] shrink_caches+0x66/0x74     [<c0155f29>] try_to_free_pages+0xad/0x1b7
> Jun  9 21:03:09 localhost kernel:  [<c014e8a5>] __alloc_pages+0x136/0x2ec     [<c016ca3e>] __block_commit_write+0x83/0x8f
> Jun  9 21:03:10 localhost kernel:  [<c014be23>] generic_file_buffered_write+0x16b/0x655     [<c012a04b>] current_fs_time+0x5a/0x75
> Jun  9 21:03:11 localhost kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 [<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9
> Jun  9 21:03:11 localhost kernel:  [<c014c822>] generic_file_aio_write_nolock+0x3c/0x92     [<c01719e0>] blkdev_file_write+0x0/0x24
> Jun  9 21:03:12 localhost kernel:  [<c014c99c>] generic_file_write_nolock+0x85/0x9f     [<c0139196>] autoremove_wake_function+0x0/0x37
> Jun  9 21:03:12 localhost kernel:  [<c0171a00>] blkdev_file_write+0x20/0x24 [<c01699f2>] vfs_write+0xa2/0x15a
> Jun  9 21:03:12 localhost kernel:  [<c0169b55>] sys_write+0x41/0x6a     [<c0104035>] syscall_call+0x7/0xb

Well.  Obviously __write_lock_debug():print_once was meant to have static
scope (__read_mostly, too).  But that's a cosmetic thing.

I'm suspecting that the debug code has simply gone wrong here - that
there's such a lot of read_lock() traffic happening with this workload that
the debug version of write_lock() simply isn't able to take the lock.

This might fix it, but it'll break the timing calculations in that loop.

--- devel/lib/spinlock_debug.c~a	2006-06-17 03:08:35.000000000 -0700
+++ devel-akpm/lib/spinlock_debug.c	2006-06-17 03:08:56.000000000 -0700
@@ -219,7 +219,7 @@ static void __write_lock_debug(rwlock_t 
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
-			__delay(1);
+			cpu_relax();
 		}
 		/* lockup suspected: */
 		if (print_once) {
_


(I'm a little surprised that RH-FC ships with this debug option enabled.  It's
good for kernel development, but not optimal for users...)

Ingo, we have two bugs in there - some assist and thought would be
appreciated, please.
