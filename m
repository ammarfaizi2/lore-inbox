Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUKORlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUKORlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKORlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:41:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:27624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261342AbUKORiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:38:03 -0500
Date: Mon, 15 Nov 2004 09:37:59 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm5 - badness in enable_irg, BUG
Message-Id: <20041115093759.721ac964.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is on the 2.6.10-rc1-mm5 kernel with one compile fix patch

Machines are the OSDl 2 and 4 CPU boxes. 
Test is reaim with the 'new_fserver' workload. The 'compute' and 'database' workloads aren't 
showing this.

I see the BUG on ext3, reiserfs, xfs and jfs. 

System usually completes the test run, and performance isn't off too much :)
--------------------------------
With ext3, get this at the start of the run 
( Full run at: http://khack.osdl.org/stp/298664 )
---------------------------------
 kernel: Badness in enable_irq at kernel/irq/manage.c:106
 kernel:  [<c013e6ac>] enable_irq+0xdc/0xf0
 kernel:  [<c025e7fa>] e100_up+0x10a/0x200
 kernel:  [<c025dbc0>] e100_intr+0x0/0x160
 kernel:  [<c025fa51>] e100_open+0x31/0x80
 kernel:  [<c02c9c4c>] dev_open+0x8c/0xa0
 kernel:  [<c02cb49a>] dev_change_flags+0x12a/0x150
 kernel:  [<c02c9aed>] dev_load+0x2d/0x80
 kernel:  [<c0306de3>] devinet_ioctl+0x273/0x670
 kernel:  [<c020a31e>] copy_to_user+0x3e/0x50
 kernel:  [<c03093c6>] inet_ioctl+0x66/0xb0
 kernel:  [<c02c0619>] sock_ioctl+0xc9/0x250
 kernel:  [<c0170c8a>] sys_ioctl+0xca/0x230
 kernel:  [<c0104681>] sysenter_past_esp+0x52/0x71
------------------------------------
Then, when the test runs:
-----------------------------------------
BUG: using smp_processor_id() in preemptible [00000001] code: mkdir/11768
caller is munmap_notify+0x7b/0x90 [oprofile]
 [<c020a465>] smp_processor_id+0xb5/0xc0
 [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
 [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
 [<c012b55d>] notifier_call_chain+0x2d/0x50
 [<c011dd93>] profile_munmap+0x33/0x50
 [<c01536f7>] sys_munmap+0x27/0x80
 [<c01046d3>] syscall_call+0x7/0xb
printk: 41 messages suppressed.
BUG: using smp_processor_id() in preemptible [00000001] code: uname/11790
caller is munmap_notify+0x7b/0x90 [oprofile]
 [<c020a465>] smp_processor_id+0xb5/0xc0
 [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
 [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
 [<c012b55d>] notifier_call_chain+0x2d/0x50
 [<c011dd93>] profile_munmap+0x33/0x50
 [<c01536f7>] sys_munmap+0x27/0x80
 [<c01046d3>] syscall_call+0x7/0xb
printk: 82 messages suppressed.
---------------------------------------
With xfs:
( Run http://khack.osdl.org/stp/298667
-------------------
BUG: using smp_processor_id() in preemptible [00000001] code: xfssyncd/7336
caller is xfs_log_force+0x2f/0xa0 [xfs]
 [<c020a465>] smp_processor_id+0xb5/0xc0
 [<f89f938f>] xfs_log_force+0x2f/0xa0 [xfs]
 [<f89f938f>] xfs_log_force+0x2f/0xa0 [xfs]
 [<f89f9d91>] xfs_log_need_covered+0x71/0xb0 [xfs]
 [<f8a0dd01>] xfs_syncsub+0x51/0x330 [xfs]
 [<c0126cf8>] del_singleshot_timer_sync+0x28/0x40
 [<f8a0d349>] xfs_sync+0x29/0x30 [xfs]
 [<f8a21f03>] vfs_sync+0x43/0x50 [xfs]
 [<f8a2110f>] vfs_sync_worker+0x4f/0x60 [xfs]
 [<f8a21281>] xfssyncd+0x161/0x230 [xfs]
 [<f8a21120>] xfssyncd+0x0/0x230 [xfs]
 [<c0102605>] kernel_thread_helper+0x5/0x10
BUG: using smp_processor_id() in preemptible [00000001] code: sleep/14682
caller is task_exit_notify+0x8/0x20 [oprofile]
 [<c020a465>] smp_processor_id+0xb5/0xc0
 [<f89129b8>] task_exit_notify+0x8/0x20 [oprofile]
 [<f89129b8>] task_exit_notify+0x8/0x20 [oprofile]
 [<c032be8d>] schedule_timeout+0x7d/0xd0 
 [<c012b55d>] notifier_call_chain+0x2d/0x50
 [<c011dcf3>] profile_task_exit+0x33/0x50
 [<c011fe8c>] do_exit+0x1c/0x510 
 [<c0127724>] sys_nanosleep+0xe4/0x180
 [<c012048d>] do_group_exit+0x8d/0xc0 
 [<c0104681>] sysenter_past_esp+0x52/0x71

----------------------
cliffw
OSDL

-------------------
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
