Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRBTX2L>; Tue, 20 Feb 2001 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131030AbRBTX2A>; Tue, 20 Feb 2001 18:28:00 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:44049 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S131018AbRBTX1x>;
	Tue, 20 Feb 2001 18:27:53 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200102202327.f1KNRkc01834@oboe.it.uc3m.es>
Subject: Re: plugging in 2.4. Does it work?
In-Reply-To: <20010220235400.A811@suse.de> from "Jens Axboe" at "Feb 20, 2001
 11:54:00 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Wed, 21 Feb 2001 00:27:46 +0100 (MET)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jens Axboe wrote:"
> On Tue, Feb 20 2001, Peter T. Breuer wrote:
> > More like "how does one get it to work".
[snip muddy end_request code]

Probably. I decided that accuracy might get a better response, though
I did have to expand the macros to get to this. It's really:

   io_spin_lock
   while (end_that_request_first(req ...);
   // one more time for luck
   if (!end_that_request_first(req ...) 
      end_that_request_last(req);
   io_spin_unlock

> Firstly, I hope that the dequeue var does not return whether the 
> request should be dequeued or not. Because if you do it after

Actually I ignore the return value at present. I just wanted to know what
happened. I haven't the faintest idea whether running end_that_request_last
MEANS anything.

> end_that_request_last, you are totally screwing the request
> lists. Maybe this is what's going wrong?

At the time that end_request is run, it's on my own queue, not on the
kernels queue. But I am eager for insight ... are you saying that
after end_that_request_last has run, all bets are off, because the
thing is completely vamooshed in every possible sense? I guess so.
But fear not ... I've already taken it off my queue too. I really
wanted the dequeue return value just in case maybe it would mean that
I'd have to put it back on my queue and have another attempt at 
acking it.

> > I've discovered that
> > 
> > 1) setting read-ahead to 0 disables request agregation by some means of
> > which I am not aware, and everything goes hunky dory.
> 
> Most likely what you are seeing happen is that we will do a
> wait_on_buffer before we have a chance to merge this request on
> the queue. Do writes, and you'll see lots of merging.

OK ... that sounds like something to avoid for a while! Wait_on_buffer,
eh? If it makes things safe, I'm all for trying it myself!

> > 2) setting read-ahead to 4 or 8 seems to be safe. I see 4K requests
> > being formed and treated OK.
> > 
> > 3) disabling plugging stops request aggretaion and makes everything
> > safe.
> > 
> > Any clues? Is the trick just "powers of 2"? how is one supposed to
> > handle plugging? Where is the canonical example. I can't see any driver
> > that does it.
> 
> There's no trick, and no required values. And there's really no special
> trick to handling clustered requests. Either you are doing scatter
> gather and setup your sg tables by going through the complete buffer
> list on the request, or you are just transferring to rq->buffer the
> amount specified by current_nr_sectors. That's it. Really.

Hurrr ... are you saying that the buffers in the bh's in the request are
not contiguous?  My reading of the make_request code in 2.2 was that
they were!  Has that changed?  There is now a reference to an elevator
algorithm in the code, and I can't make out the effect by looking ... 
I have been copying the buffer in the request as though it were a single
contigous whole.  If that is not the case, then yes, bang would happen.

My aim in allowing request aggregation was to reduce the number
of ioctl calls I do from the userspace-half of the driver, since I 
have to do one ioctl per request in the protocol. A P3 maxes out the
cpu with the driver at just about 300MB/s (cache speed) but I wanted to
go faster on other architectures.

I must apparently also call blk_init_queue, but yes I do.

Thanks for the reply Jens, I appreciate it.

Peter
