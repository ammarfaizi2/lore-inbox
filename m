Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWFJSbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWFJSbq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWFJSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:31:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10657 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030370AbWFJSbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:31:45 -0400
Date: Sat, 10 Jun 2006 11:31:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> 
 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com> 
 <20060610092412.66dd109f.akpm@osdl.org>  <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
  <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com> 
 <20060610100318.8900f849.akpm@osdl.org>  <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
 <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006, Michal Piotrowski wrote:
> [michal@ltg01-fedora linux-mm]$ cat ~/page_alloc.patch | patch -p1 --dry-run
> patching file mm/page_alloc.c
> Hunk #1 FAILED at 1583.
> Hunk #2 succeeded at 1604 (offset 1 line).
> 1 out of 3 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej
> patching file include/linux/page-flags.h
> 
> PITA for people that aren't kernel hackers.

Sorry that patch was still against mm1. Here is a fixed up version that 
applies cleanly against mm2:

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

Index: linux-2.6.17-rc6-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/mm/page_alloc.c	2006-06-10 11:11:58.068665310 -0700
+++ linux-2.6.17-rc6-mm2/mm/page_alloc.c	2006-06-10 11:13:54.679609667 -0700
@@ -1583,7 +1583,7 @@ static void show_node(struct zone *zone)
 #endif
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
+DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{LOCAL_INIT(0)}};
 EXPORT_PER_CPU_SYMBOL(vm_event_states);
 
 static void sum_vm_events(unsigned long *ret, cpumask_t *cpumask)
@@ -1604,7 +1604,7 @@ static void sum_vm_events(unsigned long 
 
 
 		for (i=0; i< NR_VM_EVENT_ITEMS; i++)
-			ret[i] += this->event[i];
+			ret[i] += local_read(&this->event[i]);
 	}
 }
 
@@ -2882,7 +2882,7 @@ static void vm_events_fold_cpu(int cpu)
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
 		count_vm_events(i, fold_state->event[i]);
-		fold_state->event[i] = 0;
+		local_set(fold_state->event[i], 0);
 	}
 }
 
Index: linux-2.6.17-rc6-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/page-flags.h	2006-06-10 11:11:57.173212937 -0700
+++ linux-2.6.17-rc6-mm2/include/linux/page-flags.h	2006-06-10 11:14:23.596764624 -0700
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
+	return cpu_local_read(vm_event_states.event[item]);
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
