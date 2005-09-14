Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVINSjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVINSjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVINSjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:39:45 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:52362 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932498AbVINSjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:39:44 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move GFP_KERNEL use out of line to shrink text
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
	<20050913120707.74a19800.akpm@osdl.org> <52y8602zl7.fsf@cisco.com>
	<52acig2q37.fsf_-_@cisco.com> <20050913223511.141e78c1.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 14 Sep 2005 11:39:34 -0700
In-Reply-To: <20050913223511.141e78c1.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 13 Sep 2005 22:35:11 -0700")
Message-ID: <52fys7ze6x.fsf_-_@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Sep 2005 18:39:36.0157 (UTC) FILETIME=[A7FE98D0:01C5B95B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> It hardly seems worth it, really.  Better savings would
    Andrew> come from doing the same trick to kmem_cache_alloc() then
    Andrew> tweaking kmalloc().

Yep, right as usual; here's an updated patch.  Do with it as you will --
I won't be hurt if you dump it, since I had fun trying this out.


Reduce kernel text by moving many uses of GFP_KERNEL out of line, by
creating __kmem_cache_alloc_gfp_kernel(), __kmalloc_gfp_kernel() and
__kzalloc_gfp_kernel() wrapper functions.  Then kmem_cache_alloc(),
kmalloc() and kzalloc() can be inline functions that just call their
_gfp_kernel version if their flags parameter is a compile-time
constant and is GFP_KERNEL, and call their ordinary version otherwise.

On an x86_64 allyesconfig kernel, I see the following sizes:

       text    data     bss     dec     hex filename
    24202272 7609162 1998512 33809946 203e61a vmlinux-before
    24197561 7609474 1998512 33805547 203d4eb vmlinux-after

for a net savings of 4711 bytes of text (at a cost of 312 bytes of
data for some reason).  With my usual config, the patched kernel boots
and runs fine.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -61,7 +61,8 @@ extern kmem_cache_t *kmem_cache_create(c
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
-extern void *kmem_cache_alloc(kmem_cache_t *, unsigned int __nocast);
+extern void *__kmem_cache_alloc(kmem_cache_t *, unsigned int __nocast);
+extern void *__kmem_cache_alloc_gfp_kernel(kmem_cache_t *);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 extern const char *kmem_cache_name(kmem_cache_t *);
@@ -75,6 +76,15 @@ struct cache_sizes {
 };
 extern struct cache_sizes malloc_sizes[];
 extern void *__kmalloc(size_t, unsigned int __nocast);
+extern void *__kmalloc_gfp_kernel(size_t);
+
+static inline void *kmem_cache_alloc(kmem_cache_t *cache, unsigned int __nocast flags)
+{
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kmem_cache_alloc_gfp_kernel(cache);
+
+	return __kmem_cache_alloc(cache, flags);
+}
 
 static inline void *kmalloc(size_t size, unsigned int __nocast flags)
 {
@@ -96,10 +106,22 @@ found:
 			malloc_sizes[i].cs_dmacachep :
 			malloc_sizes[i].cs_cachep, flags);
 	}
+
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kmalloc_gfp_kernel(size);
 	return __kmalloc(size, flags);
 }
 
-extern void *kzalloc(size_t, unsigned int __nocast);
+extern void *__kzalloc(size_t, unsigned int __nocast);
+extern void *__kzalloc_gfp_kernel(size_t);
+
+static inline void *kzalloc(size_t size, unsigned int __nocast flags)
+{
+	if (__builtin_constant_p(flags) && flags == GFP_KERNEL)
+		return __kzalloc_gfp_kernel(size);
+
+	return __kzalloc(size, flags);
+}
 
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
diff --git a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2778,11 +2778,17 @@ static inline void __cache_free(kmem_cac
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
+void *__kmem_cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
 {
 	return __cache_alloc(cachep, flags);
 }
-EXPORT_SYMBOL(kmem_cache_alloc);
+EXPORT_SYMBOL(__kmem_cache_alloc);
+
+void *__kmem_cache_alloc_gfp_kernel(kmem_cache_t *cachep)
+{
+	return __cache_alloc(cachep, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kmem_cache_alloc_gfp_kernel);
 
 /**
  * kmem_ptr_validate - check if an untrusted pointer might
@@ -2912,6 +2918,12 @@ void *__kmalloc(size_t size, unsigned in
 }
 EXPORT_SYMBOL(__kmalloc);
 
+void *__kmalloc_gfp_kernel(size_t size)
+{
+	return __kmalloc(size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kmalloc_gfp_kernel);
+
 #ifdef CONFIG_SMP
 /**
  * __alloc_percpu - allocate one copy of the object for every present
@@ -2985,14 +2997,20 @@ EXPORT_SYMBOL(kmem_cache_free);
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  */
-void *kzalloc(size_t size, unsigned int __nocast flags)
+void *__kzalloc(size_t size, unsigned int __nocast flags)
 {
 	void *ret = kmalloc(size, flags);
 	if (ret)
 		memset(ret, 0, size);
 	return ret;
 }
-EXPORT_SYMBOL(kzalloc);
+EXPORT_SYMBOL(__kzalloc);
+
+void *__kzalloc_gfp_kernel(size_t size)
+{
+	return __kzalloc(size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(__kzalloc_gfp_kernel);
 
 /**
  * kfree - free previously allocated memory
