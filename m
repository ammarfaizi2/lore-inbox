Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWGEI5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWGEI5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWGEI5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:57:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36549 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932375AbWGEI5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:57:07 -0400
Date: Wed, 5 Jul 2006 10:52:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [patch] lockdep: core, reduce per-lock class-cache size
Message-ID: <20060705085229.GA8918@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5007]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lockdep: core, reduce per-lock class-cache size
From: Ingo Molnar <mingo@elte.hu>

lockdep_map is embedded into every lock, which blows up data structure
sizes all around the kernel. Reduce the class-cache to be for the
default class only - that is used in 99.9% of the cases and even if
we dont have a class cached, the lookup in the class-hash is lockless.

this change reduces the per-lock dep_map overhead by 56 bytes on 64-bit
platforms and by 28 bytes on 32-bit platforms.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h |    2 -
 kernel/lockdep.c        |   87 +++++++++++++++++++++++++++++-------------------
 2 files changed, 55 insertions(+), 34 deletions(-)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -120,7 +120,7 @@ struct lock_class {
  */
 struct lockdep_map {
 	struct lock_class_key		*key;
-	struct lock_class		*class[MAX_LOCKDEP_SUBCLASSES];
+	struct lock_class		*class_cache;
 	const char			*name;
 };
 
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1104,7 +1104,7 @@ extern void __error_too_big_MAX_LOCKDEP_
  * itself, so actual lookup of the hash should be once per lock object.
  */
 static inline struct lock_class *
-register_lock_class(struct lockdep_map *lock, unsigned int subclass)
+look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
@@ -1148,7 +1148,26 @@ register_lock_class(struct lockdep_map *
 	 */
 	list_for_each_entry(class, hash_head, hash_entry)
 		if (class->key == key)
-			goto out_set;
+			return class;
+
+	return NULL;
+}
+
+/*
+ * Register a lock's class in the hash-table, if the class is not present
+ * yet. Otherwise we look it up. We cache the result in the lock object
+ * itself, so actual lookup of the hash should be once per lock object.
+ */
+static inline struct lock_class *
+register_lock_class(struct lockdep_map *lock, unsigned int subclass)
+{
+	struct lockdep_subclass_key *key;
+	struct list_head *hash_head;
+	struct lock_class *class;
+
+	class = look_up_lock_class(lock, subclass);
+	if (likely(class))
+		return class;
 
 	/*
 	 * Debug-check: all keys must be persistent!
@@ -1163,6 +1182,9 @@ register_lock_class(struct lockdep_map *
 		return NULL;
 	}
 
+	key = lock->key->subkeys + subclass;
+	hash_head = classhashentry(key);
+
 	__raw_spin_lock(&hash_lock);
 	/*
 	 * We have to do the hash-walk again, to avoid races
@@ -1209,8 +1231,8 @@ register_lock_class(struct lockdep_map *
 out_unlock_set:
 	__raw_spin_unlock(&hash_lock);
 
-out_set:
-	lock->class[subclass] = class;
+	if (!subclass)
+		lock->class_cache = class;
 
 	DEBUG_LOCKS_WARN_ON(class->subclass != subclass);
 
@@ -1914,7 +1936,7 @@ void lockdep_init_map(struct lockdep_map
 	}
 	lock->name = name;
 	lock->key = key;
-	memset(lock->class, 0, sizeof(lock->class[0])*MAX_LOCKDEP_SUBCLASSES);
+	lock->class_cache = NULL;
 }
 
 EXPORT_SYMBOL_GPL(lockdep_init_map);
@@ -1928,8 +1950,8 @@ static int __lock_acquire(struct lockdep
 			  unsigned long ip)
 {
 	struct task_struct *curr = current;
+	struct lock_class *class = NULL;
 	struct held_lock *hlock;
-	struct lock_class *class;
 	unsigned int depth, id;
 	int chain_head = 0;
 	u64 chain_key;
@@ -1947,8 +1969,11 @@ static int __lock_acquire(struct lockdep
 		return 0;
 	}
 
-	class = lock->class[subclass];
-	/* not cached yet? */
+	if (!subclass)
+		class = lock->class_cache;
+	/*
+	 * Not cached yet or subclass?
+	 */
 	if (unlikely(!class)) {
 		class = register_lock_class(lock, subclass);
 		if (!class)
@@ -2449,48 +2474,44 @@ void lockdep_free_key_range(void *start,
 
 void lockdep_reset_lock(struct lockdep_map *lock)
 {
-	struct lock_class *class, *next, *entry;
+	struct lock_class *class, *next;
 	struct list_head *head;
 	unsigned long flags;
 	int i, j;
 
 	raw_local_irq_save(flags);
-	__raw_spin_lock(&hash_lock);
 
 	/*
-	 * Remove all classes this lock has:
+	 * Remove all classes this lock might have:
 	 */
+	for (j = 0; j < MAX_LOCKDEP_SUBCLASSES; j++) {
+		/*
+		 * If the class exists we look it up and zap it:
+		 */
+		class = look_up_lock_class(lock, j);
+		if (class)
+			zap_class(class);
+	}
+	/*
+	 * Debug check: in the end all mapped classes should
+	 * be gone.
+	 */
+	__raw_spin_lock(&hash_lock);
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
 		if (list_empty(head))
 			continue;
 		list_for_each_entry_safe(class, next, head, hash_entry) {
-			for (j = 0; j < MAX_LOCKDEP_SUBCLASSES; j++) {
-				entry = lock->class[j];
-				if (class == entry) {
-					zap_class(class);
-					lock->class[j] = NULL;
-					break;
-				}
+			if (unlikely(class == lock->class_cache)) {
+				__raw_spin_unlock(&hash_lock);
+				DEBUG_LOCKS_WARN_ON(1);
+				goto out_restore;
 			}
 		}
 	}
-
-	/*
-	 * Debug check: in the end all mapped classes should
-	 * be gone.
-	 */
-	for (j = 0; j < MAX_LOCKDEP_SUBCLASSES; j++) {
-		entry = lock->class[j];
-		if (!entry)
-			continue;
-		__raw_spin_unlock(&hash_lock);
-		DEBUG_LOCKS_WARN_ON(1);
-		raw_local_irq_restore(flags);
-		return;
-	}
-
 	__raw_spin_unlock(&hash_lock);
+
+out_restore:
 	raw_local_irq_restore(flags);
 }
 
