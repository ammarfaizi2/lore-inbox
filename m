Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVBXHif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVBXHif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBXHhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:37:38 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:28259 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261940AbVBXH2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:28:10 -0500
Subject: [PATCH 11/13] sched-domains aware balance-on-fork
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109230031.5177.87.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
	 <1109229650.5177.78.camel@npiggin-nld.site>
	 <1109229700.5177.79.camel@npiggin-nld.site>
	 <1109229760.5177.81.camel@npiggin-nld.site>
	 <1109229867.5177.84.camel@npiggin-nld.site>
	 <1109229935.5177.85.camel@npiggin-nld.site>
	 <1109230031.5177.87.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-CiFvjD5hCRcGWqy5s32n"
Date: Thu, 24 Feb 2005 18:28:06 +1100
Message-Id: <1109230087.5177.89.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CiFvjD5hCRcGWqy5s32n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

11/13


--=-CiFvjD5hCRcGWqy5s32n
Content-Disposition: attachment; filename=sched-balance-fork.patch
Content-Type: text/x-patch; name=sched-balance-fork.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reimplement the balance on exec balancing to be sched-domains aware. Use
this to also do balance on fork balancing. Make x86_64 do balance on fork
over the NUMA domain.

The problem that the non sched domains aware blancing became apparent on
dual core, multi socket opterons. What we want is for the new tasks to be
sent to a different socket, but more often than not, we would first load
up our sibling core, or fill two cores of a single remote socket before
selecting a new one.

This gives large improvements to STREAM on such systems.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/topology.h	2005-02-24 17:39:07.320947536 +1100
+++ linux-2.6/include/asm-x86_64/topology.h	2005-02-24 17:43:37.077660523 +1100
@@ -54,9 +54,11 @@
 	.idle_idx		= 2,			\
 	.newidle_idx		= 1, 			\
 	.wake_idx		= 1,			\
+	.forkexec_idx		= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_FORK	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-02-24 17:39:06.806011090 +1100
+++ linux-2.6/include/linux/sched.h	2005-02-24 17:43:37.274636222 +1100
@@ -423,10 +423,11 @@
 #define SD_LOAD_BALANCE		1	/* Do load balancing on this domain. */
 #define SD_BALANCE_NEWIDLE	2	/* Balance when about to become idle */
 #define SD_BALANCE_EXEC		4	/* Balance on exec */
-#define SD_WAKE_IDLE		8	/* Wake to idle CPU on task wakeup */
-#define SD_WAKE_AFFINE		16	/* Wake task to waking CPU */
-#define SD_WAKE_BALANCE		32	/* Perform balancing at task wakeup */
-#define SD_SHARE_CPUPOWER	64	/* Domain members share cpu power */
+#define SD_BALANCE_FORK		8	/* Balance on fork, clone */
+#define SD_WAKE_IDLE		16	/* Wake to idle CPU on task wakeup */
+#define SD_WAKE_AFFINE		32	/* Wake task to waking CPU */
+#define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
+#define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
@@ -455,6 +456,7 @@
 	unsigned int idle_idx;
 	unsigned int newidle_idx;
 	unsigned int wake_idx;
+	unsigned int forkexec_idx;
 	int flags;			/* See SD_* */
 
 	/* Runtime fields. */
Index: linux-2.6/include/linux/topology.h
===================================================================
--- linux-2.6.orig/include/linux/topology.h	2005-02-24 17:39:07.320947536 +1100
+++ linux-2.6/include/linux/topology.h	2005-02-24 17:43:37.078660399 +1100
@@ -90,6 +90,7 @@
 	.idle_idx		= 0,			\
 	.newidle_idx		= 0,			\
 	.wake_idx		= 0,			\
+	.forkexec_idx		= 0,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
@@ -120,6 +121,7 @@
 	.idle_idx		= 0,			\
 	.newidle_idx		= 1,			\
 	.wake_idx		= 1,			\
+	.forkexec_idx		= 0,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:39:07.322947289 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:37.274636222 +1100
@@ -891,6 +891,79 @@
 	return max(rq->cpu_load[type-1], load_now);
 }
 
+/*
+ * find_idlest_group finds and returns the least busy CPU group within the
+ * domain.
+ */
+static struct sched_group *
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
+{
+	struct sched_group *idlest = NULL, *this = NULL, *group = sd->groups;
+	unsigned long min_load = ULONG_MAX, this_load = 0;
+	int load_idx = sd->forkexec_idx;
+	int imbalance = 100 + (sd->imbalance_pct-100)/2;
+
+	do {
+		unsigned long load, avg_load;
+		int local_group;
+		int i;
+
+		local_group = cpu_isset(this_cpu, group->cpumask);
+		/* XXX: put a cpus allowed check */
+
+		/* Tally up the load of all CPUs in the group */
+		avg_load = 0;
+
+		for_each_cpu_mask(i, group->cpumask) {
+			/* Bias balancing toward cpus of our domain */
+			if (local_group)
+				load = source_load(i, load_idx);
+			else
+				load = target_load(i, load_idx);
+
+			avg_load += load;
+		}
+
+		/* Adjust by relative CPU power of the group */
+		avg_load = (avg_load * SCHED_LOAD_SCALE) / group->cpu_power;
+
+		if (local_group) {
+			this_load = avg_load;
+			this = group;
+		} else if (avg_load < min_load) {
+			min_load = avg_load;
+			idlest = group;
+		}
+		group = group->next;
+	} while (group != sd->groups);
+
+	if (!idlest || 100*this_load < imbalance*min_load)
+		return NULL;
+	return idlest;
+}
+
+/*
+ * find_idlest_queue - find the idlest runqueue among the cpus in group.
+ */
+static int find_idlest_cpu(struct sched_group *group, int this_cpu)
+{
+	unsigned long load, min_load = ULONG_MAX;
+	int idlest = -1;
+	int i;
+
+	for_each_cpu_mask(i, group->cpumask) {
+		load = source_load(i, 0);
+
+		if (load < min_load || (load == min_load && i == this_cpu)) {
+			min_load = load;
+			idlest = i;
+		}
+	}
+
+	return idlest;
+}
+
+
 #endif
 
 /*
@@ -1105,11 +1178,6 @@
 	return try_to_wake_up(p, state, 0);
 }
 
-#ifdef CONFIG_SMP
-static int find_idlest_cpu(struct task_struct *p, int this_cpu,
-			   struct sched_domain *sd);
-#endif
-
 /*
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
@@ -1179,12 +1247,38 @@
 	unsigned long flags;
 	int this_cpu, cpu;
 	runqueue_t *rq, *this_rq;
+#ifdef CONFIG_SMP
+	struct sched_domain *tmp, *sd = NULL;
+#endif
 
 	rq = task_rq_lock(p, &flags);
-	cpu = task_cpu(p);
+	BUG_ON(p->state != TASK_RUNNING);
 	this_cpu = smp_processor_id();
+	cpu = task_cpu(p);
 
-	BUG_ON(p->state != TASK_RUNNING);
+#ifdef CONFIG_SMP
+	for_each_domain(cpu, tmp)
+		if (tmp->flags & SD_BALANCE_FORK)
+			sd = tmp;
+
+	if (sd) {
+		struct sched_group *group;
+
+		cpu = task_cpu(p);
+		group = find_idlest_group(sd, p, cpu);
+		if (group) {
+			int new_cpu;
+			new_cpu = find_idlest_cpu(group, cpu);
+			if (new_cpu != -1 && new_cpu != cpu &&
+					cpu_isset(new_cpu, p->cpus_allowed)) {
+				set_task_cpu(p, new_cpu);
+				task_rq_unlock(rq, &flags);
+				rq = task_rq_lock(p, &flags);
+				cpu = task_cpu(p);
+			}
+		}
+	}
+#endif
 
 	/*
 	 * We decrease the sleep average of forking parents
@@ -1479,51 +1573,6 @@
 }
 
 /*
- * find_idlest_cpu - find the least busy runqueue.
- */
-static int find_idlest_cpu(struct task_struct *p, int this_cpu,
-			   struct sched_domain *sd)
-{
-	unsigned long load, min_load, this_load;
-	int i, min_cpu;
-	cpumask_t mask;
-
-	min_cpu = UINT_MAX;
-	min_load = ULONG_MAX;
-
-	cpus_and(mask, sd->span, p->cpus_allowed);
-
-	for_each_cpu_mask(i, mask) {
-		load = target_load(i, sd->wake_idx);
-
-		if (load < min_load) {
-			min_cpu = i;
-			min_load = load;
-
-			/* break out early on an idle CPU: */
-			if (!min_load)
-				break;
-		}
-	}
-
-	/* add +1 to account for the new task */
-	this_load = source_load(this_cpu, sd->wake_idx) + SCHED_LOAD_SCALE;
-
-	/*
-	 * Would with the addition of the new task to the
-	 * current CPU there be an imbalance between this
-	 * CPU and the idlest CPU?
-	 *
-	 * Use half of the balancing threshold - new-context is
-	 * a good opportunity to balance.
-	 */
-	if (min_load*(100 + (sd->imbalance_pct-100)/2) < this_load*100)
-		return min_cpu;
-
-	return this_cpu;
-}
-
-/*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
  * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
@@ -1576,8 +1625,15 @@
 			sd = tmp;
 
 	if (sd) {
+		struct sched_group *group;
 		schedstat_inc(sd, sbe_attempts);
-		new_cpu = find_idlest_cpu(current, this_cpu, sd);
+		group = find_idlest_group(sd, current, this_cpu);
+		if (!group)
+			goto out;
+		new_cpu = find_idlest_cpu(group, this_cpu);
+		if (new_cpu == -1)
+			goto out;
+
 		if (new_cpu != this_cpu) {
 			schedstat_inc(sd, sbe_pushed);
 			put_cpu();
@@ -1790,12 +1846,10 @@
 		if (local_group) {
 			this_load = avg_load;
 			this = group;
-			goto nextgroup;
 		} else if (avg_load > max_load) {
 			max_load = avg_load;
 			busiest = group;
 		}
-nextgroup:
 		group = group->next;
 	} while (group != sd->groups);
 

--=-CiFvjD5hCRcGWqy5s32n--

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
