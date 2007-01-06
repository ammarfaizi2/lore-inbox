Return-Path: <linux-kernel-owner+w=401wt.eu-S1751167AbXAFDtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbXAFDtU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 22:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXAFDtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 22:49:19 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:50064 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751167AbXAFDtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 22:49:19 -0500
X-Greylist: delayed 4194 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 22:49:18 EST
Date: Sat, 6 Jan 2007 04:39:07 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG: warning at mm/truncate.c:60/cancel_dirty_page()
Message-ID: <20070106023907.GA7766@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.19.1 SMP [2] on Pentium D...
I was running dt-15.14 [2] and I ran
"cinfo datafile" (it does mincore()).
Well it went OK but when I ran "strace cinfo datafile"...:
04:18:48.062466 mincore(0x37f1f000, 2147266560, 
...
2007-01-06 04:19:03.788181500 <4>BUG: warning at mm/truncate.c:60/cancel_dirty_page()
2007-01-06 04:19:03.788221500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
2007-01-06 04:19:03.788223500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
2007-01-06 04:19:03.788224500 <4> [<c0103dcb>] show_trace+0x12/0x14
2007-01-06 04:19:03.788225500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
2007-01-06 04:19:03.788227500 <4> [<c01546a6>] cancel_dirty_page+0x7e/0x80
2007-01-06 04:19:03.788228500 <4> [<c01546c2>] truncate_complete_page+0x1a/0x47
2007-01-06 04:19:03.788229500 <4> [<c0154854>] truncate_inode_pages_range+0x114/0x2ae
2007-01-06 04:19:03.788245500 <4> [<c0154a08>] truncate_inode_pages+0x1a/0x1c
2007-01-06 04:19:03.788247500 <4> [<c0269244>] fs_flushinval_pages+0x40/0x77
2007-01-06 04:19:03.788248500 <4> [<c026d48c>] xfs_write+0x8c4/0xb68
2007-01-06 04:19:03.788250500 <4> [<c0268b14>] xfs_file_aio_write+0x7e/0x95
2007-01-06 04:19:03.788251500 <4> [<c016d66c>] do_sync_write+0xca/0x119
2007-01-06 04:19:03.788265500 <4> [<c016d842>] vfs_write+0x187/0x18c
2007-01-06 04:19:03.788267500 <4> [<c016d8e8>] sys_write+0x3d/0x64
2007-01-06 04:19:03.788268500 <4> [<c0102e73>] syscall_call+0x7/0xb
2007-01-06 04:19:03.788269500 <4> [<001cf410>] 0x1cf410
2007-01-06 04:19:03.788289500 <4> =======================

funny that when stracing, mincore does not return?

$ time cinfo dtfile-2091
dtfile-2091: 524285 pages, 0 pages cached (0.00%)

real    0m0.049s
user    0m0.003s
sys     0m0.046s

safari    6941 29.9 10.8 2098768 108788 pts/2  D+   04:20   3:41 strace -vfttT cinfo dtfile-2091

strace        D C179A000     0  6941   8737  6942          2089 (NOTLB)
       e7dddd90 00000046 c172e240 c179a000 c1731880 c17c51a0 c17b5be0 c1771c20
       e9b1f740 00000086 d55dd74c e7dddd6c 00000000 c02666b8 c17fd700 c2c2513c
       0000fdac b2203610 0000616f c2c25030 c17fd700 e7ddddf8 c17d31f0 e7dddd9c
Call Trace:
 [<c04b4568>] io_schedule+0x26/0x30
 [<c014cdad>] sync_page+0x3d/0x48
 [<c04b47b1>] __wait_on_bit_lock+0x45/0x67
 [<c014d556>] __lock_page+0x88/0x95
 [<c014e5a7>] filemap_nopage+0x1f4/0x386
 [<c015b24c>] do_no_page+0x82/0x2fa
 [<c015b8a3>] __handle_mm_fault+0x1fe/0x2eb
 [<c0159a99>] get_user_pages+0xc7/0x2e5
 [<c015bb8a>] access_process_vm+0x74/0x116
 [<c010639e>] arch_ptrace+0x388/0x539
 [<c012ad7f>] sys_ptrace+0x58/0xb9
 [<c0102e73>] syscall_call+0x7/0xb
 [<0081e410>] 0x81e410
 =======================
cinfo         t CB7DA040     0  6942   6941                     (NOTLB)
       e5fcdee8 00000046 ce7d9284 cb7da040 ce7d9284 cb7da078 cb7da040 e5fcdf10
       cb7da040 13a973f5 000060e3 00000078 00000000 c2c25030 c1805700 d483013c
       0021fd53 13a97513 000060e3 d4830030 e5fcdf04 00000005 00000000 e5fcdefc
Call Trace:
 [<c012e32b>] ptrace_stop+0xf8/0x17f
 [<c012e41c>] ptrace_notify+0x6a/0x92
 [<c01066a9>] do_syscall_trace+0xd4/0x1eb
 [<c0102f66>] syscall_exit_work+0x16/0x1b
 [<00878410>] 0x878410
 =======================


[1]
includes these
        8c08540f8755c451d8b96ea14cfe796bc3cd712d [PATCH] clean up __set_page_dirty_nobuffers()
        55e829af06681e5d731c03ba04febbd1c76ca293 [PATCH] io-accounting: write accounting
        e08748ce01e02f0ec154b141f392ccb9555333f4 [PATCH] io-accounting: write-cancel accounting
        fba2591bf4e418b6c3f9f8794c9dd8fe40ae7bd9 VM: Remove "clear_page_dirty()" and "test_clear_page_dirty()" functions
        3e67c0987d7567ad666641164a153dca9a43b11d [PATCH] truncate: clear page dirtiness before running try_to_free_buffers()
        5f2a105d5e33a038a717995d2738434f9c25aed2 [PATCH] truncate: dirty memory accounting fix
        8368e328dfe1c534957051333a87b3210a12743b Clean up and export cancel_dirty_page() to modules
        7658cc289288b8ae7dd2c2224549a048431222b3 VM: Fix nasty and subtle race in shared mmap'ed page writeback
        7c3ab7381e79dfc7db14a67c6f4f3285664e1ec2 [PATCH] io-accounting: core statistics
        cb876f451455b6187a7d69de2c112c45ec4b7f99 Fix up CIFS for "test_clear_page_dirty()" removal
        7dfb71030f7636a0d65200158113c37764552f93 [PATCH] Add include/linux/freezer.h and move definitions from sched.h
        46d2277c796f9f4937bfa668c40b2e3f43e93dd0 Clean up and make try_to_free_buffers() not race with dirty 
        e61c90188b9956edae1105eef361d8981a352fcd [PATCH] optimize o_direct on block devices
        5fcf7bb73f66cc1c4ad90788b0f367c4d6852b75 [PATCH] read_zero_pagealigned() locking fix
        ffaa82008f1aad52a6d3979f49d2a76c2928b60f Fix reiserfs after "test_clear_page_dirty()" removal
        d0e671a932cb9c653b27393cec26aec012a8d97e [PATCH] Fix JFS after clear_page_dirty() removal
        9280f6822c2d7112b47107251fce307aefb31f35 [PATCH] fuse: remove clear_page_dirty() call
        921320210bd2ec4f17053d283355b73048ac0e56 [PATCH] Fix XFS after clear_page_dirty() removal

[2]
dt pattern=iot incr=variable records=32768 lbs=65536 bs=65536 of=dtfile log=dtfile.log.direct.random passes=1 procs=2 iotype=random flags=direct
http://home.comcast.net/~SCSIguy/SCSI_FAQ/RMiller_Tools/ftp/dt/dt-source.tar.gz

-- 
