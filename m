Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317094AbSEXGKP>; Fri, 24 May 2002 02:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSEXGKO>; Fri, 24 May 2002 02:10:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36261 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317094AbSEXGKM>;
	Fri, 24 May 2002 02:10:12 -0400
Date: Fri, 24 May 2002 11:43:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [RFC] Dynamic percpu data allocator
Message-ID: <20020524114318.A11249@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020523183835.E4714@in.ibm.com> <AAEGIMDAKGCBHLBAACGBOEKFCJAA.balbir.singh@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:07:59AM +0530, BALBIR SINGH wrote:
> Hello, Dipankar,
> 
> I would prefer to use the existing slab allocator for this.
> I am not sure if I understand your requirements for the per-cpu
> allocator correctly, please correct me if I do not.
> 
> What I would like to see
> 
> 1. Have per-cpu slabs instead of per-cpu cpucache_t. One should
>    be able to tell for which caches we want per-cpu slabs. This
>    way we can make even kmalloc per-cpu. Since most of the kernel
>    would use and dispose memory before they migrate across cpus.
>    I think this would be useful, but again no data to back it up.

Allocating cpu-local memory is a different issue altogether.
Eventually for NUMA support, we will have to do such allocations
that supports choosing memory closest to a group of CPUs.

The per-cpu data allocator allocates one copy for *each* CPU.
It uses the slab allocator underneath. Eventually, when/if we have
per-cpu/numa-node slab allocation, the per-cpu data allocator
can allocate every CPU's copy from memory closest to it.

I suppose you worked on DYNIX/ptx ? Think of this as dynamic
plocal. 

> 
> 2. I hate the use of NR_CPUS. If I compiled an SMP kernel on a two
>    CPU machine, I still end up with support for 32 CPUs. What I would

If you don't like it, just define NR_CPUS to 2 and recompile.


>    like to see is that in new kernel code, we should use treat equivalent
>    classes of CPUs as belonging to the same CPU. For example
> 
>    void *blkaddrs[NR_CPUS];
> 
>    while searching, instead of doing
> 
>    blkaddrs[smp_processor_id()], if the slot for smp_processor_id() is full,
>    we should look through
> 
>    for (i = 0; i < NR_CPUS; i++) {
>      look into blkaddrs[smp_processor_id() + i % smp_number_of_cpus()(or
> whatever)]
>      if successful break
>    }

How will it work ? You could be accessing memory beyond blkaddrs[].

I use NR_CPUS for allocations because if I don't, supporting CPU
hotplug will be a nightmare. Resizing so many data structures is
not an option. I believe Rusty and/or cpu hotplug work is
adding a for_each_cpu() macro to walk the CPUs that take
care of everything including sparse CPU numbers. Until then,
I would use for (i = 0; i < smp_num_cpus; i++).

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
