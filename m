Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUCRMXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUCRMXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:23:51 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:39342 "EHLO smtp03.uc3m.es")
	by vger.kernel.org with ESMTP id S262569AbUCRMXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:23:49 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200403181223.i2ICNkE13506@oboe.it.uc3m.es>
Subject: Re: floppy driver 2.6.3 question
In-Reply-To: <20040318113506.GL22234@suse.de> from Jens Axboe at "Mar 18, 2004
 12:35:07 pm"
To: Jens Axboe <axboe@suse.de>
Date: Thu, 18 Mar 2004 13:23:46 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Jens Axboe:"
> > The floppy driver doesn't notice if the revalidation bio failed or not,
> > btw (and I don't see an easy way of telling, hence my questions as to
> > what the bi_size and bytes_done "really" mean - I can return them).  I
> > suppose it can tell via the drive hardware what the state is. I also
> > suppose reading the first block somehow triggers some kind of partition
> > revision or other magic?
> 
> One way would be ala the attached, see how bio_endio() clears
> BIO_UPTODATE on error.

Very good. Applied. Thanks!

(do get_bio(&bio) before submit_bio(&bio) and do put_bio(&bio)
afterwards and examine bio.flags&BIO_UPTODATE on return from
wait_for_completion between the two).

> > know.  128 requests have just previously been errored due to readahead
> > and the check_media_changed result setting the driver request function
> > to error out requests.  Perhaps we have run out of requests (they're
> > all put_ as far as I can see). Maybe the block layers get tired of
> > talking to a device that errors requests. I'm just feeling my way!
> > Any wild ideas are welcome!
> 
> If the 129th request fails, then that's a pretty good clue that you
> aren't getting the requests freed. Perhaps you are overwriting something
> in the request after allocating it? Always mask change ->flags (don't
> just set it), and don't overwrite ->rl.

Good idea. rl is inviolate, but I set at least |=REQ_NOMERGE sometimes
on flags. And I pass ioctl information in fake requests by setting
the bit just beyond the edge of those currently used (__REQ_BITS) to
indicate its an ioctl and treating it specially in end request. Maybe
on error I forgot to remove the extra bit before doing put_blk_request
..

WIll look.

Thanks again.

Peter
