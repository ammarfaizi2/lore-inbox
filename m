Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLMDjC>; Tue, 12 Dec 2000 22:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQLMDiw>; Tue, 12 Dec 2000 22:38:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129572AbQLMDil>; Tue, 12 Dec 2000 22:38:41 -0500
Date: Tue, 12 Dec 2000 19:08:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Jasper Spaans <jasper@spaans.ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
In-Reply-To: <14902.49167.834682.925490@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.10.10012121900380.22326-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Neil Brown wrote:
> 
> Yes... you are right.  Alright, I can't escape it any other way so I
> guess I must admit that  it is a raid5 bug.
> 
> But how can raid5 be calling b_end_io on a buffer_head that was never
> passed to generic_make_request?
> Answer, it snoops on the buffer cache to try to do complete stripe
> writes.

Ahh, yes. It seems to just do a "get_hash_table()", and put that bh into
the queues. Bad.

> The following patch disabled that code.

If this fix makes the oops go away, then the proper fix for the problem is
not the #if 0, but do add something like

	bh->b_end_io = buffer_end_io_sync;

to just before the "add_stripe_bh(sh, bh, i, WRITE);"

We've already locked the thing, so that should be ok.

I wonder about that "md_test_and_set_bit(BH_Lock ...);" thing there,
though. If the buffer we find was dirty but already locked, we won't be
using that buffer at all (because the md_test_and_set_bit() will fail),
which probably means that the RAID5 checksum won't be right. Hmm..

Why is there an dirty aliased buffer head anyway? That sounds like a
recipe for disaster - maybe we should have synched all the stripe devices
before we set up the raid? Is that a raid5 rebuild issue? What's going on
here?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
