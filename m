Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTENIXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTENIXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:23:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43425 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261322AbTENIXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:23:01 -0400
Date: Wed, 14 May 2003 10:32:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Bharata B Rao <bharata@in.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20030514083224.GC13456@suse.de>
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]> <20030513124807.A31823@in.ibm.com> <25840000.1052834304@[10.10.2.4]> <20030513181155.GL17033@suse.de> <20030514133843.H31823@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514133843.H31823@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Bharata B Rao wrote:
> On Tue, May 13, 2003 at 08:11:55PM +0200, Jens Axboe wrote:
> > > >  
> > > >  	/* For now we assume we have the device to ourselves */
> > > >  	/* Just a quick sanity check */
> > > > -	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
> > > > +	if (elv_next_request(bdev_get_queue(dump_bdev->bdev))) {
> > > >  		/* i/o in flight - safer to quit */
> > > >  		return -EBUSY;
> > > >  	}
> > 
> > this looks horribly racy (of the io scheduler internals corrupting
> > kind), I don't see you holding the queue lock here. some io schedulers
> > do non-significant amount of work inside they next_request functions,
> > moving from back-end lists to dispatch queue.
> > 
> 
> Jens,
> 
> All we want to do here is to check if there are requests in the
> queue. Hence thinking of using elv_queue_empty(). Do you think
> we still need to acquire queue lock for this ? This code will be
> run when we have stopped everything else in other cpus by putting
> them into spin.

That really has to be locked down as well. For your purpose, I think the
use of elv_queue_empty() is much better even though it really is an
internal function. The problem mainly comes from AS, that can have non
empty queue but still return NULL in elv_next_request().

But yes, it needs to be locked. If you have pinned the other CPUs, then
I suppose it should work. But it's still a violation of the locking
rules, and one would get in trouble dropping the queue lock from the io
scheduler elevator_queue_empty_fn. No one does that currently, but... So
please take the lock.

-- 
Jens Axboe

