Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWILOnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWILOnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWILOnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:43:45 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:8351 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S965161AbWILOnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:43:43 -0400
Date: Tue, 12 Sep 2006 07:45:18 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: [patch] slab: Do not use mempolicy for kmalloc_node
Message-ID: <20060912144518.GA4653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The slab should follow the specified memory policy for kmalloc allocations,
which it does.  However, for kmalloc_node allocations, slab should
serve the object from the requested node irrespective of memory policy.
This seems to be broken in slab code.  Following patch fixes this.

Patch abstacts out a __cache_alloc_mempolicy function to be used when
mempolicy is to be applied.
 
Signed-off-by: Alok N Kataria <alok.kataria@calsotinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scale86.org>
Signed-off-by: Shai Fultheim <shai@scale86.org>

Index: linux-2.6.18-rc3/mm/slab.c
===================================================================
--- linux-2.6.18-rc3.orig/mm/slab.c	2006-08-04 10:01:46.000000000 -0700
+++ linux-2.6.18-rc3/mm/slab.c	2006-08-08 12:05:21.000000000 -0700
@@ -2963,19 +2963,12 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
-static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static inline void *
+____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
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
@@ -2989,6 +2982,28 @@ static inline void *____cache_alloc(stru
 	return objp;
 }
 
+#ifdef CONFIG_NUMA
+static inline void *__cache_alloc_mempolicy(struct kmem_cache *cachep, gfp_t flags)
+{
+	void *objp;
+
+	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
+		objp = alternate_node_alloc(cachep, flags);
+		if (objp != NULL)
+			return objp;
+	}
+
+	return ____cache_alloc(cachep, flags);
+}
+#else
+static inline void *__cache_alloc_mempolicy(struct kmem_cache *cachep, gfp_t flags)
+{
+	return ____cache_alloc(cachep, flags);
+}
+#endif
+
+
+
 static __always_inline void *__cache_alloc(struct kmem_cache *cachep,
 						gfp_t flags, void *caller)
 {
@@ -2998,7 +3013,7 @@ static __always_inline void *__cache_all
 	cache_alloc_debugcheck_before(cachep, flags);
 
 	local_irq_save(save_flags);
-	objp = ____cache_alloc(cachep, flags);
+	objp = __cache_alloc_mempolicy(cachep, flags);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    caller);
@@ -3303,8 +3318,9 @@ void *kmem_cache_alloc_node(struct kmem_
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
 
-	if (nodeid == -1 || nodeid == numa_node_id() ||
-			!cachep->nodelists[nodeid])
+	if (nodeid == -1 || !cachep->nodelists[nodeid])
+		ptr = __cache_alloc_mempolicy(cachep, flags);
+	else if (nodeid == numa_node_id())
 		ptr = ____cache_alloc(cachep, flags);
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
