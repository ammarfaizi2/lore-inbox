Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131124AbRBTXim>; Tue, 20 Feb 2001 18:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbRBTXic>; Tue, 20 Feb 2001 18:38:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50948 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131122AbRBTXiM>;
	Tue, 20 Feb 2001 18:38:12 -0500
Date: Wed, 21 Feb 2001 00:37:57 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: plugging in 2.4. Does it work?
Message-ID: <20010221003757.A1447@suse.de>
In-Reply-To: <20010220235400.A811@suse.de> <200102202327.f1KNRkc01834@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102202327.f1KNRkc01834@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Wed, Feb 21, 2001 at 12:27:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21 2001, Peter T. Breuer wrote:
> Actually I ignore the return value at present. I just wanted to know what
> happened. I haven't the faintest idea whether running end_that_request_last
> MEANS anything.

end_that_request_last most important job is up'ing any waiters on
the request (not usual), and put the now completed request back
on the queue free (or pending) list.

> > end_that_request_last, you are totally screwing the request
> > lists. Maybe this is what's going wrong?
> 
> At the time that end_request is run, it's on my own queue, not on the
> kernels queue. But I am eager for insight ... are you saying that
> after end_that_request_last has run, all bets are off, because the
> thing is completely vamooshed in every possible sense? I guess so.
> But fear not ... I've already taken it off my queue too. I really
> wanted the dequeue return value just in case maybe it would mean that
> I'd have to put it back on my queue and have another attempt at 
> acking it.

You cannot put it on different queues when you have run
end_that_request_last on it. For all you know, it may be a part
of a new I/O request as soon as you drop the io_request_lock.
That's why you have to dequeue prior to doing the final end_request, so
none of the lists the request may be on are destroyed.

> > > 1) setting read-ahead to 0 disables request agregation by some means of
> > > which I am not aware, and everything goes hunky dory.
> > 
> > Most likely what you are seeing happen is that we will do a
> > wait_on_buffer before we have a chance to merge this request on
> > the queue. Do writes, and you'll see lots of merging.
> 
> OK ... that sounds like something to avoid for a while! Wait_on_buffer,
> eh? If it makes things safe, I'm all for trying it myself!

When someones reads the data, that is. The only real reason (as you
discovered) that we get clustered reads is when a lot of read aheads
are queued. Or if the queue is already doing something else before
the request is started. This is not something you should do in your
driver, but it's worth while knowing about it so you can optimize
your driver for max performance.

> > There's no trick, and no required values. And there's really no special
> > trick to handling clustered requests. Either you are doing scatter
> > gather and setup your sg tables by going through the complete buffer
> > list on the request, or you are just transferring to rq->buffer the
> > amount specified by current_nr_sectors. That's it. Really.
> 
> Hurrr ... are you saying that the buffers in the bh's in the request are
> not contiguous?  My reading of the make_request code in 2.2 was that
> they were!  Has that changed?  There is now a reference to an elevator
> algorithm in the code, and I can't make out the effect by looking ... 
> I have been copying the buffer in the request as though it were a single
> contigous whole.  If that is not the case, then yes, bang would happen.

Nothing has changed in this regard at all between 2.2 and 2.4. The
buffers are guaranteed to be sequentially sector-wise, but definitely
not contigious in memory!

-- 
Jens Axboe

