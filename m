Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268237AbTAMSzj>; Mon, 13 Jan 2003 13:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTAMSzh>; Mon, 13 Jan 2003 13:55:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61431 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268237AbTAMSx4>;
	Mon, 13 Jan 2003 13:53:56 -0500
Subject: Re: NUMA scheduler 2nd approach
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200301131232.40600.efocht@ess.nec.de>
References: <52570000.1042156448@flay>
	<200301130055.28005.efocht@ess.nec.de> <20030113080207.A9119@infradead.org>
	 <200301131232.40600.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Jan 2003 11:03:50 -0800
Message-Id: <1042484636.24747.129.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 03:32, Erich Focht wrote:
> Hi Christoph,
> 
> thanks for reviewing the code and the helpful comments!
> 
> On Monday 13 January 2003 09:02, Christoph Hellwig wrote:
> > On Mon, Jan 13, 2003 at 12:55:28AM +0100, Erich Focht wrote:
> > > as discussed on the LSE call I played around with a cross-node
> > > balancer approach put on top of the miniature NUMA scheduler. The
> > > patches are attached and it seems to be clear that we can regain the
> > > good performance for hackbench by adding a cross-node balancer.
> >
> > The changes look fine to me.  But I think there's some conding style
> > issues that need cleaning up (see below).  Also is there a reason
> > patches 2/3 and 4/5 aren't merged into one patch each?
> 
> The patches are separated by their functionality. Patch 2 comes from
> Michael Hohnbaum, so I kept that separate for that reason. Right now
> we can exchange the single components but when we decide that they are
> doing the job, I'd also prefer to have just one patch.

I'm not opposed to combining the patches, but isn't it typically
preferred to have patches as small as possible?  The initial load
balance patch (patch 2) applies and functions fairly independent
of the the other patches, so has been easy to maintain as a separate
patch.
> 
> 
> > +#ifdef CONFIG_NUMA
> > +extern void sched_balance_exec(void);
> > +extern void node_nr_running_init(void);
> > +#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
> > +	rq->nr_running++
> > +#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
> > +	rq->nr_running--
> >
> > 	static inline void nr_running_inc(runqueue_t *rq)
> > 	{
> > 		atomic_inc(rq->node_ptr);
> > 		rq->nr_running++
> > 	}
> >
> > 	etc.. would look a bit nicer.
> 
> We can change this. Michael, ok with you?

Fine with me.
> 
> 
> > +#if CONFIG_NUMA
> > +static atomic_t node_nr_running[MAX_NUMNODES]
> > ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
> >
> > 	Maybe wants some linewrapping after 80 chars?
> 
> Yes.
> 
> 
> > +	for (i = 0; i < NR_CPUS; i++) {
> > +		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
> > +	}
> > +	return;
> > +}
> >
> > 	The braces and the return are superflous.  Also kernel/sched.c (or
> > 	mingo codein general) seems to prefer array + i instead of &array[i]
> > 	(not that I have a general preferences, but you should try to match
> > 	the surrounding code)
> 
> Will change the braces and remove the return. I personally find
> &array[i] more readable.

I agree with Erich here - &array[i] is clearer.
> 
> > +static void sched_migrate_task(task_t *p, int dest_cpu)
> > +{
> > +	unsigned long old_mask;
> > +
> > +	old_mask = p->cpus_allowed;
> > +	if (!(old_mask & (1UL << dest_cpu)))
> > +		return;
> > +	/* force the process onto the specified CPU */
> > +	set_cpus_allowed(p, 1UL << dest_cpu);
> > +
> > +	/* restore the cpus allowed mask */
> > +	set_cpus_allowed(p, old_mask);
> >
> > 	This double set_cpus_allowed doesn't look nice to me.  I don't
> > 	have a better suggestion of-hand, though :(
> 
> This is not that bad. It involves only one single wakeup of the
> migration thread, and that's more important. Doing it another way
> would mean to replicate the set_cpus_allowed() code.

While this shows up in the patch credited to me, it was actually
Erich's idea, and I think a quite good one.  My initial impression
of this was that it was ugly, but upon closer examination (and trying
to implement this some other way) realized that Erich's implementation,
which I borrowed from, was quite good.

Good work Erich in getting the internode balancer written and
working.  I'm currently building a kernel with these patches and
will post results later in the day.  Thanks.
 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

