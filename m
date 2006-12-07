Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968789AbWLGJXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968789AbWLGJXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968824AbWLGJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:23:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47226 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968789AbWLGJXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:23:17 -0500
Date: Thu, 7 Dec 2006 10:21:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] lockdep: improve verbose messages
Message-ID: <20061207092142.GA32691@elte.hu>
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

Subject: [patch] lockdep: improve verbose messages
From: Ingo Molnar <mingo@elte.hu>

make verbose lockdep messages (off by default) more informative
by printing out the hash chain key. (this patch was what helped
me catch the earlier lockdep hash-collision bug)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1266,7 +1266,7 @@ out_unlock_set:
  * add it and return 0 - in this case the new dependency chain is
  * validated. If the key is already hashed, return 1.
  */
-static inline int lookup_chain_cache(u64 chain_key)
+static inline int lookup_chain_cache(u64 chain_key, struct lock_class *class)
 {
 	struct list_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
@@ -1288,9 +1288,13 @@ cache_hit:
 			__raw_spin_lock(&hash_lock);
 			return 1;
 #endif
+			if (very_verbose(class))
+				printk("\nhash chain already cached, key: %016Lx tail class: [%p] %s\n", chain_key, class->key, class->name);
 			return 0;
 		}
 	}
+	if (very_verbose(class))
+		printk("\nnew hash chain, key: %016Lx tail class: [%p] %s\n", chain_key, class->key, class->name);
 	/*
 	 * Allocate a new chain entry from the static array, and add
 	 * it to the hash:
@@ -2140,7 +2144,7 @@ out_calc_hash:
 	 * (If lookup_chain_cache() returns with 1 it acquires
 	 * hash_lock for us)
 	 */
-	if (!trylock && (check == 2) && lookup_chain_cache(chain_key)) {
+	if (!trylock && (check == 2) && lookup_chain_cache(chain_key, class)) {
 		/*
 		 * Check whether last held lock:
 		 *
