Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966334AbWKNUeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966334AbWKNUeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966338AbWKNUeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:34:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:950 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S966334AbWKNUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:34:00 -0500
Date: Tue, 14 Nov 2006 12:33:43 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061114203343.12761.47566.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [DEBUG] Add a few scheduler event counters
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DEBUG] Some additional VM counters

Add a few counters to be able to see how the softirq affects the
scheduler. This patch should not go into mainline and maybe also
not into mm.

New counters in /proc/vmstat

sched_tick_balance	Ticks that required invokation of the softirq
sched_tick_no_balance	Ticks that did not require the softirq
sched_load_balance	# invocations of load_balance().
sched_balance_softirq	# of softirq executions
sched_balance_running	# of times that serialization prevented
			load balancing of a sched_domain.


Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/include/linux/vmstat.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/vmstat.h	2006-11-13 19:04:08.000000000 -0600
+++ linux-2.6.19-rc5-mm1/include/linux/vmstat.h	2006-11-13 19:06:12.308571232 -0600
@@ -47,6 +47,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
 		FOR_ALL_ZONES(PGSCAN_DIRECT),
 		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
 		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
+		SCHED_TICK_NO_BALANCE, SCHED_TICK_BALANCE, SCHED_BALANCE_SOFTIRQ,
+		SCHED_LOAD_BALANCE, SCHED_BALANCE_RUNNING,
 		NR_VM_EVENT_ITEMS
 };
 
Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-13 19:06:01.000000000 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-13 19:06:12.405259200 -0600
@@ -2900,6 +2900,8 @@ static void run_rebalance_domains(struct
 	/* Earliest time when we have to call run_rebalance_domains again */
 	unsigned long next_balance = jiffies + 60*HZ;
 
+	__count_vm_event(SCHED_BALANCE_SOFTIRQ);
+
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
 			continue;
@@ -2914,11 +2916,14 @@ static void run_rebalance_domains(struct
 			interval = 1;
 
 		if (sd->flags & SD_SERIALIZE) {
-			if (!spin_trylock(&balancing))
+			if (!spin_trylock(&balancing)) {
+				__count_vm_event(SCHED_BALANCE_RUNNING);
 				goto out;
+			}
 		}
 
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
+			__count_vm_event(SCHED_LOAD_BALANCE);
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -3188,8 +3193,11 @@ void scheduler_tick(void)
 		task_running_tick(rq, p);
 #ifdef CONFIG_SMP
 	update_load(rq);
-	if (time_after_eq(jiffies, rq->next_balance))
+	if (time_after_eq(jiffies, rq->next_balance)) {
+		__count_vm_event(SCHED_TICK_BALANCE);
 		raise_softirq(SCHED_SOFTIRQ);
+	}
+		__count_vm_event(SCHED_TICK_NO_BALANCE);
 #endif
 }
 
Index: linux-2.6.19-rc5-mm1/mm/vmstat.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/mm/vmstat.c	2006-11-13 19:04:08.000000000 -0600
+++ linux-2.6.19-rc5-mm1/mm/vmstat.c	2006-11-13 19:06:12.560545937 -0600
@@ -509,6 +509,11 @@ static char *vmstat_text[] = {
 	"allocstall",
 
 	"pgrotated",
+	"sched_tick_no_balance",
+	"sched_tick_balance",
+	"sched_balance_softirq",
+	"sched_load_balance",
+	"sched_balance_running",
 #endif
 };
 
