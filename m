Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRECVLp>; Thu, 3 May 2001 17:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135226AbRECVLg>; Thu, 3 May 2001 17:11:36 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:8970 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S135217AbRECVLZ>; Thu, 3 May 2001 17:11:25 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: ac9410@bellsouth.net
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010503211046Z92199-3530+25@humbolt.nl.linux.org>
Date: Thu, 3 May 2001 23:10:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This combination against 2.4.4 won't allow directories to be moved.
> Ex: mv a b #fails with I/O error.  See attached strace.
> But with ext2-dir-patch-S4 by itself, mv works as it should.

Now it also works with my index patch as it should:

    http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-3

It was just an uninitialized *err return.  Next patch I'll follow Al
Viro's suggestion and change ext2_getblk (used *only* in the directory  
code) to use ERR_PTR instead of *err, saving an argument and eliminating
the chance for this kind of dumb error.
    
ext2_getblk now looks like:

struct buffer_head *ext2_getblk (struct inode *inode, u32 block, int create, int *err)
{
	unsigned blockshift = inode->i_sb->s_blocksize_bits;
	unsigned blocksize = 1 << blockshift;
	unsigned pshift = PAGE_CACHE_SHIFT - blockshift;
	struct buffer_head *bh;
	struct page *page;

	if (!(page = grab_cache_page(inode->i_mapping, block >> pshift)))
		goto fail_page;
	if (!page->buffers)
		create_empty_buffers (page, inode->i_dev, blocksize);
	bh = page_buffer (page, block & ((1 << pshift) - 1));
	atomic_inc(&bh->b_count);
	UnlockPage(page);
	page_cache_release(page);
	*err = 0;
	if (buffer_mapped(bh))
		return bh;
	if ((*err = ext2_get_block(inode, block, bh, create)))
		goto out_null;
	if (!buffer_mapped(bh))
		goto out_null;
	if (!buffer_new(bh))
		return bh;
	lock_buffer(bh);
	memset(bh->b_data, 0, blocksize);
	mark_buffer_uptodate(bh, 1);
	mark_buffer_dirty_inode(bh, inode);
	unlock_buffer(bh);
	return bh;
out_null:
	brelse(bh);
	return NULL;
fail_page:
	*err = -EIO;
	return NULL;
}

A little longer, somewhat clearer and much more correct.

--
Daniel
