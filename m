Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbSJ0Xt2>; Sun, 27 Oct 2002 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbSJ0Xt2>; Sun, 27 Oct 2002 18:49:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:460 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262006AbSJ0Xt0>; Sun, 27 Oct 2002 18:49:26 -0500
Date: Sun, 27 Oct 2002 15:52:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <3126082889.1035733974@[10.10.2.3]>
In-Reply-To: <200210280132.33624.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is interesting, indeed. As you might have seen from the tests I
> posted on LKML I could not see that effect on our IA64 NUMA machine.
> Which arises the question: is it expensive to recalculate the load
> when doing an exec (which I should also see) or is the strategy of
> equally distributing the jobs across the nodes bad for certain
> load+architecture combinations? 

I suspect the former. Bouncing a whole pile of cachelines every time
would be much more expensive for me than it would for you, and 
kernbench will be heavy on exec.

> As I'm not seeing the effect, maybe
> you could do the following experiment:
> In sched_best_node() keep only the "while" loop at the beginning. This
> leads to a cheap selection of the next node, just a simple round robin. 

Maybe I could just send you the profiles instead ;-)
If I have more time, I'll try your suggestion.
I'm trying Michael's balance_exec on top of your patch 1 at the 
moment, but I'm somewhat confused by his code for sched_best_cpu.

+static int sched_best_cpu(struct task_struct *p)
+{
+       int i, minload, best_cpu, cur_cpu, node;
+       best_cpu = task_cpu(p);
+       if (cpu_rq(best_cpu)->nr_running <= 2)
+               return best_cpu;
+
+       node = __cpu_to_node(__get_cpu_var(last_exec_cpu));
+       if (++node >= numnodes)
+               node = 0;
+       
+       cur_cpu = __node_to_first_cpu(node);
+       minload = cpu_rq(best_cpu)->nr_running;
+
+       for (i = 0; i < NR_CPUS; i++) {
+               if (!cpu_online(cur_cpu))
+                       continue;
+
+               if (minload > cpu_rq(cur_cpu)->nr_running) {
+                       minload = cpu_rq(cur_cpu)->nr_running;
+                       best_cpu = cur_cpu;
+               }
+               if (++cur_cpu >= NR_CPUS)
+                       cur_cpu = 0;
+       }
+       __get_cpu_var(last_exec_cpu) = best_cpu;
+       return best_cpu;
+}

Michael, the way I read the NR_CPUS loop, you walk every cpu
in the system, and take the best from all of them. In which case
what's the point of the last_exec_cpu stuff? On the other hand, 
I changed your NR_CPUS to 4 (ie just walk the cpus in that node), 
and it got worse. So perhaps I'm just misreading your code ...
and it does seem significantly cheaper to execute than Erich's.

Erich, on the other hand, your code does this:

+void sched_balance_exec(void)
+{
+       int new_cpu, new_node=0;
+
+       while (pooldata_is_locked())
+               cpu_relax();
+       if (numpools > 1) {
+               new_node = sched_best_node(current);
+       } 
+       new_cpu = sched_best_cpu(current, new_node);
+       if (new_cpu != smp_processor_id())
+               sched_migrate_task(current, new_cpu);
+}

which seems to me to walk every runqueue in the system (in
sched_best_node), then walk one node's worth all over again
in sched_best_cpu .... doesn't it? Again, I may be misreading
this ... haven't looked at the scheduler much. But I can't 
help feeling some sort of lazy evaluation is in order ....

And what's this doing?

+       do {
+               /* atomic_inc_return is not implemented on all archs [EF] */
+               atomic_inc(&sched_node);
+               best_node = atomic_read(&sched_node) % numpools;
+       } while (!(pool_mask[best_node] & mask));

I really don't think putting a global atomic in there is going to
be cheap ....

> Regarding the schedbench results: are they averages over multiple runs?
> The numa_test needs to be repeated a few times to get statistically
> meaningful results.

No. But I don't have 2 hours to run each set of tests either. I did
a couple of runs, and didn't see huge variances. Seems stable enough.

M.

