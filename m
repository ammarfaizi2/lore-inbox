Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWDZRyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWDZRyc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWDZRyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:54:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932285AbWDZRyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:54:31 -0400
Date: Wed, 26 Apr 2006 19:55:08 +0200
From: Jens Axboe <axboe@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060426175508.GE5002@suse.de>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de> <20060424145635.GH611485@melbourne.sgi.com> <20060424184730.GH29724@suse.de> <20060426023031.GH611708@melbourne.sgi.com> <20060426052846.GW4102@suse.de> <20060426154147.GL611708@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426154147.GL611708@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27 2006, David Chinner wrote:
> On Wed, Apr 26, 2006 at 07:28:47AM +0200, Jens Axboe wrote:
> > On Wed, Apr 26 2006, David Chinner wrote:
> > > On Mon, Apr 24, 2006 at 08:47:30PM +0200, Jens Axboe wrote:
> > > > The change was needed to safely split max_sectors into two sane parts:
> > > > 
> > > > - The soft value, ->max_sectors, that holds a sane default of maximum io
> > > >   size. The main issue we want to prevent is filling the queue with huge
> > > >   amounts of io, both from a pinning POV but also from user latency
> > > >   reasons.
> > > 
> > > Got any data that you can share with us?
> > > 
> > > Wrt latency, is the problem to do with large requests causing short
> > > term latency? I thought that latency minimisation is the job of the
> > > I/O scheduler, so if this is the case, doesn't this indicate a
> > > deficiency of the I/O scheduler? e.g. the I/o scheduler could split
> > > large requests to reduce latency, just like you merge adjacent
> > > requests to reduce the number of I/Os and keep overall latency
> > > low...
> > 
> > What would be the point of allowing you to build these large ios only to
> > split them up again?
> 
> Filesystems have good reasons to issue large I/Os.  Large I/Os for
> XFS mean less locking and filesystem structure traversal (i.e CPU
> usage) for a given load, we execute fewer and larger allocations, we
> get better parallelism and scalability, less transactions are
> required which means less log writes to the device, etc. There's a
> few second order filesystem effects that I can think of like this
> that result in reduced filesystem I/O load on the block device...

It's pretty clear that where you are coming from - the big server camp.
And yes, for those cases you pretty much always want huge ios. And yes,
you can get those, just set the exposed variable and be done with it. I
don't know why you are still making an issue of this or debating it...

> AFAICT, the latency issue you talk about is not a filesystem issue
> but a block layer issue, so my question is why you saw this as
> something the filesystems were doing wrong rather than a deficiency
> with the I/O scheduler. I'm not advocating you do what I said,
> I was illustrating a possible alternate approach to reducing
> latency in the block layer when the filesystem issues large I/Os.

It's actually a colaboration between the block layer / io scheduler and
the vm. The vm to some extent relies on the block layer throttling to
not have gigabytes or io in progress. I'm not too fond of that, but
that's the way it still is.

> FWIW, I'd much prefer to do 2 concurrent 2MB I/Os than issue
> 2x(4x512KB) I/Os and hope that we don't get 8 seeks instead of 2.
> Larger I/Os give far more consistent performance than the equivalent
> throughput in small I/Os. On loads where latency matters,
> consistent, predictable latency is preferable even if it means a
> higher baseline latency.

I agree. For most people it doesn't matter though, and the usecs spent
in completion is more important as it gives them skipless audio and
whatnot.

> > it's also
> > tricky to do since it requires extra allocations and no good place to do
> > it.
> 
> Allocation fails - means OOM, latency is already shot to pieces and
> you can simply ship it to disk as it stands. And i'd think that
> the place to split it would be in the merge function. My guess is
> that dm and md would provide plenty of examples of what to do ;)
> 
> Like I said though, it was simply an example....

It was a joke, there's no way on earth I'd ever add something like this.
It's pointless. Splitting is actually pretty tricky to get right (I'm
sure if you'd ever looked at dm splitting you would not be making such
suggestions). And since we are building these large ios in the first
place, the way to go is naturally to _disallow_ building something we
would split up later.

Take a look at how the buildup works, dm/md have hooks to say yay or nay
to adding another page to a bio.

> > And guess what, any recent ide or sata drive
> > should have 32768 as max_sectors_kb value.
> 
> Please correct me if I'm wrong - my understanding is that a max_sectors_kb
> this large is mostly irrelevant because the maximum size of an single I/O
> linux can support:
> 
> #define BIO_MAX_PAGES           (256)
> 
> On a 4k page machine, we've already got a maximum of 1MB for an I/O.

Not quite true. It's the largest size of a bio, but you can have
multiple bios tied to a request.

> And looking at at max_hw_segments or max_phys_segments, they both
> restrict the size of the bio. Seems that most devices set them to 128
> or 256 as well.

We can never exceed the driver given value of course. If the hardware
can do more than it advertises, then it would be a good idea to adjust
those values. Don't forget that a segment may be larger than a page.

> That means that on a 4k page machine 512k or 1MB are the most common
> largest possible I/O sizes and hence the maximum amount of memory
> pinned is 32 or 64x smaller than your original claim.
>
> Also If that is correct, then capping max_sectors to 512KB can't do much
> for reducing I/O latency or the amount of pinned memory on these systems
> because they couldn't issue I/O much larger than this.

Most drivers don't set a true max_hw_sectors yet, what I stated was for
what SATA (or lba48 on IDE, but that is limited by 256 segments anyway)
can support. The reason they don't set it yet is because this soft/hard
value split up is still quite fresh and drivers were told in the past to
not set huge max_sectors values because of this.

> So I'm still not understanding the rationale behind the new default setting
> of max_sectors....

Sorry I'm not making myself clearer. You still seem to not understand
exactly how the request buildup or limitations work, perhaps you should
start there. As to the problem in general, seems to me you are making a
big deal out of a small problem - a problem that can easily be rectified
in user space by just setting the right value.

-- 
Jens Axboe

