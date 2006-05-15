Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWEOA1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWEOA1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 20:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWEOA1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 20:27:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:45020 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750760AbWEOA1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 20:27:07 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 15 May 2006 10:26:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17511.51907.537657.656420@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
In-Reply-To: message from Andrew Morton on Friday May 12
References: <20060512160121.7872.patches@notabene>
	<1060512060809.8099@suse.de>
	<20060512104750.0f5cb10a.akpm@osdl.org>
	<17509.22160.118149.49714@cse.unsw.edu.au>
	<20060512235934.4f609019.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(replying to bits of several emails)

On Friday May 12, akpm@osdl.org wrote:
> Neil Brown <neilb@suse.de> wrote:

> > However some IO requests cannot complete until the filesystem I/O
> > completes, so we need to be sure that the filesystem I/O won't block
> > waiting for memory, or fail with -ENOMEM.
> 
> That sounds like a complex deadlock.  Suppose the bitmap writeout requres
> some writeback to happen before it can get enough memory to proceed.
> 

Exactly. Bitmap writeout must not block on fs-writeback.  It can block
on device writeout (e.g. queue congestion or mempool exhaustion) but
it must complete without waiting in the fs layer or above, and without
the possibility of any error other -EIO.  Otherwise we can get
deadlocked writing to the raid array. bh_submit (or bio_submit) is
certain to be safe in this respect.  I'm not so confident about
anything at the fs level.

> > > Read it with O_DIRECT :(
> > 
> > Which is exactly what the next release of mdadm does.
> > As the patch comment said:
> > 
> > : With this approach the pagecache may contain data which is inconsistent with 
> > : what is on disk.  To alleviate the problems this can cause, md invalidates
> > : the pagecache when releasing the file.  If the file is to be examined
> > : while the array is active (a non-critical but occasionally useful function),
> > : O_DIRECT io must be used.  And new version of mdadm will have support for this.
> 
> Which doesn't help `od -x' and is going to cause older mdadm userspace to
> mysteriously and subtly fail.  Or does the user<->kernel interface have
> versioning which will prevent this?
> 

As I said: 'non-critical'.  Nothing important breaks if reading the
file gets old data.  Reading the file while the array is active is
purely a curiosity thing.  There is information in /proc/mdstat which
gives a fairly coarse view of the same data.  It could lead to some
confusion, but if a compliant mdadm comes out before this gets into a
mainline kernel, I doubt there will be any significant issue.

Read/writing the bitmap needs to work reliably when the array is not
active, but suitable sync/invalidate calls in the kernel should make
that work perfectly.

I know this is technically a regression in user-space interface, and
you don't like such regression with good reason.... Maybe I could call
invalidate_inode_pages every few seconds or whenever the atime
changes, just to be on the safe side :-)

> >  I have a patch which did that,
> > but decided that the possibility of kmalloc failure at awkward times
> > would make that not suitable.
> 
> submit_bh() can and will allocate memory, although most decent device
> drivers should be OK.
> 

submit_bh (like all decent device drivers) uses a mempool for memory
allocation so we can be sure that the delay in getting memory is
bounded by the delay for a few IO requests to complete, and we can be
sure the allocation won't fail.  This is perfectly fine.

> > 
> > I don't think a_ops really provides an interface that I can use, partly
> > because, as I said in a previous email, it isn't really a public
> > interface to a filesystem.
> 
> It's publicer than bmap+submit_bh!
> 

I don't know how you can say that.

bmap is so public that it is exported to userspace through an IOCTL
and is used by lilo (admitted only for reading, not writing).  More
significantly it is used by swapfile which is a completely independent
subsystem from the filesystem.  Contrast this with a_ops.  The primary
users of a_ops are routines like generic_file_{read,write} and
friends.  These are tools - library routines - that are used by
filesystems to implement their 'file_operations' which are the real
public interface.  As far as these uses go, it is not a public
interface.  Where a filesystem doesn't use some library routines, it
does not need to implement the matching functionality in the a_op
interface.

The other main user is the 'VM' which might try to flush out or
invalidate pages.  However the VM isn't using this interface to
interact with files, but only to interact with pages, and it doesn't
much care what is done with the pages providing they get clean, or get
released, or whatever.

The way I perceive Linux design/development, active usage is far more
significant than documented design.  If some feature of an interface
isn't being actively used - by in-kernel code - then you cannot be
sure that feature will be uniformly implemented, or that it won't
change subtly next week.

So when I went looking for the best way to get md/bitmap to write to a
file, I didn't just look at the interface specs (which are pretty
poorly documented anyway), I looked at existing code.
I can find 3 different parts of the kernel that write to a file.
They are
   swap-file
   loop
   nfsd

nfsd uses vfs_read/vfs_write  which have too many failure/delay modes
  for me to safely use.
loop uses prepare_write/commit_write (if available) or f_op->write
  (not vfs_write - I wonder why) which is not much better than what
  nfsd uses.  And as far as I can tell loop never actually flushes data to 
  storage (hope no-one thinks a journalling filesystem on loop is a
  good idea) so it isn't a good model to follow.
  [[If loop was a good model to follow, I would have rejected the
  code for writing to a file in the first place, only accepted code
  for writing to a device, and insisted on using loop to close the gap]]

That leaves swap-file as the only in-kernel user of a filesystem that
accesses the file in a way similar to what I need.  Is it any surprise
that I chose to copy it?


> > > 
> > > I haven't looked at this patch at all closely yet.  Do I really need to?
> > 
> > I assume you are asking that because you hope I will retract the
> > patch.
> 
> Was kinda hoping that would be the outcome.  It's rather gruesome, using
> set_fs()+vfs_read() on one side and submit_bh() on the other.
> 

More gruesome than a_op->readpage on one side and bmap/submit_bio
on the other side like swapfile does?  However if it makes you happy I
can change the read side to anything that you suggest - submit_bh
would be the 'obvious' choice I guess.

> Are you sure the handling at EOF for a non-multiple-of-PAGE_SIZE file
> is OK?

I think so yes, but I will review it.
I assume that if bmap gave me a non-zero block number for the last
(partial) block, then it is safe to write that whole block.  I guess
that is a subtlety in semantics that no other user would be using.
However if a filesystem were packing the tail, then it would not be
able to return an integral block number for some fragments, so
hopefully it wouldn't for any.

> 
> But if the pagecache is dirty then invalidate_inode_pages() will leave it
> dirty and the VM will later write it back, corrupting your bitmap file. 
> You should get i_writecount, fsync the file and then run
> invalidate_inode_pages().

Well, as I am currently reading the file through the pagecache.... but
yes, I should put an fsync in there (and the invalidate before read is
fairly pointless.  It is the invalidate after close that is important).

> 
> You might as well use kernel_read() too, if you insist on begin oddball ;)

I didn't know about that one..

If you would feel more comfortable with kernel_read I would be more
than happy to use it.

In fact, if you can assure me that if I have an inode, and I have
  confirmed that
    bdi_cap_writeback_dirty(inode->i_mapping->backing_dev_info)
   && inode->i_mapping->a_ops->readpage != NULL

  and have disabled truncation, either via i_write_count or otherwise,
  then
   - read_cache_page( .... ..a_ops->readpage ....)
      will return a page that will, as long as I hold a counted reference,
      remain in the page cache for that file at the appropriate address
      (even though I don't hold it locked)
   - set_page_dirty and write_one_page
      will not fail, except with -EIO, and will not block waiting for
      any writeback except for writeback of that file (e.g. won't do
      any unprotected kmallocs)

then I'll be happy to go back to using that interface, though I guess I'd
have to figure out what to do about redirty_page_for_writepage calls...

But if you can assure me of the above, then I'd be curious as to why
swapfile doesn't use the readpage/writepage interface....

NeilBrown
