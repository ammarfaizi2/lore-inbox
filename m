Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUCRLfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbUCRLfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:35:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14217 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262540AbUCRLfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:35:09 -0500
Date: Thu, 18 Mar 2004 12:35:07 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy driver 2.6.3 question
Message-ID: <20040318113506.GL22234@suse.de>
References: <20040318091000.GA22234@suse.de> <200403181005.i2IA5lt32518@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <200403181005.i2IA5lt32518@oboe.it.uc3m.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18 2004, Peter T. Breuer wrote:
> > > request size. Yep - I'm confusicated as to whether there is some
> > > invariant like bytes_done+bio->bi_size = const or not.
> > 
> > I don't quite follow your last bytes_done+bio->bi_size, that doesn't
> > make any sense.
> 
> I mean that the call to bio->bi_endio carries a bytes_done arg, and
> that I suspect that the value of bio->bi_size at that point represents
> a "bytes_remaining_to_be_done", so that bytes_done+bio->bi_size will
> be an invariant.

bio->bi_size always represents the number of bytes that remain for io.

> > If __make_request() calls bio_endio() with the full
> > size, you get floppy_rb0_complete() invoked immediately with bi_size ==
> > 0, ie it completely ends the bio.
> 
> And the value of bytes_done in the call to bio->bi_endio presumably is
> tehn the full (original) size of the bio, so that the sum of the two
> represents a constant invariant?

bytes_done can be anything from (for fs code) 512 to bio->bi_size, in
multiples of 512.

> The reason why I was asking was because I was trying to figure out how
> to handle removable media correctly, and following the floppy driver.
> 
> The floppy driver sends out a read_block_0 bio on device revalidation
> and I was concerned because revalidation is called after a change of
> state, whether for better or worse! So if the floppy change is for the
> worse, then the bio will fail. But you have reassured me that it will
> fail and still complete, thus allowing revalidation to continue.

At least that's the way it works from the block layer, the assumption is
based on the fact that floppy isn't buggy and generates a completion on
the request with the failure set in that case. Normal behaviour.

> The floppy driver doesn't notice if the revalidation bio failed or not,
> btw (and I don't see an easy way of telling, hence my questions as to
> what the bi_size and bytes_done "really" mean - I can return them).  I
> suppose it can tell via the drive hardware what the state is. I also
> suppose reading the first block somehow triggers some kind of partition
> revision or other magic?

One way would be ala the attached, see how bio_endio() clears
BIO_UPTODATE on error.

> What hurts is that when I copy what the floppy driver does in my driver,
> then things hang in revalidation, with the submit_bio from the
> read_block_0 hanging in a "down" (not in my code), and attempts to open
> the device (which triggers the check_disk_change to run media_changed
> and revalidation) hang in schedule_io or schedule with no progress.
> 
> Leaving off the read_block_0 from the revalidation helps thinsg along,
> but the revalidation still seems fragile in some (as yet unknown) way,
> and eventually, after a few cycles of revalidation, opens on the device
> start to hang in a down or a io_schedule as before. I imagine that
> perhaps the down is the one waiting for a request, but I really don't
> know.  128 requests have just previously been errored due to readahead
> and the check_media_changed result setting the driver request function
> to error out requests.  Perhaps we have run out of requests (they're
> all put_ as far as I can see). Maybe the block layers get tired of
> talking to a device that errors requests. I'm just feeling my way!
> Any wild ideas are welcome!

If the 129th request fails, then that's a pretty good clue that you
aren't getting the requests freed. Perhaps you are overwriting something
in the request after allocating it? Always mask change ->flags (don't
just set it), and don't overwrite ->rl.

-- 
Jens Axboe


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=floppy-revalidate-failed-1

--- drivers/block/floppy.c~failed	2004-03-18 12:29:49.215713090 +0100
+++ drivers/block/floppy.c	2004-03-18 12:32:30.878313596 +0100
@@ -3892,11 +3892,16 @@
 	bio.bi_private = &complete;
 	bio.bi_end_io = floppy_rb0_complete;
 
+	bio_get(&bio);
 	submit_bio(READ, &bio);
 	generic_unplug_device(bdev_get_queue(bdev));
 	process_fd_request();
 	wait_for_completion(&complete);
 
+	if (!(bio.bi_flags & (1 << BIO_UPTODATE)))
+		printk("floppy: revalidation failed\n");
+
+	bio_put(&bio);
 	__free_page(page);
 
 	return 0;

--1yeeQ81UyVL57Vl7--
