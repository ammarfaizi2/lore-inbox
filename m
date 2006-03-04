Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWCDAut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWCDAut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWCDAut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:50:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59324 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751466AbWCDAus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:50:48 -0500
Date: Fri, 3 Mar 2006 16:50:35 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       Pekka Enberg <penberg@gmail.com>
Subject: Make drain_array more universal by adding more parameters
In-Reply-To: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0603031649340.15966@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And a parameter to drain_array to control the freeing of all objects
and then use drain_array() to replace instances of drain_array_locked
with drain_array. Doing so will avoid taking locks in those locations
if the arrays are empty.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/mm/slab.c	2006-03-03 16:14:49.000000000 -0800
+++ linux-2.6.16-rc5-mm2/mm/slab.c	2006-03-03 16:21:48.000000000 -0800
@@ -2128,6 +2128,10 @@ static void check_spinlock_acquired_node
 static void drain_array_locked(struct kmem_cache *cachep,
 			struct array_cache *ac, int force, int node);
 
+static void drain_array(struct kmem_cache *cachep, struct kmem_list3 *l3,
+			struct array_cache *ac,
+			int force, int node);
+
 static void do_drain(void *arg)
 {
 	struct kmem_cache *cachep = arg;
@@ -2152,9 +2156,7 @@ static void drain_cpu_caches(struct kmem
 	for_each_online_node(node) {
 		l3 = cachep->nodelists[node];
 		if (l3) {
-			spin_lock_irq(&l3->list_lock);
-			drain_array_locked(cachep, l3->shared, 1, node);
-			spin_unlock_irq(&l3->list_lock);
+			drain_array(cachep, l3, l3->shared, 1, node);
 			if (l3->alien)
 				drain_alien_cache(cachep, l3->alien);
 		}
@@ -3578,12 +3579,11 @@ static void drain_array_locked(struct km
  * necessary.
  */
 void drain_array(struct kmem_cache *searchp, struct kmem_list3 *l3,
-					 struct array_cache *ac)
+			 struct array_cache *ac, int force, int node)
 {
 	if (ac && ac->avail) {
 		spin_lock_irq(&l3->list_lock);
-		drain_array_locked(searchp, ac, 0,
-				   numa_node_id());
+		drain_array_locked(searchp, ac, force, node);
 		spin_unlock_irq(&l3->list_lock);
 	}
 }
@@ -3604,6 +3604,7 @@ static void cache_reap(void *unused)
 {
 	struct list_head *walk;
 	struct kmem_list3 *l3;
+	int node = numa_node_id();
 
 	if (!mutex_trylock(&cache_chain_mutex)) {
 		/* Give up. Setup the next iteration. */
@@ -3626,11 +3627,11 @@ static void cache_reap(void *unused)
 		 * have established with reasonable certainty that
 		 * we can do some work if the lock was obtained.
 		 */
-		l3 = searchp->nodelists[numa_node_id()];
+		l3 = searchp->nodelists[node];
 
 		reap_alien(searchp, l3);
 
-		drain_array(searchp, l3, cpu_cache_get(searchp));
+		drain_array(searchp, l3, cpu_cache_get(searchp), 0, node);
 
 		/*
 		 * These are racy checks but it does not matter
@@ -3641,7 +3642,7 @@ static void cache_reap(void *unused)
 
 		l3->next_reap = jiffies + REAPTIMEOUT_LIST3;
 
-		drain_array(searchp, l3, l3->shared);
+		drain_array(searchp, l3, l3->shared, 0, node);
 
 		if (l3->free_touched) {
 			l3->free_touched = 0;
