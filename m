Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSLFOt4>; Fri, 6 Dec 2002 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSLFOtz>; Fri, 6 Dec 2002 09:49:55 -0500
Received: from [195.223.140.107] ([195.223.140.107]:62849 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262924AbSLFOts>;
	Fri, 6 Dec 2002 09:49:48 -0500
Date: Fri, 6 Dec 2002 15:57:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206145718.GL1567@dualathlon.random>
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com> <20021206054804.GK1567@dualathlon.random> <3DF049F9.6F83D13@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF049F9.6F83D13@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 10:55:53PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > the
> > algorithm is autotuned at boot and depends on the zone sizes, and it
> > applies to the dma zone too with respect to the normal zone, the highmem
> > case is just one of the cases that the fix for the general problem
> > resolves,
> 
> Linus's incremental min will protect ZONE_DMA in the same manner.

of how many bytes?

> 
> > and you're totally wrong saying that mlocking 700m on a 4G box
> > could kill it.
> 
> It is possible to mlock 700M of the normal zone on a 4G -aa kernel.
> I can't immediately think of anything apart from vma's which will
> make it fall over, but it will run like crap.

you're missing the whole point. the vma are zone-normal users. You're
saying that you can run out of ZONE_NORMAL if you run
alloc_page(GFP_KERNEL) for some hundred thousand times. Yeah that's not
a big news.

I'm saying you *can't* run out of zone-normal due highmem allocations so
if you run alloc_pages(GFP_HIGHMEM), period.

that's a completely different thing.

I thought you understood what the problem is, not sure why you say you
can run out of zone-normal running 100000 times alloc_page(GFP_KERNEL),
that has *nothing* to do with the bug we're discussing here, if you
don't want to run out of zone-normal after 100000 GFP_KERNEL page
allocations you can only drop the zone-normal.

The bug we're discussing here is that w/o my fix you will run out of
zone-normal despite you didn't start allocating zone-normal yet and
despite you still have 60G free in the highmem zone. This is what the
patch prevents, nothing more nothing less.

And it's not so much specific to google, they were just unlucky
triggering it, as said just allocate plenty of pagetables (they are
highmem capable in my tree and 2.5) or swapoff -a, and you'll run in the
very same scenario that needs my fix in all normal workloads that
allocates some more than some hunded mbytes of ram.

And this is definitely a generic problem, not even specific to linux,
it's an OS wide design problem while dealing with the balancing of
different zones that have overlapping but not equivalent capabilities,
it even applies to zone-dma with respect to zone-normal and zone-highmem
and there's no other fix around it at the moment.

Mainline fixes it in a very weak way, it reserves a few meges only,
that's not nearly enough if you need to allocate more than one more
inode etc... The lowmem reservation must allow the machine to do
interesting workloads for the whole uptime, not to defer the failure of
a few seconds. A few megs aren't nearly enough.

If interesting workloads needs huge zone-normal, just reserve more of it
at boot and they will work. if all the zone-normal isn't enough you fall
into a totally different problem, that is the zone-normal existence in
the first place and it has nothing to do with this bug, and you can fix
the other problem only by dropping the zone-normal (of course if you do
that you will in turn fix this problem too, but the problems are
different).

The only alternate fix is to be able to migrate pagetables (1st level
only, pte) and all the other highmem capable allocations at runtime
(pagecache, shared memory etc..). Which is clearly not possible in 2.5
and 2.4.

Once that will be possible/implemented my fix can go away and you can
simply migrate the highmem capable allocations from zone-normal to
highmem. That would be the only alternate and also dynamic/superior fix
but it's not feasible at the moment, at the very least not in 2.4. It
would also have some performance implications, I'm sure lots of people
prefers to throw away 500M of ram in a 32G machine than riskying to
spend the cpu time in memcopies, so it would not be *that* superior, it
would be inferior in some ways.

Reserving 500M of ram on a 32G machine doesn't really matter at all, so
the current fix is certainly the best thing we can do for 2.4, and for
2.5 too unless you want to implement highmem migration for all highmem
capable kernel objects (which would work fine too).

Also your possible multiplicator via sysctl remains a much inferior to
my fix that is able to cleanly enforce classzone-point-of-view
watermarks (not fixed watermarks), you would need to change
multiplicator depending on zone size and depending on the zone to make
it equivalent, so yes, you could implement it equivally but it would be
much less clean and readable than my current code (and more hardly
tunable with a kernel paramter at boot like my current fix is).

> > 2.5 misses this important fix too btw.
> 
> It does not appear to be an important fix at all.  There have been

well if you ignore it people can use my tree, I personally need that fix
for myself on big boxes so I'm going to retain it in one form or
another (the form in mainline is too weak as said and just adding a
multiplicator would not be equivalent as said above).

> 2.5 has much bigger problems than this - radix_tree nodes and pte_chains
> in particular.

I'm not saying there aren't bigger problems in 2.5, but I don't classify
this one as a minor one, infact it was a showstopper for a long time in
2.4 (one of the last ones), until I fixed it and it still is a problem
because the 2.4 fix is way too weak (a few megs aren't enough to
guarantee big workloads to succeed).

Andrea
