Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264634AbSJOK2u>; Tue, 15 Oct 2002 06:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSJOK2u>; Tue, 15 Oct 2002 06:28:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2445 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264634AbSJOK2r>;
	Tue, 15 Oct 2002 06:28:47 -0400
Date: Tue, 15 Oct 2002 12:34:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-lvm@sistina.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021015103427.GH5294@suse.de>
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <1034614756.29775.5.camel@UberGeek.coremetrics.com> <20021014175608.GA14963@fib011235813.fsnet.co.uk> <20021015082152.GA4827@suse.de> <20021015093244.GA3782@fib011235813.fsnet.co.uk> <20021015093608.GF5294@suse.de> <20021015102023.GA3929@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015102023.GA3929@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15 2002, Joe Thornber wrote:
> On Tue, Oct 15, 2002 at 11:36:08AM +0200, Jens Axboe wrote:
> > (btw, do you have a complete patch against a recent kernel?)
> 
> Split patches are in here and were built against whatever bk pulled
> yesterday.
> 
> http://people.sistina.com/~thornber/patches/2.5-unstable

ok

> > Bouncing has just never been used with a cloned bio, so there might be a
> > corner case or two that needs to be fixed up.
> 
> OK, in that case I think we have found one of those corner cases.
> Please review the BUG_ON at the top of blk_queue_bounce.

I remember this BUG_ON() and I also remember why I added it. It was
basically laziness, what it tells you is that blk_queue_bounce() is for
now expecting that it should iterate all vecs in a bio. It really needs
to go from bi_idx -> bi_vcnt. I _think_ this was when
bio_for_each_segment() meant iterating from 0 -> bi_vcnt. These days it
correctly does:

	#define bio_for_each_segment(bvl, bio, i)
		__bio_for_each_segment(bvl, bio, i, (bio)->bi_idx)

so blk_queue_bounce() could potentially Just Work if you remove the
BUG_ON() and count segments and size to set in the allocated bio instead
of just copying bio_orig bi_size and bi_vcnt. Oh, and start sector too.
It would be nice to have the bio->bi_voffset patches for this :-)

> > But walk me through your
> > request handling, please. It seems you are always allocating a
> > clone_info and bio clone for io?
> 
> Before I dive into what dm is doing now I'll describe a couple of
> changes that I feel need to be made to the block layer.
> 
> Flushing mapped io
> ------------------
> 
> Whever a mapping driver changes the mapping of a device that is in use
> it should ensure that any io already mapped with the previous
> mapping/table has completed.  At the moment I do this by hooking the
> bi_endio fn and incrementing an pending count (see
> dm_suspend/dm_resume).  Your new merge_bvec_fn (which I like) means
> that the request has effectively been partially remapped *before* it
> gets into the request function.  ie. the request is now mapping
> specific.  So before I can use merge_bvec_fn we need to move the
> suspend/resume functionality up into ll_rw_block (eg, move the pending
> count into the queue ?).  *Every* driver that dynamically changes a
> mapping needs this functionality, LVM1 ignores it but is so simple it
> *might* get away with it, dm certainly needs it, and I presume EVMS
> has similar code in their application.
> 
> Agree ?

Agreed, we definitely need some sort of suspend (and flush) + resume
queue hooks.

> Splitting pages
> ---------------
> 
> ATM the merge_bvec_fn is a predicate which states whether a page
> _can't_ be appended to a bio (a curious way round to do it).  The
> driver will always have to contain code that copes with the case when
> a mapping boundary occurs within a page (this happens).  I would

Yes

> really like to go the whole hog and change the merge_fn so that it
> returns how much of the page can be accepted.  As far as I can tell

Irk. This was in the first patches sent to Linus, but it gets ugly due
to several reason. More below.

> (you're probably about to put me right), the only reason you haven't
> done this is because:
> 
> /*
>  * I/O completion handler for multipage BIOs.
>  *
>  * The mpage code never puts partial pages into a BIO (except for end-of-file).
>  * If a page does not map to a contiguous run of blocks then it simply falls
>  * back to block_read_full_page().
>  *
>  * Why is this?  If a page's completion depends on a number of different BIOs
>  * which can complete in any order (or at the same time) then determining the
>  * status of that page is hard.  See end_buffer_async_read() for the details.
>  * There is no point in duplicating all that complexity.
>  */
> 
> I believe it _is_ possible to implement this without incurring
> significant CPU overhead or extra memory usage in the common case that
> the mapping boundaries do occur on page breaks (This was another
> reason why I was trying to get the users of bio_add_page using a
> slightly higher level api that takes the bio submitting out of their
> hands).

mpage wasn't really considered, it's a simple enough user that it can be
made to use basically any interface. The main reason is indeed the way
it is used right now, directly from any submitter of bio's.

I'd be happy to take patches that change how this works. First patch
could change merge_bvec_fn() to return number of bytes you can accept at
this location. This can be done without breaking anything else, as long
as bio_add_page() is changed to read:

	if (q->merge_bvec_fn) {
		ret = q->merge_bvec_fn(q, bio, bvec);
		if (ret != bvec->bv_len)
			return 1;
	}

Second patch can then add a wrapper around bio_add_page() for queueing a
range of pages for io to a given device. That solves the very problem
for not having this in the first place - having a single page in more
than one bio, this will break several bi_end_io() handling functions. If
you wrap submission and end_io, it could easily be made to work.

> BTW: is there any point calling the merge_bvec_fn in bio_add_page when
> the bios length is zero ?

Nah, not really.

> dm splitting now
> ----------------
> 
> The splitting code as it exists ATM is ignoring the merge_bvec_fn.
> I'm really not worried about performance yet, that said bonnie++
> results are very similar on a raw partition or a dm mapping.
> 
> > request handling, please. It seems you are always allocating a
> > clone_info and bio clone for io?
> 
> The clone_info is a little struct that sits on the stack, keeping
> track of the splitting progress.  It is not dynamically allocated.
> 
> static void __split_bio(struct mapped_device *md, struct bio *bio)
> {
> 	struct clone_info ci;
> 
> 	...
> 
> 	while (ci.sector_count)
> 		__clone_and_map(&ci);
> 
> 
> If you look at the 2.4 version of dm you will see I'm using a struct
> io_hook to keep track of mapped bios in order to maintain the pending
> count for dm_suspend/dm_resume.  Since I will often need to allocate a
> bio_clone anyway I decided to do away with the struct io_hook, and
> always allocate the clone.
> 
> I will be very happy when the above two changes have been made to the
> block layer and the request function can become a simple, single
> remapping.  No splitting or memory allocations will then be
> neccessary.

Ok fine.

-- 
Jens Axboe

