Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUBDRIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBDRIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:08:31 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:42882 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262686AbUBDRHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:07:50 -0500
Date: Wed, 4 Feb 2004 18:07:48 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11: Crash in ps axH
Message-ID: <20040204170748.GA2817@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   maybe that this problem is already fixed in 2.6.2-rc3, but just
in case that somebody has a clue what's going on, after about
month of uptime, running couple of multithreaded apps on 2.6.0-test11
(of which slapd was running for this month without restart),
today I decided to use 'ps axH' to find what server is doing.

   In the middle of 'ps axH' output I was awarded by 'Segmentation
fault', and following oops appeared in kernel log. It died
in proc_pid_stat when doing tty_devnum(task->tty) because
task->tty->driver was 0x269BD005 (see %ebx). I'm not able to explain
what happened, but as it happened second time on this system, and
once on other one (also running 2.6.0-test11), there is certainly
something wrong... It may be also interesting that task->tty->pgrp was
0x4E70F005 (%eax), so it looks like that task->tty points just to
the garbage (task was 0xF7C12080 (%esi), and its address looks safe.
task->tty was 0xC82B2000 (%ecx), and it also looks like possible
value for tty).

   Kernel is SMP, PIII, non-preempt, with DEBUG_SLAB enabled, 4GB
config. Machine is dual PIII/933MHz, with 1.25GB of memory.

   I'm now building latest 2.6.2 from bk, but as it usually takes
about one month to get these oopses, it may take a while until
I can report success/failure. 
						Best regards,
							Petr Vandrovec

P.S.: Sorry, I noticed only after crash that Debian still does not
run klogd with -x, so numbers were converted to symbolics in the
trace.

Feb  4 17:18:06 usermap kernel: Unable to handle kernel paging request at virtual address 269bd061
Feb  4 17:18:06 usermap kernel:  printing eip:
Feb  4 17:18:06 usermap kernel: c018cbc6
Feb  4 17:18:06 usermap kernel: *pde = 00000000
Feb  4 17:18:06 usermap kernel: Oops: 0000 [#1]
Feb  4 17:18:06 usermap kernel: CPU:    1
Feb  4 17:18:06 usermap kernel: EIP:    0060:[proc_pid_stat+166/1296]    Not tainted
Feb  4 17:18:06 usermap kernel: EFLAGS: 00010286
Feb  4 17:18:06 usermap kernel: EIP is at proc_pid_stat+0xa6/0x510
Feb  4 17:18:06 usermap kernel: eax: 4e70f005   ebx: 269bd005   ecx: c82b2000   edx: db55f2a4
Feb  4 17:18:06 usermap kernel: esi: f7c12080   edi: db55f2a4   ebp: 00000000   esp: e82e7e3c
Feb  4 17:18:06 usermap kernel: ds: 007b   es: 007b   ss: 0068
Feb  4 17:18:06 usermap kernel: Process ps (pid: 6437, threadinfo=e82e6000 task=d72346b0)
Feb  4 17:18:06 usermap kernel: Stack: db55f2a4 c1cd3104 d26d729c c03fa790 f7c12080 db8194fc f7c12080 0000001d
Feb  4 17:18:06 usermap kernel:        c018a53c f7c12080 40211b3e 16ff7c54 c03fa790 d26d7320 c03fa790 c03fa790
Feb  4 17:18:06 usermap kernel:        c018aa6e d26d729c db8194fc 0000001d 00000004 f7c12080 ffffffea fffffff4
Feb  4 17:18:06 usermap kernel: Call Trace:
Feb  4 17:18:06 usermap kernel:  [proc_pid_make_inode+156/208] proc_pid_make_inode+0x9c/0xd0
Feb  4 17:18:06 usermap kernel:  [proc_pident_lookup+254/608] proc_pident_lookup+0xfe/0x260
Feb  4 17:18:06 usermap kernel:  [real_lookup+213/256] real_lookup+0xd5/0x100
Feb  4 17:18:06 usermap kernel:  [buffered_rmqueue+212/384] buffered_rmqueue+0xd4/0x180
Feb  4 17:18:06 usermap kernel:  [check_poison_obj+43/416] check_poison_obj+0x2b/0x1a0
Feb  4 17:18:06 usermap kernel:  [__alloc_pages+176/832] __alloc_pages+0xb0/0x340
Feb  4 17:18:06 usermap kernel:  [get_empty_filp+104/224] get_empty_filp+0x68/0xe0
Feb  4 17:18:06 usermap kernel:  [proc_info_read+84/336] proc_info_read+0x54/0x150
Feb  4 17:18:06 usermap kernel:  [filp_open+104/112] filp_open+0x68/0x70
Feb  4 17:18:06 usermap kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Feb  4 17:18:06 usermap kernel:  [sys_open+126/144] sys_open+0x7e/0x90
Feb  4 17:18:06 usermap kernel:  [sys_read+66/112] sys_read+0x42/0x70
Feb  4 17:18:06 usermap kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  4 17:18:06 usermap kernel:
Feb  4 17:18:06 usermap kernel: Code: 0f bf 43 5c 0f bf 5b 5e c1 e0 14 09 d8 8b 59 08 01 d8 89 c1

