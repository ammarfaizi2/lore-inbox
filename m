Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286007AbRLHWYD>; Sat, 8 Dec 2001 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286008AbRLHWXx>; Sat, 8 Dec 2001 17:23:53 -0500
Received: from zok.SGI.COM ([204.94.215.101]:65428 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S286007AbRLHWXo>;
	Sat, 8 Dec 2001 17:23:44 -0500
Date: Sat, 8 Dec 2001 14:24:36 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Niels Christiansen <nchr@us.ibm.com>, kiran@linux.ibm.com,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <20011207142448.A15810@in.ibm.com>
Message-ID: <Pine.SGI.4.21.0112081415580.201492-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Dipankar Sarma wrote:
> .... If we extend kmem_cache_alloc() to allocate memory
> in a particular NUMA node, we could simply do this for placing the
> counters -
> 
> static int pcpu_ctr_mem_grow(struct pcpu_ctr_ctl *ctl, int flags)
> {
>         ...
> 
>         /* Get per cpu cache lines for the block */
>         for_each_cpu(cpu) {
>                blkp->lineaddr[cpu] = kmem_cache_alloc_node(ctl->cachep, 
> 						flags, CPU_TO_NODE(cpu));
>                ...
>         }
> 
> This would put the block of counters corresponding to a CPU in
> memory local to the NUMA node.

Rather than baking into each call of kmem_cache_alloc_node()
the CPU_TO_NODE() transformation, how about having a
kmem_cache_alloc_cpu() call that allocates closest to a
specified cpu.

I would prefer to avoid spreading the assumption that for each
cpu there is an identifiable node that has a single memory
that is best for all cpus on that node.  Instead, assume that
for each cpu, there is an identifiable best memory ... and let
the internal implementation of kmem_cache_alloc_cpu() find that
best memory for the specified cpu.

Given this change, the kmem_cache_alloc_cpu() implementation
could use the CpuMemSets NUMA infrastructure that my group is
working on to find the best memory.  With CpuMemSets, the
kernel will have, for each cpu, a list of memories, sorted
by distance from that cpu.  Just take the first memory block
off the selected cpus memory list for the above purpose.


                          I won't rest till it's the best ...
			  Manager, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

