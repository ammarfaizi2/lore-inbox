Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWBCLOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWBCLOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWBCLOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:14:43 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:17811 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932354AbWBCLOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:14:43 -0500
Date: Fri, 3 Feb 2006 13:14:40 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [PATCH] slab: extract setup_cpu_cache
Message-ID: <Pine.LNX.4.58.0602031313100.19820@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch extracts setup_cpu_cache() function from kmem_cache_create() to
make the latter a little less complex.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 mm/slab.c |  113 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 59 insertions(+), 54 deletions(-)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -1610,6 +1610,64 @@ static inline size_t calculate_slab_orde
 	return left_over;
 }
 
+static void setup_cpu_cache(struct kmem_cache *cachep)
+{
+	if (g_cpucache_up == FULL) {
+		enable_cpucache(cachep);
+	} else {
+		if (g_cpucache_up == NONE) {
+			/* Note: the first kmem_cache_create must create
+			 * the cache that's used by kmalloc(24), otherwise
+			 * the creation of further caches will BUG().
+			 */
+			cachep->array[smp_processor_id()] =
+			    &initarray_generic.cache;
+
+			/* If the cache that's used by
+			 * kmalloc(sizeof(kmem_list3)) is the first cache,
+			 * then we need to set up all its list3s, otherwise
+			 * the creation of further caches will BUG().
+			 */
+			set_up_list3s(cachep, SIZE_AC);
+			if (INDEX_AC == INDEX_L3)
+				g_cpucache_up = PARTIAL_L3;
+			else
+				g_cpucache_up = PARTIAL_AC;
+		} else {
+			cachep->array[smp_processor_id()] =
+			    kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+
+			if (g_cpucache_up == PARTIAL_AC) {
+				set_up_list3s(cachep, SIZE_L3);
+				g_cpucache_up = PARTIAL_L3;
+			} else {
+				int node;
+				for_each_online_node(node) {
+
+					cachep->nodelists[node] =
+					    kmalloc_node(sizeof
+							 (struct kmem_list3),
+							 GFP_KERNEL, node);
+					BUG_ON(!cachep->nodelists[node]);
+					kmem_list3_init(cachep->
+							nodelists[node]);
+				}
+			}
+		}
+		cachep->nodelists[numa_node_id()]->next_reap =
+		    jiffies + REAPTIMEOUT_LIST3 +
+		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
+
+		BUG_ON(!cpu_cache_get(cachep));
+		cpu_cache_get(cachep)->avail = 0;
+		cpu_cache_get(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
+		cpu_cache_get(cachep)->batchcount = 1;
+		cpu_cache_get(cachep)->touched = 0;
+		cachep->batchcount = 1;
+		cachep->limit = BOOT_CPUCACHE_ENTRIES;
+	}
+}
+
 /**
  * kmem_cache_create - Create a cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -1868,60 +1926,7 @@ kmem_cache_create (const char *name, siz
 	/* Don't let CPUs to come and go */
 	lock_cpu_hotplug();
 
-	if (g_cpucache_up == FULL) {
-		enable_cpucache(cachep);
-	} else {
-		if (g_cpucache_up == NONE) {
-			/* Note: the first kmem_cache_create must create
-			 * the cache that's used by kmalloc(24), otherwise
-			 * the creation of further caches will BUG().
-			 */
-			cachep->array[smp_processor_id()] =
-			    &initarray_generic.cache;
-
-			/* If the cache that's used by
-			 * kmalloc(sizeof(kmem_list3)) is the first cache,
-			 * then we need to set up all its list3s, otherwise
-			 * the creation of further caches will BUG().
-			 */
-			set_up_list3s(cachep, SIZE_AC);
-			if (INDEX_AC == INDEX_L3)
-				g_cpucache_up = PARTIAL_L3;
-			else
-				g_cpucache_up = PARTIAL_AC;
-		} else {
-			cachep->array[smp_processor_id()] =
-			    kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
-
-			if (g_cpucache_up == PARTIAL_AC) {
-				set_up_list3s(cachep, SIZE_L3);
-				g_cpucache_up = PARTIAL_L3;
-			} else {
-				int node;
-				for_each_online_node(node) {
-
-					cachep->nodelists[node] =
-					    kmalloc_node(sizeof
-							 (struct kmem_list3),
-							 GFP_KERNEL, node);
-					BUG_ON(!cachep->nodelists[node]);
-					kmem_list3_init(cachep->
-							nodelists[node]);
-				}
-			}
-		}
-		cachep->nodelists[numa_node_id()]->next_reap =
-		    jiffies + REAPTIMEOUT_LIST3 +
-		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
-
-		BUG_ON(!cpu_cache_get(cachep));
-		cpu_cache_get(cachep)->avail = 0;
-		cpu_cache_get(cachep)->limit = BOOT_CPUCACHE_ENTRIES;
-		cpu_cache_get(cachep)->batchcount = 1;
-		cpu_cache_get(cachep)->touched = 0;
-		cachep->batchcount = 1;
-		cachep->limit = BOOT_CPUCACHE_ENTRIES;
-	}
+	setup_cpu_cache(cachep);
 
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
