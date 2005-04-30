Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVD3AjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVD3AjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbVD3AjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:39:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43223 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263091AbVD3Adw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:33:52 -0400
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20050429135211.GA4539@in.ibm.com>
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <20050429135211.GA4539@in.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 29 Apr 2005 17:33:46 -0700
Message-Id: <1114821227.10473.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 19:22 +0530, Suparna Bhattacharya wrote:
> On Thu, Apr 28, 2005 at 12:14:24PM -0700, Mingming Cao wrote:
> > Currently ext3_get_block()/ext3_new_block() only allocate one block at a
> > time.  To allocate multiple blocks, the caller, for example, ext3 direct
> > IO routine, has to invoke ext3_get_block() many times.  This is quite
> > inefficient for sequential IO workload. 
> > 
> > The benefit of a real get_blocks() include
> > 1) increase the possibility to get contiguous blocks, reduce possibility
> > of  fragmentation due to interleaved allocations from other threads.
> > (should good for non reservation case)
> > 2) Reduces CPU cycles spent in repeated get_block() calls
> > 3) Batch meta data update and journaling in one short
> > 4) Could possibly speed up future get_blocks() look up by cache the last
> > mapped blocks in inode.
> > 
> 
> And here is the patch to make mpage_writepages use get_blocks() for
> multiple block lookup/allocation. It performs a radix-tree contiguous 
> pages lookup, and issues a get_blocks for the range together. It maintains
> an mpageio structure to track intermediate mapping state, somewhat
> like the DIO code.
> 
> It does need some more testing, especially block_size < PAGE_SIZE.
> The JFS workaround can be dropped if the JFS get_blocks fix from
> Dave Kleikamp is integrated.
> 
> Review feedback would be welcome.
> 
> Mingming,
> Let me know if you have a chance to try this out with your patch.
> 
> Regards
> Suparna
> 
> -- 
> Suparna Bhattacharya (suparna@in.ibm.com)
> Linux Technology Center
> IBM Software Lab, India
> 
> 
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/buffer.c linux-2.6.12-rc3-getblocks/fs/buffer.c
> --- linux-2.6.12-rc3/fs/buffer.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/buffer.c	2005-04-22 15:08:33.000000000 +0530
> @@ -2514,53 +2514,10 @@ EXPORT_SYMBOL(nobh_commit_write);
>   * that it tries to operate without attaching bufferheads to
>   * the page.
>   */
> -int nobh_writepage(struct page *page, get_block_t *get_block,
> -			struct writeback_control *wbc)
> +int nobh_writepage(struct page *page, get_blocks_t *get_blocks,
> +		struct writeback_control *wbc, writepage_t bh_writepage_fn)
>  {
> -	struct inode * const inode = page->mapping->host;
> -	loff_t i_size = i_size_read(inode);
> -	const pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
> -	unsigned offset;
> -	void *kaddr;
> -	int ret;
> -
> -	/* Is the page fully inside i_size? */
> -	if (page->index < end_index)
> -		goto out;
> -
> -	/* Is the page fully outside i_size? (truncate in progress) */
> -	offset = i_size & (PAGE_CACHE_SIZE-1);
> -	if (page->index >= end_index+1 || !offset) {
> -		/*
> -		 * The page may have dirty, unmapped buffers.  For example,
> -		 * they may have been added in ext3_writepage().  Make them
> -		 * freeable here, so the page does not leak.
> -		 */
> -#if 0
> -		/* Not really sure about this  - do we need this ? */
> -		if (page->mapping->a_ops->invalidatepage)
> -			page->mapping->a_ops->invalidatepage(page, offset);
> -#endif
> -		unlock_page(page);
> -		return 0; /* don't care */
> -	}
> -
> -	/*
> -	 * The page straddles i_size.  It must be zeroed out on each and every
> -	 * writepage invocation because it may be mmapped.  "A file is mapped
> -	 * in multiples of the page size.  For a file that is not a multiple of
> -	 * the  page size, the remaining memory is zeroed when mapped, and
> -	 * writes to that region are not written out to the file."
> -	 */
> -	kaddr = kmap_atomic(page, KM_USER0);
> -	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
> -	flush_dcache_page(page);
> -	kunmap_atomic(kaddr, KM_USER0);
> -out:
> -	ret = mpage_writepage(page, get_block, wbc);
> -	if (ret == -EAGAIN)
> -		ret = __block_write_full_page(inode, page, get_block, wbc);
> -	return ret;
> +	return mpage_writepage(page, get_blocks, wbc, bh_writepage_fn);
>  }
>  EXPORT_SYMBOL(nobh_writepage);
>  
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/ext2/inode.c linux-2.6.12-rc3-getblocks/fs/ext2/inode.c
> --- linux-2.6.12-rc3/fs/ext2/inode.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/ext2/inode.c	2005-04-22 16:30:42.000000000 +0530
> @@ -639,12 +639,6 @@ ext2_nobh_prepare_write(struct file *fil
>  	return nobh_prepare_write(page,from,to,ext2_get_block);
>  }
>  
> -static int ext2_nobh_writepage(struct page *page,
> -			struct writeback_control *wbc)
> -{
> -	return nobh_writepage(page, ext2_get_block, wbc);
> -}
> -
>  static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
>  {
>  	return generic_block_bmap(mapping,block,ext2_get_block);
> @@ -662,6 +656,12 @@ ext2_get_blocks(struct inode *inode, sec
>  	return ret;
>  }
>  
> +static int ext2_nobh_writepage(struct page *page,
> +			struct writeback_control *wbc)
> +{
> +	return nobh_writepage(page, ext2_get_blocks, wbc, ext2_writepage);
> +}
> +
>  static ssize_t
>  ext2_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
>  			loff_t offset, unsigned long nr_segs)
> @@ -676,7 +676,8 @@ ext2_direct_IO(int rw, struct kiocb *ioc
>  static int
>  ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
> -	return mpage_writepages(mapping, wbc, ext2_get_block);
> +        return __mpage_writepages(mapping, wbc, ext2_get_blocks,
> +					ext2_writepage);
>  }
>  
>  struct address_space_operations ext2_aops = {
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/ext3/inode.c linux-2.6.12-rc3-getblocks/fs/ext3/inode.c
> --- linux-2.6.12-rc3/fs/ext3/inode.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/ext3/inode.c	2005-04-22 15:08:33.000000000 +0530
> @@ -866,10 +866,10 @@ get_block:
>  	return ret;
>  }
>  
> -static int ext3_writepages_get_block(struct inode *inode, sector_t iblock,
> -			struct buffer_head *bh, int create)
> +static int ext3_writepages_get_blocks(struct inode *inode, sector_t iblock,
> +		unsigned long max_blocks, struct buffer_head *bh, int create)
>  {
> -	return ext3_direct_io_get_blocks(inode, iblock, 1, bh, create);
> +	return ext3_direct_io_get_blocks(inode, iblock, max_blocks, bh, create);
>  }
>  
>  /*
> @@ -1369,11 +1369,11 @@ ext3_writeback_writepages(struct address
>  		return ret;
>  	}
>  
> -        ret = __mpage_writepages(mapping, wbc, ext3_writepages_get_block,
> +        ret = __mpage_writepages(mapping, wbc, ext3_writepages_get_blocks,
>  					ext3_writeback_writepage_helper);
>  
>  	/*
> -	 * Need to reaquire the handle since ext3_writepages_get_block()
> +	 * Need to reaquire the handle since ext3_writepages_get_blocks()
>  	 * can restart the handle
>  	 */
>  	handle = journal_current_handle();
> @@ -1402,7 +1402,8 @@ static int ext3_writeback_writepage(stru
>  	}
>  
>  	if (test_opt(inode->i_sb, NOBH))
> -		ret = nobh_writepage(page, ext3_get_block, wbc);
> +		ret = nobh_writepage(page, ext3_writepages_get_blocks, wbc,
> +			ext3_writeback_writepage_helper);
>  	else
>  		ret = block_write_full_page(page, ext3_get_block, wbc);
>  
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/ext3/super.c linux-2.6.12-rc3-getblocks/fs/ext3/super.c
> --- linux-2.6.12-rc3/fs/ext3/super.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/ext3/super.c	2005-04-22 15:08:33.000000000 +0530
> @@ -1321,6 +1321,7 @@ static int ext3_fill_super (struct super
>  	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
>  
>  	set_opt(sbi->s_mount_opt, RESERVATION);
> +	set_opt(sbi->s_mount_opt, NOBH); /* temp: set nobh default */
>  
>  	if (!parse_options ((char *) data, sb, &journal_inum, NULL, 0))
>  		goto failed_mount;
> @@ -1567,6 +1568,7 @@ static int ext3_fill_super (struct super
>  			printk(KERN_ERR "EXT3-fs: Journal does not support "
>  			       "requested data journaling mode\n");
>  			goto failed_mount3;
> +		set_opt(sbi->s_mount_opt, NOBH); /* temp: set nobh default */
>  		}
>  	default:
>  		break;
> @@ -1584,6 +1586,7 @@ static int ext3_fill_super (struct super
>  				"its supported only with writeback mode\n");
>  			clear_opt(sbi->s_mount_opt, NOBH);
>  		}
> +		printk("NOBH option set\n");
>  	}
>  	/*
>  	 * The journal_load will have done any necessary log recovery,
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/hfs/inode.c linux-2.6.12-rc3-getblocks/fs/hfs/inode.c
> --- linux-2.6.12-rc3/fs/hfs/inode.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/hfs/inode.c	2005-04-22 15:08:33.000000000 +0530
> @@ -124,7 +124,7 @@ static ssize_t hfs_direct_IO(int rw, str
>  static int hfs_writepages(struct address_space *mapping,
>  			  struct writeback_control *wbc)
>  {
> -	return mpage_writepages(mapping, wbc, hfs_get_block);
> +	return mpage_writepages(mapping, wbc, hfs_get_blocks);
>  }
>  
>  struct address_space_operations hfs_btree_aops = {
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/hfsplus/inode.c linux-2.6.12-rc3-getblocks/fs/hfsplus/inode.c
> --- linux-2.6.12-rc3/fs/hfsplus/inode.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/hfsplus/inode.c	2005-04-22 15:08:33.000000000 +0530
> @@ -121,7 +121,7 @@ static ssize_t hfsplus_direct_IO(int rw,
>  static int hfsplus_writepages(struct address_space *mapping,
>  			      struct writeback_control *wbc)
>  {
> -	return mpage_writepages(mapping, wbc, hfsplus_get_block);
> +	return mpage_writepages(mapping, wbc, hfsplus_get_blocks);
>  }
>  
>  struct address_space_operations hfsplus_btree_aops = {
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/jfs/inode.c linux-2.6.12-rc3-getblocks/fs/jfs/inode.c
> --- linux-2.6.12-rc3/fs/jfs/inode.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/jfs/inode.c	2005-04-22 16:27:19.000000000 +0530
> @@ -267,21 +267,41 @@ jfs_get_blocks(struct inode *ip, sector_
>  	return rc;
>  }
>  
> +static int
> +jfs_mpage_get_blocks(struct inode *ip, sector_t lblock, unsigned long
> +			max_blocks, struct buffer_head *bh_result, int create)
> +{
> +	/* 
> +	 * fixme: temporary workaround: return one block at a time until
> +	 * we figure out why we see exposures with truncate on 
> +	 * allocating multiple blocks in one shot.
> +	 */
> +	return jfs_get_blocks(ip, lblock, 1, bh_result, create);
> +}
> +
>  static int jfs_get_block(struct inode *ip, sector_t lblock,
>  			 struct buffer_head *bh_result, int create)
>  {
>  	return jfs_get_blocks(ip, lblock, 1, bh_result, create);
>  }
>  
> +static int jfs_bh_writepage(struct page *page,
> +				struct writeback_control *wbc)
> +{
> +	return block_write_full_page(page, jfs_get_block, wbc);
> +}
> +
> +
>  static int jfs_writepage(struct page *page, struct writeback_control *wbc)
>  {
> -	return nobh_writepage(page, jfs_get_block, wbc);
> +	return nobh_writepage(page, jfs_mpage_get_blocks, wbc, jfs_bh_writepage);
>  }
>  
>  static int jfs_writepages(struct address_space *mapping,
>  			struct writeback_control *wbc)
>  {
> -	return mpage_writepages(mapping, wbc, jfs_get_block);
> +        return __mpage_writepages(mapping, wbc, jfs_mpage_get_blocks,
> +					jfs_bh_writepage);
>  }
>  
>  static int jfs_readpage(struct file *file, struct page *page)
> diff -urp -X dontdiff linux-2.6.12-rc3/fs/mpage.c linux-2.6.12-rc3-getblocks/fs/mpage.c
> --- linux-2.6.12-rc3/fs/mpage.c	2005-04-21 05:33:15.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/fs/mpage.c	2005-04-22 16:19:14.000000000 +0530
> @@ -370,6 +370,67 @@ int mpage_readpage(struct page *page, ge
>  }
>  EXPORT_SYMBOL(mpage_readpage);
>  
> +struct mpageio {
> +	struct bio *bio;
> +	struct buffer_head map_bh;
> +	unsigned long block_in_file;
> +	unsigned long final_block_in_request;
> +	sector_t long block_in_bio;
> +	int boundary;
> +	sector_t boundary_block;
> +	struct block_device *boundary_bdev;
> +};
> +
> +/*
> + * Maps as many contiguous disk blocks as it can within the range of
> + * the request, and returns the total number of contiguous mapped
> + * blocks in the mpageio.
> + */
> +static unsigned long mpage_get_more_blocks(struct mpageio *mio,
> +	struct inode *inode, get_blocks_t get_blocks)
> +{
> +	struct buffer_head map_bh = {.b_state = 0};
> +	unsigned long mio_nblocks = mio->map_bh.b_size >> inode->i_blkbits;
> +	unsigned long first_unmapped = mio->block_in_file + mio_nblocks;
> +	unsigned long next_contig_block = mio->map_bh.b_blocknr + mio_nblocks;
> +
> +	while ((first_unmapped < mio->final_block_in_request) &&
> +		(mio->map_bh.b_size < PAGE_SIZE)) {
> +
> +		if (get_blocks(inode, first_unmapped,
> +			mio->final_block_in_request - first_unmapped,
> +			&map_bh, 1))
> +			break;
> +		if (mio_nblocks && ((map_bh.b_blocknr != next_contig_block) ||
> +			map_bh.b_bdev != mio->map_bh.b_bdev))
> +			break;
> +			
> +		if (buffer_new(&map_bh)) {
> +			int i = 0;
> +			for (; i < map_bh.b_size >> inode->i_blkbits; i++)
> +				unmap_underlying_metadata(map_bh.b_bdev,
> +					map_bh.b_blocknr + i);
> +		}
> +		
> +		if (buffer_boundary(&map_bh)) {
> +			mio->boundary = 1;
> +			mio->boundary_block = map_bh.b_blocknr;
> +			mio->boundary_bdev = map_bh.b_bdev;
> +		}
> +		if (mio_nblocks == 0) {
> +			mio->map_bh.b_bdev = map_bh.b_bdev;
> +			mio->map_bh.b_blocknr = map_bh.b_blocknr;
> +		}
> +
> +		mio_nblocks += map_bh.b_size >> inode->i_blkbits;
> +		first_unmapped = mio->block_in_file + mio_nblocks;
> +		next_contig_block = mio->map_bh.b_blocknr + mio_nblocks;
> +		mio->map_bh.b_size += map_bh.b_size;
> +	}
> +
> +	return mio_nblocks;
> +}
> +
>  /*
>   * Writing is not so simple.
>   *
> @@ -386,9 +447,9 @@ EXPORT_SYMBOL(mpage_readpage);
>   * written, so it can intelligently allocate a suitably-sized BIO.  For now,
>   * just allocate full-size (16-page) BIOs.
>   */
> -static struct bio *
> -__mpage_writepage(struct bio *bio, struct page *page, get_block_t get_block,
> -	sector_t *last_block_in_bio, int *ret, struct writeback_control *wbc,
> +static int
> +__mpage_writepage(struct mpageio *mio, struct page *page,
> +	get_blocks_t get_blocks, struct writeback_control *wbc,
>  	writepage_t writepage_fn)
>  {
>  	struct address_space *mapping = page->mapping;
> @@ -396,9 +457,8 @@ __mpage_writepage(struct bio *bio, struc
>  	const unsigned blkbits = inode->i_blkbits;
>  	unsigned long end_index;
>  	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
> -	sector_t last_block;
> +	sector_t last_block, blocks_to_skip;
>  	sector_t block_in_file;
> -	sector_t blocks[MAX_BUF_PER_PAGE];
>  	unsigned page_block;
>  	unsigned first_unmapped = blocks_per_page;
>  	struct block_device *bdev = NULL;
> @@ -406,8 +466,10 @@ __mpage_writepage(struct bio *bio, struc
>  	sector_t boundary_block = 0;
>  	struct block_device *boundary_bdev = NULL;
>  	int length;
> -	struct buffer_head map_bh;
>  	loff_t i_size = i_size_read(inode);
> +	struct buffer_head *map_bh = &mio->map_bh;
> +	struct bio *bio = mio->bio;
> +	int ret = 0;
>  
>  	if (page_has_buffers(page)) {
>  		struct buffer_head *head = page_buffers(page);
> @@ -435,10 +497,13 @@ __mpage_writepage(struct bio *bio, struc
>  			if (!buffer_dirty(bh) || !buffer_uptodate(bh))
>  				goto confused;
>  			if (page_block) {
> -				if (bh->b_blocknr != blocks[page_block-1] + 1)
> +				if (bh->b_blocknr != map_bh->b_blocknr 
> +					+ page_block)
>  					goto confused;
> +			} else {
> +				map_bh->b_blocknr = bh->b_blocknr;
> +				map_bh->b_size = PAGE_SIZE;
>  			}
> -			blocks[page_block++] = bh->b_blocknr;
>  			boundary = buffer_boundary(bh);
>  			if (boundary) {
>  				boundary_block = bh->b_blocknr;
> @@ -465,33 +530,30 @@ __mpage_writepage(struct bio *bio, struc
>  	BUG_ON(!PageUptodate(page));
>  	block_in_file = page->index << (PAGE_CACHE_SHIFT - blkbits);
>  	last_block = (i_size - 1) >> blkbits;
> -	map_bh.b_page = page;
> -	for (page_block = 0; page_block < blocks_per_page; ) {
> -
> -		map_bh.b_state = 0;
> -		if (get_block(inode, block_in_file, &map_bh, 1))
> -			goto confused;
> -		if (buffer_new(&map_bh))
> -			unmap_underlying_metadata(map_bh.b_bdev,
> -						map_bh.b_blocknr);
> -		if (buffer_boundary(&map_bh)) {
> -			boundary_block = map_bh.b_blocknr;
> -			boundary_bdev = map_bh.b_bdev;
> -		}
> -		if (page_block) {
> -			if (map_bh.b_blocknr != blocks[page_block-1] + 1)
> -				goto confused;
> -		}
> -		blocks[page_block++] = map_bh.b_blocknr;
> -		boundary = buffer_boundary(&map_bh);
> -		bdev = map_bh.b_bdev;
> -		if (block_in_file == last_block)
> -			break;
> -		block_in_file++;
> +	blocks_to_skip = block_in_file - mio->block_in_file;
> +	mio->block_in_file = block_in_file;
> +	if (blocks_to_skip < (map_bh->b_size >> blkbits)) {
> +		map_bh->b_blocknr += blocks_to_skip;
> +		map_bh->b_size -= blocks_to_skip << blkbits;
> +	} else {
> +		map_bh->b_state = 0;
> +		map_bh->b_size = 0;
> +		if (mio->final_block_in_request > last_block)
> +			mio->final_block_in_request = last_block;
> +		mpage_get_more_blocks(mio, inode, get_blocks);
>  	}
> -	BUG_ON(page_block == 0);
> +	if (map_bh->b_size < PAGE_SIZE)
> +		goto confused;
>  
> -	first_unmapped = page_block;
> +	if (mio->boundary && (mio->boundary_block < map_bh->b_blocknr 
> +		+ blocks_per_page)) {
> +		boundary = 1;
> +		boundary_block = mio->boundary_block;
> +		boundary_bdev = mio->boundary_bdev;
> +	}
> +		
> +	bdev = map_bh->b_bdev;
> +	first_unmapped = blocks_per_page;
>  
>  page_is_mapped:
>  	end_index = i_size >> PAGE_CACHE_SHIFT;
> @@ -518,12 +580,16 @@ page_is_mapped:
>  	/*
>  	 * This page will go to BIO.  Do we need to send this BIO off first?
>  	 */
> -	if (bio && *last_block_in_bio != blocks[0] - 1)
> +	if (bio && mio->block_in_bio != map_bh->b_blocknr - 1)
>  		bio = mpage_bio_submit(WRITE, bio);
>  
>  alloc_new:
>  	if (bio == NULL) {
> -		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
> +		/* 
> +		 * Fixme: bio size can be limited to final_block - block, or
> +		 * even mio->map_bh.b_size
> +		 */
> +		bio = mpage_alloc(bdev, map_bh->b_blocknr << (blkbits - 9),
>  				bio_get_nr_vecs(bdev), GFP_NOFS|__GFP_HIGH);
>  		if (bio == NULL)
>  			goto confused;
> @@ -539,6 +605,9 @@ alloc_new:
>  		bio = mpage_bio_submit(WRITE, bio);
>  		goto alloc_new;
>  	}
> +	map_bh->b_blocknr += blocks_per_page;
> +	map_bh->b_size -= PAGE_SIZE;
> +	mio->block_in_file += blocks_per_page;
>  
>  	/*
>  	 * OK, we have our BIO, so we can now mark the buffers clean.  Make
> @@ -575,7 +644,8 @@ alloc_new:
>  					boundary_block, 1 << blkbits);
>  		}
>  	} else {
> -		*last_block_in_bio = blocks[blocks_per_page - 1];
> +		/* we can pack more pages into the bio, don't submit yet */
> +		mio->block_in_bio = map_bh->b_blocknr - 1;
>  	}
>  	goto out;
>  
> @@ -584,22 +654,23 @@ confused:
>  		bio = mpage_bio_submit(WRITE, bio);
>  
>  	if (writepage_fn) {
> -		*ret = (*writepage_fn)(page, wbc);
> +		ret = (*writepage_fn)(page, wbc);
>  	} else {
> -		*ret = -EAGAIN;
> +		ret = -EAGAIN;
>  		goto out;
>  	}
>  	/*
>  	 * The caller has a ref on the inode, so *mapping is stable
>  	 */
> -	if (*ret) {
> -		if (*ret == -ENOSPC)
> +	if (ret) {
> +		if (ret == -ENOSPC)
>  			set_bit(AS_ENOSPC, &mapping->flags);
>  		else
>  			set_bit(AS_EIO, &mapping->flags);
>  	}
>  out:
> -	return bio;
> +	mio->bio = bio;
> +	return ret;
>  }
>  
>  /**
> @@ -625,20 +696,21 @@ out:
>   */
>  int
>  mpage_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc, get_block_t get_block)
> +		struct writeback_control *wbc, get_blocks_t get_blocks)
>  {
> -	return __mpage_writepages(mapping, wbc, get_block,
> +	return __mpage_writepages(mapping, wbc, get_blocks,
>  		mapping->a_ops->writepage);
>  }
>  
>  int
>  __mpage_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc, get_block_t get_block,
> +		struct writeback_control *wbc, get_blocks_t get_blocks,
>  		writepage_t writepage_fn)
>  {
>  	struct backing_dev_info *bdi = mapping->backing_dev_info;
> +	struct inode *inode = mapping->host;
> +	const unsigned blkbits = inode->i_blkbits;
>  	struct bio *bio = NULL;
> -	sector_t last_block_in_bio = 0;
>  	int ret = 0;
>  	int done = 0;
>  	int (*writepage)(struct page *page, struct writeback_control *wbc);
> @@ -648,6 +720,9 @@ __mpage_writepages(struct address_space 
>  	pgoff_t end = -1;		/* Inclusive */
>  	int scanned = 0;
>  	int is_range = 0;
> +	struct mpageio mio = {
> +		.bio = NULL
> +	};
>  
>  	if (wbc->nonblocking && bdi_write_congested(bdi)) {
>  		wbc->encountered_congestion = 1;
> @@ -655,7 +730,7 @@ __mpage_writepages(struct address_space 
>  	}
>  
>  	writepage = NULL;
> -	if (get_block == NULL)
> +	if (get_blocks == NULL)
>  		writepage = mapping->a_ops->writepage;
>  
>  	pagevec_init(&pvec, 0);
> @@ -672,12 +747,15 @@ __mpage_writepages(struct address_space 
>  		scanned = 1;
>  	}
>  retry:
> +	down_read(&inode->i_alloc_sem);
>  	while (!done && (index <= end) &&
> -			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
> -			PAGECACHE_TAG_DIRTY,
> +			(nr_pages = pagevec_contig_lookup_tag(&pvec, mapping,
> +			&index, PAGECACHE_TAG_DIRTY,
>  			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
>  		unsigned i;
>  
> +		mio.final_block_in_request = min(index, end) <<
> +			(PAGE_CACHE_SHIFT - blkbits);
>  		scanned = 1;
>  		for (i = 0; i < nr_pages; i++) {
>  			struct page *page = pvec.pages[i];
> @@ -702,7 +780,7 @@ retry:
>  				unlock_page(page);
>  				continue;
>  			}
> -
> +			
>  			if (wbc->sync_mode != WB_SYNC_NONE)
>  				wait_on_page_writeback(page);
>  
> @@ -723,9 +801,9 @@ retry:
>  							&mapping->flags);
>  				}
>  			} else {
> -				bio = __mpage_writepage(bio, page, get_block,
> -						&last_block_in_bio, &ret, wbc,
> -						writepage_fn);
> +				ret = __mpage_writepage(&mio, page, get_blocks,
> +						wbc, writepage_fn);
> +				bio = mio.bio;
>  			}
>  			if (ret || (--(wbc->nr_to_write) <= 0))
>  				done = 1;
> @@ -737,6 +815,9 @@ retry:
>  		pagevec_release(&pvec);
>  		cond_resched();
>  	}
> +	
> +	up_read(&inode->i_alloc_sem);
> +
>  	if (!scanned && !done) {
>  		/*
>  		 * We hit the last page and there is more work to be done: wrap
> @@ -755,17 +836,23 @@ retry:
>  EXPORT_SYMBOL(mpage_writepages);
>  EXPORT_SYMBOL(__mpage_writepages);
>  
> -int mpage_writepage(struct page *page, get_block_t get_block,
> -	struct writeback_control *wbc)
> +int mpage_writepage(struct page *page, get_blocks_t get_blocks,
> +		struct writeback_control *wbc, writepage_t writepage_fn)
>  {
>  	int ret = 0;
> -	struct bio *bio;
> -	sector_t last_block_in_bio = 0;
> -
> -	bio = __mpage_writepage(NULL, page, get_block,
> -			&last_block_in_bio, &ret, wbc, NULL);
> -	if (bio)
> -		mpage_bio_submit(WRITE, bio);
> +	struct address_space *mapping = page->mapping;
> +	struct inode *inode = mapping->host;
> +	const unsigned blkbits = inode->i_blkbits;
> +	struct mpageio mio = {
> +		.final_block_in_request = (page->index + 1) << (PAGE_CACHE_SHIFT
> +			- blkbits)
> +	};
> +
> +	dump_stack();
> +	ret = __mpage_writepage(&mio, page, get_blocks,
> +			wbc, writepage_fn);
> +	if (mio.bio)
> +		mpage_bio_submit(WRITE, mio.bio);
>  
>  	return ret;
>  }
> diff -urp -X dontdiff linux-2.6.12-rc3/include/linux/buffer_head.h linux-2.6.12-rc3-getblocks/include/linux/buffer_head.h
> --- linux-2.6.12-rc3/include/linux/buffer_head.h	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/include/linux/buffer_head.h	2005-04-22 15:08:33.000000000 +0530
> @@ -203,8 +203,8 @@ int file_fsync(struct file *, struct den
>  int nobh_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
>  int nobh_commit_write(struct file *, struct page *, unsigned, unsigned);
>  int nobh_truncate_page(struct address_space *, loff_t);
> -int nobh_writepage(struct page *page, get_block_t *get_block,
> -                        struct writeback_control *wbc);
> +int nobh_writepage(struct page *page, get_blocks_t *get_blocks,
> +	struct writeback_control *wbc, writepage_t bh_writepage);
>  
> 
>  /*
> diff -urp -X dontdiff linux-2.6.12-rc3/include/linux/fs.h linux-2.6.12-rc3-getblocks/include/linux/fs.h
> --- linux-2.6.12-rc3/include/linux/fs.h	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/include/linux/fs.h	2005-04-22 15:08:33.000000000 +0530
> @@ -304,6 +304,8 @@ struct address_space;
>  struct writeback_control;
>  struct kiocb;
>  
> +typedef int (writepage_t)(struct page *page, struct writeback_control *wbc);
> +
>  struct address_space_operations {
>  	int (*writepage)(struct page *page, struct writeback_control *wbc);
>  	int (*readpage)(struct file *, struct page *);
> diff -urp -X dontdiff linux-2.6.12-rc3/include/linux/mpage.h linux-2.6.12-rc3-getblocks/include/linux/mpage.h
> --- linux-2.6.12-rc3/include/linux/mpage.h	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/include/linux/mpage.h	2005-04-22 15:08:33.000000000 +0530
> @@ -11,17 +11,16 @@
>   */
>  
>  struct writeback_control;
> -typedef int (writepage_t)(struct page *page, struct writeback_control *wbc);
>  
>  int mpage_readpages(struct address_space *mapping, struct list_head *pages,
>  				unsigned nr_pages, get_block_t get_block);
>  int mpage_readpage(struct page *page, get_block_t get_block);
>  int mpage_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc, get_block_t get_block);
> -int mpage_writepage(struct page *page, get_block_t *get_block,
> -		struct writeback_control *wbc);
> +		struct writeback_control *wbc, get_blocks_t get_blocks);
> +int mpage_writepage(struct page *page, get_blocks_t *get_blocks,
> +		struct writeback_control *wbc, writepage_t writepage);
>  int __mpage_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc, get_block_t get_block,
> +		struct writeback_control *wbc, get_blocks_t get_blocks,
>  		writepage_t writepage);
>  
>  static inline int
> diff -urp -X dontdiff linux-2.6.12-rc3/include/linux/pagemap.h linux-2.6.12-rc3-getblocks/include/linux/pagemap.h
> --- linux-2.6.12-rc3/include/linux/pagemap.h	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/include/linux/pagemap.h	2005-04-22 15:08:33.000000000 +0530
> @@ -73,7 +73,8 @@ extern struct page * find_or_create_page
>  unsigned find_get_pages(struct address_space *mapping, pgoff_t start,
>  			unsigned int nr_pages, struct page **pages);
>  unsigned find_get_pages_tag(struct address_space *mapping, pgoff_t *index,
> -			int tag, unsigned int nr_pages, struct page **pages);
> +			int tag, unsigned int nr_pages, struct page **pages,
> +			int contig);
>  
>  /*
>   * Returns locked page at given index in given cache, creating it if needed.
> diff -urp -X dontdiff linux-2.6.12-rc3/include/linux/pagevec.h linux-2.6.12-rc3-getblocks/include/linux/pagevec.h
> --- linux-2.6.12-rc3/include/linux/pagevec.h	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/include/linux/pagevec.h	2005-04-22 15:08:33.000000000 +0530
> @@ -28,6 +28,9 @@ unsigned pagevec_lookup(struct pagevec *
>  unsigned pagevec_lookup_tag(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t *index, int tag,
>  		unsigned nr_pages);
> +unsigned pagevec_contig_lookup_tag(struct pagevec *pvec,
> +		struct address_space *mapping, pgoff_t *index, int tag,
> +		unsigned nr_pages);
>  
>  static inline void pagevec_init(struct pagevec *pvec, int cold)
>  {
> diff -urp -X dontdiff linux-2.6.12-rc3/include/linux/radix-tree.h linux-2.6.12-rc3-getblocks/include/linux/radix-tree.h
> --- linux-2.6.12-rc3/include/linux/radix-tree.h	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/include/linux/radix-tree.h	2005-04-22 15:08:33.000000000 +0530
> @@ -59,8 +59,18 @@ void *radix_tree_tag_clear(struct radix_
>  int radix_tree_tag_get(struct radix_tree_root *root,
>  			unsigned long index, int tag);
>  unsigned int
> -radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
> -		unsigned long first_index, unsigned int max_items, int tag);
> +__radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
> +		unsigned long first_index, unsigned int max_items, int tag,
> +		int contig);
> +
> +static inline unsigned int radix_tree_gang_lookup_tag(struct radix_tree_root
> +		*root, void **results, unsigned long first_index,
> +		unsigned int max_items, int tag)
> +{
> +	return __radix_tree_gang_lookup_tag(root, results, first_index,
> +		max_items, tag, 0);
> +}
> +
>  int radix_tree_tagged(struct radix_tree_root *root, int tag);
>  
>  static inline void radix_tree_preload_end(void)
> diff -urp -X dontdiff linux-2.6.12-rc3/lib/radix-tree.c linux-2.6.12-rc3-getblocks/lib/radix-tree.c
> --- linux-2.6.12-rc3/lib/radix-tree.c	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/lib/radix-tree.c	2005-04-22 16:34:29.000000000 +0530
> @@ -557,12 +557,13 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
>   */
>  static unsigned int
>  __lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
> -	unsigned int max_items, unsigned long *next_index, int tag)
> +	unsigned int max_items, unsigned long *next_index, int tag, int contig)
>  {
>  	unsigned int nr_found = 0;
>  	unsigned int shift;
>  	unsigned int height = root->height;
>  	struct radix_tree_node *slot;
> +	unsigned long cindex = (contig && (*next_index)) ? *next_index : -1;
>  
>  	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
>  	slot = root->rnode;
> @@ -575,6 +576,11 @@ __lookup_tag(struct radix_tree_root *roo
>  				BUG_ON(slot->slots[i] == NULL);
>  				break;
>  			}
> +			if (contig && index >= cindex) {
> +				/* break in contiguity */
> +				index = 0;
> +				goto out;
> +			}
>  			index &= ~((1UL << shift) - 1);
>  			index += 1UL << shift;
>  			if (index == 0)
> @@ -593,6 +599,10 @@ __lookup_tag(struct radix_tree_root *roo
>  					results[nr_found++] = slot->slots[j];
>  					if (nr_found == max_items)
>  						goto out;
> +				} else if (contig && nr_found) {
> +					/* break in contiguity */
> +					index = 0;
> +					goto out;
>  				}
>  			}
>  		}
> @@ -618,29 +628,32 @@ out:
>   *	returns the number of items which were placed at *@results.
>   */
>  unsigned int
> -radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
> -		unsigned long first_index, unsigned int max_items, int tag)
> +__radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
> +		unsigned long first_index, unsigned int max_items, int tag,
> +		int contig)
>  {
>  	const unsigned long max_index = radix_tree_maxindex(root->height);
>  	unsigned long cur_index = first_index;
> +	unsigned long next_index = 0;	/* Index of next contiguous search */
>  	unsigned int ret = 0;
>  
>  	while (ret < max_items) {
>  		unsigned int nr_found;
> -		unsigned long next_index;	/* Index of next search */
>  
>  		if (cur_index > max_index)
>  			break;
>  		nr_found = __lookup_tag(root, results + ret, cur_index,
> -					max_items - ret, &next_index, tag);
> +				max_items - ret, &next_index, tag, contig);
>  		ret += nr_found;
>  		if (next_index == 0)
>  			break;
>  		cur_index = next_index;
> +		if (!nr_found)
> +			next_index = 0;
>  	}
>  	return ret;
>  }
> -EXPORT_SYMBOL(radix_tree_gang_lookup_tag);
> +EXPORT_SYMBOL(__radix_tree_gang_lookup_tag);
>  
>  /**
>   *	radix_tree_delete    -    delete an item from a radix tree
> diff -urp -X dontdiff linux-2.6.12-rc3/mm/filemap.c linux-2.6.12-rc3-getblocks/mm/filemap.c
> --- linux-2.6.12-rc3/mm/filemap.c	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/mm/filemap.c	2005-04-22 16:20:30.000000000 +0530
> @@ -635,16 +635,19 @@ unsigned find_get_pages(struct address_s
>  /*
>   * Like find_get_pages, except we only return pages which are tagged with
>   * `tag'.   We update *index to index the next page for the traversal.
> + * If 'contig' is 1, then we return only pages which are contiguous in the
> + * file.
>   */
>  unsigned find_get_pages_tag(struct address_space *mapping, pgoff_t *index,
> -			int tag, unsigned int nr_pages, struct page **pages)
> +			int tag, unsigned int nr_pages, struct page **pages,
> +			int contig)
>  {
>  	unsigned int i;
>  	unsigned int ret;
>  
>  	read_lock_irq(&mapping->tree_lock);
> -	ret = radix_tree_gang_lookup_tag(&mapping->page_tree,
> -				(void **)pages, *index, nr_pages, tag);
> +	ret = __radix_tree_gang_lookup_tag(&mapping->page_tree,
> +			(void **)pages, *index, nr_pages, tag, contig);
>  	for (i = 0; i < ret; i++)
>  		page_cache_get(pages[i]);
>  	if (ret)
> diff -urp -X dontdiff linux-2.6.12-rc3/mm/swap.c linux-2.6.12-rc3-getblocks/mm/swap.c
> --- linux-2.6.12-rc3/mm/swap.c	2005-04-21 05:33:16.000000000 +0530
> +++ linux-2.6.12-rc3-getblocks/mm/swap.c	2005-04-22 15:08:33.000000000 +0530
> @@ -384,7 +384,16 @@ unsigned pagevec_lookup_tag(struct pagev
>  		pgoff_t *index, int tag, unsigned nr_pages)
>  {
>  	pvec->nr = find_get_pages_tag(mapping, index, tag,
> -					nr_pages, pvec->pages);
> +					nr_pages, pvec->pages, 0);
> +	return pagevec_count(pvec);
> +}
> +
> +unsigned int
> +pagevec_contig_lookup_tag(struct pagevec *pvec, struct address_space *mapping,
> +		pgoff_t *index, int tag, unsigned nr_pages)
> +{
> +	pvec->nr = find_get_pages_tag(mapping, index, tag,
> +					nr_pages, pvec->pages, 1);
>  	return pagevec_count(pvec);
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

