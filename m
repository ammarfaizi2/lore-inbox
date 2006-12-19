Return-Path: <linux-kernel-owner+w=401wt.eu-S932732AbWLSJxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWLSJxa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWLSJxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:53:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38598 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932732AbWLSJx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:53:29 -0500
Date: Tue, 19 Dec 2006 10:50:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] lockdep: more unlock-on-error fixes, fix
Message-ID: <20061219095047.GA2694@elte.hu>
References: <20061218115632.GA5373@ff.dom.local> <20061218143936.GA4415@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218143936.GA4415@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> An updated patch is below. I also have boot tested it. Andrew, Linus, 
> please apply.

this patch introduced a locking bug, which is fixed by the delta patch 
below.

	Ingo

------------------------>
Subject: [patch] lockdep: more unlock-on-error fixes, fix
From: Ingo Molnar <mingo@elte.hu>

my __acquire_lock() cleanup introduced a locking bug: on SMP
systems we'd release a non-owned graph lock. Fix this by
moving the graph unlock back, and by leaving the max_lockdep_depth
variable update possibly racy. (we dont care, it's just statistics)

also add some minimal debugging code to graph_unlock()/graph_lock(), 
which caught this locking bug.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -70,6 +70,9 @@ static int graph_lock(void)
 
 static inline int graph_unlock(void)
 {
+	if (debug_locks && !__raw_spin_is_locked(&lockdep_lock))
+		return DEBUG_LOCKS_WARN_ON(1);
+
 	__raw_spin_unlock(&lockdep_lock);
 	return 0;
 }
@@ -716,6 +719,9 @@ find_usage_backwards(struct lock_class *
 	struct lock_list *entry;
 	int ret;
 
+	if (!__raw_spin_is_locked(&lockdep_lock))
+		return DEBUG_LOCKS_WARN_ON(1);
+
 	if (depth > max_recursion_depth)
 		max_recursion_depth = depth;
 	if (depth >= RECURSION_LIMIT)
@@ -2208,6 +2214,7 @@ out_calc_hash:
 		if (!chain_head && ret != 2)
 			if (!check_prevs_add(curr, hlock))
 				return 0;
+		graph_unlock();
 	} else
 		/* after lookup_chain_cache(): */
 		if (unlikely(!debug_locks))
@@ -2216,7 +2223,7 @@ out_calc_hash:
 	curr->lockdep_depth++;
 	check_chain_key(curr);
 	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
-		debug_locks_off_graph_unlock();
+		debug_locks_off();
 		printk("BUG: MAX_LOCK_DEPTH too low!\n");
 		printk("turning off the locking correctness validator.\n");
 		return 0;
@@ -2225,7 +2232,6 @@ out_calc_hash:
 	if (unlikely(curr->lockdep_depth > max_lockdep_depth))
 		max_lockdep_depth = curr->lockdep_depth;
 
-	graph_unlock();
 	return 1;
 }
 
