Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWGUW7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWGUW7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGUW7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 18:59:05 -0400
Received: from lilly.ping.de ([83.97.42.2]:34569 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id S1751246AbWGUW7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 18:59:02 -0400
Date: Sat, 22 Jul 2006 00:58:05 +0200
From: Jochen Heuer <jogi-kernel@planetzork.ping.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, nathans@sgi.com,
       xfs@oss.sgi.com
Subject: Re: BUG: soft lockup detected on CPU#1!
Message-ID: <20060721225805.GB12184@planetzork.ping.de>
References: <20060717125216.GA15481@planetzork.ping.de> <1153146608.1218.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153146608.1218.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

> > Jul 17 09:23:03 [kernel]  [<c022dcbe>] crypt+0xee/0x1e0
> > Jul 17 09:23:03 [kernel]  [<c022ddef>] crypt_iv_unaligned+0x3f/0xc0
> > Jul 17 09:23:03 [kernel]  [<c022e23d>] cbc_decrypt_iv+0x3d/0x50
> > Jul 17 09:23:03 [kernel]  [<c032f6b7>] crypt_convert_scatterlist+0x117/0x170
> > Jul 17 09:23:03 [kernel]  [<c032f8b2>] crypt_convert+0x142/0x190
> > Jul 17 09:23:03 [kernel]  [<c032fb82>] kcryptd_do_work+0x42/0x60
> > Jul 17 09:23:03 [kernel]  [<c012fcff>] run_workqueue+0x6f/0xe0
> > Jul 17 09:23:03 [kernel]  [<c012fe98>] worker_thread+0x128/0x150
> > Jul 17 09:23:03 [kernel]  [<c0133364>] kthread+0xa4/0xe0
> > Jul 17 09:23:03 [kernel]  [<c01010e5>] kernel_thread_helper+0x5/0x10
> > Jul 17 09:24:17 [kernel] =============================================
> > Jul 17 09:24:17 [kernel] [ INFO: possible recursive locking detected ]
> > Jul 17 09:24:17 [kernel] ---------------------------------------------
> 
> This looks like a separate issue, and something more about fixing
> lockdep not to report it instead of an actual bug (and why I CC'd the
> xfs folks and Ingo).
> 
> Probably XFS needs to tell lockdep about it's nesting. But maybe there
> is a bug that is lying in there somewhere.

I have some more of these. Now they look like this every time I get them:

Jul 19 18:43:15 [kernel] =============================================
Jul 19 18:43:15 [kernel] [ INFO: possible recursive locking detected ]
Jul 19 18:43:15 [kernel] ---------------------------------------------
Jul 19 18:43:15 [kernel] qmail-local/9368 is trying to acquire lock:
Jul 19 18:43:15 [kernel]  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f63b0>]
xfs_ilock+0x60/0xb0
Jul 19 18:43:15 [kernel] but task is already holding lock:
Jul 19 18:43:15 [kernel]  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f63b0>]
xfs_ilock+0x60/0xb0
Jul 19 18:43:15 [kernel] other info that might help us debug this:
Jul 19 18:43:15 [kernel] 2 locks held by qmail-local/9368:
Jul 19 18:43:15 [kernel]  #0:  (&inode->i_mutex){--..}, at: [<c03c2931>]
mutex_lock+0x21/0x30
Jul 19 18:43:15 [kernel]  #1:  (&(&ip->i_lock)->mr_lock){----}, at:
[<c01f63b0>] xfs_ilock+0x60/0xb0
Jul 19 18:43:15 [kernel] stack backtrace:
Jul 19 18:43:15 [kernel]  [<c0103cd2>] show_trace+0x12/0x20
Jul 19 18:43:15 [kernel]  [<c0103de9>] dump_stack+0x19/0x20
Jul 19 18:43:15 [kernel]  [<c01385a9>] print_deadlock_bug+0xb9/0xd0
Jul 19 18:43:15 [kernel]  [<c013862b>] check_deadlock+0x6b/0x80
Jul 19 18:43:15 [kernel]  [<c0139ed4>] __lock_acquire+0x354/0x990
Jul 19 18:43:15 [kernel]  [<c013ac35>] lock_acquire+0x75/0xa0
Jul 19 18:43:15 [kernel]  [<c0136aaf>] down_write+0x3f/0x60
Jul 19 18:43:15 [kernel]  [<c01f63b0>] xfs_ilock+0x60/0xb0
Jul 19 18:43:15 [kernel]  [<c01f5b3a>] xfs_iget_core+0x2aa/0x5b0
Jul 19 18:43:15 [kernel]  [<c01f5f0c>] xfs_iget+0xcc/0x150
Jul 19 18:43:15 [kernel]  [<c0210b38>] xfs_trans_iget+0xa8/0x140
Jul 19 18:43:15 [kernel]  [<c01f80af>] xfs_ialloc+0xaf/0x4c0
Jul 19 18:43:15 [kernel]  [<c021159d>] xfs_dir_ialloc+0x6d/0x280
Jul 19 18:43:15 [kernel]  [<c0217381>] xfs_create+0x241/0x670
Jul 19 18:43:15 [kernel]  [<c022307d>] xfs_vn_mknod+0x1ed/0x2e0
Jul 19 18:43:15 [kernel]  [<c0223182>] xfs_vn_create+0x12/0x20
Jul 19 18:43:15 [kernel]  [<c017514d>] vfs_create+0x7d/0xd0
Jul 19 18:43:15 [kernel]  [<c017542f>] open_namei+0xbf/0x620
Jul 19 18:43:15 [kernel]  [<c016487c>] do_filp_open+0x2c/0x60
Jul 19 18:43:15 [kernel]  [<c0164c00>] do_sys_open+0x50/0xe0
Jul 19 18:43:15 [kernel]  [<c0164cac>] sys_open+0x1c/0x20
Jul 19 18:43:15 [kernel]  [<c0102e15>] sysenter_past_esp+0x56/0x8d

Best regards,

   Jochen
