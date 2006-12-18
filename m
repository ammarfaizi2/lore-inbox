Return-Path: <linux-kernel-owner+w=401wt.eu-S1754094AbWLROmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbWLROmP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 09:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbWLROmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 09:42:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56078 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093AbWLROmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 09:42:14 -0500
Date: Mon, 18 Dec 2006 15:39:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] lockdep: more unlock-on-error fixes
Message-ID: <20061218143936.GA4415@elte.hu>
References: <20061218115632.GA5373@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218115632.GA5373@ff.dom.local>
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


* Jarek Poplawski <jarkao2@o2.pl> wrote:

> Hello,
> 
> If any of this proposals should be omitted or separated let me know.

thanks for the fixes, they look good to me. I have reorganized the 
__lock_acquire() changes a bit. Plus i dropped the check_locks_freed() 
changes: there's no reason lockdep should be using 'raw' irq flags 
saving - these functions are not part of the irq-flags tracing code so 
they dont /need/ to be raw.

An updated patch is below. I also have boot tested it. Andrew, Linus, 
please apply.

	Ingo

------------------------->
Subject: [patch] lockdep: more unlock-on-error fixes
From: Jarek Poplawski <jarkao2@o2.pl>

- returns after DEBUG_LOCKS_WARN_ON added in 3 places

- debug_locks checking after lookup_chain_cache()
  added in __lock_acquire()

- locking for testing and changing global variable
  max_lockdep_depth added in __lock_acquire()

Signed-off-by: Jarek Poplawski <jarkao2@o2.pl>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1297,7 +1297,8 @@ out_unlock_set:
 	if (!subclass || force)
 		lock->class_cache = class;
 
-	DEBUG_LOCKS_WARN_ON(class->subclass != subclass);
+	if (DEBUG_LOCKS_WARN_ON(class->subclass != subclass))
+		return NULL;
 
 	return class;
 }
@@ -1312,7 +1313,8 @@ static inline int lookup_chain_cache(u64
 	struct list_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return 0;
 	/*
 	 * We can walk it lock-free, because entries only get added
 	 * to the hash:
@@ -1394,7 +1396,9 @@ static void check_chain_key(struct task_
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
@@ -2210,19 +2214,24 @@ out_calc_hash:
 		if (!chain_head && ret != 2)
 			if (!check_prevs_add(curr, hlock))
 				return 0;
-		graph_unlock();
-	}
+	} else
+		/* after lookup_chain_cache(): */
+		if (unlikely(!debug_locks))
+			return 0;
+
 	curr->lockdep_depth++;
 	check_chain_key(curr);
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
-		debug_locks_off();
+		debug_locks_off_graph_unlock();
 		printk("BUG: MAX_LOCK_DEPTH too low!\n");
 		printk("turning off the locking correctness validator.\n");
 		return 0;
 	}
+
 	if (unlikely(curr->lockdep_depth > max_lockdep_depth))
 		max_lockdep_depth = curr->lockdep_depth;
 
+	graph_unlock();
 	return 1;
 }
 
