Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265870AbRGKTXq>; Wed, 11 Jul 2001 15:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265737AbRGKTXh>; Wed, 11 Jul 2001 15:23:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48906 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265972AbRGKTXX>;
	Wed, 11 Jul 2001 15:23:23 -0400
Date: Wed, 11 Jul 2001 21:20:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Anderson <mike.anderson@us.ibm.com>
Cc: Dipankar Sarma <dipankar@sequent.com>, linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010711212022.H712@suse.de>
In-Reply-To: <20010710172545.A8185@in.ibm.com> <20010710160512.A25632@us.ibm.com> <20010711142311.B9220@in.ibm.com> <20010711090257.B27097@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010711090257.B27097@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11 2001, Mike Anderson wrote:
> Dipankar Sarma [dipankar@sequent.com] wrote:
> > Hi Mike,
> > 
> > On Tue, Jul 10, 2001 at 04:05:12PM -0700, Mike Anderson wrote:
> > > The call to do_aic7xxx_isr appears that you are running the aic7xxx_old.c
> > > code. This driver is using the io_request_lock to protect internal data.
> > > The newer aic driver has its own lock. This is related to previous
> > > comments by Jens and Eric about lower level use of this lock.
> > 
> > There were some problems booting with the new aic7xxx driver and 2.4.4
> > kernel. This may have been fixed in later kernels, so we will check
> > this again. Besides, I wasn't aware that the new aic7xxx driver uses
> > a different locking model. Thanks for letting me know.
> > 
> > >  
> > >  I would like to know why the request_freelist is going empty? Having
> > >  __get_request_wait being called alot would appear to be not optimal.
> > 
> > It is not unreasonable for request IOCB pools to go empty, the important
> > issue is at what rate ? If a large portion of I/Os have to wait for
> > request structures to be freed, we may not be able to utilize the available
> > hardware bandwidth of the system optimally when we need, say, large
> > # of IOs/Sec. On the other hand, having large number of request structures
> > available may not necessarily give you large IOs/sec. The thing to look
> > at would be - how well are we utilizing the queueing capablility
> > of the hardware given a particular type of workload.
> 
> Jens, I think Dipankar might have stated my comment about questioning
> optimal utilization of a pool of resources shared by all device queues in
> the last sentence of the above paragraph. 
> 
> My thought was that if one has enough IO that cannot be merged on a queue
> you eat up request descriptors. If a request queue contains more requests
> than can be put in flight by the lower level to a spindle than this
> resource might be better used by other request queues.

True. In theory it would be possible to do request slot stealing from
idle queues, in fact it's doable without adding any additional overhead
to struct request. I did discuss this with [someone, forgot who] last
year, when the per-queue slots where introduced.

I'm not sure I want to do this though. If you have lots of disks, then
yes there will be some wastage if they are idle. IMO that's ok. What's
not ok and what I do want to fix is that slower devices get just as many
slots as a 15K disk for instance. For, say, floppy or CDROM devices we
really don't need to waste that much RAM. This will change for 2.5, not
before.

-- 
Jens Axboe

