Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWE3M0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWE3M0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWE3M0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:26:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:17867 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751462AbWE3M0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:26:13 -0400
X-Authenticated: #14349625
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060530121952.GA9625@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer>
	 <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu>
	 <1148991422.8610.8.camel@homer>  <20060530121952.GA9625@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:28:18 +0200
Message-Id: <1148992098.8700.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:19 +0200, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > I have nmi_watchdog=1.  I'll reboot with 0 and see if it'll trigger.
> > 
> > I found a warning.
> 
> > BUG: warning at kernel/lockdep.c:2398/check_flags()
> 
> this one could be related to NMI. We are already disabling NMI on 
> x86_64, but i thought i had it fixed up for i386 - apparently not.

Booted with nmi_watchdog=0, no warning and no deadlock.  It produced
fruit for NFTS.

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
mount/2545 is trying to acquire lock:
 (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa

but task is already holding lock:
 (&rl->lock){----}, at: [<b1165306>] ntfs_map_runlist+0x14/0xa7

which lock already depends on the new lock,
which could lead to circular deadlocks!

the existing dependency chain (in reverse order) is:

-> #1 (&rl->lock){----}:
       [<b103d9f8>] lockdep_acquire+0x61/0x77
       [<b11613ae>] ntfs_readpage+0x92c/0xb53
       [<b10540c8>] read_cache_page+0x95/0x15a
       [<b1174b0e>] map_mft_record+0xda/0x28a
       [<b117187f>] ntfs_read_locked_inode+0x5d/0x1559
       [<b1174212>] ntfs_read_inode_mount+0x572/0xb30
       [<b1183f8c>] ntfs_fill_super+0xc9e/0x1467
       [<b1078ac2>] get_sb_bdev+0xee/0x141
       [<b117eff5>] ntfs_get_sb+0x1a/0x20
       [<b107880c>] vfs_kern_mount+0x9a/0x166
       [<b1078920>] do_kern_mount+0x30/0x43
       [<b108ea7f>] do_mount+0x464/0x7ba
       [<b108ee44>] sys_mount+0x6f/0xa4
       [<b13d3043>] syscall_call+0x7/0xb

-> #0 (&ni->mrec_lock){--..}:
       [<b103d9f8>] lockdep_acquire+0x61/0x77
       [<b13d14a5>] __mutex_lock_slowpath+0x49/0xff
       [<b13d1563>] mutex_lock+0x8/0xa
       [<b1174a51>] map_mft_record+0x1d/0x28a
       [<b1164b77>] ntfs_map_runlist_nolock+0x378/0x4a6
       [<b1165360>] ntfs_map_runlist+0x6e/0xa7
       [<b1161375>] ntfs_readpage+0x8f3/0xb53
       [<b10540c8>] read_cache_page+0x95/0x15a
       [<b11806e5>] load_system_files+0x1e3/0x1e5c
       [<b1183fec>] ntfs_fill_super+0xcfe/0x1467
       [<b1078ac2>] get_sb_bdev+0xee/0x141
       [<b117eff5>] ntfs_get_sb+0x1a/0x20
       [<b107880c>] vfs_kern_mount+0x9a/0x166
       [<b1078920>] do_kern_mount+0x30/0x43
       [<b108ea7f>] do_mount+0x464/0x7ba
       [<b108ee44>] sys_mount+0x6f/0xa4
       [<b13d3043>] syscall_call+0x7/0xb

other info that might help us debug this:

2 locks held by mount/2545:
 #0:  (&s->s_umount){----}, at: [<b10782db>] sget+0x1d9/0x3bd
 #1:  (&rl->lock){----}, at: [<b1165306>] ntfs_map_runlist+0x14/0xa7

stack backtrace:
 <b1003dd2> show_trace+0xd/0xf  <b10044c0> dump_stack+0x17/0x19
 <b103c9ca> print_circular_bug_tail+0x5d/0x66  <b103d145> __lockdep_acquire+0x772/0xc32
 <b103d9f8> lockdep_acquire+0x61/0x77  <b13d14a5> __mutex_lock_slowpath+0x49/0xff
 <b13d1563> mutex_lock+0x8/0xa  <b1174a51> map_mft_record+0x1d/0x28a
 <b1164b77> ntfs_map_runlist_nolock+0x378/0x4a6  <b1165360> ntfs_map_runlist+0x6e/0xa7
 <b1161375> ntfs_readpage+0x8f3/0xb53  <b10540c8> read_cache_page+0x95/0x15a
 <b11806e5> load_system_files+0x1e3/0x1e5c  <b1183fec> ntfs_fill_super+0xcfe/0x1467
 <b1078ac2> get_sb_bdev+0xee/0x141  <b117eff5> ntfs_get_sb+0x1a/0x20
 <b107880c> vfs_kern_mount+0x9a/0x166  <b1078920> do_kern_mount+0x30/0x43
 <b108ea7f> do_mount+0x464/0x7ba  <b108ee44> sys_mount+0x6f/0xa4
 <b13d3043> syscall_call+0x7/0xb 


