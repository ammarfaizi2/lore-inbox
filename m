Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135585AbRD1SKB>; Sat, 28 Apr 2001 14:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135583AbRD1SJu>; Sat, 28 Apr 2001 14:09:50 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:24836 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135581AbRD1SJa>; Sat, 28 Apr 2001 14:09:30 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: [TESTME] Ext2 Directory Index for 2.4.4
Message-Id: <20010428180609Z92197-843+40@humbolt.nl.linux.org>
Date: Sat, 28 Apr 2001 20:06:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am now maitaining two versions of the directory indexing patch, one
for the "old-style" ext2 directory code and another based on Al Viro's
directory-in-page-cache patch, which hasn't made it into the main tree
yet.  The current patches are:

    http://kernelnewbies.org/~phillips/htree/dx.testme-2.4.4
    http://kernelnewbies.org/~phillips/htree/dx.pcache-2.4.3
  
The pcache flavor can be applied to a 2.4.3 tree by first applying Al's
patch, available at::

   ftp://ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4-pre6.gz

There are problems with prune_icache in 2.4.3 that interfere serverely
with benchmarking.  These are fixed in 2.4.4, but if you want to do any
testing with 2.4.3, you should also apply this patch:

    http://kernelnewbies.org/~phillips/htree/marcelo.icache.fix-2.4.3

So the complete recipe for the pcache version is:

    cd source/tree
    zcat ext2-dir-patch-S4-pre6.gz | patch -p1
    cat marcelo.icache.fix-2.4.3 | patch -p0
    cat dx.pcache-2.4.3 | patch -p0

Both versions use the page cache.  The testme version can optionally
be compiled to use the tried-and-true buffer cache in case stability
turns out to be a problem.  So far, both versions have been pretty
stable but the changes both in my patch and in Al Viro's work are pretty
radical, so proceed with caution.  Oh the other hand, please proceed.
It needs testing.  It needs testing.  (Oh wait, sorry, repeating
myself.)  One more thing: it needs testing.
    
Performance
-----------

Today's pcache patch has turned in the fastest timings I've seen so far,
but in average performance the two seem to be about the same.  In other
words, the pcache version has variable performance, and actually, it's
quite extreme - more than a factor of two.  I think what that means is,
we still have some work to do to really understand and control the life
cycles of pages and buffers.  It also means we're doing something right,
we just have to be more consistent about it. 

There were a couple of adjustments to ext2_getblk_pcache to bring it
into line with current thinking with respect to BH_New handling, and to
avoid calling ext2_get_block when the buffer is already mapped (duh).
The revised version looks like:

struct buffer_head *ext2_getblk_pcache (struct inode *inode, u32 block,
	int create, int *err)
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
	if buffer_mapped(bh)
		return bh;
	if ((*err = ext2_get_block(inode, block, bh, create)))
		goto fail;
	if (!buffer_mapped(bh))
		goto fail;
	if (buffer_new(bh))
	{
		lock_buffer(bh);
		memset(bh->b_data, 0, blocksize);
		mark_buffer_uptodate(bh, 1);
		unlock_buffer(bh);
		mark_buffer_dirty_inode(bh, inode);
	}
	return bh;
fail:
	brelse(bh);
	return NULL;
}


This code is worth taking a close look at because it touches on a lot of
the issues of coding for the page cache.  In the 2.4.4 version I am
mixing together two

Changes
-------

  - two patches now, both support page cache

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

The Patches are at
------------------

    http://kernelnewbies.org/~phillips/htree/dx.testme-2.4.4
    http://kernelnewbies.org/~phillips/htree/dx.pcache-2.4.3
    http://kernelnewbies.org/~phillips/htree/marcelo.icache.fix-2.4.3
    ftp://ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4-pre6.gz

To apply:

    See above

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo
