Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUCRKFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUCRKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:05:52 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:60387 "EHLO smtp02.uc3m.es")
	by vger.kernel.org with ESMTP id S262493AbUCRKFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:05:49 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403181005.i2IA5lt32518@oboe.it.uc3m.es>
Subject: Re: floppy driver 2.6.3 question
In-Reply-To: <20040318091000.GA22234@suse.de> from Jens Axboe at "Mar 18, 2004
 10:10:00 am"
To: Jens Axboe <axboe@suse.de>
Date: Thu, 18 Mar 2004 11:05:47 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Jens Axboe:"
> On Thu, Mar 18 2004, Peter T. Breuer wrote:
> > You are saying the floppy_rb0_complete is possibly called multiple times
> > (presumably by end_that_request_first, or whatever_it_is_called :)?  I
> 
> It is called from end_that_request_first -> bio_endio() -> bi_end_io().
> So _if_ the floppy driver uses partial completions (ie several calls to
> end_that_request_first(), not just one at the end), then
> floppy_rb0_complete will be called multiple times.

Thanks - seen it now, and the bi_size decrement in bio_endio.

> > request size. Yep - I'm confusicated as to whether there is some
> > invariant like bytes_done+bio->bi_size = const or not.
> 
> I don't quite follow your last bytes_done+bio->bi_size, that doesn't
> make any sense.

I mean that the call to bio->bi_endio carries a bytes_done arg, and
that I suspect that the value of bio->bi_size at that point represents
a "bytes_remaining_to_be_done", so that bytes_done+bio->bi_size will
be an invariant.

> If __make_request() calls bio_endio() with the full
> size, you get floppy_rb0_complete() invoked immediately with bi_size ==
> 0, ie it completely ends the bio.

And the value of bytes_done in the call to bio->bi_endio presumably is
tehn the full (original) size of the bio, so that the sum of the two
represents a constant invariant?

The reason why I was asking was because I was trying to figure out how
to handle removable media correctly, and following the floppy driver.

The floppy driver sends out a read_block_0 bio on device revalidation
and I was concerned because revalidation is called after a change of
state, whether for better or worse! So if the floppy change is for the
worse, then the bio will fail. But you have reassured me that it will
fail and still complete, thus allowing revalidation to continue.

The floppy driver doesn't notice if the revalidation bio failed or not,
btw (and I don't see an easy way of telling, hence my questions as to
what the bi_size and bytes_done "really" mean - I can return them).  I
suppose it can tell via the drive hardware what the state is. I also
suppose reading the first block somehow triggers some kind of partition
revision or other magic?

What hurts is that when I copy what the floppy driver does in my driver,
then things hang in revalidation, with the submit_bio from the
read_block_0 hanging in a "down" (not in my code), and attempts to open
the device (which triggers the check_disk_change to run media_changed
and revalidation) hang in schedule_io or schedule with no progress.

Leaving off the read_block_0 from the revalidation helps thinsg along,
but the revalidation still seems fragile in some (as yet unknown) way,
and eventually, after a few cycles of revalidation, opens on the device
start to hang in a down or a io_schedule as before. I imagine that
perhaps the down is the one waiting for a request, but I really don't
know.  128 requests have just previously been errored due to readahead
and the check_media_changed result setting the driver request function
to error out requests.  Perhaps we have run out of requests (they're
all put_ as far as I can see). Maybe the block layers get tired of
talking to a device that errors requests. I'm just feeling my way!
Any wild ideas are welcome!

Peter

