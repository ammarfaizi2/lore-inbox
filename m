Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWASNOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWASNOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWASNOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:14:07 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29069 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161138AbWASNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:14:06 -0500
Date: Thu, 19 Jan 2006 15:14:03 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rostedt@goodmis.org, manfred@colorfullife.com
Subject: Re: [PATCH] 2.6.16-rc1-mm1 - produce useful info for kzalloc with
 DEBUG_SLAB
In-Reply-To: <200601190947.k0J9l4Cu029568@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0601191511320.21323@sbz-30.cs.Helsinki.FI>
References: <200601190830.k0J8UG9Q008899@turing-police.cc.vt.edu>          
  <84144f020601190058s2e8e86a8ya761fcb4fdd8eeaa@mail.gmail.com>
 <200601190947.k0J9l4Cu029568@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006 Valdis.Kletnieks@vt.edu wrote:
> I posted the basic idea of this patch back on Dec 18, Steven came up with
> his stuff about 2 weeks later, and it's a bit too creative with its use of
> the preprocessor for my tastes,  so I didn't retrofit the idea.
> 
> On the other hand, I'm not *that* attached to my solution - if somebody wants
> to code a patch Steven's way and toss it to Andrew, they're welcome to do so,
> and we'll let Andrew decide. ;)

Actually, no need to do preprocessor tricks. Valdis, can you confirm that 
this patch actually fixes your problem? It is against 2.6.16-rc1-mm1.

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
 mm/slab.c            |   28 +++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

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
 
@@ -3053,7 +3054,7 @@ EXPORT_SYMBOL(kmalloc_node);
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void *__kmalloc(size_t size, gfp_t flags)
+static inline void *__do_kmalloc(size_t size, gfp_t flags, void *caller)
 {
 	struct kmem_cache *cachep;
 
@@ -3065,10 +3066,27 @@ void *__kmalloc(size_t size, gfp_t flags
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
