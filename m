Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUCRHO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUCRHO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:14:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64934 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262441AbUCRHOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:14:25 -0500
Date: Thu, 18 Mar 2004 08:14:18 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: paul@paulbristow.net, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy driver 2.6.3 question
Message-ID: <20040318071418.GB1072@suse.de>
References: <200403172002.i2HK2GV10366@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403172002.i2HK2GV10366@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2004, Peter T. Breuer wrote:
> 
> 
> In the 2.6.3 floppy driver, when the driver is asked to revalidate by
> kernel check_disk_change (after the latter asks and the floppy signalled
> media_changed), the floppy driver constructs a read bio for the first
> block and submits it via submit_bio, and waits for completion of the
> bio.
> 
> However, the bio's embedded completion only signals back if the
> submitted bio was successful, as far as I can tell:
> 
> 
> static int floppy_rb0_complete(struct bio *bio, unsigned int bytes_done, int err)
> {
> 	if (bio->bi_size)
> 		return 1;
> 
> 	complete((struct completion*)bio->bi_private);
> 	return 0;
> }
> 
> Note that if the bi_size is nonzero, we return without signalling. Now
> bi_size starts out nozero
> 
>     bio.bi_size = size;
> 
> but I _think_ bi_size is zeroed along the way somewhere in end_request
> (who knows?) if all goes well, so that nonzero means we still have more
> to do in this bio. So if things go badly, completion is never signalled
> and the submitted read is waited for forever? (and the result is never
> tested).

You are completely missing how it works... ->bi_end_io() is invoked on
every io completion event that the hardware generates, but typically
most only care about the final completion (and not any eventual partial
completions along the way).

So driver calls end_request* which does a bio_endio() on the number of
sectors passed in, which in turn decrements bio->bi_size. _If_
bio->bi_size never hits zero, then you have a driver bug. If things 'go
badly', then the driver will signal unsuccessful completion of X
sectors.

> 
> 	submit_bio(READ, &bio);
> 	generic_unplug_device(bdev_get_queue(bdev));
> 	process_fd_request();
> 	wait_for_completion(&complete);
> 
> 	__free_page(page);
> 
> My reading therefore is that we cannot do revalidation until we are
> sure that the floppy is there. If we feel sure, but are wrong, the 
> test read of the first block will hang during the revalidation.

Wrong.

-- 
Jens Axboe

