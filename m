Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759060AbWLDIJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759060AbWLDIJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759068AbWLDIJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:09:03 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:12695 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1759060AbWLDIJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:09:01 -0500
Message-ID: <365219737.01594@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 4 Dec 2006 16:09:02 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: drop_pagecache: Possible circular locking dependency
Message-ID: <20061204080902.GA5725@mail.ustc.edu.cn>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Got the following message when doing some benchmarks.
I guess we should not hold inode_lock on calling invalidate_inode_pages().
Any ideas?

Fengguang Wu

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.19-rc6-mm2 #3
-------------------------------------------------------
rabench.sh/7467 is trying to acquire lock:
 (&journal->j_list_lock){--..}, at: [<ffffffff8113bdbc>] journal_try_to_free_buffers+0xdc/0x1c0

but task is already holding lock:
 (inode_lock){--..}, at: [<ffffffff810fe857>] drop_pagecache+0x67/0x120

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (inode_lock){--..}:
       [<ffffffff810b098f>] add_lock_to_list+0x8f/0xd0
       [<ffffffff810b35b9>] __lock_acquire+0xb29/0xd40
       [<ffffffff810b3863>] lock_acquire+0x93/0xc0
       [<ffffffff81072875>] _spin_lock+0x25/0x40
       [<ffffffff81014e41>] __mark_inode_dirty+0x101/0x190
       [<ffffffff8100fa00>] __set_page_dirty_nobuffers+0x150/0x170
       [<ffffffff810314ae>] mark_buffer_dirty+0x1e/0x30
       [<ffffffff81139798>] __journal_temp_unlink_buffer+0x1a8/0x1c0
       [<ffffffff81139a31>] __journal_unfile_buffer+0x11/0x20
       [<ffffffff81139ac7>] __journal_refile_buffer+0x87/0x120
       [<ffffffff8113cfe5>] journal_commit_transaction+0x1005/0x1300
       [<ffffffff81141285>] kjournald+0xd5/0x230
       [<ffffffff810393ea>] kthread+0xda/0x110
       [<ffffffff8106bf38>] child_rip+0xa/0x12
       [<ffffffffffffffff>] 0xffffffffffffffff

-> #0 (&journal->j_list_lock){--..}:
       [<ffffffff810b19e5>] print_circular_bug_tail+0x55/0xb0
       [<ffffffff810b349e>] __lock_acquire+0xa0e/0xd40
       [<ffffffff810b3863>] lock_acquire+0x93/0xc0
       [<ffffffff81072875>] _spin_lock+0x25/0x40
       [<ffffffff8113bdbc>] journal_try_to_free_buffers+0xdc/0x1c0
       [<ffffffff8112af49>] ext3_releasepage+0xa9/0xd0
       [<ffffffff8102c1ba>] try_to_release_page+0x5a/0x80
       [<ffffffff8104f438>] invalidate_mapping_pages+0xa8/0x150
       [<ffffffff81066842>] invalidate_inode_pages+0x12/0x20
       [<ffffffff810fe895>] drop_pagecache+0xa5/0x120
       [<ffffffff810fe932>] drop_caches_sysctl_handler+0x22/0x80
       [<ffffffff8109dca7>] do_rw_proc+0xe7/0x150
       [<ffffffff8109dd2a>] proc_writesys+0x1a/0x20
       [<ffffffff81018344>] vfs_write+0xf4/0x1b0
       [<ffffffff81018ea0>] sys_write+0x50/0xa0
       [<ffffffff8106b11e>] system_call+0x7e/0x83
       [<00002af654962422>] 0x2af654962422
       [<ffffffffffffffff>] 0xffffffffffffffff

other info that might help us debug this:

2 locks held by rabench.sh/7467:
 #0:  (&type->s_umount_key#16){----}, at: [<ffffffff810fe843>] drop_pagecache+0x53/0x120
 #1:  (inode_lock){--..}, at: [<ffffffff810fe857>] drop_pagecache+0x67/0x120

stack backtrace:

Call Trace:
 [<ffffffff8107a3e3>] dump_trace+0xb3/0x460
 [<ffffffff8107a7d3>] show_trace+0x43/0x70
 [<ffffffff8107a815>] dump_stack+0x15/0x20
 [<ffffffff810b1a26>] print_circular_bug_tail+0x96/0xb0
 [<ffffffff810b349e>] __lock_acquire+0xa0e/0xd40
 [<ffffffff810b3863>] lock_acquire+0x93/0xc0
 [<ffffffff81072875>] _spin_lock+0x25/0x40
 [<ffffffff8113bdbc>] journal_try_to_free_buffers+0xdc/0x1c0
 [<ffffffff8112af49>] ext3_releasepage+0xa9/0xd0
 [<ffffffff8102c1ba>] try_to_release_page+0x5a/0x80
 [<ffffffff8104f438>] invalidate_mapping_pages+0xa8/0x150
 [<ffffffff81066842>] invalidate_inode_pages+0x12/0x20
 [<ffffffff810fe895>] drop_pagecache+0xa5/0x120
 [<ffffffff810fe932>] drop_caches_sysctl_handler+0x22/0x80
 [<ffffffff8109dca7>] do_rw_proc+0xe7/0x150
 [<ffffffff8109dd2a>] proc_writesys+0x1a/0x20
 [<ffffffff81018344>] vfs_write+0xf4/0x1b0
 [<ffffffff81018ea0>] sys_write+0x50/0xa0
 [<ffffffff8106b11e>] system_call+0x7e/0x83
 [<00002af654962422>]

2 locks held by rabench.sh/7467:
 #0:  (&type->s_umount_key#16){----}, at: [<ffffffff810fe843>] drop_pagecache+0x53/0x120
 #1:  (inode_lock){--..}, at: [<ffffffff810fe857>] drop_pagecache+0x67/0x120
