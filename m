Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTCEJNZ>; Wed, 5 Mar 2003 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTCEJNZ>; Wed, 5 Mar 2003 04:13:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65259 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264992AbTCEJNW>;
	Wed, 5 Mar 2003 04:13:22 -0500
Date: Wed, 5 Mar 2003 10:21:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make nbd working in 2.5.x
Message-ID: <20030305092154.GH679@suse.de>
References: <11BAC7716B51@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11BAC7716B51@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03 2003, Petr Vandrovec wrote:
> On  3 Mar 03 at 19:39, Pavel Machek wrote:
> > >    we use nbd for our diskless systems, and it looks to me like that
> > > it has some serious problems in 2.5.x... Can you apply this patch
> > > and forward it to Linus? 
> > > 
> > > There were:
> > > * Missing disk's queue initialization
> > > * Driver should use list_del_init: put_request now verifies
> > >   that req->queuelist is empty, and list_del was incompatible
> > >   with this.
> > > * I converted nbd_end_request back to end_that_request_{first,last}
> > >   as I saw no reason why driver should do it itself... and 
> > >   blk_put_request has no place under queue_lock, so apparently when
> > >   semantic changed nobody went through drivers...
> > 
> > I do not think this is good idea. I am not sure who converted it to
> > bio, but he surely had good reason to do that.
> 
> I think that at the beginning of 2.5.x series there was some thinking
> about removing end_that_request* completely from the API. As it never
> happened, and __end_that_request_first()/end_that_request_last() has 
> definitely better quality (like that it does not ignore req->waiting...)
> than opencoded nbd loop, I prefer using end_that_request* over opencoding
> bio traversal.
> 
> If you want, then just replace blk_put_request() with __blk_put_request(),
> instead of first change. But I personally will not trust such code, as 
> next time something in bio changes nbd will miss this change again.

I agree with the change, there's no reason for nbd to implement its own
end_request handling. I was the one to do the bio conversion, doing XXX
drivers at one time...

A small correction to your patch, you need not hold queue_lock when
calling end_that_request_first() (which is the costly part of ending a
request), so

	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
		unsigned long flags;

		spin_lock_irqsave(q->queue_lock, flags);
		end_that_request_last(req);
		spin_unlock_irqrestore(q->queue_lock, flags);
	}

would be enough. That depends on the driver having pulled the request
off the list in the first place, which nbd has.

Also, it looks like it would be much better to simply let the queue lock
for a nbd_device be inherited from ndb_device->lo_lock.

-- 
Jens Axboe

