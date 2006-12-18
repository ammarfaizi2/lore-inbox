Return-Path: <linux-kernel-owner+w=401wt.eu-S1753891AbWLRLze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbWLRLze (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 06:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbWLRLze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 06:55:34 -0500
Received: from poczta.o2.pl ([193.17.41.142]:40175 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753891AbWLRLze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 06:55:34 -0500
Date: Mon, 18 Dec 2006 12:56:32 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] lockdep: returns after DEBUG_LOCKS_WARN_ONs etc.
Message-ID: <20061218115632.GA5373@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If any of this proposals should be omitted or separated
let me know. 

Regards,
Jarek P.

---
[PATCH] lockdep: returns after DEBUG_LOCKS_WARN_ONs etc. 

lockdep.c changes:

- returns after DEBUG_LOCKS_WARN_ON added in 3 places

- debug_locks checking after lookup_chain_cache()
  added in __lock_acquire()

- locking for testing and changing global variable
  max_lockdep_depth added in __lock_acquire()

- local_irq_save/restore() replaced by raw versions
  in debug_check_no_locks_freed()

Signed-off-by: Jarek Poplawski <jarkao2@o2.pl>
---

diff -Nurp linux-2.6.20-rc1-/kernel/lockdep.c linux-2.6.20-rc1/kernel/lockdep.c
--- linux-2.6.20-rc1-/kernel/lockdep.c	2006-12-18 08:59:24.000000000 +0100
+++ linux-2.6.20-rc1/kernel/lockdep.c	2006-12-18 11:57:40.000000000 +0100
@@ -1293,7 +1293,8 @@ out_unlock_set:
 	if (!subclass || force)
 		lock->class_cache = class;
 
-	DEBUG_LOCKS_WARN_ON(class->subclass != subclass);
+	if (DEBUG_LOCKS_WARN_ON(class->subclass != subclass))
+		return NULL;
 
 	return class;
 }
@@ -1308,7 +1309,8 @@ static inline int lookup_chain_cache(u64
 	struct list_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return 0;
 	/*
 	 * We can walk it lock-free, because entries only get added
 	 * to the hash:
@@ -1390,7 +1392,9 @@ static void check_chain_key(struct task_
 			return;
 		}
 		id = hlock->class - lock_classes;
-		DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS);
+		if (DEBUG_LOCKS_WARN_ON(id >= MAX_LOCKDEP_KEYS))
+			return;
+
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = 0;
@@ -2201,7 +2205,11 @@ out_calc_hash:
 			if (!check_prevs_add(curr, hlock))
 				return 0;
 		graph_unlock();
-	}
+
+	} else if (unlikely(!debug_locks))
+		/* after lookup_chain_cache() */
+		return 0;
+
 	curr->lockdep_depth++;
 	check_chain_key(curr);
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
@@ -2210,9 +2218,14 @@ out_calc_hash:
 		printk("turning off the locking correctness validator.\n");
 		return 0;
 	}
+
+	if (!graph_lock())
+		return 0;
+
 	if (unlikely(curr->lockdep_depth > max_lockdep_depth))
 		max_lockdep_depth = curr->lockdep_depth;
 
+	graph_unlock();
 	return 1;
 }
 
@@ -2665,7 +2678,7 @@ void debug_check_no_locks_freed(const vo
 	if (unlikely(!debug_locks))
 		return;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
 
@@ -2679,7 +2692,7 @@ void debug_check_no_locks_freed(const vo
 		print_freed_lock_bug(curr, mem_from, mem_to, hlock);
 		break;
 	}
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 
