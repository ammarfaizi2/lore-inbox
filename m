Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWIJKKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWIJKKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWIJKKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:10:39 -0400
Received: from ns1.suse.de ([195.135.220.2]:1974 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750839AbWIJKKi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:10:38 -0400
From: Andi Kleen <ak@suse.de>
To: Laurent Riffard <laurent.riffard@free.fr>, mingo@elte.hu,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Date: Sun, 10 Sep 2006 10:32:16 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <4503DC64.9070007@free.fr>
In-Reply-To: <4503DC64.9070007@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609101032.17429.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 11:35, Laurent Riffard wrote:
> Le 08.09.2006 10:13, Andrew Morton a écrit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/
> >2.6.18-rc6-mm1/
>
> Hello,
>
> This kernel won't boot here: it starts a GPFs loop on
> early boot. I attached a screenshot of the first GPF
> (pause_on_oops=120 helped).


It's lockdep's fault. This patch should fix it:

In general from my experience lockdep seems to be a dependency nightmare.
It uses far too much infrastructure far too early. Should we always disable
lockdep very early (before interrupts are turned on) instead? (early 
everything is single threaded and will never have problems with lock 
ordering)

-Andi
Hackish patch to fix lockdep with PDA current

lockdep can call current very early, so let it always use early_current
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-i386/current.h
===================================================================
--- linux.orig/include/asm-i386/current.h
+++ linux/include/asm-i386/current.h
@@ -6,6 +6,8 @@
 
 struct task_struct;
 
+#define ARCH_HAS_EARLY_CURRENT 1
+
 static __always_inline struct task_struct *early_current(void)
 {
 	return current_thread_info()->task;
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -41,6 +41,10 @@
 
 #include "lockdep_internals.h"
 
+#ifndef ARCH_HAS_EARLY_CURRENT
+#define early_current()() current
+#endif
+
 /*
  * hash_lock: protects the lockdep hashes and class/list/hash allocators.
  *
@@ -127,21 +131,21 @@ static struct list_head chainhash_table[
 
 void lockdep_off(void)
 {
-	current->lockdep_recursion++;
+	early_current()->lockdep_recursion++;
 }
 
 EXPORT_SYMBOL(lockdep_off);
 
 void lockdep_on(void)
 {
-	current->lockdep_recursion--;
+	early_current()->lockdep_recursion--;
 }
 
 EXPORT_SYMBOL(lockdep_on);
 
 int lockdep_internal(void)
 {
-	return current->lockdep_recursion != 0;
+	return early_current()->lockdep_recursion != 0;
 }
 
 EXPORT_SYMBOL(lockdep_internal);
@@ -522,7 +526,7 @@ print_circular_bug_entry(struct lock_lis
 static noinline int
 print_circular_bug_header(struct lock_list *entry, unsigned int depth)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 
 	__raw_spin_unlock(&hash_lock);
 	debug_locks_off();
@@ -547,7 +551,7 @@ print_circular_bug_header(struct lock_li
 
 static noinline int print_circular_bug_tail(void)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 	struct lock_list this;
 
 	if (debug_locks_silent)
@@ -1302,10 +1306,10 @@ cache_hit:
 	list_add_tail_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(&chain_lookup_misses);
 #ifdef CONFIG_TRACE_IRQFLAGS
-	if (current->hardirq_context)
+	if (early_current()->hardirq_context)
 		nr_hardirq_chains++;
 	else {
-		if (current->softirq_context)
+		if (early_current()->softirq_context)
 			nr_softirq_chains++;
 		else
 			nr_process_chains++;
@@ -1788,10 +1792,10 @@ void early_boot_irqs_on(void)
  */
 void trace_hardirqs_on(void)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 	unsigned long ip;
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks || early_current()->lockdep_recursion))
 		return;
 
 	if (DEBUG_LOCKS_WARN_ON(unlikely(!early_boot_irqs_enabled)))
@@ -1807,7 +1811,7 @@ void trace_hardirqs_on(void)
 
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
-	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
+	if (DEBUG_LOCKS_WARN_ON(early_current()->hardirq_context))
 		return;
 	/*
 	 * We are going to turn hardirqs on, so set the
@@ -1836,9 +1840,9 @@ EXPORT_SYMBOL(trace_hardirqs_on);
  */
 void trace_hardirqs_off(void)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks || early_current()->lockdep_recursion))
 		return;
 
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
@@ -1863,7 +1867,7 @@ EXPORT_SYMBOL(trace_hardirqs_off);
  */
 void trace_softirqs_on(unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 
 	if (unlikely(!debug_locks))
 		return;
@@ -1897,7 +1901,7 @@ void trace_softirqs_on(unsigned long ip)
  */
 void trace_softirqs_off(unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 
 	if (unlikely(!debug_locks))
 		return;
@@ -1956,7 +1960,7 @@ static int __lock_acquire(struct lockdep
 			  int trylock, int read, int check, int hardirqs_off,
 			  unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 	struct lock_class *class = NULL;
 	struct held_lock *hlock;
 	unsigned int depth, id;
@@ -1996,7 +2000,7 @@ static int __lock_acquire(struct lockdep
 	}
 
 	/*
-	 * Add the lock to the list of currently held locks.
+	 * Add the lock to the list of early_current()ly held locks.
 	 * (we dont increase the depth just yet, up until the
 	 * dependency checks are done)
 	 */
@@ -2067,7 +2071,7 @@ out_calc_hash:
 	/*
 	 * Calculate the chain hash: it's the combined has of all the
 	 * lock keys along the dependency chain. We save the hash value
-	 * at every step so that we can get the current hash easily
+	 * at every step so that we can get the early_current() hash easily
 	 * after unlock. The chain hash is then used to cache dependency
 	 * results.
 	 *
@@ -2213,7 +2217,7 @@ static int check_unlock(struct task_stru
 }
 
 /*
- * Remove the lock to the list of currently held locks in a
+ * Remove the lock to the list of early_current()ly held locks in a
  * potentially non-nested (out of order) manner. This is a
  * relatively rare operation, as all the unlock APIs default
  * to nested mode (which uses lock_release()):
@@ -2227,7 +2231,7 @@ lock_release_non_nested(struct task_stru
 	int i;
 
 	/*
-	 * Check whether the lock exists in the current stack
+	 * Check whether the lock exists in the early_current() stack
 	 * of held locks:
 	 */
 	depth = curr->lockdep_depth;
@@ -2272,10 +2276,10 @@ found_it:
 }
 
 /*
- * Remove the lock to the list of currently held locks - this gets
+ * Remove the lock to the list of early_current()ly held locks - this gets
  * called on mutex_unlock()/spin_unlock*() (or on a failed
  * mutex_lock_interruptible()). This is done for unlocks that nest
- * perfectly. (i.e. the current top of the lock-stack is unlocked)
+ * perfectly. (i.e. the early_current() top of the lock-stack is unlocked)
  */
 static int lock_release_nested(struct task_struct *curr,
 			       struct lockdep_map *lock, unsigned long ip)
@@ -2311,15 +2315,15 @@ static int lock_release_nested(struct ta
 }
 
 /*
- * Remove the lock to the list of currently held locks - this gets
+ * Remove the lock to the list of early_current()ly held locks - this gets
  * called on mutex_unlock()/spin_unlock*() (or on a failed
  * mutex_lock_interruptible()). This is done for unlocks that nest
- * perfectly. (i.e. the current top of the lock-stack is unlocked)
+ * perfectly. (i.e. the early_current() top of the lock-stack is unlocked)
  */
 static void
 __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 
 	if (!check_unlock(curr, lock, ip))
 		return;
@@ -2345,9 +2349,9 @@ static void check_flags(unsigned long fl
 		return;
 
 	if (irqs_disabled_flags(flags))
-		DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled);
+		DEBUG_LOCKS_WARN_ON(early_current()->hardirqs_enabled);
 	else
-		DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled);
+		DEBUG_LOCKS_WARN_ON(!early_current()->hardirqs_enabled);
 
 	/*
 	 * We dont accurately track softirq state in e.g.
@@ -2356,13 +2360,13 @@ static void check_flags(unsigned long fl
 	 */
 	if (!hardirq_count()) {
 		if (softirq_count())
-			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
+			DEBUG_LOCKS_WARN_ON(early_current()->softirqs_enabled);
 		else
-			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
+			DEBUG_LOCKS_WARN_ON(!early_current()->softirqs_enabled);
 	}
 
 	if (!debug_locks)
-		print_irqtrace_events(current);
+		print_irqtrace_events(early_current());
 #endif
 }
 
@@ -2375,16 +2379,16 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(early_current()->lockdep_recursion))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion = 1;
+	early_current()->lockdep_recursion = 1;
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), ip);
-	current->lockdep_recursion = 0;
+	early_current()->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 }
 
@@ -2394,14 +2398,14 @@ void lock_release(struct lockdep_map *lo
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(early_current()->lockdep_recursion))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion = 1;
+	early_current()->lockdep_recursion = 1;
 	__lock_release(lock, nested, ip);
-	current->lockdep_recursion = 0;
+	early_current()->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 }
 
@@ -2417,10 +2421,10 @@ void lockdep_reset(void)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	current->curr_chain_key = 0;
-	current->lockdep_depth = 0;
-	current->lockdep_recursion = 0;
-	memset(current->held_locks, 0, MAX_LOCK_DEPTH*sizeof(struct held_lock));
+	early_current()->curr_chain_key = 0;
+	early_current()->lockdep_depth = 0;
+	early_current()->lockdep_recursion = 0;
+	memset(early_current()->held_locks, 0, MAX_LOCK_DEPTH*sizeof(struct 
held_lock));
 	nr_hardirq_chains = 0;
 	nr_softirq_chains = 0;
 	nr_process_chains = 0;
@@ -2606,7 +2610,7 @@ print_freed_lock_bug(struct task_struct 
 void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 {
 	const void *mem_to = mem_from + mem_len, *lock_from, *lock_to;
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 	struct held_lock *hlock;
 	unsigned long flags;
 	int i;
