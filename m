Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbRGKIfQ>; Wed, 11 Jul 2001 04:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbRGKIfG>; Wed, 11 Jul 2001 04:35:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28650 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267228AbRGKIe7>; Wed, 11 Jul 2001 04:34:59 -0400
Date: Wed, 11 Jul 2001 14:09:23 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711140923.A9220@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010711091900.C17314@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010711091900.C17314@suse.de>; from axboe@suse.de on Wed, Jul 11, 2001 at 09:19:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Jul 11, 2001 at 09:19:00AM +0200, Jens Axboe wrote:
> On Tue, Jul 10 2001, Dipankar Sarma wrote:
> > In article <20010709214453.U16505@suse.de> you wrote:
> > > On Mon, Jul 09 2001, Jonathan Lahr wrote:
> > 
> > SPINLOCKS         HOLD            WAIT
> >   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
> > 
> >  0.07% 60.2%  0.5us( 4.0us)   72us( 920us)( 1.7%)    610820 39.8% 60.2%    0%    blk_get_queue+0x10
> > 
> > 1557496*26.7%*72us makes it about 30 seconds of time waiting for 
> > io_request_lock. That is nearly one-third of the total system time 
> > (about 98 seconds). As number of CPUs increase, this will likely
> > worsen.
> 
> Auch! That's pretty bad.
> 
> > It also seems that __make_request() holds the lock for the largest
> > amount of time. This hold time isn't likely to change significantly
> 
> __make_request -> elevator merge/insertion scan. This is what is taking
> all the time, not __make_request itself. With the bio-XX patches I have
> completely eliminated merge scans, so that can be done in O(1) time. For
> now insertion is still a O(N) scan, maybe that will change too [1].

I haven't got as far down as the elevator algorithm yet, but I would
like to, at some point in time. In any case, my point was that because
of disk block sorting done during initial queueing, there is likely
to be a slightly longer lock (per-queue or otherwise) hold time there compared
to, say, dequeueing for dispatch to lowlevel drivers.

Where can I get the bio patches from ?

> 
> > for a per-queue lock, but atleast it will not affect queueing i/o
> > requests to other devices. Besides, I am not sure if blk_get_queue()
> > really needs to grab the io_request_lock. blk_dev[] entries aren't
> 
> Funny, this is one thing I've been looking at too. blk_get_queue _will_
> die, don't worry. And yes, ie at open we can assign the queue. Or simply
> map it and protect it otherwise. It all ties in with being able to up or
> down a queue too, currently grabbing io_request_lock from blk_get_queue
> accomplishes exactly nothing and may as well be removed. If you do that,
> does it change the contention numbers significantly?

I haven't yet experimented with this yet, but theoritically speaking
yes, it should make a big difference. blk_get_queue() grabs the lock
very often and holds it for a very short period of time on average,
so it is the one that is affected most. Out of the 30 seconds of
spin-wait for io_request_lock, blk_get_queue() seems to take up
610820*60.2%*72us = 26.5 seconds. I will get to this soon though.

BTW, where can I get some of these lock-splitting patches from ? I
can do one myself for scsi+aic7xxx, but if there already exist some 
work, I would like to start off with them.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
