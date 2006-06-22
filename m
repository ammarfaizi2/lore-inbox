Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbWFVXek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbWFVXek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWFVXek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:34:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:41187 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932675AbWFVXej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:34:39 -0400
Date: Thu, 22 Jun 2006 16:35:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, johnstul@us.ibm.com,
       tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: [PATCH -rt] NUMA-Q fix to __cache_free and reap_alien
Message-ID: <20060622233512.GA2792@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The attached patch (no doubt quite crudely) fixes a couple of compiler
errors on NUMA-Q machines.  With these fixes, 2.6.17-rt1 builds, boots,
and runs kernelbench and LTP on NUMA-Q.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 slab.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-rt1/mm/slab.c linux-2.6.17-rt1-alienfix/mm/slab.c
--- linux-2.6.17-rt1/mm/slab.c	2006-06-22 14:12:08.000000000 -0700
+++ linux-2.6.17-rt1-alienfix/mm/slab.c	2006-06-22 14:45:56.000000000 -0700
@@ -1058,13 +1058,14 @@ static void
 reap_alien(struct kmem_cache *cachep, struct kmem_list3 *l3, int *this_cpu)
 {
 	int node = per_cpu(reap_node, *this_cpu);
+	unsigned long flags;
 
 	if (l3->alien) {
 		struct array_cache *ac = l3->alien[node];
 
-		if (ac && ac->avail && spin_trylock_irq(&ac->lock)) {
+		if (ac && ac->avail && spin_trylock_irqsave(&ac->lock, flags)) {
 			__drain_alien_cache(cachep, ac, node, this_cpu);
-			spin_unlock_irq(&ac->lock);
+			spin_unlock_irqrestore(&ac->lock, flags);
 		}
 	}
 }
@@ -3242,15 +3243,15 @@ __cache_free(struct kmem_cache *cachep, 
 				spin_lock(&alien->lock);
 				if (unlikely(alien->avail == alien->limit)) {
 					STATS_INC_ACOVERFLOW(cachep);
-					__drain_alien_cache(cachep,
-							    alien, nodeid);
+					__drain_alien_cache(cachep, alien,
+							    nodeid, this_cpu);
 				}
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
 					  list_lock);
-				free_block(cachep, &objp, 1, nodeid);
+				free_block(cachep, &objp, 1, nodeid, this_cpu);
 				spin_unlock(&(cachep->nodelists[nodeid])->
 					    list_lock);
 			}
