Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269411AbRGaSqV>; Tue, 31 Jul 2001 14:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269414AbRGaSqL>; Tue, 31 Jul 2001 14:46:11 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:8709 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S269411AbRGaSpy>;
	Tue, 31 Jul 2001 14:45:54 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200107311845.f6VIjrK32444@oboe.it.uc3m.es>
Subject: Re: what's the semaphore in requests for?
In-Reply-To: From (env: ptb) at "Jul 31, 2001 00:26:22 am"
To: axboe@suse.de
Date: Tue, 31 Jul 2001 20:45:53 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"ptb wrote:"
> "Jens Axboe wrote:"
> > > > The reason I ask is that I've been chasing an smp bug in a block driver
> > > > code under 2.2.18) and only with smp ("nosmp" squashes it).  It only
> > > 2 processors + 1 userspace helper daemon on device = no bug 
> > > 2 processors + 2 userspace helper daemon on device = bug  (lockup)
> > > 1 processors + 1 userspace helper daemon on device = no bug 
> > > 1 processors + 2 userspace helper daemon on device = no bug 
> > And I'll restate here what I said then too -- SHOW THE CODE! Or send me
> > a crystal ball and I'll be happy to solve your races for you.

Let me try this question:

  Can the device request function be called from an interrupt?

(and is this newish?). I'm talking about when the plug is released.

All would be explained if the private spinlock were taken by the
request function on an interrupt when it was already held by the
ioctl functions that the userspace daemons use to transfer data
from the private queue up to userspace and back.

I thought the request function ran as requests were added to the
queue, which comes from pressure from the block layer.

> do_request(request_queue_t * q)
> {
>         struct dev_request *req;
> 
>         while (!QUEUE_EMPTY) {
>                 struct mydevice *dev;
> 
>                 req = CURRENT;
>                 dev = &dev_array[MINOR(req->rq_dev) >> SHIFT];
>                 blkdev_dequeue_request(req);
>                 write_lock(&dev->queue_spinlock);
>    // transfer req to the private queue
>                 list_add(&req->queue, &dev->queue);
>                 write_unlock(&dev->queue_spinlock);
>    // notify listeners
>                 wake_up_interruptible(& dev->wq);
>         }
> }

I now think the request function runs with interrupts disabled locally,
so the raw spinlock access is OK here. But it wasn't ok in the
ioctl functions? ...

> int 
> get_req (struct slot *slot, char *buffer)
> {
>     struct dev_request request;
>     struct request    *req;
>     int                result = 0;
>     unsigned           start_time = jiffies;
>     struct mydevice   *dev = slot->dev;
>     unsigned           timeout = dev->req_timeo * HZ;
>     extern struct timezone sys_tz;
> 
>     down (&dev->queue_lock);
>     read_lock(&dev->queue_spinlock);
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

since maybe the request function could have run in the context of an
interrupt while this spinlock was held, which deadlocks the cpu?

But then why doesn't the problem show itself with just one daemon
running on a 2cpu machine?

I've made more tests, and using irqsave on the private spinlock everywhere
seems to cure all ills. But I'm still very hazy as to what is going on.


Peter
