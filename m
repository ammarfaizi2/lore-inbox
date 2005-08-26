Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVHZG6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVHZG6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVHZG6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:58:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19384 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932537AbVHZG6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:58:31 -0400
Date: Fri, 26 Aug 2005 08:55:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jon Escombe <lists@dresco.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
Subject: Re: PATCH: ide: ide-disk freeze support for hdaps
Message-ID: <20050826065515.GQ4018@suse.de>
References: <253818670508250708a9075a0@mail.gmail.com> <58cb370e0508250859701ea571@mail.gmail.com> <253818670508252204b22e8c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253818670508252204b22e8c2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26 2005, Yani Ioannou wrote:
> > Please make the interface accept number of seconds (as suggested by Jens)
> > and remove this module parameter. This way interface will be more flexible
> > and cleaner.  I really don't see any advantage in doing "echo 1 > ..." instead
> > of "echo x > ..." (Pavel, please explain).
> 
> Either way is pretty easy enough to implement. Note though that I'd
> expect the userspace app should thaw the device when danger is out of
> the way (the timeout is mainly there to ensure that the queue isn't
> frozen forever, and should probably be higher). Personally I don't
> have too much of an opinion either way though... what's the consensus?
> :).

Yes please, I don't understand why you would want a 0/1 interface
instead, when the timer-seconds method gives you the exact same ability
plus a way to control when to unfreeze...

> > +static struct timer_list freeze_timer =
> > +       TIMER_INITIALIZER(freeze_expire, 0, 0);
> > 
> > There needs to be a timer per device not a global one
> > (it works for a current special case of T42 but sooner
> >  or later we will hit this problem).
> 
> I was considering that, but I am confused as to whether each drive has
> it's own queue or not? (I really am a newbie to this stuff...). If so
> then yes there should be a per-device timer.

Each drive has its own queue.

> > queue handling should be done through block layer helpers
> > (as described in Jens' email) - we will need them for libata too.
> 
> Good point, I'll try to move as much as I can up to the block layer,
> it helps when it comes to implementing freeze for libata as you point
> out too.

That includes things like the timer as well, reuse the queue plugging
timer as I described in my initial posting on how to implement this.

> > At this time attribute can still be in use (because refcounting is done
> > on drive->gendev), you need to add "disk" class to ide-disk driver
> > (drivers/scsi/st.c looks like a good example how to do it).
> 
> I missed that completely, I'll look at changing it.
> 
> > IMO this should also be handled by block layer
> > which has all needed information, Jens?
> > 
> > While at it: I think that sysfs support should be moved to block layer (queue
> > attributes) and storage driver should only need to provide queue_freeze_fn
> > and queue_thaw_fn functions (similarly to cache flush support).  This should
> > be done now not later because this stuff is exposed to the user-space.
> 
> I was actually considering using a queue attribute originally, but in
> my indecision I decided to go with Jen's suggestion. A queue attribute
> does make sense in that the attribute primarily is there to freeze the
> queue, but it would also be performing the head park. Would a queue
> attribute be confusing because of that?

I fully agree with Bart here. The only stuff that should be ide special
is the actual command setup and completion check, since that is a
hardware property. libata will get a few little helpers for that as
well. The rest should be block layer implementation.

> >                  * Sanity: don't accept a request that isn't a PM request
> >                  * if we are currently power managed. This is very important as
> >                  * blk_stop_queue() doesn't prevent the elv_next_request()
> > @@ -1661,6 +1671,9 @@ int ide_do_drive_cmd (ide_drive_t *drive
> >                 where = ELEVATOR_INSERT_FRONT;
> >                 rq->flags |= REQ_PREEMPT;
> >         }
> > +       if (action == ide_next)
> > +               where = ELEVATOR_INSERT_FRONT;
> > +
> >         __elv_add_request(drive->queue, rq, where, 0);
> >         ide_do_request(hwgroup, IDE_NO_IRQ);
> >         spin_unlock_irqrestore(&ide_lock, flags);
> > 
> > Why is this needed?
> 
> I think Jon discussed that in a previous thread, but basically
> although ide_next is documented in the comment for ide_do_drive_cmd,
> there isn't (as far as Jon or I could see) anything actually handling
> it. This patch is carried over from Jon's work and adds the code to
> handle ide_next by inserting the request at the front of the queue.

As per my previous mail, I will ack that bit.

> > Overall, very promising work!
> 
> Thanks :-), most of it is Jon's work, and Jen's suggestions though.

My name is Jens, not Jen :-)

-- 
Jens Axboe

