Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316778AbSE3Rvv>; Thu, 30 May 2002 13:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSE3Rvu>; Thu, 30 May 2002 13:51:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:19084 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316778AbSE3Rvt>; Thu, 30 May 2002 13:51:49 -0400
Date: Thu, 30 May 2002 23:25:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Mala Anand <manand@us.ibm.com>
Cc: BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net,
        Paul McKenney <Paul.McKenney@us.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Message-ID: <20020530232513.C3575@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <OF6BEB750B.90A03073-ON85256BC9.0041372C@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 08:56:36AM -0500, Mala Anand wrote:
>                                                                                                                                                
>                       dipankar@beaverton.ibm.co                                                                                                
>                       m                                To:       BALBIR SINGH <balbir.singh@wipro.com>                                         
> 
> >The per-cpu data allocator allocates one copy for *each* CPU.
> >It uses the slab allocator underneath. Eventually, when/if we have
> >per-cpu/numa-node slab allocation, the per-cpu data allocator
> >can allocate every CPU's copy from memory closest to it.
> 
> Does this mean that memory allocation will happen in "each" CPU?
> Do slab allocator allocate the memory in each cpu? Your per-cpu
> data allocator sounds like the hot list skbs that are in the tcpip stack
> in the sense it is one level above the slab allocator and the list is
> kept per cpu.  If slab allocator is fixed for per cpu, do you still
> need this per-cpu data allocator?

Actually I don't know for sure what plans are afoot to fix the slab allocator
for per-cpu. One plan I heard about was allocating from per-cpu pools
rather than per-cpu copies. My requirements are similar to
the hot list skbs. I want to do this -

	int *ctrp1, *ctrp2;
	
	ctrp1 = kmalloc_percpu(sizeof(*ctrp1), GFP_ATOMIC);
	if (ctrp1 == NULL) {
		/* recover */
	}
	ctrp2 = kmalloc_percpu(sizeof(*ctrp2), GFP_ATOMIC);
	if (ctrp2 == NULL) {
		/* recover */
	}

	*per_cpu_ptr(ctrp1, smp_processor_id())++;
	this_cpu_ptr(ctrp2)++;

Now I can allocate by making ctrp1/ctrp2 point to an array
of NR_CPUS and kmalloc() memory for each CPU's copy of the
int. This is simple and will work. 

	void **ptrs = kmalloc(sizeof(*ptrs) * NR_CPUS, flags);

	if (!ptrs) return NULL;
	for (i = 0; i < NR_CPUS; i++) {
	      ptrs[i] = kmalloc(size, flags);
	      if (!ptrs[i])
		      goto unwind_oom;
	}


However I would like to use kmalloc_percpu() for allocating very 
small objects - typlically integer counters or small structures
to be used as per-cpu counters for things like dst entries and dentries.
kmalloc will waste the rest of the cache line for such small objects.
The alternative is to use a layer of code to interleave small objects
and save on space.


   CPU #0          CPU#1

 ---------       ---------         Start of cache line
   *ctrp1         *ctrp1
   *ctrp2         *ctrp2

   .               .
   .               .
   .               .
   .               .
   .               .

 ---------       ----------        End of cache line

I have an allocator that interleaves objects like this if they can be fitted
into size that is a factor of SMP_CACHE_BYTES. 

I hope someone can tell me that I don't even have to do this. Otherwise
I will go ahead and do my thing.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
