Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317926AbSFNO5c>; Fri, 14 Jun 2002 10:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSFNO5b>; Fri, 14 Jun 2002 10:57:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18575 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317926AbSFNO5a>;
	Fri, 14 Jun 2002 10:57:30 -0400
Date: Fri, 14 Jun 2002 16:57:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020614145718.GA1120@suse.de>
In-Reply-To: <200206140156.SAA02512@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13 2002, Adam J. Richter wrote:
> 
> 	In the course of working on potential kernel crashes in
> ll_rw_kio and fs/mpage.c, I have been thinking that there has got
> to be a better way to more efficiently construct large I/O requests,
> and I now have an idea of how to do it, although it may at first
> seem to be regressing back to struct buffer_head.  Currently, most
> block IO operations will at best generate IO errors if bio_alloc
> starts to fail, and code that attempts to build big block IO's has
> to be a bit complex to build bio's that are as big as possible but
> still not too big or having too many IO vectors for whatever the
> underlying device driver says it is willing to handle.
> 
> 
> PROSOSAL:	struct bio *bio_chain(struct bio* old);
> 
> 	newbio = bio_chain(oldbio);
> 
> 	would be similar to:
> 		newbio = bio_alloc(GFP_KERNEL, 1);
> 		newbio->bi_bdev = oldbio->bi_bdev;
> 		newbio->bi_rw = oldbio->bi_rw;
> 		submit_bio(oldio);
> 
> 	...except for two important differences:
> 
> 	1. bio_chain NEVER gets a memory allocation failure.  If it is
> not able to allocate any memory, it fiddles with old->bi_destructor
> and waits for the "old" bio to complete, and returns the old bio.
> This is important because most current block device drivers will, at
> best, generate errors if they fail to allocate a bio.
> 
> 	2. bio_chain will set some kind of hint that newbio is
> probably contiguous with oldbio.  So, if oldbio is still on the
> device queue when newbio is eventually submitted, the merge code
> will first check the request that oldbio is in for merging.  So,
> the merging in that case will be O(1).  Also, if bio_chain is also
> used to submit newbio and it is able to do the merge, bio_chain can
> simply return the bio that was going to be discarded by the merge,
> since bio_chain is only defined to return a bio capable of holding
> one IO vector and all bio's in a request meet that criterion, and
> the bio being discarded by the merge will already have bi_bdev and
> bi_rw set to the correct values if it was mergeable in the first
> place.

I attempted something similar to this a long time ago, when analyzing
(and attempting to fix) i/o scheduler over head when submitting lots of
contigous buffer_heads. I know you mention that...

> 	I realize there may be locking issues in implementing this.

but I think that statement is very naive :-)

Essentially you are keeping a cookie to the old bio submitted, so that
you can merge new bio with it fairly cheaply (it's still not very cheap,
although you do eliminate the biggest offender, the list merge scan).
The first problem is that once you submit the bio, there are some things
that are not yours to touch anymore. You cannot change bi_next for
instance, you have no idea what state the bio is in wrt I/O completion.
Sure you can hold a reference to the bio, but all that really gets you
in this situation is a handle to it, nothing more. How do you decide
when to invalidate this cookie that you have?

For this to work, you would have to stall the request queue while all
this is in progress.

Now, I do agree with the reasoning for this -- the max_segments etc big
bio submission problem we currently have gets solved in a hell of a lot
nicer way than the max_iovecs() approach you have suggested. I don't
like that at all since I think that we will always just fall back to the
weakest link in the submission chain. The whole 'how big can this bio
be' question is a lot more complex than most people realise. It's not
just a matter of xxx sectors, or xxx pages. Once you get in to the phys
segments and hw segments problem, you end up with just saying 'build a
bio that does not violate the least restrictive rule'. Weakest link.

Then there's the matter of splitting bio's, which is always an ugly
topic. I agree that we don't want to do this, if avoidable.

So what do I like? As I see it, the only nice way to make sure that a
bio always has the best possible size is to just ask 'can we put another
page into this bio'. That way we can apply the right (and not just
minimum) limits every time.

-- 
Jens Axboe

