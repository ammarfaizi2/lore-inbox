Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTA2HT6>; Wed, 29 Jan 2003 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTA2HT6>; Wed, 29 Jan 2003 02:19:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:32245 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265037AbTA2HTx>;
	Wed, 29 Jan 2003 02:19:53 -0500
Date: Tue, 28 Jan 2003 23:29:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Report write errors to applications
Message-Id: <20030128232929.4f2b69a6.akpm@digeo.com>
In-Reply-To: <20030129060916.GA3186@waste.org>
References: <20030129060916.GA3186@waste.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 07:29:08.0866 (UTC) FILETIME=[1C82DE20:01C2C768]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
>
> Andrew, this is a forward-port of the 2.4 write error propagation
> patch I just posted, applies against -mm6. Lightly tested on 2.5, but
> should be straightforward.

You sent Marcelo the 2.5 patch.

> diff -urN -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
> --- orig/fs/buffer.c	2003-01-24 13:24:21.000000000 -0600
> +++ patched/fs/buffer.c	2003-01-24 13:25:08.000000000 -0600
> @@ -165,15 +165,27 @@
>   * Default synchronous end-of-IO handler..  Just mark it up-to-date and
>   * unlock the buffer. This is what ll_rw_block uses too.
>   */
> -void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
> +void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
>  {
>  	if (uptodate) {
>  		set_buffer_uptodate(bh);
>  	} else {
> -		/*
> -		 * This happens, due to failed READA attempts.
> -		 * buffer_io_error(bh);
> -		 */
> +		/* This happens, due to failed READA attempts. */
> +		clear_buffer_uptodate(bh);
> +	}
> +	unlock_buffer(bh);
> +	put_bh(bh);
> +}
> +
> +void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> +{
> +	if (uptodate) {
> +		set_buffer_uptodate(bh);
> +	} else {
> +		buffer_io_error(bh);
> +		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
> +		       bdevname(bh->b_bdev));
> +		bh->b_page->mapping->error = -EIO;

Accessing bh->b_page here could be risky.

In 2.5, this _has_ to be safe, because submit_bh() requires it.

But in 2.4 (and in thus-far-untested corners of 2.5) it is possible that
someone is feeding a buffer_head with a garbage ->b_page into ll_rw_blk(). 

Now it could be that we're safe in this respect (the comment above
generic_make_request says that the caller must set up b_page, but perhaps lots
of drivers do not look at it.  Not sure...)

So what you could do here is to deliberately dereference bh->b_page even in
the non-error case so those problems are quickly detected.



But probably, there's not much point in doing any of this for ll_rw_blk() and
end_buffer_io_sync().  Most of those buffers are against the blockdev
mapping, and once the errors are propagated into the blockdev mapping's
address space we no longer know what file they pertain to.

It would be better to check the uptodate state of the buffer_head in
drop_buffers(), and to propagate errors into the address_space there.  For
buffers which are still attached to the S_ISREG file's address_space we're OK
- fsync_buffers_list() will handle them and will return errors to the fsync()
caller.  We only need to handle those buffers which were stripped
asynchronously by VM activity.


>  		clear_buffer_uptodate(bh);
>  	}
>  	unlock_buffer(bh);
> @@ -550,6 +562,9 @@
>  		set_buffer_uptodate(bh);
>  	} else {
>  		buffer_io_error(bh);
> +		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
> +		       bdevname(bh->b_bdev));
> +		bh->b_page->mapping->error = -EIO;

		page->mapping->error = -EIO;

would suffice here.

>  		clear_buffer_uptodate(bh);
>  		SetPageError(page);
>  	}
> @@ -1201,7 +1216,7 @@
>  		if (buffer_dirty(bh))
>  			buffer_error();
>  		get_bh(bh);
> -		bh->b_end_io = end_buffer_io_sync;
> +		bh->b_end_io = end_buffer_read_sync;
>  		submit_bh(READ, bh);
>  		wait_on_buffer(bh);
>  		if (buffer_uptodate(bh))
> @@ -2604,13 +2619,14 @@
>  			continue;
>  
>  		get_bh(bh);
> -		bh->b_end_io = end_buffer_io_sync;
>  		if (rw == WRITE) {
> +			bh->b_end_io = end_buffer_write_sync;
>  			if (test_clear_buffer_dirty(bh)) {
>  				submit_bh(WRITE, bh);
>  				continue;
>  			}
>  		} else {
> +			bh->b_end_io = end_buffer_read_sync;
>  			if (!buffer_uptodate(bh)) {
>  				submit_bh(rw, bh);
>  				continue;
> diff -urN -x '.patch*' -x '*.orig' orig/fs/inode.c patched/fs/inode.c
> --- orig/fs/inode.c	2003-01-24 13:24:21.000000000 -0600
> +++ patched/fs/inode.c	2003-01-24 13:24:26.000000000 -0600
> @@ -134,6 +134,7 @@
>  		mapping->dirtied_when = 0;
>  		mapping->assoc_mapping = NULL;
>  		mapping->backing_dev_info = &default_backing_dev_info;
> +		mapping->error = 0;

Machines can have millions of address_spaces in-core and here you have used
32 bits where two would do.

Please make mapping->error an unsigned long and just use bits zero and one
here for ENOSPC and EIO.  Make sure that atomic ops are used, and this way we
get 30 spare bits in the address_space for future expansion.

> @@ -598,7 +598,7 @@
>  			continue;
>  		}
>  		atomic_inc(&tbh->b_count);
> -		tbh->b_end_io = end_buffer_io_sync;
> +		tbh->b_end_io = end_buffer_read_sync;
>  		submit_bh(READ, tbh);
>  	}
>  
> diff -urN -x '.patch*' -x '*.orig' orig/fs/open.c patched/fs/open.c
> --- orig/fs/open.c	2003-01-13 23:58:05.000000000 -0600
> +++ patched/fs/open.c	2003-01-24 13:24:26.000000000 -0600
> @@ -843,21 +843,41 @@
>   */
>  int filp_close(struct file *filp, fl_owner_t id)
>  {
> -	int retval;
> +	struct address_space *mapping = filp->f_dentry->d_inode->i_mapping;
> +	struct inode	*inode = mapping->host;
> +	int retval = 0, err;
> +
> +	/* Report and clear outstanding errors */
> +	err = filp->f_error;
> +	if (err) {
> +		filp->f_error = 0;
> +		retval = err;
> +	}
> +
> +	down(&inode->i_sem);
> +	err = mapping->error;
> +	if (err && !retval) {
> +		mapping->error = 0;
> +		retval = err;
> +	}

I don't really understand why you're reporting the error on close(). 
Applications probably do not expect that.

It would be better to report the error to the next call to fsync(),
fdatasync() and msync().  Reporting it on close as well doesn't hurt, but
*sync() should be the main reporting interface.


> +	up(&inode->i_sem);

with test_and_clear_bit() against mapping->errors we can do away with the
i_sem locking here.

--- orig/mm/vmscan.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/mm/vmscan.c	2003-01-24 13:24:26.000000000 -0600
@@ -342,6 +342,9 @@
 				SetPageReclaim(page);
 				res = mapping->a_ops->writepage(page, &wbc);
 
+				if (res < 0) {
+					mapping->error = res;
+				}

Most writepage() activity happens in fs/mpage.c - you'll need to propagate IO
errors into the address_space in the BIO completion handlers there.

