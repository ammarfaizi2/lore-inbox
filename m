Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWITOxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWITOxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWITOxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:53:05 -0400
Received: from ns.suse.de ([195.135.220.2]:26813 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751581AbWITOxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:53:02 -0400
Date: Wed, 20 Sep 2006 16:53:01 +0200
From: Nick Piggin <npiggin@suse.de>
To: Chris Mason <chris.mason@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [rfc][patch 2.6.18-rc7] block: explicit plugging
Message-ID: <20060920145301.GB27347@wotan.suse.de>
References: <20060916115607.GA16971@wotan.suse.de> <20060918141031.GB2884@opti.oraclecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918141031.GB2884@opti.oraclecorp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 10:10:31AM -0400, Chris Mason wrote:
> On Sat, Sep 16, 2006 at 01:56:07PM +0200, Nick Piggin wrote:
> > Hi,
> > 
> > I've been tinkering with this idea for a while, and I'd be interested
> > in seeing what people think about it. The patch isn't in a great state
> > of commenting or splitting ;) but I'd be interested feelings about the
> > general approach, and whether I'm going to hit any bad problems (eg.
> > with SCSI or IDE).
> > 
> > Nick
> > 
> > 
> > This is a patch to perform block device plugging explicitly in the submitting
> > process context rather than implicitly by the block device.
> > 
> > There are several advantages to plugging in process context over plugging
> > by the block device:
> > 
> [ ... ]
> 
> > On a parallel tiobench benchmark, of the 800 000 calls to __make_request
> > performed, this patch avoids 490 000 (62%) of queue_lock aquisitions by
> > early merging on the private plugged list.
> 
> That is certainly interesting.  Intuitively, I would guess that having

I guess benchmarks will be interesting when it gets a bit further along.
I know Ken Chen had been very keen to minimise work in this area (althogh
I don't know how much help plugging would be to a direct-IO DB2 workload).

> the unplug per-process is going to slow down the case where multiple
> procs are banging on the dirty list for multiple files (ie for heavy
> memory pressure).  It feels like we're not going to merge as
> effectively, but your tiobench test should have hit that.  Did you look
> at elevator stats from the test?

I did, but tiobench is either very random or very linear, so it won't
show up as a problem there, I suspect.

But I hope merging shouldn't be harmed too much: we don't hold the
requests plugged for too long, and they end up going out to the queue
for public merging anyway. But I suspect that it is true to say, all
else being equal, delaying the propogation of requests to the queue
will harm merge chances.

Conversely, I suppose there is now less chance that the driver will
dequeue a request that we are likely to merge with (ie. previously
submitted one).

> > Testing and development is in early stages yet. In particular, the lack of
> > a timer based unplug kick probably breaks some block device drivers in
> > funny ways (though works here for me with SCSI and UML so far). Also needs
> > much wider testing.
> 
> Missed unplugs were a nasty problem.  We had a bunch of strange io
> stalls and deadlocks without the implicit unplugging, and we also
> managed to keep creating new ones as patches rolled into the block
> subsystem.  I would really like to keep some kind of catchall implicit
> unplug in there.

I think it should be OK in terms of missed unplugs, because we never
let the plugged context "escape" into the wider kernel while it is
still holding plugs. But as a debugging/testing aid, that might be
useful so I'll keep it in mind.

The bigger concern I have is some parts of scsi and ide seem to kind
of hijack the unplugging kick for use in some of their error/retry
mechanisms. These are probbly busted now, but they could be moved to
a SCSI/IDE specific timer/workqueue perhaps.

Nick
