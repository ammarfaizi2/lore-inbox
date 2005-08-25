Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVHYLTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVHYLTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 07:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVHYLTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 07:19:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23466 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964933AbVHYLTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 07:19:50 -0400
Date: Thu, 25 Aug 2005 13:19:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.13-rc7: crash on removing CF card
Message-ID: <20050825111943.GB4018@suse.de>
References: <20050825094846.GA2097@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825094846.GA2097@elf.ucw.cz>
X-IMAPbase: 1124875140 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25 2005, Pavel Machek wrote:
> Hi!
> 
> Something went wrong with PCMCIA on this X32. I inserted CF card, but
> it detected both hde *and* hdf, mount took forever. At that point I
> decided that I want my CF card back, took it back, it started
> producing different I/O errors , and then it oopsed.

Looks like the queue was killed while someone still holds a reference to
it. Is it reproducible with eg deadline as the io scheduler?

(cc'ing Bart as well, leaving oops below).

> Aug 25 11:21:04 amd -- MARK --
> Aug 25 11:35:23 amd kernel: cs: memory probe 0xe8000000-0xefffffff: excluding 0xe8000000-0xefffffff
> Aug 25 11:35:23 amd kernel: cs: memory probe 0xc0200000-0xcfffffff: excluding 0xc0200000-0xc11fffff 0xc1a00000-0xc61fffff 0xc6a00000-0xc71fffff 0xc7a00000-0xc81fffff 0xc8a00000-0xc91fffff 0xc9a00000-0xca1fffff 0xcaa00000-0xcb1fffff 0xcba00000-0xcc1fffff 0xcca00000-0xcd1fffff 0xcda00000-0xce1fffff 0xcea00000-0xcf1fffff 0xcfa00000-0xd01fffff
> Aug 25 11:35:23 amd kernel: hde: Transcend, CFA DISK drive
> Aug 25 11:35:23 amd kernel: hdf: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
> Aug 25 11:35:24 amd kernel: hdf: ^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H(^H^H^H(^H^H^H^H, ATA DISK drive
> Aug 25 11:35:24 amd kernel: ide2 at 0x8040-0x8047,0x804e on irq 7
> Aug 25 11:35:24 amd kernel: hde: max request size: 128KiB
> Aug 25 11:35:24 amd kernel: hde: 503808 sectors (257 MB) w/0KiB Cache, CHS=984/16/32
> Aug 25 11:35:24 amd kernel: hde: cache flushes not supported
> Aug 25 11:35:24 amd kernel:  hde: hde1
> Aug 25 11:35:24 amd kernel: hdf: max request size: 128KiB
> Aug 25 11:35:24 amd kernel: hdf: 131584 sectors (67 MB) w/1028KiB Cache, CHS=2056/8/8
> Aug 25 11:35:24 amd kernel: hdf: cache flushes not supported
> Aug 25 11:35:54 amd kernel:  hdf:<6> hde:<4>hdf: lost interrupt
> Aug 25 11:36:24 amd kernel: hdf: lost interrupt
> Aug 25 11:36:54 amd kernel: hdf: lost interrupt
> Aug 25 11:37:54 amd last message repeated 2 times
> Aug 25 11:38:54 amd last message repeated 2 times
> Aug 25 11:39:54 amd last message repeated 2 times
> Aug 25 11:40:54 amd last message repeated 2 times
> Aug 25 11:41:54 amd last message repeated 2 times
> Aug 25 11:42:24 amd kernel: hdf: lost interrupt
> Aug 25 11:42:54 amd kernel: hdf: irq timeout: status=0xff { Busy }
> Aug 25 11:42:54 amd kernel: ide: failed opcode was: unknown
> Aug 25 11:43:29 amd kernel: ide2: reset timed-out, status=0xff
> Aug 25 11:43:29 amd kernel: hde: status timeout: status=0xff { Busy }
> Aug 25 11:43:29 amd kernel: ide: failed opcode was: unknown
> Aug 25 11:43:29 amd kernel: hde: drive not ready for command
> Aug 25 11:44:04 amd kernel: ide2: reset timed-out, status=0xff
> Aug 25 11:44:04 amd kernel: hde: status timeout: status=0xff { Busy }
> Aug 25 11:44:04 amd kernel: ide: failed opcode was: unknown
> Aug 25 11:44:04 amd kernel: hde: drive not ready for command
> Aug 25 11:44:34 amd kernel: ide2: reset timed-out, status=0xff
> Aug 25 11:44:34 amd kernel: end_request: I/O error, dev hde, sector 0
> Aug 25 11:44:34 amd kernel: Buffer I/O error on device hde, logical block 0
> Aug 25 11:44:39 amd kernel: hdf: status timeout: status=0xff { Busy }
> Aug 25 11:44:39 amd kernel: ide: failed opcode was: unknown
> Aug 25 11:44:39 amd kernel: hdf: drive not ready for command
> Aug 25 11:45:09 amd kernel: ide2: reset timed-out, status=0xff
> Aug 25 11:45:09 amd kernel: end_request: I/O error, dev hde, sector 0
> Aug 25 11:45:09 amd kernel: Buffer I/O error on device hde, logical block 0
> Aug 25 11:45:09 amd kernel: end_request: I/O error, dev hdf, sector 0
> Aug 25 11:45:09 amd kernel: Buffer I/O error on device hdf, logical block 0
> Aug 25 11:45:09 amd kernel: end_request: I/O error, dev hdf, sector 0
> Aug 25 11:45:09 amd kernel: Buffer I/O error on device hdf, logical block 0
> Aug 25 11:45:09 amd kernel: ldm_validate_partition_table(): Disk read failed.
> Aug 25 11:45:09 amd kernel: end_request: I/O error, dev hdf, sector 0
> Aug 25 11:45:09 amd kernel: Buffer I/O error on device hdf, logical block 0
> Aug 25 11:45:09 amd kernel:  unable to read partition table
> Aug 25 11:45:09 amd kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
> Aug 25 11:45:09 amd kernel: ldm_validate_partition_table(): Disk read failed.
> Aug 25 11:45:10 amd kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> Aug 25 11:45:10 amd kernel:  printing eip:
> Aug 25 11:45:10 amd kernel: c02f635b
> Aug 25 11:45:10 amd kernel: *pde = 00000000
> Aug 25 11:45:10 amd kernel: Oops: 0000 [#1]
> Aug 25 11:45:10 amd kernel: PREEMPT
> Aug 25 11:45:10 amd kernel: Modules linked in:
> Aug 25 11:45:10 amd kernel: CPU:    0
> Aug 25 11:45:10 amd kernel: EIP:    0060:[as_find_arq_hash+43/160]    Not tainted VLI
> Aug 25 11:45:10 amd kernel: EFLAGS: 00010046   (2.6.13-rc7)
> Aug 25 11:45:10 amd kernel: EIP is at as_find_arq_hash+0x2b/0xa0
> Aug 25 11:45:10 amd kernel: eax: 00000004   ebx: c02f7f50   ecx: f7d78340   edx: 00000004
> Aug 25 11:45:10 amd kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp: f6aa5aa0
> Aug 25 11:45:10 amd kernel: ds: 007b   es: 007b   ss: 0068
> Aug 25 11:45:10 amd cardmgr[1429]: socket 1: Anonymous Memory
> Aug 25 11:45:10 amd kernel: Process mount (pid: 1965, threadinfo=f6aa4000 task=f6e525d0)
> Aug 25 11:45:10 amd kernel: Stack: 00000004 f7d78340 c02f7f50 00000000 f6a26200 00000000 c02f805e 00000007
> Aug 25 11:45:10 amd kernel:        00000000 f7c5c000 00000086 00000008 00000000 f7d78340 f6aa5b24 f76e0dc8
> Aug 25 11:45:10 amd kernel:        c02f7f50 f76e0dc8 00000000 00000000 c02eecb8 00000000 f76e0dc8 c02f282f
> Aug 25 11:45:10 amd kernel: Call Trace:
> Aug 25 11:45:10 amd kernel:  [as_merge+0/464] as_merge+0x0/0x1d0
> Aug 25 11:45:10 amd kernel:  [as_merge+270/464] as_merge+0x10e/0x1d0
> Aug 25 11:45:10 amd kernel:  [as_merge+0/464] as_merge+0x0/0x1d0
> Aug 25 11:45:10 amd kernel:  [elv_merge+40/48] elv_merge+0x28/0x30
> Aug 25 11:45:10 amd kernel:  [__make_request+607/1280] __make_request+0x25f/0x500
> Aug 25 11:45:10 amd kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
> Aug 25 11:45:10 amd kernel:  [generic_make_request+320/544] generic_make_request+0x140/0x220
> Aug 25 11:45:10 amd kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
> Aug 25 11:45:10 amd kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
> Aug 25 11:45:10 amd kernel:  [__wake_up_common+55/112] __wake_up_common+0x37/0x70
> Aug 25 11:45:10 amd kernel:  [submit_bio+88/224] submit_bio+0x58/0xe0
> Aug 25 11:45:10 amd kernel:  [__switch_to+28/368] __switch_to+0x1c/0x170
> Aug 25 11:45:10 amd kernel:  [schedule+823/1600] schedule+0x337/0x640
> Aug 25 11:45:10 amd kernel:  [bio_alloc_bioset+217/464] bio_alloc_bioset+0xd9/0x1d0
> Aug 25 11:45:10 amd kernel:  [end_buffer_async_read+0/288] end_buffer_async_read+0x0/0x120
> Aug 25 11:45:10 amd kernel:  [submit_bh+290/400] submit_bh+0x122/0x190
> Aug 25 11:45:10 amd kernel:  [block_read_full_page+505/816] block_read_full_page+0x1f9/0x330
> Aug 25 11:45:10 amd kernel:  [blkdev_get_block+0/112] blkdev_get_block+0x0/0x70
> Aug 25 11:45:10 amd kernel:  [add_to_page_cache+150/176] add_to_page_cache+0x96/0xb0
> Aug 25 11:45:10 amd kernel:  [lru_cache_add+51/96] lru_cache_add+0x33/0x60
> Aug 25 11:45:10 amd kernel:  [read_cache_page+124/576] read_cache_page+0x7c/0x240
> Aug 25 11:45:10 amd kernel:  [blkdev_readpage+0/16] blkdev_readpage+0x0/0x10
> Aug 25 11:45:10 amd kernel:  [read_dev_sector+46/176] read_dev_sector+0x2e/0xb0
> Aug 25 11:45:10 amd kernel:  [msdos_partition+69/864] msdos_partition+0x45/0x360
> Aug 25 11:45:10 amd kernel:  [ldm_partition+55/496] ldm_partition+0x37/0x1f0
> Aug 25 11:45:10 amd kernel:  [snprintf+31/48] snprintf+0x1f/0x30
> Aug 25 11:45:10 amd kernel:  [disk_name+168/176] disk_name+0xa8/0xb0
> Aug 25 11:45:10 amd kernel:  [check_partition+160/272] check_partition+0xa0/0x110
> Aug 25 11:45:10 amd kernel:  [rescan_partitions+107/320] rescan_partitions+0x6b/0x140
> Aug 25 11:45:10 amd kernel:  [task_no_data_intr+0/160] task_no_data_intr+0x0/0xa0
> Aug 25 11:45:10 amd kernel:  [do_open+157/816] do_open+0x9d/0x330
> Aug 25 11:45:10 amd kernel:  [blkdev_get+124/160] blkdev_get+0x7c/0xa0
> Aug 25 11:45:10 amd kernel:  [bdget+250/272] bdget+0xfa/0x110
> Aug 25 11:45:10 amd kernel:  [bdev_set+0/16] bdev_set+0x0/0x10
> Aug 25 11:45:10 amd kernel:  [do_open+448/816] do_open+0x1c0/0x330
> Aug 25 11:45:10 amd kernel:  [blkdev_open+37/96] blkdev_open+0x25/0x60
> Aug 25 11:45:10 amd kernel:  [dentry_open+358/608] dentry_open+0x166/0x260
> Aug 25 11:45:10 amd kernel:  [filp_open+79/96] filp_open+0x4f/0x60
> Aug 25 11:45:10 amd kernel:  [get_unused_fd+151/224] get_unused_fd+0x97/0xe0
> Aug 25 11:45:10 amd kernel:  [getname+103/176] getname+0x67/0xb0
> Aug 25 11:45:10 amd kernel:  [sys_open+73/208] sys_open+0x49/0xd0
> Aug 25 11:45:10 amd kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Aug 25 11:45:10 amd kernel: Code: 55 89 cd 57 89 d7 56 53 83 ec 08 89 44 24 04 89 d0 0f ac c8 03 8b 4c 24 04 69 c0 01 00 37 9e 8b 51 38 c1 e8 1a 8d 04 c2 89 04 24 <8b> 30 39 c6 74 39 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90
> Aug 25 11:45:10 amd kernel:  <6>note: mount[1965] exited with preempt_count 1
> Aug 25 11:45:10 amd cardmgr[1429]: executing: 'modprobe memory_cs'
> Aug 25 11:45:10 amd kernel: 2.6. kernels use pcmciamtd instead of memory_cs.c and do not require special
> Aug 25 11:45:10 amd kernel: MTD handling any more.
> Aug 25 11:45:10 amd cardmgr[1429]: + FATAL: Could not load /lib/modules/2.6.13-rc7/modules.dep: No such file or directory
> Aug 25 11:45:10 amd cardmgr[1429]: modprobe exited with status 1
> Aug 25 11:45:10 amd cardmgr[1429]: module //pcmcia/memory_cs.o not available
> Aug 25 11:45:10 amd cardmgr[1429]: bind 'memory_cs' to socket 1 failed: Invalid argument
> Aug 25 11:45:10 amd cardmgr[1429]: executing: 'modprobe -r memory_cs'
> Aug 25 11:45:10 amd cardmgr[1429]: + FATAL: Could not load /lib/modules/2.6.13-rc7/modules.dep: No such file or directory
> Aug 25 11:45:10 amd cardmgr[1429]: modprobe exited with status 1
> Aug 25 11:46:25 amd log1n[1487]: ROOT LOGIN on `tty6'
> /var/log/syslog lines 2692-2743/2743 (END)
> 
> -- 
> if you have sharp zaurus hardware you don't need... you know my address
> 

-- 
Jens Axboe

