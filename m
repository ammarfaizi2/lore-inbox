Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTBJVuS>; Mon, 10 Feb 2003 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTBJVuS>; Mon, 10 Feb 2003 16:50:18 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:58242 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265339AbTBJVuO>;
	Mon, 10 Feb 2003 16:50:14 -0500
Date: Mon, 10 Feb 2003 22:59:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, mikulas@artax.karlin.mff.cuni.cz, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-ID: <20030210215940.GC22275@dualathlon.random>
References: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com> <20030210124000.456318e7.akpm@digeo.com> <20030210211806.GA22275@dualathlon.random> <20030210134434.72a59aed.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210134434.72a59aed.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 01:44:34PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Mon, Feb 10, 2003 at 12:40:00PM -0800, Andrew Morton wrote:
> > > 	void sync_dirty_buffer(struct buffer_head *bh)
> > > 	{
> > > 		lock_buffer(bh);
> > > 		if (test_clear_buffer_dirty(bh)) {
> > > 			get_bh(bh);
> > > 			bh->b_end_io = end_buffer_io_sync;
> > > 			submit_bh(WRITE, bh);
> > > 		} else {
> > > 			unlock_buffer(bh);
> > > 		}
> > > 	}
> > 
> > If you we don't take the lock around the mark_dirty_buffer as Linus
> > suggested (to avoid serializing in the non-sync case), why don't you
> > simply add lock_buffer() to ll_rw_block() as we suggested originally
> 
> That is undesirable for READA.

in 2.4 we killed READA some release ago becuse of races:

		case READA:
#if 0	/* bread() misinterprets failed READA attempts as IO errors on SMP */
			rw_ahead = 1;
#endif

so I wasn't focusing on it.

> > and
> > you #define sync_dirty_buffer as ll_rw_block+wait_on_buffer if you
> > really want to make the cleanup?
> 
> Linux 2.4 tends to contain costly confusion between writeout for memory
> cleansing and writeout for data integrity.
> 
> In 2.5 I have been trying to make it very clear and explicit that these are
> fundamentally different things.

yes, and these are in the memory cleansing area (only the journal
commits [and somehow the superblock again in journaling] needs to be
writeouts for data integrity). Data doesn't need to provide data
integrity either, userspace has to care about that.

> 
> > ...
> > Especially in 2.4 I wouldn't like to make the below change that is
> > 100% equivalent to a one liner patch that just adds lock_buffer()
> > instead of the test-and-set-bit (for reads I see no problems either).
> 
> That'd probably be OK, with a dont-do-that for READA.

Not an issue in 2.4. In 2.5 the bio is providing reada still though, so
it would be wrong to wait_on_buffer there.

> > BTW, Linus's way that suggests the lock around the data modifications
> > (unconditionally), would also enforce metadata coherency so it would
> > provide an additional coherency guarantee (but it's not directly related
> > to this problem and it may be overkill). Normally we always allow
> > in-core modifications of the buffer during write-IO to disk (also for
> > the data in pagecache). Only the journal commits must be very careful in
> > avoiding that (like applications must be careful to run fsync and not to
> > overwrite the data during the fsync). So normally taking the lock around
> > the in-core modification and mark_buffer_dirty, would be overkill IMHO.
> 
> Yup.  Except for a non-uptodate buffer.  If software is bringing a
> non-uptodate buffer uptodate by hand it should generally be locked, else a
> concurrent read may stomp on the changes.  There are few places where this
> happens.

I recall I fixed all those cases where we write a non uptodate buffer
under reads in ext2 in 2.2 with proper wait_on_buffers before modifying
the buffer. That was enough to guarantee any underlying read would
complete before we were going to touch the buffer. However today with
threading (if they're not protected against reads by the big kernel
lock) they should all be converted to lock_buffers(). they were easy to
spot grepping for getblk IIRC.

Andrea
