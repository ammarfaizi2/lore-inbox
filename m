Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWGQMyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWGQMyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 08:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGQMyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 08:54:45 -0400
Received: from lilly.ping.de ([83.97.42.2]:27658 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id S1750771AbWGQMyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 08:54:44 -0400
Date: Mon, 17 Jul 2006 14:52:16 +0200
From: Jochen Heuer <jogi-kernel@planetzork.ping.de>
To: linux-kernel@vger.kernel.org
Subject: BUG: soft lockup detected on CPU#1!
Message-ID: <20060717125216.GA15481@planetzork.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been running 2.6.17 on my desktop system (Asus A8V + Athlon64 X2 3800)
and I am having severe problems with lookups. These only show up when surfing
the net. During compiling or mprime runs --> absolutly no problem.

At first I thought this was related to the S-ATA driver since I got error
messages like these on the console once before it locked up hard (no sysrq!):

ata1: command 0xca timeout, stat 0x50 host_stat 0x4
ata1: status=0x50 { DriveReady SeekComplete }
ata1: command 0xea timeout, stat 0x50 host_stat 0x0
ata1: status=0x50 { DriveReady SeekComplete }

But switching to an IDE drive did not fix the lockups. So I switched to
2.6.18-rc2 and today I got the following reported via dmesg:

Jul 17 09:23:03 [kernel] BUG: soft lockup detected on CPU#1!
Jul 17 09:23:03 [kernel]  [<c0103cd2>] show_trace+0x12/0x20
Jul 17 09:23:03 [kernel]  [<c0103de9>] dump_stack+0x19/0x20
Jul 17 09:23:03 [kernel]  [<c0143e77>] softlockup_tick+0xa7/0xd0
Jul 17 09:23:03 [kernel]  [<c0129422>] run_local_timers+0x12/0x20
Jul 17 09:23:03 [kernel]  [<c012923e>] update_process_times+0x6e/0xa0
Jul 17 09:23:03 [kernel]  [<c011127d>] smp_apic_timer_interrupt+0x6d/0x80
Jul 17 09:23:03 [kernel]  [<c0103942>] apic_timer_interrupt+0x2a/0x30
Jul 17 09:23:03 [kernel]  [<c022df93>] cbc_process_decrypt+0x93/0xf0
Jul 17 09:23:03 [kernel]  [<c022dcbe>] crypt+0xee/0x1e0
Jul 17 09:23:03 [kernel]  [<c022ddef>] crypt_iv_unaligned+0x3f/0xc0
Jul 17 09:23:03 [kernel]  [<c022e23d>] cbc_decrypt_iv+0x3d/0x50
Jul 17 09:23:03 [kernel]  [<c032f6b7>] crypt_convert_scatterlist+0x117/0x170
Jul 17 09:23:03 [kernel]  [<c032f8b2>] crypt_convert+0x142/0x190
Jul 17 09:23:03 [kernel]  [<c032fb82>] kcryptd_do_work+0x42/0x60
Jul 17 09:23:03 [kernel]  [<c012fcff>] run_workqueue+0x6f/0xe0
Jul 17 09:23:03 [kernel]  [<c012fe98>] worker_thread+0x128/0x150
Jul 17 09:23:03 [kernel]  [<c0133364>] kthread+0xa4/0xe0
Jul 17 09:23:03 [kernel]  [<c01010e5>] kernel_thread_helper+0x5/0x10
Jul 17 09:24:17 [kernel] =============================================
Jul 17 09:24:17 [kernel] [ INFO: possible recursive locking detected ]
Jul 17 09:24:17 [kernel] ---------------------------------------------
Jul 17 09:24:17 [kernel] mv/12680 is trying to acquire lock:
Jul 17 09:24:17 [kernel]  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f63b0>]
xfs_ilock+0x60/0xb0
Jul 17 09:24:17 [kernel] but task is already holding lock:
Jul 17 09:24:17 [kernel]  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f63b0>]
xfs_ilock+0x60/0xb0
Jul 17 09:24:17 [kernel] other info that might help us debug this:
Jul 17 09:24:17 [kernel] 4 locks held by mv/12680:
Jul 17 09:24:17 [kernel]  #0:  (&s->s_vfs_rename_mutex){--..}, at: [<c03c2931>]
mutex_lock+0x21/0x30
Jul 17 09:24:17 [kernel]  #1:  (&inode->i_mutex/1){--..}, at: [<c017506b>]
lock_rename+0xbb/0xd0
Jul 17 09:24:17 [kernel]  #2:  (&inode->i_mutex/2){--..}, at: [<c0175052>]
lock_rename+0xa2/0xd0
Jul 17 09:24:17 [kernel]  #3:  (&(&ip->i_lock)->mr_lock){----}, at:
[<c01f63b0>] xfs_ilock+0x60/0xb0
Jul 17 09:24:17 [kernel] stack backtrace:
Jul 17 09:24:17 [kernel]  [<c0103cd2>] show_trace+0x12/0x20
Jul 17 09:24:17 [kernel]  [<c0103de9>] dump_stack+0x19/0x20
Jul 17 09:24:17 [kernel]  [<c01385a9>] print_deadlock_bug+0xb9/0xd0
Jul 17 09:24:17 [kernel]  [<c013862b>] check_deadlock+0x6b/0x80
Jul 17 09:24:17 [kernel]  [<c0139ed4>] __lock_acquire+0x354/0x990
Jul 17 09:24:17 [kernel]  [<c013ac35>] lock_acquire+0x75/0xa0
Jul 17 09:24:17 [kernel]  [<c0136aaf>] down_write+0x3f/0x60
Jul 17 09:24:17 [kernel]  [<c01f63b0>] xfs_ilock+0x60/0xb0
Jul 17 09:24:17 [kernel]  [<c0217981>] xfs_lock_inodes+0xb1/0x120
Jul 17 09:24:17 [kernel]  [<c020ca7b>] xfs_rename+0x20b/0x8e0
Jul 17 09:24:17 [kernel]  [<c022351a>] xfs_vn_rename+0x3a/0x90
Jul 17 09:24:17 [kernel]  [<c017687d>] vfs_rename_dir+0xbd/0xd0
Jul 17 09:24:17 [kernel]  [<c0176a4c>] vfs_rename+0xdc/0x230
Jul 17 09:24:17 [kernel]  [<c0176d02>] do_rename+0x162/0x190
Jul 17 09:24:17 [kernel]  [<c0176d9c>] sys_renameat+0x6c/0x80
Jul 17 09:24:17 [kernel]  [<c0176dd8>] sys_rename+0x28/0x30
Jul 17 09:24:17 [kernel]  [<c0102e15>] sysenter_past_esp+0x56/0x8d

I am not sure if these infos are enough to isolate the problem. If you need any
further infos just let me know.

Best regards,

   Jogi
