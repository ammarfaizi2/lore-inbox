Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWFHLXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWFHLXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWFHLXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:23:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:39875 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932246AbWFHLXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:23:42 -0400
Date: Thu, 8 Jun 2006 13:23:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060608112306.GA4234@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu> <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> No it is not as explained above.  Something has gotten confused 
> somewhere because the order of events is the wrong way round...

ok, next try. Find below a chronological trace of the lock acquire and 
new dependency events leading up the the circular dependency message.

The first (mrec_lock -> runlist.lock) dependency is:

 new dependency:  (&ni->mrec_lock){--..} =>  (&rl->lock){..--}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

and the opposite (runlist.lock -> mrec_lock) dependency wants to get 
created at:

 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01c5358>] ntfs_map_runlist_nolock+0x3d8/0x530
 [<c01c5a21>] ntfs_map_runlist+0x41/0x70
 [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

does this trace make more sense?

	Ingo

----{ NTFS lock events trace }------------->

new type c05bfcc4: &ni->mrec_lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138f24>] __lock_acquire+0xd04/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

acquire type [c05bfcc4] &ni->mrec_lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138759>] __lock_acquire+0x539/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&s->s_umount#15){--..} =>  (&ni->mrec_lock){....}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

marked lock as {hardirq-on-W}:
 (&ni->mrec_lock){-...}, at: [<c0340678>] mutex_lock+0x8/0x10
irq event stamp: 2309
hardirqs last  enabled at (2307): [<c03420a7>] _spin_unlock_irqrestore+0x47/0x60
hardirqs last disabled at (2309): [<c011cad6>] vprintk+0x26/0x360
softirqs last  enabled at (1988): [<c0121e0e>] __do_softirq+0xfe/0x110
softirqs last disabled at (1981): [<c0105049>] do_softirq+0x69/0x100
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0137d37>] mark_lock+0x1c7/0x6b0
 [<c01394db>] mark_held_locks+0x4b/0xa0
 [<c0139660>] trace_hardirqs_on+0x70/0x160
 [<c034052f>] __mutex_lock_slowpath+0x15f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

marked lock as {softirq-on-W}:
 (&ni->mrec_lock){--..}, at: [<c0340678>] mutex_lock+0x8/0x10
irq event stamp: 2309
hardirqs last  enabled at (2307): [<c03420a7>] _spin_unlock_irqrestore+0x47/0x60
hardirqs last disabled at (2309): [<c011cad6>] vprintk+0x26/0x360
softirqs last  enabled at (1988): [<c0121e0e>] __do_softirq+0xfe/0x110
softirqs last disabled at (1981): [<c0105049>] do_softirq+0x69/0x100
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0137d37>] mark_lock+0x1c7/0x6b0
 [<c0139512>] mark_held_locks+0x82/0xa0
 [<c01396a0>] trace_hardirqs_on+0xb0/0x160
 [<c034052f>] __mutex_lock_slowpath+0x15f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (cpa_lock){++..}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0342159>] _spin_lock_irqsave+0x39/0x50
 [<c01135fc>] change_page_attr+0x1c/0x2a0
 [<c01138aa>] kernel_map_pages+0x2a/0xa0
 [<c0147f53>] get_page_from_freelist+0x253/0x3c0
 [<c0148110>] __alloc_pages+0x50/0x2f0
 [<c0142f65>] read_cache_page+0x85/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (&inode->i_data.tree_lock){++..}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0341c82>] _write_lock_irq+0x32/0x40
 [<c0142181>] add_to_page_cache+0x41/0xd0
 [<c014222b>] add_to_page_cache_lru+0x1b/0x40
 [<c0142f17>] read_cache_page+0x37/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (&inode->i_data.private_lock){--..}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0341bbc>] _spin_lock+0x2c/0x40
 [<c0168053>] create_empty_buffers+0x33/0xa0
 [<c01c11e7>] ntfs_readpage+0x317/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

new type c05bfcbc: &rl->lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138f24>] __lock_acquire+0xd04/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

acquire type [c05bfcbc] &rl->lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138759>] __lock_acquire+0x539/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

marked lock as {hardirq-on-R}:
 (&rl->lock){..-.}, at: [<c01c170c>] ntfs_readpage+0x83c/0x9a0
irq event stamp: 2440
hardirqs last  enabled at (2439): [<c0342107>] _read_unlock_irqrestore+0x47/0x60
hardirqs last disabled at (2440): [<c011cad6>] vprintk+0x26/0x360
softirqs last  enabled at (2436): [<c0121e0e>] __do_softirq+0xfe/0x110
softirqs last disabled at (2419): [<c0105049>] do_softirq+0x69/0x100
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0137d37>] mark_lock+0x1c7/0x6b0
 [<c0138776>] __lock_acquire+0x556/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

marked lock as {softirq-on-R}:
 (&rl->lock){..--}, at: [<c01c170c>] ntfs_readpage+0x83c/0x9a0
irq event stamp: 2440
hardirqs last  enabled at (2439): [<c0342107>] _read_unlock_irqrestore+0x47/0x60
hardirqs last disabled at (2440): [<c011cad6>] vprintk+0x26/0x360
softirqs last  enabled at (2436): [<c0121e0e>] __do_softirq+0xfe/0x110
softirqs last disabled at (2419): [<c0105049>] do_softirq+0x69/0x100
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0137d37>] mark_lock+0x1c7/0x6b0
 [<c0138882>] __lock_acquire+0x662/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (&rl->lock){..--}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (&lo->lo_lock){....}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0341f62>] _spin_lock_irq+0x32/0x40
 [<c0276e69>] loop_make_request+0x49/0x100
 [<c01f3f51>] generic_make_request+0x1c1/0x270
 [<c01f404e>] submit_bio+0x4e/0xe0
 [<c016731d>] submit_bh+0xcd/0x130
 [<c01c173e>] ntfs_readpage+0x86e/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (&q->lock){++..}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0342159>] _spin_lock_irqsave+0x39/0x50
 [<c01140cb>] complete+0x1b/0x60
 [<c0276ed7>] loop_make_request+0xb7/0x100
 [<c01f3f51>] generic_make_request+0x1c1/0x270
 [<c01f404e>] submit_bio+0x4e/0xe0
 [<c016731d>] submit_bh+0xcd/0x130
 [<c01c173e>] ntfs_readpage+0x86e/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (ide_lock){++..}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0341f62>] _spin_lock_irq+0x32/0x40
 [<c01f30d1>] generic_unplug_device+0x11/0x30
 [<c01f25e2>] blk_backing_dev_unplug+0x12/0x20
 [<c0276f57>] loop_unplug+0x37/0x40
 [<c01f25e2>] blk_backing_dev_unplug+0x12/0x20
 [<c0166269>] block_sync_page+0x39/0x50
 [<c0141cc8>] sync_page+0x38/0x50
 [<c033fc69>] __wait_on_bit_lock+0x49/0x70
 [<c0141dcb>] __lock_page+0x6b/0x80
 [<c0142fe5>] read_cache_page+0x105/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&ni->mrec_lock){--..} =>  (&rq->lock){++..}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0341f62>] _spin_lock_irq+0x32/0x40
 [<c033ebba>] schedule+0xea/0xb80
 [<c033f678>] io_schedule+0x28/0x40
 [<c0141ccd>] sync_page+0x3d/0x50
 [<c033fc69>] __wait_on_bit_lock+0x49/0x70
 [<c0141dcb>] __lock_page+0x6b/0x80
 [<c0142fe5>] read_cache_page+0x105/0x150
 [<c01d4f92>] map_mft_record+0x112/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
 [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

acquire type [c05bfcc4] &ni->mrec_lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138759>] __lock_acquire+0x539/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
 [<c01d4545>] ntfs_iget+0x55/0x80
 [<c01e216a>] load_system_files+0x7a/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

acquire type [c05bfcbc] &rl->lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138759>] __lock_acquire+0x539/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

 new dependency:  (&s->s_umount#15){--..} =>  (&rl->lock){..--}
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138bc9>] __lock_acquire+0x9a9/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c4c>] down_read+0x2c/0x40
 [<c01c170c>] ntfs_readpage+0x83c/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

acquire type [c05bfcbc] &rl->lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138759>] __lock_acquire+0x539/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c8c>] down_write+0x2c/0x50
 [<c01c5a00>] ntfs_map_runlist+0x20/0x70
 [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

marked lock as {hardirq-on-W}:
 (&rl->lock){-.--}, at: [<c01c5a00>] ntfs_map_runlist+0x20/0x70
irq event stamp: 2940
hardirqs last  enabled at (2939): [<c0342403>] restore_nocheck+0x12/0x15
hardirqs last disabled at (2940): [<c011cad6>] vprintk+0x26/0x360
softirqs last  enabled at (2938): [<c0121e0e>] __do_softirq+0xfe/0x110
softirqs last disabled at (2923): [<c0105049>] do_softirq+0x69/0x100
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0137d37>] mark_lock+0x1c7/0x6b0
 [<c0138588>] __lock_acquire+0x368/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c8c>] down_write+0x2c/0x50
 [<c01c5a00>] ntfs_map_runlist+0x20/0x70
 [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

marked lock as {softirq-on-W}:
 (&rl->lock){----}, at: [<c01c5a00>] ntfs_map_runlist+0x20/0x70
irq event stamp: 2940
hardirqs last  enabled at (2939): [<c0342403>] restore_nocheck+0x12/0x15
hardirqs last disabled at (2940): [<c011cad6>] vprintk+0x26/0x360
softirqs last  enabled at (2938): [<c0121e0e>] __do_softirq+0xfe/0x110
softirqs last disabled at (2923): [<c0105049>] do_softirq+0x69/0x100
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0137d37>] mark_lock+0x1c7/0x6b0
 [<c0138882>] __lock_acquire+0x662/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c0134c8c>] down_write+0x2c/0x50
 [<c01c5a00>] ntfs_map_runlist+0x20/0x70
 [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

acquire type [c05bfcc4] &ni->mrec_lock
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0138759>] __lock_acquire+0x539/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01c5358>] ntfs_map_runlist_nolock+0x3d8/0x530
 [<c01c5a21>] ntfs_map_runlist+0x41/0x70
 [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
mount/2406 is trying to acquire lock:
 (&ni->mrec_lock){--..}, at: [<c0340678>] mutex_lock+0x8/0x10

but task is already holding lock:
 (&rl->lock){----}, at: [<c01c5a00>] ntfs_map_runlist+0x20/0x70

which lock already depends on the new lock,
which could lead to circular deadlocks!

the existing dependency chain (in reverse order) is:

-> #1 (&rl->lock){----}:
       [<c013946b>] lock_acquire+0x7b/0xa0
       [<c0134c4c>] down_read+0x2c/0x40
       [<c01c170c>] ntfs_readpage+0x83c/0x9a0
       [<c0142f8c>] read_cache_page+0xac/0x150
       [<c01d4f92>] map_mft_record+0x112/0x2c0
       [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
       [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
       [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
       [<c016bf5e>] get_sb_bdev+0xde/0x120
       [<c01e03fb>] ntfs_get_sb+0x1b/0x30
       [<c016b583>] vfs_kern_mount+0x33/0xa0
       [<c016b646>] do_kern_mount+0x36/0x50
       [<c0181a4e>] do_mount+0x28e/0x640
       [<c0181e6f>] sys_mount+0x6f/0xb0
       [<c034233d>] sysenter_past_esp+0x56/0x8d

-> #0 (&ni->mrec_lock){--..}:
       [<c013946b>] lock_acquire+0x7b/0xa0
       [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
       [<c0340678>] mutex_lock+0x8/0x10
       [<c01d4ed1>] map_mft_record+0x51/0x2c0
       [<c01c5358>] ntfs_map_runlist_nolock+0x3d8/0x530
       [<c01c5a21>] ntfs_map_runlist+0x41/0x70
       [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
       [<c0142f8c>] read_cache_page+0xac/0x150
       [<c01e2562>] load_system_files+0x472/0x2250
       [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
       [<c016bf5e>] get_sb_bdev+0xde/0x120
       [<c01e03fb>] ntfs_get_sb+0x1b/0x30
       [<c016b583>] vfs_kern_mount+0x33/0xa0
       [<c016b646>] do_kern_mount+0x36/0x50
       [<c0181a4e>] do_mount+0x28e/0x640
       [<c0181e6f>] sys_mount+0x6f/0xb0
       [<c034233d>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

2 locks held by mount/2406:
 #0:  (&s->s_umount#15){--..}, at: [<c016bb8d>] sget+0x11d/0x2f0
 #1:  (&rl->lock){----}, at: [<c01c5a00>] ntfs_map_runlist+0x20/0x70

stack backtrace:
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0136e61>] print_circular_bug_tail+0x61/0x70
 [<c013896f>] __lock_acquire+0x74f/0xde0
 [<c013946b>] lock_acquire+0x7b/0xa0
 [<c034043f>] __mutex_lock_slowpath+0x6f/0x2a0
 [<c0340678>] mutex_lock+0x8/0x10
 [<c01d4ed1>] map_mft_record+0x51/0x2c0
 [<c01c5358>] ntfs_map_runlist_nolock+0x3d8/0x530
 [<c01c5a21>] ntfs_map_runlist+0x41/0x70
 [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
 [<c0142f8c>] read_cache_page+0xac/0x150
 [<c01e2562>] load_system_files+0x472/0x2250
 [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
 [<c016bf5e>] get_sb_bdev+0xde/0x120
 [<c01e03fb>] ntfs_get_sb+0x1b/0x30
 [<c016b583>] vfs_kern_mount+0x33/0xa0
 [<c016b646>] do_kern_mount+0x36/0x50
 [<c0181a4e>] do_mount+0x28e/0x640
 [<c0181e6f>] sys_mount+0x6f/0xb0
 [<c034233d>] sysenter_past_esp+0x56/0x8d
NTFS volume version 1.2.
NTFS-fs warning (device loop0): load_system_files(): Disabling sparse support due to NTFS volume version 1.2 (need at least version 3.0).
