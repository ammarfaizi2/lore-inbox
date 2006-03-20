Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965303AbWCTPgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbWCTPgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWCTPgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:36:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:44985 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964999AbWCTPgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:36:02 -0500
Subject: [PATCH] slab: optimize constant-size kzalloc calls
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Date: Mon, 20 Mar 2006 17:35:57 +0200
Message-Id: <1142868958.11159.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

As suggested by Eric Dumazet, this patch optimizes kzalloc() calls
that pass a compile-time constant size. Please note that the patch
increases kernel text slightly (~200 bytes for defconfig on x86).

This patch requires the kmem_cache_zalloc() patches I sent earlier.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 include/linux/slab.h |   30 +++++++++++++++++++++++++++---
 mm/util.c            |    6 +++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b595c09..db3b302 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -109,7 +109,30 @@ found:
 	return __kmalloc(size, flags);
 }
 
-extern void *kzalloc(size_t, gfp_t);
+extern void *__kzalloc(size_t, gfp_t);
+
+static inline void *kzalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(size)) {
+		int i = 0;
+#define CACHE(x) \
+		if (size <= x) \
+			goto found; \
+		else \
+			i++;
+#include "kmalloc_sizes.h"
+#undef CACHE
+		{
+			extern void __you_cannot_kzalloc_that_much(void);
+			__you_cannot_kzalloc_that_much();
+		}
+found:
+		return kmem_cache_zalloc((flags & GFP_DMA) ?
+			malloc_sizes[i].cs_dmacachep :
+			malloc_sizes[i].cs_cachep, flags);
+	}
+	return __kzalloc(size, flags);
+}
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
@@ -160,14 +183,14 @@ void *kmem_cache_zalloc(struct kmem_cach
 void kmem_cache_free(struct kmem_cache *c, void *b);
 const char *kmem_cache_name(struct kmem_cache *);
 void *kmalloc(size_t size, gfp_t flags);
-void *kzalloc(size_t size, gfp_t flags);
+void *__kzalloc(size_t size, gfp_t flags);
 void kfree(const void *m);
 unsigned int ksize(const void *m);
 unsigned int kmem_cache_size(struct kmem_cache *c);
 
 static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
 {
-	return kzalloc(n * size, flags);
+	return __kzalloc(n * size, flags);
 }
 
 #define kmem_cache_shrink(d) (0)
@@ -175,6 +198,7 @@ static inline void *kcalloc(size_t n, si
 #define kmem_ptr_validate(a, b) (0)
 #define kmem_cache_alloc_node(c, f, n) kmem_cache_alloc(c, f)
 #define kmalloc_node(s, f, n) kmalloc(s, f)
+#define kzalloc(s, f) __kzalloc(s, f)
 
 #endif /* CONFIG_SLOB */
 
diff --git a/mm/util.c b/mm/util.c
index 5f4bb59..fd78ee4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -3,18 +3,18 @@
 #include <linux/module.h>
 
 /**
- * kzalloc - allocate memory. The memory is set to zero.
+ * __kzalloc - allocate memory. The memory is set to zero.
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  */
-void *kzalloc(size_t size, gfp_t flags)
+void *__kzalloc(size_t size, gfp_t flags)
 {
 	void *ret = kmalloc(size, flags);
 	if (ret)
 		memset(ret, 0, size);
 	return ret;
 }
-EXPORT_SYMBOL(kzalloc);
+EXPORT_SYMBOL(__kzalloc);
 
 /*
  * kstrdup - allocate space for and copy an existing string


