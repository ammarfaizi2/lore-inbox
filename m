Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUCIOux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUCIOuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:50:52 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25618
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261963AbUCIOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:50:49 -0500
Date: Tue, 9 Mar 2004 15:51:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309145130.GC8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040309083103.GB8021@elte.hu> <20040309090326.GA10039@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309090326.GA10039@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 10:03:26AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > ugh? This is not my main argument against 'objrmap'. My main (and
> > pretty much only) argument against it is the linear searching it
> > reintroduces.
> 
> to clarify this somewhat. objrmap works fine (and roughly equivalently
> to rmap) when processes map files via one vma mostly. (e.g. shared
> libraries.)
> 
> objrmap falls apart badly if there are tons but _disjunct_ vmas to the
> same inode. One such workload is Oracle's 'indirect buffer cache'. It is
> a ~512 MB virtual memory window with 32KB mapsize, mapping to a much
> larger shmfs page, featuring 16 thousand vmas per process.
> 
> The problem is that the ->i_mmap and ->i_mmap_shared lists 'merge' _all_
> the vmas that somehow belong to the given inode. Ie. in the above case
> it has a length of 16 thousand entries. So while possibly none of those
> vmas shares any physical page with each other, your
> try_to_unmap_obj(page) function will loop through possibly thousands of
> vmas, killing the VM's ability to reclaim. (and also presenting the
> 'kswapd is stuck and eating up CPU time' phenomenon to users.)
> 
> Andrea, did you know about this property of your patch? If yes, why
> didnt you mention it in the announcement, as a tradeoff to take care of?

first of all that this algorithm is running in production just fine in
the workloads you're talking about, it's not like I didn't even try it,
even the ones that have to swap (see the end of the email).

you should specify that they have to swap to actually pay this cost,
and you said that the memory you're talking about is mlocked. In 2.4
objrmap I don't pay the cost for mlocked memory, the 2.6 patch isn't
smart enough yet but it will soon will.

The patch I posted is the building block, all the developemnt is on top
of that. That patch alone I agree is not optimal and my first next
target is to remove all pte_chains from the kernel and I'm not far from
that, this will avoid the rmap overhead for anon memory and secondly
(less critical) it will give us 8 bytes per page_t (reducing the page_t
of 4 bytes compared to current 2.6 mainline). I can shrink it further
but I'd need to drop some functionality so I'm doing the anon_vma work
in a self contained way using the same apis that are in rmap.c today.

Regardless the mlock thing (and I'm not even sure the 2.4 code is
running with mlocked vmas, so it may be fine even w/o mlock), you should
mention that this "cpu" cost happens only by the time you become I/O
bound. And the workload that I'm testing in 2.4 is very swap intensive,
not like a normal db.

there are three things you're missing:

1) cpus and memory are faster and faster with respect to storage
   (and there so much ram these days that one can argue if
   doing any swap oriented optimization will ever payoff)
2) the only benefit you get is less cpu cost during swapping, and 2.6
   is slower than 2.4 at swap bandwidth
3) if you use those gigabytes of ram as shmfs backing store, then I
   expect a lot more benefit than to save cpu during swapping, since
   you'll have some more gigs of ram before you start swapping

> 
> it's ironic that precisely the workload you cite (shmfs for IO cache,
> when the shared memory size is larger than what the process can map) is
> the one that would hurt most from objrmap. In that workload there can be
> possibly tens of thousands of disjunct vmas mapping the same shmfs inode
> and kswapd would loop endlessly without achieving anything useful.

it's the opposite, without objrmap the machine falls apart because
before we can swap 4k we've to destroy the entire address space, so we
keep generating minor fault floods. The cpu cost of following some
thousand pointers is little compared to destroying the whole hundred
gigabytes or terabytes of address space.

I'm not kidding, people is now able to use the machine, previously they
couldn't (it's not just objrmap of course, that's one of three bits that
fixed it).

And in this whole email you're still thinking only with 32bit mindset,
for 64bit objrmap is obviously an order of magnitude superior in the
same workload that you're complained about above for 32bit archs.
