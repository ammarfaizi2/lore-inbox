Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWATL4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWATL4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWATL4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:56:20 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26549 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750864AbWATL4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:56:17 -0500
Date: Fri, 20 Jan 2006 13:56:15 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
In-Reply-To: <20060120034027.665eb101.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601201343580.15672@sbz-30.cs.Helsinki.FI>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
 <84144f020601200333y2d2c994av96d855e300411006@mail.gmail.com>
 <20060120034027.665eb101.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > Hmm. This still leaves kstrdup() broken which is why I would prefer
> > the following patch to be applied:
 
On Fri, 20 Jan 2006, Andrew Morton wrote:
> kstrdup() doesn't get used much.
> 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113767657400334&w=2
> 
> That adds more complexity, IMO.  A bit ifdeffy too.  __do_kmalloc() should
> be __always_inline, methinks?

Yes it does. This patch does make the caller tracing more explicit, though 
and less likely to break. And yes, __do_kmalloc() should always be inlined. 
Here's an updated patch.

			Pekka

[PATCH] slab: fix kzalloc and kstrdup caller report for CONFIG_DEBUG_SLAB

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch fixes kzalloc() and kstrdup() caller report for CONFIG_DEBUG_SLAB.
We must pass the caller to __cache_alloc() instead of directly doing
__builtin_return_address(0) there; otherwise kzalloc() and kstrdup() are
reported as the allocation site instead of the real one.

Thanks to Valdis Kletnieks for reporting the problem and Steven Rostedt for
the original idea.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/slab.h |    7 +++++++
 mm/slab.c            |   29 ++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

Index: 2.6-mm/include/linux/slab.h
===================================================================
--- 2.6-mm.orig/include/linux/slab.h
+++ 2.6-mm/include/linux/slab.h
@@ -76,7 +76,14 @@ struct cache_sizes {
 	kmem_cache_t	*cs_dmacachep;
 };
 extern struct cache_sizes malloc_sizes[];
+
+#ifndef CONFIG_DEBUG_SLAB
 extern void *__kmalloc(size_t, gfp_t);
+#else
+extern void *__kmalloc_track_caller(size_t, gfp_t, void*);
+#define __kmalloc(size, flags) \
+    __kmalloc_track_caller(size, flags, __builtin_return_address(0))
+#endif
 
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
Index: 2.6-mm/mm/slab.c
===================================================================
--- 2.6-mm.orig/mm/slab.c
+++ 2.6-mm/mm/slab.c
@@ -2699,7 +2699,8 @@ static inline void *____cache_alloc(stru
 	return objp;
 }
 
-static inline void *__cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+static __always_inline void *
+__cache_alloc(struct kmem_cache *cachep, gfp_t flags, void *caller)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -2710,7 +2711,7 @@ static inline void *__cache_alloc(struct
 	objp = ____cache_alloc(cachep, flags);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
-					    __builtin_return_address(0));
+					    caller);
 	prefetchw(objp);
 	return objp;
 }
@@ -2939,7 +2940,7 @@ static inline void __cache_free(struct k
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	return __cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
@@ -3053,7 +3054,8 @@ EXPORT_SYMBOL(kmalloc_node);
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void *__kmalloc(size_t size, gfp_t flags)
+static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
+					  void *caller)
 {
 	struct kmem_cache *cachep;
 
@@ -3065,10 +3067,27 @@ void *__kmalloc(size_t size, gfp_t flags
 	cachep = __find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return __cache_alloc(cachep, flags);
+	return __cache_alloc(cachep, flags, caller);
+}
+
+#ifndef CONFIG_DEBUG_SLAB
+
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __do_kmalloc(size, flags, NULL);
 }
 EXPORT_SYMBOL(__kmalloc);
 
+#else
+
+void *__kmalloc_track_caller(size_t size, gfp_t flags, void *caller)
+{
+	return __do_kmalloc(size, flags, caller);
+}
+EXPORT_SYMBOL(__kmalloc_track_caller);
+
+#endif
+
 #ifdef CONFIG_SMP
 /**
  * __alloc_percpu - allocate one copy of the object for every present
