Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282955AbRLIDqt>; Sat, 8 Dec 2001 22:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282954AbRLIDqk>; Sat, 8 Dec 2001 22:46:40 -0500
Received: from rj.sgi.com ([204.94.215.100]:49866 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S282706AbRLIDqU>;
	Sat, 8 Dec 2001 22:46:20 -0500
From: Jack Steiner <steiner@sgi.com>
Message-Id: <200112090346.VAA10532@fsgi055.americas.sgi.com>
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: pj@engr.sgi.com (Paul Jackson)
Date: Sat, 8 Dec 2001 21:46:15 -0600 (CST)
Cc: dipankar@in.ibm.com (Dipankar Sarma), nchr@us.ibm.com (Niels Christiansen),
        kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.21.0112081415580.201492-100000@sam.engr.sgi.com> from "Paul Jackson" at Dec 08, 2001 02:24:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 7 Dec 2001, Dipankar Sarma wrote:
> > .... If we extend kmem_cache_alloc() to allocate memory
> > in a particular NUMA node, we could simply do this for placing the
> > counters -
> > 
> > static int pcpu_ctr_mem_grow(struct pcpu_ctr_ctl *ctl, int flags)
> > {
> >         ...
> > 
> >         /* Get per cpu cache lines for the block */
> >         for_each_cpu(cpu) {
> >                blkp->lineaddr[cpu] = kmem_cache_alloc_node(ctl->cachep, 
> > 						flags, CPU_TO_NODE(cpu));
> >                ...
> >         }
> > 
> > This would put the block of counters corresponding to a CPU in
> > memory local to the NUMA node.
> 
> Rather than baking into each call of kmem_cache_alloc_node()
> the CPU_TO_NODE() transformation, how about having a
> kmem_cache_alloc_cpu() call that allocates closest to a
> specified cpu.

I think it depends on whether the slab allocator manages memory by cpu or
node. Since the number of cpus per node is rather small (<=8) for
most NUMA systems, I would expect the slab allocator to manage by node.
Managing by cpu would likely add extra fragmentation and no real performance
benefit.


> 
> I would prefer to avoid spreading the assumption that for each
> cpu there is an identifiable node that has a single memory
> that is best for all cpus on that node.  

But this is already true for the page allocator (alloc_pages_node()).

The page pools are managed by node, not cpu. All memory on a node is
managed by a single pg_data_t structure. This structure contains/points-to
the tables for the memory on the node (page structs, free lists, etc). 

If a cpu needs to allocate local memory, it determines it's node_id.
This node_id is in the cpu_data structure for the cpu so this is an easy
calculation (one memory reference). The nodeid is used find the pgdata_t struct
for the node (index into an array of node-local pointers, so again, no offnode
references).

Assuming the slab allocator manages by node, kmem_cache_alloc_node() & 
kmem_cache_alloc_cpu() would be identical (exzcept for spelling :-). 
Each would pick up the nodeid from the cpu_data struct, then allocate 
from the slab cache for that node.


> Instead, assume that
> for each cpu, there is an identifiable best memory ... and let
> the internal implementation of kmem_cache_alloc_cpu() find that
> best memory for the specified cpu.
> 
> Given this change, the kmem_cache_alloc_cpu() implementation
> could use the CpuMemSets NUMA infrastructure that my group is
> working on to find the best memory.  With CpuMemSets, the
> kernel will have, for each cpu, a list of memories, sorted
> by distance from that cpu.  Just take the first memory block
> off the selected cpus memory list for the above purpose.
> 
> 
>                           I won't rest till it's the best ...
> 			  Manager, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373
> 
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 


-- 
Thanks

Jack Steiner    (651-683-5302)   (vnet 233-5302)      steiner@sgi.com

