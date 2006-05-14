Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWENLBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWENLBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWENLBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:01:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750898AbWENLBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:01:13 -0400
Date: Sun, 14 May 2006 03:58:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH 3/3] ufs: change b_blocknr
Message-Id: <20060514035801.4cb79d2c.akpm@osdl.org>
In-Reply-To: <20060514100235.GA21341@rain.homenetwork>
References: <20060514100235.GA21341@rain.homenetwork>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Dushistov <dushistov@mail.ru> wrote:
>
> Because of ufs's layout, code which works with UFS should
> time to time change such map "online":
> physical location<-->logical inode block

It does?  You mean that certain parts of a file will get moved from one set
of disk blocks to another?

I never knew that.  It'd be hard to do that while avoiding races.

> Current implementation of this cause kernel "hang up" and 
> damage of data.
> 
> This patch should solve this problems. It passes some tests,
> but I'm not sure that it completely correct. 
> The most tricky part is ufs_change_blocknr function. 
> May be some one can comment this patch?
> 

I don't know of anyone who knows the UFS code, sorry.   Apart from you ;)

> +/*
> + * Modify inode page cache in such way:
> + * have - blocks with b_blocknr equal to oldb...oldb+count-1
> + * get - blocks with b_blocknr equal to newb...newb+count-1
> + * also we suppose that oldb...oldb+count-1 blocks 
> + * situated at the end of file
> + */

It would be good if this comment could describe the operation of
`locked_page'.  What it does, how we use it.


> +static void ufs_change_blocknr(struct inode *inode, unsigned int count, 
> +			       unsigned int oldb, unsigned int newb, 
> +			       struct page *locked_page)
> +{
> +	unsigned int blk_per_page = 1UL << (PAGE_CACHE_SHIFT - inode->i_blkbits);
> +	sector_t baseblk=((inode->i_size-1)>>inode->i_blkbits)+1-count;
> +	struct address_space *mapping = inode->i_mapping;
> +	pgoff_t cur_index=locked_page->index;
> +	unsigned int i, j;
> +	struct page *page;
> +	struct buffer_head *head, *bh;

Please note that we put spaces around "+", "-" and "=".

> +	UFSD(("ENTER, ino %lu, count %u, oldb %u, newb %u\n", inode->i_ino, count, oldb, newb));
> +
> +	for (i=0; i<count; i+=blk_per_page) {

and around "<" and "+=".

> +		pgoff_t index = (baseblk+i) >> (PAGE_CACHE_SHIFT - inode->i_blkbits);
> +
> +		if (likely(cur_index!=index))
> +			page = find_lock_page(mapping, index);
> +		else
> +			page = locked_page;
> +
> +		if (!page) {
> +			page = read_cache_page(mapping, index,
> +					       (filler_t*)mapping->a_ops->readpage, NULL);
> +			if (IS_ERR(page)) {
> +				printk(KERN_ERR "ufs_change_blocknr: read_cache_page error: "
> +				       "ino %lu, index: %lu\n", inode->i_ino, index);
> +				continue;
> +			}
> +
> +			wait_on_page_locked(page);

You may as well do lock_page() here, and remove the later lock_page().

> +			if (!PageUptodate(page) || PageError(page)) {
> +				page_cache_release(page);
> +				printk(KERN_ERR "ufs_change_blocknr: can not read page: "
> +				       "ino %lu, index: %lu\n", inode->i_ino, index);
> +				continue;

And here, do

	if (page != locked_page)
		unlock_page(page);

because right now, this code can result in locked_page being unlocked,
which I think is wrong, yes?

> +			}
> +		  
> +			lock_page(page);
> +		}
> +
> +		if (!page_has_buffers(page))
> +			goto out;

Yes, you need that test - there are rare conditions under which the buffers
might have been stripped while the page was unlocked.

> +		j=i;
> +		head = page_buffers(page);
> +		bh = head;
> +		do {
> +			if (likely(bh->b_blocknr==j+oldb && j<count)) {
> +				get_bh(bh);

The get_bh() isn't needed - the page lock will protect the buffers.

> +				lock_buffer(bh);
> +				bh->b_blocknr = newb+j++;
> +				mark_buffer_dirty(bh);
> +				unlock_buffer(bh);
> +				put_bh(bh);

We're about to take a new block from the device and attach it to a
pagecache page and to then put it under I/O.

But for some filesystems (I don't know if this is true for UFS), it can be
the case that there's still a buffer dirty against that block from a
different address_space: the blockdev's address_space (the cache for
/dev/hda1, used for filesystem metadata).  In other words: even though that
disk block is presently unallocated as far as the filesystem is concerned,
there can be a pending write against it due to that dirty buffer.

So we need to shoot down that dirty blockdev buffer before marking this
other buffer (which uses the same block) as dirty.  Otherwise the old
blockdev's buffer can get written to disk after this one, corrupting data.

We do that with unmap_underlying_metadata().

> +			}
> + 
> +			bh = bh->b_this_page;
> +		} while (bh != head);
> + 
> +		__set_page_dirty_buffers(page);

I suppose so.  It might be cleaner to use set_page_dirty() here, so the
reader doesn't have to go off and check that __set_page_dirty_buffers() is
a correct optimisation for that.

> diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/inode.c linux-2.6.17-rc4/fs/ufs/inode.c
> --- linux-2.6.17-rc4-vanilla/fs/ufs/inode.c	2006-05-14 13:46:32.248269000 +0400
> +++ linux-2.6.17-rc4/fs/ufs/inode.c	2006-05-14 11:12:38.399189500 +0400
> @@ -173,9 +173,10 @@ static inline void ufs_clear_block(struc
>  }
>  
>  
> -static struct buffer_head * ufs_inode_getfrag (struct inode *inode,
> -	unsigned int fragment, unsigned int new_fragment,
> -	unsigned int required, int *err, int metadata, long *phys, int *new)
> +static struct buffer_head *ufs_inode_getfrag(struct inode *inode,
> +					     unsigned int fragment, unsigned int new_fragment,
> +					     unsigned int required, int *err, int metadata, 
> +					     long *phys, int *new, struct page *locked_page)
>  {
>  	struct ufs_inode_info *ufsi = UFS_I(inode);
>  	struct super_block * sb;
> @@ -233,7 +234,8 @@ repeat:
>  		if (lastblockoff) {
>  			p2 = ufsi->i_u1.i_data + lastblock;
>  			tmp = ufs_new_fragments (inode, p2, lastfrag, 
> -				fs32_to_cpu(sb, *p2), uspi->s_fpb - lastblockoff, err);
> +						 fs32_to_cpu(sb, *p2), uspi->s_fpb - lastblockoff, 
> +						 err, locked_page);
>  			if (!tmp) {
>  				if (lastfrag != ufsi->i_lastfrag)
>  					goto repeat;
> @@ -245,14 +247,16 @@ repeat:
>  		}
>  		goal = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock]) + uspi->s_fpb;
>  		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
> -			goal, required + blockoff, err);
> +					 goal, required + blockoff, 
> +					 err, locked_page);
>  	}
>  	/*
>  	 * We will extend last allocated block
>  	 */
>  	else if (lastblock == block) {
> -		tmp = ufs_new_fragments (inode, p, fragment - (blockoff - lastblockoff),
> -			fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff), err);
> +		tmp = ufs_new_fragments(inode, p, fragment - (blockoff - lastblockoff),
> +					fs32_to_cpu(sb, *p), required +  (blockoff - lastblockoff), 
> +					err, locked_page);
>  	}
>  	/*
>  	 * We will allocate new block before last allocated block
> @@ -260,8 +264,8 @@ repeat:
>  	else /* (lastblock > block) */ {
>  		if (lastblock && (tmp = fs32_to_cpu(sb, ufsi->i_u1.i_data[lastblock-1])))
>  			goal = tmp + uspi->s_fpb;
> -		tmp = ufs_new_fragments (inode, p, fragment - blockoff, 
> -			goal, uspi->s_fpb, err);
> +		tmp = ufs_new_fragments(inode, p, fragment - blockoff, 
> +					goal, uspi->s_fpb, err, locked_page);
>  	}

yeah, I don't know UFS and I don't have a clue what all that's doing, sorry.


