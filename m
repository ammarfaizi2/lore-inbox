Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbUB0VQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUB0VQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:16:00 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7144
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263108AbUB0VPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:15:50 -0500
Date: Fri, 27 Feb 2004 22:15:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040227211548.GI8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227122936.4c1be1fd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 12:29:36PM -0800, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> > First, let me start with one simple request.  Whatever you do,
> > please send changes upstream in small, manageable chunks so we
> > can merge your improvements without destabilising the kernel.
> > 
> > We should avoid the kind of disaster we had around 2.4.10...
> 
> We need to understand that right now, 2.6.x is 2.7-pre.  Once 2.7 forks off
> we are more at liberty to merge nasty highmem hacks which will die when 2.6
> is end-of-lined.
> 
> I plan to merge the 4g split immediately after 2.7 forks.  I wouldn't be

note that the 4:4 split is wrong in 99% of cases where people needs 64G
gigs. I'm advocating strongly for the 2:2 split to everybody I talk
with, I'm trying to spread the 2:2 idea because IMHO it's an order of
magnitude simpler and an order of magnitude superior. Unfortunately I
could get not a single number to back my 2:2 claims, since the 4:4
buzzword is spreading and people only test with 4:4. so it's pretty hard
for me to spread the 2:2 buzzword.

4:4 makes no sense at all, the only advantage of 4:4 w.r.t. 2:2 is that
they can map 2.7G per task of shm instead of 1.7G per task of shm. Oh
they also have 1G more of normal zone, that's useless since 32G 3:1
works perfectly and more zone-normal won't help at all (and if you leave
rmap kernel will lockup no matter of 4:4 or 3:1 or 2:2 or 1:3). But the
1 more gig they can map per task will give them nothing since they flush
the tlb every syscall and every irq. So it's utterly stupid to map 1
more gig per task with the end result that you've to switch_mm every
syscall and irq. I expect the databases will run an order of magnitude
faster with _2:2_ in a 64G configuration, with _1.7G_ per process of shm
mapped, instead of their 4:4 split with 2.7G (or more, up to 3.9 ;)
mapped per task.

I don't mind if 4:4 gets merged but I recommend db vendors to benchmark
_2:2_ against 4:4 before remotely considering deploying 4:4 in
production.  Then of course let me know since I had not the luck to get
any number back and I've no access to any 64G box.

I don't care about 256G with 2:2 split, since intel and hp are now going
x86-64 too.

going past 32G the bigpages makes an huge difference, not just for the
pte memory overhead, but for the tlb caching, this is make me very
confortable of claiming 2:2 will payoff big compared to 4:4.

> averse to objrmap for file-backed mappings either - I agree that the search
> problems which were demonstrated are unlikely to bite in real life.

cool.

Martin's patch from IBM is a great start IMHO. I found a bug in the vma
flags check though, VM_RESERVED should be checked too, not only
VM_LOCKED, unless I'm missing something, but it's a minor issue.

The other scary part is if the trylocking fails too often, would be nice
to be able to spin and not to trylock, I would feel safer. In 2.4 I
don't care since it's a best-effort, I don't depend on the trylocking to
succeed to unmap pages, the original walk still runs and it spins.

> But first someone would need to demonstrate that pte_chains+4g/4g are
> for some reason unacceptable for some real-world setup.

with an rmap kernel the limit goes from 150 users of 3:1 to around 700
users of 4:4.  in 2.4 I can handle ~6k users at full speed with 3:1. And
the 4:4 slowdown is a so big order of magnitude that I believe it's
crazy to use 4:4 even on a 64G box where I advocate for 2:2 instead. And
if you leave rmap in, 4:4 will be needed even on a 8G box (not only on
64G boxes) to get past 700 users.

> Apart from the search problem, my main gripe with objrmap is that it
> creates different handling for file-backed and anonymous memory.  And the
> code which extends it to anonymous memory is complex and large.  One ends
> up needing to seriously ask oneself what is being gained from it all.

I don't have a definitive answer, but trying to use objrmap for anon too
is my object. It's not clear if it worth or not though. But this is
lower prio.

> > We've heard the "no real app runs into it" argument before,
> > about various other subjects.  I remember using it myself,
> > too, and every single time I used the "no real apps run into
> > it" argument I turned out to be wrong in the end.
> > 
> 
> heh.

my answer to this is that truncate() may already be running into weird
apps. sure the vm has more probability since truncate of mapped files
isn't too frequent, but if you really expect bad luck we already have a
window open for the bad luck ;) I try to be an optimist ;). Let's say I
know at least the most important apps won't run into this. Currently the
most imporant apps will lockup. So I don't have much choice.

> Oh, and can we please have testcases?  It's all very well to assert "it
> sucks doing X and I fixed it" but it's a lot more useful if one can
> distrubute testcases as well so others can evaluate the fix and can explore
> alternative solutions.
> 
> Andrea, this shmem problem is a case in point, please.

I don't have the real life testcase myself (I lack both software and
hardware to reproduce and it's not easy to run the thing either) but
I think it's possible to test it as we move to 2.6. At the moment it's
pointless to try due rmap but as soon as it's in good shape and math
gives the ok I will try to get stuff tested in practice (at the moment I
only verified rmap is a showstopper as math says, but just to be sure).

We can write a testcase ourself, it's pretty easy, just create a 2.7G
file in /dev/shm, and mmap(MAP_SHARED) it from 1k processes and fault in
all the pagetables from all tasks touching the shm vma. Then run a
second copy until the machine starts swapping and see how thing goes. To
do this you need probably 8G, this is why I didn't write the testcase
myself yet ;).  maybe I can simulate with less shm and less tasks on 1G
boxes too, but the extreme lru effects of point 3 won't be visibile
there, the very same software configuration works fine on 1/2G boxes on
stock 2.4. problems showsup when the lru grows due the algorithm not
contemplating million of dirty swapcache in a row at the end of the lru
and some gigs of free cache ad the head of the lru. the rmap-only issues
can also be tested with math, no testcase is needed for that.

> Maybe not.  Testcase, please ;)

I think a more efficient algorithm to achive the o1 vm object (which is
only one of the issues that my point 3 solves), could be to have a
separate lru (not an anchor) protected by an irq spinlock (spinlock
because it will be accessed by the I/O completion routine) that we check
once per second and not more, so the variable becomes "time" instead of
"frequency of allocations", since swapout disk I/O is going to be quite
dependent on fixed time, rather than on the allocation rate which isn't
really fixed. This way we know we won't throw a too huge amount of cpu
on locked pages and it avoids the anchor and in turn the anchor
placement non obvious problem. However the coding of this would be
complex, maybe not more complex than the o1 vm code though.

The usage I wanted to do of an anchor in 2.4 is completely different
from the usage that o1 vm is doing IMHO.

thanks for the help!
