Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTATQOh>; Mon, 20 Jan 2003 11:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTATQOh>; Mon, 20 Jan 2003 11:14:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:26343 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266186AbTATQOg>; Mon, 20 Jan 2003 11:14:36 -0500
Date: Mon, 20 Jan 2003 08:23:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <1372810000.1043079799@titus>
In-Reply-To: <Pine.LNX.4.44.0301201022540.2585-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301201022540.2585-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernelbench is the kind of benchmark that is most sensitive to over-eager
> global balancing, and since the 2.5.59 ->nr_balanced logic produced the
> best results, it clearly shows it's not over-eager. 

Careful ... what shows well on one machine may not on another - this depends
heavily on the NUMA ratio - for our machine the nr_balanced logic in 59 is
still over-agressive (20:1 NUMA ratio). For low-ratio machines it may work
fine. It actually works best for us when it's switched off altogether I
think (which is obviously not a good solution).

But there's more than one dimension to tune here - we can tune both the 
frequency and the level of imbalance required. I had good results specifying
a minimum imbalance of > 4 between the current and busiest nodes before 
balancing. Reason (2 nodes, 4 CPUs each): If I have 4 tasks on one node, 
and 8 on another, that's still one or two per cpu in all cases whatever 
I do (well, provided I'm not stupid enough to make anything idle). So
at that point, I just want lowest task thrash. 

Moving tasks between nodes is really expensive, and shouldn't be done 
lightly - the only thing the background busy rebalancer should be fixing
is significant long-term imbalances. It would be nice if we also chose
the task with the smallest RSS to migrate, I think that's a worthwhile
optimisation (we'll need to make sure we use realistic benchmarks with
a mix of different task sizes). Working out which ones have the smallest
"on-node RSS - off-node RSS" is another step after that ...

> hackbench is one that is quite sensitive to under-balancing. 
> Ie. trying to maximize both will lead us to a good balance.

I'll try to do some hackbench runs on NUMA-Q as well.

Just to add something else to the mix, there's another important factor
as well as the NUMA ratio - the size of the interconnect cache vs the
size of the task migrated. The interconnect cache on the NUMA-Q is 32Mb,
our newer machine has a much lower NUMA ratio, but effectively a much
smaller cache as well. NUMA ratios are often expresssed in terms of
latency, but there's a bandwidth consideration too. Hyperthreading will
want something different again.

I think we definitely need to tune this on a per-arch basis. There's no
way that one-size-fits-all is going to fit a situation as complex as this
(though we can definitely learn from each other's analysis).

M.

