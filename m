Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRBTWyl>; Tue, 20 Feb 2001 17:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbRBTWyX>; Tue, 20 Feb 2001 17:54:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29700 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129490AbRBTWyU>;
	Tue, 20 Feb 2001 17:54:20 -0500
Date: Tue, 20 Feb 2001 23:54:00 +0100
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: plugging in 2.4. Does it work?
Message-ID: <20010220235400.A811@suse.de>
In-Reply-To: <200102202241.f1KMftG31691@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102202241.f1KMftG31691@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Tue, Feb 20, 2001 at 11:41:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20 2001, Peter T. Breuer wrote:
> More like "how does one get it to work".
> 
> Does anyone have a simple recipe for doing plugging right in 2.4?
> I'm doing something wrong.
> 
> When I disable plugging on my block driver (by registering a no-op
> plugging function), the driver works fine.  In particular my end_request
> code works fine - it does an if end_that_request_first return;
> end_that_request_last on the request to murder. Here it is
> 
>  int my_end_request(struct request *req) {
>    unsigned long flags; int dequeue = 0;
>    spin_lock_irqsave(&io_request_lock, flags);
>    if (!req->errors) {
>      while (req->nr_sectors > 0) {
>        printk( KERN_DEBUG "running end_first on req with %d sectors\n",
>               req->nr_sectors);
>        if (!end_that_request_first (req, !req->errors, DEVICE_NAME))
>          break;
>      }
>    }
>    printk( KERN_DEBUG "running end_first on req with %d sectors\n",
>             req->nr_sectors);
>    if (!end_that_request_first (req, !req->errors, DEVICE_NAME)) {
>      printk( KERN_DEBUG "running end_last on req with %d sectors\n",
>               req->nr_sectors);
>      end_that_request_last(req);
>      dequeue = 1;
>    }
>    spin_unlock_irqrestore(&io_request_lock, flags);
>    return dequeue;
>  }

Could this snippet possibly become more unreadable :-)
Firstly, I hope that the dequeue var does not return whether the 
request should be dequeued or not. Because if you do it after
end_that_request_last, you are totally screwing the request
lists. Maybe this is what's going wrong?

> I've discovered that
> 
> 1) setting read-ahead to 0 disables request agregation by some means of
> which I am not aware, and everything goes hunky dory.

Most likely what you are seeing happen is that we will do a
wait_on_buffer before we have a chance to merge this request on
the queue. Do writes, and you'll see lots of merging.

> 2) setting read-ahead to 4 or 8 seems to be safe. I see 4K requests
> being formed and treated OK.
> 
> 3) disabling plugging stops request aggretaion and makes everything
> safe.
> 
> Any clues? Is the trick just "powers of 2"? how is one supposed to
> handle plugging? Where is the canonical example. I can't see any driver
> that does it.

There's no trick, and no required values. And there's really no special
trick to handling clustered requests. Either you are doing scatter
gather and setup your sg tables by going through the complete buffer
list on the request, or you are just transferring to rq->buffer the
amount specified by current_nr_sectors. That's it. Really.

-- 
Jens Axboe

