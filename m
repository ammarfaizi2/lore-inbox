Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbWEOVCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWEOVCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWEOVCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:02:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965221AbWEOVCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:02:20 -0400
Date: Mon, 15 May 2006 14:04:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
Message-Id: <20060515140457.18991c2e.akpm@osdl.org>
In-Reply-To: <17511.51907.537657.656420@cse.unsw.edu.au>
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
	<20060512235934.4f609019.akpm@osdl.org>
	<17511.51907.537657.656420@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> ...
> 
> > >  I have a patch which did that,
> > > but decided that the possibility of kmalloc failure at awkward times
> > > would make that not suitable.
> > 
> > submit_bh() can and will allocate memory, although most decent device
> > drivers should be OK.
> > 
> 
> submit_bh (like all decent device drivers) uses a mempool for memory
> allocation so we can be sure that the delay in getting memory is
> bounded by the delay for a few IO requests to complete, and we can be
> sure the allocation won't fail.  This is perfectly fine.

My point is that some device drivers will apparently call into the mamory
allocator (should be GFP_NOIO) on the request submission path.  I don't
recall whcih drivers - but not mainstream ones.

> > > 
> > > I don't think a_ops really provides an interface that I can use, partly
> > > because, as I said in a previous email, it isn't really a public
> > > interface to a filesystem.
> > 
> > It's publicer than bmap+submit_bh!
> > 
> 
> I don't know how you can say that.

bmap() is a userspace API, not really a kernel one.  And it assumes a
block-backed filesystem.

> bmap is so public that it is exported to userspace through an IOCTL
> and is used by lilo (admitted only for reading, not writing).  More
> significantly it is used by swapfile which is a completely independent
> subsystem from the filesystem.  Contrast this with a_ops.  The primary
> users of a_ops are routines like generic_file_{read,write} and
> friends.  These are tools - library routines - that are used by
> filesystems to implement their 'file_operations' which are the real
> public interface.  As far as these uses go, it is not a public
> interface.  Where a filesystem doesn't use some library routines, it
> does not need to implement the matching functionality in the a_op
> interface.

Well yeah.  If one wants to do filesystem I/O in-kernel then one should use
the filesystem I/O entry points: read() and write() (and get flamed ;)).

If one wants to cut in at a lower level than that then we get into a pickle
because different types of filesytems do quite different things to
implement read() and write().

> The other main user is the 'VM' which might try to flush out or
> invalidate pages.  However the VM isn't using this interface to
> interact with files, but only to interact with pages, and it doesn't
> much care what is done with the pages providing they get clean, or get
> released, or whatever.
> 
> The way I perceive Linux design/development, active usage is far more
> significant than documented design.  If some feature of an interface
> isn't being actively used - by in-kernel code - then you cannot be
> sure that feature will be uniformly implemented, or that it won't
> change subtly next week.
> 
> So when I went looking for the best way to get md/bitmap to write to a
> file, I didn't just look at the interface specs (which are pretty
> poorly documented anyway), I looked at existing code.
> I can find 3 different parts of the kernel that write to a file.
> They are
>    swap-file
>    loop
>    nfsd
> 
> nfsd uses vfs_read/vfs_write  which have too many failure/delay modes
>   for me to safely use.
> loop uses prepare_write/commit_write (if available) or f_op->write
>   (not vfs_write - I wonder why) which is not much better than what
>   nfsd uses.  And as far as I can tell loop never actually flushes data to 
>   storage (hope no-one thinks a journalling filesystem on loop is a
>   good idea) so it isn't a good model to follow.
>   [[If loop was a good model to follow, I would have rejected the
>   code for writing to a file in the first place, only accepted code
>   for writing to a device, and insisted on using loop to close the gap]]
> 
> That leaves swap-file as the only in-kernel user of a filesystem that
> accesses the file in a way similar to what I need.  Is it any surprise
> that I chose to copy it?

swapfile doesn't use vfs_read() for swapin...

> 
> > 
> > But if the pagecache is dirty then invalidate_inode_pages() will leave it
> > dirty and the VM will later write it back, corrupting your bitmap file. 
> > You should get i_writecount, fsync the file and then run
> > invalidate_inode_pages().
> 
> Well, as I am currently reading the file through the pagecache.... but
> yes, I should put an fsync in there (and the invalidate before read is
> fairly pointless.  It is the invalidate after close that is important).

umm, the code in its present form _will_ corrupt MD bitmap files. 
invalidate_inode_pages() will not invalidate dirty pagecache, and that
dirty pagecache will later get written back, undoing any of your
intervening direct-io writes.  Most of the time, MD will do another
direct-io write _after_ the VM has done that writeback and things will get
fixed up.  But there is a window.  So that fsync() is required.

> > 
> > You might as well use kernel_read() too, if you insist on begin oddball ;)
> 
> I didn't know about that one..
> 
> If you would feel more comfortable with kernel_read I would be more
> than happy to use it.

We might as well save some code.

> In fact, if you can assure me that if I have an inode, and I have
>   confirmed that
>     bdi_cap_writeback_dirty(inode->i_mapping->backing_dev_info)
>    && inode->i_mapping->a_ops->readpage != NULL
> 
>   and have disabled truncation, either via i_write_count or otherwise,
>   then
>    - read_cache_page( .... ..a_ops->readpage ....)
>       will return a page that will, as long as I hold a counted reference,
>       remain in the page cache for that file at the appropriate address
>       (even though I don't hold it locked)

yup, as long as the page is pinned with get_page().

>    - set_page_dirty and write_one_page
>       will not fail, except with -EIO, and will not block waiting for
>       any writeback except for writeback of that file (e.g. won't do
>       any unprotected kmallocs)

Mostly.  There is a risk that ->writepage() will need to read filesystem
metadata to locate the page's blocks.  Most of the time that won't happen
because the page still has buffers attached.  You'd have to keep the pages
locked to prevent that.  But writepage() will unlock the page so there's
still a teeny window where the page could get its buffers taken away.  Plus
we don't know that the filesystem caches the disk mapping in the page's
buffers anyway (ext2 -o nobh, for example).


> then I'll be happy to go back to using that interface, though I guess I'd
> have to figure out what to do about redirty_page_for_writepage calls...
> 
> But if you can assure me of the above, then I'd be curious as to why
> swapfile doesn't use the readpage/writepage interface....

If we did that we'd need to memcpy the data between the swapfile pagecache
and swapcache whenever doing swapin and swapout.  Plus swap goes
direct-to-BIO to minimise the risk of doing memory allocations on the
swapout path.  And the swap code treats swapdevs and swapfiles identically.
And the swap code cannot pin all of the swapfile's pagecache in memory
(would make it rather pointless), whereas the MD bitmap code can afford to
do this.

Ho hum, I give up.  I don't think, in practice, this code fixes any
demonstrable bug though.

