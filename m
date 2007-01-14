Return-Path: <linux-kernel-owner+w=401wt.eu-S1751646AbXANTq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbXANTq7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbXANTq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:46:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46644 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbXANTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:46:58 -0500
Date: Sun, 14 Jan 2007 20:42:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] lockdep: shrink held_lock structure
Message-ID: <20070114194217.GA20726@elte.hu>
References: <20070102233558.GA4577@redhat.com> <20070102233824.GF18033@redhat.com> <1168800350.32239.13.camel@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168800350.32239.13.camel@earth>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: shrink held_lock structure
From: Dave Jones <davej@redhat.com>

shrink the held_lock structure from 40 to 20 bytes. This shrinks struct 
task_struct from 3056 to 2464 bytes.

[ From: Ingo Molnar <mingo@elte.hu>, shrunk hlock->class too. ]

Shrunk MAX_KEYS_BITS from 11 to 10, and thus kernel size
goes down significantly too:

    text    data     bss     dec     hex filename
 5297365  642664 3203072 9143101  8b833d vmlinux.before
 5298257  642024 2953216 8893497  87b439 vmlinux.after

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h    |   16 ++++---
 kernel/lockdep.c           |   91 ++++++++++++++++++++++++---------------------
 kernel/lockdep_internals.h |    3 -
 3 files changed, 58 insertions(+), 52 deletions(-)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -143,6 +143,9 @@ struct lock_chain {
 	u64				chain_key;
 };
 
+#define MAX_LOCKDEP_KEYS_BITS		10
+#define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
+
 struct held_lock {
 	/*
 	 * One-way hash of the dependency chain up to this point. We
@@ -159,10 +162,9 @@ struct held_lock {
 	 * with zero), here we store the previous hash value:
 	 */
 	u64				prev_chain_key;
-	struct lock_class		*class;
 	unsigned long			acquire_ip;
 	struct lockdep_map		*instance;
-
+	int				class_idx:MAX_LOCKDEP_KEYS_BITS;
 	/*
 	 * The lock-stack is unified in that the lock chains of interrupt
 	 * contexts nest ontop of process context chains, but we 'separate'
@@ -176,11 +178,11 @@ struct held_lock {
 	 * The following field is used to detect when we cross into an
 	 * interrupt context:
 	 */
-	int				irq_context;
-	int				trylock;
-	int				read;
-	int				check;
-	int				hardirqs_off;
+	unsigned char irq_context:1;
+	unsigned char trylock:1;
+	unsigned char read:2;
+	unsigned char check:1;
+	unsigned char hardirqs_off:1;
 };
 
 /*
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -128,6 +128,11 @@ static struct lock_class lock_classes[MA
  */
 LIST_HEAD(all_lock_classes);
 
+static inline struct lock_class *hlock_class(struct held_lock *hlock)
+{
+	return lock_classes + hlock->class_idx;
+}
+
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
  */
@@ -416,7 +421,7 @@ static void print_lockdep_cache(struct l
 
 static void print_lock(struct held_lock *hlock)
 {
-	print_lock_name(hlock->class);
+	print_lock_name(hlock_class(hlock));
 	printk(", at: ");
 	print_ip_sym(hlock->acquire_ip);
 }
@@ -594,7 +599,7 @@ static noinline int print_circular_bug_t
 	if (debug_locks_silent)
 		return 0;
 
-	this.class = check_source->class;
+	this.class = hlock_class(check_source);
 	if (!save_trace(&this.trace))
 		return 0;
 
@@ -639,7 +644,7 @@ check_noncircular(struct lock_class *sou
 	 * Check this lock's dependency list:
 	 */
 	list_for_each_entry(entry, &source->locks_after, entry) {
-		if (entry->class == check_target->class)
+		if (entry->class == hlock_class(check_target))
 			return print_circular_bug_header(entry, depth+1);
 		debug_atomic_inc(&nr_cyclic_checks);
 		if (!check_noncircular(entry->class, depth+1))
@@ -773,9 +778,9 @@ print_bad_irq_dependency(struct task_str
 	printk("\nand this task is already holding:\n");
 	print_lock(prev);
 	printk("which would create a new lock dependency:\n");
-	print_lock_name(prev->class);
+	print_lock_name(hlock_class(prev));
 	printk(" ->");
-	print_lock_name(next->class);
+	print_lock_name(hlock_class(next));
 	printk("\n");
 
 	printk("\nbut this new dependency connects a %s-irq-safe lock:\n",
@@ -816,12 +821,12 @@ check_usage(struct task_struct *curr, st
 
 	find_usage_bit = bit_backwards;
 	/* fills in <backwards_match> */
-	ret = find_usage_backwards(prev->class, 0);
+	ret = find_usage_backwards(hlock_class(prev), 0);
 	if (!ret || ret == 1)
 		return ret;
 
 	find_usage_bit = bit_forwards;
-	ret = find_usage_forwards(next->class, 0);
+	ret = find_usage_forwards(hlock_class(next), 0);
 	if (!ret || ret == 1)
 		return ret;
 	/* ret == 2 */
@@ -874,7 +879,7 @@ check_deadlock(struct task_struct *curr,
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		prev = curr->held_locks + i;
-		if (prev->class != next->class)
+		if (hlock_class(prev) != hlock_class(next))
 			continue;
 		/*
 		 * Allow read-after-read recursion of the same
@@ -927,7 +932,7 @@ check_prev_add(struct task_struct *curr,
 	 */
 	check_source = next;
 	check_target = prev;
-	if (!(check_noncircular(next->class, 0)))
+	if (!(check_noncircular(hlock_class(next), 0)))
 		return print_circular_bug_tail();
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -988,8 +993,8 @@ check_prev_add(struct task_struct *curr,
 	 *  chains - the second one will be new, but L1 already has
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
-	list_for_each_entry(entry, &prev->class->locks_after, entry) {
-		if (entry->class == next->class) {
+	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+		if (entry->class == hlock_class(next)) {
 			if (distance == 1)
 				entry->distance = 1;
 			return 2;
@@ -1000,26 +1005,28 @@ check_prev_add(struct task_struct *curr,
 	 * Ok, all validations passed, add the new lock
 	 * to the previous lock's dependency list:
 	 */
-	ret = add_lock_to_list(prev->class, next->class,
-			       &prev->class->locks_after, next->acquire_ip, distance);
+	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
+			       &hlock_class(prev)->locks_after,
+			       next->acquire_ip, distance);
 
 	if (!ret)
 		return 0;
 
-	ret = add_lock_to_list(next->class, prev->class,
-			       &next->class->locks_before, next->acquire_ip, distance);
+	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
+			       &hlock_class(next)->locks_before,
+			       next->acquire_ip, distance);
 	if (!ret)
 		return 0;
 
 	/*
 	 * Debugging printouts:
 	 */
-	if (verbose(prev->class) || verbose(next->class)) {
+	if (verbose(hlock_class(prev)) || verbose(hlock_class(next))) {
 		graph_unlock();
 		printk("\n new dependency: ");
-		print_lock_name(prev->class);
+		print_lock_name(hlock_class(prev));
 		printk(" => ");
-		print_lock_name(next->class);
+		print_lock_name(hlock_class(next));
 		printk("\n");
 		dump_stack();
 		return graph_lock();
@@ -1411,7 +1418,7 @@ static void notrace check_chain_key(stru
 			WARN_ON(1);
 			return;
 		}
-		id = hlock->class - lock_classes;
+		id = hlock_class(hlock) - lock_classes;
 		if (DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
 			return;
 
@@ -1463,7 +1470,7 @@ print_irq_inversion_bug(struct task_stru
 	lockdep_print_held_locks(curr);
 
 	printk("\nthe first lock's dependencies:\n");
-	print_lock_dependencies(this->class, 0);
+	print_lock_dependencies(hlock_class(this), 0);
 
 	printk("\nthe second lock's dependencies:\n");
 	print_lock_dependencies(other, 0);
@@ -1486,7 +1493,7 @@ check_usage_forwards(struct task_struct 
 
 	find_usage_bit = bit;
 	/* fills in <forwards_match> */
-	ret = find_usage_forwards(this->class, 0);
+	ret = find_usage_forwards(hlock_class(this), 0);
 	if (!ret || ret == 1)
 		return ret;
 
@@ -1505,7 +1512,7 @@ check_usage_backwards(struct task_struct
 
 	find_usage_bit = bit;
 	/* fills in <backwards_match> */
-	ret = find_usage_backwards(this->class, 0);
+	ret = find_usage_backwards(hlock_class(this), 0);
 	if (!ret || ret == 1)
 		return ret;
 
@@ -1551,7 +1558,7 @@ print_usage_bug(struct task_struct *curr
 	print_lock(this);
 
 	printk("{%s} state was registered at:\n", usage_str[prev_bit]);
-	print_stack_trace(this->class->usage_traces + prev_bit, 1);
+	print_stack_trace(hlock_class(this)->usage_traces + prev_bit, 1);
 
 	print_irqtrace_events(curr);
 	printk("\nother info that might help us debug this:\n");
@@ -1570,7 +1577,7 @@ static inline int
 valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
-	if (unlikely(this->class->usage_mask & (1 << bad_bit)))
+	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit)))
 		return print_usage_bug(curr, this, bad_bit, new_bit);
 	return 1;
 }
@@ -1590,7 +1597,7 @@ mark_lock(struct task_struct *curr, stru
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
 	 */
-	if (likely(this->class->usage_mask & new_mask))
+	if (likely(hlock_class(this)->usage_mask & new_mask))
 		return 1;
 
 	if (!graph_lock())
@@ -1598,12 +1605,12 @@ mark_lock(struct task_struct *curr, stru
 	/*
 	 * Make sure we didnt race:
 	 */
-	if (unlikely(this->class->usage_mask & new_mask)) {
+	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
 		graph_unlock();
 		return 1;
 	}
 
-	this->class->usage_mask |= new_mask;
+	hlock_class(this)->usage_mask |= new_mask;
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	if (new_bit == LOCK_ENABLED_HARDIRQS ||
@@ -1613,7 +1620,7 @@ mark_lock(struct task_struct *curr, stru
 			new_bit == LOCK_ENABLED_SOFTIRQS_READ)
 		ip = curr->softirq_enable_ip;
 #endif
-	if (!save_trace(this->class->usage_traces + new_bit))
+	if (!save_trace(hlock_class(this)->usage_traces + new_bit))
 		return 0;
 
 	switch (new_bit) {
@@ -1640,7 +1647,7 @@ mark_lock(struct task_struct *curr, stru
 				LOCK_ENABLED_HARDIRQS_READ, "hard-read"))
 			return 0;
 #endif
-		if (hardirq_verbose(this->class))
+		if (hardirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_USED_IN_SOFTIRQ:
@@ -1665,7 +1672,7 @@ mark_lock(struct task_struct *curr, stru
 				LOCK_ENABLED_SOFTIRQS_READ, "soft-read"))
 			return 0;
 #endif
-		if (softirq_verbose(this->class))
+		if (softirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_USED_IN_HARDIRQ_READ:
@@ -1678,7 +1685,7 @@ mark_lock(struct task_struct *curr, stru
 		if (!check_usage_forwards(curr, this,
 					  LOCK_ENABLED_HARDIRQS, "hard"))
 			return 0;
-		if (hardirq_verbose(this->class))
+		if (hardirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_USED_IN_SOFTIRQ_READ:
@@ -1691,7 +1698,7 @@ mark_lock(struct task_struct *curr, stru
 		if (!check_usage_forwards(curr, this,
 					  LOCK_ENABLED_SOFTIRQS, "soft"))
 			return 0;
-		if (softirq_verbose(this->class))
+		if (softirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_ENABLED_HARDIRQS:
@@ -1717,7 +1724,7 @@ mark_lock(struct task_struct *curr, stru
 				   LOCK_USED_IN_HARDIRQ_READ, "hard-read"))
 			return 0;
 #endif
-		if (hardirq_verbose(this->class))
+		if (hardirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_ENABLED_SOFTIRQS:
@@ -1743,7 +1750,7 @@ mark_lock(struct task_struct *curr, stru
 				   LOCK_USED_IN_SOFTIRQ_READ, "soft-read"))
 			return 0;
 #endif
-		if (softirq_verbose(this->class))
+		if (softirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_ENABLED_HARDIRQS_READ:
@@ -1758,7 +1765,7 @@ mark_lock(struct task_struct *curr, stru
 					   LOCK_USED_IN_HARDIRQ, "hard"))
 			return 0;
 #endif
-		if (hardirq_verbose(this->class))
+		if (hardirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 	case LOCK_ENABLED_SOFTIRQS_READ:
@@ -1773,7 +1780,7 @@ mark_lock(struct task_struct *curr, stru
 					   LOCK_USED_IN_SOFTIRQ, "soft"))
 			return 0;
 #endif
-		if (softirq_verbose(this->class))
+		if (softirq_verbose(hlock_class(this)))
 			ret = 2;
 		break;
 #endif
@@ -1781,7 +1788,7 @@ mark_lock(struct task_struct *curr, stru
 		/*
 		 * Add it to the global list of classes:
 		 */
-		list_add_tail_rcu(&this->class->lock_entry, &all_lock_classes);
+		list_add_tail_rcu(&hlock_class(this)->lock_entry, &all_lock_classes);
 		debug_atomic_dec(&nr_unused_locks);
 		break;
 	default:
@@ -2086,7 +2093,7 @@ static int __lock_acquire(struct lockdep
 
 	hlock = curr->held_locks + depth;
 
-	hlock->class = class;
+	hlock->class_idx = class - lock_classes;
 	hlock->acquire_ip = ip;
 	hlock->instance = lock;
 	hlock->trylock = trylock;
@@ -2327,7 +2334,7 @@ __lock_set_subclass(struct lockdep_map *
 
 found_it:
 	class = register_lock_class(lock, subclass, 0);
-	hlock->class = class;
+	hlock->class_idx = class - lock_classes;
 
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
@@ -2335,7 +2342,7 @@ found_it:
 	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		if (!__lock_acquire(hlock->instance,
-			hlock->class->subclass, hlock->trylock,
+			hlock_class(hlock)->subclass, hlock->trylock,
 				hlock->read, hlock->check, hlock->hardirqs_off,
 				hlock->acquire_ip))
 			return 0;
@@ -2394,7 +2401,7 @@ found_it:
 	for (i++; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		if (!__lock_acquire(hlock->instance,
-			hlock->class->subclass, hlock->trylock,
+			hlock_class(hlock)->subclass, hlock->trylock,
 				hlock->read, hlock->check, hlock->hardirqs_off,
 				hlock->acquire_ip))
 			return 0;
@@ -2437,7 +2444,7 @@ static int lock_release_nested(struct ta
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 	hlock->prev_chain_key = 0;
-	hlock->class = NULL;
+	hlock_class(hlock) = NULL;
 	hlock->acquire_ip = 0;
 	hlock->irq_context = 0;
 #endif
Index: linux/kernel/lockdep_internals.h
===================================================================
--- linux.orig/kernel/lockdep_internals.h
+++ linux/kernel/lockdep_internals.h
@@ -17,9 +17,6 @@
  */
 #define MAX_LOCKDEP_ENTRIES	8192UL
 
-#define MAX_LOCKDEP_KEYS_BITS	11
-#define MAX_LOCKDEP_KEYS	(1UL << MAX_LOCKDEP_KEYS_BITS)
-
 #define MAX_LOCKDEP_CHAINS_BITS	14
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
