Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264945AbTK3Qv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTK3Qv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:51:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43170 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264945AbTK3Qv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:51:56 -0500
Date: Sun, 30 Nov 2003 17:51:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130165146.GY10679@suse.de>
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <20031130162523.GV10679@suse.de> <3FCA1DD3.70004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA1DD3.70004@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sun, Nov 30 2003, Bartlomiej Zolnierkiewicz wrote:
> >>Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
> >>but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?
> >
> >
> >Probably because it's very dangerous to expose, echo something too big
> >and watch your data disappear.
> 
> 
> IMO, agreed.
> 
> Max KB per request really should be set by the driver, as it's a 
> hardware-specific thing that (as we see :)) is often errata-dependent.

Yes, it would be better to have a per-drive (or hwif) extra limiting
factor if it is needed. For this case it really isn't, so probably not
the best idea :)

> Tangent:  My non-pessimistic fix will involve submitting a single sector 
> DMA r/w taskfile manually, then proceeding with the remaining sectors in 
> another r/w taskfile.  This doubles the interrupts on the affected 
> chipset/drive combos, but still allows large requests.  I'm not terribly 

Or split the request 50/50.

> fond of partial completions, as I feel they add complexity, particularly 
> so in my case:  I can simply use the same error paths for both the 
> single-sector taskfile and the "everything else" taskfile, regardless of 
> which taskfile throws the error.

It's just a questions of maintaining the proper request state so you
know how much and what part of a request is pending. Requests have been
handled this way ever since clustered requests, that is why
current_nr_sectors differs from nr_sectors. And with hard_* duplicates,
it's pretty easy to extend this a bit. I don't see this as something
complex, and if the alternative you are suggesting (your implementation
idea is not clear to me...) is to fork another request then I think it's
a lot better.

Say you receive a request that violates the magic sector count rule. You
decide to do the first half of the request, and setup your taskfile for
that. You can diminish nr_sectors appropriately, or you can keep this
sector count in the associated taskfile - whatever you prefer. The
end_io path that covers both "normal" and partial IO is basically:

	if (!end_that_request_first(rq, 1, sectors))
		rq is done
	else
		rq state is now correctly the 2nd half

In the not-done case, you simply fall out of your isr as you would a
complete request, and let your request_fn just start it again. You don't
even know this request has already been processed.

Depending on whether you remove the request from the queue or not, you
just push the request to the top of the request queue so you are certain
that you start this one next.

So there's really nothing special about partial completions, rather full
completions are a one-shot partial completion :)

> (thinking out loud)  Though best for simplicity, I am curious if a 
> succession of "tiny/huge" transaction pairs are efficient?  I am hoping 
> that the drive's cache, coupled with the fact that each pair of 
> taskfiles is sequentially contiguous, will not hurt speed too much over 
> a non-errata configuration...

My gut would say rather two 64kb than a 124 and 4kb. But you should do
the numbers, of course :). I'd be surprised if the former wouldn't be
more efficient.

-- 
Jens Axboe

