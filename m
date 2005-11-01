Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVKARAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVKARAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVKARAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:00:10 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:60368 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750911AbVKARAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:00:08 -0500
Date: Tue, 1 Nov 2005 17:00:05 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.58.0511011641100.14884@skynet>
Message-ID: <Pine.LNX.4.58.0511011658200.14884@skynet>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie> 
 <20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au> 
 <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> 
 <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
  <4366C559.5090504@yahoo.com.au>  <45430000.1130858744@[10.10.2.4]>
 <1130859193.14475.104.camel@localhost> <Pine.LNX.4.58.0511011641100.14884@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Mel Gorman wrote:

> On Tue, 1 Nov 2005, Dave Hansen wrote:
>
> > On Tue, 2005-11-01 at 07:25 -0800, Martin J. Bligh wrote:
> > > > I really don't think we *want* to say we support higher order allocations
> > > > absolutely robustly, nor do we want people using them if possible. Because
> > > > we don't. Even with your patches.
> > > >
> > > > Ingo also brought up this point at Ottawa.
> > >
> > > Some of the driver issues can be fixed by scatter-gather DMA *if* the
> > > h/w supports it. But what exactly do you propose to do about kernel
> > > stacks, etc? By the time you've fixed all the individual usages of it,
> > > frankly, it would be easier to provide a generic mechanism to fix the
> > > problem ...
> >
> > That generic mechanism is the kernel virtual remapping.  However, it has
> > a runtime performance cost, which is increased TLB footprint inside the
> > kernel, and a more costly implementation of __pa() and __va().
> >
> > I'll admit, I'm biased toward partial solutions without runtime cost
> > before we start incurring constant cost across the entire kernel,
> > especially when those partial solutions have other potential in-kernel
> > users.
>
> To give an idea of the increased TLB footprint, I ran an aim9 test with
> cpu_has_pse disabled in include/arch-i386/cpufeature.h to force the use
> of small pages for the physical memory mappings.
>
> This is the -clean results
>
>                     clean  clean-nopse
>  1 creat-clo      16006.00   15294.90    -711.10 -4.44% File Creations and Closes/second
>  2 page_test     117515.83  118677.11    1161.28  0.99% System Allocations & Pages/second
>  3 brk_test      440289.81  436042.64   -4247.17 -0.96% System Memory Allocations/second
>  4 jmp_test     4179466.67 4173266.67   -6200.00 -0.15% Non-local gotos/second
>  5 signal_test    80803.20   78286.95   -2516.25 -3.11% Signal Traps/second
>  6 exec_test         61.75      60.45      -1.30 -2.11% Program Loads/second
>  7 fork_test       1327.01    1318.11      -8.90 -0.67% Task Creations/second
>  8 link_test       5531.53    5406.60    -124.93 -2.26% Link/Unlink Pairs/second
>
> This is what mbuddy-v19 with and without pse looks like
>
>                  mbuddy-v19 mbuddy-v19-nopse
>  1 creat-clo      15889.41   15328.22    -561.19 -3.53% File Creations and Closes/second
>  2 page_test     117082.15  116892.70    -189.45 -0.16% System Allocations & Pages/second
>  3 brk_test      437887.37  432716.97   -5170.40 -1.18% System Memory Allocations/second
>  4 jmp_test     4179950.00 4176087.32   -3862.68 -0.09% Non-local gotos/second
>  5 signal_test    85335.78   78553.57   -6782.21 -7.95% Signal Traps/second
>  6 exec_test         61.92      60.61      -1.31 -2.12% Program Loads/second
>  7 fork_test       1342.21    1292.26     -49.95 -3.72% Task Creations/second
>  8 link_test       5555.55    5412.90    -142.65 -2.57% Link/Unlink Pairs/second
>

I forgot to include the comparison between -clean and -mbuddy-v19-nopse

                  clean     mbuddy-v19-nopse
 1 creat-clo      16006.00   15328.22    -677.78 -4.23% File Creations and Closes/second
 2 page_test     117515.83  116892.70    -623.13 -0.53% System Allocations & Pages/second
 3 brk_test      440289.81  432716.97   -7572.84 -1.72% System Memory Allocations/second
 4 jmp_test     4179466.67 4176087.32   -3379.35 -0.08% Non-local gotos/second
 5 signal_test    80803.20   78553.57   -2249.63 -2.78% Signal Traps/second
 6 exec_test         61.75      60.61      -1.14 -1.85% Program Loads/second
 7 fork_test       1327.01    1292.26     -34.75 -2.62% Task Creations/second
 8 link_test       5531.53    5412.90    -118.63 -2.14% Link/Unlink Pairs/second

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
