Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUB0RdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUB0RdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:33:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63186
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263059AbUB0Rcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:32:50 -0500
Date: Fri, 27 Feb 2004 18:32:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040227173250.GC8834@dualathlon.random>
References: <20040227013319.GT8834@dualathlon.random> <Pine.LNX.4.44.0402262325320.1747-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402262325320.1747-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:38:20PM -0500, Rik van Riel wrote:
> On Fri, 27 Feb 2004, Andrea Arcangeli wrote:
> 
> > 	becomes freeable/swappable. Some lib function in the patch is taken
> > 	from the objrmap patch for 2.6 in the mbligh tree implemented by IBM
> > 	(thanks to Martin and IBM for maintaining that patch uptodate for 2.6,
> > 	that is a must-have starting point for the 2.6 VM too).  The original
> > 	idea of using objrmap for the vm unmapping procedure is from David
> > 	Miller (objrmap itself has always existed in every linux kernel out
> 
> Good to hear that you're finally convinced that some form
> of reverse mapping is needed.

I'm convinced about that since April 2003 (and it wasn't 1st april joke
when I posted this ;)

http://groups.google.it/groups?q=g:thl1757664681d&dq=&hl=it&lr=&ie=UTF-8&selm=20030405025008%2463d0%40gated-at.bofh.it&rnum=19

quote "Indeed. objrmap is the only way to avoid the big rmap waste.
Infact I'm not even convinced about the hybrid approch, rmap should be
avoided even for the anon pages. And the swap cpu doesn't matter, as far
as we can reach pagteables in linear time that's fine, doesn't matter
how many fixed cycles it takes. Only the complexity factor matters, and
objrmap takes care of it just fine."

It's not like I wakeup yesterday with the idea of changing it, it's just
that nobody listened to my argument for almost one year so now we're
stuck with a 2.6 kernel that has no way to run in the high end (i.e.
>200 tasks with 2.7G of shm mapped each on a 32G box, with 2.4-aa I can
reach ~6k tasks with 2.7G mapped each).

Then Andrew pointed out that there are complexity issues that objrmap
can't handle but I'm not concerned about the complexity issue of objrmap
since no real app will run into it and it's mostly a red herring since
you should be able to trigger the same complexity issues with truncate
already.

the thing I'm against for years and that I'm still against is "rmap" not
objrmap. "rmap" is what prevents 2.6 from being able to handle high end
workloads. Not even 4:4 can hide the rmap overhead, even ignoring the
slowdown provided by 4:4, you still lockup at 4 times more address space
mapped, and 4 times more address space than what 2.6 can do now, is
still a tiny fraction of what my current 2.4-aa can map with objrmap.

rmap has nothing to do with objrmap. you know objrmap is available in
every linux kernel out there (2.0 probably had objrmap too), this is why
it's zero cost for linux to use objrmap, we just start using it for the
paging mechanism for the first time, instead of building a new redundant
extremely zone-normal costly infrastructure (i.e. rmap). I also don't
buy the 64bit argument, since the waste is there, it's just not a
showstopper blocker in 64bit, but the fact it's a blocker for 32bit
archs is a good thing so we're forced to optimize 64bit archs too.

as for remap_file_pages I've two ways:

1) implicit mlock and allow it only to root (i.e. cap lock capability)
   or under your sysctl that enables mlock for everybody, this is the
   simple lazy way, and I think this is what you're doing in 2.4 too
2) use a pagetable walk on every vma marked VM_NONLINEAR queued into the
   address space, we need that pagetable walk anyways for doing truncate
   perfect

To avoid altering the API probably the first remap_file_pages should set
the VM_NONLINEAR on the vma (maybe it's already doing that, I didn't
check).

so I think 2 is the best, sure one can argue it will waste cpu, but
this is just a correctness thing, it doesn't need to be fast at all,
I prefer to optimize for the fast path.

> I agree with you that object based rmap may well be better
> for 2.6, if you want to look into that I wouldn't mind at
> all.  Especially if we can keep akpm's and Nick's nice VM
> balancing intact ...

Glad we like it both.

So my current plan is to do objrmap for all file mappings first (this is
a blocker showstopper issue or 2.6 simply will lockup immediatly in the
high end, already verified just to be sure I wasn't missing something in
the code), then convert remap_file_pages to do the pagetable walk
instead of relying on rmap, then I can go further and add a dummy inode
for anonymous mappings too during COW like DaveM did originally. Only
then I can remove rmap enterely. This last step is somewhat lower prio.

> > 	The rest is infinite swapping and machine total hung, since those 4.8G
> > 	of swapcache are now freeable and dirty, and the kernel will not
> > 	notice the freeable and clean swapcache generated by this 64M
> > 	swapout, since it's being queued at the opposite side of the lru
> 
> An obvious solution for this is the O(1) VM stuff that Arjan
> wrote and I integrated into rmap 15.  Should be worth looking
> into this for the 2.6 kernel ...
> 
> Basically it keeps the just-written pages near the end of the
> LRU, so they're easily found and freed, before the kernel even
> starts thinking about submitting the other gigabytes of dirty
> data for writeout.
> 
> > 	efficient swapping because it was taking a long time before the
> > 	vm could notice the clean swapcache, after it started the I/O on
> > 	it.
> 
> ... Arjan's O(1) VM stuff ;)
> 
> > 	It was pretty clear after that, that we've to prioritize and to
> > 	prefer discarding memory that is zerocost to collect, than to do
> > 	extremely expensive things to release free memory instead.
> 
> I'm not convinced.  If we need to free up 10MB of memory, we just

if you're not convinced I assume Arjan's O(1) VM stuff is not doing
that, which means Arjan's O(1) VM stuff has little to do with the point
3.

point 1 is objrmap, you've rmap instead.

point 2 is "start I/O from shm_writepage" and you definitely want that
too,  O(1) VM can workaround for the lack of "start I/O from
shm_writepage" but it's a wrong workaround for that, I/O must be started
immediatly from shm_writepage, no point to delay it, when writepage is
called I/O must be started, waiting another small pass of the o1 vm is
wasted cpu. As I wrote this was a trivial two liner that you can easily
merge and it's orthogonal with all other issues. I see o1 vm may be
hiding this stupidity of shm_writepage for you but you will get a
benefit from the proper fix.

the only similarity between my stuff and Arjan's O(1) VM stuff is in
point 3, but only for the "searching of the clean swapcache". Since
you're not convinced about the above it means you don't get right the
"clean cache is a memleak without -aa latest stuff".

My stuff takes care of both issues at the same time, clearly Arjan's
O(1) VM stuff can be stacked on top of my stuff if I wanted to, to reach
more quickly the swapped out swapcache now clean. This is something I don't
want to do because I think that such O(1) VM is not O(1) at all, infact
it may end up wasting a lot more cpu depending on the allocation
frequency and the disk speed, since you've no guarantee that when you
run into the page again you will find it unlocked, so it may still be
under I/O, so it may actually waste cpu instead of saving it.

Overall Arjan's O(1) VM stuff can't help in the workload I was dealing
with, since it's all about freeing clean cache first and it's not doing
that, freeing clean swapcache is important too, but it's not as
important and avoiding I/O if we can.

> shouldn't do much more than 10MB of IO.  Doing just that should be
> cheap enough, after all.
> 
> The problem is when you do two orders of magnitude more writes than
> the amount of memory you need to free.  Trying to do zero IO probably
> isn't quite needed ...

in small machines the current 2.4 stock algo works just fine too, it's
only when the lru has the million pages queued that without my new vm
algo you'll do million swapouts before freeing the memleak^Wcache.

all I care about is to avoid the I/O if I can, and that's the only thing
my patch is doing. This is about life or death of the machine, it's not
a fast/slow issue ;).

> > 	vm is an order of magnitude worse in the high end. So the fix I
> > 	implemented is to run a inactive_list/vm_cache_scan_ratio pass
> > 	on the clean immediatly freeable cache in the inactive list
> 
> Should work ok for a while, until you completely run out of
> clean pages and then you might run into a wall ... unless you
> implement smarter cleaning & freeing like Arjan's stuff does.

I understand the smart cleaning & freeing, it's not obvious as said
above for the cpu waste that it risks to generate, and the "put it near
the end of the lru" one has to define "near" which is a mess. I'm not
saying o1 vm will necessairly waste cpu, I'm just saying it's non
obvious and it's in no way similar or equivalent to my code.

> Then again, your stuff will also find pages the moment they're
> cleaned, just at the cost of a (little?) bit more CPU time.

exactly, that's an important effect of my patch and that's the only
thing that o1 vm is taking care of, I don't think it's enough since the
gigs of cache would still be like a memleak without my code.

> Shouldn't be too critical, unless you've got more than maybe
> a hundred GB of memory, which should be a year off.

I think these effects starts to be visible over 8G, the worst thing is
that you can have 4G in a row of swapcache, in smaller systems the
lru tends to be more intermixed.

> > 	A better fix would be to have an anchor in the lru (can be a per-lru
> > 	page_t with a PG_anchor set) and to avoid the clean-cache search to
> > 	alter the point where we keep swapping with writepage, but it
> > 	shouldn't matter that much and 2.4 being obsolete isn't very
> > 	worthwhile to make it even better.
> 
> Hey, that's Arjan's stuff ;)   Want to help get that into 2.6 ? ;)

I think you mean he's using an anchor in the lru too in the same way I
proposed here, but I doubt he's using it nearly as I would, there seems
to be a fundamental difference in the two algorithms, with mine partly
covering the work done by his, and not the other way around.
