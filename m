Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbUCIPUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUCIPUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:20:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50692
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261995AbUCIPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:20:40 -0500
Date: Tue, 9 Mar 2004 16:21:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309152121.GD8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309074747.GA8021@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 08:47:47AM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > I agree that works fine for Oracle, that's becase Oracle is an extreme
> > special case since most of this shared memory is an I/O cache, this is
> > not the case of other apps, and those other apps really depends on the
> > kernel vm paging algorithms for things more than istantiating a pte
> > (or a pmd if it's a largepage). Other apps can't use mlock. Some of
> > these apps works closely with oracle too.
> 
> what other apps use gigs of shared memory where that shared memory is
> not an IO cache?

another >50b company, there aren't that many

> > dropping pte_chains through mlock was suggested around april 2003
> > originally by Wli and I didn't like that idea since we really want to
> > allow swapping if we run short of ram. [...]
> 
> dropping pte_chains on mlock() we implemented in RHEL3 and it works fine
> to reduce the pte_chain overhead for those extreme shm users.

that's ok for oracle, but it's far from being an acceptable solution to
all critical apps.

> mind you, it still doesnt make high-end DB workloads viable on 32 GB
> systems. (and no, not due to the pte_chain overhead.) 3:1 is simply not
> enough at 32 GB and higher [possibly much ealier, for other workloads]. 
> Trying to argue otherwise is sticking your head into the sand.

then either we run different software or your vm is inferior, it's as
simple as that. I'm not just guessing, this stuff run for a very long
time, we've even triggered bugs outside the kernel that were never
reproducible until we did, now fixed (not a linux issue) and there was
no zone-normal shortage at all that I can remeber, not a single kernel
glitch was experienced during the 32G tests.

only if you can reproduce your zone-normal shortage with 2.4-aa I can
care about it, give it a try please, I cannot care what happens with the
rmap vm in the RHEL3 kernels, I don't know the vm of those kernels, and
in my tree I've quite a ton of add-ons for making 3:1 work (beneficial
in 64bit too of course, just to mention one the vma isn't hardware
aligned, that alone gives back dozen mbytes of normal zone etc..).

Go read this:

http://www.oracle.com/apps_benchmark/html/index.html?0325B_Report1.html

CPUs: 4 x Intel Xeon MP 2.8GHz
 Processor caches: 12 KB L1; 512 KB L2; 2MB L3
 Memory: 32GB
 Operating System: SuSE SLES8
 Disks: 2 x 72.8GB (Ultra 3) 

User Count 7504 users

there was absolutely no zone-normal shortage going on here, the machine
was perfectly fine, the 7.5k user limit is purerly a cpu bound matter,
that's the maximul the cpus could handle. Of course this was with SLES8,
mainline would run in tons of troubles due the lack of pte-highmem,
everything else these days seems to be in mainline too.

2.6 mainline would lockup quick with zone-normal shortage too in the
above workload due rmap (I think regardless of 4:4 or 3:1).

But with my 2.6 work I expect to give even more margin to those 32G
boxes using 3:1 as usual, thanks to a reduced page_t and thanks to
remap_file_pages and some other bit, so they're even more generic.

there's absolutely no swap going on in those machines, and if they swap
that will be a few megs, so walking long i_mmap lists a few times is
perfectly fine if we really have to do I/O (if they use mlock and we
teach objrmap to remove from the lru the locked pages they won't risk
any list-walking either, but while you're forced to use mlock anyways to
make RHEL work with rmap, objrmap don't need any mlock to work optimally
since normally there's no swap at all, so no cpu time spent in the
lists, mlock is more an hint than a requirement with objrmap in these
workloads).

And note that running out of zone-normal shouldn't lead to a
kernel-crash like in 2.6, in my 2.4-aa it simply generates a -ENOMEM
retval from syscalls, that's it, no task killed, nothing really bad
happening. Running out of zone-normal is not different from running out
of highmem in a machine without swap. So if 3:1 would run out of zone-normal
at 8.5k users (possible but we couldn't reach that since as said it's
cpu bound at 7.5k) it could be that not all ram will perfectly utilized,
but it'll be like running out of highmem, except the tasks will not be
killed. An admin should monitor vm over time, lowmem and highmem free
levels, to see if his workloads risks to run the box out of memory and
if he needs a different architecture or a different memory model. In the
tests I did so far in the 2.4-aa vm, 32G works fine with 3:1 after all
the work done to make it work.

a 32-way with 32G of ram may hit a zone-normal shortage earlier due the
per-cpu reservations, that's true, just like a 48G box 2-way will run
out of normal-zone quicker. At some point 3:1 becomes a limitation, we
agree on that, but I definitely would use 3:1 for workloads like the
above one with hardware like the above one, using any other model for
this workload is wrong and it will only hurt.

And about the 32G we can argue, about 8G boxes we don't really want to
argue, 3:1 is fine for 8G boxes.

as a matter of fact the only single reason you have to ship all PAE
kernels with 4:4 is rmap, no other reason. If you didn't have rmap, you
could leave the option to the user of choosing.

> most of the anti-rmap sentiment (not this patch - this patch looks OK at
> first sight, except the increase in struct page) is really backwards.

the increase in struct page will be fixed with the further patches, the
first effect of the further patches will be to make the page_t 4bytes
less than 2.6 and 2.4 mainline. this patch is just the building block of
the objrmap vm, it's not definitive, just a trasitional phase before the
pte_chain goes away completely releasing its 8bytes from the page_t.

> The right solution is to have rmap which is a _per page_ overhead and
> the clear path to a mostly O(1) VM logic. Then we can increase the page
> size (pgcl) to scale down the rmap overhead (both the per-page and the
> locking overhead). What's so hard about this concept? Simple and
> flexible data structure.
> 
> the x86 highmem issues are a quickly fading transient in history.

pte_chains hurts the same on 32bit and 64bit.
