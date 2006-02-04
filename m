Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946254AbWBDBSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946254AbWBDBSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946257AbWBDBSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:18:50 -0500
Received: from fmr21.intel.com ([143.183.121.13]:28628 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1946254AbWBDBSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:18:49 -0500
Date: Fri, 3 Feb 2006 17:18:41 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: nickpiggin@yahoo.com.au, mingo@elte.hu, hawkes@sgi.com, steiner@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] sched: fix group power for allnodes_domains
Message-ID: <20060203171841.A19490@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current sched groups power calculation for allnodes_domains is wrong. We should
really be using cumulative power of the physical packages in that group
(similar to the calculation in node_domains)

Appended patch fixes this issue. This request is for inclusion in -mm and hence
the patch is against 2.6.16-rc1-mm5(as multi core sched patch in -mm was 
touching this area)

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux/kernel/sched.c	2006-02-01 14:27:52.413687032 -0800
+++ linux-core/kernel/sched.c	2006-02-01 14:25:57.734120976 -0800
@@ -5705,6 +5705,32 @@ static int cpu_to_allnodes_group(int cpu
 {
 	return cpu_to_node(cpu);
 }
+static void init_numa_sched_groups_power(struct sched_group *group_head)
+{
+	struct sched_group *sg = group_head;
+	int j;
+
+	if (!sg)
+		return;
+next_sg:
+	for_each_cpu_mask(j, sg->cpumask) {
+		struct sched_domain *sd;
+
+		sd = &per_cpu(phys_domains, j);
+		if (j != first_cpu(sd->groups->cpumask)) {
+			/*
+			 * Only add "power" once for each
+			 * physical package.
+			 */
+			continue;
+		}
+
+		sg->cpu_power += sd->groups->cpu_power;
+	}
+	sg = sg->next;
+	if (sg != group_head)
+		goto next_sg;
+}
 #endif
 
 /*
@@ -5950,43 +5976,13 @@ void build_sched_domains(const cpumask_t
 				(cpus_weight(sd->groups->cpumask)-1) / 10;
 		sd->groups->cpu_power = power;
 #endif
-
-#ifdef CONFIG_NUMA
-		sd = &per_cpu(allnodes_domains, i);
-		if (sd->groups) {
-			power = SCHED_LOAD_SCALE + SCHED_LOAD_SCALE *
-				(cpus_weight(sd->groups->cpumask)-1) / 10;
-			sd->groups->cpu_power = power;
-		}
-#endif
 	}
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		struct sched_group *sg = sched_group_nodes[i];
-		int j;
+	for (i = 0; i < MAX_NUMNODES; i++)
+		init_numa_sched_groups_power(sched_group_nodes[i]);
 
-		if (sg == NULL)
-			continue;
-next_sg:
-		for_each_cpu_mask(j, sg->cpumask) {
-			struct sched_domain *sd;
-
-			sd = &per_cpu(phys_domains, j);
-			if (j != first_cpu(sd->groups->cpumask)) {
-				/*
-				 * Only add "power" once for each
-				 * physical package.
-				 */
-				continue;
-			}
-
-			sg->cpu_power += sd->groups->cpu_power;
-		}
-		sg = sg->next;
-		if (sg != sched_group_nodes[i])
-			goto next_sg;
-	}
+	init_numa_sched_groups_power(sched_group_allnodes);
 #endif
 
 	/* Attach the domains */

