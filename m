Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVDEXo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVDEXo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVDEXo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:44:56 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:60010 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261872AbVDEXof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:44:35 -0400
Message-ID: <425322E0.9070307@yahoo.com.au>
Date: Wed, 06 Apr 2005 09:44:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [patch 1/5] sched: remove degenerate domains
Content-Type: multipart/mixed;
 boundary="------------000002050003070906040208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000002050003070906040208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is Suresh's patch with some modifications.

-- 
SUSE Labs, Novell Inc.

--------------000002050003070906040208
Content-Type: text/plain;
 name="sched-remove-degenerate-domains.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-remove-degenerate-domains.patch"

Remove degenerate scheduler domains during the sched-domain init.

For example on x86_64, we always have NUMA configured in. On Intel EM64T
systems, top most sched domain will be of NUMA and with only one sched_group in
it. 

With fork/exec balances(recent Nick's fixes in -mm tree), we always endup 
taking wrong decisions because of this topmost domain (as it contains only 
one group and find_idlest_group always returns NULL). We will endup loading 
HT package completely first, letting active load balance kickin and correct it.

In general, this patch also makes sense with out recent Nick's fixes
in -mm.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

Modified to account for more than just sched_groups when scanning for
degenerate domains by Nick Piggin. Allow a runqueue's sd to go NULL, which
required small changes to the smtnice code.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-05 16:38:21.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-05 18:39:09.000000000 +1000
@@ -2583,11 +2583,15 @@ out:
 #ifdef CONFIG_SCHED_SMT
 static inline void wake_sleeping_dependent(int this_cpu, runqueue_t *this_rq)
 {
-	struct sched_domain *sd = this_rq->sd;
+	struct sched_domain *tmp, *sd = NULL;
 	cpumask_t sibling_map;
 	int i;
+	
+	for_each_domain(this_cpu, tmp)
+		if (tmp->flags & SD_SHARE_CPUPOWER)
+			sd = tmp;
 
-	if (!(sd->flags & SD_SHARE_CPUPOWER))
+	if (!sd)
 		return;
 
 	/*
@@ -2628,13 +2632,17 @@ static inline void wake_sleeping_depende
 
 static inline int dependent_sleeper(int this_cpu, runqueue_t *this_rq)
 {
-	struct sched_domain *sd = this_rq->sd;
+	struct sched_domain *tmp, *sd = NULL;
 	cpumask_t sibling_map;
 	prio_array_t *array;
 	int ret = 0, i;
 	task_t *p;
 
-	if (!(sd->flags & SD_SHARE_CPUPOWER))
+	for_each_domain(this_cpu, tmp)
+		if (tmp->flags & SD_SHARE_CPUPOWER)
+			sd = tmp;
+
+	if (!sd)
 		return 0;
 
 	/*
@@ -4604,6 +4612,11 @@ static void sched_domain_debug(struct sc
 {
 	int level = 0;
 
+	if (!sd) {
+		printk(KERN_DEBUG "CPU%d attaching NULL sched-domain.\n", cpu);
+		return;
+	}
+		
 	printk(KERN_DEBUG "CPU%d attaching sched-domain:\n", cpu);
 
 	do {
@@ -4809,6 +4822,50 @@ static void init_sched_domain_sysctl(voi
 }
 #endif
 
+static int __devinit sd_degenerate(struct sched_domain *sd)
+{
+	if (cpus_weight(sd->span) == 1)
+		return 1;
+
+	/* Following flags need at least 2 groups */
+	if (sd->flags & (SD_LOAD_BALANCE |
+			 SD_BALANCE_NEWIDLE |
+			 SD_BALANCE_FORK |
+			 SD_BALANCE_EXEC)) {
+		if (sd->groups != sd->groups->next)
+			return 0;
+	}
+
+	/* Following flags don't use groups */
+	if (sd->flags & (SD_WAKE_IDLE |
+			 SD_WAKE_AFFINE |
+			 SD_WAKE_BALANCE))
+		return 0;
+
+	return 1;
+}
+
+static int __devinit sd_parent_degenerate(struct sched_domain *sd,
+						struct sched_domain *parent)
+{
+	unsigned long cflags = sd->flags, pflags = parent->flags;
+
+	if (sd_degenerate(parent))
+		return 1;
+
+	if (!cpus_equal(sd->span, parent->span))
+		return 0;
+
+	/* Does parent contain flags not in child? */
+	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
+	if (cflags & SD_WAKE_AFFINE)
+		pflags &= ~SD_WAKE_BALANCE;
+	if ((~sd->flags) & parent->flags)
+		return 0;
+
+	return 1;
+}
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain.  Callers must
  * hold the hotplug lock.
@@ -4819,6 +4876,19 @@ void __devinit cpu_attach_domain(struct 
 	unsigned long flags;
 	runqueue_t *rq = cpu_rq(cpu);
 	int local = 1;
+	struct sched_domain *tmp;
+
+	/* Remove the sched domains which do not contribute to scheduling. */
+	for (tmp = sd; tmp; tmp = tmp->parent) {
+		struct sched_domain *parent = tmp->parent;
+		if (!parent)
+			break;
+		if (sd_parent_degenerate(tmp, parent))
+			tmp->parent = parent->parent;
+	}
+
+	if (sd_degenerate(sd))
+		sd = sd->parent;
 
 	sched_domain_debug(sd, cpu);
 

--------------000002050003070906040208--

