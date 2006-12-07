Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032197AbWLGNai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032197AbWLGNai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032210AbWLGNai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:30:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48943 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032197AbWLGNag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:30:36 -0500
Date: Thu, 7 Dec 2006 14:29:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jarek Poplawski <jarkao2@o2.pl>
Subject: [patch] lockdep: fix possible races while disabling lock-debugging
Message-ID: <20061207132903.GA341@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: fix possible races while disabling lock-debugging
From: Ingo Molnar <mingo@elte.hu>

Jarek Poplawski noticed that lockdep global state could be accessed in a 
racy way if one CPU did a lockdep assert (shutting lockdep down), while 
the other CPU would try to do something that changes its global state.

this patch fixes those races and cleans up lockdep's internal locking by 
adding a graph_lock()/graph_unlock()/debug_locks_off_graph_unlock 
helpers.

(also note that as we all know the Linux kernel is, by definition, 
bug-free and perfect, so this code never triggers, so these fixes are 
highly theoretical. I wrote this patch for aesthetic reasons alone.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |  170 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 105 insertions(+), 65 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -43,13 +43,49 @@
 #include "lockdep_internals.h"
 
 /*
- * hash_lock: protects the lockdep hashes and class/list/hash allocators.
+ * lockdep_lock: protects the lockdep graph, the hashes and the
+ *               class/list/hash allocators.
  *
  * This is one of the rare exceptions where it's justified
  * to use a raw spinlock - we really dont want the spinlock
- * code to recurse back into the lockdep code.
+ * code to recurse back into the lockdep code...
  */
-static raw_spinlock_t hash_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t lockdep_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+
+static int graph_lock(void)
+{
+	__raw_spin_lock(&lockdep_lock);
+	/*
+	 * Make sure that if another CPU detected a bug while
+	 * walking the graph we dont change it (while the other
+	 * CPU is busy printing out stuff with the graph lock
+	 * dropped already)
+	 */
+	if (!debug_locks) {
+		__raw_spin_unlock(&lockdep_lock);
+		return 0;
+	}
+	return 1;
+}
+
+static inline int graph_unlock(void)
+{
+	__raw_spin_unlock(&lockdep_lock);
+	return 0;
+}
+
+/*
+ * Turn lock debugging off and return with 0 if it was off already,
+ * and also release the graph lock:
+ */
+static inline int debug_locks_off_graph_unlock(void)
+{
+	int ret = debug_locks_off();
+
+	__raw_spin_unlock(&lockdep_lock);
+
+	return ret;
+}
 
 static int lockdep_initialized;
 
@@ -57,14 +93,15 @@ unsigned long nr_list_entries;
 static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
 
 /*
- * Allocate a lockdep entry. (assumes hash_lock held, returns
+ * Allocate a lockdep entry. (assumes the graph_lock held, returns
  * with NULL on failure)
  */
 static struct lock_list *alloc_list_entry(void)
 {
 	if (nr_list_entries >= MAX_LOCKDEP_ENTRIES) {
-		__raw_spin_unlock(&hash_lock);
-		debug_locks_off();
+		if (!debug_locks_off_graph_unlock())
+			return NULL;
+
 		printk("BUG: MAX_LOCKDEP_ENTRIES too low!\n");
 		printk("turning off the locking correctness validator.\n");
 		return NULL;
@@ -212,7 +249,7 @@ static int softirq_verbose(struct lock_c
 
 /*
  * Stack-trace: tightly packed array of stack backtrace
- * addresses. Protected by the hash_lock.
+ * addresses. Protected by the graph_lock.
  */
 unsigned long nr_stack_trace_entries;
 static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
@@ -226,8 +263,10 @@ static int save_trace(struct stack_trace
 	trace->skip = 3;
 	trace->all_contexts = 0;
 
-	/* Make sure to not recurse in case the the unwinder needs to tak
-e	   locks. */
+	/*
+	 * Make sure to not recurse in case the the unwinder needs
+	 * to take locks:
+	 */
 	lockdep_off();
 	save_stack_trace(trace, NULL);
 	lockdep_on();
@@ -235,18 +274,15 @@ e	   locks. */
 	trace->max_entries = trace->nr_entries;
 
 	nr_stack_trace_entries += trace->nr_entries;
-	if (DEBUG_LOCKS_WARN_ON(nr_stack_trace_entries > MAX_STACK_TRACE_ENTRIES)) {
-		__raw_spin_unlock(&hash_lock);
-		return 0;
-	}
 
 	if (nr_stack_trace_entries == MAX_STACK_TRACE_ENTRIES) {
-		__raw_spin_unlock(&hash_lock);
-		if (debug_locks_off()) {
-			printk("BUG: MAX_STACK_TRACE_ENTRIES too low!\n");
-			printk("turning off the locking correctness validator.\n");
-			dump_stack();
-		}
+		if (!debug_locks_off_graph_unlock())
+			return 0;
+
+		printk("BUG: MAX_STACK_TRACE_ENTRIES too low!\n");
+		printk("turning off the locking correctness validator.\n");
+		dump_stack();
+
 		return 0;
 	}
 
@@ -537,9 +573,7 @@ print_circular_bug_header(struct lock_li
 {
 	struct task_struct *curr = current;
 
-	__raw_spin_unlock(&hash_lock);
-	debug_locks_off();
-	if (debug_locks_silent)
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
 	printk("\n=======================================================\n");
@@ -567,12 +601,10 @@ static noinline int print_circular_bug_t
 	if (debug_locks_silent)
 		return 0;
 
-	/* hash_lock unlocked by the header */
-	__raw_spin_lock(&hash_lock);
 	this.class = check_source->class;
 	if (!save_trace(&this.trace))
 		return 0;
-	__raw_spin_unlock(&hash_lock);
+
 	print_circular_bug_entry(&this, 0);
 
 	printk("\nother info that might help us debug this:\n\n");
@@ -588,8 +620,10 @@ static noinline int print_circular_bug_t
 
 static int noinline print_infinite_recursion_bug(void)
 {
-	__raw_spin_unlock(&hash_lock);
-	DEBUG_LOCKS_WARN_ON(1);
+	if (!debug_locks_off_graph_unlock())
+		return 0;
+
+	WARN_ON(1);
 
 	return 0;
 }
@@ -724,9 +758,7 @@ print_bad_irq_dependency(struct task_str
 			 enum lock_usage_bit bit2,
 			 const char *irqclass)
 {
-	__raw_spin_unlock(&hash_lock);
-	debug_locks_off();
-	if (debug_locks_silent)
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
 	printk("\n======================================================\n");
@@ -807,9 +839,7 @@ static int
 print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
-	debug_locks_off();
-	__raw_spin_unlock(&hash_lock);
-	if (debug_locks_silent)
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
 	printk("\n=============================================\n");
@@ -985,14 +1015,14 @@ check_prev_add(struct task_struct *curr,
 	 * Debugging printouts:
 	 */
 	if (verbose(prev->class) || verbose(next->class)) {
-		__raw_spin_unlock(&hash_lock);
+		graph_unlock();
 		printk("\n new dependency: ");
 		print_lock_name(prev->class);
 		printk(" => ");
 		print_lock_name(next->class);
 		printk("\n");
 		dump_stack();
-		__raw_spin_lock(&hash_lock);
+		return graph_lock();
 	}
 	return 1;
 }
@@ -1057,8 +1087,10 @@ check_prevs_add(struct task_struct *curr
 	}
 	return 1;
 out_bug:
-	__raw_spin_unlock(&hash_lock);
-	DEBUG_LOCKS_WARN_ON(1);
+	if (!debug_locks_off_graph_unlock())
+		return 0;
+
+	WARN_ON(1);
 
 	return 0;
 }
@@ -1212,7 +1244,8 @@ register_lock_class(struct lockdep_map *
 	hash_head = classhashentry(key);
 
 	raw_local_irq_save(flags);
-	__raw_spin_lock(&hash_lock);
+	if (!graph_lock())
+		return NULL;
 	/*
 	 * We have to do the hash-walk again, to avoid races
 	 * with another CPU:
@@ -1225,9 +1258,12 @@ register_lock_class(struct lockdep_map *
 	 * the hash:
 	 */
 	if (nr_lock_classes >= MAX_LOCKDEP_KEYS) {
-		__raw_spin_unlock(&hash_lock);
+		if (!debug_locks_off_graph_unlock()) {
+			raw_local_irq_restore(flags);
+			return NULL;
+		}
 		raw_local_irq_restore(flags);
-		debug_locks_off();
+
 		printk("BUG: MAX_LOCKDEP_KEYS too low!\n");
 		printk("turning off the locking correctness validator.\n");
 		return NULL;
@@ -1248,18 +1284,23 @@ register_lock_class(struct lockdep_map *
 	list_add_tail_rcu(&class->hash_entry, hash_head);
 
 	if (verbose(class)) {
-		__raw_spin_unlock(&hash_lock);
+		graph_unlock();
 		raw_local_irq_restore(flags);
+
 		printk("\nnew class %p: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk("#%d", class->name_version);
 		printk("\n");
 		dump_stack();
+
 		raw_local_irq_save(flags);
-		__raw_spin_lock(&hash_lock);
+		if (!graph_lock()) {
+			raw_local_irq_restore(flags);
+			return NULL;
+		}
 	}
 out_unlock_set:
-	__raw_spin_unlock(&hash_lock);
+	graph_unlock();
 	raw_local_irq_restore(flags);
 
 	if (!subclass || force)
@@ -1300,19 +1341,21 @@ cache_hit:
 	 * Allocate a new chain entry from the static array, and add
 	 * it to the hash:
 	 */
-	__raw_spin_lock(&hash_lock);
+	if (!graph_lock())
+		return 0;
 	/*
 	 * We have to walk the chain again locked - to avoid duplicates:
 	 */
 	list_for_each_entry(chain, hash_head, entry) {
 		if (chain->chain_key == chain_key) {
-			__raw_spin_unlock(&hash_lock);
+			graph_unlock();
 			goto cache_hit;
 		}
 	}
 	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
-		__raw_spin_unlock(&hash_lock);
-		debug_locks_off();
+		if (!debug_locks_off_graph_unlock())
+			return 0;
+
 		printk("BUG: MAX_LOCKDEP_CHAINS too low!\n");
 		printk("turning off the locking correctness validator.\n");
 		return 0;
@@ -1388,9 +1431,7 @@ print_irq_inversion_bug(struct task_stru
 			struct held_lock *this, int forwards,
 			const char *irqclass)
 {
-	__raw_spin_unlock(&hash_lock);
-	debug_locks_off();
-	if (debug_locks_silent)
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
 	printk("\n=========================================================\n");
@@ -1479,9 +1520,7 @@ static int
 print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
-	__raw_spin_unlock(&hash_lock);
-	debug_locks_off();
-	if (debug_locks_silent)
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
 	printk("\n=================================\n");
@@ -1542,12 +1581,13 @@ static int mark_lock(struct task_struct 
 	if (likely(this->class->usage_mask & new_mask))
 		return 1;
 
-	__raw_spin_lock(&hash_lock);
+	if (!graph_lock())
+		return 0;
 	/*
 	 * Make sure we didnt race:
 	 */
 	if (unlikely(this->class->usage_mask & new_mask)) {
-		__raw_spin_unlock(&hash_lock);
+		graph_unlock();
 		return 1;
 	}
 
@@ -1738,10 +1778,10 @@ static int mark_lock(struct task_struct 
 		return 0;
 	}
 
-	__raw_spin_unlock(&hash_lock);
+	graph_unlock();
 
 	/*
-	 * We must printk outside of the hash_lock:
+	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
 		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
@@ -2139,7 +2179,7 @@ out_calc_hash:
 	 * We look up the chain_key and do the O(N^2) check and update of
 	 * the dependencies only if this is a new dependency chain.
 	 * (If lookup_chain_cache() returns with 1 it acquires
-	 * hash_lock for us)
+	 * graph_lock for us)
 	 */
 	if (!trylock && (check == 2) && lookup_chain_cache(chain_key, class)) {
 		/*
@@ -2172,7 +2212,7 @@ out_calc_hash:
 		if (!chain_head && ret != 2)
 			if (!check_prevs_add(curr, hlock))
 				return 0;
-		__raw_spin_unlock(&hash_lock);
+		graph_unlock();
 	}
 	curr->lockdep_depth++;
 	check_chain_key(curr);
@@ -2484,7 +2524,7 @@ void lockdep_free_key_range(void *start,
 	int i;
 
 	raw_local_irq_save(flags);
-	__raw_spin_lock(&hash_lock);
+	graph_lock();
 
 	/*
 	 * Unhash all classes that were created by this module:
@@ -2498,7 +2538,7 @@ void lockdep_free_key_range(void *start,
 				zap_class(class);
 	}
 
-	__raw_spin_unlock(&hash_lock);
+	graph_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -2526,20 +2566,20 @@ void lockdep_reset_lock(struct lockdep_m
 	 * Debug check: in the end all mapped classes should
 	 * be gone.
 	 */
-	__raw_spin_lock(&hash_lock);
+	graph_lock();
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
 		if (list_empty(head))
 			continue;
 		list_for_each_entry_safe(class, next, head, hash_entry) {
 			if (unlikely(class == lock->class_cache)) {
-				__raw_spin_unlock(&hash_lock);
-				DEBUG_LOCKS_WARN_ON(1);
+				if (debug_locks_off_graph_unlock())
+					WARN_ON(1);
 				goto out_restore;
 			}
 		}
 	}
-	__raw_spin_unlock(&hash_lock);
+	graph_unlock();
 
 out_restore:
 	raw_local_irq_restore(flags);
