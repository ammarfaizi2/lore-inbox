Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbRFKFc7>; Mon, 11 Jun 2001 01:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263415AbRFKFct>; Mon, 11 Jun 2001 01:32:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30891 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263407AbRFKFch>;
	Mon, 11 Jun 2001 01:32:37 -0400
Date: Mon, 11 Jun 2001 01:32:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCHes] fs/super.c stuff
Message-ID: <Pine.GSO.4.21.0106110055270.24249-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. It works here(tm). I'm sending first 10 chunks - about 70% of locking
changes. That's a good intermediate point and I'd rather avoid doing too
large steps.

Contents (patches will go in separate postings):

1, Eliminates mnt_instances and s_mounts. Instead of it we add new field to
struct super_block - s_active. Number of vfsmounts for given superblock,
i.e. number of entries in old s_mounts. Right now all accesses are serialized
by mount_sem, but later we'll need it to be atomic_t.

2. Better handling of s_active. Instead of incrementing it just when we
attach a vfsmount we do that beforehand and decrement if get_sb_... fails.

3. blkdev_put(bdev, BDEV_FS) doesn't touch superblock anymore. Current
callers don't need that (nothing to touch - it's either final kill_super()
or failed read_super()) and having it non-interfering with fs structures
gives us more freedom for get_sb_bdev().

4. pure cosmetics - fs.h contains an extern for function that doesn't exist
(put_super(kdev_t)). Removed.

5. instead of passing sb->s_dev to remove_dquot_ref() and doing get_super()
there we pass sb itself. While we are at it invalidate_dquots() is made
static - nothing outside of dquot.c calls it.

6. drop_super() added. At that stage - empty, we just add calls to balance
those of get_super().

7. First serious part.
	* we add a spinlock (sb_lock) that protects super_blocks list.
	* we add a reference counter to struct super_block. ->s_count.
At that stage we don't use it - only maintain correct value. Logics is
the same as for mm_struct - each temporary reference contributes 1,
all permanent references (from vfsmounts) are lumped together. It's an
int - all accesses are protected by sb_lock.
	At that stage we rely on mount_sem to handle the moments when
we turn a temporary reference into permanent one. That will change,
but we need to kill the "reuse" branch of get_empty_super() to do that.
And that requires s_count already in place.

8. _Now_ we can get to real stuff.
	* kill_super() removes dying superblock from the super_blocks list.
	* when s_count drops to zero we free the superblock.

9. We are done with "reuse" branch of get_empty_super(). The rest (allocation
of new one) is renamed in alloc_super(). Insertion into the super_blocks
is moved into (the only) caller - read_super().

10. Now we can solve most of the problems with get_super()/umount().
get_super() does down_read(&s->s_umount (and drop_super() - up_read()).

>From that point it's more or less easy ride - we need to reorganize
get_sb_...() to have exclusion between mount() and get_super() callers,
but now we have everything we need for that.  I would rather submit that
part separately. All really evil stuff is done - in a sense it's the
nastiest point of sequence. Basically, the rest will consist of cleanups.

I've tried to carve the thing into edible chunks - if you find something
too large, please, tell. Patches themselves will go in followups to this
posting, numbered from 1 to 10. They are incremental to each other, starting
at 2.4.6-pre2.
							Cheers,
								Al

