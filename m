Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUCRIXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUCRIXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:23:44 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:23991 "EHLO smtp02.uc3m.es")
	by vger.kernel.org with ESMTP id S262000AbUCRIXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:23:37 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403180823.i2I8NZs21184@oboe.it.uc3m.es>
Subject: Re: floppy driver 2.6.3 question
In-Reply-To: <20040318071418.GB1072@suse.de> from Jens Axboe at "Mar 18, 2004
 08:14:18 am"
To: Jens Axboe <axboe@suse.de>
Date: Thu, 18 Mar 2004 09:23:35 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks very much for the response, Jens. I appreciate it.


"Also sprach Jens Axboe:"
> On Wed, Mar 17 2004, Peter T. Breuer wrote:
> > 
> > In the 2.6.3 floppy driver, when the driver is asked to revalidate by
> > kernel check_disk_change (after the latter asks and the floppy signalled
> > media_changed), the floppy driver constructs a read bio for the first
> > block and submits it via submit_bio, and waits for completion of the
> > bio.
> > 
> > However, the bio's embedded completion only signals back if the
> > submitted bio was successful, as far as I can tell:
> > 
> > 
> > static int floppy_rb0_complete(struct bio *bio, unsigned int bytes_done, int err)
> > {
> > 	if (bio->bi_size)
> > 		return 1;
> > 
> > 	complete((struct completion*)bio->bi_private);
> > 	return 0;
> > }
> > 
> > Note that if the bi_size is nonzero, we return without signalling. Now
> > bi_size starts out nozero
> > 
> >     bio.bi_size = size;
> > 
> > but I _think_ bi_size is zeroed along the way somewhere in end_request
> > (who knows?) if all goes well, so that nonzero means we still have more
> > to do in this bio. So if things go badly, completion is never signalled
> > and the submitted read is waited for forever? (and the result is never
> > tested).
> 
> You are completely missing how it works... ->bi_end_io() is invoked on
> every io completion event that the hardware generates,

You are saying the floppy_rb0_complete is possibly called multiple times
(presumably by end_that_request_first, or whatever_it_is_called :)?  I
was not aware of that, but it makes sense, thank you. Once for each bio
in the request. But how can it be called multiple times for each bio?

I'm trying to understand the 2.6 block driver mechanisms  :-(.

It's hard btw to see from the code precisely what the args to the call
of bi_end_io in end_that_request_first are.  err seems to be either 0 or
-EIO (if the whole request was not uptodate) and bytes_done appears
always to be bi_size for the current bio. __make_request seems to be
able to generate a WOULDBLOCK error and bytes_done equal to the whole
request size. Yep - I'm confusicated as to whether there is some
invariant like bytes_done+bio->bi_size = const or not.


> but typically
> most only care about the final completion (and not any eventual partial
> completions along the way).

OK. Where approximately are the partial completion calls generated?


> So driver calls end_request* which does a bio_endio() on the number of
> sectors passed in, which in turn decrements bio->bi_size.

You know, I didn't see any such decrement in end_that-request_first.

> _If_
> bio->bi_size never hits zero, then you have a driver bug. If things 'go
> badly', then the driver will signal unsuccessful completion of X
> sectors.

Hmm, presumably in the case of unsuccessful completion, we still get
bio->b_size == 0 in the call to floppy_rb0_complete?  That's good.
Then we will always be signalled.


> > 	submit_bio(READ, &bio);
> > 	generic_unplug_device(bdev_get_queue(bdev));
> > 	process_fd_request();
> > 	wait_for_completion(&complete);
> > 
> > 	__free_page(page);
> > 
> > My reading therefore is that we cannot do revalidation until we are
> > sure that the floppy is there. If we feel sure, but are wrong, the 
> > test read of the first block will hang during the revalidation.
> 
> Wrong.

OK, you are saying that the complete will be signalled after the
request has been errored. Thank you very much for the explanation!

Peter
