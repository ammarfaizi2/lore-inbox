Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVF1UPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVF1UPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVF1UMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:12:45 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:16479 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261356AbVF1UI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:08:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jq9R4SAdsl5Dj2UWNE1gbgubzWZ6JUGviCFgWoomYJ775HA7KNB7k8rOec4T9i3k8ip7CQkdr85jFfuh8Z0VJwgsRsenyl++LuW389/3fEUNSSRS2RSxaHV/v8TC9vmxKlM5nDZueho5rQ3kIJdzeFxtWWUzWQVDDL5gXNnErQo=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] mm: propagate __nocast annotations
Date: Wed, 29 Jun 2005 00:14:03 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506290014.03284.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/gfp.h    |    4 ++--
 include/linux/slab.h   |    6 +++---
 include/linux/string.h |    2 +-
 mm/mempool.c           |    2 +-
 mm/slab.c              |   12 +++++++-----
 5 files changed, 14 insertions(+), 12 deletions(-)

diff -uprN a/include/linux/gfp.h b/include/linux/gfp.h
--- a/include/linux/gfp.h	2005-06-28 13:35:40.000000000 +0400
+++ b/include/linux/gfp.h	2005-06-29 00:07:10.000000000 +0400
@@ -12,8 +12,8 @@ struct vm_area_struct;
  * GFP bitmasks..
  */
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
-#define __GFP_DMA	0x01
-#define __GFP_HIGHMEM	0x02
+#define __GFP_DMA	0x01u
+#define __GFP_HIGHMEM	0x02u
 
 /*
  * Action modifiers - doesn't change the zoning
diff -uprN a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h	2005-06-28 13:35:48.000000000 +0400
+++ b/include/linux/slab.h	2005-06-29 00:07:37.000000000 +0400
@@ -65,7 +65,7 @@ extern void *kmem_cache_alloc(kmem_cache
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 extern const char *kmem_cache_name(kmem_cache_t *);
-extern kmem_cache_t *kmem_find_general_cachep(size_t size, int gfpflags);
+extern kmem_cache_t *kmem_find_general_cachep(size_t size, unsigned int __nocast gfpflags);
 
 /* Size description struct for general caches. */
 struct cache_sizes {
@@ -105,13 +105,13 @@ extern unsigned int ksize(const void *);
 
 #ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(kmem_cache_t *, int flags, int node);
-extern void *kmalloc_node(size_t size, int flags, int node);
+extern void *kmalloc_node(size_t size, unsigned int __nocast flags, int node);
 #else
 static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int flags, int node)
 {
 	return kmem_cache_alloc(cachep, flags);
 }
-static inline void *kmalloc_node(size_t size, int flags, int node)
+static inline void *kmalloc_node(size_t size, unsigned int __nocast flags, int node)
 {
 	return kmalloc(size, flags);
 }
diff -uprN a/include/linux/string.h b/include/linux/string.h
--- a/include/linux/string.h	2005-06-28 13:35:48.000000000 +0400
+++ b/include/linux/string.h	2005-06-29 00:07:37.000000000 +0400
@@ -88,7 +88,7 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
-extern char *kstrdup(const char *s, int gfp);
+extern char *kstrdup(const char *s, unsigned int __nocast gfp);
 
 #ifdef __cplusplus
 }
diff -uprN a/mm/mempool.c b/mm/mempool.c
--- a/mm/mempool.c	2005-06-28 13:35:59.000000000 +0400
+++ b/mm/mempool.c	2005-06-29 00:07:33.000000000 +0400
@@ -205,7 +205,7 @@ void * mempool_alloc(mempool_t *pool, un
 	void *element;
 	unsigned long flags;
 	wait_queue_t wait;
-	int gfp_temp;
+	unsigned int gfp_temp;
 
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 
diff -uprN a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	2005-06-28 13:35:59.000000000 +0400
+++ b/mm/slab.c	2005-06-29 00:07:37.000000000 +0400
@@ -584,7 +584,8 @@ static inline struct array_cache *ac_dat
 	return cachep->array[smp_processor_id()];
 }
 
-static inline kmem_cache_t *__find_general_cachep(size_t size, int gfpflags)
+static inline kmem_cache_t *__find_general_cachep(size_t size,
+						unsigned int __nocast gfpflags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
@@ -608,7 +609,8 @@ static inline kmem_cache_t *__find_gener
 	return csizep->cs_cachep;
 }
 
-kmem_cache_t *kmem_find_general_cachep(size_t size, int gfpflags)
+kmem_cache_t *kmem_find_general_cachep(size_t size,
+		unsigned int __nocast gfpflags)
 {
 	return __find_general_cachep(size, gfpflags);
 }
@@ -2100,7 +2102,7 @@ cache_alloc_debugcheck_before(kmem_cache
 #if DEBUG
 static void *
 cache_alloc_debugcheck_after(kmem_cache_t *cachep,
-			unsigned long flags, void *objp, void *caller)
+			unsigned int __nocast flags, void *objp, void *caller)
 {
 	if (!objp)	
 		return objp;
@@ -2439,7 +2441,7 @@ got_slabp:
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-void *kmalloc_node(size_t size, int flags, int node)
+void *kmalloc_node(size_t size, unsigned int __nocast flags, int node)
 {
 	kmem_cache_t *cachep;
 
@@ -3091,7 +3093,7 @@ unsigned int ksize(const void *objp)
  * @s: the string to duplicate
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  */
-char *kstrdup(const char *s, int gfp)
+char *kstrdup(const char *s, unsigned int __nocast gfp)
 {
 	size_t len;
 	char *buf;
