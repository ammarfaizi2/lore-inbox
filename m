Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUDFOlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbUDFOlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:41:51 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:40638 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263842AbUDFOlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:41:42 -0400
Message-ID: <4072C1C3.F430536B@nospam.org>
Date: Tue, 06 Apr 2004 16:42:11 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Hirokazu Takahashi <taka@valinux.co.jp>, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       iwamoto@valinux.co.jp
Subject: Re: Migrate pages from a ccNUMA node to another
References: <40695802.1F13AB0D@nospam.org>
		 <20040330.210804.71938972.taka@valinux.co.jp>
		 <40698501.BD3E12BF@nospam.org>
		 <20040403.115833.74749140.taka@valinux.co.jp>
		 <4071763E.7293CFCC@nospam.org> <1081179633.8956.2992.camel@nighthawk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> > > >Notes: "pte" can be NULL if I do not know it apriori
> > > >       I cannot release "mm->page_table_lock" otherwise I have to re-scan the "mm->pgd".
> > >
> > > Re-schan plicy would be much better since migrating pages is heavy work.
> > > I don't think that holding mm->page_table_lock for long time would be
> > > good idea.
> >
> > Re-scanning is "cache killer", at least on IA64 with huge user memory size.
> > I have more than 512 Mbytes user memory and its PTEs do not fit into the L2 cache.
> >
> > In my current design, I have the outer loops: PGD, PMD and PTE walking; and once
> > I find a valid PTE, I check it against the list of max. 2048 physical addresses as
> > the inner loop.
> > I reversed them: walking through the list of max. 2048 physical addresses as outer
> > loop and the PGD - PMD - PTE scans as inner loops resulted in 4 to 5 times slower
> > migration.
> 
> Could you explain where you're getting these "magic numbers?"  I don't
> quite understand the significance of 2048 physical addresses or 512 MB
> of memory.

I use an IA64 machine with page size of 16 Kbytes.

I allocate a single page (for simplicity) when I copy in from user space
the list of the addresses (2048 of them fit in a page).

One page of PTEs maps 32 Mbytes.
16 pages (which map 512 Mbytes) eat up my L2 cache of 256 Kbytes
(and the other data, the stack, the code, etc...).

Sure I have an L3 cache of at least 3 Mbytes (new CPUs have bigger L3 caches)
but it is much slower than the L2.

> Zoltan, it appears that we have a bit of an inherent conflict with how
> much CPU each of you is expecting to use in the removal and migration
> cases.  You're coming from a HPC environment where each CPU cycle is
> valuable, while the people trying to remove memory are probably going to
> be taking CPUs offline soon anyway, and care a bit less about how
> efficient they're being with CPU and cache resources.

Yes I see.

> Could you be a bit more explicit about how expensive (cpu-wise) these
> migrate operations can be?

My machine consists of 4 "Tiger boxes" connected together by a pair of Scalability
Port Switches. A "Tiger box" is built around a Scalable Node Controller (SNC), and
includes 4 Itanium-2 processors and some Gbytes of memory.
The CPU clock runs at 1.3 GHz. Local memory access costs 200 nanosec.
The NUMA factor is 1 : 2.25.

An OpenMP benchmark uses 1 Gbytes of memory and runs on 16 processors,
on 4 NUMA nodes.

If the benchmark is adapted to our NUMA architecture (local allocations by hand),
then it takes 86 seconds to complete.

As results are not accepted if obtained by modifying the benchmark in any
way, the best we can do is to use a random or round robin memory allocation
policy. We end up with a locality rate of 25 % and the benchmark executes in 121
seconds.

If we had a zero-overhead migration tool, then - I estimate - it would complete
In 92 seconds (the benchmark starts in a "pessimized" environment, and it takes
time for the locality ramp up from 25 % to almost 100 %).

Actually it takes 2 to 3 seconds to move 750 Mbytes of memory (on a heavily
loaded machine), reading out the counters of the SNCs and making some quick
decisions take 1 to 2 seconds, and we lose about 10 seconds due to the buggy
SNCs. We end up with 106 seconds.
(I keep holding the PGD lock, no re-scan while moving the max. 2048 pages.)

Inverting the inner - extern loops, i.e. for each page, I scan the PGD-PMD-PTE,
and the PGD lock is released between the scans, I have 10 to 12 seconds
spent on the migration (not counting the 1 to 2 seconds of the "AI" + ~10 seconds
due to the buggy SNCs.)

Thanks,

Zoltán
