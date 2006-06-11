Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWFKHKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWFKHKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 03:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWFKHKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 03:10:16 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:48097 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751560AbWFKHKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 03:10:15 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sun, 11 Jun 2006 08:10:10 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
 detected!
In-Reply-To: <20060611053154.GA8581@elte.hu>
Message-ID: <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
 <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu>
 <1149764032.10056.82.camel@imp.csi.cam.ac.uk> <20060608112306.GA4234@elte.hu>
 <1149840563.3619.46.camel@imp.csi.cam.ac.uk> <20060610075954.GA30119@elte.hu>
 <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
 <20060611053154.GA8581@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > I think the lock validator has the problem of not knowing that there 
> > are two different types of runlist which is why it complains about it.
> 
> ah, ok! What happened is that the rwlock_init() 'lock type keys' 
> (inlined via ntfs_init_runlist()) for the two runlists were 'merged':
> 
>         ntfs_init_runlist(&ni->runlist);
>         ntfs_init_runlist(&ni->attr_list_rl);
> 
> i have annotated things by initializing the two locks separately (via a 
> simple oneliner change), and this has solved the problem.
> 
> The two types are now properly 'split', and the validator tracks them 
> separately and understands their separate roles. So there's no need to 
> touch attribute runlist locking in the NTFS code.

Great!

> Some background: the validator uses lock initialization as a hint about 

Thanks for explaining.

> The good news is that after this fix things went pretty well for 
> readonly stuff and i got no new complaints from the validator. Phew! :-) 

Great!

> It does not fully cover read-write mode yet. When extending an existing 
> file the validator did not understand the following locking construct:
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> cat/2802 is trying to acquire lock:
>  (&vol->lcnbmp_lock){----}, at: [<c01e80dd>] ntfs_cluster_alloc+0x10d/0x23a0
> 
> but task is already holding lock:
>  (&ni->mrec_lock){--..}, at: [<c01d5e53>] map_mft_record+0x53/0x2c0
> 
> which lock already depends on the new lock,
> which could lead to circular dependencies.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&ni->mrec_lock){--..}:
>        [<c01394df>] lock_acquire+0x6f/0x90
>        [<c0346193>] mutex_lock_nested+0x73/0x2a0
>        [<c01d5e53>] map_mft_record+0x53/0x2c0
>        [<c01c54f8>] ntfs_map_runlist_nolock+0x3d8/0x530
>        [<c01c5bc1>] ntfs_map_runlist+0x41/0x70
>        [<c01c1929>] ntfs_readpage+0x8c9/0x9b0
>        [<c0142ffc>] read_cache_page+0xac/0x150
>        [<c01e213d>] ntfs_statfs+0x41d/0x660
>        [<c0163254>] vfs_statfs+0x54/0x70
>        [<c0163288>] vfs_statfs64+0x18/0x30
>        [<c0163384>] sys_statfs64+0x64/0xa0
>        [<c0347ddd>] sysenter_past_esp+0x56/0x8d
> 
> -> #1 (&rl->lock){----}:
>        [<c01394df>] lock_acquire+0x6f/0x90
>        [<c0134c8a>] down_read_nested+0x2a/0x40
>        [<c01c18a4>] ntfs_readpage+0x844/0x9b0
>        [<c0142ffc>] read_cache_page+0xac/0x150
>        [<c01e213d>] ntfs_statfs+0x41d/0x660
>        [<c0163254>] vfs_statfs+0x54/0x70
>        [<c0163288>] vfs_statfs64+0x18/0x30
>        [<c0163384>] sys_statfs64+0x64/0xa0
>        [<c0347ddd>] sysenter_past_esp+0x56/0x8d
> 
> -> #0 (&vol->lcnbmp_lock){----}:
>        [<c01394df>] lock_acquire+0x6f/0x90
>        [<c0134ccc>] down_write+0x2c/0x50
>        [<c01e80dd>] ntfs_cluster_alloc+0x10d/0x23a0
>        [<c01c427d>] ntfs_attr_extend_allocation+0x5fd/0x14a0
>        [<c01caa38>] ntfs_file_buffered_write+0x188/0x3880
>        [<c01ce2a8>] ntfs_file_aio_write_nolock+0x178/0x210
>        [<c01ce3f1>] ntfs_file_writev+0xb1/0x150
>        [<c01ce4af>] ntfs_file_write+0x1f/0x30
>        [<c0164f09>] vfs_write+0x99/0x160
>        [<c016589d>] sys_write+0x3d/0x70
>        [<c0347ddd>] sysenter_past_esp+0x56/0x8d
> 
> other info that might help us debug this:
> 
> 3 locks held by cat/2802:
>  #0:  (&inode->i_mutex){--..}, at: [<c0346118>] mutex_lock+0x8/0x10
>  #1:  (&rl->lock){----}, at: [<c01c3dbe>] ntfs_attr_extend_allocation+0x13e/0x14a0
>  #2:  (&ni->mrec_lock){--..}, at: [<c01d5e53>] map_mft_record+0x53/0x2c0
> 
> stack backtrace:
>  [<c0104bf2>] show_trace+0x12/0x20
>  [<c0104c19>] dump_stack+0x19/0x20
>  [<c0136ef1>] print_circular_bug_tail+0x61/0x70
>  [<c01389ff>] __lock_acquire+0x74f/0xde0
>  [<c01394df>] lock_acquire+0x6f/0x90
>  [<c0134ccc>] down_write+0x2c/0x50
>  [<c01e80dd>] ntfs_cluster_alloc+0x10d/0x23a0
>  [<c01c427d>] ntfs_attr_extend_allocation+0x5fd/0x14a0
>  [<c01caa38>] ntfs_file_buffered_write+0x188/0x3880
>  [<c01ce2a8>] ntfs_file_aio_write_nolock+0x178/0x210
>  [<c01ce3f1>] ntfs_file_writev+0xb1/0x150
>  [<c01ce4af>] ntfs_file_write+0x1f/0x30
>  [<c0164f09>] vfs_write+0x99/0x160
>  [<c016589d>] sys_write+0x3d/0x70
>  [<c0347ddd>] sysenter_past_esp+0x56/0x8d
> 
> this seems to be a pretty complex 3-way dependency related to 
> &vol->lcnbmp_lock and &ni->mrec_lock. Should i send a full dependency 
> events trace perhaps?

First an explanation of two relevant locks that are both going to upset 
the validator.  I half expected this to happen given what has happened so 
far.  The two locks are lcnbmp_lock and mftbmp_lock (both are r/w 
semaphores).

Both those locks lock the two big bitmaps on an NTFS volume:

lcnbmp_lock locks accesses to the cluster bitmap (i.e. the physical blocks 
bitmap where each 0 bit means an unallocated block and a 1 bit means an 
allocated block).

mftbmp_lock locks accesses to the mft bitmap (i.e. the inodes bitmap where 
each 0 bit means an unused inode and a 1 bit means the inode is in use).

The locks are taken when a cluster is being allocated / an mft record is 
being allocated.

The reason the validator will likely get very confused is that they 
introduce reverse semantics depending on what you are locking, i.e.

When extending a file the locking order is:

Lock runlist (data one) of file to be extended for writing (as it will be 
modified by the file extension).

Lock lcnbmp_lock for writing (as the bitmap will be modified by the 
allocated clusters).

Lock runlist of $Bitmap system file (the contents of which contain the 
bitmap) for reading so the on-disk physical location can be determined.

If the above fails then re-lock the runlist of $Bitmap for writing and 
lock mft record of $Bitmap system file and load in the runlist of the 
bitmap, the unlock the mft record, unlock the runlist of $Bitmap.

Load the $Bitmap data and allocate clusters in the bitmap.

Unlock lcnbmp_lock.

Update the runlist of the file being extended with the newly allocated 
clusters.

Lock the mft record of the file being extended and update the mft record 
with the new allocations.

Unlock the mft record and the runlist of the file that was extended.

So yes lock dependencies are inverted the validator complains.  But they 
are inverted in a special way that is safe.

Is the above description sufficient for you to fix it?

The mftbmp_lock works simillarly as above but instead of allocating 
clusters we are allocating an mft record, the locking sequence is the 
same though just substitute s/lcnbmp_lock/mftbmp_lock/ and s/cluster 
allocation/mft record allocation/.

Extending the mft in turn can require the mft itself to be extended which 
will take the lcnbmp_lock, thus mftbmp_lock nests outside the lcnbmp_lock 
and that should never be violated so the validator should be at least 
happy with that bit.  (-;

Sorry ntfs is that locking evil!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
