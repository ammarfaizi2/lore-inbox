Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbUB0WJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUB0WGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:06:38 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:35523 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263164AbUB0WD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:03:29 -0500
Date: Fri, 27 Feb 2004 14:03:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>
cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <162060000.1077919387@flay>
In-Reply-To: <20040227211548.GI8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> note that the 4:4 split is wrong in 99% of cases where people needs 64G
> gigs. I'm advocating strongly for the 2:2 split to everybody I talk
> with, I'm trying to spread the 2:2 idea because IMHO it's an order of
> magnitude simpler and an order of magnitude superior. Unfortunately I
> could get not a single number to back my 2:2 claims, since the 4:4
> buzzword is spreading and people only test with 4:4. so it's pretty hard
> for me to spread the 2:2 buzzword.

For the record, I for one am not opposed to doing 2:2 instead of 4:4.
What pisses me off is people trying to squeeze large amounts of memory
into 3:1, and distros pretending it's supportable, when it's never 
stable across a broad spectrum of workloads. Between 2:2 and 4:4,
it's just a different overhead tradeoff.

> 4:4 makes no sense at all, the only advantage of 4:4 w.r.t. 2:2 is that
> they can map 2.7G per task of shm instead of 1.7G per task of shm.

Eh? You have a 2GB difference of user address space, and a 1GB difference
of shm size. You lost a GB somewhere ;-) Depending on whether you move
TASK_UNMAPPPED_BASE or not, it you might mean 2.7 vs 0.7 or at a pinch
3.5 vs 1.5, I'm not sure.

> syscall and irq. I expect the databases will run an order of magnitude
> faster with _2:2_ in a 64G configuration, with _1.7G_ per process of shm
> mapped, instead of their 4:4 split with 2.7G (or more, up to 3.9 ;)
> mapped per task.

That may well be true for some workloads, I suspect it's slower for others.
One could call the tradeoff either way.
 
> I don't mind if 4:4 gets merged but I recommend db vendors to benchmark
> _2:2_ against 4:4 before remotely considering deploying 4:4 in
> production.  Then of course let me know since I had not the luck to get
> any number back and I've no access to any 64G box.

If you send me a *simple* simulation test, I'll gladly run it for you ;-)
But I'm not going to go fiddle with Oracle, and thousands of disks ;-)

> I don't care about 256G with 2:2 split, since intel and hp are now going
> x86-64 too.

Yeah, I don't think we ever need to deal with that kind of insanity ;-)
 
>> averse to objrmap for file-backed mappings either - I agree that the search
>> problems which were demonstrated are unlikely to bite in real life.
> 
> cool.
> 
> Martin's patch from IBM is a great start IMHO. I found a bug in the vma
> flags check though, VM_RESERVED should be checked too, not only
> VM_LOCKED, unless I'm missing something, but it's a minor issue.

I didn't actually write it - that was Dave McCracken ;-) I just suggested
the partial aproach (because I'm dirty and lazy ;-)) and carried it
in my tree.

I agree with Andrew's comments though - it's not nice having the dual
approach of the partial, but the complexity of the full approach is a
bit scary and buys you little in real terms (performance and space).
I still believe that creating an "address_space like structure" for
anon memory, shared across VMAs is an idea that might give us cleaner
code - it also fixes other problems like Andi's NUMA API binding.

> We can write a testcase ourself, it's pretty easy, just create a 2.7G
> file in /dev/shm, and mmap(MAP_SHARED) it from 1k processes and fault in
> all the pagetables from all tasks touching the shm vma. Then run a
> second copy until the machine starts swapping and see how thing goes. To
> do this you need probably 8G, this is why I didn't write the testcase
> myself yet ;).  maybe I can simulate with less shm and less tasks on 1G
> boxes too, but the extreme lru effects of point 3 won't be visibile
> there, the very same software configuration works fine on 1/2G boxes on
> stock 2.4. problems showsup when the lru grows due the algorithm not
> contemplating million of dirty swapcache in a row at the end of the lru
> and some gigs of free cache ad the head of the lru. the rmap-only issues
> can also be tested with math, no testcase is needed for that.

I don't have time at the moment to go write it at the moment, but I can certainly run it on large end hardware if that helps.

M.
