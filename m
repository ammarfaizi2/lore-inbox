Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285436AbRLGIug>; Fri, 7 Dec 2001 03:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285435AbRLGIu1>; Fri, 7 Dec 2001 03:50:27 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18893 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285434AbRLGIuP>; Fri, 7 Dec 2001 03:50:15 -0500
Date: Fri, 7 Dec 2001 14:24:48 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Niels Christiansen <nchr@us.ibm.com>
Cc: kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207142448.A15810@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>; from nchr@us.ibm.com on Thu, Dec 06, 2001 at 10:10:47AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niels,

On Thu, Dec 06, 2001 at 10:10:47AM -0600, Niels Christiansen wrote:
> 
> Hi Kiran,
> 
> > Are you concerned with increase in memory used per counter Here? I
> suppose
> > that must not be that much of an issue for a 16 processor box....
> 
> Nope, I'm concerned that if this mechanism is to be used for all counters,
> the improvement in cache coherence might be less significant to the point
> where the additional overhead isn't worth it.

In a low-cpu-count SMP box, yes, this will be a concern. Kiran and I
do plan to study this and understand the impact.

> 
> Arjab van de Ven voiced similar concerns but he also said:
> 
> > There's several things where per cpu data is useful; low frequency
> > statistics is not one of them in my opinion.
> 
> ...which may be true for 4-ways and even 8-ways but when you get to
> 32-ways and greater, you start seeing cache problems.  That was the
> case on AIX and per-cpu counters was one of the changes that helped
> get the spectacular scalability on Regatta.

Yes. It also helped us in DYNIX/ptx on Sequent boxes. What we
need to do is to verify if theory based on prior experience is
also applicable to linux.

> 
> Anyway, since we just had a long thread going on NUMA topology, maybe
> it would be proper to investigate if there is a better way, such as
> using the topology to decide where to put counters?  I think so, seeing
> as it is that most Intel based 8-ways and above will have at least some
> NUMA in them.

It should be easy to place the counters in appropriately close
memory if linux gets good NUMA APIs built on top of the topology
services. If we extend kmem_cache_alloc() to allocate memory
in a particular NUMA node, we could simply do this for placing the
counters -

static int pcpu_ctr_mem_grow(struct pcpu_ctr_ctl *ctl, int flags)
{
        void *addr;
        struct pcpu_ctr_blk *blkp;
        unsigned int save_flags;
        int i;

        if (!(blkp = pcpu_ctr_blkctl_alloc(ctl, flags)))
                return 0;

        /* Get per cpu cache lines for the block */
        for_each_cpu(cpu) {
               blkp->lineaddr[cpu] = kmem_cache_alloc_node(ctl->cachep, 
						flags, CPU_TO_NODE(cpu));
               if(!(blkp->lineaddr[cpu]))
                       goto exit1;
               memset(blkp->lineaddr[cpu], 0, PCPU_CTR_LINE_SIZE);
        }

This would put the block of counters corresponding to a CPU in
memory local to the NUMA node. If there are more sophisticated
APIs available for suitable memory selection, those too can be made
use of here.

Is this the kind of thing you are looking at ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
