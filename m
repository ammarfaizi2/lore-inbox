Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWC2CwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWC2CwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC2CwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:52:08 -0500
Received: from mga05.intel.com ([192.55.52.89]:13442 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750806AbWC2CwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:52:06 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16879878:sNHT20872012"
Date: Tue, 28 Mar 2006 18:52:02 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
Message-ID: <20060328185202.A1135@unix-os.sc.intel.com>
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4429BC61.7020201@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Mar 29, 2006 at 09:44:49AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 09:44:49AM +1100, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > We need to balance even if the other packages are not idle.. For example,
> > consider a 4-core DP system, if we have 6 runnable(assume same priority)
> > processes, we want to schedule 3 of them in each package..
> 
> Well I hope that when you do a proper implementation for this issue that 
> it takes this into account.  The current implementation doesn't.

This will also have issues when we want to implement power savings policy
for multi-core. Attached is the prototype patch(against 2.6.16-git15)
I was planning to send to mainline..

> > Todays active load balance implementation is very simple and generic. And
> > hence it works smoothly with dual and multi-core..
> 
> The application of active balancing to address your problem in the 
> current implementation is essentially random.

why so? we wanted to implement these HT and MC optimizations generically
in the scheduler and domain topology(and sched groups cpu_power) provided
that infrastructure cleanly..

> 
> > Please read my OLS 
> > 2005 paper which talks about different scheduling scenarios and also how 
> 
> A URL would be handy.

http://www.linuxsymposium.org/2005/linuxsymposium_procv2.pdf
Look for the paper titled "Chip Multi Processing aware Linux Kernel Scheduler"

> > 
> > Either way, I can show scheduling scenarios which will fail...
> 
> I'd be interested to see the ones that would fail with the corrected 
> code.  

4-way system with HT (8 logical processors) ... 

Package-P0 T0 has a highest priority task, T1 is idle
Package-P1 Both T0 and T1 have 1 normal priority task each..
P2 and P3 are idle.

Scheduler needs to move one of the normal priority tasks to P2 or P3.. 
But find_busiest_group() will always think P0 as the busy group and
will not distribute the load as expected..

I am giving so many examples that I am confused at the end of day, which
examples are fixed and which are not by your patches :)
So please send the latest smpnice patch, which you think is clean and fixes 
all the issues(look at all my examples and also the ones mentioned in the 
OLS paper...)

> Sometimes complexity is necessary.  E.g. to handle the limitations of HT 
> technology.  In this case, the complexity is necessary to make "nice" 
> work on SMP systems.  The thing that broke "nice" on SMP systems was the 
> adoption of separate run queues for each CPU and backing out that change 
> in order to fix the problem is not an option so alternative solutions 
> such as smpnice are required.

I agree with the issue you are trying to address but at the same time
we should make sure that the new patch is clean, easy to understand, 
have some predictable behavior and really fixes the issue that we
are addressing..

--

Two sysctls enable the SMT/MC power savings policy for the scheduler.

kernel.sched_core_power_savings
kernel.sched_smt_power_savings

If any of the above values are non-zero, then power savings policy will be
enabled for that level. Based on these sysctls, sched groups cpu power
will be determined for different domains. When power savings policy is
enabled and under light load conditions, scheduler will minimize the physical
packages carrying the load and thus conserving power.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -pNru linux-2.6.16-git15/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.6.16-git15/arch/i386/kernel/smpboot.c	2006-03-28 12:07:28.325536192 -0800
+++ linux/arch/i386/kernel/smpboot.c	2006-03-28 14:43:23.837282224 -0800
@@ -449,10 +449,16 @@ cpumask_t cpu_coregroup_map(int cpu)
 	struct cpuinfo_x86 *c = cpu_data + cpu;
 	/*
 	 * For perf, we return last level cache shared map.
-	 * TBD: when power saving sched policy is added, we will return
-	 *      cpu_core_map when power saving policy is enabled
+	 * And for power savings, we return cpu_core_map
+	 *
+	 * TBD: On CPU generations where there are no shared resources
+	 * (like last level cache) between cores,
+	 * let the OS choose core_power_savings sched policy during bootup.
 	 */
-	return c->llc_shared_map;
+	if (core_power_savings || smt_power_savings)
+		return cpu_core_map[cpu];
+	else
+		return c->llc_shared_map;
 }
 
 /* representing cpus for which sibling maps can be computed */
diff -pNru linux-2.6.16-git15/arch/x86_64/kernel/smpboot.c linux/arch/x86_64/kernel/smpboot.c
--- linux-2.6.16-git15/arch/x86_64/kernel/smpboot.c	2006-03-28 12:07:28.692480408 -0800
+++ linux/arch/x86_64/kernel/smpboot.c	2006-03-28 14:42:26.428009760 -0800
@@ -454,10 +454,16 @@ cpumask_t cpu_coregroup_map(int cpu)
 	struct cpuinfo_x86 *c = cpu_data + cpu;
 	/*
 	 * For perf, we return last level cache shared map.
-	 * TBD: when power saving sched policy is added, we will return
-	 *      cpu_core_map when power saving policy is enabled
+	 * And for power savings, we return cpu_core_map
+	 *
+	 * TBD: On CPU generations where there are no shared resources
+	 * (like last level cache) between cores,
+	 * let the OS choose core_power_savings sched policy during bootup.
 	 */
-	return c->llc_shared_map;
+	if (core_power_savings || smt_power_savings)
+		return cpu_core_map[cpu];
+	else
+		return c->llc_shared_map;
 }
 
 /* representing cpus for which sibling maps can be computed */
diff -pNru linux-2.6.16-git15/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.16-git15/include/linux/sched.h	2006-03-28 12:07:34.735561720 -0800
+++ linux/include/linux/sched.h	2006-03-28 12:09:36.100111504 -0800
@@ -38,6 +38,7 @@
 #include <linux/futex.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
+#include <linux/sysctl.h>
 
 struct exec_domain;
 
@@ -564,6 +565,10 @@ enum idle_type
 #define SD_WAKE_AFFINE		32	/* Wake task to waking CPU */
 #define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
+#define SD_POWERSAVINGS_BALANCE	256	/* Balance for power savings */
+
+#define BALANCE_FOR_POWER	((core_power_savings || smt_power_savings) \
+				 ? SD_POWERSAVINGS_BALANCE : 0)
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
@@ -1396,6 +1401,10 @@ static inline void arch_pick_mmap_layout
 
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
+extern int smt_power_savings, core_power_savings;
+extern int sched_sysctl_handler(ctl_table *table, int write, struct file *file,
+				void __user *buffer, size_t *length, loff_t *ppos);
+
 
 extern void normalize_rt_tasks(void);
 
diff -pNru linux-2.6.16-git15/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.6.16-git15/include/linux/sysctl.h	2006-03-28 12:07:34.747559896 -0800
+++ linux/include/linux/sysctl.h	2006-03-28 12:10:09.184081976 -0800
@@ -148,6 +148,8 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+ 	KERN_SCHED_HT_POWER=73,	/* int: schedule for saving ht power */
+ 	KERN_SCHED_CORE_POWER=74,/* int: schedule for saving core power */
 };
 
 
diff -pNru linux-2.6.16-git15/include/linux/topology.h linux/include/linux/topology.h
--- linux-2.6.16-git15/include/linux/topology.h	2006-03-28 12:07:34.749559592 -0800
+++ linux/include/linux/topology.h	2006-03-28 12:09:36.102111200 -0800
@@ -134,7 +134,8 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE,	\
+				| SD_WAKE_AFFINE	\
+				| BALANCE_FOR_POWER,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
diff -pNru linux-2.6.16-git15/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.16-git15/kernel/sched.c	2006-03-28 12:07:34.831547128 -0800
+++ linux/kernel/sched.c	2006-03-28 16:31:31.181056064 -0800
@@ -1061,6 +1061,12 @@ static int sched_balance_self(int cpu, i
 	struct task_struct *t = current;
 	struct sched_domain *tmp, *sd = NULL;
 
+	/*
+	 * If any Power savings logic is enabled, we don't sched balance
+	 */
+	if (smt_power_savings || core_power_savings)
+		return cpu;
+
 	for_each_domain(cpu, tmp)
 		if (tmp->flags & flag)
 			sd = tmp;
@@ -1928,9 +1934,9 @@ static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
 		   unsigned long *imbalance, enum idle_type idle, int *sd_idle)
 {
-	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
+	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups, *min_group = NULL, *group_leader = NULL;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
-	unsigned long max_pull;
+	unsigned long max_pull, excess_load, min_load = ULONG_MAX, leader_load = 0, unit_load;
 	int load_idx;
 
 	max_load = this_load = total_load = total_pwr = 0;
@@ -1977,13 +1983,53 @@ find_busiest_group(struct sched_domain *
 			max_load = avg_load;
 			busiest = group;
 		}
+
+		if (!(sd->flags & SD_POWERSAVINGS_BALANCE))
+			goto group_next;
+
+		/* this group is already running at full capacity. Don't get
+		 * involved in any power savings calculations
+		 */
+		if (avg_load >= SCHED_LOAD_SCALE)
+			goto group_next;
+
+		unit_load = (SCHED_LOAD_SCALE * SCHED_LOAD_SCALE) / group->cpu_power;
+		/* Calculate the group which has the least non-idle load
+		 * This is the group from where we need to pick up the load
+		 * for saving power
+		 */
+		if (avg_load >= unit_load) {
+			if ((avg_load < min_load) ||
+			    (avg_load == min_load &&
+			      first_cpu(group->cpumask) < 
+		              first_cpu(min_group->cpumask))) {
+				min_group = group;
+				min_load = avg_load;
+			}
+		}
+
+		/* Calculate the group which is almost near its
+		 * capacity but still has some space to pick up some load
+		 * from other group and save more power
+		 */
+		if (avg_load <= (SCHED_LOAD_SCALE - unit_load))
+			if (avg_load && (avg_load > leader_load || 
+			    (avg_load == leader_load &&
+			     first_cpu(group->cpumask) > 
+			      first_cpu(group_leader->cpumask)))) {
+				group_leader = group;
+				leader_load = avg_load;
+			}
+
+group_next:
 		group = group->next;
 	} while (group != sd->groups);
 
+	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
+
 	if (!busiest || this_load >= max_load || max_load <= SCHED_LOAD_SCALE)
 		goto out_balanced;
 
-	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
 
 	if (this_load >= avg_load ||
 			100*max_load <= sd->imbalance_pct*this_load)
@@ -2002,11 +2048,17 @@ find_busiest_group(struct sched_domain *
 	 */
 
 	/* Don't want to pull so many tasks that a group would go idle */
-	max_pull = min(max_load - avg_load, max_load - SCHED_LOAD_SCALE);
+	excess_load = min(max_load - avg_load, max_load - SCHED_LOAD_SCALE);
+
+	if (this_load < SCHED_LOAD_SCALE)
+		/* pull as many tasks so that this group is fully utilized */
+		max_pull = max(avg_load - this_load, SCHED_LOAD_SCALE - this_load);
+	else
+		max_pull = avg_load - this_load;
 
 	/* How much load to actually move to equalise the imbalance */
-	*imbalance = min(max_pull * busiest->cpu_power,
-				(avg_load - this_load) * this->cpu_power)
+	*imbalance = min(excess_load * busiest->cpu_power,
+				max_pull * this->cpu_power)
 			/ SCHED_LOAD_SCALE;
 
 	if (*imbalance < SCHED_LOAD_SCALE) {
@@ -2056,7 +2108,32 @@ find_busiest_group(struct sched_domain *
 	return busiest;
 
 out_balanced:
+	if (!(sd->flags & SD_POWERSAVINGS_BALANCE))
+		goto ret;
 
+	/* when this group is above its capacity or overall the system
+	 * is loaded heavily, we can't do any power savings. We will simply
+	 * return
+	 */
+	if (this_load >= SCHED_LOAD_SCALE || avg_load >= SCHED_LOAD_SCALE)
+		goto ret;
+
+	if (this == group_leader && group_leader != min_group) {
+		/*
+		 * Ideally this should be
+		 * (SCHED_LOAD_SCALE - leader_load) * group_leader->cpu_power
+		 * 			/ (SCHED_LOAD_SCALE * SCHED_LOAD_SCALE);
+		 * Anyhow, we need to rely on active load balance when the
+		 * system is lightly loaded. And active load balance
+		 * moves one at a time.
+		 *
+		 * we should be Ok with 1.
+		 */
+		*imbalance = 1;
+		return min_group;
+	}
+
+ret:
 	*imbalance = 0;
 	return NULL;
 }
@@ -5561,6 +5638,8 @@ static cpumask_t sched_domain_node_span(
 }
 #endif
 
+
+int smt_power_savings = 0, core_power_savings = 0;
 /*
  * At the moment, CONFIG_SCHED_SMT is never defined, but leave it in so we
  * can switch it on easily if needed.
@@ -5861,7 +5940,7 @@ void build_sched_domains(const cpumask_t
 	/* Calculate CPU power for physical packages and nodes */
 	for_each_cpu_mask(i, *cpu_map) {
 		int power;
-		struct sched_domain *sd;
+		struct sched_domain *sd, *sd1;
 #ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
 		power = SCHED_LOAD_SCALE;
@@ -5869,26 +5948,53 @@ void build_sched_domains(const cpumask_t
 #endif
 #ifdef CONFIG_SCHED_MC
 		sd = &per_cpu(core_domains, i);
-		power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
+		if (smt_power_savings)
+			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
+		else
+			power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
 					    * SCHED_LOAD_SCALE / 10;
 		sd->groups->cpu_power = power;
 
 		sd = &per_cpu(phys_domains, i);
+		if (i != first_cpu(sd->groups->cpumask))
+			continue;
 
- 		/*
- 		 * This has to be < 2 * SCHED_LOAD_SCALE
- 		 * Lets keep it SCHED_LOAD_SCALE, so that
- 		 * while calculating NUMA group's cpu_power
- 		 * we can simply do
- 		 *  numa_group->cpu_power += phys_group->cpu_power;
- 		 *
- 		 * See "only add power once for each physical pkg"
- 		 * comment below
- 		 */
- 		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+		sd->groups->cpu_power = 0;
+		if (core_power_savings || smt_power_savings) {
+			int j;
+
+ 			for_each_cpu_mask(j, sd->groups->cpumask) {
+ 				sd1 = &per_cpu(core_domains, j);
+ 				/*
+ 			 	 * for each core we will add once
+ 				 * to the group in physical domain
+ 			 	 */
+  	 			if (j != first_cpu(sd1->groups->cpumask))
+ 					continue;
+ 
+ 				if (smt_power_savings)
+   					sd->groups->cpu_power += SCHED_LOAD_SCALE * cpus_weight(sd1->groups->cpumask);
+ 				else
+   					sd->groups->cpu_power += SCHED_LOAD_SCALE;
+   			}
+ 		} else 
+ 			/*
+ 			 * This has to be < 2 * SCHED_LOAD_SCALE
+ 			 * Lets keep it SCHED_LOAD_SCALE, so that
+ 			 * while calculating NUMA group's cpu_power
+ 			 * we can simply do
+ 			 *  numa_group->cpu_power += phys_group->cpu_power;
+ 			 *
+ 			 * See "only add power once for each physical pkg"
+ 			 * comment below
+ 			 */
+ 			sd->groups->cpu_power = SCHED_LOAD_SCALE;
 #else
 		sd = &per_cpu(phys_domains, i);
-		power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
+		if (smt_power_savings)
+			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
+		else
+			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
 				(cpus_weight(sd->groups->cpumask)-1) / 10;
 		sd->groups->cpu_power = power;
 #endif
@@ -6017,6 +6123,21 @@ void partition_sched_domains(cpumask_t *
 		build_sched_domains(partition2);
 }
 
+#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
+int sched_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (write) {
+		lock_cpu_hotplug();
+		detach_destroy_domains(&cpu_online_map);
+		arch_init_sched_domains(&cpu_online_map);
+		unlock_cpu_hotplug();
+	}
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Force a reinitialization of the sched domains hierarchy.  The domains
diff -pNru linux-2.6.16-git15/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.6.16-git15/kernel/sysctl.c	2006-03-28 12:07:34.837546216 -0800
+++ linux/kernel/sysctl.c	2006-03-28 16:32:53.354563792 -0800
@@ -683,6 +683,26 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_SCHED_SMT
+	{
+		.ctl_name	= KERN_SCHED_HT_POWER,
+		.procname	= "sched_smt_power_savings",
+		.data		= &smt_power_savings,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &sched_sysctl_handler,
+	},
+#endif
+#ifdef CONFIG_SCHED_MC
+	{
+		.ctl_name	= KERN_SCHED_CORE_POWER,
+		.procname	= "sched_core_power_savings",
+		.data		= &core_power_savings,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &sched_sysctl_handler,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
