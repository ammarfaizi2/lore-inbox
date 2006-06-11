Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWFKFcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWFKFcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWFKFcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:32:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53205 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932100AbWFKFcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 01:32:42 -0400
Date: Sun, 11 Jun 2006 07:31:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060611053154.GA8581@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu> <1149764032.10056.82.camel@imp.csi.cam.ac.uk> <20060608112306.GA4234@elte.hu> <1149840563.3619.46.camel@imp.csi.cam.ac.uk> <20060610075954.GA30119@elte.hu> <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
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

> I think the lock validator has the problem of not knowing that there 
> are two different types of runlist which is why it complains about it.

ah, ok! What happened is that the rwlock_init() 'lock type keys' 
(inlined via ntfs_init_runlist()) for the two runlists were 'merged':

        ntfs_init_runlist(&ni->runlist);
        ntfs_init_runlist(&ni->attr_list_rl);

i have annotated things by initializing the two locks separately (via a 
simple oneliner change), and this has solved the problem.

The two types are now properly 'split', and the validator tracks them 
separately and understands their separate roles. So there's no need to 
touch attribute runlist locking in the NTFS code.

Some background: the validator uses lock initialization as a hint about 
which locks share the same 'type' (or locking domain). Currently this is 
done via:

 #define init_rwsem(sem)                                         \
 do {                                                            \
         static struct lockdep_type_key __key;                   \
                                                                 \
         __init_rwsem((sem), #sem, &__key);                      \
 } while (0)

But since ntfs_init_runlist() got inlined to within the same function, 
the __key there got shared. A better method might be to use the return 
address in __init_rwsem() [and i used that in earlier versions of the 
validator] - but even then there's no guarantee that this code will 
always be inlined. In any case, this is known to be a heuristics, it is 
totally valid to initialize locks in arbitrary manner, and the validator 
only tries to guess it right in 99.9% of the cases. In cases where the 
validator incorrectly merged (or split) lock types [such as in this 
case], the problem can be found easily - and the annotation is easy as 
well.

The good news is that after this fix things went pretty well for 
readonly stuff and i got no new complaints from the validator. Phew! :-) 

It does not fully cover read-write mode yet. When extending an existing 
file the validator did not understand the following locking construct:

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
cat/2802 is trying to acquire lock:
 (&vol->lcnbmp_lock){----}, at: [<c01e80dd>] ntfs_cluster_alloc+0x10d/0x23a0

but task is already holding lock:
 (&ni->mrec_lock){--..}, at: [<c01d5e53>] map_mft_record+0x53/0x2c0

which lock already depends on the new lock,
which could lead to circular dependencies.

the existing dependency chain (in reverse order) is:

-> #2 (&ni->mrec_lock){--..}:
       [<c01394df>] lock_acquire+0x6f/0x90
       [<c0346193>] mutex_lock_nested+0x73/0x2a0
       [<c01d5e53>] map_mft_record+0x53/0x2c0
       [<c01c54f8>] ntfs_map_runlist_nolock+0x3d8/0x530
       [<c01c5bc1>] ntfs_map_runlist+0x41/0x70
       [<c01c1929>] ntfs_readpage+0x8c9/0x9b0
       [<c0142ffc>] read_cache_page+0xac/0x150
       [<c01e213d>] ntfs_statfs+0x41d/0x660
       [<c0163254>] vfs_statfs+0x54/0x70
       [<c0163288>] vfs_statfs64+0x18/0x30
       [<c0163384>] sys_statfs64+0x64/0xa0
       [<c0347ddd>] sysenter_past_esp+0x56/0x8d

-> #1 (&rl->lock){----}:
       [<c01394df>] lock_acquire+0x6f/0x90
       [<c0134c8a>] down_read_nested+0x2a/0x40
       [<c01c18a4>] ntfs_readpage+0x844/0x9b0
       [<c0142ffc>] read_cache_page+0xac/0x150
       [<c01e213d>] ntfs_statfs+0x41d/0x660
       [<c0163254>] vfs_statfs+0x54/0x70
       [<c0163288>] vfs_statfs64+0x18/0x30
       [<c0163384>] sys_statfs64+0x64/0xa0
       [<c0347ddd>] sysenter_past_esp+0x56/0x8d

-> #0 (&vol->lcnbmp_lock){----}:
       [<c01394df>] lock_acquire+0x6f/0x90
       [<c0134ccc>] down_write+0x2c/0x50
       [<c01e80dd>] ntfs_cluster_alloc+0x10d/0x23a0
       [<c01c427d>] ntfs_attr_extend_allocation+0x5fd/0x14a0
       [<c01caa38>] ntfs_file_buffered_write+0x188/0x3880
       [<c01ce2a8>] ntfs_file_aio_write_nolock+0x178/0x210
       [<c01ce3f1>] ntfs_file_writev+0xb1/0x150
       [<c01ce4af>] ntfs_file_write+0x1f/0x30
       [<c0164f09>] vfs_write+0x99/0x160
       [<c016589d>] sys_write+0x3d/0x70
       [<c0347ddd>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

3 locks held by cat/2802:
 #0:  (&inode->i_mutex){--..}, at: [<c0346118>] mutex_lock+0x8/0x10
 #1:  (&rl->lock){----}, at: [<c01c3dbe>] ntfs_attr_extend_allocation+0x13e/0x14a0
 #2:  (&ni->mrec_lock){--..}, at: [<c01d5e53>] map_mft_record+0x53/0x2c0

stack backtrace:
 [<c0104bf2>] show_trace+0x12/0x20
 [<c0104c19>] dump_stack+0x19/0x20
 [<c0136ef1>] print_circular_bug_tail+0x61/0x70
 [<c01389ff>] __lock_acquire+0x74f/0xde0
 [<c01394df>] lock_acquire+0x6f/0x90
 [<c0134ccc>] down_write+0x2c/0x50
 [<c01e80dd>] ntfs_cluster_alloc+0x10d/0x23a0
 [<c01c427d>] ntfs_attr_extend_allocation+0x5fd/0x14a0
 [<c01caa38>] ntfs_file_buffered_write+0x188/0x3880
 [<c01ce2a8>] ntfs_file_aio_write_nolock+0x178/0x210
 [<c01ce3f1>] ntfs_file_writev+0xb1/0x150
 [<c01ce4af>] ntfs_file_write+0x1f/0x30
 [<c0164f09>] vfs_write+0x99/0x160
 [<c016589d>] sys_write+0x3d/0x70
 [<c0347ddd>] sysenter_past_esp+0x56/0x8d

this seems to be a pretty complex 3-way dependency related to 
&vol->lcnbmp_lock and &ni->mrec_lock. Should i send a full dependency 
events trace perhaps?

	Ingo
