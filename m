Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132870AbRDPG7r>; Mon, 16 Apr 2001 02:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDPG71>; Mon, 16 Apr 2001 02:59:27 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:59643 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132867AbRDPG7S>; Mon, 16 Apr 2001 02:59:18 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104160658.f3G6wL6s019012@webber.adilger.int>
Subject: Re: Ext2 Directory Index - File Structure
In-Reply-To: <20010415195233Z92259-21887+33@humbolt.nl.linux.org>
 "from Daniel Phillips at Apr 15, 2001 09:52:33 pm"
To: Daniel Phillips <phillips@nl.linux.org>
Date: Mon, 16 Apr 2001 00:58:20 -0600 (MDT)
CC: adilger@turbolinux.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, you write (re indexed directories):
> Superblock Feature Flag
> -----------------------
> 
> This is now incorporated.  I use the following code:
> 
> 	if (!EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX))
> 	{
> 		lock_kernel();
> 		ext2_update_dynamic_rev(sb);
> 		EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX);
> 		unlock_kernel();
> 		ext2_write_super(sb);
> 	}
> 	new->u.ext2_i.i_flags |= EXT2_INDEX_FL;

Why lock_kernel() calls and not lock_super()?  I would _think_ that
file creation within the VFS was already protected with BKL, but you
need to do lock_super(), because lock_kernel() can be dropped on
context switch.  A typo in the email maybe?

> It looks like there is a common factor in there that should be used
> throughout the ext2 code.

Yes, may be worthwhile to have a little helper function do this.

> This is only done on the deferred-creation path since the other path
> will be gone by beta time.

Yes, it only makes sense to do this at initial dx root creation.

> Delete Performance
> ------------------
> 
> As we both noticed, delete performance for rm -rf is running
> considerably behind create performance by a factor of 4 or so - worse,
> it's running behind non-indexed Ext2 :-O 
> 
> There is no valid reason for this in the index code.  The indexed delete
> dirties the same things as a non-indexed delete, so it's not clear to me
> why we see a lot of extra disk activity with the indexed code. 

Possibilities:
- extra cache footprint for code (unlikely cause)
- extra block reads because of index blocks
- 

> Redundant Existence Test
> ------------------------
> 
> The inner loop of add_ext2_entry has traditionally included a test for
> an existing entry with the same name as the new entry, in which case an
> error exit is taken:
> 
> 	err = -EEXIST;
> 	if (ext2_match (namelen, name, de))
> 		goto err_out;
> 
> This test is entirely redundant as can be seen from this code snippet
> from fs/namei.c, open_namei:
> 
> 980         dentry = lookup_hash(&nd->last, nd->dentry);
> [...]
> 989         /* Negative dentry, just create the file */
> 990         if (!dentry->d_inode) {
> 991                 error = vfs_create(dir->d_inode, dentry, mode);
> [...]
> 1000                goto ok;
> 1001         }
> 1002 
> 1003         /*
> 1004          * It already exists.
> 1005          */
> 
> There is always an explicit search for the entry before creating it
> (except in the case where we find a deleted entry in the dcache - then
> the search can be safely skipped)  Thus, ext2's create never gets called
> when the name already exists.  Worse, the ext2 existence test is not
> reliable.  If there is a hole in the directory big enough for the new
> entry then add_ext2_entry will stop there and not check the rest of 
> the directory.   So the test in add_ext2_entry adds no extra protection,
> except perhaps helping verify that the code is correct.  In this case,
> an assertion would capture the intent better.  On the other hand, it
> does cost a lot of CPU cycles. 

Possibly it is a holdout from (or extra check for) some sort of locking
race condition?  ISTR that the dentry cache _should_ protect us from a
dirent being created twice (that would also corrupt the dentry cache).

However, if it _was_ some sort of race avoidance, the existence check
_would_ be enough.  Reasoning is that if we had two processes trying
to create the same dirent then one of them would find "the spot" big
enough to hold the new entry first, and the second process would _have_
to pass this spot in order to find another place to put the dentry
(assuming no other dentry was deleted in the meantime).  The check
would be equally valid (if it is needed at all, mind you) in the index
code because we would always search the same hash bucket to find the
new home of the dentry.  In fact, in the indexed code we would be much
more likely to find duplicate dentries because the hashing would always
place the duplicate dentries into the same hash bucket.

> With the directory index it becomes attractive to combine the existence
> test with the entry creation and this would come almost for free: after
> a suitable place has been found for the new entry the rest of the block
> has to be searched for an entry of the same name, and if the name's hash
> value continues in the next block(s) those blocks have to be checked
> too, the latter test being needed very infrequently.  So in exchange for
> 20-30 new lines of code we get a significant performance boost.   A
> similar argument applies to unlink.  The only difficulty is, there is
> currently no internal interface to support this, so I'll just note that
> it's possible.

Yes, I have thought about this as well.  If it is possible (I'm not sure
how, maybe a hashed per-super cache?) you could keep a pointer to the first
free entry in a directory, along with the dentry size and the mtime of the
directory.  You could use this cache at dentry insertion time (validating
it by size and directory mtime).  If the cache entry is invalid, fall back
to linear search again.

>     http://kernelnewbies.org/~phillips/htree/dx.testme.2.4.3-2

Good.  You have version numbers for the patches now...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
