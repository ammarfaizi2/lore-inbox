Return-Path: <linux-kernel-owner+w=401wt.eu-S1751429AbXAKTXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXAKTXA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXAKTW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:22:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60346 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751429AbXAKTW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:22:58 -0500
Message-ID: <45A68E55.10601@sgi.com>
Date: Thu, 11 Jan 2007 13:21:57 -0600
From: Michael Reed <mdr@sgi.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andrew Morton'" <akpm@osdl.org>, "'Zach Brown'" <zach.brown@oracle.com>,
       "'Chris Mason'" <chris.mason@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeremy Higdon <jeremy@sgi.com>, David Chinner <dgc@sgi.com>
Subject: Re: [patch] optimize o_direct on block device - v3
References: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>
In-Reply-To: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing on my ia64 system reveals that this patch introduces a
data integrity error for direct i/o to a block device.  Device
errors which result in i/o failure do not propagate to the
process issuing direct i/o to the device.

This can be reproduced by doing writes to a fibre channel block
device and then disabling the switch port connecting the host
adapter to the switch.

Can this patch be adjusted to take this into account?  Or pulled?
It was introduced with patch-2.6.19-git22.  I believe the commit
is e61c90188b9956edae1105eef361d8981a352fcd.

http://marc.theaimsgroup.com/?l=linux-scsi&m=116803117327546&w=2
http://marc.theaimsgroup.com/?l=linux-scsi&m=116838403700214&w=2

I'm happy to test any suggested fixes.

Thanks,
 Mike Reed
 SGI


Chen, Kenneth W wrote:
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
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> 
> ---
> This is v3 of the patch, I have addressed all the comments from Andrew,
> Christoph, and Zach.  Too many to list here for v2->v3 changes.  I've
> created 34 test cases specifically for corner cases and tested this patch.
> (my monkey test code is on http://kernel-perf.sourceforge.net/diotest).
> 
> 
> 
> diff -Nurp linux-2.6.19/fs/block_dev.c linux-2.6.19.ken/fs/block_dev.c
> --- linux-2.6.19/fs/block_dev.c	2006-11-29 13:57:37.000000000 -0800
> +++ linux-2.6.19.ken/fs/block_dev.c	2006-12-06 13:16:43.000000000 -0800
> @@ -129,43 +129,188 @@ blkdev_get_block(struct inode *inode, se
>  	return 0;
>  }
>  
> -static int
> -blkdev_get_blocks(struct inode *inode, sector_t iblock,
> -		struct buffer_head *bh, int create)
> +static int blk_end_aio(struct bio *bio, unsigned int bytes_done, int error)
>  {
> -	sector_t end_block = max_block(I_BDEV(inode));
> -	unsigned long max_blocks = bh->b_size >> inode->i_blkbits;
> +	struct kiocb *iocb = bio->bi_private;
> +	atomic_t *bio_count = &iocb->ki_bio_count;
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
> +	if (bio_data_dir(bio) == READ)
> +		bio_check_pages_dirty(bio);
> +	else {
> +		bio_release_pages(bio);
> +		bio_put(bio);
> +	}
> +
> +	/* iocb->ki_nbytes stores error code from LLDD */
> +	if (error)
> +		iocb->ki_nbytes = -EIO;
> +
> +	if (atomic_dec_and_test(bio_count)) {
> +		if (iocb->ki_nbytes < 0)
> +			aio_complete(iocb, iocb->ki_nbytes, 0);
> +		else
> +			aio_complete(iocb, iocb->ki_left, 0);
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
> +
> +#define PAGES_SPANNED(addr, len)	\
> +	(DIV_ROUND_UP((addr) + (len), PAGE_SIZE) - (addr) / PAGE_SIZE);
> +
> +/*
> + * get page pointer for user addr, we internally cache struct page array for
> + * (addr, count) range in pvec to avoid frequent call to get_user_pages.  If
> + * internal page list is exhausted, a batch count of up to VEC_SIZE is used
> + * to get next set of page struct.
> + */
> +static struct page *blk_get_page(unsigned long addr, size_t count, int rw,
> +				 struct pvec *pvec)
> +{
> +	int ret, nr_pages;
> +	if (pvec->idx == pvec->nr) {
> +		nr_pages = PAGES_SPANNED(addr, count);
> +		nr_pages = min(nr_pages, VEC_SIZE);
> +		down_read(&current->mm->mmap_sem);
> +		ret = get_user_pages(current, current->mm, addr, nr_pages,
> +				     rw == READ, 0, pvec->page, NULL);
> +		up_read(&current->mm->mmap_sem);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +		pvec->nr = ret;
> +		pvec->idx = 0;
> +	}
> +	return pvec->page[pvec->idx++];
> +}
> +
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
> +	unsigned long seg = 0;	/* iov segment iterator */
> +	unsigned long nvec;	/* number of bio vec needed */
> +	unsigned long cur_off;	/* offset into current page */
> +	unsigned long cur_len;	/* I/O len of current page, up to PAGE_SIZE */
> +
> +	unsigned long addr;	/* user iovec address */
> +	size_t count;		/* user iovec len */
> +	size_t nbytes = iocb->ki_nbytes = iocb->ki_left; /* total xfer size */
> +	loff_t size;		/* size of block device */
> +	struct bio * bio;
> +	atomic_t *bio_count = &iocb->ki_bio_count;
> +	struct page *page;
> +	struct pvec pvec = {.nr = 0, .idx = 0, };
> +
> +	if (pos & blocksize_mask)
> +		return -EINVAL;
> +
> +	size = i_size_read(inode);
> +	if (pos + nbytes > size) {
> +		nbytes = size - pos;
> +		iocb->ki_left = nbytes;
> +	}
> +
> +	/*
> +	 * check first non-zero iov alignment, the remaining
> +	 * iov alignment is checked inside bio loop below.
> +	 */
> +	do {
> +		addr = (unsigned long) iov[seg].iov_base;
> +		count = min(iov[seg].iov_len, nbytes);
> +		if (addr & blocksize_mask || count & blocksize_mask)
> +			return -EINVAL;
> +	} while (!count && ++seg < nr_segs);
> +	atomic_set(bio_count, 1);
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
> +			while (++seg < nr_segs) {
> +				addr = (unsigned long) iov[seg].iov_base;
> +				count = iov[seg].iov_len;
> +				if (!count)
> +					continue;
> +				if (unlikely(addr & blocksize_mask ||
> +					     count & blocksize_mask)) {
> +					page = ERR_PTR(-EINVAL);
> +					goto backout;
> +				}
> +				count = min(count, nbytes);
> +				goto same_bio;
> +			}
> +		}
> +
> +		/* bio is ready, submit it */
> +		if (rw == READ)
> +			bio_set_pages_dirty(bio);
> +		atomic_inc(bio_count);
> +		submit_bio(rw, bio);
> +	}
> +
> +completion:
> +	iocb->ki_left -= nbytes;
> +	nbytes = iocb->ki_left;
> +	iocb->ki_pos += nbytes;
> +
> +	blk_run_address_space(inode->i_mapping);
> +	if (atomic_dec_and_test(bio_count))
> +		aio_complete(iocb, nbytes, 0);
>  
> -	return blockdev_direct_IO_no_locking(rw, iocb, inode, I_BDEV(inode),
> -				iov, offset, nr_segs, blkdev_get_blocks, NULL);
> +	return -EIOCBQUEUED;
> +
> +backout:
> +	/*
> +	 * back out nbytes count constructed so far for this bio,
> +	 * we will throw away current bio.
> +	 */
> +	nbytes += bio->bi_size;
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
> diff -Nurp linux-2.6.19/include/linux/aio.h linux-2.6.19.ken/include/linux/aio.h
> --- linux-2.6.19/include/linux/aio.h	2006-11-29 13:57:37.000000000 -0800
> +++ linux-2.6.19.ken/include/linux/aio.h	2006-12-06 13:16:43.000000000 -0800
> @@ -105,6 +105,7 @@ struct kiocb {
>  	wait_queue_t		ki_wait;
>  	loff_t			ki_pos;
>  
> +	atomic_t		ki_bio_count;	/* num bio used for this iocb */
>  	void			*private;
>  	/* State that we remember to be able to restart/retry  */
>  	unsigned short		ki_opcode;
> diff -Nurp linux-2.6.19/fs/bio.c linux-2.6.19.ken/fs/bio.c
> --- linux-2.6.19/fs/bio.c	2006-11-29 13:57:37.000000000 -0800
> +++ linux-2.6.19.ken/fs/bio.c	2006-12-06 13:16:43.000000000 -0800
> @@ -931,7 +931,7 @@ void bio_set_pages_dirty(struct bio *bio
>  	}
>  }
>  
> -static void bio_release_pages(struct bio *bio)
> +void bio_release_pages(struct bio *bio)
>  {
>  	struct bio_vec *bvec = bio->bi_io_vec;
>  	int i;
> diff -Nurp linux-2.6.19/include/linux/bio.h linux-2.6.19.ken/include/linux/bio.h
> --- linux-2.6.19/include/linux/bio.h	2006-11-29 13:57:37.000000000 -0800
> +++ linux-2.6.19.ken/include/linux/bio.h	2006-12-06 13:16:43.000000000 -0800
> @@ -309,6 +309,7 @@ extern struct bio *bio_map_kern(struct r
>  				gfp_t);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
> +extern void bio_release_pages(struct bio *bio);
>  extern struct bio *bio_copy_user(struct request_queue *, unsigned long, unsigned int, int);
>  extern int bio_uncopy_user(struct bio *);
>  void zero_fill_bio(struct bio *bio);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
