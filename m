Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVAWRFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVAWRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVAWRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 12:05:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45446 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261332AbVAWRE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 12:04:57 -0500
Date: Sun, 23 Jan 2005 11:28:10 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
Message-ID: <20050123132810.GA583@logos.cnet>
References: <20050120101300.26FA5E598@skynet.csn.ul.ie> <20050121142854.GH19973@logos.cnet> <Pine.LNX.4.58.0501222128380.18282@skynet> <20050122215949.GD26391@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122215949.GD26391@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 07:59:49PM -0200, Marcelo Tosatti wrote:
> On Sat, Jan 22, 2005 at 09:48:20PM +0000, Mel Gorman wrote:
> > On Fri, 21 Jan 2005, Marcelo Tosatti wrote:
> > 
> > > On Thu, Jan 20, 2005 at 10:13:00AM +0000, Mel Gorman wrote:
> > > > <Changelog snipped>
> > >
> > > Hi Mel,
> > >
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
> > 1. Download and unpack vmregress
> > 2. Patch a kernel with kernel_patches/v2.6/trace_pagealloc-count.diff .
> > The patch currently requires the modified allocator but I can fix that up
> > if people want it. Build and deploy the kernel
> > 3. Build vmregress by
> >   ./configure --with-linux=/usr/src/linux-2.6.11-rc1-mbuddy
> >   (or whatever path is appropriate)
> >   make
> > 4. Load the modules with;
> >   insmod src/code/vmregress_core.ko
> >   insmod src/sense/trace_alloccount.ko
> > 
> > This will create a proc entry /proc/vmregress/trace_alloccount that looks
> > something like;
> > 
> > Allocations (V1)
> > -----------
> > KernNoRclm   997453      370       50        0        0        0        0        0        0        0        0
> > KernRclm      35279        0        0        0        0        0        0        0        0        0        0
> > UserRclm    9870808        0        0        0        0        0        0        0        0        0        0
> > Total      10903540      370       50        0        0        0        0        0        0        0        0
> > 
> > Frees
> > -----
> > KernNoRclm   590965      244       28        0        0        0        0        0        0        0        0
> > KernRclm     227100       60        5        0        0        0        0        0        0        0        0
> > UserRclm    7974200       73       17        0        0        0        0        0        0        0        0
> > Total      19695805      747      100        0        0        0        0        0        0        0        0
> > 
> > To blank the counters, use
> > 
> > echo 0 > /proc/vmregress/trace_alloccount
> > 
> > Whatever workload we come up with, this proc entry will tell us if it is
> > exercising high-order allocations right now.
> 
> Great, excellent! Thanks.
> 
> I plan to spend some time testing and trying to understand the vmregress package 
> this week.
>  
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
> There is overhead associated with setting up and managing the scatter/gather tables. 
> 
> The benefit of large physically contiguous blocks is the ability to avoid the SG 
> management overhead. 
> 
> Now the question is: The added overhead of allocating high order blocks through migration 
> offsets the overhead of SG IO ? Quantifying that is interesting.

What is the overhead of the SG IO management and how is the improvement without them?

Are block IO drivers trying to allocate big physical segments? I bet they are not, because the
"pool of huge pages" (as you say) is limited.

> 
> This depends on the driver implementation (how efficiently its able to manage the SG IO tables) and 
> device/IO subsystem characteristics.
> 
> Also filesystems benefit from big physically contiguous blocks. Quoting wli
> "they want bigger blocks and contiguous memory to match bigger blocks..."
> 
> I completly agree that your simplified allocator decreases fragmentation which in turn
> benefits the system overall. 
> 
> This is an area which can be further improved - ie efficiency in reducing fragmentation 
> is excellent. 
> I sincerely appreciate the work you are doing!
> 
> > > To measure whether the cost of page migration offsets the ability to be
> > > able to deliver high-order allocations we want a set of meaningful
> > > performance tests?
> > >
> > 
> > Bear in mind, there are more considerations. The allocator potentially
> > makes hotplug problems easier and could be easily tied into any
> > page-zeroing system. Some of your own benchmarks also implied that the
> > modified allocator helped some types of workloads which is beneficial in
> > itself.The last consideration is HugeTLB pages, which I am hoping William
> > will weigh in.
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
> > We know right now that the overhead of this allocator is fairly low
> > (anyone got benchmarks to disagree) but I understand that page migration
> > is relatively expensive. The allocator also does not have adverse
 > CPU+cache affects like migration and the concept is fairly simple.
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
