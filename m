Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUB1Ccl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 21:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbUB1Ccl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 21:32:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37765
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263018AbUB1Ccg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 21:32:36 -0500
Date: Sat, 28 Feb 2004 03:32:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228023236.GL8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162060000.1077919387@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 4:4 makes no sense at all, the only advantage of 4:4 w.r.t. 2:2 is that
> > they can map 2.7G per task of shm instead of 1.7G per task of shm.

On Fri, Feb 27, 2004 at 02:03:07PM -0800, Martin J. Bligh wrote:
> 
> Eh? You have a 2GB difference of user address space, and a 1GB difference
> of shm size. You lost a GB somewhere ;-) Depending on whether you move
> TASK_UNMAPPPED_BASE or not, it you might mean 2.7 vs 0.7 or at a pinch
> 3.5 vs 1.5, I'm not sure.

the numbers I wrote are right. No shm size is lost. The shm size is >20G,
it doesn't fit in 4g of address space of 4:4 like it doesn't fit in 3G
of address space of 3:1 like it doesn't fit in 2:2.

I think nobody tested 2:2 seriously on 64G boxes yet, I'm simply asking
for that.

And I agree with you using 64G with 3:1 is not feasible for application
like databases, it's feasible for other apps for example needing big
caches (if you can manage to boot the machine ;) it's not a matter of
opinion, it's a matter fact, for a generic misc load the high limit of
3:1 is mem=48G, which is not too bad.

What changes between 3:1 and 2:2 is the "view" on the 20G shm file, not
the size of the shm. you can do less simultaneous mmap with a 1.7G view
instead of a 2.7G view. the nonlinear vma will be 1.7G in size with 2:2,
instead of 2.7G in size with 3:1 or 4:4 (300M are as usual left for some
hole, the binary itself and the stack)

> > syscall and irq. I expect the databases will run an order of magnitude
> > faster with _2:2_ in a 64G configuration, with _1.7G_ per process of shm
> > mapped, instead of their 4:4 split with 2.7G (or more, up to 3.9 ;)
> > mapped per task.
> 
> That may well be true for some workloads, I suspect it's slower for others.
> One could call the tradeoff either way.

the only chance it's faster is if you never use syscalls and you drive
all interrupts to other cpus and you have an advantage by mapping >2G in
the same address space. If you use syscalls and irqs, then you'll keep
flushing the address space, so you can as well use mmap and flush
_by_hand_ only the interesting bits when you really run into a
view-miss, so you can run at full speed in the fast path including
syscalls and irqs. Most of the time the view will be enough, there's
some aging technic to apply on the collection of the old buckets too. So
I've some doubt 4:4 runs faster anywhere. I could be wrong though.

> > I don't mind if 4:4 gets merged but I recommend db vendors to benchmark
> > _2:2_ against 4:4 before remotely considering deploying 4:4 in
> > production.  Then of course let me know since I had not the luck to get
> > any number back and I've no access to any 64G box.
> 
> If you send me a *simple* simulation test, I'll gladly run it for you ;-)
> But I'm not going to go fiddle with Oracle, and thousands of disks ;-)

:)

thanks for the offer! ;) I would prefer a real life db bench since
syscalls and irqs are an important part of the load that hurts 4:4 most,
it doesn't need to be necessairly oracle though. And if it's a cpu with
big tlb cache like p4 it would be prefereable. maybe we should talk
about this offline.

> > I don't care about 256G with 2:2 split, since intel and hp are now going
> > x86-64 too.
> 
> Yeah, I don't think we ever need to deal with that kind of insanity ;-)

;)

> >> averse to objrmap for file-backed mappings either - I agree that the search
> >> problems which were demonstrated are unlikely to bite in real life.
> > 
> > cool.
> > 
> > Martin's patch from IBM is a great start IMHO. I found a bug in the vma
> > flags check though, VM_RESERVED should be checked too, not only
> > VM_LOCKED, unless I'm missing something, but it's a minor issue.
> 
> I didn't actually write it - that was Dave McCracken ;-) I just suggested
> the partial aproach (because I'm dirty and lazy ;-)) and carried it
> in my tree.

I know you didn't write it but I forgot who was the author so I just
given credit to IBM at large ;). thanks for giving the due credit to
Dave ;)

> I agree with Andrew's comments though - it's not nice having the dual
> approach of the partial, but the complexity of the full approach is a
> bit scary and buys you little in real terms (performance and space).
> I still believe that creating an "address_space like structure" for
> anon memory, shared across VMAs is an idea that might give us cleaner
> code - it also fixes other problems like Andi's NUMA API binding.

agreed. It's just lower prio at the moment since anon memory doesn't
tend to be that much shared, so the overhead is minimal.

> I don't have time at the moment to go write it at the moment, but I
> can certainly run it on large end hardware if that helps.

thanks, we should write it someday. that testcase isn't the one suitable
for the 4:4 vs 2:2 thing though, for that a real life thing is needed
since irqs, syscalls (and possibly page faults but not that many with a
db) are fundamental parts of the load.  we could write a smarter
testcase as well, but I guess using a db is simpler, evaluating 2:2 vs
4:4 is more a do-once thing, results won't change over time.
