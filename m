Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129606AbRBGBqR>; Tue, 6 Feb 2001 20:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130135AbRBGBp5>; Tue, 6 Feb 2001 20:45:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10761 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129606AbRBGBpv>; Tue, 6 Feb 2001 20:45:51 -0500
Date: Tue, 6 Feb 2001 17:45:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207023952.A15015@suse.de>
Message-ID: <Pine.LNX.4.10.10102061741050.2193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Jens Axboe wrote:
> 
> > [...] so I would be _really_ nervous about just turning it on
> > silently. This is all very much a 2.5.x-kind of thing ;)
> 
> Then you might want to apply this :-)
> 
> --- drivers/block/ll_rw_blk.c~	Wed Feb  7 02:38:31 2001
> +++ drivers/block/ll_rw_blk.c	Wed Feb  7 02:38:42 2001
> @@ -1048,7 +1048,7 @@
>  	/* Verify requested block sizes. */
>  	for (i = 0; i < nr; i++) {
>  		struct buffer_head *bh = bhs[i];
> -		if (bh->b_size % correct_size) {
> +		if (bh->b_size != correct_size) {
>  			printk(KERN_NOTICE "ll_rw_block: device %s: "
>  			       "only %d-char blocks implemented (%u)\n",
>  			       kdevname(bhs[0]->b_dev),

Actually, I'd rather leave it in, but speed it up with the saner and
faster

	if (bh->b_size & (correct_size-1)) {
		...

That way people who _want_ to test the odd-size thing can do so. And
normal code (that never generates requests on any other size than the
"native" size) won't ever notice either way.

(Oh, we'll eventually need to move to "correct_size == hardware
blocksize", not the "virtual blocksize" that it is now. As it it a tester
needs to set the soft-blk size by hand now).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
