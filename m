Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRBGB4S>; Tue, 6 Feb 2001 20:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130639AbRBGB4H>; Tue, 6 Feb 2001 20:56:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130461AbRBGBzy>;
	Tue, 6 Feb 2001 20:55:54 -0500
Date: Wed, 7 Feb 2001 02:55:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207025524.C15015@suse.de>
In-Reply-To: <20010207023952.A15015@suse.de> <Pine.LNX.4.10.10102061741050.2193-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102061741050.2193-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 05:45:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Linus Torvalds wrote:
> > > [...] so I would be _really_ nervous about just turning it on
> > > silently. This is all very much a 2.5.x-kind of thing ;)
> > 
> > Then you might want to apply this :-)
> > 
> > --- drivers/block/ll_rw_blk.c~	Wed Feb  7 02:38:31 2001
> > +++ drivers/block/ll_rw_blk.c	Wed Feb  7 02:38:42 2001
> > @@ -1048,7 +1048,7 @@
> >  	/* Verify requested block sizes. */
> >  	for (i = 0; i < nr; i++) {
> >  		struct buffer_head *bh = bhs[i];
> > -		if (bh->b_size % correct_size) {
> > +		if (bh->b_size != correct_size) {
> >  			printk(KERN_NOTICE "ll_rw_block: device %s: "
> >  			       "only %d-char blocks implemented (%u)\n",
> >  			       kdevname(bhs[0]->b_dev),
> 
> Actually, I'd rather leave it in, but speed it up with the saner and
> faster
> 
> 	if (bh->b_size & (correct_size-1)) {
> 		...
> 
> That way people who _want_ to test the odd-size thing can do so. And
> normal code (that never generates requests on any other size than the
> "native" size) won't ever notice either way.

Fine, as I said I didn't spot anything bad so that's why it was changed.

> (Oh, we'll eventually need to move to "correct_size == hardware
> blocksize", not the "virtual blocksize" that it is now. As it it a tester
> needs to set the soft-blk size by hand now).

Exactly, wrt earlier mail about submitting < hw block size requests to
the lower levels.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
