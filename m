Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSGXOg3>; Wed, 24 Jul 2002 10:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSGXOg3>; Wed, 24 Jul 2002 10:36:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48782 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317329AbSGXOg1>;
	Wed, 24 Jul 2002 10:36:27 -0400
Date: Wed, 24 Jul 2002 16:39:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 Bitrot
Message-ID: <20020724143931.GG5159@suse.de>
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17Sai1-0002T7-00@starship> <20020711100828.GE808@suse.de> <E17WlGV-00052g-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17WlGV-00052g-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23 2002, Daniel Phillips wrote:
> On Thursday 11 July 2002 12:08, Jens Axboe wrote:
> > On Thu, Jul 11 2002, Daniel Phillips wrote:
> > > On Thursday 11 July 2002 08:47, Jens Axboe wrote:
> > > > Leonard has promised me to convert DAC960 to the "new" pci dma api for
> > > > years (or so it seems, actual date may vary, no purchase necessary). I
> > > > do have a Mylex controller here myself these days, so it's not
> > > > completely impossible that I may do it on a rainy day.
> > > 
> > > Well, tell me what the new api is and I'll dive in there.  For the record,
> > 
> > Documentation/DMA-mapping.txt. Also, DAC960 initial bio conversion
> > happened before the interface was finalized, so it may need changes in
> > that regard as well. Documentation/block/biodoc.txt is your friend there
> > :-)
> > 
> > a quick make drivers/block/DAC960.o shows the following stuff needs
> > changing immediately:
> > 
> > 1) q->queue_lock is a pointer to a lock, not the lock itself. Probably
> > add a per-controller spinlock to DAC960_Controller_T, and pass that to
> > blk_init_queue(). Then change DAC960_AcquireControllerLock and friends
> > in DAC960.h accordingly.
> 
> The big change here appears to be the move to per-device request queues.  
> Somebody apparently already started to update this driver (you?) but 
> obviously didn't try to compile it.  This is new territory for me, so I'll be 
> moving gingerly in here for a while.

Well not really, DAC960 is still using the default per-major queues. But
switching to per-device queue would definitely be a Really Good Idea.
The only changes I did to this driver where trivial conversions in the
2.5.1-pre days, in fact even before multi-page bio's existed. This,
btw, is also something you should keep an eye out for -- multi-page bio
support is currently broken. I would suggest also moving DAC960 to the
pci dma api (this is a must) and then move it to use the generic block
helpers for mapping requests. That way there isn't a lot of nasty
duplication there as well, plus it will automatically get the multi-page
issues right.

> For those locks, I just removed the &'s, which seems like the right thing to 
> do.   The "Controller" lock really seems to be a request queue lock.  Now I 
> think I need to allocate and initialize a request queue, possibly in 
> DAC960_CreateAuxiliaryStructures.  Am I getting warm?

If you move the queues to be per-device, then yes you can use the
Controller lock for the queue lock as well. It was made that way for
easy conversions. So basically embed a request_queue_t inside the
DAC960_Controller_T (god damnit, I'm having a hard time even just
writing these ugly names down here :-) and do something ala

	RequestQueue = = &Controller->ThisIsTheQueueYouAdded;
	spin_lock_init(&Controller->ThisIsTheLockYouAdded);
	blk_init_queue(RequestQueue, DAC960_RequestFunction, &Controller->ThisIsTheLockYouAdded);
	RequestQueue->queuedata = Controller;
	...

Hmm, is DAC960 using a full major per controller?!

But... This is the least of your worries. The major issue here is
updating it to the pci dma api. Once that is done, the rest is trivial
and will actually consist mainly of removing code, not adding.

-- 
Jens Axboe

