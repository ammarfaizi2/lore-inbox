Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269865AbUIDKLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269865AbUIDKLk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIDKLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:11:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9152 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269865AbUIDKLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:11:34 -0400
Date: Sat, 4 Sep 2004 12:10:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, lkml@lpbproductions.com,
       Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 3ware queue depth [was: Re: HIGHMEM4G config for 1GB RAM on desktop?]
Message-ID: <20040904101008.GC1610@suse.de>
References: <200408021602.34320.swsnyder@insightbb.com> <1094030083l.3189l.2l@traveler> <1094030194l.3189l.3l@traveler> <200409010233.31643.lkml@lpbproductions.com> <1094032735l.3189l.7l@traveler> <20040901110944.A10160@infradead.org> <1094036919l.3189l.11l@traveler> <20040901194325.GA11762@beaverton.ibm.com> <1094077436l.22433l.3l@drinkel.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094077436l.22433l.3l@drinkel.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01 2004, Miquel van Smoorenburg wrote:
> On Wed, 01 Sep 2004 21:43:25, Patrick Mansfield wrote:
> >On Wed, Sep 01, 2004 at 11:08:39AM +0000, Miquel van Smoorenburg wrote:
> >
> >> +	/* make sure blockdev queue depth is at least 2 * scsi depth */
> >> +	if (SDptr->request_queue->nr_requests < 2 * max_cmds)
> >> +		SDptr->request_queue->nr_requests = 2 * max_cmds;
> >
> >Why would you want nr_requests different (and larger) only for this
> >driver?
> 
> Because for the Linux I/O scheduler to work, nr_requests needs to
> be at least twice as big as the scsi queue depth.

Well, basically if you want to have a chance to do any io scheduling
anywhere, you need to have more than 1 request to play with really. And
if the drive is swallowing all your requests all the time, you are
screwed. I do think the best option (as some people mentioned in this
thread) is to limit the 3ware queue depth, not increase the io scheduler
depth. At least for most of the current io schedulers, this will kill
your latency quite a bit.

> >Is modifying nr_requests allowed?
> 
> Well we need to do the same things that ll_rw_blk::queue_requests_store()
> does, only we don't need to worry about locking or existing queue
> contents since the queue has been instantiated but the scsi device
> is not active yet.
> 
> I do notice now however, that between 2.6.4 and 2.6.9-rc1
> blk_queue_congestion_threshold() has been added which we should
> probably call after adjusting nr_requests. Unfortunately it's
> a static function in ll_rw_blk.c ..
> 
> Perhaps we should export the functionality of queue_requests_store()
> as, say, queue_adjust_nr_requests() (like scsi_adjust_queue_depth) ?
> Jens ?

Yes, if you want to do this, we need to export a function to do it that
takes care of updating the block layer congestion (etc) data.

> Anyway, for now, perhaps the mucking with nr_requests should be
> taken out and a change like the above should be sent to the
> people at 3ware.

Indeed.

> I'll submit the sysfs code for inclusion in -mm and the nr_requests
> stuff to 3ware.

Great!

-- 
Jens Axboe

