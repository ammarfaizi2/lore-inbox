Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWFLIcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWFLIcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWFLIcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:32:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31935 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750914AbWFLIcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:32:15 -0400
Date: Mon, 12 Jun 2006 10:31:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060612083117.GA29026@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu> <1149764032.10056.82.camel@imp.csi.cam.ac.uk> <20060608112306.GA4234@elte.hu> <1149840563.3619.46.camel@imp.csi.cam.ac.uk> <20060610075954.GA30119@elte.hu> <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk> <20060611053154.GA8581@elte.hu> <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> First an explanation of two relevant locks that are both going to 
> upset the validator.  I half expected this to happen given what has 
> happened so far.  The two locks are lcnbmp_lock and mftbmp_lock (both 
> are r/w semaphores).

thanks!

> Is the above description sufficient for you to fix it?

yeah. I have split off vol->lcnbmp_ino's locking rules (for mrec_lock 
and runlist.lock) from normal inode locking rules, and this fixed the 
file-writing dependency.

but i can still trigger a warning, and i think this time it's a real 
bug: if i mount NTFS with -o show_system_files, and i append data to the 
$Bitmap, then i get the dependency conflict attached further below.

While extending the $Bitmap manually is extremely evil, the filesystem 
should nevertheless not break - for example a script could do it by 
accident. I believe NTFS should either disallow writing to the $Bitmap 
(by forcing it to be readonly under all circumstances), or the writing 
should be made safe - right now if that happens in parallel to some 
other process extending an NTFS file then i think we could deadlock, 
right?

	Ingo

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
cat/2532 is trying to acquire lock:
 (&vol->lcnbmp_lock){----}, at: [<c01e809d>] ntfs_cluster_alloc+0x10d/0x23a0

but task is already holding lock:
 (lcnbmp_mrec_lock){--..}, at: [<c01d5dc3>] map_mft_record+0x53/0x2c0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (lcnbmp_mrec_lock){--..}:
       [<c013948f>] lock_acquire+0x6f/0x90
       [<c0346163>] mutex_lock_nested+0x73/0x2a0
       [<c01d5dc3>] map_mft_record+0x53/0x2c0
       [<c01c5498>] ntfs_map_runlist_nolock+0x3d8/0x530
       [<c01c5b61>] ntfs_map_runlist+0x41/0x70
       [<c01c18d1>] ntfs_readpage+0x8c1/0x9a0
       [<c0142fac>] read_cache_page+0xac/0x150
       [<c01e20ad>] ntfs_statfs+0x41d/0x660
       [<c0163204>] vfs_statfs+0x54/0x70
       [<c0163238>] vfs_statfs64+0x18/0x30
       [<c0163334>] sys_statfs64+0x64/0xa0
       [<c0347dad>] sysenter_past_esp+0x56/0x8d

-> #1 (lcnbmp_runlist_lock){----}:
       [<c013948f>] lock_acquire+0x6f/0x90
       [<c0134c4c>] down_read+0x2c/0x40
       [<c01c184c>] ntfs_readpage+0x83c/0x9a0
       [<c0142fac>] read_cache_page+0xac/0x150
       [<c01e20ad>] ntfs_statfs+0x41d/0x660
       [<c0163204>] vfs_statfs+0x54/0x70
       [<c0163238>] vfs_statfs64+0x18/0x30
       [<c0163334>] sys_statfs64+0x64/0xa0
       [<c0347dad>] sysenter_past_esp+0x56/0x8d

-> #0 (&vol->lcnbmp_lock){----}:
       [<c013948f>] lock_acquire+0x6f/0x90
       [<c0134ccc>] down_write+0x2c/0x50
       [<c01e809d>] ntfs_cluster_alloc+0x10d/0x23a0
       [<c01c421d>] ntfs_attr_extend_allocation+0x5fd/0x14a0
       [<c01ca9d8>] ntfs_file_buffered_write+0x188/0x3880
       [<c01ce248>] ntfs_file_aio_write_nolock+0x178/0x210
       [<c01ce391>] ntfs_file_writev+0xb1/0x150
       [<c01ce44f>] ntfs_file_write+0x1f/0x30
       [<c0164eb9>] vfs_write+0x99/0x160
       [<c016584d>] sys_write+0x3d/0x70
       [<c0347dad>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

3 locks held by cat/2532:
 #0:  (&inode->i_mutex){--..}, at: [<c03460e8>] mutex_lock+0x8/0x10
 #1:  (lcnbmp_runlist_lock){----}, at: [<c01c3d5e>] ntfs_attr_extend_allocation+0x13e/0x14a0
 #2:  (lcnbmp_mrec_lock){--..}, at: [<c01d5dc3>] map_mft_record+0x53/0x2c0

stack backtrace:
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0136f11>] print_circular_bug_tail+0x61/0x70
 [<c01389af>] __lock_acquire+0x6df/0xd70
 [<c013948f>] lock_acquire+0x6f/0x90
 [<c0134ccc>] down_write+0x2c/0x50
 [<c01e809d>] ntfs_cluster_alloc+0x10d/0x23a0
 [<c01c421d>] ntfs_attr_extend_allocation+0x5fd/0x14a0
 [<c01ca9d8>] ntfs_file_buffered_write+0x188/0x3880
 [<c01ce248>] ntfs_file_aio_write_nolock+0x178/0x210
 [<c01ce391>] ntfs_file_writev+0xb1/0x150
 [<c01ce44f>] ntfs_file_write+0x1f/0x30
 [<c0164eb9>] vfs_write+0x99/0x160
 [<c016584d>] sys_write+0x3d/0x70
 [<c0347dad>] sysenter_past_esp+0x56/0x8d
