Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSJaW7G>; Thu, 31 Oct 2002 17:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbSJaW7G>; Thu, 31 Oct 2002 17:59:06 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:30667 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265402AbSJaW6u>;
	Thu, 31 Oct 2002 17:58:50 -0500
Message-ID: <3DC1B6D0.8050202@colorfullife.com>
Date: Fri, 01 Nov 2002 00:03:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] faster kmalloc lookup
References: <3DBAEB64.1090109@colorfullife.com> <1036056917.2872.0.camel@dhcp59-228.rdu.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------020404020603040601030808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020404020603040601030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:

>On Sat, 2002-10-26 at 21:22, Manfred Spraul wrote:
>  
>
>>kmalloc spends a large part of the total execution time trying to find 
>>the cache for the passed in size.
>>    
>>
>
>would it be possible for fixed size kmalloc's to have the compiler
>precalculate this ?
>
>
>  
>
My patch is attached.
Question to the preprocessor experts:
is there a simpler way to achieve that? Right now the list of kmalloc 
caches exists in 3 copies, which could easily get out of sync.

--
    Manfred



--------------020404020603040601030808
Content-Type: text/plain;
 name="patch-kmalloc-fast"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kmalloc-fast"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 45
//  EXTRAVERSION =
--- 2.5/include/linux/slab.h	Sat Oct 26 21:02:12 2002
+++ build-2.5/include/linux/slab.h	Thu Oct 31 23:58:26 2002
@@ -58,7 +58,80 @@
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
-extern void *kmalloc(size_t, int);
+/* Size description struct for general caches. */
+struct cache_sizes {
+	size_t		 cs_size;
+	kmem_cache_t	*cs_cachep;
+	kmem_cache_t	*cs_dmacachep;
+};
+extern struct cache_sizes malloc_sizes[];
+extern void __you_cannot_kmalloc_more_than_128_kilo_bytes(void);
+
+enum malloc_numbers
+{
+#if PAGE_SIZE == 4096
+	kmalloc_size_32 = 0,
+#endif
+	kmalloc_size_64,
+#if L1_CACHE_BYTES < 64
+	kmalloc_size_96,
+#endif
+	kmalloc_size_128,
+#if L1_CACHE_BYTES < 128
+	kmalloc_size_192,
+#endif
+	kmalloc_size_256,
+	kmalloc_size_512,
+	kmalloc_size_1024,
+	kmalloc_size_2048,
+	kmalloc_size_4096,
+	kmalloc_size_8192,
+	kmalloc_size_16384,
+	kmalloc_size_32768,
+	kmalloc_size_65536,
+	kmalloc_size_131072
+};
+
+static inline void* __constant_kmalloc(size_t size, int flags)
+{
+#define FIXED_ALLOC(len) \
+	if(size <= len) \
+		return kmem_cache_alloc( (flags & GFP_DMA)? \
+				malloc_sizes[kmalloc_size_##len].cs_dmacachep \
+				: malloc_sizes[kmalloc_size_##len].cs_cachep, \
+				flags)
+#if PAGE_SIZE == 4096
+	FIXED_ALLOC(32);
+#endif
+	FIXED_ALLOC(64);
+#if L1_CACHE_BYTES < 64
+	FIXED_ALLOC(96);
+#endif
+	FIXED_ALLOC(128);
+#if L1_CACHE_BYTES < 128
+	FIXED_ALLOC(192);
+#endif
+	FIXED_ALLOC(256);
+	FIXED_ALLOC(512);
+	FIXED_ALLOC(1024);
+	FIXED_ALLOC(2048);
+	FIXED_ALLOC(4096);
+	FIXED_ALLOC(8192);
+	FIXED_ALLOC(16384);
+	FIXED_ALLOC(32768);
+	FIXED_ALLOC(65536);
+	FIXED_ALLOC(131072);
+#undef FIXED_ALLOC
+	__you_cannot_kmalloc_more_than_128_kilo_bytes();
+	return NULL;
+}
+extern void *__kmalloc(size_t, int);
+
+#define kmalloc(size, flags)				\
+	(__builtin_constant_p(size) ?			\
+	 __constant_kmalloc((size),(flags)) :		\
+	 __kmalloc(size,flags))
+
 extern void kfree(const void *);
 
 extern int FASTCALL(kmem_cache_reap(int));
--- 2.5/mm/slab.c	Thu Oct 31 18:48:19 2002
+++ build-2.5/mm/slab.c	Thu Oct 31 23:58:26 2002
@@ -369,15 +369,8 @@
 #define	SET_PAGE_SLAB(pg,x)   ((pg)->list.prev = (struct list_head *)(x))
 #define	GET_PAGE_SLAB(pg)     ((struct slab *)(pg)->list.prev)
 
-/* Size description struct for general caches. */
-struct cache_sizes {
-	size_t		 cs_size;
-	kmem_cache_t	*cs_cachep;
-	kmem_cache_t	*cs_dmacachep;
-};
-
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
-static struct cache_sizes malloc_sizes[] = {
+struct cache_sizes malloc_sizes[] = {
 #if PAGE_SIZE == 4096
 	{    32,	NULL, NULL},
 #endif
@@ -1804,7 +1797,7 @@
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void * kmalloc (size_t size, int flags)
+void * __kmalloc (size_t size, int flags)
 {
 	struct cache_sizes *csizep = malloc_sizes;
 
--- 2.5/kernel/ksyms.c	Thu Oct 31 18:48:18 2002
+++ build-2.5/kernel/ksyms.c	Thu Oct 31 23:44:54 2002
@@ -102,7 +102,8 @@
 EXPORT_SYMBOL(kmem_cache_size);
 EXPORT_SYMBOL(set_shrinker);
 EXPORT_SYMBOL(remove_shrinker);
-EXPORT_SYMBOL(kmalloc);
+EXPORT_SYMBOL(malloc_sizes);
+EXPORT_SYMBOL(__kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);

--------------020404020603040601030808--


