Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWFJSFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWFJSFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWFJSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:05:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48798 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751238AbWFJSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:05:03 -0400
Date: Sat, 10 Jun 2006 11:04:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <20060610100318.8900f849.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com>
 <20060610092412.66dd109f.akpm@osdl.org> <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com>
 <20060610100318.8900f849.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006, Andrew Morton wrote:

> I've placed a rollup of 2.6.17-rc6-mm2 minus the zoned-vm and eventcounter
> patches at

Oh. So 2.6.17-rc6-mm2 is out with that counter patchset. 

If someone needs a fix then please try this patch that was posted last 
night. Seems that was too late for 2.6.17-rc6-mm2.


light weight counters: race free through local_t

One way of making the light weight counters race free for x86_64 and
i386 is to use local_t. With that those two platforms are fine.

However, the others fall back to atomic operations.

Maybe we could deal with that on per platform basis? Some platforms
may want to switch away from atomics to regular integers if preemption
is not configured. Most commercial Linux distros ship with preempt off.
So this would preserve the speed of light weight counters.

Some of the potential races with just plain integers are not that good.

F.e. if an integer is loaded via the per cpu area and then
we switch to another processor. At that point the per cpu area changes.
We may then increment the count from the old processor and store it
to the counter of the new processor. Ick.

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
