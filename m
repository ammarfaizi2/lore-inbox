Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbSJ1Auy>; Sun, 27 Oct 2002 19:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJ1Auy>; Sun, 27 Oct 2002 19:50:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:24308 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262795AbSJ1Aux>;
	Sun, 27 Oct 2002 19:50:53 -0500
Subject: Re: [Lse-tech] Re: NUMA scheduler  (was: 2.5 merge candidate list
	1.5)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Erich Focht <efocht@ess.nec.de>, mingo@redhat.com,
       Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
In-Reply-To: <3126082889.1035733974@[10.10.2.3]>
References: <200210280132.33624.efocht@ess.nec.de> 
	<3126082889.1035733974@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 27 Oct 2002 16:55:24 -0800
Message-Id: <1035766530.8077.82.camel@hbaum>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm trying Michael's balance_exec on top of your patch 1 at the 
> moment, but I'm somewhat confused by his code for sched_best_cpu.
> 
> +static int sched_best_cpu(struct task_struct *p)
> +{
> +       int i, minload, best_cpu, cur_cpu, node;
> +       best_cpu = task_cpu(p);
> +       if (cpu_rq(best_cpu)->nr_running <= 2)
> +               return best_cpu;
> +
> +       node = __cpu_to_node(__get_cpu_var(last_exec_cpu));
> +       if (++node >= numnodes)
> +               node = 0;
> +       
> +       cur_cpu = __node_to_first_cpu(node);
> +       minload = cpu_rq(best_cpu)->nr_running;
> +
> +       for (i = 0; i < NR_CPUS; i++) {
> +               if (!cpu_online(cur_cpu))
> +                       continue;
> +
> +               if (minload > cpu_rq(cur_cpu)->nr_running) {
> +                       minload = cpu_rq(cur_cpu)->nr_running;
> +                       best_cpu = cur_cpu;
> +               }
> +               if (++cur_cpu >= NR_CPUS)
> +                       cur_cpu = 0;
> +       }
> +       __get_cpu_var(last_exec_cpu) = best_cpu;
> +       return best_cpu;
> +}
> 
> Michael, the way I read the NR_CPUS loop, you walk every cpu
> in the system, and take the best from all of them. In which case
> what's the point of the last_exec_cpu stuff? On the other hand, 
> I changed your NR_CPUS to 4 (ie just walk the cpus in that node), 
> and it got worse. So perhaps I'm just misreading your code ...
> and it does seem significantly cheaper to execute than Erich's.
> 
You are reading it correct.  The only thing that the last_exec_cpu
does is to help spread the load across nodes.  Without that what was
happening is that node 0 would get completely loaded, then node 1,
etc.  With it, in cases where one or more runqueues have the same
length, the one chosen tends to get spread out a bit.  Not the 
greatest solution, but it helps.
> 
-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

