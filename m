Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWFJIsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWFJIsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWFJIsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:48:37 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:27079 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750762AbWFJIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:48:36 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 10 Jun 2006 09:48:29 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
 detected!
In-Reply-To: <20060610075954.GA30119@elte.hu>
Message-ID: <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
 <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu>
 <1149764032.10056.82.camel@imp.csi.cam.ac.uk> <20060608112306.GA4234@elte.hu>
 <1149840563.3619.46.camel@imp.csi.cam.ac.uk> <20060610075954.GA30119@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > The normal access pattern (B) where the runlist lock is always taken 
> > first.  And the mft record lock is taken second and only if the 
> > runlist is incomplete in-memory.
> > 
> > Of course on file modification, this is also the case, the runlist 
> > lock is taken first, then the mft record lock is taken and thus both 
> > the runlist and the inode can be updated with the new data (e.g. on a 
> > file extend).
> 
> thanks for the detailed explanation!

You are welcome.  NTFS is not exactly simple code and its locking is 
certainly not simple at all...

> I have annotated the code for the lock validator as much as i could, by:
> 
> - excluding ntfs_fill_super() from the locking rules,
> 
> - 'splitting' the MFT's mrec_lock and runlist->lock locking rules from 
>   the other inodes's locking rules,
> 
> - splitting the mrec_lock rules of extent inodes. (We map them
>   recursively while having the main inode mft record mapped. The nesting
>   is safe because inode->extent_inode is a noncircular relation.)
 
Sounds good!

> Still there seems to be a case that the validator does not grok: 
> load_attribute_list() seems to take the lock in the opposite order from 
> what you described above. What locking detail am i missing? [let me know 
> if you need all dependency events leading up to this message from the 
> validator]

Ah, yes, I had completely forgotten about that one, sorry.  This is 
another special case I am afraid.  Note how there are two runlists in an 
ntfs_inode.  We have:

ntfs_inode->runlist - This is the runlist for the inode data (for files 
this is the actual file data, for directories this is the directory 
B-tree, for index inodes this is the view index B-tree, for attribute 
inodes this is the attribute data).  This is what we have been dealing 
with before and what you have already solved by the sounds of things.

ntfs_inode->attr_list_rl - This is the runlist for the attribute list 
attribute of a base inode, i.e. it does not exist for index inodes or 
attribute inodes, it only exists for regular files and directories (and 
once we implement symlinks, sockets, fifos and device special files for 
those, too).  Further it only exists for inodes which have extent inodes 
and those are definitely in the minority but that is irrelevant as we have 
to support it none the less.  The attribute list attribute is a linear 
list or better perhaps to describe it as an array of variable size 
records, and each record describes and attribute belonging to the inode, 
which part of the attribute this attribute extent describes and where 
(i.e. in which mft record) this attribute extent belongs.  As such the 
attribute list attribute is only ever used when the mft record is mapped 
and an attribute is being looked up and also when a new attribute is 
created or an attribute is deleted or an attribute is truncated in which 
case the attribute list must be updated.  In all those cases the mft 
record is mapped.  Thus yes in this case the locking is inverted but that 
is because ntfs_inode->attr_list_rl->lock will always be taken with the 
mft record lock held.

I think the lock validator has the problem of not knowing that there are 
two different types of runlist which is why it complains about it.

Another thing to note is that load_attribute_list() is only called at 
iget() time thus we have exclusive access to the inode so it is a special 
case in any case.

And at present the driver in the kernel does not ever modify the attribute 
list attribute (and hence does not modify its runlist either) thus the 
only time the attr_list_rl is used is at load_attribute_list() time.

Something I am noticing now is that given that the attribute list runlist 
is only ever accessed under the mft record lock it is in fact pointless to 
lock it at all as the mft record lock is an exclusive lock.

The reason I never noticed this before is that I started off having the 
mft record lock being a read-write lock so multiple processes could be 
read-accessing the mft record so I wanted to keep the attribute list 
locked as well.

I have to look through the code to make sure but I think we could simply 
not take the runlist lock when accessing the attr_list_rl and then the 
problem would go away.  The only thing is that when we start modifying the 
runlist attr_list_rl we will use functions that are common for the two 
runlist code paths and they may take the lock.  Not a huge problem as they 
can always use the _nolock version.

So I suggest if it is easy, to teach the validator to not complain about 
this as that is the order the locking is meant to happen and it is not 
circular because it is two different types of runlist being locked.  That 
gives me the possibility of later on turning the mft record lock back into 
a read-write lock to improve parallelism when reading data on ntfs...

If that is hard then you or I (or both) need to investigate whether the 
current driver can really simply not take the runlist lock when accessing 
attr_list_rl i.e. we need to make sure it always happens under the 
protection of the mft record lock and then the problem will go away.

Best regards,

	Anton

> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> ls/2581 is trying to acquire lock:
>  (&rl->lock){----}, at: [<c01c1f5b>] load_attribute_list+0xfb/0x3c0
> 
> but task is already holding lock:
>  (&ni->mrec_lock){--..}, at: [<c01d50c5>] map_mft_record_type+0x55/0x2d0
> 
> which lock already depends on the new lock,
> which could lead to circular locking dependencies.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&ni->mrec_lock){--..}:
>        [<c01394df>] lock_acquire+0x6f/0x90
>        [<c0346183>] mutex_lock_nested+0x73/0x2a0
>        [<c01d5e43>] map_mft_record+0x53/0x2c0
>        [<c01c54f8>] ntfs_map_runlist_nolock+0x3d8/0x530
>        [<c01c5bc1>] ntfs_map_runlist+0x41/0x70
>        [<c01c1929>] ntfs_readpage+0x8c9/0x9b0
>        [<c0142ffc>] read_cache_page+0xac/0x150
>        [<c01e212d>] ntfs_statfs+0x41d/0x660
>        [<c0163254>] vfs_statfs+0x54/0x70
>        [<c0163288>] vfs_statfs64+0x18/0x30
>        [<c0163384>] sys_statfs64+0x64/0xa0
>        [<c0347dcd>] sysenter_past_esp+0x56/0x8d
> 
> -> #0 (&rl->lock){----}:
>        [<c01394df>] lock_acquire+0x6f/0x90
>        [<c0134c8a>] down_read_nested+0x2a/0x40
>        [<c01c1f5b>] load_attribute_list+0xfb/0x3c0
>        [<c01d323e>] ntfs_read_locked_inode+0xcee/0x15d0
>        [<c01d4735>] ntfs_iget+0x55/0x80
>        [<c01db3da>] ntfs_lookup+0x14a/0x740
>        [<c01736b6>] do_lookup+0x126/0x150
>        [<c0173ef3>] __link_path_walk+0x813/0xe50
>        [<c017457c>] link_path_walk+0x4c/0xf0
>        [<c0174a2d>] do_path_lookup+0xad/0x260
>        [<c0175228>] __user_walk_fd+0x38/0x60
>        [<c016e3be>] vfs_lstat_fd+0x1e/0x50
>        [<c016e401>] vfs_lstat+0x11/0x20
>        [<c016ec04>] sys_lstat64+0x14/0x30
>        [<c0347dcd>] sysenter_past_esp+0x56/0x8d
> 
> other info that might help us debug this:
> 
> 2 locks held by ls/2581:
>  #0:  (&inode->i_mutex){--..}, at: [<c0346108>] mutex_lock+0x8/0x10
>  #1:  (&ni->mrec_lock){--..}, at: [<c01d50c5>] map_mft_record_type+0x55/0x2d0
> 
> stack backtrace:
>  [<c0104bf2>] show_trace+0x12/0x20
>  [<c0104c19>] dump_stack+0x19/0x20
>  [<c0136ef1>] print_circular_bug_tail+0x61/0x70
>  [<c01389ff>] __lock_acquire+0x74f/0xde0
>  [<c01394df>] lock_acquire+0x6f/0x90
>  [<c0134c8a>] down_read_nested+0x2a/0x40
>  [<c01c1f5b>] load_attribute_list+0xfb/0x3c0
>  [<c01d323e>] ntfs_read_locked_inode+0xcee/0x15d0
>  [<c01d4735>] ntfs_iget+0x55/0x80
>  [<c01db3da>] ntfs_lookup+0x14a/0x740
>  [<c01736b6>] do_lookup+0x126/0x150
>  [<c0173ef3>] __link_path_walk+0x813/0xe50
>  [<c017457c>] link_path_walk+0x4c/0xf0
>  [<c0174a2d>] do_path_lookup+0xad/0x260
>  [<c0175228>] __user_walk_fd+0x38/0x60
>  [<c016e3be>] vfs_lstat_fd+0x1e/0x50
>  [<c016e401>] vfs_lstat+0x11/0x20
>  [<c016ec04>] sys_lstat64+0x14/0x30
>  [<c0347dcd>] sysenter_past_esp+0x56/0x8d

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
