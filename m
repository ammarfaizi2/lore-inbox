Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967964AbWLELCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967964AbWLELCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759944AbWLELCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:02:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53977 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759941AbWLELCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:02:39 -0500
Date: Tue, 5 Dec 2006 11:02:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Zach Brown'" <zach.brown@oracle.com>,
       Chris Mason <chris.mason@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] optimize o_direct on block device - v2
Message-ID: <20061205110230.GA13490@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Andrew Morton' <akpm@osdl.org>,
	'Zach Brown' <zach.brown@oracle.com>,
	Chris Mason <chris.mason@oracle.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <000001c71829$a3378900$ba88030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c71829$a3378900$ba88030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 08:55:50PM -0800, Chen, Kenneth W wrote:
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

I think this separation makes a lot of sense.  direct-io.c has to deal
with a lot of convuled issues that only arise on regular files, and
the block mapping is the most trivial part of that :)  While you're
at it please send a followup patch that removes the DIO_NO_LOCKING
code from direct-io.c as it's now unused and only needlessly complicates
the code.  (Hopefully we'll get down to one single variant one day..)

> --- ./fs/block_dev.c.orig	2006-11-29 13:57:37.000000000 -0800
> +++ ./fs/block_dev.c	2006-12-04 18:38:53.000000000 -0800
> @@ -129,43 +129,164 @@ blkdev_get_block(struct inode *inode, se
>  	return 0;
>  }
>  
> -static int
> -blkdev_get_blocks(struct inode *inode, sector_t iblock,
> -		struct buffer_head *bh, int create)
> +int blk_end_aio(struct bio *bio, unsigned int bytes_done, int error)

This should be static.

> +	struct kiocb* iocb = bio->bi_private;
> +	atomic_t* bio_count = (atomic_t*) &iocb->private;

The * placement is wrong all over.  This should be:

	struct kiocb *iocb = bio->bi_private;
	atomic_t *bio_count = (atomic_t *)&iocb->private;

> +	long res;
> +
> +	if ((bio->bi_rw & 1) == READ)

I just wanted to complain about not using a proper helper for this,
but apparently we don't have one yet..

> +		bio_check_pages_dirty(bio);
> +	else {
> +		bio_release_pages(bio);
> +		bio_put(bio);
> +	}

> +	if (error)
> +		iocb->ki_left = -EIO;
> +
> +	if (atomic_dec_and_test(bio_count)) {
> +		res = (iocb->ki_left < 0) ? iocb->ki_left : iocb->ki_nbytes;
> +		aio_complete(iocb, res, 0);
>  	}


I suspect this would be a lot more readable as:

	if (atomic_dec_and_test(bio_count)) {
		if (iocb->ki_left < 0)
			aio_complete(iocb, iocb->ki_left, 0);
		else
			aio_complete(iocb, iocb->ki_nbytes, 0);
	}

> +struct page *blk_get_page(unsigned long addr, size_t count, int rw,
> +			  struct pvec *pvec)

static, again.

> +{
> +	int ret, nr_pages;
> +	if (pvec->idx == pvec->nr) {
> +		nr_pages = (addr + count + PAGE_SIZE - 1) / PAGE_SIZE -
> +			    addr / PAGE_SIZE;
> +		nr_pages = min(nr_pages, VEC_SIZE);

Didn't someone say you should add a macro for this in the last round
of reviews?

> +		down_read(&current->mm->mmap_sem);
> +		ret = get_user_pages(current, current->mm, addr, nr_pages,
> +				     rw==READ, 0, pvec->page, NULL);

				     rw == READ

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
> +
> +	BUILD_BUG_ON(sizeof(atomic_t) > sizeof(iocb->private));
> +
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

You only use one iovec and simply ignore all others, that's a huge
regression over the existing functionality (and actually a bug that
causes silent data loss)

>  static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
> --- ./fs/read_write.c.orig	2006-11-29 13:57:37.000000000 -0800
> +++ ./fs/read_write.c	2006-12-04 17:30:34.000000000 -0800
> @@ -235,7 +235,7 @@ ssize_t do_sync_read(struct file *filp, 
>  
>  	init_sync_kiocb(&kiocb, filp);
>  	kiocb.ki_pos = *ppos;
> -	kiocb.ki_left = len;
> +	kiocb.ki_nbytes = kiocb.ki_left = len;

What's this for?  I don't think anyone should rely on kiocb.ki_left
beeing initialized.

