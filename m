Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWDZF2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWDZF2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWDZF2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:28:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32601 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932377AbWDZF2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:28:07 -0400
Date: Wed, 26 Apr 2006 07:28:47 +0200
From: Jens Axboe <axboe@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060426052846.GW4102@suse.de>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de> <20060424145635.GH611485@melbourne.sgi.com> <20060424184730.GH29724@suse.de> <20060426023031.GH611708@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426023031.GH611708@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2006, David Chinner wrote:
> On Mon, Apr 24, 2006 at 08:47:30PM +0200, Jens Axboe wrote:
> > On Tue, Apr 25 2006, David Chinner wrote:
> > > On Mon, Apr 24, 2006 at 11:05:08AM +0200, Jens Axboe wrote:
> > > > 
> > > > Spoke too soon... The last part is actually on purpose, to prevent
> > > > really huge requests as part of normal file system IO.
> > > 
> > > I don't understand why this was considered necessary. It
> > > doesn't appear to be explained in any of the code so can you
> > > explain the problem that large filesystem I/Os pose to the block
> > > layer? We _need_ to be able to drive really huge requests from the
> > > filesystem down to the disks, especially for direct I/O.....
> > > 
> > > FWIW, we've just got XFS to the point where we could issue large
> > > I/Os (up to 8MB on 16k pages) with a default configuration kernel
> > > and filesystem using md+dm on an Altix. That makes an artificial
> > > 512KB filesystem I/O size limit a pretty major step backwards in
> > > terms of performance for default configs.....
> > 
> > The change was needed to safely split max_sectors into two sane parts:
> > 
> > - The soft value, ->max_sectors, that holds a sane default of maximum io
> >   size. The main issue we want to prevent is filling the queue with huge
> >   amounts of io, both from a pinning POV but also from user latency
> >   reasons.
> 
> Got any data that you can share with us?
> 
> Wrt latency, is the problem to do with large requests causing short
> term latency? I thought that latency minimisation is the job of the
> I/O scheduler, so if this is the case, doesn't this indicate a
> deficiency of the I/O scheduler? e.g. the I/o scheduler could split
> large requests to reduce latency, just like you merge adjacent
> requests to reduce the number of I/Os and keep overall latency
> low...

What would be the point of allowing you to build these large ios only to
split them up again? It's not only painfully inefficient, it's also
tricky to do since it requires extra allocations and no good place to do
it.

> And as to the pinning problem - if you have a problem with too much
> memory in the I/O queues, then the I/O queues are too deep or they
> need to be throttled based on the amount of data in them as well as
> the number of queued requests.  It's the method or configuration of
> the I/O scheduler being used to throttle requests that is deficient
> here, not the fact that a filesystem is building large I/Os.
> 
> It seems to me that you've crippled the block layer to solve very
> specific problems that most people don't see. I haven't seen pinning
> problems since the cfq request queue depth was reduced from 8192 to
> 128 and all the I/O latency problems I see are to do with multiple
> small I/Os being issued rather than a single large I/O....

I haven't crippled anything, in fact it's a lot more flexible now. I
don't know why you are whining, you have the exact same possibilities to
do large ios as you did before. Up max_sectors_kb.

8192 requests was nasty. And guess what, any recent ide or sata drive
should have 32768 as max_sectors_kb value. Multiply that by 128 * 2
(nr_requests * 2) and you have 8 times as much memory pinned in the
queue as 8192 requests did for IDE.

> > - The hard value, ->max_hw_sectors. Previously, there was no real clear
> >   definition of what ->max_sectors was supposed to do. We couldn't
> >   increase it to fit the hardware limits of most hardware, because that
> >   would hurt us latency/memory wise.
> 
> But we did have max_sectors = max_hw_sectors and I can't say that
> I've seen any evidence that it hurt us latency/memory wise.

Well good for you.

> > > > The best approach is probably to tune max_sectors on the system itself.
> > > > That's why it is exposed, after all.
> > > 
> > > You mean /sys/block/sd*/max_sector_kb?
> > 
> > Exactly.
> 
> Not happy. Now, instead of having a default config that works just fine,
> we've got to change the config of every block device on every boot
> on every machine we sell. This is a big deal when you're talking
> about machines with _thousands_ of block devices on them all needing
> to have their defaults changed.

Oh please, it's a simple operation. I doubt you put monkeys in front of
the machines doing this manually.

> BTW, can you point me to the discussion(s) that lead to this mod so
> I can catch up on this quickly? I can't find anything on lkml or
> linux-fsdevel about it....

See the postings from Mike Christie that led to the patches containing
this. WRT the max_sectors/max_hw_sectors splitup, see discussions from
the -RT people on long completion run times on large requests.

-- 
Jens Axboe

