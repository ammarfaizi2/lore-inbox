Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSJEW2P>; Sat, 5 Oct 2002 18:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSJEW2P>; Sat, 5 Oct 2002 18:28:15 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:30693 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262776AbSJEW2J> convert rfc822-to-8bit; Sat, 5 Oct 2002 18:28:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [RFC] Simple NUMA scheduler patch
Date: Sun, 6 Oct 2002 00:32:37 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200210021954.39358.efocht@ess.nec.de> <953763699.1033565134@[10.10.2.3]>
In-Reply-To: <953763699.1033565134@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210051834.31031.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin & Michael,

thanks for the mails and the results.

On Wednesday 02 October 2002 22:25, Martin J. Bligh wrote:
> > it's a start. But I'm afraid a full solution will need much more code
> > (which is one of the problems with my NUMA scheduler patch).
>
> Right, but a sequence of smaller patches will be easier to get in.
> I see this as a first step towards your larger patch ... if we can
> do something simpler like Michael has, with enough view to your
> later plans to make them merge together cleanly, I think we have
> the best of both worlds ... Erich, what would it take to make this
> a first stepping stone towards what you have? Or is it there already?

It would probably save some time if we reuse parts of the code which
is already there (as with sched_migrate_task). I'd like to mention that
the node affine scheduler is already in production use at several HPC
sites and thus pretty well tested. The performance degradation you've
hit on NUMAQ must be specific to the architecture and doesn't hit Azusa
that much (we just don't see that). I think that could result from
the idle tasks having homenode 0, this should be fixed in sched_init. 
I'll post some numbers comparing O(1), pooling scheduler, node affine
scheduler and RSS based affinity in a separate email. That should help
to decide on the direction we should move. 

Right now the approaches are far from each other because there is no
concept of looping over the CPUs in a node. I can't imagine that we
can live without that when the patch gets more complex. I suggest to use
a sorted list of CPUs (sorted by node number) and a pointer into that
list (what I was calling pool_cpus, pool_ptr):

in topology.h:
#ifdef CONFIG_NUMA_SCHED
int _node_cpus[NR_CPUS];
int node_ptr[MAX_NUMNODES+1];
#define node_cpus(i) _node_cpus[i]
#define loop_over_node(i,n) for(i=node_ptr[n];i<node_ptr[n+1];i++)
#else
#define node_cpus(i) (i)
#define loop_over_node(i,n) for(i=0;i<NR_CPUS;i++)
#endif

Looping over nodes would be:
	loop_over_node(i,node) {
		cpu=node_cpus(i);
		...
	}

For non-NUMA systems there's only one node containing all CPUs
and the "cpu=code_cpus(i)" line will be optimized away. The
initialization would simply be:

{
	int n, cpu, ptr;
	unsigned long mask;
	ptr=0;
	for (n=0; n<numnodes; n++) {
		mask = __node_to_cpu_mask(n);
		node_ptr[i] = ptr;
		for (cpu=0; cpu<NR_CPUS; cpu++)
			if (mask  & (1UL << cpu))
				_node_cpus[ptr++] = cpu;
	}
	node_ptr[numnodes]=ptr;
}



> The fact that Michael's patch seems to have better performance (at
> least for the very simple tests I've done) seems to reinforce the
> "many small steps" approach in my mind - it's easier to debug and
> analyse like that.

OK, I'll put the node-balanced initial load balancing on top of
Michael's patch. Let's see how it changes.

> > The ideas behind your patch are:
> > 2. Favor own node for stealing if any CPU on the own node is >25%
> > more loaded. Otherwise steal from another CPU if that one is >100%
> > more loaded.
> > ...
> > 2. is ok as it makes it harder to change the node. But again, you don't
> > aim at equally balanced nodes. And: if the task gets away from the node
> > on which it got its memory, it has no reason to ever come back to it.
>
> I don't think we should aim too hard for exactly equal balancing,
> it may well result in small peturbations causing task bouncing between
> nodes.

No, we shouldn't aim too hard. The histeresys introduced by the 25%
imbalance necessary to start load balancing (as in Ingo's scheduler)
is enough to protect us from the bouncing. But when running a small
number of tasks you'd like to get the best performance out of the machine.
For me that means the maximum memory bandwidth available for each task,
which you only get if you distribute the tasks equally among the nodes.
For large number of tasks you will always have good balance across the
nodes, the O(1) scheduler already inforces that.

> > For a final solution I believe that we will need targets like:
> > (a) equally balance nodes
> > (b) return tasks to the nodes where their memory is
> > (c) make nodes "sticky" for tasks which have their memory on them,
> > "repulsive" for other tasks.
>
> I'd add:
>
> (d) take into account the RSS when migrating tasks across nodes
>     (ie stickiness is proportional to amount of RAM used on nodes)
Yes. Though it sounds like a refinement of (c) ;-)

Best regards,
Erich

