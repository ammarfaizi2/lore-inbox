Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVAXN26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVAXN26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAXN26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:28:58 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:55209 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261411AbVAXN2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:28:48 -0500
Date: Mon, 24 Jan 2005 13:28:47 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
In-Reply-To: <20050122215949.GD26391@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501241141450.5286@skynet>
References: <20050120101300.26FA5E598@skynet.csn.ul.ie> <20050121142854.GH19973@logos.cnet>
 <Pine.LNX.4.58.0501222128380.18282@skynet> <20050122215949.GD26391@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2005, Marcelo Tosatti wrote:

> > > I was thinking that it would be nice to have a set of high-order
> > > intensive workloads, and I wonder what are the most common high-order
> > > allocation paths which fail.
> > >
> >
> > Agreed. As I am not fully sure what workloads require high-order
> > allocations, I updated VMRegress to keep track of the count of
> > allocations and released 0.11
> > (http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.11.tar.gz). To
> > use it to track allocations, do the following
> >
> > < VMRegress instructions snipped>
>
> Great, excellent! Thanks.
>
> I plan to spend some time testing and trying to understand the vmregress package
> this week.
>

The documentation is not in sync with the code as the package is fairly
large to maintain as a side-project. For the recent data I posted, The
interesting parts of the tools are;

1. bin/extfrag_stat.pl will display external fragmentation as a percentage
of each order. I can go more into the calculation of this if anyone is
interested. It does not require any special patches or modules

2. bin/intfrag_stat.pl will display internal fragmentation in the system.
Use the --man switch to get a list of all options. Linux occasionally
suffers badly from internal fragmentation but it's a problem for another
time

3. mapfrag_stat.pl is what I used to map where allocations are in the
address space. It requires the kernel patch in
kernel_patches/v2.6/trace_pagealloc-map-formbuddy.diff (there is a
non-mbuddy version in there) before the vmregress kernel modules can be
loaded

4. extfrag_stat_overtime.pl tracks external fragmentation over time
although the figures are not very useful. It can also graph what
fragmentation for some orders are over time. The figures are not useful
because the fragmentation figures are based on free pages and does not
take into account the layout of the currently allocated pages.

5. The module in src/test/highalloc.ko is what I used to test high-order
allocations. It creates a proc entry /proc/vmregress/test_highalloc that
can be read or written. "echo Order Pages >
/proc/vmregress/test_highalloc" will attempt to allocate 2^Order pages
"Pages" times.

The perl scripts are smart enough to load the modules they need at runtime
if the modules have been installed with "make install".

> > > It mostly depends on hardware because most high-order allocations happen
> > > inside device drivers? What are the kernel codepaths which try to do
> > > high-order allocations and fallback if failed?
> > >
> >
> > I'm not sure. I think that the paths we exercise right now will be largely
> > artifical. For example, you can force order-2 allocations by scping a
> > large file through localhost (because of the large MTU in that interface).
> > I have not come up with another meaningful workload that guarentees
> > high-order allocations yet.
>
> Thoughts and criticism of the following ideas are very much appreciated:
>
> In private conversation with wli (who helped me providing this information) we can
> conjecture the following:
>
> Modern IO devices are capable of doing scatter/gather IO.
>
> There is overhead associated with setting up and managing the
> scatter/gather tables.
>
> The benefit of large physically contiguous blocks is the ability to
> avoid the SG management overhead.
>

Do we get this benefit right now? I read through the path of
generic_file_readv(). If I am reading this correctly (first reading, so
may not be right), scatter/gather IO will always be using order-0 pages.
Is this really true?

>From what I can see, the buffers being written to for readv()  are all in
userspace so are going to be order-0 (unless hugetlb is in use, is that
the really interesting case?). For reading from the disk, the blocksize is
what will be important and we can't create a filesystem with blocksizes
greater than pagesize right now.

So, for scatter/gather to take advantage of contiguous blocks, is more
work required? If not, what am I missing?

> Also filesystems benefit from big physically contiguous blocks. Quoting
> wli "they want bigger blocks and contiguous memory to match bigger
> blocks..."
>

This I don't get... What filesystems support really large blocks? ext2/3
only support pagesize and reiser will create a filesystem with a blocksize
of 8192, but not mount it.

> I completly agree that your simplified allocator decreases fragmentation
> which in turn benefits the system overall.
>
> This is an area which can be further improved - ie efficiency in
> reducing fragmentation is excellent.  I sincerely appreciate the work
> you are doing!
>

Thanks.

> > <Snip>
> >
> > Right now, I believe that the pool of huge pages is of a fixed size
> > because of fragmentation difficulties. If we knew we could allocate huge
> > pages, this pool would not have to be fixed. Some applications will
> > heavily benefit from this. While databases are the obvious one,
> > applications with large heaps will also benefit like Java Virtual
> > Machines. I can dig up papers that measured this on Solaris although I
> > don't have them at hand right now.
>
> Please.
>

I took a root through but did not find all the papers I was looking for.
What I did find was;

1. Big Heaps and Intimate Shared Memory (ISM)
http://java.sun.com/docs/hotspot/ism.html
This is one of many similar docs that recommend the use of large pages for
applications with large heaps like JVMs and databases. ISM is no longer
used much and has been replaced by Muliple Page Size Support (MPSS) . MPSS
is essentially the same thing but does not lock pages

2. Preformance boost using ISM
http://www.gcocco.com/bench/jbb2k.html#ism_boost
The result is operations per second and ISM gives gains of between 8-10%.
The gains could be a result of either the locking of pages in memory or
the TLB gains, the article does not investigate.

2. Optimising BEA Weblogic Server Performance on Solaris
http://www.bea.com/content/files/eworld/presentations/Tues_03_04_03/Extending_the_BEA_Platform/1239_WLS_Performance_on_Solaris.pdf
Ok, reaching a little here: See slides 19 and 20. It shows what the TLB
miss rates were for 8KiB and 4MiB pages. There are 10 times as many TLB
misses with the smaller pages.

3. Multiple Page Size Support in the Linux Kernel (2002)
http://citeseer.ist.psu.edu/winwood02multiple.html
Page 11 and 12 show the experimental results they found when using large
pages although later parts of the paper talks about code and data locality
in JVMs which is also of interest.

4. Supporting Multiple Page Sizes in Solaris Operating System
http://www.sun.com/blueprints/0304/817-5918.pdf
Illustrates some of the tools Solaris has for measuring stuff like TLB
misses. Also talks about what system calls and libraries they have for
supporting large pages and using them with existing applications without
recompilation. If nothing else, this paper is interesting to compare how
Solaris provides large pages in comparison to Linux.

I could keep digging, but I think the bottom line is that having large
pages generally available rather than a fixed setting is desirable.

> > We know right now that the overhead of this allocator is fairly low
> > (anyone got benchmarks to disagree) but I understand that page migration
> > is relatively expensive. The allocator also does not have adverse
> > CPU+cache affects like migration and the concept is fairly simple.
>
> Agreed.
>
> > > Its quite possible that not all unsatisfiable high-order allocations
> > > want to force page migration (which is quite expensive in terms of
> > > CPU/cache). Only migrate on __GFP_NOFAIL ?
> > >
> >
> > I still believe with the allocator, we will only have to migrate in
> > exceptional circumstances.
>
> Agreed - best scenario is the guaranteed availability of high-order blocks, where
> migration is not necessary.
>

Right, although I also believe it will be a while before we really start
taking advantage of the high-order blocks as we've lived a long time with
the assumption that high-order allocations will fail.

-- 
Mel Gorman
