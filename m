Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTAMLX2>; Mon, 13 Jan 2003 06:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbTAMLX1>; Mon, 13 Jan 2003 06:23:27 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:25298 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267286AbTAMLXY> convert rfc822-to-8bit; Mon, 13 Jan 2003 06:23:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: NUMA scheduler 2nd approach
Date: Mon, 13 Jan 2003 12:32:40 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301130055.28005.efocht@ess.nec.de> <20030113080207.A9119@infradead.org>
In-Reply-To: <20030113080207.A9119@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131232.40600.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

thanks for reviewing the code and the helpful comments!

On Monday 13 January 2003 09:02, Christoph Hellwig wrote:
> On Mon, Jan 13, 2003 at 12:55:28AM +0100, Erich Focht wrote:
> > as discussed on the LSE call I played around with a cross-node
> > balancer approach put on top of the miniature NUMA scheduler. The
> > patches are attached and it seems to be clear that we can regain the
> > good performance for hackbench by adding a cross-node balancer.
>
> The changes look fine to me.  But I think there's some conding style
> issues that need cleaning up (see below).  Also is there a reason
> patches 2/3 and 4/5 aren't merged into one patch each?

The patches are separated by their functionality. Patch 2 comes from
Michael Hohnbaum, so I kept that separate for that reason. Right now
we can exchange the single components but when we decide that they are
doing the job, I'd also prefer to have just one patch.

>  /*
> - * find_busiest_queue - find the busiest runqueue.
> + * find_busiest_in_mask - find the busiest runqueue among the cpus in
> cpumask */
> -static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int
> this_cpu, int idle, int *imbalance) +static inline runqueue_t
> *find_busiest_in_mask(runqueue_t *this_rq, int this_cpu, int idle, int
> *imbalance, unsigned long cpumask)
>
>
> 	find_busiest_queue has just one caller in 2.5.56, I'd suggest just
> 	changing the prototype and updating that single caller to pass in
> 	the cpumask opencoded.

Having find_busiest_queue() and find_busiest_in_mask() as separate
function makes it simpler to merge in the cross-node balancer (patch
3). Otherwise we'd have to add two #ifdef CONFIG_NUMA blocks into
load_balance() (one for new variable declarations, the other one for
selecting the target node mask). We might have several calls to
find_busiest_in_mask() later, if we decide to add multi-level node
hierarchy support...


> 	I don't think you need this spurious whitespace change :)

:-) slipped in somehow.


> +#ifdef CONFIG_NUMA
> +extern void sched_balance_exec(void);
> +extern void node_nr_running_init(void);
> +#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
> +	rq->nr_running++
> +#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
> +	rq->nr_running--
>
> 	static inline void nr_running_inc(runqueue_t *rq)
> 	{
> 		atomic_inc(rq->node_ptr);
> 		rq->nr_running++
> 	}
>
> 	etc.. would look a bit nicer.

We can change this. Michael, ok with you?


> +#if CONFIG_NUMA
> +static atomic_t node_nr_running[MAX_NUMNODES]
> ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
>
> 	Maybe wants some linewrapping after 80 chars?

Yes.


> +	for (i = 0; i < NR_CPUS; i++) {
> +		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
> +	}
> +	return;
> +}
>
> 	The braces and the return are superflous.  Also kernel/sched.c (or
> 	mingo codein general) seems to prefer array + i instead of &array[i]
> 	(not that I have a general preferences, but you should try to match
> 	the surrounding code)

Will change the braces and remove the return. I personally find
&array[i] more readable.

> +static void sched_migrate_task(task_t *p, int dest_cpu)
> +{
> +	unsigned long old_mask;
> +
> +	old_mask = p->cpus_allowed;
> +	if (!(old_mask & (1UL << dest_cpu)))
> +		return;
> +	/* force the process onto the specified CPU */
> +	set_cpus_allowed(p, 1UL << dest_cpu);
> +
> +	/* restore the cpus allowed mask */
> +	set_cpus_allowed(p, old_mask);
>
> 	This double set_cpus_allowed doesn't look nice to me.  I don't
> 	have a better suggestion of-hand, though :(

This is not that bad. It involves only one single wakeup of the
migration thread, and that's more important. Doing it another way
would mean to replicate the set_cpus_allowed() code.

> +#define decl_numa_int(ctr) int ctr
>
> 	This is ugly as hell.  I'd prefer wasting one int in each runqueue
> 	or even an ifdef in the struct declaration over this obsfucation
> 	all the time.

Agreed :-) Just trying to avoid #ifdefs in sched.c as much as
possible. Somehow had the feeling Linus doesn't like that. On the
other hand: CONFIG_NUMA is a special case of CONFIG_SMP and nobody has
anything against CONFIG_SMP in sched.c...


> @@ -816,6 +834,16 @@ out:
>  static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int
> this_cpu, int idle, int *imbalance) {
>  	unsigned long cpumask = __node_to_cpu_mask(__cpu_to_node(this_cpu));
> +#if CONFIG_NUMA
> +	int node;
> +#       define INTERNODE_LB 10
>
> 	This wants to be put to the other magic constants in the scheduler
> 	and needs an explanation there.

We actually get rid of this in patch #5 (variable internode_lb,
depending on the load of the current node). But ok, I'll move the
MIN_INTERNODE_LB and MAX_INTERNODE_LB variables to the magic
constants. They'll be outside the #ifdef CONFIG_NUMA block...

Thanks,

best regards,
Erich

