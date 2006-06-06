Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWFFHzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWFFHzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWFFHzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:55:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36004 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932128AbWFFHzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:55:10 -0400
Date: Tue, 6 Jun 2006 09:54:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm3] lock validator: add CONFIG_DEBUG_NON_NESTED_UNLOCKS
Message-ID: <20060606075434.GA32506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Subject: lock validator: add CONFIG_DEBUG_NON_NESTED_UNLOCKS
From: Ingo Molnar <mingo@elte.hu>

add CONFIG_DEBUG_NON_NESTED_UNLOCKS: if enabled then a non-alarming
message about out of order unlocks is printed. If disabled then we
fall back to the non-nested unlock method automatically, without
printing a message and stopping the validator.

defaults to disabled. Tested with the option both on and off.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c       |   90 ++++++++++++++++++++++++++++---------------------
 lib/Kconfig.debug      |   13 +++++++
 lib/locking-selftest.c |   14 +++++++
 3 files changed, 79 insertions(+), 38 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -2199,6 +2199,8 @@ static int __lockdep_acquire(struct lock
 	return 1;
 }
 
+#ifdef CONFIG_DEBUG_NON_NESTED_UNLOCKS
+
 static int
 print_unlock_order_bug(struct task_struct *curr, struct lockdep_map *lock,
 		       struct held_lock *hlock, unsigned long ip)
@@ -2207,9 +2209,10 @@ print_unlock_order_bug(struct task_struc
 	if (debug_locks_silent)
 		return 0;
 
-	printk("\n======================================\n");
-	printk(  "[ BUG: bad unlock ordering detected! ]\n");
-	printk(  "--------------------------------------\n");
+	printk("\n=======================================\n");
+	printk(  "[ INFO: bad unlock ordering detected. ]\n");
+	printk(  "---------------------------------------\n");
+	printk("The code is fine but needs lock validator annotation.\n");
 	printk("%s/%d is trying to release lock (",
 		curr->comm, curr->pid);
 	print_lockdep_cache(lock);
@@ -2226,6 +2229,8 @@ print_unlock_order_bug(struct task_struc
 	return 0;
 }
 
+#endif /* CONFIG_DEBUG_NON_NESTED_UNLOCKS */
+
 static int
 print_unlock_inbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
 			   unsigned long ip)
@@ -2270,41 +2275,6 @@ static int check_unlock(struct task_stru
 }
 
 /*
- * Remove the lock to the list of currently held locks - this gets
- * called on mutex_unlock()/spin_unlock*() (or on a failed
- * mutex_lock_interruptible()). This is done for unlocks that nest
- * perfectly. (i.e. the current top of the lock-stack is unlocked)
- */
-static int lockdep_release_nested(struct task_struct *curr,
-				  struct lockdep_map *lock, unsigned long ip)
-{
-	struct held_lock *hlock;
-	unsigned int depth;
-
-	/*
-	 * Pop off the top of the lock stack:
-	 */
-	depth = --curr->lockdep_depth;
-	hlock = curr->held_locks + depth;
-
-	if (hlock->instance != lock)
-		return print_unlock_order_bug(curr, lock, hlock, ip);
-
-	if (DEBUG_WARN_ON(!depth && (hlock->prev_chain_key != 0)))
-		return 0;
-
-	curr->curr_chain_key = hlock->prev_chain_key;
-
-#ifdef CONFIG_DEBUG_LOCKDEP
-	hlock->prev_chain_key = 0;
-	hlock->type = NULL;
-	hlock->acquire_ip = 0;
-	hlock->irq_context = 0;
-#endif
-	return 1;
-}
-
-/*
  * Remove the lock to the list of currently held locks in a
  * potentially non-nested (out of order) manner. This is a
  * relatively rare operation, as all the unlock APIs default
@@ -2369,6 +2339,50 @@ found_it:
  * mutex_lock_interruptible()). This is done for unlocks that nest
  * perfectly. (i.e. the current top of the lock-stack is unlocked)
  */
+static int lockdep_release_nested(struct task_struct *curr,
+				  struct lockdep_map *lock, unsigned long ip)
+{
+	struct held_lock *hlock;
+	unsigned int depth;
+
+	/*
+	 * Pop off the top of the lock stack:
+	 */
+	depth = curr->lockdep_depth - 1;
+	hlock = curr->held_locks + depth;
+
+	/*
+	 * Is the unlock non-nested:
+	 */
+	if (hlock->instance != lock) {
+#ifdef CONFIG_DEBUG_NON_NESTED_UNLOCKS
+		return print_unlock_order_bug(curr, lock, hlock, ip);
+#else
+		return lockdep_release_non_nested(curr, lock, ip);
+#endif
+	}
+	curr->lockdep_depth--;
+
+	if (DEBUG_WARN_ON(!depth && (hlock->prev_chain_key != 0)))
+		return 0;
+
+	curr->curr_chain_key = hlock->prev_chain_key;
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+	hlock->prev_chain_key = 0;
+	hlock->type = NULL;
+	hlock->acquire_ip = 0;
+	hlock->irq_context = 0;
+#endif
+	return 1;
+}
+
+/*
+ * Remove the lock to the list of currently held locks - this gets
+ * called on mutex_unlock()/spin_unlock*() (or on a failed
+ * mutex_lock_interruptible()). This is done for unlocks that nest
+ * perfectly. (i.e. the current top of the lock-stack is unlocked)
+ */
 static void __lockdep_release(struct lockdep_map *lock, int nested,
 			      unsigned long ip)
 {
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -361,6 +361,19 @@ config LOCKDEP
 	select KALLSYMS_ALL
 	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
 
+config DEBUG_NON_NESTED_UNLOCKS
+	bool "Detect non-nested unlocks"
+	depends on LOCKDEP
+	help
+	  If you say Y here, the lock dependency engine will do
+	  additional runtime checks to detect and print non-nested
+	  unlocks.
+	  Non-nested unlocks are valid uses of the kernel's locking
+	  APIs, but they cause more overhead for the validator, and
+	  they can also be a sign for locking bugs or suboptimal
+	  locking, so it's not a bad idea to annotate and thus
+	  document those places.
+
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on LOCKDEP
Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -1027,6 +1027,16 @@ static inline void print_testname(const 
 	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
 	printk("\n");
 
+#define DO_TESTCASE_6_SUCCESS(desc, name)			\
+	print_testname(desc);					\
+	dotest(name##_spin, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(name##_wlock, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(name##_rlock, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(name##_mutex, SUCCESS, LOCKTYPE_MUTEX);		\
+	dotest(name##_wsem, SUCCESS, LOCKTYPE_RWSEM);		\
+	dotest(name##_rsem, SUCCESS, LOCKTYPE_RWSEM);		\
+	printk("\n");
+
 /*
  * 'read' variant: rlocks must not trigger.
  */
@@ -1129,7 +1139,11 @@ void locking_selftest(void)
 	DO_TESTCASE_6R("A-B-C-D-B-D-D-A deadlock", ABCDBDDA);
 	DO_TESTCASE_6R("A-B-C-D-B-C-D-A deadlock", ABCDBCDA);
 	DO_TESTCASE_6("double unlock", double_unlock);
+#ifdef CONFIG_DEBUG_NON_NESTED_UNLOCKS
 	DO_TESTCASE_6("bad unlock order", bad_unlock_order);
+#else
+	DO_TESTCASE_6_SUCCESS("bad unlock order", bad_unlock_order);
+#endif
 
 	printk("  --------------------------------------------------------------------------\n");
 	print_testname("recursive read-lock");
