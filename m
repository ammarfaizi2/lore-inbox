Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758869AbWLFBGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbWLFBGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759349AbWLFBGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:06:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34631 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758869AbWLFBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:06:40 -0500
Date: Tue, 5 Dec 2006 17:06:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "Chris Mason" <chris.mason@oracle.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] optimize o_direct on block device - v2
Message-Id: <20061205170624.b63c46bc.akpm@osdl.org>
In-Reply-To: <000001c71829$a3378900$ba88030a@amr.corp.intel.com>
References: <000001c71829$a3378900$ba88030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 20:55:50 -0800
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> This patch implements block device specific .direct_IO method instead
> of going through generic direct_io_worker for block device.
> 
> direct_io_worker is fairly complex because it needs to handle O_DIRECT
> on file system, where it needs to perform block allocation, hole detection,
> extents file on write, and tons of other corner cases. The end result is
> that it takes tons of CPU time to submit an I/O.
> 
> For block device, the block allocation is much simpler and a tight triple
> loop can be written to iterate each iovec and each page within the iovec
> in order to construct/prepare bio structure and then subsequently submit
> it to the block layer.  This significantly speeds up O_D on block device.
> 

Looks reasonable to me.  A few musings:

>  
> -static int
> -blkdev_get_blocks(struct inode *inode, sector_t iblock,
> -		struct buffer_head *bh, int create)
> +int blk_end_aio(struct bio *bio, unsigned int bytes_done, int error)
>  {
> -	sector_t end_block = max_block(I_BDEV(inode));
> -	unsigned long max_blocks = bh->b_size >> inode->i_blkbits;
> +	struct kiocb* iocb = bio->bi_private;
> +	atomic_t* bio_count = (atomic_t*) &iocb->private;

This atomic_t-in-a-void* thing is rather unpleasing.

It could be a new member of `struct kiocb', perhaps.

Please use " *" rather than "* ".

> +	long res;
> +
> +	if ((bio->bi_rw & 1) == READ)

bio_data_dir()

> +		bio_check_pages_dirty(bio);
> +	else {
> +		bio_release_pages(bio);
> +		bio_put(bio);
> +	}
>  
> -	if ((iblock + max_blocks) > end_block) {
> -		max_blocks = end_block - iblock;
> -		if ((long)max_blocks <= 0) {
> -			if (create)
> -				return -EIO;	/* write fully beyond EOF */
> -			/*
> -			 * It is a read which is fully beyond EOF.  We return
> -			 * a !buffer_mapped buffer
> -			 */
> -			max_blocks = 0;
> -		}
> +	if (error)
> +		iocb->ki_left = -EIO;
> +
> +	if (atomic_dec_and_test(bio_count)) {
> +		res = (iocb->ki_left < 0) ? iocb->ki_left : iocb->ki_nbytes;
> +		aio_complete(iocb, res, 0);
>  	}
>  
> -	bh->b_bdev = I_BDEV(inode);
> -	bh->b_blocknr = iblock;
> -	bh->b_size = max_blocks << inode->i_blkbits;
> -	if (max_blocks)
> -		set_buffer_mapped(bh);
>  	return 0;
>  }
>  
> +#define VEC_SIZE	16
> +struct pvec {
> +	unsigned short nr;
> +	unsigned short idx;
> +	struct page *page[VEC_SIZE];
> +};

Do we actually need this?  afaict all it does is saves an additional
function arg in a couple of places.

I guess it doesn't hurt though.

> +
> +struct page *blk_get_page(unsigned long addr, size_t count, int rw,
> +			  struct pvec *pvec)

Does this need kernel-wide scope?

A nice introductory comment explaining what it does would be, err, nice.

> +{
> +	int ret, nr_pages;
> +	if (pvec->idx == pvec->nr) {
> +		nr_pages = (addr + count + PAGE_SIZE - 1) / PAGE_SIZE -
> +			    addr / PAGE_SIZE;
> +		nr_pages = min(nr_pages, VEC_SIZE);
> +		down_read(&current->mm->mmap_sem);
> +		ret = get_user_pages(current, current->mm, addr, nr_pages,
> +				     rw==READ, 0, pvec->page, NULL);
> +		up_read(&current->mm->mmap_sem);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +		pvec->nr = ret;
> +		pvec->idx = 0;
> +	}
> +	return pvec->page[pvec->idx++];
> +}

hm, if get_user_pages() returns zero, badness ensues.

It won't do that, unless perhaps we passed it a zero nr_pages in the first
place.  We shouldn't do that.

Has this code been tested with zero-length writes?  And with iovecs which
contain a zero-length segment?


>  static ssize_t
>  blkdev_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
> -			loff_t offset, unsigned long nr_segs)
> +		 loff_t pos, unsigned long nr_segs)
>  {
> -	struct file *file = iocb->ki_filp;
> -	struct inode *inode = file->f_mapping->host;
> +	struct inode *inode = iocb->ki_filp->f_mapping->host;
> +	unsigned blkbits = blksize_bits(bdev_hardsect_size(I_BDEV(inode)));
> +	unsigned blocksize_mask = (1<< blkbits) - 1;
> +	unsigned long seg, nvec, cur_off, cur_len;
> +
> +	unsigned long addr;
> +	size_t count, nbytes = iocb->ki_nbytes;
> +	loff_t size;
> +	struct bio * bio;
> +	atomic_t *bio_count = (atomic_t *) &iocb->private;
> +	struct page *page;
> +	struct pvec pvec = {.nr = 0, .idx = 0, };

Please use one declaration per line (no commas).  That leaves you room for
a little comment alongside each local, explaining its operation.

This function needs little comments alongside each local, explaining their
operation.

> +	BUILD_BUG_ON(sizeof(atomic_t) > sizeof(iocb->private));

argh.  And if it triggers?

> +	size = i_size_read(inode);
> +	if (pos + nbytes > size)
> +		nbytes = size - pos;
> +
> +	seg = 0;
> +	addr = (unsigned long) iov[0].iov_base;
> +	count = iov[0].iov_len;
> +	atomic_set(bio_count, 1);
> +
> +	/* first check the alignment */
> +	if (addr & blocksize_mask || count & blocksize_mask ||
> +		pos & blocksize_mask)
> +		return -EINVAL;
> +
> +	while (nbytes) {
> +		/* roughly estimate number of bio vec needed */
> +		nvec = (nbytes + PAGE_SIZE - 1) / PAGE_SIZE;
> +		nvec = max(nvec, nr_segs - seg);
> +		nvec = min(nvec, (unsigned long) BIO_MAX_PAGES);
> +
> +		/* bio_alloc should not fail with GFP_KERNEL flag */
> +		bio = bio_alloc(GFP_KERNEL, nvec);
> +		bio->bi_bdev = I_BDEV(inode);
> +		bio->bi_end_io = blk_end_aio;
> +		bio->bi_private = iocb;
> +		bio->bi_sector = pos >> blkbits;
> +same_bio:
> +		cur_off = addr & ~PAGE_MASK;
> +		cur_len = PAGE_SIZE - cur_off;
> +		if (count < cur_len)
> +			cur_len = count;
> +
> +		page = blk_get_page(addr, count, rw, &pvec);
> +		if (unlikely(IS_ERR(page)))
> +			goto backout;
> +
> +		if (bio_add_page(bio, page, cur_len, cur_off)) {
> +			pos += cur_len;
> +			addr += cur_len;
> +			count -= cur_len;
> +			nbytes -= cur_len;
> +
> +			if (count)
> +				goto same_bio;
> +			if (++seg < nr_segs) {
> +				addr = (unsigned long) iov[seg].iov_base;
> +				count = iov[seg].iov_len;
> +				if (unlikely(addr & blocksize_mask ||
> +					     count & blocksize_mask))
> +					goto backout;
> +				goto same_bio;
> +			}
> +		}
> +
> +		/* bio is ready, submit it */
> +		if (rw == READ)
> +			bio_set_pages_dirty(bio);
> +		atomic_inc(bio_count);
> +		submit_bio(rw, bio);

This function can place a potentially unbounded amount of memory under IO. 
hence it can permit the user to pin a potentially unbounded amount of memry
for potentially unbounded amounts of time.  That "64" in dio_bio_reap() is
a lame attempt to limit this.

OK, so it's a privileged operation.

> +	}
> +
> +completion:
> +	nbytes = iocb->ki_nbytes = iocb->ki_nbytes - nbytes;

Kernel coding-style is super-simple-style.  Please avoid tricky things and
just do

	a = b;
	c = b;


> +	iocb->ki_pos += nbytes;
>  
> -	return blockdev_direct_IO_no_locking(rw, iocb, inode, I_BDEV(inode),
> -				iov, offset, nr_segs, blkdev_get_blocks, NULL);
> +	blk_run_address_space(inode->i_mapping);
> +	if (atomic_dec_and_test(bio_count))
> +		aio_complete(iocb, nbytes, 0);
> +
> +	return -EIOCBQUEUED;
> +
> +backout:
> +	/*
> +	 * back out nbytes count constructed so far for this bio,
> +	 * we will throw away current bio.
> +	 */
> +	nbytes -= bio->bi_size;
> +	bio_release_pages(bio);
> +	bio_put(bio);
> +
> +	/*
> +	 * if no bio was submmitted, return the error code.
> +	 * otherwise, proceed with pending I/O completion.
> +	 */
> +	if (atomic_read(bio_count) == 1)
> +		return PTR_ERR(page);
> +	goto completion;
>  }
>  
>  static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
> --- ./fs/read_write.c.orig	2006-11-29 13:57:37.000000000 -0800
> +++ ./fs/read_write.c	2006-12-04 17:30:34.000000000 -0800
> @@ -235,7 +235,7 @@ ssize_t do_sync_read(struct file *filp, 
>  
>  	init_sync_kiocb(&kiocb, filp);
>  	kiocb.ki_pos = *ppos;
> -	kiocb.ki_left = len;
> +	kiocb.ki_nbytes = kiocb.ki_left = len;

What's this doing here?


