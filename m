Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWI2Jrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWI2Jrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWI2Jry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:47:54 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55950 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750883AbWI2Jrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:47:53 -0400
Date: Fri, 29 Sep 2006 12:47:51 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: hch@lst.de, linux-kernel@vger.kernel.org
Subject: [PATCH] slab: clean up leak tracking ifdefs a little bit
Message-ID: <Pine.LNX.4.58.0609291247140.26566@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

 - rename ____kmalloc to kmalloc_track_caller so that people have
   a chance to guess what it does just from it's name.  Add a comment
   describing it for those who don't.  Also move it after kmalloc in
   slab.h so people get less confused when they are just looking for
   kmalloc
 - move things around in slab.c a little to reduce the ifdef mess.

[penberg@cs.helsinki.fi: Fix up reversed #ifdef.]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/slab.h |   26 ++++++++++++++++++--------
 mm/slab.c            |   13 ++++++++-----
 mm/util.c            |    4 ++--
 net/core/skbuff.c    |    3 ++-
 4 files changed, 30 insertions(+), 16 deletions(-)

Index: 2.6/include/linux/slab.h
===================================================================
--- 2.6.orig/include/linux/slab.h
+++ 2.6/include/linux/slab.h
@@ -77,13 +77,6 @@ struct cache_sizes {
 extern struct cache_sizes malloc_sizes[];
 
 extern void *__kmalloc(size_t, gfp_t);
-#ifndef CONFIG_DEBUG_SLAB
-#define ____kmalloc(size, flags) __kmalloc(size, flags)
-#else
-extern void *__kmalloc_track_caller(size_t, gfp_t, void*);
-#define ____kmalloc(size, flags) \
-    __kmalloc_track_caller(size, flags, __builtin_return_address(0))
-#endif
 
 /**
  * kmalloc - allocate memory
@@ -153,6 +146,23 @@ found:
 	return __kmalloc(size, flags);
 }
 
+/*
+ * kmalloc_track_caller is a special version of kmalloc that records the
+ * calling function of the routine calling it for slab leak tracking instead
+ * of just the calling function (confusing, eh?).
+ * It's useful when the call to kmalloc comes from a widely-used standard
+ * allocator where we care about the real place the memory allocation
+ * request comes from.
+ */
+#ifndef CONFIG_DEBUG_SLAB
+#define kmalloc_track_caller(size, flags) \
+	__kmalloc(size, flags)
+#else
+extern void *__kmalloc_track_caller(size_t, gfp_t, void*);
+#define kmalloc_track_caller(size, flags) \
+	__kmalloc_track_caller(size, flags, __builtin_return_address(0))
+#endif
+
 extern void *__kzalloc(size_t, gfp_t);
 
 /**
@@ -271,7 +281,7 @@ static inline void *kcalloc(size_t n, si
 #define kmem_cache_alloc_node(c, f, n) kmem_cache_alloc(c, f)
 #define kmalloc_node(s, f, n) kmalloc(s, f)
 #define kzalloc(s, f) __kzalloc(s, f)
-#define ____kmalloc kmalloc
+#define kmalloc_track_caller kmalloc
 
 #endif /* CONFIG_SLOB */
 
Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -3466,22 +3466,25 @@ static __always_inline void *__do_kmallo
 }
 
 
+#ifdef CONFIG_DEBUG_SLAB
 void *__kmalloc(size_t size, gfp_t flags)
 {
-#ifndef CONFIG_DEBUG_SLAB
-	return __do_kmalloc(size, flags, NULL);
-#else
 	return __do_kmalloc(size, flags, __builtin_return_address(0));
-#endif
 }
 EXPORT_SYMBOL(__kmalloc);
 
-#ifdef CONFIG_DEBUG_SLAB
 void *__kmalloc_track_caller(size_t size, gfp_t flags, void *caller)
 {
 	return __do_kmalloc(size, flags, caller);
 }
 EXPORT_SYMBOL(__kmalloc_track_caller);
+
+#else
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __do_kmalloc(size, flags, NULL);
+}
+EXPORT_SYMBOL(__kmalloc);
 #endif
 
 /**
Index: 2.6/mm/util.c
===================================================================
--- 2.6.orig/mm/util.c
+++ 2.6/mm/util.c
@@ -11,7 +11,7 @@
  */
 void *__kzalloc(size_t size, gfp_t flags)
 {
-	void *ret = ____kmalloc(size, flags);
+	void *ret = kmalloc_track_caller(size, flags);
 	if (ret)
 		memset(ret, 0, size);
 	return ret;
@@ -33,7 +33,7 @@ char *kstrdup(const char *s, gfp_t gfp)
 		return NULL;
 
 	len = strlen(s) + 1;
-	buf = ____kmalloc(len, gfp);
+	buf = kmalloc_track_caller(len, gfp);
 	if (buf)
 		memcpy(buf, s, len);
 	return buf;
Index: 2.6/net/core/skbuff.c
===================================================================
--- 2.6.orig/net/core/skbuff.c
+++ 2.6/net/core/skbuff.c
@@ -156,7 +156,8 @@ struct sk_buff *__alloc_skb(unsigned int
 
 	/* Get the DATA. Size must match skb_add_mtu(). */
 	size = SKB_DATA_ALIGN(size);
-	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+	data = kmalloc_track_caller(size + sizeof(struct skb_shared_info),
+			gfp_mask);
 	if (!data)
 		goto nodata;
 
