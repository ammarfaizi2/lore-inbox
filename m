Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267101AbUBSJYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267092AbUBSJYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:24:45 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:49301 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267101AbUBSJYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:24:33 -0500
Message-ID: <403480CA.7050804@cyberone.com.au>
Date: Thu, 19 Feb 2004 20:24:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LSE <lse-tech@lists.sourceforge.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       Rick Lindsley <ricklind@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.3-rc3-mm1: sched-group-power
Content-Type: multipart/mixed;
 boundary="------------060901040905040203000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060901040905040203000506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch implements a cpu_power member to
struct sched_group.

This allows special casing to be removed for SMT groups
in the balancing code. It does not take CPU hotplug into
account yet, but that shouldn't be too hard.

I have tested it on the NUMAQ by pretending it has SMT.
Works as expected. Active balances across nodes.

Andrew, please apply. I suppose you'd better not send
the scheduler changes to Linus quite yet.

--------------060901040905040203000506
Content-Type: text/plain;
 name="sched-group-power.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-group-power.patch"

 linux-2.6-npiggin/arch/i386/kernel/smpboot.c |   15 ++-
 linux-2.6-npiggin/include/linux/sched.h      |   12 ++
 linux-2.6-npiggin/kernel/sched.c             |  131 ++++++++++++++-------------
 3 files changed, 91 insertions(+), 67 deletions(-)

diff -puN include/linux/sched.h~sched-group-power include/linux/sched.h
--- linux-2.6/include/linux/sched.h~sched-group-power	2004-02-19 16:56:22.000000000 +1100
+++ linux-2.6-npiggin/include/linux/sched.h	2004-02-19 16:56:23.000000000 +1100
@@ -530,15 +530,25 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 
 #ifdef CONFIG_SMP
+#define SCHED_LOAD_SHIFT 7	/* increase resolution of load calculations */
+#define SCHED_LOAD_SCALE (1 << SCHED_LOAD_SHIFT)
+
 #define SD_FLAG_NEWIDLE		1	/* Balance when about to become idle */
 #define SD_FLAG_EXEC		2	/* Balance on exec */
 #define SD_FLAG_WAKE		4	/* Balance on task wakeup */
 #define SD_FLAG_FASTMIGRATE	8	/* Sync wakes put task on waking CPU */
-#define SD_FLAG_IDLE		16	/* Should not have all CPUs idle */
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
 	cpumask_t cpumask;
+
+	/*
+	 * CPU power of this group, SCHED_LOAD_SCALE being max power for a
+	 * single CPU. This should be read only (except for setup). Although
+	 * it will need to be written to at cpu hot(un)plug time, perhaps the
+	 * cpucontrol semaphore will provide enough exclusion?
+	 */
+	unsigned long cpu_power;
 };
 
 struct sched_domain {
diff -puN kernel/sched.c~sched-group-power kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-group-power	2004-02-19 16:56:22.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-02-19 17:09:47.000000000 +1100
@@ -190,9 +190,6 @@ struct prio_array {
 	struct list_head queue[MAX_PRIO];
 };
 
-#define SCHED_LOAD_SHIFT 7	/* increase resolution of load calculations */
-#define SCHED_LOAD_SCALE (1 << SCHED_LOAD_SHIFT)
-
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -1350,16 +1347,14 @@ find_busiest_group(struct sched_domain *
 				unsigned long *imbalance, enum idle_type idle)
 {
 	unsigned long max_load, avg_load, total_load, this_load;
-	int modify, total_nr_cpus, busiest_nr_cpus, this_nr_cpus;
-	enum idle_type package_idle = IDLE;
-	struct sched_group *busiest = NULL, *group = domain->groups;
+	unsigned int total_pwr;
+	int modify;
+	struct sched_group *busiest = NULL, *this = NULL, *group = domain->groups;
 
 	max_load = 0;
 	this_load = 0;
 	total_load = 0;
-	total_nr_cpus = 0;
-	busiest_nr_cpus = 0;
-	this_nr_cpus = 0;
+	total_pwr = 0;
 
 	if (group == NULL)
 		goto out_balanced;
@@ -1390,8 +1385,6 @@ find_busiest_group(struct sched_domain *
 			/* Bias balancing toward cpus of our domain */
 			if (local_group) {
 				load = get_high_cpu_load(i, modify);
-				if (!idle_cpu(i))
-					package_idle = NOT_IDLE;
 			} else
 				load = get_low_cpu_load(i, modify);
 
@@ -1403,48 +1396,34 @@ find_busiest_group(struct sched_domain *
 			goto nextgroup;
 
 		total_load += avg_load;
+		total_pwr += group->cpu_power;
 
-		/*
-		 * Load is cumulative over SD_FLAG_IDLE domains, but
-		 * spread over !SD_FLAG_IDLE domains. For example, 2
-		 * processes running on an SMT CPU puts a load of 2 on
-		 * that CPU, however 2 processes running on 2 CPUs puts
-		 * a load of 1 on that domain.
-		 *
-		 * This should be configurable so as SMT siblings become
-		 * more powerful, they can "spread" more load - for example,
-		 * the above case might only count as a load of 1.7.
-		 */
-		if (!(domain->flags & SD_FLAG_IDLE)) {
-			avg_load /= nr_cpus;
-			total_nr_cpus += nr_cpus;
-		} else
-			total_nr_cpus++;
-
-		if (avg_load > max_load)
-			max_load = avg_load;
+		/* Adjust by relative CPU power of the group */
+		avg_load = (avg_load << SCHED_LOAD_SHIFT) / group->cpu_power;
 
 		if (local_group) {
 			this_load = avg_load;
-			this_nr_cpus = nr_cpus;
-		} else if (avg_load >= max_load) {
+			this = group;
+			goto nextgroup;
+		}
+		if (avg_load > max_load) {
+			max_load = avg_load;
 			busiest = group;
-			busiest_nr_cpus = nr_cpus;
 		}
 nextgroup:
 		group = group->next;
 	} while (group != domain->groups);
 
-	if (!busiest)
+	if (!busiest || this_load >= max_load)
 		goto out_balanced;
 
-	avg_load = total_load / total_nr_cpus;
-
-	if (this_load >= avg_load)
-		goto out_balanced;
+	avg_load = (SCHED_LOAD_SCALE * total_load) / total_pwr;
 
-	if (idle == NOT_IDLE && 100*max_load <= domain->imbalance_pct*this_load)
+	if (idle == NOT_IDLE) {
+		if (this_load >= avg_load ||
+			100*max_load <= domain->imbalance_pct*this_load)
 		goto out_balanced;
+	}
 
 	/*
 	 * We're trying to get all the cpus to the average_load, so we don't
@@ -1458,15 +1437,45 @@ nextgroup:
 	 * appear as very large values with unsigned longs.
 	 */
 	*imbalance = (min(max_load - avg_load, avg_load - this_load) + 1) / 2;
-	/* Get rid of the scaling factor, rounding *up* as we divide */
-	*imbalance = (*imbalance + SCHED_LOAD_SCALE/2 + 1)
-					>> SCHED_LOAD_SHIFT;
 
-	if (*imbalance == 0)
-		goto out_balanced;
+	if (*imbalance <= SCHED_LOAD_SCALE/2) {
+		unsigned long pwr_now = 0, pwr_move = 0;
+		unsigned long load;
+		unsigned long tmp;
+
+		/*
+		 * OK, we don't have enough imbalance to justify moving tasks,
+		 * however we may be able to increase total CPU power used by
+		 * moving them.
+		 */
+
+		pwr_now += busiest->cpu_power*min(SCHED_LOAD_SCALE, max_load);
+		pwr_now += this->cpu_power*min(SCHED_LOAD_SCALE, this_load);
+		pwr_now >>= SCHED_LOAD_SHIFT;
+
+		/* Amount of load we'd subtract */
+		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/busiest->cpu_power;
+		if (max_load > tmp)
+			pwr_move += busiest->cpu_power*min(SCHED_LOAD_SCALE,
+							max_load - tmp);
+
+		/* Amount of load we'd add */
+		tmp = SCHED_LOAD_SCALE*SCHED_LOAD_SCALE/this->cpu_power;
+		pwr_move += this->cpu_power*min(this->cpu_power, this_load + tmp);
+		pwr_move >>= SCHED_LOAD_SHIFT;
+
+		/* Move if we gain another 8th of a CPU worth of throughput */
+		if (pwr_move < pwr_now + SCHED_LOAD_SCALE / 8)
+			goto out_balanced;
+		*imbalance = 1;
+		return busiest;
+	}
 
 	/* How many tasks to actually move to equalise the imbalance */
-	*imbalance *= min(busiest_nr_cpus, this_nr_cpus);
+	*imbalance = (*imbalance * min(busiest->cpu_power, this->cpu_power))
+				>> SCHED_LOAD_SHIFT;
+	/* Get rid of the scaling factor, rounding *up* as we divide */
+	*imbalance = (*imbalance + SCHED_LOAD_SCALE/2) >> SCHED_LOAD_SHIFT;
 
 	return busiest;
 
@@ -1542,26 +1551,19 @@ out:
 	if (!balanced && nr_moved == 0)
 		failed = 1;
 
-	if (domain->flags & SD_FLAG_IDLE && failed && busiest &&
+	if (failed && busiest &&
 	   		domain->nr_balance_failed > domain->cache_nice_tries) {
-		int i;
-		for_each_cpu_mask(i, group->cpumask) {
-			int wake = 0;
+		int wake = 0;
 
-			if (!cpu_online(i))
-				continue;
-
-			busiest = cpu_rq(i);
-			spin_lock(&busiest->lock);
-			if (!busiest->active_balance) {
-				busiest->active_balance = 1;
-				busiest->push_cpu = this_cpu;
-				wake = 1;
-			}
-			spin_unlock(&busiest->lock);
-			if (wake)
-				wake_up_process(busiest->migration_thread);
-		}
+		spin_lock(&busiest->lock);
+		if (!busiest->active_balance) {
+			busiest->active_balance = 1;
+			busiest->push_cpu = this_cpu;
+			wake = 1;
+		}
+		spin_unlock(&busiest->lock);
+		if (wake)
+			wake_up_process(busiest->migration_thread);
 	}
 
 	if (failed)
@@ -3324,12 +3326,14 @@ static void __init arch_init_sched_domai
 			continue;
 
 		node->cpumask = nodemask;
+		node->cpu_power = SCHED_LOAD_SCALE * cpus_weight(node->cpumask);
 
 		for_each_cpu_mask(j, node->cpumask) {
 			struct sched_group *cpu = &sched_group_cpus[j];
 
 			cpus_clear(cpu->cpumask);
 			cpu_set(j, cpu->cpumask);
+			cpu->cpu_power = SCHED_LOAD_SCALE;
 
 			if (!first_cpu)
 				first_cpu = cpu;
@@ -3376,6 +3380,7 @@ static void __init arch_init_sched_domai
 
 		cpus_clear(cpu->cpumask);
 		cpu_set(i, cpu->cpumask);
+		cpu->cpu_power = SCHED_LOAD_SCALE;
 
 		if (!first_cpu)
 			first_cpu = cpu;
diff -puN arch/i386/kernel/smpboot.c~sched-group-power arch/i386/kernel/smpboot.c
--- linux-2.6/arch/i386/kernel/smpboot.c~sched-group-power	2004-02-19 16:56:23.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/kernel/smpboot.c	2004-02-19 16:56:23.000000000 +1100
@@ -1149,7 +1149,6 @@ __init void arch_init_sched_domains(void
 
 		*phys_domain = SD_CPU_INIT;
 		phys_domain->span = nodemask;
-		phys_domain->flags |= SD_FLAG_IDLE;
 
 		*node_domain = SD_NODE_INIT;
 		node_domain->span = cpu_online_map;
@@ -1169,6 +1168,7 @@ __init void arch_init_sched_domains(void
 
 			cpu->cpumask = CPU_MASK_NONE;
 			cpu_set(j, cpu->cpumask);
+			cpu->cpu_power = SCHED_LOAD_SCALE;
 
 			if (!first_cpu)
 				first_cpu = cpu;
@@ -1182,6 +1182,7 @@ __init void arch_init_sched_domains(void
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		int j;
 		cpumask_t nodemask;
+		struct sched_group *node = &sched_group_nodes[i];
 		cpus_and(nodemask, node_to_cpumask(i), cpu_online_map);
 
 		if (cpus_empty(nodemask))
@@ -1197,6 +1198,12 @@ __init void arch_init_sched_domains(void
 				continue;
 
 			cpu->cpumask = cpu_domain->span;
+			/*
+			 * Make each extra sibling increase power by 10% of
+			 * the basic CPU. This is very arbitrary.
+			 */
+			cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
+			node->cpu_power += cpu->cpu_power;
 
 			if (!first_cpu)
 				first_cpu = cpu;
@@ -1218,6 +1225,7 @@ __init void arch_init_sched_domains(void
 			continue;
 
 		cpu->cpumask = nodemask;
+		/* ->cpu_power already setup */
 
 		if (!first_cpu)
 			first_cpu = cpu;
@@ -1227,7 +1235,6 @@ __init void arch_init_sched_domains(void
 	}
 	last_cpu->next = first_cpu;
 
-
 	mb();
 	for_each_cpu_mask(i, cpu_online_map) {
 		int node = cpu_to_node(i);
@@ -1265,7 +1272,6 @@ __init void arch_init_sched_domains(void
 
 		*phys_domain = SD_CPU_INIT;
 		phys_domain->span = cpu_online_map;
-		phys_domain->flags |= SD_FLAG_IDLE;
 	}
 
 	/* Set up CPU (sibling) groups */
@@ -1282,6 +1288,7 @@ __init void arch_init_sched_domains(void
 
 			cpus_clear(cpu->cpumask);
 			cpu_set(j, cpu->cpumask);
+			cpu->cpu_power = SCHED_LOAD_SCALE;
 
 			if (!first_cpu)
 				first_cpu = cpu;
@@ -1302,6 +1309,8 @@ __init void arch_init_sched_domains(void
 			continue;
 
 		cpu->cpumask = cpu_domain->span;
+		/* See SMT+NUMA setup for comment */
+		cpu->cpu_power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE*(cpus_weight(cpu->cpumask)-1) / 10;
 
 		if (!first_cpu)
 			first_cpu = cpu;

_

--------------060901040905040203000506--
