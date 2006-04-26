Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWDZCas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWDZCas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDZCas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:30:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21173 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932349AbWDZCar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:30:47 -0400
Date: Wed, 26 Apr 2006 12:30:31 +1000
From: David Chinner <dgc@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060426023031.GH611708@melbourne.sgi.com>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de> <20060424145635.GH611485@melbourne.sgi.com> <20060424184730.GH29724@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424184730.GH29724@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 08:47:30PM +0200, Jens Axboe wrote:
> On Tue, Apr 25 2006, David Chinner wrote:
> > On Mon, Apr 24, 2006 at 11:05:08AM +0200, Jens Axboe wrote:
> > > 
> > > Spoke too soon... The last part is actually on purpose, to prevent
> > > really huge requests as part of normal file system IO.
> > 
> > I don't understand why this was considered necessary. It
> > doesn't appear to be explained in any of the code so can you
> > explain the problem that large filesystem I/Os pose to the block
> > layer? We _need_ to be able to drive really huge requests from the
> > filesystem down to the disks, especially for direct I/O.....
> > 
> > FWIW, we've just got XFS to the point where we could issue large
> > I/Os (up to 8MB on 16k pages) with a default configuration kernel
> > and filesystem using md+dm on an Altix. That makes an artificial
> > 512KB filesystem I/O size limit a pretty major step backwards in
> > terms of performance for default configs.....
> 
> The change was needed to safely split max_sectors into two sane parts:
> 
> - The soft value, ->max_sectors, that holds a sane default of maximum io
>   size. The main issue we want to prevent is filling the queue with huge
>   amounts of io, both from a pinning POV but also from user latency
>   reasons.

Got any data that you can share with us?

Wrt latency, is the problem to do with large requests causing short
term latency? I thought that latency minimisation is the job of the
I/O scheduler, so if this is the case, doesn't this indicate a
deficiency of the I/O scheduler? e.g. the I/o scheduler could split
large requests to reduce latency, just like you merge adjacent
requests to reduce the number of I/Os and keep overall latency
low...

And as to the pinning problem - if you have a problem with too much
memory in the I/O queues, then the I/O queues are too deep or they
need to be throttled based on the amount of data in them as well as
the number of queued requests.  It's the method or configuration of
the I/O scheduler being used to throttle requests that is deficient
here, not the fact that a filesystem is building large I/Os.

It seems to me that you've crippled the block layer to solve very
specific problems that most people don't see. I haven't seen pinning
problems since the cfq request queue depth was reduced from 8192 to
128 and all the I/O latency problems I see are to do with multiple
small I/Os being issued rather than a single large I/O....

> - The hard value, ->max_hw_sectors. Previously, there was no real clear
>   definition of what ->max_sectors was supposed to do. We couldn't
>   increase it to fit the hardware limits of most hardware, because that
>   would hurt us latency/memory wise.

But we did have max_sectors = max_hw_sectors and I can't say that
I've seen any evidence that it hurt us latency/memory wise.

> > > The best approach is probably to tune max_sectors on the system itself.
> > > That's why it is exposed, after all.
> > 
> > You mean /sys/block/sd*/max_sector_kb?
> 
> Exactly.

Not happy. Now, instead of having a default config that works just fine,
we've got to change the config of every block device on every boot
on every machine we sell. This is a big deal when you're talking
about machines with _thousands_ of block devices on them all needing
to have their defaults changed.

BTW, can you point me to the discussion(s) that lead to this mod so
I can catch up on this quickly? I can't find anything on lkml or
linux-fsdevel about it....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
