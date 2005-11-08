Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVKHAz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVKHAz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVKHAz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:55:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:56222 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964951AbVKHAz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:55:56 -0500
Message-ID: <436FF797.2070407@us.ibm.com>
Date: Mon, 07 Nov 2005 16:55:51 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] Cleanup cache_reap()
References: <436FF51D.8080509@us.ibm.com>
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050201060402090603080508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050201060402090603080508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Cleanup cache_reap().

Note, I did not include the change to remove the '+ smp_processor_id()'
from the schedule_delayed_work() calls.  This may cause rejects, which I,
or any sane person :), can trivially resolve.

mcd@arrakis:~/linux/source/linux-2.6.14+slab_cleanup/patches $ diffstat
cache_reap.patch
 slab.c |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

-Matt

--------------050201060402090603080508
Content-Type: text/x-patch;
 name="cache_reap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache_reap.patch"

General readability fixes.

* Goto to end of function instead of duplicating code in case of 
     failure to grab cache_chain_sem.
* Replace a list_for_each/list_entry combo with an identical but
     more readable list_for_each_entry loop.
* Move the declaration of a variables not referenced outside of
     certain loops inside those loops.
* Store the numa_node_id() in a local variable.

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-07 15:58:50.495474952 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-07 15:59:14.091887752 -0800
@@ -3282,45 +3282,32 @@ static void drain_array_locked(kmem_cach
  */
 static void cache_reap(void *unused)
 {
-	struct list_head *walk;
-	struct kmem_list3 *l3;
-
-	if (down_trylock(&cache_chain_sem)) {
-		/* Give up. Setup the next iteration. */
-		schedule_delayed_work(&__get_cpu_var(reap_work),
-				      REAPTIMEOUT_CPUC + smp_processor_id());
-		return;
-	}
+	kmem_cache_t *searchp;
 
-	list_for_each(walk, &cache_chain) {
-		kmem_cache_t *searchp;
-		struct list_head* p;
-		int tofree;
-		struct slab *slabp;
+	if (down_trylock(&cache_chain_sem))
+		goto out;
 
-		searchp = list_entry(walk, kmem_cache_t, next);
+	list_for_each_entry(searchp, &cache_chain, next) {
+		struct kmem_list3 *l3;
+		int tofree, nid = numa_node_id();
 
 		if (searchp->flags & SLAB_NO_REAP)
 			goto next;
 
 		check_irq_on();
-
-		l3 = searchp->nodelists[numa_node_id()];
+		l3 = searchp->nodelists[nid];
 		if (l3->alien)
 			drain_alien_cache(searchp, l3);
 		spin_lock_irq(&l3->list_lock);
 
-		drain_array_locked(searchp, ac_data(searchp), 0,
-				numa_node_id());
+		drain_array_locked(searchp, ac_data(searchp), 0, nid);
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
-
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
 
 		if (l3->shared)
-			drain_array_locked(searchp, l3->shared, 0,
-				numa_node_id());
+			drain_array_locked(searchp, l3->shared, 0, nid);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
@@ -3330,7 +3317,9 @@ static void cache_reap(void *unused)
 		tofree = 5 * searchp->num;
 		tofree = (l3->free_limit + tofree - 1) / tofree;
 		do {
-			p = l3->slabs_free.next;
+			struct list_head *p = l3->slabs_free.next;
+			struct slab *slabp;
+
 			if (p == &(l3->slabs_free))
 				break;
 
@@ -3357,6 +3346,7 @@ next:
 	check_irq_on();
 	up(&cache_chain_sem);
 	drain_remote_pages();
+out:
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work),
 			      REAPTIMEOUT_CPUC + smp_processor_id());

--------------050201060402090603080508--
