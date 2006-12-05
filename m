Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937496AbWLELcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937496AbWLELcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937512AbWLELcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:32:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44588 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937496AbWLELcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:32:11 -0500
Date: Tue, 5 Dec 2006 12:31:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] lockdep: register_lock_class() fix
Message-ID: <20061205113102.GA23191@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: register_lock_class() fix
From: Ingo Molnar <mingo@elte.hu>

the hash_lock must only ever be taken with irqs disabled. This happens 
in all the important places, except one codepath: register_lock_class(). 
The race should trigger rarely because register_lock_class() is quite 
rare and single-threaded (happens during init most of the time).

The fix is to disable irqs.

( bug found live in -rt: there preemption is alot more agressive and
  preempting with the hash-lock held caused a lockup.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-mm-genapic.q/kernel/lockdep.c
===================================================================
--- linux-mm-genapic.q.orig/kernel/lockdep.c
+++ linux-mm-genapic.q/kernel/lockdep.c
@@ -1183,6 +1183,7 @@ register_lock_class(struct lockdep_map *
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
 	struct lock_class *class;
+	unsigned long flags;
 
 	class = look_up_lock_class(lock, subclass);
 	if (likely(class))
@@ -1204,6 +1205,7 @@ register_lock_class(struct lockdep_map *
 	key = lock->key->subkeys + subclass;
 	hash_head = classhashentry(key);
 
+	raw_local_irq_save(flags);
 	__raw_spin_lock(&hash_lock);
 	/*
 	 * We have to do the hash-walk again, to avoid races
@@ -1218,6 +1220,7 @@ register_lock_class(struct lockdep_map *
 	 */
 	if (nr_lock_classes >= MAX_LOCKDEP_KEYS) {
 		__raw_spin_unlock(&hash_lock);
+		raw_local_irq_restore(flags);
 		debug_locks_off();
 		printk("BUG: MAX_LOCKDEP_KEYS too low!\n");
 		printk("turning off the locking correctness validator.\n");
@@ -1240,15 +1243,18 @@ register_lock_class(struct lockdep_map *
 
 	if (verbose(class)) {
 		__raw_spin_unlock(&hash_lock);
+		raw_local_irq_restore(flags);
 		printk("\nnew class %p: %s", class->key, class->name);
 		if (class->name_version > 1)
 			printk("#%d", class->name_version);
 		printk("\n");
 		dump_stack();
+		raw_local_irq_save(flags);
 		__raw_spin_lock(&hash_lock);
 	}
 out_unlock_set:
 	__raw_spin_unlock(&hash_lock);
+	raw_local_irq_restore(flags);
 
 	if (!subclass || force)
 		lock->class_cache = class;
