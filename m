Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSJOKOe>; Tue, 15 Oct 2002 06:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSJOKOe>; Tue, 15 Oct 2002 06:14:34 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:61961 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264628AbSJOKOc>; Tue, 15 Oct 2002 06:14:32 -0400
Date: Tue, 15 Oct 2002 11:20:23 +0100
To: Jens Axboe <axboe@suse.de>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-lvm@sistina.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021015102023.GA3929@fib011235813.fsnet.co.uk>
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <1034614756.29775.5.camel@UberGeek.coremetrics.com> <20021014175608.GA14963@fib011235813.fsnet.co.uk> <20021015082152.GA4827@suse.de> <20021015093244.GA3782@fib011235813.fsnet.co.uk> <20021015093608.GF5294@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015093608.GF5294@suse.de>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 11:36:08AM +0200, Jens Axboe wrote:
> (btw, do you have a complete patch against a recent kernel?)

Split patches are in here and were built against whatever bk pulled
yesterday.

http://people.sistina.com/~thornber/patches/2.5-unstable

> Bouncing has just never been used with a cloned bio, so there might be a
> corner case or two that needs to be fixed up.

OK, in that case I think we have found one of those corner cases.
Please review the BUG_ON at the top of blk_queue_bounce.

> But walk me through your
> request handling, please. It seems you are always allocating a
> clone_info and bio clone for io?

Before I dive into what dm is doing now I'll describe a couple of
changes that I feel need to be made to the block layer.

Flushing mapped io
------------------

Whever a mapping driver changes the mapping of a device that is in use
it should ensure that any io already mapped with the previous
mapping/table has completed.  At the moment I do this by hooking the
bi_endio fn and incrementing an pending count (see
dm_suspend/dm_resume).  Your new merge_bvec_fn (which I like) means
that the request has effectively been partially remapped *before* it
gets into the request function.  ie. the request is now mapping
specific.  So before I can use merge_bvec_fn we need to move the
suspend/resume functionality up into ll_rw_block (eg, move the pending
count into the queue ?).  *Every* driver that dynamically changes a
mapping needs this functionality, LVM1 ignores it but is so simple it
*might* get away with it, dm certainly needs it, and I presume EVMS
has similar code in their application.

Agree ?


Splitting pages
---------------

ATM the merge_bvec_fn is a predicate which states whether a page
_can't_ be appended to a bio (a curious way round to do it).  The
driver will always have to contain code that copes with the case when
a mapping boundary occurs within a page (this happens).  I would
really like to go the whole hog and change the merge_fn so that it
returns how much of the page can be accepted.  As far as I can tell
(you're probably about to put me right), the only reason you haven't
done this is because:

/*
 * I/O completion handler for multipage BIOs.
 *
 * The mpage code never puts partial pages into a BIO (except for end-of-file).
 * If a page does not map to a contiguous run of blocks then it simply falls
 * back to block_read_full_page().
 *
 * Why is this?  If a page's completion depends on a number of different BIOs
 * which can complete in any order (or at the same time) then determining the
 * status of that page is hard.  See end_buffer_async_read() for the details.
 * There is no point in duplicating all that complexity.
 */

I believe it _is_ possible to implement this without incurring
significant CPU overhead or extra memory usage in the common case that
the mapping boundaries do occur on page breaks (This was another
reason why I was trying to get the users of bio_add_page using a
slightly higher level api that takes the bio submitting out of their
hands).

BTW: is there any point calling the merge_bvec_fn in bio_add_page when
the bios length is zero ?

dm splitting now
----------------

The splitting code as it exists ATM is ignoring the merge_bvec_fn.
I'm really not worried about performance yet, that said bonnie++
results are very similar on a raw partition or a dm mapping.

> request handling, please. It seems you are always allocating a
> clone_info and bio clone for io?

The clone_info is a little struct that sits on the stack, keeping
track of the splitting progress.  It is not dynamically allocated.

static void __split_bio(struct mapped_device *md, struct bio *bio)
{
	struct clone_info ci;

	...

	while (ci.sector_count)
		__clone_and_map(&ci);


If you look at the 2.4 version of dm you will see I'm using a struct
io_hook to keep track of mapped bios in order to maintain the pending
count for dm_suspend/dm_resume.  Since I will often need to allocate a
bio_clone anyway I decided to do away with the struct io_hook, and
always allocate the clone.

I will be very happy when the above two changes have been made to the
block layer and the request function can become a simple, single
remapping.  No splitting or memory allocations will then be
neccessary.

- Joe
