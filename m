Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTCELaS>; Wed, 5 Mar 2003 06:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTCELaS>; Wed, 5 Mar 2003 06:30:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23474 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265276AbTCELaQ>;
	Wed, 5 Mar 2003 06:30:16 -0500
Date: Wed, 5 Mar 2003 12:38:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make nbd working in 2.5.x
Message-ID: <20030305113857.GA640@suse.de>
References: <11E385963D76@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E385963D76@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05 2003, Petr Vandrovec wrote:
> On  5 Mar 03 at 10:21, Jens Axboe wrote:
> > On Mon, Mar 03 2003, Petr Vandrovec wrote:
> > > On  3 Mar 03 at 19:39, Pavel Machek wrote:
> > > 
> > > I think that at the beginning of 2.5.x series there was some thinking
> > > about removing end_that_request* completely from the API. As it never
> > > happened, and __end_that_request_first()/end_that_request_last() has 
> > > definitely better quality (like that it does not ignore req->waiting...)
> > > than opencoded nbd loop, I prefer using end_that_request* over opencoding
> > > bio traversal.
> > > 
> > > If you want, then just replace blk_put_request() with __blk_put_request(),
> > > instead of first change. But I personally will not trust such code, as 
> > > next time something in bio changes nbd will miss this change again.
> > 
> > I agree with the change, there's no reason for nbd to implement its own
> > end_request handling. I was the one to do the bio conversion, doing XXX
> > drivers at one time...
> > 
> > A small correction to your patch, you need not hold queue_lock when
> > calling end_that_request_first() (which is the costly part of ending a
> > request), so
> > 
> >     if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
> >         unsigned long flags;
> > 
> >         spin_lock_irqsave(q->queue_lock, flags);
> >         end_that_request_last(req);
> >         spin_unlock_irqrestore(q->queue_lock, flags);
> >     }
> > 
> > would be enough. That depends on the driver having pulled the request
> > off the list in the first place, which nbd has.
> 
> But it also finishes whole request at once, so probably with:
> 
> if (!end_that_request_first(...)) { 
>    ...
> } else {
>   BUG();
> }

Sure

> I had patch for 2.5.3 which finished request partially after each chunk
> (usually 1500 bytes) received from server, but it did not make any 
> difference in performance at that time (probably because of the way
> nbd server works and speed of network between server and client). I'll 
> try it now again...

Yes that might still make sense, especially now since we actually pass
down partially completed chunks. But the bio end_io must support it, or
you will see now difference at all. And I don't think any of them do :).
Linus played with adding it to the multi-page fs helpers, but I think he
abandoned it. Should make larger read-aheads on slow media (floppy) work
a lot nicer, though.

-- 
Jens Axboe

