Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSEXJKR>; Fri, 24 May 2002 05:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSEXJKQ>; Fri, 24 May 2002 05:10:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13952 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314281AbSEXJKQ>;
	Fri, 24 May 2002 05:10:16 -0400
Date: Fri, 24 May 2002 14:43:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Message-ID: <20020524144301.D11249@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020524114318.A11249@in.ibm.com> <AAEGIMDAKGCBHLBAACGBKEKPCJAA.balbir.singh@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 02:08:50PM +0530, BALBIR SINGH wrote:
> 
> Sure, I understand what you are talking about now. That makes a lot
> of sense, I will go through your document once more and read it.
> I was thinking of the two combined (allocating CPU local memory
> for certain data structs also includes allocating one copy per CPU).
> Is there a reason to delay the implementation of CPU local memory,
> or are we waiting for NUMA guys to do it? Is it not useful in an
> SMP system to allocate CPU local memory?

In an SMP system, the entire memory is equidistant from the CPUs.
So, any memory that is exclusively accessed by once cpu only
is CPU-local. On a NUMA machine however that isn't true, so
you need special schemes.

The thing about one-copy-per-cpu allocator that I describe is that
it interleaves per-cpu data to save on space. That is if you
allocate per-cpu ints i1, i2, it will be laid out in memory like this -

   CPU #0          CPU#1

 ---------       ---------         Start of cache line
   i1              i1
   i2              i2 

   .               .
   .               .
   .               .
   .               .
   .               .

 ---------       ----------        End of cache line

The per-cpu copies of i1 and i2 for CPU #0 and CPU #1 are allocated from 
different cache lines of memory, but copy of i1 and i2 for CPU #0 are
in the same cache line. This interleaving saves space by avoiding
the need to pad small data structures to cache line sizes.
This essentially how the static per-cpu data area in 2.5 kernel
is laid out in memory. Since copies for CPU #0 and CPU #1 for
the same variable are on different cache lines, assuming that
code that accesses "this" CPU's copy will not result in cache line
bouncing. On an SMP machine, I can allocate the cache lines
for different CPUs, where the interleaved data structures are
laid out, using the slab allocator. On a NUMA machine however,
I would want to make sure that cache line allocated for this
purpose for CPU #N is closest possible to CPU #N.


Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
