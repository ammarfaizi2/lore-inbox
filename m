Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rDflv154712>; Sun, 16 May 1999 08:39:23 -0400
Received: by vger.rutgers.edu id <S.rDeCJ154693>; Sun, 16 May 1999 06:53:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40213 "EHLO math.psu.edu") by vger.rutgers.edu with ESMTP id <S.rDY3D156232>; Sat, 15 May 1999 23:53:51 -0400
Date: Sun, 16 May 1999 00:40:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: linux-fsdevel@vger.rutgers.edu, linux-kernel@vger.rutgers.edu
Subject: [FYI][RFC] Way to deal with filesystems with jumping pieces of inodes (was Re: HPFS bug in lookup())
In-Reply-To: <Pine.LNX.3.96.990515232120.14004A-101000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.10.9905151840230.11400-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


[D'oh! It grew longer than I expected. Sorry. Originally it was going to be
a reply to email from Mikulas, but probably it's worth Cc'ing to lists.
Apologies for the head of the text - I've tried to give some explanation
of the context. Short summary: how to deal with filesystems that keep bits
and pieces of inode in a directory without excessive locking and races.]

	As we all know, decent and sane filesystems keep inode metadata out
of the directories.  The problem being: not all filesystems are sane or
even decent.  With respect to fs driver it means that we are going to have
a lot of potential races between the write_inode() method and *every*
namespace-modifying one.  Usual solutions involve a lot of locking, are
not too clean deadlock-wise and either heavily penalize write_inode() or
involve a lot of complications in namespace stuff (namei.c).
	I tried to construct a clean way to deal with those issues when
I did a FAT cleanup.  Situation with FAT had additional componenet of fun
- it has *no* out-of-directory metadata and that means that we have no
chance for even remotely sane iget().  Inumbers should stay constant for
the whole lifetime of in-core inode and that alone killed the idea of
using metadata location as inumber.  rename() could change it and we had
to reserve the directory entries of unlinked-but-still-open files.  As the
result FAT driver and derived filesystem drivers had extremely complicated
mess in directory/inode/namespace handling and contained both the rough
locking and really impressive collection of races.  During that Spring I
did a rewrite of directory/inode handling in FAT and massive cleanup of
msdosfs and VFAT namespace handling. Some fixes went into 2.2.x, the whole
thing is in 2.3.2.
	It seems that some parts of the aforementioned rewrite can be
useful for other filesystems, in particular for HPFS.  Here it comes:

	The main problem with keeping inode metadata in directories is that
VFS provides some protection from races, but it doesn't (and shouldn't) 
serialize write_inode() wrt namespace manipulations.  Said manipulations
are serialized within the same directory, but that's it.  write_inode()
may be called when the parent directory is in the middle of a change.
So some amount of serialization should be done within fs driver.
	Proposed solution is based on the following: VFS removes 'dirty' bit
on inode *before* the write_inode() is called.  So if mark_inode_dirty()
happens when write_inode() is still in progress we will get the same result
as if it would be called immediately after the write_inode() completion.
Suppose we can easily find an inode that owns given piece of in-directory
metadata.  Then we can use the following strategy:
	a) keep a per-fs spinlock.
	b) store the location of in-directory metadata in fs-specific
part of in-core inode (->u.foo_i.location)
	c) define two primitives: attach_inode(inode, location) and
detach_inode(inode).
	attach_inode(inode, pos) should grab the spinlock, set
inode->u.foo_i.location to pos and release the pinlock.
	detach_inode(inode) should grab the spinlock, set
inode->u.foo_i.location to some reserved value (0 seems to be a natural
choice) and release the spinlock.
	d) whenever the namespace-modifying operation is going to move
or delete a directory entry it should find whether it is owned by some
in-core inode (in many cases it will be immediately known to calling function)
and if it indeed is do detach_inode(inode);  If we are moving the entry
we should do attach_inode(inode, new_location); mark_inode_dirty(inode);
afterwards.
	e) write_inode() method should do the following:
		Write normal part of inode;
	     retry:
		pos = inode->u.foo_i.location;
		if (pos == DETACHED)
			return;
		bh = bread(dev, BLOCK_BY_LOCATION(pos), sb->s_blocksize);
		spin_lock(&spinlock);
		if (pos != inode->u.foo_i.location) {
			spin_unlock(&spinlock);
			brelse(bh);
			goto retry;
		}
		Put in-directory metadata to the right place of bh->b_data.
		spin_unlock(&spinlock);
		mark_buffer_dirty(bh, 1);
		brelse(bh);

How it works? First of all, with such strategy write_inode() is guaranteed to
put the in-directory metadata into the right place.  Since after the move
we are doing attach_inode() we are guaranteed that metadata *will* be written.
Notice that we don't search for in-directory metadata upon write_inode().
Which is *big* win in case of filesystems a-la HPFS.

	Potential penalty is in finding an in-core inode by the chunk of
metadata.  In case of relatively sane filesystems it can be done with
trimmed-down version of iget() that would return NULL instead of trying
to read the inode from disk.  Another possibility (the only possibility for
filesystems without decent inumbers) is more interesting and in principle
gives better performance.  It relies on another trick: shadow pointers to
inodes. Actually this technics may be useful not only here. There we go:

	You can safely keep references to in-core inode *not counting them
in ->i_count and not disturbing icache behaviour* if
	a) you provide ->clear_inode() method and forget all 'shadow'
references to inode as soon as foo_clear_inode(inode) is called.
	b) you must serialize all dereferencing of shadow references wrt
foo_clear_inode().
	c) to obtain a normal reference you should call igrab(foo) and it
will either give you a safe reference to the the same inode (i.e. increment
foo->i_count and return foo) or it will return NULL, in which case you should
act as if foo has been forgotten (see (a)).
	d) You should serialize calls of igrab() wrt foo_clear_inode().

	For example, if you want to keep a hash-table of inodes you can do it
in the following way:
	* hold a spinlock whenever you are doing a search or modification
	  of said hash.
	* start foo_clear_inode(inode) with removing the inode from hash
	  (grabbing the same lock, indeed).
	* in the very end of hash search (before releasing the spinlock)
	  pass the result of search (if something was found, indeed) to
	  igrab() and if igrab() will return NULL consider it as "not found".
With obvious modifications it can be used to deal with arbitrary data
structures. 

	Why is it tricky?  Well, we don't want to disturb icache behaviour
(i.e. fiddle with inode reusing, etc.), so we can't protect references with
i_count.  The whole point of the exercise is to allow icache to take inodes
from us whenever it normally would.  So we have to do something to avoid
dangling references.
	Why does it work?  Icache always calls ->clear_inode() before reusing
the thing.  So the whole affair was the matter of setting I_FREEING in
inode->i_state when the call of clear_inode() becomes inevitable (i.e. when
the thing can't be salvaged by iget() anymore).  igrab() was trivial -
essentially it checks for I_FREEING in ->i_state and either returns NULL
or increments ->i_count and returning its argument (it also has to grab
inode_lock, etc. - see details in fs/inode.c, the thing is a ten-liner).

	Application of the above to the search of inode by in-directory
metadata is trivial - we can use ->u.foo_i.location as hash index, make
{attach,detach}_inode() hash/unhash the thing and use the same spinlock
for all serialization needed (->write_inode, attach_inode, detach_inode and
hash search; ->clear_inode() should start from detach_inode() and it will
automatically give us needed protection).
	It is faster than icache search simply because the hash is smaller -
only inodes belonging to the fs driver in question.
	In many cases we simply know the in-core inode from the very beginning.
E.g. if we are doing rename() on FAT-derived filesystem we have the dentry
and inode *before* we've seen the directory entry. Non-trivial cases when
we really need to search may happen with filesystems a-la HPFS, where we
have to move directory entries of completely unrelated objects (HPFS keeps
directories as B-trees).
	Notice that search through dcache (after all, we know the parent) is
not enough here.  Consider the following scenario: inode of /foo/bar is dirty.
Something invoked shrink_dcache().  Dentry of /foo/bar is tossed away.  iput()
is appiled to the inode.  Now suppose that some operation reshuffles /foo,
moving the directory entry of bar.  Since /foo/bar is no longer in dcache
we would miss the inode in question.  Fun, fun - it's right in the middle
of write_inode() and is going to write something into the old place in /foo.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
