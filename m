Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWDZPmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWDZPmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWDZPmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:42:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41143 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964825AbWDZPmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:42:02 -0400
Date: Thu, 27 Apr 2006 01:41:47 +1000
From: David Chinner <dgc@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060426154147.GL611708@melbourne.sgi.com>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de> <20060424145635.GH611485@melbourne.sgi.com> <20060424184730.GH29724@suse.de> <20060426023031.GH611708@melbourne.sgi.com> <20060426052846.GW4102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426052846.GW4102@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 07:28:47AM +0200, Jens Axboe wrote:
> On Wed, Apr 26 2006, David Chinner wrote:
> > On Mon, Apr 24, 2006 at 08:47:30PM +0200, Jens Axboe wrote:
> > > The change was needed to safely split max_sectors into two sane parts:
> > > 
> > > - The soft value, ->max_sectors, that holds a sane default of maximum io
> > >   size. The main issue we want to prevent is filling the queue with huge
> > >   amounts of io, both from a pinning POV but also from user latency
> > >   reasons.
> > 
> > Got any data that you can share with us?
> > 
> > Wrt latency, is the problem to do with large requests causing short
> > term latency? I thought that latency minimisation is the job of the
> > I/O scheduler, so if this is the case, doesn't this indicate a
> > deficiency of the I/O scheduler? e.g. the I/o scheduler could split
> > large requests to reduce latency, just like you merge adjacent
> > requests to reduce the number of I/Os and keep overall latency
> > low...
> 
> What would be the point of allowing you to build these large ios only to
> split them up again?

Filesystems have good reasons to issue large I/Os.  Large I/Os for
XFS mean less locking and filesystem structure traversal (i.e CPU
usage) for a given load, we execute fewer and larger allocations, we
get better parallelism and scalability, less transactions are
required which means less log writes to the device, etc. There's a
few second order filesystem effects that I can think of like this
that result in reduced filesystem I/O load on the block device...

AFAICT, the latency issue you talk about is not a filesystem issue
but a block layer issue, so my question is why you saw this as
something the filesystems were doing wrong rather than a deficiency
with the I/O scheduler. I'm not advocating you do what I said,
I was illustrating a possible alternate approach to reducing
latency in the block layer when the filesystem issues large I/Os.

FWIW, I'd much prefer to do 2 concurrent 2MB I/Os than issue
2x(4x512KB) I/Os and hope that we don't get 8 seeks instead of 2.
Larger I/Os give far more consistent performance than the equivalent
throughput in small I/Os. On loads where latency matters,
consistent, predictable latency is preferable even if it means a
higher baseline latency.

> it's also
> tricky to do since it requires extra allocations and no good place to do
> it.

Allocation fails - means OOM, latency is already shot to pieces and
you can simply ship it to disk as it stands. And i'd think that
the place to split it would be in the merge function. My guess is
that dm and md would provide plenty of examples of what to do ;)

Like I said though, it was simply an example....

> > And as to the pinning problem - if you have a problem with too much
> > memory in the I/O queues, then the I/O queues are too deep or they
> > need to be throttled based on the amount of data in them as well as
> > the number of queued requests.  It's the method or configuration of
> > the I/O scheduler being used to throttle requests that is deficient
> > here, not the fact that a filesystem is building large I/Os.
> > 
> > It seems to me that you've crippled the block layer to solve very
> > specific problems that most people don't see. I haven't seen pinning
> > problems since the cfq request queue depth was reduced from 8192 to
> > 128 and all the I/O latency problems I see are to do with multiple
> > small I/Os being issued rather than a single large I/O....
> 
> I haven't crippled anything, in fact it's a lot more flexible now. I
> don't know why you are whining, you have the exact same possibilities to
> do large ios as you did before. Up max_sectors_kb.
> 
> 8192 requests was nasty.

I still have the scars.....

> And guess what, any recent ide or sata drive
> should have 32768 as max_sectors_kb value.

Please correct me if I'm wrong - my understanding is that a max_sectors_kb
this large is mostly irrelevant because the maximum size of an single I/O
linux can support:

#define BIO_MAX_PAGES           (256)

On a 4k page machine, we've already got a maximum of 1MB for an I/O.

And looking at at max_hw_segments or max_phys_segments, they both restrict the
size of the bio. Seems that most devices set them to 128 or 256 as well.

That means that on a 4k page machine 512k or 1MB are the most common largest
possible I/O sizes and hence the maximum amount of memory pinned is 32 or 64x
smaller than your original claim.

Also If that is correct, then capping max_sectors to 512KB can't do much
for reducing I/O latency or the amount of pinned memory on these systems
because they couldn't issue I/O much larger than this.

So I'm still not understanding the rationale behind the new default setting
of max_sectors....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
