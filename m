Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135960AbRD0AUO>; Thu, 26 Apr 2001 20:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135959AbRD0AUF>; Thu, 26 Apr 2001 20:20:05 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:13318 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135958AbRD0AT5>; Thu, 26 Apr 2001 20:19:57 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Ext2 Directory Index in page cache
Cc: adilger@turbolinux.com, viro@math.psu.edu
Message-Id: <20010427001656Z92338-1157+30@humbolt.nl.linux.org>
Date: Fri, 27 Apr 2001 02:16:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my second attempt at converting my ext2 indexing code to use the
page cache instead of the buffer cache.  The first attempt was a fairly
miserable failure for reasons I mentioned in an earlier post, and which
can be summed up as: the interface I tried to use didn't suit the
problem.  Or more specifically, if file objects don't break up evenly
into pages then trying to force them into that model can result in
complex, hard-to-debug code, which is what I got.

I concluded I needed some kind of abstraction, but what?  Instead of
reverting to the original buffer cache version, I converted my
unreliable page cache version to buffer operations, and in the process
backported some of Al Viro's streamlined page cache code to work in the
buffer cache.  I noticed that only deletions and name changes were
required, so the code got somewhat shorter.  Better, the converted
version worked reliably on the first try.

I didn't entirely discard the page cache code - I kept enough of the
extra mechanism around to make it pretty easy, I hoped, to take another
run at the page cache later, after I'd brought the code to a more mature
state.  At San Jose last month I mentioned my problem to Stephen Tweedie
and he suggested an entirely different approach, where I'd work with the
buffers underlying the page cache pages instead of directly with the
pages themselves.  I said I'd try it, it sounded good.

This week I finally got time to try that.  My plan was to try to keep
the interface as close as possible to the traditional
bread/geblk/mark_dirty etc. interface which I found to be quite robust
and easy to work with.  I first verified that mark_buffer_dirty and 
brelse can be used with page cache buffers, and they can - there are
examples in the buffer.c.  So I figured the quickest thing to do would
be to modify ext2_getblk to work through the page cache instead of the
buffer cache.  The new ext2_bread would then just call the new
ext2_getblk, and would be otherwise unchanged.

So for the new ext2_getblk, given an inode and a block number, the steps
are:

  - find or create the blocks's page cache page
  - add buffers to the page if necessary
  - select the correct buffer from the page's buffer list
  - call ext2_get_block to map the block to disk
  - for a newly created block, clear its buffer

Here's the code:

struct buffer_head *ext2_getblk_pcache (struct inode *inode,
	u32 block, int create, int *err)
{
	unsigned blockshift = inode->i_sb->s_blocksize_bits;
	unsigned blocksize = 1 << blockshift;
	unsigned pshift = PAGE_CACHE_SHIFT - blockshift;
	struct page *page = grab_cache_page(inode->i_mapping, block >> pshift);
	struct buffer_head *bh;
	if (!page->buffers)
		create_empty_buffers (page, inode->i_dev, blocksize);
	bh = page_buffer (page, block & ((1 << pshift) - 1));
	atomic_inc(&bh->b_count);
	UnlockPage(page);
	page_cache_release(page);
	if ((*err = ext2_get_block(inode, block, bh, create)))
		return NULL;
	if (!buffer_mapped(bh))
		return NULL;
	if (buffer_new(bh))
	{
		if (!buffer_uptodate(bh))
			wait_on_buffer(bh);
		memset(bh->b_data, 0, blocksize);
		mark_buffer_uptodate(bh, 1);
		mark_buffer_dirty_inode(bh, inode);
		clear_bit(BH_New, &bh->b_state);
	}
	return bh;
}

In testing this code I actually found a bug in the original ext2_getlk,
to wit, the BH_New bit was never being cleared.  How we've survived that
to this point isn't at all clear to me, but Al probably has it patched
by now.  With that bug out of the way I substituted the new functions
throughout the directory code and lo! everything worked the first try.
I then went on to clean up the code and structures to take advantage of
the fact that, with buffers you only need to keep a single pointer vs
two when you are working with a data region inside a page.

So now I have the directory index running in the page cache, and to do
that I just changed the names of two functions.  Well, it wasn't that
easy, but almost :-)

But what about performance?  In theory we should be running a little
faster because with the page cache, we don't have to look up each data
block via its index block(s): the page cache hash takes us straight to
the page we're interested in and we need to look into the index blocks
only if we find an unmapped block there.  When we need to access the
same block many times as with the directory code that adds up to a lot
of CPU saved, and did I mention that the directory operations are
CPU-bound?

What about performance versus full-page page-cache operations?  This
requires some speculation, because I never did implement the additional
mechanism that would have been necessary to make it work well when block
size does not match page size.  When page size does match block size it
looks like the two methods will be roughly comparable in execution
speed, since the sequence of operations is very similar.  When there are
several blocks on a page it looks like we might be doing more
hash lookups with the getblk-style code, but there is only one place in
the directory code - readdir - where we'd see the kind of sequential
access that might expose this overhead, and we can optimize that away
if we want to (the sequence brelse; ext2_bread is unecessary if the
next buffer is on the same page).

As far as code size goes, this didn't cost anything.  The existing
ext2_getblk/bread functions are used only in the directory code, meaning
that the originals can be discarded after we've had a chance to evaluate
the relative performance.

What about compatibility with other page cache code?  As far as I can
see we should be ok there - this style of access should mix and match
nicely with the full-page style of access, but caveat, I have not tried
this or analyzed it in great detail.  The obvious thing to do would be
to try mixing Al Viro's full-page style readdir with my getblk-style
entry creation and lookup.

Status
------

Today's patch is meant for testing and benchmarking.  There are
compilation switches to enable/disable:

  - indexing in general (CONFIG_EXT2_INDEX)
  - page cache vs buffer cache (CONFIG_EXT2_DIR_PAGE_CACHE)
  - deferred index creation (DX_DEFER)

The default is: indexed, deferred creates, page cache.  All these
options, except perhaps the first, will be removed in the finished
version, so if you are interested in doing performance measurements...
(hint hint)

I mentioned some cache-thrashing issues in a previous post - these come
up at directory sizes that were previously impractical with Ext2, and
are of two kinds:

  - prune_icache problems (MM)
  - Inode table thrashing issues

The MM problems were fixed by Marcelo Tosatti and by now are in the
2.4.4-pre trees - to be sure, you might want to ask Marcelo, or I can
forward you a copy of his patch for 2.4.3.

I've analyzed the inode table thrashing issues and now feel confident
that the thrashing can be pretty much eliminated by introducing
goal-directed inode allocation analogous to the current goal-directed
block allocation.  (The thrashing we see is not specific to the
particular indexing method I've used, but would occur with any
block-wise index on inodes.)  I plan to write up my findings on that
soon, and if you have read this far you'll probably find it quite
interesting.  In any event, now that the MM issues have been cleaned up
performance is decent even with the thrashing.  Adding more memory is an
option - I'd suggest using at least 256 Meg for 2,000,000 file
directories.

This patch remains pre-alpha, until the hash function is finalized.

Changes
-------

  - optionally run in page cache
  - use lock_super instead of lock_kernel for sb update
  - cleaned up redundant data pointers

To Do
-----

  - Finalize hash function
  - Test/debug big endian
  - Fail gracefully on random data

Future Work
-----------

  - Generalize to n level index
  - Coalesce on delete
  - Goal-directed inode allocation

Testers wanted
--------------

  - Big endian
  - SMP
  - Performance testing

The Patch is Available At
-------------------------

    http://kernelnewbies.org/~phillips/htree/dx.testme-2.4.3-3

To apply:

    cd /your/kernel/tree
    patch -p0 </the/patch

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo
