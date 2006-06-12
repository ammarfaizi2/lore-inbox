Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWFLLt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWFLLt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWFLLt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:49:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51371 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751134AbWFLLt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:49:58 -0400
Date: Mon, 12 Jun 2006 13:48:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@sgi.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-ID: <20060612114857.GA14616@elte.hu>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com> <20060610092412.66dd109f.akpm@osdl.org> <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com> <20060610100318.8900f849.akpm@osdl.org> <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com> <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com> <Pine.LNX.4.64.0606101118410.7535@schroedinger.engr.sgi.com> <20060612110537.GA11358@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612110537.GA11358@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Christoph Lameter <clameter@sgi.com> wrote:
> 
> > Sorry that patch was still against mm1. Here is a fixed up version 
> > that applies cleanly against mm2:
> 
> i have applied both patches you sent in this thread but it still 
> triggers tons of messages:

> trying to fix it i realized that i'd have to touch tons of 
> architectures, which all duplicate this piece of code:

below is an updated patch that includes fixups for i386 - but the real 
fix should be to properly reduce the per-arch local.h footprint to the 
bare minimum possible, and to do this fix on the asm-generic headers.

	Ingo
---
 include/asm-generic/local.h |   20 ++++++++++----------
 include/asm-i386/local.h    |   25 ++++++++++++++-----------
 include/linux/page-flags.h  |   14 +++++---------
 mm/page_alloc.c             |    8 ++++----
 4 files changed, 33 insertions(+), 34 deletions(-)

Index: linux/include/asm-generic/local.h
===================================================================
--- linux.orig/include/asm-generic/local.h
+++ linux/include/asm-generic/local.h
@@ -44,19 +44,19 @@ typedef struct
  * much more efficient than these naive implementations.  Note they take
  * a variable (eg. mystruct.foo), not an address.
  */
-#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
-#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+#define cpu_local_read(v)	local_read(&per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_set(v, i)	local_set(&per_cpu(v, raw_smp_processor_id()), (i))
+#define cpu_local_inc(v)	local_inc(&per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_dec(v)	local_dec(&per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_add(i, v)	local_add((i), &per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_sub(i, v)	local_sub((i), &per_cpu(v, raw_smp_processor_id()))
 
 /* Non-atomic increments, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well.
  */
-#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
-#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
-#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
-#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+#define __cpu_local_inc(v)	__local_inc(&per_cpu(v, raw_smp_processor_id()))
+#define __cpu_local_dec(v)	__local_dec(&per_cpu(v, raw_smp_processor_id()))
+#define __cpu_local_add(i, v)	__local_add((i), &per_cpu(v, raw_smp_processor_id()))
+#define __cpu_local_sub(i, v)	__local_sub((i), &per_cpu(v, raw_smp_processor_id()))
 
 #endif /* _ASM_GENERIC_LOCAL_H */
Index: linux/include/asm-i386/local.h
===================================================================
--- linux.orig/include/asm-i386/local.h
+++ linux/include/asm-i386/local.h
@@ -53,18 +53,21 @@ static __inline__ void local_sub(long i,
 
 /* Use these for per-cpu local_t variables: on some archs they are
  * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
+ * a variable (eg. mystruct.foo), not an address.
  */
-#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
-#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
-#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
-#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
-#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
-#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+#define cpu_local_read(v)	local_read(&per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_set(v, i)	local_set(&per_cpu(v, raw_smp_processor_id()), (i))
+#define cpu_local_inc(v)	local_inc(&per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_dec(v)	local_dec(&per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_add(i, v)	local_add((i), &per_cpu(v, raw_smp_processor_id()))
+#define cpu_local_sub(i, v)	local_sub((i), &per_cpu(v, raw_smp_processor_id()))
 
-#define __cpu_local_inc(v)	cpu_local_inc(v)
-#define __cpu_local_dec(v)	cpu_local_dec(v)
-#define __cpu_local_add(i, v)	cpu_local_add((i), (v))
-#define __cpu_local_sub(i, v)	cpu_local_sub((i), (v))
+/* Non-atomic increments, ie. preemption disabled and won't be touched
+ * in interrupt, etc.  Some archs can optimize this case well.
+ */
+#define __cpu_local_inc(v)	__local_inc(&per_cpu(v, raw_smp_processor_id()))
+#define __cpu_local_dec(v)	__local_dec(&per_cpu(v, raw_smp_processor_id()))
+#define __cpu_local_add(i, v)	__local_add((i), &per_cpu(v, raw_smp_processor_id()))
+#define __cpu_local_sub(i, v)	__local_sub((i), &per_cpu(v, raw_smp_processor_id()))
 
 #endif /* _ARCH_I386_LOCAL_H */
Index: linux/include/linux/page-flags.h
===================================================================
--- linux.orig/include/linux/page-flags.h
+++ linux/include/linux/page-flags.h
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
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
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
 
@@ -2881,8 +2881,8 @@ static void vm_events_fold_cpu(int cpu)
 	int i;
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-		count_vm_events(i, fold_state->event[i]);
-		fold_state->event[i] = 0;
+		count_vm_events(i, local_read(&fold_state->event[i]));
+		local_set(&fold_state->event[i], 0);
 	}
 }
 
