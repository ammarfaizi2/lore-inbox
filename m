Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVCPWEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVCPWEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVCPWAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:00:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:17094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262826AbVCPV6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:58:30 -0500
Date: Wed, 16 Mar 2005 13:58:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: Max Kamenetsky <maxk@chinook.stanford.edu>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: Kernel mm/rmap.c oops in 2.6.11.3
Message-ID: <20050316215817.GB28536@shell0.pdx.osdl.net>
References: <42389F8D.7060002@chinook.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42389F8D.7060002@chinook.stanford.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Max Kamenetsky (maxk@chinook.stanford.edu) wrote:
> I've been seeing the following bug lately when running some memory- and
> CPU-intensive MATLAB jobs.  MATLAB hangs, and commands like ps and top
> no longer work.  The only solution I've found is to reboot.  This
> happens intermittently, and here's what gets written to /var/log/syslog:

Questions...

1) Did you run memtest86 to make sure it's not bad memory?
2) Can it be reproduced on untainted kernel (no nvidia)?
3) Hugh, did you have a debug patch that Max could use that might help
chase this particular one (I think it's another of the 'exclusive club')?

> Mar 16 12:35:19 chinook kernel: kernel BUG at mm/rmap.c:482!
> Mar 16 12:35:19 chinook kernel: invalid operand: 0000 [#1]
> Mar 16 12:35:19 chinook kernel: PREEMPT
> Mar 16 12:35:19 chinook kernel: Modules linked in: nvidia
> Mar 16 12:35:19 chinook kernel: CPU:    0
> Mar 16 12:35:19 chinook kernel: EIP:    0060:[<c014a477>]    Tainted: P
>       VLI
> Mar 16 12:35:19 chinook kernel: EFLAGS: 00010286   (2.6.11.3)
> Mar 16 12:35:19 chinook kernel: EIP is at page_remove_rmap+0x37/0x50
> Mar 16 12:35:19 chinook kernel: eax: ffffffff   ebx: 00005000   ecx:
> 00000006
> edx: c16a9920
> Mar 16 12:35:19 chinook kernel: esi: e3db1e34   edi: 00008000   ebp:
> c16a9920
> esp: c8f4be54
> Mar 16 12:35:19 chinook kernel: ds: 007b   es: 007b   ss: 0068
> Mar 16 12:35:19 chinook kernel: Process MATLAB (pid: 30685,
> threadinfo=c8f4a000
> task=ec1a9a80)
> Mar 16 12:35:19 chinook kernel: Stack: c013e418 00005000 c0142ed6
> c16a9920 00000
> 007 c0565a20 00000001 354c9067
> Mar 16 12:35:19 chinook kernel:        00000000 99388000 c0565578
> 99788000 e0f80
> 994 99390000 00000000 c0143043
> Mar 16 12:35:19 chinook kernel:        c0565578 e0f80990 99388000
> 00008000 00000
> 000 99388000 e0f80994 99390000
> Mar 16 12:35:19 chinook kernel: Call Trace:
> Mar 16 12:35:19 chinook kernel:  [<c013e418>] mark_page_accessed+0x28/0x30
> Mar 16 12:35:19 chinook kernel:  [<c0142ed6>] zap_pte_range+0x166/0x280
> Mar 16 12:35:19 chinook kernel:  [<c0143043>] zap_pmd_range+0x53/0x70
> Mar 16 12:35:19 chinook kernel:  [<c014309a>] zap_pud_range+0x3a/0x60
> Mar 16 12:35:19 chinook kernel:  [<c0143130>] unmap_page_range+0x70/0x90
> Mar 16 12:35:19 chinook kernel:  [<c0143246>] unmap_vmas+0xf6/0x210
> Mar 16 12:35:19 chinook kernel:  [<c0147bbb>] unmap_region+0x7b/0xf0
> Mar 16 12:35:19 chinook kernel:  [<c0147ea6>] do_munmap+0x116/0x180
> Mar 16 12:35:19 chinook kernel:  [<c0147f54>] sys_munmap+0x44/0x70
> Mar 16 12:35:19 chinook kernel:  [<c01027db>] syscall_call+0x7/0xb
> Mar 16 12:35:19 chinook kernel: Code: 75 33 83 42 08 ff 0f 98 c0 84 c0
> 74 1a 8b
> 42 08 40 78 18 c7 44 24 04 ff ff ff ff c7 04 24 10 00 00 00 e8 9d f5 fe
> ff 83 c4
>   08 c3 <0f> 0b e2 01 7d a1 42 c0 eb de 0f 0b df 01 7d a1 42 c0 eb c3 90
> Mar 16 12:35:19 chinook kernel:  <6>note: MATLAB[30685] exited with
> preempt_count 2
> Mar 16 12:35:19 chinook kernel: scheduling while atomic:
> MATLAB/0x00000002/30685
> Mar 16 12:35:19 chinook kernel:  [<c040d3a2>] schedule+0x522/0x530
> Mar 16 12:35:19 chinook kernel:  [<c040e19d>]
> rwsem_down_read_failed+0x9d/0x190
> Mar 16 12:35:19 chinook kernel:  [<c012d414>] .text.lock.futex+0x7/0xf3
> Mar 16 12:35:19 chinook kernel:  [<c02a6e80>] vt_console_print+0x60/0x300
> Mar 16 12:35:19 chinook kernel:  [<c012d2b4>] do_futex+0x64/0xa0
> Mar 16 12:35:19 chinook kernel:  [<c0117527>]
> __call_console_drivers+0x57/0x60
> Mar 16 12:35:19 chinook kernel:  [<c012d3de>] sys_futex+0xee/0x100
> Mar 16 12:35:19 chinook kernel:  [<c0117a58>] release_console_sem+0x98/0xf0
> Mar 16 12:35:19 chinook kernel:  [<c0115178>] mm_release+0x98/0xa0
> Mar 16 12:35:19 chinook kernel:  [<c0118ed9>] exit_mm+0x19/0x110
> Mar 16 12:35:19 chinook kernel:  [<c0103d60>] do_invalid_op+0x0/0xd0
> Mar 16 12:35:19 chinook kernel:  [<c0119910>] do_exit+0xa0/0x3d0
> Mar 16 12:35:19 chinook kernel:  [<c0103d60>] do_invalid_op+0x0/0xd0
> Mar 16 12:35:19 chinook kernel:  [<c010399d>] die+0x18d/0x190
> Mar 16 12:35:19 chinook kernel:  [<c0103e0e>] do_invalid_op+0xae/0xd0
> Mar 16 12:35:19 chinook kernel:  [<c014a477>] page_remove_rmap+0x37/0x50
> Mar 16 12:35:19 chinook kernel:  [<c012872b>]
> rcu_process_callbacks+0x3b/0x40
> Mar 16 12:35:19 chinook kernel:  [<c011c416>] tasklet_action+0x46/0x70
> Mar 16 12:35:19 chinook kernel:  [<c011c1b8>] __do_softirq+0x78/0x90
> Mar 16 12:35:19 chinook kernel:  [<c0104ba8>] do_IRQ+0x28/0x40
> Mar 16 12:35:19 chinook kernel:  [<c0177691>] __mark_inode_dirty+0xd1/0x1c0
> Mar 16 12:35:19 chinook kernel:  [<c01031ef>] error_code+0x2b/0x30
> Mar 16 12:35:19 chinook kernel:  [<c014a477>] page_remove_rmap+0x37/0x50
> Mar 16 12:35:19 chinook kernel:  [<c013e418>] mark_page_accessed+0x28/0x30
> Mar 16 12:35:19 chinook kernel:  [<c0142ed6>] zap_pte_range+0x166/0x280
> Mar 16 12:35:19 chinook kernel:  [<c0143043>] zap_pmd_range+0x53/0x70
> Mar 16 12:35:19 chinook kernel:  [<c014309a>] zap_pud_range+0x3a/0x60
> Mar 16 12:35:19 chinook kernel:  [<c0143130>] unmap_page_range+0x70/0x90
> Mar 16 12:35:19 chinook kernel:  [<c0143246>] unmap_vmas+0xf6/0x210
> Mar 16 12:35:19 chinook kernel:  [<c0147bbb>] unmap_region+0x7b/0xf0
> Mar 16 12:35:19 chinook kernel:  [<c0147ea6>] do_munmap+0x116/0x180
> Mar 16 12:35:19 chinook kernel:  [<c0147f54>] sys_munmap+0x44/0x70
> Mar 16 12:35:19 chinook kernel:  [<c01027db>] syscall_call+0x7/0xb
> 
> 
> I haven't tried 2.6.11.4 yet, but based on what I see in the changelog,
> nothing related to the above seems to have been changed.

This particular problem predates 2.6.11, and you're right 2.6.11.4
shouldn't make a difference.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
