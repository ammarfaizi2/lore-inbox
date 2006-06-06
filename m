Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWFFSap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWFFSap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFFSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:30:45 -0400
Received: from mga05.intel.com ([192.55.52.89]:19541 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750937AbWFFSao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:30:44 -0400
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="47917012:sNHT117951246"
Date: Tue, 6 Jun 2006 11:25:21 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: nickpiggin@yahoo.com.au, mingo@elte.hu, pwil3058@bigpond.net.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [Patch] sched: mc/smt power savings sched policy
Message-ID: <20060606112521.A18026@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended the patch. Can someone please test compile the powerpc change?

thanks,
suresh
--

sysfs entries 'sched_mc_power_savings' and 'sched_smt_power_savings' in
/sys/devices/system/cpu/ control the MC/SMT power savings policy for 
the scheduler.

Based on the values (1-enable, 0-disable) for these controls, sched groups 
cpu power will be determined for different domains. When power savings policy is
enabled and under light load conditions, scheduler will minimize the physical
packages/cpu cores carrying the load and thus conserving power(with a perf
impact based on the workload characteristics... see OLS 2005 CMP kernel 
scheduler paper for more details..)

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff -pNru linux-2.6.17-rc5/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.6.17-rc5/arch/i386/kernel/smpboot.c	2006-06-05 14:36:46.478015456 -0700
+++ linux/arch/i386/kernel/smpboot.c	2006-06-05 14:39:14.737476592 -0700
@@ -446,10 +446,12 @@ cpumask_t cpu_coregroup_map(int cpu)
 	struct cpuinfo_x86 *c = cpu_data + cpu;
 	/*
 	 * For perf, we return last level cache shared map.
-	 * TBD: when power saving sched policy is added, we will return
-	 *      cpu_core_map when power saving policy is enabled
+	 * And for power savings, we return cpu_core_map
 	 */
-	return c->llc_shared_map;
+	if (sched_mc_power_savings || sched_smt_power_savings)
+		return cpu_core_map[cpu];
+	else
+		return c->llc_shared_map;
 }
 
 /* representing cpus for which sibling maps can be computed */
diff -pNru linux-2.6.17-rc5/arch/x86_64/kernel/smpboot.c linux/arch/x86_64/kernel/smpboot.c
--- linux-2.6.17-rc5/arch/x86_64/kernel/smpboot.c	2006-06-05 14:36:46.728977304 -0700
+++ linux/arch/x86_64/kernel/smpboot.c	2006-06-05 14:39:23.162195840 -0700
@@ -450,10 +450,12 @@ cpumask_t cpu_coregroup_map(int cpu)
 	struct cpuinfo_x86 *c = cpu_data + cpu;
 	/*
 	 * For perf, we return last level cache shared map.
-	 * TBD: when power saving sched policy is added, we will return
-	 *      cpu_core_map when power saving policy is enabled
+	 * And for power savings, we return cpu_core_map
 	 */
-	return c->llc_shared_map;
+	if (sched_mc_power_savings || sched_smt_power_savings)
+		return cpu_core_map[cpu];
+	else
+		return c->llc_shared_map;
 }
 
 /* representing cpus for which sibling maps can be computed */
diff -pNru linux-2.6.17-rc5/drivers/base/cpu.c linux/drivers/base/cpu.c
--- linux-2.6.17-rc5/drivers/base/cpu.c	2006-06-05 14:36:46.920948120 -0700
+++ linux/drivers/base/cpu.c	2006-06-06 08:41:54.859037048 -0700
@@ -143,5 +143,13 @@ EXPORT_SYMBOL_GPL(get_cpu_sysdev);
 
 int __init cpu_dev_init(void)
 {
-	return sysdev_class_register(&cpu_sysdev_class);
+	int err;
+
+	err = sysdev_class_register(&cpu_sysdev_class);
+#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
+	if (!err)
+		err = sched_create_sysfs_power_savings_entries(&cpu_sysdev_class);
+#endif
+
+	return err;
 }
diff -pNru linux-2.6.17-rc5/include/asm-i386/topology.h linux/include/asm-i386/topology.h
--- linux-2.6.17-rc5/include/asm-i386/topology.h	2006-06-05 14:36:48.631688048 -0700
+++ linux/include/asm-i386/topology.h	2006-06-05 14:39:23.163195688 -0700
@@ -112,4 +112,9 @@ extern unsigned long node_remap_size[];
 
 extern cpumask_t cpu_coregroup_map(int cpu);
 
+#ifdef CONFIG_SMP
+#define mc_capable()	(boot_cpu_data.x86_max_cores > 1)
+#define smt_capable()	(smp_num_siblings > 1)
+#endif
+
 #endif /* _ASM_I386_TOPOLOGY_H */
diff -pNru linux-2.6.17-rc5/include/asm-ia64/topology.h linux/include/asm-ia64/topology.h
--- linux-2.6.17-rc5/include/asm-ia64/topology.h	2006-05-24 18:50:17.000000000 -0700
+++ linux/include/asm-ia64/topology.h	2006-06-05 14:39:23.163195688 -0700
@@ -112,6 +112,7 @@ void build_cpu_to_node_map(void);
 #define topology_core_id(cpu)			(cpu_data(cpu)->core_id)
 #define topology_core_siblings(cpu)		(cpu_core_map[cpu])
 #define topology_thread_siblings(cpu)		(cpu_sibling_map[cpu])
+#define smt_capable() 				(smp_num_siblings > 1)
 #endif
 
 #include <asm-generic/topology.h>
diff -pNru linux-2.6.17-rc5/include/asm-powerpc/topology.h linux/include/asm-powerpc/topology.h
--- linux-2.6.17-rc5/include/asm-powerpc/topology.h	2006-06-05 14:36:48.776666008 -0700
+++ linux/include/asm-powerpc/topology.h	2006-06-05 14:39:23.164195536 -0700
@@ -88,5 +88,10 @@ static inline void sysfs_remove_device_f
 
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_SMP
+#include <asm/cputable.h>
+#define smt_capable() 		(cpu_has_feature(CPU_FTR_SMT))
+#endif
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff -pNru linux-2.6.17-rc5/include/asm-x86_64/topology.h linux/include/asm-x86_64/topology.h
--- linux-2.6.17-rc5/include/asm-x86_64/topology.h	2006-06-05 14:36:48.867652176 -0700
+++ linux/include/asm-x86_64/topology.h	2006-06-05 14:39:23.164195536 -0700
@@ -59,6 +59,8 @@ extern int __node_distance(int, int);
 #define topology_core_id(cpu)			(cpu_data[cpu].cpu_core_id)
 #define topology_core_siblings(cpu)		(cpu_core_map[cpu])
 #define topology_thread_siblings(cpu)		(cpu_sibling_map[cpu])
+#define mc_capable()			(boot_cpu_data.x86_max_cores > 1)
+#define smt_capable() 			(smp_num_siblings > 1)
 #endif
 
 #include <asm-generic/topology.h>
diff -pNru linux-2.6.17-rc5/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.17-rc5/include/linux/sched.h	2006-06-05 14:36:48.989633632 -0700
+++ linux/include/linux/sched.h	2006-06-06 08:44:38.509158448 -0700
@@ -610,6 +610,11 @@ enum idle_type
 #define SD_WAKE_AFFINE		32	/* Wake task to waking CPU */
 #define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
 #define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
+#define SD_POWERSAVINGS_BALANCE	256	/* Balance for power savings */
+
+#define BALANCE_FOR_POWER	((sched_mc_power_savings || sched_smt_power_savings) \
+				 ? SD_POWERSAVINGS_BALANCE : 0)
+
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
@@ -1527,6 +1532,11 @@ static inline void arch_pick_mmap_layout
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
 
+#include <linux/sysdev.h>
+extern int sched_mc_power_savings, sched_smt_power_savings;
+extern struct sysdev_attribute attr_sched_mc_power_savings, attr_sched_smt_power_savings;
+extern int sched_create_sysfs_power_savings_entries(struct sysdev_class *cls);
+
 extern void normalize_rt_tasks(void);
 
 #ifdef CONFIG_PM
diff -pNru linux-2.6.17-rc5/include/linux/topology.h linux/include/linux/topology.h
--- linux-2.6.17-rc5/include/linux/topology.h	2006-05-24 18:50:17.000000000 -0700
+++ linux/include/linux/topology.h	2006-06-05 14:39:23.166195232 -0700
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
diff -pNru linux-2.6.17-rc5/kernel/sched.c linux/kernel/sched.c
--- linux-2.6.17-rc5/kernel/sched.c	2006-06-05 14:36:49.123613264 -0700
+++ linux/kernel/sched.c	2006-06-06 08:58:56.392740320 -0700
@@ -1258,6 +1258,11 @@ static int sched_balance_self(int cpu, i
 	struct sched_domain *tmp, *sd = NULL;
 
 	for_each_domain(cpu, tmp) {
+ 		/*
+ 	 	 * If power savings logic is enabled for a domain, stop there.
+ 	 	 */
+		if (tmp->flags & SD_POWERSAVINGS_BALANCE)
+			break;
 		if (tmp->flags & flag)
 			sd = tmp;
 	}
@@ -2187,6 +2192,12 @@ find_busiest_group(struct sched_domain *
 	unsigned long busiest_load_per_task, busiest_nr_running;
 	unsigned long this_load_per_task, this_nr_running;
 	int load_idx;
+#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
+	int power_savings_balance = 1;
+	unsigned long leader_nr_running = 0, min_load_per_task = 0;
+	unsigned long min_nr_running = ULONG_MAX;
+	struct sched_group *group_min = NULL, *group_leader = NULL;
+#endif
 
 	max_load = this_load = total_load = total_pwr = 0;
 	busiest_load_per_task = busiest_nr_running = 0;
@@ -2199,7 +2210,7 @@ find_busiest_group(struct sched_domain *
 		load_idx = sd->idle_idx;
 
 	do {
-		unsigned long load;
+		unsigned long load, group_capacity;
 		int local_group;
 		int i;
 		unsigned long sum_nr_running, sum_weighted_load;
@@ -2232,18 +2243,76 @@ find_busiest_group(struct sched_domain *
 		/* Adjust by relative CPU power of the group */
 		avg_load = (avg_load * SCHED_LOAD_SCALE) / group->cpu_power;
 
+		group_capacity = group->cpu_power / SCHED_LOAD_SCALE;
+
 		if (local_group) {
 			this_load = avg_load;
 			this = group;
 			this_nr_running = sum_nr_running;
 			this_load_per_task = sum_weighted_load;
 		} else if (avg_load > max_load &&
-			   sum_nr_running > group->cpu_power / SCHED_LOAD_SCALE) {
+			   sum_nr_running > group_capacity) {
 			max_load = avg_load;
 			busiest = group;
 			busiest_nr_running = sum_nr_running;
 			busiest_load_per_task = sum_weighted_load;
 		}
+
+#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
+		/*
+		 * Busy processors will not participate in power savings
+		 * balance.
+		 */
+ 		if (idle == NOT_IDLE || !(sd->flags & SD_POWERSAVINGS_BALANCE))
+ 			goto group_next;
+
+		/*
+		 * If the local group is idle or completely loaded
+		 * no need to do power savings balance at this domain
+		 */
+		if (local_group && (this_nr_running >= group_capacity ||
+				    !this_nr_running))
+			power_savings_balance = 0;
+
+ 		/*
+		 * If a group is already running at full capacity or idle,
+		 * don't include that group in power savings calculations
+ 		 */
+ 		if (!power_savings_balance || sum_nr_running >= group_capacity
+		    || !sum_nr_running)
+ 			goto group_next;
+
+ 		/*
+		 * Calculate the group which has the least non-idle load.
+ 		 * This is the group from where we need to pick up the load
+ 		 * for saving power
+ 		 */
+ 		if ((sum_nr_running < min_nr_running) ||
+ 		    (sum_nr_running == min_nr_running &&
+		     first_cpu(group->cpumask) <
+		     first_cpu(group_min->cpumask))) {
+ 			group_min = group;
+ 			min_nr_running = sum_nr_running;
+			min_load_per_task = sum_weighted_load /
+						sum_nr_running;
+ 		}
+
+ 		/*
+		 * Calculate the group which is almost near its
+ 		 * capacity but still has some space to pick up some load
+ 		 * from other group and save more power
+ 		 */
+ 		if (sum_nr_running <= group_capacity - 1)
+ 			if (sum_nr_running > leader_nr_running ||
+ 			    (sum_nr_running == leader_nr_running &&
+ 			     first_cpu(group->cpumask) >
+ 			      first_cpu(group_leader->cpumask))) {
+ 				group_leader = group;
+ 				leader_nr_running = sum_nr_running;
+ 			}
+
+group_next:
+#endif
 		group = group->next;
 	} while (group != sd->groups);
 
@@ -2352,7 +2421,16 @@ small_imbalance:
 	return busiest;
 
 out_balanced:
-
+#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
+	if (idle == NOT_IDLE || !(sd->flags & SD_POWERSAVINGS_BALANCE))
+		goto ret;
+
+	if (this == group_leader && group_leader != group_min) {
+		*imbalance = min_load_per_task;
+		return group_min;
+	}
+ret:
+#endif
 	*imbalance = 0;
 	return NULL;
 }
@@ -2405,7 +2483,8 @@ static int load_balance(int this_cpu, ru
 	int active_balance = 0;
 	int sd_idle = 0;
 
-	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER)
+	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER &&
+	    !sched_smt_power_savings)
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[idle]);
@@ -2494,7 +2573,8 @@ static int load_balance(int this_cpu, ru
 			sd->balance_interval *= 2;
 	}
 
-	if (!nr_moved && !sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+	if (!nr_moved && !sd_idle && sd->flags & SD_SHARE_CPUPOWER &&
+	    !sched_smt_power_savings)
 		return -1;
 	return nr_moved;
 
@@ -2509,7 +2589,7 @@ out_one_pinned:
 			(sd->balance_interval < sd->max_interval))
 		sd->balance_interval *= 2;
 
-	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
 		return -1;
 	return 0;
 }
@@ -2530,7 +2610,7 @@ static int load_balance_newidle(int this
 	int nr_moved = 0;
 	int sd_idle = 0;
 
-	if (sd->flags & SD_SHARE_CPUPOWER)
+	if (sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
@@ -2571,7 +2651,7 @@ static int load_balance_newidle(int this
 
 out_balanced:
 	schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
-	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER)
+	if (!sd_idle && sd->flags & SD_SHARE_CPUPOWER && !sched_smt_power_savings)
 		return -1;
 	sd->nr_balance_failed = 0;
 	return 0;
@@ -6009,6 +6089,7 @@ static cpumask_t sched_domain_node_span(
 }
 #endif
 
+int sched_smt_power_savings = 0, sched_mc_power_savings = 0;
 /*
  * At the moment, CONFIG_SCHED_SMT is never defined, but leave it in so we
  * can switch it on easily if needed.
@@ -6390,37 +6471,72 @@ static int build_sched_domains(const cpu
 #endif
 
 	/* Calculate CPU power for physical packages and nodes */
+#ifdef CONFIG_SCHED_SMT
 	for_each_cpu_mask(i, *cpu_map) {
-		int power;
 		struct sched_domain *sd;
-#ifdef CONFIG_SCHED_SMT
 		sd = &per_cpu(cpu_domains, i);
-		power = SCHED_LOAD_SCALE;
-		sd->groups->cpu_power = power;
+		sd->groups->cpu_power = SCHED_LOAD_SCALE;
+	}
 #endif
 #ifdef CONFIG_SCHED_MC
+	for_each_cpu_mask(i, *cpu_map) {
+		int power;
+		struct sched_domain *sd;
 		sd = &per_cpu(core_domains, i);
-		power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
+		if (sched_smt_power_savings)
+			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
+		else
+			power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
 					    * SCHED_LOAD_SCALE / 10;
 		sd->groups->cpu_power = power;
+	}
+#endif
 
+	for_each_cpu_mask(i, *cpu_map) {
+		struct sched_domain *sd;
+#ifdef CONFIG_SCHED_MC
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
+		if (sched_mc_power_savings || sched_smt_power_savings) {
+			int j;
+
+ 			for_each_cpu_mask(j, sd->groups->cpumask) {
+				struct sched_domain *sd1;
+ 				sd1 = &per_cpu(core_domains, j);
+ 				/*
+ 			 	 * for each core we will add once
+ 				 * to the group in physical domain
+ 			 	 */
+  	 			if (j != first_cpu(sd1->groups->cpumask))
+ 					continue;
+
+ 				if (sched_smt_power_savings)
+   					sd->groups->cpu_power += sd1->groups->cpu_power;
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
+		int power;
 		sd = &per_cpu(phys_domains, i);
-		power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
+		if (sched_smt_power_savings)
+			power = SCHED_LOAD_SCALE * cpus_weight(sd->groups->cpumask);
+		else
+			power = SCHED_LOAD_SCALE;
 		sd->groups->cpu_power = power;
 #endif
 	}
@@ -6521,6 +6637,80 @@ int partition_sched_domains(cpumask_t *p
 	return err;
 }
 
+#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
+int arch_reinit_sched_domains(void)
+{
+	int err;
+
+	lock_cpu_hotplug();
+	detach_destroy_domains(&cpu_online_map);
+	err = arch_init_sched_domains(&cpu_online_map);
+	unlock_cpu_hotplug();
+
+	return err;
+}
+
+static ssize_t sched_power_savings_store(const char *buf, size_t count, int smt)
+{
+	int ret;
+
+	if (buf[0] != '0' && buf[0] != '1')
+		return -EINVAL;
+
+	if (smt)
+		sched_smt_power_savings = (buf[0] == '1');
+	else
+		sched_mc_power_savings = (buf[0] == '1');
+		
+	ret = arch_reinit_sched_domains();
+
+	return ret ? ret : count;
+}
+
+int sched_create_sysfs_power_savings_entries(struct sysdev_class *cls)
+{
+	int err = 0;
+#ifdef CONFIG_SCHED_SMT
+	if (smt_capable())
+		err = sysfs_create_file(&cls->kset.kobj,
+					&attr_sched_smt_power_savings.attr);
+#endif
+#ifdef CONFIG_SCHED_MC
+	if (!err && mc_capable())	
+		err = sysfs_create_file(&cls->kset.kobj,
+					&attr_sched_mc_power_savings.attr);
+#endif
+	return err;	
+}
+#endif
+
+#ifdef CONFIG_SCHED_MC
+static ssize_t sched_mc_power_savings_show(struct sys_device *dev, char *page)
+{
+	return sprintf(page, "%u\n", sched_mc_power_savings);
+}
+static ssize_t sched_mc_power_savings_store(struct sys_device *dev, const char *buf, size_t count)
+{
+	return sched_power_savings_store(buf, count, 0);
+}
+SYSDEV_ATTR(sched_mc_power_savings, 0644, sched_mc_power_savings_show,
+	    sched_mc_power_savings_store);
+#endif
+
+#ifdef CONFIG_SCHED_SMT
+static ssize_t sched_smt_power_savings_show(struct sys_device *dev, char *page)
+{
+	return sprintf(page, "%u\n", sched_smt_power_savings);
+}
+static ssize_t sched_smt_power_savings_store(struct sys_device *dev, const char *buf, size_t count)
+{
+	return sched_power_savings_store(buf, count, 1);
+}
+SYSDEV_ATTR(sched_smt_power_savings, 0644, sched_smt_power_savings_show,
+	    sched_smt_power_savings_store);
+#endif
+
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Force a reinitialization of the sched domains hierarchy.  The domains
