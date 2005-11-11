Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVKKAFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVKKAFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKKAFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:05:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54708 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932257AbVKKAFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:05:22 -0500
Message-ID: <4373E03F.6060302@us.ibm.com>
Date: Thu, 10 Nov 2005 16:05:19 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] Cleanup cache_reap()
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060804000903010100010008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060804000903010100010008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cache_reap() could also use a little love.  Here's a patch to clean it up.

-Matt

--------------060804000903010100010008
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

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:48:47.540627688 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:48:49.384347400 -0800
@@ -3302,45 +3302,32 @@ static void drain_array_locked(kmem_cach
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
-				   numa_node_id());
+		drain_array_locked(searchp, ac_data(searchp), 0, nid);
 
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
-
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
 
 		if (l3->shared)
-			drain_array_locked(searchp, l3->shared, 0,
-					   numa_node_id());
+			drain_array_locked(searchp, l3->shared, 0, nid);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
@@ -3350,7 +3337,9 @@ static void cache_reap(void *unused)
 		tofree = 5 * searchp->num;
 		tofree = (l3->free_limit + tofree - 1) / tofree;
 		do {
-			p = l3->slabs_free.next;
+			struct list_head *p = l3->slabs_free.next;
+			struct slab *slabp;
+
 			if (p == &(l3->slabs_free))
 				break;
 
@@ -3377,6 +3366,7 @@ next:
 	check_irq_on();
 	up(&cache_chain_sem);
 	drain_remote_pages();
+out:
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work),
 			      REAPTIMEOUT_CPUC + smp_processor_id());

--------------060804000903010100010008--
