Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSGXNdu>; Wed, 24 Jul 2002 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSGXNdu>; Wed, 24 Jul 2002 09:33:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30600 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317096AbSGXNds>;
	Wed, 24 Jul 2002 09:33:48 -0400
Date: Wed, 24 Jul 2002 15:36:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
Message-ID: <20020724133652.GH15201@suse.de>
References: <20020724132529.GD15201@suse.de> <Pine.SOL.4.30.0207241531200.15605-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207241531200.15605-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> On Wed, 24 Jul 2002, Jens Axboe wrote:
> 
> > On Wed, Jul 24 2002, Marcin Dalecki wrote:
> > > Jens Axboe wrote:
> > >
> > > >>>>2.5.27:drivers/block/ll_rw_blk.c
> > > >>>>void blk_start_queue(request_queue_t *q)
> > > >>>>{
> > > >>>>       if (test_and_clear_bit(QUEUE_FLAG_STOPPED, &q->queue_flags)) {
> > > >>>>               unsigned long flags;
> > > >>>>
> > > >>>>               spin_lock_irqsave(q->queue_lock, flags);
> > > >>>>               if (!elv_queue_empty(q))
> > > >>>>                       q->request_fn(q);
> > > >>>>               spin_unlock_irqrestore(q->queue_lock, flags);
> > > >>>>       }
> > > >>>>}
> > >
> > > >There were buggy versions at one point, however they may not have made it
> > > >into a full release. In that case it was just bk version of 2.5.19-pre
> > > >effectively. I forget the details :-)
> > >
> > > Naj - it's far more trivial I just looked at wrong tree at hand...
> > > But anyway. What happens if somone does set QUEUE_FLAG_STOPPED
> > > between the test_and_claer_bit and taking the spin_lock? Setting
> > > the QUEUE_FLAG_STOPPED isn't maintaining the spin_lock protection!
> >
> > It doesn't matter. If QUEUE_FLAG_STOPPED was set when entering
> > blk_start_queue(), it will call into the request_fn. If blk_stop_queue()
> > is called between clearing QUEUE_FLAG_STOPPED in blk_start_queue() and
> > grabbing the spin_lock, the worst that can happen is a spurios extra
> > request_fn call.
> >
> > > My goal is to make sure that the QUEUE_FLAG_STOPPED has a valid value
> > > *inside* the q->request_fn call.
> >
> > So you want the queue_lock to protect the flags as well... I don't
> > really see the point of this.
> 
> If driver corectly uses blk_start/stop_queue() it is not needed.
> Whole point of introducing this flag was not to take lock to check
> status of queue.

Right. The way it was meant to be used it how cpqarray and cciss does
it -- stopping queue in request_fn, restarting it from isr.

-- 
Jens Axboe

