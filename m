Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTA2QPE>; Wed, 29 Jan 2003 11:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbTA2QPE>; Wed, 29 Jan 2003 11:15:04 -0500
Received: from waste.org ([209.173.204.2]:14032 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S266175AbTA2QO4>;
	Wed, 29 Jan 2003 11:14:56 -0500
Date: Wed, 29 Jan 2003 10:24:12 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.5] Report write errors to applications
Message-ID: <20030129162411.GB3186@waste.org>
References: <20030129060916.GA3186@waste.org> <20030128232929.4f2b69a6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128232929.4f2b69a6.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 11:29:29PM -0800, Andrew Morton wrote:
> Oliver Xymoron <oxymoron@waste.org> wrote:
> >
> > Andrew, this is a forward-port of the 2.4 write error propagation
> > patch I just posted, applies against -mm6. Lightly tested on 2.5, but
> > should be straightforward.
> 
> You sent Marcelo the 2.5 patch.

Doh.

> > diff -urN -x '.patch*' -x '*.orig' orig/fs/buffer.c patched/fs/buffer.c
> > +++ patched/fs/buffer.c	2003-01-24 13:25:08.000000000 -0600
> > @@ -165,15 +165,27 @@
> >   * Default synchronous end-of-IO handler..  Just mark it up-to-date and
> >   * unlock the buffer. This is what ll_rw_block uses too.
> >   */
> > -void end_buffer_io_sync(struct buffer_head *bh, int uptodate)
> > +void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
> >  {
> >  	if (uptodate) {
> >  		set_buffer_uptodate(bh);
> >  	} else {
> > -		/*
> > -		 * This happens, due to failed READA attempts.
> > -		 * buffer_io_error(bh);
> > -		 */
> > +		/* This happens, due to failed READA attempts. */
> > +		clear_buffer_uptodate(bh);
> > +	}
> > +	unlock_buffer(bh);
> > +	put_bh(bh);
> > +}
> > +
> > +void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> > +{
> > +	if (uptodate) {
> > +		set_buffer_uptodate(bh);
> > +	} else {
> > +		buffer_io_error(bh);
> > +		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
> > +		       bdevname(bh->b_bdev));
> > +		bh->b_page->mapping->error = -EIO;
> 
> Accessing bh->b_page here could be risky.
> 
> In 2.5, this _has_ to be safe, because submit_bh() requires it.
> 
> But in 2.4 (and in thus-far-untested corners of 2.5) it is possible that
> someone is feeding a buffer_head with a garbage ->b_page into ll_rw_blk(). 

I actually looked at this a bit and it seemed fine. What are some
likely candidates? I'll take a look.

> Now it could be that we're safe in this respect (the comment above
> generic_make_request says that the caller must set up b_page, but
> perhaps lots of drivers do not look at it. Not sure...)
> 
> So what you could do here is to deliberately dereference bh->b_page even in
> the non-error case so those problems are quickly detected.

Enforcing it in 2.5 this way might make sense, but if it's actually a
problem in 2.4, I doubt that's acceptable at this point. Some form of this fix
needs to make it to 2.4, which is where the people with big disk farms
are going to be for at least the next year.
 
> But probably, there's not much point in doing any of this for ll_rw_blk() and
> end_buffer_io_sync().  Most of those buffers are against the blockdev
> mapping, and once the errors are propagated into the blockdev mapping's
> address space we no longer know what file they pertain to.

Ok, didn't realize how much this had changed in 2.5. This works nicely
for regular files in 2.4.

> It would be better to check the uptodate state of the buffer_head in
> drop_buffers(), and to propagate errors into the address_space there.  For
> buffers which are still attached to the S_ISREG file's address_space we're OK
> - fsync_buffers_list() will handle them and will return errors to the fsync()
> caller.  We only need to handle those buffers which were stripped
> asynchronously by VM activity.

Are we guaranteed that we'll get a try_to_free_buffers after IO
completion and before sync? I haven't dug through this path much.

> 
> >  		clear_buffer_uptodate(bh);
> >  	}
> >  	unlock_buffer(bh);
> > @@ -550,6 +562,9 @@
> >  		set_buffer_uptodate(bh);
> >  	} else {
> >  		buffer_io_error(bh);
> > +		printk(KERN_WARNING "lost page write due to I/O error on %s\n",
> > +		       bdevname(bh->b_bdev));
> > +		bh->b_page->mapping->error = -EIO;
> 
> 		page->mapping->error = -EIO;
> 
> would suffice here.

Will look at that.
 
> >  		clear_buffer_uptodate(bh);
> >  		SetPageError(page);
> >  	}
> > @@ -1201,7 +1216,7 @@
> >  		if (buffer_dirty(bh))
> >  			buffer_error();
> >  		get_bh(bh);
> > -		bh->b_end_io = end_buffer_io_sync;
> > +		bh->b_end_io = end_buffer_read_sync;
> >  		submit_bh(READ, bh);
> >  		wait_on_buffer(bh);
> >  		if (buffer_uptodate(bh))
> > @@ -2604,13 +2619,14 @@
> >  			continue;
> >  
> >  		get_bh(bh);
> > -		bh->b_end_io = end_buffer_io_sync;
> >  		if (rw == WRITE) {
> > +			bh->b_end_io = end_buffer_write_sync;
> >  			if (test_clear_buffer_dirty(bh)) {
> >  				submit_bh(WRITE, bh);
> >  				continue;
> >  			}
> >  		} else {
> > +			bh->b_end_io = end_buffer_read_sync;
> >  			if (!buffer_uptodate(bh)) {
> >  				submit_bh(rw, bh);
> >  				continue;
> > diff -urN -x '.patch*' -x '*.orig' orig/fs/inode.c patched/fs/inode.c
> > +++ patched/fs/inode.c	2003-01-24 13:24:26.000000000 -0600
> > @@ -134,6 +134,7 @@
> >  		mapping->dirtied_when = 0;
> >  		mapping->assoc_mapping = NULL;
> >  		mapping->backing_dev_info = &default_backing_dev_info;
> > +		mapping->error = 0;
> 
> Machines can have millions of address_spaces in-core and here you have used
> 32 bits where two would do.
> 
> Please make mapping->error an unsigned long and just use bits zero and one
> here for ENOSPC and EIO.  Make sure that atomic ops are used, and this way we
> get 30 spare bits in the address_space for future expansion.

I certainly thought about that (given your partial patch that did the
same with pages), but I couldn't see the point. We can return exactly
one error and given that they're all effectively "everything you did
since the last sync is hosed", there's no obvious way to choose among
them. There is no ENOSPC_AND_BTW_IO. As long as we're dedicating a new
structure member to this, why not simplify the logic and just track
the latest error?

If we're going to bother with this complexity, then we ought to merge
it with an existing element, for example, combine it with gfp_mask. If
you think that's worth the effort, I'll take a look at it. I don't
think this complexity makes sense for 2.4 though.

> > @@ -598,7 +598,7 @@
> >  			continue;
> >  		}
> >  		atomic_inc(&tbh->b_count);
> > -		tbh->b_end_io = end_buffer_io_sync;
> > +		tbh->b_end_io = end_buffer_read_sync;
> >  		submit_bh(READ, tbh);
> >  	}
> >  
> > diff -urN -x '.patch*' -x '*.orig' orig/fs/open.c patched/fs/open.c
> > +++ patched/fs/open.c	2003-01-24 13:24:26.000000000 -0600
> > @@ -843,21 +843,41 @@
> >   */
> >  int filp_close(struct file *filp, fl_owner_t id)
> >  {
> > -	int retval;
> > +	struct address_space *mapping = filp->f_dentry->d_inode->i_mapping;
> > +	struct inode	*inode = mapping->host;
> > +	int retval = 0, err;
> > +
> > +	/* Report and clear outstanding errors */
> > +	err = filp->f_error;
> > +	if (err) {
> > +		filp->f_error = 0;
> > +		retval = err;
> > +	}
> > +
> > +	down(&inode->i_sem);
> > +	err = mapping->error;
> > +	if (err && !retval) {
> > +		mapping->error = 0;
> > +		retval = err;
> > +	}
> 
> I don't really understand why you're reporting the error on close(). 
> Applications probably do not expect that.
>
> It would be better to report the error to the next call to fsync(),
> fdatasync() and msync().  Reporting it on close as well doesn't hurt, but
> *sync() should be the main reporting interface.

Yes, I do those too, there's a chunk that you don't appear to have
quoted from filemap which is in the common waiting path of all the sync
syscalls:

diff -urN -x '.patch*' -x '*.orig' orig/mm/filemap.c patched/mm/filemap.c
--- orig/mm/filemap.c	2003-01-24 13:24:21.000000000 -0600
+++ patched/mm/filemap.c	2003-01-24 13:24:26.000000000 -0600
@@ -185,6 +185,14 @@
 		write_lock(&mapping->page_lock);
 	}
 	write_unlock(&mapping->page_lock);
+
+	/* Check for outstanding write errors */
+	if (mapping->error)
+	{
+		ret = mapping->error;
+		mapping->error = 0;
+	}
+
 	return ret;
 }
 
Though it turns out a lot of apps _are_ checking close and not doing
sync (I believe this includes some of the standard fileutils).
 
> 
> > +	up(&inode->i_sem);
> 
> with test_and_clear_bit() against mapping->errors we can do away with the
> i_sem locking here.

I'm actually not really concerned about concurrent writers in the
close case. It inherently races with with the VM pushing pages out
anyway. And we already make no guarantees about _who_ the error gets
delivered to in the multiple writers case, so the case where two
simultaneous closers get errors is ok too. The above locking is just
cut and paste from the code that handles another class of inode error.
 
> +++ patched/mm/vmscan.c	2003-01-24 13:24:26.000000000 -0600
> @@ -342,6 +342,9 @@
>  				SetPageReclaim(page);
>  				res = mapping->a_ops->writepage(page, &wbc);
>  
> +				if (res < 0) {
> +					mapping->error = res;
> +				}
> 
> Most writepage() activity happens in fs/mpage.c - you'll need to propagate IO
> errors into the address_space in the BIO completion handlers there.

Another 2.5 change I hadn't noticed. Ok, will look at that. I haven't
come up with a good test for the writepage ENOSPC, thoughts?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
