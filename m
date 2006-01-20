Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWATOyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWATOyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWATOyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:54:46 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:4760 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751028AbWATOyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:54:46 -0500
Date: Fri, 20 Jan 2006 14:53:36 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
In-Reply-To: <43D0BE27.5000807@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0601201204100.14292@skynet>
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
 <43CFE77B.3090708@austin.ibm.com> <43D02B3E.5030603@jp.fujitsu.com>
 <Pine.LNX.4.58.0601200102040.15823@skynet> <43D03C24.5080409@jp.fujitsu.com>
 <Pine.LNX.4.58.0601200934300.10920@skynet> <43D0BE27.5000807@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:>
> > What sort of tests would you suggest? The tests I have been running to date
> > are
> >
> > "kbuild + aim9" for regression testing
> >
> > "updatedb + 7 -j1 kernel compiles + highorder allocation" for seeing how
> > easy it was to reclaim contiguous blocks
> >
> > What tests could be run that would be representative of real-world
> > workloads?
> >
>

Before I get writing, I want to be clear on what tests are considered
useful.

> 1. Using 1000+ processes(threads) at once

Would tiobench --threads be suitable or would the IO skew what you are
looking for? If the IO is a problem, what would you recommend instead?

> 2. heavy network load.

Would iperf be suitable?

> 3. running NFS

Is running a kernel build over NFS reasonable? Should it be a remote NFS
server or could I setup a NFS share and mount it locally? If a kernel
build is not suitable, would tiobench over NFS be a better plan?

> is maybe good.
>
> > > > > And, for people who want to remove range of memory, list-based
> > > > > approach
> > > > > will
> > > > > need some other hook and its flexibility is of no use.
> > > > > (If list-based approach goes, I or someone will do.)
> > > > >
> > > > Will do what?
> > > >
> > > add kernelcore= boot option and so on :)
> > > As you say, "In an ideal world, we would have both".
> > >
> >
> > List-based was frowned at for adding complexity to the main path so we may
> > not get list-based built on top of zone based even though it is certinatly
> > possible. One reason to do zone-based was to do a comparison between them
> > in terms of complexity. Hopefully, Nick Piggin (as the first big objector
> > to the list-based approach) will make some sort of comment on what he
> > thinks of zone-based in comparison to list-based.
> >
> I think there is another point.
>
> what I concern about is Linus's word ,this:
> > My point is that regardless of what you _want_, defragmentation is
> > _useless_. It's useless simply because for big areas it is so expensive as
> > to be impractical.
>
> You should make your own answer for this before posting.
>

If it was expensive in absolute performance, then the aim9 figures would
have suffered badly and kbuild would also be hit. It has never been shown
that the list-based approach incurred a serious performance loss.
Similarly, I have not been able to find a performance loss with zone-based
unless it kernelcore was a small number. As both approaches reduce
fragmentation in a way without a measurable performance loss, I disagree
that defragmentation is "useless simply because for big areas it is so
expensive as to be impractical".

For "big areas", the issue is how big. When list-based was last released,
peoples view of "big" was the size of a bank of memory that was about to
be physically removed. AFAIK, that scenario is not as important as it was
because it comes with a host of difficult problems.

The scenario people really care about (someone correct me if I'm wrong
here) for hot-remove is giving virtual machines more or less memory as
demand requires. In this case, the "big"  area of memory required is the
same size as a sparsemem section - 16MiB on the ppc64 and 64MiB on the x86
(I think). Also, for hot-remove, it does not really matter where in the
zone the chunk is, as long as it is free. For ppc64, 16MiB of contiguous
memory is reasonably easy to get with the list-based approach and the case
would likely be the same for x86 if the value of MAX_ORDER was increased.

Both list-based and zone-based give the large chunks that could be
removed, but with list-based memory can be added that is usable by the
kernel and zone-based can only give more memory for userspace processes.
If the workload requires more kernel memory, you are out of luck.

The ideal would be bits of both would be available but I find it difficult
to believe that will ever make it it. I believe that list-based is better
overall because it's flexible and it helps both kernel and userspace.
However, it affects the main allocator code paths and it was greeted with
a severe kicking. Zone-based is less invasive, more predictable, probably
has a better chance of getting in, but it requires careful tuning and the
kernel cannot use hot-added memory at run-time.

I'd prefer the list-based approach to make it in, but zone-based is better
than nothing.

> From the old threads (very long!), I think  one of the point was :
> To use hugepages, sysadmin can specifies what he wants at boot time.
> This guarantees 100% allocation of needed huge pages.
> Why memhotplug cannot specifies "how much they can remove" before booting.
> This will guaranntee 100% memory hotremove.
>

One distinction is that memory reserved for huge pages is not the same as
memory placed in ZONE_EASYRCLM. Critically, pages in ZONE_EASYRCLM cannot
be used by the kernel for slabs, buffer pages etc. On the x86, this is not
a big issue because ZONE_HIGHMEM cannot be used anyway, but on
architectures that can use all memory (or at least large portions of it)
they would use ZONE_NORMAL, it is a big problem.

> I think hugetlb and memory hotplug cannot be good reason for defragment.
>

Right now, they are the main reasons for needing low fragmentation.

> Finding the reason for defragment is good.
> Unfortunately, I don't know the cases of memory allocation failure
> because of fragmentation with recent kernel.
>
> -- Kame
>
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
