Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWCTNIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWCTNIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWCTNIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:08:00 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:56499 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932277AbWCTNH7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:07:59 -0500
Date: Mon, 20 Mar 2006 15:07:57 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] slab: introduce kmem_cache_zalloc allocator
Message-ID: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch introduces a memory-zeroing variant of kmem_cache_alloc. The
allocator already exits in XFS and there are potential users for it so
this patch makes the allocator available for the general public.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 include/linux/slab.h |    2 ++
 mm/slab.c            |   17 +++++++++++++++++
 mm/slob.c            |   10 ++++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

7ebeed21971a6a24749a4966db1ccc69c6806e15
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8cf5293..b595c09 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -64,6 +64,7 @@ extern kmem_cache_t *kmem_cache_create(c
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
+extern void *kmem_cache_zalloc(struct kmem_cache *, gfp_t);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 extern const char *kmem_cache_name(kmem_cache_t *);
@@ -155,6 +156,7 @@ struct kmem_cache *kmem_cache_create(con
 	void (*)(void *, struct kmem_cache *, unsigned long));
 int kmem_cache_destroy(struct kmem_cache *c);
 void *kmem_cache_alloc(struct kmem_cache *c, gfp_t flags);
+void *kmem_cache_zalloc(struct kmem_cache *, gfp_t);
 void kmem_cache_free(struct kmem_cache *c, void *b);
 const char *kmem_cache_name(struct kmem_cache *);
 void *kmalloc(size_t size, gfp_t flags);
diff --git a/mm/slab.c b/mm/slab.c
index d0bd7f0..5f3e14b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3056,6 +3056,23 @@ void *kmem_cache_alloc(struct kmem_cache
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 /**
+ * kmem_cache_alloc - Allocate an object. The memory is set to zero.
+ * @cache: The cache to allocate from.
+ * @flags: See kmalloc().
+ *
+ * Allocate an object from this cache and set the allocated memory to zero.
+ * The flags are only relevant if the cache has no available objects.
+ */
+void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
+{
+	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
+	if (ret)
+		memset(ret, 0, obj_size(cache));
+	return ret;
+}
+EXPORT_SYMBOL(kmem_cache_zalloc);
+
+/**
  * kmem_ptr_validate - check if an untrusted pointer might
  *	be a slab entry.
  * @cachep: the cache we're checking against
diff --git a/mm/slob.c b/mm/slob.c
index a1f42bd..9bcc7e2 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -294,6 +294,16 @@ void *kmem_cache_alloc(struct kmem_cache
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
+void *kmem_cache_zalloc(struct kmem_cache *c, gfp_t flags)
+{
+	void *ret = kmem_cache_alloc(c, flags);
+	if (ret)
+		memset(ret, 0, c->size);
+
+	return ret;
+}
+EXPORT_SYMBOL(kmem_cache_zalloc);
+
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
 	if (c->dtor)
-- 
1.2.3

