Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRDPQhU>; Mon, 16 Apr 2001 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDPQhK>; Mon, 16 Apr 2001 12:37:10 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2901 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S131505AbRDPQgz>; Mon, 16 Apr 2001 12:36:55 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: adilger@turbolinux.com, phillips@nl.linux.org
Subject: Re: Ext2 Directory Index - File Structure
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010416163649Z92255-29165+15@humbolt.nl.linux.org>
Date: Mon, 16 Apr 2001 18:36:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 April 2001 14:40, you wrote:
> Daniel, you write (re indexed directories):
> > Superblock Feature Flag
> > -----------------------
> >
> > This is now incorporated.  I use the following code:
> >
> > 	if (!EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX))
> > 	{
> > 		lock_kernel();
> > 		ext2_update_dynamic_rev(sb);
> > 		EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX);
> > 		unlock_kernel();
> > 		ext2_write_super(sb);
> > 	}
> > 	new->u.ext2_i.i_flags |= EXT2_INDEX_FL;
>
> Why lock_kernel() calls and not lock_super()?  I would _think_ that
> file creation within the VFS was already protected with BKL, but you
> need to do lock_super(), because lock_kernel() can be dropped on
> context switch.  A typo in the email maybe?

I lifted the code directly from ext2_update_inode in ext2/inode.c.
I suppose I should looked at it more critically, but at least I wrote a
comment that it has to be looked at further.  The BKL does the job but
on SMP it's overkill, but is probably also inconsequential because it's
a once-per-life-of-filesystem operation.  Al Viro has rewritten the
superblock locking completely and is preparing patches for 2.5, so I
suppose we need to see what the new locking regime is going to be.  In
2.5 we can clean up all the update_dynamic_rev's at the same time. 

> > This is only done on the deferred-creation path since the other path
> > will be gone by beta time.
>
> Yes, it only makes sense to do this at initial dx root creation.

Actually, I do it at the time I set the EXT2_INDEX_FL and the dx root is
created later, on the theory that even the presence of the index flag is
something that fsck might be interested in.

> > Delete Performance
> > ------------------
> >
> > As we both noticed, delete performance for rm -rf is running
> > considerably behind create performance by a factor of 4 or so - worse,
> > it's running behind non-indexed Ext2 :-O
> >
> > There is no valid reason for this in the index code.  The indexed delete
> > dirties the same things as a non-indexed delete, so it's not clear to me
> > why we see a lot of extra disk activity with the indexed code.
>
> Possibilities:
> - extra cache footprint for code (unlikely cause)
> - extra block reads because of index blocks
> -

The second possibility is unlikely too, since we see the slowness even
when the directory has only a single block.  I'm hunting for your third
possiblity now.

I can think of quite a few ways to chase this but they are all
time-consuming, so I'm taking even more time to read the code and settle
on my line of attack.  I strikes me that the Linux Trace Toolkit is
something I want to be using right now, but most likely not on my
laptop.  I don't know, I think I will get a copy and see if there's any
chance it will run under UML.

I need some way of finding out where all the extra disk events are
coming from.

> > Redundant Existence Test
> > ------------------------
> >
> > The inner loop of add_ext2_entry has traditionally included a test for
> > an existing entry with the same name as the new entry, in which case an
> > error exit is taken:
> >
> > 	err = -EEXIST;
> > 	if (ext2_match (namelen, name, de))
> > 		goto err_out;
> >
> > This test is entirely redundant as can be seen from this code snippet
> > from fs/namei.c, open_namei:
> >
> > 980         dentry = lookup_hash(&nd->last, nd->dentry);
> > [...]
> > 989         /* Negative dentry, just create the file */
> > 990         if (!dentry->d_inode) {
> > 991                 error = vfs_create(dir->d_inode, dentry, mode);
> > [...]
> > 1000                goto ok;
> > 1001         }
> > 1002
> > 1003         /*
> > 1004          * It already exists.
> > 1005          */
> >
> > There is always an explicit search for the entry before creating it
> > (except in the case where we find a deleted entry in the dcache - then
> > the search can be safely skipped)  Thus, ext2's create never gets called
> > when the name already exists.  Worse, the ext2 existence test is not
> > reliable.  If there is a hole in the directory big enough for the new
> > entry then add_ext2_entry will stop there and not check the rest of
> > the directory.   So the test in add_ext2_entry adds no extra protection,
> > except perhaps helping verify that the code is correct.  In this case,
> > an assertion would capture the intent better.  On the other hand, it
> > does cost a lot of CPU cycles.
>
> Possibly it is a holdout from (or extra check for) some sort of locking
> race condition?  ISTR that the dentry cache _should_ protect us from a
> dirent being created twice (that would also corrupt the dentry cache).
>
> However, if it _was_ some sort of race avoidance, the existence check
> _would_ be enough.  Reasoning is that if we had two processes trying
> to create the same dirent then one of them would find "the spot" big
> enough to hold the new entry first, and the second process would _have_
> to pass this spot in order to find another place to put the dentry
> (assuming no other dentry was deleted in the meantime).  The check
> would be equally valid (if it is needed at all, mind you) in the index
> code because we would always search the same hash bucket to find the
> new home of the dentry.  In fact, in the indexed code we would be much
> more likely to find duplicate dentries because the hashing would always
> place the duplicate dentries into the same hash bucket.

Sorry, I should not have snipped out the locking above.  The
test/create is serialized by ->i_sem: 

979         down(&dir->d_inode->i_sem);
980         dentry = lookup_hash(&nd->last, nd->dentry);
[...]
989         /* Negative dentry, just create the file */
990         if (!dentry->d_inode) {
991                 error = vfs_create(dir->d_inode, dentry, mode);
992                 up(&dir->d_inode->i_sem);

Out of interest I'll check to see how far back this goes.  (lksr.org has
a full history of kernels in cvs; bitkeeper.com has something similar -
Larry McVoversion

and I suppose I should use a dash between the patchname and
kernelversion to be consistent.  I'll do that on the next version and
hopefully that will be the last time I change my patch naming scheme. 
(Drifting offtopic here)  I guess there are probably more patch naming
schemes than there are hackers, since the natural tendency is to come up
with a new improvement to the naming scheme with each patch revision. 
So the lifetime of a patch naming scheme tends towards 1, such a system
being approximately as useful as a read-once cache.
--
Daniel
