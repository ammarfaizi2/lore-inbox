Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBGBki>; Tue, 6 Feb 2001 20:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBGBk2>; Tue, 6 Feb 2001 20:40:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7940 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129250AbRBGBkS>;
	Tue, 6 Feb 2001 20:40:18 -0500
Date: Wed, 7 Feb 2001 02:39:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207023952.A15015@suse.de>
In-Reply-To: <20010207020221.B13647@suse.de> <Pine.LNX.4.10.10102061713160.2193-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102061713160.2193-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 05:19:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Linus Torvalds wrote:
> > I don't see anything that would break doing this, in fact you can
> > do this as long as the buffers are all at least a multiple of the
> > block size. All the drivers I've inspected handle this fine, noone
> > assumes that rq->bh->b_size is the same in all the buffers attached
> > to the request.
> 
> It's really easy to get this wrong when going forward in the request list:
> you need to make sure that you update "request->current_nr_sectors" each
> time you move on to the next bh.
> 
> I would not be surprised if some of them have been seriously buggered. 

Maybe have been, but it looks good at least with the general drivers
that I mentioned.

> [...] so I would be _really_ nervous about just turning it on
> silently. This is all very much a 2.5.x-kind of thing ;)

Then you might want to apply this :-)

--- drivers/block/ll_rw_blk.c~	Wed Feb  7 02:38:31 2001
+++ drivers/block/ll_rw_blk.c	Wed Feb  7 02:38:42 2001
@@ -1048,7 +1048,7 @@
 	/* Verify requested block sizes. */
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
-		if (bh->b_size % correct_size) {
+		if (bh->b_size != correct_size) {
 			printk(KERN_NOTICE "ll_rw_block: device %s: "
 			       "only %d-char blocks implemented (%u)\n",
 			       kdevname(bhs[0]->b_dev),

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
