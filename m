Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRDOTxM>; Sun, 15 Apr 2001 15:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132797AbRDOTxD>; Sun, 15 Apr 2001 15:53:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30522 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132796AbRDOTwp>; Sun, 15 Apr 2001 15:52:45 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: adilger@turbolinux.com, phillips@nl.linux.org
Subject: Re: Ext2 Directory Index - File Structure
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010415195233Z92259-21887+33@humbolt.nl.linux.org>
Date: Sun, 15 Apr 2001 21:52:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas, you wrote:
> Daniel, you write:
> > So then, the obvious candidate would be:
> >
> > 	#define EXT2_FEATURE_RO_COMPAT_DIR_INDEX        0x0004
> >
> > which was formerly EXT2_FEATURE_RO_COMPAT_BTREE_DIR.
>
> Actually not.  We should go with "EXT2_FEATURE_COMPAT_DIR_INDEX 0x0008"
> because the on-disk layout is 100% compatible with older kernels, so
> no reason to force read-only for those systems.  I'm guessing Ted had
> put RO_COMPAT_BTREE_DIR in there in anticipation, but it was never used.

Whoops, my mind came to one conclusion and my mouse to another: I cut
and pasted Ted's original define without noticing the RO in it.  Yes,
it would have been RO as Ted  conceived it due to the addition
of a new class of filesystem metadata (btree nodes).  He suggested
keeping the normal file index blocks as well, which would have given it
RO compatibility, which is what got me thinking about this design.  As
it turns out, the page cache erases the advantage of absolute indexing
in terms of access time, and even with the buffer cache the overhead is
not large compared to the savings.

That reminds me, putting this code back into the page cache is gradually
working its way back up my to-do list.  My first attempt to do that was
not very satisfying.  The problems I ran into were:

  - Locking issues.  The page cache locks in units of pages; the
    directory index works in units of blocks that do not group nicely
    into pages.  We do not lock buffers at all when we read/write them,
    but in the current page cache regime we are supposed to with pages.
    Since I operate on up to 4 non-contiguous blocks simultaneously this
    turns into a major hassle, and at least one problem is quite
    difficult: suppose you are splitting a leaf.  You have a lock on the
    page the original lives on and you allocate a new block at the end
    of the file for the new one.  Is that new block on the same page as
    the original or not?  If it is, you'd better not try to lock again
    or you will deadlock.  So you skip the lock, and now you have to
    remember that you skipped the lock so you don't unlock the page
    twice.  This is just a simple example, when you throw index blocks
    in with the leaf blocks it can get quite a lot messier.

  - The "prepare/commit bracket".  In the current regime you prepare a
    page for writing by calling a VFS function that maps the page to
    file blocks and reads some of them if necessary.  With buffers, you
    use the same function (bread) to prepare the buffer for writing as
    you do for reading.  Often, you will have read the buffer anyway, so
    there's nothing more to do there.  This doesn't sound like a huge
    difference, but actually it is.  In the case of mark_buffer_dirty
    you are acting on the buffer at one point in its lifetime; with
    prepare/commit you have to worry about a linear span of a page's
    life.  This can get especially messy if the span crosses a few
    conditionals, which it often does.

  - Extra parameters.  Because you are typically operating on a piece of
    a page you have to keep not only a pointer to the struct page, but
    something to tell you which part of the page you were working on,
    so instead of having one data item to pass around you have 2-3, and
    the chance of them getting out of sync increases from "0" to
    "probable".  If you examine directory code you'll see I'm keeping a
    pointer not only to each buffer, but to its b_data as well, which
    would normally be a stupid thing to do - I kept this extra cruft in
    there when I converted the code back from the page cache to the
    buffer cache, in order to ease the pain of the next try at page
    cache conversion.  Combined with the prepare/commit bracket, you now
    have to track 4-6 data items over a span of code fs 1 data item at
    one point.  The combinatorics are starting to kick in here.  Sure,
    it's all doable, but at what cost to readability?

  - Granularity.  Besides the locking issue, it is just extra work to
    keep track of which logical block lives on which page.

  - Interface definition issues.  Nobody has written down a definition
    of the page cache interface in terms of operations, states, locking
    rules, etc.  There are fragments of information here and there but
    you really have to dig for them and it's a practical certainty that
    you will miss some.  You pretty much just have to read the code on
    this one, and even then there are a lot of subtleties that can be
    easily missed.

All these problems could have been solved, but the fact is, I put quite
a lot of work into the code and the result was distressingly unstable,
the reasons for this being not at all obvious.  On top of that, I found
that the code was getting quite tied to all the little bookkeeping
issues that came up, to the point where I wasn't making a lot of
progress developing the features I wanted.  And to add insult to injury,
I just wasn't very proud of the way the code looked on the page, and
didn't see a way clear to cleaning it up.

But the fact is, there remain very good reasons for dealing with these
issues.  For example, it is wasteful to have the same file block
referenced by both the page cache and buffer cache, which can easily
happen if a directory is deleted and its blocks get reallocated to a
regular file.  It is also annoying to have to keep track of the states
of both blocks and pages throughout the VFS, and we would at least make
some progress towards consolidating code paths.  So there is no question
about whether to do this or not.  (Let alone the fact that Linus has so
decreed;-)

Having had time to think about it and discuss the problem with a few
people, I have a pretty good idea how to proceed for my page cache
version, take two.  In San Jose last month Stephen Tweedie suggested
that instead of directly on pages, I operate on the buffer attached to
the page.  Al Viro hated this idea but was willing to admit that it
would probably work.  Notwithstanding the need to convince Al of the
merits, I now plan to try this and see how it works.  If it does work
reliably I will be able to keep essentially the same control flow and
data design I have now, without obfuscation, and I will also be able to
get the efficiency advantage of the page cache.  (Operating on the
buffers underlying a page does not mean that I am actually using the
buffer cache - the buffer cache is accessed through a separate hash
table.)

A drawback of operating on the underlying buffers of a page is that we
fail to hide details of how the page cache works.  However, it should be
clear from above that we fail to hide those details anyway, and in a way
that really hurts the readability/maintainability of the code.

By the way, did you mean:

	#define EXT2_FEATURE_COMPAT_DIR_INDEX 0x0002

since there is only one other COMPAT feature currently defined?

> > Other than declaring it, I gather I have to set this flag in the
> > superblock every time I set the EXT2_INDEX_FL in an inode.  Is that it?
>
> Yes.  If you do like the LARGE_FILE code, it may be worthwhile to check
> whether it is already set to avoid writing out the superblock.  However,
> in most cases the superblock is already dirty after block allocation, so
> it is no extra overhead in those cases.

OK, this revision of the patch incorporates the COMPAT handling, I'd
appreciate your comments.

> > Yes, I will mask of 8 bits of the block index and this will be more than
> > enough to support the planned coalesce function.  I can't think of any
> > other use for these bits than coalescing - can you?
>
> Not at the moment, but then again, I probably couldn't have foreseen any
> of the other requirements either.  If we don't need them for indexed
> directories, we may as well save them for a future (unspecified) use.
> Start using them from the high bits down, so that we allow the directory
> size to grow (if needed) in the future.

Yes, that was my plan.

> > > So then bailing out of index mode (on error) to go into linear search
> > > mode is as easy as clearing the directory index flag and reading the
> > > directory from the start.
> >
> > Are you sure we want to clear the index flag?  The user has probably
> > just booted the wrong kernel.  And yes, we are talking about a
> > strategically placed goto here, after a little cleanup.
>
> OK, no need to clear the index flag under normal circumstances.  We
> simply fall back to linear search on unknown hash code, etc.  But
> with the hash version byte and dx_root size we should _know_ when we
> have bogus data.  Whether we clear the index flag or not in this case
> is up for debate.  I was thinking that it would force us into the
> "safer" code path of linear search.  However, clearing the index flag
> may lose some state (if we decide to allow the admin to set un-indexed
> but larger than 1 block directories).  In that case, how do we make
> e2fsck create indexes for old filesystems when the DIR_INDEX compat flag
> is turned on in the superblock?

For now I will leave the index flag untouched.

Modified Header Info
--------------------

The root_info has been rearranged along the lines you suggested, to gain
the ability to detect the case where a pre-2.2 kernel has modified an
indexed directory without clearing the inode's index flag:

	struct dx_root
	{
		struct fake_dirent fake1;
		char dot1[4];
		struct fake_dirent fake2;
		char dot2[4];
		struct dx_root_info
		{
			le_u32 reserved_zero;
			u8 hash_version; /* 0 now, 1 at release */
			u8 info_length; /* 8 */
			u8 indirect_levels;
			u8 unused_flags;
		}
		info;
		struct dx_entry	entries[0];
	};

Deferred Index Creation
-----------------------

The current patch incorporates the deferred index creation feature. 
For now, this can be enabled/disabled by the defining/undefing the
DX_DEFER symbol (defaults to on).  Evenhis can be enabled/disabled by the defining/undefing the
DX_DEFER symbol (defaults to on).  Eventually the index creation will
always be deferred and the original code path removed, after some
testing and perhaps some benchmarking of the deferred vs always-indexed
cases.  It would be nice to know what the overhead of the index is on
single-block directories.

It would also be nice to know whether my theory that the index begins to
win when the directory grows over one block is in fact correct.  If I'm
wrong then I may have to defer the index creation by more than one
block, work I'd prefer to avoid.

Developing the deferred index creation took longer than I expected, but
then, I expected that. :-/  This feature sits cross-wise in the code
path, jumping from across from the non-indexed to the indexed entry
creation path.  A batch of index-specific local data had to be moved
into common scope, and as expected, making the directory look as if the
index had always been there was a little messy.

The compiler blindsided me with a surprise union of local data
allocation in different blocks, causing rarely-occurring stack overflows.
My solution to this was to develop a longer piece of custom code that
uses less stack, something I had to do in the leaf-splitting part of the
code earlier.  An alternative and perhaps cleaner solution is the break
the memory-using parts out into separate functions so that the compiler
doesn't have the option of goofing up in this way, so I left the
original, overflow-causing code in as an ifdef for now.

This feature now seems to be stable, though I haven't tested it under a
wide variety of conditions.

Superblock Feature Flag
-----------------------

This is now incorporated.  I use the following code:

	if (!EXT2_HAS_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX))
	{
		lock_kernel();
		ext2_update_dynamic_rev(sb);
		EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_DIR_INDEX);
		unlock_kernel();
		ext2_write_super(sb);
	}
	new->u.ext2_i.i_flags |= EXT2_INDEX_FL;

It looks like there is a common factor in there that should be used
throughout the ext2 code.

This is only done on the deferred-creation path since the other path
will be gone by beta time.

Delete Performance
------------------

As we both noticed, delete performance for rm -rf is running
considerably behind create performance by a factor of 4 or so - worse,
it's running behind non-indexed Ext2 :-O 

There is no valid reason for this in the index code.  The indexed delete
dirties the same things as a non-indexed delete, so it's not clear to me
why we see a lot of extra disk activity with the indexed code. 

I'm a little hampered in tracking this down since I do not have a test
machine at the moment, just my laptop and my firewall, neither of which
is available for booting hacked kernels.  So I'd appreciate it if
somebody else wants to jump in here.  What we need to do is put in
tracing code to find out why excessive numbers of block writes are
taking place.

Since I have to guess at this point, I guess that we are triggering some
fringe behavior of the buffer LRU, possibly caused by interaction with
page-oriented VFS code.  If so, it's likely the behavior was introduced
in the pre-2.4 series and I could test this by preparing a patch for the
2.2 series.

For now, I'll just assume the lotus position and contemplate the code.

Redundant Existence Test
------------------------

The inner loop of add_ext2_entry has traditionally included a test for
an existing entry with the same name as the new entry, in which case an
error exit is taken:

	err = -EEXIST;
	if (ext2_match (namelen, name, de))
		goto err_out;

This test is entirely redundant as can be seen from this code snippet
from fs/namei.c, open_namei:

980         dentry = lookup_hash(&nd->last, nd->dentry);
[...]
989         /* Negative dentry, just create the file */
990         if (!dentry->d_inode) {
991                 error = vfs_create(dir->d_inode, dentry, mode);
[...]
1000                goto ok;
1001         }
1002 
1003         /*
1004          * It already exists.
1005          */

There is always an explicit search for the entry before creating it
(except in the case where we find a deleted entry in the dcache - then
the search can be safely skipped)  Thus, ext2's create never gets called
when the name already exists.  Worse, the ext2 existence test is not
reliable.  If there is a hole in the directory big enough for the new
entry then add_ext2_entry will stop there and not check the rest of 
the directory.   So the test in add_ext2_entry adds no extra protection,
except perhaps helping verify that the code is correct.  In this case,
an assertion would capture the intent better.  On the other hand, it
does cost a lot of CPU cycles. 

For now I have removed the existence test from both the indexed and
non-indexed paths.

With the directory index it becomes attractive to combine the existence
test with the entry creation and this would come almost for free: after
a suitable place has been found for the new entry the rest of the block
has to be searched for an entry of the same name, and if the name's hash
value continues in the next block(s) those blocks have to be checked
too, the latter test being needed very infrequently.  So in exchange for
20-30 new lines of code we get a significant performance boost.   A
similar argument applies to unlink.  The only difficulty is, there is
currently no internal interface to support this, so I'll just note that
it's possible.

Status
------

Funnily enough, all the same items remain on my to-do list as last week,
in fact it got longer.  However, one item from the future work list is
now done: 

  - Defer index creation until 1st block full

And several items were taken care of that weren't on the list:

  - Add COMPAT flag handling
  - Rearrange header info for forward-compatibility with 2.0 series
  - Cleaned up the non-indexed create path, merged the common parts
    with the indexed path.

Quite a few small cleanups have been done in preparation for a new
attack on the page cache problem. 

The patch is still pre-alpha, until the work on the hash function is
complete, and until you run out of objections to the on-disk format :-)

To Do
-----

  - Finalize hash function
  - Test/debug big endian
  - Incorporate more of AV's cleaned up dir/namei code
  - Convert to page cache (take two)
  - Fail gracefully on random data

Future Work
-----------

  - Generalize to n level index
  - Coalesce on delete

The Patch is Available At
-------------------------

    http://kernelnewbies.org/~phillips/htree/dx.testme.2.4.3-2

To apply:

    cd /your/kernel/source
    patch -p0 </the/patch

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo

Everybody: the invitation for testing remains open.

--
Daniel
