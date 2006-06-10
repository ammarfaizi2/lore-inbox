Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWFJIAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWFJIAn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWFJIAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:00:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31426 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030357AbWFJIAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:00:42 -0400
Date: Sat, 10 Jun 2006 09:59:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060610075954.GA30119@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu> <1149764032.10056.82.camel@imp.csi.cam.ac.uk> <20060608112306.GA4234@elte.hu> <1149840563.3619.46.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149840563.3619.46.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> The normal access pattern (B) where the runlist lock is always taken 
> first.  And the mft record lock is taken second and only if the 
> runlist is incomplete in-memory.
> 
> Of course on file modification, this is also the case, the runlist 
> lock is taken first, then the mft record lock is taken and thus both 
> the runlist and the inode can be updated with the new data (e.g. on a 
> file extend).

thanks for the detailed explanation!

I have annotated the code for the lock validator as much as i could, by:

- excluding ntfs_fill_super() from the locking rules,

- 'splitting' the MFT's mrec_lock and runlist->lock locking rules from 
  the other inodes's locking rules,

- splitting the mrec_lock rules of extent inodes. (We map them
  recursively while having the main inode mft record mapped. The nesting
  is safe because inode->extent_inode is a noncircular relation.)

Still there seems to be a case that the validator does not grok: 
load_attribute_list() seems to take the lock in the opposite order from 
what you described above. What locking detail am i missing? [let me know 
if you need all dependency events leading up to this message from the 
validator]

	Ingo

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
ls/2581 is trying to acquire lock:
 (&rl->lock){----}, at: [<c01c1f5b>] load_attribute_list+0xfb/0x3c0

but task is already holding lock:
 (&ni->mrec_lock){--..}, at: [<c01d50c5>] map_mft_record_type+0x55/0x2d0

which lock already depends on the new lock,
which could lead to circular locking dependencies.

the existing dependency chain (in reverse order) is:

-> #1 (&ni->mrec_lock){--..}:
       [<c01394df>] lock_acquire+0x6f/0x90
       [<c0346183>] mutex_lock_nested+0x73/0x2a0
       [<c01d5e43>] map_mft_record+0x53/0x2c0
       [<c01c54f8>] ntfs_map_runlist_nolock+0x3d8/0x530
       [<c01c5bc1>] ntfs_map_runlist+0x41/0x70
       [<c01c1929>] ntfs_readpage+0x8c9/0x9b0
       [<c0142ffc>] read_cache_page+0xac/0x150
       [<c01e212d>] ntfs_statfs+0x41d/0x660
       [<c0163254>] vfs_statfs+0x54/0x70
       [<c0163288>] vfs_statfs64+0x18/0x30
       [<c0163384>] sys_statfs64+0x64/0xa0
       [<c0347dcd>] sysenter_past_esp+0x56/0x8d

-> #0 (&rl->lock){----}:
       [<c01394df>] lock_acquire+0x6f/0x90
       [<c0134c8a>] down_read_nested+0x2a/0x40
       [<c01c1f5b>] load_attribute_list+0xfb/0x3c0
       [<c01d323e>] ntfs_read_locked_inode+0xcee/0x15d0
       [<c01d4735>] ntfs_iget+0x55/0x80
       [<c01db3da>] ntfs_lookup+0x14a/0x740
       [<c01736b6>] do_lookup+0x126/0x150
       [<c0173ef3>] __link_path_walk+0x813/0xe50
       [<c017457c>] link_path_walk+0x4c/0xf0
       [<c0174a2d>] do_path_lookup+0xad/0x260
       [<c0175228>] __user_walk_fd+0x38/0x60
       [<c016e3be>] vfs_lstat_fd+0x1e/0x50
       [<c016e401>] vfs_lstat+0x11/0x20
       [<c016ec04>] sys_lstat64+0x14/0x30
       [<c0347dcd>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

2 locks held by ls/2581:
 #0:  (&inode->i_mutex){--..}, at: [<c0346108>] mutex_lock+0x8/0x10
 #1:  (&ni->mrec_lock){--..}, at: [<c01d50c5>] map_mft_record_type+0x55/0x2d0

stack backtrace:
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0136ef1>] print_circular_bug_tail+0x61/0x70
 [<c01389ff>] __lock_acquire+0x74f/0xde0
 [<c01394df>] lock_acquire+0x6f/0x90
 [<c0134c8a>] down_read_nested+0x2a/0x40
 [<c01c1f5b>] load_attribute_list+0xfb/0x3c0
 [<c01d323e>] ntfs_read_locked_inode+0xcee/0x15d0
 [<c01d4735>] ntfs_iget+0x55/0x80
 [<c01db3da>] ntfs_lookup+0x14a/0x740
 [<c01736b6>] do_lookup+0x126/0x150
 [<c0173ef3>] __link_path_walk+0x813/0xe50
 [<c017457c>] link_path_walk+0x4c/0xf0
 [<c0174a2d>] do_path_lookup+0xad/0x260
 [<c0175228>] __user_walk_fd+0x38/0x60
 [<c016e3be>] vfs_lstat_fd+0x1e/0x50
 [<c016e401>] vfs_lstat+0x11/0x20
 [<c016ec04>] sys_lstat64+0x14/0x30
 [<c0347dcd>] sysenter_past_esp+0x56/0x8d
