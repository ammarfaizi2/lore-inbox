Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311583AbSCTGPU>; Wed, 20 Mar 2002 01:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311585AbSCTGPL>; Wed, 20 Mar 2002 01:15:11 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:41415 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S311583AbSCTGO4>; Wed, 20 Mar 2002 01:14:56 -0500
Date: Tue, 19 Mar 2002 22:15:30 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <221408128.1016576129@[10.10.2.3]>
In-Reply-To: <20020320024008.A4268@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have PIII cpus pre3 mainline has a bug in the machine check code,
> this one liner will fix it:

Thanks - that'll probably save me a bunch of time ... 

May I assume, for the sake of discussion, that there's not much 
difference between pre1-aa1 and your latest stuff in the area we're 
talking about here?

> One thing I see is not only a scalability problem with the locking, but
> it seems kmap_high is also spending an huge amount of time in kernel
> compared to the "standard" profiling.  

One other wierd thing to note in the profiling is that kunmap_high
is way up in the profile as well - seeing as kunmap_high doesn't
do the same sort of scanning as kmap_high, it shouldn't be O(N).
I'm wondering if somehow the profiling attributes some of the spinning
cost to the calling function. Pure speculation, but there's defintely
something strange there ....

> That maybe  because I increased
> too much the size of the pool (the algorithm is O(N)). Can you try 
> again with this incremental patch applied?

Sure ... will retest. But by shrinking the size of the pool back down, 
won't you just increase the number of global tlbflushes? Any way you 
cut it, the kmaps are going to be expensive ... according to the 
lockmeter stuff, you're doing about 3.5 times as many kmaps.

> The pte-highmem stuff has nothing to do with the kmap_high O(N)
> complexity that maybe the real reason of this slowdown. (the above 
> patch decreases N of an order of magnitude and so we'll see if that 
> was the real problem or not)

I appreciate the scanning doesn't scale well, but is the pte-highmem
stuff the cause of the increase of kmap frequency? There seems to be
both a frequency and duration problem.

> So avoiding persistent kmaps in the pte handling would in turn you give
> you additional scalability __if__ your workload is very pagetable
> intensive (a kernel compile is very pagetable intensive incidentally),
> but the very same scalability problem you can find with the pagetables
> you will have it also for the cache in different workloads because all
> the pagecache is in highmem too and every time you execute a read
> syscall you will also need to kmap-persistent a pagecache.

I don't think anyone would deny that making kmap faster / more scalable
would be a Good Thing ;-) I haven't stared at the pagecache code too
much - once we avoid the bounce buffers with Jens' patches, do we 
still need to do a kmap for the pagecache situation you mention?

> The 2.5 kernel avoids using persistent kmaps for pagetables, that's the
> only interesting difference with pte-highmem in 2.4 (all other
> differences are not interesting and I prefer pte-highmem for all other
> parts for sure), but note that you will still have to pay for an hit if
> you want the feature compared to the "standard" 2.4 that you benchmarked
> against: in 2.5 the CPU will have to walk pagetables for the kmap areas
> after every new kmap because the kmap will be forced to flush the tlb
> entry without persistence. The pagetables relative to the kmap atomic
> area are shared across all cpus and the cpu issues locked cycles to walk
> them.

OK, I guess we're back to the question of whether a local tlb_flush_one
per kmap is cheaper than a global tlb_flush_all once per LAST_PKMAP 
kmaps. Not just in terms of time to execute, but in terms of how much
we slow down others by trashing the cache ... I guess that's going to
be tough to really measure.

It would be nice to be able to compare the two different kmap approaches
against each other - AFAIK, the 2.5 implementation isn't available for 
2.4 to compare though ... if your stuff is easy to change over to 
atomic_kmap, I'd be happy to compare it (unless shrinking the pool size
fixes it, in which case we're done).

Thanks for taking the time to explain all of this - I have a much 
better idea what's going on now. I'll get you the new numbers tommorow.

M.

