Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWFOHMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWFOHMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWFOHMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:12:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55957 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750838AbWFOHMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:12:46 -0400
Subject: [RFC/PATCH 1/2] slab: cpucache allocation cleanup
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: christoph@lameter.com, manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Date: Thu, 15 Jun 2006 10:12:44 +0300
Message-Id: <1150355564.4633.6.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch cleans up allocation from the per-CPU cache by separating NUMA
and UMA paths.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 mm/slab.c |   69 +++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 42 insertions(+), 27 deletions(-)

8658c94d24e3b97f2ad747182811713c52dffdcf
diff --git a/mm/slab.c b/mm/slab.c
index f1b644e..579cff3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2855,19 +2855,12 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static __always_inline void *__cache_alloc_cpucache(struct kmem_cache *cachep,
+						    gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
-#ifdef CONFIG_NUMA
-	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
-		objp = alternate_node_alloc(cachep, flags);
-		if (objp != NULL)
-			return objp;
-	}
-#endif
-
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
@@ -2881,23 +2874,6 @@ static inline void *____cache_alloc(stru
 	return objp;
 }
 
-static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
-						gfp_t flags, void *caller)
-{
-	unsigned long save_flags;
-	void *objp;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-
-	local_irq_save(save_flags);
-	objp = ____cache_alloc(cachep, flags);
-	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					    caller);
-	prefetchw(objp);
-	return objp;
-}
-
 #ifdef CONFIG_NUMA
 /*
  * Try allocating on another node if PF_SPREAD_SLAB|PF_MEMPOLICY.
@@ -2982,8 +2958,47 @@ must_grow:
 done:
 	return obj;
 }
+
+static inline void *cache_alloc_cpucache(struct kmem_cache *cache, gfp_t flags)
+{
+	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
+		void *objp = alternate_node_alloc(cache, flags);
+		if (objp != NULL)
+			return objp;
+	}
+	return __cache_alloc_cpucache(cache, flags);
+}
+
+#else
+
+/*
+ * On UMA, we always allocate directly drom the per-CPU cache.
+ */
+
+static inline void *cache_alloc_cpucache(struct kmem_cache *cache, gfp_t flags)
+{
+	return __cache_alloc_cpucache(cache, flags);
+}
+
 #endif
 
+static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
+						gfp_t flags, void *caller)
+{
+	unsigned long save_flags;
+	void *objp;
+
+	cache_alloc_debugcheck_before(cachep, flags);
+
+	local_irq_save(save_flags);
+	objp = cache_alloc_cpucache(cachep, flags);
+	local_irq_restore(save_flags);
+	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
+					    caller);
+	prefetchw(objp);
+	return objp;
+}
+
 /*
  * Caller needs to acquire correct kmem_list's list_lock
  */
@@ -3229,7 +3244,7 @@ void *kmem_cache_alloc_node(struct kmem_
 
 	if (nodeid == -1 || nodeid == numa_node_id() ||
 			!cachep->nodelists[nodeid])
-		ptr = ____cache_alloc(cachep, flags);
+		ptr = cache_alloc_cpucache(cachep, flags);
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
-- 
1.1.3


