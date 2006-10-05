Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWJEP0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWJEP0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWJEP0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:26:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:9423 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932125AbWJEPZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:25:59 -0400
From: Andi Kleen <ak@suse.de>
To: axboe@kernel.dk
Subject: sys_splice crashes in 2.6.19rc1 during autotest
Date: Thu, 5 Oct 2006 17:25:53 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051725.53183.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was running autotest on 2.6.19rc1+x86_64 patchkit and I ended up with a BUG()
below sys_splice while running some IO test there.

This was a debugging kernel with PREEMPTION and various other
debugging options enabled.

The system ran out of disk space during the test so that
might have been related and I ended up with a "fio" process
in D. Also the system was confused afterwards with rm
oopsing etc.

File system was reiserfs.

-Andi

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at /abuild/autoboot/lsrc/x86_64/linux/mm/filemap.c:547
invalid opcode: 0000 [1] SMP 
CPU 0 
Modules linked in:
Pid: 13789, comm: fio Not tainted 2.6.19-rc1 #5
RIP: 0010:[<ffffffff80255134>]  [<ffffffff80255134>] unlock_page+0xf/0x2f
RSP: 0018:ffff81000a5e1e18  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff810000cfa9e0 RCX: 0000000000000036
RDX: ffff81000a5e1e98 RSI: ffff810000cfa9e0 RDI: ffff810000cfa9e0
RBP: ffff810000cfa9e0 R08: ffff81003ec46c00 R09: ffffc20000265908
R10: ffff8100157a3e40 R11: 0000000000000000 R12: ffff81003e0a09a0
R13: 0000000000001000 R14: 0000000006400000 R15: ffff810037baac10
FS:  00002af7c37d7b70(0000) GS:ffffffff8077d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002af7c365e0b0 CR3: 0000000002c07000 CR4: 00000000000006e0
Process fio (pid: 13789, threadinfo ffff81000a5e0000, task ffff81003f4b6e60)
Stack:  00000000ffffffe4 ffffffff80293652 ffff81000a5e1e98 ffff81003e0a0800
 ffff8100367745c0 00000000000200d2 000000000000452c ffff81003e0a09a0
 ffff81003e0a0800 0000000000000000 0000000000000000 ffffffff80694f00
Call Trace:
 [<ffffffff80293652>] pipe_to_file+0x2df/0x2f0
 [<ffffffff80292b4e>] splice_from_pipe+0x86/0x213
 [<ffffffff80292f0d>] generic_file_splice_write+0x21/0x8a
 [<ffffffff80293baa>] sys_splice+0x105/0x210
 [<ffffffff8020953e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83

Leftover inexact backtrace:


fio process:

Code: 0f 0b 68 fc 59 57 80 c2 23 02 48 89 df e8 f2 f9 ff ff 48 89
RIP  [<ffffffff80255134>] unlock_page+0xf/0x2f
 RSP <ffff81000a5e1e18>

fio           D ffff81003d50c3e4     0 13789      1                4669 (L-TLB)
 ffff81000a5e1ad8 0000000000000046 0000000000000001 0000000000000000
 0000000000000007 ffff81003f4b6e60 ffff81003d666a30 000000f51a101cfa
 000000000000494a ffff81003f4b7038 0000000100000000 0000000000000282
Call Trace:
 [<ffffffff805323df>] __mutex_lock_slowpath+0x5d/0x98
 [<ffffffff80532287>] mutex_lock+0x1a/0x1e
 [<ffffffff8027da11>] pipe_read_fasync+0x29/0x60
 [<ffffffff8027dd4b>] pipe_read_release+0xe/0x1e
 [<ffffffff80279496>] __fput+0xae/0x191
 [<ffffffff80276f53>] filp_close+0x5c/0x64
 [<ffffffff802326b5>] put_files_struct+0x6e/0xcd
 [<ffffffff80233870>] do_exit+0x235/0x829
 [<ffffffff8020af9d>] kernel_math_error+0x0/0x90
 [<ffffffff8020b53f>] do_invalid_op+0xad/0xb7
 [<ffffffff8053373d>] error_exit+0x0/0x84
DWARF2 unwinder stuck at error_exit+0x0/0x84


