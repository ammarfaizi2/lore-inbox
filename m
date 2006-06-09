Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWFIWjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWFIWjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWFIWjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:39:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62634 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751420AbWFIWjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:39:04 -0400
Date: Fri, 9 Jun 2006 15:38:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@suse.de,
       ak@suse.de, hugh@veritas.com
Subject: Re: Light weight counter 1/1 Framework
In-Reply-To: <20060609143333.39b29109.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606091537350.3036@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606091216320.1174@schroedinger.engr.sgi.com>
 <20060609143333.39b29109.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eventcounter fixups

- Add comment to all_vm_events

- remove get_global_events.

- fold foreign cpu events into our own.

- Remove useless exports

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-09 15:14:44.173612828 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-09 15:35:21.719837630 -0700
@@ -1585,7 +1585,7 @@ static void show_node(struct zone *zone)
 #ifdef CONFIG_VM_EVENT_COUNTERS
 DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
 
-void sum_vm_events(unsigned long *ret, cpumask_t *cpumask)
+static void sum_vm_events(unsigned long *ret, cpumask_t *cpumask)
 {
 	int cpu = 0;
 	int i;
@@ -1606,25 +1606,16 @@ void sum_vm_events(unsigned long *ret, c
 			ret[i] += this->event[i];
 	}
 }
-EXPORT_SYMBOL(sum_vm_events);
 
-void all_vm_events(unsigned long *ret)
+/*
+ * Accumulate the vm event counters across all CPUs.
+ * The result is unavoidably approximate - it can change
+ * during and after execution of this function.
+*/
+static void all_vm_events(unsigned long *ret)
 {
 	sum_vm_events(ret, &cpu_online_map);
 }
-EXPORT_SYMBOL(all_vm_events);
-
-unsigned long get_global_vm_events(enum vm_event_item e)
-{
-	unsigned long ret = 0;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		ret += per_cpu(vm_event_states, cpu).event[e];
-
-	return ret;
-}
-EXPORT_SYMBOL(get_global_vm_events);
 #endif
 
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
@@ -2875,6 +2866,25 @@ struct seq_operations vmstat_op = {
 #endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_HOTPLUG_CPU
+/*
+ * Fold the foreign cpu states int our own.
+ *
+ * This is a pretty inconsistent thing to do since
+ * the event array is to count the events occurring
+ * for each processor. But we did this in the past
+ * so I guess that we need to continue.
+ */
+static void vm_events_fold_cpu(int cpu)
+{
+	struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
+	int i;
+
+	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
+		count_vm_events(i, fold_state->event[i]);
+		fold_state->event[i] = 0;
+	}
+}
+
 static int page_alloc_cpu_notify(struct notifier_block *self,
 				 unsigned long action, void *hcpu)
 {
@@ -2886,17 +2896,7 @@ static int page_alloc_cpu_notify(struct 
 
 		local_irq_disable();
 		__drain_pages(cpu);
-
-		/* Add dead cpu's page_states to our own. */
-		dest = (unsigned long *)&__get_cpu_var(page_states);
-		src = (unsigned long *)&per_cpu(page_states, cpu);
-
-		for (i = 0; i < sizeof(struct page_state)/sizeof(unsigned long);
-				i++) {
-			dest[i] += src[i];
-			src[i] = 0;
-		}
-
+		vm_events_fold_cpu(cpu);
 		local_irq_enable();
 		refresh_cpu_vm_stats(cpu);
 	} 
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-09 15:10:30.611239764 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-09 15:35:41.847495238 -0700
@@ -139,10 +139,6 @@ struct vm_event_state {
 
 DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
 
-extern unsigned long get_global_vm_events(enum vm_event_item e);
-extern void sum_vm_events(unsigned long *r, cpumask_t *cpumask);
-extern void all_vm_events(unsigned long *r);
-
 static inline unsigned long get_cpu_vm_events(enum vm_event_item item)
 {
 	return __get_cpu_var(vm_event_states).event[item];
@@ -161,7 +157,6 @@ static inline void count_vm_events(enum 
 #else
 /* Disable counters */
 #define get_cpu_vm_events(e)	0L
-#define get_global_vm_events(e)	0L
 #define count_vm_event(e)	do { } while (0)
 #define count_vm_events(e,d)	do { } while (0)
 #endif
