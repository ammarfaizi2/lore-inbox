Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWFJFao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWFJFao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWFJFao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:30:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16583 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932366AbWFJFan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:30:43 -0400
Date: Fri, 9 Jun 2006 22:30:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org, ak@suse.de
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: light weight counters: race free through local_t?
Message-ID: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One way of making the light weight counters race free for x86_64 and
i386 is to use local_t. With that those two platforms are fine.

However, the others fall back to atomic operations.

Maybe we could deal with that on per platform basis? Some platforms may 
want to switch the local_t implementation away from atomics to regular 
integers if preemption is not configured. Most commercial Linux distros 
ship with preempt off. So this would preserve the speed of light weight 
counters, while holding off the worst races. But it still could allow
interrupts while the counter is being incremented and so it would not 
be race free. This would no longer allow the use of local_t for 
refcounts but I think those uses are not that performance critical
and we may just switch to atomic. Maybe I am just off in fantasyland.

Andi?

Another thing to investigate (at least on ia64) is how significant the 
impact of a fetchadd instruction is if none of the results are used. Maybe 
it is tolerable and we can stay with the existing implementation.

On IA64 we we would trade an interrupt disable/ load / add / store /interrupt 
enable against one fetchadd instruction with this patch. How bad/good a 
trade is that?

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-09 17:51:18.789713315 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-09 22:06:09.491210492 -0700
@@ -1583,7 +1583,7 @@ static void show_node(struct zone *zone)
 #endif
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
+DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{LOCAL_INIT(0)}};
 
 static void sum_vm_events(unsigned long *ret, cpumask_t *cpumask)
 {
@@ -1603,7 +1603,7 @@ static void sum_vm_events(unsigned long 
 
 
 		for (i=0; i< NR_VM_EVENT_ITEMS; i++)
-			ret[i] += this->event[i];
+			ret[i] += local_read(&this->event[i]);
 	}
 }
 
@@ -2881,7 +2881,7 @@ static void vm_events_fold_cpu(int cpu)
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
 		count_vm_events(i, fold_state->event[i]);
-		fold_state->event[i] = 0;
+		local_set(fold_state->event[i], 0);
 	}
 }
 
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-09 22:06:18.001424043 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-09 22:29:48.581945624 -0700
@@ -8,7 +8,7 @@
 #include <linux/percpu.h>
 #include <linux/cache.h>
 #include <linux/types.h>
-
+#include <asm/local.h>
 #include <asm/pgtable.h>
 
 /*
@@ -108,10 +108,6 @@
 /*
  * Light weight per cpu counter implementation.
  *
- * Note that these can race. We do not bother to enable preemption
- * or care about interrupt races. All we care about is to have some
- * approximate count of events.
- *
  * Counters should only be incremented and no critical kernel component
  * should rely on the counter values.
  *
@@ -134,24 +130,24 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
 };
 
 struct vm_event_state {
-	unsigned long event[NR_VM_EVENT_ITEMS];
+	local_t event[NR_VM_EVENT_ITEMS];
 };
 
 DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
 
 static inline unsigned long get_cpu_vm_events(enum vm_event_item item)
 {
-	return __get_cpu_var(vm_event_states).event[item];
+	cpu_local_read(vm_event_states.event[item]);
 }
 
 static inline void count_vm_event(enum vm_event_item item)
 {
-	__get_cpu_var(vm_event_states).event[item]++;
+	cpu_local_inc(vm_event_states.event[item]);
 }
 
 static inline void count_vm_events(enum vm_event_item item, long delta)
 {
-	__get_cpu_var(vm_event_states).event[item] += delta;
+	cpu_local_add(delta, vm_event_states.event[item]);
 }
 
 extern void all_vm_events(unsigned long *);
